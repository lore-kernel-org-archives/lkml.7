Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEB0C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0250E2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 14:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A7cCZzyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAAOCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 09:02:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:47441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgAAOCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 09:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577887359;
        bh=7kmhkdXPBbL1jj3zc0sr6uH68l4x5u6bSPbY7lCoBww=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=A7cCZzyGsDJswKneoS/KZOFCYPG6K4mjXjjrjgbtEnzSqmm42WhRFJ6FYfoRYsdEC
         P9MzhVYjaGu7w9s6TBEFCHBWElSlAeueLgY6eMszYXC+PN1COuxuEgBGNccf2a4R2M
         kNpp0kDwzLrTonFR6nidu4Ag+3mVaOLQmYPRCtf0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MJmGP-1j2PDC1OWn-00K6si; Wed, 01 Jan 2020 15:02:39 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] Bluetooth: hci_bcm: Drive RTS only for BCM43438
Date:   Wed,  1 Jan 2020 15:01:34 +0100
Message-Id: <1577887294-6089-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xJplZGoEroUu1vuigD0tjAl4Wq6KAohLgNWl31Vnp+DQVNJEcCr
 948uuc7lO2JhdSbqS6YKnb1ZuFph4Rb65Dq+KbnDq2Yjb89E5HMSvhsg4ks0btvwBWzqFpR
 rnb/9JBS2kjbHKjY0RoVpw8fYBaboX/YFSAjSFnoN6/TFOkmACbfzBMvLNx9ckVMOepfuhG
 xv/e3EnT97QEUNV8XrbJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mNWhPzDDukc=:PIiLxvNGg5nMACH6n4Ux/0
 r57jFafuT9qFBrJ5TfaOk5/pLaYpQ4NU3rakKvNjaFEwx2bva3Wm6p4Ei7bFS1Ku+cHPzsOzM
 2MXZAaP8Gx4r9+irKQ6hJxUjyJ0RSk6TzEIBOG9dVjx7TwjaI2YWaFBYK5sEk6qw4XVrh/DS5
 GetEVxYil8b1b4e3Jch+yeayLNlnb10APwpVF9KhWAU97a53GeX2CgUuHBLZHAwwTDglf+fyH
 O/VpNTfQfTMsCRkBM2GY+PoPRhwQRTLqtI+0m6n6kHpcOCBhVWSPFxQ9YDzpqikWAHvl5LhaE
 RW5Grs51hRolQrjF0MF4I6Nn60x1esqo4g8N+vcwgjfcuXeFJMJbtr1WoMs1RYi2Bw+zBCZ2Q
 5KX/zN+oDk1Cy+WOBwthIEiaF4IZPxErz3/gteHgmbXyw02rNbz3te5Z56ZwzsxYUGI77so+O
 HgHXCmD95JP+coIhU8gxwCH1HSeXjT7i8OKxPgL0m1bBtR3f9c4fdSMuB4CIY4o+kZ90RzKrd
 L0kqaMkydPv02o4ILtkB1tmL/13rtwB9jADJHCyrcztawypK1Sy5hRNtd+l+4Y+Os00ASopMk
 glO1ZrXEa/00ipVnFUQ56QXLQtA/F6QQ1d1BL8FCI4sqknupHffxd6QrQW9ICYR6LWvGO0m2I
 WnNx2fAf9Wo+LHGfv9avKtub6tiYcFs4/8KNQ+f/Nc534+37kd6nIE5Q9FYoZ3liJrEcZsvEo
 F7jtu8oN2C+j7jOwaxd+CIH6WkBZlJhBdPPSzWeSrUCTsxF7Jp1wQulS4snH2qLU5c/lDTkTS
 +YiSmVnMteaAP0GsW98SJdZjnBeZDY/b0XNbky1KDwaSVouffmALLq0urAmbyYPB9T5AIeGDp
 mlm2DKLbBAF3OlPXlW636oxewJko9SNzzQ26b+Lf682HJV8z3SzcHt0q2Q4O6OQuRg8HqUP4W
 nPcdv7I1+57wuOoXC/y0jBMBEHkVqdeaVZlNjSOlCn7KgEkNGCAudS6V8c+gbOACv/Si/+cZt
 H1e6jWA5h/ylGISEnrk1lHRwK6tyCP6Znzxun8AkG4gyDeCOxmpImBbOXXzklktlzhhMVEwg6
 dqJ2FXaNzMDtqikLXlGixJdmiI57oW+cdENh2BhHFxbxludi5V06GPtFdoh3tR/zdb6Z/DN6/
 CGpxykKtMCd9Nf5EMOPUHXofGBNkSKMN17RDdfEsgN3B5KQ2hWw0f8E981pVbbLoF0GTSr9pK
 3g5dioNizp4zHqG4fTKUbMWvynRrFZ7m1hgyn//Weyzxx0ycMGEl6ZtS3AQI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3347a80965b3 ("Bluetooth: hci_bcm: Fix RTS handling during
startup") is causing at least a regression for AP6256 on Orange Pi 3.
So do the RTS line handing during startup only on the necessary platform.

Fixes: 3347a80965b3 ("Bluetooth: hci_bcm: Fix RTS handling during startup"=
)
Reported-by: Ond=C5=99ej Jirman <megous@megous.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/bluetooth/hci_bcm.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index bbfaf0c..769bb44 100644
=2D-- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -53,6 +53,7 @@
  */
 struct bcm_device_data {
 	bool	no_early_set_baudrate;
+	bool	drive_rts_on_open;
 };

 /**
@@ -122,6 +123,7 @@ struct bcm_device {
 	bool			is_suspended;
 #endif
 	bool			no_early_set_baudrate;
+	bool			drive_rts_on_open;
 	u8			pcm_int_params[5];
 };

@@ -456,7 +458,9 @@ static int bcm_open(struct hci_uart *hu)

 out:
 	if (bcm->dev) {
-		hci_uart_set_flow_control(hu, true);
+		if (bcm->dev->drive_rts_on_open)
+			hci_uart_set_flow_control(hu, true);
+
 		hu->init_speed =3D bcm->dev->init_speed;

 		/* If oper_speed is set, ldisc/serdev will set the baudrate
@@ -466,7 +470,10 @@ static int bcm_open(struct hci_uart *hu)
 			hu->oper_speed =3D bcm->dev->oper_speed;

 		err =3D bcm_gpio_set_power(bcm->dev, true);
-		hci_uart_set_flow_control(hu, false);
+
+		if (bcm->dev->drive_rts_on_open)
+			hci_uart_set_flow_control(hu, false);
+
 		if (err)
 			goto err_unset_hu;
 	}
@@ -1447,8 +1454,10 @@ static int bcm_serdev_probe(struct serdev_device *s=
erdev)
 		dev_err(&serdev->dev, "Failed to power down\n");

 	data =3D device_get_match_data(bcmdev->dev);
-	if (data)
+	if (data) {
 		bcmdev->no_early_set_baudrate =3D data->no_early_set_baudrate;
+		bcmdev->drive_rts_on_open =3D data->drive_rts_on_open;
+	}

 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
 }
@@ -1465,12 +1474,16 @@ static struct bcm_device_data bcm4354_device_data =
=3D {
 	.no_early_set_baudrate =3D true,
 };

+static struct bcm_device_data bcm43438_device_data =3D {
+	.drive_rts_on_open =3D true,
+};
+
 static const struct of_device_id bcm_bluetooth_of_match[] =3D {
 	{ .compatible =3D "brcm,bcm20702a1" },
 	{ .compatible =3D "brcm,bcm4329-bt" },
 	{ .compatible =3D "brcm,bcm4345c5" },
 	{ .compatible =3D "brcm,bcm4330-bt" },
-	{ .compatible =3D "brcm,bcm43438-bt" },
+	{ .compatible =3D "brcm,bcm43438-bt", .data =3D &bcm43438_device_data },
 	{ .compatible =3D "brcm,bcm43540-bt", .data =3D &bcm4354_device_data },
 	{ .compatible =3D "brcm,bcm4335a0" },
 	{ },
=2D-
2.7.4

