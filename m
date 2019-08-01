Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF94C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DCA216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkibWlGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfHAOk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38241 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfHAOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so42088196wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JzB9VaAbbg7LQZ9XSxn2KJHSUzRU4B8rlHeaB0NzIVs=;
        b=qkibWlGky7jPtVk0adbE/rqs5Uc/g8DkejdRLARL5z6ljsALiSbXTObjHxNfYrKpBA
         3Rd7Gr3DKgHMiICqjUrs0Eh2qVjF4ONHskFovt1TZCkirFuxBlzvm6/GCrjQKoTD11bg
         qEk6/S0U1C0vIto+9KYKlfw0NdxYDPhRIqS+IqtMgEuhkdtsY+864Mx4nva3ED5y3rko
         QdbKYi62LQmkffNjYyQ6An+rwoymFF1QLMnUziKOMo/aPtxbc38lopX6TKEGZ2F/JWfN
         L093jggoRY7BAckbIHj53Ohc+JEw/ER2wiibR2yo6yhW9Ww4rcahADbsVsOOcYi8IFa0
         h/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzB9VaAbbg7LQZ9XSxn2KJHSUzRU4B8rlHeaB0NzIVs=;
        b=fOeyz/atMEprqa+IgbtiP4ZBmXp4tPaYpdlTTyDnc1BSjUCYKxhqDB8IU88/jCiSBz
         w6BgpKU2k8kWlS2u46M2yoGB5nFspwAumZy/yqIocz+3/lstLp19PkMNqPDW6jO8MalG
         SjdN/UH4wZcDWM4SxLqyjWKUI7mQEpgoru1NACreM0p3AMchrU/PdLSnlnCE0FY86oU9
         aACDbPqd9yqgU4wgN8axQt1SLY5ZlU0dr5Dl0DBA3BkialmV+DA8VGu5WEfbU6wqq+BI
         ic91IAx2oPyuDDCo/U0sROvtwUpDUm5O0ni+8DwHBDI1zTsJJbTLY9TqjpCIRmfgHEhx
         MMdw==
X-Gm-Message-State: APjAAAWiDGqliwDx+I6zGllUC9g/zT7M/L8y/KF7n9Mr/HiQLcoje3ze
        7c3iYVLidjWgtxXundC7UFztOaHzZKk=
X-Google-Smtp-Source: APXvYqz2UY746bAd7JIWlpxON9YUpKVgeWvi4XRnJoWyU7Iz/ytIKzVsJ9KBpXv3HdhtWFOGYGP/7g==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr122451652wmj.31.1564670436768;
        Thu, 01 Aug 2019 07:40:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:36 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 6/8] sched/fair: use load instead of runnable load
Date:   Thu,  1 Aug 2019 16:40:22 +0200
Message-Id: <1564670424-26023-7-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runnable load has been introduced to take into account the case
where blocked load biases the load balance decision which was selecting
underutilized group with huge blocked load whereas other groups were
overloaded.

The load is now only used when groups are overloaded. In this case,
it's worth being conservative and taking into account the sleeping
tasks that might wakeup on the cpu.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f05f1ad..dfaf0b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5445,6 +5445,11 @@ static unsigned long cpu_runnable_load(struct rq *rq)
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
 
+static unsigned long cpu_load(struct rq *rq)
+{
+	return cfs_rq_load_avg(&rq->cfs);
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -5540,7 +5545,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = cpu_runnable_load(cpu_rq(this_cpu));
+	this_eff_load = cpu_load(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5558,7 +5563,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = cpu_runnable_load(cpu_rq(prev_cpu));
+	prev_eff_load = cpu_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5646,7 +5651,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -5787,7 +5792,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				continue;
 			}
 
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
 				least_loaded_cpu = i;
@@ -8128,7 +8133,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += cpu_runnable_load(rq);
+		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -8569,7 +8574,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	init_sd_lb_stats(&sds);
 
 	/*
-	 * Compute the various statistics relavent for load balancing at
+	 * Compute the various statistics relevant for load balancing at
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
@@ -8748,10 +8753,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		case migrate_load:
 			/*
-			 * When comparing with load imbalance, use cpu_runnable_load()
+			 * When comparing with load imbalance, use cpu_load()
 			 * which is not scaled with the CPU capacity.
 			 */
-			load = cpu_runnable_load(rq);
+			load = cpu_load(rq);
 
 			if (nr_running == 1 && load > env->imbalance &&
 			    !check_cpu_capacity(rq, env->sd))
@@ -8759,7 +8764,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 			/*
 			 * For the load comparisons with the other CPU's, consider
-			 * the cpu_runnable_load() scaled with the CPU capacity, so
+			 * the cpu_load() scaled with the CPU capacity, so
 			 * that the load can be moved away from the CPU that is
 			 * potentially running at a lower capacity.
 			 *
-- 
2.7.4

