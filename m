Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2147FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F3E21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCVHpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:45:50 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47575 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:45:50 -0400
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4A88E20001D;
        Fri, 22 Mar 2019 07:45:43 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 3/4] mips: Use generic mmap top-down layout
Date:   Fri, 22 Mar 2019 03:42:24 -0400
Message-Id: <20190322074225.22282-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322074225.22282-1-alex@ghiti.fr>
References: <20190322074225.22282-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mips uses a top-down layout by default that fits the generic functions.
At the same time, this commit allows to fix problem uncovered
and not fixed for mips here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/mips/include/asm/processor.h |  4 +--
 arch/mips/mm/mmap.c               | 57 -------------------------------
 2 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index aca909bd7841..f8e04962b52d 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -30,9 +30,9 @@
 extern unsigned int vced_count, vcei_count;
 
 /*
- * MIPS does have an arch_pick_mmap_layout()
+ * MIPS uses the default implementation of topdown mmap layout.
  */
-#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
+#define ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 2f616ebeb7e0..61e65a69bb09 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -20,33 +20,6 @@
 unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
 EXPORT_SYMBOL(shm_align_mask);
 
-/* gap between mmap and stack */
-#define MIN_GAP (128*1024*1024UL)
-#define MAX_GAP ((TASK_SIZE)/6*5)
-
-static int mmap_is_legacy(struct rlimit *rlim_stack)
-{
-	if (current->personality & ADDR_COMPAT_LAYOUT)
-		return 1;
-
-	if (rlim_stack->rlim_cur == RLIM_INFINITY)
-		return 1;
-
-	return sysctl_legacy_va_layout;
-}
-
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
-{
-	unsigned long gap = rlim_stack->rlim_cur;
-
-	if (gap < MIN_GAP)
-		gap = MIN_GAP;
-	else if (gap > MAX_GAP)
-		gap = MAX_GAP;
-
-	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
-}
-
 #define COLOUR_ALIGN(addr, pgoff)				\
 	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
 	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
@@ -144,36 +117,6 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 			addr0, len, pgoff, flags, DOWN);
 }
 
-unsigned long arch_mmap_rnd(void)
-{
-	unsigned long rnd;
-
-#ifdef CONFIG_COMPAT
-	if (TASK_IS_32BIT_ADDR)
-		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
-	else
-#endif /* CONFIG_COMPAT */
-		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
-
-	return rnd << PAGE_SHIFT;
-}
-
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
-{
-	unsigned long random_factor = 0UL;
-
-	if (current->flags & PF_RANDOMIZE)
-		random_factor = arch_mmap_rnd();
-
-	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		mm->get_unmapped_area = arch_get_unmapped_area;
-	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
-	}
-}
-
 static inline unsigned long brk_rnd(void)
 {
 	unsigned long rnd = get_random_long();
-- 
2.20.1

