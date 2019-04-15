Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EAF218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355474;
	bh=qoX3PzjF7Dqk1qH2BhxXXBKIO6YPZETPHbHpfbAla0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0d9WAmd9frdAGh0tzusi/RI+M/pZ9vJfHCzBxAZzdFcvo09AcF2JOyUX48Ys/AGF3
	 fWi6a/6eyvNCAZhzvVXT4muy91uqkTUzvZwjAo71ZB20LL71EOOBOq8ZkTaNJSBEYB
	 ilz9EV9tIkPOtBaJ1WZDD3xQc+3Gpf+j1r8mPuSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfDOTLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731153AbfDOTLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76886218A1;
        Mon, 15 Apr 2019 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355470;
        bh=qoX3PzjF7Dqk1qH2BhxXXBKIO6YPZETPHbHpfbAla0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfI8LQdO/p1ysgOZuxIdXV3o20Xqp7jXxqVKNkQ1Bhmdo6X38eeFIy6C0OYk6fvMw
         N5q1HVuHiyt5z/q7+NgC12BlTEE//3utTPiiTSpLX/Rwulj3sx2Uv1xpzx7oYKaqVB
         +x6yX0ZPxS77z/dGhnUpMAohBwOVbeE8ikHjTq5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 033/117] net: ip6_gre: fix possible use-after-free in ip6erspan_rcv
Date:   Mon, 15 Apr 2019 21:00:03 +0200
Message-Id: <20190415183746.663885941@linuxfoundation.org>
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

[ Upstream commit 2a3cabae4536edbcb21d344e7aa8be7a584d2afb ]

erspan_v6 tunnels run __iptunnel_pull_header on received skbs to remove
erspan header. This can determine a possible use-after-free accessing
pkt_md pointer in ip6erspan_rcv since the packet will be 'uncloned'
running pskb_expand_head if it is a cloned gso skb (e.g if the packet has
been sent though a veth device). Fix it resetting pkt_md pointer after
__iptunnel_pull_header

Fixes: 1d7e2ed22f8d ("net: erspan: refactor existing erspan code")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 26f25b6e2833..438f1a5fd19a 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -524,11 +524,10 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 	return PACKET_REJECT;
 }
 
-static int ip6erspan_rcv(struct sk_buff *skb, int gre_hdr_len,
-			 struct tnl_ptk_info *tpi)
+static int ip6erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
+			 int gre_hdr_len)
 {
 	struct erspan_base_hdr *ershdr;
-	struct erspan_metadata *pkt_md;
 	const struct ipv6hdr *ipv6h;
 	struct erspan_md2 *md2;
 	struct ip6_tnl *tunnel;
@@ -547,18 +546,16 @@ static int ip6erspan_rcv(struct sk_buff *skb, int gre_hdr_len,
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 
-		ershdr = (struct erspan_base_hdr *)skb->data;
-		pkt_md = (struct erspan_metadata *)(ershdr + 1);
-
 		if (__iptunnel_pull_header(skb, len,
 					   htons(ETH_P_TEB),
 					   false, false) < 0)
 			return PACKET_REJECT;
 
 		if (tunnel->parms.collect_md) {
+			struct erspan_metadata *pkt_md, *md;
 			struct metadata_dst *tun_dst;
 			struct ip_tunnel_info *info;
-			struct erspan_metadata *md;
+			unsigned char *gh;
 			__be64 tun_id;
 			__be16 flags;
 
@@ -571,6 +568,14 @@ static int ip6erspan_rcv(struct sk_buff *skb, int gre_hdr_len,
 			if (!tun_dst)
 				return PACKET_REJECT;
 
+			/* skb can be uncloned in __iptunnel_pull_header, so
+			 * old pkt_md is no longer valid and we need to reset
+			 * it
+			 */
+			gh = skb_network_header(skb) +
+			     skb_network_header_len(skb);
+			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
+							    sizeof(*ershdr));
 			info = &tun_dst->u.tun_info;
 			md = ip_tunnel_info_opts(info);
 			md->version = ver;
@@ -607,7 +612,7 @@ static int gre_rcv(struct sk_buff *skb)
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, hdr_len, &tpi) == PACKET_RCVD)
+		if (ip6erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
-- 
2.19.1



