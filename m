Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC6DC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7709B20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558169478;
	bh=zVvEor8YH8Hh20xh0H3oNcWyU8GN8XZ5r+LS9h26qMY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yWK8OOcN1SlExGV9NOTBpZx2+j4TcjVXMheDGKRHJwbNbvaj0w5L1tKnozx664jXS
	 tZlAofrU8Xz0J2OjHXRdaafZzVPb1DGe9919nvmMv/XhBcVaNJxtLmTwlXzzdb6Zj0
	 VbANpPHNj/15Qf0eulb0EJAMky96mf4doK7b72YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfERIvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:51:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfERIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:51:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so8906103wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/wF9v2iVkRv3vieWULL9HEr1N+pHzbIwb5kSK4YkLQs=;
        b=QtrA4U4tF6capQu4B/+J8InDu1aggugu5pAl82N3MKinE9QGyfb09wtjRbO9/0lM6H
         bxX4iFEj1Pn9njgxa5zGESdKkg686gdksWLaupo3DbVvQmI/4jCSVSeQ3f71YNoHOS6Q
         Eb6+xGqQKLvV918K2zjz3w9s5EvTGKdh3cOVyK7mXdlNv7e4vDDj4myEY97MjeZJXINi
         WZzhiPR6Q2JiGuZljfq8y6sbX975mPLg5q/t6KxEi+yu+kg4NdSufehJXezrWGrtQFbX
         8448TOm5BPe7fEIgJ+0uQuH0zNvI76tuRFR8DWS0Z0vzUu4R+pgYoZlPHisTJWcOuVw7
         362Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=/wF9v2iVkRv3vieWULL9HEr1N+pHzbIwb5kSK4YkLQs=;
        b=Y+vbdfXQPK3eHQJVyfVFiBcQ7nenBA/m1AsFe0TQcjfkRdvpSzC2CEFWKHCxQx/x12
         +8IWLWT+b8wUK2tdPWNcytKzF4kr1mYSOdB2l2eD59oV8yZFzF0IRn9h3eHOBxbi9kC0
         wl0hTXPZya+kPQZdKYUsuDyL2qDz5A8D6CJZ30WpruhtlcIEsFtwCKbKi7NekugX+vMH
         ZBdUmVyBQG92U4zyhMJ9jEBTsZGrb+ERRYNjtFPDO6+db1eJZ09mwiiU0lXmZOpdNqMN
         5aKU3yDctSJ363R5nUfcCttzUO6WPlzj4mMOjClKcGaLEyqrxkHNN894nMMHAHPohkPy
         WjSQ==
X-Gm-Message-State: APjAAAXJ2Q/x5OeLkGB3+YBTbksgZO0nILFfNrVnwZFKbDjMbUelDByE
        avp/yWvU+Pi9oj6QddCspnE=
X-Google-Smtp-Source: APXvYqxPXnXc3eVcJ0yDU/MdT5ajkvKguJ5+EVbMr2hjAvHmlz1i5afAVPz7vhfnctkBcOVJlR3SfA==
X-Received: by 2002:a1c:cb81:: with SMTP id b123mr4882378wmg.107.1558169474180;
        Sat, 18 May 2019 01:51:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m13sm9725889wrs.87.2019.05.18.01.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 01:51:13 -0700 (PDT)
Date:   Sat, 18 May 2019 10:51:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>, Dave Hansen <dave@sr71.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core kernel fixes
Message-ID: <20190518085111.GA45888@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 8ea58f1e8b11cca3087b294779bf5959bf89cc10 objtool: Allow AR to be overridden with HOSTAR

This fixes a particularly thorny munmap() bug with MPX, plus fixes a host 
build environment assumption in objtool.

 Thanks,

	Ingo

------------------>
Dave Hansen (1):
      x86/mpx, mm/core: Fix recursive munmap() corruption

Nathan Chancellor (1):
      objtool: Allow AR to be overridden with HOSTAR


 arch/powerpc/include/asm/mmu_context.h   |  1 -
 arch/um/include/asm/mmu_context.h        |  1 -
 arch/unicore32/include/asm/mmu_context.h |  1 -
 arch/x86/include/asm/mmu_context.h       |  6 +++---
 arch/x86/include/asm/mpx.h               | 15 ++++++++-------
 arch/x86/mm/mpx.c                        | 10 ++++++----
 include/asm-generic/mm_hooks.h           |  1 -
 mm/mmap.c                                | 15 ++++++++-------
 tools/objtool/Makefile                   |  3 ++-
 9 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 6ee8195a2ffb..4a6dd3ba0b0b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -237,7 +237,6 @@ extern void arch_exit_mmap(struct mm_struct *mm);
 #endif
 
 static inline void arch_unmap(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
 			      unsigned long start, unsigned long end)
 {
 	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index fca34b2177e2..9f4b4bb78120 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -22,7 +22,6 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 }
 extern void arch_exit_mmap(struct mm_struct *mm);
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
index 5c205a9cb5a6..9f06ea5466dd 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -88,7 +88,6 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 93dff1963337..9024236693d2 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -278,8 +278,8 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
 	mpx_mm_init(mm);
 }
 
-static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-			      unsigned long start, unsigned long end)
+static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
+			      unsigned long end)
 {
 	/*
 	 * mpx_notify_unmap() goes and reads a rarely-hot
@@ -299,7 +299,7 @@ static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * consistently wrong.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_MPX)))
-		mpx_notify_unmap(mm, vma, start, end);
+		mpx_notify_unmap(mm, start, end);
 }
 
 /*
diff --git a/arch/x86/include/asm/mpx.h b/arch/x86/include/asm/mpx.h
index d0b1434fb0b6..143a5c193ed3 100644
--- a/arch/x86/include/asm/mpx.h
+++ b/arch/x86/include/asm/mpx.h
@@ -64,12 +64,15 @@ struct mpx_fault_info {
 };
 
 #ifdef CONFIG_X86_INTEL_MPX
-int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
-int mpx_handle_bd_fault(void);
+
+extern int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
+extern int mpx_handle_bd_fault(void);
+
 static inline int kernel_managing_mpx_tables(struct mm_struct *mm)
 {
 	return (mm->context.bd_addr != MPX_INVALID_BOUNDS_DIR);
 }
+
 static inline void mpx_mm_init(struct mm_struct *mm)
 {
 	/*
@@ -78,11 +81,10 @@ static inline void mpx_mm_init(struct mm_struct *mm)
 	 */
 	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
 }
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end);
 
-unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
-		unsigned long flags);
+extern void mpx_notify_unmap(struct mm_struct *mm, unsigned long start, unsigned long end);
+extern unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len, unsigned long flags);
+
 #else
 static inline int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
 {
@@ -100,7 +102,6 @@ static inline void mpx_mm_init(struct mm_struct *mm)
 {
 }
 static inline void mpx_notify_unmap(struct mm_struct *mm,
-				    struct vm_area_struct *vma,
 				    unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index c805db6236b4..7aeb9fe2955f 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -881,9 +881,10 @@ static int mpx_unmap_tables(struct mm_struct *mm,
  * the virtual address region start...end have already been split if
  * necessary, and the 'vma' is the first vma in this range (start -> end).
  */
-void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
+void mpx_notify_unmap(struct mm_struct *mm, unsigned long start,
+		      unsigned long end)
 {
+	struct vm_area_struct *vma;
 	int ret;
 
 	/*
@@ -902,11 +903,12 @@ void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * which should not occur normally. Being strict about it here
 	 * helps ensure that we do not have an exploitable stack overflow.
 	 */
-	do {
+	vma = find_vma(mm, start);
+	while (vma && vma->vm_start < end) {
 		if (vma->vm_flags & VM_MPX)
 			return;
 		vma = vma->vm_next;
-	} while (vma && vma->vm_start < end);
+	}
 
 	ret = mpx_unmap_tables(mm, start, end);
 	if (ret)
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index 8ac4e68a12f0..6736ed2f632b 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -18,7 +18,6 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
-			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index bd7b9f293b39..2d6a6662edb9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2735,9 +2735,17 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		return -EINVAL;
 
 	len = PAGE_ALIGN(len);
+	end = start + len;
 	if (len == 0)
 		return -EINVAL;
 
+	/*
+	 * arch_unmap() might do unmaps itself.  It must be called
+	 * and finish any rbtree manipulation before this code
+	 * runs and also starts to manipulate the rbtree.
+	 */
+	arch_unmap(mm, start, end);
+
 	/* Find the first overlapping VMA */
 	vma = find_vma(mm, start);
 	if (!vma)
@@ -2746,7 +2754,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* we have  start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
-	end = start + len;
 	if (vma->vm_start >= end)
 		return 0;
 
@@ -2816,12 +2823,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* Detach vmas from rbtree */
 	detach_vmas_to_be_unmapped(mm, vma, prev, end);
 
-	/*
-	 * mpx unmap needs to be called with mmap_sem held for write.
-	 * It is safe to call it before unmap_region().
-	 */
-	arch_unmap(mm, vma, start, end);
-
 	if (downgrade)
 		downgrade_write(&mm->mmap_sem);
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 53f8be0f4a1f..88158239622b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -7,11 +7,12 @@ ARCH := x86
 endif
 
 # always use the host compiler
+HOSTAR	?= ar
 HOSTCC	?= gcc
 HOSTLD	?= ld
+AR	 = $(HOSTAR)
 CC	 = $(HOSTCC)
 LD	 = $(HOSTLD)
-AR	 = ar
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
