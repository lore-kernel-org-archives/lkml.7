Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A635BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13A20659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YhKEr7US"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfFYIhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:37:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfFYIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:37:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8aRrc3532095
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:36:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8aRrc3532095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451788;
        bh=rmFBswgpno9iHjZKzzTqaubK1JLgiNCqDsNJ3THSVfM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YhKEr7USQeaIG64giBF3XkXnHfZ4/AOY7Qpke5q7ceOcIwp+pVureK32+2lEVIoa2
         jFAsonRxWm+HffxymA7R7pjJ/KRlesXeHVyQQ8HEd4RNKSv1tf4T3LQEHuNKTEhNMi
         p6c1V6770CA+P0UWoAwtCSHKqyfLY5y5zekTHolufWKVWqZUkwljxgbGEUAWUERoTV
         IG83IgtTG0ZzXjqKXlNySFnJ6t+NdI1GgkHf5iuFDLUGtTbGhLXbNm3JOGBck4f6TB
         LMSHwA6U+kX+SKMUKoF9qoo10F3C99c5A6oYP1uo3XU/XRV8ZX3hk1Rh+/hKvHSqzw
         X5EpWFEsD2ujg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8aQQl3532092;
        Tue, 25 Jun 2019 01:36:26 -0700
Date:   Tue, 25 Jun 2019 01:36:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-9d20ad7dfc9a5cc64e33d725902d3863d350a66a@git.kernel.org>
Cc:     dietmar.eggemann@arm.com, balsini@android.com,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, mingo@kernel.org, peterz@infradead.org,
        tkjos@google.com, hpa@zytor.com, smuckle@google.com,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        surenb@google.com, patrick.bellasi@arm.com, tglx@linutronix.de,
        quentin.perret@arm.com, torvalds@linux-foundation.org,
        tj@kernel.org, pjt@google.com, morten.rasmussen@arm.com,
        joelaf@google.com
Reply-To: smuckle@google.com, vincent.guittot@linaro.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com, tkjos@google.com,
          rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
          viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
          balsini@android.com, juri.lelli@redhat.com, tglx@linutronix.de,
          surenb@google.com, patrick.bellasi@arm.com,
          morten.rasmussen@arm.com, joelaf@google.com, pjt@google.com,
          torvalds@linux-foundation.org, tj@kernel.org,
          quentin.perret@arm.com
In-Reply-To: <20190621084217.8167-11-patrick.bellasi@arm.com>
References: <20190621084217.8167-11-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Add uclamp_util_with()
Git-Commit-ID: 9d20ad7dfc9a5cc64e33d725902d3863d350a66a
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

Commit-ID:  9d20ad7dfc9a5cc64e33d725902d3863d350a66a
Gitweb:     https://git.kernel.org/tip/9d20ad7dfc9a5cc64e33d725902d3863d350a66a
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:48 +0200

sched/uclamp: Add uclamp_util_with()

So far uclamp_util() allows to clamp a specified utilization considering
the clamp values requested by RUNNABLE tasks in a CPU. For the Energy
Aware Scheduler (EAS) it is interesting to test how clamp values will
change when a task is becoming RUNNABLE on a given CPU.
For example, EAS is interested in comparing the energy impact of
different scheduling decisions and the clamp values can play a role on
that.

Add uclamp_util_with() which allows to clamp a given utilization by
considering the possible impact on CPU clamp values of a specified task.

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
Link: https://lkml.kernel.org/r/20190621084217.8167-11-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 13 +++++++++++++
 kernel/sched/sched.h | 21 ++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6cd5133f0c2a..fa43ce3962e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -880,6 +880,19 @@ uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
 	return uc_req;
 }
 
+unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
+{
+	struct uclamp_se uc_eff;
+
+	/* Task currently refcounted: use back-annotated (effective) value */
+	if (p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].value;
+
+	uc_eff = uclamp_eff_get(p, clamp_id);
+
+	return uc_eff.value;
+}
+
 /*
  * When a task is enqueued on a rq, the clamp bucket currently defined by the
  * task's uclamp::bucket_id is refcounted on that rq. This also immediately
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b0c77a99346..1783f6b4c2e0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2266,11 +2266,20 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id);
+
+static __always_inline
+unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
+			      struct task_struct *p)
 {
 	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
 	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
+	if (p) {
+		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
+		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+	}
+
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
@@ -2281,7 +2290,17 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 
 	return clamp(util, min_util, max_util);
 }
+
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	return uclamp_util_with(rq, util, NULL);
+}
 #else /* CONFIG_UCLAMP_TASK */
+static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
+					    struct task_struct *p)
+{
+	return util;
+}
 static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 {
 	return util;
