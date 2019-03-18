Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB053C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552867416;
	bh=eCmJjyr44FE+G2O+HjhdABzN3Spbmhvj+pnlTTMQybk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kagx8oqb4vKWEesO4BvfBhMEWer1RlCem5b0wgwKFeKyGpYV9TddhqdHUuyn+VIsK
	 avZ9BfiI0fyK0Tu872ECEx9bQ8w5fccg3Ah0eXB9KlHFgvX5+f9c7NayYfgfYTPdvf
	 /idhX8UJZ3BrFxngLL1YSwGlg9bfulclibVNDUUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfCRADf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:03:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60189 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfCRADd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:03:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 62E7C2144B;
        Sun, 17 Mar 2019 20:03:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 17 Mar 2019 20:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AeBIbLH/k+PlVuOhUlPjQBBvHXf9fNsgIcyOzJV+yJ0=; b=ssQMkIrB
        shXlcEPj1zP9UfU1fj0Oei9LBB0KeFE5A3iLgetR/WeVzb7Ui21UYJCUEt/zlmyG
        WD+edggAXX3g68bBpYjxNFFBekbcOljvZy1iIUd+Z8skU7tkqfeyUjng+GXNk4lT
        jskjvl50U/HHP/3WcEZjXUJIgDuMc/ua5bdMAWtuZ1uXKq5IqRyk6nde71StXtfy
        ghb3gact3LCB5wqjHC6BA9oniV0WxEGb9q9Qkk5iTk4k9kg1S3xJ6gJmguAlMSNd
        +4Q4XgEIglaNd+Iz3fS5hwxHkd7WUsO5lMJ46EbLXWSCrG29lXXLgj02j7S4mC2Z
        sjB1xFsQInYrrQ==
X-ME-Sender: <xms:VOCOXMjEUvcWtF3vhL9ifJ-oA0F1g7UfdjtvzyvTZ17FejjX8-xzQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelledruddvieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:VOCOXDeVWU8CcT_tj0UgmqIaOpC0lgDjt-FDTgU8jNO-ppGmm15FAA>
    <xmx:VOCOXBdmYsOiwoVCNkb44hq4nzJT6wiIyXEvYsf06RrAG_I-UdcaEQ>
    <xmx:VOCOXAencl0O4s9kniNtEfSEvREO4dc4B5-2y_zo5p5IjfvKm0RCAQ>
    <xmx:VOCOXHewi5PHD6yNt_vpEQgOFkf6jjvA6HnV341c-Vm5mLl8kAdIRA>
Received: from eros.localdomain (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5B9CE4581;
        Sun, 17 Mar 2019 20:03:28 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] slob: Respect list_head abstraction layer
Date:   Mon, 18 Mar 2019 11:02:29 +1100
Message-Id: <20190318000234.22049-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318000234.22049-1-tobin@kernel.org>
References: <20190318000234.22049-1-tobin@kernel.org>
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

