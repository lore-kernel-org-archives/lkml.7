Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF17C76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D382166E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfG0Xak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 19:30:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfG0Xaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 19:30:39 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrW97-0002MD-HQ; Sun, 28 Jul 2019 01:30:37 +0200
Date:   Sat, 27 Jul 2019 23:26:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc2 
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
Message-ID: <156426997428.6953.12194106548896484035.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  517c3ba00916: x86/speculation/mds: Apply more accurate check on hypervisor platform

A set of x86 fixes and functional updates:

 - Prevent stale huge I/O TLB mappings on 32bit. A long standing bug which got
   exposed by KPTI support for 32bit

 - Prevent bogus access_ok() warnings in arch_stack_walk_user()

 - Add display quirks for Lenovo devices which have height and width swapped

 - Add the missing CR2 fixup for 32 bit async pagefaults. Fallout of the
   CR2 bug fix series.

 - Unbreak handling of force enabled HPET by moving the 'is HPET counting'
   check back to the original place.

 - A more accurate check for running on a hypervisor platform in the MDS
   mitigation code. Not perfect, but more accurate than the previous one.

 - Update a stale and confusing comment vs. IRQ stacks

Thanks,

	tglx

------------------>
Cao jin (1):
      x86/irq/64: Update stale comment

Eiichi Tsukata (1):
      x86/stacktrace: Prevent access_ok() warnings in arch_stack_walk_user()

Hans de Goede (1):
      x86/sysfb_efi: Add quirks for some devices with swapped width and height

Joerg Roedel (3):
      x86/mm: Check for pfn instead of page in vmalloc_sync_one()
      x86/mm: Sync also unmappings in vmalloc_sync_all()
      mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()

Matt Mullins (1):
      x86/entry/32: Pass cr2 to do_async_page_fault()

Thomas Gleixner (1):
      x86/hpet: Undo the early counter is counting check

Zhenzhong Duan (1):
      x86/speculation/mds: Apply more accurate check on hypervisor platform


 arch/x86/entry/entry_32.S    | 13 +++++++++----
 arch/x86/kernel/cpu/bugs.c   |  2 +-
 arch/x86/kernel/head_64.S    |  8 ++++----
 arch/x86/kernel/hpet.c       | 12 ++++++++----
 arch/x86/kernel/stacktrace.c |  2 +-
 arch/x86/kernel/sysfb_efi.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c          | 15 ++++++---------
 mm/vmalloc.c                 |  9 +++++++++
 8 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2bb986f305ac..4f86928246e7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1443,8 +1443,12 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 ENTRY(page_fault)
 	ASM_CLAC
-	pushl	$0; /* %gs's slot on the stack */
+	pushl	$do_page_fault
+	jmp	common_exception_read_cr2
+END(page_fault)
 
+common_exception_read_cr2:
+	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1
 
 	ENCODE_FRAME_POINTER
@@ -1452,6 +1456,7 @@ ENTRY(page_fault)
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
+	movl	PT_GS(%esp), %edi
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
 
@@ -1463,9 +1468,9 @@ ENTRY(page_fault)
 
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	call	do_page_fault
+	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(page_fault)
+END(common_exception_read_cr2)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
@@ -1595,7 +1600,7 @@ END(general_protection)
 ENTRY(async_page_fault)
 	ASM_CLAC
 	pushl	$do_async_page_fault
-	jmp	common_exception
+	jmp	common_exception_read_cr2
 END(async_page_fault)
 #endif
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 66ca906aa790..801ecd1c3fd5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1226,7 +1226,7 @@ static ssize_t l1tf_show_state(char *buf)
 
 static ssize_t mds_show_state(char *buf)
 {
-	if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		return sprintf(buf, "%s; SMT Host state unknown\n",
 			       mds_strings[mds_mitigation]);
 	}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a6342c899be5..f3d3e9646a99 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -193,10 +193,10 @@ ENTRY(secondary_startup_64)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to the bottom of the irqstack
-	 * union.  If the stack protector canary is enabled, it is
-	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
-	 * init data section till per cpu areas are set up.
+	 * The base of %gs always points to fixed_percpu_data. If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
 	movl	initial_gs(%rip),%eax
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c43e96a938d0..c6f791bc481e 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -827,10 +827,6 @@ int __init hpet_enable(void)
 	if (!hpet_cfg_working())
 		goto out_nohpet;
 
-	/* Validate that the counter is counting */
-	if (!hpet_counting())
-		goto out_nohpet;
-
 	/*
 	 * Read the period and check for a sane value:
 	 */
@@ -896,6 +892,14 @@ int __init hpet_enable(void)
 	}
 	hpet_print_config();
 
+	/*
+	 * Validate that the counter is counting. This needs to be done
+	 * after sanitizing the config registers to properly deal with
+	 * force enabled HPETs.
+	 */
+	if (!hpet_counting())
+		goto out_nohpet;
+
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 4f36d3241faf..2d6898c2cb64 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -100,7 +100,7 @@ copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
 {
 	int ret;
 
-	if (!access_ok(fp, sizeof(*frame)))
+	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
 		return 0;
 
 	ret = 1;
diff --git a/arch/x86/kernel/sysfb_efi.c b/arch/x86/kernel/sysfb_efi.c
index 8eb67a670b10..653b7f617b61 100644
--- a/arch/x86/kernel/sysfb_efi.c
+++ b/arch/x86/kernel/sysfb_efi.c
@@ -230,9 +230,55 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
 	{},
 };
 
+/*
+ * Some devices have a portrait LCD but advertise a landscape resolution (and
+ * pitch). We simply swap width and height for these devices so that we can
+ * correctly deal with some of them coming with multiple resolutions.
+ */
+static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
+	{
+		/*
+		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
+		 * 800x1280 portrait screen. Luckily the portrait version has
+		 * its own BIOS version, so we match on that.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
+		},
+	},
+	{
+		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"Lenovo MIIX 320-10ICR"),
+		},
+	},
+	{
+		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"Lenovo ideapad D330-10IGM"),
+		},
+	},
+	{},
+};
+
 __init void sysfb_apply_efi_quirks(void)
 {
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	    dmi_check_system(efifb_dmi_swap_width_height)) {
+		u16 temp = screen_info.lfb_width;
+
+		screen_info.lfb_width = screen_info.lfb_height;
+		screen_info.lfb_height = temp;
+		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+	}
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6c46095cd0d9..9ceacd1156db 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -177,13 +177,14 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 
 	pmd = pmd_offset(pud, address);
 	pmd_k = pmd_offset(pud_k, address);
-	if (!pmd_present(*pmd_k))
-		return NULL;
 
-	if (!pmd_present(*pmd))
+	if (pmd_present(*pmd) != pmd_present(*pmd_k))
 		set_pmd(pmd, *pmd_k);
+
+	if (!pmd_present(*pmd_k))
+		return NULL;
 	else
-		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
 	return pmd_k;
 }
@@ -203,17 +204,13 @@ void vmalloc_sync_all(void)
 		spin_lock(&pgd_lock);
 		list_for_each_entry(page, &pgd_list, lru) {
 			spinlock_t *pgt_lock;
-			pmd_t *ret;
 
 			/* the pgt_lock only for Xen */
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
 
 			spin_lock(pgt_lock);
-			ret = vmalloc_sync_one(page_address(page), address);
+			vmalloc_sync_one(page_address(page), address);
 			spin_unlock(pgt_lock);
-
-			if (!ret)
-				break;
 		}
 		spin_unlock(&pgd_lock);
 	}
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4fa8d84599b0..e0fc963acc41 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1258,6 +1258,12 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	if (unlikely(valist == NULL))
 		return false;
 
+	/*
+	 * First make sure the mappings are removed from all page-tables
+	 * before they are freed.
+	 */
+	vmalloc_sync_all();
+
 	/*
 	 * TODO: to calculate a flush range without looping.
 	 * The list can be up to lazy_max_pages() elements.
@@ -3038,6 +3044,9 @@ EXPORT_SYMBOL(remap_vmalloc_range);
 /*
  * Implement a stub for vmalloc_sync_all() if the architecture chose not to
  * have one.
+ *
+ * The purpose of this function is to make sure the vmalloc area
+ * mappings are identical in all page-tables in the system.
  */
 void __weak vmalloc_sync_all(void)
 {

