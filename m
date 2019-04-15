Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC2AC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941962087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355150;
	bh=74NF6t6x76by8bHCCmeDDrtQE+57CZunci9bkwuwZIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gnw+X87fwQgrPJrFwvdYsfrgftBPMbbP9T8/2yt/dZZwnM/aNLFQXZiZlQJrEVYK4
	 Y5Um9LJO9VCw0L+U7uynagg9nV7/gmNV8ZZQnn1NUlfO/14mb9sKoVDF5YHf/FAUR6
	 dDUrnRjWRuBQQjUNLCEm/KoTvjGeuCG/Bok8k82o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfDOTFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfDOTFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764B72087C;
        Mon, 15 Apr 2019 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355145;
        bh=74NF6t6x76by8bHCCmeDDrtQE+57CZunci9bkwuwZIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbx7RnUgOAB+wihBpCoxPOLvgp6iI6ZdnzZtoZrjhI+pTW0WJAnifLtuq3nvVdf06
         Yy68l+Ya/BtVSBaKP3tmrl+3F63NRiMr740GHye/VXmt4cx32D6C4IquSpYSLmFvmf
         OGs94Iv35sb1owk3d5gOSebhZknUR63AcXWPgxLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/101] net: ip_gre: fix possible use-after-free in erspan_rcv
Date:   Mon, 15 Apr 2019 20:58:28 +0200
Message-Id: <20190415183742.032647007@linuxfoundation.org>
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

[ Upstream commit 492b67e28ee5f2a2522fb72e3d3bcb990e461514 ]

erspan tunnels run __iptunnel_pull_header on received skbs to remove
gre and erspan headers. This can determine a possible use-after-free
accessing pkt_md pointer in erspan_rcv since the packet will be 'uncloned'
running pskb_expand_head if it is a cloned gso skb (e.g if the packet has
been sent though a veth device). Fix it resetting pkt_md pointer after
__iptunnel_pull_header

Fixes: 1d7e2ed22f8d ("net: erspan: refactor existing erspan code")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_gre.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f199945f6e4a..3c734832bb7c 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -260,7 +260,6 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	struct net *net = dev_net(skb->dev);
 	struct metadata_dst *tun_dst = NULL;
 	struct erspan_base_hdr *ershdr;
-	struct erspan_metadata *pkt_md;
 	struct ip_tunnel_net *itn;
 	struct ip_tunnel *tunnel;
 	const struct iphdr *iph;
@@ -283,9 +282,6 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 
-		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
-		pkt_md = (struct erspan_metadata *)(ershdr + 1);
-
 		if (__iptunnel_pull_header(skb,
 					   len,
 					   htons(ETH_P_TEB),
@@ -293,8 +289,9 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			goto drop;
 
 		if (tunnel->collect_md) {
+			struct erspan_metadata *pkt_md, *md;
 			struct ip_tunnel_info *info;
-			struct erspan_metadata *md;
+			unsigned char *gh;
 			__be64 tun_id;
 			__be16 flags;
 
@@ -307,6 +304,14 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
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
 			md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
 			md->version = ver;
 			md2 = &md->u.md2;
-- 
2.19.1



