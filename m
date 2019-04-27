Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6955D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfD0PSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:18:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbfD0PPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:40 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-000144-5y; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004Rk-JW; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        bridge@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        "Nkolay Aleksandrov" <nikolay@cumulusnetworks.com>,
        "Roopa Prabhu" <roopa@cumulusnetworks.com>,
        "Yunjian Wang" <wangyunjian@huawei.com>,
        "Stephen Hemminger" <stephen@networkplumber.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.710221079@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 052/202] net: bridge: Fix ethernet header pointer
 before check skb forwardable
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yunjian Wang <wangyunjian@huawei.com>

commit 28c1382fa28f2e2d9d0d6f25ae879b5af2ecbd03 upstream.

The skb header should be set to ethernet header before using
is_skb_forwardable. Because the ethernet header length has been
considered in is_skb_forwardable(including dev->hard_header_len
length).

To reproduce the issue:
1, add 2 ports on linux bridge br using following commands:
$ brctl addbr br
$ brctl addif br eth0
$ brctl addif br eth1
2, the MTU of eth0 and eth1 is 1500
3, send a packet(Data 1480, UDP 8, IP 20, Ethernet 14, VLAN 4)
from eth0 to eth1

So the expect result is packet larger than 1500 cannot pass through
eth0 and eth1. But currently, the packet passes through success, it
means eth1's MTU limit doesn't take effect.

Fixes: f6367b4660dd ("bridge: use is_skb_forwardable in forward path")
Cc: bridge@lists.linux-foundation.org
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - br_dev_queue_push_xmit() has to call nf_bridge_maybe_copy_header()
   before pushing the Ethernet header
 - adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -38,16 +38,21 @@ static inline int should_deliver(const s
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
 	/* ip_fragment doesn't copy the MAC header */
-	if (nf_bridge_maybe_copy_header(skb) ||
-	    !is_skb_forwardable(skb->dev, skb)) {
-		kfree_skb(skb);
-	} else {
-		skb_push(skb, ETH_HLEN);
-		br_drop_fake_rtable(skb);
-		dev_queue_xmit(skb);
-	}
+	if (nf_bridge_maybe_copy_header(skb))
+		goto drop;
+
+	skb_push(skb, ETH_HLEN);
+	if (!is_skb_forwardable(skb->dev, skb))
+		goto drop;
+
+	br_drop_fake_rtable(skb);
+	dev_queue_xmit(skb);
 
 	return 0;
+
+drop:
+	kfree_skb(skb);
+	return 0;
 }
 
 int br_forward_finish(struct sk_buff *skb)
@@ -66,12 +71,11 @@ static void __br_deliver(const struct ne
 	skb->dev = to->dev;
 
 	if (unlikely(netpoll_tx_running(to->br->dev))) {
+		skb_push(skb, ETH_HLEN);
 		if (!is_skb_forwardable(skb->dev, skb))
 			kfree_skb(skb);
-		else {
-			skb_push(skb, ETH_HLEN);
+		else
 			br_netpoll_send_skb(to, skb);
-		}
 		return;
 	}
 

