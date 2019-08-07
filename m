Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0EA21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0NkoRum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbfHGNd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:33:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfHGNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:31:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so40771180plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e1qgTbhZ3ilsUFJdPMIsnkWUy0Sq5muknSgMZN/FEUs=;
        b=n0NkoRumuiNGa89NyRsLYLINlG24HJgySkd6Jq0w/YYGjFBPtrepN1XIih5CYhpOiJ
         lckztJkDgtNQROigUO0sDRt1/BoW2ZTizewLDeO4XwkZTJc92mMLcrXMwqB9BeNbElpR
         6I5MmjFwLXhcSr32dLkmep5Wy1qRw55yQEq96UcgkLFKkxXCVqjO2Lx3ZEPMLfjmAhkF
         QYle0rXftZyEKRl0S4zZI+x5faFbO3/vpzvRPzAPmK7M+XY+beqO5+D2dirqJ6gkvXyf
         QKWE+k399+XYkAdjdmseQrCFbqSX8VYP4NAYMRrEDqhB/uE2Ue9SZAUicZy0II8G3Sgb
         2iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e1qgTbhZ3ilsUFJdPMIsnkWUy0Sq5muknSgMZN/FEUs=;
        b=QiVIICDQFNvRuxNA68vhoYE/t9r3MEGQpAB+qEcwGbdVKSgkVOmkNCNeMlSFG4XfZO
         24jaLdglhupZXowujP1ZoMHZDl+AT5Qke7jQfDis6oUy8Gs5F7WSLlh0oJrSqJ+1J10e
         x1cPD+co8wGd7hC4Dht4pB1dOksm3SkdmxQXq5D8Rd0OG4pBOYJ5NLcSY8kSmkjTLnoa
         +x156Wb6SNX9eNmH384QZxoJSyVfVZtqYWflpuNWe89ZZZg9mDLwHrVwdLSdNDmA8N2N
         Is2Sv6Kq205DEMtBIo6zMY/MKehpFw4E6uuhVTgdEVQ5ZT5/GrA4zgdGaBFDIRdeuDxa
         98gw==
X-Gm-Message-State: APjAAAW4UwaaI2UbILL1Avjkex0qkzSsG3KuLeBXQNPpTuvyVowrxVD1
        L6bz0Oq8X+1yIouHKSO2Giw=
X-Google-Smtp-Source: APXvYqzRcSxU7bCc8aTKDsA9pItoBJnbVvlv6UoQ9Jcu5JZx/glDXhTuzwbYvv/lBWzlf4P3tuKiEQ==
X-Received: by 2002:aa7:8108:: with SMTP id b8mr9501158pfi.197.1565184665086;
        Wed, 07 Aug 2019 06:31:05 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id f7sm88423063pfd.43.2019.08.07.06.31.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 06:31:04 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] riscv: Using CSR numbers to access CSRs
Date:   Wed,  7 Aug 2019 06:30:56 -0700
Message-Id: <1565184656-4282-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1562831376-21255-1-git-send-email-bmeng.cn@gmail.com>
References: <1562831376-21255-1-git-send-email-bmeng.cn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a3182c91ef4e ("RISC-V: Access CSRs using CSR numbers"),
we should prefer accessing CSRs using their CSR numbers, but there
are several leftovers like sstatus / sptbr we missed.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Anup Patel <anup@brainfault.org>

---

Changes in v2:
- add SoB tag of Christoph Hellwig and Andreas Schwab
- change CSR_SATP in mm/init.c that was recently changed after v1 patch

 arch/riscv/kernel/entry.S |  6 +++---
 arch/riscv/kernel/fpu.S   |  8 ++++----
 arch/riscv/kernel/head.S  |  2 +-
 arch/riscv/lib/uaccess.S  | 12 ++++++------
 arch/riscv/mm/context.c   |  7 +------
 arch/riscv/mm/init.c      |  2 +-
 6 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bc7a56e..74ccfd4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -167,7 +167,7 @@ ENTRY(handle_exception)
 	tail do_IRQ
 1:
 	/* Exceptions run with interrupts enabled */
-	csrs sstatus, SR_SIE
+	csrs CSR_SSTATUS, SR_SIE
 
 	/* Handle syscalls */
 	li t0, EXC_SYSCALL
@@ -222,7 +222,7 @@ ret_from_syscall:
 
 ret_from_exception:
 	REG_L s0, PT_SSTATUS(sp)
-	csrc sstatus, SR_SIE
+	csrc CSR_SSTATUS, SR_SIE
 	andi s0, s0, SR_SPP
 	bnez s0, resume_kernel
 
@@ -265,7 +265,7 @@ work_pending:
 	bnez s1, work_resched
 work_notifysig:
 	/* Handle pending signals and notify-resume requests */
-	csrs sstatus, SR_SIE /* Enable interrupts for do_notify_resume() */
+	csrs CSR_SSTATUS, SR_SIE /* Enable interrupts for do_notify_resume() */
 	move a0, sp /* pt_regs */
 	move a1, s0 /* current_thread_info->flags */
 	tail do_notify_resume
diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
index 1defb06..631d315 100644
--- a/arch/riscv/kernel/fpu.S
+++ b/arch/riscv/kernel/fpu.S
@@ -23,7 +23,7 @@ ENTRY(__fstate_save)
 	li  a2,  TASK_THREAD_F0
 	add a0, a0, a2
 	li t1, SR_FS
-	csrs sstatus, t1
+	csrs CSR_SSTATUS, t1
 	frcsr t0
 	fsd f0,  TASK_THREAD_F0_F0(a0)
 	fsd f1,  TASK_THREAD_F1_F0(a0)
@@ -58,7 +58,7 @@ ENTRY(__fstate_save)
 	fsd f30, TASK_THREAD_F30_F0(a0)
 	fsd f31, TASK_THREAD_F31_F0(a0)
 	sw t0, TASK_THREAD_FCSR_F0(a0)
-	csrc sstatus, t1
+	csrc CSR_SSTATUS, t1
 	ret
 ENDPROC(__fstate_save)
 
@@ -67,7 +67,7 @@ ENTRY(__fstate_restore)
 	add a0, a0, a2
 	li t1, SR_FS
 	lw t0, TASK_THREAD_FCSR_F0(a0)
-	csrs sstatus, t1
+	csrs CSR_SSTATUS, t1
 	fld f0,  TASK_THREAD_F0_F0(a0)
 	fld f1,  TASK_THREAD_F1_F0(a0)
 	fld f2,  TASK_THREAD_F2_F0(a0)
@@ -101,6 +101,6 @@ ENTRY(__fstate_restore)
 	fld f30, TASK_THREAD_F30_F0(a0)
 	fld f31, TASK_THREAD_F31_F0(a0)
 	fscsr t0
-	csrc sstatus, t1
+	csrc CSR_SSTATUS, t1
 	ret
 ENDPROC(__fstate_restore)
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 0f1ba17..86049ae 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -61,7 +61,7 @@ _start_kernel:
 	 * floating point in kernel space
 	 */
 	li t0, SR_FS
-	csrc sstatus, t0
+	csrc CSR_SSTATUS, t0
 
 	/* Pick one hart to run the main boot sequence */
 	la a3, hart_lottery
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 399e6f0..ed2696c 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -18,7 +18,7 @@ ENTRY(__asm_copy_from_user)
 
 	/* Enable access to user memory */
 	li t6, SR_SUM
-	csrs sstatus, t6
+	csrs CSR_SSTATUS, t6
 
 	add a3, a1, a2
 	/* Use word-oriented copy only if low-order bits match */
@@ -47,7 +47,7 @@ ENTRY(__asm_copy_from_user)
 
 3:
 	/* Disable access to user memory */
-	csrc sstatus, t6
+	csrc CSR_SSTATUS, t6
 	li a0, 0
 	ret
 4: /* Edge case: unalignment */
@@ -72,7 +72,7 @@ ENTRY(__clear_user)
 
 	/* Enable access to user memory */
 	li t6, SR_SUM
-	csrs sstatus, t6
+	csrs CSR_SSTATUS, t6
 
 	add a3, a0, a1
 	addi t0, a0, SZREG-1
@@ -94,7 +94,7 @@ ENTRY(__clear_user)
 
 3:
 	/* Disable access to user memory */
-	csrc sstatus, t6
+	csrc CSR_SSTATUS, t6
 	li a0, 0
 	ret
 4: /* Edge case: unalignment */
@@ -114,11 +114,11 @@ ENDPROC(__clear_user)
 	/* Fixup code for __copy_user(10) and __clear_user(11) */
 10:
 	/* Disable access to user memory */
-	csrs sstatus, t6
+	csrs CSR_SSTATUS, t6
 	mv a0, a2
 	ret
 11:
-	csrs sstatus, t6
+	csrs CSR_SSTATUS, t6
 	mv a0, a1
 	ret
 	.previous
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 89ceb3c..beeb5d7 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -57,12 +57,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
-	/*
-	 * Use the old spbtr name instead of using the current satp
-	 * name to support binutils 2.29 which doesn't know about the
-	 * privileged ISA 1.10 yet.
-	 */
-	csr_write(sptbr, virt_to_pfn(next->pgd) | SATP_MODE);
+	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | SATP_MODE);
 	local_flush_tlb_all();
 
 	flush_icache_deferred(next);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 42bf939..238fc41 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -435,7 +435,7 @@ static void __init setup_vm_final(void)
 	clear_fixmap(FIX_PMD);
 
 	/* Move to swapper page table */
-	csr_write(sptbr, PFN_DOWN(__pa(swapper_pg_dir)) | SATP_MODE);
+	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
 }
 
-- 
2.7.4

