Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA0D20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfDJPi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:38:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731503AbfDJPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:38:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B5AE1E1F9D71F31DD01;
        Wed, 10 Apr 2019 23:38:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 23:38:49 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul.burton@mips.com>, <bbrezillon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] mtd: nand: Fix build error while CONFIG_MTD_NAND_ECC_SW_BCH is set to module
Date:   Wed, 10 Apr 2019 23:37:07 +0800
Message-ID: <20190410153707.29492-1-yuehaibing@huawei.com>
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
while MTD_RAW_NAND is set to y.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 193bd4002644 ("mtd: nand: add software BCH ECC support")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use imply as suggestion
---
 drivers/mtd/devices/Kconfig  |  2 +-
 drivers/mtd/nand/raw/Kconfig | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 7fcdaf6..f9258d6 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -207,7 +207,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
 	tristate "M-Systems Disk-On-Chip G3"
 	select BCH
-	select BCH_CONST_PARAMS if !CONFIG_MTD_NAND_ECC_SW_BCH
+	select BCH_CONST_PARAMS if !MTD_NAND_ECC_SW_BCH
 	select BITREVERSE
 	help
 	  This provides an MTD device driver for the M-Systems DiskOnChip
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 615d738..65c85fc 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -9,11 +9,22 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
 	  Software ECC according to the Smart Media Specification.
 	  The original Linux implementation had byte 0 and 1 swapped.
 
+config MTD_NAND_ECC_SW_BCH
+	tristate "Support software BCH ECC"
+	select BCH
+	default n
+	help
+	  This enables support for software BCH error correction. Binary BCH
+	  codes are more powerful and cpu intensive than traditional Hamming
+	  ECC codes. They are used with NAND devices requiring more than 1 bit
+	  of error correction.
+
 menuconfig MTD_RAW_NAND
 	tristate "Raw/Parallel NAND Device Support"
 	depends on MTD
 	select MTD_NAND_CORE
 	select MTD_NAND_ECC_SW_HAMMING
+	imply MTD_NAND_ECC_SW_BCH
 	help
 	  This enables support for accessing all type of raw/parallel
 	  NAND flash devices. For further information see
@@ -21,16 +32,6 @@ menuconfig MTD_RAW_NAND
 
 if MTD_RAW_NAND
 
-config MTD_NAND_ECC_SW_BCH
-	tristate "Support software BCH ECC"
-	select BCH
-	default n
-	help
-	  This enables support for software BCH error correction. Binary BCH
-	  codes are more powerful and cpu intensive than traditional Hamming
-	  ECC codes. They are used with NAND devices requiring more than 1 bit
-	  of error correction.
-
 comment "Raw/parallel NAND flash controllers"
 
 config MTD_NAND_DENALI
-- 
2.7.4


