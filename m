Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5829BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C86217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfH1KRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfH1KQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0E-0000H2-VR; Wed, 28 Aug 2019 12:16:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F6841C07D2;
        Wed, 28 Aug 2019 12:16:28 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Simplify timer queueing
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.212129449@linutronix.de>
References: <20190821192921.212129449@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738809.5750.8972136364385252748.tip-bot2@tip-bot2>
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

Commit-ID:     3b495b22d04df3220ccae829bf7c5cadb3059ccf
Gitweb:        https://git.kernel.org/tip/3b495b22d04df3220ccae829bf7c5cadb3059ccf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:36 +02:00

posix-cpu-timers: Simplify timer queueing

Now that the expiry cache can be accessed as an array, the per clock
checking can be reduced to just comparing the corresponding array elements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.212129449@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 55 ++++++++++++---------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a38b6d0..b132417 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -456,20 +456,20 @@ static inline int expires_gt(u64 expires, u64 new_exp)
  */
 static void arm_timer(struct k_itimer *timer)
 {
+	struct cpu_timer_list *const nt = &timer->it.cpu;
+	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+	u64 *cpuexp, newexp = timer->it.cpu.expires;
 	struct task_struct *p = timer->it.cpu.task;
 	struct list_head *head, *listpos;
-	struct task_cputime *cputime_expires;
-	struct cpu_timer_list *const nt = &timer->it.cpu;
 	struct cpu_timer_list *next;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		head = p->posix_cputimers.cpu_timers;
-		cputime_expires = &p->posix_cputimers.cputime_expires;
+		head = p->posix_cputimers.cpu_timers + clkidx;
+		cpuexp = p->posix_cputimers.expiries + clkidx;
 	} else {
-		head = p->signal->posix_cputimers.cpu_timers;
-		cputime_expires = &p->signal->posix_cputimers.cputime_expires;
+		head = p->signal->posix_cputimers.cpu_timers + clkidx;
+		cpuexp = p->signal->posix_cputimers.expiries + clkidx;
 	}
-	head += CPUCLOCK_WHICH(timer->it_clock);
 
 	listpos = head;
 	list_for_each_entry(next, head, entry) {
@@ -479,35 +479,22 @@ static void arm_timer(struct k_itimer *timer)
 	}
 	list_add(&nt->entry, listpos);
 
-	if (listpos == head) {
-		u64 exp = nt->expires;
+	if (listpos != head)
+		return;
 
-		/*
-		 * We are the new earliest-expiring POSIX 1.b timer, hence
-		 * need to update expiration cache. Take into account that
-		 * for process timers we share expiration cache with itimers
-		 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
-		 */
+	/*
+	 * We are the new earliest-expiring POSIX 1.b timer, hence
+	 * need to update expiration cache. Take into account that
+	 * for process timers we share expiration cache with itimers
+	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
+	 */
+	if (expires_gt(*cpuexp, newexp))
+		*cpuexp = newexp;
 
-		switch (CPUCLOCK_WHICH(timer->it_clock)) {
-		case CPUCLOCK_PROF:
-			if (expires_gt(cputime_expires->prof_exp, exp))
-				cputime_expires->prof_exp = exp;
-			break;
-		case CPUCLOCK_VIRT:
-			if (expires_gt(cputime_expires->virt_exp, exp))
-				cputime_expires->virt_exp = exp;
-			break;
-		case CPUCLOCK_SCHED:
-			if (expires_gt(cputime_expires->sched_exp, exp))
-				cputime_expires->sched_exp = exp;
-			break;
-		}
-		if (CPUCLOCK_PERTHREAD(timer->it_clock))
-			tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
-		else
-			tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
-	}
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
+	else
+		tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 /*
