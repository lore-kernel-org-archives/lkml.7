Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163AF2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SC/wtDlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407968AbfFLKtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:49:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33573 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407236AbfFLKtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:49:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so9469883pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/34VUba2TMn1HUJYz+e67ilwN8q7isgKAmoXZ4qRiqs=;
        b=SC/wtDlWHVohDk7cxk5knZoolyQZl4Clqn455YPX3TFOuVKH5GRuCtgk3p6HL+y8jn
         b+keSwdI+s29Sse4jokvis6wMRIfvVT0nh7ABPa6t1aMvDSdLkexGNnD+j9irzPHXud5
         mXH820BF/AhKZIJ8f8JFX1tOayUZBgudZUu6F9jLp6An15h3NMu2RgXBMjjgrj0dzVE+
         jI0yzEL+/aQu0+z0MXvYsxxXEs0Kr3/VIp5zaMWvsgVIK046vdZVePonBYmVst2ug4iH
         JDJCWMFbeaAou4tAl8U+yJ0W9eO5ruf4/AJYDr+Mo6IdiPCHaIm2kjWrXud2/P76YHmh
         KGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/34VUba2TMn1HUJYz+e67ilwN8q7isgKAmoXZ4qRiqs=;
        b=D9EHu4Xrg1B4LElQt9zBl80F4adp8atYw4uv57WVNVvTJbogG7QK4uLmmon0QWR93Q
         UV7+MusLAOUC35uhJdIq+2te3K1X3kVCat/MDtXmbhW296nQ7R78f3Ajg1IhdcY04d2q
         7ElMv49rdMqSvtHziRuCc8Rn1ytRmgv3xVV3qL11ncS7aqNLfoiJ+tqiLpY+K7ZHkLQO
         eUsnExD1JHd/rpHRLB6QMc2TJYA3DL97DuhLSOX65RNzzOAOaS7ypCD7a1UnOOAaQhH3
         x5QLsaoo8sWETF5Djgvb0u6Mf1dGu2C8l7p0XrMTKxHvmK09peJd2HVubG0Xj0PbJVbK
         NIQw==
X-Gm-Message-State: APjAAAXUrAE26ZNoaCNbR17MYNDqG+qCjb3RVc/U8GZQ8hX+XKtXa6IG
        0540xHj0BNO9bzjiAwpzUT4aUg==
X-Google-Smtp-Source: APXvYqyyIMxcvMkdOmgbGdxqwUCfj1i8ToNEidoIVG/3vovKkuMaa+3pJ9drMOOqrY0fD0slF0BNZg==
X-Received: by 2002:a62:5c84:: with SMTP id q126mr59382546pfb.247.1560336553124;
        Wed, 12 Jun 2019 03:49:13 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id y22sm12241561pfm.70.2019.06.12.03.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 03:49:12 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        wesley@sifive.com, Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v5 2/3] mtd: spi-nor: add support to unlock flash device
Date:   Wed, 12 Jun 2019 16:17:55 +0530
Message-Id: <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
have memory blocks guarded by block protection bits BP[0,1,2,3].

Clearing block protection bits,unlocks the flash memory regions
The unlock scheme is registered during nor scans.

Based on code developed by Wesley Terpstra <wesley@sifive.com>
and/or Palmer Dabbelt <palmer@sifive.com>.
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2d5a925..b7c6261 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1461,6 +1461,49 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
 
 /**
+ * issi_unlock() - clear BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to unlock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Bits [2345] of the Status Register are BP[0123].
+ * ISSI chips use a different block protection scheme than other chips.
+ * Just disable the write-protect unilaterally.
+ *
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
+		ret = 0;
+	} else {
+		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+/**
  * spansion_quad_enable() - set QE bit in Configuraiton Register.
  * @nor:	pointer to a 'struct spi_nor'
  *
@@ -1836,7 +1879,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_4B_OPCODES)
+			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK)
 	},
 
 	/* Macronix */
@@ -4080,6 +4123,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
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

