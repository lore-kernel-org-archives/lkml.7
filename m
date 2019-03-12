Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2324BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5662083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCLPdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:33:44 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40105 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfCLPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:32:59 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 6517A15FCC9;
        Tue, 12 Mar 2019 15:26:40 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 14/14] ARM: dts: sun8i: s3l: add support for Pine64 Single Cube Computer
Date:   Tue, 12 Mar 2019 23:22:56 +0800
Message-Id: <20190312152256.35574-15-icenowy@aosc.io>
In-Reply-To: <20190312152256.35574-1-icenowy@aosc.io>
References: <20190312152256.35574-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Single Cube Computer kit by Pine64 is a development kit with
Allwinner S3L SoC.

It comes with a main board, an expansion board and a camera.

The main board features a Micro-USB power-only jack, a USB Type-A port,
an Ethernet port connected to the internal PHY of the SoC. A RGB LED
port is reserved on the board.

The expansion board features a TF slot, a microphone and a speaker
connector with on-board amplifier.

Add support for the kit, with features on the main board and the
expansion board now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/sun8i-s3l-single-cube-computer.dts    | 166 ++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3l-single-cube-computer.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aeaf3298..a77d1a000953 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1096,6 +1096,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
 	sun8i-r16-parrot.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
+	sun8i-s3l-single-cube-computer.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
diff --git a/arch/arm/boot/dts/sun8i-s3l-single-cube-computer.dts b/arch/arm/boot/dts/sun8i-s3l-single-cube-computer.dts
new file mode 100644
index 000000000000..a014de597c8a
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3l-single-cube-computer.dts
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2019 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+/dts-v1/;
+#include "sun8i-s3l.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Pine64 Single Cube Computer";
+	compatible = "pine64,single-cube-computer", "allwinner,sun8i-s3l";
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "pine64:green:led1";
+			gpios = <&pio 1 11 GPIO_ACTIVE_LOW>; /* PB11 */
+		};
+
+		led2 {
+			label = "pine64:green:led2";
+			gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
+		};
+
+		led3 {
+			label = "pine64:green:led3";
+			gpios = <&pio 1 12 GPIO_ACTIVE_LOW>; /* PB12 */
+		};
+
+		led4 {
+			label = "pine64:green:led4";
+			gpios = <&pio 1 13 GPIO_ACTIVE_LOW>; /* PB13 */
+		};
+	};
+
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_wifi: vcc-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 1 2 GPIO_ACTIVE_LOW>; /* PB2 WIFI-EN */
+		vin-supply = <&reg_dcdc3>;
+		startup-delay-us = <200000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 WIFI-RST */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		compatible = "x-powers,axp203",
+			     "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc_wifi>;
+	vqmmc-supply = <&reg_dcdc3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&pio {
+	vcc-pd-supply = <&reg_dcdc3>;
+	vcc-pe-supply = <&reg_ldo3>;
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <1250000>;
+	regulator-name = "vdd-sys-cpu-ephy";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_ldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-pe";
+};
+
+&reg_ldo4 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avdd-mipi";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.18.1

