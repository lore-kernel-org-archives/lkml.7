Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C92C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE4217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfICIc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:32:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfICIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dn-0002gL-Kl; Tue, 03 Sep 2019 10:31:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 370651C0772;
        Tue,  3 Sep 2019 10:31:27 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:27 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Use TG's clamps to restrict TASK's clamps
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
In-Reply-To: <20190822132811.31294-5-patrick.bellasi@arm.com>
References: <20190822132811.31294-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Message-ID: <156749948707.12887.5752456843363605543.tip-bot2@tip-bot2>
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

Commit-ID:     3eac870a324728e5d17118888840dad70bcd37f3
Gitweb:        https://git.kernel.org/tip/3eac870a324728e5d17118888840dad70bcd37f3
Author:        Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate:    Thu, 22 Aug 2019 14:28:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:39 +02:00

sched/uclamp: Use TG's clamps to restrict TASK's clamps

When a task specific clamp value is configured via sched_setattr(2), this
value is accounted in the corresponding clamp bucket every time the task is
{en,de}qeued. However, when cgroups are also in use, the task specific
clamp values could be restricted by the task_group (TG) clamp values.

Update uclamp_cpu_inc() to aggregate task and TG clamp values. Every time a
task is enqueued, it's accounted in the clamp bucket tracking the smaller
clamp between the task specific value and its TG effective value. This
allows to:

1. ensure cgroup clamps are always used to restrict task specific requests,
   i.e. boosted not more than its TG effective protection and capped at
   least as its TG effective limit.

2. implement a "nice-like" policy, where tasks are still allowed to request
   less than what enforced by their TG effective limits and protections

Do this by exploiting the concept of "effective" clamp, which is already
used by a TG to track parent enforced restrictions.

Apply task group clamp restrictions only to tasks belonging to a child
group. While, for tasks in the root group or in an autogroup, system
defaults are still enforced.

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
Link: https://lkml.kernel.org/r/20190822132811.31294-5-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e6800fe..c32ac07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -873,16 +873,42 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+static inline struct uclamp_se
+uclamp_tg_restrict(struct task_struct *p, unsigned int clamp_id)
+{
+	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	struct uclamp_se uc_max;
+
+	/*
+	 * Tasks in autogroups or root task group will be
+	 * restricted by system defaults.
+	 */
+	if (task_group_is_autogroup(task_group(p)))
+		return uc_req;
+	if (task_group(p) == &root_task_group)
+		return uc_req;
+
+	uc_max = task_group(p)->uclamp[clamp_id];
+	if (uc_req.value > uc_max.value || !uc_req.user_defined)
+		return uc_max;
+#endif
+
+	return uc_req;
+}
+
 /*
  * The effective clamp bucket index of a task depends on, by increasing
  * priority:
  * - the task specific clamp value, when explicitly requested from userspace
+ * - the task group effective clamp value, for tasks not either in the root
+ *   group or in an autogroup
  * - the system default clamp value, defined by the sysadmin
  */
 static inline struct uclamp_se
 uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
 {
-	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
 	struct uclamp_se uc_max = uclamp_default[clamp_id];
 
 	/* System default restrictions always apply */
