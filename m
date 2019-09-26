Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F6C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695D3222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfIZJkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7103 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:40:52 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48FD488309
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:51 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id i28so1351964pfq.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XP6gr3eQdJ6u+sy/NHvjIjEoZ5vslpS8bcX23tyuCE4=;
        b=HSkwZMMDr43bTkic4GYoiOhwCw5jZKw9DIDMXqb4S5opKMNzTbJdmBsC2hpiOkaBIQ
         YkTgJheXB1n/13or8jW9e3p627NvGfaGihfhYlJUKWkN8FO2iqZrcitk4/ol4zv7wNPo
         BAii63vOR0p3kk+FKufrvgzCQ1TCVRAp4bjDu2praUAnBobFiZCKpGGwNVTBCVR6h7kC
         B26+I1JrE4b6O5BmCAU4sSmHapb6/Ig2m6YDt59yCn1ARohBi4DdWZ7tFFJt0QzesgDB
         tthqL82HjSxAb9KAnp030kigcsKlZj3TyZ6cbn+k1hRhcIf6gFpPudLa+2gpvTLw4CJt
         u9vQ==
X-Gm-Message-State: APjAAAU5HZBqLzDsN8r0RwEidNXGoNo6So40ZtqHj4UWQpf4p9RJPW1+
        rgEPjKKwhNUlT6MsBlj+rfdXlR06TSA7SUV1cF7swgntHkwTYc9qrdbbKqg+s4fUM182RfmUP/g
        RN2QoFR8uV/W/yZJrsjtqddDE
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr2531929pjt.108.1569490850674;
        Thu, 26 Sep 2019 02:40:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7yR58nRgGu4SMpKi5ogu9u89i//blno2FCMu/YjHE1i9BEbFh647zHZqW2SOGSk22OQdVhg==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr2531894pjt.108.1569490850207;
        Thu, 26 Sep 2019 02:40:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:40:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 11/16] mm: Introduce FAULT_FLAG_DEFAULT
Date:   Thu, 26 Sep 2019 17:38:59 +0800
Message-Id: <20190926093904.5090-12-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there're tons of arch-specific page fault handlers, most of
them are still sharing the same initial value of the page fault flags.
Say, merely all of the page fault handlers would allow the fault to be
retried, and they also allow the fault to respond to SIGKILL.

Let's define a default value for the fault flags to replace those
initial page fault flags that were copied over.  With this, it'll be
far easier to introduce new fault flag that can be used by all the
architectures instead of touching all the archs.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c      | 2 +-
 arch/arc/mm/fault.c        | 2 +-
 arch/arm/mm/fault.c        | 2 +-
 arch/arm64/mm/fault.c      | 2 +-
 arch/hexagon/mm/vm_fault.c | 2 +-
 arch/ia64/mm/fault.c       | 2 +-
 arch/m68k/mm/fault.c       | 2 +-
 arch/microblaze/mm/fault.c | 2 +-
 arch/mips/mm/fault.c       | 2 +-
 arch/nds32/mm/fault.c      | 2 +-
 arch/nios2/mm/fault.c      | 2 +-
 arch/openrisc/mm/fault.c   | 2 +-
 arch/parisc/mm/fault.c     | 2 +-
 arch/powerpc/mm/fault.c    | 2 +-
 arch/riscv/mm/fault.c      | 2 +-
 arch/s390/mm/fault.c       | 2 +-
 arch/sh/mm/fault.c         | 2 +-
 arch/sparc/mm/fault_32.c   | 2 +-
 arch/sparc/mm/fault_64.c   | 2 +-
 arch/um/kernel/trap.c      | 2 +-
 arch/unicore32/mm/fault.c  | 2 +-
 arch/x86/mm/fault.c        | 2 +-
 arch/xtensa/mm/fault.c     | 2 +-
 include/linux/mm.h         | 7 +++++++
 24 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index aea33b599037..fcfa229cc1e7 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -89,7 +89,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
 	   (or is suppressed by the PALcode).  Support that for older CPUs
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index ee3ba7c7b891..33a609f1c43c 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -94,7 +94,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	         (regs->ecr_cause == ECR_C_PROTV_INST_FETCH))
 		exec = 1;
 
-	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 	if (write)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index c8f2950fa733..101ae6698637 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -241,7 +241,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm;
 	int sig, code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4a695a44fb05..23e3feca0f02 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -410,7 +410,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	struct mm_struct *mm = current->mm;
 	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
-	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index d19beaf11b4c..d9e15d941bdb 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -41,7 +41,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	int si_code = SEGV_MAPERR;
 	vm_fault_t fault;
 	const struct exception_table_entry *fixup;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	/*
 	 * If we're in an interrupt or have no user context,
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 211b4f439384..b5aa4e80c762 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -65,7 +65,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	struct mm_struct *mm = current->mm;
 	unsigned long mask;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
 		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index a455e202691b..182799fd9987 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -71,7 +71,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct * vma;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	pr_debug("do page fault:\nregs->sr=%#x, regs->pc=%#lx, address=%#lx, %ld, %p\n",
 		regs->sr, regs->pc, address, error_code, mm ? mm->pgd : NULL);
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index cdde01dcdfc3..32da02778a63 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -91,7 +91,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	int code = SEGV_MAPERR;
 	int is_write = error_code & ESR_S;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	regs->ear = address;
 	regs->esr = error_code;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 31fda59199eb..f811ef5efb80 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -44,7 +44,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	const int field = sizeof(unsigned long) * 2;
 	int si_code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
 
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index c8f32b4784bd..4e402f2c88c3 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -76,7 +76,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	int si_code;
 	vm_fault_t fault;
 	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	error_code = error_code & (ITYPE_mskINST | ITYPE_mskETYPE);
 	tsk = current;
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 704ace8ca0ee..c38bea4220fb 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -47,7 +47,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	struct mm_struct *mm = tsk->mm;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	cause >>= 2;
 
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 85c7eb0c0186..30d5c51e9d40 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -50,7 +50,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct vm_area_struct *vma;
 	int si_code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index f9be1d1cb43f..8e88e5c5f26a 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -274,7 +274,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	if (!mm)
 		goto no_context;
 
-	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7dabd1243f1b..db156537a2fa 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -435,7 +435,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 {
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
  	int is_exec = TRAP(regs) == 0x400;
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 48a60e128b3f..1f77dd2c491c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -28,7 +28,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr, cause;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 179cf92a56e5..551ac311bd35 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -429,7 +429,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 	if (access == VM_WRITE || (trans_exc_code & store_indication) == 0x400)
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index eb4048ad0b38..d9c8f2d00a54 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -380,7 +380,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 	mm = tsk->mm;
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 7a62edf7f68b..447f61c4e996 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -168,7 +168,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	int from_user = !(regs->psr & PSR_PS);
 	int code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	if (text_fault)
 		address = regs->pc;
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index d90bafb63e17..6807fba66331 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -267,7 +267,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	int si_code, fault_code;
 	vm_fault_t fault;
 	unsigned long address, mm_rss;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	fault_code = get_thread_fault_code();
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 58fe36856182..bc2756782d64 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -32,7 +32,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	pmd_t *pmd;
 	pte_t *pte;
 	int err = -EFAULT;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	*code_out = SEGV_MAPERR;
 
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 59d0e6ec2cfc..34a90453ca18 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -202,7 +202,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm;
 	int sig, code;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 	mm = tsk->mm;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 059331797827..d211585cfffd 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1287,7 +1287,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	vm_fault_t fault, major = 0;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
 	mm = tsk->mm;
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 8651520de460..6467e3fb9762 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -43,7 +43,7 @@ void do_page_fault(struct pt_regs *regs)
 
 	int is_write, is_exec;
 	vm_fault_t fault;
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	code = SEGV_MAPERR;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..57fb5c535f8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -393,6 +393,13 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
 #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
 
+/*
+ * The default fault flags that should be used by most of the
+ * arch-specific page fault handlers.
+ */
+#define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
+			     FAULT_FLAG_KILLABLE)
+
 #define FAULT_FLAG_TRACE \
 	{ FAULT_FLAG_WRITE,		"WRITE" }, \
 	{ FAULT_FLAG_MKWRITE,		"MKWRITE" }, \
-- 
2.21.0

