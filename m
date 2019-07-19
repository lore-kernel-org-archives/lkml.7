Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137D0C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D145120651
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SB+Ov0l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfGSH7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:59:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:58:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so6200847wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VFn6DSv72GJsliLwuv9W2q96ioKlPRjyGZeuajHmgtE=;
        b=SB+Ov0l/ue1DcfuYS7KJdEGkxp2FpHHZXl+50VpC3zP0c34kTRQAwGeucMbAAVl1Ym
         eKgsMQPdtJudYvhWBfTFA3WHdWOguR65R2AbhrzwE65dwT9xpV7xvXQrZLEFVFayIMjB
         jM3Usdn5pm+CboXgEuYNPVw+LdJMMS84BSzJvVDUeVjh7uDKa9eB3VsI30x0ZHV8hZHY
         bknEIW2O3g7diOO17GclFlDJepm4SVDDke3WWS54R/0TnrSA322/mEl63hxwiXyP9wJx
         yNadEkuzm5zbPx+9wE4NZMDbMJM27apXefJMrbbQ2X3a0jESln+H85htqNGc5wWkvKj5
         Qoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VFn6DSv72GJsliLwuv9W2q96ioKlPRjyGZeuajHmgtE=;
        b=PZotBVcJ1X5pFYI1APF0TneULZLDAWMXFS4eS2oLe1EPK3J9wWfK5UU4M4nInNHCpZ
         3g3ByRm8EPpdPc10Fabg8+oYz47JHXobCqnAfTzEvsGG+GE00WJVwmv6Cd82/neh6UG0
         QqlMnR/FOM1G2NC0y9OazM3PQO3rRnDF7FEyN2HDEijYmxW/mwCkyHFCz0lDElNe5V/G
         uo9ua6JS178EVcpaqt9WtaYAfp/XeOZhcGuHLO8GXg9SlYNY2Uaq71itdmpb18yjynT2
         1XLdV9dPuRGzjxC3ooJETzIT0pC5IPFjZXF04E/YlAlYueFQKlnFxBD8TgmYk0uD/jN6
         pq6g==
X-Gm-Message-State: APjAAAVv2w6Os+rhtUxS3+de6bcc/pqr0DK96m+PUDmJBDCb6q79oAR2
        QxEUX1RwOZG+PFPXcD+81ev5N0Nbyck=
X-Google-Smtp-Source: APXvYqxlXRCD7iqCOp2OAHKzG19OuBJ4aCcDxfKzGKrRsaX5l7EpKOaaGyfCF03qWgrJ5g1m64tx8Q==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr55713933wrv.207.1563523136338;
        Fri, 19 Jul 2019 00:58:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:484b:32fe:1cf4:f69b])
        by smtp.gmail.com with ESMTPSA id c1sm58673826wrh.1.2019.07.19.00.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 00:58:55 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/5] sched/fair: rename sum_nr_running to sum_h_nr_running
Date:   Fri, 19 Jul 2019 09:58:22 +0200
Message-Id: <1563523105-24673-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sum_nr_running will track rq->nr_running task and sum_h_nr_running
will track cfs->h_nr_running so we can use both to detect when other
scheduling class are running and preempt CFS.

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a530fd..67f0acd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7650,6 +7650,7 @@ struct sg_lb_stats {
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
 	unsigned int sum_nr_running; /* Nr tasks running in the group */
+	unsigned int sum_h_nr_running; /* Nr tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -7695,6 +7696,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.busiest_stat = {
 			.avg_load = 0UL,
 			.sum_nr_running = 0,
+			.sum_h_nr_running = 0,
 			.group_type = group_other,
 		},
 	};
@@ -7885,7 +7887,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running < sgs->group_weight)
+	if (sgs->sum_h_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7906,7 +7908,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running <= sgs->group_weight)
+	if (sgs->sum_h_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8000,6 +8002,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
@@ -8030,8 +8033,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
+	if (sgs->sum_h_nr_running)
+		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
@@ -8088,7 +8091,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_nr_running <= sgs->group_weight &&
+	if (sgs->sum_h_nr_running <= sgs->group_weight &&
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
@@ -8119,7 +8122,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * perform better since they share less core resources.  Hence when we
 	 * have idle threads, we want them to be the higher ones.
 	 */
-	if (sgs->sum_nr_running &&
+	if (sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
 		sgs->group_asym_capacity = 1;
 		if (!sds->busiest)
@@ -8137,9 +8140,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 #ifdef CONFIG_NUMA_BALANCING
 static inline enum fbq_type fbq_classify_group(struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running > sgs->nr_numa_running)
+	if (sgs->sum_h_nr_running > sgs->nr_numa_running)
 		return regular;
-	if (sgs->sum_nr_running > sgs->nr_preferred_running)
+	if (sgs->sum_h_nr_running > sgs->nr_preferred_running)
 		return remote;
 	return all;
 }
@@ -8214,7 +8217,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		 */
 		if (prefer_sibling && sds->local &&
 		    group_has_capacity(env, local) &&
-		    (sgs->sum_nr_running > local->sum_nr_running + 1)) {
+		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
 			sgs->group_no_capacity = 1;
 			sgs->group_type = group_classify(sg, sgs);
 		}
@@ -8226,7 +8229,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 next_group:
 		/* Now, start updating sd_lb_stats */
-		sds->total_running += sgs->sum_nr_running;
+		sds->total_running += sgs->sum_h_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
 
@@ -8280,7 +8283,7 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
-	if (!local->sum_nr_running)
+	if (!local->sum_h_nr_running)
 		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
 	else if (busiest->load_per_task > local->load_per_task)
 		imbn = 1;
@@ -8378,7 +8381,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (busiest->group_type == group_overloaded &&
 	    local->group_type   == group_overloaded) {
-		load_above_capacity = busiest->sum_nr_running * SCHED_CAPACITY_SCALE;
+		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
 		if (load_above_capacity > busiest->group_capacity) {
 			load_above_capacity -= busiest->group_capacity;
 			load_above_capacity *= scale_load_down(NICE_0_LOAD);
@@ -8459,7 +8462,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
-	if (!sds.busiest || busiest->sum_nr_running == 0)
+	if (!sds.busiest || busiest->sum_h_nr_running == 0)
 		goto out_balanced;
 
 	/* XXX broken for overlapping NUMA groups */
@@ -8781,7 +8784,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_rq = busiest;
 
 	ld_moved = 0;
-	if (busiest->nr_running > 1) {
+	if (busiest->cfs.h_nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
-- 
2.7.4

