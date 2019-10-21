Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8122205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vESnDQab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfJUTeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:34:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39914 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUTeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:34:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id c6so3100832wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5WndJUXXgXPHwhCLRr7+0pwnLZl+9kPbswD/C+BOyJg=;
        b=vESnDQabBipv8xjPoc+wa2ekTjGtmzxFa4h6bCF3qeMKKFfZeqXR4+nvEHRA0fFcSR
         IJQUqHM4+kKmbaxbkL91blNgMn7VdxdRCJPaslroCFq6gdNvHasjYj9xlJFRlmmQcMSD
         +aerwVR89midy5FIYroHDoufpZsTi+pJ95BB2dMJidfzs5ZhJllBhkHii6DT1C5X3hxD
         bb0JfJwsvxLjTJfxbF2uYUCH73ZyON4IokveiL1tCoGjLTabJDxX3/DxYpKfB7DVyjBM
         IYDhULdiPp2gnyz54wgU6nbdHUPcMqmvC8r8LCTX/die87VBjodMjERvyZ9MKOYWFlTg
         pJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5WndJUXXgXPHwhCLRr7+0pwnLZl+9kPbswD/C+BOyJg=;
        b=F7cbbPcriyySbF6stpdbby3bP5tX5gdiNBEbpBnXomKa1bLFNUiaJhoPFsewpno2xZ
         IqPJeyGRZB56iEwpqvgH8zgOFo15V+3Tz/QHa0sM8I/sZ6cIRZ/DDE0OUsSYzgB+quLr
         iDrOmFvxSDDzQsPnDpHQG9hltTpfjqoP5wPgpR5GWIq9iZzuwZfoPtNPIZpJTi/i/9Tu
         fiwz8wfd3eJJXBLYtE0nleI/af3/n5fz1CsPIkYyaW8Ho0Sy8PGKCW9fu9Eioanwbks6
         J/KCf74lDyBKFPXt/A0JdMIjrfmD7aboaqZhXO+yN65JC39HaNykqZBWfvMy51cxnLsv
         WpNg==
X-Gm-Message-State: APjAAAUr5aWQl3F8oe61lRZTbyfcmMFoR9G1nyz8g0vsH/B6IF/5rFOQ
        pE7gs7H/Uw1BQNUajYR2QQM=
X-Google-Smtp-Source: APXvYqzS5vgQy/FpbUE4Fmk+Rt3w4YTqGQCYR/5WDy7njSYsMCPb0vmcAPYauVMXqpLPNZsg0LNACw==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr20608149wrx.124.1571686438805;
        Mon, 21 Oct 2019 12:33:58 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 79sm24394580wmb.7.2019.10.21.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:33:58 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mtd: set mtd partition panic write flag
Date:   Mon, 21 Oct 2019 15:32:52 -0400
Message-Id: <20191021193343.41320-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check mtd panic write flag and set the mtd partition panic
write flag so that low level drivers can use it to take
required action to ensure oops data gets written to assigned
mtd partition.

Fixes: 9f897bfdd8 ("mtd: Add flag to indicate panic_write")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/mtdpart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 7328c066c5ba..b4f6479abeda 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -159,6 +159,10 @@ static int part_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 		size_t *retlen, const u_char *buf)
 {
 	struct mtd_part *part = mtd_to_part(mtd);
+
+	if (mtd->oops_panic_write)
+		part->parent->oops_panic_write = true;
+
 	return part->parent->_panic_write(part->parent, to + part->offset, len,
 					  retlen, buf);
 }
-- 
2.17.1

