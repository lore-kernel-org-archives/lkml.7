Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EFCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D5218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfDXNrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:47:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbfDXNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:47:38 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJIFL-0001Ak-Gj; Wed, 24 Apr 2019 15:47:35 +0200
Message-Id: <20190424134223.690835713@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 15:41:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [patch 3/3] x86/paravirt: Replace paravirt patch asm magic
References: <20190424134115.091452807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magic macro DEF_NATIVE() in the paravirt patching code uses inline
assembly to generate a data table for patching in the native instructions.

While clever this is falling apart with LTO and even aside of LTO the
construct is just working by chance according to GCC folks.

Aside of that the tables are constant data and not some form of magic
text.

As these constructs are not subject to frequent changes it is not a
maintenance issue to convert them to regular data tables which are
initialized with hex bytes.

Create a new set of macros and data structures to store the instruction
sequences and convert the code over.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/paravirt_types.h |    4 
 arch/x86/kernel/paravirt_patch.c      |  144 +++++++++++++++++++---------------
 2 files changed, 82 insertions(+), 66 deletions(-)

--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -370,10 +370,6 @@ extern struct paravirt_patch_template pv
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
 
-#define DEF_NATIVE(ops, name, code)					\
-	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
-	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
-
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len);
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -4,103 +4,123 @@
 #include <asm/paravirt.h>
 #include <asm/asm-offsets.h>
 
-#ifdef CONFIG_X86_64
-# ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
-DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
-DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
-DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
-DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
-DEF_NATIVE(cpu, wbinvd, "wbinvd");
-DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(cpu, swapgs, "swapgs");
-DEF_NATIVE(, mov64, "mov %rdi, %rax");
+#define PSTART(d, m)							\
+	patch_data_##d.m
 
-unsigned int paravirt_patch_ident_64(void *insnbuf, unsigned int len)
-{
-	return paravirt_patch_insns(insnbuf, len, start__mov64, end__mov64);
-}
-# endif /* CONFIG_PARAVIRT_XXL */
+#define PEND(d, m)							\
+	(PSTART(d, m) + sizeof(patch_data_##d.m))
 
-# ifdef CONFIG_PARAVIRT_SPINLOCKS
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-# endif
+#define PATCH(d, m, ibuf, len)						\
+	paravirt_patch_insns(ibuf, len, PSTART(d, m), PEND(d, m))
 
-#else /* CONFIG_X86_64 */
+#define PATCH_CASE(ops, m, data, ibuf, len)				\
+	case PARAVIRT_PATCH(ops.m):					\
+		return PATCH(data, ops##_##m, ibuf, len)
 
-# ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "push %eax; popf");
-DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
-DEF_NATIVE(cpu, iret, "iret");
-DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
+#ifdef CONFIG_PARAVIRT_XXL
+struct patch_xxl {
+	const unsigned char	irq_irq_disable[1];
+	const unsigned char	irq_irq_enable[1];
+	const unsigned char	irq_restore_fl[2];
+	const unsigned char	irq_save_fl[2];
+	const unsigned char	mmu_read_cr2[3];
+	const unsigned char	mmu_read_cr3[3];
+	const unsigned char	mmu_write_cr3[3];
+# ifdef CONFIG_X86_64
+	const unsigned char	cpu_wbinvd[2];
+	const unsigned char	cpu_usergs_sysret64[6];
+	const unsigned char	cpu_swapgs[3];
+	const unsigned char	mov64[3];
+# else
+	const unsigned char	cpu_iret[1];
+# endif
+};
+
+static const struct patch_xxl patch_data_xxl = {
+	.irq_irq_disable	= { 0xfa },		// cli
+	.irq_irq_enable		= { 0xfb },		// sti
+	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
+	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
+	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
+# ifdef CONFIG_X86_64
+	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
+	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
+	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
+	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
+				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
+	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
+	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
+# else
+	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
+	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
+	.cpu_iret		= { 0xcf },		// iret
+# endif
+};
 
 unsigned int paravirt_patch_ident_64(void *insnbuf, unsigned int len)
 {
-	/* arg in %edx:%eax, return in %edx:%eax */
+#ifdef CONFIG_X86_64
+	return PATCH(xxl, mov64, insnbuf, len);
+#endif
 	return 0;
 }
 # endif /* CONFIG_PARAVIRT_XXL */
 
-# ifdef CONFIG_PARAVIRT_SPINLOCKS
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
-# endif
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+struct patch_lock {
+	unsigned char queued_spin_unlock[3];
+	unsigned char vcpu_is_preempted[2];
+};
 
-#endif /* !CONFIG_X86_64 */
+static const struct patch_lock patch_data_lock = {
+	.vcpu_is_preempted	= { 0x31, 0xc0 },	// xor %eax, %eax
+
+# ifdef CONFIG_X86_64
+	.queued_spin_unlock	= { 0xc6, 0x07, 0x00 },	// movb $0, (%rdi)
+# else
+	.queued_spin_unlock	= { 0xc6, 0x00, 0x00 },	// movb $0, (%eax)
+# endif
+};
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
 unsigned int native_patch(u8 type, void *ibuf, unsigned long addr,
 			  unsigned int len)
 {
-#define PATCH_SITE(ops, x)					\
-	case PARAVIRT_PATCH(ops.x):				\
-		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
-
 	switch (type) {
+
 #ifdef CONFIG_PARAVIRT_XXL
-		PATCH_SITE(irq, restore_fl);
-		PATCH_SITE(irq, save_fl);
-		PATCH_SITE(irq, irq_enable);
-		PATCH_SITE(irq, irq_disable);
-
-		PATCH_SITE(mmu, read_cr2);
-		PATCH_SITE(mmu, read_cr3);
-		PATCH_SITE(mmu, write_cr3);
+	PATCH_CASE(irq, restore_fl, xxl, ibuf, len);
+	PATCH_CASE(irq, save_fl, xxl, ibuf, len);
+	PATCH_CASE(irq, irq_enable, xxl, ibuf, len);
+	PATCH_CASE(irq, irq_disable, xxl, ibuf, len);
+
+	PATCH_CASE(mmu, read_cr2, xxl, ibuf, len);
+	PATCH_CASE(mmu, read_cr3, xxl, ibuf, len);
+	PATCH_CASE(mmu, write_cr3, xxl, ibuf, len);
 
 # ifdef CONFIG_X86_64
-		PATCH_SITE(cpu, usergs_sysret64);
-		PATCH_SITE(cpu, swapgs);
-		PATCH_SITE(cpu, wbinvd);
+	PATCH_CASE(cpu, usergs_sysret64, xxl, ibuf, len);
+	PATCH_CASE(cpu, swapgs, xxl, ibuf, len);
+	PATCH_CASE(cpu, wbinvd, xxl, ibuf, len);
 # else
-		PATCH_SITE(cpu, iret);
+	PATCH_CASE(cpu, iret, xxl, ibuf, len);
 # endif
 #endif
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 	case PARAVIRT_PATCH(lock.queued_spin_unlock):
 		if (pv_is_native_spin_unlock())
-			return paravirt_patch_insns(ibuf, len,
-						    start_lock_queued_spin_unlock,
-						    end_lock_queued_spin_unlock);
+			return PATCH(lock, queued_spin_unlock, ibuf, len);
 		break;
 
 	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 		if (pv_is_native_vcpu_is_preempted())
-			return paravirt_patch_insns(ibuf, len,
-						    start_lock_vcpu_is_preempted,
-						    end_lock_vcpu_is_preempted);
+			return PATCH(lock, vcpu_is_preempted, ibuf, len);
 		break;
 #endif
-
 	default:
 		break;
 	}
-#undef PATCH_SITE
+
 	return paravirt_patch_default(type, ibuf, addr, len);
 }


