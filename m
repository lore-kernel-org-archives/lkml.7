Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A3C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7517B21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJDYCYjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbfISHee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36468 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388613AbfISHeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so239372wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/SFuEruliHoJKYfECKgXFMMbQHFq3dwW+v5uybTb84=;
        b=fJDYCYjYKy8EiIblYLJyhEy/vfUWklDTbcUJLIG2CYH6z/PA3AjGQgQ1ETjX65zb1j
         CZTQr7YBcUiwmvpnfcJjpdiuQ61mYOC03pAPXsTX7FW7CzzrnDpY21pWxBhB2g/t3JM/
         euCwsBU5ogNi1SPeFgu0N5cubN3XIbHD9q3bsg6pb+Btqx3dHQxMGj1oFILTDZGuZNG5
         6w+yVrCv9NrxI2fcs7eCv5nu513rGx1/NNQQa+XEWYWLiZH789GdugXeXwiPcYwmjQbN
         Qkctnv2hIvZEJkDcCTTKVFm9j1bxlueo4uBzzQb03DiUiPCXaAWDDaelJWmfYNfRLASP
         BHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/SFuEruliHoJKYfECKgXFMMbQHFq3dwW+v5uybTb84=;
        b=CucA+VTEzWIRnkgx2hdwgPO+E/l9bCYVVV2RnaJPeaVplTsUJf/weGkwRSTxXjlBJd
         IETLAv4DLiWcyueYhTC51q/SxwZuNLKttaZa68u/Vf7Ng13k9DJ9ZcUBHUg7122hVyQ4
         1/9iGVtHabSpSzWgkI6VJOD+IuT9NX3lTAP16sbqobitafczkgPapzXQlUrz1xHFm9qN
         pDzykI2F8VrgX2zB0oLa4/CGAseRE02/X4voR34uPjdPEo+ovLq29zgOuUDtt6w5p9bP
         AABVgJ4R6nu/4U54Pf3wuW0nfYezbiV/5DgoJpRIZfec2PuJ09Bh5ZDC5kPa6xmiuI+L
         StHA==
X-Gm-Message-State: APjAAAWF8tH0n02b0cq3T8z3+4NWcqIwESRJ1TO7LciZeIJmYEjF7PpD
        JIBPdLXvS/X95dg25JtlBwGERjUc28M=
X-Google-Smtp-Source: APXvYqzMVUPuMpG7LSek1Lm+nuEcLOVMKcFBKo+icgoi56DPobaCmsc/oGsv56QimLy87Q5C6Amixg==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr1622467wmo.114.1568878439717;
        Thu, 19 Sep 2019 00:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:33:58 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 02/10] sched/fair: rename sum_nr_running to sum_h_nr_running
Date:   Thu, 19 Sep 2019 09:33:33 +0200
Message-Id: <1568878421-12301-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sum_nr_running to sum_h_nr_running because it effectively tracks
cfs->h_nr_running so we can use sum_nr_running to track rq->nr_running
when needed.

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3175fea..02ab6b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7680,7 +7680,7 @@ struct sg_lb_stats {
 	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
-	unsigned int sum_nr_running; /* Nr tasks running in the group */
+	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -7725,7 +7725,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_capacity = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
-			.sum_nr_running = 0,
+			.sum_h_nr_running = 0,
 			.group_type = group_other,
 		},
 	};
@@ -7916,7 +7916,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running < sgs->group_weight)
+	if (sgs->sum_h_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7937,7 +7937,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running <= sgs->group_weight)
+	if (sgs->sum_h_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8029,7 +8029,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
-		sgs->sum_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
@@ -8059,8 +8059,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
+	if (sgs->sum_h_nr_running)
+		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
@@ -8117,7 +8117,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_nr_running <= sgs->group_weight &&
+	if (sgs->sum_h_nr_running <= sgs->group_weight &&
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
@@ -8148,7 +8148,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * perform better since they share less core resources.  Hence when we
 	 * have idle threads, we want them to be the higher ones.
 	 */
-	if (sgs->sum_nr_running &&
+	if (sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
 		sgs->group_asym_packing = 1;
 		if (!sds->busiest)
@@ -8166,9 +8166,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
@@ -8243,7 +8243,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		 */
 		if (prefer_sibling && sds->local &&
 		    group_has_capacity(env, local) &&
-		    (sgs->sum_nr_running > local->sum_nr_running + 1)) {
+		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
 			sgs->group_no_capacity = 1;
 			sgs->group_type = group_classify(sg, sgs);
 		}
@@ -8255,7 +8255,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 next_group:
 		/* Now, start updating sd_lb_stats */
-		sds->total_running += sgs->sum_nr_running;
+		sds->total_running += sgs->sum_h_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
 
@@ -8309,7 +8309,7 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
-	if (!local->sum_nr_running)
+	if (!local->sum_h_nr_running)
 		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
 	else if (busiest->load_per_task > local->load_per_task)
 		imbn = 1;
@@ -8407,7 +8407,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (busiest->group_type == group_overloaded &&
 	    local->group_type   == group_overloaded) {
-		load_above_capacity = busiest->sum_nr_running * SCHED_CAPACITY_SCALE;
+		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
 		if (load_above_capacity > busiest->group_capacity) {
 			load_above_capacity -= busiest->group_capacity;
 			load_above_capacity *= scale_load_down(NICE_0_LOAD);
@@ -8488,7 +8488,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
-	if (!sds.busiest || busiest->sum_nr_running == 0)
+	if (!sds.busiest || busiest->sum_h_nr_running == 0)
 		goto out_balanced;
 
 	/* XXX broken for overlapping NUMA groups */
-- 
2.7.4

