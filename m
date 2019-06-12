Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F6AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580A62082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZSELiBES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438114AbfFLKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:49:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34529 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438001AbfFLKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:49:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so2873773pgn.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7M7QYSxGt/aVWkXZdIMJHrBQMPJsRF6Kb+FhsyP4CA=;
        b=ZSELiBESGPlceqPX3xiDLypLBYaVWBovPKh751e21AzuB6YBJLTeXfqMFPfCnHHtwD
         KzSenLJAQYR5e8gZfmN2mvHPZsmlAOMibc4jRsDbtXbGa+Zh6yxNbJ24PKWZzucJMN3d
         3DP5BBk8wqJQD2cC5tRRguKt7ZBDCJyNE/90iFKnTr9ocx8UsMsRQXMteuWCpQNQXSGd
         5HJ+/Nvfen8CBt1ZKi6Rx6UXP3nKpErfFa1wrVwpUY2LC0iNqjGCtcNjV9USd0PBGSbL
         Br+hzWZWfhfEW8VqGFrFjhkz8wIIkI7oBwu4rOXoCJi3OjvA85GSY3IRHmTic5v0Y8PC
         CX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7M7QYSxGt/aVWkXZdIMJHrBQMPJsRF6Kb+FhsyP4CA=;
        b=Wp0JCf9LmlQicy+gG9JytA1gLHpMaUPlq0nKTHAOgzVb0Vsj9PWyje4yaehRa+NL06
         KdFyWyCL9ijirDz+5na9WWgS+2RX4lV6e53Y/exttJgDhRqbxTcNw8C4fwS4HKZCQ4zY
         ng+NuvWqUsmvesnxOTm/Xvh7cysdXnFIneLpV+3WMpVXfCNhNr9Z1+naE1fr/U1QaaXM
         h7nIbgbpf2DWDyiFutZHx+x02aOT1EwfAKouiNhJZhlk3ko1hj46ZOFbc5643tRe3wmV
         tHDK3vNECC7rGx/ZIGLlmsIstef4qOhTu9TMh/ZsSzATJvm9ntib12GkLc2Yn/aF2r7x
         xCtA==
X-Gm-Message-State: APjAAAU7s6THzdqF5xcPIQfp1kGFMPKnjGWYE0bAYajDG57JMpM023Sj
        PME+iByW7Ofm+sgr/InStNR0Xw==
X-Google-Smtp-Source: APXvYqw0gz/9zS/lAD2oWKmUiowOrlPz0e+ywn/q0KQ7ZMUPVYjMbZ10Yp+KlKI2tXbBvWxiC43gVg==
X-Received: by 2002:a63:6881:: with SMTP id d123mr18402074pgc.201.1560336546861;
        Wed, 12 Jun 2019 03:49:06 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id y22sm12241561pfm.70.2019.06.12.03.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 03:49:06 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        wesley@sifive.com, Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v5 1/3] mtd: spi-nor: add support for is25wp256
Date:   Wed, 12 Jun 2019 16:17:54 +0530
Message-Id: <1560336476-31763-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
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
index 73172d7..2d5a925 100644
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
@@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
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

