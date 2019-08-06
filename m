Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468BFC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135B320663
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfHFX5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:57:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfHFX5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:57:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76NpeJU118673;
        Tue, 6 Aug 2019 19:56:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7hf83yhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 19:56:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x76NuWJF128951;
        Tue, 6 Aug 2019 19:56:32 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7hf83yhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 19:56:32 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x76Nt5a1006516;
        Tue, 6 Aug 2019 23:56:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 2u51w63t9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 23:56:31 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x76NuUsK51839328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 23:56:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66467B2067;
        Tue,  6 Aug 2019 23:56:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B37BB2064;
        Tue,  6 Aug 2019 23:56:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 23:56:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 269EF16C9A58; Tue,  6 Aug 2019 16:56:31 -0700 (PDT)
Date:   Tue, 6 Aug 2019 16:56:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190806235631.GU28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806212041.118146-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> Recently a discussion about performance of system involving a high rate
> of kfree_rcu() calls surfaced on the list [1] which led to another
> discussion how to prepare for this situation.
> 
> This patch adds basic batching support for kfree_rcu. It is "basic"
> because we do none of the slab management, dynamic allocation, code
> moving or any of the other things, some of which previous attempts did
> [2]. These fancier improvements can be follow-up patches and there are
> several ideas being experimented in those regards.
> 
> Torture tests follow in the next patch and show improvements of around
> ~13% with continuous flooding of kfree_rcu() calls on a 16 CPU system.
> 
> [1] http://lore.kernel.org/lkml/20190723035725-mutt-send-email-mst@kernel.org
> [2] https://lkml.org/lkml/2017/12/19/824
> 
> This is an effort just to start simple, and build up from there.
> 
> Cc: Rao Shoaib <rao.shoaib@oracle.com>
> Cc: max.byungchul.park@gmail.com
> Cc: byungchul.park@lge.com
> Cc: kernel-team@android.com
> Cc: kernel-team@lge.com
> Co-developed-by: Byungchul Park <byungchul.park@lge.com>
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks like a great start!  Some comments and questions interspersed.
There are a number of fixes required for this to be ready for mainline,
but that is to be expected for v1.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 198 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 193 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a14e5fbbea46..bdbd483606ce 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2593,19 +2593,194 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> +
> +/* Maximum number of jiffies to wait before draining batch */
> +#define KFREE_DRAIN_JIFFIES 50
> +
> +/*
> + * Maximum number of kfree(s) to batch, if limit is hit
> + * then RCU work is queued right away
> + */
> +#define KFREE_MAX_BATCH	200000ULL
> +
> +struct kfree_rcu_cpu {
> +	/* The work done to free objects after GP */
> +	struct rcu_work rcu_work;

If I didn't already know what a struct rcu_work was, the comment would
completely confuse me.  The key point is that an rcu_work structure
is to queue_kfree_rcu_work() as rcu_head is to call_rcu().

All the header comments need to be complete sentences as well, including
the period at the end of the sentence.

Yes, I am sure that you find the existing comments in RCU just as
confusing, but all the more reason to make it easier on people reading
your code.  ;-)

> +	/* The list of objects being queued */
> +	struct rcu_head *head;

So these are the ones that have been queued, but are not yet waiting
for a grace period, correct?

> +	int kfree_batch_len;

This length applies only to the callbacks in ->head, and not to those
in ->head_free, yes?

> +	/* The list of objects pending a free */
> +	struct rcu_head *head_free;

And these are the ones waiting for a grace period, right?

> +	/* Protect concurrent access to this structure */
> +	spinlock_t lock;
> +
> +	/* The work done to monitor whether objects need free */
> +	struct delayed_work monitor_work;

This would be the callbacks in ->head, not those in ->head_free, right?

> +	bool monitor_todo;
> +};

Either way, the comments need a bit of work.

> +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> +
> +/* Free all heads after a grace period (worker function) */

Perhaps something like "This function is invoked in workqueue context
after a grace period.  It frees all the objects queued on ->head_free."

The current "Frees all heads" is asking for confusion between ->head
and ->head_free.

> +static void kfree_rcu_work(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	struct rcu_head *head, *next;
> +	struct kfree_rcu_cpu *krc = container_of(to_rcu_work(work),
> +					struct kfree_rcu_cpu, rcu_work);
> +
> +	spin_lock_irqsave(&krc->lock, flags);
> +	head = krc->head_free;
> +	krc->head_free = NULL;
> +	spin_unlock_irqrestore(&krc->lock, flags);
> +
> +	/* The head must be detached and not referenced from anywhere */
> +	for (; head; head = next) {
> +		next = head->next;
> +		head->next = NULL;
> +		/* Could be possible to optimize with kfree_bulk in future */
> +		__rcu_reclaim(rcu_state.name, head);

We need at least a cond_resched() here.  If earlier experience of
a series of kfree() calls taking two milliseconds each holds up, a
cond_resched_tasks_rcu_qs() would also be necessary.

The two-milliseconds experience was with more than one hundred CPUs
concurrently doing kfree(), in case you were wondering why you hadn't
seen this in single-threaded operation.

Of course, I am hoping that a later patch uses an array of pointers built
at kfree_rcu() time, similar to Rao's patch (with or without kfree_bulk)
in order to reduce per-object cache-miss overhead.  This would make it
easier for callback invocation to keep up with multi-CPU kfree_rcu()
floods.

> +	}
> +}
> +
> +/*
> + * Schedule the kfree batch RCU work to run after GP.

Better!  Still, please add the workqueue part, so that it is something
like "Schedule the kfree batch RCU work to run in workqueue context
after a GP."

> + *
> + * Either the batch reached its maximum size, or the monitor's
> + * time reached, either way schedule the batch work.

Perhaps something like "This function is invoked when the batch
has reached size KFREE_MAX_BATCH or when kfree_rcu_monitor() sees
that the KFREE_DRAIN_JIFFIES timeout has been reached."

> + */
> +static bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krc)

"krcp" would be more consistent with other RCU pointer naming.  It would
also avoid the "this_" prefix below, whose purpose appears to be to
avoid confusion between the "krc" per-CPU variable and the "krc" pointer
currently in use.

> +{
> +	lockdep_assert_held(&krc->lock);
> +
> +	/*
> +	 * Someone already drained, probably before the monitor's worker
> +	 * thread ran. Just return to avoid useless work.
> +	 */
> +	if (!krc->head)
> +		return true;

Given that we held the lock across the earlier enqueue of a callback
onto ->head, how can ->head be NULL here?  What am I missing?

> +	/*
> +	 * If RCU batch work already in progress, we cannot
> +	 * queue another one, just refuse the optimization.
> +	 */
> +	if (krc->head_free)
> +		return false;
> +
> +	krc->head_free = krc->head;
> +	krc->head = NULL;
> +	krc->kfree_batch_len = 0;
> +	INIT_RCU_WORK(&krc->rcu_work, kfree_rcu_work);
> +	queue_rcu_work(system_wq, &krc->rcu_work);
> +
> +	return true;
> +}
> +
> +static void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krc,
> +				   unsigned long flags)
> +{
> +	struct rcu_head *head, *next;
> +
> +	/* It is time to do bulk reclaim after grace period */
> +	krc->monitor_todo = false;
> +	if (queue_kfree_rcu_work(krc)) {
> +		spin_unlock_irqrestore(&krc->lock, flags);
> +		return;
> +	}
> +
> +	/*
> +	 * Use non-batch regular call_rcu for kfree_rcu in case things are too
> +	 * busy and batching of kfree_rcu could not be used.
> +	 */
> +	head = krc->head;
> +	krc->head = NULL;
> +	krc->kfree_batch_len = 0;
> +	spin_unlock_irqrestore(&krc->lock, flags);
> +
> +	for (; head; head = next) {
> +		next = head->next;
> +		head->next = NULL;
> +		__call_rcu(head, head->func, -1, 1);

We need at least a cond_resched() here.  200,000 times through this loop
in a PREEMPT=n kernel might not always be pretty.  Except that this is
invoked directly from kfree_rcu() which might be invoked with interrupts
disabled, which precludes calls to cond_resched().  So the realtime guys
are not going to be at all happy with this loop.

And this loop could be avoided entirely by having a third rcu_head list
in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
should be OK, or at least more OK than queuing 200,000 callbacks with
interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
pointers can be used to reduce the probability of oversized batches.)
This would also mean that the equality comparisons with KFREE_MAX_BATCH
need to become greater-or-equal comparisons or some such.

> +	}
> +}
> +
> +/*
> + * If enough time has passed, the kfree batch has to be drained
> + * and the monitor takes care of that.

Perhaps something like: "This function is invoked after the
KFREE_DRAIN_JIFFIES timeout has elapse, so it drains the specified
kfree_rcu_cpu structure's ->head list."

> + */
> +static void kfree_rcu_monitor(struct work_struct *work)
> +{
> +	bool todo;
> +	unsigned long flags;
> +	struct kfree_rcu_cpu *krc = container_of(work, struct kfree_rcu_cpu,
> +						 monitor_work.work);
> +
> +	/* It is time to do bulk reclaim after grace period */

Except that we really aren't doing kfree_bulk() yet because we are on
the wrong side of the grace period, which means that we are not going
to kfree() anything yet.  The actual kfree()ing happens after the grace
period.  (Yes, I see the other interpretation, but it would be good to
make it unambiguous.)

> +	spin_lock_irqsave(&krc->lock, flags);
> +	todo = krc->monitor_todo;
> +	krc->monitor_todo = false;
> +	if (todo)
> +		kfree_rcu_drain_unlock(krc, flags);
> +	else
> +		spin_unlock_irqrestore(&krc->lock, flags);
> +}
> +
> +static void kfree_rcu_batch(struct rcu_head *head, rcu_callback_t func)
> +{
> +	unsigned long flags;
> +	struct kfree_rcu_cpu *this_krc;
> +	bool monitor_todo;
> +
> +	local_irq_save(flags);
> +	this_krc = this_cpu_ptr(&krc);
> +
> +	spin_lock(&this_krc->lock);
> +
> +	/* Queue the kfree but don't yet schedule the batch */
> +	head->func = func;
> +	head->next = this_krc->head;
> +	this_krc->head = head;
> +	this_krc->kfree_batch_len++;
> +
> +	if (this_krc->kfree_batch_len == KFREE_MAX_BATCH) {
> +		kfree_rcu_drain_unlock(this_krc, flags);
> +		return;
> +	}
> +
> +	/* Maximum has not been reached, schedule monitor for timely drain */
> +	monitor_todo = this_krc->monitor_todo;
> +	this_krc->monitor_todo = true;
> +	spin_unlock(&this_krc->lock);
> +
> +	if (!monitor_todo) {
> +		schedule_delayed_work_on(smp_processor_id(),
> +				&this_krc->monitor_work,  KFREE_DRAIN_JIFFIES);
> +	}
> +	local_irq_restore(flags);
> +}
> +
>  /*
>   * Queue an RCU callback for lazy invocation after a grace period.

This should be expanded a bit.  Workqueue context and all that.

> - * This will likely be later named something like "call_rcu_lazy()",
> - * but this change will require some way of tagging the lazy RCU
> - * callbacks in the list of pending callbacks. Until then, this
> - * function may only be called from __kfree_rcu().
>   */
>  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	__call_rcu(head, func, -1, 1);
> +	kfree_rcu_batch(head, func);

Can't we just put the contents of kfree_rcu_batch() here and avoid the
extra level of function call?

>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
>  
> +/*
> + * The version of kfree_call_rcu that does not do batching of kfree_rcu()
> + * requests. To be used only for performance testing comparisons with
> + * kfree_rcu_batch().
> + */
> +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> +{
> +	__call_rcu(head, func, -1, 1);
> +}

You need an EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch) here to allow
rcuperf to be used via modprobe/rmmod.  Normally 0day test robot would
have complained about this.

> +
>  /*
>   * During early boot, any blocking grace-period wait automatically
>   * implies a grace period.  Later on, this is never the case for PREEMPT.
> @@ -3452,6 +3627,17 @@ static void __init rcu_dump_rcu_node_tree(void)
>  	pr_cont("\n");
>  }
>  
> +void kfree_rcu_batch_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +
> +		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> +	}
> +}
> +
>  struct workqueue_struct *rcu_gp_wq;
>  struct workqueue_struct *rcu_par_gp_wq;
>  
> @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
>  {
>  	int cpu;
>  
> +	kfree_rcu_batch_init();

What happens if someone does a kfree_rcu() before this point?  It looks
like it should work, but have you tested it?

>  	rcu_early_boot_tests();

For example, by testing it in rcu_early_boot_tests() and moving the
call to kfree_rcu_batch_init() here.

>  	rcu_bootup_announce();
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 
