Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89239C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0A42171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfDDTth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:49:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbfDDTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:49:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34JnVVC111873
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 15:49:35 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rnq8jk8mq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:49:34 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 20:49:34 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 20:49:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34JnS4u17563694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 19:49:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BE41B2064;
        Thu,  4 Apr 2019 19:49:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1E5B205F;
        Thu,  4 Apr 2019 19:49:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 19:49:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 47C5016C6107; Thu,  4 Apr 2019 12:49:30 -0700 (PDT)
Date:   Thu, 4 Apr 2019 12:49:30 -0700
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
 <20190401172257.GN4102@linux.ibm.com>
 <20190402070953.GG12232@hirez.programming.kicks-ass.net>
 <20190402131853.GV4102@linux.ibm.com>
 <20190403095046.GD4038@hirez.programming.kicks-ass.net>
 <20190403162550.GB14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403162550.GB14111@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040419-2213-0000-0000-00000371821C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01184343; UDB=6.00620116; IPR=6.00965096;
 MB=3.00026298; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 19:49:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040419-2214-0000-0000-00005DE795A3
Message-Id: <20190404194930.GA3145@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:25:50AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 03, 2019 at 11:50:46AM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 02, 2019 at 06:18:53AM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 02, 2019 at 09:09:53AM +0200, Peter Zijlstra wrote:
> > > > On Mon, Apr 01, 2019 at 10:22:57AM -0700, Paul E. McKenney wrote:
> > 
> > > > > Or am I missing something that gets the scheduler on the job faster?
> > > > 
> > > > Oh urgh, yah. So normally we only twiddle with the need_resched state:
> > > > 
> > > >  - while preempt_disabl(), such that preempt_enable() will reschedule
> > > >  - from interrupt context, such that interrupt return will reschedule
> > > > 
> > > > But the usage here 'violates' those rules and then there is an
> > > > unspecified latency between setting the state and it getting observed,
> > > > but no longer than 1 tick I would think.
> > > 
> > > In general, yes, which is fine (famous last words) for normal grace
> > > periods but not so good for expedited grace periods.
> > > 
> > > > I don't think we can go NOHZ with need_resched set, because the moment
> > > > we hit the idle loop with that set, we _will_ reschedule.
> > > 
> > > Agreed, and I believe that transitioning to usermode execution also
> > > gives the scheduler a chance to take action.
> > > 
> > > The one exception to this is when a nohz_full CPU running in nohz_full
> > > mode does a system call that decides to execute for a very long time.
> > > Last I checked, the scheduling-clock interrupt did -not- get retriggered
> > > in this case, and the delay could be indefinite, as in bad even for
> > > normal grace periods.
> > 
> > Right, there is that.
> > 
> > > > So in that respect the irq_work suggestion I made would fix things
> > > > properly.
> > > 
> > > But wouldn't the current use of set_tsk_need_resched(current) followed by
> > > set_preempt_need_resched() work just as well in that case?  The scheduler
> > > would react to these at the next scheduler-clock interrupt on their
> > > own, right?  Or am I being scheduler-naive again?
> > 
> > Well, you have that unspecified delay. By forcing the (self) interrupt
> > you enforce a timely response.
> 
> Good point!  I will give this a go, thank you!

How about as shown below?

							Thanx, Paul

------------------------------------------------------------------------

commit 687c00c91c9edbaf5309402689bce644dd140590
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu Apr 4 12:19:25 2019 -0700

    rcu: Use irq_work to get scheduler's attention in clean context
    
    When rcu_read_unlock_special() is invoked with interrupts disabled, is
    either not in an interrupt handler or is not using RCU_SOFTIRQ, is not
    the first RCU read-side critical section in the chain, and either there
    is an expedited grace period in flight or this is a NO_HZ_FULL kernel,
    the end of the grace period can be unduly delayed.  The reason for this
    is that it is not safe to do wakeups in this situation.
    
    This commit fixes this problem by using the irq_work subsystem to
    force a later interrupt handler in a clean environment.  Because
    set_tsk_need_resched(current) and set_preempt_need_resched() are
    invoked prior to this, the scheduler will force a context switch
    upon return from this interrupt (though perhaps at the end of any
    interrupted preempt-disable or BH-disable region of code), which will
    invoke rcu_note_context_switch() (again in a clean environment), which
    will in turn give RCU the chance to report the deferred quiescent state.
    
    Of course, by then this task might be within another RCU read-side
    critical section.  But that will be detected at that time and reporting
    will be further deferred to the outermost rcu_read_unlock().  See
    rcu_preempt_need_deferred_qs() and rcu_preempt_deferred_qs() for more
    details on the checking.
    
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b9c5d1af8451..dc3c53cb9608 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -161,6 +161,8 @@ struct rcu_data {
 					/*  ticks this CPU has handled */
 					/*  during and after the last grace */
 					/* period it is aware of. */
+	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
+	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
 
 	/* 2) batch handling */
 	struct rcu_segcblist cblist;	/* Segmented callback list, with */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d90a262ba04b..80ee4d3f3891 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -587,6 +587,17 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
 		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
 }
 
+/*
+ * Minimal handler to give the scheduler a chance to re-evaluate.
+ */
+static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
+{
+	struct rcu_data *rdp;
+
+	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
+	rdp->defer_qs_iw_pending = false;
+}
+
 /*
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
@@ -630,6 +641,15 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Also if no expediting or NO_HZ_FULL, slow is OK.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
+			if (IS_ENABLED(CONFIG_IRQ_WORK) &&
+			    !rdp->defer_qs_iw_pending && exp) {
+				// Get scheduler to re-evaluate and call hooks.
+				// If !IRQ_WORK, FQS scan will eventually IPI.
+				init_irq_work(&rdp->defer_qs_iw,
+					      rcu_preempt_deferred_qs_handler);
+				rdp->defer_qs_iw_pending = true;
+				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
+			}
 		}
 		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);

