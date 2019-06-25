Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB726C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B48A21655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ksTJ0WpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfFYIcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:32:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbfFYIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:32:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8VUiY3530954
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:31:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8VUiY3530954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451491;
        bh=PqIDUKUUmeNFmTSXYdkT/JwB3XdwItIXvEyRMxSeKNI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ksTJ0WpPMxTWlTS8nGoYs023nQ0lS/g9qJOIdJQIFvz50g586SMw3kwe2QZ7ThYmd
         lcDEgeDM+vLvsyv4EgqHQnEleFyfqoPOJa8l4qVbSYC7gkE0to+hsrOxE9htSNqjxZ
         7azbUOQXJHFiLCwolYzXXQJSjqPrntBiM5JV965OoFKcyt/YjQcksiyY4JppUXk6k1
         B+EAPPvSTtNwKCSsLpDtOTULzUZSArGb+Xj2z6p5gXyp/+8blVZ3SiiPC/ML76Undp
         i7ZCqW5YGuamxNhulTsheRElN0mFm8YH8ZUuoZNiS4kQxaTJrx4FmD+9NuKUryOagT
         tgDHaHhVJZ3jg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8VUk43530951;
        Tue, 25 Jun 2019 01:31:30 -0700
Date:   Tue, 25 Jun 2019 01:31:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-e496187da71070687b55ff455e7d8d7d7f0ae0b9@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        surenb@google.com, joelaf@google.com, juri.lelli@redhat.com,
        tj@kernel.org, vincent.guittot@linaro.org, smuckle@google.com,
        quentin.perret@arm.com, balsini@android.com, mingo@kernel.org,
        patrick.bellasi@arm.com, pjt@google.com,
        rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
        torvalds@linux-foundation.org, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, tkjos@google.com
Reply-To: joelaf@google.com, surenb@google.com, tj@kernel.org,
          juri.lelli@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          quentin.perret@arm.com, balsini@android.com,
          patrick.bellasi@arm.com, smuckle@google.com,
          vincent.guittot@linaro.org, rafael.j.wysocki@intel.com,
          pjt@google.com, tkjos@google.com, peterz@infradead.org,
          viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
          morten.rasmussen@arm.com, torvalds@linux-foundation.org
In-Reply-To: <20190621084217.8167-4-patrick.bellasi@arm.com>
References: <20190621084217.8167-4-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Enforce last task's UCLAMP_MAX
Git-Commit-ID: e496187da71070687b55ff455e7d8d7d7f0ae0b9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e496187da71070687b55ff455e7d8d7d7f0ae0b9
Gitweb:     https://git.kernel.org/tip/e496187da71070687b55ff455e7d8d7d7f0ae0b9
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:04 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:45 +0200

sched/uclamp: Enforce last task's UCLAMP_MAX

When a task sleeps it removes its max utilization clamp from its CPU.
However, the blocked utilization on that CPU can be higher than the max
clamp value enforced while the task was running. This allows undesired
CPU frequency increases while a CPU is idle, for example, when another
CPU on the same frequency domain triggers a frequency update, since
schedutil can now see the full not clamped blocked utilization of the
idle CPU.

Fix this by using:

  uclamp_rq_dec_id(p, rq, UCLAMP_MAX)
    uclamp_rq_max_value(rq, UCLAMP_MAX, clamp_value)

to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition.

Don't track any minimum utilization clamps since an idle CPU never
requires a minimum frequency. The decay of the blocked utilization is
good enough to reduce the CPU frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alessio Balsini <balsini@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190621084217.8167-4-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |  2 ++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0a6eff8a278b..2dde735635ec 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -803,8 +803,36 @@ static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
 	uc_se->bucket_id = uclamp_bucket_id(value);
 }
 
+static inline unsigned int
+uclamp_idle_value(struct rq *rq, unsigned int clamp_id,
+		  unsigned int clamp_value)
+{
+	/*
+	 * Avoid blocked utilization pushing up the frequency when we go
+	 * idle (which drops the max-clamp) by retaining the last known
+	 * max-clamp.
+	 */
+	if (clamp_id == UCLAMP_MAX) {
+		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
+		return clamp_value;
+	}
+
+	return uclamp_none(UCLAMP_MIN);
+}
+
+static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
+				     unsigned int clamp_value)
+{
+	/* Reset max-clamp retention only on idle exit */
+	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		return;
+
+	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
+}
+
 static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
+unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
+				 unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
 	int bucket_id = UCLAMP_BUCKETS - 1;
@@ -820,7 +848,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
 	}
 
 	/* No tasks -- default clamp values */
-	return uclamp_none(clamp_id);
+	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
 /*
@@ -845,6 +873,8 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
 
+	uclamp_idle_reset(rq, clamp_id, uc_se->value);
+
 	/*
 	 * Local max aggregation: rq buckets always track the max
 	 * "requested" clamp value of its RUNNABLE tasks.
@@ -871,6 +901,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
 	struct uclamp_bucket *bucket;
+	unsigned int bkt_clamp;
 	unsigned int rq_clamp;
 
 	lockdep_assert_held(&rq->lock);
@@ -895,8 +926,10 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * e.g. due to future modification, warn and fixup the expected value.
 	 */
 	SCHED_WARN_ON(bucket->value > rq_clamp);
-	if (bucket->value >= rq_clamp)
-		WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
+	if (bucket->value >= rq_clamp) {
+		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
+		WRITE_ONCE(uc_rq->value, bkt_clamp);
+	}
 }
 
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
@@ -908,6 +941,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
+
+	/* Reset clamp idle holding when there is one RUNNABLE task */
+	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
@@ -926,8 +963,10 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		cpu_rq(cpu)->uclamp_flags = 0;
+	}
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp[clamp_id],
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cecc6baaba93..0d2ba8bb2cb3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -870,6 +870,8 @@ struct rq {
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
+	unsigned int		uclamp_flags;
+#define UCLAMP_FLAG_IDLE 0x01
 #endif
 
 	struct cfs_rq		cfs;
