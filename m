Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4983FC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172032077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfHPTQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:16:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfHPTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:16:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GIw0Wi141644
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:16:37 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ue0hum96f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:16:36 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 16 Aug 2019 20:16:35 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 20:16:31 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GJGUji53281266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 19:16:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1864DB2067;
        Fri, 16 Aug 2019 19:16:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2108B2064;
        Fri, 16 Aug 2019 19:16:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 19:16:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C875F16C2BCC; Fri, 16 Aug 2019 12:16:29 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:16:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@lge.com, Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190816164330.GA8320@linux.ibm.com>
 <20190816174429.GE10481@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816174429.GE10481@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081619-0060-0000-0000-0000036D344B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011600; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01247776; UDB=6.00658565; IPR=6.01029285;
 MB=3.00028205; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-16 19:16:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081619-0061-0000-0000-00004A93A2E9
Message-Id: <20190816191629.GW28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:44:29PM -0400, Joel Fernandes wrote:
> On Fri, Aug 16, 2019 at 09:43:30AM -0700, Paul E. McKenney wrote:
> > Hello, Joel,
> > 
> > I reworked the commit log as follows, but was then unsuccessful in
> > working out which -rcu commit to apply it to.  Could you please
> > tell me what commit to apply this to?  (Once applied, git cherry-pick
> > is usually pretty good about handling minor conflicts.)
> 
> It was originally based on v5.3-rc2
> 
> I was able to apply it just now to the rcu -dev branch and I pushed it here:
> https://github.com/joelagnel/linux-kernel.git (branch paul-dev)
> 
> Let me know if any other issues, thanks for the change log rework!

Pulled and cherry-picked, thank you!

Just for grins, I also  pushed out a from-joel.2019.08.16a showing the
results of the pull.  If you pull that branch, then run something like
"gitk v5.3-rc2..", and then do the same with branch "dev", comparing the
two might illustrate some of the reasons for the current restrictions
on pull requests and trees subject to rebase.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 							Thanx, Paul
> > 
> > On Wed, Aug 14, 2019 at 12:04:10PM -0400, Joel Fernandes (Google) wrote:
> > > A recent discussion about stability and performance systems with
> > > kfree_rcu() flooding [1] led to another discussion how to better handle
> > > this situation.
> > > 
> > > This commit starts simple, adding only basic batching support for
> > > kfree_rcu(). It is "basic" because it does none of the slab management,
> > > dynamic allocation, or code movement carried out by a previous attempt
> > > [2].  These additional improvements can be implemented later as agreement
> > > is reached on these other issues.  For example, future work might
> > > increase cache locality by applying vector object lists, kfree_bulk(),
> > > or per-slab batching to further improve handling of kfree_rcu() floods.
> > > 
> > > Performance tests are provided in a latter commmit.  These tests show a
> > > 5x reduction in number of grace periods on a 16 CPU system, with minimal
> > > increase in kfree() latency.
> > > 
> > > Note that this commit prevents rcu_barrier() from waiting for the
> > > execution of the kfree() calls associated with prior kfree_rcu()
> > > invocations.  This should not be a problem, given that the resulting
> > > pending kfree() calls do not prevent module unloading or filesystem
> > > unmounting.  The reason rcu_barrier() no longer waits for the kfree()
> > > calls is that the kfree_rcu() requests are now batched, so that at
> > > any given time there might be kfree_rcu() requests that are not yet
> > > known to the core RCU machinery.  Furthermore, once a kfree_rcu()
> > > grace period has elapsed, the actual kfree() invocations happen in
> > > workqueue context.  So rcu_barrier() no longer waits for all of the
> > > prior requests, nor it does not wait for the workqueue handlers to
> > > start, let alone complete.  If there is ever a good reason to wait for
> > > the kfree() invocation corresponding to all prior kfree_rcu() calls,
> > > an approapriate kfree_rcu_barrier() can be constructed.  However, at
> > > the moment no reasonable use case is apparent.
> > > 
> > > This commit can result in increased memory footprint because the
> > > batching can increase the kfree_rcu()-to-kfree() latency.  Later
> > > commits will reduce this memory footprint.
> > > 
> > > Later commits will also remove the special handling of kfree_rcu() by
> > > __rcu_reclaim() within the RCU core.  This will require changes to
> > > rcuperf testing and to early boot handling of kfree_rcu().
> > > 
> > > [1] http://lore.kernel.org/lkml/20190723035725-mutt-send-email-mst@kernel.org
> > > [2] https://lkml.org/lkml/2017/12/19/824
> > > 
> > > Cc: kernel-team@android.com
> > > Cc: kernel-team@lge.com
> > > Co-developed-by: Byungchul Park <byungchul.park@lge.com>
> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > ---
> > > v3->v4: Some corrections by Paul.
> > > 	Used xchg in places to simplify code.
> > > 
> > > v2->v3: Just some code comment changes thanks to Byungchul.
> > > 
> > > RFCv1->PATCH v2: Removed limits on the ->head list, just let it grow.
> > >                    Dropped KFREE_MAX_JIFFIES to HZ/50 from HZ/20 to reduce OOM occurrence.
> > >                    Removed sleeps in rcuperf test, just using cond_resched()in loop.
> > >                    Better code comments ;)
> > > 
> > >  include/linux/rcutiny.h |   5 ++
> > >  include/linux/rcutree.h |   1 +
> > >  kernel/rcu/tree.c       | 194 ++++++++++++++++++++++++++++++++++++++--
> > >  3 files changed, 194 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index 8e727f57d814..383f2481750f 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -39,6 +39,11 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	call_rcu(head, func);
> > >  }
> > >  
> > > +static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +	call_rcu(head, func);
> > > +}
> > > +
> > >  void rcu_qs(void);
> > >  
> > >  static inline void rcu_softirq_qs(void)
> > > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > > index 735601ac27d3..7e38b39ec634 100644
> > > --- a/include/linux/rcutree.h
> > > +++ b/include/linux/rcutree.h
> > > @@ -34,6 +34,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
> > >  
> > >  void synchronize_rcu_expedited(void);
> > >  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> > > +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
> > >  
> > >  void rcu_barrier(void);
> > >  bool rcu_eqs_special_set(int cpu);
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a14e5fbbea46..1d1847cadea2 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2593,17 +2593,185 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  }
> > >  EXPORT_SYMBOL_GPL(call_rcu);
> > >  
> > > +
> > > +/* Maximum number of jiffies to wait before draining a batch. */
> > > +#define KFREE_DRAIN_JIFFIES (HZ / 50)
> > > +
> > >  /*
> > > - * Queue an RCU callback for lazy invocation after a grace period.
> > > - * This will likely be later named something like "call_rcu_lazy()",
> > > - * but this change will require some way of tagging the lazy RCU
> > > - * callbacks in the list of pending callbacks. Until then, this
> > > - * function may only be called from __kfree_rcu().
> > > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > > + * kfree(s) is queued for freeing after a grace period, right away.
> > >   */
> > > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +struct kfree_rcu_cpu {
> > > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > > +	 * is done after a grace period.
> > > +	 */
> > > +	struct rcu_work rcu_work;
> > > +
> > > +	/* The list of objects being queued in a batch but are not yet
> > > +	 * scheduled to be freed.
> > > +	 */
> > > +	struct rcu_head *head;
> > > +
> > > +	/* The list of objects that have now left ->head and are queued for
> > > +	 * freeing after a grace period.
> > > +	 */
> > > +	struct rcu_head *head_free;
> > > +
> > > +	/* Protect concurrent access to this structure. */
> > > +	spinlock_t lock;
> > > +
> > > +	/* The delayed work that flushes ->head to ->head_free incase ->head
> > > +	 * within KFREE_DRAIN_JIFFIES. In case flushing cannot be done if RCU
> > > +	 * is busy, ->head just continues to grow and we retry flushing later.
> > > +	 */
> > > +	struct delayed_work monitor_work;
> > > +	bool monitor_todo;	/* Is a delayed work pending execution? */
> > > +};
> > > +
> > > +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> > > +
> > > +/*
> > > + * This function is invoked in workqueue context after a grace period.
> > > + * It frees all the objects queued on ->head_free.
> > > + */
> > > +static void kfree_rcu_work(struct work_struct *work)
> > > +{
> > > +	unsigned long flags;
> > > +	struct rcu_head *head, *next;
> > > +	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> > > +					struct kfree_rcu_cpu, rcu_work);
> > > +
> > > +	spin_lock_irqsave(&krcp->lock, flags);
> > > +	head = krcp->head_free;
> > > +	krcp->head_free = NULL;
> > > +	spin_unlock_irqrestore(&krcp->lock, flags);
> > > +
> > > +	/*
> > > +	 * The head is detached and not referenced from anywhere, so lockless
> > > +	 * access is Ok.
> > > +	 */
> > > +	for (; head; head = next) {
> > > +		next = head->next;
> > > +		/* Could be possible to optimize with kfree_bulk in future */
> > > +		__rcu_reclaim(rcu_state.name, head);
> > > +		cond_resched_tasks_rcu_qs();
> > > +	}
> > > +}
> > > +
> > > +/*
> > > + * Schedule the kfree batch RCU work to run in workqueue context after a GP.
> > > + *
> > > + * This function is invoked by kfree_rcu_monitor() when the KFREE_DRAIN_JIFFIES
> > > + * timeout has been reached.
> > > + */
> > > +static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > > +{
> > > +	lockdep_assert_held(&krcp->lock);
> > > +
> > > +	/* If a previous RCU batch work is already in progress, we cannot queue
> > > +	 * another one, just refuse the optimization and it will be retried
> > > +	 * again in KFREE_DRAIN_JIFFIES time.
> > > +	 */
> > > +	if (krcp->head_free)
> > > +		return false;
> > > +
> > > +	krcp->head_free = krcp->head;
> > > +	krcp->head = NULL;
> > > +	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
> > > +	queue_rcu_work(system_wq, &krcp->rcu_work);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > > +				   unsigned long flags)
> > > +{
> > > +	/* Flush ->head to ->head_free, all objects on ->head_free will be
> > > +	 * kfree'd after a grace period.
> > > +	 */
> > > +	if (queue_kfree_rcu_work(krcp)) {
> > > +		/* Success! Our job is done here. */
> > > +		spin_unlock_irqrestore(&krcp->lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Previous batch that was queued to RCU did not get free yet, let us
> > > +	 * try again soon.
> > > +	 */
> > > +	if (!xchg(&krcp->monitor_todo, true))
> > > +		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > > +	spin_unlock_irqrestore(&krcp->lock, flags);
> > > +}
> > > +
> > > +/*
> > > + * This function is invoked after the KFREE_DRAIN_JIFFIES timeout has elapsed,
> > > + * and it drains the specified kfree_rcu_cpu structure's ->head list.
> > > + */
> > > +static void kfree_rcu_monitor(struct work_struct *work)
> > > +{
> > > +	unsigned long flags;
> > > +	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
> > > +						 monitor_work.work);
> > > +
> > > +	spin_lock_irqsave(&krcp->lock, flags);
> > > +	if (xchg(&krcp->monitor_todo, false))
> > > +		kfree_rcu_drain_unlock(krcp, flags);
> > > +	else
> > > +		spin_unlock_irqrestore(&krcp->lock, flags);
> > > +}
> > > +
> > > +/*
> > > + * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
> > > + * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
> > > + */
> > > +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> > >  {
> > >  	__call_rcu(head, func, -1, 1);
> > >  }
> > > +EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
> > > +
> > > +/*
> > > + * Queue a request for lazy invocation of kfree() after a grace period.
> > > + *
> > > + * Each kfree_call_rcu() request is added to a batch. The batch will be drained
> > > + * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
> > > + * will be kfree'd in workqueue context. This allows us to:
> > > + *
> > > + * 1. Batch requests together to reduce the number of grace periods during
> > > + * heavy kfree_rcu() load.
> > > + *
> > > + * 2. In the future, makes it possible to use kfree_bulk() on a large number of
> > > + * kfree_rcu() requests thus reducing the per-object overhead of kfree() and
> > > + * also reducing cache misses.
> > > + */
> > > +void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +	unsigned long flags;
> > > +	struct kfree_rcu_cpu *krcp;
> > > +
> > > +	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
> > > +	 * is not yet up, just skip batching and do the non-batched version.
> > > +	 */
> > > +	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> > > +		return kfree_call_rcu_nobatch(head, func);
> > > +
> > > +	head->func = func;
> > > +
> > > +	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
> > > +	krcp = this_cpu_ptr(&krc);
> > > +	spin_lock(&krcp->lock);
> > > +
> > > +	/* Queue the kfree but don't yet schedule the batch. */
> > > +	head->next = krcp->head;
> > > +	krcp->head = head;
> > > +
> > > +	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
> > > +	if (!xchg(&krcp->monitor_todo, true))
> > > +		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > > +
> > > +	spin_unlock(&krcp->lock);
> > > +	local_irq_restore(flags);
> > > +}
> > >  EXPORT_SYMBOL_GPL(kfree_call_rcu);
> > >  
> > >  /*
> > > @@ -3455,10 +3623,24 @@ static void __init rcu_dump_rcu_node_tree(void)
> > >  struct workqueue_struct *rcu_gp_wq;
> > >  struct workqueue_struct *rcu_par_gp_wq;
> > >  
> > > +static void __init kfree_rcu_batch_init(void)
> > > +{
> > > +	int cpu;
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > +
> > > +		spin_lock_init(&krcp->lock);
> > > +		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> > > +	}
> > > +}
> > > +
> > >  void __init rcu_init(void)
> > >  {
> > >  	int cpu;
> > >  
> > > +	kfree_rcu_batch_init();
> > > +
> > >  	rcu_early_boot_tests();
> > >  
> > >  	rcu_bootup_announce();
> > > -- 
> > > 2.23.0.rc1.153.gdeed80330f-goog
> > > 
> 

