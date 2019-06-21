Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA270C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2DE208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OXIh86gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFURN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:13:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34792 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFURN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:13:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so3702296pgn.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o1QLzue2L9JyqaN4FDGc1k6pQyo17m+dj0qwGBRdDDY=;
        b=OXIh86gcYSAIWnFCybe6YkfZ9n6MJRje1GXFZ6LrKLFv0hm4DdMxg4+ScBQkfv9tlB
         my4V9V6Z1bwokLV6PeVUkhXOct2z+oaVqKOvCAFs6y1VgnOuUjfEpQpqved5gUmsuP1F
         y8EYncVYigNk+XV+olBklsZhQiHyaMMGYdzCooNYiP4Rk0cRDUcjm5/v3eR9uvZWY9lv
         xOnCiLn5lvUrVSvkRjlQ1pB3SmgmvEq3wJAaebOY5wPx1nDIA+5bq33uq3MMUEq7umOq
         yj1a2obP9idCdB4MG9zRK27yHDxdF85lMbv9FicaWkIdVHDdZFxoMlDgOtiG8mL8FlLa
         1GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o1QLzue2L9JyqaN4FDGc1k6pQyo17m+dj0qwGBRdDDY=;
        b=ugse7E4OurrcK69QX1DBAhdaUG1u4pbIMNcRpSNib4HnGqQrpQf1bNQTP5qLL7w3/o
         lovcuMFeJ1fUwPwnHu0FwFme8ZWSJ/mzF1LDIJcDVQN3F7+3jH7OrqCumMf8YQI+g563
         PHKAmFjMe3nJoKMGAo1FkqCK8Wulzo+CUJQ3IhUqsSnNgXet21sm2WPuZNOQcCcaU/WT
         XIZTVEOKrkxPt/MY5LwJQfzkDImgH3pQuaffmtNG0yfIn8sTnHpWIsYBdf/wH5cjB9iH
         z3E+a5Ieeuc0YTNx9JelsfAVYkuA8hOu12y6E+kIFAY7ILlnkKB7LJsAEb40R2iuUZ9X
         LpYA==
X-Gm-Message-State: APjAAAXXpdqRUJ5KPHdLy6UMxMXu50JR8ltBJ0qgTpU0xTqchPPBGOma
        g0n8uSLhantyxbPBKyaFy8mYcA==
X-Google-Smtp-Source: APXvYqxof2SKEqf2xCm0Tw+L4w3+uZRZjimqmRHsuJRrgvUKSNpX9BWdxeTfusOXP5HA2YFfZEboDg==
X-Received: by 2002:a63:1343:: with SMTP id 3mr20134770pgt.426.1561137240372;
        Fri, 21 Jun 2019 10:14:00 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t5sm3496190pgh.46.2019.06.21.10.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 10:13:59 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v6 1/3] mtd: spi-nor: add support for is25wp256
Date:   Fri, 21 Jun 2019 22:43:29 +0530
Message-Id: <1561137211-12406-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561137211-12406-1-git-send-email-sagar.kadam@sifive.com>
References: <1561137211-12406-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi_nor_id table for is25wp256 (32MB) device from ISSI,
present on HiFive Unleashed dev board (Rev: A00).

Set method to enable quad mode for ISSI device in flash parameters
table. Set address width to 4byte if device supports 4Byte opcode and
it's size is greater than 16MiB.

Based on code originally written by Wesley Terpstra <wesley@sifive.com>
and/or Palmer Dabbelt <palmer@sifive.com>
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 19 +++++++++++++++----
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 73172d7..c816f0c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1834,6 +1834,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_4B_OPCODES)
+	},
 
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
@@ -3652,6 +3656,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		case SNOR_MFR_MACRONIX:
 			params->quad_enable = macronix_quad_enable;
 			break;
+		case SNOR_MFR_ISSI:
+			params->quad_enable = macronix_quad_enable;
+			break;
+
 
 		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
@@ -4129,13 +4137,16 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
-	if (nor->addr_width) {
+	if (info->flags & SPI_NOR_4B_OPCODES && mtd->size > 0x1000000) {
+		/*
+		 * enable 4-byte addressing if device supports it and
+		 * its size exceeds 16MiB.
+		 */
+		nor->addr_width = 4;
+	} else if (nor->addr_width) {
 		/* already configured from SFDP */
 	} else if (info->addr_width) {
 		nor->addr_width = info->addr_width;
-	} else if (mtd->size > 0x1000000) {
-		/* enable 4-byte addressing if the device exceeds 16MiB */
-		nor->addr_width = 4;
 	} else {
 		nor->addr_width = 3;
 	}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b3d360b..ff13297 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -19,6 +19,7 @@
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
+#define SNOR_MFR_ISSI		0x9d		/* ISSI */
 #define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
 #define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
-- 
1.9.1

