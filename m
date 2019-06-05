Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA4BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF3C20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFEVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:35:35 -0400
Received: from mx.allycomm.com ([138.68.30.55]:10524 "EHLO mx.allycomm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFEVff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:35:35 -0400
Received: from allycomm.com (unknown [IPv6:2601:647:5401:2210::49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.allycomm.com (Postfix) with ESMTPSA id 0998D22214;
        Wed,  5 Jun 2019 14:35:33 -0700 (PDT)
From:   Jeff Kletsky <lede@allycomm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Jeff Kletsky <git-commits@allycomm.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spinand: Support Paragon PN26G01A and PN26G02A
Date:   Wed,  5 Jun 2019 14:35:15 -0700
Message-Id: <20190605213516.13516-1-lede@allycomm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kletsky <git-commits@allycomm.com>

These Paragon chips are very similar to other 1Gb/2Gb chips
in terms of their layout and command timings.

One notable difference is that "Minimum number of valid blocks"
(Nvb) is 1003 per Gb, rather than the common 1004. As a result,
the bad-block reservation is 21 per Gb, rather than 20 per Gb.

Datasheets available at
http://www.xtxtech.com/upfile/2016082517274590.pdf
http://www.xtxtech.com/upfile/2016082517282329.pdf

Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>
---
 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |   1 +
 drivers/mtd/nand/spi/paragon.c | 142 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |   1 +
 4 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/paragon.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 753125082640..9662b9c1d5a9 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o toshiba.o winbond.o
+spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 556bfdb34455..f0f3528aab8f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -757,6 +757,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
+	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 };
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
new file mode 100644
index 000000000000..dd863dbc593a
--- /dev/null
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Jeff Kletsky
+ *
+ * Author: Jeff Kletsky <git-commits@allycomm.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+
+#define SPINAND_MFR_PARAGON	0xa1
+
+
+#define PN26G0XA_STATUS_ECC_BITMASK		(3 << 4)
+
+#define PN26G0XA_STATUS_ECC_NONE_DETECTED	(0 << 4)
+#define PN26G0XA_STATUS_ECC_1_7_CORRECTED	(1 << 4)
+#define PN26G0XA_STATUS_ECC_ERRORED		(2 << 4)
+#define PN26G0XA_STATUS_ECC_8_CORRECTED		(3 << 4)
+
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+
+static int pn26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 64;
+	region->length = 64;
+
+	return 0;
+}
+
+static int pn26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 1;	/* Reserved byte for BBM */
+	region->length = 63;
+
+	return 0;
+}
+
+static int pn26g0xa_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
+{
+	switch (status & PN26G0XA_STATUS_ECC_BITMASK) {
+	case PN26G0XA_STATUS_ECC_NONE_DETECTED:
+		return 0;
+
+	case PN26G0XA_STATUS_ECC_1_7_CORRECTED:
+		return 7;	/* Return upper limit by convention */
+
+	case PN26G0XA_STATUS_ECC_8_CORRECTED:
+		return 8;
+
+	case PN26G0XA_STATUS_ECC_ERRORED:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct mtd_ooblayout_ops pn26g0xa_ooblayout = {
+	.ecc = pn26g0xa_ooblayout_ecc,
+	.free = pn26g0xa_ooblayout_free,
+};
+
+
+static const struct spinand_info paragon_spinand_table[] = {
+	SPINAND_INFO("PN26G01A", 0xe1,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 21, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&pn26g0xa_ooblayout,
+				     pn26g0xa_ecc_get_status)),
+	SPINAND_INFO("PN26G02A", 0xe2,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 21, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&pn26g0xa_ooblayout,
+				     pn26g0xa_ecc_get_status)),
+};
+
+static int paragon_spinand_detect(struct spinand_device *spinand)
+{
+	u8 *id = spinand->id.data;
+	int ret;
+
+	/* Read ID returns [0][MID][DID] */
+
+	if (id[1] != SPINAND_MFR_PARAGON)
+		return 0;
+
+	ret = spinand_match_and_init(spinand, paragon_spinand_table,
+				     ARRAY_SIZE(paragon_spinand_table),
+				     id[2]);
+	if (ret)
+		return ret;
+
+	return 1;
+}
+
+static const struct spinand_manufacturer_ops paragon_spinand_manuf_ops = {
+	.detect = paragon_spinand_detect,
+};
+
+const struct spinand_manufacturer paragon_spinand_manufacturer = {
+	.id = SPINAND_MFR_PARAGON,
+	.name = "Paragon",
+	.ops = &paragon_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fbc0423bb4ae..4ea558bd3c46 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -227,6 +227,7 @@ struct spinand_manufacturer {
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
+extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 
-- 
2.20.1

