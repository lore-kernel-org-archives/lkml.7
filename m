Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC9DC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BDA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfEUExo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:44 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:50305 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUExl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:41 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:40 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:53:13 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 08/14] arch/x86: teach the mm about range locking
Date:   Mon, 20 May 2019 21:52:36 -0700
Message-Id: <20190521045242.24378-9-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion is straightforward, mmap_sem is used within the
the same function context most of the time. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/entry/vdso/vma.c      | 12 +++++++-----
 arch/x86/kernel/vm86_32.c      |  5 +++--
 arch/x86/kvm/paging_tmpl.h     |  9 +++++----
 arch/x86/mm/debug_pagetables.c |  8 ++++----
 arch/x86/mm/fault.c            |  8 ++++----
 arch/x86/mm/mpx.c              | 15 +++++++++------
 arch/x86/um/vdso/vma.c         |  5 +++--
 7 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index babc4e7a519c..f6d8950f37b8 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -145,12 +145,13 @@ static const struct vm_special_mapping vvar_mapping = {
  */
 static int map_vdso(const struct vdso_image *image, unsigned long addr)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long text_start;
 	int ret = 0;
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	addr = get_unmapped_area(NULL, addr,
@@ -193,7 +194,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	}
 
 up_fail:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return ret;
 }
 
@@ -254,8 +255,9 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	/*
 	 * Check if we have already mapped vdso blob - fail to prevent
 	 * abusing from userspace install_speciall_mapping, which may
@@ -266,11 +268,11 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
-			up_write(&mm->mmap_sem);
+			mm_write_unlock(mm, &mmrange);
 			return -EEXIST;
 		}
 	}
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 
 	return map_vdso(image, addr);
 }
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 6a38717d179c..39eecee07dcd 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -171,8 +171,9 @@ static void mark_screen_rdonly(struct mm_struct *mm)
 	pmd_t *pmd;
 	pte_t *pte;
 	int i;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	pgd = pgd_offset(mm, 0xA0000);
 	if (pgd_none_or_clear_bad(pgd))
 		goto out;
@@ -198,7 +199,7 @@ static void mark_screen_rdonly(struct mm_struct *mm)
 	}
 	pte_unmap_unlock(pte, ptl);
 out:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
 }
 
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 367a47df4ba0..347d3ba41974 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -152,23 +152,24 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		unsigned long vaddr = (unsigned long)ptep_user & PAGE_MASK;
 		unsigned long pfn;
 		unsigned long paddr;
+		DEFINE_RANGE_LOCK_FULL(mmrange);
 
-		down_read(&current->mm->mmap_sem);
+		mm_read_lock(current->mm, &mmrange);
 		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
 		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
-			up_read(&current->mm->mmap_sem);
+			mm_read_unlock(current->mm, &mmrange);
 			return -EFAULT;
 		}
 		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 		paddr = pfn << PAGE_SHIFT;
 		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
 		if (!table) {
-			up_read(&current->mm->mmap_sem);
+			mm_read_unlock(current->mm, &mmrange);
 			return -EFAULT;
 		}
 		ret = CMPXCHG(&table[index], orig_pte, new_pte);
 		memunmap(table);
-		up_read(&current->mm->mmap_sem);
+		mm_read_unlock(current->mm, &mmrange);
 	}
 
 	return (ret != orig_pte);
diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index cd84f067e41d..0d131edc6a75 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -15,9 +15,9 @@ DEFINE_SHOW_ATTRIBUTE(ptdump);
 static int ptdump_curknl_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
-		down_read(&current->mm->mmap_sem);
+		mm_read_lock(current->mm, &mmrange);
 		ptdump_walk_pgd_level_debugfs(m, current->mm->pgd, false);
-		up_read(&current->mm->mmap_sem);
+		mm_read_unlock(current->mm, &mmrange);
 	}
 	return 0;
 }
@@ -30,9 +30,9 @@ static struct dentry *pe_curusr;
 static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
-		down_read(&current->mm->mmap_sem);
+		mm_read_lock(current->mm, &mmrange);
 		ptdump_walk_pgd_level_debugfs(m, current->mm->pgd, true);
-		up_read(&current->mm->mmap_sem);
+		mm_read_unlock(current->mm, &mmrange);
 	}
 	return 0;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fb869c292b91..fbb060c89e7d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -946,7 +946,7 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	 * Something tried to access memory that isn't in our memory map..
 	 * Fix it, but check if it's kernel or user first..
 	 */
-	up_read(&mm->mmap_sem);
+        mm_read_unlock(mm, mmrange);
 
 	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
 }
@@ -1399,7 +1399,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * 1. Failed to acquire mmap_sem, and
 	 * 2. The access did not originate in userspace.
 	 */
-	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
+	if (unlikely(!mm_read_trylock(mm, &mmrange))) {
 		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
 			/*
 			 * Fault from code in kernel from
@@ -1409,7 +1409,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			return;
 		}
 retry:
-		down_read(&mm->mmap_sem);
+		mm_read_lock(mm, &mmrange);
 	} else {
 		/*
 		 * The above down_read_trylock() might have succeeded in
@@ -1485,7 +1485,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		mm_fault_error(regs, hw_error_code, address, fault);
 		return;
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index 0d1c47cbbdd6..5f0a4af29920 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -46,16 +46,17 @@ static inline unsigned long mpx_bt_size_bytes(struct mm_struct *mm)
 static unsigned long mpx_mmap(unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	unsigned long addr, populate;
 
 	/* Only bounds table can be allocated here */
 	if (len != mpx_bt_size_bytes(mm))
 		return -EINVAL;
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	addr = do_mmap(NULL, 0, len, PROT_READ | PROT_WRITE,
 		       MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate, NULL);
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	if (populate)
 		mm_populate(addr, populate);
 
@@ -214,6 +215,7 @@ int mpx_enable_management(void)
 	void __user *bd_base = MPX_INVALID_BOUNDS_DIR;
 	struct mm_struct *mm = current->mm;
 	int ret = 0;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	/*
 	 * runtime in the userspace will be responsible for allocation of
@@ -227,7 +229,7 @@ int mpx_enable_management(void)
 	 * unmap path; we can just use mm->context.bd_addr instead.
 	 */
 	bd_base = mpx_get_bounds_dir();
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 
 	/* MPX doesn't support addresses above 47 bits yet. */
 	if (find_vma(mm, DEFAULT_MAP_WINDOW)) {
@@ -241,20 +243,21 @@ int mpx_enable_management(void)
 	if (mm->context.bd_addr == MPX_INVALID_BOUNDS_DIR)
 		ret = -ENXIO;
 out:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return ret;
 }
 
 int mpx_disable_management(void)
 {
 	struct mm_struct *mm = current->mm;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	if (!cpu_feature_enabled(X86_FEATURE_MPX))
 		return -ENXIO;
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	mm->context.bd_addr = MPX_INVALID_BOUNDS_DIR;
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return 0;
 }
 
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index 6be22f991b59..d65d82b967c7 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -55,13 +55,14 @@ subsys_initcall(init_vdso);
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	int err;
 	struct mm_struct *mm = current->mm;
 
 	if (!vdso_enabled)
 		return 0;
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	err = install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
@@ -69,7 +70,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 		vdsop);
 
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 
 	return err;
 }
-- 
2.16.4

