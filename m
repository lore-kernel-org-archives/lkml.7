Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F76C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C691E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbfFKBYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 21:24:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388845AbfFKBYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:24:48 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 53BC6ABED0F103BEE140;
        Tue, 11 Jun 2019 09:24:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Jun 2019 09:24:34 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>
CC:     <willemdebruijn.kernel@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v2] packet: remove unused variable 'status' in __packet_lookup_frame_in_block
Date:   Tue, 11 Jun 2019 09:32:13 +0800
Message-ID: <20190611013213.142745-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAF=yD-+g1bSGOubFUE8veZNvGiPy1oYsf+dFDd=hqXYD+k4g_Q@mail.gmail.com>
References: <CAF=yD-+g1bSGOubFUE8veZNvGiPy1oYsf+dFDd=hqXYD+k4g_Q@mail.gmail.com>
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

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v2: don't change parameter from 0 to TP_STATUS_KERNEL when calls 
 prb_retire_current_block(). 
---
 net/packet/af_packet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a29d66da7394..7fa847dcea30 100644
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
2.20.1

