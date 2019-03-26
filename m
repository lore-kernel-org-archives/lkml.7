Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56294C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C938213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ceaZ5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfCZMOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:14:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39997 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:14:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id b11so1540402plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wh5+g+uysosk1iBHLcowBqW+WfVMKebwK30nreI2pK4=;
        b=P8ceaZ5hdsW9XQl4tc+h46swLoRF873oO71e+WAaBfgFahNjpjXVwHim4VM3pjlCng
         gVBe7Gqw2d2nYLF5dPRNGDasBYpLeqKtALQBsvai0wTuH1DAhHfcO+4NOQfbu/6D2i7G
         h3ODMrgd6bdeuUrl2k00aX9S6jQ3vXO+I3ajEfT2MtGGOhI9AzGR6e7EMjZ6eMlKmFHX
         brbcr9shHh90xIw0tj6Kqsza1RhWka1YLQ9kJqSPi8ktcqTSFhq/Pip4sJwKh036UZeH
         sTvv7gqSBBuu83b72TI0eevIvTXM9GWtsid4npTEes0AQ4106JAPQfd1RxfRFwubK1SG
         4C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wh5+g+uysosk1iBHLcowBqW+WfVMKebwK30nreI2pK4=;
        b=L1LxBjeQouLtiJBFrK2XfRXX/tW8UWTmmaXHnlChAr7DnjEjKRsrcsPF9F6equwKSU
         aDwFdeTtLPal7knKFK4wIDAJnH4dQlsDQntWQrEZiwIdeG53dgb0uA/DzDhWDOZ6bElQ
         ndy5PJ5aYvDHYk7e9iA6d3cwVTWFqz9+xewITYV6fWHiNijXAlr9JXZsmikix/fudKV0
         6dM1BnxCJlJbAX3/Foe2zCNhc6kZifNyVp65EUOM3k9NByx0mbvWA5ZOvve+xcBW9IE3
         GL6Bj2NsDkqzJnoTr5gtXae6k5VbQrtQ3MJt2uFfHbtihVjgXLZwkUm6Z29pqao87GSO
         JKsw==
X-Gm-Message-State: APjAAAWGZOeA76oejQR7V5C3H+VgcpqPYjNlxpp81nypSuPSaVZCz7f9
        813pxhNBHK47dZbn9npk0LTosLfUXCKe2w==
X-Google-Smtp-Source: APXvYqz5/5oddCj/DTcupxcJ2fe3yYzwOfgJw97x9AOwjzXdOHEHVuAtI20zF12Y4kQXUXLraAZ9zg==
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr30578674plb.239.1553602444085;
        Tue, 26 Mar 2019 05:14:04 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e2sm31263881pfa.64.2019.03.26.05.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 05:14:03 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 3/3] rcu: validate arguments for rcu tracepoints
Date:   Tue, 26 Mar 2019 20:13:11 +0800
Message-Id: <1553602391-11926-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RCU_TRACE is not set, all these tracepoints are defined as
do-nothing macro.
We'd better make those inline functions that take proper arguments.

As RCU_TRACE() is defined as do-nothing marco as well when
CONFIG_RCU_TRACE is not set, so we can clean it up.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/rcu.h | 81 ++++++++++++++--------------------------------
 kernel/rcu/rcu.h           |  9 ++----
 kernel/rcu/tree.c          |  8 ++---
 3 files changed, 31 insertions(+), 67 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f0c4d10..e3f357b 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -7,6 +7,12 @@
 
 #include <linux/tracepoint.h>
 
+#ifdef CONFIG_RCU_TRACE
+#define TRACE_EVENT_RCU TRACE_EVENT
+#else
+#define TRACE_EVENT_RCU TRACE_EVENT_NOP
+#endif
+
 /*
  * Tracepoint for start/end markers used for utilization calculations.
  * By convention, the string is of the following forms:
@@ -35,8 +41,6 @@
 	TP_printk("%s", __entry->s)
 );
 
-#ifdef CONFIG_RCU_TRACE
-
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 
 /*
@@ -62,7 +66,7 @@
  *	"end": End a grace period.
  *	"cpuend": CPU first notices a grace-period end.
  */
-TRACE_EVENT(rcu_grace_period,
+TRACE_EVENT_RCU(rcu_grace_period,
 
 	TP_PROTO(const char *rcuname, unsigned long gp_seq, const char *gpevent),
 
@@ -101,7 +105,7 @@
  * "Cleanup": Clean up rcu_node structure after previous GP.
  * "CleanupMore": Clean up, and another GP is needed.
  */
-TRACE_EVENT(rcu_future_grace_period,
+TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_PROTO(const char *rcuname, unsigned long gp_seq,
 		 unsigned long gp_seq_req, u8 level, int grplo, int grphi,
@@ -141,7 +145,7 @@
  * rcu_node structure, and the mask of CPUs that will be waited for.
  * All but the type of RCU are extracted from the rcu_node structure.
  */
-TRACE_EVENT(rcu_grace_period_init,
+TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_PROTO(const char *rcuname, unsigned long gp_seq, u8 level,
 		 int grplo, int grphi, unsigned long qsmask),
@@ -186,7 +190,7 @@
  *	"endwake": Woke piggybackers up.
  *	"done": Someone else did the expedited grace period for us.
  */
-TRACE_EVENT(rcu_exp_grace_period,
+TRACE_EVENT_RCU(rcu_exp_grace_period,
 
 	TP_PROTO(const char *rcuname, unsigned long gpseq, const char *gpevent),
 
@@ -218,7 +222,7 @@
  *	"nxtlvl": Advance to next level of rcu_node funnel
  *	"wait": Wait for someone else to do expedited GP
  */
-TRACE_EVENT(rcu_exp_funnel_lock,
+TRACE_EVENT_RCU(rcu_exp_funnel_lock,
 
 	TP_PROTO(const char *rcuname, u8 level, int grplo, int grphi,
 		 const char *gpevent),
@@ -269,7 +273,7 @@
  *	"WaitQueue": Enqueue partially done, timed wait for it to complete.
  *	"WokeQueue": Partial enqueue now complete.
  */
-TRACE_EVENT(rcu_nocb_wake,
+TRACE_EVENT_RCU(rcu_nocb_wake,
 
 	TP_PROTO(const char *rcuname, int cpu, const char *reason),
 
@@ -297,7 +301,7 @@
  * include SRCU), the grace-period number that the task is blocking
  * (the current or the next), and the task's PID.
  */
-TRACE_EVENT(rcu_preempt_task,
+TRACE_EVENT_RCU(rcu_preempt_task,
 
 	TP_PROTO(const char *rcuname, int pid, unsigned long gp_seq),
 
@@ -324,7 +328,7 @@
  * read-side critical section exiting that critical section.  Track the
  * type of RCU (which one day might include SRCU) and the task's PID.
  */
-TRACE_EVENT(rcu_unlock_preempted_task,
+TRACE_EVENT_RCU(rcu_unlock_preempted_task,
 
 	TP_PROTO(const char *rcuname, unsigned long gp_seq, int pid),
 
@@ -353,7 +357,7 @@
  * whether there are any blocked tasks blocking the current grace period.
  * All but the type of RCU are extracted from the rcu_node structure.
  */
-TRACE_EVENT(rcu_quiescent_state_report,
+TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_PROTO(const char *rcuname, unsigned long gp_seq,
 		 unsigned long mask, unsigned long qsmask,
@@ -396,7 +400,7 @@
  * state, which can be "dti" for dyntick-idle mode or "kick" when kicking
  * a CPU that has been in dyntick-idle mode for too long.
  */
-TRACE_EVENT(rcu_fqs,
+TRACE_EVENT_RCU(rcu_fqs,
 
 	TP_PROTO(const char *rcuname, unsigned long gp_seq, int cpu, const char *qsevent),
 
@@ -436,7 +440,7 @@
  * events use two separate counters, and that the "++=" and "--=" events
  * for irq/NMI will change the counter by two, otherwise by one.
  */
-TRACE_EVENT(rcu_dyntick,
+TRACE_EVENT_RCU(rcu_dyntick,
 
 	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
 
@@ -468,7 +472,7 @@
  * number of lazy callbacks queued, and the fourth element is the
  * total number of callbacks queued.
  */
-TRACE_EVENT(rcu_callback,
+TRACE_EVENT_RCU(rcu_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, long qlen_lazy,
 		 long qlen),
@@ -504,7 +508,7 @@
  * the fourth argument is the number of lazy callbacks queued, and the
  * fifth argument is the total number of callbacks queued.
  */
-TRACE_EVENT(rcu_kfree_callback,
+TRACE_EVENT_RCU(rcu_kfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
 		 long qlen_lazy, long qlen),
@@ -539,7 +543,7 @@
  * the total number of callbacks queued, and the fourth argument is
  * the current RCU-callback batch limit.
  */
-TRACE_EVENT(rcu_batch_start,
+TRACE_EVENT_RCU(rcu_batch_start,
 
 	TP_PROTO(const char *rcuname, long qlen_lazy, long qlen, long blimit),
 
@@ -569,7 +573,7 @@
  * The first argument is the type of RCU, and the second argument is
  * a pointer to the RCU callback itself.
  */
-TRACE_EVENT(rcu_invoke_callback,
+TRACE_EVENT_RCU(rcu_invoke_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp),
 
@@ -598,7 +602,7 @@
  * is the offset of the callback within the enclosing RCU-protected
  * data structure.
  */
-TRACE_EVENT(rcu_invoke_kfree_callback,
+TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
 
@@ -631,7 +635,7 @@
  * and the sixth argument (risk) is the return value from
  * rcu_is_callbacks_kthread().
  */
-TRACE_EVENT(rcu_batch_end,
+TRACE_EVENT_RCU(rcu_batch_end,
 
 	TP_PROTO(const char *rcuname, int callbacks_invoked,
 		 char cb, char nr, char iit, char risk),
@@ -673,7 +677,7 @@
  * callback address can be NULL.
  */
 #define RCUTORTURENAME_LEN 8
-TRACE_EVENT(rcu_torture_read,
+TRACE_EVENT_RCU(rcu_torture_read,
 
 	TP_PROTO(const char *rcutorturename, struct rcu_head *rhp,
 		 unsigned long secs, unsigned long c_old, unsigned long c),
@@ -721,7 +725,7 @@
  * The "cpu" argument is the CPU or -1 if meaningless, the "cnt" argument
  * is the count of remaining callbacks, and "done" is the piggybacking count.
  */
-TRACE_EVENT(rcu_barrier,
+TRACE_EVENT_RCU(rcu_barrier,
 
 	TP_PROTO(const char *rcuname, const char *s, int cpu, int cnt, unsigned long done),
 
@@ -748,41 +752,6 @@
 		  __entry->done)
 );
 
-#else /* #ifdef CONFIG_RCU_TRACE */
-
-#define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
-#define trace_rcu_future_grace_period(rcuname, gp_seq, gp_seq_req, \
-				      level, grplo, grphi, event) \
-				      do { } while (0)
-#define trace_rcu_grace_period_init(rcuname, gp_seq, level, grplo, grphi, \
-				    qsmask) do { } while (0)
-#define trace_rcu_exp_grace_period(rcuname, gqseq, gpevent) \
-	do { } while (0)
-#define trace_rcu_exp_funnel_lock(rcuname, level, grplo, grphi, gpevent) \
-	do { } while (0)
-#define trace_rcu_nocb_wake(rcuname, cpu, reason) do { } while (0)
-#define trace_rcu_preempt_task(rcuname, pid, gp_seq) do { } while (0)
-#define trace_rcu_unlock_preempted_task(rcuname, gp_seq, pid) do { } while (0)
-#define trace_rcu_quiescent_state_report(rcuname, gp_seq, mask, qsmask, level, \
-					 grplo, grphi, gp_tasks) do { } \
-	while (0)
-#define trace_rcu_fqs(rcuname, gp_seq, cpu, qsevent) do { } while (0)
-#define trace_rcu_dyntick(polarity, oldnesting, newnesting, dyntick) do { } while (0)
-#define trace_rcu_callback(rcuname, rhp, qlen_lazy, qlen) do { } while (0)
-#define trace_rcu_kfree_callback(rcuname, rhp, offset, qlen_lazy, qlen) \
-	do { } while (0)
-#define trace_rcu_batch_start(rcuname, qlen_lazy, qlen, blimit) \
-	do { } while (0)
-#define trace_rcu_invoke_callback(rcuname, rhp) do { } while (0)
-#define trace_rcu_invoke_kfree_callback(rcuname, rhp, offset) do { } while (0)
-#define trace_rcu_batch_end(rcuname, callbacks_invoked, cb, nr, iit, risk) \
-	do { } while (0)
-#define trace_rcu_torture_read(rcutorturename, rhp, secs, c_old, c) \
-	do { } while (0)
-#define trace_rcu_barrier(name, s, cpu, cnt, done) do { } while (0)
-
-#endif /* #else #ifdef CONFIG_RCU_TRACE */
-
 #endif /* _TRACE_RCU_H */
 
 /* This part must be outside protection */
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index a393e24..2778e44 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -24,11 +24,6 @@
 #define __LINUX_RCU_H
 
 #include <trace/events/rcu.h>
-#ifdef CONFIG_RCU_TRACE
-#define RCU_TRACE(stmt) stmt
-#else /* #ifdef CONFIG_RCU_TRACE */
-#define RCU_TRACE(stmt)
-#endif /* #else #ifdef CONFIG_RCU_TRACE */
 
 /* Offset to allow for unmatched rcu_irq_{enter,exit}(). */
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
@@ -229,12 +224,12 @@ static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
 
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
-		RCU_TRACE(trace_rcu_invoke_kfree_callback(rn, head, offset);)
+		trace_rcu_invoke_kfree_callback(rn, head, offset);
 		kfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	} else {
-		RCU_TRACE(trace_rcu_invoke_callback(rn, head);)
+		trace_rcu_invoke_callback(rn, head);
 		f = head->func;
 		WRITE_ONCE(head->func, (rcu_callback_t)0L);
 		f(head);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9180158..d2ad39f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2329,14 +2329,14 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
  */
 int rcutree_dying_cpu(unsigned int cpu)
 {
-	RCU_TRACE(bool blkd;)
-	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(&rcu_data);)
-	RCU_TRACE(struct rcu_node *rnp = rdp->mynode;)
+	bool blkd;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_node *rnp = rdp->mynode;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	RCU_TRACE(blkd = !!(rnp->qsmask & rdp->grpmask);)
+	blkd = !!(rnp->qsmask & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, rnp->gp_seq,
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
 	return 0;
-- 
1.8.3.1

