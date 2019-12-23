Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF74C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FF220715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577098819;
	bh=zAszdLT1JTNhUnK07u2YDQUkzGvZ8CFgTLeMEXE3UZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hRuoIX+fFECtkx0jIv4C4c9LTAzOp2NKCVKi9nic8TaOjFUFYIJh1BL99DkwAcCg3
	 K4QUtNwR7IC7zr8sc+emDsvMpG+vG6icB0QmfIlety+g08JRvHmnrkMIoHrcfTR1yk
	 zwZt54YkUxHOYbx9FL0LELDP9oXrJDNYtWpfuAh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWLAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfLWLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:00:16 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C1A20715;
        Mon, 23 Dec 2019 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577098815;
        bh=zAszdLT1JTNhUnK07u2YDQUkzGvZ8CFgTLeMEXE3UZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJ25GmoKLAenzA0w4AkjOBArzus9SzixGgb15kpfgoldgTUiSTuuPkylECBKoauHy
         dVqCU+k7foyIjXBstNwAka7ta0E0Fk3EL6zzzkHxFj4SSLUMzx/2DFSfrdCl8+BuN7
         lrVnuyjAu8EJrYPNXbKBelpQRhAMH8OKboumRGXc=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/2] asm-generic/nds32: don't redefine cacheflush primitives
Date:   Mon, 23 Dec 2019 13:00:03 +0200
Message-Id: <20191223110004.2157-2-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223110004.2157-1-rppt@kernel.org>
References: <20191223110004.2157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The commit c296d4dc13ae ("asm-generic: fix a compilation warning") changed
asm-generic/cachflush.h to use static inlines instead of macros and as a
result the nds32 build with CONFIG_CPU_CACHE_ALIASING=n fails:

  CC      init/main.o
In file included from arch/nds32/include/asm/cacheflush.h:43,
                 from include/linux/highmem.h:12,
                 from include/linux/pagemap.h:11,
                 from include/linux/blkdev.h:16,
                 from include/linux/blk-cgroup.h:23,
                 from include/linux/writeback.h:14,
                 from init/main.c:44:
include/asm-generic/cacheflush.h:50:20: error: static declaration of 'flush_icache_range' follows non-static declaration
 static inline void flush_icache_range(unsigned long start, unsigned long end)
                    ^~~~~~~~~~~~~~~~~~
In file included from include/linux/highmem.h:12,
                 from include/linux/pagemap.h:11,
                 from include/linux/blkdev.h:16,
                 from include/linux/blk-cgroup.h:23,
                 from include/linux/writeback.h:14,
                 from init/main.c:44:
arch/nds32/include/asm/cacheflush.h:11:6: note: previous declaration of 'flush_icache_range' was here
 void flush_icache_range(unsigned long start, unsigned long end);
      ^~~~~~~~~~~~~~~~~~

Surround the inline functions in asm-generic/cacheflush.h by ifdef's so
that architectures could override them and add the required overrides to
nds32.

Fixes: c296d4dc13ae ("asm-generic: fix a compilation warning")
Link: https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nds32/include/asm/cacheflush.h | 11 ++++++----
 include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index d9ac7e6408ef..caddded56e77 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -9,7 +9,11 @@
 #define PG_dcache_dirty PG_arch_1
 
 void flush_icache_range(unsigned long start, unsigned long end);
+#define flush_icache_range flush_icache_range
+
 void flush_icache_page(struct vm_area_struct *vma, struct page *page);
+#define flush_icache_page flush_icache_page
+
 #ifdef CONFIG_CPU_CACHE_ALIASING
 void flush_cache_mm(struct mm_struct *mm);
 void flush_cache_dup_mm(struct mm_struct *mm);
@@ -40,12 +44,11 @@ void invalidate_kernel_vmap_range(void *addr, int size);
 #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
 
 #else
-#include <asm-generic/cacheflush.h>
-#undef flush_icache_range
-#undef flush_icache_page
-#undef flush_icache_user_range
 void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	                     unsigned long addr, int len);
+#define flush_icache_user_range flush_icache_user_range
+
+#include <asm-generic/cacheflush.h>
 #endif
 
 #endif /* __NDS32_CACHEFLUSH_H__ */
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index a950a22c4890..cac7404b2bdd 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -11,71 +11,102 @@
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
  */
+#ifndef flush_cache_all
 static inline void flush_cache_all(void)
 {
 }
+#endif
 
+#ifndef flush_cache_mm
 static inline void flush_cache_mm(struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef flush_cache_dup_mm
 static inline void flush_cache_dup_mm(struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef flush_cache_range
 static inline void flush_cache_range(struct vm_area_struct *vma,
 				     unsigned long start,
 				     unsigned long end)
 {
 }
+#endif
 
+#ifndef flush_cache_page
 static inline void flush_cache_page(struct vm_area_struct *vma,
 				    unsigned long vmaddr,
 				    unsigned long pfn)
 {
 }
+#endif
 
+#ifndef flush_dcache_page
 static inline void flush_dcache_page(struct page *page)
 {
 }
+#endif
 
+#ifndef flush_dcache_mmap_lock
 static inline void flush_dcache_mmap_lock(struct address_space *mapping)
 {
 }
+#endif
 
+#ifndef flush_dcache_mmap_unlock
 static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
 {
 }
+#endif
 
+#ifndef flush_icache_range
 static inline void flush_icache_range(unsigned long start, unsigned long end)
 {
 }
+#endif
 
+#ifndef flush_icache_page
 static inline void flush_icache_page(struct vm_area_struct *vma,
 				     struct page *page)
 {
 }
+#endif
 
+#ifndef flush_icache_user_range
 static inline void flush_icache_user_range(struct vm_area_struct *vma,
 					   struct page *page,
 					   unsigned long addr, int len)
 {
 }
+#endif
 
+#ifndef flush_cache_vmap
 static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 {
 }
+#endif
 
+#ifndef flush_cache_vunmap
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 }
+#endif
 
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+#ifndef copy_to_user_page
+#define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
 		memcpy(dst, src, len); \
 		flush_icache_user_range(vma, page, vaddr, len); \
 	} while (0)
+#endif
+
+#ifndef copy_from_user_page
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	memcpy(dst, src, len)
+#endif
 
 #endif /* __ASM_CACHEFLUSH_H */
-- 
2.24.0

