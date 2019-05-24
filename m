Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B66C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E5321841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Rk9w4P5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbfEXIBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:01:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbfEXIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:01:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O80mXX115426
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:00:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O80mXX115426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558684848;
        bh=xajh/pBeBL05s7KIlV6uo5jiZRR5i5ycLXDIx+krz2Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Rk9w4P5alah1BFNv9PRq3BVNfpxHhtyo/Tq/XRFFs/yp5R2NYcjYRoZWzMDA4kzBu
         nnX6ItOa6l6SBTrydhdx9ptYbdVhJpMKeguY/jxrbi8TyQnUlTk9dISiXJb3HoB/JZ
         pHX0XMdATJP1mc1+NFwslm/uhZ6MgxGPjCZWf0YhnQuLRDhIZe+So4u88tQ1uD9F47
         TZNA5szxdyeL68IWqr42ai4HLgtlu38qkKCmfh5NIaZEvAzee/qxqfztX8JdNgQZz5
         bttapLrlLUAumeXd5iSdSKG1TmllmSciZO5o6c1icEnbBqNRCP1zVBciKJpS3eY5Z9
         MxMv4CmKVcAAA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O80lAJ115423;
        Fri, 24 May 2019 01:00:47 -0700
Date:   Fri, 24 May 2019 01:00:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-0b9d2fc1d0d628c94c6866a2ed3005c6730db512@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, dvlasenk@redhat.com,
        luto@kernel.org, dave.hansen@linux.intel.com, riel@surriel.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, bp@alien8.de,
        torvalds@linux-foundation.org, jgross@suse.com, brgerst@gmail.com
Reply-To: brgerst@gmail.com, jgross@suse.com,
          torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
          peterz@infradead.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, riel@surriel.com, luto@kernel.org,
          dave.hansen@linux.intel.com, dvlasenk@redhat.com,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190424134223.690835713@linutronix.de>
References: <20190424134223.690835713@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Replace the paravirt patch asm
 magic
Git-Commit-ID: 0b9d2fc1d0d628c94c6866a2ed3005c6730db512
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

Commit-ID:  0b9d2fc1d0d628c94c6866a2ed3005c6730db512
Gitweb:     https://git.kernel.org/tip/0b9d2fc1d0d628c94c6866a2ed3005c6730db512
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 24 Apr 2019 15:41:18 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 12:00:44 +0200

x86/paravirt: Replace the paravirt patch asm magic

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
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/20190424134223.690835713@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/paravirt_types.h |   4 -
 arch/x86/kernel/paravirt_patch.c      | 142 +++++++++++++++++++---------------
 2 files changed, 81 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2474e434a6f7..ae8d6ddfe39a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -370,10 +370,6 @@ extern struct paravirt_patch_template pv_ops;
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
 
-#define DEF_NATIVE(ops, name, code)					\
-	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
-	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
-
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len);
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index a47899db9932..60e7a5e236c0 100644
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
+
+static const struct patch_lock patch_data_lock = {
+	.vcpu_is_preempted	= { 0x31, 0xc0 },	// xor %eax, %eax
 
-#endif /* !CONFIG_X86_64 */
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
+	PATCH_CASE(irq, restore_fl, xxl, ibuf, len);
+	PATCH_CASE(irq, save_fl, xxl, ibuf, len);
+	PATCH_CASE(irq, irq_enable, xxl, ibuf, len);
+	PATCH_CASE(irq, irq_disable, xxl, ibuf, len);
 
-		PATCH_SITE(mmu, read_cr2);
-		PATCH_SITE(mmu, read_cr3);
-		PATCH_SITE(mmu, write_cr3);
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
