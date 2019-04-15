Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99139C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656572087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355021;
	bh=+HBsefubRR+4ussTbLL2GPewZEX7PB/RSXikccQioFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJ24drKpHxs5AtxZmIWlqeHnitCad2Cn31/ZsRbEFlgx4E/MGSQNypINojDV8Q+Q3
	 5Wg0buR+yxb7uKp+dOD4IwhpaSsoKTa/l0srE7cob94Fr+dHWHkQVHIuPkcglLaDwM
	 jfRMki5iANOzV+mmNJ1hnwW2QyWebxcm2L56+tE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfDOTDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfDOTDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E4EF2087C;
        Mon, 15 Apr 2019 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355011;
        bh=+HBsefubRR+4ussTbLL2GPewZEX7PB/RSXikccQioFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nb/mIWxNq4BsgpsQQ/CfAPn8GoMlKbqAtpr0B53kxVbRtK+QDVK3KeGi4E1CTXtaM
         iqpG23Idcsp2CZ+cPXjQtP4chFZJ7BIwgn+rlG4uFDwiryrRVrKH9Hxr+qyluwOq3p
         4YgA/ZojJoqWZM/nKSbcFkSY+gGdyrF5WdxEIlaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Amit Klein <aksecurity@gmail.com>,
        Benny Pinkas <benny@pinkas.net>,
        Pavel Emelyanov <xemul@openvz.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 34/69] netns: provide pure entropy for net_hash_mix()
Date:   Mon, 15 Apr 2019 20:58:52 +0200
Message-Id: <20190415183731.933613890@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 355b98553789b646ed97ad801a619ff898471b92 ]

net_hash_mix() currently uses kernel address of a struct net,
and is used in many places that could be used to reveal this
address to a patient attacker, thus defeating KASLR, for
the typical case (initial net namespace, &init_net is
not dynamically allocated)

I believe the original implementation tried to avoid spending
too many cycles in this function, but security comes first.

Also provide entropy regardless of CONFIG_NET_NS.

Fixes: 0b4419162aa6 ("netns: introduce the net_hash_mix "salt" for hashes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Benny Pinkas <benny@pinkas.net>
Cc: Pavel Emelyanov <xemul@openvz.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/net_namespace.h |    1 +
 include/net/netns/hash.h    |   15 ++-------------
 net/core/net_namespace.c    |    1 +
 3 files changed, 4 insertions(+), 13 deletions(-)

--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -56,6 +56,7 @@ struct net {
 						 */
 	spinlock_t		rules_mod_lock;
 
+	u32			hash_mix;
 	atomic64_t		cookie_gen;
 
 	struct list_head	list;		/* list of network namespaces */
--- a/include/net/netns/hash.h
+++ b/include/net/netns/hash.h
@@ -2,21 +2,10 @@
 #ifndef __NET_NS_HASH_H__
 #define __NET_NS_HASH_H__
 
-#include <asm/cache.h>
-
-struct net;
+#include <net/net_namespace.h>
 
 static inline u32 net_hash_mix(const struct net *net)
 {
-#ifdef CONFIG_NET_NS
-	/*
-	 * shift this right to eliminate bits, that are
-	 * always zeroed
-	 */
-
-	return (u32)(((unsigned long)net) >> L1_CACHE_SHIFT);
-#else
-	return 0;
-#endif
+	return net->hash_mix;
 }
 #endif
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -285,6 +285,7 @@ static __net_init int setup_net(struct n
 
 	atomic_set(&net->count, 1);
 	refcount_set(&net->passive, 1);
+	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 	idr_init(&net->netns_ids);


