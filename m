Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB6C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 00:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6C5217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 00:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAFAjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 19:39:07 -0500
Received: from foss.arm.com ([217.140.110.172]:39236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgAFAjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 19:39:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F2D531B;
        Sun,  5 Jan 2020 16:39:06 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4D53F703;
        Sun,  5 Jan 2020 16:39:04 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2] ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes
Date:   Mon,  6 Jan 2020 00:38:49 +0000
Message-Id: <20200106003849.16666-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner R40 SoC contains four SPI controllers, using the newer
sun6i design (but at the legacy addresses).
The controller seems to be fully compatible to the A64 one, so no driver
changes are necessary.
The first three controllers can be used on two sets of pins, but SPI3 is
only routed to one set on Port A.
Only the pin groups for SPI0 on PortC and SPI1 on PortI are added here,
because those seem to be the only one exposed on the Bananapi boards.

Tested by connecting a SPI flash to a Bananapi M2 Berry SPI0 and SPI1
header pins.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Changes from v1 3/3 ... v2:
- Removed most pin groups except SPI0-PC and SPI1-PI
- Split off CS pins
- Add omit-if-no-ref tags

 arch/arm/boot/dts/sun8i-r40.dtsi | 90 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 8dcbc4465fbb..c5654fd034be 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -418,6 +418,36 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC0", "PC1", "PC2";
+				function = "spi0";
+			};
+
+			/omit-if-no-ref/
+			spi0_cs0_pc_pin: spi0-cs0-pc-pin {
+				pins = "PC23";
+				function = "spi0";
+			};
+
+			/omit-if-no-ref/
+			spi1_pi_pins: spi1-pi-pins {
+				pins = "PI17", "PI18", "PI19";
+				function = "spi1";
+			};
+
+			/omit-if-no-ref/
+			spi1_cs0_pi_pin: spi1-cs0-pi-pin {
+				pins = "PI16";
+				function = "spi1";
+			};
+
+			/omit-if-no-ref/
+			spi1_cs1_pi_pin: spi1-cs1-pi-pin {
+				pins = "PI15";
+				function = "spi1";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -594,6 +624,66 @@
 			#size-cells = <0>;
 		};
 
+		spi0: spi@1c05000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
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
+			dmas = <&dma 25>, <&dma 25>;
+			dma-names = "rx", "tx";
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
+			dmas = <&dma 26>, <&dma 26>;
+			dma-names = "rx", "tx";
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
+			dmas = <&dma 27>, <&dma 27>;
+			dma-names = "rx", "tx";
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

