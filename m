Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955D7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654A7218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfDXNrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:47:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfDXNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:47:37 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJIFK-0001Ae-Dw; Wed, 24 Apr 2019 15:47:34 +0200
Message-Id: <20190424134223.603491680@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 15:41:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [patch 2/3] x86/paravirt: Unify 32/64 bit patch code
References: <20190424134115.091452807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large parts of these two files are identical. Merge them together.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/Makefile            |    4 -
 arch/x86/kernel/paravirt_patch.c    |  106 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/paravirt_patch_32.c |   64 ---------------------
 arch/x86/kernel/paravirt_patch_64.c |   72 ------------------------
 4 files changed, 108 insertions(+), 138 deletions(-)

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
--- /dev/null
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/stringify.h>
+
+#include <asm/paravirt.h>
+#include <asm/asm-offsets.h>
+
+#ifdef CONFIG_X86_64
+# ifdef CONFIG_PARAVIRT_XXL
+DEF_NATIVE(irq, irq_disable, "cli");
+DEF_NATIVE(irq, irq_enable, "sti");
+DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
+DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
+DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
+DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
+DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
+DEF_NATIVE(cpu, wbinvd, "wbinvd");
+DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
+DEF_NATIVE(cpu, swapgs, "swapgs");
+DEF_NATIVE(, mov64, "mov %rdi, %rax");
+
+unsigned int paravirt_patch_ident_64(void *insnbuf, unsigned int len)
+{
+	return paravirt_patch_insns(insnbuf, len, start__mov64, end__mov64);
+}
+# endif /* CONFIG_PARAVIRT_XXL */
+
+# ifdef CONFIG_PARAVIRT_SPINLOCKS
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
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
+
+unsigned int native_patch(u8 type, void *ibuf, unsigned long addr,
+			  unsigned int len)
+{
+#define PATCH_SITE(ops, x)					\
+	case PARAVIRT_PATCH(ops.x):				\
+		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+
+	switch (type) {
+#ifdef CONFIG_PARAVIRT_XXL
+		PATCH_SITE(irq, restore_fl);
+		PATCH_SITE(irq, save_fl);
+		PATCH_SITE(irq, irq_enable);
+		PATCH_SITE(irq, irq_disable);
+
+		PATCH_SITE(mmu, read_cr2);
+		PATCH_SITE(mmu, read_cr3);
+		PATCH_SITE(mmu, write_cr3);
+
+# ifdef CONFIG_X86_64
+		PATCH_SITE(cpu, usergs_sysret64);
+		PATCH_SITE(cpu, swapgs);
+		PATCH_SITE(cpu, wbinvd);
+# else
+		PATCH_SITE(cpu, iret);
+# endif
+#endif
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	case PARAVIRT_PATCH(lock.queued_spin_unlock):
+		if (pv_is_native_spin_unlock())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_queued_spin_unlock,
+						    end_lock_queued_spin_unlock);
+		break;
+
+	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
+		if (pv_is_native_vcpu_is_preempted())
+			return paravirt_patch_insns(ibuf, len,
+						    start_lock_vcpu_is_preempted,
+						    end_lock_vcpu_is_preempted);
+		break;
+#endif
+
+	default:
+		break;
+	}
+#undef PATCH_SITE
+	return paravirt_patch_default(type, ibuf, addr, len);
+}
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
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/paravirt.h>
-#include <asm/asm-offsets.h>
-#include <linux/stringify.h>
-
-#ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
-DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
-DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
-DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
-DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
-DEF_NATIVE(cpu, wbinvd, "wbinvd");
-
-DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(cpu, swapgs, "swapgs");
-DEF_NATIVE(, mov64, "mov %rdi, %rax");
-
-unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
-{
-	return paravirt_patch_insns(insnbuf, len,
-				    start__mov64, end__mov64);
-}
-#endif
-
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
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
-		PATCH_SITE(irq, restore_fl);
-		PATCH_SITE(irq, save_fl);
-		PATCH_SITE(irq, irq_enable);
-		PATCH_SITE(irq, irq_disable);
-		PATCH_SITE(cpu, usergs_sysret64);
-		PATCH_SITE(cpu, swapgs);
-		PATCH_SITE(cpu, wbinvd);
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


