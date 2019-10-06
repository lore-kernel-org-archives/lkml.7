Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC5C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034F5218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="oqQgL003"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJFEPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 00:15:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38953 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJFEP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 00:15:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so11390603wrj.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QozrMhXJgHHdM+iGkY0NB88OtzgjpNGyCoYDQ1lx0No=;
        b=oqQgL003qUPuSOE4ihRwxplr2wwIQgMtlieQDhsvqKfC6LjTMd1HQFZ06+zqU8t0sr
         hKM39Tmi2zJxok0tyK1Otc4IwsM1/uT2DmMsEa7ZF5QaUPsyIIxgtkHWaVHJUVEBgT/k
         /CzDu2p9a+11LVHRPsm8tIaEHdBZYYS+fVC7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QozrMhXJgHHdM+iGkY0NB88OtzgjpNGyCoYDQ1lx0No=;
        b=miE59jDOVlNnDR+QsB+ovpd6jqqXGmcg/Ay+eBPqNOMbQiV73D8ps2dKOEObLfSpHo
         Xkm3lXrb8FmttYUl02r8dsj1AB5U3KMlHEQh/8+66du34bbsKY8BNy1adX2t7rSKoTMh
         21gfNFrv6UudhhkqFSOlghzVx9oFDGwNlA2zvd3L9l1n8NQ3NEgaVleZ+nf7/7fjy4Eh
         WHCRakEsxtTcS7RyGkRAvBBM2F7VjsJT/hn87IItAL8y8mnDnpFkudNTRr2I1A1roZR3
         FbATyIT9iYJNBKgqIX8IVecJv8naiK7fT0ZOOe3kJ7BEKkcyG8HVDzrf2oKw2+Ux8rP6
         jBQg==
X-Gm-Message-State: APjAAAXliSWQOUAhfwGN0qi8rodspYZxb+V8ooLJgp13FhlWTdJjn1tq
        8rpY9T0FYZxREbhXuwZiJUDqSA==
X-Google-Smtp-Source: APXvYqw9t8lnpYJAAX8ADuFrkSQsHJ/IvjkPV0zH3kMgVbcRDhZb9NwJRPKGdXNiuG2vt+8RodDcuA==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr10711320wrt.188.1570335323672;
        Sat, 05 Oct 2019 21:15:23 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id q66sm8651138wme.39.2019.10.05.21.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 21:15:23 -0700 (PDT)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
X-Google-Original-From: Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     vitaly.vul@sony.com, linux-kernel@vger.kernel.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] z3fold: add inter-page compaction
Date:   Sun,  6 Oct 2019 07:14:57 +0300
Message-Id: <20191006041457.24113-1-vitalywool@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Wool <vitaly.wool@konsulko.com>

For each page scheduled for compaction (e. g. by z3fold_free()),
try to apply inter-page compaction before running the traditional/
existing intra-page compaction. That means, if the page has only one
buddy, we treat that buddy as a new object that we aim to place into
an existing z3fold page. If such a page is found, that object is
transferred and the old page is freed completely. The transferred
object is named "foreign" and treated slightly differently thereafter.

Namely, we increase "foreign handle" counter for the new page. Pages
with non-zero "foreign handle" count become unmovable. This patch
implements "foreign handle" detection when a handle is freed to
decrement the foreign handle counter accordingly, so a page may as
well become movable again as the time goes by.

As a result, we almost always have exactly 3 objects per page and
significantly better average compression ratio.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 363 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 291 insertions(+), 72 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 6d3d3f698ebb..25713a4a7186 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -41,6 +41,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/rwlock.h>
 #include <linux/zpool.h>
 #include <linux/magic.h>
 
@@ -90,6 +91,7 @@ struct z3fold_buddy_slots {
 	 */
 	unsigned long slot[BUDDY_MASK + 1];
 	unsigned long pool; /* back link + flags */
+	rwlock_t lock;
 };
 #define HANDLE_FLAG_MASK	(0x03)
 
@@ -124,6 +126,7 @@ struct z3fold_header {
 	unsigned short start_middle;
 	unsigned short first_num:2;
 	unsigned short mapped_count:2;
+	unsigned short foreign_handles:2;
 };
 
 /**
@@ -178,6 +181,19 @@ enum z3fold_page_flags {
 	PAGE_CLAIMED, /* by either reclaim or free */
 };
 
+/*
+ * handle flags, go under HANDLE_FLAG_MASK
+ */
+enum z3fold_handle_flags {
+	HANDLES_ORPHANED = 0,
+};
+
+/*
+ * Forward declarations
+ */
+static struct z3fold_header *__z3fold_alloc(struct z3fold_pool *, size_t, bool);
+static void compact_page_work(struct work_struct *w);
+
 /*****************
  * Helpers
 *****************/
@@ -191,8 +207,6 @@ static int size_to_chunks(size_t size)
 #define for_each_unbuddied_list(_iter, _begin) \
 	for ((_iter) = (_begin); (_iter) < NCHUNKS; (_iter)++)
 
-static void compact_page_work(struct work_struct *w);
-
 static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 							gfp_t gfp)
 {
@@ -204,6 +218,7 @@ static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 	if (slots) {
 		memset(slots->slot, 0, sizeof(slots->slot));
 		slots->pool = (unsigned long)pool;
+		rwlock_init(&slots->lock);
 	}
 
 	return slots;
@@ -219,27 +234,108 @@ static inline struct z3fold_buddy_slots *handle_to_slots(unsigned long handle)
 	return (struct z3fold_buddy_slots *)(handle & ~(SLOTS_ALIGN - 1));
 }
 
+/* Lock a z3fold page */
+static inline void z3fold_page_lock(struct z3fold_header *zhdr)
+{
+	spin_lock(&zhdr->page_lock);
+}
+
+/* Try to lock a z3fold page */
+static inline int z3fold_page_trylock(struct z3fold_header *zhdr)
+{
+	return spin_trylock(&zhdr->page_lock);
+}
+
+/* Unlock a z3fold page */
+static inline void z3fold_page_unlock(struct z3fold_header *zhdr)
+{
+	spin_unlock(&zhdr->page_lock);
+}
+
+
+static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
+							bool lock)
+{
+	struct z3fold_buddy_slots *slots;
+	struct z3fold_header *zhdr;
+	int locked = 0;
+
+	if (!(handle & (1 << PAGE_HEADLESS))) {
+		slots = handle_to_slots(handle);
+		do {
+			unsigned long addr;
+
+			read_lock(&slots->lock);
+			addr = *(unsigned long *)handle;
+			zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
+			if (lock)
+				locked = z3fold_page_trylock(zhdr);
+			read_unlock(&slots->lock);
+			if (locked)
+				break;
+			cpu_relax();
+		} while (lock);
+	} else {
+		zhdr = (struct z3fold_header *)(handle & PAGE_MASK);
+	}
+
+	return zhdr;
+}
+
+/* Returns the z3fold page where a given handle is stored */
+static inline struct z3fold_header *handle_to_z3fold_header(unsigned long h)
+{
+	return __get_z3fold_header(h, false);
+}
+
+/* return locked z3fold page if it's not headless */
+static inline struct z3fold_header *get_z3fold_header(unsigned long h)
+{
+	return __get_z3fold_header(h, true);
+}
+
+static inline void put_z3fold_header(struct z3fold_header *zhdr)
+{
+	struct page *page = virt_to_page(zhdr);
+
+	if (!test_bit(PAGE_HEADLESS, &page->private))
+		z3fold_page_unlock(zhdr);
+}
+
 static inline void free_handle(unsigned long handle)
 {
 	struct z3fold_buddy_slots *slots;
+	struct z3fold_header *zhdr;
 	int i;
 	bool is_free;
 
 	if (handle & (1 << PAGE_HEADLESS))
 		return;
 
-	WARN_ON(*(unsigned long *)handle == 0);
-	*(unsigned long *)handle = 0;
+	if (WARN_ON(*(unsigned long *)handle == 0))
+		return;
+
+	zhdr = handle_to_z3fold_header(handle);
 	slots = handle_to_slots(handle);
+	write_lock(&slots->lock);
+	*(unsigned long *)handle = 0;
+	write_unlock(&slots->lock);
+	if (zhdr->slots == slots)
+		return; /* simple case, nothing else to do */
+
+	/* we are freeing a foreign handle if we are here */
+	zhdr->foreign_handles--;
 	is_free = true;
+	read_lock(&slots->lock);
 	for (i = 0; i <= BUDDY_MASK; i++) {
 		if (slots->slot[i]) {
 			is_free = false;
 			break;
 		}
 	}
+	read_unlock(&slots->lock);
 
-	if (is_free) {
+	if (is_free && test_and_clear_bit(HANDLES_ORPHANED, &slots->pool)) {
 		struct z3fold_pool *pool = slots_to_pool(slots);
 
 		kmem_cache_free(pool->c_handle, slots);
@@ -322,6 +418,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 	zhdr->first_num = 0;
 	zhdr->start_middle = 0;
 	zhdr->cpu = -1;
+	zhdr->foreign_handles = 0;
 	zhdr->slots = slots;
 	zhdr->pool = pool;
 	INIT_LIST_HEAD(&zhdr->buddy);
@@ -341,24 +438,6 @@ static void free_z3fold_page(struct page *page, bool headless)
 	__free_page(page);
 }
 
-/* Lock a z3fold page */
-static inline void z3fold_page_lock(struct z3fold_header *zhdr)
-{
-	spin_lock(&zhdr->page_lock);
-}
-
-/* Try to lock a z3fold page */
-static inline int z3fold_page_trylock(struct z3fold_header *zhdr)
-{
-	return spin_trylock(&zhdr->page_lock);
-}
-
-/* Unlock a z3fold page */
-static inline void z3fold_page_unlock(struct z3fold_header *zhdr)
-{
-	spin_unlock(&zhdr->page_lock);
-}
-
 /* Helper function to build the index */
 static inline int __idx(struct z3fold_header *zhdr, enum buddy bud)
 {
@@ -389,7 +468,9 @@ static unsigned long __encode_handle(struct z3fold_header *zhdr,
 	if (bud == LAST)
 		h |= (zhdr->last_chunks << BUDDY_SHIFT);
 
+	write_lock(&slots->lock);
 	slots->slot[idx] = h;
+	write_unlock(&slots->lock);
 	return (unsigned long)&slots->slot[idx];
 }
 
@@ -398,17 +479,6 @@ static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
 	return __encode_handle(zhdr, zhdr->slots, bud);
 }
 
-/* Returns the z3fold page where a given handle is stored */
-static inline struct z3fold_header *handle_to_z3fold_header(unsigned long h)
-{
-	unsigned long addr = h;
-
-	if (!(addr & (1 << PAGE_HEADLESS)))
-		addr = *(unsigned long *)h;
-
-	return (struct z3fold_header *)(addr & PAGE_MASK);
-}
-
 /* only for LAST bud, returns zero otherwise */
 static unsigned short handle_to_chunks(unsigned long handle)
 {
@@ -442,6 +512,8 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 {
 	struct page *page = virt_to_page(zhdr);
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
+	bool is_free = true;
+	int i;
 
 	WARN_ON(!list_empty(&zhdr->buddy));
 	set_bit(PAGE_STALE, &page->private);
@@ -450,8 +522,25 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	if (!list_empty(&page->lru))
 		list_del_init(&page->lru);
 	spin_unlock(&pool->lock);
+
+	/* If there are no foreign handles, free the handles array */
+	read_lock(&zhdr->slots->lock);
+	for (i = 0; i <= BUDDY_MASK; i++) {
+		if (zhdr->slots->slot[i]) {
+			is_free = false;
+			break;
+		}
+	}
+	read_unlock(&zhdr->slots->lock);
+
+	if (is_free)
+		kmem_cache_free(pool->c_handle, zhdr->slots);
+	else
+		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
+
 	if (locked)
 		z3fold_page_unlock(zhdr);
+
 	spin_lock(&pool->stale_lock);
 	list_add(&zhdr->buddy, &pool->stale);
 	queue_work(pool->release_wq, &pool->work);
@@ -479,6 +568,7 @@ static void release_z3fold_page_locked_list(struct kref *ref)
 	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
 					       refcount);
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
+
 	spin_lock(&pool->lock);
 	list_del_init(&zhdr->buddy);
 	spin_unlock(&pool->lock);
@@ -559,6 +649,119 @@ static inline void *mchunk_memmove(struct z3fold_header *zhdr,
 		       zhdr->middle_chunks << CHUNK_SHIFT);
 }
 
+static inline bool buddy_single(struct z3fold_header *zhdr)
+{
+	return !((zhdr->first_chunks && zhdr->middle_chunks) ||
+			(zhdr->first_chunks && zhdr->last_chunks) ||
+			(zhdr->middle_chunks && zhdr->last_chunks));
+}
+
+static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
+{
+	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
+	void *p = zhdr;
+	unsigned long old_handle = 0;
+	enum buddy bud;
+	size_t sz = 0;
+	struct z3fold_header *new_zhdr = NULL;
+	int first_idx = __idx(zhdr, FIRST);
+	int middle_idx = __idx(zhdr, MIDDLE);
+	int last_idx = __idx(zhdr, LAST);
+
+	/*
+	 * No need to protect slots here -- all the slots are "local" and
+	 * the page lock is already taken
+	 */
+	if (zhdr->first_chunks && zhdr->slots->slot[first_idx]) {
+		bud = FIRST;
+		p += ZHDR_SIZE_ALIGNED;
+		sz = zhdr->first_chunks << CHUNK_SHIFT;
+		old_handle = (unsigned long)&zhdr->slots->slot[first_idx];
+	} else if (zhdr->middle_chunks && zhdr->slots->slot[middle_idx]) {
+		bud = MIDDLE;
+		p += zhdr->start_middle << CHUNK_SHIFT;
+		sz = zhdr->middle_chunks << CHUNK_SHIFT;
+		old_handle = (unsigned long)&zhdr->slots->slot[middle_idx];
+	} else if (zhdr->last_chunks && zhdr->slots->slot[last_idx]) {
+		bud = LAST;
+		p += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
+		sz = zhdr->last_chunks << CHUNK_SHIFT;
+		old_handle = (unsigned long)&zhdr->slots->slot[last_idx];
+	}
+
+	if (sz > 0) {
+		struct page *newpage;
+		enum buddy new_bud = HEADLESS;
+		short chunks = size_to_chunks(sz);
+		void *q;
+
+		new_zhdr = __z3fold_alloc(pool, sz, false);
+		if (!new_zhdr)
+			return NULL;
+
+		newpage = virt_to_page(new_zhdr);
+		if (WARN_ON(new_zhdr == zhdr))
+			goto out_fail;
+
+		if (new_zhdr->first_chunks == 0) {
+			if (new_zhdr->middle_chunks != 0 &&
+					chunks >= new_zhdr->start_middle) {
+				new_bud = LAST;
+			} else {
+				new_bud = FIRST;
+			}
+		} else if (new_zhdr->last_chunks == 0) {
+			new_bud = LAST;
+		} else if (new_zhdr->middle_chunks == 0) {
+			new_bud = MIDDLE;
+		}
+		q = new_zhdr;
+		switch (new_bud) {
+		case FIRST:
+			new_zhdr->first_chunks = chunks;
+			q += ZHDR_SIZE_ALIGNED;
+			break;
+		case MIDDLE:
+			new_zhdr->middle_chunks = chunks;
+			new_zhdr->start_middle =
+				new_zhdr->first_chunks + ZHDR_CHUNKS;
+			q += new_zhdr->start_middle << CHUNK_SHIFT;
+			break;
+		case LAST:
+			new_zhdr->last_chunks = chunks;
+			q += PAGE_SIZE - (new_zhdr->last_chunks << CHUNK_SHIFT);
+			break;
+		default:
+			goto out_fail;
+		}
+		new_zhdr->foreign_handles++;
+		memcpy(q, p, sz);
+		write_lock(&zhdr->slots->lock);
+		*(unsigned long *)old_handle = (unsigned long)new_zhdr +
+			__idx(new_zhdr, new_bud);
+		if (new_bud == LAST)
+			*(unsigned long *)old_handle |=
+					(new_zhdr->last_chunks << BUDDY_SHIFT);
+		write_unlock(&zhdr->slots->lock);
+		add_to_unbuddied(pool, new_zhdr);
+		z3fold_page_unlock(new_zhdr);
+	}
+
+	return new_zhdr;
+
+out_fail:
+	if (new_zhdr) {
+		if (kref_put(&new_zhdr->refcount, release_z3fold_page_locked))
+			atomic64_dec(&pool->pages_nr);
+		else {
+			add_to_unbuddied(pool, new_zhdr);
+			z3fold_page_unlock(new_zhdr);
+		}
+	}
+	return NULL;
+
+}
+
 #define BIG_CHUNK_GAP	3
 /* Has to be called with lock held */
 static int z3fold_compact_page(struct z3fold_header *zhdr)
@@ -638,6 +841,15 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 		return;
 	}
 
+	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
+			compact_single_buddy(zhdr)) {
+		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
+			atomic64_dec(&pool->pages_nr);
+		else
+			z3fold_page_unlock(zhdr);
+		return;
+	}
+
 	z3fold_compact_page(zhdr);
 	add_to_unbuddied(pool, zhdr);
 	z3fold_page_unlock(zhdr);
@@ -690,7 +902,8 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		spin_unlock(&pool->lock);
 
 		page = virt_to_page(zhdr);
-		if (test_bit(NEEDS_COMPACTING, &page->private)) {
+		if (test_bit(NEEDS_COMPACTING, &page->private) ||
+		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr = NULL;
 			put_cpu_ptr(pool->unbuddied);
@@ -734,7 +947,8 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 			spin_unlock(&pool->lock);
 
 			page = virt_to_page(zhdr);
-			if (test_bit(NEEDS_COMPACTING, &page->private)) {
+			if (test_bit(NEEDS_COMPACTING, &page->private) ||
+			    test_bit(PAGE_CLAIMED, &page->private)) {
 				z3fold_page_unlock(zhdr);
 				zhdr = NULL;
 				if (can_sleep)
@@ -1000,7 +1214,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	enum buddy bud;
 	bool page_claimed;
 
-	zhdr = handle_to_z3fold_header(handle);
+	zhdr = get_z3fold_header(handle);
 	page = virt_to_page(zhdr);
 	page_claimed = test_and_set_bit(PAGE_CLAIMED, &page->private);
 
@@ -1014,6 +1228,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 			spin_lock(&pool->lock);
 			list_del(&page->lru);
 			spin_unlock(&pool->lock);
+			put_z3fold_header(zhdr);
 			free_z3fold_page(page, true);
 			atomic64_dec(&pool->pages_nr);
 		}
@@ -1021,7 +1236,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	}
 
 	/* Non-headless case */
-	z3fold_page_lock(zhdr);
 	bud = handle_to_buddy(handle);
 
 	switch (bud) {
@@ -1037,11 +1251,11 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	default:
 		pr_err("%s: unknown bud %d\n", __func__, bud);
 		WARN_ON(1);
-		z3fold_page_unlock(zhdr);
+		put_z3fold_header(zhdr);
+		clear_bit(PAGE_CLAIMED, &page->private);
 		return;
 	}
 
-	free_handle(handle);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
 		atomic64_dec(&pool->pages_nr);
 		return;
@@ -1051,9 +1265,10 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		z3fold_page_unlock(zhdr);
 		return;
 	}
+	free_handle(handle);
 	if (unlikely(PageIsolated(page)) ||
 	    test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
-		z3fold_page_unlock(zhdr);
+		put_z3fold_header(zhdr);
 		clear_bit(PAGE_CLAIMED, &page->private);
 		return;
 	}
@@ -1063,14 +1278,14 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		spin_unlock(&pool->lock);
 		zhdr->cpu = -1;
 		kref_get(&zhdr->refcount);
-		do_compact_page(zhdr, true);
 		clear_bit(PAGE_CLAIMED, &page->private);
+		do_compact_page(zhdr, true);
 		return;
 	}
 	kref_get(&zhdr->refcount);
-	queue_work_on(zhdr->cpu, pool->compact_wq, &zhdr->work);
 	clear_bit(PAGE_CLAIMED, &page->private);
-	z3fold_page_unlock(zhdr);
+	queue_work_on(zhdr->cpu, pool->compact_wq, &zhdr->work);
+	put_z3fold_header(zhdr);
 }
 
 /**
@@ -1111,11 +1326,10 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
  */
 static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 {
-	int i, ret = 0;
+	int i, ret = -1;
 	struct z3fold_header *zhdr = NULL;
 	struct page *page = NULL;
 	struct list_head *pos;
-	struct z3fold_buddy_slots slots;
 	unsigned long first_handle = 0, middle_handle = 0, last_handle = 0;
 
 	spin_lock(&pool->lock);
@@ -1153,6 +1367,12 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 				zhdr = NULL;
 				continue; /* can't evict at this point */
 			}
+			if (zhdr->foreign_handles) {
+				clear_bit(PAGE_CLAIMED, &page->private);
+				z3fold_page_unlock(zhdr);
+				zhdr = NULL;
+				continue; /* can't evict such page */
+			}
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
@@ -1176,39 +1396,38 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			last_handle = 0;
 			middle_handle = 0;
 			if (zhdr->first_chunks)
-				first_handle = __encode_handle(zhdr, &slots,
-								FIRST);
+				first_handle = encode_handle(zhdr, FIRST);
 			if (zhdr->middle_chunks)
-				middle_handle = __encode_handle(zhdr, &slots,
-								MIDDLE);
+				middle_handle = encode_handle(zhdr, MIDDLE);
 			if (zhdr->last_chunks)
-				last_handle = __encode_handle(zhdr, &slots,
-								LAST);
+				last_handle = encode_handle(zhdr, LAST);
 			/*
 			 * it's safe to unlock here because we hold a
 			 * reference to this page
 			 */
 			z3fold_page_unlock(zhdr);
 		} else {
-			first_handle = __encode_handle(zhdr, &slots, HEADLESS);
+			first_handle = encode_handle(zhdr, HEADLESS);
 			last_handle = middle_handle = 0;
 		}
-
 		/* Issue the eviction callback(s) */
 		if (middle_handle) {
 			ret = pool->ops->evict(pool, middle_handle);
 			if (ret)
 				goto next;
+			free_handle(middle_handle);
 		}
 		if (first_handle) {
 			ret = pool->ops->evict(pool, first_handle);
 			if (ret)
 				goto next;
+			free_handle(first_handle);
 		}
 		if (last_handle) {
 			ret = pool->ops->evict(pool, last_handle);
 			if (ret)
 				goto next;
+			free_handle(last_handle);
 		}
 next:
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
@@ -1264,14 +1483,13 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 	void *addr;
 	enum buddy buddy;
 
-	zhdr = handle_to_z3fold_header(handle);
+	zhdr = get_z3fold_header(handle);
 	addr = zhdr;
 	page = virt_to_page(zhdr);
 
 	if (test_bit(PAGE_HEADLESS, &page->private))
 		goto out;
 
-	z3fold_page_lock(zhdr);
 	buddy = handle_to_buddy(handle);
 	switch (buddy) {
 	case FIRST:
@@ -1293,8 +1511,8 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 
 	if (addr)
 		zhdr->mapped_count++;
-	z3fold_page_unlock(zhdr);
 out:
+	put_z3fold_header(zhdr);
 	return addr;
 }
 
@@ -1309,18 +1527,17 @@ static void z3fold_unmap(struct z3fold_pool *pool, unsigned long handle)
 	struct page *page;
 	enum buddy buddy;
 
-	zhdr = handle_to_z3fold_header(handle);
+	zhdr = get_z3fold_header(handle);
 	page = virt_to_page(zhdr);
 
 	if (test_bit(PAGE_HEADLESS, &page->private))
 		return;
 
-	z3fold_page_lock(zhdr);
 	buddy = handle_to_buddy(handle);
 	if (buddy == MIDDLE)
 		clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	zhdr->mapped_count--;
-	z3fold_page_unlock(zhdr);
+	put_z3fold_header(zhdr);
 }
 
 /**
@@ -1352,19 +1569,21 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	    test_bit(PAGE_STALE, &page->private))
 		goto out;
 
+	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0)
+		goto out;
+
 	pool = zhdr_to_pool(zhdr);
+	spin_lock(&pool->lock);
+	if (!list_empty(&zhdr->buddy))
+		list_del_init(&zhdr->buddy);
+	if (!list_empty(&page->lru))
+		list_del_init(&page->lru);
+	spin_unlock(&pool->lock);
+
+	kref_get(&zhdr->refcount);
+	z3fold_page_unlock(zhdr);
+	return true;
 
-	if (zhdr->mapped_count == 0) {
-		kref_get(&zhdr->refcount);
-		if (!list_empty(&zhdr->buddy))
-			list_del_init(&zhdr->buddy);
-		spin_lock(&pool->lock);
-		if (!list_empty(&page->lru))
-			list_del(&page->lru);
-		spin_unlock(&pool->lock);
-		z3fold_page_unlock(zhdr);
-		return true;
-	}
 out:
 	z3fold_page_unlock(zhdr);
 	return false;
@@ -1387,7 +1606,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	if (!z3fold_page_trylock(zhdr)) {
 		return -EAGAIN;
 	}
-	if (zhdr->mapped_count != 0) {
+	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
 		z3fold_page_unlock(zhdr);
 		return -EBUSY;
 	}
-- 
2.20.1

