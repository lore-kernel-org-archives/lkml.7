Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19441C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92AE227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLYKjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLYKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44C-000899-U4; Wed, 25 Dec 2019 11:39:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89E101C2BA8;
        Wed, 25 Dec 2019 11:39:00 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:00 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Rename uclamp_util_with() into
 uclamp_rq_util_with()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211113851.24241-4-valentin.schneider@arm.com>
References: <20191211113851.24241-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157727034043.30329.5395594787992535523.tip-bot2@tip-bot2>
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

Commit-ID:     d2b58a286e89824900d501db0be1d4f6aed474fc
Gitweb:        https://git.kernel.org/tip/d2b58a286e89824900d501db0be1d4f6aed474fc
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 11 Dec 2019 11:38:49 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:08 +01:00

sched/uclamp: Rename uclamp_util_with() into uclamp_rq_util_with()

The current helper returns (CPU) rq utilization with uclamp restrictions
taken into account. A uclamp task utilization helper would be quite
helpful, but this requires some renaming.

Prepare the code for the introduction of a uclamp_task_util() by renaming
the existing uclamp_util_with() to uclamp_rq_util_with().

Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191211113851.24241-4-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             |  9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9b8916f..7fbaee2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -238,7 +238,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	 */
 	util = util_cfs + cpu_util_rt(rq);
 	if (type == FREQUENCY_UTIL)
-		util = uclamp_util_with(rq, util, p);
+		util = uclamp_rq_util_with(rq, util, p);
 
 	dl_util = cpu_util_dl(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b478474..1a88dc8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2303,8 +2303,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
-unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
-			       struct task_struct *p)
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
 {
 	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
 	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
@@ -2325,8 +2325,9 @@ unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
 	return clamp(util, min_util, max_util);
 }
 #else /* CONFIG_UCLAMP_TASK */
-static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
-					     struct task_struct *p)
+static inline
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
 {
 	return util;
 }
