Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F0C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7573F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAOn5Shr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfIQPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:53:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43871 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbfIQPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:53:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so4044727lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=2YOj06cPPvgsZx9maFNFvfyY5twtTMJtLzahT6UKWkM=;
        b=kAOn5ShrNvK4JRjqibsxIgC3tnVF3yLFi1pJnhx52obG35TjwggxRBvh7USQv2jDlh
         SaXa5YI0QDhVDM0XOtk2uIbz6dnWhZwPCnKx7aj/1dv5EwEEJhm24G5CSugX93SklLME
         6ClLDZZvexTAhqhrhsnupobLStLlEZEIn0lVbIjpFCQ+VTRgmAS1lf0XFPM2tscrZIWi
         MUPhhPUnjkeAkQEzIvs8qXv9f+zwOWPRxKva89MthTxTIRNnnQvcXmOSlh0xq9pm+ysI
         wVLuqnzz39t3+DrPVleBmISEaUxgBdqhprHTOH9K/NQ+ozoqAHxtEJQnXnZIMvvLDbEd
         Ye2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=2YOj06cPPvgsZx9maFNFvfyY5twtTMJtLzahT6UKWkM=;
        b=A1ll4QaY/joLrRWvsJuW03bj0KBkBB8RCl1aM8DryRN23efkjpCMJjqE/S0n0X7m9D
         /+g0rQuoh7BYTHoduOO1YB0tuZzK6r3LjV6l/49PsBXkab3SJQ1LYP2MmXvuK41/EroT
         MDlnutG8rSwaOR6XoLla+zHmj4vLzQoZjJ8S9xn/BjNcv1pv+fqOsfxkZdNec+3Ic99d
         TPMJgOXruhw6TpF4VxhJ5VraPV5UQuW0VEZJITl4WnMq/djngiP58A6mwYRA+dzNaDw+
         S1E6obbOIA5dd7P72hILJ3qojTinC/BEVCa4g1TDEMw//KDtwKpZ8U/DRKgEAtOOkr/Q
         NsUA==
X-Gm-Message-State: APjAAAWwQnpdRbfej0ntSS4uBQPk4anz5wNBn9OtSfHLJebKSaMtFUty
        +ZET4qNIZCRFmQow6f0XbHc=
X-Google-Smtp-Source: APXvYqxInzgwwA/H7snjGtaKT2ZKQl55koT6+1i82eeg1Fid52kHKD8WfWEvLiVsSbaoNPgPXI6hVA==
X-Received: by 2002:a2e:9d0d:: with SMTP id t13mr2297429lji.169.1568735634420;
        Tue, 17 Sep 2019 08:53:54 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X ([188.150.241.161])
        by smtp.gmail.com with ESMTPSA id x76sm604083ljb.81.2019.09.17.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 08:53:53 -0700 (PDT)
Date:   Tue, 17 Sep 2019 18:53:52 +0300
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Vlastimil Babka <vbabka@suse.cz>, markus.linnala@gmail.com
Subject: [PATCH] z3fold: fix memory leak in kmem cache
Message-Id: <20190917185352.44cf285d3ebd9e64548de5de@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a leak in init_z3fold_page() -- it allocates
handles from kmem cache even for headless pages, but then they are
never used and never freed, so eventually kmem cache may get
exhausted. This patch provides a fix for that.

Reported-by: Markus Linnala <markus.linnala@gmail.com>
Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 mm/z3fold.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 6397725b5ec6..7dffef2599c3 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -301,14 +301,11 @@ static void z3fold_unregister_migration(struct z3fold_pool *pool)
  }
 
 /* Initializes the z3fold header of a newly allocated z3fold page */
-static struct z3fold_header *init_z3fold_page(struct page *page,
+static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 					struct z3fold_pool *pool, gfp_t gfp)
 {
 	struct z3fold_header *zhdr = page_address(page);
-	struct z3fold_buddy_slots *slots = alloc_slots(pool, gfp);
-
-	if (!slots)
-		return NULL;
+	struct z3fold_buddy_slots *slots;
 
 	INIT_LIST_HEAD(&page->lru);
 	clear_bit(PAGE_HEADLESS, &page->private);
@@ -316,6 +313,12 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
 	clear_bit(PAGE_CLAIMED, &page->private);
+	if (headless)
+		return zhdr;
+
+	slots = alloc_slots(pool, gfp);
+	if (!slots)
+		return NULL;
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -962,7 +965,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	if (!page)
 		return -ENOMEM;
 
-	zhdr = init_z3fold_page(page, pool, gfp);
+	zhdr = init_z3fold_page(page, bud == HEADLESS, pool, gfp);
 	if (!zhdr) {
 		__free_page(page);
 		return -ENOMEM;
-- 
2.17.1
