Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FEB2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfJTKPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:15:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfJTKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:14:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iM8Ei-0007VU-2S; Sun, 20 Oct 2019 12:14:56 +0200
Date:   Sun, 20 Oct 2019 10:13:56 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.4-rc4
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
Message-ID: <157156643658.8795.4431392863558132451.tglx@nanos.tec.linutronix.de>
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

up to:  228d120051a2: x86/boot/acpi: Move get_cmdline_acpi_rsdp() under #ifdef guard

A small set of x86 fixes:

 - Prevent a NULL pointer dereference in the X2APIC code in case of a CPU
   hotplug failure.

 - Prevent boot failures on HP superdome machines by invalidating the
   level2 kernel pagetable entries outside of the kernel area as invalid so
   BIOS reserved space won't be touched unintentionally. Also ensure that
   memory holes are rounded up to the next PMD boundary correctly.

 - Enable X2APIC support on Hyper-V to prevent boot failures.

 - Set the paravirt name when running on Hyper-V for consistency

 - Move a function under the appropriate ifdef guard to prevent build
   warnings.

Thanks,

	tglx

------------------>
Andrea Parri (1):
      x86/hyperv: Set pv_info.name to "Hyper-V"

Roman Kagan (1):
      x86/hyperv: Make vapic support x2apic mode

Sean Christopherson (1):
      x86/apic/x2apic: Fix a NULL pointer deref when handling a dying cpu

Steve Wahl (2):
      x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area
      x86/boot/64: Round memory hole size up to next PMD page

Zhenzhong Duan (1):
      x86/boot/acpi: Move get_cmdline_acpi_rsdp() under #ifdef guard


 arch/x86/boot/compressed/acpi.c       | 48 +++++++++++++++++------------------
 arch/x86/boot/compressed/misc.c       | 25 +++++++++++++-----
 arch/x86/hyperv/hv_apic.c             | 20 +++++++++++----
 arch/x86/kernel/apic/x2apic_cluster.c |  3 ++-
 arch/x86/kernel/cpu/mshyperv.c        |  4 +++
 arch/x86/kernel/head64.c              | 22 ++++++++++++++--
 6 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 149795c369f2..25019d42ae93 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -20,30 +20,6 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
-/*
- * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
- * digits, and '\0' for termination.
- */
-#define MAX_ADDR_LEN 19
-
-static acpi_physical_address get_cmdline_acpi_rsdp(void)
-{
-	acpi_physical_address addr = 0;
-
-#ifdef CONFIG_KEXEC
-	char val[MAX_ADDR_LEN] = { };
-	int ret;
-
-	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
-	if (ret < 0)
-		return 0;
-
-	if (kstrtoull(val, 16, &addr))
-		return 0;
-#endif
-	return addr;
-}
-
 /*
  * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
  * ACPI_TABLE_GUID are found, take the former, which has more features.
@@ -298,6 +274,30 @@ acpi_physical_address get_rsdp_addr(void)
 }
 
 #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+/*
+ * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
+ * digits, and '\0' for termination.
+ */
+#define MAX_ADDR_LEN 19
+
+static acpi_physical_address get_cmdline_acpi_rsdp(void)
+{
+	acpi_physical_address addr = 0;
+
+#ifdef CONFIG_KEXEC
+	char val[MAX_ADDR_LEN] = { };
+	int ret;
+
+	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (kstrtoull(val, 16, &addr))
+		return 0;
+#endif
+	return addr;
+}
+
 /* Compute SRAT address from RSDP. */
 static unsigned long get_acpi_srat_table(void)
 {
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 53ac0cb2396d..9652d5c2afda 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -345,6 +345,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	unsigned long needed_size;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
 	boot_params = rmode;
@@ -379,26 +380,38 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	free_mem_ptr     = heap;	/* Heap */
 	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
 
+	/*
+	 * The memory hole needed for the kernel is the larger of either
+	 * the entire decompressed kernel plus relocation table, or the
+	 * entire decompressed kernel plus .bss and .brk sections.
+	 *
+	 * On X86_64, the memory is mapped with PMD pages. Round the
+	 * size up so that the full extent of PMD pages mapped is
+	 * included in the check against the valid memory table
+	 * entries. This ensures the full mapped area is usable RAM
+	 * and doesn't include any reserved areas.
+	 */
+	needed_size = max(output_len, kernel_total_size);
+#ifdef CONFIG_X86_64
+	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
+#endif
+
 	/* Report initial kernel position details. */
 	debug_putaddr(input_data);
 	debug_putaddr(input_len);
 	debug_putaddr(output);
 	debug_putaddr(output_len);
 	debug_putaddr(kernel_total_size);
+	debug_putaddr(needed_size);
 
 #ifdef CONFIG_X86_64
 	/* Report address of 32-bit trampoline */
 	debug_putaddr(trampoline_32bit);
 #endif
 
-	/*
-	 * The memory hole needed for the kernel is the larger of either
-	 * the entire decompressed kernel plus relocation table, or the
-	 * entire decompressed kernel plus .bss and .brk sections.
-	 */
 	choose_random_location((unsigned long)input_data, input_len,
 				(unsigned long *)&output,
-				max(output_len, kernel_total_size),
+				needed_size,
 				&virt_addr);
 
 	/* Validate memory location choices. */
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5c056b8aebef..e01078e93dd3 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -260,11 +260,21 @@ void __init hv_apic_init(void)
 	}
 
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
-		pr_info("Hyper-V: Using MSR based APIC access\n");
+		pr_info("Hyper-V: Using enlightened APIC (%s mode)",
+			x2apic_enabled() ? "x2apic" : "xapic");
+		/*
+		 * With x2apic, architectural x2apic MSRs are equivalent to the
+		 * respective synthetic MSRs, so there's no need to override
+		 * the apic accessors.  The only exception is
+		 * hv_apic_eoi_write, because it benefits from lazy EOI when
+		 * available, but it works for both xapic and x2apic modes.
+		 */
 		apic_set_eoi_write(hv_apic_eoi_write);
-		apic->read      = hv_apic_read;
-		apic->write     = hv_apic_write;
-		apic->icr_write = hv_apic_icr_write;
-		apic->icr_read  = hv_apic_icr_read;
+		if (!x2apic_enabled()) {
+			apic->read      = hv_apic_read;
+			apic->write     = hv_apic_write;
+			apic->icr_write = hv_apic_icr_write;
+			apic->icr_read  = hv_apic_icr_read;
+		}
 	}
 }
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 45e92cba92f5..b0889c48a2ac 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -156,7 +156,8 @@ static int x2apic_dead_cpu(unsigned int dead_cpu)
 {
 	struct cluster_mask *cmsk = per_cpu(cluster_masks, dead_cpu);
 
-	cpumask_clear_cpu(dead_cpu, &cmsk->mask);
+	if (cmsk)
+		cpumask_clear_cpu(dead_cpu, &cmsk->mask);
 	free_cpumask_var(per_cpu(ipi_mask, dead_cpu));
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 267daad8c036..c656d92cd708 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -216,6 +216,10 @@ static void __init ms_hyperv_init_platform(void)
 	int hv_host_info_ecx;
 	int hv_host_info_edx;
 
+#ifdef CONFIG_PARAVIRT
+	pv_info.name = "Hyper-V";
+#endif
+
 	/*
 	 * Extract the features and hints
 	 */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 29ffa495bd1c..206a4b6144c2 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -222,13 +222,31 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * we might write invalid pmds, when the kernel is relocated
 	 * cleanup_highmap() fixes this up along with the mappings
 	 * beyond _end.
+	 *
+	 * Only the region occupied by the kernel image has so far
+	 * been checked against the table of usable memory regions
+	 * provided by the firmware, so invalidate pages outside that
+	 * region. A page table entry that maps to a reserved area of
+	 * memory would allow processor speculation into that area,
+	 * and on some hardware (particularly the UV platform) even
+	 * speculative access to some reserved areas is caught as an
+	 * error, causing the BIOS to halt the system.
 	 */
 
 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
-	for (i = 0; i < PTRS_PER_PMD; i++) {
+
+	/* invalidate pages before the kernel image */
+	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	/* fixup pages that are part of the kernel image */
+	for (; i <= pmd_index((unsigned long)_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
-	}
+
+	/* invalidate pages after the kernel image */
+	for (; i < PTRS_PER_PMD; i++)
+		pmd[i] &= ~_PAGE_PRESENT;
 
 	/*
 	 * Fixup phys_base - remove the memory encryption mask to obtain


