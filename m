Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13655C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DC52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfLYKjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfLYKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44D-00089E-3f; Wed, 25 Dec 2019 11:39:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C864F1C2B24;
        Wed, 25 Dec 2019 11:39:00 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:00 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Make uclamp util helpers use and
 return UL values
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211113851.24241-3-valentin.schneider@arm.com>
References: <20191211113851.24241-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157727034066.30329.2864192311719058609.tip-bot2@tip-bot2>
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

Commit-ID:     686516b55e98edf18c2a02d36aaaa6f4c0f6c39c
Gitweb:        https://git.kernel.org/tip/686516b55e98edf18c2a02d36aaaa6f4c0f6c39c
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 11 Dec 2019 11:38:48 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:08 +01:00

sched/uclamp: Make uclamp util helpers use and return UL values

Vincent pointed out recently that the canonical type for utilization
values is 'unsigned long'. Internally uclamp uses 'unsigned int' values for
cache optimization, but this doesn't have to be exported to its users.

Make the uclamp helpers that deal with utilization use and return unsigned
long values.

Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191211113851.24241-3-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  |  6 +++---
 kernel/sched/sched.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f6c094..e7b08d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -919,17 +919,17 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
 	/* Task currently refcounted: use back-annotated (effective) value */
 	if (p->uclamp[clamp_id].active)
-		return p->uclamp[clamp_id].value;
+		return (unsigned long)p->uclamp[clamp_id].value;
 
 	uc_eff = uclamp_eff_get(p, clamp_id);
 
-	return uc_eff.value;
+	return (unsigned long)uc_eff.value;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d9b2451..b478474 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,14 +2300,14 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
-unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-			      struct task_struct *p)
+unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
+			       struct task_struct *p)
 {
-	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
-	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
+	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
 	if (p) {
 		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
@@ -2325,8 +2325,8 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 	return clamp(util, min_util, max_util);
 }
 #else /* CONFIG_UCLAMP_TASK */
-static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-					    struct task_struct *p)
+static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
+					     struct task_struct *p)
 {
 	return util;
 }
