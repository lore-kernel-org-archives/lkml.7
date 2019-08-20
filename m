Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38682C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A389216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfHTPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:19:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729956AbfHTPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:19:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EADE958FF6C9E88FE42E;
        Tue, 20 Aug 2019 23:19:28 +0800 (CST)
Received: from szxyal004123181.china.huawei.com (10.65.65.77) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 20 Aug 2019 23:19:27 +0800
From:   Dongxu Liu <liudongxu3@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: Fix detection for IPv4 duplicate address.
Date:   Tue, 20 Aug 2019 23:19:05 +0800
Message-ID: <20190820151905.13148-1-liudongxu3@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.65.65.77]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The network sends an ARP REQUEST packet to determine
whether there is a host with the same IP.
The source IP address of the packet is 0.
However, Windows may also send the source IP address
to determine, then the source IP address is equal to
the destination IP address.

Signed-off-by: Dongxu Liu <liudongxu3@huawei.com>
---
 net/ipv4/arp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 05eb42f..944f8e8 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -800,8 +800,11 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			    iptunnel_metadata_reply(skb_metadata_dst(skb),
 						    GFP_ATOMIC);
 
-	/* Special case: IPv4 duplicate address detection packet (RFC2131) */
-	if (sip == 0) {
+/* Special case: IPv4 duplicate address detection packet (RFC2131).
+ * Linux usually sends zero to detect duplication, and windows may
+ * send a same ip (not zero, sip equal to tip) to do this detection.
+ */
+	if (sip == 0 || sip == tip) {
 		if (arp->ar_op == htons(ARPOP_REQUEST) &&
 		    inet_addr_type_dev_table(net, dev, tip) == RTN_LOCAL &&
 		    !arp_ignore(in_dev, sip, tip))
-- 
2.12.3


