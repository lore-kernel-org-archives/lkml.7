Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C10C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518BA206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDCFBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:01:36 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:34430
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726676AbfDCFBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:01:35 -0400
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 9C18220B22;
        Wed,  3 Apr 2019 05:01:33 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     andrew.hendry@gmail.com, davem@davemloft.net, khc@pm.waw.pl,
        isdn@linux-pingi.de
Cc:     edumazet@google.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 3/4] isdn/i4l/isdn_x25iface: call skb_reset_network_header
Date:   Wed,  3 Apr 2019 07:01:17 +0200
Message-Id: <20190403050118.12785-3-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403050118.12785-1-ms@dev.tdt.de>
References: <20190403050118.12785-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... after skb_push() / skb_pull().

This fixes the output of tcpdump.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/isdn/i4l/isdn_x25iface.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_x25iface.c b/drivers/isdn/i4l/isdn_x25iface.c
index 48bfbcb4a09d..ffd50fa47111 100644
--- a/drivers/isdn/i4l/isdn_x25iface.c
+++ b/drivers/isdn/i4l/isdn_x25iface.c
@@ -194,6 +194,7 @@ static int isdn_x25iface_receive(struct concap_proto *cprot, struct sk_buff *skb
 	if (((ix25_pdata_t *)(cprot->proto_data))
 	    ->state == WAN_CONNECTED) {
 		if (skb_push(skb, 1)) {
+			skb_reset_network_header(skb);
 			skb->data[0] = X25_IFACE_DATA;
 			skb->protocol = x25_type_trans(skb, cprot->net_dev);
 			netif_rx(skb);
@@ -225,6 +226,7 @@ static int isdn_x25iface_connect_ind(struct concap_proto *cprot)
 	skb = dev_alloc_skb(1);
 	if (skb) {
 		skb_put_u8(skb, X25_IFACE_CONNECT);
+		skb_reset_network_header(skb);
 		skb->protocol = x25_type_trans(skb, cprot->net_dev);
 		netif_rx(skb);
 		return 0;
@@ -254,6 +256,7 @@ static int isdn_x25iface_disconn_ind(struct concap_proto *cprot)
 	skb = dev_alloc_skb(1);
 	if (skb) {
 		skb_put_u8(skb, X25_IFACE_DISCONNECT);
+		skb_reset_network_header(skb);
 		skb->protocol = x25_type_trans(skb, cprot->net_dev);
 		netif_rx(skb);
 		return 0;
@@ -278,10 +281,14 @@ static int isdn_x25iface_xmit(struct concap_proto *cprot, struct sk_buff *skb)
 	case X25_IFACE_DATA:
 		if (*state == WAN_CONNECTED) {
 			skb_pull(skb, 1);
+			skb_reset_network_header(skb);
 			netif_trans_update(cprot->net_dev);
 			ret = (cprot->dops->data_req(cprot, skb));
 			/* prepare for future retransmissions */
-			if (ret) skb_push(skb, 1);
+			if (ret) {
+				skb_push(skb, 1);
+				skb_reset_network_header(skb);
+			}
 			return ret;
 		}
 		illegal_state_warn(*state, firstbyte);
-- 
2.11.0

