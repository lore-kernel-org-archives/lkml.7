Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83557C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F35218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfC3HaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:30:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfC3HaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:30:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4692232C626D7813BA63;
        Sat, 30 Mar 2019 15:30:10 +0800 (CST)
Received: from [127.0.0.1] (10.184.191.73) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Sat, 30 Mar 2019
 15:29:55 +0800
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   hujunwei <hujunwei4@huawei.com>
Subject: [PATCH net] ipv6: Fix dangling pointer when ipv6 fragment
CC:     <mingfangsen@huawei.com>, <liuzhiqiang26@huawei.com>,
        <zhangwenhao8@huawei.com>
Message-ID: <cbbedd1f-3e99-85f7-86d7-d02a86d59c29@huawei.com>
Date:   Sat, 30 Mar 2019 15:29:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.191.73]
X-CFilter-Loop: Reflected
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
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index edbd12067170..6db3c60b3b66 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -606,12 +606,14 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
     __be32 frag_id;
     int ptr, offset = 0, err = 0;
     u8 *prevhdr, nexthdr = 0;
+    u8 nexthdr_offset;
 
     err = ip6_find_1stfragopt(skb, &prevhdr);
     if (err < 0)
         goto fail;
     hlen = err;
     nexthdr = *prevhdr;
+    nexthdr_offset = prevhdr - skb_network_header(skb);
 
     mtu = ip6_skb_dst_mtu(skb);
 
@@ -646,6 +648,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
         (err = skb_checksum_help(skb)))
         goto fail;
 
+    prevhdr = skb_network_header(skb) + nexthdr_offset;
+
     hroom = LL_RESERVED_SPACE(rt->dst.dev);
     if (skb_has_frag_list(skb)) {
         unsigned int first_len = skb_pagelen(skb);
-- 
2.19.1


