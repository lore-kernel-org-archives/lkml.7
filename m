Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D5EC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CB120B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bStR7V2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfHAOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50994 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732207AbfHAOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so64929719wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLjvU2ODIosSbAGgfcgnEGYGA9K2KD8U033BkbWqs6s=;
        b=bStR7V2YeW1gpq+dA8PYooGb99XNuHu+zzQtd51dbKalI8jrPgAb2R9ba/V4CAdF/H
         woSWGAhZ/iHRhtyFLJs9GdUWHXbv81mkCwgAWmWkHJM9sR33mqR+hVEIto13KjW61G9V
         /9MqwZDC/t+QiZYeHOAH3iqU2AabjsjpHQFaeWn6DOZwvj3mh6FxGGXiS1qFIqTMTe0L
         K/Mxa3+TABsk5BcInkHnOZEiiq5cThOwPqIfDSGg2zldedK6t8eZD1wu4GuWkwf/Zf+w
         k6+9I07eJO2tzcy0/9sexqeBmcBYNm8N+ynpD6GIyR83nfZVg9+BSmldfV8Gmr9R4Nmt
         3H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JLjvU2ODIosSbAGgfcgnEGYGA9K2KD8U033BkbWqs6s=;
        b=BpaiuKhZW4iQEqclXxalXV1zveX7maETqjL63RdKnxHRzeIa7s9GfJp4/BkqGykeon
         JD8UlYOpVvl5pL4LC7aN9UZRF4ZJw8bJUddHF0LaisYZBrAr4Z97OPDpa5nskaI8ahuZ
         z4hL5aM/lJuNoHUA6+2VDmMA3qixOroA9u0LmJMaRLRdOjf24QtlZgdWy/ohbjYuJ5V2
         2o1dOn70wZBi8DV69pXhadCCTq9elG11EIO6tC0+eq6XjflT4jl0TpOthRLdFSmJObBH
         e95pFJZQ/IE8o7K4l+JsbWCcw7jeFAYqTkBHVVKhB5C/dcYQi8/UO4XXDN+wkYXDJBOp
         WMRw==
X-Gm-Message-State: APjAAAUt+ODNRLqilDtHxvT0+gNSlnYTudi6Tp/1Alkwt5wovOiiZorb
        yMVfxx5jGgcqRMbtxDWUZdAHY+DxiGk=
X-Google-Smtp-Source: APXvYqz+Zw9kld2nPblI1PI9MXZipUcsQWerybRNNF582amjjXF8q2t4NKJ69J9yl3mEf03Ikld5aQ==
X-Received: by 2002:a1c:a686:: with SMTP id p128mr55764273wme.130.1564670438525;
        Thu, 01 Aug 2019 07:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:38 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 8/8] sched/fair: use utilization to select misfit task
Date:   Thu,  1 Aug 2019 16:40:24 +0200
Message-Id: <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utilization is used to detect a misfit task but the load is then used to
select the task on the CPU which can lead to select a small task with
high weight instead of the task that triggered the misfit migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 28 ++++++++++++++--------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53e64a7..d08cc12 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3817,16 +3817,16 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 
 	if (!p) {
-		rq->misfit_task_load = 0;
+		rq->misfit_task_util = 0;
 		return;
 	}
 
 	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
-		rq->misfit_task_load = 0;
+		rq->misfit_task_util = 0;
 		return;
 	}
 
-	rq->misfit_task_load = task_h_load(p);
+	rq->misfit_task_util = task_util_est(p);
 }
 
 #else /* CONFIG_SMP */
@@ -7487,14 +7487,14 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		case migrate_misfit:
-			load = task_h_load(p);
+			util = task_util_est(p);
 
 			/*
 			 * utilization of misfit task might decrease a bit
 			 * since it has been recorded. Be conservative in the
 			 * condition.
 			 */
-			if (load < env->imbalance)
+			if (2*util < env->imbalance)
 				goto next;
 
 			env->imbalance = 0;
@@ -7785,7 +7785,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_capacity; /* tasks should be move to preferred cpu */
-	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
+	unsigned long group_misfit_task_util; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -7959,7 +7959,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
  */
 static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
 {
-	return rq->misfit_task_load &&
+	return rq->misfit_task_util &&
 		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
 		 check_cpu_capacity(rq, sd));
 }
@@ -8078,7 +8078,7 @@ group_type group_classify(struct lb_env *env,
 	if (sgs->group_asym_capacity)
 		return group_asym_capacity;
 
-	if (sgs->group_misfit_task_load)
+	if (sgs->group_misfit_task_util)
 		return group_misfit_task;
 
 	if (!group_has_capacity(env, sgs))
@@ -8164,8 +8164,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		/* Check for a misfit task on the cpu */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    sgs->group_misfit_task_load < rq->misfit_task_load) {
-			sgs->group_misfit_task_load = rq->misfit_task_load;
+		    sgs->group_misfit_task_util < rq->misfit_task_util) {
+			sgs->group_misfit_task_util = rq->misfit_task_util;
 			*sg_status |= SG_OVERLOAD;
 		}
 	}
@@ -8261,7 +8261,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 * If we have more than one misfit sg go with the
 		 * biggest misfit.
 		 */
-		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+		if (sgs->group_misfit_task_util < busiest->group_misfit_task_util)
 			return false;
 		break;
 
@@ -8458,7 +8458,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	if (busiest->group_type == group_misfit_task) {
 		/* Set imbalance to allow misfit task to be balanced. */
 		env->balance_type = migrate_misfit;
-		env->imbalance = busiest->group_misfit_task_load;
+		env->imbalance = busiest->group_misfit_task_util;
 		return;
 	}
 
@@ -8801,8 +8801,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			 * For ASYM_CPUCAPACITY domains with misfit tasks we simply
 			 * seek the "biggest" misfit task.
 			 */
-			if (rq->misfit_task_load > busiest_load) {
-				busiest_load = rq->misfit_task_load;
+			if (rq->misfit_task_util > busiest_util) {
+				busiest_util = rq->misfit_task_util;
 				busiest = rq;
 			}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7583fad..ef6e1b2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -916,7 +916,7 @@ struct rq {
 
 	unsigned char		idle_balance;
 
-	unsigned long		misfit_task_load;
+	unsigned long		misfit_task_util;
 
 	/* For active balancing */
 	int			active_balance;
-- 
2.7.4

