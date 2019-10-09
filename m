Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2FEC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66391206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLLC6eS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfJIDvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:51:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33018 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfJIDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:51:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so383689pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 20:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zVu11whZejwT26Lzl3FQULkz866LhnLShS6RpKsbAz4=;
        b=cLLC6eS/u5pAChPsyLfugrYPdytzuN8IQTkOMNpe6fAx4n4dXT3qxBZ/TglrOY9+9S
         Ofps+UkZvVRuBpm+xSeLkw4J104IbNv5sW5Rf5QCTxoeIP4D9bvHBBflxmxN8O9uV7A9
         KmJhJ2Ox3WpopjvyEgtHninJuPtyvvO4nvuwohvRjmmpFF4F5PQEciFW0A/b0ORKhbjl
         b23YqmOL35jgqh2BHHNAMqwR8sjYNCm18ANBYzVO2DA1tbXc5h8kZD+aNhRWD438QHJn
         /KwgluFw8iig12GGmPGJTvmVBgvgjkDEProGmjeTu2DqR1LmAsb4KYSA1sVBwHNAM8aS
         Q7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zVu11whZejwT26Lzl3FQULkz866LhnLShS6RpKsbAz4=;
        b=WIROZsBdVMRfO35NkQaJslxkh4rkT0q2/7awKRagA9C15DAHoP5lkHTiSsT2mH8g+p
         MbYuAc4lIlL8l7FfbQdjOwzlXdLpMwiFxpoUUz2FgLcwxT0DcB86eyGZXAVZu2g5lwGt
         sQY4aLlZIP+5aPCimwn6DnMDFVSmYXgjv5BGVB2F72elHTfWWYFef3NAyric8Q/DiywF
         MwXMsjmEk46v5rvAlYq6wpsWKGslsN0o04ZQ8jugg+bNcbTGVK5rvZYzKmaDe5l4PVGM
         bOp7hYf7JZAEU6haG8UPI0fi9smXi8D/jIRknYadlh8Z3gv6kso3ukcMX8tyKA8JCv91
         tI4w==
X-Gm-Message-State: APjAAAWeBSZSU70abUUX0EgZYFQzmsfeQKrGn7hE4w9YmLpNvE1gG1P8
        rRwtExbJYNtrKTbiDbBlwoLd1XKo9uX0NA==
X-Google-Smtp-Source: APXvYqwxeVBDhkV/HdCDAy5+ejwZaPxvvRCHf7VHqhekwWpzmirEKdHBSNhi18b8MGl3L3DtRLFs+g==
X-Received: by 2002:a17:902:7b95:: with SMTP id w21mr1139908pll.322.1570593061698;
        Tue, 08 Oct 2019 20:51:01 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id y7sm562206pfn.142.2019.10.08.20.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 20:51:00 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, michael.scheiderer@fau.de,
        fabian.krueger@fau.de, chandra627@gmail.com, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix alignment and style problems.
Date:   Tue,  8 Oct 2019 20:50:39 -0700
Message-Id: <1570593039-19059-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Fixed alignment and style issues raised by checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 49 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 3be33c4..a20f2d7 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -30,19 +30,27 @@
 #include "kpc.h"
 
 static struct mtd_partition p2kr0_spi0_parts[] = {
-	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_0",	.size = 7798784,	.offset = 0,},
+	{ .name = "SLOT_1",	.size = 7798784,	.offset =
+							 MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_2",	.size = 7798784,	.offset =
+							 MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_3",	.size = 7798784,	.offset =
+							 MTDPART_OFS_NXTBLK},
+	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset =
+							 MTDPART_OFS_NXTBLK},
 };
 
 static struct mtd_partition p2kr0_spi1_parts[] = {
-	{ .name = "SLOT_4",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_5",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_6",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_7",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_4",	.size = 7798784,	.offset = 0,},
+	{ .name = "SLOT_5",	.size = 7798784,	.offset =
+							   MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_6",	.size = 7798784,	.offset =
+							   MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_7",	.size = 7798784,	.offset =
+							   MTDPART_OFS_NXTBLK},
+	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset =
+							   MTDPART_OFS_NXTBLK},
 };
 
 static struct flash_platform_data p2kr0_spi0_pdata = {
@@ -50,6 +58,7 @@ static struct flash_platform_data p2kr0_spi0_pdata = {
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi0_parts),
 	.parts =	p2kr0_spi0_parts,
 };
+
 static struct flash_platform_data p2kr0_spi1_pdata = {
 	.name =		"SPI1",
 	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
@@ -165,7 +174,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	u64 val;
 
 	addr += idx;
-	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0))
+	if (idx == KP_SPI_REG_CONFIG && cs->conf_cache >= 0)
 		return cs->conf_cache;
 
 	val = readq(addr);
@@ -227,8 +236,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
@@ -315,19 +323,18 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		if (transfer->speed_hz > KP_SPI_CLK ||
 		    (len && !(rx_buf || tx_buf))) {
 			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
-					transfer->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					transfer->bits_per_word);
+				transfer->speed_hz,
+				len,
+				tx_buf ? "tx" : "",
+				rx_buf ? "rx" : "",
+				transfer->bits_per_word);
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
 		if (transfer->speed_hz &&
 		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
-					transfer->speed_hz,
-					KP_SPI_CLK >> 15);
+				transfer->speed_hz, KP_SPI_CLK >> 15);
 			dev_dbg(kpspi->dev, "  speed_hz -EINVAL\n");
 			return -EINVAL;
 		}
@@ -478,7 +485,7 @@ kp_spi_probe(struct platform_device *pldev)
 	/* register the slave boards */
 #define NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(table) \
 	for (i = 0 ; i < ARRAY_SIZE(table) ; i++) { \
-		spi_new_device(master, &(table[i])); \
+		spi_new_device(master, &table[i]); \
 	}
 
 	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
-- 
2.7.4

