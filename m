Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D1C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F5F206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="N9T4s1rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgAHXhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:37:33 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:51477 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAHXhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:37:33 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0CD8423E23;
        Thu,  9 Jan 2020 00:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578526650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZVcQlcSQa0twgDeV34tE7xVyDIK8gY9Ex04Co+QXWg=;
        b=N9T4s1rpWvTFCrOMOP3JV8GSd488gbBOV63IDTL7esnInQl6hvaM0BNtRJ7e3mmySs5e/T
        JbJ/wCogBGl6EMZ1SYu6/8A8+Gnc+A2Jg4AUcQw7j0Icwn2n5enlckHkvI1kGKloCJPtHx
        OTdO/5CCRrq0Vr0KTVna/QNxHci1VLA=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] mtd: spi-nor: add OTP support
Date:   Thu,  9 Jan 2020 00:36:53 +0100
Message-Id: <20200108233654.29027-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108233654.29027-1-michael@walle.cc>
References: <20200108233654.29027-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 0CD8423E23
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.698];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         FREEMAIL_CC(0.00)[microchip.com,bootlin.com,nod.at,ti.com,gmail.com,imgtec.com,walle.cc]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the MTD callbacks for the OTP methods for the SPI NOR
subsystem.

Usually, the OTP area of a SPI flash can be accessed like the normal
memory, eg by offset addressing; except that you either have to use
special read/write commands (Winbond) or you have to enter (and exit) a
specific OTP mode (Macronix, Micron). Sometimes there are individual
regions, which might have individual offsets. Therefore, it is possible
to specify the starting address of the first regions as well as the
distance between two regions (Winbond).

Additionally, the regions might be locked down. Once locked, no further
write access is possible.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spi-nor.c | 147 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  38 +++++++++
 2 files changed, 185 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 818cb9393f41..5eabaec70508 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -241,6 +241,15 @@ struct flash_info {
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
+
+	/* OTP size in bytes */
+	u16 otp_size;
+	/* Number of OTP banks */
+	u16 n_otps;
+	/* Start address of OTP area */
+	u32 otp_start_addr;
+	/* Offset between consecutive OTP banks if there are more than one */
+	u32 otp_addr_offset;
 };
 
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -2240,6 +2249,12 @@ static int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 		.addr_width = 3,					\
 		.flags = SPI_NOR_NO_FR | SPI_S3AN,
 
+#define OTP_INFO(_otp_size, _n_otps, _otp_start_addr, _otp_addr_offset)	\
+		.otp_size = (_otp_size),				\
+		.n_otps = (_n_otps),					\
+		.otp_start_addr = (_otp_start_addr),			\
+		.otp_addr_offset = (_otp_addr_offset),
+
 static int
 is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 			   const struct sfdp_parameter_header *bfpt_header,
@@ -4827,6 +4842,12 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+
+	/* OTP parameters */
+	nor->params.otp_info.otp_size = info->otp_size;
+	nor->params.otp_info.n_otps = info->n_otps;
+	nor->params.otp_info.otp_start_addr = info->otp_start_addr;
+	nor->params.otp_info.otp_addr_offset = info->otp_addr_offset;
 }
 
 static void spansion_post_sfdp_fixups(struct spi_nor *nor)
@@ -5122,6 +5143,125 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	return info;
 }
 
+static loff_t spi_nor_otp_region_start(struct spi_nor *nor, int region)
+{
+	struct spi_nor_otp_info *info = &nor->params.otp_info;
+
+	return info->otp_start_addr + region * info->otp_addr_offset;
+}
+
+static loff_t spi_nor_otp_region_end(struct spi_nor *nor, int region)
+{
+	struct spi_nor_otp_info *info = &nor->params.otp_info;
+
+	return (info->otp_start_addr + region * info->otp_addr_offset
+		+ info->otp_size - 1);
+}
+
+static int spi_nor_otp_info(struct mtd_info *mtd, size_t len, size_t *retlen,
+			    struct otp_info *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int i;
+
+	for (i = 0; i < nor->params.otp_info.n_otps; i++) {
+		buf[i].start = spi_nor_otp_region_start(nor, i);
+		buf[i].length = nor->params.otp_info.otp_size;
+		buf[i].locked = !!(nor->params.otp_ops->is_locked(nor, i));
+	}
+
+	*retlen = nor->params.otp_info.n_otps * sizeof(*buf);
+
+	return 0;
+}
+
+static int spi_nor_otp_addr_to_region(struct spi_nor *nor, loff_t addr)
+{
+	int i;
+
+	for (i = 0; i < nor->params.otp_info.n_otps; i++)
+		if (addr >= spi_nor_otp_region_start(nor, i) &&
+		    addr <= spi_nor_otp_region_end(nor, i))
+			return i;
+
+	return -EINVAL;
+}
+
+static int _spi_nor_otp_read_write(struct mtd_info *mtd, loff_t ofs,
+				   size_t len, size_t *retlen, u_char *buf,
+				   bool is_write)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	enum spi_nor_ops ops = (is_write) ? SPI_NOR_OPS_OTP_WRITE
+					  : SPI_NOR_OPS_OTP_READ;
+	int region;
+	int ret;
+
+	*retlen = 0;
+
+	/* check boundaries */
+	region = spi_nor_otp_addr_to_region(nor, ofs);
+	if (region < 0)
+		return 0;
+
+	if (ofs < spi_nor_otp_region_start(nor, region))
+		return 0;
+
+	if ((ofs + len - 1) > spi_nor_otp_region_end(nor, region))
+		return 0;
+
+	ret = spi_nor_lock_and_prep(nor, ops);
+
+	if (is_write)
+		ret = nor->params.otp_ops->write(nor, ofs, len, buf);
+	else
+		ret = nor->params.otp_ops->read(nor, ofs, len, buf);
+
+	spi_nor_unlock_and_unprep(nor, ops);
+
+	if (ret < 0)
+		return ret;
+
+	*retlen = len;
+	return 0;
+}
+
+static int spi_nor_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
+			    size_t *retlen, u_char *buf)
+{
+	return _spi_nor_otp_read_write(mtd, from, len, retlen, buf, false);
+}
+
+static int spi_nor_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
+			     size_t *retlen, u_char *buf)
+{
+	return _spi_nor_otp_read_write(mtd, to, len, retlen, buf, true);
+}
+
+static int spi_nor_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int region;
+	int ret;
+
+	region = spi_nor_otp_addr_to_region(nor, from);
+	if (region < 0)
+		return -EINVAL;
+
+	if (len != nor->params.otp_info.otp_size)
+		return -EINVAL;
+
+	ret = spi_nor_lock_and_prep(nor, SPI_NOR_OPS_OTP_LOCK);
+	if (ret)
+		return ret;
+
+	ret = nor->params.otp_ops->lock(nor, region);
+
+	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_OTP_LOCK);
+
+	return ret;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
@@ -5197,6 +5337,13 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		mtd->_is_locked = spi_nor_is_locked;
 	}
 
+	if (nor->params.otp_ops) {
+		mtd->_get_user_prot_info = spi_nor_otp_info;
+		mtd->_read_user_prot_reg = spi_nor_otp_read;
+		mtd->_write_user_prot_reg = spi_nor_otp_write;
+		mtd->_lock_user_prot_reg = spi_nor_otp_lock;
+	}
+
 	/* sst nor chips use AAI word program */
 	if (info->flags & SST_WRITE)
 		mtd->_write = sst_write;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7cefad41acff..e427dcd72f79 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -232,6 +232,9 @@ enum spi_nor_ops {
 	SPI_NOR_OPS_LOCK,
 	SPI_NOR_OPS_UNLOCK,
 	SPI_NOR_OPS_IS_LOCKED,
+	SPI_NOR_OPS_OTP_READ,
+	SPI_NOR_OPS_OTP_WRITE,
+	SPI_NOR_OPS_OTP_LOCK,
 };
 
 enum spi_nor_option_flags {
@@ -510,6 +513,36 @@ struct spi_nor_locking_ops {
 	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 };
 
+/**
+ * struct spi_nor_otp_info - Structure to describe the SPI NOR OTP region
+ * @otp_size:		size of one OTP region in bytes.
+ * @n_otps:		number of individual OTP regions.
+ * @otp_start_addr:	start address of the OTP area.
+ * @otp_addr_offset:	offset between consecutive OTP regions if there are
+ *			more than one.
+ */
+struct spi_nor_otp_info {
+	u32 otp_size;
+	int n_otps;
+	u32 otp_start_addr;
+	u32 otp_addr_offset;
+};
+
+/**
+ * struct spi_nor_otp_ops - SPI NOR OTP methods
+ * @read:	read from the SPI NOR OTP area.
+ * @write:	write to the SPI NOR OTP area.
+ * @lock:	lock an OTP region.
+ * @is_locked:	check if an OTP region of the SPI NOR is locked.
+ */
+struct spi_nor_otp_ops {
+	int (*read)(struct spi_nor *nor, loff_t ofs, uint64_t len, u8 *buf);
+	int (*write)(struct spi_nor *nor, loff_t ofs, uint64_t len, u8 *buf);
+	int (*lock)(struct spi_nor *nor, unsigned int region);
+	int (*is_locked)(struct spi_nor *nor, unsigned int region);
+};
+
+
 /**
  * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
  * Includes legacy flash parameters and settings that can be overwritten
@@ -526,6 +559,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @otp_info:		describes the OTP regions.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
  * @convert_addr:	converts an absolute address into something the flash
@@ -536,6 +570,7 @@ struct spi_nor_locking_ops {
  *                      e.g. different opcodes, specific address calculation,
  *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
+ * @otp_ops:		SPI NOR OTP methods.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -547,12 +582,15 @@ struct spi_nor_flash_parameter {
 
 	struct spi_nor_erase_map        erase_map;
 
+	struct spi_nor_otp_info otp_info;
+
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 
 	const struct spi_nor_locking_ops *locking_ops;
+	const struct spi_nor_otp_ops *otp_ops;
 };
 
 /**
-- 
2.20.1

