Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C7C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BBB206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfFJFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 01:34:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35540 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387528AbfFJFe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 01:34:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 988682006ED;
        Mon, 10 Jun 2019 07:34:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 283522006F6;
        Mon, 10 Jun 2019 07:34:48 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E8E1440310;
        Mon, 10 Jun 2019 13:34:39 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, l.stach@pengutronix.de, ccaione@baylibre.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] clk: imx8mq: Use imx_check_clocks() API directly
Date:   Mon, 10 Jun 2019 13:36:34 +0800
Message-Id: <20190610053634.14339-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610053634.14339-1-Anson.Huang@nxp.com>
References: <20190610053634.14339-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use imx_check_clocks() API to check clocks directly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 7da1edb..5fbc2a7 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -278,7 +278,6 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
 	int err;
-	int i;
 
 	clks[IMX8MQ_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 	clks[IMX8MQ_CLK_32K] = of_clk_get_by_name(np, "ckil");
@@ -548,10 +547,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 					   clks[IMX8MQ_ARM_PLL_OUT],
 					   clks[IMX8MQ_SYS1_PLL_800M]);
 
-	for (i = 0; i < IMX8MQ_CLK_END; i++)
-		if (IS_ERR(clks[i]))
-			pr_err("i.MX8mq clk %u register failed with %ld\n",
-			       i, PTR_ERR(clks[i]));
+	imx_check_clocks(clks, ARRAY_SIZE(clks));
 
 	clk_data.clks = clks;
 	clk_data.clk_num = ARRAY_SIZE(clks);
-- 
2.7.4

