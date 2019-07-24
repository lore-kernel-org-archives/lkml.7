Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD8DC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAE9229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfGXMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:01:40 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2488 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfGXMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:01:40 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15d384881758-15cfc; Wed, 24 Jul 2019 20:01:07 +0800 (CST)
X-RM-TRANSID: 2ee15d384881758-15cfc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85d384882a7d-f1062;
        Wed, 24 Jul 2019 20:01:07 +0800 (CST)
X-RM-TRANSID: 2ee85d384882a7d-f1062
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>
Subject: [PATCH] ip6_gre: reload ipv6h in prepare_ip6gre_xmit_ipv6
Date:   Wed, 24 Jul 2019 20:00:42 +0800
Message-Id: <1563969642-11843-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ip6_tnl_parse_tlv_enc_lim() can call pskb_may_pull()
which may change skb->data, so we need to re-load ipv6h at
the right place.

Fixes: 898b29798e36 ("ip6_gre: Refactor ip6gre xmit codes")
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv6/ip6_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index c2049c7..dd2d0b96 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -660,12 +660,13 @@ static int prepare_ip6gre_xmit_ipv6(struct sk_buff *skb,
 				    struct flowi6 *fl6, __u8 *dsfield,
 				    int *encap_limit)
 {
-	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	struct ipv6hdr *ipv6h;
 	struct ip6_tnl *t = netdev_priv(dev);
 	__u16 offset;
 
 	offset = ip6_tnl_parse_tlv_enc_lim(skb, skb_network_header(skb));
 	/* ip6_tnl_parse_tlv_enc_lim() might have reallocated skb->head */
+	ipv6h = ipv6_hdr(skb);
 
 	if (offset > 0) {
 		struct ipv6_tlv_tnl_enc_lim *tel;
-- 
1.8.3.1



