Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006DC32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B7B217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfI0IK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:10:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45183 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfI0IKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:10:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKs-0005aa-Dp; Fri, 27 Sep 2019 10:10:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CD1CC1C0440;
        Fri, 27 Sep 2019 10:10:41 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:41 -0000
From:   "tip-bot2 for Qian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix -Wunused-but-set-variable warnings
Cc:     Qian Cai <cai@lca.pw>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Dave Chiluk <chiluk+linux@indeed.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, pauld@redhat.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1566326455-8038-1-git-send-email-cai@lca.pw>
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <156957184180.9866.14215366891982372616.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     763a9ec06c409dcde2a761aac4bb83ff3938e0b3
Gitweb:        https://git.kernel.org/tip/763a9ec06c409dcde2a761aac4bb83ff3938e0b3
Author:        Qian Cai <cai@lca.pw>
AuthorDate:    Tue, 20 Aug 2019 14:40:55 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:31 +02:00

sched/fair: Fix -Wunused-but-set-variable warnings

Commit:

   de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")

introduced a few compilation warnings:

  kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
  kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used [-Wunused-but-set-variable]
  kernel/sched/fair.c: In function 'start_cfs_bandwidth':
  kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used [-Wunused-but-set-variable]

Also, __refill_cfs_bandwidth_runtime() does no longer update the
expiration time, so fix the comments accordingly.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: pauld@redhat.com
Fixes: de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")
Link: https://lkml.kernel.org/r/1566326455-8038-1-git-send-email-cai@lca.pw
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5bc2399..dfdac90 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4353,21 +4353,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 }
 
 /*
- * Replenish runtime according to assigned quota and update expiration time.
- * We use sched_clock_cpu directly instead of rq->clock to avoid adding
- * additional synchronization around rq->lock.
+ * Replenish runtime according to assigned quota. We use sched_clock_cpu
+ * directly instead of rq->clock to avoid adding additional synchronization
+ * around rq->lock.
  *
  * requires cfs_b->lock
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	u64 now;
-
-	if (cfs_b->quota == RUNTIME_INF)
-		return;
-
-	now = sched_clock_cpu(smp_processor_id());
-	cfs_b->runtime = cfs_b->quota;
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_b->runtime = cfs_b->quota;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4983,15 +4978,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
-	u64 overrun;
-
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
