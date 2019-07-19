Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346AC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB1C2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BF48iUBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfGSMwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:52:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Jmn29wGoXT9QdGkDNlV+i5/j/BkpR5s03WdJB+pl+A=; b=BF48iUBT/5RwmJv10nnTLt7vj
        uI9mH/pEALobTJcA9bIJLpjwv7Cp77vuXTxoI8mwKvFzacsGFZ9M4peCCICog7JWBgxM3XPntRSqf
        jLSEHS9GiBdx+k1/su6a0wJtatBtR73gUzu/86qnTF+KkO+9Ijn+hPqasAB+vlSEPY2vd23YCsklZ
        vFYMLnKfsFhq3Cts7KGhlbFLU5LBIJBfS3O43XFfzHzMD6zQLxppcirHDQx9nttqDv06W9GCRd5Ow
        WmZGb54FWuSZBCwLb+gz3nC5d4YquHJx4lHptd61R4n4uoBW+XPpFVXGgPip0u3cVl781Hr/i7c6Q
        VomlRJ1pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoSNJ-0007dU-0g; Fri, 19 Jul 2019 12:52:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 733A120B9799F; Fri, 19 Jul 2019 14:52:35 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:52:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Message-ID: <20190719125235.GI3419@hirez.programming.kicks-ass.net>
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
> @@ -7060,12 +7048,21 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
>  enum fbq_type { regular, remote, all };
>  
>  enum group_type {
> -	group_other = 0,
> +	group_has_spare = 0,
> +	group_fully_busy,
>  	group_misfit_task,
> +	group_asym_capacity,
>  	group_imbalanced,
>  	group_overloaded,
>  };
>  
> +enum group_migration {
> +	migrate_task = 0,
> +	migrate_util,
> +	migrate_load,
> +	migrate_misfit,
> +};
> +
>  #define LBF_ALL_PINNED	0x01
>  #define LBF_NEED_BREAK	0x02
>  #define LBF_DST_PINNED  0x04
> @@ -7096,7 +7093,7 @@ struct lb_env {
>  	unsigned int		loop_max;
>  
>  	enum fbq_type		fbq_type;
> -	enum group_type		src_grp_type;
> +	enum group_migration	src_grp_type;
>  	struct list_head	tasks;
>  };
>  
> @@ -7328,7 +7325,6 @@ static int detach_tasks(struct lb_env *env)
>  {
>  	struct list_head *tasks = &env->src_rq->cfs_tasks;
>  	struct task_struct *p;
> -	unsigned long load;
>  	int detached = 0;
>  
>  	lockdep_assert_held(&env->src_rq->lock);
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
> +
> +			env->imbalance -= load;
> +		} else	if (env->src_grp_type == migrate_util) {
> +			unsigned long util = task_util_est(p);
> +
> +			if (util > env->imbalance)
> +				goto next;
> +
> +			env->imbalance -= util;
> +		} else if (env->src_grp_type == migrate_misfit) {
> +			unsigned long util = task_util_est(p);
> +
> +			/*
> +			 * utilization of misfit task might decrease a bit
> +			 * since it has been recorded. Be conservative in the
> +			 * condition.
> +			 */
> +			if (2*util < env->imbalance)
> +				goto next;
> +
> +			env->imbalance = 0;
> +		} else {
> +			/* Migrate task */
> +			env->imbalance--;
> +		}
>  
> -		if ((load / 2) > env->imbalance)
> -			goto next;
>  
>  		detach_task(p, env);
>  		list_add(&p->se.group_node, &env->tasks);
>  
>  		detached++;
> -		env->imbalance -= load;
>  
>  #ifdef CONFIG_PREEMPT
>  		/*

Still reading through this; maybe something like so instead?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7057,7 +7057,7 @@ enum group_type {
 	group_overloaded,
 };
 
-enum group_migration {
+enum migration_type {
 	migrate_task = 0,
 	migrate_util,
 	migrate_load,
@@ -7094,7 +7094,7 @@ struct lb_env {
 	unsigned int		loop_max;
 
 	enum fbq_type		fbq_type;
-	enum group_migration	src_grp_type;
+	enum migration_type	balance_type;
 	struct list_head	tasks;
 };
 
@@ -7325,6 +7325,7 @@ static const unsigned int sched_nr_migra
 static int detach_tasks(struct lb_env *env)
 {
 	struct list_head *tasks = &env->src_rq->cfs_tasks;
+	unsigned long load, util;
 	struct task_struct *p;
 	int detached = 0;
 
@@ -7358,8 +7359,14 @@ static int detach_tasks(struct lb_env *e
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		if (env->src_grp_type == migrate_load) {
-			unsigned long load = task_h_load(p);
+		switch (env->balance_type) {
+		case migrate_task:
+			/* Migrate task */
+			env->imbalance--;
+			break;
+
+		case migrate_load:
+			load = task_h_load(p);
 
 			if (sched_feat(LB_MIN) &&
 			    load < 16 && !env->sd->nr_balance_failed)
@@ -7369,15 +7376,20 @@ static int detach_tasks(struct lb_env *e
 				goto next;
 
 			env->imbalance -= load;
-		} else	if (env->src_grp_type == migrate_util) {
-			unsigned long util = task_util_est(p);
+			break;
+
+		case migrate_util:
+			util = task_util_est(p);
 
 			if (util > env->imbalance)
 				goto next;
 
 			env->imbalance -= util;
-		} else if (env->src_grp_type == migrate_misfit) {
-			unsigned long util = task_util_est(p);
+			break;
+
+
+		case migrate_misfit:
+			util = task_util_est(p);
 
 			/*
 			 * utilization of misfit task might decrease a bit
@@ -7388,9 +7400,7 @@ static int detach_tasks(struct lb_env *e
 				goto next;
 
 			env->imbalance = 0;
-		} else {
-			/* Migrate task */
-			env->imbalance--;
+			break;
 		}
 
 
@@ -8311,7 +8321,7 @@ static inline void calculate_imbalance(s
 		 * In case of asym capacity, we will try to migrate all load
 		 * to the preferred CPU
 		 */
-		env->src_grp_type = migrate_load;
+		env->balance_type = migrate_load;
 		env->imbalance = busiest->group_load;
 		return;
 	}
@@ -8323,14 +8333,14 @@ static inline void calculate_imbalance(s
 		 * the imbalance. The next load balance will take care of
 		 * balancing back the system.
 		 */
-		env->src_grp_type = migrate_task;
+		env->balance_type = migrate_task;
 		env->imbalance = 1;
 		return;
 	}
 
 	if (busiest->group_type == group_misfit_task) {
 		/* Set imbalance to allow misfit task to be balanced. */
-		env->src_grp_type = migrate_misfit;
+		env->balance_type = migrate_misfit;
 		env->imbalance = busiest->group_misfit_task_load;
 		return;
 	}
@@ -8346,7 +8356,7 @@ static inline void calculate_imbalance(s
 		 * If there is no overload, we just want to even the number of
 		 * idle cpus.
 		 */
-		env->src_grp_type = migrate_task;
+		env->balance_type = migrate_task;
 		imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
 
 		if (sds->prefer_sibling)
@@ -8365,7 +8375,7 @@ static inline void calculate_imbalance(s
 			 * amount of load to migrate in order to balance the
 			 * system.
 			 */
-			env->src_grp_type = migrate_util;
+			env->balance_type = migrate_util;
 			imbalance = max(local->group_capacity, local->group_util) -
 				    local->group_util;
 		}
@@ -8399,7 +8409,7 @@ static inline void calculate_imbalance(s
 	 * don't want to reduce the group load below the group capacity.
 	 * Thus we look for the minimum possible imbalance.
 	 */
-	env->src_grp_type = migrate_load;
+	env->balance_type = migrate_load;
 	env->imbalance = min(
 		(busiest->avg_load - sds->avg_load) * busiest->group_capacity,
 		(sds->avg_load - local->avg_load) * local->group_capacity
@@ -8597,7 +8607,7 @@ static struct rq *find_busiest_queue(str
 		 * For ASYM_CPUCAPACITY domains with misfit tasks we simply
 		 * seek the "biggest" misfit task.
 		 */
-		if (env->src_grp_type == migrate_misfit) {
+		if (env->balance_type == migrate_misfit) {
 			if (rq->misfit_task_load > busiest_load) {
 				busiest_load = rq->misfit_task_load;
 				busiest = rq;
@@ -8619,7 +8629,7 @@ static struct rq *find_busiest_queue(str
 		    rq->nr_running == 1)
 			continue;
 
-		if (env->src_grp_type == migrate_task) {
+		if (env->balance_type == migrate_task) {
 			nr_running = rq->cfs.h_nr_running;
 
 			if (busiest_nr < nr_running) {
@@ -8630,7 +8640,7 @@ static struct rq *find_busiest_queue(str
 			continue;
 		}
 
-		if (env->src_grp_type == migrate_util) {
+		if (env->balance_type == migrate_util) {
 			util = cpu_util(cpu_of(rq));
 
 			if (busiest_util < util) {
@@ -8711,7 +8721,7 @@ voluntary_active_balance(struct lb_env *
 			return 1;
 	}
 
-	if (env->src_grp_type == migrate_misfit)
+	if (env->balance_type == migrate_misfit)
 		return 1;
 
 	return 0;
