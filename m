Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5FC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466182173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bxa2y/bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfGSMyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:54:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DXNQpemO0s6ZsdmuvuRkNsU08/I80Gd0lDDMS6hkaN4=; b=Bxa2y/bwwmwLJPnfrbl1yNUEv
        iBsE+R6+O9n9b4xwdOmD1Sk5sPD36F/tdoUsAnxiEzJlUg7Lk2r0HnId0CYrStVN616QEfJEJ2zWC
        hvwNNaJlp1kQOn2IQca9TKeudQcjOAuf14ojHtNljp9g3me4ew1DPsQPm3tnmpmwbDKgeJ96jHx9D
        q4eXXk0m5E0dgZCzB0jGxbmAlLdSSkFwLXHGN5HpPMfNwIuNLMcpHQ5eVKkMd3bkqJ6YoxVBE55vJ
        wS7WJa8AGgeycaVcmlYpz+m1SOBinupoTpUxY+CW4Am48vPYyjISuy7p6dmDpdcng+WkipjZleLfv
        FjDjQVfxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoSPM-00089Z-W0; Fri, 19 Jul 2019 12:54:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F1122059A401; Fri, 19 Jul 2019 14:54:43 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:54:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Message-ID: <20190719125443.GJ3419@hirez.programming.kicks-ass.net>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 67f0acd..472959df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5376,18 +5376,6 @@ static unsigned long capacity_of(int cpu)
>  	return cpu_rq(cpu)->cpu_capacity;
>  }
>  
> -static unsigned long cpu_avg_load_per_task(int cpu)
> -{
> -	struct rq *rq = cpu_rq(cpu);
> -	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
> -	unsigned long load_avg = cpu_runnable_load(rq);
> -
> -	if (nr_running)
> -		return load_avg / nr_running;
> -
> -	return 0;
> -}
> -
>  static void record_wakee(struct task_struct *p)
>  {
>  	/*

> @@ -7646,7 +7669,6 @@ static unsigned long task_h_load(struct task_struct *p)
>  struct sg_lb_stats {
>  	unsigned long avg_load; /*Avg load across the CPUs of the group */
>  	unsigned long group_load; /* Total load over the CPUs of the group */
> -	unsigned long load_per_task;
>  	unsigned long group_capacity;
>  	unsigned long group_util; /* Total utilization of the group */
>  	unsigned int sum_nr_running; /* Nr tasks running in the group */


> @@ -8266,76 +8293,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  }
>  
>  /**
> - * fix_small_imbalance - Calculate the minor imbalance that exists
> - *			amongst the groups of a sched_domain, during
> - *			load balancing.
> - * @env: The load balancing environment.
> - * @sds: Statistics of the sched_domain whose imbalance is to be calculated.
> - */
> -static inline
> -void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> -{
> -	unsigned long tmp, capa_now = 0, capa_move = 0;
> -	unsigned int imbn = 2;
> -	unsigned long scaled_busy_load_per_task;
> -	struct sg_lb_stats *local, *busiest;
> -
> -	local = &sds->local_stat;
> -	busiest = &sds->busiest_stat;
> -
> -	if (!local->sum_h_nr_running)
> -		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
> -	else if (busiest->load_per_task > local->load_per_task)
> -		imbn = 1;
> -
> -	scaled_busy_load_per_task =
> -		(busiest->load_per_task * SCHED_CAPACITY_SCALE) /
> -		busiest->group_capacity;
> -
> -	if (busiest->avg_load + scaled_busy_load_per_task >=
> -	    local->avg_load + (scaled_busy_load_per_task * imbn)) {
> -		env->imbalance = busiest->load_per_task;
> -		return;
> -	}
> -
> -	/*
> -	 * OK, we don't have enough imbalance to justify moving tasks,
> -	 * however we may be able to increase total CPU capacity used by
> -	 * moving them.
> -	 */
> -
> -	capa_now += busiest->group_capacity *
> -			min(busiest->load_per_task, busiest->avg_load);
> -	capa_now += local->group_capacity *
> -			min(local->load_per_task, local->avg_load);
> -	capa_now /= SCHED_CAPACITY_SCALE;
> -
> -	/* Amount of load we'd subtract */
> -	if (busiest->avg_load > scaled_busy_load_per_task) {
> -		capa_move += busiest->group_capacity *
> -			    min(busiest->load_per_task,
> -				busiest->avg_load - scaled_busy_load_per_task);
> -	}
> -
> -	/* Amount of load we'd add */
> -	if (busiest->avg_load * busiest->group_capacity <
> -	    busiest->load_per_task * SCHED_CAPACITY_SCALE) {
> -		tmp = (busiest->avg_load * busiest->group_capacity) /
> -		      local->group_capacity;
> -	} else {
> -		tmp = (busiest->load_per_task * SCHED_CAPACITY_SCALE) /
> -		      local->group_capacity;
> -	}
> -	capa_move += local->group_capacity *
> -		    min(local->load_per_task, local->avg_load + tmp);
> -	capa_move /= SCHED_CAPACITY_SCALE;
> -
> -	/* Move if we gain throughput */
> -	if (capa_move > capa_now)
> -		env->imbalance = busiest->load_per_task;
> -}
> -
> -/**
>   * calculate_imbalance - Calculate the amount of imbalance present within the
>   *			 groups of a given sched_domain during load balance.
>   * @env: load balance environment

Maybe strip this out first, in a separate patch. It's all magic doo-doo.
