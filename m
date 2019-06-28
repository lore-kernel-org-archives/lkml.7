Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D342064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF1Pbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:31:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbfF1Pbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:31:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SFRX26071781;
        Fri, 28 Jun 2019 11:30:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdng989mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 11:30:52 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5SFS2IS074157;
        Fri, 28 Jun 2019 11:30:52 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdng989m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 11:30:52 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5SFUNDf030411;
        Fri, 28 Jun 2019 15:30:51 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2t9by7ebqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 15:30:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SFUovM51708234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 15:30:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F39EB2064;
        Fri, 28 Jun 2019 15:30:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71350B205F;
        Fri, 28 Jun 2019 15:30:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 15:30:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EE60416C5D59; Fri, 28 Jun 2019 08:30:50 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:30:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628153050.GU26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628135433.GE3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:54:33PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > of any way to determine whether rcu_read_unlock() is being called from
> > the scheduler, but it has been some time since I asked Peter Zijlstra
> > about that.
> 
> There (still) is no 'in-scheduler' state.

Well, my TREE03 + threadirqs rcutorture test ran for ten hours last
night with no problems, so we just might be OK.

The apparent fix is below, though my approach would be to do backports
for the full set of related changes.

Joel, Sebastian, how goes any testing from your end?  Any reason
to believe that this does not represent a fix?  (Me, I am still
concerned about doing raise_softirq() from within a threaded
interrupt, but am not seeing failures.)

							Thanx, Paul

------------------------------------------------------------------------

commit 23634ebc1d946f19eb112d4455c1d84948875e31
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Sun Mar 24 15:25:51 2019 -0700

    rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
    
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
