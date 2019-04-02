Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C2C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EDE2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246401;
	bh=UBfA9Qej3J7d2TAAwsQ8LTFTzHypCSFnphYEEXKe57Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sO1n/XkuLQvVPGLEBbqt7ZB7H+05MFk/yBFktdtzjK9pzKCgpPoI3h0Jy9WiZ0N/6
	 7Pv8hDHYz52jFORopd8lZKAEvb3zOI1MpIH8LrzP8lPBkPFI+t2vNpX2NI74qCfoOx
	 sn8zGZky7S4leD8zNFegRAxfUVugHCDEu85yU02A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDBXGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:06:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57715 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:06:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id ACCEC21EF6;
        Tue,  2 Apr 2019 19:06:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2019 19:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3K2yhT+sszNfHiVNPV2b/RN3GQNa8ZJypdeBAdHjZ+U=; b=J+ufpkhH
        vZEfzYhN14fxy08UgL7zicdFN3w19iPwhvtvHDyyFGhp+th9Y4H+bs59zZ/lCEYf
        sAuMzO0kEdX0d6MrM7j3VVadRO79mpKP0OeBSX9X+7XR3fTJ2yz68brwxGaHSN7/
        D2xQ5Gzp5OpC+9JndF8XHSE37m6iEO2seUGEasvV+WqttsN3o24s6pa2VLPj8TSP
        Cpfyi7lPHhEFsybWnMCnfT/5akQtQ0uPXoTCed5EXmf51gCcEe07hzG7E6OEhOU2
        3GN76kSDFAZda6mmChVz1dzZRZlbm5d40Y35rHyhWSbQtkAo37gq3JbRjTmTVTn0
        Q+qfUXPIXyCO/Q==
X-ME-Sender: <xms:_eqjXJy3zwZs_ahB6UQ_BEvLuU6tdjzStnCRjXsV4eea_IMhqYefNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdduieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedu
X-ME-Proxy: <xmx:_eqjXBMMLhXtM191LHPlc4_z5CufHr_QDkcw19WD646QXhHTuarIvg>
    <xmx:_eqjXKg_nhTplalxG3T6P8xEKtsoaX9MuVjpKCLNX9UUMNTMsCebrQ>
    <xmx:_eqjXB9oVWjAUi1xIHpRutQ89xoEYYdYgEcy_ls15zqPBPWacqSiMw>
    <xmx:_eqjXI4-vMRehLp7b2vI8NnJALmfgnTlWWcxqVudcSRMNOefiOOiFA>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 212961031A;
        Tue,  2 Apr 2019 19:06:33 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/7] slob: Use slab_list instead of lru
Date:   Wed,  3 Apr 2019 10:05:41 +1100
Message-Id: <20190402230545.2929-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402230545.2929-1-tobin@kernel.org>
References: <20190402230545.2929-1-tobin@kernel.org>
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
 mm/slob.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 07356e9feaaa..84aefd9b91ee 100644
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
 
@@ -298,7 +298,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 
 	spin_lock_irqsave(&slob_lock, flags);
 	/* Iterate through each partially free page, try to find room */
-	list_for_each_entry(sp, slob_list, lru) {
+	list_for_each_entry(sp, slob_list, slab_list) {
 		bool page_removed_from_list = false;
 #ifdef CONFIG_NUMA
 		/*
@@ -328,8 +328,8 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 			 * search time by starting our next search here. (see
 			 * Knuth vol 1, sec 2.5, pg 449)
 			 */
-			if (!list_is_first(&sp->lru, slob_list))
-				list_rotate_to_front(&sp->lru, slob_list);
+			if (!list_is_first(&sp->slab_list, slob_list))
+				list_rotate_to_front(&sp->slab_list, slob_list);
 		}
 		break;
 	}
@@ -346,7 +346,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		spin_lock_irqsave(&slob_lock, flags);
 		sp->units = SLOB_UNITS(PAGE_SIZE);
 		sp->freelist = b;
-		INIT_LIST_HEAD(&sp->lru);
+		INIT_LIST_HEAD(&sp->slab_list);
 		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
 		set_slob_page_free(sp, slob_list);
 		b = slob_page_alloc(sp, size, align, &_unused);
-- 
2.21.0

