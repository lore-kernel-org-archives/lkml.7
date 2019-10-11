Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B34C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD14B214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja7WMJKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfJKFwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:52:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39563 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKFwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:52:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so5401441pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dqoYfCwSTXnrPu65kXilGlo/9dFlyTd0Onso9PljAiY=;
        b=ja7WMJKGVFeDsPWZbD3eP1exBEeovUc3M+srrumG9lw3FwxPytgJHMp2h+5wPHfp4P
         SdmJLxFcems22RCyDedMqYYNd9v9pGiObyicT27agrzJwjPRRGAjShWGQYXC9lpCLX41
         cXwHULtTCwFBrw788774u+HOOhU9GgLQgD/Nkei0T5fXFT41E2m28WF2i6933wTeE87R
         7Y/fskU+WTmOITSiHW2DGdQArGwT4p9dPsA7f01SKq+dqTmH+C2+vqPM3fq3957cdWaa
         w2IS4QTGqQd3x2vKDaPLGZrLSRGMm9bGoWY5u4yLOl1UgZG/pjqjyFvU8NQTQWtx+0PB
         PFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dqoYfCwSTXnrPu65kXilGlo/9dFlyTd0Onso9PljAiY=;
        b=Fy68Z3zu3Levxj9N9bAmC9sQu8oGKNoOZggELZCOkS/OOjyMqnJIObJyab83GRGtHm
         Lr++UEINbLMhFaUKfUk3FRx/x+7uFC3CraKR2bG0Nk3ikUgNYFO0Xn6n2Re0YoKjv1KH
         4wK21zUJZpKboCcx1ZIpOG9Ly5Ysayn2t45O8CZUXnrF3UuqRLMWsjmm+4CvYSD3LR92
         P4VEvoTXp4q/GZfwrXsUIOUM8YSq/k0wyWnIUuh3AnFVTrtOuKcrcyp0T52BnWOYQ+na
         MLaasr/LMDX6pr5ueZNdl3jNlEolSXnqGfzuYw1Yhh1p8qfBveIhyil6WmDLRAZsgAgk
         Ky6Q==
X-Gm-Message-State: APjAAAVmv1GxZ0B9bmIM+WSvDUEsAjJP1kj0dcvdF+EwgoBpN7xh20kb
        VEevb0zhFcwGu05LWOjmGho=
X-Google-Smtp-Source: APXvYqx8srCZR27sA18/99NHofX5apHWWzDqgtZO8ISutoswAwDwdHzSweW0oDlcLt0TqEls65/gcA==
X-Received: by 2002:a63:f44e:: with SMTP id p14mr14548314pgk.2.1570773124323;
        Thu, 10 Oct 2019 22:52:04 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id i184sm10257782pge.5.2019.10.10.22.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:52:03 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, michael.scheiderer@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] KPC2000: kpc2000_spi.c: Fix style issues (line length)
Date:   Thu, 10 Oct 2019 22:51:51 -0700
Message-Id: <20191011055155.4985-1-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 3be33c450cab..81d79b116ce0 100644
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
+	{ .name = "SLOT_0",  .size = 7798784,  .offset = 0,                },
+	{ .name = "SLOT_1",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_2",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "SLOT_3",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
+	{ .name = "CS0_EXTRA",  .size = MTDPART_SIZ_FULL,  .offset = MTDPART_OFS_NXTBLK},
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
+	{ .name = "CS1_EXTRA",  .size = MTDPART_SIZ_FULL,  .offset = MTDPART_OFS_NXTBLK},
 };
 
 static struct flash_platform_data p2kr0_spi0_pdata = {
-- 
2.20.1

