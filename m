Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C1C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5895320B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfFSHLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:11:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34442 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSHLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:11:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E26120017D;
        Wed, 19 Jun 2019 09:10:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 881702005B3;
        Wed, 19 Jun 2019 09:10:53 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C70FC402F6;
        Wed, 19 Jun 2019 15:10:45 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, ccaione@baylibre.com, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] clk: imx8mq: Keep uart clocks on during system boot
Date:   Wed, 19 Jun 2019 15:12:40 +0800
Message-Id: <20190619071240.38503-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190619071240.38503-1-Anson.Huang@nxp.com>
References: <20190619071240.38503-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Call imx_register_uart_clocks() API to keep uart clocks enabled
when earlyprintk or earlycon is active.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 5fbc2a7..d407a07 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -272,6 +272,14 @@ static const char * const imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sy
 
 static struct clk_onecell_data clk_data;
 
+static struct clk ** const uart_clks[] = {
+	&clks[IMX8MQ_CLK_UART1_ROOT],
+	&clks[IMX8MQ_CLK_UART2_ROOT],
+	&clks[IMX8MQ_CLK_UART3_ROOT],
+	&clks[IMX8MQ_CLK_UART4_ROOT],
+	NULL
+};
+
 static int imx8mq_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -555,6 +563,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	err = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	WARN_ON(err);
 
+	imx_register_uart_clocks(uart_clks);
+
 	return err;
 }
 
-- 
2.7.4

