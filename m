Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A008C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5372921848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfISI3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:29:53 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:39913 "EHLO
        2.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfISI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:29:53 -0400
X-Greylist: delayed 155106 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 04:29:50 EDT
Received: from player168.ha.ovh.net (unknown [10.108.35.211])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id CA6C4190369
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:11:04 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id E53A09E20A08;
        Thu, 19 Sep 2019 08:10:57 +0000 (UTC)
Date:   Thu, 19 Sep 2019 10:10:53 +0200
From:   Quentin Perret <qperret@qperret.net>
To:     YT Chang <yt.chang@mediatek.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched/eas: introduce system-wide overutil indicator
Message-ID: <20190919081053.GA10561@qperret.net>
References: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Ovh-Tracer-Id: 4041980666167909293
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you please CC me on later versions of this ? I'm interested.

On Thursday 19 Sep 2019 at 15:20:22 (+0800), YT Chang wrote:
> When the system is overutilization, the load-balance crossing
> clusters will be triggered and scheduler will not use energy
> aware scheduling to choose CPUs.
> 
> The overutilization means the loading of  ANY CPUs
> exceeds threshold (80%).
> 
> However, only 1 heavy task or while-1 program will run on highest
> capacity CPUs and it still result to trigger overutilization. So
> the system will not use Energy Aware scheduling.
> 
> To avoid it, a system-wide over-utilization indicator to trigger
> load-balance cross clusters.
> 
> The policy is:
> 	The loading of "ALL CPUs in the highest capacity"
> 						exceeds threshold(80%) or
> 	The loading of "Any CPUs not in the highest capacity"
> 						exceed threshold(80%)
> 
> Signed-off-by: YT Chang <yt.chang@mediatek.com>

Right, so we originally went for the simpler implementation because in
general when you have the biggest CPUs of the system running flat out at
max freq, the micro-optimizations for energy on littles don't matter all
that much. Is there a use-case where you see a big difference ?

A second thing is RT pressure. If a big CPU is used at 50% by a CFS task
and 50% by RT, we should mark it overutilized. Otherwise EAS will think
the CFS task is 50% and try to down-migrate it. But the truth is, we
dont know the size of the task ... So, I believe your patch breaks that
ATM.

And there is a similar problem with misfit. That is, a task running flat
out on a big CPU will be flagged as misfit, even if there is nothing we
can do about (we can't up-migrate it for obvious reasons). So perhaps we
should look at a common solution for both issues, if deemed useful.

> ---
>  kernel/sched/fair.c | 76 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 036be95..f4c3d70 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5182,10 +5182,71 @@ static inline bool cpu_overutilized(int cpu)
>  static inline void update_overutilized_status(struct rq *rq)
>  {
>  	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> +		if (capacity_orig_of(cpu_of(rq)) < rq->rd->max_cpu_capacity) {
> +			WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> +			trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> +		}
>  	}
>  }
> +
> +static
> +void update_system_overutilized(struct sched_domain *sd, struct cpumask *cpus)
> +{
> +	unsigned long group_util;
> +	bool intra_overutil = false;
> +	unsigned long max_capacity;
> +	struct sched_group *group = sd->groups;
> +	struct root_domain *rd;
> +	int this_cpu;
> +	bool overutilized;
> +	int i;
> +
> +	this_cpu = smp_processor_id();
> +	rd = cpu_rq(this_cpu)->rd;
> +	overutilized = READ_ONCE(rd->overutilized);
> +	max_capacity = rd->max_cpu_capacity;
> +
> +	do {
> +		group_util = 0;
> +		for_each_cpu_and(i, sched_group_span(group), cpus) {
> +			group_util += cpu_util(i);
> +			if (cpu_overutilized(i)) {
> +				if (capacity_orig_of(i) < max_capacity) {

This is what breaks things with RT pressure I think.

> +					intra_overutil = true;
> +					break;
> +				}
> +			}
> +		}
> +
> +		/*
> +		 * A capacity base hint for over-utilization.
> +		 * Not to trigger system overutiled if heavy tasks
> +		 * in Big.cluster, so
> +		 * add the free room(20%) of Big.cluster is impacted which means
> +		 * system-wide over-utilization,
> +		 * that considers whole cluster not single cpu
> +		 */
> +		if (group->group_weight > 1 && (group->sgc->capacity * 1024 <
> +						group_util * capacity_margin)) {
> +			intra_overutil = true;
> +			break;
> +		}

What if we have only one big MC domain with both big and little CPUs and
no DIE ? Say you have 4 big tasks, 4 big CPUs, 4 little CPUs (idle).
You'll fail to mark the system overutilized no ?

> +
> +		group = group->next;
> +
> +	} while (group != sd->groups && !intra_overutil);
> +
> +	if (overutilized != intra_overutil) {
> +		if (intra_overutil == true) {
> +			WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> +			trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +		} else {
> +			WRITE_ONCE(rd->overutilized, 0);
> +			trace_sched_overutilized_tp(rd, 0);
> +		}
> +	}
> +}
> +
>  #else
>  static inline void update_overutilized_status(struct rq *rq) { }
>  #endif
> @@ -8242,15 +8303,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  
>  		/* update overload indicator if we are at root domain */
>  		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> -
> -		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> -	} else if (sg_status & SG_OVERUTILIZED) {
> -		struct root_domain *rd = env->dst_rq->rd;
> -
> -		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
>  	}
>  }
>  
> @@ -8476,6 +8528,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	 */
>  	update_sd_lb_stats(env, &sds);
>  
> +	update_system_overutilized(env->sd, env->cpus);
> +
>  	if (sched_energy_enabled()) {
>  		struct root_domain *rd = env->dst_rq->rd;
>  
> -- 
> 1.9.1
> 
