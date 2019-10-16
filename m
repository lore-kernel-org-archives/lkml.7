Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74653ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D0420873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfJPCRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:17:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57544 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbfJPCRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:17:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 17F481A0854;
        Wed, 16 Oct 2019 04:17:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 205311A04F9;
        Wed, 16 Oct 2019 04:17:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DC22C402B3;
        Wed, 16 Oct 2019 10:16:58 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        jun.li@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, daniel.lezcano@linaro.org,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, jon@solid-run.com, baruch@tkos.co.il,
        angus@akkea.ca, pavel@ucw.cz, agx@sigxcpu.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        dafna.hirschfeld@collabora.com, richard.hu@technexion.com,
        andradanciu1997@gmail.com, manivannan.sadhasivam@linaro.org,
        aisheng.dong@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to board DT
Date:   Wed, 16 Oct 2019 10:14:23 +0800
Message-Id: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usdhc's clock rate is different according to different devices
connected, so clock rate assignment should be placed in board
DT according to different devices connected on each usdhc port.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   | 4 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      | 6 ------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
index 91eef97..a3f8cf1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
@@ -133,6 +133,8 @@
 &usdhc1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
+	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	bus-width = <4>;
@@ -149,6 +151,8 @@
 
 /* SD */
 &usdhc2 {
+	assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 88dd9132..d3d26cc 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -137,6 +137,8 @@
 };
 
 &usdhc1 {
+	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	bus-width = <8>;
@@ -147,6 +149,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 2d69f1a..9646a41 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -368,8 +368,6 @@
 				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
 				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
 			clock-names = "ipg", "per", "ahb";
-			assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
-			assigned-clock-rates = <200000000>;
 			power-domains = <&pd IMX_SC_R_SDHC_0>;
 			status = "disabled";
 		};
@@ -383,8 +381,6 @@
 				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
 				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
 			clock-names = "ipg", "per", "ahb";
-			assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
-			assigned-clock-rates = <200000000>;
 			power-domains = <&pd IMX_SC_R_SDHC_1>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step= <2>;
@@ -400,8 +396,6 @@
 				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
 				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
 			clock-names = "ipg", "per", "ahb";
-			assigned-clocks = <&clk IMX_CONN_SDHC2_CLK>;
-			assigned-clock-rates = <200000000>;
 			power-domains = <&pd IMX_SC_R_SDHC_2>;
 			status = "disabled";
 		};
-- 
2.7.4

