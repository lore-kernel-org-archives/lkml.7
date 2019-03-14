Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C18C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF1420854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfCNNHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:07:07 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35789 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:07:07 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost.localdomain (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 38EC7240004;
        Thu, 14 Mar 2019 13:07:02 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] ARM: dts: sun8i-h3: Add support for the RerVision H3-DVK board
Date:   Thu, 14 Mar 2019 14:06:56 +0100
Message-Id: <20190314130656.8010-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an H3-based board that sticks close to the reference design.

Supported features:
* UART
* DRAM
* MMC
* eMMC
* Ethernet
* USB host
* USB peripheral
* HDMI

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts | 119 +++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148a15b2..8db275b75214 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1078,6 +1078,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus.dtb \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-h3-orangepi-zero-plus2.dtb \
+	sun8i-h3-rervision-dvk.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts b/arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts
new file mode 100644
index 000000000000..94b71e064eb6
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-rervision-dvk.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "RerVision H3-DVK";
+	compatible = "rervision,h3-dvk", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_input: endpoint {
+				remote-endpoint = <&hdmi_connector_output>;
+			};
+		};
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_connector_output: endpoint {
+		remote-endpoint = <&hdmi_connector_input>;
+	};
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+	vmmc-supply = <&reg_vcc3v3>;
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&mmc2_8bit_pins {
+	drive-strength = <40>;
+	bias-pull-up;
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.21.0

