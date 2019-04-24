Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE98CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4521907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126345;
	bh=WMsuK4oBxUq3ToKRclrgQHMxfLV042jFlZ6LgHOaE6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWDFRDPpev91r+c9VNm9w/Xo7NFLxMcvu2JV5lRA2G3wW5/TkPqmWDA+sSVqoSSNZ
	 XBqhedjbUWlYS9BbJOYweNiReSyGXRdKGPZxkD7/31YgdKNiRpxFJA8c3ApJvzZZet
	 SVyTpSL0CA8a5cpe8RFpkERBxdivsrE+w1QUE9nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfDXRTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388921AbfDXRTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E26218B0;
        Wed, 24 Apr 2019 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126339;
        bh=WMsuK4oBxUq3ToKRclrgQHMxfLV042jFlZ6LgHOaE6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjHgzX+wJ6XjqNdanIKFkdWNLAcmVcyem+HxFSnUYH18AH4kWwSJDLV4chZR5TNWx
         784Y/k7b2huQVIBZ8xHa8m6FBG7LVXPzqaSJjF7ualJv0Xq29QRTGqQWW/eW73SlBL
         ho6hrih80dGv96xi1pA9n0bZJCMubRmQMQZwXkYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Hu <hujunwei4@huawei.com>,
        Wenhao Zhang <zhangwenhao8@huawei.com>,
        syzbot+e8ce541d095e486074fc@syzkaller.appspotmail.com,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 077/168] ipv6: Fix dangling pointer when ipv6 fragment
Date:   Wed, 24 Apr 2019 19:08:41 +0200
Message-Id: <20190424170928.504455385@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -575,7 +575,7 @@ int ip6_fragment(struct net *net, struct
 				inet6_sk(skb->sk) : NULL;
 	struct ipv6hdr *tmp_hdr;
 	struct frag_hdr *fh;
-	unsigned int mtu, hlen, left, len;
+	unsigned int mtu, hlen, left, len, nexthdr_offset;
 	int hroom, troom;
 	__be32 frag_id;
 	int ptr, offset = 0, err = 0;
@@ -586,6 +586,7 @@ int ip6_fragment(struct net *net, struct
 		goto fail;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);
 
 	mtu = ip6_skb_dst_mtu(skb);
 
@@ -620,6 +621,7 @@ int ip6_fragment(struct net *net, struct
 	    (err = skb_checksum_help(skb)))
 		goto fail;
 
+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
 	if (skb_has_frag_list(skb)) {
 		int first_len = skb_pagelen(skb);


