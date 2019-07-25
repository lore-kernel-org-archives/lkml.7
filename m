Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93065218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jC+t14ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbfGYQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:19:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbfGYQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:19:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGJ2ZM1075755
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:19:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGJ2ZM1075755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071543;
        bh=PCGBS68QWBzGeNkONybLIbURoOoUu0zUOLvVOWcxqYE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jC+t14uaWgKVOY/MzPU/p7OIsCoAT+r2Ofw/OkEWdoSYY9+2n3ECn2lY+nV9IEwyX
         85yI6BcBjIL6TYEJ7jdw7VA5mc48CXSp7QsIPbDrU8/a1kHMq+SmDfc1xFSkhz/lR0
         XRFdN0iUBrYzd+dJnQlIpvb/20CFI2QMFD9SnIsjAVzd0C9k6tPik56nQxjjL4z6rf
         Z5nDfcBKUuuo555UOFWcjuEu5mPK/pY6IvvKiNYakqHUeRIsxlFaSmdwPTHFI0nGoF
         Bf2lj/V5BGFOgkITJNPONAmDRQoHKNGz9oYFNjM4sxL5Ibt4OBL3rOhFmB9skEJKL6
         4FAXOGYeKzfYw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGJ0o51075750;
        Thu, 25 Jul 2019 09:19:00 -0700
Date:   Thu, 25 Jul 2019 09:19:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-60e17f5cef838e9ca7946ced208ceddcec6c315d@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        vincent.guittot@linaro.org, tglx@linutronix.de,
        viresh.kumar@linaro.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, vincent.guittot@linaro.org, hpa@zytor.com,
          viresh.kumar@linaro.org, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Introduce fits_capacity()
Git-Commit-ID: 60e17f5cef838e9ca7946ced208ceddcec6c315d
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

Commit-ID:  60e17f5cef838e9ca7946ced208ceddcec6c315d
Gitweb:     https://git.kernel.org/tip/60e17f5cef838e9ca7946ced208ceddcec6c315d
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Tue, 4 Jun 2019 12:31:52 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:56 +0200

sched/fair: Introduce fits_capacity()

The same formula to check utilization against capacity (after
considering capacity_margin) is already used at 5 different locations.

This patch creates a new macro, fits_capacity(), which can be used from
all these locations without exposing the details of it and hence
simplify code.

All the 5 code locations are updated as well to use it..

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52564e050062..fb75c0bea80f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -96,12 +96,12 @@ int __weak arch_asym_cpu_priority(int cpu)
 }
 
 /*
- * The margin used when comparing utilization with CPU capacity:
- * util * margin < capacity * 1024
+ * The margin used when comparing utilization with CPU capacity.
  *
  * (default: ~20%)
  */
-static unsigned int capacity_margin			= 1280;
+#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -3808,7 +3808,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
 {
-	return capacity * 1024 > task_util_est(p) * capacity_margin;
+	return fits_capacity(task_util_est(p), capacity);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -5235,7 +5235,7 @@ static inline unsigned long cpu_util(int cpu);
 
 static inline bool cpu_overutilized(int cpu)
 {
-	return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
+	return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -6456,7 +6456,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			/* Skip CPUs that will be overutilized. */
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
-			if (cpu_cap * 1024 < util * capacity_margin)
+			if (!fits_capacity(util, cpu_cap))
 				continue;
 
 			/* Always use prev_cpu as a candidate. */
@@ -8011,8 +8011,7 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return sg->sgc->min_capacity * capacity_margin <
-						ref->sgc->min_capacity * 1024;
+	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
 }
 
 /*
@@ -8022,8 +8021,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 static inline bool
 group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return sg->sgc->max_capacity * capacity_margin <
-						ref->sgc->max_capacity * 1024;
+	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
 }
 
 static inline enum
