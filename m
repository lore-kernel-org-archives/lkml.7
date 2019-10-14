Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DCEECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A6B21835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfJNOjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:39:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732981AbfJNOjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:39:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D7614E7280617369737;
        Mon, 14 Oct 2019 22:39:01 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 22:38:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <eric@anholt.net>,
        <wahrenst@gmx.net>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <mripard@kernel.org>, <heiko@sntech.de>,
        <yuehaibing@huawei.com>, <mbrugger@suse.com>, <broonie@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-clk@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: bcm2835: use devm_platform_ioremap_resource() to simplify code
Date:   Mon, 14 Oct 2019 22:36:42 +0800
Message-ID: <20191014143642.24552-1-yuehaibing@huawei.com>
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
 drivers/clk/bcm/clk-bcm2835-aux.c | 4 +---
 drivers/clk/bcm/clk-bcm2835.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index b6d07ca..290a284 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -19,7 +19,6 @@ static int bcm2835_aux_clk_probe(struct platform_device *pdev)
 	struct clk_hw_onecell_data *onecell;
 	const char *parent;
 	struct clk *parent_clk;
-	struct resource *res;
 	void __iomem *reg, *gate;
 
 	parent_clk = devm_clk_get(dev, NULL);
@@ -27,8 +26,7 @@ static int bcm2835_aux_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(parent_clk);
 	parent = __clk_get_name(parent_clk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(dev, res);
+	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 802e488..ded13cc 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -2192,7 +2192,6 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct clk_hw **hws;
 	struct bcm2835_cprman *cprman;
-	struct resource *res;
 	const struct bcm2835_clk_desc *desc;
 	const size_t asize = ARRAY_SIZE(clk_desc_array);
 	const struct cprman_plat_data *pdata;
@@ -2211,8 +2210,7 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 
 	spin_lock_init(&cprman->regs_lock);
 	cprman->dev = dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cprman->regs = devm_ioremap_resource(dev, res);
+	cprman->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cprman->regs))
 		return PTR_ERR(cprman->regs);
 
-- 
2.7.4


