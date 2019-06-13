Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ADAC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA0E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442629;
	bh=R+2pXkKe0s6fwK8oiPplKNoGbWQdhdkcchjZKW5zPJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LexDBTva1OP0BDVibgwYvmUOXV/Y1IbTywoZO59SQ29rJCXgR211Adk4c/CWzky6d
	 Obs2fRowTqrCz/WjRdsgk9ECn/23OObhr+3xDhxvDy/9vaMSnK9EYmXyEe414stLe1
	 m7mONbCSvxFiYC8X5csJdrrPMEywx2cAt9t8roGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391827AbfFMQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731140AbfFMIlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:41:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B6921479;
        Thu, 13 Jun 2019 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415260;
        bh=R+2pXkKe0s6fwK8oiPplKNoGbWQdhdkcchjZKW5zPJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjpIEtiwdy2z0tNFRyZcDWEhkmhphG907G+lu2x2bjEe+apZ9yd3nVV5BdKY9R8Uy
         FVygcU5gxuAQPx8XsAU7gkNs8OuX/llyIt4cQ4gqfe6jzEGY0GfzE+3P77KSHbNfe+
         3xddmf++ytcIMDGeJS+IkM008MAkCeo5zlezY48I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/118] netfilter: nf_flow_table: check ttl value in flow offload data path
Date:   Thu, 13 Jun 2019 10:33:19 +0200
Message-Id: <20190613075647.405017874@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 33cc3c0cfa64c86b6c4bbee86997aea638534931 ]

nf_flow_offload_ip_hook() and nf_flow_offload_ipv6_hook() do not check
ttl value. So, ttl value overflow may occur.

Fixes: 97add9f0d66d ("netfilter: flow table support for IPv4")
Fixes: 0995210753a2 ("netfilter: flow table support for IPv6")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 15ed91309992..129e9ec99ec9 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -181,6 +181,9 @@ static int nf_flow_tuple_ip(struct sk_buff *skb, const struct net_device *dev,
 	    iph->protocol != IPPROTO_UDP)
 		return -1;
 
+	if (iph->ttl <= 1)
+		return -1;
+
 	thoff = iph->ihl * 4;
 	if (!pskb_may_pull(skb, thoff + sizeof(*ports)))
 		return -1;
@@ -412,6 +415,9 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 	    ip6h->nexthdr != IPPROTO_UDP)
 		return -1;
 
+	if (ip6h->hop_limit <= 1)
+		return -1;
+
 	thoff = sizeof(*ip6h);
 	if (!pskb_may_pull(skb, thoff + sizeof(*ports)))
 		return -1;
-- 
2.20.1



