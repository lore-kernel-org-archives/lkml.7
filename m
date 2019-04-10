Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EAAC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DA52083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfDJNLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:11:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbfDJNLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:11:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2EB64FAA5A17F98C34F8;
        Wed, 10 Apr 2019 21:11:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 21:11:01 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul.burton@mips.com>, <bbrezillon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mtd: nand: Fix build error while CONFIG_MTD_NAND_ECC_SW_BCH is set to module
Date:   Wed, 10 Apr 2019 21:07:47 +0800
Message-ID: <20190410130747.35692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix gcc build error while CONFIG_MTD_NAND_ECC_SW_BCH
is set to module:

drivers/mtd/nand/raw/nand_base.o: In function `nand_cleanup':
(.text+0xef6): undefined reference to `nand_bch_free'
drivers/mtd/nand/raw/nand_base.o: In function `nand_scan_tail':
nand_base.c:(.text+0xa101): undefined reference to `nand_bch_calculate_ecc'
nand_base.c:(.text+0xa120): undefined reference to `nand_bch_correct_data'
nand_base.c:(.text+0xa269): undefined reference to `nand_bch_init'

CONFIG_MTD_NAND_ECC_SW_BCH should not be set to M,
because MTD_RAW_NAND need it while linked.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 193bd4002644 ("mtd: nand: add software BCH ECC support"
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 615d738..0500c42 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -22,7 +22,7 @@ menuconfig MTD_RAW_NAND
 if MTD_RAW_NAND
 
 config MTD_NAND_ECC_SW_BCH
-	tristate "Support software BCH ECC"
+	bool "Support software BCH ECC"
 	select BCH
 	default n
 	help
-- 
2.7.4


