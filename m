Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC912C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E86206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDHObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:31:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:30:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x38ETlTZ4100787
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 8 Apr 2019 07:29:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x38ETkOn4100784;
        Mon, 8 Apr 2019 07:29:46 -0700
Date:   Mon, 8 Apr 2019 07:29:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-67e87d43b794a8886b5d075b3e0fdd0c615a595f@git.kernel.org>
Cc:     linux@dominikbrodowski.net, rafael.j.wysocki@intel.com,
        jroedel@suse.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dave.hansen@intel.com, mingo@kernel.org, konrad.wilk@oracle.com,
        tony.luck@intel.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, nadav.amit@gmail.com, bp@suse.de,
        riel@surriel.com, Thomas.Lendacky@amd.com, jannh@google.com,
        hpa@zytor.com, peterz@infradead.org, mhiramat@kernel.org,
        aubrey.li@intel.com
Reply-To: rafael.j.wysocki@intel.com, linux@dominikbrodowski.net,
          jroedel@suse.de, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, mingo@redhat.com, bigeasy@linutronix.de,
          mingo@kernel.org, konrad.wilk@oracle.com, tony.luck@intel.com,
          tglx@linutronix.de, kirill.shutemov@linux.intel.com, bp@suse.de,
          nadav.amit@gmail.com, jannh@google.com, Thomas.Lendacky@amd.com,
          riel@surriel.com, hpa@zytor.com, peterz@infradead.org,
          mhiramat@kernel.org, aubrey.li@intel.com
In-Reply-To: <20190330112022.28888-3-bp@alien8.de>
References: <20190330112022.28888-3-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86: Convert some slow-path static_cpu_has() callers
 to boot_cpu_has()
Git-Commit-ID: 67e87d43b794a8886b5d075b3e0fdd0c615a595f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  67e87d43b794a8886b5d075b3e0fdd0c615a595f
Gitweb:     https://git.kernel.org/tip/67e87d43b794a8886b5d075b3e0fdd0c615a595f
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 29 Mar 2019 19:52:59 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 8 Apr 2019 12:13:34 +0200

x86: Convert some slow-path static_cpu_has() callers to boot_cpu_has()

Using static_cpu_has() is pointless on those paths, convert them to the
boot_cpu_has() variant.

No functional changes.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Juergen Gross <jgross@suse.com> # for paravirt
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: linux-edac@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190330112022.28888-3-bp@alien8.de
---
 arch/x86/include/asm/fpu/internal.h  |  7 +++----
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/cpu/aperfmperf.c     |  6 +++---
 arch/x86/kernel/cpu/common.c         |  2 +-
 arch/x86/kernel/cpu/mce/inject.c     |  2 +-
 arch/x86/kernel/cpu/proc.c           | 10 +++++-----
 arch/x86/kernel/ldt.c                | 14 +++++++-------
 arch/x86/kernel/paravirt.c           |  2 +-
 arch/x86/kernel/process.c            |  4 ++--
 arch/x86/kernel/reboot.c             |  2 +-
 arch/x86/kernel/vm86_32.c            |  2 +-
 11 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index fb04a3ded7dd..745a19d34f23 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -253,7 +253,7 @@ static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
 
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 	else
 		XSTATE_OP(XSAVE, xstate, lmask, hmask, err);
@@ -275,7 +275,7 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
 
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
 		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
@@ -497,8 +497,7 @@ static inline void fpregs_activate(struct fpu *fpu)
  *  - switch_fpu_finish() restores the new state as
  *    necessary.
  */
-static inline void
-switch_fpu_prepare(struct fpu *old_fpu, int cpu)
+static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && old_fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 78778b54f904..a5464b8b6c46 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -175,7 +175,7 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 	this_cpu_write(cpu_llc_id, node);
 
 	/* Account for nodes per socket in multi-core-module processors */
-	if (static_cpu_has(X86_FEATURE_NODEID_MSR)) {
+	if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
 		rdmsrl(MSR_FAM10H_NODE_ID, val);
 		nodes = ((val >> 3) & 7) + 1;
 	}
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 804c49493938..64d5aec24203 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -83,7 +83,7 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!cpu_khz)
 		return 0;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
@@ -99,7 +99,7 @@ void arch_freq_prepare_all(void)
 	if (!cpu_khz)
 		return;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
 	for_each_online_cpu(cpu)
@@ -115,7 +115,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!cpu_khz)
 		return 0;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..95a5faf3a6a0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1668,7 +1668,7 @@ static void setup_getcpu(int cpu)
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
 
-	if (static_cpu_has(X86_FEATURE_RDTSCP))
+	if (boot_cpu_has(X86_FEATURE_RDTSCP))
 		write_rdtscp_aux(cpudata);
 
 	/* Store CPU and node number in limit. */
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 8492ef7d9015..3da9a8823e47 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -528,7 +528,7 @@ static void do_inject(void)
 	 * only on the node base core. Refer to D18F3x44[NbMcaToMstCpuEn] for
 	 * Fam10h and later BKDGs.
 	 */
-	if (static_cpu_has(X86_FEATURE_AMD_DCM) &&
+	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
 		toggle_nb_mca_mst_cpu(amd_get_nb_id(cpu));
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 2c8522a39ed5..cb2e49810d68 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -35,11 +35,11 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 		   "fpu_exception\t: %s\n"
 		   "cpuid level\t: %d\n"
 		   "wp\t\t: yes\n",
-		   static_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
-		   static_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
-		   static_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
-		   static_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
-		   static_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   boot_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
+		   boot_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
+		   boot_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
+		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
 		   c->cpuid_level);
 }
 #else
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 6135ae8ce036..b2463fcb20a8 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -113,7 +113,7 @@ static void do_sanity_check(struct mm_struct *mm,
 		 * tables.
 		 */
 		WARN_ON(!had_kernel_mapping);
-		if (static_cpu_has(X86_FEATURE_PTI))
+		if (boot_cpu_has(X86_FEATURE_PTI))
 			WARN_ON(!had_user_mapping);
 	} else {
 		/*
@@ -121,7 +121,7 @@ static void do_sanity_check(struct mm_struct *mm,
 		 * Sync the pgd to the usermode tables.
 		 */
 		WARN_ON(had_kernel_mapping);
-		if (static_cpu_has(X86_FEATURE_PTI))
+		if (boot_cpu_has(X86_FEATURE_PTI))
 			WARN_ON(had_user_mapping);
 	}
 }
@@ -156,7 +156,7 @@ static void map_ldt_struct_to_user(struct mm_struct *mm)
 	k_pmd = pgd_to_pmd_walk(k_pgd, LDT_BASE_ADDR);
 	u_pmd = pgd_to_pmd_walk(u_pgd, LDT_BASE_ADDR);
 
-	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+	if (boot_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
 		set_pmd(u_pmd, *k_pmd);
 }
 
@@ -181,7 +181,7 @@ static void map_ldt_struct_to_user(struct mm_struct *mm)
 {
 	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
 
-	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+	if (boot_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
 		set_pgd(kernel_to_user_pgdp(pgd), *pgd);
 }
 
@@ -208,7 +208,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	spinlock_t *ptl;
 	int i, nr_pages;
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return 0;
 
 	/*
@@ -271,7 +271,7 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 		return;
 
 	/* LDT map/unmap is only required for PTI */
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
@@ -311,7 +311,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	unsigned long start = LDT_BASE_ADDR;
 	unsigned long end = LDT_END_ADDR;
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	tlb_gather_mmu(&tlb, mm, start, end);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c0e0101133f3..7bbaa6baf37f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -121,7 +121,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58ac7be52c7a..16a7113e91c5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -236,7 +236,7 @@ static int get_cpuid_mode(void)
 
 static int set_cpuid_mode(struct task_struct *task, unsigned long cpuid_enabled)
 {
-	if (!static_cpu_has(X86_FEATURE_CPUID_FAULT))
+	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
 		return -ENODEV;
 
 	if (cpuid_enabled)
@@ -666,7 +666,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (!cpu_has(c, X86_FEATURE_MWAIT) || static_cpu_has_bug(X86_BUG_MONITOR))
+	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
 		return 0;
 
 	return 1;
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 725624b6c0c0..d62ebbc5ec78 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -108,7 +108,7 @@ void __noreturn machine_real_restart(unsigned int type)
 	write_cr3(real_mode_header->trampoline_pgd);
 
 	/* Exiting long mode will fail if CR4.PCIDE is set. */
-	if (static_cpu_has(X86_FEATURE_PCID))
+	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4_clear_bits(X86_CR4_PCIDE);
 #endif
 
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index a092b6b40c6b..6a38717d179c 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -369,7 +369,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	preempt_disable();
 	tsk->thread.sp0 += 16;
 
-	if (static_cpu_has(X86_FEATURE_SEP)) {
+	if (boot_cpu_has(X86_FEATURE_SEP)) {
 		tsk->thread.sysenter_cs = 0;
 		refresh_sysenter_cs(&tsk->thread);
 	}
