Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D2C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150502075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLYKjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfLYKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44C-00088w-FT; Wed, 25 Dec 2019 11:39:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 19D001C2BA3;
        Wed, 25 Dec 2019 11:39:00 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:38:59 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make EAS wakeup placement consider
 uclamp restrictions
Cc:     Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211113851.24241-6-valentin.schneider@arm.com>
References: <20191211113851.24241-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157727033997.30329.10913355096896914803.tip-bot2@tip-bot2>
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

Commit-ID:     1d42509e475cdc8542aa5b3e03a7e845244f4f57
Gitweb:        https://git.kernel.org/tip/1d42509e475cdc8542aa5b3e03a7e845244f4f57
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 11 Dec 2019 11:38:51 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:09 +01:00

sched/fair: Make EAS wakeup placement consider uclamp restrictions

task_fits_capacity() has just been made uclamp-aware, and
find_energy_efficient_cpu() needs to go through the same treatment.

Things are somewhat different here however - using the task max clamp isn't
sufficient. Consider the following setup:

  The target runqueue, rq:
    rq.cpu_capacity_orig = 512
    rq.cfs.avg.util_avg = 200
    rq.uclamp.max = 768 // the max p.uclamp.max of all enqueued p's is 768

  The waking task, p (not yet enqueued on rq):
    p.util_est = 600
    p.uclamp.max = 100

Now, consider the following code which doesn't use the rq clamps:

  util = uclamp_task_util(p);
  // Does the task fit in the spare CPU capacity?
  cpu = cpu_of(rq);
  fits_capacity(util, cpu_capacity(cpu) - cpu_util(cpu))

This would lead to:

  util = 100;
  fits_capacity(100, 512 - 200)

fits_capacity() would return true. However, enqueuing p on that CPU *will*
cause it to become overutilized since rq clamp values are max-aggregated,
so we'd remain with

  rq.uclamp.max = 768

which comes from the other tasks already enqueued on rq. Thus, we could
select a high enough frequency to reach beyond 0.8 * 512 utilization
(== overutilized) after enqueuing p on rq. What find_energy_efficient_cpu()
needs here is uclamp_rq_util_with() which lets us peek at the future
utilization landscape, including rq-wide uclamp values.

Make find_energy_efficient_cpu() use uclamp_rq_util_with() for its
fits_capacity() check. This is in line with what compute_energy() ends up
using for estimating utilization.

Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191211113851.24241-6-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26c59bc..2d170b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6273,9 +6273,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			/* Skip CPUs that will be overutilized. */
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
+			spare_cap = cpu_cap - util;
+
+			/*
+			 * Skip CPUs that cannot satisfy the capacity request.
+			 * IOW, placing the task there would make the CPU
+			 * overutilized. Take uclamp into account to see how
+			 * much capacity we can get out of the CPU; this is
+			 * aligned with schedutil_cpu_util().
+			 */
+			util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
 			if (!fits_capacity(util, cpu_cap))
 				continue;
 
@@ -6290,7 +6299,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * Find the CPU with the maximum spare capacity in
 			 * the performance domain
 			 */
-			spare_cap = cpu_cap - util;
 			if (spare_cap > max_spare_cap) {
 				max_spare_cap = spare_cap;
 				max_spare_cap_cpu = cpu;
