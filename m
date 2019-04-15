Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC66C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1A820651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356338;
	bh=e37djG8SqYwWcoHhU5v/2hRNgoNb5BooMAO63WoHok8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=06RhNYpnqfyIuLced7M/cqi7u+RGUa55vsxBZ+7cOEPDUUjK3mUXuv2iC0Vn+P1hC
	 W5zXisLoajRLZB42pL0UYfxWK0OAKDqzZ0hIrdGTjifGc0RQom7/a2t+PrMMw+uSK/
	 3iN7GcB/nzWi3stykwxExNooK+UxgDqtUP9DtnUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfDOTZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfDOTFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F0C20880;
        Mon, 15 Apr 2019 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355122;
        bh=e37djG8SqYwWcoHhU5v/2hRNgoNb5BooMAO63WoHok8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kl9Qy4yFrDTQSwOplTInDoNxoY8e3R7scPv5JGYzRgUZaDjphwrxTyz7ptyKyU7Pa
         EtJRHPUvlQfN68kpzNqn0UX0kj7FVN2PlbqodqcOPgC4e9lnUUgE2cEp0+yqkbzTn/
         iUA87UZZo6T/ffAWOqkVppt6QIFCXx9h4R2Om9a0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Amit Klein <aksecurity@gmail.com>,
        Benny Pinkas <benny@pinkas.net>,
        Pavel Emelyanov <xemul@openvz.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/101] netns: provide pure entropy for net_hash_mix()
Date:   Mon, 15 Apr 2019 20:58:11 +0200
Message-Id: <20190415183741.075424358@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/net_namespace.h |  1 +
 include/net/netns/hash.h    | 10 ++--------
 net/core/net_namespace.c    |  1 +
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 9b5fdc50519a..3f7b166262d7 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -57,6 +57,7 @@ struct net {
 						 */
 	spinlock_t		rules_mod_lock;
 
+	u32			hash_mix;
 	atomic64_t		cookie_gen;
 
 	struct list_head	list;		/* list of network namespaces */
diff --git a/include/net/netns/hash.h b/include/net/netns/hash.h
index 16a842456189..d9b665151f3d 100644
--- a/include/net/netns/hash.h
+++ b/include/net/netns/hash.h
@@ -2,16 +2,10 @@
 #ifndef __NET_NS_HASH_H__
 #define __NET_NS_HASH_H__
 
-#include <asm/cache.h>
-
-struct net;
+#include <net/net_namespace.h>
 
 static inline u32 net_hash_mix(const struct net *net)
 {
-#ifdef CONFIG_NET_NS
-	return (u32)(((unsigned long)net) >> ilog2(sizeof(*net)));
-#else
-	return 0;
-#endif
+	return net->hash_mix;
 }
 #endif
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 670c84b1bfc2..7320f0844a50 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -304,6 +304,7 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 
 	refcount_set(&net->count, 1);
 	refcount_set(&net->passive, 1);
+	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 	idr_init(&net->netns_ids);
-- 
2.19.1



