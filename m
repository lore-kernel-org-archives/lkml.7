Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8085CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9214121928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LgeCmyzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfJXW7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:59:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37429 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733033AbfJXW66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:58:58 -0400
Received: by mail-io1-f68.google.com with SMTP id 1so226811iou.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZGI60drGLEmEdUk33cvNefM4FOv+8ekneB/xoyZ64U=;
        b=LgeCmyzq23k8BWVjg2WviMFw8asiFBOvnZg7deJhibXBj1HLTBlXz2vtpnQ6nuIYvO
         XXFnlxRKjcHWQYLFLJ+PGlibLnPi0qPFQNOVjpAyB0F8gpz94/hhIxkGiWm4o5dWHQQl
         yISQyG07EPAmoCquUbFwPbvGFTVGQ8qMKj4ySY3TV57lmIwbPq0Gt/WyYmSyKm1fZ2dw
         hZ7UPF4bB4ilAvTlLhFkqZvI215lMskH8EDR1PBt7SXnJytJcImFTwn2usKcGyDl0/Za
         pg7eitZrlVfgwryr4t/I0S5U+AIqcX1Bduxn7xAQhroR7MsiV4wFRIRI9aK5aO0d6Rtt
         yAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZGI60drGLEmEdUk33cvNefM4FOv+8ekneB/xoyZ64U=;
        b=QVWU1vNFShV7GFVrVUYxeCq2jjFsPy1aMTsqF3slFihtlbGQVeMGhO5nhAx149KMr7
         8aB2YXtCwyB7QkkyueVnEWclmK7IT0VwHD4zbIhJVvQt+aCs7o0SNt7r/zHgy0JD4pc6
         ac6IC8hcary0vT3v7Gah7//ObCGrq+qZcGIescMPzW8EUiGUH5VSH42nhcl8IvrjnXua
         652NGgNZ737iyOuEuNpCziHxn/ewdLo92xDnHMCXp3hoRQYpJ+W/ycEMUH2XNnz+RVYb
         PogBe/FOdUnD92dV0X+owt2aRPpLtzFG4yRsMEOHzP+mcQxLny9VbAzSnBvMRSTF1Sbd
         H7HA==
X-Gm-Message-State: APjAAAXDO/v2csoclpTGxphvBIi2zjY/pJK9r6ch7jWMNqHW+LAeGAN+
        OhPLtwzeuk6yL0Rwq5lD0QicGg==
X-Google-Smtp-Source: APXvYqy5a3tMIoeboC3+CjPmvSWpA4ri/LdZPhn89cOMCvNtxEs3nSMucfncykRCBi1B9Sfu9WS8dA==
X-Received: by 2002:a6b:7942:: with SMTP id j2mr591492iop.161.1571957937016;
        Thu, 24 Oct 2019 15:58:57 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm58112ilo.70.2019.10.24.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:58:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.dev, greentime.hu@sifive.com,
        luc.vanoostenryck@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 4/6] riscv: add missing header file includes
Date:   Thu, 24 Oct 2019 15:58:36 -0700
Message-Id: <20191024225838.27743-5-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191024225838.27743-1-paul.walmsley@sifive.com>
References: <20191024225838.27743-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse identifies several missing prototypes caused by missing
preprocessor include directives:

arch/riscv/kernel/cpufeature.c:16:6: warning: symbol 'has_fpu' was not declared. Should it be static?
arch/riscv/kernel/process.c:26:6: warning: symbol 'arch_cpu_idle' was not declared. Should it be static?
arch/riscv/kernel/reset.c:15:6: warning: symbol 'pm_power_off' was not declared. Should it be static?
arch/riscv/kernel/syscall_table.c:15:6: warning: symbol 'sys_call_table' was not declared. Should it be static?
arch/riscv/kernel/traps.c:149:13: warning: symbol 'trap_init' was not declared. Should it be static?
arch/riscv/kernel/vdso.c:54:5: warning: symbol 'arch_setup_additional_pages' was not declared. Should it be static?
arch/riscv/kernel/smp.c:64:6: warning: symbol 'arch_match_cpu_phys_id' was not declared. Should it be static?
arch/riscv/kernel/module-sections.c:89:5: warning: symbol 'module_frob_arch_sections' was not declared. Should it be static?
arch/riscv/mm/context.c:42:6: warning: symbol 'switch_mm' was not declared. Should it be static?

Fix by including the appropriate header files in the appropriate
source files.

This patch should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/irq.h        | 3 +++
 arch/riscv/include/asm/switch_to.h  | 1 +
 arch/riscv/kernel/cpufeature.c      | 1 +
 arch/riscv/kernel/module-sections.c | 1 +
 arch/riscv/kernel/process.c         | 2 ++
 arch/riscv/kernel/reset.c           | 1 +
 arch/riscv/kernel/smp.c             | 2 ++
 arch/riscv/kernel/smpboot.c         | 1 +
 arch/riscv/kernel/syscall_table.c   | 1 +
 arch/riscv/kernel/time.c            | 1 +
 arch/riscv/kernel/traps.c           | 1 +
 arch/riscv/kernel/vdso.c            | 1 +
 arch/riscv/mm/context.c             | 1 +
 13 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 75576424c0f7..6e1b0e0325eb 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -7,6 +7,9 @@
 #ifndef _ASM_RISCV_IRQ_H
 #define _ASM_RISCV_IRQ_H
 
+#include <linux/interrupt.h>
+#include <linux/linkage.h>
+
 #define NR_IRQS         0
 
 void riscv_timer_interrupt(void);
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index f0227bdce0f0..ee4f0ac62c9d 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_RISCV_SWITCH_TO_H
 #define _ASM_RISCV_SWITCH_TO_H
 
+#include <linux/sched/task_stack.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1ade9a49347..a5ad00043104 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/hwcap.h>
 #include <asm/smp.h>
+#include <asm/switch_to.h>
 
 unsigned long elf_hwcap __read_mostly;
 #ifdef CONFIG_FPU
diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index c9ae48333114..e264e59e596e 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -8,6 +8,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 
 unsigned long module_emit_got_entry(struct module *mod, unsigned long val)
 {
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index fb3a082362eb..85e3c39bb60b 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -19,6 +20,7 @@
 #include <asm/csr.h>
 #include <asm/string.h>
 #include <asm/switch_to.h>
+#include <asm/thread_info.h>
 
 extern asmlinkage void ret_from_fork(void);
 extern asmlinkage void ret_from_kernel_thread(void);
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index d0fe623bfb8f..aa56bb135ec4 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/reboot.h>
+#include <linux/pm.h>
 #include <asm/sbi.h>
 
 static void default_power_off(void)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b18cd6c8e8fb..5c9ec78422c2 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -8,7 +8,9 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 59fa59e013d4..ec0be2f6a2e8 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -29,6 +29,7 @@
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>
+#include <asm/smp.h>
 
 #include "head.h"
 
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
index e5dd52d8f633..f1ead9df96ca 100644
--- a/arch/riscv/kernel/syscall_table.c
+++ b/arch/riscv/kernel/syscall_table.c
@@ -8,6 +8,7 @@
 #include <linux/syscalls.h>
 #include <asm-generic/syscalls.h>
 #include <asm/vdso.h>
+#include <asm/syscall.h>
 
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	[nr] = (call),
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 9dd1f2e64db1..6a53c02e9c73 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -7,6 +7,7 @@
 #include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <asm/sbi.h>
+#include <asm/processor.h>
 
 unsigned long riscv_timebase;
 EXPORT_SYMBOL_GPL(riscv_timebase);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 10a17e545f43..0b6e271efc43 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index e24fccab8185..484d95a70907 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2015 Regents of the University of California
  */
 
+#include <linux/elf.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/binfmts.h>
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index beeb5d7f92ea..ca66d44156b6 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
+#include <asm/mmu_context.h>
 
 /*
  * When necessary, performs a deferred icache flush for the given MM context,
-- 
2.24.0.rc0

