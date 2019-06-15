Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD3C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA3721773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFONpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 09:45:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfFONpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:45:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF088C10F934311373F7;
        Sat, 15 Jun 2019 21:45:37 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Jun 2019
 21:45:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>, <paul@crapouillou.net>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mtd: rawnand: ingenic: Fix build error
Date:   Sat, 15 Jun 2019 21:44:30 +0800
Message-ID: <20190615134430.30384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MTD_NAND_JZ4780 is y and MTD_NAND_JZ4780_BCH is m,
which select CONFIG_MTD_NAND_INGENIC_ECC to m, building fails:

drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function `ingenic_nand_remove':
ingenic_nand.c:(.text+0x177): undefined reference to `ingenic_ecc_release'
drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function `ingenic_nand_ecc_correct':
ingenic_nand.c:(.text+0x2ee): undefined reference to `ingenic_ecc_correct'

Select MTD_NAND_INGENIC_ECC if MTD_NAND_JZ4780 is set

Reported-by: Hulk Robot <hulkci@huawei.com>
Fiexes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/ingenic/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
index 19a96ce..d0b1909 100644
--- a/drivers/mtd/nand/raw/ingenic/Kconfig
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -9,6 +9,7 @@ config MTD_NAND_JZ4740
 config MTD_NAND_JZ4780
 	tristate "JZ4780 NAND controller"
 	depends on JZ4780_NEMC
+	select MTD_NAND_INGENIC_ECC
 	help
 	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
 	  based boards, using the BCH controller for hardware error correction.
@@ -20,7 +21,6 @@ config MTD_NAND_INGENIC_ECC
 
 config MTD_NAND_JZ4740_ECC
 	tristate "Hardware BCH support for JZ4740 SoC"
-	select MTD_NAND_INGENIC_ECC
 	help
 	  Enable this driver to support the Reed-Solomon error-correction
 	  hardware present on the JZ4740 SoC from Ingenic.
@@ -30,7 +30,6 @@ config MTD_NAND_JZ4740_ECC
 
 config MTD_NAND_JZ4725B_BCH
 	tristate "Hardware BCH support for JZ4725B SoC"
-	select MTD_NAND_INGENIC_ECC
 	help
 	  Enable this driver to support the BCH error-correction hardware
 	  present on the JZ4725B SoC from Ingenic.
@@ -40,7 +39,6 @@ config MTD_NAND_JZ4725B_BCH
 
 config MTD_NAND_JZ4780_BCH
 	tristate "Hardware BCH support for JZ4780 SoC"
-	select MTD_NAND_INGENIC_ECC
 	help
 	  Enable this driver to support the BCH error-correction hardware
 	  present on the JZ4780 SoC from Ingenic.
-- 
2.7.4


