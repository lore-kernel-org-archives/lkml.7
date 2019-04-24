Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC90C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0F20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129543;
	bh=NW9CxUf+rz3n5ng2Quu2wbGE1uAwkncSz3gCLdXVzSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=taZ7Tl361Au3QY5024sr6yLd1ws/03rKtgucCzD+TKcp172eLZZHtiJfOeAmEWwXM
	 aP9aRU0guqFX7xfARZfVn+4xNQcsh21jUtFeZIFy34mmp0Eg2NtsAE8pLYffuxYRUz
	 0Bw3VOvxOoBATufJiQ0uzmgo9tOYEz6Cub8bs2v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfDXRM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387733AbfDXRM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6F421900;
        Wed, 24 Apr 2019 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125975;
        bh=NW9CxUf+rz3n5ng2Quu2wbGE1uAwkncSz3gCLdXVzSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rn94cWq9gjsNz6OL5ohkl53+Ji0c7zZJ5lj7mkTPvcR+2QKgTmCH6i/UsAWF9NI8L
         QWN/+T3WkWOFtWaCH7SelyDAS+xiQKvJOYQlVRwlyJQFyULv1ln6EmvSh4nx8PgHt5
         iZhMIBZj1FBCdAZNH5xbE2B5T/nttl//lOs9xpa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Amit Klein <aksecurity@gmail.com>,
        Benny Pinkas <benny@pinkas.net>,
        Pavel Emelyanov <xemul@openvz.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 049/104] netns: provide pure entropy for net_hash_mix()
Date:   Wed, 24 Apr 2019 19:09:06 +0200
Message-Id: <20190424170901.247037421@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
 include/net/net_namespace.h |    2 ++
 include/net/netns/hash.h    |   15 ++-------------
 net/core/net_namespace.c    |    1 +
 3 files changed, 5 insertions(+), 13 deletions(-)

--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -54,6 +54,8 @@ struct net {
 #endif
 	spinlock_t		rules_mod_lock;
 
+	u32			hash_mix;
+
 	struct list_head	list;		/* list of network namespaces */
 	struct list_head	cleanup_list;	/* namespaces on death row */
 	struct list_head	exit_list;	/* Use only net_mutex */
--- a/include/net/netns/hash.h
+++ b/include/net/netns/hash.h
@@ -1,21 +1,10 @@
 #ifndef __NET_NS_HASH_H__
 #define __NET_NS_HASH_H__
 
-#include <asm/cache.h>
-
-struct net;
+#include <net/net_namespace.h>
 
 static inline unsigned int net_hash_mix(struct net *net)
 {
-#ifdef CONFIG_NET_NS
-	/*
-	 * shift this right to eliminate bits, that are
-	 * always zeroed
-	 */
-
-	return (unsigned)(((unsigned long)net) >> L1_CACHE_SHIFT);
-#else
-	return 0;
-#endif
+	return net->hash_mix;
 }
 #endif
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -156,6 +156,7 @@ static __net_init int setup_net(struct n
 
 	atomic_set(&net->count, 1);
 	atomic_set(&net->passive, 1);
+	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 


