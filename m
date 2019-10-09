Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E9AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2BD218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfJIPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:06:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfJIPF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:05:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 88476E027C07F55D1EF4;
        Wed,  9 Oct 2019 23:05:53 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 23:05:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <carmeli.tamir@gmail.com>,
        <daniela.mormocea@gmail.com>, <payal.s.kshirsagar.98@gmail.com>,
        <sicilia.cristian@gmail.com>, <saiyamdoshi.in@gmail.com>,
        <nishadkamdar@gmail.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: emxx_udc: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 9 Oct 2019 23:05:35 +0800
Message-ID: <20191009150535.6412-1-yuehaibing@huawei.com>
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
 drivers/staging/emxx_udc/emxx_udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 147481b..9e0c19e 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3078,7 +3078,6 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 {
 	int	status = -ENODEV;
 	struct nbu2ss_udc	*udc;
-	struct resource *r;
 	int irq;
 	void __iomem *mmio_base;
 
@@ -3088,8 +3087,7 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, udc);
 
 	/* require I/O memory and IRQ to be provided as resources */
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mmio_base))
 		return PTR_ERR(mmio_base);
 
-- 
2.7.4


