Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC262C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2CA2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfG1PUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:20:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51204 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfG1PUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:20:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7C042011E2;
        Sun, 28 Jul 2019 17:20:44 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C90682011D4;
        Sun, 28 Jul 2019 17:20:44 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B2C52060A;
        Sun, 28 Jul 2019 17:20:44 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        baruch@tkos.co.il, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        angus@akkea.ca, agx@sigxcpu.org, Anson.Huang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs for clocks
Date:   Sun, 28 Jul 2019 18:20:40 +0300
Message-Id: <20190728152040.15323-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

Add the initial configuration for clocks that need default parent and rate
setting. This is based on the vendor tree clock provider parents and rates
configuration except this is doing the setup in dts rather then using clock
consumer API in a clock provider driver.

Note that by adding the initial rate setting for audio_pll1/audio_pll
setting we need to remove it from imx8mq-librem5-devkit.dts

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Tested-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
Changes since v3:
	- fix extra new lines

 .../dts/freescale/imx8mq-librem5-devkit.dts   |  5 -----
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 683a11035643..c702ccc82867 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -169,11 +169,6 @@
 	};
 };
 
-&clk {
-	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
-	assigned-clock-rates = <786432000>, <722534400>;
-};
-
 &dphy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 02fbd0625318..a55d72ba2e05 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -494,6 +494,25 @@
 				clock-names = "ckil", "osc_25m", "osc_27m",
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
+				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1>,
+					<&clk IMX8MQ_AUDIO_PLL1>,
+					<&clk IMX8MQ_AUDIO_PLL2>,
+					<&clk IMX8MQ_CLK_AHB>,
+					<&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
+					<&clk IMX8MQ_CLK_AUDIO_AHB>,
+					<&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
+					<&clk IMX8MQ_CLK_NOC>;
+				assigned-clock-parents = <0>,
+						<0>,
+						<0>,
+						<&clk IMX8MQ_SYS1_PLL_133M>,
+						<&clk IMX8MQ_SYS1_PLL_266M>,
+						<&clk IMX8MQ_SYS2_PLL_500M>,
+						<&clk IMX8MQ_CLK_27M>,
+						<&clk IMX8MQ_SYS1_PLL_800M>;
+				assigned-clock-rates = <593999999>,
+						<786432000>,
+						<722534400>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.17.1

