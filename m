Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83B82064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391495AbfDRSZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:25:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:41802 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390842AbfDRSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:06 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hHBP8-0005BU-Ll; Thu, 18 Apr 2019 21:04:58 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/4] net/skbuff: warn if kmalloc_reserve() fails to allocate memory.
Date:   Thu, 18 Apr 2019 21:05:22 +0300
Message-Id: <20190418180524.23489-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418180524.23489-1-aryabinin@virtuozzo.com>
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c93bdd0e03e8 ("netvm: allow skb allocation to use PFMEMALLOC reserves")
removed memory potential allocation failure messages in the cases when
pfmemalloc reserves are not allowed to be used. Inability to allocate
skb usually indicates some problem, e.g. these ones:

	commit 5d4c9bfbabdb ("tcp: fix potential huge kmalloc() calls in TCP_REPAIR")
	commit 19125c1a4fd8 ("net: use skb_clone to avoid alloc_pages failure.")

It makes sense to bring the warning back to make problems more obvious,
easier to spot. Also neighboring to kmalloc_reserve() allocations often
doesn't add __GFP_NOWARN. For example __alloc_skb():

	skb = kmem_cache_alloc_node(cache, gfp_mask & ~__GFP_DMA, node);
	...
	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);

It seems unreasonable to allow kmem_cache_alloc_node() to fail loudly but
forbid the same for the kmalloc_reserve().
So, don't add __GFP_NOWARN unless we can use fallback allocation with
__GFP_MEMALLOC.

Also remove __GFP_NOMEMALLOC when usage of memory reserves isn't allowed.
Many allocations on receive path use plain GFP_ATOMIC without adding
__GFP_NOMEMALLOC (again, see __alloc_skb()). Such allocations have greater chances
to succeed because plain GFP_ATOMIC can use 1/4 of memory reserves, while
GFP_ATOMIC|__GFP_NOMEMALLOC can't. So it's seems more reasonable to add
__GFP_NOMEMALLOC only if we have fallback to memory reserves.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 net/core/skbuff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a083e188374f..97557554e90e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -133,16 +133,19 @@ static void *__kmalloc_reserve(size_t size, gfp_t flags, int node,
 			       unsigned long ip, bool *pfmemalloc)
 {
 	void *obj;
+	gfp_t gfp_mask = flags;
 	bool ret_pfmemalloc = false;
+	bool pfmemalloc_allowed = gfp_pfmemalloc_allowed(flags);
 
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
 	 */
-	obj = kmalloc_node_track_caller(size,
-					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
-					node);
-	if (obj || !(gfp_pfmemalloc_allowed(flags)))
+	if (pfmemalloc_allowed)
+		gfp_mask |= __GFP_NOMEMALLOC | __GFP_NOWARN;
+
+	obj = kmalloc_node_track_caller(size, gfp_mask, node);
+	if (obj || !pfmemalloc_allowed)
 		goto out;
 
 	/* Try again but now we are using pfmemalloc reserves */
-- 
2.21.0

