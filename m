Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A672C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F842083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eiaip+pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfCZBkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:40:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45086 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfCZBkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:40:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so6437051pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GMJaPQ/SyD7l7T8PXZ5G4Dne0XO+tnXhM764F6ldYtE=;
        b=Eiaip+pMMu+0V6HaUAk0XZQXlBTaOgSM84u1501le2Q6WdNx4j9yOOVaQSOsUO+dBr
         COtwQ0Fp7btnZ4UraGEab8zSnTLa8wA/ZuN5PQkP8XcsK525tKJp9ysObHijeNsJqisN
         NPgU1uUj3bo4RxC1yCcWj7jvegQ1RmK8/WpR7LPHw97MUFra+ZYSIx4fhnpkQmCYsdC1
         1p+YvbZXsNjPDI5kGZ+09bsV8zGGRilm/iRmXtH2C5atsnIXSUUXyTsIj9OWcCQ8K8L9
         ySVO4ikYecM4AZY8sw0L4kig5OVTEbiAkuEjuBK1yha7Snj8kTSCJghsDltyCh6UAu8c
         QHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GMJaPQ/SyD7l7T8PXZ5G4Dne0XO+tnXhM764F6ldYtE=;
        b=LB0rclBWDfaUdaVIBCMxzAx1k4zcUvEGc/GNY4eH4WXVxzQIlHMz7b/SrY0EffvD/R
         Sl/GjZLoJGDpguKStDCOgDeBpLBUpcsYDlVvUIhmF3pyZs6LlbBMSKruVyHk7p4Nbco2
         /KkyrJNNIqHb1yR7IKfAFugD2WwrmnYBqNjN1jUMWCLo319s2OPOYWL5JmrcV44moJ+Z
         EqrpN+v4ahei7/HFjlKY3JqtvtWRDJFtJo2f1OuLNoMKKdSBHmnc9qojAfUCFptyfTVr
         zmlbTLj6S9jcEIWvwVN9pCXJmezuiv/qlLPTNY9TsRN984se9UPYDIlYQa1vpgMYQWRm
         Cn/A==
X-Gm-Message-State: APjAAAW6VTpbt33h8U0naTi+RCiVg60modYTv2p5/y5wSNN1HHmAdxzG
        AYxKM5MG18cEsWofWXxVoMY=
X-Google-Smtp-Source: APXvYqxLObR/b2foGejVIYeNJz6B7cbBh7CBY8diUitZ+VuH7UyY35aP51aFF9cqGwvvpzYv4qVlMA==
X-Received: by 2002:a62:445a:: with SMTP id r87mr26647959pfa.13.1553564444377;
        Mon, 25 Mar 2019 18:40:44 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m7sm41464119pgg.62.2019.03.25.18.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 18:40:43 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 3/3] rcu: validate arguments for rcu tracepoints
Date:   Tue, 26 Mar 2019 09:40:07 +0800
Message-Id: <1553564407-1162-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RCU_TRACE is not set, all these tracepoints are define as
do-nothing macro.
We'd better make those inline functions that take proper arguments.

As RCU_TRACE() is defined as do-nothing marco as well when
CONFIG_RCU_TRACE is not set, so we can clean it up.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/rcu.h | 84 +++++++++++++++++++++++++++++-----------------
 kernel/rcu/rcu.h           |  9 ++---
 kernel/rcu/tree.c          |  8 ++---
 3 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f0c4d10..357e1b6 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -750,36 +750,60 @@
 
 #else /* #ifdef CONFIG_RCU_TRACE */
 
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
+TRACE_EVENT_NONE(rcu_grace_period,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq,
+		 const char *gpevent));
+TRACE_EVENT_NONE(rcu_future_grace_period,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq,
+		 unsigned long gp_seq_req, u8 level, int grplo,
+		 int grphi, const char *gpevent));
+TRACE_EVENT_NONE(rcu_grace_period_init,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, u8 level,
+		 int grplo, int grphi, unsigned long qsmask));
+TRACE_EVENT_NONE(rcu_exp_grace_period,
+	TP_PROTO(const char *rcuname, unsigned long gpseq,
+		 const char *gpevent));
+TRACE_EVENT_NONE(rcu_exp_funnel_lock,
+	TP_PROTO(const char *rcuname, u8 level, int grplo, int grphi,
+		 const char *gpevent));
+TRACE_EVENT_NONE(rcu_nocb_wake,
+	TP_PROTO(const char *rcuname, int cpu, const char *reason));
+TRACE_EVENT_NONE(rcu_preempt_task,
+	TP_PROTO(const char *rcuname, int pid, unsigned long gp_seq));
+TRACE_EVENT_NONE(rcu_unlock_preempted_task,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, int pid));
+TRACE_EVENT_NONE(rcu_quiescent_state_report,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq,
+		 unsigned long mask, unsigned long qsmask,
+		 u8 level, int grplo, int grphi, int gp_tasks));
+TRACE_EVENT_NONE(rcu_fqs,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, int cpu,
+		 const char *qsevent));
+TRACE_EVENT_NONE(rcu_dyntick,
+	TP_PROTO(const char *polarity, long oldnesting, long newnesting,
+		 atomic_t dynticks));
+TRACE_EVENT_NONE(rcu_callback,
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp, long qlen_lazy,
+		 long qlen));
+TRACE_EVENT_NONE(rcu_kfree_callback,
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp,
+		 unsigned long offset, long qlen_lazy, long qlen));
+TRACE_EVENT_NONE(rcu_batch_start,
+	TP_PROTO(const char *rcuname, long qlen_lazy, long qlen, long blimit));
+TRACE_EVENT_NONE(rcu_invoke_callback,
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp));
+TRACE_EVENT_NONE(rcu_invoke_kfree_callback,
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp,
+		 unsigned long offset));
+TRACE_EVENT_NONE(rcu_batch_end,
+	TP_PROTO(const char *rcuname, int callbacks_invoked,
+		 char cb, char nr, char iit, char risk));
+TRACE_EVENT_NONE(rcu_torture_read,
+	TP_PROTO(const char *rcutorturename, struct rcu_head *rhp,
+		 unsigned long secs, unsigned long c_old, unsigned long c));
+TRACE_EVENT_NONE(rcu_barrier,
+	TP_PROTO(const char *rcuname, const char *s, int cpu, int cnt,
+		 unsigned long done));
 
 #endif /* #else #ifdef CONFIG_RCU_TRACE */
 
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

