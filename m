Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D76C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1500821848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfJIOqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:46:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730674AbfJIOqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:46:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 13323F43F7DFF59EF2D1;
        Wed,  9 Oct 2019 22:46:09 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 22:45:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zbr@ioremap.net>, <gregkh@linuxfoundation.org>,
        <yuehaibing@huawei.com>, <tbogendoerfer@suse.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] w1: sgi_w1: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 9 Oct 2019 22:44:35 +0800
Message-ID: <20191009144435.12656-1-yuehaibing@huawei.com>
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
 drivers/w1/masters/sgi_w1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/w1/masters/sgi_w1.c b/drivers/w1/masters/sgi_w1.c
index 1b2d96b..e8c7fa6 100644
--- a/drivers/w1/masters/sgi_w1.c
+++ b/drivers/w1/masters/sgi_w1.c
@@ -77,15 +77,13 @@ static int sgi_w1_probe(struct platform_device *pdev)
 {
 	struct sgi_w1_device *sdev;
 	struct sgi_w1_platform_data *pdata;
-	struct resource *res;
 
 	sdev = devm_kzalloc(&pdev->dev, sizeof(struct sgi_w1_device),
 			    GFP_KERNEL);
 	if (!sdev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdev->mcr = devm_ioremap_resource(&pdev->dev, res);
+	sdev->mcr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdev->mcr))
 		return PTR_ERR(sdev->mcr);
 
-- 
2.7.4


