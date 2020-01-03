Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A6C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448CF21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="p1wFuJQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgACWMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:12:44 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:56713 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgACWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:12:44 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 71CAC2327F;
        Fri,  3 Jan 2020 23:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578089560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pxc7LxMRggzlHkhDG41adMieU1U8xqZrMb5OXW+ieCw=;
        b=p1wFuJQfrsj4WzxrA6up1UAW/emqypjJRdD578u3iWq2pAIdaIWlh9MiK478i0soquclVY
        w+F5FOVFfC/5dVqE3Tutxn8bcaVdVbs6Sa+sSmsKpCs2Ja+2WJlxWy56UKFujFevxNBP2+
        MdOy1M/GZbwVtc8pVvIucqfufQiw89g=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Date:   Fri,  3 Jan 2020 23:12:29 +0100
Message-Id: <20200103221229.7287-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 71CAC2327F
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.843];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, linux unlocks the whole flash because there are legacy
devices which has the write protections bits set by default at startup.
If you actually want to use the flash protection bits, eg. because there
is a read-only part for a bootloader, this automatic unlocking is
harmful. If there is no hardware write protection in place (usually
called WP#), a startup of the kernel just discards this protection.

I've gone through the datasheets of all the flashes (except the Intel
ones where I could not find any datasheet nor reference) which supports
the unlocking feature and looked how the sector protection was
implemented. The currently supported flashes can be divided into the
following two categories:
 (1) block protection bits are non-volatile. Thus they keep their values
     at reset and power-cycle
 (2) flashes where these bits are volatile. After reset or power-cycle,
     the whole memory array is protected.
     (a) some devices needs a special "Global Unprotect" command, eg.
         the Atmel AT25DF041A.
     (b) some devices require to clear the BPn bits in the status
         register.

Due to the reasons above, we do not want to clear the bits for flashes
which belong to category (1). Fortunately for us, the flashes in (2a)
and (2b) are compatible with each other in a sense that the "Global
Unprotect" command will clear the block protection bits in all the (2b)
flashes.

This patch adds a new flag to indicate the case (2). Only if we have
such a flash we perform a "Global Unprotect". Hopefully, this will clean
up "unlock the entire flash for legacy devices" once and for all.

For reference here are the actually commits which introduced the legacy
behaviour (and extended the behaviour to other chip manufacturers):

commit f80e521c916cb ("mtd: m25p80: add support for the Intel/Numonyx {16,32,64}0S33B SPI flash chips")
commit ea60658a08f8f ("mtd: m25p80: disable SST software protection bits by default")
commit 7228982442365 ("[MTD] m25p80: fix bug - ATmel spi flash fails to be copied to")

Actually, this might also fix handling of the Atmel AT25DF flashes,
because the original commit 7228982442365 ("[MTD] m25p80: fix bug -
ATmel spi flash fails to be copied to") was writing a 0 to the status
register, which is a "Global Unprotect". This might not be the case in
the current code which only handles the block protection bits BP2, BP1
and BP0. Thus, it depends on the current contents of the status register
if this unlock actually corresponds to a "Global Unprotect" command. In
the worst case, the current code might leave the AT25DF flashes in a
write protected state.

The commit 191f5c2ed4b6f ("mtd: spi-nor: use 16-bit WRR command when QE
is set on spansion flashes") changed that behaviour by just clearing BP2
to BP0 instead of writing a 0 to the status register.

Fixes: 191f5c2ed4b6f ("mtd: spi-nor: use 16-bit WRR command when QE is set on spansion flashes")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spi-nor.c | 95 ++++++++++++++++++++++-------------
 include/linux/mtd/spi-nor.h   |  7 ++-
 2 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index addb6319fcbb..66dfb4396146 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -238,6 +238,11 @@ struct flash_info {
 					 * status register. Must be used with
 					 * SPI_NOR_HAS_TB.
 					 */
+#define SPI_NOR_UNPROTECT	BIT(17)	/*
+					 * Flash is write-protected after
+					 * power-up and needs a global
+					 * unprotect.
+					 */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -2318,15 +2323,15 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
 	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
 
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
-	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
+	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_UNPROTECT) },
 
-	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
+	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_UNPROTECT) },
 
 	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
 
@@ -2348,9 +2353,9 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "en25s64",	INFO(0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
 
 	/* ESMT */
-	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_UNPROTECT) },
+	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_UNPROTECT) },
+	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_UNPROTECT) },
 
 	/* Everspin */
 	{ "mr25h128", CAT25_INFO( 16 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
@@ -2406,9 +2411,9 @@ static const struct flash_info spi_nor_ids[] = {
 	},
 
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, SPI_NOR_UNPROTECT) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, SPI_NOR_UNPROTECT) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, SPI_NOR_UNPROTECT) },
 
 	/* ISSI */
 	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2, SECT_4K) },
@@ -2563,18 +2568,18 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
-	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
-	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
-	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE) },
-	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE) },
-	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
-	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE) },
-	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE) },
-	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE) },
+	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_UNPROTECT) },
+	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
 	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K) },
 	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
-	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
-	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
+	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
+	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE | SPI_NOR_UNPROTECT) },
 	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32, SECT_4K |
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
@@ -4941,20 +4946,38 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_unlock_all() - Unlocks the entire flash memory array.
+ * spi_nor_global_unprotect() - Perform a global unprotect of the memory area.
  * @nor:	pointer to a 'struct spi_nor'.
  *
  * Some SPI NOR flashes are write protected by default after a power-on reset
  * cycle, in order to avoid inadvertent writes during power-up. Backward
  * compatibility imposes to unlock the entire flash memory array at power-up
- * by default.
+ * by default. Do it only for flashes where the block protection bits
+ * are volatile, this is indicated by SNOR_F_NEED_UNPROTECT.
+ *
+ * We cannot use spi_nor_unlock(nor->params.size) here because there are
+ * legacy devices (eg. AT25DF041A) which need a "global unprotect" command.
+ * This is done by writing 0b0x0000xx to the status register. This will also
+ * work for all other flashes which have these bits mapped to BP0 to BP3.
+ * The top most bit is ususally some kind of lock bit for the block
+ * protection bits.
  */
-static int spi_nor_unlock_all(struct spi_nor *nor)
+static int spi_nor_global_unprotect(struct spi_nor *nor)
 {
-	if (nor->flags & SNOR_F_HAS_LOCK)
-		return spi_nor_unlock(&nor->mtd, 0, nor->params.size);
+	int ret;
 
-	return 0;
+	dev_dbg(nor->dev, "unprotecting entire flash\n");
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	nor->bouncebuf[0] &= ~SR_GLOBAL_UNPROTECT_MASK;
+
+	/*
+	 * Don't use spi_nor_write_sr1_and_check() because writing the status
+	 * register might fail if the flash is hardware write protected.
+	 */
+	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
 }
 
 static int spi_nor_init(struct spi_nor *nor)
@@ -4967,10 +4990,12 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
 
-	err = spi_nor_unlock_all(nor);
-	if (err) {
-		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
-		return err;
+	if (nor->flags & SNOR_F_NEED_UNPROTECT) {
+		err = spi_nor_global_unprotect(nor);
+		if (err) {
+			dev_err(nor->dev, "global unprotect failed\n");
+			return err;
+		}
 	}
 
 	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
@@ -5193,6 +5218,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 	if (info->flags & USE_CLSR)
 		nor->flags |= SNOR_F_USE_CLSR;
+	if (info->flags & SPI_NOR_UNPROTECT)
+		nor->flags |= SNOR_F_NEED_UNPROTECT;
 
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7e32adce72f7..89c96c943172 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -137,6 +137,11 @@
 
 #define SR1_QUAD_EN_BIT6	BIT(6)
 
+/* Global unprotect is performed by writing the 0b0x0000xx to the status
+ * register.
+ */
+#define SR_GLOBAL_UNPROTECT_MASK 0xbc
+
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
 
@@ -246,7 +251,7 @@ enum spi_nor_option_flags {
 	SNOR_F_HAS_16BIT_SR	= BIT(9),
 	SNOR_F_NO_READ_CR	= BIT(10),
 	SNOR_F_HAS_SR_TB_BIT6	= BIT(11),
-
+	SNOR_F_NEED_UNPROTECT	= BIT(12),
 };
 
 /**
-- 
2.20.1

