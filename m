Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6589AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37444206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552266527;
	bh=zxWKAbS1fUm7FpkmNqD5Ca6uc3FLeCfdkfmm3+bYnJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fygdstomxqFI4fwZpWv2m5ILcs1QFri7eHBd7JNwlrLOHc+yepmixN8EsObJhswRf
	 3+ItUnNmz3ikiNv8xQupEtSABKZvYYpUTD87nhdnJGKRkq6uUS8kXDC6qHMhbGP1zM
	 o6fdWWOlJSRP9cdTYAxxalhVq++eo5dYw64id5Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCKBIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:08:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33697 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbfCKBId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:08:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 52BC521F86;
        Sun, 10 Mar 2019 21:08:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Mar 2019 21:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zLp9xmyRL5FGSf3lybn7avPXaeiP5CieRjoPUWOw1UY=; b=2EJQ+BG+
        Wfxvf5TF8zZb4G4z2IhbAoh5oBkt3SQlgxYO3tIAq+MxHR08gW+uZZ8AAfTd69o5
        3ykj1DSQCSs0smdS8cJ+CUxT5d1IijEGr+UEjS03bkm1vFfsQQWUxQKAbVskNLKN
        mRzUbFBzHZIpGP7N2eC5Uf4GFQcefWMD7QOEVUmZOfAQLOxJUh0BrmuUInXhfF5T
        5Dur9NdWoOTWxukjO+CTE+XJ+HMZy4TrXiN8k/wuhYLk1+QeE37r40TPgeOgBMhP
        co69JcKtfJWuM7VW/puE7lOdFRkjmXp6+Ef6zG3rIa73lrgbdGb8ATZX7zJR81Mb
        p4oO0l0FDrCXTw==
X-ME-Sender: <xms:ELWFXGuYUpdG__mG4R7_mE-NQQp32ROSIxvotozOPmzIp11Sbf4Fiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelvddrieeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:ELWFXOpXnO07wEEAZG9LB9fay5XP41VtwW7zkCD_D5W_20mU87gVrg>
    <xmx:ELWFXN7GnxWF1fQyrisYc2ES2POZ0T0raJRznE4RyVbuWfsTTb7qNA>
    <xmx:ELWFXLokIx1EpLqGCdYscuq8YMmFe-86FqjoCp_CTp2Vi34MR87yEQ>
    <xmx:ELWFXNSxYNI_9q7Vb2wUI5KpLqCAx3CsGaxqTuaq71AGqoFJVV1-VQ>
Received: from eros.localdomain (ppp118-211-192-66.bras1.syd2.internode.on.net [118.211.192.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id 327CB10310;
        Sun, 10 Mar 2019 21:08:28 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] slob: Use slab_list instead of lru
Date:   Mon, 11 Mar 2019 12:07:44 +1100
Message-Id: <20190311010744.5862-5-tobin@kernel.org>
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

