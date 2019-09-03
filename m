Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB73C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FD12053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfICIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfICIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Do-0002iq-At; Tue, 03 Sep 2019 10:31:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D04A91C0DDE;
        Tue,  3 Sep 2019 10:31:27 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:27 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Update CPU's refcount on TG's clamp changes
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
In-Reply-To: <20190822132811.31294-6-patrick.bellasi@arm.com>
References: <20190822132811.31294-6-patrick.bellasi@arm.com>
MIME-Version: 1.0
Message-ID: <156749948767.12894.5150732137197774157.tip-bot2@tip-bot2>
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

Commit-ID:     babbe170e053c6ec2343751749995b7b9fd5fd2c
Gitweb:        https://git.kernel.org/tip/babbe170e053c6ec2343751749995b7b9fd5fd2c
Author:        Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate:    Thu, 22 Aug 2019 14:28:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:40 +02:00

sched/uclamp: Update CPU's refcount on TG's clamp changes

On updates of task group (TG) clamp values, ensure that these new values
are enforced on all RUNNABLE tasks of the task group, i.e. all RUNNABLE
tasks are immediately boosted and/or capped as requested.

Do that each time we update effective clamps from cpu_util_update_eff().
Use the *cgroup_subsys_state (css) to walk the list of tasks in each
affected TG and update their RUNNABLE tasks.
Update each task by using the same mechanism used for cpu affinity masks
updates, i.e. by taking the rq lock.

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
Link: https://lkml.kernel.org/r/20190822132811.31294-6-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 55 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c32ac07..55a1c07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1043,6 +1043,54 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+static inline void
+uclamp_update_active(struct task_struct *p, unsigned int clamp_id)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the task and the rq where the task is (or was) queued.
+	 *
+	 * We might lock the (previous) rq of a !RUNNABLE task, but that's the
+	 * price to pay to safely serialize util_{min,max} updates with
+	 * enqueues, dequeues and migration operations.
+	 * This is the same locking schema used by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * Setting the clamp bucket is serialized by task_rq_lock().
+	 * If the task is not yet RUNNABLE and its task_struct is not
+	 * affecting a valid clamp bucket, the next time it's enqueued,
+	 * it will already see the updated clamp bucket value.
+	 */
+	if (!p->uclamp[clamp_id].active) {
+		uclamp_rq_dec_id(rq, p, clamp_id);
+		uclamp_rq_inc_id(rq, p, clamp_id);
+	}
+
+	task_rq_unlock(rq, p, &rf);
+}
+
+static inline void
+uclamp_update_active_tasks(struct cgroup_subsys_state *css,
+			   unsigned int clamps)
+{
+	struct css_task_iter it;
+	struct task_struct *p;
+	unsigned int clamp_id;
+
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it))) {
+		for_each_clamp_id(clamp_id) {
+			if ((0x1 << clamp_id) & clamps)
+				uclamp_update_active(p, clamp_id);
+		}
+	}
+	css_task_iter_end(&it);
+}
+
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 static void uclamp_update_root_tg(void)
@@ -7160,8 +7208,13 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
 			clamps |= (0x1 << clamp_id);
 		}
-		if (!clamps)
+		if (!clamps) {
 			css = css_rightmost_descendant(css);
+			continue;
+		}
+
+		/* Immediately update descendants RUNNABLE tasks */
+		uclamp_update_active_tasks(css, clamps);
 	}
 }
 
