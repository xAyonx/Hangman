!/bin/bash

# Definiere das zu erratende Wort
wort="Computer"

# Bestimme, wie viele Buchstaben das Wort hat
anzahl_buchstaben=${#wort}

# Erstelle das aktuelle Rätselwort mit Unterstrichen
aktuelles_raetselwort=$(echo "$wort" | sed 's/./_ /g')

# Initialisiere den Hangman und die Fehlversuche
hangman=""
fehlversuche=0

# Schleife bis das Spiel beendet ist
while true; do
    # Gib das aktuelle Rätselwort aus
    echo "Das Wort hat $anzahl_buchstaben Buchstaben: $aktuelles_raetselwort"

    # Lasse den Spieler einen Buchstaben raten
    echo "Rate einen Buchstaben:"
    read buchstabe

    # Überprüfe, ob der geratene Buchstabe im Wort enthalten ist
    if [[ $wort == *"$buchstabe"* ]]; then
        # Aktualisiere das Rätselwort
        aktuelles_raetselwort=$(echo "$wort" | sed "s/[^$buchstabe]/_/g")

        # Überprüfe, ob das Rätselwort vollständig gelöst wurde
        if [[ $aktuelles_raetselwort == *"_ "* ]]; then
            echo "Richtig geraten! Das Wort lautet: $wort"
            exit 0
        fi
    else
        # Füge den Buchstaben zum Hangman hinzu
        hangman="$hangman+---+
|   |
|   O
|  /|\\
|  / \\
|
========"

        # Zeige den aktuellen Hangman an
        echo "$hangman"

        # Erhöhe die Anzahl der Fehlversuche
        fehlversuche=$((fehlversuche + 1))

        # Überprüfe, ob das Spiel verloren wurde
        if [ $fehlversuche -eq 7 ]; then
            echo "Leider verloren! Das Wort lautet: $wort"
            exit 0
        fi
    fi
done
