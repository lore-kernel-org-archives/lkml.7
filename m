Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF24C10F0D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE666206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552266515;
	bh=Bpa2NV2ZW7lQQdTF138bcOQHIN45tWa370Kad1UgNPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U3jhwLwc6aCb6YfMZ8TP14w0anD/vnl5yAsMInt/a0ry6n/09z423XkY0xoaumyzN
	 XPHVhQ9CizOc482kLpViC31RS/Xwhh7PZqVxq47vpQK0ODcTihJV6eIZAd/YLWgjfX
	 PckNf9LvPeA6aulee2GG7rEH/ZcR/yA6McmMygvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCKBIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:08:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55219 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfCKBI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:08:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BE2DF21F86;
        Sun, 10 Mar 2019 21:08:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Mar 2019 21:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CxGqyPgRRgFsJNIUYcTQsfjDYACO56dLDTf5SGEtnkY=; b=zbEIlQFi
        Tke8QZo8EK3u9652auMp3yuH27RKJrSxGU/IXsMu6GjmwBuPx1RxrbgKPbzyLX/h
        OzALvVjZYChQHXV2jNbDF12ReyQhbvNXaUVTIQQMOuiKptz4mRpfBdEqVDTdHpGc
        7lPi3jO+XLngDVR0gOKuOmfTnNOob6e36iRwAZjrtUgkoDUArnS0eqjUiui9Jreb
        weo0uM0XrXQMmipthLO9uylb2aKet/zO9trnhamDkEtinlBeFBzdKvOOBnjFJJ5W
        0D720pDlcXN5yN5fsIynrBvmt+B9TKtf6uJ7r2NrInTGfjJ+mHrXVOWwmOi19q6E
        uuz7bGHupAes4A==
X-ME-Sender: <xms:DLWFXKcj_bWyh4sNWfLm5SObd2kaQdHx3uFqp9p6qTDk4pmMppi0yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelvddrieeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:DLWFXFdUHhZADXSSXcU48tRGoPpPOvw2B8UmtNZ9aI67cSd6HFHvmA>
    <xmx:DLWFXD8XrF_FOxNokSqDDmuw5CPPZDdG4Bv7Rp9d7klLqTsZ0nS0Ow>
    <xmx:DLWFXOKQrbsj5wZ1bcENurnMNRBO5OJCGmeUrBQXg-EKaNqRczHBjg>
    <xmx:DLWFXFj512bKHTju0WWW5HbAa6bLKVjLqJIQ87TnJbg8j-a4At597A>
Received: from eros.localdomain (ppp118-211-192-66.bras1.syd2.internode.on.net [118.211.192.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id 947DF10312;
        Sun, 10 Mar 2019 21:08:25 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] slab: Use slab_list instead of lru
Date:   Mon, 11 Mar 2019 12:07:43 +1100
Message-Id: <20190311010744.5862-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190311010744.5862-1-tobin@kernel.org>
References: <20190311010744.5862-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use the page->lru list for maintaining lists of slabs.  We
have a list in the page structure (slab_list) that can be used for this
purpose.  Doing so makes the code cleaner since we are not overloading
the lru list.

Use the slab_list instead of the lru list for maintaining lists of
slabs.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slab.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 28652e4218e0..09cc64ef9613 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1710,8 +1710,8 @@ static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
 {
 	struct page *page, *n;
 
-	list_for_each_entry_safe(page, n, list, lru) {
-		list_del(&page->lru);
+	list_for_each_entry_safe(page, n, list, slab_list) {
+		list_del(&page->slab_list);
 		slab_destroy(cachep, page);
 	}
 }
@@ -2265,8 +2265,8 @@ static int drain_freelist(struct kmem_cache *cache,
 			goto out;
 		}
 
-		page = list_entry(p, struct page, lru);
-		list_del(&page->lru);
+		page = list_entry(p, struct page, slab_list);
+		list_del(&page->slab_list);
 		n->free_slabs--;
 		n->total_slabs--;
 		/*
@@ -2726,13 +2726,13 @@ static void cache_grow_end(struct kmem_cache *cachep, struct page *page)
 	if (!page)
 		return;
 
-	INIT_LIST_HEAD(&page->lru);
+	INIT_LIST_HEAD(&page->slab_list);
 	n = get_node(cachep, page_to_nid(page));
 
 	spin_lock(&n->list_lock);
 	n->total_slabs++;
 	if (!page->active) {
-		list_add_tail(&page->lru, &(n->slabs_free));
+		list_add_tail(&page->slab_list, &n->slabs_free);
 		n->free_slabs++;
 	} else
 		fixup_slab_list(cachep, n, page, &list);
@@ -2841,9 +2841,9 @@ static inline void fixup_slab_list(struct kmem_cache *cachep,
 				void **list)
 {
 	/* move slabp to correct slabp list: */
-	list_del(&page->lru);
+	list_del(&page->slab_list);
 	if (page->active == cachep->num) {
-		list_add(&page->lru, &n->slabs_full);
+		list_add(&page->slab_list, &n->slabs_full);
 		if (OBJFREELIST_SLAB(cachep)) {
 #if DEBUG
 			/* Poisoning will be done without holding the lock */
@@ -2857,7 +2857,7 @@ static inline void fixup_slab_list(struct kmem_cache *cachep,
 			page->freelist = NULL;
 		}
 	} else
-		list_add(&page->lru, &n->slabs_partial);
+		list_add(&page->slab_list, &n->slabs_partial);
 }
 
 /* Try to find non-pfmemalloc slab if needed */
@@ -2880,20 +2880,20 @@ static noinline struct page *get_valid_first_slab(struct kmem_cache_node *n,
 	}
 
 	/* Move pfmemalloc slab to the end of list to speed up next search */
-	list_del(&page->lru);
+	list_del(&page->slab_list);
 	if (!page->active) {
-		list_add_tail(&page->lru, &n->slabs_free);
+		list_add_tail(&page->slab_list, &n->slabs_free);
 		n->free_slabs++;
 	} else
-		list_add_tail(&page->lru, &n->slabs_partial);
+		list_add_tail(&page->slab_list, &n->slabs_partial);
 
-	list_for_each_entry(page, &n->slabs_partial, lru) {
+	list_for_each_entry(page, &n->slabs_partial, slab_list) {
 		if (!PageSlabPfmemalloc(page))
 			return page;
 	}
 
 	n->free_touched = 1;
-	list_for_each_entry(page, &n->slabs_free, lru) {
+	list_for_each_entry(page, &n->slabs_free, slab_list) {
 		if (!PageSlabPfmemalloc(page)) {
 			n->free_slabs--;
 			return page;
@@ -2908,11 +2908,12 @@ static struct page *get_first_slab(struct kmem_cache_node *n, bool pfmemalloc)
 	struct page *page;
 
 	assert_spin_locked(&n->list_lock);
-	page = list_first_entry_or_null(&n->slabs_partial, struct page, lru);
+	page = list_first_entry_or_null(&n->slabs_partial, struct page,
+					slab_list);
 	if (!page) {
 		n->free_touched = 1;
 		page = list_first_entry_or_null(&n->slabs_free, struct page,
-						lru);
+						slab_list);
 		if (page)
 			n->free_slabs--;
 	}
@@ -3413,29 +3414,29 @@ static void free_block(struct kmem_cache *cachep, void **objpp,
 		objp = objpp[i];
 
 		page = virt_to_head_page(objp);
-		list_del(&page->lru);
+		list_del(&page->slab_list);
 		check_spinlock_acquired_node(cachep, node);
 		slab_put_obj(cachep, page, objp);
 		STATS_DEC_ACTIVE(cachep);
 
 		/* fixup slab chains */
 		if (page->active == 0) {
-			list_add(&page->lru, &n->slabs_free);
+			list_add(&page->slab_list, &n->slabs_free);
 			n->free_slabs++;
 		} else {
 			/* Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
-			list_add_tail(&page->lru, &n->slabs_partial);
+			list_add_tail(&page->slab_list, &n->slabs_partial);
 		}
 	}
 
 	while (n->free_objects > n->free_limit && !list_empty(&n->slabs_free)) {
 		n->free_objects -= cachep->num;
 
-		page = list_last_entry(&n->slabs_free, struct page, lru);
-		list_move(&page->lru, list);
+		page = list_last_entry(&n->slabs_free, struct page, slab_list);
+		list_move(&page->slab_list, list);
 		n->free_slabs--;
 		n->total_slabs--;
 	}
@@ -3473,7 +3474,7 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 		int i = 0;
 		struct page *page;
 
-		list_for_each_entry(page, &n->slabs_free, lru) {
+		list_for_each_entry(page, &n->slabs_free, slab_list) {
 			BUG_ON(page->active);
 
 			i++;
@@ -4336,9 +4337,9 @@ static int leaks_show(struct seq_file *m, void *p)
 			check_irq_on();
 			spin_lock_irq(&n->list_lock);
 
-			list_for_each_entry(page, &n->slabs_full, lru)
+			list_for_each_entry(page, &n->slabs_full, slab_list)
 				handle_slab(x, cachep, page);
-			list_for_each_entry(page, &n->slabs_partial, lru)
+			list_for_each_entry(page, &n->slabs_partial, slab_list)
 				handle_slab(x, cachep, page);
 			spin_unlock_irq(&n->list_lock);
 		}
-- 
2.21.0

