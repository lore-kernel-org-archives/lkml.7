Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C69C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A144B214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FnZO1lQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfDBEEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:04:38 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18467 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBEEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:04:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3243HaX021871;
        Tue, 2 Apr 2019 13:03:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3243HaX021871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554177802;
        bh=xYb/+hiH5D1jSa4/gtzB1odnYPr+jiiacmqKZxqbzpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnZO1lQ4o1kj5Omxemzu4RqSl8vYF/jzFG3jaPvY3ZUTpjtvMB8AhcQHs/bctSpVp
         YRL4pwgFE3ipQhi3PPc4olrgXG+4XsLgP2k6QNdS8lbMVXcXAqXPUOgQgMni9rYraB
         V2DWHCI2EivJB/ok+WnwfGx/eWsoFpFIEEYSEByxMrnLfSjuYbVHNhVM7xyukzl8TG
         CjllsfsHjfX2G3rDuKnSdAIO+Vv83Q/uPUAbeea86puyaAISFKZC1zvMYm+1rwWT2M
         P3yZnJxVM7zTpUldu6f30wnErFoWp2DmdcPigdmKeShtpjtf8uLu4lTKVJ4YdMxls0
         baOK2awbixmRg==
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
Subject: [PATCH v5 4/9] mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
Date:   Tue,  2 Apr 2019 13:03:04 +0900
Message-Id: <1554177789-15414-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
References: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ->exec_op(), and remove the deprecated hooks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4:
  - add denali_exec_in() and denali_exec_out()
  - avoid ternary operator to select function

Changes in v3:
  - Fix byte-swap in denali_exec_in16()

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 251 ++++++++++++++++++++++++------------------
 1 file changed, 143 insertions(+), 108 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 1422015..b9bc406 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -206,85 +206,11 @@ static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
 	return denali->irq_status;
 }
 
-static void denali_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
+static void denali_select_target(struct nand_chip *chip, int cs)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
-	int i;
-
-	for (i = 0; i < len; i++)
-		buf[i] = denali->host_read(denali, addr);
-}
-
-static void denali_write_buf(struct nand_chip *chip, const uint8_t *buf,
-			     int len)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
-	int i;
-
-	for (i = 0; i < len; i++)
-		denali->host_write(denali, addr, buf[i]);
-}
-
-static void denali_read_buf16(struct nand_chip *chip, uint8_t *buf, int len)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
-	uint16_t *buf16 = (uint16_t *)buf;
-	int i;
-
-	for (i = 0; i < len / 2; i++)
-		buf16[i] = denali->host_read(denali, addr);
-}
-
-static void denali_write_buf16(struct nand_chip *chip, const uint8_t *buf,
-			       int len)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-	u32 addr = DENALI_MAP11_DATA | DENALI_BANK(denali);
-	const uint16_t *buf16 = (const uint16_t *)buf;
-	int i;
-
-	for (i = 0; i < len / 2; i++)
-		denali->host_write(denali, addr, buf16[i]);
-}
-
-static uint8_t denali_read_byte(struct nand_chip *chip)
-{
-	uint8_t byte;
-
-	denali_read_buf(chip, &byte, 1);
-
-	return byte;
-}
-
-static void denali_write_byte(struct nand_chip *chip, uint8_t byte)
-{
-	denali_write_buf(chip, &byte, 1);
-}
-
-static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-	uint32_t type;
-
-	if (ctrl & NAND_CLE)
-		type = DENALI_MAP11_CMD;
-	else if (ctrl & NAND_ALE)
-		type = DENALI_MAP11_ADDR;
-	else
-		return;
-
-	/*
-	 * Some commands are followed by chip->legacy.waitfunc.
-	 * irq_status must be cleared here to catch the R/B# interrupt later.
-	 */
-	if (ctrl & NAND_CTRL_CHANGE)
-		denali_reset_irq(denali);
+	struct denali_nand_info *denali = to_denali(chip);
 
-	denali->host_write(denali, DENALI_BANK(denali) | type, dat);
+	denali->active_bank = cs;
 }
 
 static int denali_change_column(struct nand_chip *chip, unsigned int offset,
@@ -772,6 +698,8 @@ static int denali_page_xfer(struct nand_chip *chip, void *buf, size_t size,
 {
 	struct denali_nand_info *denali = to_denali(chip);
 
+	denali_select_target(chip, chip->cur_cs);
+
 	if (denali->dma_avail)
 		return denali_dma_xfer(denali, buf, size, page, write);
 	else
@@ -819,24 +747,6 @@ static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 	return denali_page_xfer(chip, (void *)buf, mtd->writesize, page, 1);
 }
 
-static void denali_select_chip(struct nand_chip *chip, int cs)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-
-	denali->active_bank = cs;
-}
-
-static int denali_waitfunc(struct nand_chip *chip)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-	uint32_t irq_status;
-
-	/* R/B# pin transitioned from low to high? */
-	irq_status = denali_wait_for_irq(denali, INTR__INT_ACT);
-
-	return irq_status & INTR__INT_ACT ? 0 : NAND_STATUS_FAIL;
-}
-
 static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 				       const struct nand_data_interface *conf)
 {
@@ -1149,13 +1059,6 @@ static int denali_attach_chip(struct nand_chip *chip)
 
 	mtd_set_ooblayout(mtd, &denali_ooblayout_ops);
 
-	if (chip->options & NAND_BUSWIDTH_16) {
-		chip->legacy.read_buf = denali_read_buf16;
-		chip->legacy.write_buf = denali_write_buf16;
-	} else {
-		chip->legacy.read_buf = denali_read_buf;
-		chip->legacy.write_buf = denali_write_buf;
-	}
 	chip->ecc.read_page = denali_read_page;
 	chip->ecc.read_page_raw = denali_read_page_raw;
 	chip->ecc.write_page = denali_write_page;
@@ -1170,8 +1073,146 @@ static int denali_attach_chip(struct nand_chip *chip)
 	return 0;
 }
 
+static void denali_exec_in8(struct denali_nand_info *denali, u32 type,
+			    u8 *buf, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = denali->host_read(denali, type | DENALI_BANK(denali));
+}
+
+static void denali_exec_in16(struct denali_nand_info *denali, u32 type,
+			     u8 *buf, unsigned int len)
+{
+	u32 data;
+	int i;
+
+	for (i = 0; i < len; i += 2) {
+		data = denali->host_read(denali, type | DENALI_BANK(denali));
+		/* bit 31:24 and 15:8 are used for DDR */
+		buf[i] = data;
+		buf[i + 1] = data >> 16;
+	}
+}
+
+static void denali_exec_in(struct denali_nand_info *denali, u32 type,
+			   u8 *buf, unsigned int len, bool width16)
+{
+	if (width16)
+		denali_exec_in16(denali, type, buf, len);
+	else
+		denali_exec_in8(denali, type, buf, len);
+}
+
+static void denali_exec_out8(struct denali_nand_info *denali, u32 type,
+			     const u8 *buf, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		denali->host_write(denali, type | DENALI_BANK(denali), buf[i]);
+}
+
+static void denali_exec_out16(struct denali_nand_info *denali, u32 type,
+			      const u8 *buf, unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i += 2)
+		denali->host_write(denali, type | DENALI_BANK(denali),
+				   buf[i + 1] << 16 | buf[i]);
+}
+
+static void denali_exec_out(struct denali_nand_info *denali, u32 type,
+			    const u8 *buf, unsigned int len, bool width16)
+{
+	if (width16)
+		denali_exec_out16(denali, type, buf, len);
+	else
+		denali_exec_out8(denali, type, buf, len);
+}
+
+static int denali_exec_waitrdy(struct denali_nand_info *denali)
+{
+	u32 irq_stat;
+
+	/* R/B# pin transitioned from low to high? */
+	irq_stat = denali_wait_for_irq(denali, INTR__INT_ACT);
+
+	/* Just in case nand_operation has multiple NAND_OP_WAITRDY_INSTR. */
+	denali_reset_irq(denali);
+
+	return irq_stat & INTR__INT_ACT ? 0 : -EIO;
+}
+
+static int denali_exec_instr(struct nand_chip *chip,
+			     const struct nand_op_instr *instr)
+{
+	struct denali_nand_info *denali = to_denali(chip);
+
+	switch (instr->type) {
+	case NAND_OP_CMD_INSTR:
+		denali_exec_out8(denali, DENALI_MAP11_CMD,
+				 &instr->ctx.cmd.opcode, 1);
+		return 0;
+	case NAND_OP_ADDR_INSTR:
+		denali_exec_out8(denali, DENALI_MAP11_ADDR,
+				 instr->ctx.addr.addrs,
+				 instr->ctx.addr.naddrs);
+		return 0;
+	case NAND_OP_DATA_IN_INSTR:
+		denali_exec_in(denali, DENALI_MAP11_DATA,
+			       instr->ctx.data.buf.in,
+			       instr->ctx.data.len,
+			       !instr->ctx.data.force_8bit &&
+			       chip->options & NAND_BUSWIDTH_16);
+		return 0;
+	case NAND_OP_DATA_OUT_INSTR:
+		denali_exec_out(denali, DENALI_MAP11_DATA,
+				instr->ctx.data.buf.out,
+				instr->ctx.data.len,
+				!instr->ctx.data.force_8bit &&
+				chip->options & NAND_BUSWIDTH_16);
+		return 0;
+	case NAND_OP_WAITRDY_INSTR:
+		return denali_exec_waitrdy(denali);
+	default:
+		WARN_ONCE(1, "unsupported NAND instruction type: %d\n",
+			  instr->type);
+
+		return -EINVAL;
+	}
+}
+
+static int denali_exec_op(struct nand_chip *chip,
+			  const struct nand_operation *op, bool check_only)
+{
+	int i, ret;
+
+	if (check_only)
+		return 0;
+
+	denali_select_target(chip, op->cs);
+
+	/*
+	 * Some commands contain NAND_OP_WAITRDY_INSTR.
+	 * irq must be cleared here to catch the R/B# interrupt there.
+	 */
+	denali_reset_irq(to_denali(chip));
+
+	for (i = 0; i < op->ninstrs; i++) {
+		ret = denali_exec_instr(chip, &op->instrs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_controller_ops denali_controller_ops = {
 	.attach_chip = denali_attach_chip,
+	.exec_op = denali_exec_op,
 	.setup_data_interface = denali_setup_data_interface,
 };
 
@@ -1206,12 +1247,6 @@ int denali_init(struct denali_nand_info *denali)
 	if (!mtd->name)
 		mtd->name = "denali-nand";
 
-	chip->legacy.select_chip = denali_select_chip;
-	chip->legacy.read_byte = denali_read_byte;
-	chip->legacy.write_byte = denali_write_byte;
-	chip->legacy.cmd_ctrl = denali_cmd_ctrl;
-	chip->legacy.waitfunc = denali_waitfunc;
-
 	if (features & FEATURES__INDEX_ADDR) {
 		denali->host_read = denali_indexed_read;
 		denali->host_write = denali_indexed_write;
-- 
2.7.4

