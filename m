Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D7216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbfHHVaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390446AbfHHVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:30:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78LOgZ6032704
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 17:30:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8rep7ruu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 17:30:18 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Aug 2019 22:30:17 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 22:30:12 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78LUBH047382834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 21:30:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57E11B205F;
        Thu,  8 Aug 2019 21:30:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A290B2066;
        Thu,  8 Aug 2019 21:30:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 21:30:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 94AD416C9A2E; Thu,  8 Aug 2019 14:30:12 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:30:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Reply-To: paulmck@linux.ibm.com
References: <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
 <20190805155024.GK2332@hirez.programming.kicks-ass.net>
 <20190805174800.GK28441@linux.ibm.com>
 <20190806180824.GA28448@linux.ibm.com>
 <20190807214131.GA15124@linux.ibm.com>
 <20190808203541.GA8160@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808203541.GA8160@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080821-0060-0000-0000-0000036B2416
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244014; UDB=6.00656291; IPR=6.01025493;
 MB=3.00028097; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 21:30:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080821-0061-0000-0000-00004A7AC423
Message-Id: <20190808213012.GA28773@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 01:35:41PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 07, 2019 at 02:41:31PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 06, 2019 at 11:08:24AM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 05, 2019 at 10:48:00AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Aug 05, 2019 at 05:50:24PM +0200, Peter Zijlstra wrote:
> > > > > On Mon, Aug 05, 2019 at 07:54:48AM -0700, Paul E. McKenney wrote:
> > > > > 
> > > > > > > Right; so clearly we're not understanding what's happening. That seems
> > > > > > > like a requirement for actually doing a patch.
> > > > > > 
> > > > > > Almost but not quite.  It is a requirement for a patch *that* *is*
> > > > > > *supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
> > > > > > writing experimental patches, please feel free to take a long walk on
> > > > > > a short pier.
> > > > > > 
> > > > > > Understood???
> > > > > 
> > > > > Ah, my bad, I thought you were actually proposing this as an actual
> > > > > patch. I now see that is my bad, I'd overlooked the RFC part.
> > > > 
> > > > No problem!
> > > > 
> > > > And of course adding tracing decreases the frequency and duration of
> > > > the multi_cpu_stop().  Re-running with shorter-duration triggering.  ;-)
> > > 
> > > And I did eventually get a good trace.  If I am interpreting this trace
> > > correctly, the torture_-135 task didn't get around to attempting to wake
> > > up all of the CPUs.  I will try again, but this time with the sched_switch
> > > trace event enabled.
> > > 
> > > As a side note, enabling ftrace from the command line seems to interact
> > > badly with turning tracing off and on in the kernel, so I eventually
> > > resorted to trace_printk() in the functions of interest.  The trace
> > > output is below, followed by the current diagnostic patch.  Please note
> > > that I am -not- using the desperation hammer-the-scheduler patches.
> > > 
> > > More as I learn more!
> > 
> > And of course I forgot to dump out the online CPUs, so I really had no
> > idea whether or not all the CPUs were accounted for.  I added tracing
> > to dump out the online CPUs at the beginning of __stop_cpus() and then
> > reworked it a few times to get the problem to happen in reasonable time.
> > Please see below for the resulting annotated trace.
> > 
> > I was primed to expect a lost IPI, perhaps due to yet another qemu bug,
> > but all the migration threads are running within about 2 milliseconds.
> > It is then almost two minutes(!) until the next trace message.
> > 
> > Looks like time to (very carefully!) instrument multi_cpu_stop().
> > 
> > Of course, if you have any ideas, please do not keep them a secret!
> 
> Functionally, multi_cpu_stop() is working fine, according to the trace
> below (search for a line beginning with TAB).  But somehow CPU 2 took
> almost three -minutes- to do one iteration of the loop.  The prime suspect
> in that loop is cpu_relax() due to the hypervisor having an opportunity
> to do something at that point.  The commentary below (again, search for
> a line beginning with TAB) gives my analysis.
> 
> Of course, if I am correct, it should be possible to catch cpu_relax()
> in the act.  That is the next step, give or take the Heisenbuggy nature
> of this beast.
> 
> Another thing for me to try is to run longer with !NO_HZ_FULL, just in
> case the earlier runs just got lucky.
> 
> Thoughts?

And it really can happen:

[ 1881.467922] migratio-33      4...1 1879530317us : stop_machine_yield: cpu_relax() took 756140 ms

The previous timestamp was 1123391100us, so the cpu_relax() is almost
exactly the full delay.

But another instance stalled for many minutes without a ten-second
cpu_relax().  So it is not just cpu_relax() causing trouble.  I could
rationalize that vCPU preemption being at fault...

And my diagnostic patch is below, just in case I am doing something
stupid with that.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ce00b442ced0..1a50ed258ef0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3569,6 +3569,7 @@ void __init rcu_init(void)
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
 	srcu_init();
+	tracing_off();
 }
 
 #include "tree_stall.h"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0b22e55cebe8..a5a879a49051 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -479,6 +479,7 @@ void wake_up_q(struct wake_q_head *head)
 {
 	struct wake_q_node *node = head->first;
 
+	trace_printk("entered\n");
 	while (node != WAKE_Q_TAIL) {
 		struct task_struct *task;
 
@@ -509,6 +510,7 @@ void resched_curr(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
+	trace_printk("entered\n");
 	lockdep_assert_held(&rq->lock);
 
 	if (test_tsk_need_resched(curr))
@@ -1197,6 +1199,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_printk("entered\n");
 	if (task_contributes_to_load(p))
 		rq->nr_uninterruptible--;
 
@@ -1298,6 +1301,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
 	const struct sched_class *class;
 
+	trace_printk("entered\n");
 	if (p->sched_class == rq->curr->sched_class) {
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
 	} else {
@@ -2097,6 +2101,7 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 			   struct rq_flags *rf)
 {
+	trace_printk("entered\n");
 	check_preempt_curr(rq, p, wake_flags);
 	p->state = TASK_RUNNING;
 	trace_sched_wakeup(p);
@@ -2132,6 +2137,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
 
+	trace_printk("entered\n");
 	lockdep_assert_held(&rq->lock);
 
 #ifdef CONFIG_SMP
@@ -2178,9 +2184,11 @@ void sched_ttwu_pending(void)
 	struct task_struct *p, *t;
 	struct rq_flags rf;
 
+	trace_printk("entered\n");
 	if (!llist)
 		return;
 
+	trace_printk("non-NULL llist\n");
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
@@ -2192,6 +2200,7 @@ void sched_ttwu_pending(void)
 
 void scheduler_ipi(void)
 {
+	trace_printk("entered\n");
 	/*
 	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
 	 * TIF_NEED_RESCHED remotely (for the first time) will also send
@@ -2232,6 +2241,7 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
+	trace_printk("%s entered, CPU %d\n", __func__, cpu);
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
@@ -2277,6 +2287,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	trace_printk("%s entered\n", __func__);
 #if defined(CONFIG_SMP)
 	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
@@ -2399,6 +2410,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	trace_printk("entered\n");
 	preempt_disable();
 	if (p == current) {
 		/*
@@ -2545,6 +2557,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 int wake_up_process(struct task_struct *p)
 {
+	trace_printk("entered\n");
 	return try_to_wake_up(p, TASK_NORMAL, 0);
 }
 EXPORT_SYMBOL(wake_up_process);
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 5c2b2f90fae1..a07f77b9c1f2 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sched/clock.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -80,6 +81,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	unsigned long flags;
 	bool enabled;
 
+	trace_printk("entered for CPU %u\n", cpu);
 	preempt_disable();
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
@@ -167,7 +169,7 @@ static void set_state(struct multi_stop_data *msdata,
 	/* Reset ack counter. */
 	atomic_set(&msdata->thread_ack, msdata->num_threads);
 	smp_wmb();
-	msdata->state = newstate;
+	WRITE_ONCE(msdata->state, newstate);
 }
 
 /* Last one to ack a state moves to the next state. */
@@ -179,7 +181,15 @@ static void ack_state(struct multi_stop_data *msdata)
 
 void __weak stop_machine_yield(const struct cpumask *cpumask)
 {
+	u64 starttime = local_clock();
+	u64 endtime;
+	const u64 delta = 100ULL * 1000ULL * 1000ULL * 1000ULL;
+
 	cpu_relax();
+	endtime = local_clock();
+	if (time_after64(endtime, starttime + delta))
+		trace_printk("cpu_relax() took %llu ms\n",
+			     (endtime - starttime) / (1000ULL * 1000ULL));
 }
 
 /* This is the cpu_stop function which stops the CPU. */
@@ -210,8 +220,9 @@ static int multi_cpu_stop(void *data)
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
 		stop_machine_yield(cpumask);
-		if (msdata->state != curstate) {
-			curstate = msdata->state;
+		if (READ_ONCE(msdata->state) != curstate) {
+			curstate = READ_ONCE(msdata->state);
+			trace_printk("curstate = %d, ack = %d\n", curstate, atomic_read(&msdata->thread_ack));
 			switch (curstate) {
 			case MULTI_STOP_DISABLE_IRQ:
 				local_irq_disable();
@@ -382,6 +393,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 	 * preempted by a stopper which might wait for other stoppers
 	 * to enter @fn which can lead to deadlock.
 	 */
+	trace_printk("entered\n");
 	preempt_disable();
 	stop_cpus_in_progress = true;
 	for_each_cpu(cpu, cpumask) {
@@ -402,11 +414,18 @@ static int __stop_cpus(const struct cpumask *cpumask,
 		       cpu_stop_fn_t fn, void *arg)
 {
 	struct cpu_stop_done done;
+	unsigned long j = jiffies;
 
+	tracing_on();
+	trace_printk("entered\n");
+	trace_printk("CPUs %*pbl online\n", cpumask_pr_args(cpu_online_mask));
 	cpu_stop_init_done(&done, cpumask_weight(cpumask));
 	if (!queue_stop_cpus_work(cpumask, fn, arg, &done))
 		return -ENOENT;
 	wait_for_completion(&done.completion);
+	tracing_off();
+	if (time_after(jiffies, j + HZ * 20))
+		ftrace_dump(DUMP_ALL);
 	return done.ret;
 }
 
@@ -442,6 +461,7 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 {
 	int ret;
 
+	trace_printk("entered\n");
 	/* static works are used, process one request at a time */
 	mutex_lock(&stop_cpus_mutex);
 	ret = __stop_cpus(cpumask, fn, arg);
@@ -599,6 +619,7 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
 		.active_cpus = cpus,
 	};
 
+	trace_printk("entered\n");
 	lockdep_assert_cpus_held();
 
 	if (!stop_machine_initialized) {

