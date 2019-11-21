Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CA7C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88772206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfKUQsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:48:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKUQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcm-0000Z1-8W; Thu, 21 Nov 2019 17:48:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EABCB1C1A3B;
        Thu, 21 Nov 2019 17:48:07 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:07 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] procfs: Use all-in-one vtime aware kcpustat accessor
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121024430.19938-4-frederic@kernel.org>
References: <20191121024430.19938-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157435488789.21853.3157956857911322483.tip-bot2@tip-bot2>
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

Commit-ID:     26dae145a76c3615588f263885904c6e567ff116
Gitweb:        https://git.kernel.org/tip/26dae145a76c3615588f263885904c6e567ff116
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 03:44:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:33:24 +01:00

procfs: Use all-in-one vtime aware kcpustat accessor

Now that we can read also user and guest time safely under vtime, use
the relevant accessor to fix frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191121024430.19938-4-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/stat.c | 56 +++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 5c6bd0a..37bdbec 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -120,20 +120,23 @@ static int show_stat(struct seq_file *p, void *v)
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
-		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
-
-		user += kcs->cpustat[CPUTIME_USER];
-		nice += kcs->cpustat[CPUTIME_NICE];
-		system += kcpustat_field(kcs, CPUTIME_SYSTEM, i);
-		idle += get_idle_time(kcs, i);
-		iowait += get_iowait_time(kcs, i);
-		irq += kcs->cpustat[CPUTIME_IRQ];
-		softirq += kcs->cpustat[CPUTIME_SOFTIRQ];
-		steal += kcs->cpustat[CPUTIME_STEAL];
-		guest += kcs->cpustat[CPUTIME_GUEST];
-		guest_nice += kcs->cpustat[CPUTIME_GUEST_NICE];
-		sum += kstat_cpu_irqs_sum(i);
-		sum += arch_irq_stat_cpu(i);
+		struct kernel_cpustat kcpustat;
+		u64 *cpustat = kcpustat.cpustat;
+
+		kcpustat_cpu_fetch(&kcpustat, i);
+
+		user		+= cpustat[CPUTIME_USER];
+		nice		+= cpustat[CPUTIME_NICE];
+		system		+= cpustat[CPUTIME_SYSTEM];
+		idle		+= get_idle_time(&kcpustat, i);
+		iowait		+= get_iowait_time(&kcpustat, i);
+		irq		+= cpustat[CPUTIME_IRQ];
+		softirq		+= cpustat[CPUTIME_SOFTIRQ];
+		steal		+= cpustat[CPUTIME_STEAL];
+		guest		+= cpustat[CPUTIME_GUEST];
+		guest_nice	+= cpustat[CPUTIME_USER];
+		sum		+= kstat_cpu_irqs_sum(i);
+		sum		+= arch_irq_stat_cpu(i);
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
 			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
@@ -157,19 +160,22 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
-		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
+		struct kernel_cpustat kcpustat;
+		u64 *cpustat = kcpustat.cpustat;
+
+		kcpustat_cpu_fetch(&kcpustat, i);
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
-		user = kcs->cpustat[CPUTIME_USER];
-		nice = kcs->cpustat[CPUTIME_NICE];
-		system = kcpustat_field(kcs, CPUTIME_SYSTEM, i);
-		idle = get_idle_time(kcs, i);
-		iowait = get_iowait_time(kcs, i);
-		irq = kcs->cpustat[CPUTIME_IRQ];
-		softirq = kcs->cpustat[CPUTIME_SOFTIRQ];
-		steal = kcs->cpustat[CPUTIME_STEAL];
-		guest = kcs->cpustat[CPUTIME_GUEST];
-		guest_nice = kcs->cpustat[CPUTIME_GUEST_NICE];
+		user		= cpustat[CPUTIME_USER];
+		nice		= cpustat[CPUTIME_NICE];
+		system		= cpustat[CPUTIME_SYSTEM];
+		idle		= get_idle_time(&kcpustat, i);
+		iowait		= get_iowait_time(&kcpustat, i);
+		irq		= cpustat[CPUTIME_IRQ];
+		softirq		= cpustat[CPUTIME_SOFTIRQ];
+		steal		= cpustat[CPUTIME_STEAL];
+		guest		= cpustat[CPUTIME_GUEST];
+		guest_nice	= cpustat[CPUTIME_USER];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
