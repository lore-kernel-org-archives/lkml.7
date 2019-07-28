Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835AC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563622077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfG1OIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:08:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42778 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1OIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:08:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C96B2011AF;
        Sun, 28 Jul 2019 16:08:29 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F25252011AB;
        Sun, 28 Jul 2019 16:08:28 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D0B52060A;
        Sun, 28 Jul 2019 16:08:28 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        baruch@tkos.co.il, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        angus@akkea.ca, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq-evk: Unbypass audio_pll1
Date:   Sun, 28 Jul 2019 17:08:17 +0300
Message-Id: <20190728140817.12509-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making audio_pll1 parent of audio_pll1_bypass, will allow
setting rates multiple of 8000 for children.

After unbypass clk hierarchy looks like this:
 * osc_25m
   * audio_pll1
     * audio_pll1_bypass
       * audio_pll1_out
         * sai2
           * sai2_root_clk

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index e3df9b8cd9ca..05958124f173 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -118,9 +118,9 @@
 &sai2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
+	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <0>, <24576000>;
 	status = "okay";
 };
 
-- 
2.17.1

