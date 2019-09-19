Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44EFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D71521924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkJ83N0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfISHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbfISHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so1873628wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vT3Cd0NoScWU8B4s0yMOgG1KA81Kqbh6T7GDIZMysSg=;
        b=IkJ83N0ynH6XKiHk3CQil2ckbXxjqo5pUHPS6taYyJRDS8qrGC9+tyFOB+7M84gGKo
         wTSGVdxZ5ZjvvMC3XiD5bdflf3YR+EOkG59XaRaAZIqkg22WJrWmkYrIhzv2n9nSfMek
         DE1q0JyvpkVb5PsKAbI3keJvgI3EyKv+6VbzthFqjwbq3uDyir+p/P4/t07DDT2HGj56
         vXY83lcVveh2vl+JgFFIl6NtjpiTEUO36IPe8TAYZ9Res/U3AZMANGDGzSAneDFzXGAC
         9FRepOWBk+rJyynJyoMroEBHJ7Y34W4bSOM0AgWCsA02jwgUbdCSycd5P27mwOjl8d5h
         9aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vT3Cd0NoScWU8B4s0yMOgG1KA81Kqbh6T7GDIZMysSg=;
        b=oLQkCo530jWlt7aAD93piJqdOC7xmkW5+o5n/1Q7Hv/9vAAUmDYGebKn4Uc6TJg26n
         g6aSoj45jnDmAfmsxfaeGYyVi1K1UMACTvPH3uGmszALLym7vUpPUpF4JAWoJaylMge2
         YWzBgpDSwqWTJZSkdAPnhaetPY0DYOvqGR85Q+D+O6qlkRkGelAJ9f02h+dMENAjMFMV
         zG4D6A+zeOxbi/TeeD7bQTQJIxXiLy1lAJhn7yJHTIPF/Eia8mONxRX9y84X/p/9sX/F
         seANIgl+USYPka0nqk7M5HIjShgwZwhFCog9oD/643w6SWTGgjKzMpBYUfkcjc6gCHL1
         7zpQ==
X-Gm-Message-State: APjAAAVYEU58QFfUIIGEurv8GjsRBm7MNnu3hVq2Pw73o5LjpSN0Th9O
        qDzise5F3W0u64LFu3RYxKMebLRC0Y0=
X-Google-Smtp-Source: APXvYqyrs/LM/6nQxdaxH24HvWzfpTtHyc18s9M3UhQa9kx6dR6s3D8WKq8hG834Aeg/TF/VRo3Ecg==
X-Received: by 2002:adf:f601:: with SMTP id t1mr5958913wrp.36.1568878441506;
        Thu, 19 Sep 2019 00:34:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:33:59 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 03/10] sched/fair: remove meaningless imbalance calculation
Date:   Thu, 19 Sep 2019 09:33:34 +0200
Message-Id: <1568878421-12301-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clean up load_balance and remove meaningless calculation and fields before
adding new algorithm.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 105 +---------------------------------------------------
 1 file changed, 1 insertion(+), 104 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02ab6b5..017aad0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5390,18 +5390,6 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
-static unsigned long cpu_avg_load_per_task(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
-	unsigned long load_avg = cpu_runnable_load(rq);
-
-	if (nr_running)
-		return load_avg / nr_running;
-
-	return 0;
-}
-
 static void record_wakee(struct task_struct *p)
 {
 	/*
@@ -7677,7 +7665,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
@@ -8059,9 +8046,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_h_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
-
 	sgs->group_weight = group->group_weight;
 
 	sgs->group_no_capacity = group_is_overloaded(env, sgs);
@@ -8292,76 +8276,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 }
 
 /**
- * fix_small_imbalance - Calculate the minor imbalance that exists
- *			amongst the groups of a sched_domain, during
- *			load balancing.
- * @env: The load balancing environment.
- * @sds: Statistics of the sched_domain whose imbalance is to be calculated.
- */
-static inline
-void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
-{
-	unsigned long tmp, capa_now = 0, capa_move = 0;
-	unsigned int imbn = 2;
-	unsigned long scaled_busy_load_per_task;
-	struct sg_lb_stats *local, *busiest;
-
-	local = &sds->local_stat;
-	busiest = &sds->busiest_stat;
-
-	if (!local->sum_h_nr_running)
-		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
-	else if (busiest->load_per_task > local->load_per_task)
-		imbn = 1;
-
-	scaled_busy_load_per_task =
-		(busiest->load_per_task * SCHED_CAPACITY_SCALE) /
-		busiest->group_capacity;
-
-	if (busiest->avg_load + scaled_busy_load_per_task >=
-	    local->avg_load + (scaled_busy_load_per_task * imbn)) {
-		env->imbalance = busiest->load_per_task;
-		return;
-	}
-
-	/*
-	 * OK, we don't have enough imbalance to justify moving tasks,
-	 * however we may be able to increase total CPU capacity used by
-	 * moving them.
-	 */
-
-	capa_now += busiest->group_capacity *
-			min(busiest->load_per_task, busiest->avg_load);
-	capa_now += local->group_capacity *
-			min(local->load_per_task, local->avg_load);
-	capa_now /= SCHED_CAPACITY_SCALE;
-
-	/* Amount of load we'd subtract */
-	if (busiest->avg_load > scaled_busy_load_per_task) {
-		capa_move += busiest->group_capacity *
-			    min(busiest->load_per_task,
-				busiest->avg_load - scaled_busy_load_per_task);
-	}
-
-	/* Amount of load we'd add */
-	if (busiest->avg_load * busiest->group_capacity <
-	    busiest->load_per_task * SCHED_CAPACITY_SCALE) {
-		tmp = (busiest->avg_load * busiest->group_capacity) /
-		      local->group_capacity;
-	} else {
-		tmp = (busiest->load_per_task * SCHED_CAPACITY_SCALE) /
-		      local->group_capacity;
-	}
-	capa_move += local->group_capacity *
-		    min(local->load_per_task, local->avg_load + tmp);
-	capa_move /= SCHED_CAPACITY_SCALE;
-
-	/* Move if we gain throughput */
-	if (capa_move > capa_now)
-		env->imbalance = busiest->load_per_task;
-}
-
-/**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
  * @env: load balance environment
@@ -8380,15 +8294,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		return;
 	}
 
-	if (busiest->group_type == group_imbalanced) {
-		/*
-		 * In the group_imb case we cannot rely on group-wide averages
-		 * to ensure CPU-load equilibrium, look at wider averages. XXX
-		 */
-		busiest->load_per_task =
-			min(busiest->load_per_task, sds->avg_load);
-	}
-
 	/*
 	 * Avg load of busiest sg can be less and avg load of local sg can
 	 * be greater than avg load across all sgs of sd because avg load
@@ -8399,7 +8304,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	    (busiest->avg_load <= sds->avg_load ||
 	     local->avg_load >= sds->avg_load)) {
 		env->imbalance = 0;
-		return fix_small_imbalance(env, sds);
+		return;
 	}
 
 	/*
@@ -8437,14 +8342,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 				       busiest->group_misfit_task_load);
 	}
 
-	/*
-	 * if *imbalance is less than the average load per runnable task
-	 * there is no guarantee that any tasks will be moved so we'll have
-	 * a think about bumping its value to force at least one task to be
-	 * moved
-	 */
-	if (env->imbalance < busiest->load_per_task)
-		return fix_small_imbalance(env, sds);
 }
 
 /******* find_busiest_group() helpers end here *********************/
-- 
2.7.4

