Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A6C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E68220726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIOxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:53:16 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46588 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIOxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:53:14 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ieKPN-0001Ca-En; Mon, 09 Dec 2019 15:53:09 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: add core dsi components for px30
Date:   Mon,  9 Dec 2019 15:53:00 +0100
Message-Id: <20191209145301.5307-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

This adds the dw-mipi-dsi controller and the external dsi-dphy
and hooks them into the display-subsystem on px30.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index c31423f36192..ff53cc56f80f 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -820,6 +820,19 @@ u2phy_otg: otg-port {
 		};
 	};
 
+	dsi_dphy: phy@ff2e0000 {
+		compatible = "rockchip,px30-dsi-dphy";
+		reg = <0x0 0xff2e0000 0x0 0x10000>;
+		clocks = <&pmucru SCLK_MIPIDSIPHY_REF>, <&cru PCLK_MIPIDSIPHY>;
+		clock-names = "ref", "pclk";
+		#clock-cells = <0>;
+		resets = <&cru SRST_MIPIDSIPHY_P>;
+		reset-names = "apb";
+		#phy-cells = <0>;
+		power-domains = <&power PX30_PD_VO>;
+		status = "disabled";
+	};
+
 	usb20_otg: usb@ff300000 {
 		compatible = "rockchip,px30-usb", "rockchip,rk3066-usb",
 			     "snps,dwc2";
@@ -943,6 +956,44 @@ gpu: gpu@ff400000 {
 		status = "disabled";
 	};
 
+	dsi: dsi@ff450000 {
+		compatible = "rockchip,px30-mipi-dsi";
+		reg = <0x0 0xff450000 0x0 0x10000>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_MIPI_DSI>;
+		clock-names = "pclk";
+		resets = <&cru SRST_MIPIDSI_HOST_P>;
+		reset-names = "apb";
+		phys = <&dsi_dphy>;
+		phy-names = "dphy";
+		power-domains = <&power PX30_PD_VO>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dsi_in_vopb: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_dsi>;
+				};
+
+				dsi_in_vopl: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_dsi>;
+				};
+			};
+		};
+	};
+
 	vopb: vop@ff460000 {
 		compatible = "rockchip,px30-vop-big";
 		reg = <0x0 0xff460000 0x0 0xefc>;
@@ -960,6 +1011,11 @@ vopb: vop@ff460000 {
 		vopb_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopb_out_dsi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dsi_in_vopb>;
+			};
 		};
 	};
 
@@ -992,6 +1048,11 @@ vopl: vop@ff470000 {
 		vopl_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopl_out_dsi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dsi_in_vopl>;
+			};
 		};
 	};
 
-- 
2.24.0

