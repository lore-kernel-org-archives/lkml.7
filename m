Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D4BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEEF2341B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfH1KSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfH1KQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v05-0000El-LP; Wed, 28 Aug 2019 12:16:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5170D1C07D2;
        Wed, 28 Aug 2019 12:16:25 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Sample task times once in expiry check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.639878168@linutronix.de>
References: <20190821192920.639878168@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738522.5731.9692769171723341682.tip-bot2@tip-bot2>
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

Commit-ID:     0476ff2c151ee35bda2f938e8828b6f6113ebf55
Gitweb:        https://git.kernel.org/tip/0476ff2c151ee35bda2f938e8828b6f6113ebf55
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:32 +02:00

posix-cpu-timers: Sample task times once in expiry check

Sampling the task times twice does not make sense. Do it once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.639878168@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a2007ce..98dab3e 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -785,9 +785,9 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct list_head *timers = tsk->cpu_timers;
 	struct task_cputime *tsk_expires = &tsk->cputime_expires;
-	u64 expires;
+	struct list_head *timers = tsk->cpu_timers;
+	u64 expires, stime, utime;
 	unsigned long soft;
 
 	if (dl_task(tsk))
@@ -800,10 +800,12 @@ static void check_thread_timers(struct task_struct *tsk,
 	if (task_cputime_zero(&tsk->cputime_expires))
 		return;
 
-	expires = check_timers_list(timers, firing, prof_ticks(tsk));
+	task_cputime(tsk, &utime, &stime);
+
+	expires = check_timers_list(timers, firing, utime + stime);
 	tsk_expires->prof_exp = expires;
 
-	expires = check_timers_list(++timers, firing, virt_ticks(tsk));
+	expires = check_timers_list(++timers, firing, utime);
 	tsk_expires->virt_exp = expires;
 
 	tsk_expires->sched_exp = check_timers_list(++timers, firing,
