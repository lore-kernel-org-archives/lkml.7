Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E5EC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B3E2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRb9sA6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfHAOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:41:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbfHAOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so64928194wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axmD3S1h/frv2E13/5bCDU36iLrwU3ahTJXFWAatH2M=;
        b=aRb9sA6WjjV7IDju8NSoS81d3+VJ0baffXtJVjDihdnhlfl18KMgPeZJVEVKM5RIZN
         unmk/MzC+OZHdchCrfIdb1tNXDqArErWo2fzRpVP1Wgow0ocjNybi1lgVwXMdr6zrLEf
         N6i2IwsjDUquVOQjyIZtPEWXXNJDve1KfDi7kHogCor57/fRQkzDcIUBkMFaETbuKKt3
         QYGrvUqlUd36hype07UtDNL7ifu2rCPyTt8jIf5k1AR61Iip62Bm5xI5WMLPqlpqO6Qk
         89EAyIvaUOcQkk4IgbH+esvo5cYRk0/5sYeSC2JW7vO0CzsQwqWEKxf3lrZVAjcHI8ED
         WuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axmD3S1h/frv2E13/5bCDU36iLrwU3ahTJXFWAatH2M=;
        b=ZD7Kzh9v8oGtYkzMReHgkjVohYtPH0UGBd0+X/Wh29Gr0QWMoFLCLq/efTPDoia5Ib
         D2HWWJzCgiLqrMi3g79mKEebAD8DtMkvRlbAuoCMlOh1hQkZTMiWOY+rvDerhh3xhLk+
         fbzwlodhOWSHUdYcL47bWPmYVBx9QTqnjJOdIuiRuDbojNP4d0M5RsWoSMHoJSv+/Js6
         9hopBBZxI93r1ZX1cfH4Top0O0wTK9GMbkesi2tILBiESFJNeqQ8Tv3JZI5jF1b/MfLL
         Yww1oqt3I+QkSwre/IQb57cJQDYwLga+e6kIVOFHVfD3nsJ7eSAqbODaBb1v/ZRw/38h
         u5mw==
X-Gm-Message-State: APjAAAXbZkmqbmAb7aCwXrFD1CGsgJ59NrkZ49mQXoleZoUkzoM4XYA2
        A+JweNBzAewa+V27SiKU6TFSg4Hgl2A=
X-Google-Smtp-Source: APXvYqyFXzNnFfFgsaJdg17jDvuVxNF4rZ8aLmEgXfg9wGZ/LZHMn4RFvglEAb6AcsFLGIDB44rfCw==
X-Received: by 2002:a05:600c:228b:: with SMTP id 11mr17324724wmf.26.1564670433681;
        Thu, 01 Aug 2019 07:40:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:32 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/8] sched/fair: rename sum_nr_running to sum_h_nr_running
Date:   Thu,  1 Aug 2019 16:40:18 +0200
Message-Id: <1564670424-26023-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
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
 kernel/sched/fair.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b432349..d7f76b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7738,7 +7738,7 @@ struct sg_lb_stats {
 	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
-	unsigned int sum_nr_running; /* Nr tasks running in the group */
+	unsigned int sum_h_nr_running; /* Nr tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -7783,7 +7783,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_capacity = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
-			.sum_nr_running = 0,
+			.sum_h_nr_running = 0,
 			.group_type = group_other,
 		},
 	};
@@ -7974,7 +7974,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running < sgs->group_weight)
+	if (sgs->sum_h_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7995,7 +7995,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running <= sgs->group_weight)
+	if (sgs->sum_h_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8087,7 +8087,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
-		sgs->sum_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
@@ -8117,8 +8117,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
+	if (sgs->sum_h_nr_running)
+		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
@@ -8175,7 +8175,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_nr_running <= sgs->group_weight &&
+	if (sgs->sum_h_nr_running <= sgs->group_weight &&
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
@@ -8206,7 +8206,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * perform better since they share less core resources.  Hence when we
 	 * have idle threads, we want them to be the higher ones.
 	 */
-	if (sgs->sum_nr_running &&
+	if (sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
 		sgs->group_asym_capacity = 1;
 		if (!sds->busiest)
@@ -8224,9 +8224,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
@@ -8301,7 +8301,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		 */
 		if (prefer_sibling && sds->local &&
 		    group_has_capacity(env, local) &&
-		    (sgs->sum_nr_running > local->sum_nr_running + 1)) {
+		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
 			sgs->group_no_capacity = 1;
 			sgs->group_type = group_classify(sg, sgs);
 		}
@@ -8313,7 +8313,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 next_group:
 		/* Now, start updating sd_lb_stats */
-		sds->total_running += sgs->sum_nr_running;
+		sds->total_running += sgs->sum_h_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
 
@@ -8367,7 +8367,7 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
-	if (!local->sum_nr_running)
+	if (!local->sum_h_nr_running)
 		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
 	else if (busiest->load_per_task > local->load_per_task)
 		imbn = 1;
@@ -8465,7 +8465,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (busiest->group_type == group_overloaded &&
 	    local->group_type   == group_overloaded) {
-		load_above_capacity = busiest->sum_nr_running * SCHED_CAPACITY_SCALE;
+		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
 		if (load_above_capacity > busiest->group_capacity) {
 			load_above_capacity -= busiest->group_capacity;
 			load_above_capacity *= scale_load_down(NICE_0_LOAD);
@@ -8546,7 +8546,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
-	if (!sds.busiest || busiest->sum_nr_running == 0)
+	if (!sds.busiest || busiest->sum_h_nr_running == 0)
 		goto out_balanced;
 
 	/* XXX broken for overlapping NUMA groups */
@@ -8868,7 +8868,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_rq = busiest;
 
 	ld_moved = 0;
-	if (busiest->nr_running > 1) {
+	if (busiest->cfs.h_nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
-- 
2.7.4

