Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5242C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CDC21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbfGRPNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:13:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44720 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfGRPNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:13:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 67AC21A02BB;
        Thu, 18 Jul 2019 17:13:50 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AA0D1A0127;
        Thu, 18 Jul 2019 17:13:50 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 63D46205C7;
        Thu, 18 Jul 2019 17:13:49 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        aisheng.dong@nxp.com, leonard.crestez@nxp.com, anson.huang@nxp.com,
        peng.fan@nxp.com, Frank.Li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: [PATCH 1/3] clk: imx8: Add DSP related clocks
Date:   Thu, 18 Jul 2019 18:13:44 +0300
Message-Id: <20190718151346.3523-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718151346.3523-1-daniel.baluta@nxp.com>
References: <20190718151346.3523-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP contains Hifi4 DSP. There are four clocks
associated with DSP:
  * dsp_lpcg_core_clk
  * dsp_lpcg_ipg_clk
  * dsp_lpcg_adb_aclk
  * ocram_lpcg_ipg_clk

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c     | 5 +++++
 include/dt-bindings/clock/imx8-clock.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index fb6edf1b8aa2..c0aff7ca6374 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -72,6 +72,11 @@ static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[] = {
 	{ IMX_ADMA_LPCG_I2C2_CLK, "i2c2_lpcg_clk", "i2c2_clk", 0, ADMA_LPI2C_2_LPCG, 0, 0, },
 	{ IMX_ADMA_LPCG_I2C3_IPG_CLK, "i2c3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_3_LPCG, 16, 0, },
 	{ IMX_ADMA_LPCG_I2C3_CLK, "i2c3_lpcg_clk", "i2c3_clk", 0, ADMA_LPI2C_3_LPCG, 0, 0, },
+
+	{ IMX_ADMA_LPCG_DSP_CORE_CLK, "dsp_lpcg_core_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 28, 0, },
+	{ IMX_ADMA_LPCG_DSP_IPG_CLK, "dsp_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 20, 0, },
+	{ IMX_ADMA_LPCG_DSP_ADB_CLK, "dsp_lpcg_adb_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_OCRAM_IPG_CLK, "ocram_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_OCRAM_LPCG, 16, 0, },
 };
 
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_adma = {
diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 4236818e3be5..673a8c662340 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -283,7 +283,11 @@
 #define IMX_ADMA_LPCG_PWM_IPG_CLK			38
 #define IMX_ADMA_LPCG_LCD_PIX_CLK			39
 #define IMX_ADMA_LPCG_LCD_APB_CLK			40
+#define IMX_ADMA_LPCG_DSP_ADB_CLK			41
+#define IMX_ADMA_LPCG_DSP_IPG_CLK			42
+#define IMX_ADMA_LPCG_DSP_CORE_CLK			43
+#define IMX_ADMA_LPCG_OCRAM_IPG_CLK			44
 
-#define IMX_ADMA_LPCG_CLK_END				41
+#define IMX_ADMA_LPCG_CLK_END				45
 
 #endif /* __DT_BINDINGS_CLOCK_IMX_H */
-- 
2.17.1

