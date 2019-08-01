Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D55F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zD0IG2rE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfHAOkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52146 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbfHAOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so64928238wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=893Na5Ygp+4zeJW+8ck9Lf3W5foV9bFTJAzn+BBXDEc=;
        b=zD0IG2rExt+2+IO1UN/pxAOGLPjwQzwpl2THycWr9AAPDojvvIzjaZsHp+tb7s15s+
         XlZM1ASfFST0Js0WYeAnaYpgOt8SRCnUKDY/DhD7/qHhaPzsO0BqSlKhbRYyELKFT31Q
         qnf5yv1AQ8j/OrShIsCIIqZpAIDZB/v6CYCL6IZg8wZb1BUPsbVPT63gp2ijA8WaCO96
         u9w5FRL4PyDCQqDp3Um1mrUAelaOrHG1hH/uFe+DBo/1T5bcDr4HHRrcUeEJJ8wdQKgO
         kZlF0KCjwL+yopP1HkPp9XTUEKybeG7SGCEUeOuf7qe3vJaYh4tpZ7JlK2kCqsnaNfY6
         VEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=893Na5Ygp+4zeJW+8ck9Lf3W5foV9bFTJAzn+BBXDEc=;
        b=HVqrRwYajZxG3hRf5QI8QqAdJmK47OMNp5SQR6kVkYjMSZ8SQYkKBvf7Fbt/zWIQ9E
         YliZ5BitBtbTqpmyBVQYo1cYEAtg7YOYHGnF5s0WAcYJm/CRcJHuYIMMBap84/GweAxr
         Ol3SOyupSO9WZesv0J2+HJCl+GFZruxlLHPWVtXpi+EpNhFMa7/GvBbPuSNrmv8Yq2p+
         jDh4UsY/+bEW/QBnEZXqygSiIpeWUBrFL1/qr5Nd+g++WyzopcRhjlgBPqpRXxxgxjBv
         /vk50pfxuPjZ9P5G16H/OFtWytAZbHI1u+Zhgfkkxjar/rTo8qIv39BkldlmOZGnpqic
         EQTQ==
X-Gm-Message-State: APjAAAUwINKtJ2QojOkCpi02amjAouQV731C9sNZGiU3RE6rlZV8BFea
        LPmmyqXhKp0nyEaIwpclrNyg6eZL3aM=
X-Google-Smtp-Source: APXvYqyPaU/8fUIEQ/eAlPXVUaHUjWsc2i1WOr14Q++tw731GEzzCtlqt2i81coluubrPg0pb15Q4A==
X-Received: by 2002:a1c:407:: with SMTP id 7mr123196010wme.113.1564670434461;
        Thu, 01 Aug 2019 07:40:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/8] sched/fair: remove meaningless imbalance calculation
Date:   Thu,  1 Aug 2019 16:40:19 +0200
Message-Id: <1564670424-26023-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
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
index d7f76b0..d7f4a7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5450,18 +5450,6 @@ static unsigned long capacity_of(int cpu)
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
@@ -7735,7 +7723,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
 	unsigned int sum_h_nr_running; /* Nr tasks running in the group */
@@ -8117,9 +8104,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_h_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
-
 	sgs->group_weight = group->group_weight;
 
 	sgs->group_no_capacity = group_is_overloaded(env, sgs);
@@ -8350,76 +8334,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8438,15 +8352,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8457,7 +8362,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	    (busiest->avg_load <= sds->avg_load ||
 	     local->avg_load >= sds->avg_load)) {
 		env->imbalance = 0;
-		return fix_small_imbalance(env, sds);
+		return;
 	}
 
 	/*
@@ -8495,14 +8400,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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

