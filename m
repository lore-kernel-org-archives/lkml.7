Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABB62087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049760;
	bh=5XEe1eTeHv+pS7czFd19eROf1oEed2SFkXpxswNA+PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fGPA05uQPoAb1gDl3ovUkdxgqFGjqmWziuf0Q5TkdA0AGaUi+2zqYzvrQd3ZtcXUd
	 EnEDp4cU7VOjAGtLOBgTYZzy0iHIvTuBjoiRHsmsCK0/DN2Wh9Z6YUx5OrYoKc7PCV
	 /GTrQjNsK9VHOCjoQMRJycp6fMwg+0iajjLGetVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCHMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfCHMz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26C420449;
        Fri,  8 Mar 2019 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049756;
        bh=5XEe1eTeHv+pS7czFd19eROf1oEed2SFkXpxswNA+PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3OoBHGUPkIAY/I5CxgvbqKfw7jxlXoZaXK1EE935YB0vaF6cJ0cVPvoX5wpYUdBo
         gDEiO+ZmorsVDExzVtjWtvviKmJD6IUjph+xsLZauBAesy4ahDqWVMcSkUm+8U2htu
         /kX4/0Yv3kJUkS5C8f0wtj4nNEj0RDHXQvPUePBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 54/76] ipv4: Pass original device to ip_rcv_finish_core
Date:   Fri,  8 Mar 2019 13:50:06 +0100
Message-Id: <20190308124916.717732887@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit a1fd1ad2552fad9e649eeb85fd79301e2880a886 ]

ip_route_input_rcu expects the original ingress device (e.g., for
proper multicast handling). The skb->dev can be changed by l3mdev_ip_rcv,
so dev needs to be saved prior to calling it. This was the behavior prior
to the listify changes.

Fixes: 5fa12739a53d0 ("net: ipv4: listify ip_rcv_finish")
Cc: Edward Cree <ecree@solarflare.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_input.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -308,11 +308,10 @@ drop:
 }
 
 static int ip_rcv_finish_core(struct net *net, struct sock *sk,
-			      struct sk_buff *skb)
+			      struct sk_buff *skb, struct net_device *dev)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	int (*edemux)(struct sk_buff *skb);
-	struct net_device *dev = skb->dev;
 	struct rtable *rt;
 	int err;
 
@@ -401,6 +400,7 @@ drop_error:
 
 static int ip_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
 	int ret;
 
 	/* if ingress device is enslaved to an L3 master device pass the
@@ -410,7 +410,7 @@ static int ip_rcv_finish(struct net *net
 	if (!skb)
 		return NET_RX_SUCCESS;
 
-	ret = ip_rcv_finish_core(net, sk, skb);
+	ret = ip_rcv_finish_core(net, sk, skb, dev);
 	if (ret != NET_RX_DROP)
 		ret = dst_input(skb);
 	return ret;
@@ -546,6 +546,7 @@ static void ip_list_rcv_finish(struct ne
 
 	INIT_LIST_HEAD(&sublist);
 	list_for_each_entry_safe(skb, next, head, list) {
+		struct net_device *dev = skb->dev;
 		struct dst_entry *dst;
 
 		skb_list_del_init(skb);
@@ -555,7 +556,7 @@ static void ip_list_rcv_finish(struct ne
 		skb = l3mdev_ip_rcv(skb);
 		if (!skb)
 			continue;
-		if (ip_rcv_finish_core(net, sk, skb) == NET_RX_DROP)
+		if (ip_rcv_finish_core(net, sk, skb, dev) == NET_RX_DROP)
 			continue;
 
 		dst = skb_dst(skb);


