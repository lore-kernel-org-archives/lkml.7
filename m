Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E3D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tKjX/55b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCLIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:46:45 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:37468 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfCLIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:46:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2C8j6Zf004092;
        Tue, 12 Mar 2019 17:45:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2C8j6Zf004092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552380320;
        bh=kVssoXDEMc1C7cAWFVVD37uUpfQMM9/zmejXeUkxrzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKjX/55bbm9IFBkccf6GU76HlIk0A1uAcGARQE941K69nMS19G/6ht87gbyk4y/SM
         46rqK/rCHAmKG1VEc6c0Nga2XkUUrqQhuW1iPSMGsPKaqR8PUNEMcGFsWonyFvOEw7
         Ar/VlZ4nIDpmer/ekVEyX+6YT3OOjk0BoVG4jblOZk7FVamdTbTz33TEsY8FjnsiC3
         XCXaBIqLR25QUfOvtFFW7GEvlLnr+cCM7Ni1CCfPqTIvCjIMJdNj1UPeE/lH/7nX2t
         4ECsgJV85oUWownvRw3Z6Grt4dDdDXYZMy+GcD9Rbgr4jzuHklo9Xdc7NUI8C8k++Q
         MTkG1dFqhvsQQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v3 5/9] mtd: rawnand: denali: use bool type instead of int where appropriate
Date:   Tue, 12 Mar 2019 17:44:46 +0900
Message-Id: <1552380290-19951-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'bool' type for the following boolean parameters.

 - write (write or read?)
 - raw (raw access or not?)
 - dma_avail (DMA engine available or not?)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - Use bool for dma_avail as well

 drivers/mtd/nand/raw/denali.c | 27 ++++++++++++++-------------
 drivers/mtd/nand/raw/denali.h |  4 ++--
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 2c7dc9b..05fbe8f 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -357,7 +357,7 @@ static int denali_sw_ecc_fixup(struct nand_chip *chip,
 }
 
 static void denali_setup_dma64(struct denali_nand_info *denali,
-			       dma_addr_t dma_addr, int page, int write)
+			       dma_addr_t dma_addr, int page, bool write)
 {
 	uint32_t mode;
 	const int page_count = 1;
@@ -371,7 +371,8 @@ static void denali_setup_dma64(struct denali_nand_info *denali,
 	 *    burst len = 64 bytes, the number of pages
 	 */
 	denali->host_write(denali, mode,
-			   0x01002000 | (64 << 16) | (write << 8) | page_count);
+			   0x01002000 | (64 << 16) |
+			   (write ? BIT(8) : 0) | page_count);
 
 	/* 2. set memory low address */
 	denali->host_write(denali, mode, lower_32_bits(dma_addr));
@@ -381,7 +382,7 @@ static void denali_setup_dma64(struct denali_nand_info *denali,
 }
 
 static void denali_setup_dma32(struct denali_nand_info *denali,
-			       dma_addr_t dma_addr, int page, int write)
+			       dma_addr_t dma_addr, int page, bool write)
 {
 	uint32_t mode;
 	const int page_count = 1;
@@ -392,7 +393,7 @@ static void denali_setup_dma32(struct denali_nand_info *denali,
 
 	/* 1. setup transfer type and # of pages */
 	denali->host_write(denali, mode | page,
-			   0x2000 | (write << 8) | page_count);
+			   0x2000 | (write ? BIT(8) : 0) | page_count);
 
 	/* 2. set memory high address bits 23:8 */
 	denali->host_write(denali, mode | ((dma_addr >> 16) << 8), 0x2200);
@@ -452,7 +453,7 @@ static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
 }
 
 static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int write)
+			   size_t size, int page, bool write)
 {
 	if (write)
 		return denali_pio_write(denali, buf, size, page);
@@ -461,7 +462,7 @@ static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
 }
 
 static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int write)
+			   size_t size, int page, bool write)
 {
 	dma_addr_t dma_addr;
 	uint32_t irq_mask, irq_status, ecc_err_mask;
@@ -518,7 +519,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 }
 
 static int denali_data_xfer(struct nand_chip *chip, void *buf, size_t size,
-			    int page, int raw, int write)
+			    int page, bool raw, bool write)
 {
 	struct denali_nand_info *denali = to_denali(chip);
 
@@ -669,7 +670,7 @@ static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 	if (!buf)
 		return -EINVAL;
 
-	ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
+	ret = denali_data_xfer(chip, tmp_buf, size, page, true, false);
 	if (ret)
 		return ret;
 
@@ -725,7 +726,7 @@ static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 			return ret;
 	}
 
-	return denali_data_xfer(chip, tmp_buf, size, page, 1, 1);
+	return denali_data_xfer(chip, tmp_buf, size, page, true, true);
 }
 
 static int denali_change_read_column_op(void *buf, unsigned int offset,
@@ -777,7 +778,7 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	int stat = 0;
 	int ret;
 
-	ret = denali_data_xfer(chip, buf, mtd->writesize, page, 0, 0);
+	ret = denali_data_xfer(chip, buf, mtd->writesize, page, false, false);
 	if (ret && ret != -EBADMSG)
 		return ret;
 
@@ -807,7 +808,7 @@ static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	return denali_data_xfer(chip, (void *)buf, mtd->writesize, page,
-				0, 1);
+				false, true);
 }
 
 static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
@@ -1063,7 +1064,7 @@ static int denali_attach_chip(struct nand_chip *chip)
 	int ret;
 
 	if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
-		denali->dma_avail = 1;
+		denali->dma_avail = true;
 
 	if (denali->dma_avail) {
 		int dma_bit = denali->caps & DENALI_CAP_DMA_64BIT ? 64 : 32;
@@ -1072,7 +1073,7 @@ static int denali_attach_chip(struct nand_chip *chip)
 		if (ret) {
 			dev_info(denali->dev,
 				 "Failed to set DMA mask. Disabling DMA.\n");
-			denali->dma_avail = 0;
+			denali->dma_avail = false;
 		}
 	}
 
diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index c8c2620..8552b3f 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -304,7 +304,7 @@ struct denali_nand_info {
 	u32 irq_status;			/* interrupts that have happened */
 	int irq;
 	void *buf;			/* for syndrome layout conversion */
-	int dma_avail;			/* can support DMA? */
+	bool dma_avail;			/* can support DMA? */
 	int devs_per_cs;		/* devices connected in parallel */
 	int oob_skip_bytes;		/* number of bytes reserved for BBM */
 	int max_banks;
@@ -314,7 +314,7 @@ struct denali_nand_info {
 	u32 (*host_read)(struct denali_nand_info *denali, u32 addr);
 	void (*host_write)(struct denali_nand_info *denali, u32 addr, u32 data);
 	void (*setup_dma)(struct denali_nand_info *denali, dma_addr_t dma_addr,
-			  int page, int write);
+			  int page, bool write);
 };
 
 #define DENALI_CAP_HW_ECC_FIXUP			BIT(0)
-- 
2.7.4

