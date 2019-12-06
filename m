Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB13C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F982464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKUt7ka9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLFWOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:38 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:48382 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfLFWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:34 -0500
Received: by mail-pg1-f201.google.com with SMTP id p188so4542921pgp.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RFQeZBUfRbHmuBkixdwdHyK03/i2WwDYL6zKZ0PVNPE=;
        b=IKUt7ka9OPp04nuNFtbFmNhMED5ty9XakjQvaYcOsgsRH/SYzLcVVpMACFeRRQLdNK
         a0mE4lnUMI89KyyiE6NlXFQ2m8GZLvuy4PR6RLdT9AEzgHkAZhU6G5b+ckma8n0/nC3A
         uTP3fT2oiMISqhQbVaIW4gO4gBClTWdiTL7rm1J1XulV10rrt/IDRTieIL/GcGuQQsG4
         6Egq9+uHYBwiCGJ5LMSdZgryo1aNlorDmLG/eGF39k5gHk7IQUupl1+Ijf3qbFwsleLT
         LLpe6caJ3SjrMFXnNFw4D60rd2Nj6RFgfq1c/qqHzMkzJxwAtqhrgHtf2Hz7J2QnnbA5
         OZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RFQeZBUfRbHmuBkixdwdHyK03/i2WwDYL6zKZ0PVNPE=;
        b=AGUwrYTlU9B1NwaCXgSpuWpXCFrHNgiIFM3U+6jUvlnGABsrmXBAKckMVybSoXvf/z
         IL4r8Ga2GS3VA6jFNF0o4TxgKsNKDIc01n0mwh6iP0JjUBVLcxUGXV+c1vEO5fK52Q0m
         3xtJ9Az2990qO6ItEZRudDHoFQ06u5oFU4dddAvE2t7DLl1riqNdC3RomYl5Z7i4QzxL
         vNjKASvewh9KhDUj5Vz00Nvcr3QwU1QJH56Wtj0yekrlF/8snSpSLev5US9nO52gtgJh
         3E/Pb0dCA9L7+riiLblrzqaqYDdECK5NUFetJhXBUk9zOCFBjqzXCPM9MouzlQ9sOqbB
         oGuQ==
X-Gm-Message-State: APjAAAXAzzmwePGI6B4qjNl2HZE4wtBZm+zyxfNV4Zit3iT9lEWbkk3L
        4+YI0yjnq+TvcQsgdLLOP4dOYGHlHR+4V/Pwgo8=
X-Google-Smtp-Source: APXvYqxpGanN1bCoq5Nmn3aCH0YBZJAgBLdmk2cjRtHg7acgtGNdUOb0ffYjmscMm2O9CKp+3KwgpjzPR+bJF894TjI=
X-Received: by 2002:a63:3484:: with SMTP id b126mr5874359pga.17.1575670473753;
 Fri, 06 Dec 2019 14:14:33 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:51 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 15/15] arm64: scs: add shadow stacks for SDEI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds per-CPU shadow call stacks for the SDEI handler.
Similarly to how the kernel stacks are handled, we add separate shadow
stacks for normal and critical events.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/scs.h |   2 +
 arch/arm64/kernel/entry.S    |  14 ++++-
 arch/arm64/kernel/scs.c      | 106 +++++++++++++++++++++++++++++------
 arch/arm64/kernel/sdei.c     |   7 +++
 4 files changed, 112 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index c50d2b0c6c5f..8e327e14bc15 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -9,6 +9,7 @@
 #ifdef CONFIG_SHADOW_CALL_STACK
 
 extern void scs_init_irq(void);
+extern int scs_init_sdei(void);
 
 static __always_inline void scs_save(struct task_struct *tsk)
 {
@@ -27,6 +28,7 @@ static inline void scs_overflow_check(struct task_struct *tsk)
 #else /* CONFIG_SHADOW_CALL_STACK */
 
 static inline void scs_init_irq(void) {}
+static inline int scs_init_sdei(void) { return 0; }
 static inline void scs_save(struct task_struct *tsk) {}
 static inline void scs_overflow_check(struct task_struct *tsk) {}
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7aa2d366b2df..9327c3d21b64 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1048,13 +1048,16 @@ ENTRY(__sdei_asm_handler)
 
 	mov	x19, x1
 
+#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
+#endif
+
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * entry.S may have been using sp as a scratch register, find whether
 	 * this is a normal or critical event and switch to the appropriate
 	 * stack for this CPU.
 	 */
-	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
 	cbnz	w4, 1f
 	ldr_this_cpu dst=x5, sym=sdei_stack_normal_ptr, tmp=x6
 	b	2f
@@ -1064,6 +1067,15 @@ ENTRY(__sdei_asm_handler)
 	mov	sp, x5
 #endif
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+	/* Use a separate shadow call stack for normal and critical events */
+	cbnz	w4, 3f
+	ldr_this_cpu dst=x18, sym=sdei_shadow_call_stack_normal_ptr, tmp=x6
+	b	4f
+3:	ldr_this_cpu dst=x18, sym=sdei_shadow_call_stack_critical_ptr, tmp=x6
+4:
+#endif
+
 	/*
 	 * We may have interrupted userspace, or a guest, or exit-from or
 	 * return-to either of these. We can't trust sp_el0, restore it.
diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
index eaadf5430baa..dddb7c56518b 100644
--- a/arch/arm64/kernel/scs.c
+++ b/arch/arm64/kernel/scs.c
@@ -10,31 +10,105 @@
 #include <asm/pgtable.h>
 #include <asm/scs.h>
 
-DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+#define DECLARE_SCS(name)						\
+	DECLARE_PER_CPU(unsigned long *, name ## _ptr);			\
+	DECLARE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)
 
-#ifndef CONFIG_SHADOW_CALL_STACK_VMAP
-DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], irq_shadow_call_stack)
-	__aligned(SCS_SIZE);
+#ifdef CONFIG_SHADOW_CALL_STACK_VMAP
+#define DEFINE_SCS(name)						\
+	DEFINE_PER_CPU(unsigned long *, name ## _ptr)
+#else
+/* Allocate a static per-CPU shadow stack */
+#define DEFINE_SCS(name)						\
+	DEFINE_PER_CPU(unsigned long *, name ## _ptr);			\
+	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
+		__aligned(SCS_SIZE)
+#endif /* CONFIG_SHADOW_CALL_STACK_VMAP */
+
+DECLARE_SCS(irq_shadow_call_stack);
+DECLARE_SCS(sdei_shadow_call_stack_normal);
+DECLARE_SCS(sdei_shadow_call_stack_critical);
+
+DEFINE_SCS(irq_shadow_call_stack);
+#ifdef CONFIG_ARM_SDE_INTERFACE
+DEFINE_SCS(sdei_shadow_call_stack_normal);
+DEFINE_SCS(sdei_shadow_call_stack_critical);
 #endif
 
+static int scs_alloc_percpu(unsigned long * __percpu *ptr, int cpu)
+{
+	unsigned long *p;
+
+	p = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
+				 VMALLOC_START, VMALLOC_END,
+				 GFP_SCS, PAGE_KERNEL,
+				 0, cpu_to_node(cpu),
+				 __builtin_return_address(0));
+
+	if (!p)
+		return -ENOMEM;
+	per_cpu(*ptr, cpu) = p;
+
+	return 0;
+}
+
+static void scs_free_percpu(unsigned long * __percpu *ptr, int cpu)
+{
+	unsigned long *p = per_cpu(*ptr, cpu);
+
+	if (p) {
+		per_cpu(*ptr, cpu) = NULL;
+		vfree(p);
+	}
+}
+
+static void scs_free_sdei(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		scs_free_percpu(&sdei_shadow_call_stack_normal_ptr, cpu);
+		scs_free_percpu(&sdei_shadow_call_stack_critical_ptr, cpu);
+	}
+}
+
 void scs_init_irq(void)
 {
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-#ifdef CONFIG_SHADOW_CALL_STACK_VMAP
-		unsigned long *p;
+		if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK_VMAP))
+			WARN_ON(scs_alloc_percpu(&irq_shadow_call_stack_ptr,
+						 cpu));
+		else
+			per_cpu(irq_shadow_call_stack_ptr, cpu) =
+				per_cpu(irq_shadow_call_stack, cpu);
+	}
+}
 
-		p = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
-					 VMALLOC_START, VMALLOC_END,
-					 GFP_SCS, PAGE_KERNEL,
-					 0, cpu_to_node(cpu),
-					 __builtin_return_address(0));
+int scs_init_sdei(void)
+{
+	int cpu;
 
-		per_cpu(irq_shadow_call_stack_ptr, cpu) = p;
-#else
-		per_cpu(irq_shadow_call_stack_ptr, cpu) =
-			per_cpu(irq_shadow_call_stack, cpu);
-#endif /* CONFIG_SHADOW_CALL_STACK_VMAP */
+	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK_VMAP)) {
+			if (scs_alloc_percpu(
+				&sdei_shadow_call_stack_normal_ptr, cpu) ||
+			    scs_alloc_percpu(
+				&sdei_shadow_call_stack_critical_ptr, cpu)) {
+				scs_free_sdei();
+				return -ENOMEM;
+			}
+		} else {
+			per_cpu(sdei_shadow_call_stack_normal_ptr, cpu) =
+				per_cpu(sdei_shadow_call_stack_normal, cpu);
+			per_cpu(sdei_shadow_call_stack_critical_ptr, cpu) =
+				per_cpu(sdei_shadow_call_stack_critical, cpu);
+		}
 	}
+
+	return 0;
 }
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index d6259dac62b6..2854b9f7760a 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -13,6 +13,7 @@
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
 #include <asm/ptrace.h>
+#include <asm/scs.h>
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
@@ -162,6 +163,12 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 			return 0;
 	}
 
+	if (scs_init_sdei()) {
+		if (IS_ENABLED(CONFIG_VMAP_STACK))
+			free_sdei_stacks();
+		return 0;
+	}
+
 	sdei_exit_mode = (conduit == SMCCC_CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-- 
2.24.0.393.g34dc348eaf-goog

