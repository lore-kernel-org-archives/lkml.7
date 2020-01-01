Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E04C32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97142072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAAF47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 00:56:59 -0500
Received: from foss.arm.com ([217.140.110.172]:38866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgAAF47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 00:56:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679E81FB;
        Tue, 31 Dec 2019 21:56:58 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE70E3F237;
        Tue, 31 Dec 2019 21:56:56 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix sgc->{min,max}_capacity miscalculate
To:     Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ec390ddb-c015-a467-2f88-47c00f23e27b@arm.com>
Date:   Wed, 1 Jan 2020 05:56:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 31/12/2019 03:51, Peng Liu wrote:
> commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> sched_group_capacity") introduced per-cpu min_capacity.
> 
> commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> introduced per-cpu max_capacity.
> 
> sgc->capacity is the *SUM* of all CPU's capacity in the group.
> sgc->{min,max}_capacity are the sg per-cpu variables. Compare with
> sgc->capacity to get sgc->{min,max}_capacity makes no sense. Instead,
> we should compare one by one in each iteration to get
> sgc->{min,max}_capacity of the group.
> 

Worth noting this only affects the SD_OVERLAP case, the other case is fine
(I checked again just to be sure).

Now, on the bright side of things I don't think this currently causes any
harm. The {min,max}_capacity values are used in bits of code that only
gets run on topologies with asymmetric CPU µarchs (SD_ASYM_CPUCAPACITY), and
I know of no such system that is also NUMA, i.e. end up with SD_OVERLAP
(here's hoping nobody gets any funny idea).

Still, nice find!

> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> ---
>  kernel/sched/fair.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d170b5da0e3..97b164fcda93 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7795,6 +7795,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>  		for_each_cpu(cpu, sched_group_span(sdg)) {
>  			struct sched_group_capacity *sgc;
>  			struct rq *rq = cpu_rq(cpu);
> +			unsigned long cap;
>  
>  			/*
>  			 * build_sched_domains() -> init_sched_groups_capacity()
> @@ -7808,14 +7809,16 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>  			 * causing divide-by-zero issues on boot.
>  			 */
>  			if (unlikely(!rq->sd)) {
> -				capacity += capacity_of(cpu);
> +				cap = capacity_of(cpu);
> +				capacity += cap;
> +				min_capacity = min(cap, min_capacity);
> +				max_capacity = max(cap, max_capacity);
>  			} else {
>  				sgc = rq->sd->groups->sgc;
>  				capacity += sgc->capacity;
> +				min_capacity = min(sgc->min_capacity, min_capacity);
> +				max_capacity = max(sgc->max_capacity, max_capacity);
>  			}
> -
> -			min_capacity = min(capacity, min_capacity);
> -			max_capacity = max(capacity, max_capacity);
>  		}
>  	} else  {
>  		/*
> 

All that could be shortened like the below, no? 

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..9f6c015639ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7773,8 +7773,8 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 		 */
 
 		for_each_cpu(cpu, sched_group_span(sdg)) {
-			struct sched_group_capacity *sgc;
 			struct rq *rq = cpu_rq(cpu);
+			unsigned long cpu_cap;
 
 			/*
 			 * build_sched_domains() -> init_sched_groups_capacity()
@@ -7787,15 +7787,15 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			 * This avoids capacity from being 0 and
 			 * causing divide-by-zero issues on boot.
 			 */
-			if (unlikely(!rq->sd)) {
-				capacity += capacity_of(cpu);
-			} else {
-				sgc = rq->sd->groups->sgc;
-				capacity += sgc->capacity;
-			}
+			if (unlikely(!rq->sd))
+				cpu_cap = capacity_of(cpu);
+			else
+				cpu_cap = rq->sd->groups->sgc->capacity;
+
+			min_capacity = min(cpu_cap, min_capacity);
+			max_capacity = max(cpu_cap, max_capacity);
 
-			min_capacity = min(capacity, min_capacity);
-			max_capacity = max(capacity, max_capacity);
+			capacity += cpu_cap;
 		}
 	} else  {
 		/*
