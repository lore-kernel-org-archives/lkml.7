Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA56F218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfC3AsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:48:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:64217 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730452AbfC3Arw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:47:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 17:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="129912801"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2019 17:47:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E5AAA301BE3; Fri, 29 Mar 2019 17:47:50 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 3/9] x86/paravirt: Replace paravirt patches with data
Date:   Fri, 29 Mar 2019 17:47:37 -0700
Message-Id: <20190330004743.29541-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330004743.29541-1-andi@firstfloor.org>
References: <20190330004743.29541-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For LTO all top level assembler statements need to be global because
LTO might put it into a different assembler file than the referencing
C code.

To avoid making all the paravirt patch snippets global replace them
with data containing the patch instructions. Since these are unlikely
to change this shouldn't be a significant maintenance burden.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/paravirt_types.h |  6 +---
 arch/x86/kernel/paravirt_patch_32.c   | 33 +++++++++++----------
 arch/x86/kernel/paravirt_patch_64.c   | 42 +++++++++++++++------------
 3 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2474e434a6f7..bb13e79d4344 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -367,12 +367,8 @@ extern struct paravirt_patch_template pv_ops;
 #define paravirt_alt(insn_string)					\
 	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
-/* Simple instruction patching code. */
-#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
-
 #define DEF_NATIVE(ops, name, code)					\
-	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
-	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
+	const char start_##ops##_##name[] = code
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index de138d3912e4..9a649026d74c 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -2,14 +2,14 @@
 #include <asm/paravirt.h>
 
 #ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "push %eax; popf");
-DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
-DEF_NATIVE(cpu, iret, "iret");
-DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
+static const unsigned char patch_irq_irq_disable[] = { 0xfa }; 	  	/* cli */
+static const unsigned char patch_irq_irq_enable[] = { 0xfb };  	  	/* sti */
+static const unsigned char patch_irq_restore_fl[] =  { 0x50, 0x9d }; 	/* push %eax; popf */
+static const unsigned char patch_irq_save_fl[] = { 0x9c, 0x58 };  	/* pushf; pop %eax */
+static const unsigned char patch_cpu_iret[] = { 0xcf };		  	/* iret */
+static const unsigned char patch_mmu_read_cr2[] = { 0x0f, 0x20, 0xd0 }; /* mov %cr2, %eax */
+static const unsigned char patch_mmu_write_cr3[] = { 0x0f, 0x22, 0xd8 };/* mov %eax, %cr3 */
+static const unsigned char patch_mmu_read_cr3[] = { 0x0f, 0x20, 0xd8 }; /* mov %cr3, %eax */
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 {
@@ -19,8 +19,8 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 #endif
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+static const unsigned char patch_lock_queued_spin_unlock[] = { 0xc6, 0x00, 0x00 }; /* movb $0, (%eax) */
+static const unsigned char patch_lock_vcpu_is_preempted[] =  { 0x31, 0xc0 }; 	 /* xor %eax, %eax */
 #endif
 
 extern bool pv_is_native_spin_unlock(void);
@@ -30,7 +30,8 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 #define PATCH_SITE(ops, x)					\
 	case PARAVIRT_PATCH(ops.x):				\
-		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+		return paravirt_patch_insns(ibuf, len, 		\
+				patch_##ops##_##x, patch_##ops##_##x+sizeof(patch_##ops##_x));
 
 	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
@@ -47,15 +48,17 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 	case PARAVIRT_PATCH(lock.queued_spin_unlock):
 		if (pv_is_native_spin_unlock())
 			return paravirt_patch_insns(ibuf, len,
-						    start_lock_queued_spin_unlock,
-						    end_lock_queued_spin_unlock);
+						    patch_lock_queued_spin_unlock,
+						    patch_lock_queued_spin_unlock +
+						    sizeof(patch_lock_queued_spin_unlock));
 		break;
 
 	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 		if (pv_is_native_vcpu_is_preempted())
 			return paravirt_patch_insns(ibuf, len,
-						    start_lock_vcpu_is_preempted,
-						    end_lock_vcpu_is_preempted);
+						    patch_lock_vcpu_is_preempted,
+						    patch_lock_vcpu_is_preempted +
+						    sizeof(patch_lock_vcpu_is_preempted));
 		break;
 #endif
 
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 9d9e04b31077..fce6f54665d3 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -4,29 +4,30 @@
 #include <linux/stringify.h>
 
 #ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
-DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
-DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
-DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
-DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
-DEF_NATIVE(cpu, wbinvd, "wbinvd");
+static const unsigned char patch_irq_irq_disable[] = { 0xfa }; 			/* cli */
+static const unsigned char patch_irq_irq_enable[] =  { 0xfb }; 			/* sti */
+static const unsigned char patch_irq_restore_fl[] =  { 0x50, 0x9d};		/* pushq %rdi; popfq */
+static const unsigned char patch_irq_save_fl[] =     { 0x9c, 0x58 };		/* pushfq; popq %rax */
+static const unsigned char patch_mmu_read_cr2[] =    { 0x0f, 0x20, 0xd0 };	/* movq %cr2, %rax */
+static const unsigned char patch_mmu_read_cr3[] =    { 0x0f, 0x22, 0xd8 };	/* movq %cr3, %rax */
+static const unsigned char patch_mmu_write_cr3[] =   { 0x0f, 0x22, 0xdf };	/* movq %rdi, %cr3 */
+static const unsigned char patch_cpu_wbinvd[] =      { 0x0f, 0x09 };		/* wbinvd */
 
-DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(cpu, swapgs, "swapgs");
-DEF_NATIVE(, mov64, "mov %rdi, %rax");
+static const unsigned char patch_cpu_usergs_sysret64[] = { 0x0f, 0x01, 0xf8, 0x48, 0x0f, 0x07 };
+										/* swapgs; sysretq */
+static const unsigned char patch_cpu_swapgs[] = { 0x0f, 0x01, 0xf8 };		/* swapgs */
+static const unsigned char patch_mov64[] = { 0x48, 0x89, 0xf8 };		/* mov %rdi, %rax */
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 {
 	return paravirt_patch_insns(insnbuf, len,
-				    start__mov64, end__mov64);
+				    start_mov64, start_mov64 + sizeof(start_mov64));
 }
 #endif
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
+static const unsigned char patch_lock_queued_spin_unlock[] = { 0xc6, 0x07, 0x00}; /* movb $0, (%rdi) */
+static const unsigned char patch_lock_vcpu_is_preempted[] = { 0x31, 0xc0 };	  /* xor %eax, %eax */
 #endif
 
 extern bool pv_is_native_spin_unlock(void);
@@ -36,7 +37,8 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 #define PATCH_SITE(ops, x)					\
 	case PARAVIRT_PATCH(ops.x):				\
-		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
+		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, \
+				patch_##ops##_##x + sizeof(patch_##ops##_##x));
 
 	switch (type) {
 #ifdef CONFIG_PARAVIRT_XXL
@@ -55,15 +57,17 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 	case PARAVIRT_PATCH(lock.queued_spin_unlock):
 		if (pv_is_native_spin_unlock())
 			return paravirt_patch_insns(ibuf, len,
-						    start_lock_queued_spin_unlock,
-						    end_lock_queued_spin_unlock);
+						    patch_lock_queued_spin_unlock,
+						    patch_lock_queued_spin_unlock +
+						    sizeof(patch_lock_queued_spin_unlock));
 		break;
 
 	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 		if (pv_is_native_vcpu_is_preempted())
 			return paravirt_patch_insns(ibuf, len,
-						    start_lock_vcpu_is_preempted,
-						    end_lock_vcpu_is_preempted);
+						    patch_lock_vcpu_is_preempted,
+						    patch_lock_vcpu_is_preempted +
+						    sizeof(patch_lock_vcpu_is_preempted));
 		break;
 #endif
 
-- 
2.20.1

