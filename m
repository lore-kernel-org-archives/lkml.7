Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF14C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFA22184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411089;
	bh=+BtQIOkPthkYQRG21/cECx3xIJsjPFEiuYTDe/WY2QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCS2vB3wkFa/DDG4RpSQV8zlZh1BPjbveaLfw9AQdiN2VlwY9jTqglTYp1wKgUXK5
	 ChamJ4Jwbazssl0jCCb+jyR+MjATT5ZvZlClp5Wat5czk0AXgtTf7s5qofokKeLmXP
	 ZcHdo2hSdIwztf0is7mWJrY89AO67rJe8G62FGks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfCLRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfCLRRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:20 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C6C217D4;
        Tue, 12 Mar 2019 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411039;
        bh=+BtQIOkPthkYQRG21/cECx3xIJsjPFEiuYTDe/WY2QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JujUbiAUI40JzUEfgjNnNW6iilOofnMD09qtBVzz1g5RH2qEgD5rcRVKJrGPBEc2S
         db6TEY1qWEJvA3IjJ4tNlaLAkeWnpgeEQXstWSh1qnwFWvQVqgPOkZmlNmZeyA5j7G
         vcBSdwOLGJ95dBH/7BktvTMpHkzU4EKS0Gc4QHgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Lan <lansheng@huawei.com>,
        Qin Ji <jiqin.ji@huawei.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 18/96] net: netem: fix skb length BUG_ON in __skb_to_sgvec
Date:   Tue, 12 Mar 2019 10:09:36 -0700
Message-Id: <20190312171035.916739282@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sheng Lan <lansheng@huawei.com>

[ Upstream commit 5845f706388a4cde0f6b80f9e5d33527e942b7d9 ]

It can be reproduced by following steps:
1. virtio_net NIC is configured with gso/tso on
2. configure nginx as http server with an index file bigger than 1M bytes
3. use tc netem to produce duplicate packets and delay:
   tc qdisc add dev eth0 root netem delay 100ms 10ms 30% duplicate 90%
4. continually curl the nginx http server to get index file on client
5. BUG_ON is seen quickly

[10258690.371129] kernel BUG at net/core/skbuff.c:4028!
[10258690.371748] invalid opcode: 0000 [#1] SMP PTI
[10258690.372094] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W         5.0.0-rc6 #2
[10258690.372094] RSP: 0018:ffffa05797b43da0 EFLAGS: 00010202
[10258690.372094] RBP: 00000000000005ea R08: 0000000000000000 R09: 00000000000005ea
[10258690.372094] R10: ffffa0579334d800 R11: 00000000000002c0 R12: 0000000000000002
[10258690.372094] R13: 0000000000000000 R14: ffffa05793122900 R15: ffffa0578f7cb028
[10258690.372094] FS:  0000000000000000(0000) GS:ffffa05797b40000(0000) knlGS:0000000000000000
[10258690.372094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10258690.372094] CR2: 00007f1a6dc00868 CR3: 000000001000e000 CR4: 00000000000006e0
[10258690.372094] Call Trace:
[10258690.372094]  <IRQ>
[10258690.372094]  skb_to_sgvec+0x11/0x40
[10258690.372094]  start_xmit+0x38c/0x520 [virtio_net]
[10258690.372094]  dev_hard_start_xmit+0x9b/0x200
[10258690.372094]  sch_direct_xmit+0xff/0x260
[10258690.372094]  __qdisc_run+0x15e/0x4e0
[10258690.372094]  net_tx_action+0x137/0x210
[10258690.372094]  __do_softirq+0xd6/0x2a9
[10258690.372094]  irq_exit+0xde/0xf0
[10258690.372094]  smp_apic_timer_interrupt+0x74/0x140
[10258690.372094]  apic_timer_interrupt+0xf/0x20
[10258690.372094]  </IRQ>

In __skb_to_sgvec(), the skb->len is not equal to the sum of the skb's
linear data size and nonlinear data size, thus BUG_ON triggered.
Because the skb is cloned and a part of nonlinear data is split off.

Duplicate packet is cloned in netem_enqueue() and may be delayed
some time in qdisc. When qdisc len reached the limit and returns
NET_XMIT_DROP, the skb will be retransmit later in write queue.
the skb will be fragmented by tso_fragment(), the limit size
that depends on cwnd and mss decrease, the skb's nonlinear
data will be split off. The length of the skb cloned by netem
will not be updated. When we use virtio_net NIC and invoke skb_to_sgvec(),
the BUG_ON trigger.

To fix it, netem returns NET_XMIT_SUCCESS to upper stack
when it clones a duplicate packet.

Fixes: 35d889d1 ("sch_netem: fix skb leak in netem_enqueue()")
Signed-off-by: Sheng Lan <lansheng@huawei.com>
Reported-by: Qin Ji <jiqin.ji@huawei.com>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_netem.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -441,6 +441,7 @@ static int netem_enqueue(struct sk_buff
 	int nb = 0;
 	int count = 1;
 	int rc = NET_XMIT_SUCCESS;
+	int rc_drop = NET_XMIT_DROP;
 
 	/* Do not fool qdisc_drop_all() */
 	skb->prev = NULL;
@@ -480,6 +481,7 @@ static int netem_enqueue(struct sk_buff
 		q->duplicate = 0;
 		rootq->enqueue(skb2, rootq, to_free);
 		q->duplicate = dupsave;
+		rc_drop = NET_XMIT_SUCCESS;
 	}
 
 	/*
@@ -492,7 +494,7 @@ static int netem_enqueue(struct sk_buff
 		if (skb_is_gso(skb)) {
 			segs = netem_segment(skb, sch, to_free);
 			if (!segs)
-				return NET_XMIT_DROP;
+				return rc_drop;
 		} else {
 			segs = skb;
 		}
@@ -515,8 +517,10 @@ static int netem_enqueue(struct sk_buff
 			1<<(prandom_u32() % 8);
 	}
 
-	if (unlikely(sch->q.qlen >= sch->limit))
-		return qdisc_drop_all(skb, sch, to_free);
+	if (unlikely(sch->q.qlen >= sch->limit)) {
+		qdisc_drop_all(skb, sch, to_free);
+		return rc_drop;
+	}
 
 	qdisc_qstats_backlog_inc(sch, skb);
 


