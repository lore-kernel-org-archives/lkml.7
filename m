Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4FC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD2208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SiTnOmO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfEKKI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 06:08:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEKKI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 06:08:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so4216130pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lq4Rwbk+Emx7YmwQUYNWJJYYUQtvyvA+20pB793R1LY=;
        b=SiTnOmO5Sznr5CnkPCNnoJVJU5Gvid2yUW/23I5LhaPf+c7zw252vPCI8XCFt1fZmo
         emDGSDr4ld2Y4g4B24Y7T443ibZBpcgBrr1rJkwzTywjYNGhQAOy0k7XeIAxp1uVt2rd
         txaE9KGRqB04hsCqTzsanygmidSljfy0mQ8LmxWRQjt3Q5IuhfWS+hcaQggLWJu09tIo
         KssEG3LK8ZkIt2S/6sR2ZSdS2YQlZkkumcnHaJmfEXvKBYbf+MKKcTnpmLCtxsU1VOCO
         PuQ4gVdeDWhzoEuxevEEIK165ionec0kMb6BvKCrPiBNcd4/MIm9iFSHzrR6BCxcGyQV
         Gn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lq4Rwbk+Emx7YmwQUYNWJJYYUQtvyvA+20pB793R1LY=;
        b=CMXNPDkDJWV6LqJ+6EFs9895og4195CxPa8tOG8wPKKn85SwNkg9564lvn9VDVt/AX
         wVDBdv2HTp0hmKUx/oCwRhtfg2GrKIFOpBSQ+JE4KP65IflySkWUDPZ7Wk0u8Vtgum9V
         2l4gxP+RrdBNCMX9nqom0IHciwZ9PriuQ9dGwG1/EVYed6nv3LgB8uLsrCbOWanSmYM6
         kUbKYwnWxp4bYDimUeGJZuZaLzD7G3FzjhpO00BYwE0aEMLOkGLpHrTFjGcEdBJYsdF2
         4ofoZtSNxIoWi1SnAcV7X6prxPXxUijtZ7R2tDL+fSiclfHTDCxyehnzxIfmsoVS9duh
         dpvQ==
X-Gm-Message-State: APjAAAVLdxbP83ju95O+vpquLyhxfhTQo5zuh8GSMA8vxp6ZN/h3gm2c
        X/E/610i3/Zg6+3O89aj4B73OA==
X-Google-Smtp-Source: APXvYqxOdhmgPO8LBuF/0ZOWGILA5WyT0Mz/HZlaeiC4VVBR8+wmgJ7gNoTimV5uPF/AqWOurqUY4w==
X-Received: by 2002:a62:d286:: with SMTP id c128mr21241832pfg.159.1557569307043;
        Sat, 11 May 2019 03:08:27 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id c129sm16951836pfg.178.2019.05.11.03.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 May 2019 03:08:26 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v4 1/3] mtd: spi-nor: add support for is25wp256
Date:   Sat, 11 May 2019 15:38:06 +0530
Message-Id: <1557569288-19441-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557569288-19441-1-git-send-email-sagar.kadam@sifive.com>
References: <1557569288-19441-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi_nor_id table for is25wp256 (32MB)device from ISSI,
present on HiFive Unleashed dev board (Rev: A00).

Set method to enable quad mode for ISSI device in flash parameters
table.

Based on code originally written by Wesley Terpstra <wesley@sifive.com>
and/or Palmer Dabbelt <palmer@sifive.com>
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index fae1474..c5408ed 100644
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
@@ -3650,6 +3654,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		case SNOR_MFR_MACRONIX:
 			params->quad_enable = macronix_quad_enable;
 			break;
+		case SNOR_MFR_ISSI:
+			params->quad_enable = macronix_quad_enable;
+			break;
+
 
 		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
@@ -4127,7 +4135,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
-	if (nor->addr_width) {
+	if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
 		/* already configured from SFDP */
 	} else if (info->addr_width) {
 		nor->addr_width = info->addr_width;
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

