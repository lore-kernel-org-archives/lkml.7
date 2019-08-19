Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366682070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfHSPqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47752 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfHSPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqu-0006zS-TA; Mon, 19 Aug 2019 17:45:48 +0200
Message-Id: <20190819143804.450851157@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 32/44] posix-cpu-timers: Provide array based sample functions
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using task_cputime and doing the addition of utime and stime at
all call sites, it's way simpler to have a sample array which allows
indexed based checks against the expiry cache array.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -195,6 +195,32 @@ static u64 cpu_clock_sample(const clocki
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


