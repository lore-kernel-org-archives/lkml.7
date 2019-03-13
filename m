Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16848C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4CF2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cu+lrHhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCMNwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:52:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfCMNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RG53r50nPpF7IX4NqLL/cGAKut5OYQQxH5dVNDOwMc4=; b=Cu+lrHhFM4vk2Xr1IGeqsOAzB
        rPP/3VQ4GdWdpIWnBVOiCl88Yj7f4orNO+wgjtWDNQyN/MUOtwt79i4SRIqzy2+pYAG0SvDULbYh3
        H6zv9ILFyNcY4OAO4ckEvUVxwyrDigrAQ/02NseVeMXalTo0oSHbfctRnY7SBj10B8Gm9PvVwm8WR
        sjcjr/XJvFE0BOIbXwBwcqDkS+XZ/oWQ05Vm8jaDZKF4pWOohpI9gekq9mzX279QZNy5EGBBf8ySx
        BL6hOXtWB9hEda3C/xy6PdNQhbJZa6eZtz4ar0ECSBarkVQECgpRTXKArB8guSOhuSWuBJ44EU2K2
        iZFFtkKUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44JD-00034s-95; Wed, 13 Mar 2019 13:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 107202028B0E8; Wed, 13 Mar 2019 14:52:38 +0100 (CET)
Date:   Wed, 13 Mar 2019 14:52:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190313135238.GC5922@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> +/*
> + * When a task is enqueued on a rq, the clamp bucket currently defined by the
> + * task's uclamp::bucket_id is reference counted on that rq. This also
> + * immediately updates the rq's clamp value if required.
> + *
> + * Since tasks know their specific value requested from user-space, we track
> + * within each bucket the maximum value for tasks refcounted in that bucket.
> + * This provide a further aggregation (local clamping) which allows to track
> + * within each bucket the exact "requested" clamp value whenever all tasks
> + * RUNNABLE in that bucket require the same clamp.
> + */
> +static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
> +				    unsigned int clamp_id)
> +{
> +	unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> +	unsigned int rq_clamp, bkt_clamp, tsk_clamp;
> +
> +	rq->uclamp[clamp_id].bucket[bucket_id].tasks++;
> +
> +	/*
> +	 * Local clamping: rq's buckets always track the max "requested"
> +	 * clamp value from all RUNNABLE tasks in that bucket.
> +	 */
> +	tsk_clamp = p->uclamp[clamp_id].value;
> +	bkt_clamp = rq->uclamp[clamp_id].bucket[bucket_id].value;
> +	rq->uclamp[clamp_id].bucket[bucket_id].value = max(bkt_clamp, tsk_clamp);

So, if I read this correct:

 - here we track a max value in a bucket,

> +	rq_clamp = READ_ONCE(rq->uclamp[clamp_id].value);
> +	WRITE_ONCE(rq->uclamp[clamp_id].value, max(rq_clamp, tsk_clamp));
> +}
> +
> +/*
> + * When a task is dequeued from a rq, the clamp bucket reference counted by
> + * the task is released. If this is the last task reference counting the rq's
> + * max active clamp value, then the rq's clamp value is updated.
> + * Both the tasks reference counter and the rq's cached clamp values are
> + * expected to be always valid, if we detect they are not we skip the updates,
> + * enforce a consistent state and warn.
> + */
> +static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
> +				    unsigned int clamp_id)
> +{
> +	unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> +	unsigned int rq_clamp, bkt_clamp;
> +
> +	SCHED_WARN_ON(!rq->uclamp[clamp_id].bucket[bucket_id].tasks);
> +	if (likely(rq->uclamp[clamp_id].bucket[bucket_id].tasks))
> +		rq->uclamp[clamp_id].bucket[bucket_id].tasks--;
> +
> +	/*
> +	 * Keep "local clamping" simple and accept to (possibly) overboost
> +	 * still RUNNABLE tasks in the same bucket.
> +	 */
> +	if (likely(rq->uclamp[clamp_id].bucket[bucket_id].tasks))
> +		return;

(Oh man, I hope that generates semi sane code; long live CSE passes I
suppose)

But we never decrement that bkt_clamp value on dequeue.

> +	bkt_clamp = rq->uclamp[clamp_id].bucket[bucket_id].value;
> +
> +	/* The rq's clamp value is expected to always track the max */
> +	rq_clamp = READ_ONCE(rq->uclamp[clamp_id].value);
> +	SCHED_WARN_ON(bkt_clamp > rq_clamp);
> +	if (bkt_clamp >= rq_clamp) {

head hurts, this reads ==, how can this ever not be so?

> +		/*
> +		 * Reset rq's clamp bucket value to its nominal value whenever
> +		 * there are anymore RUNNABLE tasks refcounting it.

-ENOPARSE

> +		 */
> +		rq->uclamp[clamp_id].bucket[bucket_id].value =
> +			uclamp_bucket_value(rq_clamp);

But basically you decrement the bucket value to the nominal value.

> +		uclamp_rq_update(rq, clamp_id);
> +	}
> +}

Given all that, what is to stop the bucket value to climbing to
uclamp_bucket_value(+1)-1 and staying there (provided there's someone
runnable)?

Why are we doing this... ?
