Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6282073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfLMAKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:58628 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbfLMAJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 16:09:10 -0800
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="208276338"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 16:09:09 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v11] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 12 Dec 2019 16:09:08 -0800
Message-Id: <20191213000908.22813-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122152715.GA1909@hirez.programming.kicks-ass.net>
References: <20191122152715.GA1909@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

A split-lock occurs when an atomic instruction operates on data
that spans two cache lines. In order to maintain atomicity the
core takes a global bus lock.

This is typically >1000 cycles slower than an atomic operation
within a cache line. It also disrupts performance on other cores
(which must wait for the bus lock to be released before their
memory operations can complete. For real-time systems this may
mean missing deadlines. For other systems it may just be very
annoying.

Some CPUs have the capability to raise an #AC trap when a
split lock is attempted.

Provide a command line option to give the user choices on how
to handle this. split_lock_detect=
	off	- not enabled (no traps for split locks)
	warn	- warn once when an application does a
		  split lock, bust allow it to continue
		  running.
	fatal	- Send SIGBUS to applications that cause split lock

Default is "warn". Note that if the kernel hits a split lock
in any mode other than "off" it will OOPs.

One implementation wrinkle is that the MSR to control the
split lock detection is per-core, not per thread. This might
result in some short lived races on HT systems in "warn" mode
if Linux tries to enable on one thread while disabling on
the other. Race analysis by Sean Christopherson:

  - Toggling of split-lock is only done in "warn" mode.  Worst case
    scenario of a race is that a misbehaving task will generate multiple
    #AC exceptions on the same instruction.  And this race will only occur
    if both siblings are running tasks that generate split-lock #ACs, e.g.
    a race where sibling threads are writing different values will only
    occur if CPUx is disabling split-lock after an #AC and CPUy is
    re-enabling split-lock after *its* previous task generated an #AC.
  - Transitioning between modes at runtime isn't supported and disabling
    is tracked per task, so hardware will always reach a steady state that
    matches the configured mode.  I.e. split-lock is guaranteed to be
    enabled in hardware once all _TIF_SLD threads have been scheduled out.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---

[Note that I gave PeterZ Author credit because the majority
of the code here came from his untested patch. I just fixed
the typos. He didn't give a "Signed-off-by" ... so he can
either add one to this, or disavow all knowledge - his choice]
---
 .../admin-guide/kernel-parameters.txt         |  18 ++
 Makefile                                      |   4 +-
 arch/x86/include/asm/cpu.h                    |  17 ++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/msr-index.h              |   8 +
 arch/x86/include/asm/thread_info.h            |   6 +-
 arch/x86/include/asm/traps.h                  |   1 +
 arch/x86/kernel/cpu/common.c                  |   2 +
 arch/x86/kernel/cpu/intel.c                   | 170 ++++++++++++++++++
 arch/x86/kernel/process.c                     |   3 +
 arch/x86/kernel/traps.c                       |  29 ++-
 11 files changed, 254 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..173c1acff5f0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3181,6 +3181,24 @@
 
 	nosoftlockup	[KNL] Disable the soft-lockup detector.
 
+	split_lock_detect=
+			[X86] Enable split lock detection
+
+			When enabled (and if hardware support is present), atomic
+			instructions that access data across cache line
+			boundaries will result in an alignment check exception.
+
+			off	- not enabled
+
+			warn	- the kernel will pr_alert about applications
+				  triggering the #AC exception
+
+			fatal	- the kernel will SIGBUS applications that
+				  trigger the #AC exception.
+
+			For any more other than 'off' the kernel will die if
+			it (or firmware) will trigger #AC.
+
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
diff --git a/Makefile b/Makefile
index 999a197d67d2..73e3c2802927 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
-PATCHLEVEL = 4
+PATCHLEVEL = 5
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = -rc1
 NAME = Kleptomaniac Octopus
 
 # *DOCUMENTATION*
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..5223504c7e7c 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,21 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_CPU_SUP_INTEL
+extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern bool handle_split_lock(void);
+extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern void switch_sld(struct task_struct *);
+#else
+static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline bool handle_split_lock(void)
+{
+	return false;
+}
+static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	return false;
+}
+static inline void switch_sld(struct task_struct *prev) {}
+#endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e9b62498fe75..c3edd2bba184 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -220,6 +220,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_SPLIT_LOCK_DETECT	( 7*32+31) /* #AC for split lock */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -365,6 +366,7 @@
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 084e98da04a7..8bb2e08ce4a3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -41,6 +41,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTRL				0x00000033
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
@@ -70,6 +74,10 @@
  */
 #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
 
+#define MSR_IA32_CORE_CAPABILITIES			  0x000000cf
+#define MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT_BIT  5
+#define MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d779366ce3f8..d23638a0525e 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -92,6 +92,7 @@ struct thread_info {
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
+#define TIF_SLD			18	/* split_lock_detect */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -122,6 +123,7 @@ struct thread_info {
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
+#define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
@@ -158,9 +160,9 @@ struct thread_info {
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 # define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | \
-				 _TIF_IO_BITMAP)
+				 _TIF_IO_BITMAP | _TIF_SLD)
 #else
-# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY)
+# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | _TIF_SLD)
 #endif
 
 #define _TIF_WORK_CTXSW_NEXT	(_TIF_WORK_CTXSW)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index ffa0dc8a535e..6ceab60370f0 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -175,4 +175,5 @@ enum x86_pf_error_code {
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
 };
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d90294fe6..39245f61fad0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1234,6 +1234,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
+	cpu_set_core_cap_bits(c);
+
 	fpu__init_system(c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4a900804a023..79cec85c5132 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -19,6 +19,8 @@
 #include <asm/microcode_intel.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cmdline.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -31,6 +33,14 @@
 #include <asm/apic.h>
 #endif
 
+enum split_lock_detect_state {
+	sld_off = 0,
+	sld_warn,
+	sld_fatal,
+};
+
+static enum split_lock_detect_state sld_state = sld_warn;
+
 /*
  * Just in case our CPU detection goes bad, or you have a weird system,
  * allow a way to override the automatic disabling of MPX.
@@ -652,6 +662,8 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
+static void split_lock_init(void);
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	early_init_intel(c);
@@ -767,6 +779,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_enable();
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
+
+	split_lock_init();
 }
 
 #ifdef CONFIG_X86_32
@@ -1028,3 +1042,159 @@ static const struct cpu_dev intel_cpu_dev = {
 };
 
 cpu_dev_register(intel_cpu_dev);
+
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/split lock detection: " fmt
+
+static const struct {
+	const char			*option;
+	enum split_lock_detect_state	state;
+} sld_options[] __initconst = {
+	{ "off",	sld_off   },
+	{ "warn",	sld_warn  },
+	{ "fatal",	sld_fatal },
+};
+
+static inline bool match_option(const char *arg, int arglen, const char *opt)
+{
+	int len = strlen(opt);
+
+	return len == arglen && !strncmp(arg, opt, len);
+}
+
+static void __init split_lock_setup(void)
+{
+	enum split_lock_detect_state sld = sld_state;
+	char arg[20];
+	int i, ret;
+
+	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+
+	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
+				  arg, sizeof(arg));
+	if (ret < 0)
+		goto print;
+
+	for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
+		if (match_option(arg, ret, sld_options[i].option)) {
+			sld = sld_options[i].state;
+			break;
+		}
+	}
+
+	if (sld != sld_state)
+		sld_state = sld;
+
+print:
+	switch(sld) {
+	case sld_off:
+		pr_info("disabled\n");
+		break;
+
+	case sld_warn:
+		pr_info("warning about user-space split_locks\n");
+		break;
+
+	case sld_fatal:
+		pr_info("sending SIGBUS on user-space split_locks\n");
+		break;
+	}
+}
+
+/*
+ * The TEST_CTRL MSR is per core. So multiple threads can
+ * read/write the MSR in parallel. But it's possible to
+ * simplify the read/write without locking and without
+ * worry about overwriting the MSR because only bit 29
+ * is implemented in the MSR and the bit is set as 1 by all
+ * threads. Locking may be needed in the future if situation
+ * is changed e.g. other bits are implemented.
+ */
+
+static bool __sld_msr_set(bool on)
+{
+	u64 test_ctrl_val;
+
+	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
+		return false;
+
+	if (on)
+		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+	else
+		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+
+	if (wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val))
+		return false;
+
+	return true;
+}
+
+static void split_lock_init(void)
+{
+	if (sld_state == sld_off)
+		return;
+
+	if (__sld_msr_set(true))
+		return;
+
+	/*
+	 * If this is anything other than the boot-cpu, you've done
+	 * funny things and you get to keep whatever pieces.
+	 */
+	pr_warn("MSR fail -- disabled\n");
+	__sld_msr_set(sld_off);
+}
+
+bool handle_split_lock(void)
+{
+	return sld_state != sld_off;
+}
+
+bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if ((regs->eflags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+		return false;
+
+	pr_alert("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
+		 current->comm, current->pid, regs->ip);
+
+	__sld_msr_set(false);
+	set_tsk_thread_flag(current, TIF_SLD);
+	return true;
+}
+
+void switch_sld(struct task_struct *prev)
+{
+	__sld_msr_set(true);
+	clear_tsk_thread_flag(prev, TIF_SLD);
+}
+
+#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
+
+/*
+ * The following processors have split lock detection feature. But since they
+ * don't have MSR IA32_CORE_CAPABILITIES, the feature cannot be enumerated by
+ * the MSR. So enumerate the feature by family and model on these processors.
+ */
+static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	{}
+};
+
+void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+{
+	u64 ia32_core_caps = 0;
+
+	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
+		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+		rdmsrl(MSR_IA32_CORE_CAPABILITIES, ia32_core_caps);
+	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		/* Enumerate split lock detection by family and model. */
+		if (x86_match_cpu(split_lock_cpu_ids))
+			ia32_core_caps |= MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT;
+	}
+
+	if (ia32_core_caps & MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT)
+		split_lock_setup();
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 61e93a318983..55d205820f35 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -654,6 +654,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		/* Enforce MSR update to ensure consistent state */
 		__speculation_ctrl_update(~tifn, tifn);
 	}
+
+	if (tifp & _TIF_SLD)
+		switch_sld(prev_p);
 }
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 05da6b5b167b..a933a01f6e40 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -46,6 +46,7 @@
 #include <asm/traps.h>
 #include <asm/desc.h>
 #include <asm/fpu/internal.h>
+#include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/mce.h>
 #include <asm/fixmap.h>
@@ -242,7 +243,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 {
 	struct task_struct *tsk = current;
 
-
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
 
@@ -288,9 +288,34 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
 #undef IP
 
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	unsigned int trapnr = X86_TRAP_AC;
+	char str[] = "alignment check";
+	int signr = SIGBUS;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_STOP)
+		return;
+
+	if (!handle_split_lock())
+		return;
+
+	if (!user_mode(regs))
+		die("Split lock detected\n", regs, error_code);
+
+	cond_local_irq_enable(regs);
+
+	if (handle_user_split_lock(regs, error_code))
+		return;
+
+	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
+		error_code, BUS_ADRALN, NULL);
+}
+
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
-- 
2.20.1

