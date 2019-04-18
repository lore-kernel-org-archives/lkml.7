Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C582120643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbfDRSFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:05:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:41800 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391218AbfDRSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:06 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hHBP8-0005BU-UQ; Thu, 18 Apr 2019 21:04:59 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 3/4] net/skbuff: remove unused skb_propagate_pfmemalloc()
Date:   Thu, 18 Apr 2019 21:05:23 +0300
Message-Id: <20190418180524.23489-3-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418180524.23489-1-aryabinin@virtuozzo.com>
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_propagate_pfmemalloc() never has been used, remove it.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/skbuff.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 676e54f84de4..bda9d0865a25 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2847,18 +2847,6 @@ static inline struct page *dev_alloc_page(void)
 	return dev_alloc_pages(0);
 }
 
-/**
- *	skb_propagate_pfmemalloc - Propagate pfmemalloc if skb is allocated after RX page
- *	@page: The page that was allocated from skb_alloc_page
- *	@skb: The skb that may need pfmemalloc set
- */
-static inline void skb_propagate_pfmemalloc(struct page *page,
-					     struct sk_buff *skb)
-{
-	if (page_is_pfmemalloc(page))
-		skb->pfmemalloc = true;
-}
-
 /**
  * skb_frag_page - retrieve the page referred to by a paged fragment
  * @frag: the paged fragment
-- 
2.21.0

