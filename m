Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C2C2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405257AbfHBKeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:34:16 -0400
Received: from shell.v3.sk ([90.176.6.54]:47579 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404935AbfHBKeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:34:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0E73280536;
        Fri,  2 Aug 2019 12:34:05 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XVuQ5ilwv7tj; Fri,  2 Aug 2019 12:33:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0DF8180538;
        Fri,  2 Aug 2019 12:33:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mjuXp4jJ5lMD; Fri,  2 Aug 2019 12:33:40 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C72EB8053E;
        Fri,  2 Aug 2019 12:33:36 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 6/6] ARM: dts: mmp2: add OLPC XO 1.75 machine
Date:   Fri,  2 Aug 2019 12:33:26 +0200
Message-Id: <20190802103326.531250-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190802103326.531250-1-lkundrak@v3.sk>
References: <20190802103326.531250-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fairly complete description of an OLPC XO 1.75 laptop.
What's missing for now is the GPU, LCD controller, DCON, the panel and
audio.

The machine is booted with OpenFirmware and thus has a devicetree.
However, older versions are unable to create a valid FDT and don't
follow the Linux bindings. Having an device tree in the kernel tree
makes it easier to use mainline kernels on such machines, test changes
with CONFIG_ARM_APPENDED_DTB and give a good reference on what bindings
are used on the machine without an access to one.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/Makefile              |   3 +-
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 244 ++++++++++++++++++++++++
 2 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90c..65213b5265187 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -336,7 +336,8 @@ dtb-$(CONFIG_MACH_MESON8) +=3D \
 dtb-$(CONFIG_ARCH_MMP) +=3D \
 	pxa168-aspenite.dtb \
 	pxa910-dkb.dtb \
-	mmp2-brownstone.dtb
+	mmp2-brownstone.dtb \
+	mmp2-olpc-xo-1-75.dtb
 dtb-$(CONFIG_ARCH_MPS2) +=3D \
 	mps2-an385.dtb \
 	mps2-an399.dtb
diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/=
mmp2-olpc-xo-1-75.dts
new file mode 100644
index 0000000000000..6cfa0d4a18845
--- /dev/null
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * OLPC XO 1.75 Laptop.
+ *
+ * Copyright (C) 2018,2019 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+/dts-v1/;
+#include "mmp2.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model =3D "OLPC XO-1.75";
+	compatible =3D "olpc,xo-1.75", "mrvl,mmp2";
+
+	chosen {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges;
+
+		framebuffer@1fc00000 {
+			compatible =3D "simple-framebuffer";
+			reg =3D <0x1fc00000 (1200 * 900 * 2)>;
+			width =3D <1200>;
+			height =3D <900>;
+			stride =3D <(1200 * 2)>;
+			format =3D "r5g6b5";
+			clocks =3D <&soc_clocks MMP2_CLK_DISP0_LCDC>,
+				 <&soc_clocks MMP2_CLK_DISP0>;
+		};
+	};
+
+	memory {
+		linux,usable-memory =3D <0x0 0x1f800000>;
+		available =3D <0xcf000 0x1ef31000 0x1000 0xbf000>;
+		reg =3D <0x0 0x20000000>;
+		device_type =3D "memory";
+	};
+
+	gpio-keys {
+		compatible =3D "gpio-keys";
+
+		lid {
+			label =3D "Lid";
+			gpios =3D <&gpio 129 GPIO_ACTIVE_LOW>;
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_LID>;
+			wakeup-source;
+		};
+
+		tablet_mode {
+			label =3D "E-Book Mode";
+			gpios =3D <&gpio 128 GPIO_ACTIVE_LOW>;
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_TABLET_MODE>;
+			wakeup-source;
+		};
+
+		microphone_insert {
+			label =3D "Microphone Plug";
+			gpios =3D <&gpio 96 GPIO_ACTIVE_HIGH>;
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_MICROPHONE_INSERT>;
+			debounce-interval =3D <100>;
+			wakeup-source;
+		};
+
+		headphone_insert {
+			label =3D "Headphone Plug";
+			gpios =3D <&gpio 97 GPIO_ACTIVE_HIGH>;
+			linux,input-type =3D <EV_SW>;
+			linux,code =3D <SW_HEADPHONE_INSERT>;
+			debounce-interval =3D <100>;
+			wakeup-source;
+		};
+	};
+
+	camera_i2c {
+		compatible =3D "i2c-gpio";
+		gpios =3D <&gpio 109 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>,
+			<&gpio 108 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		i2c-gpio,timeout-ms =3D <1000>;
+		status =3D "okay";
+
+		camera@21 {
+			compatible =3D "ovti,ov7670";
+			reg =3D <0x21>;
+			reset-gpios =3D <&gpio 102 GPIO_ACTIVE_LOW>;
+			powerdown-gpios =3D <&gpio 150 GPIO_ACTIVE_LOW>;
+			clocks =3D <&camera0>;
+			clock-names =3D "xclk";
+
+			port {
+				ov7670_0: endpoint {
+					hsync-active =3D <1>;
+					vsync-active =3D <1>;
+					remote-endpoint =3D <&camera0_0>;
+				};
+			};
+		};
+	};
+
+	battery {
+		compatible =3D "olpc,xo1.5-battery", "olpc,xo1-battery";
+	};
+
+	wlan_reg: fixedregulator0 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "wlan";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		gpio =3D <&gpio 34 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	wlan_pwrseq: pwrseq0 {
+		compatible =3D "mmc-pwrseq-sd8787";
+		powerdown-gpios =3D <&gpio 57 GPIO_ACTIVE_HIGH>;
+		reset-gpios =3D <&gpio 58 GPIO_ACTIVE_HIGH>;
+	};
+
+	soc {
+		axi@d4200000 {
+			ap-sp@d4290000 {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				compatible =3D "olpc,ap-sp";
+				interrupts =3D <40>;
+				reg =3D <0xd4290000 0x1000>;
+				data-gpios =3D <&gpio 72 GPIO_ACTIVE_HIGH>;
+				clk-gpios =3D <&gpio 71 GPIO_ACTIVE_HIGH>;
+				status =3D "okay";
+			};
+		};
+	};
+};
+
+&uart3 {
+	status =3D "okay";
+};
+
+&uart4 {
+	status =3D "okay";
+};
+
+&rtc {
+	status =3D "okay";
+};
+
+&usb_phy0 {
+	status =3D "okay";
+};
+
+&usb_otg0 {
+	status =3D "okay";
+};
+
+&mmc1 {
+	clock-frequency =3D <50000000>;
+	no-1-8-v;
+	mrvl,clk-delay-cycles =3D <31>;
+	broken-cd;
+	status =3D "okay";
+};
+
+&mmc2 {
+	clock-frequency =3D <50000000>;
+	no-1-8-v;
+	bus-width =3D <4>;
+	non-removable;
+	broken-cd;
+	wakeup-source;
+	keep-power-in-suspend;
+	mmc-pwrseq =3D <&wlan_pwrseq>;
+	vmmc-supply =3D <&wlan_reg>;
+	status =3D "okay";
+};
+
+&mmc3 {
+	clock-frequency =3D <50000000>;
+	no-1-8-v;
+	bus-width =3D <8>;
+	non-removable;
+	broken-cd;
+	mrvl,clk-delay-cycles =3D <31>;
+	status =3D "okay";
+};
+
+&twsi1 {
+	status =3D "okay";
+
+	audio-codec@1a {
+		compatible =3D "realtek,alc5631";
+		reg =3D <0x1a>;
+		status =3D "okay";
+	};
+};
+
+&twsi2 {
+	status =3D "okay";
+
+	rtc@68 {
+		compatible =3D "dallas,ds1338";
+		reg =3D <0x68>;
+		status =3D "okay";
+	};
+};
+
+&twsi6 {
+	status =3D "okay";
+
+	accelerometer@1d {
+		compatible =3D "st,lis331dlh", "st,lis3lv02d";
+		reg =3D <0x1d>;
+		status =3D "okay";
+	};
+};
+
+&ssp3 {
+	#address-cells =3D <0>;
+	spi-slave;
+	status =3D "okay";
+	ready-gpio =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+	slave {
+		compatible =3D "olpc,xo1.75-ec";
+		spi-cpha;
+		cmd-gpio =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&camera0 {
+	status =3D "okay";
+
+	port {
+		camera0_0: endpoint {
+			remote-endpoint =3D <&ov7670_0>;
+		};
+	};
+};
--=20
2.21.0

