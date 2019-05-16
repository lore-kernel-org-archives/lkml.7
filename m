Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A6C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108712082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558023985;
	bh=CIl94wQpDwU4GgKQ3wC4n34XlTR/Uf4Z9aPX6bQkqis=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ozsVXwmm2R1Mp7SRCVf/2c8DadfdqqeBbv6dBvQiFqnYYCAsA8cBNF+mGNJRZae6M
	 xIY2WzFxsMWC/iTxbAD6puQ0B7uaccI8h1EeV8IUMTsMauhdq92kqtIPcQ6NONPmOG
	 HwfAEgYdBIcXlaE6oP+6mysY2/k/DUZB/ZlwvoD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEPQ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:26:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:26:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so4047302wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f00DMjp8cKcST/lHSpAW1ffKo3wLmv2pQvMgWPNHQDQ=;
        b=l7cbfWSgFOaSx1KYaXJ3btCNI3XFrqQSdvVWPw58D34hnrhqyzGqHDyb6xAPUYFegH
         ALc7yeCQh3fNSi5EdqSMppGIkqk9W5UAWCscxMdOijXJ2XyCLbLwHnoJuj0uZi91i0VD
         Pgiv64Tx4JuxftZR/qqsN2zpF8wvlJ3ZETskied3qFC1r/xiE6BFnL3vYS3KRCdcfxyy
         1UgPJPJPvE5pm2A4N742hKlTgy7ozhA1GFPMfhoUBLZ0RWQ/24TsjbUYGbAV0wuk44vi
         zos8MqN0UkuF0OIXFfET02W21fdRal5zDt/YRj5JESv4Vp01Db2HzmTKm41i3hG7L9wf
         MLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=f00DMjp8cKcST/lHSpAW1ffKo3wLmv2pQvMgWPNHQDQ=;
        b=X532VFDLvYDHJ0U+OcerkTieXgurBrx56+z4mcXjmTlzEfiOlfIkoCDez3gvK/6x1C
         9jbKn4Ssohq7d1rFyCQh329OODKBMLv8tumczzMWch6B4wgdLsw+JAdX9wmz1uP8Oc4t
         PiPRH/aX2s4OpQ0R8VqixYAV0F1mGKd/byc3c3psboNxCNHjA3Q4GWfCREAgq7Ykqgec
         Doloz7YkQQRpTOgujEYLVPaADAu7rQrpcRhVjksf4JKnP1ZIFB1EL2ok1sTAKhmk9nqL
         fDWvI1Y1GLzvd+mXuoM0wQ8U7gD88dBxWItfo4fkMz1tjBSVF7lAUyWHOXCfS0MlvkHl
         lM5w==
X-Gm-Message-State: APjAAAWBSBcaLVVJeVLmGcxFGJVTqHo7TDkWFdVruBz+vBYT6flsftZM
        NbEu+lGZFVfU0JQRcrEtQvU=
X-Google-Smtp-Source: APXvYqzv2UDaYfkDa7GlX9rjM4Gp+YGaLKZ5pdUVAOk0jxwRohpH8eTSdowntu77YdX8qpZLmjx9Yw==
X-Received: by 2002:adf:e404:: with SMTP id g4mr30390224wrm.161.1558023978706;
        Thu, 16 May 2019 09:26:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g2sm6984210wru.37.2019.05.16.09.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:26:18 -0700 (PDT)
Date:   Thu, 16 May 2019 18:26:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190516162616.GA15490@gmail.com>
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

   # HEAD: 9d8d0294e78a164d407133dea05caf4b84247d6a x86/speculation/mds: Improve CPU buffer clear documentation

Misc fixes and updates:

 - a handful of MDS documentation/comment updates
 - a cleanup related to hweight interfaces
 - a SEV guest fix for large pages
 - a kprobes LTO fix
 - and a final cleanup commit for vDSO HPET support removal.


  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  lib/hweight.c                      # 409ca45526a4: x86/kconfig: Disable CONFIG_

 Thanks,

	Ingo

------------------>
Andi Kleen (1):
      x86/kprobes: Make trampoline_handler() global and visible

Andy Lutomirski (2):
      x86/speculation/mds: Revert CPU buffer clear on double fault exit
      x86/speculation/mds: Improve CPU buffer clear documentation

Brijesh Singh (1):
      x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page

Jia Zhang (1):
      x86/vdso: Remove hpet_page from vDSO

Masahiro Yamada (1):
      x86/kconfig: Disable CONFIG_GENERIC_HWEIGHT and remove __HAVE_ARCH_SW_HWEIGHT


 Documentation/x86/mds.rst           |  44 ++---------
 arch/x86/Kconfig                    |   3 -
 arch/x86/entry/vdso/vdso2c.c        |   3 -
 arch/x86/include/asm/arch_hweight.h |   2 -
 arch/x86/include/asm/vdso.h         |   1 -
 arch/x86/kernel/kprobes/core.c      |   2 +-
 arch/x86/kernel/traps.c             |   8 --
 arch/x86/mm/init_64.c               | 144 ++++++++++++++++++++++++++----------
 arch/x86/mm/mem_encrypt.c           |  10 ++-
 arch/x86/mm/mm_internal.h           |   3 +
 lib/hweight.c                       |   4 -
 11 files changed, 121 insertions(+), 103 deletions(-)

diff --git a/Documentation/x86/mds.rst b/Documentation/x86/mds.rst
index 534e9baa4e1d..5d4330be200f 100644
--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -142,45 +142,13 @@ Mitigation points
    mds_user_clear.
 
    The mitigation is invoked in prepare_exit_to_usermode() which covers
-   most of the kernel to user space transitions. There are a few exceptions
-   which are not invoking prepare_exit_to_usermode() on return to user
-   space. These exceptions use the paranoid exit code.
+   all but one of the kernel to user space transitions.  The exception
+   is when we return from a Non Maskable Interrupt (NMI), which is
+   handled directly in do_nmi().
 
-   - Non Maskable Interrupt (NMI):
-
-     Access to sensible data like keys, credentials in the NMI context is
-     mostly theoretical: The CPU can do prefetching or execute a
-     misspeculated code path and thereby fetching data which might end up
-     leaking through a buffer.
-
-     But for mounting other attacks the kernel stack address of the task is
-     already valuable information. So in full mitigation mode, the NMI is
-     mitigated on the return from do_nmi() to provide almost complete
-     coverage.
-
-   - Double fault (#DF):
-
-     A double fault is usually fatal, but the ESPFIX workaround, which can
-     be triggered from user space through modify_ldt(2) is a recoverable
-     double fault. #DF uses the paranoid exit path, so explicit mitigation
-     in the double fault handler is required.
-
-   - Machine Check Exception (#MC):
-
-     Another corner case is a #MC which hits between the CPU buffer clear
-     invocation and the actual return to user. As this still is in kernel
-     space it takes the paranoid exit path which does not clear the CPU
-     buffers. So the #MC handler repopulates the buffers to some
-     extent. Machine checks are not reliably controllable and the window is
-     extremly small so mitigation would just tick a checkbox that this
-     theoretical corner case is covered. To keep the amount of special
-     cases small, ignore #MC.
-
-   - Debug Exception (#DB):
-
-     This takes the paranoid exit path only when the INT1 breakpoint is in
-     kernel space. #DB on a user space address takes the regular exit path,
-     so no extra mitigation required.
+   (The reason that NMI is special is that prepare_exit_to_usermode() can
+    enable IRQs.  In NMI context, NMIs are blocked, and we don't want to
+    enable IRQs with NMIs blocked.)
 
 
 2. C-State transition
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 326b2d5bab9d..6bc9dd6e7534 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -259,9 +259,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	bool
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 8e470b018512..3a4d8d4d39f8 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -73,14 +73,12 @@ const char *outfilename;
 enum {
 	sym_vvar_start,
 	sym_vvar_page,
-	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
-	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
 };
@@ -93,7 +91,6 @@ struct vdso_sym {
 struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", true},
 	[sym_vvar_page] = {"vvar_page", true},
-	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
 	{"VDSO32_NOTE_MASK", true},
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index fc0693569f7a..ba88edd0d58b 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -12,8 +12,6 @@
 #define REG_OUT "a"
 #endif
 
-#define __HAVE_ARCH_SW_HWEIGHT
-
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 27566e57e87d..230474e2ddb5 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -19,7 +19,6 @@ struct vdso_image {
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
 	long sym_vvar_page;
-	long sym_hpet_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
 	long sym_VDSO32_NOTE_MASK;
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index cf52ee0d8711..9e4fa2484d10 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -768,7 +768,7 @@ static struct kprobe kretprobe_kprobe = {
 /*
  * Called from kretprobe_trampoline
  */
-static __used void *trampoline_handler(struct pt_regs *regs)
+__used __visible void *trampoline_handler(struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7de466eb960b..8b6d03e55d2f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -58,7 +58,6 @@
 #include <asm/alternative.h>
 #include <asm/fpu/xstate.h>
 #include <asm/trace/mpx.h>
-#include <asm/nospec-branch.h>
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
@@ -368,13 +367,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 		regs->ip = (unsigned long)general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
-		/*
-		 * This situation can be triggered by userspace via
-		 * modify_ldt(2) and the return does not take the regular
-		 * user space exit, so a CPU buffer clear is required when
-		 * MDS mitigation is enabled.
-		 */
-		mds_user_clear_cpu_buffers();
 		return;
 	}
 #endif
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 20d14254b686..62fc457f3849 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -58,6 +58,37 @@
 
 #include "ident_map.c"
 
+#define DEFINE_POPULATE(fname, type1, type2, init)		\
+static inline void fname##_init(struct mm_struct *mm,		\
+		type1##_t *arg1, type2##_t *arg2, bool init)	\
+{								\
+	if (init)						\
+		fname##_safe(mm, arg1, arg2);			\
+	else							\
+		fname(mm, arg1, arg2);				\
+}
+
+DEFINE_POPULATE(p4d_populate, p4d, pud, init)
+DEFINE_POPULATE(pgd_populate, pgd, p4d, init)
+DEFINE_POPULATE(pud_populate, pud, pmd, init)
+DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
+
+#define DEFINE_ENTRY(type1, type2, init)			\
+static inline void set_##type1##_init(type1##_t *arg1,		\
+			type2##_t arg2, bool init)		\
+{								\
+	if (init)						\
+		set_##type1##_safe(arg1, arg2);			\
+	else							\
+		set_##type1(arg1, arg2);			\
+}
+
+DEFINE_ENTRY(p4d, p4d, init)
+DEFINE_ENTRY(pud, pud, init)
+DEFINE_ENTRY(pmd, pmd, init)
+DEFINE_ENTRY(pte, pte, init)
+
+
 /*
  * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
  * physical space so we can cache the place of the first one and move
@@ -414,7 +445,7 @@ void __init cleanup_highmap(void)
  */
 static unsigned long __meminit
 phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
-	      pgprot_t prot)
+	      pgprot_t prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long paddr_last = paddr_end;
@@ -432,7 +463,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pte_safe(pte, __pte(0));
+				set_pte_init(pte, __pte(0), init);
 			continue;
 		}
 
@@ -452,7 +483,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			pr_info("   pte=%p addr=%lx pte=%016lx\n", pte, paddr,
 				pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL).pte);
 		pages++;
-		set_pte_safe(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
+		set_pte_init(pte, pfn_pte(paddr >> PAGE_SHIFT, prot), init);
 		paddr_last = (paddr & PAGE_MASK) + PAGE_SIZE;
 	}
 
@@ -468,7 +499,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
  */
 static unsigned long __meminit
 phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
-	      unsigned long page_size_mask, pgprot_t prot)
+	      unsigned long page_size_mask, pgprot_t prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long paddr_last = paddr_end;
@@ -487,7 +518,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pmd_safe(pmd, __pmd(0));
+				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
 
@@ -496,7 +527,8 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 				spin_lock(&init_mm.page_table_lock);
 				pte = (pte_t *)pmd_page_vaddr(*pmd);
 				paddr_last = phys_pte_init(pte, paddr,
-							   paddr_end, prot);
+							   paddr_end, prot,
+							   init);
 				spin_unlock(&init_mm.page_table_lock);
 				continue;
 			}
@@ -524,19 +556,20 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_2M)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte_safe((pte_t *)pmd,
-				pfn_pte((paddr & PMD_MASK) >> PAGE_SHIFT,
-					__pgprot(pgprot_val(prot) | _PAGE_PSE)));
+			set_pte_init((pte_t *)pmd,
+				     pfn_pte((paddr & PMD_MASK) >> PAGE_SHIFT,
+					     __pgprot(pgprot_val(prot) | _PAGE_PSE)),
+				     init);
 			spin_unlock(&init_mm.page_table_lock);
 			paddr_last = paddr_next;
 			continue;
 		}
 
 		pte = alloc_low_page();
-		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot);
+		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		pmd_populate_kernel_safe(&init_mm, pmd, pte);
+		pmd_populate_kernel_init(&init_mm, pmd, pte, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	update_page_count(PG_LEVEL_2M, pages);
@@ -551,7 +584,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
  */
 static unsigned long __meminit
 phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
-	      unsigned long page_size_mask)
+	      unsigned long page_size_mask, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long paddr_last = paddr_end;
@@ -573,7 +606,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pud_safe(pud, __pud(0));
+				set_pud_init(pud, __pud(0), init);
 			continue;
 		}
 
@@ -583,7 +616,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 				paddr_last = phys_pmd_init(pmd, paddr,
 							   paddr_end,
 							   page_size_mask,
-							   prot);
+							   prot, init);
 				continue;
 			}
 			/*
@@ -610,9 +643,10 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_1G)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte_safe((pte_t *)pud,
-				pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
-					PAGE_KERNEL_LARGE));
+			set_pte_init((pte_t *)pud,
+				     pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
+					     PAGE_KERNEL_LARGE),
+				     init);
 			spin_unlock(&init_mm.page_table_lock);
 			paddr_last = paddr_next;
 			continue;
@@ -620,10 +654,10 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 
 		pmd = alloc_low_page();
 		paddr_last = phys_pmd_init(pmd, paddr, paddr_end,
-					   page_size_mask, prot);
+					   page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		pud_populate_safe(&init_mm, pud, pmd);
+		pud_populate_init(&init_mm, pud, pmd, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 
@@ -634,14 +668,15 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 
 static unsigned long __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
-	      unsigned long page_size_mask)
+	      unsigned long page_size_mask, bool init)
 {
 	unsigned long paddr_next, paddr_last = paddr_end;
 	unsigned long vaddr = (unsigned long)__va(paddr);
 	int i = p4d_index(vaddr);
 
 	if (!pgtable_l5_enabled())
-		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end, page_size_mask);
+		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
+				     page_size_mask, init);
 
 	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
 		p4d_t *p4d;
@@ -657,39 +692,34 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_p4d_safe(p4d, __p4d(0));
+				set_p4d_init(p4d, __p4d(0), init);
 			continue;
 		}
 
 		if (!p4d_none(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			paddr_last = phys_pud_init(pud, paddr,
-					paddr_end,
-					page_size_mask);
+			paddr_last = phys_pud_init(pud, paddr, paddr_end,
+						   page_size_mask, init);
 			continue;
 		}
 
 		pud = alloc_low_page();
 		paddr_last = phys_pud_init(pud, paddr, paddr_end,
-					   page_size_mask);
+					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		p4d_populate_safe(&init_mm, p4d, pud);
+		p4d_populate_init(&init_mm, p4d, pud, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 
 	return paddr_last;
 }
 
-/*
- * Create page table mapping for the physical memory for specific physical
- * addresses. The virtual and physical addresses have to be aligned on PMD level
- * down. It returns the last physical address mapped.
- */
-unsigned long __meminit
-kernel_physical_mapping_init(unsigned long paddr_start,
-			     unsigned long paddr_end,
-			     unsigned long page_size_mask)
+static unsigned long __meminit
+__kernel_physical_mapping_init(unsigned long paddr_start,
+			       unsigned long paddr_end,
+			       unsigned long page_size_mask,
+			       bool init)
 {
 	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
@@ -709,19 +739,22 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 			p4d = (p4d_t *)pgd_page_vaddr(*pgd);
 			paddr_last = phys_p4d_init(p4d, __pa(vaddr),
 						   __pa(vaddr_end),
-						   page_size_mask);
+						   page_size_mask,
+						   init);
 			continue;
 		}
 
 		p4d = alloc_low_page();
 		paddr_last = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
-					   page_size_mask);
+					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
-			pgd_populate_safe(&init_mm, pgd, p4d);
+			pgd_populate_init(&init_mm, pgd, p4d, init);
 		else
-			p4d_populate_safe(&init_mm, p4d_offset(pgd, vaddr), (pud_t *) p4d);
+			p4d_populate_init(&init_mm, p4d_offset(pgd, vaddr),
+					  (pud_t *) p4d, init);
+
 		spin_unlock(&init_mm.page_table_lock);
 		pgd_changed = true;
 	}
@@ -732,6 +765,37 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 	return paddr_last;
 }
 
+
+/*
+ * Create page table mapping for the physical memory for specific physical
+ * addresses. Note that it can only be used to populate non-present entries.
+ * The virtual and physical addresses have to be aligned on PMD level
+ * down. It returns the last physical address mapped.
+ */
+unsigned long __meminit
+kernel_physical_mapping_init(unsigned long paddr_start,
+			     unsigned long paddr_end,
+			     unsigned long page_size_mask)
+{
+	return __kernel_physical_mapping_init(paddr_start, paddr_end,
+					      page_size_mask, true);
+}
+
+/*
+ * This function is similar to kernel_physical_mapping_init() above with the
+ * exception that it uses set_{pud,pmd}() instead of the set_{pud,pte}_safe()
+ * when updating the mapping. The caller is responsible to flush the TLBs after
+ * the function returns.
+ */
+unsigned long __meminit
+kernel_physical_mapping_change(unsigned long paddr_start,
+			       unsigned long paddr_end,
+			       unsigned long page_size_mask)
+{
+	return __kernel_physical_mapping_init(paddr_start, paddr_end,
+					      page_size_mask, false);
+}
+
 #ifndef CONFIG_NUMA
 void __init initmem_init(void)
 {
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 385afa2b9e17..51f50a7a07ef 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -301,9 +301,13 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 		else
 			split_page_size_mask = 1 << PG_LEVEL_2M;
 
-		kernel_physical_mapping_init(__pa(vaddr & pmask),
-					     __pa((vaddr_end & pmask) + psize),
-					     split_page_size_mask);
+		/*
+		 * kernel_physical_mapping_change() does not flush the TLBs, so
+		 * a TLB flush is required after we exit from the for loop.
+		 */
+		kernel_physical_mapping_change(__pa(vaddr & pmask),
+					       __pa((vaddr_end & pmask) + psize),
+					       split_page_size_mask);
 	}
 
 	ret = 0;
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 319bde386d5f..eeae142062ed 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -13,6 +13,9 @@ void early_ioremap_page_table_range_init(void);
 unsigned long kernel_physical_mapping_init(unsigned long start,
 					     unsigned long end,
 					     unsigned long page_size_mask);
+unsigned long kernel_physical_mapping_change(unsigned long start,
+					     unsigned long end,
+					     unsigned long page_size_mask);
 void zone_sizes_init(void);
 
 extern int after_bootmem;
diff --git a/lib/hweight.c b/lib/hweight.c
index 7660d88fd496..c94586b62551 100644
--- a/lib/hweight.c
+++ b/lib/hweight.c
@@ -10,7 +10,6 @@
  * The Hamming Weight of a number is the total number of bits set in it.
  */
 
-#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned int __sw_hweight32(unsigned int w)
 {
 #ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
@@ -27,7 +26,6 @@ unsigned int __sw_hweight32(unsigned int w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight32);
-#endif
 
 unsigned int __sw_hweight16(unsigned int w)
 {
@@ -46,7 +44,6 @@ unsigned int __sw_hweight8(unsigned int w)
 }
 EXPORT_SYMBOL(__sw_hweight8);
 
-#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned long __sw_hweight64(__u64 w)
 {
 #if BITS_PER_LONG == 32
@@ -69,4 +66,3 @@ unsigned long __sw_hweight64(__u64 w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight64);
-#endif
