Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1040C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEFB27F83
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553434;
	bh=+LOt4TjRkn7igKwk5B5UOFUfZvRSeUUEQE2fUSPJPdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vnC+GTTH9SJhhDtHGZEDRdTuBXmUnjJdTAITaJFT4AS4qNswFY8UhhnYuxfdg09eF
	 tgSJWMYxS7IZXLY5z0/qO8zmmwphoPkuAoj5QSC/mZCmSZc+mzzXOKiSrjo/LcGyKA
	 V/YexhYVTWCqY3qMe+IUozXy/f4NDHHiZUGDrlO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfFCJLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFCJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:11:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD0E27E65;
        Mon,  3 Jun 2019 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553105;
        bh=+LOt4TjRkn7igKwk5B5UOFUfZvRSeUUEQE2fUSPJPdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2K03YdF4maOf8sThtAANtEYc/tuc3OHtmML9Y3W+IigNoszA3cJ97aR2vwqwzi30p
         tv2wxWL6PDXiXZqENARRFzo0p0crbg5tHokTrVDRdKS7Tra2n0Fx4u2sI7efWyca3+
         NCIrND1qlX2WkS5cSxDX6CkwvcmupLGz9QhS8lbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Amit Klein <aksecurity@gmail.com>,
        Benny Pinkas <benny@pinkas.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 03/36] inet: switch IP ID generator to siphash
Date:   Mon,  3 Jun 2019 11:08:51 +0200
Message-Id: <20190603090521.191098392@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
References: <20190603090520.998342694@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit df453700e8d81b1bdafdf684365ee2b9431fb702 ]

According to Amit Klein and Benny Pinkas, IP ID generation is too weak
and might be used by attackers.

Even with recent net_hash_mix() fix (netns: provide pure entropy for net_hash_mix())
having 64bit key and Jenkins hash is risky.

It is time to switch to siphash and its 128bit keys.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Benny Pinkas <benny@pinkas.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/siphash.h  |    5 +++++
 include/net/netns/ipv4.h |    2 ++
 net/ipv4/route.c         |   12 +++++++-----
 net/ipv6/output_core.c   |   30 ++++++++++++++++--------------
 4 files changed, 30 insertions(+), 19 deletions(-)

--- a/include/linux/siphash.h
+++ b/include/linux/siphash.h
@@ -21,6 +21,11 @@ typedef struct {
 	u64 key[2];
 } siphash_key_t;
 
+static inline bool siphash_key_is_zero(const siphash_key_t *key)
+{
+	return !(key->key[0] | key->key[1]);
+}
+
 u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key);
 #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key);
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -9,6 +9,7 @@
 #include <linux/uidgid.h>
 #include <net/inet_frag.h>
 #include <linux/rcupdate.h>
+#include <linux/siphash.h>
 
 struct tcpm_hash_bucket;
 struct ctl_table_header;
@@ -217,5 +218,6 @@ struct netns_ipv4 {
 	unsigned int	ipmr_seq;	/* protected by rtnl_mutex */
 
 	atomic_t	rt_genid;
+	siphash_key_t	ip_id_key;
 };
 #endif
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -500,15 +500,17 @@ EXPORT_SYMBOL(ip_idents_reserve);
 
 void __ip_select_ident(struct net *net, struct iphdr *iph, int segs)
 {
-	static u32 ip_idents_hashrnd __read_mostly;
 	u32 hash, id;
 
-	net_get_random_once(&ip_idents_hashrnd, sizeof(ip_idents_hashrnd));
+	/* Note the following code is not safe, but this is okay. */
+	if (unlikely(siphash_key_is_zero(&net->ipv4.ip_id_key)))
+		get_random_bytes(&net->ipv4.ip_id_key,
+				 sizeof(net->ipv4.ip_id_key));
 
-	hash = jhash_3words((__force u32)iph->daddr,
+	hash = siphash_3u32((__force u32)iph->daddr,
 			    (__force u32)iph->saddr,
-			    iph->protocol ^ net_hash_mix(net),
-			    ip_idents_hashrnd);
+			    iph->protocol,
+			    &net->ipv4.ip_id_key);
 	id = ip_idents_reserve(hash, segs);
 	iph->id = htons(id);
 }
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -10,15 +10,25 @@
 #include <net/secure_seq.h>
 #include <linux/netfilter.h>
 
-static u32 __ipv6_select_ident(struct net *net, u32 hashrnd,
+static u32 __ipv6_select_ident(struct net *net,
 			       const struct in6_addr *dst,
 			       const struct in6_addr *src)
 {
+	const struct {
+		struct in6_addr dst;
+		struct in6_addr src;
+	} __aligned(SIPHASH_ALIGNMENT) combined = {
+		.dst = *dst,
+		.src = *src,
+	};
 	u32 hash, id;
 
-	hash = __ipv6_addr_jhash(dst, hashrnd);
-	hash = __ipv6_addr_jhash(src, hash);
-	hash ^= net_hash_mix(net);
+	/* Note the following code is not safe, but this is okay. */
+	if (unlikely(siphash_key_is_zero(&net->ipv4.ip_id_key)))
+		get_random_bytes(&net->ipv4.ip_id_key,
+				 sizeof(net->ipv4.ip_id_key));
+
+	hash = siphash(&combined, sizeof(combined), &net->ipv4.ip_id_key);
 
 	/* Treat id of 0 as unset and if we get 0 back from ip_idents_reserve,
 	 * set the hight order instead thus minimizing possible future
@@ -41,7 +51,6 @@ static u32 __ipv6_select_ident(struct ne
  */
 __be32 ipv6_proxy_select_ident(struct net *net, struct sk_buff *skb)
 {
-	static u32 ip6_proxy_idents_hashrnd __read_mostly;
 	struct in6_addr buf[2];
 	struct in6_addr *addrs;
 	u32 id;
@@ -53,11 +62,7 @@ __be32 ipv6_proxy_select_ident(struct ne
 	if (!addrs)
 		return 0;
 
-	net_get_random_once(&ip6_proxy_idents_hashrnd,
-			    sizeof(ip6_proxy_idents_hashrnd));
-
-	id = __ipv6_select_ident(net, ip6_proxy_idents_hashrnd,
-				 &addrs[1], &addrs[0]);
+	id = __ipv6_select_ident(net, &addrs[1], &addrs[0]);
 	return htonl(id);
 }
 EXPORT_SYMBOL_GPL(ipv6_proxy_select_ident);
@@ -66,12 +71,9 @@ __be32 ipv6_select_ident(struct net *net
 			 const struct in6_addr *daddr,
 			 const struct in6_addr *saddr)
 {
-	static u32 ip6_idents_hashrnd __read_mostly;
 	u32 id;
 
-	net_get_random_once(&ip6_idents_hashrnd, sizeof(ip6_idents_hashrnd));
-
-	id = __ipv6_select_ident(net, ip6_idents_hashrnd, daddr, saddr);
+	id = __ipv6_select_ident(net, daddr, saddr);
 	return htonl(id);
 }
 EXPORT_SYMBOL(ipv6_select_ident);


