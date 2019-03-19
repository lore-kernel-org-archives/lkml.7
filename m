Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC239C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F68217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViufV3H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfCSX4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:56:43 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42455 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfCSX4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:36 -0400
Received: by mail-pg1-f202.google.com with SMTP id v3so732510pgk.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OBXkes655anl10ghu56F3PCl5wd5CeGj94L2IaEvAok=;
        b=ViufV3H9RpAeDfEYRca09ZHiuCDEEE7bKNCDMcMtKBrJC14eRqNfcqNHHYQOq+na9V
         6H7JdNNGddCsCaecqnHRDT4qvYX1DB8C6plteEXU+zIk9R8baXzQOsoHfLMW7UYoIrJa
         xnxyu8o4Ns4Hw4KIqkgi04u/ojN0sGrpDJ53t1VKOu9ympyYotAVuoZWBitaFUIMdMav
         Nyhu/nbgRgdMV1SO9zoqliqG4Z3hvkfNYsgnd1suNAvHG589L2XGHM6fZx/n65Up7Ijh
         Cxbjtaq3cvyaQyocIsPIbFFUuY28iDEH1CwonE07NSVXVpttNoqUiLr31kJH9b2CyWhZ
         7Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OBXkes655anl10ghu56F3PCl5wd5CeGj94L2IaEvAok=;
        b=c6JUICSzViM9kokZyeW+Eerbm5lEnFMlDR7+voPeWL9Pm7hqrMNUlp13r7aPGNrvt/
         H171Y8+IIMN8Pv0XcEqRdnzF2x0Hmu4X0H31GszN6rKpRWZGoYewF3lxQF5tYCsGU2LA
         RDWrCzJtzm5w2an0yQsnJLF08ZTJ/w1DuyEKB6Vc/pitt3X/hBhQu7wxkH24kNmHuzqf
         fKU7fTTaTQ4oNG8t1UGb8pKpzd39lvvtLzfboNy58+z47OgxnFTL/1sCb87YkQXYeAa1
         zgBp5xaRGQU6WBQtKQfQkrNlXBV2GRNhU2kgkWtuT4NJ0uR0Ka6aspTmV2kkHFiv13QA
         NWdg==
X-Gm-Message-State: APjAAAWxAZ406aUByvDQTpwnXi+ZGmC7dm+HFeHTHvtRyBctcLJ7nOS+
        K7ZOGJb3DzGWSFoTaf3hce5kR+YRAiM=
X-Google-Smtp-Source: APXvYqyuwpOXbhD+fWfIrgCA7neQKWQsukpEJktLS0Mziza+SL39C80NgdVKpxLsF1KcKTsjtymvde1TM/8=
X-Received: by 2002:a65:6495:: with SMTP id e21mr8268337pgv.58.1553039794697;
 Tue, 19 Mar 2019 16:56:34 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:56:15 -0700
In-Reply-To: <20190319235619.260832-1-surenb@google.com>
Message-Id: <20190319235619.260832-4-surenb@google.com>
Mime-Version: 1.0
References: <20190319235619.260832-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v6 3/7] psi: rename psi fields in preparation for psi trigger addition
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming psi_group structure member fields used for calculating psi totals
and averages for clear distinction between them and trigger-related fields
that will be added next.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi_types.h | 14 ++++++-------
 kernel/sched/psi.c        | 41 ++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 762c6bb16f3c..4d1c1f67be18 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -69,17 +69,17 @@ struct psi_group_cpu {
 };
 
 struct psi_group {
-	/* Protects data updated during an aggregation */
-	struct mutex stat_lock;
+	/* Protects data used by the aggregator */
+	struct mutex avgs_lock;
 
 	/* Per-cpu task state & time tracking */
 	struct psi_group_cpu __percpu *pcpu;
 
-	/* Periodic aggregation state */
-	u64 total_prev[NR_PSI_STATES - 1];
-	u64 last_update;
-	u64 next_update;
-	struct delayed_work clock_work;
+	/* Running pressure averages */
+	u64 avg_total[NR_PSI_STATES - 1];
+	u64 avg_last_update;
+	u64 avg_next_update;
+	struct delayed_work avgs_work;
 
 	/* Total stall times and sampled pressure averages */
 	u64 total[NR_PSI_STATES - 1];
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 281702de9772..4fb4d9913bc8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -165,7 +165,7 @@ static struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
-static void psi_update_work(struct work_struct *work);
+static void psi_avgs_work(struct work_struct *work);
 
 static void group_init(struct psi_group *group)
 {
@@ -173,9 +173,9 @@ static void group_init(struct psi_group *group)
 
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
-	group->next_update = sched_clock() + psi_period;
-	INIT_DELAYED_WORK(&group->clock_work, psi_update_work);
-	mutex_init(&group->stat_lock);
+	group->avg_next_update = sched_clock() + psi_period;
+	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
+	mutex_init(&group->avgs_lock);
 }
 
 void __init psi_init(void)
@@ -278,7 +278,7 @@ static bool update_stats(struct psi_group *group)
 	int cpu;
 	int s;
 
-	mutex_lock(&group->stat_lock);
+	mutex_lock(&group->avgs_lock);
 
 	/*
 	 * Collect the per-cpu time buckets and average them into a
@@ -319,7 +319,7 @@ static bool update_stats(struct psi_group *group)
 
 	/* avgX= */
 	now = sched_clock();
-	expires = group->next_update;
+	expires = group->avg_next_update;
 	if (now < expires)
 		goto out;
 	if (now - expires >= psi_period)
@@ -332,14 +332,14 @@ static bool update_stats(struct psi_group *group)
 	 * But the deltas we sample out of the per-cpu buckets above
 	 * are based on the actual time elapsing between clock ticks.
 	 */
-	group->next_update = expires + ((1 + missed_periods) * psi_period);
-	period = now - (group->last_update + (missed_periods * psi_period));
-	group->last_update = now;
+	group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	period = now - (group->avg_last_update + (missed_periods * psi_period));
+	group->avg_last_update = now;
 
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {
 		u32 sample;
 
-		sample = group->total[s] - group->total_prev[s];
+		sample = group->total[s] - group->avg_total[s];
 		/*
 		 * Due to the lockless sampling of the time buckets,
 		 * recorded time deltas can slip into the next period,
@@ -359,22 +359,22 @@ static bool update_stats(struct psi_group *group)
 		 */
 		if (sample > period)
 			sample = period;
-		group->total_prev[s] += sample;
+		group->avg_total[s] += sample;
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
 out:
-	mutex_unlock(&group->stat_lock);
+	mutex_unlock(&group->avgs_lock);
 	return nonidle_total;
 }
 
-static void psi_update_work(struct work_struct *work)
+static void psi_avgs_work(struct work_struct *work)
 {
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	bool nonidle;
 
 	dwork = to_delayed_work(work);
-	group = container_of(dwork, struct psi_group, clock_work);
+	group = container_of(dwork, struct psi_group, avgs_work);
 
 	/*
 	 * If there is task activity, periodically fold the per-cpu
@@ -391,8 +391,9 @@ static void psi_update_work(struct work_struct *work)
 		u64 now;
 
 		now = sched_clock();
-		if (group->next_update > now)
-			delay = nsecs_to_jiffies(group->next_update - now) + 1;
+		if (group->avg_next_update > now)
+			delay = nsecs_to_jiffies(
+					group->avg_next_update - now) + 1;
 		schedule_delayed_work(dwork, delay);
 	}
 }
@@ -546,13 +547,13 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	 */
 	if (unlikely((clear & TSK_RUNNING) &&
 		     (task->flags & PF_WQ_WORKER) &&
-		     wq_worker_last_func(task) == psi_update_work))
+		     wq_worker_last_func(task) == psi_avgs_work))
 		wake_clock = false;
 
 	while ((group = iterate_groups(task, &iter))) {
 		psi_group_change(group, cpu, clear, set);
-		if (wake_clock && !delayed_work_pending(&group->clock_work))
-			schedule_delayed_work(&group->clock_work, PSI_FREQ);
+		if (wake_clock && !delayed_work_pending(&group->avgs_work))
+			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 	}
 }
 
@@ -649,7 +650,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	cancel_delayed_work_sync(&cgroup->psi.clock_work);
+	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
 	free_percpu(cgroup->psi.pcpu);
 }
 
-- 
2.21.0.225.g810b269d1ac-goog

