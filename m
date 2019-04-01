Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD14C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8FA218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfDARXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:23:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731418AbfDARXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:23:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31HJniJ107081
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 13:23:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rkp323a9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 13:22:59 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Apr 2019 18:22:58 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Apr 2019 18:22:54 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x31HMrEW24051750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 17:22:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47BDBB2067;
        Mon,  1 Apr 2019 17:22:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21895B2066;
        Mon,  1 Apr 2019 17:22:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Apr 2019 17:22:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5465016C34BA; Mon,  1 Apr 2019 10:22:57 -0700 (PDT)
Date:   Mon, 1 Apr 2019 10:22:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Check for wakeup-safe conditions
 in rcu_read_unlock_special()
Reply-To: paulmck@linux.ibm.com
References: <20190329182608.GA23877@linux.ibm.com>
 <20190329182634.24994-2-paulmck@linux.ibm.com>
 <20190401083211.GD11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401083211.GD11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040117-0040-0000-0000-000004DB078E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010856; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01182868; UDB=6.00619225; IPR=6.00963610;
 MB=3.00026247; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-01 17:22:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040117-0041-0000-0000-000008E60769
Message-Id: <20190401172257.GN4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:32:11AM +0200, Peter Zijlstra wrote:
> On Fri, Mar 29, 2019 at 11:26:34AM -0700, Paul E. McKenney wrote:
> > When RCU core processing is offloaded from RCU_SOFTIRQ to the rcuc
> > kthreads, a full and unconditional wakeup is required to initiate RCU
> > core processing.  In contrast, when RCU core processing is carried
> > out by RCU_SOFTIRQ, a raise_softirq() suffices.  Of course, there are
> > situations where raise_softirq() does a full wakeup, but these do not
> > occur with normal usage of rcu_read_unlock().
> 
> Do we have a comment somewhere explaining why?

First, thank you for reviewing this!

The "why" is because people normally don't do things like the code
sequence shown below, but where the scheduler holds locks across the
second RCU read-side critical section.  (If they did, lockdep would
complain.  Nevertheless, it is good to avoid this potential problem.)

> > The initial solution to this problem was to use set_tsk_need_resched() and
> > set_preempt_need_resched() to force a future context switch, which allows
> > rcu_preempt_note_context_switch() to report the deferred quiescent state
> > to RCU's core processing.  Unfortunately for expedited grace periods,
> > there can be a significant delay between the call for a context switch
> > and the actual context switch.
> 
> This is all PREEMPT=y kernels, right? Where is the latency coming from?
> Because PREEMPT=y _should_ react quite quickly.

Yes, PREEMPT=y.  It happens like this:

1.	rcu_read_lock() with everything enabled.

2.	Preemption then resumption.

3.	local_irq_disable().

4.	rcu_read_unlock().

5.	local_irq_enable().

From what I know, the scheduler doesn't see anything until the next
interrupt, local_bh_enable(), return to userspace, etc.  Because this
is PREEMPT=y, preempt_enable() and cond_resched() do nothing.  So
it could be some time (milliseconds, depending on HZ, NO_HZ_FULL, and
so on) until the scheduler responds.  With NO_HZ_FULL, last I knew,
the delay can be extremely long.

Or am I missing something that gets the scheduler on the job faster?

Hmmm...  If your point is that this amount of delay matters only for
expedited grace periods, you are quite right.  So perhaps I shouldn't be
doing any of the expensive stuff unless there is an expedited grace period
in flight.  Or if NO_HZ_FULL.  See below for an updated (and untested)
patch to this effect.

> > This commit therefore introduces a ->deferred_qs flag to the task_struct
> > structure's rcu_special structure.  This flag is initially false, and
> > is set to true by the first call to rcu_read_unlock() requiring special
> > attention, then finally reset back to false when the quiescent state is
> > finally reported.  Then rcu_read_unlock() attempts full wakeups only when
> > ->deferred_qs is false, that is, on the first rcu_read_unlock() requiring
> > special attention.  Note that a chain of RCU readers linked by some other
> > sort of reader may find that a later rcu_read_unlock() is once again able
> > to do a full wakeup, courtesy of an intervening preemption:
> > 
> > 	rcu_read_lock();
> > 	/* preempted */
> > 	local_irq_disable();
> > 	rcu_read_unlock(); /* Can do full wakeup, sets ->deferred_qs. */
> > 	rcu_read_lock();
> > 	local_irq_enable();
> > 	preempt_disable()
> > 	rcu_read_unlock(); /* Cannot do full wakeup, ->deferred_qs set. */
> > 	rcu_read_lock();
> > 	preempt_enable();
> > 	/* preempted, >deferred_qs reset. */
> 
> As it would have without ->deferred_sq and just having done the above
> which was deemed insufficient.
> 
> So I'm really puzzled by the need for all this.

On the first round, without the ->deferred_qs, we know the scheduler
cannot be holding any of its pi or rq locks because if it did, it would
have disabled interrupts across the entire RCU read-side critical section.
Wakeups are therefore safe in this case, whether via softirq or wakeup.
Afterwards, we don't have that guarantee because an earlier critical
section might have been preempted and the scheduler might have held one
of its locks across the entire just-ended critical section.

And I believe you are right that we should avoid the wakeups unless
there is an expedited grace period in flight or in a NO_HZ_FULL kernel.
Hence the patch shown below.

							Thanx, Paul

-----------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2e52a77af6be..582c6d88aaa0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -606,20 +606,26 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
+		bool exp;
+
 		t->rcu_read_unlock_special.b.exp_hint = false;
+		exp = !!READ_ONCE(this_cpu_ptr(&rcu_data)->mynode->exp_tasks);
 		// Need to defer quiescent state until everything is enabled.
-		if (irqs_were_disabled && use_softirq &&
+		if ((exp || IS_ENABLED(CONFIG_NO_HZ_FULL)) &&
+		    irqs_were_disabled && use_softirq &&
 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
-		} else if (irqs_were_disabled && !use_softirq &&
+		} else if ((exp || IS_ENABLED(CONFIG_NO_HZ_FULL)) &&
+			   irqs_were_disabled && !use_softirq &&
 			   !t->rcu_read_unlock_special.b.deferred_qs) {
 			// Safe to awaken and we get no help from enabling
 			// irqs, unlike bh/preempt.
 			invoke_rcu_core();
 		} else {
 			// Enabling BH or preempt does reschedule, so...
+			// Also if no expediting or NO_HZ_FULL, slow is OK.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 		}

