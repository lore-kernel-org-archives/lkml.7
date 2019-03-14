Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A738A2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552541538;
	bh=Y3zIRN/frafIL/QPWGI/o8+XQYEXMw5kzoOySUlGYhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CInPQrSRct2iihnrXvPfOOLu0Pe9e/kCTVVZ5OWGq+H11BLF5QUfOANu2wYZZSD7A
	 u8Bmkn96aQGr2JwWChONcTlT36ofIyuNfO1eVAL5rd5XIMLxgHn1T4yWjwHZcnzU5y
	 WmOf+5DeR9NqBd394N8sGDXy2PesmfE3XkBMdGaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNFcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:32:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40215 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfCNFcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:32:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D451E214E0;
        Thu, 14 Mar 2019 01:32:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Mar 2019 01:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=sj6M4OpXGBRvDdAJeVq0+fK1eLMRQBJtoq/YI75189Q=; b=TSUpdgdJ
        U3GaOh+0VR06/UhiUqmiX9hT+6ZjnnXKAd/Js9+MTL0QgE1EHJdHHK2qiVbaKqz+
        9x/aceEGdIi5Zx7jY0XgDwspMLIXFwIfN1fCI7XImr8D9a9K4ZgsSYi77c6i93+6
        Ne30IQLGZ8vdDHvEYK2BFfQdGZwgvVs5UcGp5qQiiRecuE5qAvK/2pzWolFGTbAV
        oA8l06zPSt2HkHj8SJDWOqf0noK8QjPFzw49MmzYcV8mYQbEBBVmWD78jWlTCCk8
        TOwjKGiJ38u6yR/RusWV0dMP7X6q7SW4jHeHuNRv10Dyv9UXLraivrZe7fksUEAL
        RbDhew6o9XGaLw==
X-ME-Sender: <xms:XOeJXHSkCT9nnNDxNco8BxiT6BzRP-lhb1-r-lxomDzQvDcin4HV1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:XOeJXNoUnTDEupa0Xn4oeuGFV95svUdh6R07YlAgR4pE1aW58HvcQg>
    <xmx:XOeJXFYF4kt_UN3Fok6W3fTt_vVbqvfsu3Wjc_7wsd5kEWmye2leAw>
    <xmx:XOeJXITYUrsUTLxVpaEDctTFxTTybIQwCZIhaHNtkoaHr3QEFrP5wQ>
    <xmx:XOeJXHERyhLfvf-Iv4c-SniqugI407BgdWEoYM4Su0A9gXRb07Fkgw>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43937E415C;
        Thu, 14 Mar 2019 01:32:08 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] slob: Respect list_head abstraction layer
Date:   Thu, 14 Mar 2019 16:31:30 +1100
Message-Id: <20190314053135.1541-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314053135.1541-1-tobin@kernel.org>
References: <20190314053135.1541-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we reach inside the list_head.  This is a violation of the
layer of abstraction provided by the list_head.  It makes the code
fragile.  More importantly it makes the code wicked hard to understand.

The code logic is based on the page in which an allocation was made, we
want to modify the slob_list we are working on to have this page at the
front.  We already have a function to check if an entry is at the front
of the list.  Recently a function was added to list.h to do the list
rotation. We can use these two functions to reduce line count, reduce
code fragility, and reduce cognitive load required to read the code.

Use list_head functions to interact with lists thereby maintaining the
abstraction provided by the list_head structure.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

I verified the comment pointing to Knuth, the page number may be out of
date but with this comment I was able to find the text that discusses
this, left the comment as is (after fixing style).

 mm/slob.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 307c2c9feb44..39ad9217ffea 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -268,8 +268,7 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
  */
 static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 {
-	struct page *sp;
-	struct list_head *prev;
+	struct page *sp, *prev, *next;
 	struct list_head *slob_list;
 	slob_t *b = NULL;
 	unsigned long flags;
@@ -296,18 +295,27 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		if (sp->units < SLOB_UNITS(size))
 			continue;
 
+		/*
+		 * Cache previous entry because slob_page_alloc() may
+		 * remove sp from slob_list.
+		 */
+		prev = list_prev_entry(sp, lru);
+
 		/* Attempt to alloc */
-		prev = sp->lru.prev;
 		b = slob_page_alloc(sp, size, align);
 		if (!b)
 			continue;
 
-		/* Improve fragment distribution and reduce our average
+		next = list_next_entry(prev, lru); /* This may or may not be sp */
+
+		/*
+		 * Improve fragment distribution and reduce our average
 		 * search time by starting our next search here. (see
-		 * Knuth vol 1, sec 2.5, pg 449) */
-		if (prev != slob_list->prev &&
-				slob_list->next != prev->next)
-			list_move_tail(slob_list, prev->next);
+		 * Knuth vol 1, sec 2.5, pg 449)
+		 */
+		if (!list_is_first(&next->lru, slob_list))
+			list_rotate_to_front(&next->lru, slob_list);
+
 		break;
 	}
 	spin_unlock_irqrestore(&slob_lock, flags);
-- 
2.21.0

