Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6401A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCLPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:32:58 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40098 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCLPc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:32:56 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id AE2D715FCC8;
        Tue, 12 Mar 2019 15:26:33 +0000 (UTC)
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
Subject: [PATCH 13/14] ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
Date:   Tue, 12 Mar 2019 23:22:55 +0800
Message-Id: <20190312152256.35574-14-icenowy@aosc.io>
In-Reply-To: <20190312152256.35574-1-icenowy@aosc.io>
References: <20190312152256.35574-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3/V3s/S3L/SoChip S3 Ethernet MAC and internal PHY is quite
similar to the ones on Allwinner H3, except for V3s the external MII is
not wired out.

Add ethernet support to V3/V3s/S3/S3L.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3.dtsi  | 13 ++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index 6ae8645ade50..ca4672ed2e02 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -9,6 +9,19 @@
 	compatible = "allwinner,sun8i-v3-ccu";
 };
 
+&emac {
+	/delete-property/ phy-handle;
+	/delete-property/ phy-mode;
+};
+
+&mdio_mux {
+	external_mdio: mdio@2 {
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
 &pio {
 	compatible = "allwinner,sun8i-v3-pinctrl";
 };
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 10795b5ec376..0f179785be81 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -141,6 +141,15 @@
 			};
 		};
 
+		syscon: system-control@1c00000 {
+			compatible = "allwinner,sun8i-v3s-system-control",
+				     "allwinner,sun8i-h3-system-control";
+			reg = <0x01c00000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
 		tcon0: lcd-controller@1c0c000 {
 			compatible = "allwinner,sun8i-v3s-tcon";
 			reg = <0x01c0c000 0x1000>;
@@ -411,6 +420,49 @@
 			#size-cells = <0>;
 		};
 
+		emac: ethernet@1c30000 {
+			compatible = "allwinner,sun8i-v3s-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			phy-handle = <&int_mii_phy>;
+			phy-mode = "mii";
+			status = "disabled";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+
+			mdio_mux: mdio-mux {
+				compatible = "allwinner,sun8i-h3-mdio-mux";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mdio-parent-bus = <&mdio>;
+				/* Only one MDIO is usable at the time */
+				internal_mdio: mdio@1 {
+					compatible = "allwinner,sun8i-h3-mdio-internal";
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					int_mii_phy: ethernet-phy@1 {
+						compatible = "ethernet-phy-ieee802.3-c22";
+						reg = <1>;
+						clocks = <&ccu CLK_BUS_EPHY>;
+						resets = <&ccu RST_BUS_EPHY>;
+					};
+				};
+			};
+		};
+
 		spi0: spi@1c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
-- 
2.18.1

