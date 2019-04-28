Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA9C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9C02067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cliCmWri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfD1SJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:09:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33856 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:09:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so4218803pfd.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BvubvJYb+FM7vShur/HONzMPhp7VVdC41h6xYnez19Q=;
        b=cliCmWriOH8BtZerv3/PhzAYBgAHmAn/BrP/6O6H+pa35eUYh2i5OzyIRqQsk5eo5Z
         P695cS5aoldg7gH2IB4/TVZ2EE5BQnE5UIsP3kFI4du5gnfw1ie8ZBkz70nEO9OyTmTv
         zpFrWgo9zForFBTLCynBx7TQsKvB+aStTgjaKALxhQDnVhnYABmLlW3YNGhIcVlQB28h
         hnvkBC6SInKUzdjOL06dj41rIthKqG1Pm0Zn6qKTlq5bcfAH2xdPt9/PfumM9C3iUbNL
         Hfw792S27EGV0sNVP7J83DWZLgWeHIdQ45gVN7SPF62aiW8tHRDzs7TAAIgRsVGf7c+3
         F7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BvubvJYb+FM7vShur/HONzMPhp7VVdC41h6xYnez19Q=;
        b=TMx2GcgMLMJLlcO5DdZGFXcuIyXUjNbDns4GNUcpJg0hqHVIwNQGM1PM0FASmpXHSb
         9IUlgtyJshB/hTBDFBSrYLICrz3v1z40w1koad6uKZ0ZS+d86k+6/LbCaBMHXiSGsEw0
         mt8q2YUbAcemA6iNRN45AYNtaA2jA4BXc6Iaw4i9q0KSAJmzztupDXJFbYbxv02+I9jr
         ShG9nkVPnp1KdvhIbAErZoIscYGDQhTAVdijDsqH7DuiM2B/tiCZvqbvDoyM0eyVof4S
         DxMd9lHpGmjq02F4O6Wu7oWzk88x7AKW8Ejyy8kkQMt6+BdAc8v7g6XNvQ+MR9G2qALU
         a+Qw==
X-Gm-Message-State: APjAAAWXFTQlCbE8T/31JZtHiul0eUGqd1gvV7O/10QPdtxfg2Tpe/K4
        h8B9j6hagXzBZpxwiheuMwGL/Q==
X-Google-Smtp-Source: APXvYqxd7cVuYNl2H0/5QdgaiNhQRkrPL2bmDL+SM8n7GtSp+XzhH/ei7GN3FQudzAjiRD0XEDH60Q==
X-Received: by 2002:a65:5046:: with SMTP id k6mr21256885pgo.325.1556474980663;
        Sun, 28 Apr 2019 11:09:40 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l2sm36177136pgl.2.2019.04.28.11.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 11:09:40 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: add support for is25wp256
Date:   Sun, 28 Apr 2019 23:39:14 +0530
Message-Id: <1556474956-27786-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi_nor_id tablet for is25wp256 (32MB)device from ISSI,
present on HiFive Unleashed dev board (Rev: A00).

Set method to enable quad mode for ISSI device in flash parameters
table.

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

