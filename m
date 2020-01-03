Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E30C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA3C21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgACOoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 09:44:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgACOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:44:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1A6E328;
        Fri,  3 Jan 2020 06:44:02 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64AB03F237;
        Fri,  3 Jan 2020 06:44:01 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix sgc->{min,max}_capacity miscalculate
To:     Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191231035122.GA10020@iZj6chx1xj0e0buvshuecpZ>
 <ec390ddb-c015-a467-2f88-47c00f23e27b@arm.com>
 <20200101141329.GA12809@iZj6chx1xj0e0buvshuecpZ>
 <e41793bc-daaf-b224-1f3d-a3e468072592@arm.com>
 <20200103142152.GA4551@iZj6chx1xj0e0buvshuecpZ>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7370a631-1e9a-90ba-dcbe-f714ecb0fb26@arm.com>
Date:   Fri, 3 Jan 2020 14:44:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200103142152.GA4551@iZj6chx1xj0e0buvshuecpZ>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2020 14:21, Peng Liu wrote:
> Thanks for your patient explanation, and the picture is intuitive
> and clear. Indeed, the group in lowest domain only contains one CPU, and
> the only CPU in the first group should be the rq's CPU. So, I wonder if
> we can do like this?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d170b5da0e3..c9d7613c74d2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7793,9 +7793,6 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>                  */
> 
>                 for_each_cpu(cpu, sched_group_span(sdg)) {
> -                       struct sched_group_capacity *sgc;
> -                       struct rq *rq = cpu_rq(cpu);
> -
>                         /*
>                          * build_sched_domains() -> init_sched_groups_capacity()
>                          * gets here before we've attached the domains to the
> @@ -7807,15 +7804,11 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
>                          * This avoids capacity from being 0 and
>                          * causing divide-by-zero issues on boot.
>                          */
> -                       if (unlikely(!rq->sd)) {
> -                               capacity += capacity_of(cpu);
> -                       } else {
> -                               sgc = rq->sd->groups->sgc;
> -                               capacity += sgc->capacity;
> -                       }
> +                       unsigned long cpu_cap = capacity_of(cpu);
> 
> -                       min_capacity = min(capacity, min_capacity);
> -                       max_capacity = max(capacity, max_capacity);
> +                       min_capacity = min(cpu_cap, min_capacity);
> +                       max_capacity = max(cpu_cap, max_capacity);
> +                       capacity += cpu_cap;
>                 }
>         } else  {
>                 /*
> 

Yep, if we refactor it to always use capacity_of() we'd end up with
something like this. The comment block could be updated (or removed) as
well.

There must be (or have been) a reason to use the sched_group_capacity
structure, but I'm not aware of it and I don't have time right now to dig
through the git history to figure it out. I didn't see anyone suggesting
or talking about this simplification in the discussion thread of

  9abf24d46518 ("sched: Check sched_domain before computing group power")

What you can try is sending that as the v2, and see if anyone screams. FWIW
you can add this to it too:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
