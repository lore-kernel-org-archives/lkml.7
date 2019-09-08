Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCB6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDBF2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyu4RvO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfIHN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:29:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40444 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfIHN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:29:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id u29so8417252lfk.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=6lNXgAQlloBq09t2/nK3LNBQyxX4oXqE9HyFRNm1KeM=;
        b=Uyu4RvO3HcBMCXKz0RS8L195kWZJOD/9/pJe+i/xTsg5S1rub7udK/ONYVX5qSAzqf
         2tL9UO1h3yEZoSgjWfXL9Bq/UyVU8+UdUzY6J2dO53fWGCfxBJvU8d8a6KsnIu3k9BVn
         8PB0Y7lkoJHzQki7nCeiXqvWv4OS67mrP5dLYXVSRKSY3NM4RcVzeOBfQE5wfh4Snrgd
         mB0ftKcpxbZqHGTsS5K9sUbGH+j97epiGwo4/bx1xaFsuAEDf32w9s7RxYhHGTkuG9kO
         HA0/mWgx2pWh+4FfRLGPBPg8I++wAh6Xs2qPuE7vDeaPnLq2Os07I3vp2SCM8+MfEBE1
         fRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=6lNXgAQlloBq09t2/nK3LNBQyxX4oXqE9HyFRNm1KeM=;
        b=tyisBXlHEJ1cyqv3B7zOFNBap/B0ZxvsZnlmob8UuZ32jvnXxIHD4ifuMAKPg0V2Aw
         5W4LNRZP9hXyDqRbKbN5yr2TwR2PBPc4FGV5s+lyoGky/9L1MCuSwiP8SzM8wz0WCH0d
         tkSioKvC4SixsgL9BzI4nOhI433cxJvdH6uzdP3iRnpSEQvv8f2Vl6QzD8Kq7wuiIwxr
         aSxH5pvD8oiDOR7hF21vLBH8snBnQ/xgrzqeMNyLXmXwUY/nPx0nFMALj6FMCfqX6Hz0
         pXswr9CmB27Kz048WRjsWJDxrvKT0IO9XVOpxiyfA4BnOEK4aOPovIMmQYJ7hTmrY3TJ
         f2Fw==
X-Gm-Message-State: APjAAAVKx3kJgbPBEyR9opxSltm4AHR39zBGBYMdUHqOBdTCXJBBa3Ad
        c1ZzD6+RP6Dn9AUPpQk0e1iAXiZ4hecX6w==
X-Google-Smtp-Source: APXvYqyv7JixNnh6ak2mB2bq8QbwSZeIPaeUEBuxCVso1mLbR+kOcbhHUcvqtn1NmuqA6ZfvOh3oNw==
X-Received: by 2002:ac2:5206:: with SMTP id a6mr12786584lfl.96.1567949368254;
        Sun, 08 Sep 2019 06:29:28 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X (c90-142-47-185.bredband.comhem.se. [90.142.47.185])
        by smtp.gmail.com with ESMTPSA id h3sm1981042ljg.40.2019.09.08.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 06:29:27 -0700 (PDT)
Date:   Sun, 8 Sep 2019 16:29:19 +0300
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>,
        Dan Streetman <ddstreet@ieee.org>,
        Vlastimil Babka <vbabka@suse.cz>, markus.linnala@gmail.com
Subject: [PATCH] z3fold: fix retry mechanism in page reclaim
Message-Id: <20190908162919.830388dc7404d1e2c80f4095@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

z3fold_page_reclaim()'s retry mechanism is broken: on a second
iteration it will have zhdr from the first one so that zhdr
is no longer in line with struct page. That leads to crashes when
the system is stressed.

Fix that by moving zhdr assignment up.

While at it, protect against using already freed handles by using
own local slots structure in z3fold_page_reclaim().

Reported-by: Markus Linnala <markus.linnala@gmail.com>
Reported-by: Chris Murphy <bugzilla@colorremedies.com>
Reported-by: Agustin Dall'Alba <agustin@dallalba.com.ar>
Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 mm/z3fold.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 75b7962439ff..6397725b5ec6 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -372,9 +372,10 @@ static inline int __idx(struct z3fold_header *zhdr, enum buddy bud)
  * Encodes the handle of a particular buddy within a z3fold page
  * Pool lock should be held as this function accesses first_num
  */
-static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
+static unsigned long __encode_handle(struct z3fold_header *zhdr,
+				struct z3fold_buddy_slots *slots,
+				enum buddy bud)
 {
-	struct z3fold_buddy_slots *slots;
 	unsigned long h = (unsigned long)zhdr;
 	int idx = 0;
 
@@ -391,11 +392,15 @@ static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
 	if (bud == LAST)
 		h |= (zhdr->last_chunks << BUDDY_SHIFT);
 
-	slots = zhdr->slots;
 	slots->slot[idx] = h;
 	return (unsigned long)&slots->slot[idx];
 }
 
+static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
+{
+	return __encode_handle(zhdr, zhdr->slots, bud);
+}
+
 /* Returns the z3fold page where a given handle is stored */
 static inline struct z3fold_header *handle_to_z3fold_header(unsigned long h)
 {
@@ -630,6 +635,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	}
 
 	if (unlikely(PageIsolated(page) ||
+		     test_bit(PAGE_CLAIMED, &page->private) ||
 		     test_bit(PAGE_STALE, &page->private))) {
 		z3fold_page_unlock(zhdr);
 		return;
@@ -1132,6 +1138,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 	struct z3fold_header *zhdr = NULL;
 	struct page *page = NULL;
 	struct list_head *pos;
+	struct z3fold_buddy_slots slots;
 	unsigned long first_handle = 0, middle_handle = 0, last_handle = 0;
 
 	spin_lock(&pool->lock);
@@ -1150,16 +1157,22 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			/* this bit could have been set by free, in which case
 			 * we pass over to the next page in the pool.
 			 */
-			if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+			if (test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+				page = NULL;
 				continue;
+			}
 
-			if (unlikely(PageIsolated(page)))
+			if (unlikely(PageIsolated(page))) {
+				clear_bit(PAGE_CLAIMED, &page->private);
+				page = NULL;
 				continue;
+			}
+			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
 				break;
 
-			zhdr = page_address(page);
 			if (!z3fold_page_trylock(zhdr)) {
+				clear_bit(PAGE_CLAIMED, &page->private);
 				zhdr = NULL;
 				continue; /* can't evict at this point */
 			}
@@ -1177,26 +1190,30 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 
 		if (!test_bit(PAGE_HEADLESS, &page->private)) {
 			/*
-			 * We need encode the handles before unlocking, since
-			 * we can race with free that will set
-			 * (first|last)_chunks to 0
+			 * We need encode the handles before unlocking, and
+			 * use our local slots structure because z3fold_free
+			 * can zero out zhdr->slots and we can't do much
+			 * about that
 			 */
 			first_handle = 0;
 			last_handle = 0;
 			middle_handle = 0;
 			if (zhdr->first_chunks)
-				first_handle = encode_handle(zhdr, FIRST);
+				first_handle = __encode_handle(zhdr, &slots,
+								FIRST);
 			if (zhdr->middle_chunks)
-				middle_handle = encode_handle(zhdr, MIDDLE);
+				middle_handle = __encode_handle(zhdr, &slots,
+								MIDDLE);
 			if (zhdr->last_chunks)
-				last_handle = encode_handle(zhdr, LAST);
+				last_handle = __encode_handle(zhdr, &slots,
+								LAST);
 			/*
 			 * it's safe to unlock here because we hold a
 			 * reference to this page
 			 */
 			z3fold_page_unlock(zhdr);
 		} else {
-			first_handle = encode_handle(zhdr, HEADLESS);
+			first_handle = __encode_handle(zhdr, &slots, HEADLESS);
 			last_handle = middle_handle = 0;
 		}
 
@@ -1226,9 +1243,9 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			spin_lock(&pool->lock);
 			list_add(&page->lru, &pool->lru);
 			spin_unlock(&pool->lock);
+			clear_bit(PAGE_CLAIMED, &page->private);
 		} else {
 			z3fold_page_lock(zhdr);
-			clear_bit(PAGE_CLAIMED, &page->private);
 			if (kref_put(&zhdr->refcount,
 					release_z3fold_page_locked)) {
 				atomic64_dec(&pool->pages_nr);
@@ -1243,6 +1260,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			list_add(&page->lru, &pool->lru);
 			spin_unlock(&pool->lock);
 			z3fold_page_unlock(zhdr);
+			clear_bit(PAGE_CLAIMED, &page->private);
 		}
 
 		/* We started off locked to we need to lock the pool back */
@@ -1369,7 +1387,8 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
-	if (test_bit(PAGE_HEADLESS, &page->private))
+	if (test_bit(PAGE_HEADLESS, &page->private) ||
+	    test_bit(PAGE_CLAIMED, &page->private))
 		return false;
 
 	zhdr = page_address(page);
-- 
2.20.1
