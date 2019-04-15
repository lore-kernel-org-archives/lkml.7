Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C839C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5E321900
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354040;
	bh=zfzYwbAwJm0fglQB53WTUxwHsqz42lR02PfPzioo9gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZCnearsOSVvhUKU1TaEo+NkmgLjbl10Y8QmFNBiq1YiNkSeKIWyFtHn3I/MbGtCk/
	 4/SaCE62IpyjRaPdnqX2X+nI75PCQgYp5RbHpAo9lB4kSo1ffsEKiRb7WSmH3dHSta
	 nbEmy4dJ/2XvePzzXbBgCivyA6oDan/K4MA+CN94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfDOSrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbfDOSrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE53218D3;
        Mon, 15 Apr 2019 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354035;
        bh=zfzYwbAwJm0fglQB53WTUxwHsqz42lR02PfPzioo9gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/4nWANb9wrVY35Y1pRl0ql5TFy0npYqF5TBLGTgL6dEyTGRwChCd/fZupvJsjSWp
         KuZvbTNCvPv0wixPkmuHycN19QP/tfySQmfoTJVeiwwCRT6TPi9CpZ2xcaUjlwCYTX
         P6lxOz5kB3ZjynU5278ZY7aPHP+csJAlUaRKKKpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Hu <hujunwei4@huawei.com>,
        Wenhao Zhang <zhangwenhao8@huawei.com>,
        syzbot+e8ce541d095e486074fc@syzkaller.appspotmail.com,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 48/76] ipv6: Fix dangling pointer when ipv6 fragment
Date:   Mon, 15 Apr 2019 20:44:12 +0200
Message-Id: <20190415183720.771455989@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junwei Hu <hujunwei4@huawei.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -592,7 +592,7 @@ int ip6_fragment(struct net *net, struct
 				inet6_sk(skb->sk) : NULL;
 	struct ipv6hdr *tmp_hdr;
 	struct frag_hdr *fh;
-	unsigned int mtu, hlen, left, len;
+	unsigned int mtu, hlen, left, len, nexthdr_offset;
 	int hroom, troom;
 	__be32 frag_id;
 	int ptr, offset = 0, err = 0;
@@ -603,6 +603,7 @@ int ip6_fragment(struct net *net, struct
 		goto fail;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);
 
 	mtu = ip6_skb_dst_mtu(skb);
 
@@ -637,6 +638,7 @@ int ip6_fragment(struct net *net, struct
 	    (err = skb_checksum_help(skb)))
 		goto fail;
 
+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
 	if (skb_has_frag_list(skb)) {
 		int first_len = skb_pagelen(skb);


