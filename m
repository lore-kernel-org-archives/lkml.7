Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D21EC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAD420657
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfDBLia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:38:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbfDBLia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:38:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [10.3.19.206])
        by Forcepoint Email with ESMTP id E0558CABE41BB83B77AC;
        Tue,  2 Apr 2019 19:38:27 +0800 (CST)
Received: from [127.0.0.1] (10.184.191.73) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 19:38:17 +0800
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mingfangsen@huawei.com>, <liuzhiqiang26@huawei.com>
From:   hujunwei <hujunwei4@huawei.com>
Subject: [PATCH v4 net] ipv6: Fix dangling pointer when ipv6 fragment
Message-ID: <aaccfa09-8acf-e247-ab71-3d6ec3803f55@huawei.com>
Date:   Tue, 2 Apr 2019 19:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.191.73]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junwei Hu <hujunwei4@huawei.com>

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
---
V3->V4:
- fix build warning

 net/ipv6/ip6_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index edbd12067170..e51f3c648b09 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -601,7 +601,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				inet6_sk(skb->sk) : NULL;
 	struct ipv6hdr *tmp_hdr;
 	struct frag_hdr *fh;
-	unsigned int mtu, hlen, left, len;
+	unsigned int mtu, hlen, left, len, nexthdr_offset;
 	int hroom, troom;
 	__be32 frag_id;
 	int ptr, offset = 0, err = 0;
@@ -612,6 +612,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		goto fail;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);

 	mtu = ip6_skb_dst_mtu(skb);

@@ -646,6 +647,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	    (err = skb_checksum_help(skb)))
 		goto fail;

+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
 	if (skb_has_frag_list(skb)) {
 		unsigned int first_len = skb_pagelen(skb);
-- 
2.19.1

