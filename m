Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B38BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A17C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJ3QEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:04:01 -0400
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:52369 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfJ3QEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:04:01 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 0BEAC1C1D6D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 16:03:59 +0000 (GMT)
Received: (qmail 23324 invoked from network); 30 Oct 2019 16:03:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 16:03:58 -0000
Date:   Wed, 30 Oct 2019 16:03:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 07/11] sched/fair: evenly spread tasks when not
 overloaded
Message-ID: <20191030160356.GM3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-8-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571405198-27570-8-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:26:34PM +0200, Vincent Guittot wrote:
> When there is only 1 cpu per group, using the idle cpus to evenly spread
> tasks doesn't make sense and nr_running is a better metrics.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9ac2264..9b8e20d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8601,18 +8601,34 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	    busiest->sum_nr_running > local->sum_nr_running + 1)
>  		goto force_balance;
>  
> -	if (busiest->group_type != group_overloaded &&
> -	     (env->idle == CPU_NOT_IDLE ||
> -	      local->idle_cpus <= (busiest->idle_cpus + 1)))
> -		/*
> -		 * If the busiest group is not overloaded
> -		 * and there is no imbalance between this and busiest group
> -		 * wrt idle CPUs, it is balanced. The imbalance
> -		 * becomes significant if the diff is greater than 1 otherwise
> -		 * we might end up to just move the imbalance on another
> -		 * group.
> -		 */
> -		goto out_balanced;
> +	if (busiest->group_type != group_overloaded) {
> +		if (env->idle == CPU_NOT_IDLE)
> +			/*
> +			 * If the busiest group is not overloaded (and as a
> +			 * result the local one too) but this cpu is already
> +			 * busy, let another idle cpu try to pull task.
> +			 */
> +			goto out_balanced;
> +
> +		if (busiest->group_weight > 1 &&
> +		    local->idle_cpus <= (busiest->idle_cpus + 1))
> +			/*
> +			 * If the busiest group is not overloaded
> +			 * and there is no imbalance between this and busiest
> +			 * group wrt idle CPUs, it is balanced. The imbalance
> +			 * becomes significant if the diff is greater than 1
> +			 * otherwise we might end up to just move the imbalance
> +			 * on another group. Of course this applies only if
> +			 * there is more than 1 CPU per group.
> +			 */
> +			goto out_balanced;
> +
> +		if (busiest->sum_h_nr_running == 1)
> +			/*
> +			 * busiest doesn't have any tasks waiting to run
> +			 */
> +			goto out_balanced;
> +	}
>  

While outside the scope of this patch, it appears that this would still
allow slight imbalances in idle CPUs to pull tasks across NUMA domains
too easily.

-- 
Mel Gorman
SUSE Labs
