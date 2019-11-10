Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AED721855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKJKYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:24:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfKJKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:24:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTkO6-0004YA-Lb; Sun, 10 Nov 2019 11:24:07 +0100
Date:   Sun, 10 Nov 2019 10:21:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.4-rc7
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
Message-ID: <157338131324.14789.8363441947094006311.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  63ec58b44fcc: x86/tsc: Respect tsc command line paraemeter for clocksource_tsc_early

A small set of fixes for x86:

  - Make the tsc=reliable/nowatchdog command line parameter work again. It was broken
    with the introduction of the early TSC clocksource.

  - Prevent the evaluation of exception stacks before they are set up. This
    causes a crash in dumpstack because the stack walk termination gets
    screwed up.

  - Prevent a NULL pointer dereference in the rescource control file
    system.

  - Avoid bogus warnings about APIC id mismatch related to the LDR which
    can happen when the LDR is not in use and therefore not initialized.
    Only evaluate that when the APIC is in logical destination mode.

Thanks,

	tglx

------------------>
Jan Beulich (1):
      x86/apic/32: Avoid bogus LDR warnings

Michael Zhivich (1):
      x86/tsc: Respect tsc command line paraemeter for clocksource_tsc_early

Thomas Gleixner (1):
      x86/dumpstack/64: Don't evaluate exception stacks before setup

Xiaochen Shen (1):
      x86/resctrl: Prevent NULL pointer dereference when reading mondata


 arch/x86/kernel/apic/apic.c               | 28 +++++++++++++++-------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 ++++
 arch/x86/kernel/dumpstack_64.c            |  7 +++++++
 arch/x86/kernel/tsc.c                     |  3 +++
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 9e2dd2b296cd..2b0faf86da1b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1586,9 +1586,6 @@ static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
 	unsigned int value;
-#ifdef CONFIG_X86_32
-	int logical_apicid, ldr_apicid;
-#endif
 
 	if (disable_apic) {
 		disable_ioapic_support();
@@ -1626,16 +1623,21 @@ static void setup_local_APIC(void)
 	apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	/*
-	 * APIC LDR is initialized.  If logical_apicid mapping was
-	 * initialized during get_smp_config(), make sure it matches the
-	 * actual value.
-	 */
-	logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
-	ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-	WARN_ON(logical_apicid != BAD_APICID && logical_apicid != ldr_apicid);
-	/* always use the value from LDR */
-	early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
+	if (apic->dest_logical) {
+		int logical_apicid, ldr_apicid;
+
+		/*
+		 * APIC LDR is initialized.  If logical_apicid mapping was
+		 * initialized during get_smp_config(), make sure it matches
+		 * the actual value.
+		 */
+		logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
+		ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
+		if (logical_apicid != BAD_APICID)
+			WARN_ON(logical_apicid != ldr_apicid);
+		/* Always use the value from LDR. */
+		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
+	}
 #endif
 
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index efbd54cc4e69..055c8613b531 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -522,6 +522,10 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	md.priv = of->kn->priv;
 	resid = md.u.rid;
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 753b8cfe8b8a..87b97897a881 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -94,6 +94,13 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
+	/*
+	 * Handle the case where stack trace is collected _before_
+	 * cea_exception_stacks had been initialized.
+	 */
+	if (!begin)
+		return false;
+
 	end = begin + sizeof(struct cea_exception_stacks);
 	/* Bail if @stack is outside the exception stack area. */
 	if (stk < begin || stk >= end)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c59454c382fd..7e322e2daaf5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1505,6 +1505,9 @@ void __init tsc_init(void)
 		return;
 	}
 
+	if (tsc_clocksource_reliable || no_tsc_watchdog)
+		clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
 }


