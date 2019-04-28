Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0DDC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141B42067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BhzA6dOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfD1SJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:09:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41937 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:09:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so4060856pgs.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3oA6xsWkMzW8lhwed6XL1LWLbuI401osDXa7Y5e4Ugw=;
        b=BhzA6dOb3wKoCsXuMCvfUbj5goqhFsUESrXRkMrNCJiUCA6wI0b2PkAr5bsPeFe7CQ
         1VKTvjFM/RyCZV6kJ3CGKHupbKoNSq+ajU3s7xVuVtp2hl5IA+kLiV24UB89iAtJc/GL
         k5537kLMn8GDFWmIo+zvQr6fsab3hLl/M+WIWwOmdGQ1CaBGTmTA9Tm7XWy4qV6wTtI1
         dMKPEhM3tMOwmpVANSOsuxPqcEo33BwMrPW1PXsmQJyih0oLYd9GFHdxNbT9dlqYEqDe
         omk09bFmQShHaOxjNGt/Wzn/f8JQq2oh23sOBlLa/apFIqtq7db1btRBVbM2c/QRjIVM
         AEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3oA6xsWkMzW8lhwed6XL1LWLbuI401osDXa7Y5e4Ugw=;
        b=VUEEZHpriQ1ZCfn4BdS7bkKXEGEXZW34a7RrLOwyuzHjz1sgPxvJRT8WUxz5dBRZt5
         NpdmdApZC/Y5tNxo/lLu2eumrie4VY/3seolWPLp2Y7PRS8iBXDxCBYzbVF7BjZP9++z
         DgpORKPkkib17i9FID1xAOKM7695AvlkLROg6Dtj2MmfzKp2eHjtL5DqF59uJB4Qm/xf
         SUz7sG5CUSW8psqaPRTp8u8q5oJ/R0WyW/4WO36pXIYT+LZrEiViU0mpJXahEeAaWUxm
         zWGSyTfLG5pLzfa89LFOPKpcmwVoMZGR3hLDzNGV+4mzcUNzWitBz2go2tl6N0zOcqP0
         KqDA==
X-Gm-Message-State: APjAAAWvuQSNMhyWu5yBcX8XtotFM4bFDwBbdwSw3j3Rj8EhjvYruvsZ
        keIpewVJ9LI006YvnO12QszqqRZInkSP6Ays
X-Google-Smtp-Source: APXvYqwgLdSdvicG3hPqn/pwFsyTDykIPuPwRED2PxbP9C+HiksUXNY7i90q+fAo5WyG/BdNDlcToQ==
X-Received: by 2002:a63:5014:: with SMTP id e20mr30993446pgb.312.1556474993621;
        Sun, 28 Apr 2019 11:09:53 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l2sm36177136pgl.2.2019.04.28.11.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 11:09:53 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 2/3] mtd: spi-nor: add support to unlock flash device.
Date:   Sun, 28 Apr 2019 23:39:15 +0530
Message-Id: <1556474956-27786-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
have memory blocks guarded by block protection bits BP[0,1,2,3].

Clearing block protection bits,unlocks the flash memory regions
The unlock scheme is registered during nor scans.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c5408ed..81c7b3e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1461,6 +1461,46 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
 
 /**
+ * issi_unlock() - clear BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'
+ * @ofs: offset from which to unlock memory
+ * @len: number of bytes to unlock
+ * Bits [2345] of the Status Register are BP[0123].
+ * ISSI chips use a different block protection scheme than other chips.
+ * Just disable the write-protect unilaterally.
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret, val;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
+
+	val = read_sr(nor);
+	if (val < 0)
+		return val;
+	if (!(val & mask))
+		return 0;
+
+	write_enable(nor);
+
+	write_sr(nor, val & ~mask);
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret = read_sr(nor);
+	if (ret > 0 && !(ret & mask)) {
+		dev_info(nor->dev,
+			"ISSI Block Protection Bits cleared SR=0x%x", ret);
+		return 0;
+	} else {
+		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
+		return -EINVAL;
+	}
+}
+
+/**
  * spansion_quad_enable() - set QE bit in Configuraiton Register.
  * @nor:	pointer to a 'struct spi_nor'
  *
@@ -1836,7 +1876,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_4B_OPCODES)
+			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK)
 	},
 
 	/* Macronix */
@@ -4078,6 +4118,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flash_is_locked = stm_is_locked;
 	}
 
+	/* NOR protection support for ISSI chips */
+	if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
+	    info->flags & SPI_NOR_HAS_LOCK) {
+		nor->flash_unlock = issi_unlock;
+
+	}
 	if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
 		mtd->_lock = spi_nor_lock;
 		mtd->_unlock = spi_nor_unlock;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index ff13297..9a7d719 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -127,6 +127,7 @@
 #define SR_BP0			BIT(2)	/* Block protect 0 */
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
+#define SR_BP3			BIT(5)	/* Block protect 3 for ISSI device*/
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 /* Spansion/Cypress specific status bits */
-- 
1.9.1

