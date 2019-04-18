Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D03C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C1C2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbfDRSZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:25:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:41798 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391219AbfDRSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:06 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hHBP8-0005BU-FO; Thu, 18 Apr 2019 21:04:58 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 1/4] net/skbuff: don't waste memory reserves
Date:   Thu, 18 Apr 2019 21:05:21 +0300
Message-Id: <20190418180524.23489-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some workloads we have noticed packets being dropped by
sk_filter_trim_cap() because the 'skb' was allocated from pfmemalloc
reserves:

	/*
	 * If the skb was allocated from pfmemalloc reserves, only
	 * allow SOCK_MEMALLOC sockets to use it as this socket is
	 * helping free memory
	 */
	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
		return -ENOMEM;
	}

Memalloc sockets are used for stuff like swap over NBD or NFS
and only memalloc sockets can process memalloc skbs. Since we
don't have any memalloc sockets in our setups we shouldn't have
memalloc skbs either. It simply doesn't make any sense to waste
memory reserves on skb which will be dropped anyway.

It appears that __dev_alloc_pages() unconditionally uses
__GFP_MEMALLOC, so unless caller added __GFP_NOMEMALLOC, the
__dev_alloc_pages() may dive into memory reserves.
Later build_skb() or __skb_fill_page_desc() sets skb->pfmemalloc = 1
so this skb always dropped by sk_filter_trim_cap().

Instead of wasting memory reserves we simply shouldn't use them in the
case of absence memalloc sockets in the system. Do this by adding
the  __GFP_MEMALLOC only when such socket is present in the system.

Fixes: 0614002bb5f7 ("netvm: propagate page->pfmemalloc from skb_alloc_page to skb")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/skbuff.h | 17 ++++++++++++++++-
 include/net/sock.h     | 15 ---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a06275a618f0..676e54f84de4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2784,6 +2784,19 @@ void napi_consume_skb(struct sk_buff *skb, int budget);
 void __kfree_skb_flush(void);
 void __kfree_skb_defer(struct sk_buff *skb);
 
+#ifdef CONFIG_NET
+DECLARE_STATIC_KEY_FALSE(memalloc_socks_key);
+static inline int sk_memalloc_socks(void)
+{
+	return static_branch_unlikely(&memalloc_socks_key);
+}
+#else
+static inline int sk_memalloc_socks(void)
+{
+	return 0;
+}
+#endif
+
 /**
  * __dev_alloc_pages - allocate page for network Rx
  * @gfp_mask: allocation priority. Set __GFP_NOMEMALLOC if not for network Rx
@@ -2804,7 +2817,9 @@ static inline struct page *__dev_alloc_pages(gfp_t gfp_mask,
 	 * 4.  __GFP_MEMALLOC is ignored if __GFP_NOMEMALLOC is set due to
 	 *     code in gfp_to_alloc_flags that should be enforcing this.
 	 */
-	gfp_mask |= __GFP_COMP | __GFP_MEMALLOC;
+	gfp_mask |=  __GFP_COMP;
+	if (sk_memalloc_socks())
+		gfp_mask |= __GFP_MEMALLOC;
 
 	return alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index bdd77bbce7d8..5b2138d47bd8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -838,21 +838,6 @@ static inline bool sock_flag(const struct sock *sk, enum sock_flags flag)
 	return test_bit(flag, &sk->sk_flags);
 }
 
-#ifdef CONFIG_NET
-DECLARE_STATIC_KEY_FALSE(memalloc_socks_key);
-static inline int sk_memalloc_socks(void)
-{
-	return static_branch_unlikely(&memalloc_socks_key);
-}
-#else
-
-static inline int sk_memalloc_socks(void)
-{
-	return 0;
-}
-
-#endif
-
 static inline gfp_t sk_gfp_mask(const struct sock *sk, gfp_t gfp_mask)
 {
 	return gfp_mask | (sk->sk_allocation & __GFP_MEMALLOC);
-- 
2.21.0

