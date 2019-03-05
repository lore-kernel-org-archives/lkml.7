Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E384C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133CD20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCEK5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:57:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53879 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:57:09 -0500
Received: from 79.184.253.110.ipv4.supernova.orange.pl (79.184.253.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 40a9587713d56c89; Tue, 5 Mar 2019 11:57:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        =?utf-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?utf-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Fix 32bit math overflow
Date:   Tue, 05 Mar 2019 11:55:30 +0100
Message-ID: <6859558.Jnm9at0D9I@aspire.rjw.lan>
In-Reply-To: <20190305083202.GU32494@hirez.programming.kicks-ass.net>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com> <20190304191059.mzwid3udqwtzejww@queper01-lin> <20190305083202.GU32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 5, 2019 9:32:02 AM CET Peter Zijlstra wrote:
> On Mon, Mar 04, 2019 at 07:11:01PM +0000, Quentin Perret wrote:
> 
> > So yeah, that works for me.
> 
> Chunyan, Vincent; can you verify the below cures your ill?
> 
> ---
> Subject: sched/cpufreq: Fix 32bit math overflow
> 
> Vincent Wang reported that get_next_freq() has a mult overflow issue on
> 32bit platforms in the IOWAIT boost case, since in that case {util,max}
> are in freq units instead of capacity units.
> 
> Solve this by moving the IOWAIT boost to capacity units. And since this
> means @max is constant; simplify the code.
> 
> Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Reported-by: Vincent Wang <vincent.wang@unisoc.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 58 +++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2efe629425be..72b62ac1c7c2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -48,10 +48,10 @@ struct sugov_cpu {
>  
>  	bool			iowait_boost_pending;
>  	unsigned int		iowait_boost;
> -	unsigned int		iowait_boost_max;
>  	u64			last_update;
>  
>  	unsigned long		bw_dl;
> +	unsigned long		min;
>  	unsigned long		max;
>  
>  	/* The field below is for single-CPU policies only: */
> @@ -303,8 +303,7 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
>  	if (delta_ns <= TICK_NSEC)
>  		return false;
>  
> -	sg_cpu->iowait_boost = set_iowait_boost
> -		? sg_cpu->sg_policy->policy->min : 0;
> +	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
>  	sg_cpu->iowait_boost_pending = set_iowait_boost;
>  
>  	return true;
> @@ -344,14 +343,12 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  
>  	/* Double the boost at each request */
>  	if (sg_cpu->iowait_boost) {
> -		sg_cpu->iowait_boost <<= 1;
> -		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> -			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> +		sg_cpu->iowait_boost = min(sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
>  		return;
>  	}
>  
>  	/* First wakeup after IO: start with minimum boost */
> -	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
> +	sg_cpu->iowait_boost = sg_cpu->min;
>  }
>  
>  /**
> @@ -373,47 +370,38 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * This mechanism is designed to boost high frequently IO waiting tasks, while
>   * being more conservative on tasks which does sporadic IO operations.
>   */
> -static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> -			       unsigned long *util, unsigned long *max)
> +static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +					unsigned long util, unsigned long max)
>  {
> -	unsigned int boost_util, boost_max;
> +	unsigned long boost;
>  
>  	/* No boost currently required */
>  	if (!sg_cpu->iowait_boost)
> -		return;
> +		return util;
>  
>  	/* Reset boost if the CPU appears to have been idle enough */
>  	if (sugov_iowait_reset(sg_cpu, time, false))
> -		return;
> +		return util;
>  
> -	/*
> -	 * An IO waiting task has just woken up:
> -	 * allow to further double the boost value
> -	 */
> -	if (sg_cpu->iowait_boost_pending) {
> -		sg_cpu->iowait_boost_pending = false;
> -	} else {
> +	if (!sg_cpu->iowait_boost_pending) {
>  		/*
> -		 * Otherwise: reduce the boost value and disable it when we
> -		 * reach the minimum.
> +		 * No boost pending; reduce the boost value.
>  		 */
>  		sg_cpu->iowait_boost >>= 1;
> -		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
> +		if (sg_cpu->iowait_boost < sg_cpu->min) {
>  			sg_cpu->iowait_boost = 0;
> -			return;
> +			return util;
>  		}
>  	}
>  
> +	sg_cpu->iowait_boost_pending = false;
> +
>  	/*
> -	 * Apply the current boost value: a CPU is boosted only if its current
> -	 * utilization is smaller then the current IO boost level.
> +	 * @util is already in capacity scale; convert iowait_boost
> +	 * into the same scale so we can compare.
>  	 */
> -	boost_util = sg_cpu->iowait_boost;
> -	boost_max = sg_cpu->iowait_boost_max;
> -	if (*util * boost_max < *max * boost_util) {
> -		*util = boost_util;
> -		*max = boost_max;
> -	}
> +	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> +	return max(boost, util);
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -460,7 +448,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  
>  	util = sugov_get_util(sg_cpu);
>  	max = sg_cpu->max;
> -	sugov_iowait_apply(sg_cpu, time, &util, &max);
> +	util = sugov_iowait_apply(sg_cpu, time, util, max);
>  	next_f = get_next_freq(sg_policy, util, max);
>  	/*
>  	 * Do not reduce the frequency if the CPU has not been idle
> @@ -500,7 +488,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  
>  		j_util = sugov_get_util(j_sg_cpu);
>  		j_max = j_sg_cpu->max;
> -		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
> +		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
>  
>  		if (j_util * max > j_max * util) {
>  			util = j_util;
> @@ -837,7 +825,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu			= cpu;
>  		sg_cpu->sg_policy		= sg_policy;
> -		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
> +		sg_cpu->min			=
> +			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> +			policy->cpuinfo.max_freq;
>  	}
>  
>  	for_each_cpu(cpu, policy->cpus) {
> 


