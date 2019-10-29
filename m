Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A552FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801DA208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfJ2Jww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47808 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJ2Jwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAr-0004Tt-DL; Tue, 29 Oct 2019 10:52:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 281E41C04DD;
        Tue, 29 Oct 2019 10:52:23 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:22 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Record CPU under seqcount for kcpustat needs
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
In-Reply-To: <20191016025700.31277-2-frederic@kernel.org>
References: <20191016025700.31277-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274286.29376.7269590620212447664.tip-bot2@tip-bot2>
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

Commit-ID:     802f4a827f139f2581b3c50c69d20f8bf4c24af1
Gitweb:        https://git.kernel.org/tip/802f4a827f139f2581b3c50c69d20f8bf4c24af1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:08 +01:00

sched/vtime: Record CPU under seqcount for kcpustat needs

In order to compute the kcpustat delta on a nohz CPU, we'll need to
fetch the task running on that target. Checking that its vtime
state snapshot actually refers to the relevant target involves recording
that CPU under the seqcount locked on task switch.

This is a step toward making kcpustat moving forward on full nohz CPUs.

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
Link: https://lkml.kernel.org/r/20191016025700.31277-2-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  | 1 +
 kernel/sched/cputime.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56b..d5d0733 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -259,6 +259,7 @@ struct vtime {
 	seqcount_t		seqcount;
 	unsigned long long	starttime;
 	enum vtime_state	state;
+	unsigned int		cpu;
 	u64			utime;
 	u64			stime;
 	u64			gtime;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cef23c2..40f5816 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -818,6 +818,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	else
 		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
+	vtime->cpu = -1;
 	write_seqcount_end(&vtime->seqcount);
 
 	vtime = &current->vtime;
@@ -825,6 +826,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
+	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -837,6 +839,7 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
+	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
 	local_irq_restore(flags);
 }
