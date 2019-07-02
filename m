Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2FB21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kP2+RMyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGBSkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:40:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33714 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:40:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so8705391pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y+CmxvfTHNmkdcHZerrxb2wPdBc38Gq6FdKZioHxbqE=;
        b=kP2+RMySSYi0s9bLP+JPIjdlGB7GP0IyPMEzIP3Nw8BtM33CdAP+p6Xn577lTaKdlp
         V+w3kPeb5i+UGKJakJaQOQVeum5kY/mqq6YHOduVMyUHDmWPutdGc233cDaOEIVLqvfP
         7rqMmNJlpWAzrndk+vQFCzTnq/8RJ1BWWLOR6qdg5VOAK7H//4nxXEYWAzm8ya9l2TxX
         HC2zk1EAPyr93XGjNK/kAyFGXQYgubDB5b6TZ5Z3U1fXC/ygMrr6LgOA0DoIrxaw0NmS
         eU9yK8CmXKmxzJ26PaclixrkwaWWf8W0UdGbk3wJXKRICVUR2zQqDB2OwmCXDVkGQ/ip
         XvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y+CmxvfTHNmkdcHZerrxb2wPdBc38Gq6FdKZioHxbqE=;
        b=ELDyrxqP9Y0RzEdxqf/pIZi2CFF3ipRkXLnU6EDrdliLV4xACJP5Ht7+g7sBDMrhtO
         MSBHldeSiG7BezH3QmTfXIwuQUjsBknYtA1E/uXQ5sgT+iPQRpoImOWG9eSg9vq6kmkf
         v9omzD/+k7VBBT0FT3S0epXP388WBVCfc3bI/8w0x8LiThBLDYirb739UHWrgGqPU2LO
         YJn6/jKfTKExBcEt3dP0ofUDaGloj6l/ufgsjGP3MG3x/YukCBBBTB5+r4tOgc85fHlL
         UsmGbSzQ0wgiKP3CyVghKOtkItOKevBtwDF5TxzElatJBMYkE5OUvcZlWnxdioSmd/fU
         l4sg==
X-Gm-Message-State: APjAAAWmxTgnAUOXAMiWH1pFfxhkSjFIDs2G8X8PW1CVs4Y3yfdvB3SG
        4HEQeK6ej+NK8QNrhWBgb6SbnQ==
X-Google-Smtp-Source: APXvYqwGMFL+2bJhWMoeLMIUPikC9EIj+4FMNu3+vEguV2Ru2oTeOyZJqNVCOTuD3VLHeGb+B2sKMg==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr32511540pgj.447.1562092811827;
        Tue, 02 Jul 2019 11:40:11 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id e10sm15065327pfi.173.2019.07.02.11.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 11:40:11 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v7 1/4] mtd: spi-nor: add support for is25wp256
Date:   Wed,  3 Jul 2019 00:09:02 +0530
Message-Id: <1562092745-11541-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi_nor_id table for is25wp256 (32MB) device from ISSI,
present on HiFive Unleashed dev board (Rev: A00).

Set method to enable quad mode for ISSI device in flash parameters
table.

Based on code originally written by Wesley Terpstra <wesley@sifive.com>
and/or Palmer Dabbelt <palmer@sifive.com>
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
 include/linux/mtd/spi-nor.h   | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index e3a28c0..971f0f3 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1857,7 +1857,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-
+	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_4B_OPCODES)
+	},
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
@@ -3687,6 +3690,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
 			break;
+		case SNOR_MFR_ISSI:
+			params->quad_enable = macronix_quad_enable;
+			break;
+
 
 		default:
 			/* Kept only for backward compatibility purpose. */
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b3d360b..b0e42b3 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -21,6 +21,7 @@
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
 #define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
 #define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
+#define SNOR_MFR_ISSI		0x9d		/* ISSI */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
 #define SNOR_MFR_SPANSION	CFI_MFR_AMD
 #define SNOR_MFR_SST		CFI_MFR_SST
-- 
1.9.1

