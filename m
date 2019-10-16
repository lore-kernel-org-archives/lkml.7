Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9723BECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5220872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbfJPIub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:50:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfJPIua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:50:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 654FF79F726037B6E36F;
        Wed, 16 Oct 2019 16:50:29 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:50:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <TheSven73@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: fieldbus: arcx-anybus:use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 16:50:16 +0800
Message-ID: <20191016085016.23676-1-yuehaibing@huawei.com>
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
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index 2ecffa4..5b8d0ba 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -127,12 +127,10 @@ static const struct regmap_config arcx_regmap_cfg = {
 static struct regmap *create_parallel_regmap(struct platform_device *pdev,
 					     int idx)
 {
-	struct resource *res;
 	void __iomem *base;
 	struct device *dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, idx + 1);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 	return devm_regmap_init_mmio(dev, base, &arcx_regmap_cfg);
@@ -230,7 +228,6 @@ static int controller_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct regulator_dev *regulator;
 	int err, id;
-	struct resource *res;
 	struct anybuss_host *host;
 	u8 status1, cap;
 
@@ -244,8 +241,7 @@ static int controller_probe(struct platform_device *pdev)
 		return PTR_ERR(cd->reset_gpiod);
 
 	/* CPLD control memory, sits at index 0 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cd->cpld_base = devm_ioremap_resource(dev, res);
+	cd->cpld_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cd->cpld_base)) {
 		dev_err(dev,
 			"failed to map cpld base address\n");
-- 
2.7.4


