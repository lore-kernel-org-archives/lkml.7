Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEA5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B70B22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfH1KS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfH1KQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v00-0000B9-O0; Wed, 28 Aug 2019 12:16:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F2EA1C0DE2;
        Wed, 28 Aug 2019 12:16:20 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Provide quick sample function for itimer
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.599658199@linutronix.de>
References: <20190821192919.599658199@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738032.5696.14317928842926407933.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     19298fbf453c90a6cf72288155f80c6f55e9139d
Gitweb:        https://git.kernel.org/tip/19298fbf453c90a6cf72288155f80c6f55e9139d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:26 +02:00

posix-cpu-timers: Provide quick sample function for itimer

get_itimer() needs a sample of the current thread group cputime. It invokes
thread_group_cputimer() - which is a misnomer. That function also starts
eventually the group cputime accouting which is bogus because the
accounting is already active when a timer is armed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192919.599658199@linutronix.de

---
 include/linux/sched/cputime.h  |  2 +-
 kernel/time/posix-cpu-timers.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 53f883f..6de7b38 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -62,7 +62,7 @@ extern void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
 void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times);
-
+void thread_group_sample_cputime(struct task_struct *tsk, struct task_cputime *times);
 
 /*
  * The following are functions that support scheduler-internal time accounting.
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 4426a0f..c22b6b6 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -232,6 +232,27 @@ static inline void sample_cputime_atomic(struct task_cputime *times,
 	times->sum_exec_runtime = atomic64_read(&atomic_times->sum_exec_runtime);
 }
 
+/**
+ * thread_group_sample_cputime - Sample cputime for a given task
+ * @tsk:	Task for which cputime needs to be started
+ * @iimes:	Storage for time samples
+ *
+ * Called from sys_getitimer() to calculate the expiry time of an active
+ * timer. That means group cputime accounting is already active. Called
+ * with task sighand lock held.
+ *
+ * Updates @times with an uptodate sample of the thread group cputimes.
+ */
+void thread_group_sample_cputime(struct task_struct *tsk,
+				struct task_cputime *times)
+{
+	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+
+	WARN_ON_ONCE(!cputimer->running);
+
+	sample_cputime_atomic(times, &cputimer->cputime_atomic);
+}
+
 void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
