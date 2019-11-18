Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FEFC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8F320748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WepqQ2ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKRNV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:21:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36910 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfKRNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:21:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so19444222wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lxr9GeEXmv85wrOINCVAdQwZGIOO7LWMdZuLx8D/s+g=;
        b=WepqQ2MLR3dv6BdTSlx/OorTFy1GwgA7kGJUyfCgeq/K0BCp/QrBROKM8KUVVRjePF
         LWIldKlG5HSXlIYg5u6YFqrHgY1uzC3TXGpttuoKtmqW+HWS8WFVgz1b9esoj8CHprSX
         MyoIIPMij0igA425jyt1pcKGnz33Wu+s93N3rr5gik9Ugb9+Kqo+z/qUsdMF40HImQ3n
         du1VexynxXwnDStOW/eHaNmuZzEhatmoQY5f0lwraHeQltO4+Fmkltl6Dp7OR/BnaaDH
         gTjXLUkk5iexmL8qqpBZT99VxHn7YeT/6Vpn13BKU/ZFbHTXcb2C+xyJgWeQ4qZoEILg
         XEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lxr9GeEXmv85wrOINCVAdQwZGIOO7LWMdZuLx8D/s+g=;
        b=TZXdcDZ9dB/rgIGV52q071W9FIbpC6kNZFxB4DBfTC7POQk4z0H+mq5HtSERzBUulI
         7MgQ9swY3dRsmUCQtwNiOU7FHds704+kz/fFatla0Em3Vtk/1QHzCC8J08K8eqS9Sisb
         DqngZsfHKszZU5FfgE6RW/NawGar26HJNKcDu3+AwmCqzq3hwzRSCn0A8JFGp6kFx4ca
         Xsz1kl/BuZ2MhhGz/NDsuTRRtoNJpatcdku2vph+Q/Eokv2/MN3Nf/1VRv6sJoGfiDdO
         j6rhQ9Lmxp36lNwKxipMoQiswr5/NTYc7deHATBTkht++vru3F6P84ji3ucW80ZhYj5C
         OzbQ==
X-Gm-Message-State: APjAAAVF5UoJd8LWXGbDBdkEfVRk3yCTGsypRYD+kKc77yB2v0+U5pwE
        MyM+LsoqhhadZwNAQqrpYBgyVJNDSy4=
X-Google-Smtp-Source: APXvYqwOw5vY+XC8a1FuDYfRrM1VgnuaYLBFMScjC2Gn+RImpzNdz0SHH+YSU0mbsLfBvecVE/2vtw==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr30998209wro.22.1574083284192;
        Mon, 18 Nov 2019 05:21:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:fc86:5ba0:cc9f:f10b])
        by smtp.gmail.com with ESMTPSA id f140sm21331661wme.21.2019.11.18.05.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 05:21:22 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com, rafael.j.wysocki@intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5] sched/freq: move call to cpufreq_update_util
Date:   Mon, 18 Nov 2019 14:21:19 +0100
Message-Id: <1574083279-799-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
which might be inefficient when cpufreq driver has rate limitation.

When a task is attached on a CPU, we have call path:

update_load_avg()
  update_cfs_rq_load_avg()
    cfs_rq_util_change -- > trig frequency update
  attach_entity_load_avg()
    cfs_rq_util_change -- > trig frequency update

The 1st frequency update will not take into account the utilization of the
newly attached task and the 2nd one might be discard because of rate
limitation of the cpufreq driver.

update_cfs_rq_load_avg() is only called by update_blocked_averages()
and update_load_avg() so we can move the call to
cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
interesting to notice that update_load_avg() already calls directly
cfs_rq_util_change() for !SMP case.

This changes will also ensure that cpufreq_update_util() is called even
when there is no more CFS rq in the leaf_cfs_rq_list to update but only
irq, rt or dl pelt signals.

Reported-by: Doug Smythies <dsmythies@telus.net>
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Doug Smythies <dsmythies@telus.net>
---

this patch applies on tip/sched/urgent as there is a dependency with
commit b90f7c9d2198 ("sched/pelt: Fix update of blocked PELT ordering")

Changes for v5:
- split functions and move code
- no functional change

 kernel/sched/fair.c | 111 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5..9893528 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3504,9 +3504,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3616,8 +3613,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
 		update_tg_load_avg(cfs_rq, 0);
 
-	} else if (decayed && (flags & UPDATE_TG))
-		update_tg_load_avg(cfs_rq, 0);
+	} else if (decayed) {
+		cfs_rq_util_change(cfs_rq, 0);
+
+		if (flags & UPDATE_TG)
+			update_tg_load_avg(cfs_rq, 0);
+	}
 }
 
 #ifndef CONFIG_64BIT
@@ -7517,6 +7518,28 @@ static inline bool others_have_blocked(struct rq *rq) { return false; }
 static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
 #endif
 
+static bool __update_blocked_others(struct rq *rq, bool *done)
+{
+	const struct sched_class *curr_class;
+	u64 now = rq_clock_pelt(rq);
+	bool decayed;
+
+	/*
+	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
+	 * DL and IRQ signals have been updated before updating CFS.
+	 */
+	curr_class = rq->curr->sched_class;
+
+	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
+		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		  update_irq_load_avg(rq, 0);
+
+	if (others_have_blocked(rq))
+		*done = false;
+
+	return decayed;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7536,29 +7559,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
-static void update_blocked_averages(int cpu)
+static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
-	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
-	const struct sched_class *curr_class;
-	struct rq_flags rf;
-	bool done = true;
-
-	rq_lock_irqsave(rq, &rf);
-	update_rq_clock(rq);
-
-	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
-	 */
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
-
-	/* Don't need periodic decay once load/util_avg are null */
-	if (others_have_blocked(rq))
-		done = false;
+	bool decayed = false;
+	int cpu = cpu_of(rq);
 
 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
@@ -7567,9 +7572,13 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq, 0);
 
+			if (cfs_rq == &rq->cfs)
+				decayed = true;
+		}
+
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
@@ -7584,11 +7593,10 @@ static void update_blocked_averages(int cpu)
 
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
-			done = false;
+			*done = false;
 	}
 
-	update_blocked_load_status(rq, !done);
-	rq_unlock_irqrestore(rq, &rf);
+	return decayed;
 }
 
 /*
@@ -7638,29 +7646,16 @@ static unsigned long task_h_load(struct task_struct *p)
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
 #else
-static inline void update_blocked_averages(int cpu)
+static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
-	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
-	const struct sched_class *curr_class;
-	struct rq_flags rf;
-
-	rq_lock_irqsave(rq, &rf);
-	update_rq_clock(rq);
-
-	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
-	 */
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	bool decayed;
 
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	if (cfs_rq_has_blocked(cfs_rq))
+		*done = false;
 
-	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
-	rq_unlock_irqrestore(rq, &rf);
+	return decayed;
 }
 
 static unsigned long task_h_load(struct task_struct *p)
@@ -7669,6 +7664,24 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif
 
+static void update_blocked_averages(int cpu)
+{
+	bool decayed = false, done = true;
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	decayed |= __update_blocked_others(rq, &done);
+	decayed |= __update_blocked_fair(rq, &done);
+
+	update_blocked_load_status(rq, !done);
+	if (decayed)
+		cpufreq_update_util(rq, 0);
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /********** Helpers for find_busiest_group ************************/
 
 /*
-- 
2.7.4

