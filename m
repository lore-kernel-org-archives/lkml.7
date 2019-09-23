Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8283920820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437024AbfIWIFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:05:30 -0400
Received: from foss.arm.com ([217.140.110.172]:38226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436751AbfIWIF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:05:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B41541000;
        Mon, 23 Sep 2019 01:05:28 -0700 (PDT)
Received: from [192.168.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FE1A3F59C;
        Mon, 23 Sep 2019 01:08:00 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/eas: introduce system-wide overutil indicator
To:     YT Chang <yt.chang@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <17c5f3bf-b739-b041-c71a-3d568be6f46d@arm.com>
Date:   Mon, 23 Sep 2019 10:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 9:20 AM, YT Chang wrote:
> When the system is overutilization, the load-balance crossing
> clusters will be triggered and scheduler will not use energy
> aware scheduling to choose CPUs.

We're currently transitioning from traditional big.LITTLE (the CPUs of 1
cluster (all having the same CPU (original) capacity) represent a DIE
Sched Domain (SD) level Sched Group (SG)) to DynamIQ systems. Later can
share CPUs with different CPU (original) capacity in one cluster.
In Linux mainline with today's DynamIQ systems (1 cluster) you will
only have 1 cluster, i.e. 1 MC SD level SG.

For those systems the current approach is much more applicable.

Or do you apply the out-of-tree Phantom Domain concept, which creates n
(n=2 or 3 ((huge,) big, little)) DIE SGs on your 1 cluster DynamIQ system?

> The overutilization means the loading of  ANY CPUs
> exceeds threshold (80%).
> 
> However, only 1 heavy task or while-1 program will run on highest
> capacity CPUs and it still result to trigger overutilization. So
> the system will not use Energy Aware scheduling.

The patch-header of commit 2802bf3cd936 ("sched/fair: Add
over-utilization/tipping point indicator") mentioned why the current
approach is so conservatively defined.

> To avoid it, a system-wide over-utilization indicator to trigger
> load-balance cross clusters.
> 
> The policy is:
> 	The loading of "ALL CPUs in the highest capacity"
> 						exceeds threshold(80%) or
> 	The loading of "Any CPUs not in the highest capacity"
> 						exceed threshold(80%)

We experimented with an overutilized (tipping point) indicator per SD
from Thara Gopinath (Linaro), mentioned by Vincent already, till v2 of
the Energy Aware Scheduling patch-set in 2018 but we couldn't find any
advantage using it over the one you now find in mainline.

https://lore.kernel.org/r/20180406153607.17815-4-dietmar.eggemann@arm.com

Maybe you can have a look at this patch and see if it gives you an
advantage with your use cases and system topology layout?

The 'system-wide' in the name of the patch is misleading. The current
approach is also system-wide, we have the overutilized information on
the root domain (system here stands for root domain). You change the
detection mechanism from per-CPU to a mixed-mode detection (per-CPU and
per-SG).

> Signed-off-by: YT Chang <yt.chang@mediatek.com>
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

Why 'group->group_weight > 1' ? Do you have some out-of-tree code which
lets SGs with 1 CPU survive?

[...]
