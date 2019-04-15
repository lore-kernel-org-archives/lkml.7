Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA54AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A716020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355420;
	bh=HCDpqSv2ecceVF6ucEbuH2DN99NaF9GUzIdbj3Y9Ydo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPQWWB2ZZ3F3iJGmxlNxz6KHR8Ww/sTqagpsGzyUNmrJ764GeeQbFAJUm1AZQrg3z
	 9z6AeTPfZDEf3k5e/MLTuDzKhN3+ohqbMbBFgyYgEyWAJljNwOCPAOeFemDiUIEKDf
	 VXgtaNpymAZg/i5c0ysKQROiotMgJJn+5qJh3w60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfDOTKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbfDOTKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72DB218D3;
        Mon, 15 Apr 2019 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355411;
        bh=HCDpqSv2ecceVF6ucEbuH2DN99NaF9GUzIdbj3Y9Ydo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLkobY+6mmVHr9jPMjkJ6GzTcrqtiJdliGIfNVawX5B5loL/yBxTK44KPIfOyJZrp
         LK8djWWryUzurMWqAWzwdIc0M+2ZE0cBRIxy2DV1BGoDeOj5SG/tgy624LeY9uSOVf
         GLRqJNoJRFZ0RzIlHBCiX5IIQEMjQMuSEUnCfn1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 025/117] vrf: check accept_source_route on the original netdevice
Date:   Mon, 15 Apr 2019 20:59:55 +0200
Message-Id: <20190415183746.166879651@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c83f2df9c6578ea4c5b940d8238ad8a41b87e9e ]

Configuration check to accept source route IP options should be made on
the incoming netdevice when the skb->dev is an l3mdev master. The route
lookup for the source route next hop also needs the incoming netdev.

v2->v3:
- Simplify by passing the original netdevice down the stack (per David
  Ahern).

Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h      | 2 +-
 net/ipv4/ip_input.c   | 7 +++----
 net/ipv4/ip_options.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index be3cad9c2e4c..583526aad1d0 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -677,7 +677,7 @@ int ip_options_get_from_user(struct net *net, struct ip_options_rcu **optp,
 			     unsigned char __user *data, int optlen);
 void ip_options_undo(struct ip_options *opt);
 void ip_forward_options(struct sk_buff *skb);
-int ip_options_rcv_srr(struct sk_buff *skb);
+int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
 
 /*
  *	Functions provided by ip_sockglue.c
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 1f4737b77067..ccf0d31b6ce5 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -257,11 +257,10 @@ int ip_local_deliver(struct sk_buff *skb)
 		       ip_local_deliver_finish);
 }
 
-static inline bool ip_rcv_options(struct sk_buff *skb)
+static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip_options *opt;
 	const struct iphdr *iph;
-	struct net_device *dev = skb->dev;
 
 	/* It looks as overkill, because not all
 	   IP options require packet mangling.
@@ -297,7 +296,7 @@ static inline bool ip_rcv_options(struct sk_buff *skb)
 			}
 		}
 
-		if (ip_options_rcv_srr(skb))
+		if (ip_options_rcv_srr(skb, dev))
 			goto drop;
 	}
 
@@ -353,7 +352,7 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	}
 #endif
 
-	if (iph->ihl > 5 && ip_rcv_options(skb))
+	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
 		goto drop;
 
 	rt = skb_rtable(skb);
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index 32a35043c9f5..3db31bb9df50 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -612,7 +612,7 @@ void ip_forward_options(struct sk_buff *skb)
 	}
 }
 
-int ip_options_rcv_srr(struct sk_buff *skb)
+int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip_options *opt = &(IPCB(skb)->opt);
 	int srrspace, srrptr;
@@ -647,7 +647,7 @@ int ip_options_rcv_srr(struct sk_buff *skb)
 
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
-		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, skb->dev);
+		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, dev);
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
-- 
2.19.1



