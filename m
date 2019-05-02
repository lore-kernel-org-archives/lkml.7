Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEDC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23502216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810856;
	bh=d3m7PQSSBTdvSaJ14Zwtv2BlPgAGJByr5swq2PYGtRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jpt/ws1TQMUMcwRRgcVz1PB9dKBoutAELWppEkStMhGBpSVnc0sTr+wLKlO1kFrj7
	 +GQxQ4HIPu4jO/nZ7SJc6/naAqAe6v/CLAAUjtHJdyzi+WbUJqDqA86gjgMiSg5kCa
	 H+tzLo2/gY8DL16jvBpUykmG58vMnkBA6Owkh1X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfEBP1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbfEBP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:27:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC8E214DA;
        Thu,  2 May 2019 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810852;
        bh=d3m7PQSSBTdvSaJ14Zwtv2BlPgAGJByr5swq2PYGtRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7AdOSyc1BKBd7u4jE7IgsLnGefu12Dq7kFhMtwHLkzFgvyzs8sNKSQnHDq/kH4Cj
         59L700mxXHffMqgf43rqmRPRRXyDXMphK0oRXGT31F/6K7id1w/nqRAtCLFxNP3yyk
         OvnaGl485ULDyfKsG/v8F1bdff0DsX08Of+bp6PA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Florian Westphal <fw@strlen.de>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 17/72] netfilter: bridge: set skb transport_header before entering NF_INET_PRE_ROUTING
Date:   Thu,  2 May 2019 17:20:39 +0200
Message-Id: <20190502143334.689747978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e166e4fdaced850bee3d5ee12a5740258fb30587 ]

Since Commit 21d1196a35f5 ("ipv4: set transport header earlier"),
skb->transport_header has been always set before entering INET
netfilter. This patch is to set skb->transport_header for bridge
before entering INET netfilter by bridge-nf-call-iptables.

It also fixes an issue that sctp_error() couldn't compute a right
csum due to unset skb->transport_header.

Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
Reported-by: Li Shuang <shuali@redhat.com>
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 net/bridge/br_netfilter_hooks.c | 1 +
 net/bridge/br_netfilter_ipv6.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 3b0a03b92080..212c184c1eee 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -515,6 +515,7 @@ static unsigned int br_nf_pre_routing(void *priv,
 	nf_bridge->ipv4_daddr = ip_hdr(skb)->daddr;
 
 	skb->protocol = htons(ETH_P_IP);
+	skb->transport_header = skb->network_header + ip_hdr(skb)->ihl * 4;
 
 	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING, state->net, state->sk, skb,
 		skb->dev, NULL,
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 5811208863b7..09d5e0c7b3ba 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -235,6 +235,8 @@ unsigned int br_nf_pre_routing_ipv6(void *priv,
 	nf_bridge->ipv6_daddr = ipv6_hdr(skb)->daddr;
 
 	skb->protocol = htons(ETH_P_IPV6);
+	skb->transport_header = skb->network_header + sizeof(struct ipv6hdr);
+
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING, state->net, state->sk, skb,
 		skb->dev, NULL,
 		br_nf_pre_routing_finish_ipv6);
-- 
2.19.1



