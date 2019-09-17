Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF69C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275B206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbfIQGlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:41:46 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36765 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729443AbfIQGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:41:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TcaHJnG_1568702495;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TcaHJnG_1568702495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Sep 2019 14:41:41 +0800
From:   shile.zhang@linux.alibaba.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mm/hugetlb: topdown mmap supports for hugepage
Date:   Tue, 17 Sep 2019 14:41:35 +0800
Message-Id: <1568702495-220091-1-git-send-email-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <VI1PR0701MB2846C892037A515D0B3F4EF8A12B0@VI1PR0701MB2846.eurprd07.prod.outlook.com>
References: <VI1PR0701MB2846C892037A515D0B3F4EF8A12B0@VI1PR0701MB2846.eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

Similar to other arches, this adds topdown mmap support for hugepage
in user process address space allocation. It allows mmap big size
hugepage. This patch copied from the implementation in arch/x86.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 arch/arm/include/asm/page.h |  1 +
 arch/arm/mm/hugetlbpage.c   | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index c2b75cb..dcb4df5 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -141,6 +141,7 @@ extern void __cpu_copy_user_highpage(struct page *to, struct page *from,
 
 #ifdef CONFIG_KUSER_HELPERS
 #define __HAVE_ARCH_GATE_AREA 1
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
 #ifdef CONFIG_ARM_LPAE
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index a1e5aac..ba9e151 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -33,3 +33,88 @@ int pmd_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
 }
+
+#ifdef CONFIG_HUGETLB_PAGE
+static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
+		unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = current->mm->mmap_legacy_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
+		unsigned long addr0, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+	unsigned long addr;
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = current->mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (addr & ~PAGE_MASK) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+unsigned long
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (addr) {
+		addr = ALIGN(addr, huge_page_size(h));
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	if (mm->get_unmapped_area == arch_get_unmapped_area)
+		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
+				pgoff, flags);
+	else
+		return hugetlb_get_unmapped_area_topdown(file, addr, len,
+				pgoff, flags);
+}
+#endif /* CONFIG_HUGETLB_PAGE */
-- 
1.8.3.1

