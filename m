Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1856EC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3592067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MDXXcj5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfD1SKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:10:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39234 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:10:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so325258pfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohuUhz4x6Zl7HFy2hPxACEBNrjELYOPEczRq/3tltOQ=;
        b=MDXXcj5mz3+eAxqbaDVzpkVfcgJmHrCr8AtD5PVH1KAtWp0FrHIsBcm4Uz1Cdt+s4k
         3to7Sl9MRMa0jhkyLEK/xTeakw5Cd4sWtPHuw6p1ejVGzDChlw0BH5mXenX8dBRqCBZx
         h2cadE9uPrBsicmPSIBbCtkMy0ZAvTT/DhuLDkS1HjM2WvFwllL637GAtXi7MjBq/Q+t
         FM1YQZ9p5OZyRmvZXSBC83V0SxlbXRsLBBNdqNALePeP7KYtRvZf5V/ifaROowGYqqlL
         zOSFEUM4k4tbtPLQyTINrBRxmh18eMFshNBx61WKDPU8dKcKnvxdD+gHezXzUy2R9YMZ
         mN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohuUhz4x6Zl7HFy2hPxACEBNrjELYOPEczRq/3tltOQ=;
        b=IhXzlV9HQVBf6SN8UkvpKVQPG37tlf11GgkPbCMdeQYY8b0Q04Cy2PdKGQxyV1AeWt
         rLTmjTdGO/Ku2pLE69ZpO17gjnvKeECb8cVYC19Feo3P9pLa/YUNO3CsWdZTHrgoE3tX
         tHVJozXNBXXOZh+lBePlke7Pf8Vnkzrecwfvrh6hdJG2XI4PCyqVLwlgD9edGWz4Ku1k
         zrUDfisf8jX5AORMCm1yw0XUlnkWTGNbp+ENpT1MXRlDQlq6YrmTI6kErQZdAHg6Aj+u
         M82XdSqkrCie0iGz4R8j/07E+u4wFc0XVnghvIeM0xzWWexSklAy/8ur74sPMA3UEK0W
         uWVA==
X-Gm-Message-State: APjAAAU8//ZWfBn592dxbcTa+xnNK1RHSbZ4YXDo5UHYEGW/t1TM/eNw
        Q+K4XL+gbeVPploSLTxIBwhKkg==
X-Google-Smtp-Source: APXvYqyq0E1OO/NnqwXgZaHv0s0uS3p5TaTatpJ9CmBFjEw+fj7Fo0DXSUyTxVQBiRirvIcR+F9TBA==
X-Received: by 2002:a65:60ca:: with SMTP id r10mr4401741pgv.64.1556474999956;
        Sun, 28 Apr 2019 11:09:59 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l2sm36177136pgl.2.2019.04.28.11.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 11:09:59 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 3/3] mtd: spi-nor: add locking support for is25xxxxx device
Date:   Sun, 28 Apr 2019 23:39:16 +0530
Message-Id: <1556474956-27786-4-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locking scheme for ISSI devices is based on stm_lock mechanism.
The is25xxxxx  devices have 4 bits for selecting the range of blocks to
be locked for write.

The current implementation, blocks entire 512 blocks of flash memory.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 81c7b3e..2dba7e9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1459,6 +1459,65 @@ static int macronix_quad_enable(struct spi_nor *nor)
 
 	return 0;
 }
+/**
+ * Lock a region of the flash.Implementation is based on stm_lock
+ * Supports the block protection bits BP{0,1,2,3} in the status register
+ * Returns negative on errors, 0 on success.
+ */
+static int issi_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int status_old, status_new;
+	u8 mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
+	u8 shift = ffs(mask) - 1, pow, val = 0;
+	loff_t lock_len;
+	bool use_top = true;
+
+	status_old = read_sr(nor);
+
+	if (status_old < 0)
+		return status_old;
+
+	/* lock_len: length of region that should end up locked */
+	if (use_top)
+		lock_len = mtd->size - ofs;
+	else
+		lock_len = ofs + len;
+
+	/*
+	 * Need smallest pow such that:
+	 *
+	 *   1 / (2^pow) <= (len / size)
+	 *
+	 * so (assuming power-of-2 size) we do:
+	 *
+	 *   pow = ceil(log2(size / len)) = log2(size) - floor(log2(len))
+	 */
+	pow = ilog2(mtd->size) - ilog2(lock_len);
+	val = mask - (pow << shift);
+
+	if (val & ~mask)
+		return -EINVAL;
+
+	/* Don't "lock" with no region! */
+	if (!(val & mask))
+		return -EINVAL;
+
+	status_new = (status_old & ~mask & ~SR_TB) | val;
+
+	/* Disallow further writes if WP pin is asserted */
+	status_new |= SR_SRWD;
+
+	/* Don't bother if they're the same */
+	if (status_new == status_old)
+		return 0;
+
+	/* Only modify protection if it will not unlock other areas */
+	if ((status_new & mask) < (status_old & mask))
+		return -EINVAL;
+
+	return write_sr_and_check(nor, status_new, mask);
+}
 
 /**
  * issi_unlock() - clear BP[0123] write-protection.
@@ -4121,6 +4180,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	/* NOR protection support for ISSI chips */
 	if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
 	    info->flags & SPI_NOR_HAS_LOCK) {
+		nor->flash_lock = issi_lock;
 		nor->flash_unlock = issi_unlock;
 
 	}
-- 
1.9.1

