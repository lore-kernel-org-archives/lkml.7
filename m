Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217D206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKJG7x4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSOpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:45:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33351 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLSOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:45:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so6282506wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qg1gXhrcIHdtScJRLNDxHeXcjWC/dABHHJi/6+tjQ1k=;
        b=dKJG7x4DCtnTuWktnpvZo+VTe5E28wiU+A4ARWh7dievqWhMjI+Rp74+wymF6GdUnJ
         hk0gm+swjYJvO4hUq7MpW519XhAqrnTOi9pBZ95C+aNNWocAKm6exo5GhhEoZNiQMrNv
         tNw43XcJmMnFC9nsT1BxhNlQzofqKy1Guqjg1SoC2emiyCZvdNl88xYR6h7RsjtuXsvP
         fVqgrdAlcii9U+QASeLR9wHyx+W4ad2Su0vnSjRKUd9XiIjFijAHuTwyrzfei7OFM9ub
         5kCr4PbcSYVSNNXvmudwd8o9yYyPPIbazcDmL1EAwzznkbtAAhXQdZiiqQw1rCF5YfpZ
         rPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qg1gXhrcIHdtScJRLNDxHeXcjWC/dABHHJi/6+tjQ1k=;
        b=escC90JkFbnSpfF0Q/g+yBVxyFbJOT0abtQ54PaYLYDZ/leZSKm/tTo1H+i/oB0yog
         cf8Sr58YQfOBkSLky5tMQRSh1XBlRdcvywISb1Hji3YbBckERRQBz4JSrvdWZLTkM7xn
         cX2prAKPLWFCJSAhj3YAh36mQMzqarQVCcouxDLaUvfap8FdNGZEUiBNmVS09jKt6pOf
         eFInmuRpXy73U3L+Vc3sMPWfpPa3kR0fTS7cniM3VI3ld+mBdw0fFyfd2CyjF75lrtE0
         YcB0xFHjOiGq9+bsMzFNQORzJ5cLu1OJh1QubXmrgWQcJbL81knP4KWeNp8RksKw54w9
         eYVg==
X-Gm-Message-State: APjAAAWoTOeyHL2ng7A7yS1ayPn/iaLV4QuKLu9fUFVC4Bz48zk4ah+E
        q5oXluX2YLtdDcmoJWcAhasUuoHD5Co=
X-Google-Smtp-Source: APXvYqzHSRNbAYkA6F39rH0X7gz9ey7jODrY+zyigS6i6zJo28JaOv1cpURP4bRQiV08rSxNT1o6mw==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr9954808wrm.248.1576766742653;
        Thu, 19 Dec 2019 06:45:42 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:3953:d503:a17e:8209])
        by smtp.gmail.com with ESMTPSA id c68sm6370207wme.13.2019.12.19.06.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:45:41 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:45:39 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191219144539.GA19614@linaro.org>
References: <20191218154402.GF3178@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218154402.GF3178@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

Thanks for looking at this NUMA locality vs spreading tasks point.

Le Wednesday 18 Dec 2019 à 15:44:02 (+0000), Mel Gorman a écrit :
> The CPU load balancer balances between different domains to spread load
> and strives to have equal balance everywhere. Communicating tasks can
> migrate so they are topologically close to each other but these decisions
> are independent. On a lightly loaded NUMA machine, two communicating tasks
> pulled together at wakeup time can be pushed apart by the load balancer.
> In isolation, the load balancer decision is fine but it ignores the tasks
> data locality and the wakeup/LB paths continually conflict. NUMA balancing
> is also a factor but it also simply conflicts with the load balancer.
> 

[snip]

> There is some impact but there is a degree of variability and the ones
> showing impact are mainly workloads that are mostly parallelised
> and communicate infrequently between tests. It's a corner case where
> the workload benefits heavily from spreading wide and early which is
> not common. This is intended to illustrate the worst case measured.
> 
> In general, the patch simply seeks to avoid unnecessarily cross-node
> migrations when a machine is lightly loaded but shows benefits for other
> workloads. While tests are still running, so far it seems to benefit
> light-utilisation smaller workloads on large machines and does not appear
> to do any harm to larger or parallelised workloads.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..1dc8c7800fc0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8637,10 +8637,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  	/*
>  	 * Try to use spare capacity of local group without overloading it or
>  	 * emptying busiest.
> -	 * XXX Spreading tasks across NUMA nodes is not always the best policy
> -	 * and special care should be taken for SD_NUMA domain level before
> -	 * spreading the tasks. For now, load_balance() fully relies on
> -	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
>  	 */
>  	if (local->group_type == group_has_spare) {
>  		if (busiest->group_type > group_fully_busy) {
> @@ -8680,7 +8676,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			env->migration_type = migrate_task;
>  			lsub_positive(&nr_diff, local->sum_nr_running);
>  			env->imbalance = nr_diff >> 1;
> -			return;
> +			goto out_spare;

Why are you doing this only for prefer_sibling case ? That's probably the default case of most of numa system but you should also consider others case too.

So you should probably add your

> +                * Whether balancing the number of running tasks or the number
> +                * of idle CPUs, consider allowing some degree of imbalance if
> +                * migrating between NUMA domains.
> +                */
> +               if (env->sd->flags & SD_NUMA) {
> +                       unsigned int imbalance_adj, imbalance_max;

...

> +               }

before the prefer_sibling case :

		if (busiest->group_weight == 1 || sds->prefer_sibling) {
			unsigned int nr_diff = busiest->sum_nr_running;
			/*
			 * When prefer sibling, evenly spread running tasks on
			 * groups.
			 */


>
>  		}
>  
>  		/*
> @@ -8690,6 +8686,38 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		env->migration_type = migrate_task;
>  		env->imbalance = max_t(long, 0, (local->idle_cpus -
>  						 busiest->idle_cpus) >> 1);
> +
> +out_spare:
> +		/*
> +		 * Whether balancing the number of running tasks or the number
> +		 * of idle CPUs, consider allowing some degree of imbalance if
> +		 * migrating between NUMA domains.
> +		 */
> +		if (env->sd->flags & SD_NUMA) {
> +			unsigned int imbalance_adj, imbalance_max;
> +
> +			/*
> +			 * imbalance_adj is the allowable degree of imbalance
> +			 * to exist between two NUMA domains. It's calculated
> +			 * relative to imbalance_pct with a minimum of two
> +			 * tasks or idle CPUs.
> +			 */
> +			imbalance_adj = (busiest->group_weight *
> +				(env->sd->imbalance_pct - 100) / 100) >> 1;
> +			imbalance_adj = max(imbalance_adj, 2U);
> +
> +			/*
> +			 * Ignore imbalance unless busiest sd is close to 50%
> +			 * utilisation. At that point balancing for memory
> +			 * bandwidth and potentially avoiding unnecessary use
> +			 * of HT siblings is as relevant as memory locality.
> +			 */
> +			imbalance_max = (busiest->group_weight >> 1) - imbalance_adj;
> +			if (env->imbalance <= imbalance_adj &&
> +			    busiest->sum_nr_running < imbalance_max) {i

Shouldn't you consider the number of busiest->idle_cpus instead of the busiest->sum_nr_running ?

and you could simplify by 


	if ((env->sd->flags & SD_NUMA) &&
		((100 * busiest->group_weight) <= (env->sd->imbalance_pct * (busiest->idle_cpus << 1)))) {
			env->imbalance = 0;
			return;
	}

And otherwise it will continue with the current path

Also I'm a bit worry about using a 50% threshold that look a bit like a
heuristic which can change depending of platform and the UCs that run of the
system.

In fact i was hoping that we could use the numa_preferred_nid ? During the
detach of tasks, we don't detach the task if busiest has spare capacity and
preferred_nid of the task is busiest.

I'm going to run some tests to see the impact on my platform 

Regards,
Vincent
}


> +				env->imbalance = 0;
> +			}
> +		}
>  		return;
>  	}
>  
> 
> -- 
> Mel Gorman
> SUSE Labs
