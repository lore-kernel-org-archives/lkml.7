Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3262C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9212921850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN6hgXSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfDKPer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:34:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42647 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:34:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so7927019wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H8CKRiQBJrU9wnvoQVT3UbKuoETyr+5Jz1SZnQKUh/k=;
        b=ZN6hgXSCtlTPbMmvp/ojwcsYK2THTdLfGjYX2Bap1YoEHgNJ1uDyGtUkwzWrt5kSrG
         o3YCoLy4wwkDIsWuLlkZmKuVvniTOghG3qHYy7zm/3F+6fBgYmeS6wxKRpKRlbF8bEQL
         6IdNbXP5yIoJkQi9rozhLFTOOQulS2wgq9LJLe7okPzxgOfBTMLs/8kv3UCgr+5V9gZK
         QaGABA2/c/0TcjGkhPp8KHxECaaUYl0YMcaC44T5NnNbxHIg7zjCC5N9VDQCqFV9FtIf
         KdsHmp9BhSnSlhvZdq5FyCl4C9HWDUo7VV2a2zI5huVnxvqFDSLr/H46KmO5/xPEYCdr
         Psbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H8CKRiQBJrU9wnvoQVT3UbKuoETyr+5Jz1SZnQKUh/k=;
        b=qqnzOXWGtuPcrF6LIzu33x2oX4kiHkVdRLCmLwh7bgAbecAQguLG45M8NTasKmt8k9
         +gSTulqMi4GeA1eCTkcBDTVXuj9SV2XpQm+EQCtSicA5+VwLr4McxaLrsc2D74JDhep4
         CF/XRHyzZul2P0qBDE5gik2k+mWfVYA2MNc7m1jA4CbpJcn0JgFHkam9suTG46o5iCNg
         aUBn8xEgF58ebPrwSjSM6Yr0TxTYfny1ATNgv+rlvtsNJYck7++SzXEgAS1n2OgQCo6Z
         FZme+NyAAG5KwHGDEr6ysnHuwxRFjYJ87XyOH+dht5ZTAjyJIL0eqMdp6mnqj0I4YRDI
         cCaQ==
X-Gm-Message-State: APjAAAUjgtA3wuOEjLQ3mPlUT67Icg2J0xek/F59B2SYggp6HOORheKX
        7e2DtHfWOq/SeUdoyPyPWY4=
X-Google-Smtp-Source: APXvYqwP0+fI2vXpZJYCfbxU5ppVWn4tyWRPpJ4O101dUJBwc0UoRitGEoY1DegOuYY13O2b/Ri8Vw==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr10845698wrl.175.1554996882485;
        Thu, 11 Apr 2019 08:34:42 -0700 (PDT)
Received: from ?IPv6:::1? (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id f11sm50072974wrm.30.2019.04.11.08.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:34:41 -0700 (PDT)
Subject: [PATCH 1/4] z3fold: introduce helper functions
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com, Dan Streetman <ddstreet@ieee.org>
References: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
Message-ID: <0d1e978b-1701-9d46-de86-cc6b7d8934f0@gmail.com>
Date:   Thu, 11 Apr 2019 17:34:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a separate helper function for object
allocation, as well as 2 smaller helpers to add a buddy to the list
and to get a pointer to the pool from the z3fold header. No
functional changes here.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
  mm/z3fold.c | 184 ++++++++++++++++++++++++++++------------------------
  1 file changed, 100 insertions(+), 84 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index aee9b0b8d907..7a59875d880c 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -255,10 +255,15 @@ static enum buddy handle_to_buddy(unsigned long handle)
  	return (handle - zhdr->first_num) & BUDDY_MASK;
  }
  
+static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *zhdr)
+{
+	return zhdr->pool;
+}
+
  static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
  {
  	struct page *page = virt_to_page(zhdr);
-	struct z3fold_pool *pool = zhdr->pool;
+	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
  
  	WARN_ON(!list_empty(&zhdr->buddy));
  	set_bit(PAGE_STALE, &page->private);
@@ -295,9 +300,10 @@ static void release_z3fold_page_locked_list(struct kref *ref)
  {
  	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
  					       refcount);
-	spin_lock(&zhdr->pool->lock);
+	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
+	spin_lock(&pool->lock);
  	list_del_init(&zhdr->buddy);
-	spin_unlock(&zhdr->pool->lock);
+	spin_unlock(&pool->lock);
  
  	WARN_ON(z3fold_page_trylock(zhdr));
  	__release_z3fold_page(zhdr, true);
@@ -349,6 +355,23 @@ static int num_free_chunks(struct z3fold_header *zhdr)
  	return nfree;
  }
  
+/* Add to the appropriate unbuddied list */
+static inline void add_to_unbuddied(struct z3fold_pool *pool,
+				struct z3fold_header *zhdr)
+{
+	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
+			zhdr->middle_chunks == 0) {
+		struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
+
+		int freechunks = num_free_chunks(zhdr);
+		spin_lock(&pool->lock);
+		list_add(&zhdr->buddy, &unbuddied[freechunks]);
+		spin_unlock(&pool->lock);
+		zhdr->cpu = smp_processor_id();
+		put_cpu_ptr(pool->unbuddied);
+	}
+}
+
  static inline void *mchunk_memmove(struct z3fold_header *zhdr,
  				unsigned short dst_chunk)
  {
@@ -406,10 +429,8 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
  
  static void do_compact_page(struct z3fold_header *zhdr, bool locked)
  {
-	struct z3fold_pool *pool = zhdr->pool;
+	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
  	struct page *page;
-	struct list_head *unbuddied;
-	int fchunks;
  
  	page = virt_to_page(zhdr);
  	if (locked)
@@ -430,18 +451,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
  	}
  
  	z3fold_compact_page(zhdr);
-	unbuddied = get_cpu_ptr(pool->unbuddied);
-	fchunks = num_free_chunks(zhdr);
-	if (fchunks < NCHUNKS &&
-	    (!zhdr->first_chunks || !zhdr->middle_chunks ||
-			!zhdr->last_chunks)) {
-		/* the page's not completely free and it's unbuddied */
-		spin_lock(&pool->lock);
-		list_add(&zhdr->buddy, &unbuddied[fchunks]);
-		spin_unlock(&pool->lock);
-		zhdr->cpu = smp_processor_id();
-	}
-	put_cpu_ptr(pool->unbuddied);
+	add_to_unbuddied(pool, zhdr);
  	z3fold_page_unlock(zhdr);
  }
  
@@ -453,6 +463,67 @@ static void compact_page_work(struct work_struct *w)
  	do_compact_page(zhdr, false);
  }
  
+/* returns _locked_ z3fold page header or NULL */
+static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
+						size_t size, bool can_sleep)
+{
+	struct z3fold_header *zhdr = NULL;
+	struct page *page;
+	struct list_head *unbuddied;
+	int chunks = size_to_chunks(size), i;
+
+lookup:
+	/* First, try to find an unbuddied z3fold page. */
+	unbuddied = get_cpu_ptr(pool->unbuddied);
+	for_each_unbuddied_list(i, chunks) {
+		struct list_head *l = &unbuddied[i];
+
+		zhdr = list_first_entry_or_null(READ_ONCE(l),
+					struct z3fold_header, buddy);
+
+		if (!zhdr)
+			continue;
+
+		/* Re-check under lock. */
+		spin_lock(&pool->lock);
+		l = &unbuddied[i];
+		if (unlikely(zhdr != list_first_entry(READ_ONCE(l),
+						struct z3fold_header, buddy)) ||
+		    !z3fold_page_trylock(zhdr)) {
+			spin_unlock(&pool->lock);
+			zhdr = NULL;
+			put_cpu_ptr(pool->unbuddied);
+			if (can_sleep)
+				cond_resched();
+			goto lookup;
+		}
+		list_del_init(&zhdr->buddy);
+		zhdr->cpu = -1;
+		spin_unlock(&pool->lock);
+
+		page = virt_to_page(zhdr);
+		if (test_bit(NEEDS_COMPACTING, &page->private)) {
+			z3fold_page_unlock(zhdr);
+			zhdr = NULL;
+			put_cpu_ptr(pool->unbuddied);
+			if (can_sleep)
+				cond_resched();
+			goto lookup;
+		}
+
+		/*
+		 * this page could not be removed from its unbuddied
+		 * list while pool lock was held, and then we've taken
+		 * page lock so kref_put could not be called before
+		 * we got here, so it's safe to just call kref_get()
+		 */
+		kref_get(&zhdr->refcount);
+		break;
+	}
+	put_cpu_ptr(pool->unbuddied);
+
+	return zhdr;
+}
  
  /*
   * API Functions
@@ -546,7 +617,7 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
  static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  			unsigned long *handle)
  {
-	int chunks = 0, i, freechunks;
+	int chunks = size_to_chunks(size);
  	struct z3fold_header *zhdr = NULL;
  	struct page *page = NULL;
  	enum buddy bud;
@@ -561,56 +632,8 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  	if (size > PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE)
  		bud = HEADLESS;
  	else {
-		struct list_head *unbuddied;
-		chunks = size_to_chunks(size);
-
-lookup:
-		/* First, try to find an unbuddied z3fold page. */
-		unbuddied = get_cpu_ptr(pool->unbuddied);
-		for_each_unbuddied_list(i, chunks) {
-			struct list_head *l = &unbuddied[i];
-
-			zhdr = list_first_entry_or_null(READ_ONCE(l),
-						struct z3fold_header, buddy);
-
-			if (!zhdr)
-				continue;
-
-			/* Re-check under lock. */
-			spin_lock(&pool->lock);
-			l = &unbuddied[i];
-			if (unlikely(zhdr != list_first_entry(READ_ONCE(l),
-					struct z3fold_header, buddy)) ||
-			    !z3fold_page_trylock(zhdr)) {
-				spin_unlock(&pool->lock);
-				put_cpu_ptr(pool->unbuddied);
-				goto lookup;
-			}
-			list_del_init(&zhdr->buddy);
-			zhdr->cpu = -1;
-			spin_unlock(&pool->lock);
-
-			page = virt_to_page(zhdr);
-			if (test_bit(NEEDS_COMPACTING, &page->private)) {
-				z3fold_page_unlock(zhdr);
-				zhdr = NULL;
-				put_cpu_ptr(pool->unbuddied);
-				if (can_sleep)
-					cond_resched();
-				goto lookup;
-			}
-
-			/*
-			 * this page could not be removed from its unbuddied
-			 * list while pool lock was held, and then we've taken
-			 * page lock so kref_put could not be called before
-			 * we got here, so it's safe to just call kref_get()
-			 */
-			kref_get(&zhdr->refcount);
-			break;
-		}
-		put_cpu_ptr(pool->unbuddied);
-
+retry:
+		zhdr = __z3fold_alloc(pool, size, can_sleep);
  		if (zhdr) {
  			if (zhdr->first_chunks == 0) {
  				if (zhdr->middle_chunks != 0 &&
@@ -630,8 +653,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  					z3fold_page_unlock(zhdr);
  				pr_err("No free chunks in unbuddied\n");
  				WARN_ON(1);
-				goto lookup;
+				goto retry;
  			}
+			page = virt_to_page(zhdr);
  			goto found;
  		}
  		bud = FIRST;
@@ -662,8 +686,12 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  	if (!page)
  		return -ENOMEM;
  
-	atomic64_inc(&pool->pages_nr);
  	zhdr = init_z3fold_page(page, pool);
+	if (!zhdr) {
+		__free_page(page);
+		return -ENOMEM;
+	}
+	atomic64_inc(&pool->pages_nr);
  
  	if (bud == HEADLESS) {
  		set_bit(PAGE_HEADLESS, &page->private);
@@ -680,19 +708,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  		zhdr->middle_chunks = chunks;
  		zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
  	}
-
-	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
-			zhdr->middle_chunks == 0) {
-		struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
-
-		/* Add to unbuddied list */
-		freechunks = num_free_chunks(zhdr);
-		spin_lock(&pool->lock);
-		list_add(&zhdr->buddy, &unbuddied[freechunks]);
-		spin_unlock(&pool->lock);
-		zhdr->cpu = smp_processor_id();
-		put_cpu_ptr(pool->unbuddied);
-	}
+	add_to_unbuddied(pool, zhdr);
  
  headless:
  	spin_lock(&pool->lock);
-- 
2.17.1

