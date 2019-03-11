Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D148CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A122084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552266515;
	bh=Tm4qA2beTYFtpket6V7nEjXkJ7klRwNuZ3Qrq3r79Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bb1ISMquaw7kN2+ygyAR5DRtUeIFVbhMBmwu2zKSz/myhN+C6+gjVbOcLnmbiyBA1
	 6/e2F4l2YH3m7NhXLCUa2WHcvlqs6MGmPV0FGYe0nxZLkFJ3W5+DH1FWYPOqXkNLYF
	 wxHIAY2pNoLNsp2KyRpOcKhb1v8UtnNoN2Inkfgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCKBI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:08:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48819 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfCKBIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:08:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C5CB20D7C;
        Sun, 10 Mar 2019 21:08:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Mar 2019 21:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0YdAVJOsub1ouxSrbSwMtQqJcFX4a2eTBDmV3Tq0WPQ=; b=FZkGMICQ
        RBJt7UixobVfNSBG6ZzC3alUMFvJvwoj2/NFH0E8fvRo8Sx6bbysKrp9Wfuum10m
        L7rqsn59D+3FmhUzJImeA6ycQNy10ZP3YuveStk3D21Teyl+r2hEmej23RmjD9rB
        CS3x5CRp744TUjAaq64/9gA+UWf7v2at5yQr+LPyKYahGe7E8Ke6+u/qe5prO2Fj
        8Qo9MNjj7is532Wc3BXmJaQf3kq7w3ElgHiDymGC7s2lVhKi7ejWU8n7aEgklYEi
        GgHH6Z9qk3nUjBffVK+kxcKNtxzqr8USQiZ9CrLgL9skyYKDbjD09pQ0N8EElyur
        vXFybCJG0UnS2Q==
X-ME-Sender: <xms:CLWFXB81MkiCi86xfm_0QPG0vwfdPDQnOZFkyff4A4fKH6wU2xoAwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelvddrieeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:CLWFXJ9PVf86PWqAOaocg7GbhSR0RPzK4Uf0QYakrrCZkVjd50gPcg>
    <xmx:CLWFXCJlZe39PDfUUZyQo1UcfN-Vo2LjriZFLif0ytfRvE7UuakY1Q>
    <xmx:CLWFXDzTQqrSag6WwVDOpFdY5y6K3-yGpQW1-wDesMSta1KYq7EtXg>
    <xmx:CbWFXGz0YMbeLzF8QFx36Xtjtnt3s_FFKt9xoe6o9apogoSXAqi8QQ>
Received: from eros.localdomain (ppp118-211-192-66.bras1.syd2.internode.on.net [118.211.192.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id C822010312;
        Sun, 10 Mar 2019 21:08:21 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] slub: Use slab_list instead of lru
Date:   Mon, 11 Mar 2019 12:07:42 +1100
Message-Id: <20190311010744.5862-3-tobin@kernel.org>
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
 mm/slub.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b282e22885cd..d692b5e0163d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1023,7 +1023,7 @@ static void add_full(struct kmem_cache *s,
 		return;
 
 	lockdep_assert_held(&n->list_lock);
-	list_add(&page->lru, &n->full);
+	list_add(&page->slab_list, &n->full);
 }
 
 static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct page *page)
@@ -1032,7 +1032,7 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 		return;
 
 	lockdep_assert_held(&n->list_lock);
-	list_del(&page->lru);
+	list_del(&page->slab_list);
 }
 
 /* Tracking of the number of slabs for debugging purposes */
@@ -1773,9 +1773,9 @@ __add_partial(struct kmem_cache_node *n, struct page *page, int tail)
 {
 	n->nr_partial++;
 	if (tail == DEACTIVATE_TO_TAIL)
-		list_add_tail(&page->lru, &n->partial);
+		list_add_tail(&page->slab_list, &n->partial);
 	else
-		list_add(&page->lru, &n->partial);
+		list_add(&page->slab_list, &n->partial);
 }
 
 static inline void add_partial(struct kmem_cache_node *n,
@@ -1789,7 +1789,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
 					struct page *page)
 {
 	lockdep_assert_held(&n->list_lock);
-	list_del(&page->lru);
+	list_del(&page->slab_list);
 	n->nr_partial--;
 }
 
@@ -1863,7 +1863,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		return NULL;
 
 	spin_lock(&n->list_lock);
-	list_for_each_entry_safe(page, page2, &n->partial, lru) {
+	list_for_each_entry_safe(page, page2, &n->partial, slab_list) {
 		void *t;
 
 		if (!pfmemalloc_match(page, flags))
@@ -2407,7 +2407,7 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 	struct page *page;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(page, &n->partial, lru)
+	list_for_each_entry(page, &n->partial, slab_list)
 		x += get_count(page);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
@@ -3702,10 +3702,10 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 
 	BUG_ON(irqs_disabled());
 	spin_lock_irq(&n->list_lock);
-	list_for_each_entry_safe(page, h, &n->partial, lru) {
+	list_for_each_entry_safe(page, h, &n->partial, slab_list) {
 		if (!page->inuse) {
 			remove_partial(n, page);
-			list_add(&page->lru, &discard);
+			list_add(&page->slab_list, &discard);
 		} else {
 			list_slab_objects(s, page,
 			"Objects remaining in %s on __kmem_cache_shutdown()");
@@ -3713,7 +3713,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	}
 	spin_unlock_irq(&n->list_lock);
 
-	list_for_each_entry_safe(page, h, &discard, lru)
+	list_for_each_entry_safe(page, h, &discard, slab_list)
 		discard_slab(s, page);
 }
 
@@ -3993,7 +3993,7 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 		 * Note that concurrent frees may occur while we hold the
 		 * list_lock. page->inuse here is the upper limit.
 		 */
-		list_for_each_entry_safe(page, t, &n->partial, lru) {
+		list_for_each_entry_safe(page, t, &n->partial, slab_list) {
 			int free = page->objects - page->inuse;
 
 			/* Do not reread page->inuse */
@@ -4003,10 +4003,10 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 			BUG_ON(free <= 0);
 
 			if (free == page->objects) {
-				list_move(&page->lru, &discard);
+				list_move(&page->slab_list, &discard);
 				n->nr_partial--;
 			} else if (free <= SHRINK_PROMOTE_MAX)
-				list_move(&page->lru, promote + free - 1);
+				list_move(&page->slab_list, promote + free - 1);
 		}
 
 		/*
@@ -4019,7 +4019,7 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 		spin_unlock_irqrestore(&n->list_lock, flags);
 
 		/* Release empty slabs */
-		list_for_each_entry_safe(page, t, &discard, lru)
+		list_for_each_entry_safe(page, t, &discard, slab_list)
 			discard_slab(s, page);
 
 		if (slabs_node(s, node))
@@ -4211,11 +4211,11 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	for_each_kmem_cache_node(s, node, n) {
 		struct page *p;
 
-		list_for_each_entry(p, &n->partial, lru)
+		list_for_each_entry(p, &n->partial, slab_list)
 			p->slab_cache = s;
 
 #ifdef CONFIG_SLUB_DEBUG
-		list_for_each_entry(p, &n->full, lru)
+		list_for_each_entry(p, &n->full, slab_list)
 			p->slab_cache = s;
 #endif
 	}
@@ -4432,7 +4432,7 @@ static int validate_slab_node(struct kmem_cache *s,
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
-	list_for_each_entry(page, &n->partial, lru) {
+	list_for_each_entry(page, &n->partial, slab_list) {
 		validate_slab_slab(s, page, map);
 		count++;
 	}
@@ -4443,7 +4443,7 @@ static int validate_slab_node(struct kmem_cache *s,
 	if (!(s->flags & SLAB_STORE_USER))
 		goto out;
 
-	list_for_each_entry(page, &n->full, lru) {
+	list_for_each_entry(page, &n->full, slab_list) {
 		validate_slab_slab(s, page, map);
 		count++;
 	}
@@ -4639,9 +4639,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
 			continue;
 
 		spin_lock_irqsave(&n->list_lock, flags);
-		list_for_each_entry(page, &n->partial, lru)
+		list_for_each_entry(page, &n->partial, slab_list)
 			process_slab(&t, s, page, alloc, map);
-		list_for_each_entry(page, &n->full, lru)
+		list_for_each_entry(page, &n->full, slab_list)
 			process_slab(&t, s, page, alloc, map);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
-- 
2.21.0

