Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D46C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F4120895
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574304290;
	bh=bVTtftvy/497ZG5CBfJ+tdQkUTY2Eip4rA9yqOgTedc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FmL7J7/WEdNYw4R2FHBccZozD1FW8qZYb3hmX8QFin3j/LuItVnY2aTzL0r7+coel
	 Vvdw8bhHIaAdW8pcZFSYFnyesQwQEA11r819weiDL/b/DheD6xdme86tYC+XkvXdI/
	 eTGR/vbJtzRyoJTk+RuYzteTjQsHEq2a7WOFTEdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUCot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKUCop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:45 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42532089D;
        Thu, 21 Nov 2019 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304285;
        bh=bVTtftvy/497ZG5CBfJ+tdQkUTY2Eip4rA9yqOgTedc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLPkw3IrS8wi7V+ItSmG0FlnLfYxSpzZQm44Oi3df/1wpCJBeweCO/W4PrHjugR84
         ezxljgQQhJdHK3/HZO3L2tCMP2lH/eV0u7irndM0pGGV/FnHmjplf7tQb/GjLt6Gfr
         fzglAYtPjYqaazgkZOkrY2S6a4cGFX7Tsj6qmaDg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/6] procfs: Use all-in-one vtime aware kcpustat accessor
Date:   Thu, 21 Nov 2019 03:44:27 +0100
Message-Id: <20191121024430.19938-4-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121024430.19938-1-frederic@kernel.org>
References: <20191121024430.19938-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can read also user and guest time safely under vtime, use
the relevant accessor to fix frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/stat.c | 54 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 5c6bd0ae3802..37bdbec5b402 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -120,20 +120,23 @@ static int show_stat(struct seq_file *p, void *v)
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
-		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
+		struct kernel_cpustat kcpustat;
+		u64 *cpustat = kcpustat.cpustat;
 
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
-- 
2.23.0

