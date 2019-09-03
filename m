Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16948C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E170C2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfICIbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfICIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dn-0002gC-4r; Tue, 03 Sep 2019 10:31:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A60BC1C0DDE;
        Tue,  3 Sep 2019 10:31:26 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:26 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Propagate system defaults to the root group
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
In-Reply-To: <20190822132811.31294-4-patrick.bellasi@arm.com>
References: <20190822132811.31294-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Message-ID: <156749948653.12884.4026456408630677258.tip-bot2@tip-bot2>
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

Commit-ID:     7274a5c1bbec45f06f1fff4b8c8b5855b6cc189d
Gitweb:        https://git.kernel.org/tip/7274a5c1bbec45f06f1fff4b8c8b5855b6cc189d
Author:        Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate:    Thu, 22 Aug 2019 14:28:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:38 +02:00

sched/uclamp: Propagate system defaults to the root group

The clamp values are not tunable at the level of the root task group.
That's for two main reasons:

 - the root group represents "system resources" which are always
   entirely available from the cgroup standpoint.

 - when tuning/restricting "system resources" makes sense, tuning must
   be done using a system wide API which should also be available when
   control groups are not.

When a system wide restriction is available, cgroups should be aware of
its value in order to know exactly how much "system resources" are
available for the subgroups.

Utilization clamping supports already the concepts of:

 - system defaults: which define the maximum possible clamp values
   usable by tasks.

 - effective clamps: which allows a parent cgroup to constraint (maybe
   temporarily) its descendants without losing the information related
   to the values "requested" from them.

Exploit these two concepts and bind them together in such a way that,
whenever system default are tuned, the new values are propagated to
(possibly) restrict or relax the "effective" value of nested cgroups.

When cgroups are in use, force an update of all the RUNNABLE tasks.
Otherwise, keep things simple and do just a lazy update next time each
task will be enqueued.
Do that since we assume a more strict resource control is required when
cgroups are in use. This allows also to keep "effective" clamp values
updated in case we need to expose them to user-space.

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
Link: https://lkml.kernel.org/r/20190822132811.31294-4-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8855481..e6800fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1017,10 +1017,30 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css);
+static void uclamp_update_root_tg(void)
+{
+	struct task_group *tg = &root_task_group;
+
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN],
+		      sysctl_sched_uclamp_util_min, false);
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
+		      sysctl_sched_uclamp_util_max, false);
+
+	rcu_read_lock();
+	cpu_util_update_eff(&root_task_group.css);
+	rcu_read_unlock();
+}
+#else
+static void uclamp_update_root_tg(void) { }
+#endif
+
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
+	bool update_root_tg = false;
 	int old_min, old_max;
 	int result;
 
@@ -1043,16 +1063,23 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
 			      sysctl_sched_uclamp_util_min, false);
+		update_root_tg = true;
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
 			      sysctl_sched_uclamp_util_max, false);
+		update_root_tg = true;
 	}
 
+	if (update_root_tg)
+		uclamp_update_root_tg();
+
 	/*
-	 * Updating all the RUNNABLE task is expensive, keep it simple and do
-	 * just a lazy update at each next enqueue time.
+	 * We update all RUNNABLE tasks only when task groups are in use.
+	 * Otherwise, keep it simple and do just a lazy update at each next
+	 * task enqueue time.
 	 */
+
 	goto done;
 
 undo:
