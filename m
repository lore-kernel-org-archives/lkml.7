Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73250C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB5208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049664;
	bh=2kqpZtO+pIcrbtE3OnXCt9ljTMmv1wbPO5YbCBTKMUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G4uqZXhJ6e0EGjLM534G0y1mPSy0qMyTFuyZWM8v6Qc11lJo7WyiVwBolwFRAOvWA
	 aEawqJnvnEytyBjIWThy1eHCb8wUB9hph3TKsKOeqPAp7x7A0iu7kI+0gIV61RlX9J
	 r0kU1lSVWfh9MYjxcMgqIu0MnujHjTrwkR3o5/lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCHMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfCHMyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A682D20449;
        Fri,  8 Mar 2019 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049658;
        bh=2kqpZtO+pIcrbtE3OnXCt9ljTMmv1wbPO5YbCBTKMUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe0C9hLiY1Zt0lHNJhUWlqFWS57y1MrImU9BoPJxNbHkb4dmyuRami9bCuafRAZdz
         5LKMgGhL7sl8iQUjhI4MiQbQJVF7eIKFLOUL0gJDDYWvVyy4B5oaGs3P2bcyBnecWP
         4kHGMOojeXI/6WIxEdtxaL4Q9xa97kp9V8dLmfW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 23/76] net: sched: put back q.qlen into a single location
Date:   Fri,  8 Mar 2019 13:49:35 +0100
Message-Id: <20190308124915.596417692@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 46b1c18f9deb326a7e18348e668e4c7ab7c7458b ]

In the series fc8b81a5981f ("Merge branch 'lockless-qdisc-series'")
John made the assumption that the data path had no need to read
the qdisc qlen (number of packets in the qdisc).

It is true when pfifo_fast is used as the root qdisc, or as direct MQ/MQPRIO
children.

But pfifo_fast can be used as leaf in class full qdiscs, and existing
logic needs to access the child qlen in an efficient way.

HTB breaks badly, since it uses cl->leaf.q->q.qlen in :
  htb_activate() -> WARN_ON()
  htb_dequeue_tree() to decide if a class can be htb_deactivated
  when it has no more packets.

HFSC, DRR, CBQ, QFQ have similar issues, and some calls to
qdisc_tree_reduce_backlog() also read q.qlen directly.

Using qdisc_qlen_sum() (which iterates over all possible cpus)
in the data path is a non starter.

It seems we have to put back qlen in a central location,
at least for stable kernels.

For all qdisc but pfifo_fast, qlen is guarded by the qdisc lock,
so the existing q.qlen{++|--} are correct.

For 'lockless' qdisc (pfifo_fast so far), we need to use atomic_{inc|dec}()
because the spinlock might be not held (for example from
pfifo_fast_enqueue() and pfifo_fast_dequeue())

This patch adds atomic_qlen (in the same location than qlen)
and renames the following helpers, since we want to express
they can be used without qdisc lock, and that qlen is no longer percpu.

- qdisc_qstats_cpu_qlen_dec -> qdisc_qstats_atomic_qlen_dec()
- qdisc_qstats_cpu_qlen_inc -> qdisc_qstats_atomic_qlen_inc()

Later (net-next) we might revert this patch by tracking all these
qlen uses and replace them by a more efficient method (not having
to access a precise qlen, but an empty/non_empty status that might
be less expensive to maintain/track).

Another possibility is to have a legacy pfifo_fast version that would
be used when used a a child qdisc, since the parent qdisc needs
a spinlock anyway. But then, future lockless qdiscs would also
have the same problem.

Fixes: 7e66016f2c65 ("net: sched: helpers to sum qlen and qlen for per cpu logic")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sch_generic.h |   31 +++++++++++++------------------
 net/core/gen_stats.c      |    2 --
 net/sched/sch_generic.c   |   13 ++++++-------
 3 files changed, 19 insertions(+), 27 deletions(-)

--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -48,7 +48,10 @@ struct qdisc_size_table {
 struct qdisc_skb_head {
 	struct sk_buff	*head;
 	struct sk_buff	*tail;
-	__u32		qlen;
+	union {
+		u32		qlen;
+		atomic_t	atomic_qlen;
+	};
 	spinlock_t	lock;
 };
 
@@ -405,27 +408,19 @@ static inline void qdisc_cb_private_vali
 	BUILD_BUG_ON(sizeof(qcb->data) < sz);
 }
 
-static inline int qdisc_qlen_cpu(const struct Qdisc *q)
-{
-	return this_cpu_ptr(q->cpu_qstats)->qlen;
-}
-
 static inline int qdisc_qlen(const struct Qdisc *q)
 {
 	return q->q.qlen;
 }
 
-static inline int qdisc_qlen_sum(const struct Qdisc *q)
+static inline u32 qdisc_qlen_sum(const struct Qdisc *q)
 {
-	__u32 qlen = q->qstats.qlen;
-	int i;
+	u32 qlen = q->qstats.qlen;
 
-	if (q->flags & TCQ_F_NOLOCK) {
-		for_each_possible_cpu(i)
-			qlen += per_cpu_ptr(q->cpu_qstats, i)->qlen;
-	} else {
+	if (q->flags & TCQ_F_NOLOCK)
+		qlen += atomic_read(&q->q.atomic_qlen);
+	else
 		qlen += q->q.qlen;
-	}
 
 	return qlen;
 }
@@ -798,14 +793,14 @@ static inline void qdisc_qstats_cpu_back
 	this_cpu_add(sch->cpu_qstats->backlog, qdisc_pkt_len(skb));
 }
 
-static inline void qdisc_qstats_cpu_qlen_inc(struct Qdisc *sch)
+static inline void qdisc_qstats_atomic_qlen_inc(struct Qdisc *sch)
 {
-	this_cpu_inc(sch->cpu_qstats->qlen);
+	atomic_inc(&sch->q.atomic_qlen);
 }
 
-static inline void qdisc_qstats_cpu_qlen_dec(struct Qdisc *sch)
+static inline void qdisc_qstats_atomic_qlen_dec(struct Qdisc *sch)
 {
-	this_cpu_dec(sch->cpu_qstats->qlen);
+	atomic_dec(&sch->q.atomic_qlen);
 }
 
 static inline void qdisc_qstats_cpu_requeues_inc(struct Qdisc *sch)
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -291,7 +291,6 @@ __gnet_stats_copy_queue_cpu(struct gnet_
 	for_each_possible_cpu(i) {
 		const struct gnet_stats_queue *qcpu = per_cpu_ptr(q, i);
 
-		qstats->qlen = 0;
 		qstats->backlog += qcpu->backlog;
 		qstats->drops += qcpu->drops;
 		qstats->requeues += qcpu->requeues;
@@ -307,7 +306,6 @@ void __gnet_stats_copy_queue(struct gnet
 	if (cpu) {
 		__gnet_stats_copy_queue_cpu(qstats, cpu);
 	} else {
-		qstats->qlen = q->qlen;
 		qstats->backlog = q->backlog;
 		qstats->drops = q->drops;
 		qstats->requeues = q->requeues;
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -68,7 +68,7 @@ static inline struct sk_buff *__skb_dequ
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
 				qdisc_qstats_cpu_backlog_dec(q, skb);
-				qdisc_qstats_cpu_qlen_dec(q);
+				qdisc_qstats_atomic_qlen_dec(q);
 			} else {
 				qdisc_qstats_backlog_dec(q, skb);
 				q->q.qlen--;
@@ -108,7 +108,7 @@ static inline void qdisc_enqueue_skb_bad
 
 	if (qdisc_is_percpu_stats(q)) {
 		qdisc_qstats_cpu_backlog_inc(q, skb);
-		qdisc_qstats_cpu_qlen_inc(q);
+		qdisc_qstats_atomic_qlen_inc(q);
 	} else {
 		qdisc_qstats_backlog_inc(q, skb);
 		q->q.qlen++;
@@ -147,7 +147,7 @@ static inline int dev_requeue_skb_locked
 
 		qdisc_qstats_cpu_requeues_inc(q);
 		qdisc_qstats_cpu_backlog_inc(q, skb);
-		qdisc_qstats_cpu_qlen_inc(q);
+		qdisc_qstats_atomic_qlen_inc(q);
 
 		skb = next;
 	}
@@ -252,7 +252,7 @@ static struct sk_buff *dequeue_skb(struc
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
 				qdisc_qstats_cpu_backlog_dec(q, skb);
-				qdisc_qstats_cpu_qlen_dec(q);
+				qdisc_qstats_atomic_qlen_dec(q);
 			} else {
 				qdisc_qstats_backlog_dec(q, skb);
 				q->q.qlen--;
@@ -645,7 +645,7 @@ static int pfifo_fast_enqueue(struct sk_
 	if (unlikely(err))
 		return qdisc_drop_cpu(skb, qdisc, to_free);
 
-	qdisc_qstats_cpu_qlen_inc(qdisc);
+	qdisc_qstats_atomic_qlen_inc(qdisc);
 	/* Note: skb can not be used after skb_array_produce(),
 	 * so we better not use qdisc_qstats_cpu_backlog_inc()
 	 */
@@ -670,7 +670,7 @@ static struct sk_buff *pfifo_fast_dequeu
 	if (likely(skb)) {
 		qdisc_qstats_cpu_backlog_dec(qdisc, skb);
 		qdisc_bstats_cpu_update(qdisc, skb);
-		qdisc_qstats_cpu_qlen_dec(qdisc);
+		qdisc_qstats_atomic_qlen_dec(qdisc);
 	}
 
 	return skb;
@@ -714,7 +714,6 @@ static void pfifo_fast_reset(struct Qdis
 		struct gnet_stats_queue *q = per_cpu_ptr(qdisc->cpu_qstats, i);
 
 		q->backlog = 0;
-		q->qlen = 0;
 	}
 }
 


