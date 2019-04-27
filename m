Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AE120673
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfD0P1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:27:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33216 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbfD0PPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:24 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-00014G-4n; Sat, 27 Apr 2019 16:15:21 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004dv-Rd; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Qin Ji" <jiqin.ji@huawei.com>, "Sheng Lan" <lansheng@huawei.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <eric.dumazet@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.362875821@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 183/202] net: netem: fix skb length BUG_ON in
 __skb_to_sgvec
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

From: Sheng Lan <lansheng@huawei.com>

commit 5845f706388a4cde0f6b80f9e5d33527e942b7d9 upstream.

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
[bwh: Backported to 3.16: netem_enqueue() may call qdisc_reshape_fail();
 keep returning NET_XMIT_SUCCESS if that succeeds]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -444,6 +444,7 @@ static int netem_enqueue(struct sk_buff
 	int nb = 0;
 	int count = 1;
 	int rc = NET_XMIT_SUCCESS;
+	int rc_drop = NET_XMIT_DROP;
 
 	/* Random duplication */
 	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor))
@@ -480,6 +481,7 @@ static int netem_enqueue(struct sk_buff
 
 		qdisc_enqueue_root(skb2, rootq);
 		q->duplicate = dupsave;
+		rc_drop = NET_XMIT_SUCCESS;
 	}
 
 	/*
@@ -492,7 +494,7 @@ static int netem_enqueue(struct sk_buff
 		if (skb_is_gso(skb)) {
 			segs = netem_segment(skb, sch);
 			if (!segs)
-				return NET_XMIT_DROP;
+				return rc_drop;
 		} else {
 			segs = skb;
 		}
@@ -514,8 +516,10 @@ static int netem_enqueue(struct sk_buff
 	if (unlikely(skb_queue_len(&sch->q) >= sch->limit)) {
 		/* qdisc_reshape_fail() can't handle segmented skb */
 		if (segs)
-			return qdisc_drop_all(skb, sch);
-		return qdisc_reshape_fail(skb, sch);
+			qdisc_drop_all(skb, sch);
+		else if (qdisc_reshape_fail(skb, sch) == NET_XMIT_SUCCESS)
+			return NET_XMIT_SUCCESS;
+		return rc_drop;
 	}
 
 	sch->qstats.backlog += qdisc_pkt_len(skb);

