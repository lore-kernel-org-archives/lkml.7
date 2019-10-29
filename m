Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDEECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA96208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfJ2Jw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47825 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbfJ2Jwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAu-0004Sp-W6; Tue, 29 Oct 2019 10:52:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C157F1C04D7;
        Tue, 29 Oct 2019 10:52:22 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:22 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Add vtime idle task state
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-3-frederic@kernel.org>
References: <20191016025700.31277-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274247.29376.2147408859881531348.tip-bot2@tip-bot2>
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

Commit-ID:     14faf6fcac4ba33f8fd8d9b2d0278010a9eb1742
Gitweb:        https://git.kernel.org/tip/14faf6fcac4ba33f8fd8d9b2d0278010a9eb1742
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:10 +01:00

sched/cputime: Add vtime idle task state

Record idle as a VTIME state instead of guessing it from VTIME_SYS and
is_idle_task(). This is going to simplify the cputime read side
especially as its state machine is going to further expand in order to
fully support kcpustat on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-3-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  6 ++++--
 kernel/sched/cputime.c | 13 ++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d5d0733..4ae19be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -249,10 +249,12 @@ struct prev_cputime {
 enum vtime_state {
 	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
-	/* Task runs in userspace in a CPU with VTIME active: */
-	VTIME_USER,
+	/* Task is idle */
+	VTIME_IDLE,
 	/* Task runs in kernelspace in a CPU with VTIME active: */
 	VTIME_SYS,
+	/* Task runs in userspace in a CPU with VTIME active: */
+	VTIME_USER,
 };
 
 struct vtime {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 40f5816..2e885e8 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -813,7 +813,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	struct vtime *vtime = &prev->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	if (is_idle_task(prev))
+	if (vtime->state == VTIME_IDLE)
 		vtime_account_idle(prev);
 	else
 		__vtime_account_kernel(prev, vtime);
@@ -824,7 +824,10 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	vtime = &current->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->state = VTIME_SYS;
+	if (is_idle_task(current))
+		vtime->state = VTIME_IDLE;
+	else
+		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
@@ -837,7 +840,7 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 
 	local_irq_save(flags);
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->state = VTIME_SYS;
+	vtime->state = VTIME_IDLE;
 	vtime->starttime = sched_clock();
 	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
@@ -888,8 +891,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		*utime = t->utime;
 		*stime = t->stime;
 
-		/* Task is sleeping, nothing to add */
-		if (vtime->state == VTIME_INACTIVE || is_idle_task(t))
+		/* Task is sleeping or idle, nothing to add */
+		if (vtime->state < VTIME_SYS)
 			continue;
 
 		delta = vtime_delta(vtime);
