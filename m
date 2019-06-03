Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D45AC282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9127A49
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFCArx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 20:47:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56296 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCAqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 20:46:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 210161A001B;
        Mon,  3 Jun 2019 02:46:38 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D41D91A02FA;
        Mon,  3 Jun 2019 02:46:31 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2957B402CF;
        Mon,  3 Jun 2019 08:46:24 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        viresh.kumar@linaro.org, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mm: Fix build warnings
Date:   Mon,  3 Jun 2019 08:48:20 +0800
Message-Id: <20190603004820.36247-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

This patch fixes below build warning with "W=1":

arch/arm64/boot/dts/freescale/imx8mm.dtsi:203.6-754.4:
 Warning (unit_address_vs_reg): /soc: node has a reg or
 ranges property, but no unit name
arch/arm64/boot/dts/freescale/imx8mm.dtsi:209.23-388.5:
 Warning (unit_address_vs_reg): /soc/bus@30000000: node
 has a unit name, but no reg property
arch/arm64/boot/dts/freescale/imx8mm.dtsi:390.23-439.5:
 Warning (unit_address_vs_reg): /soc/bus@30400000: node
 has a unit name, but no reg property
arch/arm64/boot/dts/freescale/imx8mm.dtsi:441.23-658.5:
 Warning (unit_address_vs_reg): /soc/bus@30800000: node
 has a unit name, but no reg property
arch/arm64/boot/dts/freescale/imx8mm.dtsi:660.23-724.5:
 Warning (unit_address_vs_reg): /soc/bus@32c00000: node
 has a unit name, but no reg property
arch/arm64/boot/dts/freescale/imx8mm.dtsi:681.27-687.6:
 Warning (simple_bus_reg): /soc/bus@32c00000/usbphynop1:
 missing or empty reg/ranges property
arch/arm64/boot/dts/freescale/imx8mm.dtsi:710.27-716.6:
 Warning (simple_bus_reg): /soc/bus@32c00000/usbphynop2:
 missing or empty reg/ranges property

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 38 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 708d3c4..dc99f45 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -200,7 +200,7 @@
 		arm,no-tick-in-suspend;
 	};
 
-	soc {
+	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -208,6 +208,7 @@
 
 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x30000000 0x400000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -389,6 +390,7 @@
 
 		aips2: bus@30400000 {
 			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x30400000 0x400000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -440,6 +442,7 @@
 
 		aips3: bus@30800000 {
 			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x30800000 0x400000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -659,6 +662,7 @@
 
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x32c00000 0x400000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -678,14 +682,6 @@
 				status = "disabled";
 			};
 
-			usbphynop1: usbphynop1 {
-				compatible = "usb-nop-xceiv";
-				clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
-				assigned-clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_100M>;
-				clock-names = "main_clk";
-			};
-
 			usbmisc1: usbmisc@32e40200 {
 				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
 				#index-cells = <1>;
@@ -707,14 +703,6 @@
 				status = "disabled";
 			};
 
-			usbphynop2: usbphynop2 {
-				compatible = "usb-nop-xceiv";
-				clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
-				assigned-clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_100M>;
-				clock-names = "main_clk";
-			};
-
 			usbmisc2: usbmisc@32e50200 {
 				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
 				#index-cells = <1>;
@@ -752,4 +740,20 @@
 			status = "disabled";
 		};
 	};
+
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
+		assigned-clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
+		assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_100M>;
+		clock-names = "main_clk";
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
+		assigned-clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
+		assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_100M>;
+		clock-names = "main_clk";
+	};
 };
-- 
2.7.4

