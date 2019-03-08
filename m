Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71382C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4660F20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050165;
	bh=reziMT9gYL8ccEKfI3IahToj8tuiHTpnooaoSExJ2AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFogX/q6yOh80njoZQ6N6CgJiE9lDIn1CgLKLp/sYr8Td4a7WnhqQALI/ZdEzTj2G
	 WSlnXABrblx+FQXtwMUoGst0HXYKs9728wV2EwiQ+WRxzDAfxt1Od97c1skezSr98q
	 PIk7xUeRV2e5+8MM9f16e4By6P5B5JL2FL9qsbec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfCHNCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbfCHM7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC34D20449;
        Fri,  8 Mar 2019 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049981;
        bh=reziMT9gYL8ccEKfI3IahToj8tuiHTpnooaoSExJ2AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OppcwdT8jqivjBPeQ6oZWdNUUAUIAbiOzn57kyhejY5nsj9z5VnUqs4wL601Kd44B
         DSMbK9mm7FMVhVCY49LDHnSXXMLPCsidSJ8nKcrEhVfqB8j+Kk+k5LzHMWKpmQET6K
         2iENm+gZV1kiwPv+wOxypQopA0r0bvOK9ecDyp8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 47/68] ipv4: Pass original device to ip_rcv_finish_core
Date:   Fri,  8 Mar 2019 13:50:17 +0100
Message-Id: <20190308124912.984347779@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -550,6 +550,7 @@ static void ip_list_rcv_finish(struct ne
 
 	INIT_LIST_HEAD(&sublist);
 	list_for_each_entry_safe(skb, next, head, list) {
+		struct net_device *dev = skb->dev;
 		struct dst_entry *dst;
 
 		skb_list_del_init(skb);
@@ -559,7 +560,7 @@ static void ip_list_rcv_finish(struct ne
 		skb = l3mdev_ip_rcv(skb);
 		if (!skb)
 			continue;
-		if (ip_rcv_finish_core(net, sk, skb) == NET_RX_DROP)
+		if (ip_rcv_finish_core(net, sk, skb, dev) == NET_RX_DROP)
 			continue;
 
 		dst = skb_dst(skb);


