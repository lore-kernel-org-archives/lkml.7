Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D86DECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3602064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbfJOOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:23:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732050AbfJOOXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:23:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 86C819DAF3342081BB63;
        Tue, 15 Oct 2019 22:23:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 22:23:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Eugeniy.Paltsev@synopsys.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: axs10x: use devm_platform_ioremap_resource() to simplify code
Date:   Tue, 15 Oct 2019 22:22:59 +0800
Message-ID: <20191015142259.17216-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/axs10x/i2s_pll_clock.c | 4 +---
 drivers/clk/axs10x/pll_clock.c     | 7 ++-----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/axs10x/i2s_pll_clock.c b/drivers/clk/axs10x/i2s_pll_clock.c
index 71c2e95..e9da0e6 100644
--- a/drivers/clk/axs10x/i2s_pll_clock.c
+++ b/drivers/clk/axs10x/i2s_pll_clock.c
@@ -172,14 +172,12 @@ static int i2s_pll_clk_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct i2s_pll_clk *pll_clk;
 	struct clk_init_data init;
-	struct resource *mem;
 
 	pll_clk = devm_kzalloc(dev, sizeof(*pll_clk), GFP_KERNEL);
 	if (!pll_clk)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pll_clk->base = devm_ioremap_resource(dev, mem);
+	pll_clk->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pll_clk->base))
 		return PTR_ERR(pll_clk->base);
 
diff --git a/drivers/clk/axs10x/pll_clock.c b/drivers/clk/axs10x/pll_clock.c
index aba787b..500345d 100644
--- a/drivers/clk/axs10x/pll_clock.c
+++ b/drivers/clk/axs10x/pll_clock.c
@@ -221,7 +221,6 @@ static int axs10x_pll_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const char *parent_name;
 	struct axs10x_pll_clk *pll_clk;
-	struct resource *mem;
 	struct clk_init_data init = { };
 	int ret;
 
@@ -229,13 +228,11 @@ static int axs10x_pll_clk_probe(struct platform_device *pdev)
 	if (!pll_clk)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pll_clk->base = devm_ioremap_resource(dev, mem);
+	pll_clk->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pll_clk->base))
 		return PTR_ERR(pll_clk->base);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	pll_clk->lock = devm_ioremap_resource(dev, mem);
+	pll_clk->lock = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(pll_clk->lock))
 		return PTR_ERR(pll_clk->lock);
 
-- 
2.7.4


