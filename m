Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96570C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 09:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C18206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 09:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfKQJuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 04:50:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfKQJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 04:50:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iWHBy-0007RY-3X; Sun, 17 Nov 2019 10:50:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 50ECF1C0085;
        Sun, 17 Nov 2019 10:50:01 +0100 (CET)
Date:   Sun, 17 Nov 2019 09:50:01 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix overzealous type replacement
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        patrick.bellasi@matbug.net, qperret@google.com, surenb@google.com,
        tj@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191115103908.27610-1-valentin.schneider@arm.com>
References: <20191115103908.27610-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157398420124.12247.5677680230156384788.tip-bot2@tip-bot2>
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

Commit-ID:     7763baace1b738d65efa46d68326c9406311c6bf
Gitweb:        https://git.kernel.org/tip/7763baace1b738d65efa46d68326c9406311c6bf
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 15 Nov 2019 10:39:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Nov 2019 10:46:05 +01:00

sched/uclamp: Fix overzealous type replacement

Some uclamp helpers had their return type changed from 'unsigned int' to
'enum uclamp_id' by commit

  0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")

but it happens that some do return a value in the [0, SCHED_CAPACITY_SCALE]
range, which should really be unsigned int. The affected helpers are
uclamp_none(), uclamp_rq_max_value() and uclamp_eff_value(). Fix those up.

Note that this doesn't lead to any obj diff using a relatively recent
aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
properly returns an 11 bit value (bits_per(1024)) and doesn't seem to do
anything funny. I'm still marking this as fixing the above commit to be on
the safe side.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: patrick.bellasi@matbug.net
Cc: qperret@google.com
Cc: surenb@google.com
Cc: tj@kernel.org
Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
Link: https://lkml.kernel.org/r/20191115103908.27610-1-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 6 +++---
 kernel/sched/sched.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 513a479..3ceff1c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -810,7 +810,7 @@ static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
 	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
 }
 
-static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
+static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
 		return 0;
@@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 }
 
 static inline
-enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
+unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 				   unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
@@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 05c2827..280a3c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,7 +2300,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
 unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
