Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5E0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FA42087F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552867420;
	bh=GJoAA98DrZ5bNpnRcC3SZnEGmLidQqf2+pGPeojc/gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fgexMFCY/5nVGrbDWso6L2TbnD+lBDKp8HwhNizLB4wdvaNusoLXcD7eWgsCtlfKl
	 nbfqzxOb6oZOsonY09IFZW5PEiSjcskO4UVSWc7CWpLdruJLFHSBoeylyC/y56rbGh
	 NMO9a/TsMUhICk9iXNOv9T9hu4SmdOsX4QWgpn+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfCRADj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:03:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46699 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfCRADh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:03:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 85C5621B74;
        Sun, 17 Mar 2019 20:03:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 17 Mar 2019 20:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=NJ63LCCLaSV3iAE8Jn20nHVAI3AvEK5t29Xi1XCFI+c=; b=pCd6G5/s
        IXk6xU7bwSgPoncwBnY1rz9JSIIm3jsaPiDopQmEidYawkMK7P22Yrh69Lic82j/
        u29QWAJD0OVZ8ushlWC8j0Thl3bkX5t5WMeaBnvCjqgMG+E5CyUJceEHcgUch/vc
        tGUIA62xBGG942nyd9+f6PSF8ZrshTW04TVDPINKTivdbCeH671z63whT70e3tZQ
        OFKz+eOKCFkdaMKaOaT8BgDbV8il3f5757Pc/kv+n9BUVWTWnS6qYJJ2lMn6XMaG
        A5FK8BG9a9aIruxIjUYNEreotCLHsdRrgUlBLVcPCUitvd1X+ocgIvRp8y9YQ50a
        JmqbHTnrplbvdA==
X-ME-Sender: <xms:WOCOXMDtgJbU231kGnLLfSMfV_j8Q5-T-QUUB4bCpnrUGwu7mX72WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelledruddvieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:WOCOXMBqT8dBlqKlhHyriGce3wK1ySenV7K6rneGo-N_Kd7dfQy11Q>
    <xmx:WOCOXLoJLiphiWyhQiLY9z2kkBe8WKT3I_35ssKpZVLzAMhe3i5q3g>
    <xmx:WOCOXAAoQDST5s-Y_aZqCJsLricpgxVe9iJCNY4XFyihTbg1jA3ViA>
    <xmx:WOCOXOnGfetuCDmAaKYYNiOOqQLRmKHCqYWLINtwxcxxDSCpkOAlrw>
Received: from eros.localdomain (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A615E427B;
        Sun, 17 Mar 2019 20:03:32 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] slob: Use slab_list instead of lru
Date:   Mon, 18 Mar 2019 11:02:30 +1100
Message-Id: <20190318000234.22049-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318000234.22049-1-tobin@kernel.org>
References: <20190318000234.22049-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use the page->lru list for maintaining lists of slabs.  We
have a list_head in the page structure (slab_list) that can be used for
this purpose.  Doing so makes the code cleaner since we are not
overloading the lru list.

The slab_list is part of a union within the page struct (included here
stripped down):

	union {
		struct {	/* Page cache and anonymous pages */
			struct list_head lru;
			...
		};
		struct {
			dma_addr_t dma_addr;
		};
		struct {	/* slab, slob and slub */
			union {
				struct list_head slab_list;
				struct {	/* Partial pages */
					struct page *next;
					int pages;	/* Nr of pages left */
					int pobjects;	/* Approximate count */
				};
			};
		...

Here we see that slab_list and lru are the same bits.  We can verify
that this change is safe to do by examining the object file produced from
slob.c before and after this patch is applied.

Steps taken to verify:

 1. checkout current tip of Linus' tree

    commit a667cb7a94d4 ("Merge branch 'akpm' (patches from Andrew)")

 2. configure and build (select SLOB allocator)

    CONFIG_SLOB=y
    CONFIG_SLAB_MERGE_DEFAULT=y

 3. dissasemble object file `objdump -dr mm/slub.o > before.s
 4. apply patch
 5. build
 6. dissasemble object file `objdump -dr mm/slub.o > after.s
 7. diff before.s after.s

Use slab_list list_head instead of the lru list_head for maintaining
lists of slabs.

Reviewed-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slob.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 39ad9217ffea..21af3fdb457a 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -112,13 +112,13 @@ static inline int slob_page_free(struct page *sp)
 
 static void set_slob_page_free(struct page *sp, struct list_head *list)
 {
-	list_add(&sp->lru, list);
+	list_add(&sp->slab_list, list);
 	__SetPageSlobFree(sp);
 }
 
 static inline void clear_slob_page_free(struct page *sp)
 {
-	list_del(&sp->lru);
+	list_del(&sp->slab_list);
 	__ClearPageSlobFree(sp);
 }
 
@@ -282,7 +282,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 
 	spin_lock_irqsave(&slob_lock, flags);
 	/* Iterate through each partially free page, try to find room */
-	list_for_each_entry(sp, slob_list, lru) {
+	list_for_each_entry(sp, slob_list, slab_list) {
 #ifdef CONFIG_NUMA
 		/*
 		 * If there's a node specification, search for a partial
@@ -299,22 +299,22 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		 * Cache previous entry because slob_page_alloc() may
 		 * remove sp from slob_list.
 		 */
-		prev = list_prev_entry(sp, lru);
+		prev = list_prev_entry(sp, slab_list);
 
 		/* Attempt to alloc */
 		b = slob_page_alloc(sp, size, align);
 		if (!b)
 			continue;
 
-		next = list_next_entry(prev, lru); /* This may or may not be sp */
+		next = list_next_entry(prev, slab_list); /* This may or may not be sp */
 
 		/*
 		 * Improve fragment distribution and reduce our average
 		 * search time by starting our next search here. (see
 		 * Knuth vol 1, sec 2.5, pg 449)
 		 */
-		if (!list_is_first(&next->lru, slob_list))
-			list_rotate_to_front(&next->lru, slob_list);
+		if (!list_is_first(&next->slab_list, slob_list))
+			list_rotate_to_front(&next->slab_list, slob_list);
 
 		break;
 	}
@@ -331,7 +331,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		spin_lock_irqsave(&slob_lock, flags);
 		sp->units = SLOB_UNITS(PAGE_SIZE);
 		sp->freelist = b;
-		INIT_LIST_HEAD(&sp->lru);
+		INIT_LIST_HEAD(&sp->slab_list);
 		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
 		set_slob_page_free(sp, slob_list);
 		b = slob_page_alloc(sp, size, align);
-- 
2.21.0

