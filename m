Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F72C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7528824655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfLQMkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55303 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfLQMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8s-0001pj-BH; Tue, 17 Dec 2019 13:39:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C3D11C2A41;
        Tue, 17 Dec 2019 13:39:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:52 -0000
From:   "tip-bot2 for Cheng Jian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize select_idle_cpu
Cc:     Cheng Jian <cj.chengjian@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191213024530.28052-1-cj.chengjian@huawei.com>
References: <20191213024530.28052-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Message-ID: <157658639229.30329.254182650055773886.tip-bot2@tip-bot2>
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

Commit-ID:     60588bfa223ff675b95f866249f90616613fbe31
Gitweb:        https://git.kernel.org/tip/60588bfa223ff675b95f866249f90616613fbe31
Author:        Cheng Jian <cj.chengjian@huawei.com>
AuthorDate:    Fri, 13 Dec 2019 10:45:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:51 +01:00

sched/fair: Optimize select_idle_cpu

select_idle_cpu() will scan the LLC domain for idle CPUs,
it's always expensive. so the next commit :

	1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")

introduces a way to limit how many CPUs we scan.

But it consume some CPUs out of 'nr' that are not allowed
for the task and thus waste our attempts. The function
always return nr_cpumask_bits, and we can't find a CPU
which our task is allowed to run.

Cpumask may be too big, similar to select_idle_core(), use
per_cpu_ptr 'select_idle_mask' to prevent stack overflow.

Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20191213024530.28052-1-cj.chengjian@huawei.com
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 846f50b..280d54c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5828,6 +5828,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
@@ -5859,11 +5860,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
+	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return si_cpu;
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-			continue;
 		if (available_idle_cpu(cpu))
 			break;
 		if (si_cpu == -1 && sched_idle_cpu(cpu))
