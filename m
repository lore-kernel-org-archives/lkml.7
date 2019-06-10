Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC08EC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AC020859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbfFJLvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:51:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18541 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388572AbfFJLvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:51:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B58472FEA26F6711455F;
        Mon, 10 Jun 2019 19:50:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Jun 2019 19:50:51 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] packet: remove unused variable 'status' in __packet_lookup_frame_in_block
Date:   Mon, 10 Jun 2019 19:58:31 +0800
Message-ID: <20190610115831.175710-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'status' in  __packet_lookup_frame_in_block() is never used since
introduction in commit f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer
implementation."), we can remove it.
And when __packet_lookup_frame_in_block() calls prb_retire_current_block(), 
it can pass macro TP_STATUS_KERNEL instead of 0.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/packet/af_packet.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a29d66d..fb1a79c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1003,7 +1003,6 @@ static void prb_fill_curr_block(char *curr,
 /* Assumes caller has the sk->rx_queue.lock */
 static void *__packet_lookup_frame_in_block(struct packet_sock *po,
 					    struct sk_buff *skb,
-						int status,
 					    unsigned int len
 					    )
 {
@@ -1046,7 +1045,7 @@ static void *__packet_lookup_frame_in_block(struct packet_sock *po,
 	}
 
 	/* Ok, close the current block */
-	prb_retire_current_block(pkc, po, 0);
+	prb_retire_current_block(pkc, po, TP_STATUS_KERNEL);
 
 	/* Now, try to dispatch the next block */
 	curr = (char *)prb_dispatch_next_block(pkc, po);
@@ -1075,7 +1074,7 @@ static void *packet_current_rx_frame(struct packet_sock *po,
 					po->rx_ring.head, status);
 		return curr;
 	case TPACKET_V3:
-		return __packet_lookup_frame_in_block(po, skb, status, len);
+		return __packet_lookup_frame_in_block(po, skb, len);
 	default:
 		WARN(1, "TPACKET version not supported\n");
 		BUG();
-- 
2.7.4

