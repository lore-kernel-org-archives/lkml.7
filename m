Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B9C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CE2214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561799654;
	bh=pTe+S1kLNJ8eE5Eq0LEy9zhxloZrSaRnxxZbVCZifl8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ssqw5DGIV+qubXRdSDvw4pRO47pXAOUvtdKmcb/U39ShFCKjriuRjtBQ07QBwsaal
	 rVOYw67mu2B3B13mhsM8J88M1srZGHGIhGVKY6G4uguxby6iLsxFkXjlh12OHEwKM1
	 techSVxO+nIonSpr1oMGUWThZNLJUxpY0MPR0NOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfF2JON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 05:14:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34356 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF2JOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 05:14:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so10818632wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I/BhM/HEG2d9Ysu06nVtRASQ8ooJecAUaIoNu5xRmJc=;
        b=fQAA9pxGhBpGxxa/4P/km2e8u4L3Nza/pF6u8sjGYf1orkGHAQZyGeXVYgCqiO2t9a
         ulLzrN9cI5LrdHYrrRwQ77vEBtVm7q0v54mu6knONvlwjkCCdReB7qoL2rXoG5ewywpi
         041YjtxsCjAXgMOMFpo4WBZw28rqEeXLwngyj1ybD07PHjKYzwCEH30htAazBT4B2mcO
         CkZ1CN5y885Qr+eeHkHtjHRkbFUHC8wQnR03TiAOkJKrHXtUZZ2y0vkWsSzkjnTyQF6p
         YKocR2tvgGgYn/JnBL1ZrKenSdelKbYYAmqsyK4WXK+LqZmPmM8EO2IHIFcLHuBvX6Gf
         DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=I/BhM/HEG2d9Ysu06nVtRASQ8ooJecAUaIoNu5xRmJc=;
        b=X4WTZuWjiP+66XN/78HZI491jUmzMkerzJLkxL3Mmpoh6gk/IXs8kJFfUR5BAP5hOp
         uxUQv58ad2sdJpuL/gleQyyCAWV8CmpE9ZssxAsARuCS5kIyQ4lmvC+r6hivp2j7zTjl
         vXPjOjsHqA5ETv7iCYOYq6WxySX1Hlvt/6/qoawkyArjmhpXbCQbARLv0/33cblSf+MA
         Ltuk+NzjVg9eNEj894Cimeg+FlaUGHr6r6wucONdAN9CBwJozXUIf/ydbLADr0kmmRZx
         uRGMy8MU7GkEc9s9GJOMCG3GDosg3Ac20C6wlwgCqawy6Z3UgWE3w1Kxhemps3xnPwxx
         g5cQ==
X-Gm-Message-State: APjAAAVT7HXYIU404sLh5SEQsP0PqXNG71bbzoRTTxYvshUMF40geIxi
        81aVXl7opdR2n5KXF2VKLY9ucJ0U
X-Google-Smtp-Source: APXvYqw1ocSqrOChevZRc5b7UHe8569M7A6QIjcY3VcUaaA+LJ2Vo84fmrE/QI5+FDo5WEQ4LIZtJA==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr9740248wma.107.1561799649535;
        Sat, 29 Jun 2019 02:14:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q193sm4014550wme.8.2019.06.29.02.14.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 02:14:09 -0700 (PDT)
Date:   Sat, 29 Jun 2019 11:14:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190629091407.GA104355@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: ae6a45a0868986f69039a2150d3b2b9ca294c378 x86/unwind/orc: Fall back to using frame pointers for generated code

Misc fixes all over the place:

- might_sleep() atomicity fix in the microcode loader
- resctrl boundary condition fix
- APIC arithmethics bug fix for frequencies >= 4.2 GHz
- three 5-level paging crash fixes
- two speculation fixes
- a perf/stacktrace fix

 Thanks,

	Ingo

------------------>
Alejandro Jimenez (1):
      x86/speculation: Allow guests to use SSBD even if host does not

Colin Ian King (1):
      x86/apic: Fix integer overflow on 10 bit left shift of cpu_khz

Josh Poimboeuf (1):
      x86/unwind/orc: Fall back to using frame pointers for generated code

Kirill A. Shutemov (3):
      x86/boot/64: Fix crash if kernel image crosses page table boundary
      x86/boot/64: Add missing fixup_pointer() for next_early_pgt access
      x86/mm: Handle physical-virtual alignment mismatch in phys_p4d_init()

Reinette Chatre (1):
      x86/resctrl: Prevent possible overrun during bitmap operations

Song Liu (1):
      perf/x86: Always store regs->ip in perf_callchain_kernel()

Thomas Gleixner (1):
      x86/microcode: Fix the microcode load on CPU hotplug for real


 arch/x86/events/core.c                 | 10 +++++-----
 arch/x86/kernel/apic/apic.c            |  3 ++-
 arch/x86/kernel/cpu/bugs.c             | 11 ++++++++++-
 arch/x86/kernel/cpu/microcode/core.c   | 15 ++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++------------------
 arch/x86/kernel/head64.c               | 20 ++++++++++---------
 arch/x86/kernel/unwind_orc.c           | 26 +++++++++++++++++++++----
 arch/x86/mm/init_64.c                  | 24 ++++++++++++-----------
 8 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..4fb3ca1e699d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2402,13 +2402,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_hw_regs(regs)) {
-		if (perf_callchain_store(entry, regs->ip))
-			return;
+	if (perf_callchain_store(entry, regs->ip))
+		return;
+
+	if (perf_hw_regs(regs))
 		unwind_start(&state, current, regs, NULL);
-	} else {
+	else
 		unwind_start(&state, current, NULL, (void *)regs->sp);
-	}
 
 	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 177aa8ef2afa..85be316665b4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1464,7 +1464,8 @@ static void apic_pending_intr_clear(void)
 		if (queued) {
 			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
 				ntsc = rdtsc();
-				max_loops = (cpu_khz << 10) - (ntsc - tsc);
+				max_loops = (long long)cpu_khz << 10;
+				max_loops -= ntsc - tsc;
 			} else {
 				max_loops--;
 			}
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 03b4cc0ec3a7..66ca906aa790 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -835,6 +835,16 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		break;
 	}
 
+	/*
+	 * If SSBD is controlled by the SPEC_CTRL MSR, then set the proper
+	 * bit in the mask to allow guests to use the mitigation even in the
+	 * case where the host does not enable it.
+	 */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
+	}
+
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
@@ -852,7 +862,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 			x86_amd_ssb_disable();
 		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
-			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 		}
 	}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index a813987b5552..cb0fdcaf1415 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -789,13 +789,16 @@ static struct syscore_ops mc_syscore_ops = {
 	.resume			= mc_bp_resume,
 };
 
-static int mc_cpu_online(unsigned int cpu)
+static int mc_cpu_starting(unsigned int cpu)
 {
-	struct device *dev;
-
-	dev = get_cpu_device(cpu);
 	microcode_update_cpu(cpu);
 	pr_debug("CPU%d added\n", cpu);
+	return 0;
+}
+
+static int mc_cpu_online(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
 
 	if (sysfs_create_group(&dev->kobj, &mc_attr_group))
 		pr_err("Failed to create group for CPU%d\n", cpu);
@@ -872,7 +875,9 @@ int __init microcode_init(void)
 		goto out_ucode_group;
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:online",
+	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
+				  mc_cpu_starting, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 869cbef5da81..f9d8ed6ab03b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -804,8 +804,12 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
-	u32 sw_shareable = 0, hw_shareable = 0;
-	u32 exclusive = 0, pseudo_locked = 0;
+	/*
+	 * Use unsigned long even though only 32 bits are used to ensure
+	 * test_bit() is used safely.
+	 */
+	unsigned long sw_shareable = 0, hw_shareable = 0;
+	unsigned long exclusive = 0, pseudo_locked = 0;
 	struct rdt_domain *dom;
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
@@ -850,10 +854,10 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		}
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
 			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
-			hwb = test_bit(i, (unsigned long *)&hw_shareable);
-			swb = test_bit(i, (unsigned long *)&sw_shareable);
-			excl = test_bit(i, (unsigned long *)&exclusive);
-			psl = test_bit(i, (unsigned long *)&pseudo_locked);
+			hwb = test_bit(i, &hw_shareable);
+			swb = test_bit(i, &sw_shareable);
+			excl = test_bit(i, &exclusive);
+			psl = test_bit(i, &pseudo_locked);
 			if (hwb && swb)
 				seq_putc(seq, 'X');
 			else if (hwb && !swb)
@@ -2494,26 +2498,19 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
  */
 static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
 {
-	/*
-	 * Convert the u32 _val to an unsigned long required by all the bit
-	 * operations within this function. No more than 32 bits of this
-	 * converted value can be accessed because all bit operations are
-	 * additionally provided with cbm_len that is initialized during
-	 * hardware enumeration using five bits from the EAX register and
-	 * thus never can exceed 32 bits.
-	 */
-	unsigned long *val = (unsigned long *)_val;
+	unsigned long val = *_val;
 	unsigned int cbm_len = r->cache.cbm_len;
 	unsigned long first_bit, zero_bit;
 
-	if (*val == 0)
+	if (val == 0)
 		return;
 
-	first_bit = find_first_bit(val, cbm_len);
-	zero_bit = find_next_zero_bit(val, cbm_len, first_bit);
+	first_bit = find_first_bit(&val, cbm_len);
+	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
 	/* Clear any remaining bits to ensure contiguous region */
-	bitmap_clear(val, zero_bit, cbm_len - zero_bit);
+	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
+	*_val = (u32)val;
 }
 
 /*
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 16b1cbd3a61e..29ffa495bd1c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -184,24 +184,25 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[next_early_pgt++], physaddr);
+		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
+				    physaddr);
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
 		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
 
-		i = (physaddr >> P4D_SHIFT) % PTRS_PER_P4D;
-		p4d[i + 0] = (pgdval_t)pud + pgtable_flags;
-		p4d[i + 1] = (pgdval_t)pud + pgtable_flags;
+		i = physaddr >> P4D_SHIFT;
+		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
 	} else {
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
 		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
 	}
 
-	i = (physaddr >> PUD_SHIFT) % PTRS_PER_PUD;
-	pud[i + 0] = (pudval_t)pmd + pgtable_flags;
-	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
+	i = physaddr >> PUD_SHIFT;
+	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
@@ -211,8 +212,9 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd_entry +=  physaddr;
 
 	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
-		int idx = i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
-		pmd[idx] = pmd_entry + i * PMD_SIZE;
+		int idx = i + (physaddr >> PMD_SHIFT);
+
+		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
 	}
 
 	/*
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 33b66b5c5aec..72b997eaa1fc 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -82,9 +82,9 @@ static struct orc_entry *orc_find(unsigned long ip);
  * But they are copies of the ftrace entries that are static and
  * defined in ftrace_*.S, which do have orc entries.
  *
- * If the undwinder comes across a ftrace trampoline, then find the
+ * If the unwinder comes across a ftrace trampoline, then find the
  * ftrace function that was used to create it, and use that ftrace
- * function's orc entrie, as the placement of the return code in
+ * function's orc entry, as the placement of the return code in
  * the stack will be identical.
  */
 static struct orc_entry *orc_ftrace_find(unsigned long ip)
@@ -128,6 +128,16 @@ static struct orc_entry null_orc_entry = {
 	.type = ORC_TYPE_CALL
 };
 
+/* Fake frame pointer entry -- used as a fallback for generated code */
+static struct orc_entry orc_fp_entry = {
+	.type		= ORC_TYPE_CALL,
+	.sp_reg		= ORC_REG_BP,
+	.sp_offset	= 16,
+	.bp_reg		= ORC_REG_PREV_SP,
+	.bp_offset	= -16,
+	.end		= 0,
+};
+
 static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
@@ -392,8 +402,16 @@ bool unwind_next_frame(struct unwind_state *state)
 	 * calls and calls to noreturn functions.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
-	if (!orc)
-		goto err;
+	if (!orc) {
+		/*
+		 * As a fallback, try to assume this code uses a frame pointer.
+		 * This is useful for generated code, like BPF, which ORC
+		 * doesn't know about.  This is just a guess, so the rest of
+		 * the unwind is no longer considered reliable.
+		 */
+		orc = &orc_fp_entry;
+		state->error = true;
+	}
 
 	/* End-of-stack check for kernel threads: */
 	if (orc->sp_reg == ORC_REG_UNDEFINED) {
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 693aaf28d5fe..0f01c7b1d217 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -671,23 +671,25 @@ static unsigned long __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, bool init)
 {
-	unsigned long paddr_next, paddr_last = paddr_end;
-	unsigned long vaddr = (unsigned long)__va(paddr);
-	int i = p4d_index(vaddr);
+	unsigned long vaddr, vaddr_end, vaddr_next, paddr_next, paddr_last;
+
+	paddr_last = paddr_end;
+	vaddr = (unsigned long)__va(paddr);
+	vaddr_end = (unsigned long)__va(paddr_end);
 
 	if (!pgtable_l5_enabled())
 		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
 				     page_size_mask, init);
 
-	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
-		p4d_t *p4d;
+	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
+		p4d_t *p4d = p4d_page + p4d_index(vaddr);
 		pud_t *pud;
 
-		vaddr = (unsigned long)__va(paddr);
-		p4d = p4d_page + p4d_index(vaddr);
-		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
+		vaddr_next = (vaddr & P4D_MASK) + P4D_SIZE;
+		paddr = __pa(vaddr);
 
 		if (paddr >= paddr_end) {
+			paddr_next = __pa(vaddr_next);
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
@@ -699,13 +701,13 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 
 		if (!p4d_none(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			paddr_last = phys_pud_init(pud, paddr, paddr_end,
-						   page_size_mask, init);
+			paddr_last = phys_pud_init(pud, paddr, __pa(vaddr_end),
+					page_size_mask, init);
 			continue;
 		}
 
 		pud = alloc_low_page();
-		paddr_last = phys_pud_init(pud, paddr, paddr_end,
+		paddr_last = phys_pud_init(pud, paddr, __pa(vaddr_end),
 					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
