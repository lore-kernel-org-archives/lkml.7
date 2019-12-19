Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B20C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F88206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hykn+ZX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSKC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:02:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o+0r16DLXVbC+7Zxqq6v+t/eSFuvrc9Emyuzqsf4HpQ=; b=hykn+ZX/usebevoo+tpjD7cev
        zhqEgk1m4ICoMp2ftEfbrQ+/PnEryttu+L2s1ewb/bBJ8wTJJAZYpMOG9aVdlk1OYbzKwe21T6dup
        3gChZRsSYwtKHKIObN1Z2JxyJ3W0UzeBQ5Lg7sdU9Lmcy1Fj51RLv5BqU9J1vK4SIWUHbaMhAfTEP
        2hKMMSwe1TIqBOBck0rCBtLAvWHwLcxAO2zNNoy2lWEw6aP7y/OnvBmd6JRKeq2BhTkKPx546MMN7
        0AakeW6h4y/T1pYMEoI85GzjBruV3ed9XgizMyUfOL8kEjlZfiDWBlZ+6NCmEZZsUkq8lBtV8Zp3A
        97pJcKCqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihsdg-0006Bx-Pn; Thu, 19 Dec 2019 10:02:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 457C63007F2;
        Thu, 19 Dec 2019 11:01:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AC6D2B291C44; Thu, 19 Dec 2019 11:02:32 +0100 (CET)
Date:   Thu, 19 Dec 2019 11:02:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191219100232.GY2844@hirez.programming.kicks-ass.net>
References: <20191218154402.GF3178@techsingularity.net>
 <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:50:52PM +0000, Valentin Schneider wrote:
> I'm quite sure you have reasons to have written it that way, but I was
> hoping we could squash it down to something like:
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..f05d09a8452e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8680,16 +8680,27 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			env->migration_type = migrate_task;
>  			lsub_positive(&nr_diff, local->sum_nr_running);
>  			env->imbalance = nr_diff >> 1;
> -			return;
> +		} else {
> +
> +			/*
> +			 * If there is no overload, we just want to even the number of
> +			 * idle cpus.
> +			 */
> +			env->migration_type = migrate_task;
> +			env->imbalance = max_t(long, 0, (local->idle_cpus -
> +							 busiest->idle_cpus) >> 1);
>  		}
>  
>  		/*
> -		 * If there is no overload, we just want to even the number of
> -		 * idle cpus.
> +		 * Allow for a small imbalance between NUMA groups; don't do any
> +		 * of it if there is at least half as many tasks / busy CPUs as
> +		 * there are available CPUs in the busiest group
>  		 */
> -		env->migration_type = migrate_task;
> -		env->imbalance = max_t(long, 0, (local->idle_cpus -
> -						 busiest->idle_cpus) >> 1);
> +		if (env->sd->flags & SD_NUMA &&
> +		    (busiest->sum_nr_running < busiest->group_weight >> 1) &&
> +		    (env->imbalance < busiest->group_weight * (env->sd->imbalance_pct - 100) / 100))

Note that this form allows avoiding the division. Every time I see that
/100 I'm thinking we should rename and make imbalance_pct a base-2
thing.

> +				env->imbalance = 0;
> +
>  		return;
>  	}
>  
