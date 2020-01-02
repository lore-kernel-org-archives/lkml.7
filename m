Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E47C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE2821D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgABB1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:27:24 -0500
Received: from foss.arm.com ([217.140.110.172]:43550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABB1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:27:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 258551063;
        Wed,  1 Jan 2020 17:27:23 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0E8A3F703;
        Wed,  1 Jan 2020 17:27:21 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes
Date:   Thu,  2 Jan 2020 01:26:57 +0000
Message-Id: <20200102012657.9278-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200102012657.9278-1-andre.przywara@arm.com>
References: <20200102012657.9278-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner R40 SoC contains four SPI controllers, using the newer
sun6i design (but at the legacy addresses).
The controller seems to be fully compatible to the A64 one, so no driver
changes are necessary.
The first three controller can be used on two sets of pins, but SPI3 is
only routed to one set on Port A.

Tested by connecting a SPI flash to a Bananapi M2 Berry on the SPI0
PortC header pins.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 8dcbc4465fbb..af437391dcf4 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -418,6 +418,41 @@
 				bias-pull-up;
 			};
 
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC0", "PC1", "PC2", "PC23";
+				function = "spi0";
+			};
+
+			spi0_pi_pins: spi0-pi-pins {
+				pins = "PI10", "PI11", "PI12", "PI13", "PI14";
+				function = "spi0";
+			};
+
+			spi1_pa_pins: spi1-pa-pins {
+				pins = "PA0", "PA1", "PA2", "PA3", "PA4";
+				function = "spi1";
+			};
+
+			spi1_pi_pins: spi1-pi-pins {
+				pins = "PI15", "PI16", "PI17", "PI18", "PI19";
+				function = "spi1";
+			};
+
+			spi2_pb_pins: spi2-pb-pins {
+				pins = "PB13", "PB14", "PB15", "PB16", "PB17";
+				function = "spi2";
+			};
+
+			spi2_pc_pins: spi2-pc-pins {
+				pins = "PC19", "PC20", "PC21", "PC22";
+				function = "spi2";
+			};
+
+			spi3_pins: spi3-pins {
+				pins = "PA5", "PA6", "PA7", "PA8", "PA9";
+				function = "spi3";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -594,6 +629,60 @@
 			#size-cells = <0>;
 		};
 
+		spi0: spi@1c05000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@1c06000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi2: spi@1c07000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c07000 0x1000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi3: spi@1c0f000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c0f000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
+			clock-names = "ahb", "mod";
+			pinctrl-0 = <&spi3_pins>;
+			pinctrl-names = "default";
+			resets = <&ccu RST_BUS_SPI3>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ahci: sata@1c18000 {
 			compatible = "allwinner,sun8i-r40-ahci";
 			reg = <0x01c18000 0x1000>;
-- 
2.14.5

