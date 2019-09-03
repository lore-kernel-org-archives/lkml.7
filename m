Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263CEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BE12053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfICIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59206 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfICIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dm-0002fV-KI; Tue, 03 Sep 2019 10:31:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 196221C0772;
        Tue,  3 Sep 2019 10:31:26 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:25 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Propagate parent clamps
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
In-Reply-To: <20190822132811.31294-3-patrick.bellasi@arm.com>
References: <20190822132811.31294-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Message-ID: <156749948592.12881.9832071454008370865.tip-bot2@tip-bot2>
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

Commit-ID:     0b60ba2dd342016e4e717dbaa4ca9af3a43f4434
Gitweb:        https://git.kernel.org/tip/0b60ba2dd342016e4e717dbaa4ca9af3a43f4434
Author:        Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate:    Thu, 22 Aug 2019 14:28:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:38 +02:00

sched/uclamp: Propagate parent clamps

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are locally consistent and constrained based on parent's
assigned resources. This requires to properly propagate and aggregate
parent attributes down to its descendants.

Implement this mechanism by adding a new "effective" clamp value for each
task group. The effective clamp value is defined as the smaller value
between the clamp value of a group and the effective clamp value of its
parent. This is the actual clamp value enforced on tasks in a task group.

Since it's possible for a cpu.uclamp.min value to be bigger than the
cpu.uclamp.max value, ensure local consistency by restricting each
"protection" (i.e. min utilization) with the corresponding "limit"
(i.e. max utilization).

Do that at effective clamps propagation to ensure all user-space write
never fails while still always tracking the most restrictive values.

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
Link: https://lkml.kernel.org/r/20190822132811.31294-3-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 44 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  2 ++-
 2 files changed, 46 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c186abe..8855481 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1166,6 +1166,7 @@ static void __init init_uclamp(void)
 		uclamp_default[clamp_id] = uc_max;
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		root_task_group.uclamp_req[clamp_id] = uc_max;
+		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
 }
@@ -6824,6 +6825,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
 			      uclamp_none(clamp_id), false);
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
 	}
 #endif
 }
@@ -7070,6 +7072,45 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_parent = NULL;
+	struct uclamp_se *uc_se = NULL;
+	unsigned int eff[UCLAMP_CNT];
+	unsigned int clamp_id;
+	unsigned int clamps;
+
+	css_for_each_descendant_pre(css, top_css) {
+		uc_parent = css_tg(css)->parent
+			? css_tg(css)->parent->uclamp : NULL;
+
+		for_each_clamp_id(clamp_id) {
+			/* Assume effective clamps matches requested clamps */
+			eff[clamp_id] = css_tg(css)->uclamp_req[clamp_id].value;
+			/* Cap effective clamps with parent's effective clamps */
+			if (uc_parent &&
+			    eff[clamp_id] > uc_parent[clamp_id].value) {
+				eff[clamp_id] = uc_parent[clamp_id].value;
+			}
+		}
+		/* Ensure protection is always capped by limit */
+		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
+
+		/* Propagate most restrictive effective clamps */
+		clamps = 0x0;
+		uc_se = css_tg(css)->uclamp;
+		for_each_clamp_id(clamp_id) {
+			if (eff[clamp_id] == uc_se[clamp_id].value)
+				continue;
+			uc_se[clamp_id].value = eff[clamp_id];
+			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
+			clamps |= (0x1 << clamp_id);
+		}
+		if (!clamps)
+			css = css_rightmost_descendant(css);
+	}
+}
 
 /*
  * Integer 10^N with a given N exponent by casting to integer the literal "1eN"
@@ -7138,6 +7179,9 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	 */
 	tg->uclamp_pct[clamp_id] = req.percent;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of));
+
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ae1be61..5b34311 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -397,6 +397,8 @@ struct task_group {
 	unsigned int		uclamp_pct[UCLAMP_CNT];
 	/* Clamp values requested for a task group */
 	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a task group */
+	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
 };
