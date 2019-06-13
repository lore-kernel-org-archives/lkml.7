Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63911C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8FE20896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oKVNvJa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfFMPJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbfFMN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mLSldcVcVz9TAKo5kEex8eRnPnqh+Wg+iTyVmwvGgcI=; b=oKVNvJa5qFzq78yIg/hrGZqbbD
        BGcX3F8BxJIB6nAOd8vlcGqp0meSUGJDuYrhPfVEsLFuPKwXMW/1gFUF+WSkMc2vj2F6FCfD74xxe
        1498iLobQ8ULuS2SW/HmYre9qfVGsDQ5Xa6wRssQCvK974yP0/7cj76SP1iuox7D1shWnVjehUZPW
        +cCW14iIK0S+ECCcloVJ3DV8IR7kY+z9+EnvFocNPBRH5qqhY3EnOPpG3aTU9pKdQqrJrkjZfDyf0
        D0rxJuA+S29ObyoPl3Tz95Tm6kA1fJfAFRtHLXycL13Pk3H8jAKbSyrTMC7Yf9urV5sjSpR3x7XXf
        o32A0fNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQDy-0005lL-HU; Thu, 13 Jun 2019 13:57:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0E78320435AA0; Thu, 13 Jun 2019 15:57:05 +0200 (CEST)
Message-Id: <20190613135653.310055383@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:54:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 2/5] x86/percpu: Relax smp_processor_id()
References: <20190613135445.318096781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav reported that since this_cpu_read() became asm-volatile, many
smp_processor_id() users generated worse code due to the extra
constraints.

However since smp_processor_id() is reading a stable value, we can use
__this_cpu_read().

While this does reduce text size somewhat, this mostly results in code
movement to .text.unlikely as a result of more/larger .cold.
subfunctions. Less text on the hotpath is good for I$.

$ ./compare.sh defconfig-build1 defconfig-build2 vmlinux.o
setup_APIC_ibs                                             90         98   -12,+20
force_ibs_eilvt_setup                                     400        413   -57,+70
pci_serr_error                                            109        104   -54,+49
pci_serr_error                                            109        104   -54,+49
unknown_nmi_error                                         125        120   -76,+71
unknown_nmi_error                                         125        120   -76,+71
io_check_error                                            125        132   -97,+104
intel_thermal_interrupt                                   730        822   +92,+0
intel_init_thermal                                        951        945   -6,+0
generic_get_mtrr                                          301        294   -7,+0
generic_get_mtrr                                          301        294   -7,+0
generic_set_all                                           749        754   -44,+49
get_fixed_ranges                                          352        360   -41,+49
x86_acpi_suspend_lowlevel                                 369        363   -6,+0
check_tsc_sync_source                                     412        412   -71,+71
irq_migrate_all_off_this_cpu                              662        674   -14,+26
clocksource_watchdog                                      748        748   -113,+113
__perf_event_account_interrupt                            204        197   -7,+0
attempt_merge                                            1748       1741   -7,+0
intel_guc_send_ct                                        1424       1409   -15,+0
__fini_doorbell                                           235        231   -4,+0
bdw_set_cdclk                                             928        923   -5,+0
gen11_dsi_disable                                        1571       1556   -15,+0
gmbus_wait                                                493        488   -5,+0
md_make_request                                           376        369   -7,+0
__split_and_process_bio                                   543        536   -7,+0
delay_tsc                                                  96         89   -7,+0
hsw_disable_pc8                                           696        691   -5,+0
tsc_verify_tsc_adjust                                     215        228   -22,+35
cpuidle_driver_unref                                       56         49   -7,+0
blk_account_io_completion                                 159        148   -11,+0
mtrr_wrmsr                                                 95         99   -29,+33
__intel_wait_for_register_fw                              401        419   +18,+0
cpuidle_driver_ref                                         43         36   -7,+0
cpuidle_get_driver                                         15          8   -7,+0
blk_account_io_done                                       535        528   -7,+0
irq_migrate_all_off_this_cpu                              662        674   -14,+26
check_tsc_sync_source                                     412        412   -71,+71
irq_wait_for_poll                                         170        163   -7,+0
generic_end_io_acct                                       329        322   -7,+0
x86_acpi_suspend_lowlevel                                 369        363   -6,+0
nohz_balance_enter_idle                                   198        191   -7,+0
generic_start_io_acct                                     254        247   -7,+0
blk_account_io_start                                      341        334   -7,+0
perf_event_task_tick                                      682        675   -7,+0
intel_init_thermal                                        951        945   -6,+0
amd_e400_c1e_apic_setup                                    47         51   -28,+32
setup_APIC_eilvt                                          350        328   -22,+0
hsw_enable_pc8                                           1611       1605   -6,+0
                                             total   12985947   12985892   -994,+939

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/smp.h |    3 ++-
 include/linux/smp.h        |   45 +++++++++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -162,7 +162,8 @@ __visible void smp_call_function_single_
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (this_cpu_read(cpu_number))
+#define raw_smp_processor_id()  this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
 
 #ifdef CONFIG_X86_32
 extern int safe_smp_processor_id(void);
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -181,29 +181,46 @@ static inline int get_boot_cpu_id(void)
 
 #endif /* !SMP */
 
-/*
- * smp_processor_id(): get the current CPU ID.
+/**
+ * raw_processor_id() - get the current (unstable) CPU id
+ *
+ * For then you know what you are doing and need an unstable
+ * CPU id.
+ */
+
+/**
+ * smp_processor_id() - get the current (stable) CPU id
+ *
+ * This is the normal accessor to the CPU id and should be used
+ * whenever possible.
  *
- * if DEBUG_PREEMPT is enabled then we check whether it is
- * used in a preemption-safe way. (smp_processor_id() is safe
- * if it's used in a preemption-off critical section, or in
- * a thread that is bound to the current CPU.)
+ * The CPU id is stable when:
+ *
+ *  - IRQs are disabled;
+ *  - preemption is disabled;
+ *  - the task is CPU affine.
  *
- * NOTE: raw_smp_processor_id() is for internal use only
- * (smp_processor_id() is the preferred variant), but in rare
- * instances it might also be used to turn off false positives
- * (i.e. smp_processor_id() use that the debugging code reports but
- * which use for some reason is legal). Don't use this to hack around
- * the warning message, as your code might not work under PREEMPT.
+ * When CONFIG_DEBUG_PREEMPT; we verify these assumption and WARN
+ * when smp_processor_id() is used when the CPU id is not stable.
  */
+
+/*
+ * Allow the architecture to differentiate between a stable and unstable read.
+ * For example, x86 uses an IRQ-safe asm-volatile read for the unstable but a
+ * regular asm read for the stable.
+ */
+#ifndef __smp_processor_id
+#define __smp_processor_id(x) raw_smp_processor_id(x)
+#endif
+
 #ifdef CONFIG_DEBUG_PREEMPT
   extern unsigned int debug_smp_processor_id(void);
 # define smp_processor_id() debug_smp_processor_id()
 #else
-# define smp_processor_id() raw_smp_processor_id()
+# define smp_processor_id() __smp_processor_id()
 #endif
 
-#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
+#define get_cpu()		({ preempt_disable(); __smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 
 /*


