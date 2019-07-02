Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54462C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CB22082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JmqRM9vA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfGBQ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:29:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i3U3+SH43F3XPOPGdtgZpSBrZbLIY/EEkJSSfHm9egY=; b=JmqRM9vAEAnCpHNKTnMEyFDmv
        /Lg912H/YMUBUzQGySA2pVAwuzv8pvKtZ009UYIeUxYgRAy4S8pLASBf/ThV27EW5A5+5VTVwTgwL
        Qgr+KHaQ7Tt5ZfaIu17aICHChTKUoASSKtBs6WoLUI0iTSCrGc7YcA5FMdQrnYQA68eUHZ+m1ygcJ
        7+mSHfDoBza6bJC2z7UTAlFVsD5Zg9uKou8RsUaBjAjPN/EJw9xqQgT+XOO6A45MBGzqQu41xg0PK
        qrj9CD7/ND8SccTcqERmtG50WSPL4iv5jSDPxE90ug4gpnqQk0HBgWGbWSmgcTl1dhrBABS8+RvSU
        k9omqdFLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiLeo-00083w-L5; Tue, 02 Jul 2019 16:29:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13879203C694A; Tue,  2 Jul 2019 18:29:25 +0200 (CEST)
Date:   Tue, 2 Jul 2019 18:29:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: Re: [RFC PATCH 1/3] sched: Introduce new interface for scheduler
 soft affinity
Message-ID: <20190702162925.GZ3436@hirez.programming.kicks-ass.net>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-2-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626224718.21973-2-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:47:16PM -0700, subhra mazumdar wrote:
> @@ -1082,6 +1088,37 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>  		put_prev_task(rq, p);
>  
>  	p->sched_class->set_cpus_allowed(p, new_mask);
> +	set_cpus_preferred_common(p, new_mask);
> +
> +	if (queued)
> +		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
> +	if (running)
> +		set_curr_task(rq, p);
> +}
> +
> +void do_set_cpus_preferred(struct task_struct *p,
> +			   const struct cpumask *new_mask)
> +{
> +	struct rq *rq = task_rq(p);
> +	bool queued, running;
> +
> +	lockdep_assert_held(&p->pi_lock);
> +
> +	queued = task_on_rq_queued(p);
> +	running = task_current(rq, p);
> +
> +	if (queued) {
> +		/*
> +		 * Because __kthread_bind() calls this on blocked tasks without
> +		 * holding rq->lock.
> +		 */
> +		lockdep_assert_held(&rq->lock);
> +		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
> +	}
> +	if (running)
> +		put_prev_task(rq, p);
> +
> +	set_cpus_preferred_common(p, new_mask);
>  
>  	if (queued)
>  		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
> @@ -1170,6 +1207,41 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	return ret;
>  }
>  
> +static int
> +__set_cpus_preferred_ptr(struct task_struct *p, const struct cpumask *new_mask)
> +{
> +	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> +	unsigned int dest_cpu;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	int ret = 0;
> +
> +	rq = task_rq_lock(p, &rf);
> +	update_rq_clock(rq);
> +
> +	if (p->flags & PF_KTHREAD) {
> +		/*
> +		 * Kernel threads are allowed on online && !active CPUs
> +		 */
> +		cpu_valid_mask = cpu_online_mask;
> +	}
> +
> +	if (cpumask_equal(&p->cpus_preferred, new_mask))
> +		goto out;
> +
> +	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	do_set_cpus_preferred(p, new_mask);
> +
> +out:
> +	task_rq_unlock(rq, p, &rf);
> +
> +	return ret;
> +}
> +
>  int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
>  {
>  	return __set_cpus_allowed_ptr(p, new_mask, false);
> @@ -4724,7 +4796,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	return retval;
>  }
>  
> -long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> +long sched_setaffinity(pid_t pid, const struct cpumask *in_mask, int flags)
>  {
>  	cpumask_var_t cpus_allowed, new_mask;
>  	struct task_struct *p;
> @@ -4742,6 +4814,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  	get_task_struct(p);
>  	rcu_read_unlock();
>  
> +	if (flags == SCHED_SOFT_AFFINITY &&
> +	    p->sched_class != &fair_sched_class) {
> +		retval = -EINVAL;
> +		goto out_put_task;
> +	}
>  	if (p->flags & PF_NO_SETAFFINITY) {
>  		retval = -EINVAL;
>  		goto out_put_task;
> @@ -4790,18 +4867,37 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  	}
>  #endif
>  again:
> -	retval = __set_cpus_allowed_ptr(p, new_mask, true);
> -
> -	if (!retval) {
> -		cpuset_cpus_allowed(p, cpus_allowed);
> -		if (!cpumask_subset(new_mask, cpus_allowed)) {
> -			/*
> -			 * We must have raced with a concurrent cpuset
> -			 * update. Just reset the cpus_allowed to the
> -			 * cpuset's cpus_allowed
> -			 */
> -			cpumask_copy(new_mask, cpus_allowed);
> -			goto again;
> +	if (flags == SCHED_HARD_AFFINITY) {
> +		retval = __set_cpus_allowed_ptr(p, new_mask, true);
> +
> +		if (!retval) {
> +			cpuset_cpus_allowed(p, cpus_allowed);
> +			if (!cpumask_subset(new_mask, cpus_allowed)) {
> +				/*
> +				 * We must have raced with a concurrent cpuset
> +				 * update. Just reset the cpus_allowed to the
> +				 * cpuset's cpus_allowed
> +				 */
> +				cpumask_copy(new_mask, cpus_allowed);
> +				goto again;
> +			}
> +			p->affinity_unequal = false;
> +		}
> +	} else if (flags == SCHED_SOFT_AFFINITY) {
> +		retval = __set_cpus_preferred_ptr(p, new_mask);
> +		if (!retval) {
> +			cpuset_cpus_allowed(p, cpus_allowed);
> +			if (!cpumask_subset(new_mask, cpus_allowed)) {
> +				/*
> +				 * We must have raced with a concurrent cpuset
> +				 * update.
> +				 */
> +				cpumask_and(new_mask, new_mask, cpus_allowed);
> +				goto again;
> +			}
> +			if (!cpumask_equal(&p->cpus_allowed,
> +					   &p->cpus_preferred))
> +				p->affinity_unequal = true;
>  		}
>  	}
>  out_free_new_mask:

This seems like a terrible lot of pointless duplication; don't you get a
much smaller diff by passing the hard/soft thing into
__set_cpus_allowed_ptr() and only branching where it matters?
