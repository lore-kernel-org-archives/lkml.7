Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105D4C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322D21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0e9c5ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGSH7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:59:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41378 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:59:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so28071356wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uMqEORZKZxack2XqfX2Ct1qRRq3fXFeaXwXevbx4NJQ=;
        b=X0e9c5geHASXobnY4+VsSDlwg7F3sr1FwU2iX6VKMRFsANCoSWuJpkdXFixx774oAK
         xo02I+gragJZZQ+h6i7CfDlIZIGgtxoUXANdvwIsk5/RpVQD+mDtVIjyb/6UzHxOJYXV
         E3+t0bvkjBc9vK1ImBLBwuCXcehZt2Akp82PoYliQbh3O0Ta77Bl7ah5zcIPRm33sOcA
         1oYfjgzHO7TmSVvEz66vFrT4QWJfMiV03U8cAfaEOI5kPE+TuMT1GI3OAvXuWlzYwxsW
         JQEtjt3TwZ1efSdLKuE19RaGZRltsF4Mq5UsFnRm1OYC6X+HDXc7ip0ZZ80ASqxOFUPN
         w8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uMqEORZKZxack2XqfX2Ct1qRRq3fXFeaXwXevbx4NJQ=;
        b=oKaIJaPglx7TQbuRCW0I6t3O338UCrX4AEYKHLD0jkWnUe1/BkyYXB85sbwtIBzPBU
         QPtnUFzKl1QNoEfRksCReXvwuAivJLKeWH5As2lPJzLoAs0AJjTYh0I5X3p87RmddMo9
         pM5Dl2a70gEr+yx0Bvx8cwAV2z/9rpw1mGwDESlsCvtVezijunr3/uGQbmpl0O21ctdo
         IF3VZXgKWsVYkZAKta42OtbOFFluyp/PVDlMHS7rzBXN32lOnM/hG1522ss6Zqcqw5dz
         bdJxNT/TeTnbY08/cPb1uOyTh51axSQ0YGshz4ZIqTkKHedjXKxWJvcei1cAHK2KpZpr
         /oTw==
X-Gm-Message-State: APjAAAVR4SRpUw+YhRwzZ2v6I2LlHIOygm/Nn64WPEsbFRH0o9Z/a7l2
        Tf1gKuCZl4u9/UgoKpncfyN8S3a8DF8=
X-Google-Smtp-Source: APXvYqy/Q13XKUIkC3I8jvsNpTMYdcK1OZYV1QkSWVPEiZYUF2MZeFRTjn0EqwMIC7RdbxL4i3srDA==
X-Received: by 2002:adf:f286:: with SMTP id k6mr45104371wro.320.1563523138168;
        Fri, 19 Jul 2019 00:58:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:484b:32fe:1cf4:f69b])
        by smtp.gmail.com with ESMTPSA id c1sm58673826wrh.1.2019.07.19.00.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 00:58:57 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/5] sched/fair: use load instead of runnable load
Date:   Fri, 19 Jul 2019 09:58:24 +0200
Message-Id: <1563523105-24673-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
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
 kernel/sched/fair.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 472959df..c221713 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5371,6 +5371,11 @@ static unsigned long cpu_runnable_load(struct rq *rq)
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
@@ -5466,7 +5471,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = cpu_runnable_load(cpu_rq(this_cpu));
+	this_eff_load = cpu_load(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5484,7 +5489,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = cpu_runnable_load(cpu_rq(prev_cpu));
+	prev_eff_load = cpu_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5572,7 +5577,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -5708,7 +5713,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
 				least_loaded_cpu = i;
@@ -8030,7 +8035,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += cpu_runnable_load(rq);
+		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 		nr_running = rq->nr_running;
@@ -8446,7 +8451,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	init_sd_lb_stats(&sds);
 
 	/*
-	 * Compute the various statistics relavent for load balancing at
+	 * Compute the various statistics relevant for load balancing at
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
@@ -8641,10 +8646,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		}
 
 		/*
-		 * When comparing with load imbalance, use weighted_cpuload()
+		 * When comparing with load imbalance, use cpu_load()
 		 * which is not scaled with the CPU capacity.
 		 */
-		load = cpu_runnable_load(rq);
+		load = cpu_load(rq);
 
 		if (rq->nr_running == 1 && load > env->imbalance &&
 		    !check_cpu_capacity(rq, env->sd))
-- 
2.7.4

