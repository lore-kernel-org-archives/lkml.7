Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894DCC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51996214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Tz572m1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfFYIgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:36:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFYIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:36:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8ZiM93531767
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:35:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8ZiM93531767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451745;
        bh=tk+zbFpCCUsWl252gJZzUY5QBmDU1J/H0E9e8GNrAtk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Tz572m1uPuZeqTOS5mQmfRrJadzp5RmlOjTc+5CVUwZrfEpXo4vBSH9hoSKu6ljxJ
         z1rYi0BFea4Q2JZOfwZSGtvlK0JdHZbYUaY4AXShFpF94NdoyyNCDkAKYwFIVoizeS
         ssYsvn5wI6pFopAgovY8wuTsbyYdbO17NuwSj5yiEQMuwAN2/MISjZdguZvGLZmO8O
         YOfHCJfUmz9L0BWu5oweOGHiiUNp4/Ua3OyVdhX6Yukeo2crEjU6r3Jh3xW6lCHpKH
         vmsXLlLaB6oJuB3SpoALx8lyqL8Nd63ydSYCmTHd+Kt5x9WQ3uCYripwxPLVdoZQl1
         HbCsiXOgpT7rQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8ZhlA3531764;
        Tue, 25 Jun 2019 01:35:43 -0700
Date:   Tue, 25 Jun 2019 01:35:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-982d9cdc22c9f6df5ad790caa229ff74fb1d95e7@git.kernel.org>
Cc:     morten.rasmussen@arm.com, torvalds@linux-foundation.org,
        joelaf@google.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, rafael.j.wysocki@intel.com,
        peterz@infradead.org, hpa@zytor.com, surenb@google.com,
        balsini@android.com, tj@kernel.org, tkjos@google.com,
        smuckle@google.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        viresh.kumar@linaro.org, pjt@google.com, tglx@linutronix.de,
        quentin.perret@arm.com, juri.lelli@redhat.com
Reply-To: peterz@infradead.org, rafael.j.wysocki@intel.com,
          balsini@android.com, surenb@google.com, hpa@zytor.com,
          smuckle@google.com, tkjos@google.com, tj@kernel.org,
          morten.rasmussen@arm.com, joelaf@google.com,
          torvalds@linux-foundation.org, patrick.bellasi@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, pjt@google.com,
          juri.lelli@redhat.com, quentin.perret@arm.com,
          vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
          mingo@kernel.org, viresh.kumar@linaro.org
In-Reply-To: <20190621084217.8167-10-patrick.bellasi@arm.com>
References: <20190621084217.8167-10-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq, sched/uclamp: Add clamps for FAIR
 and RT tasks
Git-Commit-ID: 982d9cdc22c9f6df5ad790caa229ff74fb1d95e7
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

Commit-ID:  982d9cdc22c9f6df5ad790caa229ff74fb1d95e7
Gitweb:     https://git.kernel.org/tip/982d9cdc22c9f6df5ad790caa229ff74fb1d95e7
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:48 +0200

sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks

Each time a frequency update is required via schedutil, a frequency is
selected to (possibly) satisfy the utilization reported by each
scheduling class and irqs. However, when utilization clamping is in use,
the frequency selection should consider userspace utilization clamping
hints.  This will allow, for example, to:

 - boost tasks which are directly affecting the user experience
   by running them at least at a minimum "requested" frequency

 - cap low priority tasks not directly affecting the user experience
   by running them only up to a maximum "allowed" frequency

These constraints are meant to support a per-task based tuning of the
frequency selection thus supporting a fine grained definition of
performance boosting vs energy saving strategies in kernel space.

Add support to clamp the utilization of RUNNABLE FAIR and RT tasks
within the boundaries defined by their aggregated utilization clamp
constraints.

Do that by considering the max(min_util, max_util) to give boosted tasks
the performance they need even when they happen to be co-scheduled with
other capped tasks.

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
Link: https://lkml.kernel.org/r/20190621084217.8167-10-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
 kernel/sched/fair.c              |  4 ++++
 kernel/sched/rt.c                |  4 ++++
 kernel/sched/sched.h             | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7c4ce69067c4..d84e036a7536 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -202,8 +202,10 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
 
-	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
+	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
 		return max;
+	}
 
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
@@ -219,9 +221,16 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 * CFS tasks and we use the same metric to track the effective
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
 	 */
-	util = util_cfs;
-	util += cpu_util_rt(rq);
+	util = util_cfs + cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_util(rq, util);
 
 	dl_util = cpu_util_dl(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bdcd3c718bc..28db7ce5c3a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10393,6 +10393,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	.task_change_group	= task_change_group_fair,
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 63ad7c90822c..a532558a5176 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2400,6 +2400,10 @@ const struct sched_class rt_sched_class = {
 	.switched_to		= switched_to_rt,
 
 	.update_curr		= update_curr_rt,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0d2ba8bb2cb3..9b0c77a99346 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2265,6 +2265,29 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
+	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+
+	/*
+	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
+	 * RUNNABLE tasks with _different_ clamps, we can end up with an
+	 * inversion. Fix it now when the clamps are applied.
+	 */
+	if (unlikely(min_util >= max_util))
+		return min_util;
+
+	return clamp(util, min_util, max_util);
+}
+#else /* CONFIG_UCLAMP_TASK */
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	return util;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
 #  define arch_scale_freq_invariant()	true
