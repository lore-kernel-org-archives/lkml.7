Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3303C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B847D2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246396;
	bh=cWhSKSn1jG7I+Z6nYleGnLCJ79ZUmT7TSxm3Le4Immw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FF2lb7K2n3Mpb1Z+H7qFqitwXmQxfo+qk2PGkspOHZeLaM99g8Pg6vnAfrFMeApkI
	 j2yq9szGjhJ8h5h238Um8V2oG6n2OBmyOZ9eSPL9Iya2/cSArCs3ijCQOv//NERf4+
	 itr2ymezV0eK9jnQPGTEo1DymSVjoVTcEjnpDWPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDBXGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:06:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35381 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:06:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 92E3F21F4F;
        Tue,  2 Apr 2019 19:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2019 19:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=DgIYnn/fssjAlV/t8WH3LwNCV6/gchODyjSyz2g47Ag=; b=fY5GcgBj
        A5RmmSax0s7ajf0TNyjjdaOe6cLvx0pgrb3jofsE3nCice4TPLerLhcX5/2ABdgU
        2K+GTTOPLBMXz8+bCLgI9peLM9xjggKKl6Qm78+9feW7pEFv5G7xiejTWshm22bQ
        d0m+b6cFQhg+Z1Muyhlk1dZdXfZUs3RC+DxmW6f9+hTW7h/Yr29bdYL4nha7POyB
        ZBvS6jZkanocSqY10uSiaHPH0fSUzWt8VF4ae4kUZu/C8GDdwlwocI8IZweV5N2K
        Wl8OhPY5BNQ7HMIvu9r+k6k7Kt/yrk/3kHNxQG0uZGRsHv0Ifc1xrzgdwrwc7Ifw
        +TOc3UJrPUmNuA==
X-ME-Sender: <xms:-eqjXFS1l0QkshLEkPLnUyXddayY3w6OB5je24bA5QKGpmRjSJDfFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdduieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedu
X-ME-Proxy: <xmx:-eqjXNKWZNYWlNe2yx4DSl-eHPAJpQlhD-F1YxBBO_0jFHGZGopi5w>
    <xmx:-eqjXG2cWElsHtE8IFgcgqFty_Rk7YbhvB-Wbd-XAexQ6lB4XsSODA>
    <xmx:-eqjXAIfHFI53Em0abjWfaFj_acmGAkv0q4P_-kWfvYDcaDE7BIvDg>
    <xmx:-eqjXN2-L09x1CtWlz3eW2J8LtjBc0G2GsqGn7lMFdNBNX6kkCXWug>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0362C10391;
        Tue,  2 Apr 2019 19:06:29 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] slob: Respect list_head abstraction layer
Date:   Wed,  3 Apr 2019 10:05:40 +1100
Message-Id: <20190402230545.2929-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402230545.2929-1-tobin@kernel.org>
References: <20190402230545.2929-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we reach inside the list_head.  This is a violation of the
layer of abstraction provided by the list_head.  It makes the code
fragile.  More importantly it makes the code wicked hard to understand.

The code reaches into the list_head structure to counteract the fact
that the list _may_ have been changed during slob_page_alloc().  Instead
of this we can add a return parameter to slob_page_alloc() to signal
that the list was modified (list_del() called with page->lru to remove
page from the freelist).

This code is concerned with an optimisation that counters the tendency
for first fit allocation algorithm to fragment memory into many small
chunks at the front of the memory pool.  Since the page is only removed
from the list when an allocation uses _all_ the remaining memory in the
page then in this special case fragmentation does not occur and we
therefore do not need the optimisation.

Add a return parameter to slob_page_alloc() to signal that the
allocation used up the whole page and that the page was removed from the
free list.  After calling slob_page_alloc() check the return value just
added and only attempt optimisation if the page is still on the list.

Use list_head API instead of reaching into the list_head structure to
check if sp is at the front of the list.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slob.c | 51 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 307c2c9feb44..07356e9feaaa 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -213,13 +213,26 @@ static void slob_free_pages(void *b, int order)
 }
 
 /*
- * Allocate a slob block within a given slob_page sp.
+ * slob_page_alloc() - Allocate a slob block within a given slob_page sp.
+ * @sp: Page to look in.
+ * @size: Size of the allocation.
+ * @align: Allocation alignment.
+ * @page_removed_from_list: Return parameter.
+ *
+ * Tries to find a chunk of memory at least @size bytes big within @page.
+ *
+ * Return: Pointer to memory if allocated, %NULL otherwise.  If the
+ *         allocation fills up @page then the page is removed from the
+ *         freelist, in this case @page_removed_from_list will be set to
+ *         true (set to false otherwise).
  */
-static void *slob_page_alloc(struct page *sp, size_t size, int align)
+static void *slob_page_alloc(struct page *sp, size_t size, int align,
+			     bool *page_removed_from_list)
 {
 	slob_t *prev, *cur, *aligned = NULL;
 	int delta = 0, units = SLOB_UNITS(size);
 
+	*page_removed_from_list = false;
 	for (prev = NULL, cur = sp->freelist; ; prev = cur, cur = slob_next(cur)) {
 		slobidx_t avail = slob_units(cur);
 
@@ -254,8 +267,10 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
 			}
 
 			sp->units -= units;
-			if (!sp->units)
+			if (!sp->units) {
 				clear_slob_page_free(sp);
+				*page_removed_from_list = true;
+			}
 			return cur;
 		}
 		if (slob_last(cur))
@@ -269,10 +284,10 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
 static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 {
 	struct page *sp;
-	struct list_head *prev;
 	struct list_head *slob_list;
 	slob_t *b = NULL;
 	unsigned long flags;
+	bool _unused;
 
 	if (size < SLOB_BREAK1)
 		slob_list = &free_slob_small;
@@ -284,6 +299,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 	spin_lock_irqsave(&slob_lock, flags);
 	/* Iterate through each partially free page, try to find room */
 	list_for_each_entry(sp, slob_list, lru) {
+		bool page_removed_from_list = false;
 #ifdef CONFIG_NUMA
 		/*
 		 * If there's a node specification, search for a partial
@@ -296,18 +312,25 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		if (sp->units < SLOB_UNITS(size))
 			continue;
 
-		/* Attempt to alloc */
-		prev = sp->lru.prev;
-		b = slob_page_alloc(sp, size, align);
+		b = slob_page_alloc(sp, size, align, &page_removed_from_list);
 		if (!b)
 			continue;
 
-		/* Improve fragment distribution and reduce our average
-		 * search time by starting our next search here. (see
-		 * Knuth vol 1, sec 2.5, pg 449) */
-		if (prev != slob_list->prev &&
-				slob_list->next != prev->next)
-			list_move_tail(slob_list, prev->next);
+		/*
+		 * If slob_page_alloc() removed sp from the list then we
+		 * cannot call list functions on sp.  If so allocation
+		 * did not fragment the page anyway so optimisation is
+		 * unnecessary.
+		 */
+		if (!page_removed_from_list) {
+			/*
+			 * Improve fragment distribution and reduce our average
+			 * search time by starting our next search here. (see
+			 * Knuth vol 1, sec 2.5, pg 449)
+			 */
+			if (!list_is_first(&sp->lru, slob_list))
+				list_rotate_to_front(&sp->lru, slob_list);
+		}
 		break;
 	}
 	spin_unlock_irqrestore(&slob_lock, flags);
@@ -326,7 +349,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		INIT_LIST_HEAD(&sp->lru);
 		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
 		set_slob_page_free(sp, slob_list);
-		b = slob_page_alloc(sp, size, align);
+		b = slob_page_alloc(sp, size, align, &_unused);
 		BUG_ON(!b);
 		spin_unlock_irqrestore(&slob_lock, flags);
 	}
-- 
2.21.0

