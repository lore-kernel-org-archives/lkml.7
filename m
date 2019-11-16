Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B613C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5556120728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfKPPN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:13:56 -0500
Received: from smtp.uniroma2.it ([160.80.6.23]:54166 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKPPNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:13:55 -0500
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id xAGF6RdB011419
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 16 Nov 2019 16:06:29 +0100
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Lebrun <dav.lebrun@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net, 2/2] seg6: fix skb transport_header after decap_and_validate()
Date:   Sat, 16 Nov 2019 16:05:53 +0100
Message-Id: <20191116150553.17497-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116150553.17497-1-andrea.mayer@uniroma2.it>
References: <20191116150553.17497-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the receive path (more precisely in ip6_rcv_core()) the
skb->transport_header is set to skb->network_header + sizeof(*hdr). As a
consequence, after routing operations, destination input expects to find
skb->transport_header correctly set to the next protocol (or extension
header) that follows the network protocol. However, decap behaviors (DX*,
DT*) remove the outer IPv6 and SRH extension and do not set again the
skb->transport_header pointer correctly. For this reason, the patch sets
the skb->transport_header to the skb->network_header + sizeof(hdr) in each
DX* and DT* behavior.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 5e3d7004d431..e70567446f28 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -341,6 +341,8 @@ static int input_action_end_dx6(struct sk_buff *skb,
 	if (!ipv6_addr_any(&slwt->nh6))
 		nhaddr = &slwt->nh6;
 
+	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+
 	seg6_lookup_nexthop(skb, nhaddr, 0);
 
 	return dst_input(skb);
@@ -370,6 +372,8 @@ static int input_action_end_dx4(struct sk_buff *skb,
 
 	skb_dst_drop(skb);
 
+	skb_set_transport_header(skb, sizeof(struct iphdr));
+
 	err = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
 	if (err)
 		goto drop;
@@ -390,6 +394,8 @@ static int input_action_end_dt6(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 		goto drop;
 
+	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+
 	seg6_lookup_nexthop(skb, NULL, slwt->table);
 
 	return dst_input(skb);
-- 
2.20.1

