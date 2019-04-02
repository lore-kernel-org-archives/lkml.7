Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248C120857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="19HsWFwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfDBEEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:04:53 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18564 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfDBEEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:04:36 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3243HaV021871;
        Tue, 2 Apr 2019 13:03:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3243HaV021871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554177800;
        bh=FKq8aD1FycYPHgKxmTHL4cPLkqTu2cgg9vWKkGvpBLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19HsWFwCwTUn10Bfy/xYatxR33khvmw+OGN4TIxfZZ3+L5D/ejrqpaFkCublu+jA6
         5b8PJe6Q4BzNEwoE2Y/+YNYH5wWYOhmgbnK6Vx7kafmKOJlOIcsobn7u+sJqM5fUh6
         AkSMlR45Y5FcnV/BGsRV1rsg4ZelRPIw4Hz8mHeEoIBAsGvfHfN17ajk9D2UfDILQT
         FHUZOBAZSfUfb5MZuU1OIXnusx3CmpFtbp5fyPBAYsf3au3qdRL0kuuQx/jIaEUtw7
         3lkdcR4ki2ji7JxFmGyGfMXjRFkgPzBO10JljuONWuDry6BDek/Im1Uwf6CsyxBJU/
         /NLq/GitHwfLg==
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
Subject: [PATCH v5 2/9] mtd: rawnand: denali: refactor raw page accessors
Date:   Tue,  2 Apr 2019 13:03:02 +0900
Message-Id: <1554177789-15414-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
References: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali IP adopts the syndrome page layout (payload and ECC are
interleaved). The *_page_raw() and *_oob() callbacks are complicated
because they must hide the underlying layout used by the hardware,
and always return contiguous in-band and out-of-band data.

The Denali IP cannot reuse nand_{read,write}_page_raw_syndrome()
in nand_base.c because its hardware ECC engine skips some of first
bytes in OOB. That is why this driver implements specially-crafted
*_page_raw() and *_oob() hooks.

Currently, similar code is duplicated to reorganize the data layout.
For example, denali_read_page_raw() and denali_write_page_raw() look
almost the same. The complexity is partly due to the DMA transfer
used for better performance of *_page_raw() accessors.

On second thought, we do not need to care about their performance
because MTD_OPS_RAW is rarely used.

Let's focus on code cleanups rather than the performance. This commit
removes the internal buffer for DMA, and factors out as much code as
possible.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4:
  - Do not pass function pointers
  - The code simplicity wins over the performance
    since the raw accessors are rarely used.

Changes in v3:
  - Add comments to denali_raw_payload_op() and denali_oob_payload_op()

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 446 +++++++++++++++++-------------------------
 drivers/mtd/nand/raw/denali.h |   1 -
 2 files changed, 182 insertions(+), 265 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 83156f4..6a3520f 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -287,6 +287,182 @@ static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 	denali->host_write(denali, DENALI_BANK(denali) | type, dat);
 }
 
+static int denali_change_column(struct nand_chip *chip, unsigned int offset,
+				void *buf, unsigned int len, bool write)
+{
+	if (write)
+		return nand_change_write_column_op(chip, offset, buf, len,
+						   false);
+	else
+		return nand_change_read_column_op(chip, offset, buf, len,
+						  false);
+}
+
+static int denali_payload_xfer(struct nand_chip *chip, void *buf, bool write)
+{
+	struct denali_nand_info *denali = to_denali(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int writesize = mtd->writesize;
+	int oob_skip = denali->oob_skip_bytes;
+	int ret, i, pos, len;
+
+	for (i = 0; i < ecc->steps; i++) {
+		pos = i * (ecc->size + ecc->bytes);
+		len = ecc->size;
+
+		if (pos >= writesize) {
+			pos += oob_skip;
+		} else if (pos + len > writesize) {
+			/* This chunk overwraps the BBM area. Must be split */
+			ret = denali_change_column(chip, pos, buf,
+						   writesize - pos, write);
+			if (ret)
+				return ret;
+
+			buf += writesize - pos;
+			len -= writesize - pos;
+			pos = writesize + oob_skip;
+		}
+
+		ret = denali_change_column(chip, pos, buf, len, write);
+		if (ret)
+			return ret;
+
+		buf += len;
+	}
+
+	return 0;
+}
+
+static int denali_oob_xfer(struct nand_chip *chip, void *buf, bool write)
+{
+	struct denali_nand_info *denali = to_denali(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int writesize = mtd->writesize;
+	int oobsize = mtd->oobsize;
+	int oob_skip = denali->oob_skip_bytes;
+	int ret, i, pos, len;
+
+	/* BBM at the beginning of the OOB area */
+	ret = denali_change_column(chip, writesize, buf, oob_skip, write);
+	if (ret)
+		return ret;
+
+	buf += oob_skip;
+
+	for (i = 0; i < ecc->steps; i++) {
+		pos = ecc->size + i * (ecc->size + ecc->bytes);
+
+		if (i == ecc->steps - 1)
+			/* The last chunk includes OOB free */
+			len = writesize + oobsize - pos - oob_skip;
+		else
+			len = ecc->bytes;
+
+		if (pos >= writesize) {
+			pos += oob_skip;
+		} else if (pos + len > writesize) {
+			/* This chunk overwraps the BBM area. Must be split */
+			ret = denali_change_column(chip, pos, buf,
+						   writesize - pos, write);
+			if (ret)
+				return ret;
+
+			buf += writesize - pos;
+			len -= writesize - pos;
+			pos = writesize + oob_skip;
+		}
+
+		ret = denali_change_column(chip, pos, buf, len, write);
+		if (ret)
+			return ret;
+
+		buf += len;
+	}
+
+	return 0;
+}
+
+static int denali_read_raw(struct nand_chip *chip, void *buf, void *oob_buf,
+			   int page)
+{
+	int ret;
+
+	if (!buf && !oob_buf)
+		return -EINVAL;
+
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	if (buf) {
+		ret = denali_payload_xfer(chip, buf, false);
+		if (ret)
+			return ret;
+	}
+
+	if (oob_buf) {
+		ret = denali_oob_xfer(chip, oob_buf, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int denali_write_raw(struct nand_chip *chip, const void *buf,
+			    const void *oob_buf, int page)
+{
+	int ret;
+
+	if (!buf && !oob_buf)
+		return -EINVAL;
+
+	ret = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	if (buf) {
+		ret = denali_payload_xfer(chip, (void *)buf, true);
+		if (ret)
+			return ret;
+	}
+
+	if (oob_buf) {
+		ret = denali_oob_xfer(chip, (void *)oob_buf, true);
+		if (ret)
+			return ret;
+	}
+
+	return nand_prog_page_end_op(chip);
+}
+
+static int denali_read_page_raw(struct nand_chip *chip, u8 *buf,
+				int oob_required, int page)
+{
+	return denali_read_raw(chip, buf, oob_required ? chip->oob_poi : NULL,
+			       page);
+}
+
+static int denali_write_page_raw(struct nand_chip *chip, const u8 *buf,
+				 int oob_required, int page)
+{
+	return denali_write_raw(chip, buf, oob_required ? chip->oob_poi : NULL,
+				page);
+}
+
+static int denali_read_oob(struct nand_chip *chip, int page)
+{
+	return denali_read_raw(chip, NULL, chip->oob_poi, page);
+}
+
+static int denali_write_oob(struct nand_chip *chip, int page)
+{
+	return denali_write_raw(chip, NULL, chip->oob_poi, page);
+}
+
 static int denali_check_erased_page(struct nand_chip *chip, u8 *buf,
 				    unsigned long uncor_ecc_flags,
 				    unsigned int max_bitflips)
@@ -593,178 +769,17 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 	return ret;
 }
 
-static int denali_data_xfer(struct nand_chip *chip, void *buf, size_t size,
-			    int page, int raw, int write)
+static int denali_page_xfer(struct nand_chip *chip, void *buf, size_t size,
+			    int page, int write)
 {
 	struct denali_nand_info *denali = to_denali(chip);
 
-	iowrite32(raw ? 0 : ECC_ENABLE__FLAG, denali->reg + ECC_ENABLE);
-	iowrite32(raw ? TRANSFER_SPARE_REG__FLAG : 0,
-		  denali->reg + TRANSFER_SPARE_REG);
-
 	if (denali->dma_avail)
 		return denali_dma_xfer(denali, buf, size, page, write);
 	else
 		return denali_pio_xfer(denali, buf, size, page, write);
 }
 
-static void denali_oob_xfer(struct mtd_info *mtd, struct nand_chip *chip,
-			    int page, int write)
-{
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-	int writesize = mtd->writesize;
-	int oobsize = mtd->oobsize;
-	uint8_t *bufpoi = chip->oob_poi;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
-	int oob_skip = denali->oob_skip_bytes;
-	size_t size = writesize + oobsize;
-	int i, pos, len;
-
-	/* BBM at the beginning of the OOB area */
-	if (write)
-		nand_prog_page_begin_op(chip, page, writesize, bufpoi,
-					oob_skip);
-	else
-		nand_read_page_op(chip, page, writesize, bufpoi, oob_skip);
-	bufpoi += oob_skip;
-
-	/* OOB ECC */
-	for (i = 0; i < ecc_steps; i++) {
-		pos = ecc_size + i * (ecc_size + ecc_bytes);
-		len = ecc_bytes;
-
-		if (pos >= writesize)
-			pos += oob_skip;
-		else if (pos + len > writesize)
-			len = writesize - pos;
-
-		if (write)
-			nand_change_write_column_op(chip, pos, bufpoi, len,
-						    false);
-		else
-			nand_change_read_column_op(chip, pos, bufpoi, len,
-						   false);
-		bufpoi += len;
-		if (len < ecc_bytes) {
-			len = ecc_bytes - len;
-			if (write)
-				nand_change_write_column_op(chip, writesize +
-							    oob_skip, bufpoi,
-							    len, false);
-			else
-				nand_change_read_column_op(chip, writesize +
-							   oob_skip, bufpoi,
-							   len, false);
-			bufpoi += len;
-		}
-	}
-
-	/* OOB free */
-	len = oobsize - (bufpoi - chip->oob_poi);
-	if (write)
-		nand_change_write_column_op(chip, size - len, bufpoi, len,
-					    false);
-	else
-		nand_change_read_column_op(chip, size - len, bufpoi, len,
-					   false);
-}
-
-static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
-				int oob_required, int page)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-	int writesize = mtd->writesize;
-	int oobsize = mtd->oobsize;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
-	void *tmp_buf = denali->buf;
-	int oob_skip = denali->oob_skip_bytes;
-	size_t size = writesize + oobsize;
-	int ret, i, pos, len;
-
-	ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
-	if (ret)
-		return ret;
-
-	/* Arrange the buffer for syndrome payload/ecc layout */
-	if (buf) {
-		for (i = 0; i < ecc_steps; i++) {
-			pos = i * (ecc_size + ecc_bytes);
-			len = ecc_size;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(buf, tmp_buf + pos, len);
-			buf += len;
-			if (len < ecc_size) {
-				len = ecc_size - len;
-				memcpy(buf, tmp_buf + writesize + oob_skip,
-				       len);
-				buf += len;
-			}
-		}
-	}
-
-	if (oob_required) {
-		uint8_t *oob = chip->oob_poi;
-
-		/* BBM at the beginning of the OOB area */
-		memcpy(oob, tmp_buf + writesize, oob_skip);
-		oob += oob_skip;
-
-		/* OOB ECC */
-		for (i = 0; i < ecc_steps; i++) {
-			pos = ecc_size + i * (ecc_size + ecc_bytes);
-			len = ecc_bytes;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(oob, tmp_buf + pos, len);
-			oob += len;
-			if (len < ecc_bytes) {
-				len = ecc_bytes - len;
-				memcpy(oob, tmp_buf + writesize + oob_skip,
-				       len);
-				oob += len;
-			}
-		}
-
-		/* OOB free */
-		len = oobsize - (oob - chip->oob_poi);
-		memcpy(oob, tmp_buf + size - len, len);
-	}
-
-	return 0;
-}
-
-static int denali_read_oob(struct nand_chip *chip, int page)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
-	denali_oob_xfer(mtd, chip, page, 0);
-
-	return 0;
-}
-
-static int denali_write_oob(struct nand_chip *chip, int page)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
-	denali_oob_xfer(mtd, chip, page, 1);
-
-	return nand_prog_page_end_op(chip);
-}
-
 static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 			    int oob_required, int page)
 {
@@ -774,7 +789,7 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	int stat = 0;
 	int ret;
 
-	ret = denali_data_xfer(chip, buf, mtd->writesize, page, 0, 0);
+	ret = denali_page_xfer(chip, buf, mtd->writesize, page, 0);
 	if (ret && ret != -EBADMSG)
 		return ret;
 
@@ -798,92 +813,12 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	return stat;
 }
 
-static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
-				 int oob_required, int page)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-	int writesize = mtd->writesize;
-	int oobsize = mtd->oobsize;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
-	void *tmp_buf = denali->buf;
-	int oob_skip = denali->oob_skip_bytes;
-	size_t size = writesize + oobsize;
-	int i, pos, len;
-
-	/*
-	 * Fill the buffer with 0xff first except the full page transfer.
-	 * This simplifies the logic.
-	 */
-	if (!buf || !oob_required)
-		memset(tmp_buf, 0xff, size);
-
-	/* Arrange the buffer for syndrome payload/ecc layout */
-	if (buf) {
-		for (i = 0; i < ecc_steps; i++) {
-			pos = i * (ecc_size + ecc_bytes);
-			len = ecc_size;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(tmp_buf + pos, buf, len);
-			buf += len;
-			if (len < ecc_size) {
-				len = ecc_size - len;
-				memcpy(tmp_buf + writesize + oob_skip, buf,
-				       len);
-				buf += len;
-			}
-		}
-	}
-
-	if (oob_required) {
-		const uint8_t *oob = chip->oob_poi;
-
-		/* BBM at the beginning of the OOB area */
-		memcpy(tmp_buf + writesize, oob, oob_skip);
-		oob += oob_skip;
-
-		/* OOB ECC */
-		for (i = 0; i < ecc_steps; i++) {
-			pos = ecc_size + i * (ecc_size + ecc_bytes);
-			len = ecc_bytes;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(tmp_buf + pos, oob, len);
-			oob += len;
-			if (len < ecc_bytes) {
-				len = ecc_bytes - len;
-				memcpy(tmp_buf + writesize + oob_skip, oob,
-				       len);
-				oob += len;
-			}
-		}
-
-		/* OOB free */
-		len = oobsize - (oob - chip->oob_poi);
-		memcpy(tmp_buf + size - len, oob, len);
-	}
-
-	return denali_data_xfer(chip, tmp_buf, size, page, 1, 1);
-}
-
 static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 			     int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	return denali_data_xfer(chip, (void *)buf, mtd->writesize, page,
-				0, 1);
+	return denali_page_xfer(chip, (void *)buf, mtd->writesize, page, 1);
 }
 
 static void denali_select_chip(struct nand_chip *chip, int cs)
@@ -1051,9 +986,10 @@ static void denali_hw_init(struct denali_nand_info *denali)
 	}
 
 	denali_detect_max_banks(denali);
+	iowrite32(0, denali->reg + TRANSFER_SPARE_REG);
 	iowrite32(0x0F, denali->reg + RB_PIN_ENABLED);
 	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);
-
+	iowrite32(ECC_ENABLE__FLAG, denali->reg + ECC_ENABLE);
 	iowrite32(0xffff, denali->reg + SPARE_AREA_MARKER);
 }
 
@@ -1233,29 +1169,11 @@ static int denali_attach_chip(struct nand_chip *chip)
 	if (ret)
 		return ret;
 
-	/*
-	 * This buffer is DMA-mapped by denali_{read,write}_page_raw.  Do not
-	 * use devm_kmalloc() because the memory allocated by devm_ does not
-	 * guarantee DMA-safe alignment.
-	 */
-	denali->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
-	if (!denali->buf)
-		return -ENOMEM;
-
 	return 0;
 }
 
-static void denali_detach_chip(struct nand_chip *chip)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-
-	kfree(denali->buf);
-}
-
 static const struct nand_controller_ops denali_controller_ops = {
 	.attach_chip = denali_attach_chip,
-	.detach_chip = denali_detach_chip,
 	.setup_data_interface = denali_setup_data_interface,
 };
 
diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index c8c2620..4447184 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -303,7 +303,6 @@ struct denali_nand_info {
 	u32 irq_mask;			/* interrupts we are waiting for */
 	u32 irq_status;			/* interrupts that have happened */
 	int irq;
-	void *buf;			/* for syndrome layout conversion */
 	int dma_avail;			/* can support DMA? */
 	int devs_per_cs;		/* devices connected in parallel */
 	int oob_skip_bytes;		/* number of bytes reserved for BBM */
-- 
2.7.4

