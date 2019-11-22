Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79574C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334F52071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivM/OUuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKVP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:27:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKVP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vb/gixP6zF1umJNizUrdqArA9btyR/z5iBUb//XsOc8=; b=ivM/OUuc2xVarlnW5jSylqC1e
        Qpo9cXYiKYjSATVPCDYBMhcjm8l5Rh+yBlrsnwVanwTwYZYL5XalYm7/B9iTCjyATEiecWH3tbMb8
        xnEWtzc1Y6+zLs2d6gy9bxbzdlUFnyi7lEmRliW8jTz1wLhvsVzLqoXnzspq83EEDl/vvG3BMiUQP
        xMKa7PJI9k8ou7PRLb1CGLELSRKDrD0DAhOQnTXmOkF52Y7SyNgyQ2M73l41fsXei/YczLANf/Oet
        0aOyyr2zO7W1Nmv0R4Fdv8P8qx8Da5apuK0KxO5dbKmm3EwrQCFbmezo+fhxi2CzVHCWVDMGbYxw/
        gvb+rChOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYAq5-0001gq-MR; Fri, 22 Nov 2019 15:27:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4188330068E;
        Fri, 22 Nov 2019 16:26:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 903D620B2867E; Fri, 22 Nov 2019 16:27:15 +0100 (CET)
Date:   Fri, 22 Nov 2019 16:27:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122152715.GA1909@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122105141.GY4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:51:41AM +0100, Peter Zijlstra wrote:

> A non-lethal default enabled variant would be even better for them :-)

fresh from the keyboard, *completely* untested.

it requires we get the kernel and firmware clean, but only warns about
dodgy userspace, which I really don't think there is much of.

getting the kernel clean should be pretty simple.

---
 Documentation/admin-guide/kernel-parameters.txt |  18 +++
 arch/x86/include/asm/cpu.h                      |  17 +++
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/msr-index.h                |   8 ++
 arch/x86/include/asm/thread_info.h              |   6 +-
 arch/x86/include/asm/traps.h                    |   1 +
 arch/x86/kernel/cpu/common.c                    |   2 +
 arch/x86/kernel/cpu/intel.c                     | 165 ++++++++++++++++++++++++
 arch/x86/kernel/process.c                       |   3 +
 arch/x86/kernel/traps.c                         |  28 +++-
 10 files changed, 246 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9983ac73b66d..18f15defdba6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3172,6 +3172,24 @@
 
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
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..fa75bbd502b3 100644
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
+extern void switch_sld(void);
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
index 6a3124664289..7b25cec494fd 100644
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
index b25e633033c3..2a7cfe8e8c3f 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -172,4 +172,5 @@ enum x86_pf_error_code {
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
 };
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4fc016bc6abd..a6b176fc3996 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1233,6 +1233,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
+	cpu_set_core_cap_bits(c);
+
 	fpu__init_system(c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4a900804a023..d83b8031a124 100644
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
@@ -1028,3 +1042,154 @@ static const struct cpu_dev intel_cpu_dev = {
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
+	{ "force",	sld_force },
+};
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
+	if (rdmsrl_safe(MSR_TEST_CTRL, test_ctrl_val))
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
+	u64 test_ctrl_val;
+
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
+	__sld_set_all(sld_off);
+}
+
+void handle_split_lock(void)
+{
+	return sld_state != sld_off;
+}
+
+void handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if (sld_state == sld_fatal)
+		return false;
+
+	pr_alert("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
+		 current->comm, current->pid, regs->ip);
+
+	__sld_set_msr(false);
+	set_tsk_thread_flag(current, TIF_CLD);
+	return true;
+}
+
+void switch_sld(struct task_struct *prev)
+{
+	__sld_set_msr(true);
+	clear_tsk_thread_flag(current, TIF_CLD);
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
index bd2a11ca5dd6..c04476a1f970 100644
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
index 3451a004e162..3cba28c9c4d9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -242,7 +242,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 {
 	struct task_struct *tsk = current;
 
-
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
 
@@ -288,9 +287,34 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
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
