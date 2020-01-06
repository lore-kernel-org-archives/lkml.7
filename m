Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755C9C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3BA2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgAFJZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:25:53 -0500
Received: from foss.arm.com ([217.140.110.172]:41846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgAFJZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:25:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5E711FB;
        Mon,  6 Jan 2020 01:25:52 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1E63F6C4;
        Mon,  6 Jan 2020 01:25:50 -0800 (PST)
Subject: Re: [PATCH v2] sched/fair: fix sgc->{min,max}_capacity miscalculate
To:     Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, qais.yousef@arm.com,
        morten.rasmussen@arm.com, valentin.schneider@arm.com
References: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e034b806-bb3d-98c0-5d60-53610bfe6ca0@arm.com>
Date:   Mon, 6 Jan 2020 10:25:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2020 14:08, Peng Liu wrote:

Could you add a hint that this is about the SD_OVERLAP path? Something
like 'Fix sgc->{min,max}_capacity calculation for SD_OVERLAP'

> commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> sched_group_capacity") introduced per-cpu min_capacity.
> 
> commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> introduced per-cpu max_capacity.
> 
> Here, capacity is the accumulated sum of (maybe) many CPUs' capacity.
> Compare with capacity to get {min,max}_capacity makes no sense. Instead,
> we should compare one by one in each iteration to get
> sgc->{min,max}_capacity of the group.
> 
> Also, the only CPU in rq->sd->groups should be rq's CPU. Thus,
> capacity_of(cpu_of(rq)) should be equal to rq->sd->groups->sgc->capacity.
> Code can be simplified by removing the if/else.

Could we improve the description of the issue and the change a little
bit? Something like:

In the SD_OVERLAP case, the local variable 'capacity' represents the sum
of CPU capacity of all CPUs in the first sched group (sg) of the sched
domain (sd).

It is erroneously used to calculate sg's min and max CPU capacity.
To fix this use capacity_of(cpu) instead of 'capacity'.

The code which achieves this via cpu_rq(cpu)->sd->groups->sgc->capacity
(for rq->sd != NULL) can be removed since it delivers the same value as
capacity_of(cpu) which is currently only used for the (!rq->sd) case
(see update_cpu_capacity()).
A sg of the lowest sd (rq->sd or sd->child == NULL) represents a single
CPU (and hence sg->sgc->capacity == capacity_of(cpu)).

> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> v1: https://lkml.org/lkml/2019/12/30/502
> 
>  kernel/sched/fair.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d170b5da0e3..e14698a8ee38 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7793,29 +7793,11 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>  		 */
>  
>  		for_each_cpu(cpu, sched_group_span(sdg)) {
> -			struct sched_group_capacity *sgc;
> -			struct rq *rq = cpu_rq(cpu);
> +			unsigned long cpu_cap = capacity_of(cpu);
>  
> -			/*
> -			 * build_sched_domains() -> init_sched_groups_capacity()
> -			 * gets here before we've attached the domains to the
> -			 * runqueues.
> -			 *
> -			 * Use capacity_of(), which is set irrespective of domains
> -			 * in update_cpu_capacity().
> -			 *
> -			 * This avoids capacity from being 0 and
> -			 * causing divide-by-zero issues on boot.
> -			 */
> -			if (unlikely(!rq->sd)) {
> -				capacity += capacity_of(cpu);
> -			} else {
> -				sgc = rq->sd->groups->sgc;
> -				capacity += sgc->capacity;
> -			}
> -
> -			min_capacity = min(capacity, min_capacity);
> -			max_capacity = max(capacity, max_capacity);
> +			min_capacity = min(cpu_cap, min_capacity);
> +			max_capacity = max(cpu_cap, max_capacity);
> +			capacity += cpu_cap;

Nit: Why not

+                       capacity += cpu_cap;
+                       min_capacity = min(cpu_cap, min_capacity);
+                       max_capacity = max(cpu_cap, max_capacity);

like in the !SD_OVERLAP path?

>  		}
>  	} else  {
>  		/*
> 
