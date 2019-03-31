Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3801C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE030218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfCaKm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:42:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfCaKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:42:24 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAXuv-0005YD-IX; Sun, 31 Mar 2019 12:42:21 +0200
Date:   Sun, 31 Mar 2019 10:39:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86 updates for 5.1
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
Message-ID: <155402878327.25983.8123182893406429117.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  f560bd19d2fe ("x86/realmode: Make set_real_mode_mem() static inline")

A pile of x86 updates:

 - Prevent exceeding he valid physical address space in the /dev/mem limit
   checks.

 - Move all header content inside the header guard to prevent compile
   failures.

 - Fix the bogus __percpu annotation in this_cpu_has() which makes sparse
   very noisy.

 - Disable switch jump tables completely when retpolines are enabled.

 - Prevent leaking the trampoline address.

Thanks,

	tglx

------------------>
Baoquan He (1):
      x86/boot: Fix incorrect ifdeffery scope

Daniel Borkmann (1):
      x86/retpolines: Disable switch jump tables when retpolines are enabled

Jann Horn (1):
      x86/cpufeature: Fix __percpu annotation in this_cpu_has()

Matteo Croce (2):
      x86/realmode: Don't leak the trampoline kernel address
      x86/realmode: Make set_real_mode_mem() static inline

Peng Hao (1):
      x86/resctrl: Remove unused variable

Ralph Campbell (1):
      x86/mm: Don't exceed the valid physical address space


 arch/x86/Makefile                     |  8 ++++++--
 arch/x86/boot/compressed/misc.h       |  4 ++--
 arch/x86/include/asm/cpufeature.h     |  5 +++--
 arch/x86/include/asm/realmode.h       |  6 +++++-
 arch/x86/kernel/cpu/resctrl/monitor.c |  3 ---
 arch/x86/mm/mmap.c                    |  2 +-
 arch/x86/platform/efi/quirks.c        |  2 +-
 arch/x86/realmode/init.c              | 11 +----------
 8 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2d8b9d8ca4f8..a587805c6687 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -219,8 +219,12 @@ ifdef CONFIG_RETPOLINE
   # Additionally, avoid generating expensive indirect jumps which
   # are subject to retpolines for small number of switch cases.
   # clang turns off jump table generation by default when under
-  # retpoline builds, however, gcc does not for x86.
-  KBUILD_CFLAGS += $(call cc-option,--param=case-values-threshold=20)
+  # retpoline builds, however, gcc does not for x86. This has
+  # only been fixed starting from gcc stable version 8.4.0 and
+  # onwards, but not for older ones. See gcc bug #86952.
+  ifndef CONFIG_CC_IS_CLANG
+    KBUILD_CFLAGS += $(call cc-option,-fno-jump-tables)
+  endif
 endif
 
 archscripts: scripts_basic
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fd13655e0f9b..d2f184165934 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -120,8 +120,6 @@ static inline void console_init(void)
 
 void set_sev_encryption_mask(void);
 
-#endif
-
 /* acpi.c */
 #ifdef CONFIG_ACPI
 acpi_physical_address get_rsdp_addr(void);
@@ -135,3 +133,5 @@ int count_immovable_mem_regions(void);
 #else
 static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
+
+#endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index ce95b8cbd229..0e56ff7e4848 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -112,8 +112,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	 test_cpu_cap(c, bit))
 
 #define this_cpu_has(bit)						\
-	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : 	\
-	 x86_this_cpu_test_bit(bit, (unsigned long *)&cpu_info.x86_capability))
+	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
+	 x86_this_cpu_test_bit(bit,					\
+		(unsigned long __percpu *)&cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 63b3393bd98e..c53682303c9c 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -77,7 +77,11 @@ static inline size_t real_mode_size_needed(void)
 	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
 }
 
-void set_real_mode_mem(phys_addr_t mem, size_t size);
+static inline void set_real_mode_mem(phys_addr_t mem)
+{
+	real_mode_header = (struct real_mode_header *) __va(mem);
+}
+
 void reserve_real_mode(void);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f33f11f69078..1573a0a6b525 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -501,11 +501,8 @@ void cqm_handle_limbo(struct work_struct *work)
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
-	struct rdt_resource *r;
 	int cpu;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
-
 	cpu = cpumask_any(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index db3165714521..dc726e07d8ba 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -230,7 +230,7 @@ bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
 /* Can we access it for direct reading/writing? Must be RAM: */
 int valid_phys_addr_range(phys_addr_t addr, size_t count)
 {
-	return addr + count <= __pa(high_memory);
+	return addr + count - 1 <= __pa(high_memory - 1);
 }
 
 /* Can we access it through mmap? Must be a valid physical address: */
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 458a0e2bcc57..a25a9fd987a9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -449,7 +449,7 @@ void __init efi_free_boot_services(void)
 		 */
 		rm_size = real_mode_size_needed();
 		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
-			set_real_mode_mem(start, rm_size);
+			set_real_mode_mem(start);
 			start += rm_size;
 			size -= rm_size;
 		}
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index d10105825d57..7dce39c8c034 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -15,15 +15,6 @@ u32 *trampoline_cr4_features;
 /* Hold the pgd entry used on booting additional CPUs */
 pgd_t trampoline_pgd_entry;
 
-void __init set_real_mode_mem(phys_addr_t mem, size_t size)
-{
-	void *base = __va(mem);
-
-	real_mode_header = (struct real_mode_header *) base;
-	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
-	       base, (unsigned long long)mem, size);
-}
-
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem;
@@ -42,7 +33,7 @@ void __init reserve_real_mode(void)
 	}
 
 	memblock_reserve(mem, size);
-	set_real_mode_mem(mem, size);
+	set_real_mode_mem(mem);
 }
 
 static void __init setup_real_mode(void)

