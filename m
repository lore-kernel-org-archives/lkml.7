Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960E921848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJOLgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:36:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728061AbfJOLgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:36:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0CEA856F593A920B9B6C;
        Tue, 15 Oct 2019 19:36:47 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 19:36:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <yuehaibing@huawei.com>,
        <tglx@linutronix.de>, <weiyi.lu@mediatek.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next] clk: mediatek: mt2712: use devm_platform_ioremap_resource() to simplify code
Date:   Tue, 15 Oct 2019 19:26:44 +0800
Message-ID: <20191015112644.19816-1-yuehaibing@huawei.com>
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
 drivers/clk/mediatek/clk-mt2712.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 354c26f..a3bd9a1 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1306,9 +1306,8 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	int r, i;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		pr_err("%s(): ioremap failed\n", __func__);
 		return PTR_ERR(base);
@@ -1394,9 +1393,8 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		pr_err("%s(): ioremap failed\n", __func__);
 		return PTR_ERR(base);
-- 
2.7.4


