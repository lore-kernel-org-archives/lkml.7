Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74473C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499152186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391260AbfDRSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:05:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:41804 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390575AbfDRSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:06 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hHBP9-0005BU-2v; Thu, 18 Apr 2019 21:04:59 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 4/4] net/skbuff: kmalloc_reserve(): remove unused argument
Date:   Thu, 18 Apr 2019 21:05:24 +0300
Message-Id: <20190418180524.23489-4-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418180524.23489-1-aryabinin@virtuozzo.com>
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argument 'ip' always has been unused. Remove it.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 net/core/skbuff.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 97557554e90e..5cd067b44371 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -126,11 +126,8 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
  * may be used. Otherwise, the packet data may be discarded until enough
  * memory is free
  */
-#define kmalloc_reserve(size, gfp, node, pfmemalloc) \
-	 __kmalloc_reserve(size, gfp, node, _RET_IP_, pfmemalloc)
-
-static void *__kmalloc_reserve(size_t size, gfp_t flags, int node,
-			       unsigned long ip, bool *pfmemalloc)
+static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
+			     bool *pfmemalloc)
 {
 	void *obj;
 	gfp_t gfp_mask = flags;
-- 
2.21.0

