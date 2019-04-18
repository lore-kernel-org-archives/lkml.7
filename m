Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47289C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61B217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbfDROLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:11:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54389 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389196AbfDROLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:11:40 -0400
Received: from 79.184.254.18.ipv4.supernova.orange.pl (79.184.254.18) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 569ca173a2a89f99; Thu, 18 Apr 2019 16:11:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     x86 Maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Date:   Thu, 18 Apr 2019 16:11:37 +0200
Message-ID: <38900622.ao2n2t5aPS@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are problems with running time_cpufreq_notifier() on SMP
systems.

First off, the rdtsc() called from there runs on the CPU executing
that code and not necessarily on the CPU whose sched_clock() rate is
updated which is questionable at best.

Second, in the cases when the frequencies of all CPUs in an SMP
system are always in sync, it is not sufficient to update just
one of them or the set associated with a given cpufreq policy on
frequency changes - all CPUs in the system should be updated and
that would require more than a simple transition notifier.

Note, however, that the underlying issue (the TSC rate depending on
the CPU frequency) has not been present in hardware shipping for the
last few years and in quite a few relevant cases (acpi-cpufreq in
particular) running time_cpufreq_notifier() will cause the TSC to
be marked as unstable anyway.

For this reason, make time_cpufreq_notifier() simply mark the TSC
as unstable and give up when run on SMP and only try to carry out
any adjustments otherwise.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

Index: linux-pm/arch/x86/kernel/tsc.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/tsc.c
+++ linux-pm/arch/x86/kernel/tsc.c
@@ -185,8 +185,7 @@ static void __init cyc2ns_init_boot_cpu(
 /*
  * Secondary CPUs do not run through tsc_init(), so set up
  * all the scale factors for all CPUs, assuming the same
- * speed as the bootup CPU. (cpufreq notifiers will fix this
- * up if their speed diverges)
+ * speed as the bootup CPU.
  */
 static void __init cyc2ns_init_secondary_cpus(void)
 {
@@ -937,12 +936,12 @@ void tsc_restore_sched_clock_state(void)
 }
 
 #ifdef CONFIG_CPU_FREQ
-/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
+/*
+ * Frequency scaling support. Adjust the TSC based timer when the CPU frequency
  * changes.
  *
- * RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
- * not that important because current Opteron setups do not support
- * scaling on SMP anyroads.
+ * NOTE: On SMP the situation is not fixable in general, so simply mark the TSC
+ * as unstable and give up in those cases.
  *
  * Should fix up last_tsc too. Currently gettimeofday in the
  * first tick after the change will be slightly wrong.
@@ -956,22 +955,22 @@ static int time_cpufreq_notifier(struct
 				void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned long *lpj;
 
-	lpj = &boot_cpu_data.loops_per_jiffy;
-#ifdef CONFIG_SMP
-	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
-#endif
+	if (num_online_cpus() > 1) {
+		mark_tsc_unstable("cpufreq changes on SMP");
+		return 0;
+	}
 
 	if (!ref_freq) {
 		ref_freq = freq->old;
-		loops_per_jiffy_ref = *lpj;
+		loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
 		tsc_khz_ref = tsc_khz;
 	}
+
 	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
-			(val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
-		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+		boot_cpu_data.loops_per_jiffy =
+			cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 
 		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))



