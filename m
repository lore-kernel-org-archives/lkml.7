Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFBEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19B218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iApAD5/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfDYHck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:32:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfDYHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:32:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3P7W23t3004887
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 00:32:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3P7W23t3004887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556177523;
        bh=/02nBKtSwZ5pyXgKylTabyI+vaPmRNcgzp6IKCkfZ+o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iApAD5/xlqTKEJanyFNZsS2BJtnNei4G+yzvdRPAyZpZQ2ZQ49ROZb0WkUlwaTa1u
         /s9zqPIqeTpZwmas7RobtmQEhMjxR1i827bAziGxAizYzC3/0JnxSuSsyTil742Wu2
         sFkdWuQ0EJggFcPaKbkwZSGBe0TcSwv1Ue+Uxly7gUCjG6HcWvUCKSo6wbcV07/y0D
         kP6bYTKmRRTNPe6bO1WZEkfZ9JLLVUD2bS2gYFf6//IrSP/DDEvU3kzvtBuyF8k5WS
         3VnwR2r5wEiFsVIh5UH7HgvccCZaWpCVrC5M8w+7U9UIgBibOgDeuIfZ/82/a4omBp
         gSqlzR8q3BVOQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3P7W2v23004884;
        Thu, 25 Apr 2019 00:32:02 -0700
Date:   Thu, 25 Apr 2019 00:32:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-92c814ed5f39d0f03d8cc432449a07f82e2c8a73@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, jgross@suse.com, tglx@linutronix.de,
        bp@alien8.de, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, bp@alien8.de,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          jgross@suse.com
In-Reply-To: <20190424134223.603491680@linutronix.de>
References: <20190424134223.603491680@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Unify 32/64 bit patch code
Git-Commit-ID: 92c814ed5f39d0f03d8cc432449a07f82e2c8a73
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

Commit-ID:  92c814ed5f39d0f03d8cc432449a07f82e2c8a73
Gitweb:     https://git.kernel.org/tip/92c814ed5f39d0f03d8cc432449a07f82e2c8a73
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 24 Apr 2019 15:41:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 08:45:02 +0200

x86/paravirt: Unify 32/64 bit patch code

Large parts of these two files are identical. Merge them together.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190424134223.603491680@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/Makefile                           |  4 +-
 .../{paravirt_patch_64.c => paravirt_patch.c}      | 62 ++++++++++++++++-----
 arch/x86/kernel/paravirt_patch_32.c                | 64 ----------------------
 3 files changed, 50 insertions(+), 80 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 00b7e27bc2b7..62e78a3fd31e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -30,7 +30,7 @@ KASAN_SANITIZE_paravirt.o				:= n
 
 OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
-OBJECT_FILES_NON_STANDARD_paravirt_patch_$(BITS).o	:= y
+OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
 
 ifdef CONFIG_FRAME_POINTER
 OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
@@ -112,7 +112,7 @@ obj-$(CONFIG_AMD_NB)		+= amd_nb.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
-obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_$(BITS).o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch.o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch.c
similarity index 59%
rename from arch/x86/kernel/paravirt_patch_64.c
rename to arch/x86/kernel/paravirt_patch.c
index bd1558f90cfb..a47899db9932 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/stringify.h>
+
 #include <asm/paravirt.h>
 #include <asm/asm-offsets.h>
-#include <linux/stringify.h>
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_X86_64
+# ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(irq, irq_disable, "cli");
 DEF_NATIVE(irq, irq_enable, "sti");
 DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
@@ -12,24 +14,49 @@ DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
 DEF_NATIVE(cpu, wbinvd, "wbinvd");
-
 DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(cpu, swapgs, "swapgs");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
-unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
+unsigned int paravirt_patch_ident_64(void *insnbuf, unsigned int len)
 {
-	return paravirt_patch_insns(insnbuf, len,
-				    start__mov64, end__mov64);
+	return paravirt_patch_insns(insnbuf, len, start__mov64, end__mov64);
 }
-#endif
+# endif /* CONFIG_PARAVIRT_XXL */
 
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+# ifdef CONFIG_PARAVIRT_SPINLOCKS
 DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
 DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-#endif
+# endif
+
+#else /* CONFIG_X86_64 */
+
+# ifdef CONFIG_PARAVIRT_XXL
+DEF_NATIVE(irq, irq_disable, "cli");
+DEF_NATIVE(irq, irq_enable, "sti");
+DEF_NATIVE(irq, restore_fl, "push %eax; popf");
+DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
+DEF_NATIVE(cpu, iret, "iret");
+DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
+DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
+DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
+
+unsigned int paravirt_patch_ident_64(void *insnbuf, unsigned int len)
+{
+	/* arg in %edx:%eax, return in %edx:%eax */
+	return 0;
+}
+# endif /* CONFIG_PARAVIRT_XXL */
+
+# ifdef CONFIG_PARAVIRT_SPINLOCKS
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+# endif
+
+#endif /* !CONFIG_X86_64 */
 
-unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
+unsigned int native_patch(u8 type, void *ibuf, unsigned long addr,
+			  unsigned int len)
 {
 #define PATCH_SITE(ops, x)					\
 	case PARAVIRT_PATCH(ops.x):				\
@@ -41,14 +68,21 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(irq, save_fl);
 		PATCH_SITE(irq, irq_enable);
 		PATCH_SITE(irq, irq_disable);
-		PATCH_SITE(cpu, usergs_sysret64);
-		PATCH_SITE(cpu, swapgs);
-		PATCH_SITE(cpu, wbinvd);
+
 		PATCH_SITE(mmu, read_cr2);
 		PATCH_SITE(mmu, read_cr3);
 		PATCH_SITE(mmu, write_cr3);
+
+# ifdef CONFIG_X86_64
+		PATCH_SITE(cpu, usergs_sysret64);
+		PATCH_SITE(cpu, swapgs);
+		PATCH_SITE(cpu, wbinvd);
+# else
+		PATCH_SITE(cpu, iret);
+# endif
 #endif
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 	case PARAVIRT_PATCH(lock.queued_spin_unlock):
 		if (pv_is_native_spin_unlock())
 			return paravirt_patch_insns(ibuf, len,
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
deleted file mode 100644
index 05d771f81e74..000000000000
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/paravirt.h>
-
-#ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "push %eax; popf");
-DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
-DEF_NATIVE(cpu, iret, "iret");
-DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
-
-unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
-{
-	/* arg in %edx:%eax, return in %edx:%eax */
-	return 0;
-}
-#endif
-
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-#endif
-
-unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
-{
-#define PATCH_SITE(ops, x)					\
-	case PARAVIRT_PATCH(ops.x):				\
-		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
-
-	switch (type) {
-#ifdef CONFIG_PARAVIRT_XXL
-		PATCH_SITE(irq, irq_disable);
-		PATCH_SITE(irq, irq_enable);
-		PATCH_SITE(irq, restore_fl);
-		PATCH_SITE(irq, save_fl);
-		PATCH_SITE(cpu, iret);
-		PATCH_SITE(mmu, read_cr2);
-		PATCH_SITE(mmu, read_cr3);
-		PATCH_SITE(mmu, write_cr3);
-#endif
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-	case PARAVIRT_PATCH(lock.queued_spin_unlock):
-		if (pv_is_native_spin_unlock())
-			return paravirt_patch_insns(ibuf, len,
-						    start_lock_queued_spin_unlock,
-						    end_lock_queued_spin_unlock);
-		break;
-
-	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
-		if (pv_is_native_vcpu_is_preempted())
-			return paravirt_patch_insns(ibuf, len,
-						    start_lock_vcpu_is_preempted,
-						    end_lock_vcpu_is_preempted);
-		break;
-#endif
-
-	default:
-		break;
-	}
-#undef PATCH_SITE
-	return paravirt_patch_default(type, ibuf, addr, len);
-}
