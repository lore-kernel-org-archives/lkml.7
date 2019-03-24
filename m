Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778A3222E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfCXOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:08 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83sy-0001zO-TT; Sun, 24 Mar 2019 15:14:05 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86 updates for 5.1
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Message-ID: <155343674152.28403.17446642093501773007.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of x86 fixes:

 - Prevent potential NULL pointer dereferences in the HPET and HyperV code

 - Exclude the GART aperture from /proc/kcore to prevent kernel crashes on
   access
 
 - Use the correct macros for Cyrix I/O on Geode processors

 - Remove yet another kernel address printk leak

 - Announce microcode reload completion as requested by quite some
   people. Microcode loading has become popular recently.

 - Same 'Make Clang' happy fixlets

 - A few cleanups for recently added code

Thanks,

	tglx

------------------>
Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Borislav Petkov (1):
      x86/microcode: Announce reload operation's completion

Colin Ian King (1):
      x86/lib: Fix indentation issue, remove extra tab

Ingo Molnar (1):
      x86/cpufeature: Fix various quality problems in the <asm/cpu_device_hd.h> header

Kairui Song (1):
      x86/gart: Exclude GART aperture from kcore

Kangjie Lu (1):
      x86/hyperv: Prevent potential NULL pointer dereference

Matteo Croce (1):
      x86/mm: Don't leak kernel addresses

Matthew Whitehead (2):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors
      x86/cpu/cyrix: Remove {get,set}Cx86_old macros used for Cyrix processors

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error

Nick Desaulniers (1):
      x86/boot: Restrict header scope to make Clang happy

Valdis Kletnieks (1):
      x86/mm/pti: Make local symbols static


 arch/x86/boot/string.c                 |  3 ++-
 arch/x86/hyperv/hv_init.c              |  6 +++++-
 arch/x86/include/asm/cpu_device_id.h   | 31 +++++++++++++++----------------
 arch/x86/include/asm/processor-cyrix.h | 21 ---------------------
 arch/x86/kernel/aperture_64.c          | 20 +++++++++++++-------
 arch/x86/kernel/cpu/cyrix.c            | 14 +++++++-------
 arch/x86/kernel/cpu/microcode/core.c   |  2 ++
 arch/x86/kernel/hpet.c                 |  2 ++
 arch/x86/kernel/hw_breakpoint.c        |  1 +
 arch/x86/kernel/mpparse.c              |  4 ++--
 arch/x86/lib/csum-partial_64.c         |  2 +-
 arch/x86/mm/pti.c                      |  4 ++--
 fs/proc/kcore.c                        | 27 +++++++++++++++++++++++++++
 include/linux/kcore.h                  |  2 ++
 14 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 315a67b8896b..90154df8f125 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,8 +13,9 @@
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6461a16b4559..e4ba467a9fc6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -103,9 +103,13 @@ static int hv_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
+	struct page *pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*input_arg = page_address(alloc_page(GFP_KERNEL));
+	pg = alloc_page(GFP_KERNEL);
+	if (unlikely(!pg))
+		return -ENOMEM;
+	*input_arg = page_address(pg);
 
 	hv_get_vp_index(msr_vp_index);
 
diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 3417110574c1..31c379c1da41 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _CPU_DEVICE_ID
-#define _CPU_DEVICE_ID 1
+#ifndef _ASM_X86_CPU_DEVICE_ID
+#define _ASM_X86_CPU_DEVICE_ID
 
 /*
  * Declare drivers belonging to specific x86 CPUs
@@ -9,8 +9,6 @@
 
 #include <linux/mod_devicetable.h>
 
-extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
-
 /*
  * Match specific microcode revisions.
  *
@@ -22,21 +20,22 @@ extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
  */
 
 struct x86_cpu_desc {
-	__u8	x86_family;
-	__u8	x86_vendor;
-	__u8	x86_model;
-	__u8	x86_stepping;
-	__u32	x86_microcode_rev;
+	u8	x86_family;
+	u8	x86_vendor;
+	u8	x86_model;
+	u8	x86_stepping;
+	u32	x86_microcode_rev;
 };
 
-#define INTEL_CPU_DESC(mod, step, rev) {			\
-	.x86_family = 6,					\
-	.x86_vendor = X86_VENDOR_INTEL,				\
-	.x86_model = mod,					\
-	.x86_stepping = step,					\
-	.x86_microcode_rev = rev,				\
+#define INTEL_CPU_DESC(model, stepping, revision) {		\
+	.x86_family		= 6,				\
+	.x86_vendor		= X86_VENDOR_INTEL,		\
+	.x86_model		= (model),			\
+	.x86_stepping		= (stepping),			\
+	.x86_microcode_rev	= (revision),			\
 }
 
+extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
 
-#endif
+#endif /* _ASM_X86_CPU_DEVICE_ID */
diff --git a/arch/x86/include/asm/processor-cyrix.h b/arch/x86/include/asm/processor-cyrix.h
index aaedd73ea2c6..df700a6cc869 100644
--- a/arch/x86/include/asm/processor-cyrix.h
+++ b/arch/x86/include/asm/processor-cyrix.h
@@ -3,19 +3,6 @@
  * NSC/Cyrix CPU indexed register access. Must be inlined instead of
  * macros to ensure correct access ordering
  * Access order is always 0x22 (=offset), 0x23 (=value)
- *
- * When using the old macros a line like
- *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
- * gets expanded to:
- *  do {
- *    outb((CX86_CCR2), 0x22);
- *    outb((({
- *        outb((CX86_CCR2), 0x22);
- *        inb(0x23);
- *    }) | 0x88), 0x23);
- *  } while (0);
- *
- * which in fact violates the access order (= 0x22, 0x22, 0x23, 0x23).
  */
 
 static inline u8 getCx86(u8 reg)
@@ -29,11 +16,3 @@ static inline void setCx86(u8 reg, u8 data)
 	outb(reg, 0x22);
 	outb(data, 0x23);
 }
-
-#define getCx86_old(reg) ({ outb((reg), 0x22); inb(0x23); })
-
-#define setCx86_old(reg, data) do { \
-	outb((reg), 0x22); \
-	outb((data), 0x23); \
-} while (0)
-
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 58176b56354e..294ed4392a0e 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "AGP: " fmt
 
 #include <linux/kernel.h>
+#include <linux/kcore.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
@@ -57,7 +58,7 @@ int fallback_aper_force __initdata;
 
 int fix_aperture __initdata = 1;
 
-#ifdef CONFIG_PROC_VMCORE
+#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
 /*
  * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
  * use the same range because it will remain configured in the northbridge.
@@ -66,20 +67,25 @@ int fix_aperture __initdata = 1;
  */
 static unsigned long aperture_pfn_start, aperture_page_count;
 
-static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+static int gart_mem_pfn_is_ram(unsigned long pfn)
 {
 	return likely((pfn < aperture_pfn_start) ||
 		      (pfn >= aperture_pfn_start + aperture_page_count));
 }
 
-static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+static void __init exclude_from_core(u64 aper_base, u32 aper_order)
 {
 	aperture_pfn_start = aper_base >> PAGE_SHIFT;
 	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
-	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+#ifdef CONFIG_PROC_VMCORE
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_mem_pfn_is_ram));
+#endif
+#ifdef CONFIG_PROC_KCORE
+	WARN_ON(register_mem_pfn_is_ram(&gart_mem_pfn_is_ram));
+#endif
 }
 #else
-static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+static void exclude_from_core(u64 aper_base, u32 aper_order)
 {
 }
 #endif
@@ -474,7 +480,7 @@ int __init gart_iommu_hole_init(void)
 			 * may have allocated the range over its e820 RAM
 			 * and fixed up the northbridge
 			 */
-			exclude_from_vmcore(last_aper_base, last_aper_order);
+			exclude_from_core(last_aper_base, last_aper_order);
 
 			return 1;
 		}
@@ -520,7 +526,7 @@ int __init gart_iommu_hole_init(void)
 	 * overlap with the first kernel's memory. We can't access the
 	 * range through vmcore even though it should be part of the dump.
 	 */
-	exclude_from_vmcore(aper_alloc, aper_order);
+	exclude_from_core(aper_alloc, aper_order);
 
 	/* Fix up the north bridges */
 	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index d12226f60168..1d9b8aaea06c 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -124,7 +124,7 @@ static void set_cx86_reorder(void)
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN */
 
 	/* Load/Store Serialize to mem access disable (=reorder it) */
-	setCx86_old(CX86_PCR0, getCx86_old(CX86_PCR0) & ~0x80);
+	setCx86(CX86_PCR0, getCx86(CX86_PCR0) & ~0x80);
 	/* set load/store serialize from 1GB to 4GB */
 	ccr3 |= 0xe0;
 	setCx86(CX86_CCR3, ccr3);
@@ -135,11 +135,11 @@ static void set_cx86_memwb(void)
 	pr_info("Enable Memory-Write-back mode on Cyrix/NSC processor.\n");
 
 	/* CCR2 bit 2: unlock NW bit */
-	setCx86_old(CX86_CCR2, getCx86_old(CX86_CCR2) & ~0x04);
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) & ~0x04);
 	/* set 'Not Write-through' */
 	write_cr0(read_cr0() | X86_CR0_NW);
 	/* CCR2 bit 2: lock NW bit and set WT1 */
-	setCx86_old(CX86_CCR2, getCx86_old(CX86_CCR2) | 0x14);
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x14);
 }
 
 /*
@@ -153,14 +153,14 @@ static void geode_configure(void)
 	local_irq_save(flags);
 
 	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86_old(CX86_CCR2, getCx86_old(CX86_CCR2) | 0x88);
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */
 
 
 	/* FPU fast, DTE cache, Mem bypass */
-	setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x38);
+	setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x38);
 	setCx86(CX86_CCR3, ccr3);			/* disable MAPEN */
 
 	set_cx86_memwb();
@@ -296,7 +296,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
 			/* Enable cxMMX extensions (GX1 Datasheet 54) */
-			setCx86_old(CX86_CCR7, getCx86_old(CX86_CCR7) | 1);
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
 
 			/*
 			 * GXm : 0x30 ... 0x5f GXm  datasheet 51
@@ -319,7 +319,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		if (dir1 > 7) {
 			dir0_msn++;  /* M II */
 			/* Enable MMX extensions (App note 108) */
-			setCx86_old(CX86_CCR7, getCx86_old(CX86_CCR7)|1);
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7)|1);
 		} else {
 			/* A 6x86MX - it has the bug. */
 			set_cpu_bug(c, X86_BUG_COMA);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 97f9ada9ceda..5260185cbf7b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -608,6 +608,8 @@ static int microcode_reload_late(void)
 	if (ret > 0)
 		microcode_check();
 
+	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index dfd3aca82c61..fb32925a2e62 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -905,6 +905,8 @@ int __init hpet_enable(void)
 		return 0;
 
 	hpet_set_mapping();
+	if (!hpet_virt_address)
+		return 0;
 
 	/*
 	 * Read the period and check for a sane value:
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index ff9bfd40429e..d73083021002 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -354,6 +354,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 #endif
 	default:
 		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/*
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 3482460d984d..1bfe5c6e6cfe 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -598,8 +598,8 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 			mpf_base = base;
 			mpf_found = true;
 
-			pr_info("found SMP MP-table at [mem %#010lx-%#010lx] mapped at [%p]\n",
-				base, base + sizeof(*mpf) - 1, mpf);
+			pr_info("found SMP MP-table at [mem %#010lx-%#010lx]\n",
+				base, base + sizeof(*mpf) - 1);
 
 			memblock_reserve(base, sizeof(*mpf));
 			if (mpf->physptr)
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 9baca3e054be..e7925d668b68 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -94,7 +94,7 @@ static unsigned do_csum(const unsigned char *buff, unsigned len)
 				    : "m" (*(unsigned long *)buff), 
 				    "r" (zero),  "0" (result));
 				--count; 
-					buff += 8;
+				buff += 8;
 			}
 			result = add32_with_carry(result>>32,
 						  result&0xffffffff); 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4fee5c3003ed..139b28a01ce4 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -77,7 +77,7 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
-enum pti_mode {
+static enum pti_mode {
 	PTI_AUTO = 0,
 	PTI_FORCE_OFF,
 	PTI_FORCE_ON
@@ -602,7 +602,7 @@ static void pti_clone_kernel_text(void)
 	set_memory_global(start, (end_global - start) >> PAGE_SHIFT);
 }
 
-void pti_set_kernel_image_nonglobal(void)
+static void pti_set_kernel_image_nonglobal(void)
 {
 	/*
 	 * The identity map is created with PMDs, regardless of the
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..d29d869abec1 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -54,6 +54,28 @@ static LIST_HEAD(kclist_head);
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
+/*
+ * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
+ * Same as oldmem_pfn_is_ram in vmcore
+ */
+static int (*mem_pfn_is_ram)(unsigned long pfn);
+
+int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn))
+{
+	if (mem_pfn_is_ram)
+		return -EBUSY;
+	mem_pfn_is_ram = fn;
+	return 0;
+}
+
+static int pfn_is_ram(unsigned long pfn)
+{
+	if (mem_pfn_is_ram)
+		return mem_pfn_is_ram(pfn);
+	else
+		return 1;
+}
+
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
 void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 		       int type)
@@ -465,6 +487,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				goto out;
 			}
 			m = NULL;	/* skip the list anchor */
+		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
+			if (clear_user(buffer, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 8c3f8c14eeaa..c843f4a9c512 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -44,6 +44,8 @@ void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
 	m->vaddr = (unsigned long)vaddr;
 	kclist_add(m, addr, sz, KCORE_REMAP);
 }
+
+extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)

