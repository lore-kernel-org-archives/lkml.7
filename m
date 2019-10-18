Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9D6CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ECB222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLuEtlbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410301AbfJRN0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:26:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfJRN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:26:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so6250903wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQ/eLJSNkXW8LLvqvhxjiDQg9h5mHrnthUFHJ+Kv0ak=;
        b=xLuEtlbmH+Nznuz5yb+VUq02dwTDaV1iJR9HpM9SMb+dWkPSwWtUAsSrD6IQiwLF3e
         7q0/3FbOoEktY3dlzDqBeX/UeryUQb+IMGdhl5AxF2kfpiyVADAYak3J/CefUoQY3ibD
         2oE3NL5Ab/hC5PBAwckf38DxtLA8Hcia5Kb5d9dtG4AWbuYWEmuqTDwR1YWM/cmm0OVW
         RmRvyHjfLJ+i8ndw8RtMy4T5YDhllFoIr5K/PedxIX3F+BL5QXelO87E2OrWgqauTTRn
         YXt0/voFH6DelLCfHpuCdz5wuPe6HfC1c3crCfbgoAsh2dZYqesUCBoSHFDrzjb48Pap
         rwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NQ/eLJSNkXW8LLvqvhxjiDQg9h5mHrnthUFHJ+Kv0ak=;
        b=MYNY69sI8GYNQIoDGFgyLKItwdgNLCKaeDeAHRQ9qU5bgs2Xzak5BlnhR7Z0aXfciP
         BDlzsjV+dfzzBa23O8xMgEbPOlylt5RvmVCr3/U0lw/hjGhFSwUkl0S7MbrAsu5QtQQv
         4JK4Vqj7ZIB62j0nNahoO8loBt5XjLX5jl806SusvtIJVzUuBmTXz0PaqDgKavAquOcU
         FAP4btrl/IPtS8/jQxtFbGdB5/Pu8obgwKednFUr+zL/1u4gruqclQ5vbS7dPA429wpT
         +c7is4LT5WiqL+uxUPzxXexhMG15ryuKiUpL6ULQy3a37qWKzYf+k0gmpuAE60oFp19t
         +gMw==
X-Gm-Message-State: APjAAAUfQEhYfOqBJIXsMOpFEOfGl5TyjmPx5jHaG6N8r4fh6T9xRgRJ
        e3Z/qCQn0g4ZmMfFEvwRq4ysrHuIsw4=
X-Google-Smtp-Source: APXvYqztiLq4IjS8IXnaU1MLL8M6e7eIC2QwSM9t8rU+npk+xJ1FfwHfLbxrFn3JEcGpjDyp7egg2A==
X-Received: by 2002:adf:f152:: with SMTP id y18mr8106740wro.285.1571405207340;
        Fri, 18 Oct 2019 06:26:47 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:45 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 02/11] sched/fair: rename sum_nr_running to sum_h_nr_running
Date:   Fri, 18 Oct 2019 15:26:29 +0200
Message-Id: <1571405198-27570-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sum_nr_running to sum_h_nr_running because it effectively tracks
cfs->h_nr_running so we can use sum_nr_running to track rq->nr_running
when needed.

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 617145c..9a2aceb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7670,7 +7670,7 @@ struct sg_lb_stats {
 	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
-	unsigned int sum_nr_running; /* Nr tasks running in the group */
+	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -7715,7 +7715,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_capacity = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
-			.sum_nr_running = 0,
+			.sum_h_nr_running = 0,
 			.group_type = group_other,
 		},
 	};
@@ -7906,7 +7906,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running < sgs->group_weight)
+	if (sgs->sum_h_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7927,7 +7927,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running <= sgs->group_weight)
+	if (sgs->sum_h_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8019,7 +8019,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
-		sgs->sum_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
@@ -8049,8 +8049,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
+	if (sgs->sum_h_nr_running)
+		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
@@ -8107,7 +8107,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_nr_running <= sgs->group_weight &&
+	if (sgs->sum_h_nr_running <= sgs->group_weight &&
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
@@ -8138,7 +8138,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * perform better since they share less core resources.  Hence when we
 	 * have idle threads, we want them to be the higher ones.
 	 */
-	if (sgs->sum_nr_running &&
+	if (sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
 		sgs->group_asym_packing = 1;
 		if (!sds->busiest)
@@ -8156,9 +8156,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
@@ -8233,7 +8233,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		 */
 		if (prefer_sibling && sds->local &&
 		    group_has_capacity(env, local) &&
-		    (sgs->sum_nr_running > local->sum_nr_running + 1)) {
+		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
 			sgs->group_no_capacity = 1;
 			sgs->group_type = group_classify(sg, sgs);
 		}
@@ -8245,7 +8245,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 next_group:
 		/* Now, start updating sd_lb_stats */
-		sds->total_running += sgs->sum_nr_running;
+		sds->total_running += sgs->sum_h_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
 
@@ -8299,7 +8299,7 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
-	if (!local->sum_nr_running)
+	if (!local->sum_h_nr_running)
 		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
 	else if (busiest->load_per_task > local->load_per_task)
 		imbn = 1;
@@ -8397,7 +8397,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (busiest->group_type == group_overloaded &&
 	    local->group_type   == group_overloaded) {
-		load_above_capacity = busiest->sum_nr_running * SCHED_CAPACITY_SCALE;
+		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
 		if (load_above_capacity > busiest->group_capacity) {
 			load_above_capacity -= busiest->group_capacity;
 			load_above_capacity *= scale_load_down(NICE_0_LOAD);
@@ -8478,7 +8478,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
-	if (!sds.busiest || busiest->sum_nr_running == 0)
+	if (!sds.busiest || busiest->sum_h_nr_running == 0)
 		goto out_balanced;
 
 	/* XXX broken for overlapping NUMA groups */
-- 
2.7.4

