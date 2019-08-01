Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C223BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E77820B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tX6MNZQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfHAOkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42958 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHAOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so23978013wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dUYVYalJMZgAeVU29YjiRXel4z/PC0IpF1q5CiNQv+8=;
        b=tX6MNZQmI4hZOvjFzOFXnPB78JPjpMhfMK094UjgR99Ot4cRbA0mHjt3glVc5Tlhi1
         /AmUz1yniLwdrwvedvRAGhf1DuJiqEzcFxSB3sB4wzd9d/RUYeBc1WVf1CiS1DHUL/Hx
         Bq3fx9EgemQHWPsRHaHrjOdOaXkTOPc+NPsNszFgv87cowRZMLcv0mFCpsjd7aSVyM34
         2KUODNrbC54YTPWpi1UeC76DvtBVXd+MeB4QFFz4/2dBXaRR3fbnm76VqkkFJiuNwKVp
         OyJ2RnEEr74e1hIjXwBcKwRgTJdP/C9Hg5DphwgsrcbhCacUSzEY5VxmUReDjDDI5L/2
         gkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dUYVYalJMZgAeVU29YjiRXel4z/PC0IpF1q5CiNQv+8=;
        b=oRcBDBTBND8mmY/MivTCjanJxoFn4nIVOy8GUfBQRX4XADlRhgLPsDsZlhQxZcIxmd
         aUOf5UXf3dBOUgiTGUAxW9WGvjX+QEzUA70TERzTH9V8EnqH37BSp9LKHytySNlxsQW7
         rBi5tc7DAbhBjm7fdM6KW5L8rF0Z107SyOFlv0ynSSGlvGlkPhJu4jLeUIWrgzl/hui3
         VAgIvfl/YpOcOUK0Ksmq2CzhuLZWgk7MzbIcRHb+sy+cj+jQ2oU2hApHRogZ7UQgcCD0
         7IulvUvdfqNQHByXcgIU0WCh+q1L7kSSn4bVqUohuw3OZRSFOM00BAuYrTl8QM4amqhf
         cwJQ==
X-Gm-Message-State: APjAAAWYRnn5SBr5iLdIS4PdblFPCUmL85UunoVqu6LILljXR57xycwY
        7FOOqQCUryb97k8uKE9F21ahXQk+vDM=
X-Google-Smtp-Source: APXvYqyYbt5lTTsHss+sBnwF1hjTWv/eNGw/MIYpIK4dPXSr8ddA3DvXUHSChuh5O3jBuPSvDxargg==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr61570347wrw.21.1564670432649;
        Thu, 01 Aug 2019 07:40:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:32 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/8] sched/fair: clean up asym packing
Date:   Thu,  1 Aug 2019 16:40:17 +0200
Message-Id: <1564670424-26023-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up asym packing to follow the default load balance behavior:
- classify the group by creating a group_asym_capacity field.
- calculate the imbalance in calculate_imbalance() instead of bypassing it.

We don't need to test twice same conditions anymore to detect asym packing
and we consolidate the calculation of imbalance in calculate_imbalance().

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb75c0b..b432349 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7743,6 +7743,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	int group_asym_capacity;
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -8197,9 +8198,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * ASYM_PACKING needs to move all the work to the highest
 	 * prority CPUs in the group, therefore mark all groups
 	 * of lower priority than ourself as busy.
+	 *
+	 * This is primarily intended to used at the sibling level.  Some
+	 * cores like POWER7 prefer to use lower numbered SMT threads.  In the
+	 * case of POWER7, it can move to lower SMT modes only when higher
+	 * threads are idle.  When in lower SMT modes, the threads will
+	 * perform better since they share less core resources.  Hence when we
+	 * have idle threads, we want them to be the higher ones.
 	 */
 	if (sgs->sum_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
+		sgs->group_asym_capacity = 1;
 		if (!sds->busiest)
 			return true;
 
@@ -8341,51 +8350,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 }
 
 /**
- * check_asym_packing - Check to see if the group is packed into the
- *			sched domain.
- *
- * This is primarily intended to used at the sibling level.  Some
- * cores like POWER7 prefer to use lower numbered SMT threads.  In the
- * case of POWER7, it can move to lower SMT modes only when higher
- * threads are idle.  When in lower SMT modes, the threads will
- * perform better since they share less core resources.  Hence when we
- * have idle threads, we want them to be the higher ones.
- *
- * This packing function is run on idle threads.  It checks to see if
- * the busiest CPU in this domain (core in the P7 case) has a higher
- * CPU number than the packing function is being run on.  Here we are
- * assuming lower CPU number will be equivalent to lower a SMT thread
- * number.
- *
- * Return: 1 when packing is required and a task should be moved to
- * this CPU.  The amount of the imbalance is returned in env->imbalance.
- *
- * @env: The load balancing environment.
- * @sds: Statistics of the sched_domain which is to be packed
- */
-static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
-{
-	int busiest_cpu;
-
-	if (!(env->sd->flags & SD_ASYM_PACKING))
-		return 0;
-
-	if (env->idle == CPU_NOT_IDLE)
-		return 0;
-
-	if (!sds->busiest)
-		return 0;
-
-	busiest_cpu = sds->busiest->asym_prefer_cpu;
-	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
-		return 0;
-
-	env->imbalance = sds->busiest_stat.group_load;
-
-	return 1;
-}
-
-/**
  * fix_small_imbalance - Calculate the minor imbalance that exists
  *			amongst the groups of a sched_domain, during
  *			load balancing.
@@ -8469,6 +8433,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
+	if (busiest->group_asym_capacity) {
+		env->imbalance = busiest->group_load;
+		return;
+	}
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -8573,8 +8542,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	busiest = &sds.busiest_stat;
 
 	/* ASYM feature bypasses nice load balance check */
-	if (check_asym_packing(env, &sds))
-		return sds.busiest;
+	if (busiest->group_asym_capacity)
+		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest || busiest->sum_nr_running == 0)
-- 
2.7.4

