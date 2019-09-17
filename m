Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E222C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF93218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfIQIsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:48:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47556 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfIQIsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:48:03 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pK-0005ZY-QE; Tue, 17 Sep 2019 10:27:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 12/13] arm64: dts: rockchip: add usb2phy for px30
Date:   Tue, 17 Sep 2019 10:26:58 +0200
Message-Id: <20190917082659.25549-12-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the usb2phy node on the px30 and hook it up to the usb controllers
it supplies.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 9ad1c2f04ea9..837e421cc30f 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -701,6 +701,43 @@
 			<26000000>;
 	};
 
+	usb2phy_grf: syscon@ff2c0000 {
+		compatible = "rockchip,px30-usb2phy-grf", "syscon",
+			     "simple-mfd";
+		reg = <0x0 0xff2c0000 0x0 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy: usb2-phy@100 {
+			compatible = "rockchip,px30-usb2phy";
+			reg = <0x100 0x20>;
+			clocks = <&pmucru SCLK_USBPHY_REF>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&cru USB480M>;
+			assigned-clock-parents = <&u2phy>;
+			clock-output-names = "usb480m_phy";
+			status = "disabled";
+
+			u2phy_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+
+			u2phy_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				status = "disabled";
+			};
+		};
+	};
+
 	usb20_otg: usb@ff300000 {
 		compatible = "rockchip,px30-usb", "rockchip,rk3066-usb",
 			     "snps,dwc2";
@@ -713,6 +750,8 @@
 		g-rx-fifo-size = <280>;
 		g-tx-fifo-size = <256 128 128 64 32 16>;
 		g-use-dma;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
 		power-domains = <&power PX30_PD_USB>;
 		status = "disabled";
 	};
@@ -723,6 +762,8 @@
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST>;
 		clock-names = "usbhost";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
 		power-domains = <&power PX30_PD_USB>;
 		status = "disabled";
 	};
@@ -733,6 +774,8 @@
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST>;
 		clock-names = "usbhost";
+		phys = <&u2phy_host>;
+		phy-names = "usb";
 		power-domains = <&power PX30_PD_USB>;
 		status = "disabled";
 	};
-- 
2.20.1

