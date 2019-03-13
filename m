Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B5F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552454486;
	bh=42gIq/hYXNzs43Y3q4Rwx65n3HY42N5F1KeLwLAdrvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e4FQXSoYbTRP8+XQXv+mo5OSTEbEVID+Cd627nXmLL0JdptkwGzhQJJOH8ocQ4ojj
	 9lrHgsJw2TqA7xs4GCHuSi1yPm+mtfA/MOzwEVWF/BlnO76qPvDuh8Pq7IfQpWqJPV
	 QrgMI4FdweqmwITspFkEHQb2ttYZT3bUFPRgeqII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCMFVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:21:24 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45735 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfCMFVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:21:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9D02838BD;
        Wed, 13 Mar 2019 01:21:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 01:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=aR78W31q72vxmgugCUO4zRYVwt/hNV8R2x/8ymYFgIU=; b=Y59tExhx
        GKNS4b5q5bZQhE8JfLu/yue+mnCE/qtxShZS6ONFIZCadUJmGwilY3O+AiZOo73g
        b6XQskb8KQcazK1o0Z9CCq5rHVGJv3fk4KfTwZWAw+cnC2Oxw9bSEGI9cdQKd8Rm
        BnlrynlD0UX/DNKn7kPHai/+kIufKApqtMtsEUlV/3i9jLyxk5jHjuykM7Z39/v6
        Y0TybJ/0+fOy8/+josus7cXyZ0N4e2lV/CTWgnkwDCDLcMnKmE6LorOlGsy7TOWP
        4vpxWGoWdYSYKjL18kPzkOXOgj0DA3OrHpOJNR+2y5hl1bx/3vrY9alD0UVeLpOD
        079JXKsVGxtmCQ==
X-ME-Sender: <xms:UJOIXG0LsPb3z2ZaDeWk8JKF8NWYyKh3JPzKpbzV1oezZVwLisuW-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:UJOIXNXA2eICJnOZOSA6gv3tAHoEgsFw-Xq5UAeJreWzbl1nVQKSow>
    <xmx:UJOIXJ5l_XWyLFLeLNRhCR_CQUcr4fUtcnRJMOv1aeIgVrmYQCCesg>
    <xmx:UJOIXMJB16a2FKJnZCKZJid8OD9nXYc8txYj4xv_0rocCiSXHkYwgQ>
    <xmx:UJOIXISiqNWFZLn_S7xLeo7r2hUrUeGCiRs0md9rMFxWhrtwsOgW_w>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7752E427E;
        Wed, 13 Mar 2019 01:21:16 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] slob: Use slab_list instead of lru
Date:   Wed, 13 Mar 2019 16:20:29 +1100
Message-Id: <20190313052030.13392-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313052030.13392-1-tobin@kernel.org>
References: <20190313052030.13392-1-tobin@kernel.org>
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
 mm/slob.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 307c2c9feb44..ee68ff2a2833 100644
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
 
@@ -283,7 +283,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 
 	spin_lock_irqsave(&slob_lock, flags);
 	/* Iterate through each partially free page, try to find room */
-	list_for_each_entry(sp, slob_list, lru) {
+	list_for_each_entry(sp, slob_list, slab_list) {
 #ifdef CONFIG_NUMA
 		/*
 		 * If there's a node specification, search for a partial
@@ -297,7 +297,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 			continue;
 
 		/* Attempt to alloc */
-		prev = sp->lru.prev;
+		prev = sp->slab_list.prev;
 		b = slob_page_alloc(sp, size, align);
 		if (!b)
 			continue;
@@ -323,7 +323,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
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

