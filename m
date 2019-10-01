Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FADECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3340215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfJARrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:47:15 -0400
Received: from foss.arm.com ([217.140.110.172]:55472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfJARrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:47:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C032337;
        Tue,  1 Oct 2019 10:47:14 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009113F706;
        Tue,  1 Oct 2019 10:47:12 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
Date:   Tue, 1 Oct 2019 18:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 08:33, Vincent Guittot wrote:

[...]

> @@ -8283,69 +8363,133 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>   */
>  static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> -	unsigned long max_pull, load_above_capacity = ~0UL;
>  	struct sg_lb_stats *local, *busiest;
>  
>  	local = &sds->local_stat;
>  	busiest = &sds->busiest_stat;
>  
> -	if (busiest->group_asym_packing) {
> +	if (busiest->group_type == group_misfit_task) {
> +		/* Set imbalance to allow misfit task to be balanced. */
> +		env->balance_type = migrate_misfit;
> +		env->imbalance = busiest->group_misfit_task_load;
> +		return;
> +	}
> +
> +	if (busiest->group_type == group_asym_packing) {
> +		/*
> +		 * In case of asym capacity, we will try to migrate all load to
> +		 * the preferred CPU.
> +		 */
> +		env->balance_type = migrate_load;
>  		env->imbalance = busiest->group_load;
>  		return;
>  	}
>  
> +	if (busiest->group_type == group_imbalanced) {
> +		/*
> +		 * In the group_imb case we cannot rely on group-wide averages
> +		 * to ensure CPU-load equilibrium, try to move any task to fix
> +		 * the imbalance. The next load balance will take care of
> +		 * balancing back the system.
> +		 */
> +		env->balance_type = migrate_task;
> +		env->imbalance = 1;
> +		return;
> +	}
> +
>  	/*
> -	 * Avg load of busiest sg can be less and avg load of local sg can
> -	 * be greater than avg load across all sgs of sd because avg load
> -	 * factors in sg capacity and sgs with smaller group_type are
> -	 * skipped when updating the busiest sg:
> +	 * Try to use spare capacity of local group without overloading it or
> +	 * emptying busiest
>  	 */
> -	if (busiest->group_type != group_misfit_task &&
> -	    (busiest->avg_load <= sds->avg_load ||
> -	     local->avg_load >= sds->avg_load)) {
> -		env->imbalance = 0;
> +	if (local->group_type == group_has_spare) {
> +		if (busiest->group_type > group_fully_busy) {
> +			/*
> +			 * If busiest is overloaded, try to fill spare
> +			 * capacity. This might end up creating spare capacity
> +			 * in busiest or busiest still being overloaded but
> +			 * there is no simple way to directly compute the
> +			 * amount of load to migrate in order to balance the
> +			 * system.
> +			 */
> +			env->balance_type = migrate_util;
> +			env->imbalance = max(local->group_capacity, local->group_util) -
> +				    local->group_util;
> +			return;
> +		}
> +
> +		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> +			/*
> +			 * When prefer sibling, evenly spread running tasks on
> +			 * groups.
> +			 */
> +			env->balance_type = migrate_task;
> +			env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;

Isn't that one somewhat risky?

Say both groups are classified group_has_spare and we do prefer_sibling.
We'd select busiest as the one with the maximum number of busy CPUs, but it
could be so that busiest.sum_h_nr_running < local.sum_h_nr_running (because
pinned tasks or wakeup failed to properly spread stuff).

The thing should be unsigned so at least we save ourselves from right
shifting a negative value, but we still end up with a gygornous imbalance
(which we then store into env.imbalance which *is* signed... Urgh).

[...]
