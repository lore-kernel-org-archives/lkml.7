Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FABC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA478207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfLIOMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:12:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbfLIOLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:11:54 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5CB71F1F54802B1C6EE;
        Mon,  9 Dec 2019 22:11:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 9 Dec 2019 22:11:41 +0800
From:   John Garry <john.garry@huawei.com>
To:     <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: hisi-sfc: Try to provide some clarity on which SFC we are
Date:   Mon, 9 Dec 2019 22:08:08 +0800
Message-ID: <1575900490-74467-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is for the HiSilicon FMC (Flash Memory Controller), which
supports SPI NOR in addition other memory technologies, like SPI NAND.

Indeed, the naming in the driver is a little inappropriate, especially
considering that there is already another HiSilicon SPI NOR flash
controller (which I believe the FMC is derived from).

Since we now want to provide software support for this other HiSilicon
controller, update code comments to at least try to make it clear that
this driver is for the FMC.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/mtd/spi-nor/Kconfig    | 4 ++--
 drivers/mtd/spi-nor/hisi-sfc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index f237fcdf7f86..c1eda67d1ad2 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -46,11 +46,11 @@ config SPI_CADENCE_QUADSPI
 	  Flash as an MTD device.
 
 config SPI_HISI_SFC
-	tristate "Hisilicon SPI-NOR Flash Controller(SFC)"
+	tristate "Hisilicon FMC SPI-NOR Flash Controller(SFC)"
 	depends on ARCH_HISI || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This enables support for hisilicon SPI-NOR flash controller.
+	  This enables support for HiSilicon FMC SPI-NOR flash controller.
 
 config SPI_MTK_QUADSPI
 	tristate "MediaTek Quad SPI controller"
diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/hisi-sfc.c
index a1258216f89d..6db964bf3b0e 100644
--- a/drivers/mtd/spi-nor/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/hisi-sfc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * HiSilicon SPI Nor Flash Controller Driver
+ * HiSilicon FMC SPI-NOR flash controller driver
  *
  * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
  */
-- 
2.17.1

