Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A68320882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zKFkzbQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfDBEEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:04:35 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18474 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfDBEEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:04:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3243HaW021871;
        Tue, 2 Apr 2019 13:03:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3243HaW021871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554177801;
        bh=hwp7B4epm8xIJuNf4RNloi2tLVuAeJkYxTUaLmMTjAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKFkzbQf973zNpAcNfC6xUrmOYIx6eX8Lyp3shiPnIc6TRgl6dFbiBeLjbtBQJp63
         oDMP3VVXLDLUeI4GrBIVMjE9cFqGXuseluPq4Ocgd2cuSEQCK10lh8I2zFdpsnFXcz
         VCox/AXG1ZmcSjHDrooB37l5QkaFvouS6K/YAwpsG2T3/+HWr2zozZgQWkWMBgGBkG
         rHeqRgtuWsOzBlUdabAws4HyPHZWvqnusnukThIlLDMWwpgodZzp2LSqcIIhGtRUgj
         kY0k/HTTxgT75vpZ6T23kJ4MepkDRsq72ycDfP2DpljX6nRFyLhd1LHyjiMbZZ0T4c
         PrG12Qp+stCiA==
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
Subject: [PATCH v5 3/9] mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
Date:   Tue,  2 Apr 2019 13:03:03 +0900
Message-Id: <1554177789-15414-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
References: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since (u32 *) can accept an opaque pointer, the explicit casting
from (void *) to (u32 *) is redundant. Change the function argument type
to remove the casts.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 6a3520f..1422015 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -654,11 +654,10 @@ static void denali_setup_dma32(struct denali_nand_info *denali,
 	denali->host_write(denali, mode | 0x14000, 0x2400);
 }
 
-static int denali_pio_read(struct denali_nand_info *denali, void *buf,
+static int denali_pio_read(struct denali_nand_info *denali, u32 *buf,
 			   size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
-	uint32_t *buf32 = (uint32_t *)buf;
 	uint32_t irq_status, ecc_err_mask;
 	int i;
 
@@ -670,7 +669,7 @@ static int denali_pio_read(struct denali_nand_info *denali, void *buf,
 	denali_reset_irq(denali);
 
 	for (i = 0; i < size / 4; i++)
-		*buf32++ = denali->host_read(denali, addr);
+		buf[i] = denali->host_read(denali, addr);
 
 	irq_status = denali_wait_for_irq(denali, INTR__PAGE_XFER_INC);
 	if (!(irq_status & INTR__PAGE_XFER_INC))
@@ -682,18 +681,17 @@ static int denali_pio_read(struct denali_nand_info *denali, void *buf,
 	return irq_status & ecc_err_mask ? -EBADMSG : 0;
 }
 
-static int denali_pio_write(struct denali_nand_info *denali,
-			    const void *buf, size_t size, int page)
+static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
+			    size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
-	const uint32_t *buf32 = (uint32_t *)buf;
 	uint32_t irq_status;
 	int i;
 
 	denali_reset_irq(denali);
 
 	for (i = 0; i < size / 4; i++)
-		denali->host_write(denali, addr, *buf32++);
+		denali->host_write(denali, addr, buf[i]);
 
 	irq_status = denali_wait_for_irq(denali,
 				INTR__PROGRAM_COMP | INTR__PROGRAM_FAIL);
-- 
2.7.4

