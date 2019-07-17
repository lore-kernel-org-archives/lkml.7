Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2676C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FD721743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IWZIAlpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfGQVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:23:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfGQVX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:23:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HLMuir1693672
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 14:22:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HLMuir1693672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563398577;
        bh=jIzUKJGA6cruHyjucz6ZkLlXUj498dG9bTuoPNvenU4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IWZIAlpUqmskmNwWPDA1jTB0TpiZesBaNuCzdRruL1xlfve2eJ5bpi9wOa9lTOgId
         oPaARpVFUE7H+gOWALdW6tcwGknHzbZV9EGiEtk6ZRFqAFtdznxjHfVqHQmt6VfpEH
         hL99B55E+iuxKMIKdsXMxuQuWHuNcmV/5iemS0loJgRVzt2AQP+p0tUF/VXEjyqPmt
         xW9N/jolsxD0lh+DvorXHWiozFGJRgG+p++LAENO5dbuCnTfEEQzrQOZ/GqpE6sTfN
         T0KuWViDNfcb2Ly2iHixuBQqWSxCxBWuJTc3cIBdfAlp40Qo9aEAyWhdaXOwSFG7Wp
         2f3hNZHZXOxQg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HLMu781693669;
        Wed, 17 Jul 2019 14:22:56 -0700
Date:   Wed, 17 Jul 2019 14:22:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-55aedddb6149ab71bec9f050846855113977b033@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        jgross@suse.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, jgross@suse.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190711114335.887392493@infradead.org>
References: <20190711114335.887392493@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/paravirt: Make read_cr2() CALLEE_SAVE
Git-Commit-ID: 55aedddb6149ab71bec9f050846855113977b033
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

Commit-ID:  55aedddb6149ab71bec9f050846855113977b033
Gitweb:     https://git.kernel.org/tip/55aedddb6149ab71bec9f050846855113977b033
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Jul 2019 13:40:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 23:17:37 +0200

x86/paravirt: Make read_cr2() CALLEE_SAVE

The one paravirt read_cr2() implementation (Xen) is actually quite trivial
and doesn't need to clobber anything other than the return register.

Making read_cr2() CALLEE_SAVE avoids all the PUSH/POP nonsense and allows
more convenient use from assembly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: bp@alien8.de
Cc: rostedt@goodmis.org
Cc: luto@kernel.org
Cc: torvalds@linux-foundation.org
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: zhe.he@windriver.com
Cc: joel@joelfernandes.org
Cc: devel@etsukata.com
Link: https://lkml.kernel.org/r/20190711114335.887392493@infradead.org

---
 arch/x86/entry/calling.h              |  6 ++++++
 arch/x86/include/asm/paravirt.h       | 22 +++++++++++++---------
 arch/x86/include/asm/paravirt_types.h |  2 +-
 arch/x86/kernel/asm-offsets.c         |  1 +
 arch/x86/kernel/head_64.S             |  4 +---
 arch/x86/kernel/paravirt.c            |  2 +-
 arch/x86/xen/enlighten_pv.c           |  3 ++-
 arch/x86/xen/mmu_pv.c                 | 12 +-----------
 arch/x86/xen/xen-asm.S                | 16 ++++++++++++++++
 arch/x86/xen/xen-ops.h                |  3 +++
 10 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1f9e3b8230..830bd984182b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -343,3 +343,9 @@ For 32-bit we have the following conventions - kernel is built with
 .Lafter_call_\@:
 #endif
 .endm
+
+#ifdef CONFIG_PARAVIRT_XXL
+#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
+#else
+#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
+#endif
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..5135282683d4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -116,7 +116,7 @@ static inline void write_cr0(unsigned long x)
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, mmu.read_cr2);
+	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
@@ -909,13 +909,7 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
 		 )
-#endif
-
-#define GET_CR2_INTO_RAX				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
@@ -929,9 +923,19 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
-#endif
+#endif /* CONFIG_PARAVIRT_XXL */
+#endif	/* CONFIG_X86_64 */
+
+#ifdef CONFIG_PARAVIRT_XXL
+
+#define GET_CR2_INTO_AX							\
+	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\
+		  ANNOTATE_RETPOLINE_SAFE;				\
+		  call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);		\
+		 )
+
+#endif /* CONFIG_PARAVIRT_XXL */
 
-#endif	/* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 946f8f1f1efc..639b2df445ee 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -220,7 +220,7 @@ struct pv_mmu_ops {
 	void (*exit_mmap)(struct mm_struct *mm);
 
 #ifdef CONFIG_PARAVIRT_XXL
-	unsigned long (*read_cr2)(void);
+	struct paravirt_callee_save read_cr2;
 	void (*write_cr2)(unsigned long);
 
 	unsigned long (*read_cr3)(void);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index da64452584b0..5c7ee3df4d0b 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -76,6 +76,7 @@ static void __used common(void)
 	BLANK();
 	OFFSET(XEN_vcpu_info_mask, vcpu_info, evtchn_upcall_mask);
 	OFFSET(XEN_vcpu_info_pending, vcpu_info, evtchn_upcall_pending);
+	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
 	BLANK();
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index bcd206c8ac90..0e2d72929a8c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -29,9 +29,7 @@
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
-#define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
-#define GET_CR2_INTO(reg) movq %cr2, reg
 #define INTERRUPT_RETURN iretq
 #endif
 
@@ -323,7 +321,7 @@ early_idt_handler_common:
 
 	cmpq $14,%rsi		/* Page fault? */
 	jnz 10f
-	GET_CR2_INTO(%rdi)	/* Can clobber any volatile register if pv */
+	GET_CR2_INTO(%rdi)	/* can clobber %rax if pv */
 	call early_make_pgtable
 	andl %eax,%eax
 	jz 20f			/* All good */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 98039d7fb998..0aa6256eedd8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -370,7 +370,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.exit_mmap		= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		= native_read_cr2,
+	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4722ba2966ac..26b63d051bda 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -998,7 +998,8 @@ void __init xen_setup_vcpu_info_placement(void)
 			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_ops.irq.irq_enable =
 			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_ops.mmu.read_cr2 = xen_read_cr2_direct;
+		pv_ops.mmu.read_cr2 =
+			__PV_IS_CALLEE_SAVE(xen_read_cr2_direct);
 	}
 }
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index f6e5eeecfc69..26e8b326966d 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1307,16 +1307,6 @@ static void xen_write_cr2(unsigned long cr2)
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }
 
-static unsigned long xen_read_cr2(void)
-{
-	return this_cpu_read(xen_vcpu)->arch.cr2;
-}
-
-unsigned long xen_read_cr2_direct(void)
-{
-	return this_cpu_read(xen_vcpu_info.arch.cr2);
-}
-
 static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
@@ -2397,7 +2387,7 @@ static void xen_leave_lazy_mmu(void)
 }
 
 static const struct pv_mmu_ops xen_mmu_ops __initconst = {
-	.read_cr2 = xen_read_cr2,
+	.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
 	.write_cr2 = xen_write_cr2,
 
 	.read_cr3 = xen_read_cr3,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 8019edd0125c..be104eef80be 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -10,6 +10,7 @@
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
+#include <asm/asm.h>
 
 #include <linux/linkage.h>
 
@@ -135,3 +136,18 @@ ENTRY(check_events)
 	FRAME_END
 	ret
 ENDPROC(check_events)
+
+ENTRY(xen_read_cr2)
+	FRAME_BEGIN
+	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
+	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2);
+
+ENTRY(xen_read_cr2_direct)
+	FRAME_BEGIN
+	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2_direct);
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 2f111f47ba98..45a441c33d6d 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -134,6 +134,9 @@ __visible void xen_irq_disable_direct(void);
 __visible unsigned long xen_save_fl_direct(void);
 __visible void xen_restore_fl_direct(unsigned long);
 
+__visible unsigned long xen_read_cr2(void);
+__visible unsigned long xen_read_cr2_direct(void);
+
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
 __visible void xen_sysret32(void);
