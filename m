Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5AAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A2F21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLRWu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:50:29 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:40567 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfLRWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:50:29 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 5D904D0B02
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 22:50:26 +0000 (GMT)
Received: (qmail 26881 invoked from network); 18 Dec 2019 22:50:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Dec 2019 22:50:26 -0000
Date:   Wed, 18 Dec 2019 22:50:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191218225023.GG3178@techsingularity.net>
References: <20191218154402.GF3178@techsingularity.net>
 <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:50:52PM +0000, Valentin Schneider wrote:
> > In general, the patch simply seeks to avoid unnecessarily cross-node
> > migrations when a machine is lightly loaded but shows benefits for other
> > workloads. While tests are still running, so far it seems to benefit
> > light-utilisation smaller workloads on large machines and does not appear
> > to do any harm to larger or parallelised workloads.
> > 
> 
> Thanks for the detailed testing, I haven't digested it entirely yet but I
> appreciate the effort.
> 

No problem, this is one of those patches that it's best to test a bunch
of loads and machines. I haven't presented it all because the changelog
would be beyond ridiculous.

> > @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >  		env->migration_type = migrate_task;
> >  		env->imbalance = max_t(long, 0, (local->idle_cpus -
> >  						 busiest->idle_cpus) >> 1);
> > +
> > +out_spare:
> > +		/*
> > +		 * Whether balancing the number of running tasks or the number
> > +		 * of idle CPUs, consider allowing some degree of imbalance if
> > +		 * migrating between NUMA domains.
> > +		 */
> > +		if (env->sd->flags & SD_NUMA) {
> > +			unsigned int imbalance_adj, imbalance_max;
> > +
> > +			/*
> > +			 * imbalance_adj is the allowable degree of imbalance
> > +			 * to exist between two NUMA domains. It's calculated
> > +			 * relative to imbalance_pct with a minimum of two
> > +			 * tasks or idle CPUs.
> > +			 */
> > +			imbalance_adj = (busiest->group_weight *
> > +				(env->sd->imbalance_pct - 100) / 100) >> 1;
> 
> IIRC imbalance_pct for NUMA domains uses the default 125, so I read this as
> "allow an imbalance of 1 task per 8 CPU in the source group" (just making
> sure I follow).
> 

That is how it works out in most cases. As imbalance_pct can be anything
in theory, I didn't specify what it usually breaks down to. The >> 1 is
to go "half way" similar to how imbalance itself is calculated.

> > +			imbalance_adj = max(imbalance_adj, 2U);
> > +
> > +			/*
> > +			 * Ignore imbalance unless busiest sd is close to 50%
> > +			 * utilisation. At that point balancing for memory
> > +			 * bandwidth and potentially avoiding unnecessary use
> > +			 * of HT siblings is as relevant as memory locality.
> > +			 */
> > +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
> > +			if (env->imbalance <= imbalance_adj &&
> > +			    busiest->sum_nr_running < imbalance_max) {
> 
> The code does "unless busiest group has half as many runnable tasks (or more)
> as it has CPUs (modulo the adj thing)", is that what you mean by "unless
> busiest sd is close to 50% utilisation" in the comment? It's somewhat
> different IMO.
> 

Crap, yes. At the time of writing, I was thinking in terms of running
tasks that were fully active hence the misleading comment.

> > +				env->imbalance = 0;
> > +			}
> > +		}
> >  		return;
> >  	}
> >  
> > 
> I'm quite sure you have reasons to have written it that way, but I was
> hoping we could squash it down to something like:

I wrote it that way to make it clear exactly what has changed, the
thinking behind the checks and to avoid 80-col limits to make review
easier overall. It's a force of habit and I'm happy to reformat it as
you suggest except....

> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..f05d09a8452e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8680,16 +8680,27 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			env->migration_type = migrate_task;
>  			lsub_positive(&nr_diff, local->sum_nr_running);
>  			env->imbalance = nr_diff >> 1;
> -			return;
> +		} else {
> +
> +			/*
> +			 * If there is no overload, we just want to even the number of
> +			 * idle cpus.
> +			 */
> +			env->migration_type = migrate_task;
> +			env->imbalance = max_t(long, 0, (local->idle_cpus -
> +							 busiest->idle_cpus) >> 1);
>  		}
>  
>  		/*
> -		 * If there is no overload, we just want to even the number of
> -		 * idle cpus.
> +		 * Allow for a small imbalance between NUMA groups; don't do any
> +		 * of it if there is at least half as many tasks / busy CPUs as
> +		 * there are available CPUs in the busiest group
>  		 */
> -		env->migration_type = migrate_task;
> -		env->imbalance = max_t(long, 0, (local->idle_cpus -
> -						 busiest->idle_cpus) >> 1);
> +		if (env->sd->flags & SD_NUMA &&
> +		    (busiest->sum_nr_running < busiest->group_weight >> 1) &&

This last line is not exactly equivalent to what I wrote. It would need
to be

	(busiest->sum_nr_running < (busiest->group_weight >> 1) - imbalance_adj) &&

I can test as you suggest to see if it's roughly equivalent in terms of
performance. The intent was to have a cutoff just before we reached 50%
running tasks / busy CPUs.

-- 
Mel Gorman
SUSE Labs
