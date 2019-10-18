Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9628CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94532222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXR90jeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410322AbfJRN06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:26:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40142 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410292AbfJRN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:26:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so6271773wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTQ1SciiKePYzOmVVy3DyjwjaDHHkwpywXBi+0rOpxQ=;
        b=QXR90jeKm05HUBMzUKPG93fbL6a4P5nHC1TJmpDv528sLkrBIwVZKNq/OQC/K458Un
         uxBioUPxoSm+VwhN1IfQqkhRs1DOxdr/UebBO3l/UFi9v7LXNo6GekREPyB1pb/Zh5Cv
         eFW37PbpACZ7F5kImbRvXv6cTZmJzDoAky6U6fldf2YL5q3PGATsrrl7vxJ5sc8zKpMd
         WIXzgJOUQKhM2ulfj7pLDF6EUyR7yUlqAixaeQlTGEJ0be3DN5tfe7KQpMppOlVIh+Aa
         NH8L4R9xNW/tlOQe4kWK0g9AIOdRmYuMp2i501s9eVH9ygXAHpFesaH0yzlhQ2hhZeeC
         bgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UTQ1SciiKePYzOmVVy3DyjwjaDHHkwpywXBi+0rOpxQ=;
        b=sbO7TkMGJ7OrIhvKF6K29sdZrhV7ql0IsaOLajX0vAAPQl+vzNo0Vt9EH5Qw4ze5iW
         Cw/ojyLpaZDi6/NB0qdRwehM0nlBigMdrq2Q0tZvDqGm3i9X24C8zKAx+UM8o0XeHhE0
         hMy35GcSR85h7ogopZHNAvXkB0V1V8oQDpylhsDfMJEc4f2W4xkwhBUkD7GDXGUth2ED
         D0nZ86pd7B4nRXQd9ElobbJC8qn7qLDQD885VuL+KNIq41o1wPZN3uqikJLu7q7YNk8F
         bnreuN1An0jWlLtGNlzpVzE5MoFC/ed3rARbw8HbvKZ8FDkk9LcoahdrbKjlEIT/NUC8
         aWlg==
X-Gm-Message-State: APjAAAUrP9wx+/l4e5+UektKAadOONhDSfax5YZBaSht5hzYfsi2hGML
        d87iU1L0ZwsYZJ7oEs363cbUuR3x9fE=
X-Google-Smtp-Source: APXvYqxo+MtVI/lsHpeiSttcjSaRZwcdkXGN/FpRh8CeUyoohUsu8hpBiOjlvBtdC/SqamvZ6jQqgw==
X-Received: by 2002:adf:de85:: with SMTP id w5mr7613678wrl.278.1571405209399;
        Fri, 18 Oct 2019 06:26:49 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:48 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 03/11] sched/fair: remove meaningless imbalance calculation
Date:   Fri, 18 Oct 2019 15:26:30 +0200
Message-Id: <1571405198-27570-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clean up load_balance and remove meaningless calculation and fields before
adding new algorithm.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 105 +---------------------------------------------------
 1 file changed, 1 insertion(+), 104 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a2aceb..e004841 100644
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
@@ -7667,7 +7655,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
@@ -8049,9 +8036,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_h_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
-
 	sgs->group_weight = group->group_weight;
 
 	sgs->group_no_capacity = group_is_overloaded(env, sgs);
@@ -8282,76 +8266,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8370,15 +8284,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8389,7 +8294,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	    (busiest->avg_load <= sds->avg_load ||
 	     local->avg_load >= sds->avg_load)) {
 		env->imbalance = 0;
-		return fix_small_imbalance(env, sds);
+		return;
 	}
 
 	/*
@@ -8427,14 +8332,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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

