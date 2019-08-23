Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFCEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195320870
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394401AbfHWPEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:04:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732542AbfHWPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:04:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i1B6h-0004l7-6M; Fri, 23 Aug 2019 17:04:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC0E51C089A;
        Fri, 23 Aug 2019 17:04:02 +0200 (CEST)
Date:   Fri, 23 Aug 2019 15:04:02 -0000
From:   tip-bot2 for Tianyu Lan <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyperv: Add Hyper-V specific
 sched clock function
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190814123216.32245-3-Tianyu.Lan@microsoft.com>
References: <20190814123216.32245-3-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Message-ID: <156657264274.8404.12703131421619631346.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bd00cd52d5be655a2f217e2ed74b91a71cb2b14f
Gitweb:        https://git.kernel.org/tip/bd00cd52d5be655a2f217e2ed74b91a71cb2b14f
Author:        Tianyu Lan <Tianyu.Lan@microsoft.com>
AuthorDate:    Wed, 14 Aug 2019 20:32:16 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2019 16:59:54 +02:00

clocksource/drivers/hyperv: Add Hyper-V specific sched clock function

Hyper-V guests use the default native_sched_clock() in
pv_ops.time.sched_clock on x86. But native_sched_clock() directly uses the
raw TSC value, which can be discontinuous in a Hyper-V VM.
    
Add the generic hv_setup_sched_clock() to set the sched clock function
appropriately. On x86, this sets pv_ops.time.sched_clock to read the
Hyper-V reference TSC value that is scaled and adjusted to be continuous.
    
Also move the Hyper-V reference TSC initialization much earlier in the boot
process so no discontinuity is observed when pv_ops.time.sched_clock
calculates its offset.

[ tglx: Folded build fix ]

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lkml.kernel.org/r/20190814123216.32245-3-Tianyu.Lan@microsoft.com
---
 arch/x86/hyperv/hv_init.c          |  2 --
 arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
 drivers/clocksource/hyperv_timer.c | 22 ++++++++++++----------
 include/asm-generic/mshyperv.h     |  1 +
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0d25868..866dfb3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -301,8 +301,6 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
-	/* Register Hyper-V specific clocksource */
-	hv_init_clocksource();
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 062f772..53afd33 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -29,6 +29,7 @@
 #include <asm/timer.h>
 #include <asm/reboot.h>
 #include <asm/nmi.h>
+#include <clocksource/hyperv_timer.h>
 
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
@@ -338,9 +339,16 @@ static void __init ms_hyperv_init_platform(void)
 		x2apic_phys = 1;
 # endif
 
+	/* Register Hyper-V specific clocksource */
+	hv_init_clocksource();
 #endif
 }
 
+void hv_setup_sched_clock(void *sched_clock)
+{
+	pv_ops.time.sched_clock = sched_clock;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 432aa33..c322ab4 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -22,6 +22,7 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
+static u64 hv_sched_clock_offset __ro_after_init;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -222,7 +223,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_sched_clock_tsc(void)
+static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 {
 	u64 current_tick = hv_read_tsc_page(&tsc_pg);
 
@@ -232,9 +233,9 @@ static u64 notrace read_hv_sched_clock_tsc(void)
 	return current_tick;
 }
 
-static u64 read_hv_clock_tsc(struct clocksource *arg)
+static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_sched_clock_tsc();
+	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_tsc = {
@@ -246,7 +247,7 @@ static struct clocksource hyperv_cs_tsc = {
 };
 #endif
 
-static u64 notrace read_hv_sched_clock_msr(void)
+static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 {
 	u64 current_tick;
 	/*
@@ -258,9 +259,9 @@ static u64 notrace read_hv_sched_clock_msr(void)
 	return current_tick;
 }
 
-static u64 read_hv_clock_msr(struct clocksource *arg)
+static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_sched_clock_msr();
+	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_msr = {
@@ -298,8 +299,9 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
-	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
+	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_setup_sched_clock(read_hv_sched_clock_tsc);
+
 	return true;
 }
 #else
@@ -329,7 +331,7 @@ void __init hv_init_clocksource(void)
 	hyperv_cs = &hyperv_cs_msr;
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
-	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
-	sched_clock_register(read_hv_sched_clock_msr, 64, HV_CLOCK_HZ);
+	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 0becb7d..18d8e2d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -167,6 +167,7 @@ void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
+void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline void hyperv_cleanup(void) {}
