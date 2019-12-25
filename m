Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C281C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B502077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLYKjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40613 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfLYKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44C-000893-M6; Wed, 25 Dec 2019 11:39:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D0231C2B1E;
        Wed, 25 Dec 2019 11:39:00 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:00 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make task_fits_capacity() consider
 uclamp restrictions
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211113851.24241-5-valentin.schneider@arm.com>
References: <20191211113851.24241-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157727034019.30329.4519699507798726125.tip-bot2@tip-bot2>
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

Commit-ID:     a7008c07a568278ed2763436404752a98004c7ff
Gitweb:        https://git.kernel.org/tip/a7008c07a568278ed2763436404752a98004c7ff
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 11 Dec 2019 11:38:50 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:09 +01:00

sched/fair: Make task_fits_capacity() consider uclamp restrictions

task_fits_capacity() drives CPU selection at wakeup time, and is also used
to detect misfit tasks. Right now it does so by comparing task_util_est()
with a CPU's capacity, but doesn't take into account uclamp restrictions.

There's a few interesting uses that can come out of doing this. For
instance, a low uclamp.max value could prevent certain tasks from being
flagged as misfit tasks, so they could merrily remain on low-capacity CPUs.
Similarly, a high uclamp.min value would steer tasks towards high capacity
CPUs at wakeup (and, should that fail, later steered via misfit balancing),
so such "boosted" tasks would favor CPUs of higher capacity.

Introduce uclamp_task_util() and make task_fits_capacity() use it.

Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191211113851.24241-5-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f34fa9..26c59bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3711,6 +3711,20 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline unsigned long uclamp_task_util(struct task_struct *p)
+{
+	return clamp(task_util_est(p),
+		     uclamp_eff_value(p, UCLAMP_MIN),
+		     uclamp_eff_value(p, UCLAMP_MAX));
+}
+#else
+static inline unsigned long uclamp_task_util(struct task_struct *p)
+{
+	return task_util_est(p);
+}
+#endif
+
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -3822,7 +3836,7 @@ done:
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
 {
-	return fits_capacity(task_util_est(p), capacity);
+	return fits_capacity(uclamp_task_util(p), capacity);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
