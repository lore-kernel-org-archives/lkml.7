Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72373C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5FD205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fj3OUfzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfFYIbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:31:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:31:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8UiJ83530859
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:30:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8UiJ83530859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451445;
        bh=TtMW6kRNDrkdJRMunLg1nGGdBIfnK4EGkyNec+zzJZU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fj3OUfzWHM0TCOx7kXexCkELuk1BvnJR9lL5xcB18dDvf6EoGedY7Xgp4sXnpK9tO
         JT/fjxLAaMlaHR0IcAykHXIv0EaZtqW0ONoWFFMLimqYnB6HnYPUbOhx0+ErNphRd8
         9kdU4x0ppKNNSLfR6s7vqH7TrHVlaCOHd0Atx2G3jEMg6FDprxTF7kXuPF6+1L4Vdc
         6/i9vqpM4YhgKYy/Ze9r/ShMgtk3yzfAlFQilZM+3IALecVdEI2xgLCMT14u/FOt9a
         my5AMy1qmPazIuXiuQktysfj2JcSHvlPLWv14EFRTvkapJorGKhb3yBczGnrCaDPON
         DeuwsQcM29EBA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8UiNp3530856;
        Tue, 25 Jun 2019 01:30:44 -0700
Date:   Tue, 25 Jun 2019 01:30:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-60daf9c19410604f08c99e146bc378c8a64f4ccd@git.kernel.org>
Cc:     pjt@google.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, balsini@android.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        vincent.guittot@linaro.org, tkjos@google.com, hpa@zytor.com,
        juri.lelli@redhat.com, patrick.bellasi@arm.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        viresh.kumar@linaro.org, surenb@google.com, tj@kernel.org,
        mingo@kernel.org, joelaf@google.com, quentin.perret@arm.com,
        smuckle@google.com, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, pjt@google.com,
          dietmar.eggemann@arm.com, rafael.j.wysocki@intel.com,
          peterz@infradead.org, balsini@android.com, hpa@zytor.com,
          juri.lelli@redhat.com, vincent.guittot@linaro.org,
          tkjos@google.com, patrick.bellasi@arm.com,
          morten.rasmussen@arm.com, viresh.kumar@linaro.org,
          tglx@linutronix.de, surenb@google.com, smuckle@google.com,
          torvalds@linux-foundation.org, mingo@kernel.org, tj@kernel.org,
          joelaf@google.com, quentin.perret@arm.com
In-Reply-To: <20190621084217.8167-3-patrick.bellasi@arm.com>
References: <20190621084217.8167-3-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Add bucket local max tracking
Git-Commit-ID: 60daf9c19410604f08c99e146bc378c8a64f4ccd
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

Commit-ID:  60daf9c19410604f08c99e146bc378c8a64f4ccd
Gitweb:     https://git.kernel.org/tip/60daf9c19410604f08c99e146bc378c8a64f4ccd
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:03 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:44 +0200

sched/uclamp: Add bucket local max tracking

Because of bucketization, different task-specific clamp values are
tracked in the same bucket.  For example, with 20% bucket size and
assuming to have:

  Task1: util_min=25%
  Task2: util_min=35%

both tasks will be refcounted in the [20..39]% bucket and always boosted
only up to 20% thus implementing a simple floor aggregation normally
used in histograms.

In systems with only few and well-defined clamp values, it would be
useful to track the exact clamp value required by a task whenever
possible. For example, if a system requires only 23% and 47% boost
values then it's possible to track the exact boost required by each
task using only 3 buckets of ~33% size each.

Introduce a mechanism to max aggregate the requested clamp values of
RUNNABLE tasks in the same bucket. Keep it simple by resetting the
bucket value to its base value only when a bucket becomes inactive.
Allow a limited and controlled overboosting margin for tasks recounted
in the same bucket.

In systems where the boost values are not known in advance, it is still
possible to control the maximum acceptable overboosting margin by tuning
the number of clamp groups. For example, 20 groups ensure a 5% maximum
overboost.

Remove the rq bucket initialization code since a correct bucket value
is now computed when a task is refcounted into a CPU's rq.

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
Link: https://lkml.kernel.org/r/20190621084217.8167-3-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8c1e67afd82..0a6eff8a278b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -785,6 +785,11 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 	return clamp_value / UCLAMP_BUCKET_DELTA;
 }
 
+static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
+{
+	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
+}
+
 static inline unsigned int uclamp_none(int clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
@@ -822,6 +827,11 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
  * When a task is enqueued on a rq, the clamp bucket currently defined by the
  * task's uclamp::bucket_id is refcounted on that rq. This also immediately
  * updates the rq's clamp value if required.
+ *
+ * Tasks can have a task-specific value requested from user-space, track
+ * within each bucket the maximum value for tasks refcounted in it.
+ * This "local max aggregation" allows to track the exact "requested" value
+ * for each bucket when all its RUNNABLE tasks require the same clamp.
  */
 static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 				    unsigned int clamp_id)
@@ -835,8 +845,15 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
 
+	/*
+	 * Local max aggregation: rq buckets always track the max
+	 * "requested" clamp value of its RUNNABLE tasks.
+	 */
+	if (bucket->tasks == 1 || uc_se->value > bucket->value)
+		bucket->value = uc_se->value;
+
 	if (uc_se->value > READ_ONCE(uc_rq->value))
-		WRITE_ONCE(uc_rq->value, bucket->value);
+		WRITE_ONCE(uc_rq->value, uc_se->value);
 }
 
 /*
@@ -863,6 +880,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	if (likely(bucket->tasks))
 		bucket->tasks--;
 
+	/*
+	 * Keep "local max aggregation" simple and accept to (possibly)
+	 * overboost some RUNNABLE tasks in the same bucket.
+	 * The rq clamp bucket value is reset to its base value whenever
+	 * there are no more RUNNABLE tasks refcounting it.
+	 */
 	if (likely(bucket->tasks))
 		return;
 
@@ -903,25 +926,9 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		struct uclamp_bucket *bucket;
-		struct uclamp_rq *uc_rq;
-		unsigned int bucket_id;
-
+	for_each_possible_cpu(cpu)
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 
-		for_each_clamp_id(clamp_id) {
-			uc_rq = &cpu_rq(cpu)->uclamp[clamp_id];
-
-			bucket_id = 1;
-			while (bucket_id < UCLAMP_BUCKETS) {
-				bucket = &uc_rq->bucket[bucket_id];
-				bucket->value = bucket_id * UCLAMP_BUCKET_DELTA;
-				++bucket_id;
-			}
-		}
-	}
-
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp[clamp_id],
 			      uclamp_none(clamp_id));
