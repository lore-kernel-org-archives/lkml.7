Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293F0217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfH1KSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1KQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v02-0000CI-43; Wed, 28 Aug 2019 12:16:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF1B31C07D2;
        Wed, 28 Aug 2019 12:16:21 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:21 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Rename thread_group_cputimer()
 and make it static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.869350319@linutronix.de>
References: <20190821192919.869350319@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738168.5705.3770894138948288106.tip-bot2@tip-bot2>
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

Commit-ID:     c506bef424ca282f2ad357e86fee940c69018974
Gitweb:        https://git.kernel.org/tip/c506bef424ca282f2ad357e86fee940c69018974
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:27 +02:00

posix-cpu-timers: Rename thread_group_cputimer() and make it static

thread_group_cputimer() is a complete misnomer. The function does two things:

 - For arming process wide timers it makes sure that the atomic time
   storage is up to date. If no cpu timer is armed yet, then the atomic
   time storage is not updated by the scheduler for performance reasons.

   In that case a full summing up of all threads needs to be done and the
   update needs to be enabled.

- Samples the current time into the caller supplied storage.

Rename it to thread_group_start_cputime(), make it static and fixup the
callsite.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192919.869350319@linutronix.de

---
 include/linux/sched/cputime.h  |  1 -
 kernel/time/posix-cpu-timers.c | 17 +++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 6de7b38..2638fd0 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -61,7 +61,6 @@ extern void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
  * Thread group CPU time accounting.
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
-void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times);
 void thread_group_sample_cputime(struct task_struct *tsk, struct task_cputime *times);
 
 /*
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cb73678..def225a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -253,7 +253,20 @@ void thread_group_sample_cputime(struct task_struct *tsk,
 	sample_cputime_atomic(times, &cputimer->cputime_atomic);
 }
 
-void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times)
+/**
+ * thread_group_start_cputime - Start cputime and return a sample
+ * @tsk:	Task for which cputime needs to be started
+ * @iimes:	Storage for time samples
+ *
+ * The thread group cputime accouting is avoided when there are no posix
+ * CPU timers armed. Before starting a timer it's required to check whether
+ * the time accounting is active. If not, a full update of the atomic
+ * accounting store needs to be done and the accounting enabled.
+ *
+ * Updates @times with an uptodate sample of the thread group cputimes.
+ */
+static void
+thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 	struct task_cputime sum;
@@ -536,7 +549,7 @@ static int cpu_timer_sample_group(const clockid_t which_clock,
 {
 	struct task_cputime cputime;
 
-	thread_group_cputimer(p, &cputime);
+	thread_group_start_cputime(p, &cputime);
 	switch (CPUCLOCK_WHICH(which_clock)) {
 	default:
 		return -EINVAL;
