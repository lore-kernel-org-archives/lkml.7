Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA129C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8693422CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfGZN7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:59:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387871AbfGZN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:59:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QDwPVP002309
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:59:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u02qw8g9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:59:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 26 Jul 2019 14:58:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Jul 2019 14:58:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6QDwsHT56819804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 13:58:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A20A0AE045;
        Fri, 26 Jul 2019 13:58:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA92AE04D;
        Fri, 26 Jul 2019 13:58:53 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Jul 2019 13:58:52 +0000 (GMT)
Date:   Fri, 26 Jul 2019 19:28:52 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        pauld@redhat.com
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19072613-0020-0000-0000-00000357795A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072613-0021-0000-0000-000021AB71EE
Message-Id: <20190726135852.GB7168@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The type of sched_group has been extended to better reflect the type of
> imbalance. We now have :
> 	group_has_spare
> 	group_fully_busy
> 	group_misfit_task
> 	group_asym_capacity
> 	group_imbalanced
> 	group_overloaded

How is group_fully_busy different from group_overloaded?

> 
> Based on the type fo sched_group, load_balance now sets what it wants to
> move in order to fix the imnbalance. It can be some load as before but
> also some utilization, a number of task or a type of task:
> 	migrate_task
> 	migrate_util
> 	migrate_load
> 	migrate_misfit

Can we club migrate_util and migrate_misfit?

> @@ -7361,19 +7357,46 @@ static int detach_tasks(struct lb_env *env)
>  		if (!can_migrate_task(p, env))
>  			goto next;
>  
> -		load = task_h_load(p);
> +		if (env->src_grp_type == migrate_load) {
> +			unsigned long load = task_h_load(p);
>  
> -		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> -			goto next;
> +			if (sched_feat(LB_MIN) &&
> +			    load < 16 && !env->sd->nr_balance_failed)
> +				goto next;
> +
> +			if ((load / 2) > env->imbalance)
> +				goto next;

I know this existed before too but if the load is exactly or around 2x of
env->imbalance, the resultant imbalance after the load balance operation
would still be around env->imbalance. We may lose some cache affinity too.

Can we do something like.
		if (2 * load > 3 * env->imbalance)
			goto next;

> @@ -7690,14 +7711,14 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>  	*sds = (struct sd_lb_stats){
>  		.busiest = NULL,
>  		.local = NULL,
> -		.total_running = 0UL,
>  		.total_load = 0UL,
>  		.total_capacity = 0UL,
>  		.busiest_stat = {
>  			.avg_load = 0UL,
>  			.sum_nr_running = 0,
>  			.sum_h_nr_running = 0,
> -			.group_type = group_other,
> +			.idle_cpus = UINT_MAX,

Why are we initializing idle_cpus to UINT_MAX? Shouldnt this be set to 0?
I only see an increment and compare. 

> +			.group_type = group_has_spare,
>  		},
>  	};
>  }
>  
>  static inline enum
> -group_type group_classify(struct sched_group *group,
> +group_type group_classify(struct lb_env *env,
> +			  struct sched_group *group,
>  			  struct sg_lb_stats *sgs)
>  {
> -	if (sgs->group_no_capacity)
> +	if (group_is_overloaded(env, sgs))
>  		return group_overloaded;
>  
>  	if (sg_imbalanced(group))
> @@ -7953,7 +7975,13 @@ group_type group_classify(struct sched_group *group,
>  	if (sgs->group_misfit_task_load)
>  		return group_misfit_task;
>  
> -	return group_other;
> +	if (sgs->group_asym_capacity)
> +		return group_asym_capacity;
> +
> +	if (group_has_capacity(env, sgs))
> +		return group_has_spare;
> +
> +	return group_fully_busy;

If its not overloaded but also doesnt have capacity.
Does it mean its capacity is completely filled.
Cant we consider that as same as overloaded?

>  }
>  
>  
> -	if (sgs->sum_h_nr_running)
> -		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
> +	sgs->group_capacity = group->sgc->capacity;
>  
>  	sgs->group_weight = group->group_weight;
>  
> -	sgs->group_no_capacity = group_is_overloaded(env, sgs);
> -	sgs->group_type = group_classify(group, sgs);
> +	sgs->group_type = group_classify(env, group, sgs);
> +
> +	/* Computing avg_load makes sense only when group is overloaded */
> +	if (sgs->group_type != group_overloaded)
> +		sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
> +				sgs->group_capacity;

Mismatch in comment and code?

> @@ -8079,11 +8120,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (sgs->group_type < busiest->group_type)
>  		return false;
>  
> -	if (sgs->avg_load <= busiest->avg_load)
> +	/* Select the overloaded group with highest avg_load */
> +	if (sgs->group_type == group_overloaded &&
> +	    sgs->avg_load <= busiest->avg_load)
> +		return false;
> +
> +	/* Prefer to move from lowest priority CPU's work */
> +	if (sgs->group_type == group_asym_capacity && sds->busiest &&
> +	    sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
>  		return false;

I thought this should have been 
	/* Prefer to move from lowest priority CPU's work */
	if (sgs->group_type == group_asym_capacity && sds->busiest &&
	    sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
		return true;

> @@ -8357,72 +8318,115 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  	if (busiest->group_type == group_imbalanced) {
>  		/*
>  		 * In the group_imb case we cannot rely on group-wide averages
> -		 * to ensure CPU-load equilibrium, look at wider averages. XXX
> +		 * to ensure CPU-load equilibrium, try to move any task to fix
> +		 * the imbalance. The next load balance will take care of
> +		 * balancing back the system.
>  		 */
> -		busiest->load_per_task =
> -			min(busiest->load_per_task, sds->avg_load);
> +		env->src_grp_type = migrate_task;
> +		env->imbalance = 1;
> +		return;
>  	}
>  
> -	/*
> -	 * Avg load of busiest sg can be less and avg load of local sg can
> -	 * be greater than avg load across all sgs of sd because avg load
> -	 * factors in sg capacity and sgs with smaller group_type are
> -	 * skipped when updating the busiest sg:
> -	 */
> -	if (busiest->group_type != group_misfit_task &&
> -	    (busiest->avg_load <= sds->avg_load ||
> -	     local->avg_load >= sds->avg_load)) {
> -		env->imbalance = 0;
> -		return fix_small_imbalance(env, sds);
> +	if (busiest->group_type == group_misfit_task) {
> +		/* Set imbalance to allow misfit task to be balanced. */
> +		env->src_grp_type = migrate_misfit;
> +		env->imbalance = busiest->group_misfit_task_load;
> +		return;
>  	}
>  
>  	/*
> -	 * If there aren't any idle CPUs, avoid creating some.
> +	 * Try to use spare capacity of local group without overloading it or
> +	 * emptying busiest
>  	 */
> -	if (busiest->group_type == group_overloaded &&
> -	    local->group_type   == group_overloaded) {
> -		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
> -		if (load_above_capacity > busiest->group_capacity) {
> -			load_above_capacity -= busiest->group_capacity;
> -			load_above_capacity *= scale_load_down(NICE_0_LOAD);
> -			load_above_capacity /= busiest->group_capacity;
> -		} else
> -			load_above_capacity = ~0UL;
> +	if (local->group_type == group_has_spare) {
> +		long imbalance;
> +
> +		/*
> +		 * If there is no overload, we just want to even the number of
> +		 * idle cpus.
> +		 */
> +		env->src_grp_type = migrate_task;
> +		imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);

Shouldnt this be?
		imbalance = max_t(long, 0, (busiest->idle_cpus - local->idle_cpus) >> 1);
> +
> +		if (sds->prefer_sibling)
> +			/*
> +			 * When prefer sibling, evenly spread running tasks on
> +			 * groups.
> +			 */
> +			imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
> +
> +		if (busiest->group_type > group_fully_busy) {
> +			/*
> +			 * If busiest is overloaded, try to fill spare
> +			 * capacity. This might end up creating spare capacity
> +			 * in busiest or busiest still being overloaded but
> +			 * there is no simple way to directly compute the
> +			 * amount of load to migrate in order to balance the
> +			 * system.
> +			 */
> +			env->src_grp_type = migrate_util;
> +			imbalance = max(local->group_capacity, local->group_util) -
> +				    local->group_util;
> +		}
> +
> +		env->imbalance = imbalance;
> +		return;
>  	}
>  
>  	/*
> -	 * We're trying to get all the CPUs to the average_load, so we don't
> -	 * want to push ourselves above the average load, nor do we wish to
> -	 * reduce the max loaded CPU below the average load. At the same time,
> -	 * we also don't want to reduce the group load below the group
> -	 * capacity. Thus we look for the minimum possible imbalance.
> +	 * Local is fully busy but have to take more load to relieve the
> +	 * busiest group
>  	 */
> -	max_pull = min(busiest->avg_load - sds->avg_load, load_above_capacity);
> +	if (local->group_type < group_overloaded) {


What action are we taking if we find the local->group_type to be group_imbalanced
or group_misfit ?  We will fall here but I dont know if it right to look for
avg_load in that case.

> +		/*
> +		 * Local will become overvloaded so the avg_load metrics are
> +		 * finally needed
> +		 */
>  
> -	/* How much load to actually move to equalise the imbalance */
> -	env->imbalance = min(
> -		max_pull * busiest->group_capacity,
> -		(sds->avg_load - local->avg_load) * local->group_capacity
> -	) / SCHED_CAPACITY_SCALE;
> +		local->avg_load = (local->group_load*SCHED_CAPACITY_SCALE)
> +						/ local->group_capacity;
>  
> -	/* Boost imbalance to allow misfit task to be balanced. */
> -	if (busiest->group_type == group_misfit_task) {
> -		env->imbalance = max_t(long, env->imbalance,
> -				       busiest->group_misfit_task_load);
> +		sds->avg_load = (SCHED_CAPACITY_SCALE * sds->total_load)
> +						/ sds->total_capacity;
>  	}
>  
>  	/*
> -	 * if *imbalance is less than the average load per runnable task
> -	 * there is no guarantee that any tasks will be moved so we'll have
> -	 * a think about bumping its value to force at least one task to be
> -	 * moved
> +	 * Both group are or will become overloaded and we're trying to get
> +	 * all the CPUs to the average_load, so we don't want to push
> +	 * ourselves above the average load, nor do we wish to reduce the
> +	 * max loaded CPU below the average load. At the same time, we also
> +	 * don't want to reduce the group load below the group capacity.
> +	 * Thus we look for the minimum possible imbalance.
>  	 */
> -	if (env->imbalance < busiest->load_per_task)
> -		return fix_small_imbalance(env, sds);
> +	env->src_grp_type = migrate_load;
> +	env->imbalance = min(
> +		(busiest->avg_load - sds->avg_load) * busiest->group_capacity,
> +		(sds->avg_load - local->avg_load) * local->group_capacity
> +	) / SCHED_CAPACITY_SCALE;
>  }

We calculated avg_load for !group_overloaded case, but seem to be using for
group_overloaded cases too.


-- 
Thanks and Regards
Srikar Dronamraju

