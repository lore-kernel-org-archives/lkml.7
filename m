Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2642C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCMPPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:15:42 -0400
Received: from foss.arm.com ([217.140.101.70]:59026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMPPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:15:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD7980D;
        Wed, 13 Mar 2019 08:15:40 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8FE73F71D;
        Wed, 13 Mar 2019 08:15:37 -0700 (PDT)
Date:   Wed, 13 Mar 2019 15:15:35 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190313151535.q5ivsuywvwkewrk5@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <21171fa0-7fd5-ebbf-dd48-d6668ed563af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21171fa0-7fd5-ebbf-dd48-d6668ed563af@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Mar 13:52, Dietmar Eggemann wrote:
> On 2/8/19 11:05 AM, Patrick Bellasi wrote:
> 
> [...]
> 
> > +config UCLAMP_BUCKETS_COUNT
> > +	int "Number of supported utilization clamp buckets"
> > +	range 5 20
> > +	default 5
> > +	depends on UCLAMP_TASK
> > +	help
> > +	  Defines the number of clamp buckets to use. The range of each bucket
> > +	  will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
> > +	  number of clamp buckets the finer their granularity and the higher
> > +	  the precision of clamping aggregation and tracking at run-time.
> > +
> > +	  For example, with the default configuration we will have 5 clamp
> > +	  buckets tracking 20% utilization each. A 25% boosted tasks will be
> > +	  refcounted in the [20..39]% bucket and will set the bucket clamp
> > +	  effective value to 25%.
> > +	  If a second 30% boosted task should be co-scheduled on the same CPU,
> > +	  that task will be refcounted in the same bucket of the first task and
> > +	  it will boost the bucket clamp effective value to 30%.
> > +	  The clamp effective value of a bucket is reset to its nominal value
> > +	  (20% in the example above) when there are anymore tasks refcounted in
> 
> this sounds weird.

Why ?

> 
> [...]
> 
> > +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> > +{
> > +	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> > +}
> 
> Soemthing like uclamp_bucket_nominal_value() should be clearer.

Maybe... can update it in v8

> > +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > +{
> > +	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > +	unsigned int max_value = uclamp_none(clamp_id);
> > +	unsigned int bucket_id;
> 
> unsigned int bucket_id = UCLAMP_BUCKETS;
> 
> > +
> > +	/*
> > +	 * Both min and max clamps are MAX aggregated, thus the topmost
> > +	 * bucket with some tasks defines the rq's clamp value.
> > +	 */
> > +	bucket_id = UCLAMP_BUCKETS;
> 
> to get rid of this line?

I put it on a different line as a justfication for the loop variable
initialization described in the comment above.

> 
> > +	do {
> > +		--bucket_id;
> > +		if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> 
> if (!bucket[bucket_id].tasks)

Right... that's some leftover from the last refactoring!

[...]

> > + * within each bucket the exact "requested" clamp value whenever all tasks
> > + * RUNNABLE in that bucket require the same clamp.
> > + */
> > +static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
> > +				    unsigned int clamp_id)
> > +{
> > +	unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > +	unsigned int rq_clamp, bkt_clamp, tsk_clamp;
> 
> Wouldn't it be easier to have a pointer to the task's and rq's uclamp
> structure as well to the bucket?
> 
> -       unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> +       struct uclamp_se *uc_se = &p->uclamp[clamp_id];
> +       struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
> +       struct uclamp_bucket *bucket = &uc_rq->bucket[uc_se->bucket_id];

I think I went back/forth a couple of times in using pointer or the
extended version, which both have pros and cons.

I personally prefer the pointers as you suggest but I've got the
impression in the past that since everybody cleared "basic C trainings"
it's not so difficult to read the code above too.

> The code in uclamp_rq_inc_id() and uclamp_rq_dec_id() for example becomes
> much more readable.

Agree... let's try to switch once again in v8 and see ;)

> [...]
> 
> >   struct sched_class {
> >   	const struct sched_class *next;
> > +#ifdef CONFIG_UCLAMP_TASK
> > +	int uclamp_enabled;
> > +#endif
> > +
> >   	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
> >   	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
> > -	void (*yield_task)   (struct rq *rq);
> > -	bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
> >   	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
> > @@ -1685,7 +1734,6 @@ struct sched_class {
> >   	void (*set_curr_task)(struct rq *rq);
> >   	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
> >   	void (*task_fork)(struct task_struct *p);
> > -	void (*task_dead)(struct task_struct *p);
> >   	/*
> >   	 * The switched_from() call is allowed to drop rq->lock, therefore we
> > @@ -1702,12 +1750,17 @@ struct sched_class {
> >   	void (*update_curr)(struct rq *rq);
> > +	void (*yield_task)   (struct rq *rq);
> > +	bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
> > +
> >   #define TASK_SET_GROUP		0
> >   #define TASK_MOVE_GROUP		1
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> >   	void (*task_change_group)(struct task_struct *p, int type);
> >   #endif
> > +
> > +	void (*task_dead)(struct task_struct *p);
> 
> Why do you move yield_task, yield_to_task and task_dead here?

Since I'm adding a new field at the beginning of the struct, which is
used at enqueue/dequeue time, this is to ensure that all the
callbacks used in these paths are grouped together and don't fall
across a cache line... but yes, that's supposed to be a
micro-optimization which I can skip in this patch.

-- 
#include <best/regards.h>

Patrick Bellasi
