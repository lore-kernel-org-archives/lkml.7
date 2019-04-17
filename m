Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996A7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4628221773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AWFE3Dy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbfDQOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:23:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52071 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:23:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEMDS33936095
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:22:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEMDS33936095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510935;
        bh=z1W8WDxkujJiiK/F/GowQ9zxowZ1maRkB2ApbcJP77k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AWFE3Dy204LujThQ0++CRaWevikvZqG17BYGEIoQTiftfwQjK9bSyayLFtJKjkrG3
         ROSRw2FqcP5p7u0ab6bgeONWI7IlhbOupDPu0tag0mmH3NKt8NOcILzCaphpbXRyJm
         utosInbIszNra1hPAwWGMQazwbJlYw95s/sODb5CYu8WoACT6H/31KZ2B/v+xdpJ+F
         z9WTR0vSo6/3/+tIZVXX7i+NBxgZMEy+uE89O0dEud4Igs0aIslwpxOmA4ZBjcim9v
         ZNJCwXObp+3W1/tBeUZeYGKqeE8QBigUngBD7lPIrfDhlkBRJcBotwD/sP4iOe6+tc
         jF8x/vfnPV5Vg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEMC1q3936091;
        Wed, 17 Apr 2019 07:22:12 -0700
Date:   Wed, 17 Apr 2019 07:22:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-e6401c13093173aad709a5c6de00cf8d692ee786@git.kernel.org>
Cc:     mhocko@suse.com, brijesh.singh@amd.com, jroedel@suse.de,
        maran.wilson@oracle.com, bp@suse.de, tglx@linutronix.de,
        sstabellini@kernel.org, luto@kernel.org, ard.biesheuvel@linaro.org,
        mingo@redhat.com, feng.tang@intel.com, hpa@zytor.com,
        x86@kernel.org, JBeulich@suse.com, sean.j.christopherson@intel.com,
        jgross@suse.com, nstange@suse.de, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        konrad.wilk@oracle.com, chang.seok.bae@intel.com,
        boris.ostrovsky@oracle.com, puwen@hygon.cn, jkosina@suse.cz,
        mingo@kernel.org, mail@jordan-borgner.de, peterz@infradead.org,
        vbabka@suse.cz, rafael@espindo.la, ndesaulniers@google.com,
        yamada.masahiro@socionext.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, linux@dominikbrodowski.net
Reply-To: mhocko@suse.com, brijesh.singh@amd.com, jroedel@suse.de,
          bp@suse.de, maran.wilson@oracle.com, tglx@linutronix.de,
          luto@kernel.org, ard.biesheuvel@linaro.org,
          sstabellini@kernel.org, feng.tang@intel.com, mingo@redhat.com,
          hpa@zytor.com, x86@kernel.org, nstange@suse.de, jgross@suse.com,
          JBeulich@suse.com, sean.j.christopherson@intel.com,
          rppt@linux.vnet.ibm.com, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
          chang.seok.bae@intel.com, boris.ostrovsky@oracle.com,
          puwen@hygon.cn, mingo@kernel.org, jkosina@suse.cz,
          peterz@infradead.org, mail@jordan-borgner.de, rafael@espindo.la,
          ndesaulniers@google.com, vbabka@suse.cz,
          yamada.masahiro@socionext.com, adobriyan@gmail.com,
          linux@dominikbrodowski.net, akpm@linux-foundation.org
In-Reply-To: <20190414160146.267376656@linutronix.de>
References: <20190414160146.267376656@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Split the IRQ stack into its own pages
Git-Commit-ID: e6401c13093173aad709a5c6de00cf8d692ee786
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

Commit-ID:  e6401c13093173aad709a5c6de00cf8d692ee786
Gitweb:     https://git.kernel.org/tip/e6401c13093173aad709a5c6de00cf8d692ee786
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 14 Apr 2019 18:00:06 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:37:02 +0200

x86/irq/64: Split the IRQ stack into its own pages

Currently, the IRQ stack is hardcoded as the first page of the percpu
area, and the stack canary lives on the IRQ stack. The former gets in
the way of adding an IRQ stack guard page, and the latter is a potential
weakness in the stack canary mechanism.

Split the IRQ stack into its own private percpu pages.

[ tglx: Make 64 and 32 bit share struct irq_stack ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Feng Tang <feng.tang@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Maran Wilson <maran.wilson@oracle.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael Ávila de Espíndola" <rafael@espindo.la>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20190414160146.267376656@linutronix.de
---
 arch/x86/entry/entry_64.S             |  4 ++--
 arch/x86/include/asm/processor.h      | 32 ++++++++++++++------------------
 arch/x86/include/asm/stackprotector.h |  6 +++---
 arch/x86/kernel/asm-offsets_64.c      |  2 +-
 arch/x86/kernel/cpu/common.c          |  8 ++++----
 arch/x86/kernel/head_64.S             |  2 +-
 arch/x86/kernel/irq_64.c              |  5 ++++-
 arch/x86/kernel/setup_percpu.c        |  5 -----
 arch/x86/kernel/vmlinux.lds.S         |  7 ++++---
 arch/x86/tools/relocs.c               |  2 +-
 arch/x86/xen/xen-head.S               | 10 +++++-----
 11 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 726abbe6c6d8..cfe4d6ea258d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -298,7 +298,7 @@ ENTRY(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(irq_stack_union)+stack_canary_offset
+	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + stack_canary_offset
 #endif
 
 #ifdef CONFIG_RETPOLINE
@@ -430,7 +430,7 @@ END(irq_entries_start)
 	 * it before we actually move ourselves to the IRQ stack.
 	 */
 
-	movq	\old_rsp, PER_CPU_VAR(irq_stack_union + IRQ_STACK_SIZE - 8)
+	movq	\old_rsp, PER_CPU_VAR(irq_stack_backing_store + IRQ_STACK_SIZE - 8)
 	movq	PER_CPU_VAR(hardirq_stack_ptr), %rsp
 
 #ifdef CONFIG_DEBUG_ENTRY
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5e3dd4e2136d..7e99ef67bff0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -367,6 +367,13 @@ DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
 #define __KERNEL_TSS_LIMIT	\
 	(IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
 
+/* Per CPU interrupt stacks */
+struct irq_stack {
+	char		stack[IRQ_STACK_SIZE];
+} __aligned(IRQ_STACK_SIZE);
+
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+
 #ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #else
@@ -375,28 +382,24 @@ DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #endif
 
 #ifdef CONFIG_X86_64
-union irq_stack_union {
-	char irq_stack[IRQ_STACK_SIZE];
+struct fixed_percpu_data {
 	/*
 	 * GCC hardcodes the stack canary as %gs:40.  Since the
 	 * irq_stack is the object at %gs:0, we reserve the bottom
 	 * 48 bytes of the irq stack for the canary.
 	 */
-	struct {
-		char gs_base[40];
-		unsigned long stack_canary;
-	};
+	char		gs_base[40];
+	unsigned long	stack_canary;
 };
 
-DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_union);
+DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
+DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(irq_stack_union.gs_base, cpu);
+	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(char *, hardirq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
@@ -418,14 +421,7 @@ struct stack_canary {
 };
 DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
-/*
- * per-CPU IRQ handling stacks
- */
-struct irq_stack {
-	char			stack[IRQ_STACK_SIZE];
-} __aligned(IRQ_STACK_SIZE);
-
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+/* Per CPU softirq stack pointer */
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* X86_64 */
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 8ec97a62c245..91e29b6a86a5 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -13,7 +13,7 @@
  * On x86_64, %gs is shared by percpu area and stack canary.  All
  * percpu symbols are zero based and %gs points to the base of percpu
  * area.  The first occupant of the percpu area is always
- * irq_stack_union which contains stack_canary at offset 40.  Userland
+ * fixed_percpu_data which contains stack_canary at offset 40.  Userland
  * %gs is always saved and restored on kernel entry and exit using
  * swapgs, so stack protector doesn't add any complexity there.
  *
@@ -64,7 +64,7 @@ static __always_inline void boot_init_stack_canary(void)
 	u64 tsc;
 
 #ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(union irq_stack_union, stack_canary) != 40);
+	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
 #endif
 	/*
 	 * We both use the random pool and the current TSC as a source
@@ -79,7 +79,7 @@ static __always_inline void boot_init_stack_canary(void)
 
 	current->stack_canary = canary;
 #ifdef CONFIG_X86_64
-	this_cpu_write(irq_stack_union.stack_canary, canary);
+	this_cpu_write(fixed_percpu_data.stack_canary, canary);
 #else
 	this_cpu_write(stack_canary.canary, canary);
 #endif
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index f5281567e28e..d3d075226c0a 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -73,7 +73,7 @@ int main(void)
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
-	DEFINE(stack_canary_offset, offsetof(union irq_stack_union, stack_canary));
+	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
 	BLANK();
 #endif
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1222080838da..801c6f040faa 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1498,9 +1498,9 @@ static __init int setup_clearcpuid(char *arg)
 __setup("clearcpuid=", setup_clearcpuid);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(union irq_stack_union,
-		     irq_stack_union) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(irq_stack_union);
+DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
+		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
+EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
 /*
  * The following percpu variables are hot.  Align current_task to
@@ -1510,7 +1510,7 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(char *, hardirq_stack_ptr);
+DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d1dbe8e4eb82..bcd206c8ac90 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -265,7 +265,7 @@ ENDPROC(start_cpu0)
 	GLOBAL(initial_code)
 	.quad	x86_64_start_kernel
 	GLOBAL(initial_gs)
-	.quad	INIT_PER_CPU_VAR(irq_stack_union)
+	.quad	INIT_PER_CPU_VAR(fixed_percpu_data)
 	GLOBAL(initial_stack)
 	/*
 	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index c0bea0d7d76a..c0f89d136b80 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -23,6 +23,9 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
+DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
+DECLARE_INIT_PER_CPU(irq_stack_backing_store);
+
 int sysctl_panic_on_stackoverflow;
 
 /*
@@ -90,7 +93,7 @@ bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 
 static int map_irq_stack(unsigned int cpu)
 {
-	void *va = per_cpu_ptr(irq_stack_union.irq_stack, cpu);
+	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
 	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
 	return 0;
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 657343ecc2da..86663874ef04 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -244,11 +244,6 @@ void __init setup_per_cpu_areas(void)
 		per_cpu(x86_cpu_to_logical_apicid, cpu) =
 			early_per_cpu_map(x86_cpu_to_logical_apicid, cpu);
 #endif
-#ifdef CONFIG_X86_64
-		per_cpu(hardirq_stack_ptr, cpu) =
-			per_cpu(irq_stack_union.irq_stack, cpu) +
-			IRQ_STACK_SIZE;
-#endif
 #ifdef CONFIG_NUMA
 		per_cpu(x86_cpu_to_node_map, cpu) =
 			early_per_cpu_map(x86_cpu_to_node_map, cpu);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bad8c51fee6e..a5af9a7c4be4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -403,7 +403,8 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_union);
+INIT_PER_CPU(fixed_percpu_data);
+INIT_PER_CPU(irq_stack_backing_store);
 
 /*
  * Build-time check on the image size:
@@ -412,8 +413,8 @@ INIT_PER_CPU(irq_stack_union);
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
 #ifdef CONFIG_SMP
-. = ASSERT((irq_stack_union == 0),
-           "irq_stack_union is not at start of per-cpu area");
+. = ASSERT((fixed_percpu_data == 0),
+           "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
 #endif /* CONFIG_X86_32 */
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b629f6992d9f..efa483205e43 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -738,7 +738,7 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__irq_stack_union
+ *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 5077ead5e59c..c1d8b90aa4e2 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -40,13 +40,13 @@ ENTRY(startup_xen)
 #ifdef CONFIG_X86_64
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to the bottom of the irqstack
-	 * union.  If the stack protector canary is enabled, it is
-	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
-	 * init data section till per cpu areas are set up.
+	 * The base of %gs always points to fixed_percpu_data.  If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
 	cdq
 	wrmsr
 #endif
