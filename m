Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE572190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfIAGNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 02:13:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55190 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIAGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 02:13:44 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i4J7K-0007Lv-HA; Sun, 01 Sep 2019 08:13:38 +0200
Date:   Sun, 01 Sep 2019 06:07:33 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc7
References: <156731805398.16551.16721065723173566021.tglx@nanos.tec.linutronix.de>
Message-ID: <156731805398.16551.14162357872200269955.tglx@nanos.tec.linutronix.de>
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

up to:  7af0145067bc: x86/mm/cpa: Prevent large page split when ftrace flips RW on kernel text

A set of fixes for x86:

 - Fix the bogus detection of 32bit user mode for uretprobes which caused
   corruption of the user return address resulting in application
   crashes. In the uprobes handler in_ia32_syscall() is obviously always
   returning false on a 64bit kernel. Use user_64bit_mode() instead which
   works correctly.

 - Prevent large page splitting when ftrace flips RW/RO on the kernel text
   which caused iTLB performance issues. Ftrace wants to be converted to
   text_poke() which avoids the problem, but for now allow large page
   preservation in the static protections check when the change request
   spawns a full large page.

 - Prevent arch_dynirq_lower_bound() from returning 0 when the IOAPIC is
   configured via device tree. In the device tree case the GSI 1:1 mapping
   is meaningless therefore the lower bound which protects the GSI range on
   ACPI machines is irrelevant. Return the lower bound which the core hands
   to the function instead of blindly returning 0 which causes the core to
   allocate the invalid virtual interupt number 0 which in turn prevents
   all drivers from allocating and requesting an interrupt.

 - Remove the bogus initialization of LDR and DFR in the 32bit bigsmp APIC
   driver. That uses physical destination mode where LDR/DFR are ignored,
   but the initialization and the missing clear of LDR caused the APIC to
   be left in a inconsistent state on kexec/reboot.

 - Clear LDR when clearing the APIC registers so the APIC is in a well
   defined state.

 - Initialize variables proper in the find_trampoline_placement() code.

 - Silence GCC( build warning for the real mode part of the build

Thanks,

	tglx

------------------>
Bandan Das (2):
      x86/apic: Do not initialize LDR and DFR for bigsmp
      x86/apic: Include the LDR when clearing out APIC registers

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Fix missing initialization in find_trampoline_placement()

Linus Torvalds (1):
      x86/build: Add -Wnoaddress-of-packed-member to REALMODE_CFLAGS, to silence GCC9 build warning

Sebastian Mayr (1):
      uprobes/x86: Fix detection of 32-bit user mode

Thomas Gleixner (2):
      x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines
      x86/mm/cpa: Prevent large page split when ftrace flips RW on kernel text


 arch/x86/Makefile                     |  1 +
 arch/x86/boot/compressed/pgtable_64.c |  2 +-
 arch/x86/kernel/apic/apic.c           |  4 ++++
 arch/x86/kernel/apic/bigsmp_32.c      | 24 ++----------------------
 arch/x86/kernel/apic/io_apic.c        |  8 +++++++-
 arch/x86/kernel/uprobes.c             | 17 ++++++++++-------
 arch/x86/mm/pageattr.c                | 26 ++++++++++++++++++--------
 7 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 56e748a7679f..94df0868804b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -38,6 +38,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
 export REALMODE_CFLAGS
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2faddeb0398a..c8862696a47b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -72,7 +72,7 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
-		unsigned long new;
+		unsigned long new = bios_start;
 
 		entry = &boot_params->e820_table[i];
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index aa5495d0f478..dba2828b779a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1179,6 +1179,10 @@ void clear_local_APIC(void)
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 	v = apic_read(APIC_LVT1);
 	apic_write(APIC_LVT1, v | APIC_LVT_MASKED);
+	if (!x2apic_enabled()) {
+		v = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+		apic_write(APIC_LDR, v);
+	}
 	if (maxlvt >= 4) {
 		v = apic_read(APIC_LVTPC);
 		apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index afee386ff711..caedd8d60d36 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -38,32 +38,12 @@ static int bigsmp_early_logical_apicid(int cpu)
 	return early_per_cpu(x86_cpu_to_apicid, cpu);
 }
 
-static inline unsigned long calculate_ldr(int cpu)
-{
-	unsigned long val, id;
-
-	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
-	id = per_cpu(x86_bios_cpu_apicid, cpu);
-	val |= SET_APIC_LOGICAL_ID(id);
-
-	return val;
-}
-
 /*
- * Set up the logical destination ID.
- *
- * Intel recommends to set DFR, LDR and TPR before enabling
- * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
- * document number 292116).  So here it goes...
+ * bigsmp enables physical destination mode
+ * and doesn't use LDR and DFR
  */
 static void bigsmp_init_apic_ldr(void)
 {
-	unsigned long val;
-	int cpu = smp_processor_id();
-
-	apic_write(APIC_DFR, APIC_DFR_FLAT);
-	val = calculate_ldr(cpu);
-	apic_write(APIC_LDR, val);
 }
 
 static void bigsmp_setup_apic_routing(void)
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c7bb6c69f21c..d6af97fd170a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2438,7 +2438,13 @@ unsigned int arch_dynirq_lower_bound(unsigned int from)
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	return ioapic_initialized ? ioapic_dynirq_base : gsi_top;
+	if (!ioapic_initialized)
+		return gsi_top;
+	/*
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
+	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 */
+	return ioapic_dynirq_base ? : from;
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index d8359ebeea70..8cd745ef8c7b 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -508,9 +508,12 @@ struct uprobe_xol_ops {
 	void	(*abort)(struct arch_uprobe *, struct pt_regs *);
 };
 
-static inline int sizeof_long(void)
+static inline int sizeof_long(struct pt_regs *regs)
 {
-	return in_ia32_syscall() ? 4 : 8;
+	/*
+	 * Check registers for mode as in_xxx_syscall() does not apply here.
+	 */
+	return user_64bit_mode(regs) ? 8 : 4;
 }
 
 static int default_pre_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
@@ -521,9 +524,9 @@ static int default_pre_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 static int emulate_push_stack(struct pt_regs *regs, unsigned long val)
 {
-	unsigned long new_sp = regs->sp - sizeof_long();
+	unsigned long new_sp = regs->sp - sizeof_long(regs);
 
-	if (copy_to_user((void __user *)new_sp, &val, sizeof_long()))
+	if (copy_to_user((void __user *)new_sp, &val, sizeof_long(regs)))
 		return -EFAULT;
 
 	regs->sp = new_sp;
@@ -556,7 +559,7 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
 		long correction = utask->vaddr - utask->xol_vaddr;
 		regs->ip += correction;
 	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
-		regs->sp += sizeof_long(); /* Pop incorrect return address */
+		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
 		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
 			return -ERESTART;
 	}
@@ -675,7 +678,7 @@ static int branch_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	 * "call" insn was executed out-of-line. Just restore ->sp and restart.
 	 * We could also restore ->ip and try to call branch_emulate_op() again.
 	 */
-	regs->sp += sizeof_long();
+	regs->sp += sizeof_long(regs);
 	return -ERESTART;
 }
 
@@ -1056,7 +1059,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs)
 {
-	int rasize = sizeof_long(), nleft;
+	int rasize = sizeof_long(regs), nleft;
 	unsigned long orig_ret_vaddr = 0; /* clear high bits for 32-bit apps */
 
 	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp, rasize))
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 6a9a77a403c9..e14e95ea7338 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -516,7 +516,7 @@ static inline void check_conflict(int warnlvl, pgprot_t prot, pgprotval_t val,
  */
 static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 					  unsigned long pfn, unsigned long npg,
-					  int warnlvl)
+					  unsigned long lpsize, int warnlvl)
 {
 	pgprotval_t forbidden, res;
 	unsigned long end;
@@ -535,9 +535,17 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
 	forbidden = res;
 
-	res = protect_kernel_text_ro(start, end);
-	check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
-	forbidden |= res;
+	/*
+	 * Special case to preserve a large page. If the change spawns the
+	 * full large page mapping then there is no point to split it
+	 * up. Happens with ftrace and is going to be removed once ftrace
+	 * switched to text_poke().
+	 */
+	if (lpsize != (npg * PAGE_SIZE) || (start & (lpsize - 1))) {
+		res = protect_kernel_text_ro(start, end);
+		check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
+		forbidden |= res;
+	}
 
 	/* Check the PFN directly */
 	res = protect_pci_bios(pfn, pfn + npg - 1);
@@ -819,7 +827,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * extra conditional required here.
 	 */
 	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
-				      CPA_CONFLICT);
+				      psize, CPA_CONFLICT);
 
 	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
 		/*
@@ -855,7 +863,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * protection requirement in the large page.
 	 */
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
-				      CPA_DETECT);
+				      psize, CPA_DETECT);
 
 	/*
 	 * If there is a conflict, split the large page.
@@ -906,7 +914,8 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 	if (!cpa->force_static_prot)
 		goto set;
 
-	prot = static_protections(ref_prot, address, pfn, npg, CPA_PROTECT);
+	/* Hand in lpsize = 0 to enforce the protection mechanism */
+	prot = static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT);
 
 	if (pgprot_val(prot) == pgprot_val(ref_prot))
 		goto set;
@@ -1503,7 +1512,8 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
 		cpa_inc_4k_install();
-		new_prot = static_protections(new_prot, address, pfn, 1,
+		/* Hand in lpsize = 0 to enforce the protection mechanism */
+		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);


