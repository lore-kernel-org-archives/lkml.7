Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF3C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C77A214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGIMeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:34:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:34:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkpJq-0006GZ-F6; Tue, 09 Jul 2019 14:34:02 +0200
Date:   Tue, 09 Jul 2019 12:33:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/kdump for 5.3-rc1
References: <156267559466.6547.5675975755906539836.tglx@nanos.tec.linutronix.de>
Message-ID: <156267559466.6547.2199213187743143427.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-kdump-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

up to:  4eb5fec31e61: fs/proc/vmcore: Enable dumping of encrypted memory when SEV was active

Yet more kexec/kdump updates:

  - Properly support kexec when AMD's memory encryption (SME) is enabled

  - Pass reserved e820 ranges to the kexec kernel so both PCI and SME can
    work.
    


Thanks,

	tglx

------------------>
Lianbo Jiang (6):
      x86/e820, ioport: Add a new I/O resource descriptor IORES_DESC_RESERVED
      x86/mm: Rework ioremap resource mapping determination
      x86/crash: Add e820 reserved ranges to kdump kernel's e820 table
      x86/kexec: Do not map kexec area as decrypted when SEV is active
      x86/kexec: Set the C-bit in the identity map page table when SEV is active
      fs/proc/vmcore: Enable dumping of encrypted memory when SEV was active

Thomas Lendacky (2):
      x86/mm: Identify the end of the kernel area to be reserved
      x86/mm: Create a workarea in the kernel for SME early encryption


 arch/x86/include/asm/sections.h    |  2 ++
 arch/x86/kernel/crash.c            |  6 ++++
 arch/x86/kernel/e820.c             |  2 +-
 arch/x86/kernel/machine_kexec_64.c | 31 +++++++++++++++--
 arch/x86/kernel/setup.c            |  8 ++++-
 arch/x86/kernel/vmlinux.lds.S      | 34 +++++++++++++++++-
 arch/x86/mm/ioremap.c              | 71 ++++++++++++++++++++++++--------------
 arch/x86/mm/mem_encrypt_identity.c | 22 ++++++++++--
 fs/proc/vmcore.c                   |  6 ++--
 include/linux/ioport.h             | 10 ++++++
 10 files changed, 155 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 8ea1cfdbeabc..71b32f2570ab 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -13,4 +13,6 @@ extern char __end_rodata_aligned[];
 extern char __end_rodata_hpage_align[];
 #endif
 
+extern char __end_of_kernel_reserve[];
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 576b2e1bfc12..32c956705b8e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -381,6 +381,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	/* Add e820 reserved ranges */
+	cmd.type = E820_TYPE_RESERVED;
+	flags = IORESOURCE_MEM;
+	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
+			   memmap_entry_callback);
+
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 8f32e705a980..e69408bf664b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1063,10 +1063,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
-	case E820_TYPE_RESERVED:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
 	}
 }
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..16c37fe489bc 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -50,12 +50,13 @@ static void free_transition_pgtable(struct kimage *image)
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 {
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
+	unsigned long vaddr, paddr;
+	int result = -ENOMEM;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long vaddr, paddr;
-	int result = -ENOMEM;
 
 	vaddr = (unsigned long)relocate_kernel;
 	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
@@ -92,7 +93,11 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
-	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
+
+	if (sev_active())
+		prot = PAGE_KERNEL_EXEC;
+
+	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
 	return 0;
 err:
 	return result;
@@ -129,6 +134,11 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
 
+	if (sev_active()) {
+		info.page_flag   |= _PAGE_ENC;
+		info.kernpg_flag |= _PAGE_ENC;
+	}
+
 	if (direct_gbpages)
 		info.direct_gbpages = true;
 
@@ -559,8 +569,20 @@ void arch_kexec_unprotect_crashkres(void)
 	kexec_mark_crashkres(false);
 }
 
+/*
+ * During a traditional boot under SME, SME will encrypt the kernel,
+ * so the SME kexec kernel also needs to be un-encrypted in order to
+ * replicate a normal SME boot.
+ *
+ * During a traditional boot under SEV, the kernel has already been
+ * loaded encrypted, so the SEV kexec kernel needs to be encrypted in
+ * order to replicate a normal SEV boot.
+ */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
+	if (sev_active())
+		return 0;
+
 	/*
 	 * If SME is active we need to be sure that kexec pages are
 	 * not encrypted because when we boot to the new kernel the
@@ -571,6 +593,9 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
+	if (sev_active())
+		return;
+
 	/*
 	 * If SME is active we need to reset the pages back to being
 	 * an encrypted mapping before freeing them.
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 08a5f4a131f5..dac60ad37e5e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -827,8 +827,14 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 
 void __init setup_arch(char **cmdline_p)
 {
+	/*
+	 * Reserve the memory occupied by the kernel between _text and
+	 * __end_of_kernel_reserve symbols. Any kernel sections after the
+	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
+	 * separate memblock_reserve() or they will be discarded.
+	 */
 	memblock_reserve(__pa_symbol(_text),
-			 (unsigned long)__bss_stop - (unsigned long)_text);
+			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
 
 	/*
 	 * Make sure page 0 is always reserved because on systems with
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0850b5149345..147cd020516a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -368,6 +368,14 @@ SECTIONS
 		__bss_stop = .;
 	}
 
+	/*
+	 * The memory occupied from _text to here, __end_of_kernel_reserve, is
+	 * automatically reserved in setup_arch(). Anything after here must be
+	 * explicitly reserved using memblock_reserve() or it will be discarded
+	 * and treated as available memory.
+	 */
+	__end_of_kernel_reserve = .;
+
 	. = ALIGN(PAGE_SIZE);
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
@@ -379,10 +387,34 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Early scratch/workarea section: Lives outside of the kernel proper
+	 * (_text - _end).
+	 *
+	 * Resides after _end because even though the .brk section is after
+	 * __end_of_kernel_reserve, the .brk section is later reserved as a
+	 * part of the kernel. Since it is located after __end_of_kernel_reserve
+	 * it will be discarded and become part of the available memory. As
+	 * such, it can only be used by very early boot code and must not be
+	 * needed afterwards.
+	 *
+	 * Currently used by SME for performing in-place encryption of the
+	 * kernel during boot. Resides on a 2MB boundary to simplify the
+	 * pagetable setup used for SME in-place encryption.
+	 */
+	. = ALIGN(HPAGE_SIZE);
+	.init.scratch : AT(ADDR(.init.scratch) - LOAD_OFFSET) {
+		__init_scratch_begin = .;
+		*(.init.scratch)
+		. = ALIGN(HPAGE_SIZE);
+		__init_scratch_end = .;
+	}
+#endif
+
 	STABS_DEBUG
 	DWARF_DEBUG
 
-	/* Sections to be discarded */
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 4b6423e7bd21..e500f1df1140 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -28,9 +28,11 @@
 
 #include "physaddr.h"
 
-struct ioremap_mem_flags {
-	bool system_ram;
-	bool desc_other;
+/*
+ * Descriptor controlling ioremap() behavior.
+ */
+struct ioremap_desc {
+	unsigned int flags;
 };
 
 /*
@@ -62,13 +64,14 @@ int ioremap_change_attr(unsigned long vaddr, unsigned long size,
 	return err;
 }
 
-static bool __ioremap_check_ram(struct resource *res)
+/* Does the range (or a subset of) contain normal RAM? */
+static unsigned int __ioremap_check_ram(struct resource *res)
 {
 	unsigned long start_pfn, stop_pfn;
 	unsigned long i;
 
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
-		return false;
+		return 0;
 
 	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
@@ -76,28 +79,44 @@ static bool __ioremap_check_ram(struct resource *res)
 		for (i = 0; i < (stop_pfn - start_pfn); ++i)
 			if (pfn_valid(start_pfn + i) &&
 			    !PageReserved(pfn_to_page(start_pfn + i)))
-				return true;
+				return IORES_MAP_SYSTEM_RAM;
 	}
 
-	return false;
+	return 0;
 }
 
-static int __ioremap_check_desc_other(struct resource *res)
+/*
+ * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
+ * there the whole memory is already encrypted.
+ */
+static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	if (!sev_active())
+		return 0;
+
+	switch (res->desc) {
+	case IORES_DESC_NONE:
+	case IORES_DESC_RESERVED:
+		break;
+	default:
+		return IORES_MAP_ENCRYPTED;
+	}
+
+	return 0;
 }
 
-static int __ioremap_res_check(struct resource *res, void *arg)
+static int __ioremap_collect_map_flags(struct resource *res, void *arg)
 {
-	struct ioremap_mem_flags *flags = arg;
+	struct ioremap_desc *desc = arg;
 
-	if (!flags->system_ram)
-		flags->system_ram = __ioremap_check_ram(res);
+	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
+		desc->flags |= __ioremap_check_ram(res);
 
-	if (!flags->desc_other)
-		flags->desc_other = __ioremap_check_desc_other(res);
+	if (!(desc->flags & IORES_MAP_ENCRYPTED))
+		desc->flags |= __ioremap_check_encrypted(res);
 
-	return flags->system_ram && flags->desc_other;
+	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
+			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
 }
 
 /*
@@ -106,15 +125,15 @@ static int __ioremap_res_check(struct resource *res, void *arg)
  * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
  */
 static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
-				struct ioremap_mem_flags *flags)
+				struct ioremap_desc *desc)
 {
 	u64 start, end;
 
 	start = (u64)addr;
 	end = start + size - 1;
-	memset(flags, 0, sizeof(*flags));
+	memset(desc, 0, sizeof(struct ioremap_desc));
 
-	walk_mem_res(start, end, flags, __ioremap_res_check);
+	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
 }
 
 /*
@@ -131,15 +150,15 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-static void __iomem *__ioremap_caller(resource_size_t phys_addr,
-		unsigned long size, enum page_cache_mode pcm,
-		void *caller, bool encrypted)
+static void __iomem *
+__ioremap_caller(resource_size_t phys_addr, unsigned long size,
+		 enum page_cache_mode pcm, void *caller, bool encrypted)
 {
 	unsigned long offset, vaddr;
 	resource_size_t last_addr;
 	const resource_size_t unaligned_phys_addr = phys_addr;
 	const unsigned long unaligned_size = size;
-	struct ioremap_mem_flags mem_flags;
+	struct ioremap_desc io_desc;
 	struct vm_struct *area;
 	enum page_cache_mode new_pcm;
 	pgprot_t prot;
@@ -158,12 +177,12 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		return NULL;
 	}
 
-	__ioremap_check_mem(phys_addr, size, &mem_flags);
+	__ioremap_check_mem(phys_addr, size, &io_desc);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
-	if (mem_flags.system_ram) {
+	if (io_desc.flags & IORES_MAP_SYSTEM_RAM) {
 		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
 			  &phys_addr, &last_addr);
 		return NULL;
@@ -201,7 +220,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if ((sev_active() && mem_flags.desc_other) || encrypted)
+	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 4aa9b1480866..6a8dd483f7d9 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -73,6 +73,19 @@ struct sme_populate_pgd_data {
 	unsigned long vaddr_end;
 };
 
+/*
+ * This work area lives in the .init.scratch section, which lives outside of
+ * the kernel proper. It is sized to hold the intermediate copy buffer and
+ * more than enough pagetable pages.
+ *
+ * By using this section, the kernel can be encrypted in place and it
+ * avoids any possibility of boot parameters or initramfs images being
+ * placed such that the in-place encryption logic overwrites them.  This
+ * section is 2MB aligned to allow for simple pagetable setup using only
+ * PMD entries (see vmlinux.lds.S).
+ */
+static char sme_workarea[2 * PMD_PAGE_SIZE] __section(.init.scratch);
+
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
@@ -314,8 +327,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/* Set the encryption workarea to be immediately after the kernel */
-	workarea_start = kernel_end;
+	/*
+	 * We're running identity mapped, so we must obtain the address to the
+	 * SME encryption workarea using rip-relative addressing.
+	 */
+	asm ("lea sme_workarea(%%rip), %0"
+	     : "=r" (workarea_start)
+	     : "p" (sme_workarea));
 
 	/*
 	 * Calculate required number of workarea bytes needed:
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7bb96fdd38ad..57957c91c6df 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -166,7 +166,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
 }
 
 /*
@@ -174,7 +174,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sme_active());
+	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
 }
 
 /*
@@ -374,7 +374,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, sme_active());
+					       userbuf, mem_encrypt_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..5db386cfc2d4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/bits.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -133,6 +134,15 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
+	IORES_DESC_RESERVED			= 8,
+};
+
+/*
+ * Flags controlling ioremap() behavior.
+ */
+enum {
+	IORES_MAP_SYSTEM_RAM		= BIT(0),
+	IORES_MAP_ENCRYPTED		= BIT(1),
 };
 
 /* helpers to define resources */

