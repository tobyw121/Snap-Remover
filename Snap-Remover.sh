#!/bin/bash

echo "Deletes snap..."

# Stops the process
sudo systemctl stop snapd && sudo systemctl disable snapd && sudo systemctl disable snapd.service 

# Uninstalls Snap
sudo apt purge -y snapd

# Cleans the snap dirt
echo "Snap Dirt Is Removed" 
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd ~/snap
echo "Snap Dirt Was Removed"

# Prevents the snap from being installed again like during an update or from other packages
cat << EOF > no-snap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

# Prevents the domination of the snap version of firefox for installation
cat << EOF > firefox.pref
Package: firefox*
Pin: release o=ubuntu
Pin-Priority: -1
EOF

# Move snap packets to blacklist to prevent snap from being installed again
sudo mv no-snap.pref /etc/apt/preferences.d/
sudo chown root:root /etc/apt/preferences.d/no-snap.pref
sudo mv firefox.pref /etc/apt/preferences.d/
sudo chown root:root /etc/apt/preferences.d/firefox.pref

# Adds PPA repository of Firefox
echo "Adds PPA repository of Firefox"
echo "Adds everything For the installation of Mozilla Firefox "
sudo apt-add-repository ppa:mozillateam/ppa
sudo apt update

# Installs Firefox
echo "Installs Firefox"
sudo apt install firefox -y
cat << EOF > Firefox.desktop
[Desktop Entry]
Name=Firefox
Exec=firefox
Icon=/usr/lib/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Comment=
Path=
StartupNotify=true
EOF

chmod -x Firefox.desktop

cp Firefox.desktop ~/Desktop/
cp Firefox.desktop ~/Schreibtisch
echo "Firefox was installed "

# Installs Synaptic 
sudo apt install synaptic -y

# Fertig
echo " Snap was removed "
echo " Goodbye Snap and all Snap Packets"
echo " Made by Tobyw121 "
