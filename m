Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614EA208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfJ2Jw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47820 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfJ2Jwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAt-0004SV-SQ; Tue, 29 Oct 2019 10:52:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6062E1C047B;
        Tue, 29 Oct 2019 10:52:22 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:22 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Add vtime guest task state
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
In-Reply-To: <20191016025700.31277-4-frederic@kernel.org>
References: <20191016025700.31277-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274212.29376.10288322559842657116.tip-bot2@tip-bot2>
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

Commit-ID:     e6d5bf3e321ca664d12eb00ceb40bd58987ce8a1
Gitweb:        https://git.kernel.org/tip/e6d5bf3e321ca664d12eb00ceb40bd58987ce8a1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:11 +01:00

sched/cputime: Add vtime guest task state

Record guest as a VTIME state instead of guessing it from VTIME_SYS and
PF_VCPU. This is going to simplify the cputime read side especially as
its state machine is going to further expand in order to fully support
kcpustat on nohz_full.

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
Link: https://lkml.kernel.org/r/20191016025700.31277-4-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  2 ++
 kernel/sched/cputime.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4ae19be..988c4da 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -255,6 +255,8 @@ enum vtime_state {
 	VTIME_SYS,
 	/* Task runs in userspace in a CPU with VTIME active: */
 	VTIME_USER,
+	/* Task runs as guests in a CPU with VTIME active: */
+	VTIME_GUEST,
 };
 
 struct vtime {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2e885e8..34086af 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -733,7 +733,7 @@ static void __vtime_account_kernel(struct task_struct *tsk,
 				   struct vtime *vtime)
 {
 	/* We might have scheduled out from guest path */
-	if (tsk->flags & PF_VCPU)
+	if (vtime->state == VTIME_GUEST)
 		vtime_account_guest(tsk, vtime);
 	else
 		vtime_account_system(tsk, vtime);
@@ -788,6 +788,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_system(tsk, vtime);
 	tsk->flags |= PF_VCPU;
+	vtime->state = VTIME_GUEST;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
@@ -799,6 +800,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_guest(tsk, vtime);
 	tsk->flags &= ~PF_VCPU;
+	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
@@ -826,6 +828,8 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	write_seqcount_begin(&vtime->seqcount);
 	if (is_idle_task(current))
 		vtime->state = VTIME_IDLE;
+	else if (current->flags & PF_VCPU)
+		vtime->state = VTIME_GUEST;
 	else
 		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
@@ -860,7 +864,7 @@ u64 task_gtime(struct task_struct *t)
 		seq = read_seqcount_begin(&vtime->seqcount);
 
 		gtime = t->gtime;
-		if (vtime->state == VTIME_SYS && t->flags & PF_VCPU)
+		if (vtime->state == VTIME_GUEST)
 			gtime += vtime->gtime + vtime_delta(vtime);
 
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
@@ -898,13 +902,13 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		delta = vtime_delta(vtime);
 
 		/*
-		 * Task runs either in user or kernel space, add pending nohz time to
-		 * the right place.
+		 * Task runs either in user (including guest) or kernel space,
+		 * add pending nohz time to the right place.
 		 */
-		if (vtime->state == VTIME_USER || t->flags & PF_VCPU)
-			*utime += vtime->utime + delta;
-		else if (vtime->state == VTIME_SYS)
+		if (vtime->state == VTIME_SYS)
 			*stime += vtime->stime + delta;
+		else
+			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
