Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E0C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C566021655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="Br0y0a6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfHPIoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:44:23 -0400
Received: from letterbox.kde.org ([46.43.1.242]:39534 "EHLO letterbox.kde.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfHPIoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:44:22 -0400
Received: from archbox.localdomain (unknown [203.187.238.17])
        (Authenticated sender: bshah)
        by letterbox.kde.org (Postfix) with ESMTPSA id 44D8E2809BC;
        Fri, 16 Aug 2019 09:44:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1565945059; bh=sAbIIO25DFg96Y7To2es2ueSVMDPNv0p6SZWhrXB2FI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Br0y0a6vew+9OIPXxe4HVf75OTvlvAQOWBlv42czZM1VT8G9CTdhCSFc+ETQDTXmj
         E12KzdzF72kObah17DUTIyOg0wOVn6fB9O/Qe4wnpwtbhdw5CxqSIuN3/S9UfbMimj
         KQpRQ1cfGw5oR2ESsu+KDTGm5DJWB+qO+uo+De3f7nope/OHfT7Yjwn8KY3KzLfBwH
         vrXN8Y5SQQG7g19be6ybba2QIqSNWfnfdMJJviQrWOSQt+cxRa0MnDZ9qZiExrq1uG
         1C+A6Y0ltffihQ3iRhDPUXbZAFM4tgNIZEEqG7hMRRxeeW/g29VcL8e0drtr85R2j4
         iJ9IWE/XVY4VQ==
From:   Bhushan Shah <bshah@kde.org>
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, Bhushan Shah <bshah@kde.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] arm64: allwinner: h6: add I2C nodes
Date:   Fri, 16 Aug 2019 14:13:09 +0530
Message-Id: <20190816084309.27440-3-bshah@kde.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816084309.27440-1-bshah@kde.org>
References: <20190816064710.18280-1-bshah@kde.org>
 <20190816084309.27440-1-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree nodes for i2c0 to i2c2, and also add relevant pinctrl
nodes.

Suggested-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Bhushan Shah <bshah@kde.org>
---
Changes in v3:
  - fix compatible for the i2c
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 60 +++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index db71807255ef..5dc174715311 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -332,6 +332,21 @@
 				function = "hdmi";
 			};
 
+			i2c0_pins: i2c0-pins {
+				pins = "PD25", "PD26";
+				function = "i2c0";
+			};
+
+			i2c1_pins: i2c1-pins {
+				pins = "PH5", "PH6";
+				function = "i2c1";
+			};
+
+			i2c2_pins: i2c2-pins {
+				pins = "PD23", "PD24";
+				function = "i2c2";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
@@ -467,6 +482,48 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c@5002000 {
+			compatible = "allwinner,sun50i-h6-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x05002000 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@5002400 {
+			compatible = "allwinner,sun50i-h6-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x05002400 0x400>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@5002800 {
+			compatible = "allwinner,sun50i-h6-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x05002800 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		emac: ethernet@5020000 {
 			compatible = "allwinner,sun50i-h6-emac",
 				     "allwinner,sun50i-a64-emac";
@@ -798,7 +855,8 @@
 		};
 
 		r_i2c: i2c@7081400 {
-			compatible = "allwinner,sun6i-a31-i2c";
+			compatible = "allwinner,sun50i-h6-i2c",
+				     "allwinner,sun6i-a31-i2c";
 			reg = <0x07081400 0x400>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB2_I2C>;
-- 
2.17.1

