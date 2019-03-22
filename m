Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0D120449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254321;
	bh=AhHrjQQbCDQcd4G13Dk3pe1iUYMFaecnmBpFImW8kpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PEU3+yvFjtEmHkxurhK6c+EbAGuntVUBE4UPHJuCvPWFHE+ivbAWGnC/Galmd85jX
	 Mez0rz2A5sb/t9nKCkH0EYnHGwgxbJVgGhI1vvuR1YJ9gnG2EI9ywsbs85FiWQTYA6
	 BfubZDOD7pcKmkKjrK30fzlhQubo+vxwSqfS6mCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfCVLb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbfCVLbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A07218B0;
        Fri, 22 Mar 2019 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254314;
        bh=AhHrjQQbCDQcd4G13Dk3pe1iUYMFaecnmBpFImW8kpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1oHf6EAt29SRtZQ7Q3P/Q10SaH3RNE+UBnV+R/1VrZ3FgKIXi6maKhLZewpvjWjg3
         RJiozFIcKyjidP8DCpXpI45VySX0TWPLEgSlntzk9Wc3fWYz8bLqv5VHrq7cGmW2RW
         q5X2O/PBn4WMQE1408FX5hQlTIF5lPCI2WlCZbU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 080/230] vti4: Fix a ipip packet processing bug in IPCOMP virtual tunnel
Date:   Fri, 22 Mar 2019 12:13:38 +0100
Message-Id: <20190322111242.263147385@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit dd9ee3444014e8f28c0eefc9fffc9ac9c5248c12 ]

Recently we run a network test over ipcomp virtual tunnel.We find that
if a ipv4 packet needs fragment, then the peer can't receive
it.

We deep into the code and find that when packet need fragment the smaller
fragment will be encapsulated by ipip not ipcomp. So when the ipip packet
goes into xfrm, it's skb->dev is not properly set. The ipv4 reassembly code
always set skb'dev to the last fragment's dev. After ipv4 defrag processing,
when the kernel rp_filter parameter is set, the skb will be drop by -EXDEV
error.

This patch adds compatible support for the ipip process in ipcomp virtual tunnel.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_vti.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 4b7c81f88abf..fcf327ebd134 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -75,6 +75,33 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 	return 0;
 }
 
+static int vti_input_ipip(struct sk_buff *skb, int nexthdr, __be32 spi,
+		     int encap_type)
+{
+	struct ip_tunnel *tunnel;
+	const struct iphdr *iph = ip_hdr(skb);
+	struct net *net = dev_net(skb->dev);
+	struct ip_tunnel_net *itn = net_generic(net, vti_net_id);
+
+	tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, TUNNEL_NO_KEY,
+				  iph->saddr, iph->daddr, 0);
+	if (tunnel) {
+		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
+			goto drop;
+
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
+
+		skb->dev = tunnel->dev;
+
+		return xfrm_input(skb, nexthdr, spi, encap_type);
+	}
+
+	return -EINVAL;
+drop:
+	kfree_skb(skb);
+	return 0;
+}
+
 static int vti_rcv(struct sk_buff *skb)
 {
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
@@ -83,6 +110,14 @@ static int vti_rcv(struct sk_buff *skb)
 	return vti_input(skb, ip_hdr(skb)->protocol, 0, 0);
 }
 
+static int vti_rcv_ipip(struct sk_buff *skb)
+{
+	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
+	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
+
+	return vti_input_ipip(skb, ip_hdr(skb)->protocol, ip_hdr(skb)->saddr, 0);
+}
+
 static int vti_rcv_cb(struct sk_buff *skb, int err)
 {
 	unsigned short family;
@@ -409,6 +444,12 @@ static struct xfrm4_protocol vti_ipcomp4_protocol __read_mostly = {
 	.priority	=	100,
 };
 
+static struct xfrm_tunnel ipip_handler __read_mostly = {
+	.handler	=	vti_rcv_ipip,
+	.err_handler	=	vti4_err,
+	.priority	=	0,
+};
+
 static int __net_init vti_init_net(struct net *net)
 {
 	int err;
@@ -592,6 +633,13 @@ static int __init vti_init(void)
 	if (err < 0)
 		goto xfrm_proto_comp_failed;
 
+	msg = "ipip tunnel";
+	err = xfrm4_tunnel_register(&ipip_handler, AF_INET);
+	if (err < 0) {
+		pr_info("%s: cant't register tunnel\n",__func__);
+		goto xfrm_tunnel_failed;
+	}
+
 	msg = "netlink interface";
 	err = rtnl_link_register(&vti_link_ops);
 	if (err < 0)
@@ -601,6 +649,8 @@ static int __init vti_init(void)
 
 rtnl_link_failed:
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
+xfrm_tunnel_failed:
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 xfrm_proto_comp_failed:
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 xfrm_proto_ah_failed:
-- 
2.19.1



