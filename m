Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFF92173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfHHJZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:25:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbfHHJZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:25:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 827791576;
        Thu,  8 Aug 2019 02:24:59 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B172A3F706;
        Thu,  8 Aug 2019 02:24:58 -0700 (PDT)
Date:   Thu, 8 Aug 2019 10:24:56 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH 2/3] sched/fair: Prevent active LB from preempting higher
 sched classes
Message-ID: <20190808092455.qavanylzts2vmktk@e107158-lin.cambridge.arm.com>
References: <20190807174026.31242-1-valentin.schneider@arm.com>
 <20190807174026.31242-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807174026.31242-3-valentin.schneider@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/19 18:40, Valentin Schneider wrote:
> The CFS load balancer can cause the cpu_stopper to run a function to
> try and steal a rq's currently running task. However, it so happens
> that while only CFS tasks will ever be migrated by that function, we
> can end up preempting higher sched class tasks, since it is executed
> by the cpu_stopper.
> 
> I don't expect this to be exceedingly common: we still need to have
> had a busiest group in the first place, which needs
> 
>   busiest->sum_nr_running != 0
> 
> which is a cfs.h_nr_running sum, so we should have something to pull,
> but if we fail to pull anything and the remote rq is executing
> an RT/DL task we can hit this.
> 
> Add an extra check to not trigger the cpu_stopper if the remote
> rq's running task isn't CFS.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b56b8edee3d3..79bd6ead589c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8834,6 +8834,10 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
>  
>  	raw_spin_lock_irqsave(&busiest->lock, flags);
>  
> +	/* Make sure we're not about to stop a task from a higher sched class */
> +	if (busiest->curr->sched_class != &fair_sched_class)
> +		goto unlock;
> +

This looks correct to me, but I wonder if this check is something that belongs
to the CONFIG_PREEMPT_RT land. This will give a preference to not disrupt the
RT/DL tasks which is certainly the desired behavior there, but maybe in none
PREEMPT_RT world balancing CFS tasks is more important? Hmmm

--
Qais Yousef

>  	/*
>  	 * Don't kick the active_load_balance_cpu_stop, if the curr task on
>  	 * busiest CPU can't be moved to dst_cpu:
> --
> 2.22.0
> 
