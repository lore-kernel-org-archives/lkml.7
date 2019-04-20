Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B1C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BCF21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555745896;
	bh=Uq4yPJ255Xenxeft5Isb4t6yHHVOD6p0lHeADuRATbU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=f/6jO70v08SRGUOoy8pjr9Eqgp43FuvHsT0naCp9eg/yku8zBzW9vi8HmYk2WsvCr
	 OEWyo2bmeV67gDYjdkrMELPdNPCqUSqDt4dHdprXTKDDkFwrQKx6IizJSG1UaHdUlm
	 FxSEcJ1S3pw09UDcIJS7e/K1cDnB0lqiG/CopAM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfDTHiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:38:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDTHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:38:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so8491836wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SPy0BqFWGQV6esurHTdX/nrOfEZ0o8rHkz/zifnJAzQ=;
        b=pt6UVTz9Ofvf+7fr9JfNWat5ieHsIgWw9C19VQf56StcGJH+ofwdwpKW6uunaJNsfx
         QfgEnK5yflh492zphB6SAy0PxsQzN6AehSeBpCYm+tdFyXbo1j76gQeqlv92c5IrYPZN
         Fic/qlpA9XoAGPKGNxRGJnr66GcI6se7rQ+qg/J+qmFBu7D7sB8Nm4qRSgEO8wfvF+nY
         ifdzQ2gRuC3yJYO68fC4PuBf2SC6vVx9tcBDkg/1lgtZU2Tv6mLwXBZUanxsOUrkFxh/
         exjpKy/uNtIfjeVcYzOGx9R6AwLM6g2ZZi6kglooAJ6TSiDBof8kqjGMMYM4q6E4aJIC
         T4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=SPy0BqFWGQV6esurHTdX/nrOfEZ0o8rHkz/zifnJAzQ=;
        b=o/h7fRmjVIR8TMPeddF1ZKaerxkoDG3d4fSYEhcPJdNBwxbq671If4/D0yiNgZev8M
         0glh3ADpLzaKq1Anu7/FiwCUulQki8nRyvw6XnCwilnMNvMEzo1xptXpE1NvaQbn59E7
         Jw0pygbmOlUbTFeNIMQWeyZus9p7lbr0Ym6fCzA6zH5glSCBiQruYYTceK1M8LKRs780
         UJ5Fbr0epUVHLgEoIbpzi6JdlIbAGdfEzQ7LlcIMvbYWEQ1UqS7xKFFMkbO+bDJWoB4h
         1weKhqb0TInGsJAdpd7MggcTnWAR0MfQiPrA+bgCHa11FiCB+Th8nK4XAaMueZQZwDui
         LMAw==
X-Gm-Message-State: APjAAAVI4ZRuFYguf5ikIL0/qH1lROQTqcsjFqSe8l1HZsWMac7OE4vD
        OKrd3zIW7ZBKqFibaDLMtT0=
X-Google-Smtp-Source: APXvYqwBmcgGDZBgP+eZ9pX4nO57mix5B1wxUdkllUp4KQZyqYz4hV7UxZnkMI9II/5iCx1K5dQNGA==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr5062243wmj.70.1555745892396;
        Sat, 20 Apr 2019 00:38:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b204sm8021848wmh.29.2019.04.20.00.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:38:11 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:38:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190420073809.GA74261@gmail.com>
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

   # HEAD: 2ee27796f298b710992a677a7e4d35c8c588b17e x86/cpu/intel: Lower the "ENERGY_PERF_BIAS: Set to normal" message's log priority

Misc fixes all over the place: a console spam fix, section attributes 
fixes, a KASLR fix, a TLB stack-variable alignment fix, a reboot quirk, 
boot options related warnings fix, an LTO fix, a deadlock fix and an RDT 
fix.

 Thanks,

	Ingo

------------------>
Andi Kleen (1):
      x86/cpu/bugs: Use __initconst for 'const' init data

Baoquan He (1):
      x86/mm/KASLR: Fix the size of the direct mapping section

Colin Ian King (1):
      x86/Kconfig: Fix spelling mistake "effectivness" -> "effectiveness"

Hans de Goede (1):
      x86/cpu/intel: Lower the "ENERGY_PERF_BIAS: Set to normal" message's log priority

Jian-Hong Pan (1):
      x86/reboot, efi: Use EFI reboot for Acer TravelMate X514-51T

Peter Zijlstra (1):
      x86/mm/tlb: Revert "x86/mm: Align TLB invalidation info"

Sami Tolvanen (1):
      x86/build/lto: Fix truncated .bss with -fdata-sections

Thomas Gleixner (2):
      x86/speculation: Prevent deadlock on ssb_state::lock
      x86/mm: Prevent bogus warnings with "noexec=off"

Xiaochen Shen (1):
      x86/resctrl: Do not repeat rdtgroup mode initialization


 arch/x86/Kconfig                       |  2 +-
 arch/x86/kernel/cpu/bugs.c             |  6 +++---
 arch/x86/kernel/cpu/intel.c            |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  3 ++-
 arch/x86/kernel/process.c              |  8 ++++++--
 arch/x86/kernel/reboot.c               | 21 +++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S          |  2 +-
 arch/x86/mm/dump_pagetables.c          |  3 ++-
 arch/x86/mm/ioremap.c                  |  2 +-
 arch/x86/mm/kaslr.c                    |  2 +-
 arch/x86/mm/tlb.c                      |  2 +-
 include/linux/efi.h                    |  7 ++++++-
 12 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..01dbb05bc498 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1499,7 +1499,7 @@ config X86_CPA_STATISTICS
 	depends on DEBUG_FS
 	---help---
 	  Expose statistics about the Change Page Attribute mechanims, which
-	  helps to determine the effectivness of preserving large and huge
+	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
 config ARCH_HAS_MEM_ENCRYPT
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2da82eff0eb4..b91b3bfa5cfb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -275,7 +275,7 @@ static const struct {
 	const char			*option;
 	enum spectre_v2_user_cmd	cmd;
 	bool				secure;
-} v2_user_options[] __initdata = {
+} v2_user_options[] __initconst = {
 	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
 	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
 	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
@@ -419,7 +419,7 @@ static const struct {
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
-} mitigation_options[] __initdata = {
+} mitigation_options[] __initconst = {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
@@ -658,7 +658,7 @@ static const char * const ssb_strings[] = {
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[]  __initdata = {
+} ssb_mitigation_options[]  __initconst = {
 	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
 	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
 	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..3142fd7a9b32 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -611,8 +611,8 @@ static void init_intel_energy_perf(struct cpuinfo_x86 *c)
 	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
 		return;
 
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
+	pr_info_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
+	pr_info_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
 	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 54b9eef3eea9..85212a32b54d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2610,9 +2610,10 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
 		}
-		rdtgrp->mode = RDT_MODE_SHAREABLE;
 	}
 
+	rdtgrp->mode = RDT_MODE_SHAREABLE;
+
 	return 0;
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58ac7be52c7a..957eae13b370 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -426,6 +426,8 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 	u64 msr = x86_spec_ctrl_base;
 	bool updmsr = false;
 
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * If TIF_SSBD is different, select the proper mitigation
 	 * method. Note that if SSBD mitigation is disabled or permanentely
@@ -477,10 +479,12 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 
 void speculation_ctrl_update(unsigned long tif)
 {
+	unsigned long flags;
+
 	/* Forced update. Make sure all relevant TIF flags are different */
-	preempt_disable();
+	local_irq_save(flags);
 	__speculation_ctrl_update(~tif, tif);
-	preempt_enable();
+	local_irq_restore(flags);
 }
 
 /* Called from seccomp/prctl update */
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 725624b6c0c0..8fd3cedd9acc 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -81,6 +81,19 @@ static int __init set_bios_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
+/*
+ * Some machines don't handle the default ACPI reboot method and
+ * require the EFI reboot method:
+ */
+static int __init set_efi_reboot(const struct dmi_system_id *d)
+{
+	if (reboot_type != BOOT_EFI && !efi_runtime_disabled()) {
+		reboot_type = BOOT_EFI;
+		pr_info("%s series board detected. Selecting EFI-method for reboot.\n", d->ident);
+	}
+	return 0;
+}
+
 void __noreturn machine_real_restart(unsigned int type)
 {
 	local_irq_disable();
@@ -166,6 +179,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AOA110"),
 		},
 	},
+	{	/* Handle reboot issue on Acer TravelMate X514-51T */
+		.callback = set_efi_reboot,
+		.ident = "Acer TravelMate X514-51T",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate X514-51T"),
+		},
+	},
 
 	/* Apple */
 	{	/* Handle problems with rebooting on Apple MacBook5 */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bad8c51fee6e..a5127b2c195f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -362,7 +362,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
-		*(.bss)
+		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index ee8f8ab46941..c0309ea9abee 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -259,7 +259,8 @@ static void note_wx(struct pg_state *st)
 #endif
 	/* Account the WX pages */
 	st->wx_pages += npages;
-	WARN_ONCE(1, "x86/mm: Found insecure W+X mapping at address %pS\n",
+	WARN_ONCE(__supported_pte_mask & _PAGE_NX,
+		  "x86/mm: Found insecure W+X mapping at address %pS\n",
 		  (void *)st->start_address);
 }
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..dd73d5d74393 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -825,7 +825,7 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 	pte = early_ioremap_pte(addr);
 
 	/* Sanitize 'prot' against any unsupported bits: */
-	pgprot_val(flags) &= __default_kernel_pte_mask;
+	pgprot_val(flags) &= __supported_pte_mask;
 
 	if (pgprot_val(flags))
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed7e9..d669c5e797e0 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -94,7 +94,7 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bc4bc7b2f075..487b8474c01c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -728,7 +728,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	int cpu;
 
-	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
+	struct flush_tlb_info info = {
 		.mm = mm,
 		.stride_shift = stride_shift,
 		.freed_tables = freed_tables,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 54357a258b35..6ebc2098cfe1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1611,7 +1611,12 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
 			   struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
-bool efi_runtime_disabled(void);
+#ifdef CONFIG_EFI
+extern bool efi_runtime_disabled(void);
+#else
+static inline bool efi_runtime_disabled(void) { return true; }
+#endif
+
 extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
 extern unsigned long efi_call_virt_save_flags(void);
 
