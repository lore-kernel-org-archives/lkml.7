Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1334C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07132184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552541546;
	bh=gUFJdsg6eQ+mMvsfm/Xzl1XNRpj/qNubIqZCpXclZlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D1c7vw6o8/AUDe7vXsM7k0uMCRxXBBF6DXbS6Ht/L1kPzaWCAM+6jxFx57xzaAG23
	 MYn2WlmTjk2epJScaoOPaz9TfQ0Qeda82xEk7HA1FI6onxmXO3qXfG6bjr/sKn092p
	 /O+di4TTRcYvWea8fnqxb62YdQ2lnb75ReLEg3H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCNFcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:32:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42949 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfCNFcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:32:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B4D962073F;
        Thu, 14 Mar 2019 01:32:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Mar 2019 01:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2eN7lydm96kcUslXdltVZiRHDPn/FxigSb7w12z8+Ik=; b=FTUT+ROK
        r7cdMFF2w62zmsE8vApTYJq9L8QrVsuNfDtT9fhKrKpLxkN2CX61Mddximwx9i1W
        VAISGqfybF8Ug6tna24R7iuAQx/Vc+79zTb8wKhHAy5wuL7O+IsHs6dOXD0Aejy2
        352XtRpl7RUevrbaK1t2IcqyTeBaP3N0Y06mf60HfN9SJ7NpEx6Y+1z+WUEZgPn1
        p910s13PA3qc2/26aw4YACDhrbpkHIOdkMZJZxidWQ/w/sudwK4sPmnhrGoUea3i
        70/Tw9nxOXh21VGK2PLrFpYbogNU4zvCCl0xDSsouLB+urfyJZ2XW4JvPKwZllVf
        y+WLfpABG0V1OA==
X-ME-Sender: <xms:YOeJXFXs9ogZ3iWR1b8kNUXTxZIMe-qdn-I-nPlFlDgRRFr5fk4LDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:YOeJXMhNH-KQMkjuMxmetz-GsilhhQZa7pehEkX9kUnr0BI8SgVcQg>
    <xmx:YOeJXGjqXE1WkIH06M5CFegSr1p2h5xxJfVA-MMm2s1bvtVytJM5xw>
    <xmx:YOeJXMvMIWilkq_XeqtB89ropeqjP1JVFvyelGgzO-My1KRpTAzh4Q>
    <xmx:YOeJXIUkJVC4FIz5lRC4yxrrIIy3vjCsn_ffeRORijt-klO8lXc2nw>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28FD1E415C;
        Thu, 14 Mar 2019 01:32:12 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] slob: Use slab_list instead of lru
Date:   Thu, 14 Mar 2019 16:31:31 +1100
Message-Id: <20190314053135.1541-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314053135.1541-1-tobin@kernel.org>
References: <20190314053135.1541-1-tobin@kernel.org>
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
 mm/slob.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 39ad9217ffea..94486c32e0ff 100644
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

