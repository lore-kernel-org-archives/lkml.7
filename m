Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B375DCA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197921D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Gok8T07u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409111AbfJRAuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:50:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34737 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408807AbfJRAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:59 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so5428392ion.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3NziRvdn2+kK8Uw4QbU0HMH6O8cLDFVZEbh6XeL1sY=;
        b=Gok8T07uC2ipQ9VW5tYHspu6O8Wr0bh0vwo7z2IyRedQR3a3/vHXyFTsGLJAPLpfZ1
         wBhDjSO+NWrKT46+f8dUbZbI3wJnelJVVeW0NA+247qCyD6FSmfFvIg2veaQA9/jHn6I
         8M+90gxuHpFKbAaTiSLU/A1WYYg4Rjg6oyBjjkYjI64TpxgkqGAmLP/7Cffv1oM/rBup
         NfeaHsqQYNp/pWyltRpgDB7cozD/ZuWAEjzWNQcA/WGlft7b9DX/bp+60e12xjmzDJfH
         DWpPtj9gENrn4L4jVTu7g934zaXTN3+znVdX5JNCoHGxB+kL+PVSzHO9b4kbSHRQiFIr
         dgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3NziRvdn2+kK8Uw4QbU0HMH6O8cLDFVZEbh6XeL1sY=;
        b=QN9AOZMsIRHQ1gEMpeXvFN2CNY1jzILqi0VDf3+nsoN9Xx3g7OqTEGmWfjD6ZVozEY
         ZzUkVrz03NtfDSXEAc3zAej3dyUeAVZwjv08cYv57bsWCl76IsZHaEoWEhPNC9Us1wCh
         SJ0wIycKfFJALomD60ZaGsx8YyZK3LF8/pMRgkuxgDO/ZrnhP7eo7RFdC0C7LRgIVLEG
         sw9w06w5GJLGUvydGYNEO+qniMu4F5NFb71/4zrCwKLHRMv6qRhfZORTDwO/UfmZZt4g
         Maf7Lf5n/byRViwCUmvzKzVaykfwbDZ+V2KJYOqrdpvTu+w47p8TpMM+mHkw5fOePLhI
         U1fw==
X-Gm-Message-State: APjAAAUVMtAujMGrsqxRfmO4Hln7D8txRBie3ohHEYzGxnC+vqW/Lh+0
        N4mDBS539KUmL2CruNp/8D4V2xXl+TU=
X-Google-Smtp-Source: APXvYqxsnRrt2A3w8IXl4OSNAXOcY/yyDjv4iYOG/mSDmoknP6Xks90gq+mT3OQHegaNfv+sOT2Vsw==
X-Received: by 2002:a05:6602:119:: with SMTP id s25mr6015773iot.111.1571359798798;
        Thu, 17 Oct 2019 17:49:58 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] riscv: add missing header file includes
Date:   Thu, 17 Oct 2019 17:49:28 -0700
Message-Id: <20191018004929.3445-8-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
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
arch/riscv/kernel/process.c:93:5: warning: symbol 'arch_dup_task_struct' was not declared. Should it be static?
arch/riscv/kernel/reset.c:15:6: warning: symbol 'pm_power_off' was not declared. Should it be static?
arch/riscv/kernel/syscall_table.c:15:6: warning: symbol 'sys_call_table' was not declared. Should it be static?
arch/riscv/kernel/time.c:14:13: warning: symbol 'time_init' was not declared. Should it be static?
arch/riscv/kernel/vdso.c:54:5: warning: symbol 'arch_setup_additional_pages' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:134:24: warning: symbol 'smp_callin' was not declared. Should it be static?
arch/riscv/kernel/smp.c:64:6: warning: symbol 'arch_match_cpu_phys_id' was not declared. Should it be static?
arch/riscv/kernel/smp.c:70:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
arch/riscv/kernel/module-sections.c:89:5: warning: symbol 'module_frob_arch_sections' was not declared. Should it be static?
arch/riscv/mm/context.c:42:6: warning: symbol 'switch_mm' was not declared. Should it be static?

Fix by including the appropriate header files in the appropriate
source files.

This patch should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
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
 arch/riscv/kernel/vdso.c            | 1 +
 arch/riscv/mm/context.c             | 1 +
 12 files changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 589e2d9fb2a6..f0e9df6e6049 100644
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
2.23.0

