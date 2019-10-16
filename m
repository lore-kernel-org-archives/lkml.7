Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4338CECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2435D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbfJPCRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:17:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39636 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732007AbfJPCRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:17:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B89F20093F;
        Wed, 16 Oct 2019 04:17:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 612F12004B9;
        Wed, 16 Oct 2019 04:17:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D1B864030C;
        Wed, 16 Oct 2019 10:17:06 +0800 (SGT)
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
Subject: [PATCH 4/5] arm64: dts: imx8mn: Move usdhc clocks assignment to board DT
Date:   Wed, 16 Oct 2019 10:14:26 +0800
Message-Id: <1571192067-19600-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi         | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 1b90faac..5c96203 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -186,6 +186,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MN_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
@@ -197,6 +199,8 @@
 };
 
 &usdhc3 {
+	assigned-clocks = <&clk IMX8MN_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 73e3711..46c218e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -598,8 +598,6 @@
 					 <&clk IMX8MN_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MN_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX8MN_CLK_USDHC1>;
-				assigned-clock-rates = <400000000>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
@@ -628,8 +626,6 @@
 					 <&clk IMX8MN_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MN_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX8MN_CLK_USDHC3_ROOT>;
-				assigned-clock-rates = <400000000>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
-- 
2.7.4

