Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75221C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563F72146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTMkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:40:08 -0500
Received: from foss.arm.com ([217.140.110.172]:50454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLTMkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:40:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C17030E;
        Fri, 20 Dec 2019 04:40:07 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A7133F719;
        Fri, 20 Dec 2019 04:40:05 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191220084252.GL3178@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d44ae0ff-3bd7-fab1-66d0-71769c078918@arm.com>
Date:   Fri, 20 Dec 2019 12:40:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220084252.GL3178@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2019 08:42, Mel Gorman wrote:
> In general, the patch simply seeks to avoid unnecessarily cross-node
> migrations when a machine is lightly loaded but shows benefits for other
> workloads. While tests are still running, so far it seems to benefit
> light-utilisation smaller workloads on large machines and does not appear
> to do any harm to larger or parallelised workloads.
> 
> [valentin.schneider@arm.com: Reformat code flow, correct comment, use idle_cpus]

I think only the comment bit is still there in this version and it's not
really worth mentioning (but I do thank you for doing it!).

> @@ -8671,6 +8667,39 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			return;
>  		}
>  
> +		/* Consider allowing a small imbalance between NUMA groups */
> +		if (env->sd->flags & SD_NUMA) {
> +			unsigned int imbalance_adj, imbalance_max;
> +
> +			/*
> +			 * imbalance_adj is the allowable degree of imbalance
> +			 * to exist between two NUMA domains. It's calculated
> +			 * relative to imbalance_pct with a minimum of two
> +			 * tasks or idle CPUs. The choice of two is due to
> +			 * the most basic case of two communicating tasks
> +			 * that should remain on the same NUMA node after
> +			 * wakeup.
> +			 */
> +			imbalance_adj = max(2U, (busiest->group_weight *
> +				(env->sd->imbalance_pct - 100) / 100) >> 1);
> +
> +			/*
> +			 * Ignore small imbalances unless the busiest sd has
> +			 * almost half as many busy CPUs as there are
> +			 * available CPUs in the busiest group. Note that

This is all on the busiest group, so this should be more like:

			 * Ignore small imbalances unless almost half of the
			 * busiest sg's CPUs are busy.

> +			 * it is not exactly half as imbalance_adj must be
> +			 * accounted for or the two domains do not converge
> +			 * as equally balanced if the number of busy tasks is
> +			 * roughly the size of one NUMA domain.
> +			 */
> +			imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;
> +			if (env->imbalance <= imbalance_adj &&

I'm confused now, have we set env->imbalance to anything at this point? AIUI
Vincent's suggestion was to hinge this purely on the weight vs idle_cpus /
nr_running, IOW not use imbalance:

if (sd->flags & SD_NUMA) {                                                                         
	imbalance_adj = max(2U, (busiest->group_weight *                                           
				 (env->sd->imbalance_pct - 100) / 100) >> 1);                      
	imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;                              
                                                                                                     
	if (busiest->idle_cpus >= imbalance_max) {                                                 
		env->imbalance = 0;                                                                
		return;                                                                            
	}                                                                                          
}                                                                                                  
       
Now, I have to say I'm not sold on the idle_cpus thing, I'd much rather use
the number of runnable tasks. We are setting up a threshold for how far we
are willing to ignore imbalances; if we have overloaded CPUs we *really*
should try to solve this. Number of tasks is the safer option IMO: when we
do have one task per CPU, it'll be the same as if we had used idle_cpus, and
when we don't have one task per CPU we'll load-balance more often that we
would have with idle_cpus.

> +			    busiest->idle_cpus >= imbalance_max) {
> +				env->imbalance = 0;
> +				return;
> +			}
> +		}
> +
>  		if (busiest->group_weight == 1 || sds->prefer_sibling) {
>  			unsigned int nr_diff = busiest->sum_nr_running;
>  			/*
> 
