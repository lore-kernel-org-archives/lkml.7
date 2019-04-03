Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE9CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAF621741
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfDCFB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:01:28 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:20987
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726676AbfDCFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:01:28 -0400
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 43418209EA;
        Wed,  3 Apr 2019 05:01:25 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     andrew.hendry@gmail.com, davem@davemloft.net, khc@pm.waw.pl,
        isdn@linux-pingi.de
Cc:     edumazet@google.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 1/4] net/x25: call skb_reset_network_header where needed
Date:   Wed,  3 Apr 2019 07:01:15 +0200
Message-Id: <20190403050118.12785-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some problems like:
 o tcpdump not showing X.25<->LapB Header
 o "protocol 0508 is buggy" warning from I4L

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
index 39231237e1c3..eef0305f3e99 100644
--- a/net/x25/x25_dev.c
+++ b/net/x25/x25_dev.c
@@ -127,6 +127,7 @@ int x25_lapb_receive_frame(struct sk_buff *skb, struct net_device *dev,
 
 	case X25_IFACE_DATA:
 		skb_pull(skb, 1);
+		skb_reset_network_header(skb);
 		if (x25_receive_data(skb, nb)) {
 			x25_neigh_put(nb);
 			goto out;
@@ -171,6 +172,8 @@ void x25_establish_link(struct x25_neigh *nb)
 		return;
 	}
 
+	skb_reset_network_header(skb);
+
 	skb->protocol = htons(ETH_P_X25);
 	skb->dev      = nb->dev;
 
@@ -198,6 +201,8 @@ void x25_terminate_link(struct x25_neigh *nb)
 	ptr  = skb_put(skb, 1);
 	*ptr = X25_IFACE_DISCONNECT;
 
+	skb_reset_network_header(skb);
+
 	skb->protocol = htons(ETH_P_X25);
 	skb->dev      = nb->dev;
 	dev_queue_xmit(skb);
@@ -207,8 +212,6 @@ void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
 {
 	unsigned char *dptr;
 
-	skb_reset_network_header(skb);
-
 	switch (nb->dev->type) {
 	case ARPHRD_X25:
 		dptr  = skb_push(skb, 1);
@@ -225,6 +228,8 @@ void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
 		return;
 	}
 
+	skb_reset_network_header(skb);
+
 	skb->protocol = htons(ETH_P_X25);
 	skb->dev      = nb->dev;
 
-- 
2.11.0

