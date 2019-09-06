Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE6CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AE62070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR42GsoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393561AbfIFTtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:49:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33738 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393498AbfIFTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:49:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so5232731pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mU1+WGtGI6s1SQGf+HUbugB7ywPYgCVVN6kyBzTaNcA=;
        b=rR42GsoQTXfsBGioVnUnyXrolTnujYH0VV3GlvCX7f+eVRQOY4iR4Jl+A6T+JGK6Uk
         JhVPirT10DmB2aIVqgd4ufROGVgCU8UmCaouhJLZWmSkSJ2scDGTwV76+FP7Edb0zl3m
         EjtKQp3GCokxIGWgxsemLvZS7youH/HsBTsxTfjEei6lQXPSs48cXywXSvUhFW6i2a/h
         hPrEbkaapa19w8ts7Y5h34/COYBufEfcxHs7sxStF+YBs/HNE+dQTMfCodr6eRHu+eOU
         htdA0pHyEdY+AGo8rb8rs7WmyBfdJYCIjmIarIXCLCreuFoEdum2dXLGlhZQYqKQCT4A
         D2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mU1+WGtGI6s1SQGf+HUbugB7ywPYgCVVN6kyBzTaNcA=;
        b=ojuE7Yk8QdrsnlvwwK04A2Um6x4bxavgyJYHA52bVLQ3WhcvQ4cNxqlR0+cEkmruSq
         8Lxh4YOes7Nab4S5fP3Nl9AtuLeF1nF/i/j1OOWe9BG0w98qxE5/o3Yc5rCNFxY7qOiF
         Cv1P1Q51BFkfFHMyQz/uv1UhGxBgxAg1qoDGtBJwZfSn+d4oqiXbG+m4iQwqPjjcDTv6
         ANkvBN/5moAyxOqD0JFn00TMfiApeNV9jQN28e+xC+yoFAqxzDYNZ+C1XmeM1UATKIld
         bwINu0lFR13p7rNaEKsFhtzq6K73kyAqd39ilRxQ7NJdyStFKfEjD8BucwlOK0FIXWv+
         u+rw==
X-Gm-Message-State: APjAAAUkbrI296e4HEONZQx22k1uNHwv0rjCmWjq+t+du5c4xX7Xd7Qj
        H+n4WvCz+GcLaMoth4Gvxow=
X-Google-Smtp-Source: APXvYqxso7WabPx8hLIH7RQGLkKtxnqxDs90vXPzVkIPXtY/aopJL+vzjpb6PG1mpQ04vofmb+UVqw==
X-Received: by 2002:aa7:8a86:: with SMTP id a6mr12830850pfc.76.1567799359949;
        Fri, 06 Sep 2019 12:49:19 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c127sm9830119pfb.5.2019.09.06.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 12:49:19 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     kdasu.kdev@gmail.com
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: rawnand: use bounce buffer when vmalloced data buf detected
Date:   Fri,  6 Sep 2019 15:47:16 -0400
Message-Id: <20190906194719.15761-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906194719.15761-1-kdasu.kdev@gmail.com>
References: <20190906194719.15761-1-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For controller drivers that use DMA and set NAND_USE_BOUNCE_BUFFER
option use data buffers that are not vmalloced, aligned and have
valid virtual address to be able to do DMA transfers. This change
adds additional check and makes use of data buffer allocated
in nand_base driver when it is passed a vmalloced data buffer for
DMA transfers.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/nand_base.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 91f046d4d452..46f6965a896a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -45,6 +45,12 @@
 
 #include "internals.h"
 
+static int nand_need_bounce_buf(const void *buf, struct nand_chip *chip)
+{
+	return !virt_addr_valid(buf) || is_vmalloc_addr(buf) ||
+		!IS_ALIGNED((unsigned long)buf, chip->buf_align);
+}
+
 /* Define default oob placement schemes for large and small page devices */
 static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
 				 struct mtd_oob_region *oobregion)
@@ -3183,9 +3189,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 		if (!aligned)
 			use_bufpoi = 1;
 		else if (chip->options & NAND_USE_BOUNCE_BUFFER)
-			use_bufpoi = !virt_addr_valid(buf) ||
-				     !IS_ALIGNED((unsigned long)buf,
-						 chip->buf_align);
+			use_bufpoi = nand_need_bounce_buf(buf, chip);
 		else
 			use_bufpoi = 0;
 
@@ -4009,9 +4013,7 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
 		if (part_pagewr)
 			use_bufpoi = 1;
 		else if (chip->options & NAND_USE_BOUNCE_BUFFER)
-			use_bufpoi = !virt_addr_valid(buf) ||
-				     !IS_ALIGNED((unsigned long)buf,
-						 chip->buf_align);
+			use_bufpoi = nand_need_bounce_buf(buf, chip);
 		else
 			use_bufpoi = 0;
 
-- 
2.17.1

