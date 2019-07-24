Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B99C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910902253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGXDPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:15:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53972 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfGXDPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 23:15:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B31402000E2;
        Wed, 24 Jul 2019 05:15:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88AE7200034;
        Wed, 24 Jul 2019 05:15:25 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CA888402F6;
        Wed, 24 Jul 2019 11:15:17 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, gustavo@embeddedor.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clk: imx7ulp: Make sure earlycon's clock is enabled
Date:   Wed, 24 Jul 2019 11:06:00 +0800
Message-Id: <20190724030600.17839-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Earlycon's clock could be disabled during kernel boot up,
if earlycon is enabled and its clock is gated, then kernel
boot up will fail. Make sure earlycon's clock is enabled
during kernel boot up.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 42e4667..2022d9b 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -42,6 +42,19 @@ static const struct clk_div_table ulp_div_table[] = {
 	{ .val = 7, .div = 64, },
 };
 
+static const int pcc2_uart_clk_ids[] __initconst = {
+	IMX7ULP_CLK_LPUART4,
+	IMX7ULP_CLK_LPUART5,
+};
+
+static const int pcc3_uart_clk_ids[] __initconst = {
+	IMX7ULP_CLK_LPUART6,
+	IMX7ULP_CLK_LPUART7,
+};
+
+static struct clk **pcc2_uart_clks[ARRAY_SIZE(pcc2_uart_clk_ids) + 1] __initdata;
+static struct clk **pcc3_uart_clks[ARRAY_SIZE(pcc3_uart_clk_ids) + 1] __initdata;
+
 static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -135,6 +148,7 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **clks;
 	void __iomem *base;
+	int i;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC2_END),
 			   GFP_KERNEL);
@@ -173,6 +187,14 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 	imx_check_clk_hws(clks, clk_data->num);
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+
+	for (i = 0; i < ARRAY_SIZE(pcc2_uart_clk_ids); i++) {
+		int index = pcc2_uart_clk_ids[i];
+
+		pcc2_uart_clks[i] = &clks[index]->clk;
+	}
+
+	imx_register_uart_clocks(pcc2_uart_clks);
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", imx7ulp_clk_pcc2_init);
 
@@ -181,6 +203,7 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **clks;
 	void __iomem *base;
+	int i;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC3_END),
 			   GFP_KERNEL);
@@ -218,6 +241,14 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 	imx_check_clk_hws(clks, clk_data->num);
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+
+	for (i = 0; i < ARRAY_SIZE(pcc3_uart_clk_ids); i++) {
+		int index = pcc3_uart_clk_ids[i];
+
+		pcc3_uart_clks[i] = &clks[index]->clk;
+	}
+
+	imx_register_uart_clocks(pcc3_uart_clks);
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init);
 
-- 
2.7.4

