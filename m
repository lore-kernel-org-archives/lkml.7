Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF90CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9639A21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VrmTrkRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408896AbfJRAuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:50:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34733 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407397AbfJRAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:56 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so5428277ion.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sw5Ks5zpf1Nuh8wRuxwVGtvcKmJb0kK5d8WuX5BG9jw=;
        b=VrmTrkRvVTEn84dhRBdS11oAkVzg6uonjQBBnhJOw6SMZ8UivLCf1eojFdqM5R6EfK
         jeZ4yawEZ6j5ZHz7DMqCSdCdYmrsbxTI3Wt6PWwiADCAsIGlcuPMMk8j1of31LTtV9uG
         1ljVOqZza+kEuaqYKPhQpKppLLPrEh8l4v2QIKbACUoK5UAlPFZDVp0gEVri0PiA6HFG
         XANw+6qppe+f/LKH+WvV2nIhM7TKOzG7VChTMIlED9Tx79WHAr7lEWWI1S/EGL5X+6Nn
         H7j9RQ2svFXzPRkGkYBtp8JVDBjMBF7Sd/XpIyVlbeMAVq36Z7bUqNtjTXm+2h0oLTQq
         NMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw5Ks5zpf1Nuh8wRuxwVGtvcKmJb0kK5d8WuX5BG9jw=;
        b=c8s9wjb+VLm3LNoik4SJDdTSC9Hz7rG2ABo22H1Lra/bnfUodZP2w82eQIY1GmJVxC
         AUchvsh7PfT4puesmmx00KI7TWHrwPZh0ayjTricFBKt21K2iLzZot/qMkQIQQg5U+yI
         cOLUQBGoB9Z93PsxTJ+cpJfew9i5mS+L4RCjIOix8D3Pd05PWllgLdojuKS5IfX2Zz0p
         7Js30eJTEpMBkfMjG+eZAw6VxIQmcQwEHC5hQl05Prc01mforcPCFRNfiev6soA8ROZG
         30MNwhTFQpIpqqwVsqgs3Ryw/o0kSZtvWElajVbIR65r/CLuTtG200dxvMLIXSU/IeB8
         UWyg==
X-Gm-Message-State: APjAAAV8LuZeV8RCBlR9JhilUvQA1pMQP6vHgy7Ee6emNQAP2oXwMH4G
        4lTlgJ/WQQmS54cuQwYc/vwCWw==
X-Google-Smtp-Source: APXvYqymE5ZR4YyA/tn085AGhj69LfIIF6ea+V9gGTis9QH4ixI2j7nXOaoAqmTbg7Qdf1ShSPZm1Q==
X-Received: by 2002:a5d:8b12:: with SMTP id k18mr6270154ion.133.1571359795802;
        Thu, 17 Oct 2019 17:49:55 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:55 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] riscv: add missing prototypes
Date:   Thu, 17 Oct 2019 17:49:26 -0700
Message-Id: <20191018004929.3445-6-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse identifies these missing prototypes when building arch/riscv:

arch/riscv/kernel/cpu.c:149:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?
arch/riscv/kernel/irq.c:27:29: warning: symbol 'do_IRQ' was not declared. Should it be static?
arch/riscv/kernel/irq.c:57:13: warning: symbol 'init_IRQ' was not declared. Should it be static?
arch/riscv/kernel/syscall_table.c:15:6: warning: symbol 'sys_call_table' was not declared. Should it be static?
arch/riscv/kernel/time.c:15:13: warning: symbol 'time_init' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:135:24: warning: symbol 'smp_callin' was not declared. Should it be static?
arch/riscv/kernel/smp.c:72:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
arch/riscv/mm/init.c:151:7: warning: symbol 'trampoline_pg_dir' was not declared. Should it be static?
arch/riscv/mm/init.c:157:7: warning: symbol 'early_pg_dir' was not declared. Should it be static?
arch/riscv/kernel/process.c:32:6: warning: symbol 'show_regs' was not declared. Should it be static?
arch/riscv/kernel/ptrace.c:151:6: warning: symbol 'do_syscall_trace_enter' was not declared. Should it be static?
arch/riscv/kernel/ptrace.c:165:6: warning: symbol 'do_syscall_trace_exit' was not declared. Should it be static?

Fix by adding the missing prototypes to the appropriate header files.

This change should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/irq.h       | 3 +++
 arch/riscv/include/asm/pgtable.h   | 2 ++
 arch/riscv/include/asm/processor.h | 4 ++++
 arch/riscv/include/asm/ptrace.h    | 4 ++++
 arch/riscv/include/asm/smp.h       | 2 ++
 5 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 75576424c0f7..589e2d9fb2a6 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,9 @@
 void riscv_timer_interrupt(void);
 void riscv_software_interrupt(void);
 
+asmlinkage void do_IRQ(struct pt_regs *regs);
+void __init init_IRQ(void);
+
 #include <asm-generic/irq.h>
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 42292d99cc74..7fc5e4a56715 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -61,6 +61,8 @@
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
+extern pgd_t trampoline_pg_dir[];
+extern pgd_t early_pg_dir[];
 extern pgd_t swapper_pg_dir[];
 
 /* MAP_PRIVATE permissions: xwr (copy-on-write) */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f539149d04c2..ab56435de629 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -78,6 +78,10 @@ int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
+extern const struct seq_operations cpuinfo_op;
+
+void time_init(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index d48d1e13973c..78562f3317e6 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -101,6 +101,10 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+void do_syscall_trace_enter(struct pt_regs *regs);
+void do_syscall_trace_exit(struct pt_regs *regs);
+void show_regs(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a83451d73a4e..d19dd2e2e1da 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,6 +15,8 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
+asmlinkage void __init smp_callin(void);
+
 #ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
-- 
2.23.0

