Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52527C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E12A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EhgUOilA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfCMOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:32:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l4y3uyx9OFx08MnbvVoBjf1QMWF43hx5TE5qEzJ65l8=; b=EhgUOilAsh89BK/UGoRir5+2L
        JWBLCMbScO9AA/REYxTunmHkol0X/caW8qpAJ9MAFUIWApVNhHDhfHgtFYpPj9CqwZk0frVwNhVhX
        Ah8UUpsUpSKGXCUD4/tx/pJHUNnVlwWJzyCCKttGH/t6coPy0ZcorVaknhr9zdOrK4wjl5zcIbWfM
        TGPOb5ud+BP2RnmbDhvEINC9qVw3/+8QYLBRpSli7Ru1Wbqs3Oz9l9b7j9BP8deK/QhEsWzSFXZHT
        6Kt42pz88yBhSbwX7+clqyJfy/e0Y6fVAltoWPl0yAVA2AW8WM1A5OMLHMLb8osYz8d5CLRSmDa9f
        J/cH65usw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44vx-0004j2-Q2; Wed, 13 Mar 2019 14:32:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B247202989D2; Wed, 13 Mar 2019 15:32:40 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:32:40 +0100
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
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190313143240.GH5922@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:42AM +0000, Patrick Bellasi wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 45460e7a3eee..447261cd23ba 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -584,14 +584,32 @@ struct sched_dl_entity {
>   * Utilization clamp for a scheduling entity
>   * @value:		clamp value "requested" by a se
>   * @bucket_id:		clamp bucket corresponding to the "requested" value
> + * @effective:		clamp value and bucket actually "assigned" to the se
> + * @active:		the se is currently refcounted in a rq's bucket
>   *
> + * Both bucket_id and effective::bucket_id are the index of the clamp bucket
> + * matching the corresponding clamp value which are pre-computed and stored to
> + * avoid expensive integer divisions from the fast path.
> + *
> + * The active bit is set whenever a task has got an effective::value assigned,
> + * which can be different from the user requested clamp value. This allows to
> + * know a task is actually refcounting the rq's effective::bucket_id bucket.
>   */
>  struct uclamp_se {
> +	/* Clamp value "requested" by a scheduling entity */
>  	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
>  	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
> +	unsigned int active		: 1;
> +	/*
> +	 * Clamp value "obtained" by a scheduling entity.
> +	 *
> +	 * This cache the actual clamp value, possibly enforced by system
> +	 * default clamps, a task is subject to while enqueued in a rq.
> +	 */
> +	struct {
> +		unsigned int value	: bits_per(SCHED_CAPACITY_SCALE);
> +		unsigned int bucket_id	: bits_per(UCLAMP_BUCKETS);
> +	} effective;

I still think that this effective thing is backwards.

The existing code already used @value and @bucket_id as 'effective' and
you're now changing all that again. This really doesn't make sense to
me.

Also; if you don't add it inside struct uclamp_se, but add a second
instance,

>  };
>  #endif /* CONFIG_UCLAMP_TASK */
>  


> @@ -803,6 +811,70 @@ static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id,
>  	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
>  }
>  
> +/*
> + * The effective clamp bucket index of a task depends on, by increasing
> + * priority:
> + * - the task specific clamp value, when explicitly requested from userspace
> + * - the system default clamp value, defined by the sysadmin
> + *
> + * As a side effect, update the task's effective value:
> + *    task_struct::uclamp::effective::value
> + * to represent the clamp value of the task effective bucket index.
> + */
> +static inline void
> +uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
> +		     unsigned int *clamp_value, unsigned int *bucket_id)
> +{
> +	/* Task specific clamp value */
> +	*bucket_id = p->uclamp[clamp_id].bucket_id;
> +	*clamp_value = p->uclamp[clamp_id].value;
> +
> +	/* Always apply system default restrictions */
> +	if (unlikely(*clamp_value > uclamp_default[clamp_id].value)) {
> +		*clamp_value = uclamp_default[clamp_id].value;
> +		*bucket_id = uclamp_default[clamp_id].bucket_id;
> +	}
> +}

you can avoid horrors like this and simply return a struct uclamp_se by
value.


