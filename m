Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF27218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355395;
	bh=sD7gOzUOKKzJwYA0BwrxQnGXaY0I4f2t1KjIDK1wUqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOQ9yQ0zHc2vUEp3hERe+GUwJLveR3AGcZeP/wnCYsFamrgySRy687p3+shv8B01t
	 8M5FAUYwtSIbXzEg+bwzP/H2XWLKHA9seH/0gkKuvXtCp9uA/mwgCaPpeKA0ihPKon
	 iDLMuSEq5g+QPYfda8vyzHHAxOj+ERWpwfbZ4o+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfDOTJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfDOTJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1E820651;
        Mon, 15 Apr 2019 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355390;
        bh=sD7gOzUOKKzJwYA0BwrxQnGXaY0I4f2t1KjIDK1wUqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+JWY2ekMUDB6X89suEK3ivtpph/SLsf7BEX02r8lEEw8WnXANeF34aT0stP9b5AM
         KcT1UZaqfguyuljxa16gqtD4I5SEAzTRX0XZBkjvu8OM4dqQbFjxDFqjVYCIY7jJC+
         r4nZrbsiqbR3yfRIbdJ/+ZR8w1T0VjkWo4T+nYMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Hu <hujunwei4@huawei.com>,
        Wenhao Zhang <zhangwenhao8@huawei.com>,
        syzbot+e8ce541d095e486074fc@syzkaller.appspotmail.com,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 009/117] ipv6: Fix dangling pointer when ipv6 fragment
Date:   Mon, 15 Apr 2019 20:59:39 +0200
Message-Id: <20190415183745.361112272@linuxfoundation.org>
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

[ Upstream commit ef0efcd3bd3fd0589732b67fb586ffd3c8705806 ]

At the beginning of ip6_fragment func, the prevhdr pointer is
obtained in the ip6_find_1stfragopt func.
However, all the pointers pointing into skb header may change
when calling skb_checksum_help func with
skb->ip_summed = CHECKSUM_PARTIAL condition.
The prevhdr pointe will be dangling if it is not reloaded after
calling __skb_linearize func in skb_checksum_help func.

Here, I add a variable, nexthdr_offset, to evaluate the offset,
which does not changes even after calling __skb_linearize func.

Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Signed-off-by: Junwei Hu <hujunwei4@huawei.com>
Reported-by: Wenhao Zhang <zhangwenhao8@huawei.com>
Reported-by: syzbot+e8ce541d095e486074fc@syzkaller.appspotmail.com
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5f9fa0302b5a..e71227390bec 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -595,7 +595,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				inet6_sk(skb->sk) : NULL;
 	struct ipv6hdr *tmp_hdr;
 	struct frag_hdr *fh;
-	unsigned int mtu, hlen, left, len;
+	unsigned int mtu, hlen, left, len, nexthdr_offset;
 	int hroom, troom;
 	__be32 frag_id;
 	int ptr, offset = 0, err = 0;
@@ -606,6 +606,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		goto fail;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);
 
 	mtu = ip6_skb_dst_mtu(skb);
 
@@ -640,6 +641,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	    (err = skb_checksum_help(skb)))
 		goto fail;
 
+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
 	if (skb_has_frag_list(skb)) {
 		unsigned int first_len = skb_pagelen(skb);
-- 
2.19.1



