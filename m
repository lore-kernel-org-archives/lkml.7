Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72722189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfH1KSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1KQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0C-0000JQ-OC; Wed, 28 Aug 2019 12:16:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D7071C0DE5;
        Wed, 28 Aug 2019 12:16:30 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Provide array based sample functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.590362974@linutronix.de>
References: <20190821192921.590362974@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739018.5762.6168289869044091093.tip-bot2@tip-bot2>
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

Commit-ID:     b0d524f77956eec887b30732af1f5f98cbf62b9f
Gitweb:        https://git.kernel.org/tip/b0d524f77956eec887b30732af1f5f98cbf62b9f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:38 +02:00

posix-cpu-timers: Provide array based sample functions

Instead of using task_cputime and doing the addition of utime and stime at
all call sites, it's way simpler to have a sample array which allows
indexed based checks against the expiry cache array.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.590362974@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 220e3c7..11c841c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -202,6 +202,32 @@ static u64 cpu_clock_sample(const clockid_t clkid, struct task_struct *p)
 	return 0;
 }
 
+static inline void store_samples(u64 *samples, u64 stime, u64 utime, u64 rtime)
+{
+	samples[CPUCLOCK_PROF] = stime + utime;
+	samples[CPUCLOCK_VIRT] = utime;
+	samples[CPUCLOCK_SCHED] = rtime;
+}
+
+static void task_sample_cputime(struct task_struct *p, u64 *samples)
+{
+	u64 stime, utime;
+
+	task_cputime(p, &utime, &stime);
+	store_samples(samples, stime, utime, p->se.sum_exec_runtime);
+}
+
+static void proc_sample_cputime_atomic(struct task_cputime_atomic *at,
+				       u64 *samples)
+{
+	u64 stime, utime, rtime;
+
+	utime = atomic64_read(&at->utime);
+	stime = atomic64_read(&at->stime);
+	rtime = atomic64_read(&at->sum_exec_runtime);
+	store_samples(samples, stime, utime, rtime);
+}
+
 /*
  * Set cputime to sum_cputime if sum_cputime > cputime. Use cmpxchg
  * to avoid race conditions with concurrent updates to cputime.
