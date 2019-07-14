Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A09C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 13:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AFF20644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfGNNdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 09:33:01 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2374 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfGNNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 09:33:00 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65d2b2ecb0c4-4529b; Sun, 14 Jul 2019 21:31:56 +0800 (CST)
X-RM-TRANSID: 2ee65d2b2ecb0c4-4529b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55d2b2eca11a-b5f09;
        Sun, 14 Jul 2019 21:31:56 +0800 (CST)
X-RM-TRANSID: 2ee55d2b2eca11a-b5f09
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH] sit: use dst_cache in ipip6_tunnel_xmit
Date:   Sun, 14 Jul 2019 21:31:22 +0800
Message-Id: <1563111082-10721-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as other ip tunnel, use dst_cache in xmit action to avoid
unnecessary fib lookups.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv6/sit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 8061089..b2ccbc4 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -900,12 +900,17 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 			   RT_TOS(tos), RT_SCOPE_UNIVERSE, IPPROTO_IPV6,
 			   0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
-	rt = ip_route_output_flow(tunnel->net, &fl4, NULL);
 
-	if (IS_ERR(rt)) {
-		dev->stats.tx_carrier_errors++;
-		goto tx_error_icmp;
+	rt = dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr);
+	if (!rt) {
+		rt = ip_route_output_flow(tunnel->net, &fl4, NULL);
+		if (IS_ERR(rt)) {
+			dev->stats.tx_carrier_errors++;
+			goto tx_error_icmp;
+		}
+		dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst, fl4.saddr);
 	}
+
 	if (rt->rt_type != RTN_UNICAST) {
 		ip_rt_put(rt);
 		dev->stats.tx_carrier_errors++;
-- 
1.8.3.1



