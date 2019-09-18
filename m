Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C460C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D79421907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NLPFJ4H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfIRQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:02:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43728 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfIRQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:02:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so246510pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x/hOHLuin26MPrIrFSxVodQBfjvOevhYq+l2qnUtb4s=;
        b=NLPFJ4H0KYYWxV3pQaf6UPLJT5yOe2Z9mc8KjdbFMglhBxFeEQqRaXBFL1FuONKFuP
         LtZ8e4sGexom6Wfnf4zMIOCuNksF3PxbFOEggvk84aA483J2v8FXBtq9HKu1SO+XhEHY
         K7XZwjXvtTf01Gsc2jdjCc+BuepCKtwVksaw6Pwc8sGUyDYFy36zzKCo/eL/DZur+pLK
         u2zovlIoxYeTiAR6ZKEAwG6BDwhQvTE2Y6d7YxdWerUzzV2ZgZ9dcHLSnyU30fYkrfHU
         wd29GJsVRBrNGPgKc98MJq//C0IiIP+VM5nQrCjIxWOVNkA6wpJL8+9SrfgZowQ4xRh+
         MNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/hOHLuin26MPrIrFSxVodQBfjvOevhYq+l2qnUtb4s=;
        b=j/IagTkOJ+DnYWUWY7mksrdoFKWtDZ0/nzemkwDhBtoEOfE+P00qHxVcLf8z+aTWo1
         mIonH9w/qcOUHKNdeFFUovLv9GtjpxGfDNXyijcgkmocGdGuv0g5GXcm/NxIMKcOpV/r
         x5I4OUHBnJTn5LcQS29zb9sx+3UKK6ahh3IW+WdadJO9OJoI48FiElPCO/1a5sJ4pfKO
         nMWx+54ET3oqeRocKXHCW3HGLBcobgBSIp9pE9Iox4B33FYjH1bPGNYjeXGqWG5uyxsF
         YTIE1Do97nxOXXfCTLpytn2lWoUo0EmT/sIm2/8/fFPfGwBPoN8sGtexTVsQIyJISxvV
         8uCQ==
X-Gm-Message-State: APjAAAU5sDPKO4FPQcKL9NKSiLlyITIRsWsHNDG2Vey6jcIei0h80jsB
        7FBjJL1kUnX/bSxvgKnvkmXknA==
X-Google-Smtp-Source: APXvYqyTb59K5tEHA9jKBr9DDK6Fol9hLY0ADaMXEbmWN9Vrrd8hcj+iGvecx5mGfHulwlg9Srchew==
X-Received: by 2002:a65:5543:: with SMTP id t3mr4674553pgr.242.1568822553580;
        Wed, 18 Sep 2019 09:02:33 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id g12sm9872379pfb.97.2019.09.18.09.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 09:02:33 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v9 1/2] mtd: spi-nor: add support for is25wp256
Date:   Wed, 18 Sep 2019 21:31:44 +0530
Message-Id: <1568822505-19297-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
References: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
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
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
 include/linux/mtd/spi-nor.h   | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 654bdc4..003c1c7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1946,7 +1946,10 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-
+	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_4B_OPCODES)
+	},
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
@@ -3776,6 +3779,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
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
index 9f57cdf..5d6583e 100644
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

