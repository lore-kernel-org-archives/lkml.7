Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82010C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60404206E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLCQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:02:19 -0500
Received: from foss.arm.com ([217.140.110.172]:44854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCQCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:02:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73849DA7;
        Tue,  3 Dec 2019 08:02:16 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24E073F52E;
        Tue,  3 Dec 2019 08:02:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v2 4/4] sched/fair: Make feec() consider uclamp restrictions
Date:   Tue,  3 Dec 2019 15:59:07 +0000
Message-Id: <20191203155907.2086-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203155907.2086-1-valentin.schneider@arm.com>
References: <20191203155907.2086-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've just made task_fits_capacity() uclamp-aware, and
find_energy_efficient_cpu() needs to go through the same treatment.
Things are somewhat different here however - we can't directly use
the now uclamp-aware task_fits_capacity(). Consider the following setup:

  rq.cpu_capacity_orig = 512
  rq.util_avg = 200
  rq.uclamp.max = 768

  p.util_est = 600
  p.uclamp.max = 256

  (p not yet enqueued on rq)

Using task_fits_capacity() here would tell us that p fits on the above CPU.
However, enqueuing p on that CPU *will* cause it to become overutilized
since rq clamp values are max-aggregated, so we'd remain with

  rq.uclamp.max = 768

Thus we could reach a high enough frequency to reach beyond 0.8 * 512
utilization (== overutilized). What feec() needs here is
uclamp_rq_util_with() which lets us peek at the future utilization
landscape, including rq-wide uclamp values.

Make find_energy_efficient_cpu() use uclamp_rq_util_with() for its
fits_capacity() check. This is in line with what compute_energy() ends up
using for estimating utilization.

Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dc3e86cb2b2e..cc659a3944f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6284,9 +6284,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
 
@@ -6301,7 +6310,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * Find the CPU with the maximum spare capacity in
 			 * the performance domain
 			 */
-			spare_cap = cpu_cap - util;
 			if (spare_cap > max_spare_cap) {
 				max_spare_cap = spare_cap;
 				max_spare_cap_cpu = cpu;
-- 
2.24.0

