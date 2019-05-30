Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB3C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920EB25BB4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfE3Ox0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbfE3OxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:53:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEpptl074774;
        Thu, 30 May 2019 10:52:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgfkaj5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 10:52:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4UEqNEQ077071;
        Thu, 30 May 2019 10:52:31 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgfkaj4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 10:52:31 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4UCshTi014763;
        Thu, 30 May 2019 12:55:04 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2spwb96ny6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 12:55:04 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEqT5j27132130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9212FB206E;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 643E0B2067;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EC2916C5D7E; Thu, 30 May 2019 07:52:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH tip/core/rcu 02/12] rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
Date:   Thu, 30 May 2019 07:52:19 -0700
Message-Id: <20190530145229.29565-2-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145204.GA28526@linux.ibm.com>
References: <20190530145204.GA28526@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RCU core processing is offloaded from RCU_SOFTIRQ to the rcuc
kthreads, a full and unconditional wakeup is required to initiate RCU
core processing.  In contrast, when RCU core processing is carried
out by RCU_SOFTIRQ, a raise_softirq() suffices.  Of course, there are
situations where raise_softirq() does a full wakeup, but these do not
occur with normal usage of rcu_read_unlock().

The reason that full wakeups can be problematic is that the scheduler
sometimes invokes rcu_read_unlock() with its pi or rq locks held,
which can of course result in deadlock in CONFIG_PREEMPT=y kernels when
rcu_read_unlock() invokes the scheduler.  Scheduler invocations can happen
in the following situations: (1) The just-ended reader has been subjected
to RCU priority boosting, in which case rcu_read_unlock() must deboost,
(2) Interrupts were disabled across the call to rcu_read_unlock(), so
the quiescent state must be deferred, requiring a wakeup of the rcuc
kthread corresponding to the current CPU.

Now, the scheduler may hold one of its locks across rcu_read_unlock()
only if preemption has been disabled across the entire RCU read-side
critical section, which in the days prior to RCU flavor consolidation
meant that rcu_read_unlock() never needed to do wakeups.  However, this
is no longer the case for any but the first rcu_read_unlock() following a
condition (e.g., preempted RCU reader) requiring special rcu_read_unlock()
attention.  For example, an RCU read-side critical section might be
preempted, but preemption might be disabled across the rcu_read_unlock().
The rcu_read_unlock() must defer the quiescent state, and therefore
leaves the task queued on its leaf rcu_node structure.  If a scheduler
interrupt occurs, the scheduler might well invoke rcu_read_unlock() with
one of its locks held.  However, the preempted task is still queued, so
rcu_read_unlock() will attempt to defer the quiescent state once more.
When RCU core processing is carried out by RCU_SOFTIRQ, this works just
fine: The raise_softirq() function simply sets a bit in a per-CPU mask
and the RCU core processing will be undertaken upon return from interrupt.

Not so when RCU core processing is carried out by the rcuc kthread: In this
case, the required wakeup can result in deadlock.

The initial solution to this problem was to use set_tsk_need_resched() and
set_preempt_need_resched() to force a future context switch, which allows
rcu_preempt_note_context_switch() to report the deferred quiescent state
to RCU's core processing.  Unfortunately for expedited grace periods,
there can be a significant delay between the call for a context switch
and the actual context switch.

This commit therefore introduces a ->deferred_qs flag to the task_struct
structure's rcu_special structure.  This flag is initially false, and
is set to true by the first call to rcu_read_unlock() requiring special
attention, then finally reset back to false when the quiescent state is
finally reported.  Then rcu_read_unlock() attempts full wakeups only when
->deferred_qs is false, that is, on the first rcu_read_unlock() requiring
special attention.  Note that a chain of RCU readers linked by some other
sort of reader may find that a later rcu_read_unlock() is once again able
to do a full wakeup, courtesy of an intervening preemption:

	rcu_read_lock();
	/* preempted */
	local_irq_disable();
	rcu_read_unlock(); /* Can do full wakeup, sets ->deferred_qs. */
	rcu_read_lock();
	local_irq_enable();
	preempt_disable()
	rcu_read_unlock(); /* Cannot do full wakeup, ->deferred_qs set. */
	rcu_read_lock();
	preempt_enable();
	/* preempted, >deferred_qs reset. */
	local_irq_disable();
	rcu_read_unlock(); /* Can again do full wakeup, sets ->deferred_qs. */

Such linked RCU readers do not yet seem to appear in the Linux kernel, and
it is probably best if they don't.  However, RCU needs to handle them, and
some variations on this theme could make even raise_softirq() unsafe due to
the possibility of its doing a full wakeup.  This commit therefore also
avoids invoking raise_softirq() when the ->deferred_qs set flag is set.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h    |  2 +-
 kernel/rcu/tree_plugin.h | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..942a44c1b8eb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -565,7 +565,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			pad; /* No garbage from compiler! */
+		u8			deferred_qs;
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 21611862e083..75110ea75d01 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -455,6 +455,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
+	t->rcu_read_unlock_special.b.deferred_qs = false;
 	if (special.b.need_qs) {
 		rcu_qs();
 		t->rcu_read_unlock_special.b.need_qs = false;
@@ -605,16 +606,24 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
-		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
-		/* Need to defer quiescent state until everything is enabled. */
-		if (irqs_were_disabled && use_softirq) {
-			/* Enabling irqs does not reschedule, so... */
+		t->rcu_read_unlock_special.b.exp_hint = false;
+		// Need to defer quiescent state until everything is enabled.
+		if (irqs_were_disabled && use_softirq &&
+		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
+			// Using softirq, safe to awaken, and we get
+			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
+		} else if (irqs_were_disabled && !use_softirq &&
+			   !t->rcu_read_unlock_special.b.deferred_qs) {
+			// Safe to awaken and we get no help from enabling
+			// irqs, unlike bh/preempt.
+			invoke_rcu_core();
 		} else {
-			/* Enabling BH or preempt does reschedule, so... */
+			// Enabling BH or preempt does reschedule, so...
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 		}
+		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
 		return;
 	}
-- 
2.17.1

