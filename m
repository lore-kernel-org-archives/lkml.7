Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8456AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551AF20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Eji9QCzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfHMMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:40:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43387 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHMMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:40:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so42238393pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgvdxjtpuz55YPGQB23L2WMX3O76fZRFK/d5NtZERoU=;
        b=Eji9QCzX6NDgNFeFnxj9rUaLJ6FyD9qbUp2fmHutJvjmJL8oz/oWGOEImUBp2qtzw2
         ghphYL3aC6mXnLbOGCvXFQjrVBDpirAncbRbGmdUEa7XYLNB0D+JhD51PifiQw0pgHLw
         q1SDWN7dG9Glq6n0BucEoRp8nl9RhPMvVmD/hR9H22W/jI1JPRuB5KVf5Jet9+mUpmOT
         /GhnmfRF/XGkkEgiLzboxS9VhOmSkpz7xq5ZezpOIKH+oS6LIxMPzLR7H8po8iEM4nWL
         KuuymjgKjvPoiInOFUkLUoUWoDAkYK6WXeZiPva9HxTsOLsM0oeJH4zBeiBQoNloEkqW
         DKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgvdxjtpuz55YPGQB23L2WMX3O76fZRFK/d5NtZERoU=;
        b=ODPh7RviqNRuN2L8lsrcEpyg49/rt8hmmTeq/uhgELwqFG2WWklMsr+zOUZ3h8NEmw
         xll9+rXtFMas1MeDOq28jS/SwfZucKjEOUtG95FLTqsjtwRa1BgAgKDPnVvLg6+95hsJ
         rQ+s66bkzuuruXfTSFHnaU4VAraYoXqNdGwY8borAwlJGhAPucgrmrWsJ1Bi3ICcVpWR
         tkh1y11qRIIelldXQ/F3qKbxXlQbj2vqa94++cf+Wf7sAKMAYREg4LxJthV4csEwvmy2
         QMxNgf99EFGWaE4ghCB65QRhD+OzH/yXrYn5tQovRe+vtTuIXk/YZU6ORKaFMvddrSQq
         gSwQ==
X-Gm-Message-State: APjAAAVzmhMb5iNCn51+7ClhZS2bK+3SQZSuLVw6s9UyL8fkjy6pBcqu
        e7fW0uAtFdVBwyu8K2Tu3jhd9w==
X-Google-Smtp-Source: APXvYqxWcTCU0kgc6G/GYUMZlXWQ2LubbF4dViI0P+GouGc1oCNVdP/GEvRTcKm+kT7ludfGw87CVg==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr24385277plg.188.1565700017042;
        Tue, 13 Aug 2019 05:40:17 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v145sm14758467pfc.31.2019.08.13.05.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:40:16 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v8 1/4] mtd: spi-nor: add support for is25wp256
Date:   Tue, 13 Aug 2019 18:08:12 +0530
Message-Id: <1565699895-4770-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
References: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
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
index 03cc788..6635127 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1946,7 +1946,10 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
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

