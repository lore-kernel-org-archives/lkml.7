Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD82FC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D45F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDDFxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:53:51 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53711 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:53:51 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4E94BFF80F;
        Thu,  4 Apr 2019 05:53:44 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 2/5] arm64, mm: Move generic mmap layout functions to mm
Date:   Thu,  4 Apr 2019 01:51:25 -0400
Message-Id: <20190404055128.24330-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404055128.24330-1-alex@ghiti.fr>
References: <20190404055128.24330-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 handles top-down mmap layout in a way that can be easily reused
by other architectures, so make it available in mm.

This commit also takes the opportunity to:
- make use of is_compat_task instead of specific arm64 test
  test_thread_flag(TIF_32BIT), which allows more genericity and is
  equivalent.
- fix the case where stack randomization should not be taken into
  account.

It then introduces a new config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
that can be set by other architectures to benefit from those functions.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/Kconfig                       |  8 ++++
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/processor.h |  2 -
 arch/arm64/mm/mmap.c               | 72 ----------------------------
 kernel/sysctl.c                    |  6 ++-
 mm/util.c                          | 77 +++++++++++++++++++++++++++++-
 6 files changed, 89 insertions(+), 77 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dddd86a..ef8d0b50cc41 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -684,6 +684,14 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
 	  and vice-versa 32-bit applications to call 64-bit mmap().
 	  Required for applications doing different bitness syscalls.
 
+config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	bool
+	help
+	  This allows to use a set of generic functions to determine mmap base
+	  address by giving priority to top-down scheme only if the process
+	  is not in legacy mode (compat task, unlimited stack size or
+	  sysctl_legacy_va_layout).
+
 config HAVE_COPY_THREAD_TLS
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9eba5de..670719a26b45 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -66,6 +66,7 @@ config ARM64
 	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5d9ce62bdebd..4de2a2fd605a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -274,8 +274,6 @@ static inline void spin_lock_prefetch(const void *ptr)
 		     "nop") : : "p" (ptr));
 }
 
-#define HAVE_ARCH_PICK_MMAP_LAYOUT
-
 #endif
 
 extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size */
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 842c8a5fcd53..c74224421216 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -31,78 +31,6 @@
 
 #include <asm/cputype.h>
 
-/*
- * Leave enough space between the mmap area and the stack to honour ulimit in
- * the face of randomisation.
- */
-#define MIN_GAP (SZ_128M)
-#define MAX_GAP	(STACK_TOP/6*5)
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
-unsigned long arch_mmap_rnd(void)
-{
-	unsigned long rnd;
-
-#ifdef CONFIG_COMPAT
-	if (test_thread_flag(TIF_32BIT))
-		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
-	else
-#endif
-		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
-	return rnd << PAGE_SHIFT;
-}
-
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
-{
-	unsigned long gap = rlim_stack->rlim_cur;
-	unsigned long pad = (STACK_RND_MASK << PAGE_SHIFT) + stack_guard_gap;
-
-	/* Values close to RLIM_INFINITY can overflow. */
-	if (gap + pad > gap)
-		gap += pad;
-
-	if (gap < MIN_GAP)
-		gap = MIN_GAP;
-	else if (gap > MAX_GAP)
-		gap = MAX_GAP;
-
-	return PAGE_ALIGN(STACK_TOP - gap - rnd);
-}
-
-/*
- * This function, called very early during the creation of a new process VM
- * image, sets up which VM layout function to use:
- */
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
-{
-	unsigned long random_factor = 0UL;
-
-	if (current->flags & PF_RANDOMIZE)
-		random_factor = arch_mmap_rnd();
-
-	/*
-	 * Fall back to the standard layout if the personality bit is set, or
-	 * if the expected stack growth is unlimited:
-	 */
-	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		mm->get_unmapped_area = arch_get_unmapped_area;
-	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
-	}
-}
-
 /*
  * You really shouldn't be using read() or write() on /dev/mem.  This might go
  * away in the future.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e5da394d1ca3..eb3414e78986 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -269,7 +269,8 @@ extern struct ctl_table epoll_table[];
 extern struct ctl_table firmware_config_table[];
 #endif
 
-#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
+#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
+    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
 int sysctl_legacy_va_layout;
 #endif
 
@@ -1564,7 +1565,8 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec,
 		.extra1		= &zero,
 	},
-#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
+#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
+    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
 	{
 		.procname	= "legacy_va_layout",
 		.data		= &sysctl_legacy_va_layout,
diff --git a/mm/util.c b/mm/util.c
index a54afb9b4faa..2027457ec30d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -15,7 +15,12 @@
 #include <linux/vmalloc.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/elf.h>
+#include <linux/elf-randomize.h>
+#include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/processor.h>
+#include <linux/sizes.h>
+#include <linux/compat.h>
 
 #include <linux/uaccess.h>
 
@@ -313,13 +318,83 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 #endif
 }
 
-#if defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
+#ifdef CONFIG_MMU
+#ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+
+#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
+unsigned long arch_mmap_rnd(void)
+{
+	unsigned long rnd;
+
+#ifdef CONFIG_COMPAT
+	if (is_compat_task())
+		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
+	else
+#endif
+		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
+
+	return rnd << PAGE_SHIFT;
+}
+#endif
+
+static int mmap_is_legacy(struct rlimit *rlim_stack)
+{
+	if (current->personality & ADDR_COMPAT_LAYOUT)
+		return 1;
+
+	if (rlim_stack->rlim_cur == RLIM_INFINITY)
+		return 1;
+
+	return sysctl_legacy_va_layout;
+}
+
+#define MIN_GAP		(SZ_128M)
+#define MAX_GAP		(STACK_TOP / 6 * 5)
+
+static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+{
+	unsigned long gap = rlim_stack->rlim_cur;
+	unsigned long pad = stack_guard_gap;
+
+	/* Account for stack randomization if necessary */
+	if (current->flags & PF_RANDOMIZE)
+		pad += (STACK_RND_MASK << PAGE_SHIFT);
+
+	/* Values close to RLIM_INFINITY can overflow. */
+	if (gap + pad > gap)
+		gap += pad;
+
+	if (gap < MIN_GAP)
+		gap = MIN_GAP;
+	else if (gap > MAX_GAP)
+		gap = MAX_GAP;
+
+	return PAGE_ALIGN(STACK_TOP - gap - rnd);
+}
+
+void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+{
+	unsigned long random_factor = 0UL;
+
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = arch_mmap_rnd();
+
+	if (mmap_is_legacy(rlim_stack)) {
+		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
+		mm->get_unmapped_area = arch_get_unmapped_area;
+	} else {
+		mm->mmap_base = mmap_base(random_factor, rlim_stack);
+		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+	}
+}
+#elif !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
 	mm->get_unmapped_area = arch_get_unmapped_area;
 }
 #endif
+#endif /* CONFIG_MMU */
 
 /*
  * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
-- 
2.20.1

