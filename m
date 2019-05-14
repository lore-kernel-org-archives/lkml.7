Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E415820881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfENUyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:54:54 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:33943 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726362AbfENUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:54:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 72127521E15;
        Tue, 14 May 2019 22:54:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pn1ki_A1-MXA; Tue, 14 May 2019 22:54:51 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 11E89521E6F;
        Tue, 14 May 2019 22:54:51 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A83ED521E15;
        Tue, 14 May 2019 22:54:50 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v2] arm64: dts: allwinner: a64: orangepi-win: Add wifi and bluetooth nodes
Date:   Tue, 14 May 2019 22:54:45 +0200
Message-Id: <20190514205445.11591-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
identifies as BCM43430, while the Bluetooth side identifies as BCM43438.

WiFi is connected to mmc1 and the Bluetooth side is connected to UART1
in a 4 wire configuration. Same as the WiFi side, due to being the same
chip and package, DLDO2 provides overall power via VBAT, and DLDO4
provides I/O power via VDDIO. The RTC clock output provides the LPO low
power clock at 32.768 kHz.

This patch enables WiFi and Bluetooth on OrangePi Win boards and adds
missing LPO clock on the WiFi side. PCM connection also exists for
Bluetooth audio, but it's not used here.

Bluetooth UART speed is set to 1.5 MBaud in order to be able transmit
audio. While module supports even higher speeds, currently sunxi clock
driver doesn't support higher speed.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Changes from v1:
- fix commit log by stating that current clock driver doesn't support
  higher speeds instead of UART driver

 .../dts/allwinner/sun50i-a64-orangepi-win.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 510f661229dc..5ef3c62c765e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -109,6 +109,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible =3D "mmc-pwrseq-simple";
 		reset-gpios =3D <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+		clocks =3D <&rtc 1>;
+		clock-names =3D "ext_clock";
 	};
 };
=20
@@ -170,6 +172,14 @@
 	bus-width =3D <4>;
 	non-removable;
 	status =3D "okay";
+
+	brcmf: wifi@1 {
+		reg =3D <1>;
+		compatible =3D "brcm,bcm4329-fmac";
+		interrupt-parent =3D <&r_pio>;
+		interrupts =3D <0 7 IRQ_TYPE_LEVEL_LOW>; /* PL7 */
+		interrupt-names =3D "host-wake";
+	};
 };
=20
 &ohci0 {
@@ -342,7 +352,20 @@
 &uart1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status =3D "okay";
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		max-speed =3D <1500000>;
+		clocks =3D <&rtc 1>;
+		clock-names =3D "lpo";
+		vbat-supply =3D <&reg_dldo2>;
+		vddio-supply =3D <&reg_dldo4>;
+		device-wakeup-gpios =3D <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		host-wakeup-gpios =3D <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+	};
 };
=20
 /* On Pi-2 connector, RTS/CTS optional */
--=20
2.21.0

