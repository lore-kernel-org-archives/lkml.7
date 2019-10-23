Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D2ECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C04B2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406272AbfJWN5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:57:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405260AbfJWN53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:57:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ED1D5DD28FD9AC71B3EB;
        Wed, 23 Oct 2019 21:57:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:57:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <piotrs@cadence.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: rawnand: cadence: Remove dev_err() on platform_get_irq() failure
Date:   Wed, 23 Oct 2019 21:57:10 +0800
Message-ID: <20191023135710.29888-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() will call dev_err() itself on failure,
so there is no need for the driver to also do this.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 91dabff..5f07e8e 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2961,10 +2961,8 @@ static int cadence_nand_dt_probe(struct platform_device *ofdev)
 
 	cdns_ctrl->dev = &ofdev->dev;
 	cdns_ctrl->irq = platform_get_irq(ofdev, 0);
-	if (cdns_ctrl->irq < 0) {
-		dev_err(&ofdev->dev, "no irq defined\n");
+	if (cdns_ctrl->irq < 0)
 		return cdns_ctrl->irq;
-	}
 	dev_info(cdns_ctrl->dev, "IRQ: nr %d\n", cdns_ctrl->irq);
 
 	cdns_ctrl->reg = devm_platform_ioremap_resource(ofdev, 0);
-- 
2.7.4


