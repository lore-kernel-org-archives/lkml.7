Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B526C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D711205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413109;
	bh=vgqLMyj3R+O1kuqc4IhM5eGrEoTUzu1LfO5Frp0UoHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mttKLHsOikcEJUjya1myho039D+DiEYlLR57V3ue5k3VzKDkG3oD04RAYB97BlM0h
	 Vw1/ofoMlSZ/CB8mjE+Vg2V/whqcB5UaPcRqtz/uQ5DEJIAmXRmg7pXhlYp7Lg6J4i
	 9go0mV7LVwvF5W7sB/eQzT7Q4ohgCMALVUY3j1GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfCLROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbfCLRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:46 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51C621741;
        Tue, 12 Mar 2019 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410825;
        bh=vgqLMyj3R+O1kuqc4IhM5eGrEoTUzu1LfO5Frp0UoHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=funZzm9Sk7yWgyaVG4iEMbYjUVp1JFeZdbrINlO/JJdt0ElCrOdFRpRA4Ebh/GJc4
         ek+ZiNM3CepHMBFVS8nTz0VkzgFm1RQ8WZ+TiJgYVEELKwCKBeDDA8L3afKqw0HsIo
         8m6Ceu5GDjHZF8H096y8wFxUCjSDaahsgTEJWry8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/149] vti4: Fix a ipip packet processing bug in IPCOMP virtual tunnel
Date:   Tue, 12 Mar 2019 10:07:00 -0700
Message-Id: <20190312170349.648360239@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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
index 7f56944b020f..40a7cd56e008 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -74,6 +74,33 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
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
@@ -82,6 +109,14 @@ static int vti_rcv(struct sk_buff *skb)
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
@@ -435,6 +470,12 @@ static struct xfrm4_protocol vti_ipcomp4_protocol __read_mostly = {
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
@@ -603,6 +644,13 @@ static int __init vti_init(void)
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
@@ -612,6 +660,8 @@ static int __init vti_init(void)
 
 rtnl_link_failed:
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
+xfrm_tunnel_failed:
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 xfrm_proto_comp_failed:
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 xfrm_proto_ah_failed:
-- 
2.19.1



