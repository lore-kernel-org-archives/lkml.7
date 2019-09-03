Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C20C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820D322DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfICIb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfICIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Do-0002jp-R7; Tue, 03 Sep 2019 10:31:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5723C1C0772;
        Tue,  3 Sep 2019 10:31:28 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:28 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Always use 'enum uclamp_id' for
 clamp_id values
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Koutny <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190822132811.31294-7-patrick.bellasi@arm.com>
References: <20190822132811.31294-7-patrick.bellasi@arm.com>
MIME-Version: 1.0
Message-ID: <156749948822.12901.16409092197332560507.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0413d7f33e60751570fd6c179546bde2f7d82dcb
Gitweb:        https://git.kernel.org/tip/0413d7f33e60751570fd6c179546bde2f7d82dcb
Author:        Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate:    Thu, 22 Aug 2019 14:28:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:40 +02:00

sched/uclamp: Always use 'enum uclamp_id' for clamp_id values

The supported clamp indexes are defined in 'enum clamp_id', however, because
of the code logic in some of the first utilization clamping series version,
sometimes we needed to use 'unsigned int' to represent indices.

This is not more required since the final version of the uclamp_* APIs can
always use the proper enum uclamp_id type.

Fix it with a bulk rename now that we have all the bits merged.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michal Koutny <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190822132811.31294-7-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 38 +++++++++++++++++++-------------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55a1c07..3c7b90b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -810,7 +810,7 @@ static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
 	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
 }
 
-static inline unsigned int uclamp_none(int clamp_id)
+static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
 		return 0;
@@ -826,7 +826,7 @@ static inline void uclamp_se_set(struct uclamp_se *uc_se,
 }
 
 static inline unsigned int
-uclamp_idle_value(struct rq *rq, unsigned int clamp_id,
+uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
 		  unsigned int clamp_value)
 {
 	/*
@@ -842,7 +842,7 @@ uclamp_idle_value(struct rq *rq, unsigned int clamp_id,
 	return uclamp_none(UCLAMP_MIN);
 }
 
-static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
+static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 				     unsigned int clamp_value)
 {
 	/* Reset max-clamp retention only on idle exit */
@@ -853,8 +853,8 @@ static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
 }
 
 static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
-				 unsigned int clamp_value)
+enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
+				   unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
 	int bucket_id = UCLAMP_BUCKETS - 1;
@@ -874,7 +874,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
 }
 
 static inline struct uclamp_se
-uclamp_tg_restrict(struct task_struct *p, unsigned int clamp_id)
+uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
@@ -906,7 +906,7 @@ uclamp_tg_restrict(struct task_struct *p, unsigned int clamp_id)
  * - the system default clamp value, defined by the sysadmin
  */
 static inline struct uclamp_se
-uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
+uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
 	struct uclamp_se uc_max = uclamp_default[clamp_id];
@@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
 	return uc_req;
 }
 
-unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
+enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
@@ -942,7 +942,7 @@ unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
  * for each bucket when all its RUNNABLE tasks require the same clamp.
  */
 static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
-				    unsigned int clamp_id)
+				    enum uclamp_id clamp_id)
 {
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
@@ -980,7 +980,7 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
  * enforce the expected state and warn.
  */
 static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
-				    unsigned int clamp_id)
+				    enum uclamp_id clamp_id)
 {
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
@@ -1019,7 +1019,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
@@ -1034,7 +1034,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
@@ -1044,7 +1044,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 }
 
 static inline void
-uclamp_update_active(struct task_struct *p, unsigned int clamp_id)
+uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -1077,9 +1077,9 @@ static inline void
 uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 			   unsigned int clamps)
 {
+	enum uclamp_id clamp_id;
 	struct css_task_iter it;
 	struct task_struct *p;
-	unsigned int clamp_id;
 
 	css_task_iter_start(css, 0, &it);
 	while ((p = css_task_iter_next(&it))) {
@@ -1187,7 +1187,7 @@ static int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	/*
 	 * On scheduling class change, reset to default clamps for tasks
@@ -1224,7 +1224,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 
 static void uclamp_fork(struct task_struct *p)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
@@ -1246,7 +1246,7 @@ static void uclamp_fork(struct task_struct *p)
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 	int cpu;
 
 	mutex_init(&uclamp_mutex);
@@ -6921,7 +6921,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 					    struct task_group *parent)
 {
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-	int clamp_id;
+	enum uclamp_id clamp_id;
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
@@ -7179,7 +7179,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	struct uclamp_se *uc_parent = NULL;
 	struct uclamp_se *uc_se = NULL;
 	unsigned int eff[UCLAMP_CNT];
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 	unsigned int clamps;
 
 	css_for_each_descendant_pre(css, top_css) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b34311..00ff5b5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2281,7 +2281,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id);
+enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
 unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
