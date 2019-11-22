Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8194C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C717320718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfKVMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:03:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbfKVMDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:03:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D76088106B322F716145;
        Fri, 22 Nov 2019 20:03:19 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 22 Nov 2019 20:03:10 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <kyungmin.park@samsung.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] nand: onenand: samsung: remove variable 'tmp' set but not used
Date:   Fri, 22 Nov 2019 20:08:54 +0800
Message-ID: <1574424534-141265-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:
drivers/mtd/nand/onenand/samsung_mtd.c: In function s3c_onenand_check_lock_status:
drivers/mtd/nand/onenand/samsung_mtd.c:731:6: warning: variable tmp set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/mtd/nand/onenand/samsung_mtd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/onenand/samsung_mtd.c b/drivers/mtd/nand/onenand/samsung_mtd.c
index 55e5536..3573b12 100644
--- a/drivers/mtd/nand/onenand/samsung_mtd.c
+++ b/drivers/mtd/nand/onenand/samsung_mtd.c
@@ -728,13 +728,12 @@ static void s3c_onenand_check_lock_status(struct mtd_info *mtd)
 	struct onenand_chip *this = mtd->priv;
 	struct device *dev = &onenand->pdev->dev;
 	unsigned int block, end;
-	int tmp;
 
 	end = this->chipsize >> this->erase_shift;
 
 	for (block = 0; block < end; block++) {
 		unsigned int mem_addr = onenand->mem_addr(block, 0, 0);
-		tmp = s3c_read_cmd(CMD_MAP_01(onenand, mem_addr));
+		s3c_read_cmd(CMD_MAP_01(onenand, mem_addr));
 
 		if (s3c_read_reg(INT_ERR_STAT_OFFSET) & LOCKED_BLK) {
 			dev_err(dev, "block %d is write-protected!\n", block);
-- 
2.7.4

