Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88413C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D5F21850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGZOJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:09:31 -0400
Received: from foss.arm.com ([217.140.110.172]:45328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGZOJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:09:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5538B337;
        Fri, 26 Jul 2019 07:09:27 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D5733F71F;
        Fri, 26 Jul 2019 07:09:26 -0700 (PDT)
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        pauld@redhat.com
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <20190726135852.GB7168@linux.vnet.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b98ae93b-80f7-a4ca-0c4d-9d6c166055a7@arm.com>
Date:   Fri, 26 Jul 2019 15:09:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726135852.GB7168@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 14:58, Srikar Dronamraju wrote:
[...]
>> @@ -8357,72 +8318,115 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>  	if (busiest->group_type == group_imbalanced) {
>>  		/*
>>  		 * In the group_imb case we cannot rely on group-wide averages
>> -		 * to ensure CPU-load equilibrium, look at wider averages. XXX
>> +		 * to ensure CPU-load equilibrium, try to move any task to fix
>> +		 * the imbalance. The next load balance will take care of
>> +		 * balancing back the system.
>>  		 */
>> -		busiest->load_per_task =
>> -			min(busiest->load_per_task, sds->avg_load);
>> +		env->src_grp_type = migrate_task;
>> +		env->imbalance = 1;
>> +		return;
>>  	}
>>  
>> -	/*
>> -	 * Avg load of busiest sg can be less and avg load of local sg can
>> -	 * be greater than avg load across all sgs of sd because avg load
>> -	 * factors in sg capacity and sgs with smaller group_type are
>> -	 * skipped when updating the busiest sg:
>> -	 */
>> -	if (busiest->group_type != group_misfit_task &&
>> -	    (busiest->avg_load <= sds->avg_load ||
>> -	     local->avg_load >= sds->avg_load)) {
>> -		env->imbalance = 0;
>> -		return fix_small_imbalance(env, sds);
>> +	if (busiest->group_type == group_misfit_task) {
>> +		/* Set imbalance to allow misfit task to be balanced. */
>> +		env->src_grp_type = migrate_misfit;
>> +		env->imbalance = busiest->group_misfit_task_load;
>> +		return;
>>  	}
>>  
>>  	/*
>> -	 * If there aren't any idle CPUs, avoid creating some.
>> +	 * Try to use spare capacity of local group without overloading it or
>> +	 * emptying busiest
>>  	 */
>> -	if (busiest->group_type == group_overloaded &&
>> -	    local->group_type   == group_overloaded) {
>> -		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
>> -		if (load_above_capacity > busiest->group_capacity) {
>> -			load_above_capacity -= busiest->group_capacity;
>> -			load_above_capacity *= scale_load_down(NICE_0_LOAD);
>> -			load_above_capacity /= busiest->group_capacity;
>> -		} else
>> -			load_above_capacity = ~0UL;
>> +	if (local->group_type == group_has_spare) {
>> +		long imbalance;
>> +
>> +		/*
>> +		 * If there is no overload, we just want to even the number of
>> +		 * idle cpus.
>> +		 */
>> +		env->src_grp_type = migrate_task;
>> +		imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
> 
> Shouldnt this be?
> 		imbalance = max_t(long, 0, (busiest->idle_cpus - local->idle_cpus) >> 1);

I think it's the right way around - if busiest has more idle CPUs than local,
then we shouldn't balance (local is busier than busiest)

However, doesn't that lead to a imbalance of 0 when e.g. local has 1 idle
CPU and busiest has 0 ?. If busiest has more than one task we should try
to pull at least one.
