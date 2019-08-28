Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BCE2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfH1KQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46389 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfH1KQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v07-0000F0-70; Wed, 28 Aug 2019 12:16:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D44B31C0DE5;
        Wed, 28 Aug 2019 12:16:25 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Move prof/virt_ticks into caller
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.729298382@linutronix.de>
References: <20190821192920.729298382@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738577.5734.8944060068496596785.tip-bot2@tip-bot2>
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

Commit-ID:     ab693c5a5e3107f035d5162e6ada9aaf7dd76a1d
Gitweb:        https://git.kernel.org/tip/ab693c5a5e3107f035d5162e6ada9aaf7dd76a1d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:33 +02:00

posix-cpu-timers: Move prof/virt_ticks into caller

The functions have only one caller left. No point in having them.

Move the almost duplicated code into the caller and simplify it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.729298382@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 98dab3e..b1c9766 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -130,23 +130,6 @@ static inline int task_cputime_zero(const struct task_cputime *cputime)
 	return 0;
 }
 
-static inline u64 prof_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime + stime;
-}
-static inline u64 virt_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime;
-}
-
 static int
 posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
@@ -184,13 +167,18 @@ posix_cpu_clock_set(const clockid_t clock, const struct timespec64 *tp)
  */
 static u64 cpu_clock_sample(const clockid_t clkid, struct task_struct *p)
 {
+	u64 utime, stime;
+
+	if (clkid == CPUCLOCK_SCHED)
+		return task_sched_runtime(p);
+
+	task_cputime(p, &utime, &stime);
+
 	switch (clkid) {
 	case CPUCLOCK_PROF:
-		return prof_ticks(p);
+		return utime + stime;
 	case CPUCLOCK_VIRT:
-		return virt_ticks(p);
-	case CPUCLOCK_SCHED:
-		return task_sched_runtime(p);
+		return utime;
 	default:
 		WARN_ON_ONCE(1);
 	}
