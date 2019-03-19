Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B946217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6b442+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCSX4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:56:42 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39187 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCSX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:38 -0400
Received: by mail-yw1-f74.google.com with SMTP id p1so687792ywm.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dn6PEiCR+dScVGu5EewnvuQCwpS0GucFANxBNtI0jyg=;
        b=Z6b442+6DNI/wL3Sl+GmBfCDemyRgLchS2XX8vUdUBCLvLTr6SRAXAFrKle3CWKt83
         v/Lyw5vroFag4ZNItRCs1E2AW0rTWPfFeUTPo1GonT4xq3BSGy7UAoDlpLr8wfzd4dEk
         cAQsQM3nDSIJoKigdyekrTeWCnEDlgdImc40cSqjYKkcrN0irpacS5iuUwz+nNKTfCj6
         gN9agbjk3JafwYtdbZcJrSQ9KVE5u5RPfTsRdqFUk6odVENAIbN2URKCX146f8h3tIki
         tQqvJcideceDh5tkn6j7mXS/7dCIydNbwoCEy1XZmg00rksFqoQLHtmFE2PGru24T2ue
         Q36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dn6PEiCR+dScVGu5EewnvuQCwpS0GucFANxBNtI0jyg=;
        b=GLSchV1JvDLO2mWlH7aT3FpN1KVd2PahXDpX2+WKGl6p1fZJMxGKAaGxZQj+HsaH9D
         thuN6v7thh8CCTg/w2j5YDsl5xpuvSB5sSEJjO3l4+7vN9u9jsE+Z2uJJKdWWkqlOwOb
         V8yFXSAWAAmrVwGDfzjT5vUC0YtPjFa41h7VnDuqBQmr7XNk3qX1YXxwzQQPA9AlV9jG
         0bitezsJDsnpjOPxQPO0iw1CeK2cIPY8YfxFhUKfCEmpJBLxEhSSWgAa/61TnbC2EVcr
         9j/SS0tIkxIEmP6MIW4jURgM8FMp0oeQ/YZXV7UnrA5HwV+nCcR+8lzqYNm4pTNd5tqd
         ewcA==
X-Gm-Message-State: APjAAAUL+7jteQTiqq8ps57rXMPE0FwnFEFGC2l54G2Rsw3CxfLoZGnM
        6Aa8n4tJS4VbvgLb5YC3LiQnSkbppkM=
X-Google-Smtp-Source: APXvYqzqRXV9Su0O8ijkHzVc98Uu6jekXyU8mHEz8z0Z4ekoSX8Xd/HdmZXF1XnScGWT74vxfZWql8OgG4g=
X-Received: by 2002:a25:ae96:: with SMTP id b22mr1664495ybj.94.1553039797316;
 Tue, 19 Mar 2019 16:56:37 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:56:16 -0700
In-Reply-To: <20190319235619.260832-1-surenb@google.com>
Message-Id: <20190319235619.260832-5-surenb@google.com>
Mime-Version: 1.0
References: <20190319235619.260832-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v6 4/7] psi: split update_stats into parts
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

Split update_stats into collect_percpu_times and update_averages for
collect_percpu_times to be reused later inside psi monitor.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 57 +++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 4fb4d9913bc8..ace5ed97b186 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -269,17 +269,13 @@ static void calc_avgs(unsigned long avg[3], int missed_periods,
 	avg[2] = calc_load(avg[2], EXP_300s, pct);
 }
 
-static bool update_stats(struct psi_group *group)
+static bool collect_percpu_times(struct psi_group *group)
 {
 	u64 deltas[NR_PSI_STATES - 1] = { 0, };
-	unsigned long missed_periods = 0;
 	unsigned long nonidle_total = 0;
-	u64 now, expires, period;
 	int cpu;
 	int s;
 
-	mutex_lock(&group->avgs_lock);
-
 	/*
 	 * Collect the per-cpu time buckets and average them into a
 	 * single time sample that is normalized to wallclock time.
@@ -317,11 +313,18 @@ static bool update_stats(struct psi_group *group)
 	for (s = 0; s < NR_PSI_STATES - 1; s++)
 		group->total[s] += div_u64(deltas[s], max(nonidle_total, 1UL));
 
+	return nonidle_total;
+}
+
+static u64 update_averages(struct psi_group *group, u64 now)
+{
+	unsigned long missed_periods = 0;
+	u64 expires, period;
+	u64 avg_next_update;
+	int s;
+
 	/* avgX= */
-	now = sched_clock();
 	expires = group->avg_next_update;
-	if (now < expires)
-		goto out;
 	if (now - expires >= psi_period)
 		missed_periods = div_u64(now - expires, psi_period);
 
@@ -332,7 +335,7 @@ static bool update_stats(struct psi_group *group)
 	 * But the deltas we sample out of the per-cpu buckets above
 	 * are based on the actual time elapsing between clock ticks.
 	 */
-	group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	avg_next_update = expires + ((1 + missed_periods) * psi_period);
 	period = now - (group->avg_last_update + (missed_periods * psi_period));
 	group->avg_last_update = now;
 
@@ -362,9 +365,8 @@ static bool update_stats(struct psi_group *group)
 		group->avg_total[s] += sample;
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
-out:
-	mutex_unlock(&group->avgs_lock);
-	return nonidle_total;
+
+	return avg_next_update;
 }
 
 static void psi_avgs_work(struct work_struct *work)
@@ -372,10 +374,16 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	bool nonidle;
+	u64 now;
 
 	dwork = to_delayed_work(work);
 	group = container_of(dwork, struct psi_group, avgs_work);
 
+	mutex_lock(&group->avgs_lock);
+
+	now = sched_clock();
+
+	nonidle = collect_percpu_times(group);
 	/*
 	 * If there is task activity, periodically fold the per-cpu
 	 * times and feed samples into the running averages. If things
@@ -383,19 +391,15 @@ static void psi_avgs_work(struct work_struct *work)
 	 * Once restarted, we'll catch up the running averages in one
 	 * go - see calc_avgs() and missed_periods.
 	 */
-
-	nonidle = update_stats(group);
+	if (now >= group->avg_next_update)
+		group->avg_next_update = update_averages(group, now);
 
 	if (nonidle) {
-		unsigned long delay = 0;
-		u64 now;
-
-		now = sched_clock();
-		if (group->avg_next_update > now)
-			delay = nsecs_to_jiffies(
-					group->avg_next_update - now) + 1;
-		schedule_delayed_work(dwork, delay);
+		schedule_delayed_work(dwork, nsecs_to_jiffies(
+				group->avg_next_update - now) + 1);
 	}
+
+	mutex_unlock(&group->avgs_lock);
 }
 
 static void record_times(struct psi_group_cpu *groupc, int cpu,
@@ -707,11 +711,18 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
 	int full;
+	u64 now;
 
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
-	update_stats(group);
+	/* Update averages before reporting them */
+	mutex_lock(&group->avgs_lock);
+	now = sched_clock();
+	collect_percpu_times(group);
+	if (now >= group->avg_next_update)
+		group->avg_next_update = update_averages(group, now);
+	mutex_unlock(&group->avgs_lock);
 
 	for (full = 0; full < 2 - (res == PSI_CPU); full++) {
 		unsigned long avg[3];
-- 
2.21.0.225.g810b269d1ac-goog

