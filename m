Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1907C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C7C204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395109AbfHBPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:15:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732689AbfHBPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F6tn0065549;
        Fri, 2 Aug 2019 11:15:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4nrqw0gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:03 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72F6cNL063918;
        Fri, 2 Aug 2019 11:15:03 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4nrqw0f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:03 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72FAnvH000644;
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85y9ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 15:15:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF0nW51905022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B483B2066;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70195B2068;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EE43716C9A3A; Fri,  2 Aug 2019 08:15:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 04/14] rcu/nocb: Print no-CBs diagnostics when rcutorture writer unduly delayed
Date:   Fri,  2 Aug 2019 08:14:51 -0700
Message-Id: <20190802151501.13069-4-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit causes locking, sleeping, and callback state to be printed
for no-CBs CPUs when the rcutorture writer is delayed sufficiently for
rcutorture to complain.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c  |  1 +
 kernel/rcu/tree.h        |  7 +++-
 kernel/rcu/tree_plugin.h | 82 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree_stall.h  |  5 +++
 4 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b22947324423..3c9feca1eab1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2176,6 +2176,7 @@ rcu_torture_cleanup(void)
 		return;
 	}
 
+	show_rcu_gp_kthreads();
 	rcu_torture_barrier_cleanup();
 	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
 	torture_stop_kthread(rcu_torture_stall, stall_task);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4df86db8137..c612f306fe89 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -212,7 +212,11 @@ struct rcu_data {
 	/* The following fields are used by GP kthread, hence own cacheline. */
 	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
 	struct timer_list nocb_bypass_timer; /* Force nocb_bypass flush. */
-	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
+	u8 nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
+	u8 nocb_gp_bypass;		/* Found a bypass on last scan? */
+	u8 nocb_gp_gp;			/* GP to wait for on last scan? */
+	unsigned long nocb_gp_seq;	/*  If so, ->gp_seq to wait for. */
+	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
 	struct task_struct *nocb_cb_kthread;
@@ -438,6 +442,7 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_cpu_nocb_kthread(int cpu);
 static void __init rcu_spawn_nocb_kthreads(void);
+static void show_rcu_nocb_state(struct rcu_data *rdp);
 static void rcu_nocb_lock(struct rcu_data *rdp);
 static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fcbd61738dff..aaeb8a658f4b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2018,6 +2018,9 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			rcu_gp_kthread_wake();
 	}
 
+	my_rdp->nocb_gp_bypass = bypass;
+	my_rdp->nocb_gp_gp = needwait_gp;
+	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
 	if (bypass && !rcu_nocb_poll) {
 		// At least one child with non-empty ->nocb_bypass, so set
 		// timer in order to avoid stranding its callbacks.
@@ -2052,6 +2055,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
+	my_rdp->nocb_gp_seq = -1;
 	WARN_ON(signal_pending(current));
 }
 
@@ -2068,6 +2072,7 @@ static int rcu_nocb_gp_kthread(void *arg)
 	struct rcu_data *rdp = arg;
 
 	for (;;) {
+		WRITE_ONCE(rdp->nocb_gp_loops, rdp->nocb_gp_loops + 1);
 		nocb_gp_wait(rdp);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -2359,6 +2364,79 @@ void rcu_bind_current_to_nocb(void)
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
+/*
+ * Dump out nocb grace-period kthread state for the specified rcu_data
+ * structure.
+ */
+static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
+{
+	struct rcu_node *rnp = rdp->mynode;
+
+	pr_info("nocb GP %d %c%c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu\n",
+		rdp->cpu,
+		"kK"[!!rdp->nocb_gp_kthread],
+		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
+		"dD"[!!rdp->nocb_defer_wakeup],
+		"tT"[timer_pending(&rdp->nocb_timer)],
+		"bB"[timer_pending(&rdp->nocb_bypass_timer)],
+		"sS"[!!rdp->nocb_gp_sleep],
+		".W"[swait_active(&rdp->nocb_gp_wq)],
+		".W"[swait_active(&rnp->nocb_gp_wq[0])],
+		".W"[swait_active(&rnp->nocb_gp_wq[1])],
+		".B"[!!rdp->nocb_gp_bypass],
+		".G"[!!rdp->nocb_gp_gp],
+		(long)rdp->nocb_gp_seq,
+		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops));
+}
+
+/* Dump out nocb kthread state for the specified rcu_data structure. */
+static void show_rcu_nocb_state(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *rsclp = &rdp->cblist;
+	bool waslocked;
+	bool wastimer;
+	bool wassleep;
+
+	if (rdp->nocb_gp_rdp == rdp)
+		show_rcu_nocb_gp_state(rdp);
+
+	pr_info("   CB %d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%c%c%c q%ld\n",
+		rdp->cpu, rdp->nocb_gp_rdp->cpu,
+		"kK"[!!rdp->nocb_cb_kthread],
+		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
+		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
+		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
+		"sS"[!!rdp->nocb_cb_sleep],
+		".W"[swait_active(&rdp->nocb_cb_wq)],
+		jiffies - rdp->nocb_bypass_first,
+		jiffies - rdp->nocb_nobypass_last,
+		rdp->nocb_nobypass_count,
+		".D"[rcu_segcblist_ready_cbs(rsclp)],
+		".W"[!rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL)],
+		".R"[!rcu_segcblist_restempty(rsclp, RCU_WAIT_TAIL)],
+		".N"[!rcu_segcblist_restempty(rsclp, RCU_NEXT_READY_TAIL)],
+		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
+		rcu_segcblist_n_cbs(&rdp->cblist));
+
+	/* It is OK for GP kthreads to have GP state. */
+	if (rdp->nocb_gp_rdp == rdp)
+		return;
+
+	waslocked = raw_spin_is_locked(&rdp->nocb_gp_lock);
+	wastimer = timer_pending(&rdp->nocb_timer);
+	wassleep = swait_active(&rdp->nocb_gp_wq);
+	if (!rdp->nocb_defer_wakeup && !rdp->nocb_gp_sleep &&
+	    !waslocked && !wastimer && !wassleep)
+		return;  /* Nothing untowards. */
+
+	pr_info("   !!! %c%c%c%c %c\n",
+		"lL"[waslocked],
+		"dD"[!!rdp->nocb_defer_wakeup],
+		"tT"[wastimer],
+		"sS"[!!rdp->nocb_gp_sleep],
+		".W"[wassleep]);
+}
+
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
 /* No ->nocb_lock to acquire.  */
@@ -2436,6 +2514,10 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 }
 
+static void show_rcu_nocb_state(struct rcu_data *rdp)
+{
+}
+
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /*
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0627a66699a6..841ab43f3e60 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -589,6 +589,11 @@ void show_rcu_gp_kthreads(void)
 				cpu, (long)rdp->gp_seq_needed);
 		}
 	}
+	for_each_possible_cpu(cpu) {
+		rdp = per_cpu_ptr(&rcu_data, cpu);
+		if (rcu_segcblist_is_offloaded(&rdp->cblist))
+			show_rcu_nocb_state(rdp);
+	}
 	/* sched_show_task(rcu_state.gp_kthread); */
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
-- 
2.17.1

