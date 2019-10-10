Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1270C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D30208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMfoNNo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfJJDJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:09:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39659 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfJJDJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:09:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so2932522pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Amx9YY+yziFlDI2hhYIbIlLCsPm7c25vcSV2f894tNQ=;
        b=SMfoNNo3c5r80CpNcKVMbXdH9ZW/ZHkwXp0WtL5H8WaHYQDyHzCQmSm8AQWH1gqYB3
         VD0QRl0GBE/RxX7YpOw4N4vIkMA1LErFS+IDTMDvALP0/y5/jbz+2S3yntmKhy4DHlQb
         I3djShrJHKd7rodpzFS44wrYhmHyH9r+TEQHYubQ6ODpV4DgqpRDRm73gM/kKYixbMOX
         /3cY8swUK9s4kT9aAxBlWaabn3BsZmTB7CY1993P/a6Qm8RdVyA9RfZKUFbPAuINhVjm
         IvSjGGupCnQhWgoaQH75/K0Bo6Jobn0meH4PAuEsFEe1zq3Ld1lFMbL8GPILAJ4ZVaQn
         s8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Amx9YY+yziFlDI2hhYIbIlLCsPm7c25vcSV2f894tNQ=;
        b=CpuXh7zuCIoivv07b4gJy3cVmAynQFjp/3H4uQoR74JFQBGqKYZjzZnkij/UC1KZGQ
         IhQD4NpxJ18kNx3O+mJGgVI8W5Sgm815o2CIbeIEik4B/8GZkFFfiNAWQ1QYK+p3zRR0
         47RZvBdou7I76zbypDNv8U9XgbSjeU4MzYr0PtpbsoRvs3rLs1wfYTybzreYZH7gVREc
         cM5yXmSFPAXnlAQME2hBDg5Ru9OakDLqeC0/jy3HnmP99vqwwwG7VrjgYUiD5Sm97H2/
         FUF6YzWygsyy9jhsY6lkRBL133NjwiYBJb6jUmRyroh/hbuSFm5JjSvLYX6St2TYvHoy
         N9IA==
X-Gm-Message-State: APjAAAW65wDzFfSh6L7TWROpn8p6t+AXnjqwhhDiybV8RNR7ABaHLxJt
        vZk5jwWbMU26DWivtogR05I=
X-Google-Smtp-Source: APXvYqyHB0ErhnpjJiDC1J7saY0Xw3qRmfj5fFr6YNfGkuUZxiXUIGVA+qxb/QT1/jku6bfzbCZd5w==
X-Received: by 2002:a17:90a:35a5:: with SMTP id r34mr7846455pjb.40.1570676949648;
        Wed, 09 Oct 2019 20:09:09 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id z23sm3385867pgu.16.2019.10.09.20.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 20:09:08 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, chandra627@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (line length)
Date:   Wed,  9 Oct 2019 20:08:57 -0700
Message-Id: <1570676937-3975-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resoved: "WARNING: line over 80 characters" from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 3be33c4..ef78b6d 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -30,19 +30,19 @@
 #include "kpc.h"
 
 static struct mtd_partition p2kr0_spi0_parts[] = {
-	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_0",  .size = 7798784,  .offset = 0,},
+	{ .name = "SLOT_1",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_2",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_3",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "CS0_EXTRA", .size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
 };
 
 static struct mtd_partition p2kr0_spi1_parts[] = {
-	{ .name = "SLOT_4",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_5",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_6",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_7",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_4",  .size = 7798784,  .offset = 0,},
+	{ .name = "SLOT_5",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_6",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_7",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "CS1_EXTRA",  .size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
 };
 
 static struct flash_platform_data p2kr0_spi0_pdata = {
-- 
2.7.4

