Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5BCECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80620650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391961AbfJPJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:24:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfJPJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:24:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58B5D5162D73CB561496;
        Wed, 16 Oct 2019 17:24:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 17:24:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ipmi: bt-bmc: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 17:21:31 +0800
Message-ID: <20191016092131.23096-1-yuehaibing@huawei.com>
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
 drivers/char/ipmi/bt-bmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 40b9927..d36aeac 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -444,15 +444,13 @@ static int bt_bmc_probe(struct platform_device *pdev)
 
 	bt_bmc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(bt_bmc->map)) {
-		struct resource *res;
 		void __iomem *base;
 
 		/*
 		 * Assume it's not the MFD-based devicetree description, in
 		 * which case generate a regmap ourselves
 		 */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		base = devm_ioremap_resource(&pdev->dev, res);
+		base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
-- 
2.7.4


