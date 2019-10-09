Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA61C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD2D20640
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfJIOhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:37:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfJIOhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:37:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68B3417EC3AC044581C8;
        Wed,  9 Oct 2019 22:37:14 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 22:37:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <yuehaibing@huawei.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] firmware: tegra: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 9 Oct 2019 22:36:48 +0800
Message-ID: <20191009143648.3620-1-yuehaibing@huawei.com>
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
 drivers/firmware/tegra/bpmp-tegra210.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra210.c b/drivers/firmware/tegra/bpmp-tegra210.c
index ae15940..c2447be 100644
--- a/drivers/firmware/tegra/bpmp-tegra210.c
+++ b/drivers/firmware/tegra/bpmp-tegra210.c
@@ -162,7 +162,6 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 {
 	struct platform_device *pdev = to_platform_device(bpmp->dev);
 	struct tegra210_bpmp *priv;
-	struct resource *res;
 	unsigned int i;
 	int err;
 
@@ -172,13 +171,11 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 
 	bpmp->priv = priv;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->atomics = devm_ioremap_resource(&pdev->dev, res);
+	priv->atomics = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->atomics))
 		return PTR_ERR(priv->atomics);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->arb_sema = devm_ioremap_resource(&pdev->dev, res);
+	priv->arb_sema = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->arb_sema))
 		return PTR_ERR(priv->arb_sema);
 
-- 
2.7.4


