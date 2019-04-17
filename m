Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85814C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A6021773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hFHcrnUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfDQOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:20:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:20:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEJQZE3935573
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:19:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEJQZE3935573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510767;
        bh=t+rPHEsUM+z7X+7CU/vfHYjmtoDOW6a5gwpfNmIPV1A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hFHcrnUGIz7dvi6YpooKKPU5Rd1HOyOENYyE5S7uBTE7oLr7uFC4CLEdHfQXq/OEV
         M0Yl2IVwqy7gI9Ud949ImLweNdX4log4wKN9ot9Q24cvyJzmbl7pVVGUWrYlqc4bJt
         AAqf7FiICwGCHrgfBAu4MSiwR96XGPNQYe+9P9IkCFIvNeGy8pbrMddviMbi3rH+e/
         UYjgmz5X7YvdP9SwJH29H5qZEHmgqiz8pm8D53+CcjP5NQ10PjHCd2JiXUDFnEb4G4
         VC5vwvtnRYF7EBuK6g75qJAAHBRYkxnQV6Ttcq0RjuMFTfjt2JRbFNFuXnYo32LdWD
         83m1CVZnoQulA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEJOlY3935570;
        Wed, 17 Apr 2019 07:19:24 -0700
Date:   Wed, 17 Apr 2019 07:19:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-758a2e312228410f2f5092ade558109e93dc3ee8@git.kernel.org>
Cc:     chang.seok.bae@intel.com, nstange@suse.de, kernelfans@gmail.com,
        mhocko@suse.com, linux@dominikbrodowski.net,
        konrad.wilk@oracle.com, jpoimboe@redhat.com,
        ndesaulniers@google.com, mingo@redhat.com, adobriyan@gmail.com,
        bp@suse.de, x86@kernel.org, rppt@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        luto@kernel.org, jkosina@suse.cz, vbabka@suse.cz,
        sean.j.christopherson@intel.com
Reply-To: jkosina@suse.cz, luto@kernel.org, tglx@linutronix.de,
          mingo@kernel.org, sean.j.christopherson@intel.com,
          vbabka@suse.cz, peterz@infradead.org, sfr@canb.auug.org.au,
          akpm@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, adobriyan@gmail.com,
          mingo@redhat.com, rppt@linux.vnet.ibm.com, x86@kernel.org,
          bp@suse.de, nstange@suse.de, chang.seok.bae@intel.com,
          jpoimboe@redhat.com, ndesaulniers@google.com, mhocko@suse.com,
          linux@dominikbrodowski.net, konrad.wilk@oracle.com,
          kernelfans@gmail.com
In-Reply-To: <20190414160145.912584074@linutronix.de>
References: <20190414160145.912584074@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Rename irq_stack_ptr to hardirq_stack_ptr
Git-Commit-ID: 758a2e312228410f2f5092ade558109e93dc3ee8
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

Commit-ID:  758a2e312228410f2f5092ade558109e93dc3ee8
Gitweb:     https://git.kernel.org/tip/758a2e312228410f2f5092ade558109e93dc3ee8
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:02 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:27:10 +0200

x86/irq/64: Rename irq_stack_ptr to hardirq_stack_ptr

Preparatory patch to share code with 32bit.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.912584074@linutronix.de
---
 arch/x86/entry/entry_64.S        | 2 +-
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/common.c     | 2 +-
 arch/x86/kernel/dumpstack_64.c   | 2 +-
 arch/x86/kernel/irq_64.c         | 2 +-
 arch/x86/kernel/setup_percpu.c   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ee649f1f279e..726abbe6c6d8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -431,7 +431,7 @@ END(irq_entries_start)
 	 */
 
 	movq	\old_rsp, PER_CPU_VAR(irq_stack_union + IRQ_STACK_SIZE - 8)
-	movq	PER_CPU_VAR(irq_stack_ptr), %rsp
+	movq	PER_CPU_VAR(hardirq_stack_ptr), %rsp
 
 #ifdef CONFIG_DEBUG_ENTRY
 	/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0b7d866a1ad5..5e3dd4e2136d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -396,7 +396,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(irq_stack_union.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(char *, irq_stack_ptr);
+DECLARE_PER_CPU(char *, hardirq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 88cab45707a9..13ec72bb8f36 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,7 +1510,7 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(char *, irq_stack_ptr) =
+DEFINE_PER_CPU(char *, hardirq_stack_ptr) =
 	init_per_cpu_var(irq_stack_union.irq_stack) + IRQ_STACK_SIZE;
 
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index f356d3ea0c70..753b8cfe8b8a 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -120,7 +120,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end   = (unsigned long *)this_cpu_read(irq_stack_ptr);
+	unsigned long *end   = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *begin = end - (IRQ_STACK_SIZE / sizeof(long));
 
 	/*
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 7eb6f8d11bfd..f0c7356c8969 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -56,7 +56,7 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 	    regs->sp <= curbase + THREAD_SIZE)
 		return;
 
-	irq_stack_top = (u64)__this_cpu_read(irq_stack_ptr);
+	irq_stack_top = (u64)__this_cpu_read(hardirq_stack_ptr);
 	irq_stack_bottom = irq_stack_top - IRQ_STACK_SIZE + STACK_MARGIN;
 	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
 		return;
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 4bf46575568a..657343ecc2da 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -245,7 +245,7 @@ void __init setup_per_cpu_areas(void)
 			early_per_cpu_map(x86_cpu_to_logical_apicid, cpu);
 #endif
 #ifdef CONFIG_X86_64
-		per_cpu(irq_stack_ptr, cpu) =
+		per_cpu(hardirq_stack_ptr, cpu) =
 			per_cpu(irq_stack_union.irq_stack, cpu) +
 			IRQ_STACK_SIZE;
 #endif
