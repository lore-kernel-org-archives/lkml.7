Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5BA20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfJIPF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:05:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfJIPF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:05:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A5F762D325306B8FE36C;
        Wed,  9 Oct 2019 23:05:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 23:05:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: clocking-wizard: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 9 Oct 2019 23:04:27 +0800
Message-ID: <20191009150427.10852-1-yuehaibing@huawei.com>
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
 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
index 15b7a82..e52a64b 100644
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
@@ -135,7 +135,6 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	unsigned long rate;
 	const char *clk_name;
 	struct clk_wzrd *clk_wzrd;
-	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
 
 	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
@@ -143,8 +142,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, clk_wzrd);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	clk_wzrd->base = devm_ioremap_resource(&pdev->dev, mem);
+	clk_wzrd->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(clk_wzrd->base))
 		return PTR_ERR(clk_wzrd->base);
 
-- 
2.7.4


