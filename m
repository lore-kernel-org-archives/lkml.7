Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BD122D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NENubW1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfICJdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:33:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfICJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aGZ6eex/vaDo70w5kZ45TaxrzZcYzCY8A7OTiCg28DE=; b=NENubW1Ioc/COXHzQNyWXTUqdG
        73452rzNbGHa7VDsPV89qoHAkezQsz9tKERa5sWaGqQjmHdQCR9+LCRD7lkdOVPuKdrAhoIbaBGD4
        rMlAc88Mhimn9snapkJUza42rdSqdg081e5Fq769wwsazeVu3QJxLIdnoavR+rARFIfJ6j8ff9w4g
        +chgCUukgF5YnTroUzpzJ5nr3g+DAvl+VH619i9jULHtcdgc8bQPeT/kkP7K25TLyQS4LyQFIZy4z
        RZRcpDm+gOhnVY8jz7/kRaowqkXft4TDhcM9gHzQ7D9/aE0+IFU53oKVwgk6y7yH3210SRToye62y
        HbH+D+Yg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BJ-0004UW-Fe; Tue, 03 Sep 2019 09:32:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 07/20] riscv: move the TLB flush logic out of line
Date:   Tue,  3 Sep 2019 11:32:26 +0200
Message-Id: <20190903093239.21278-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB flush logic is going to become more complex.  Start moving
it out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/tlbflush.h | 37 ++++++-------------------------
 arch/riscv/mm/Makefile            |  3 +++
 arch/riscv/mm/tlbflush.c          | 35 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 30 deletions(-)
 create mode 100644 arch/riscv/mm/tlbflush.c

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index df31fe2ed09c..075a784c66c5 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -25,8 +25,13 @@ static inline void local_flush_tlb_page(unsigned long addr)
 	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
 }
 
-#ifndef CONFIG_SMP
-
+#ifdef CONFIG_SMP
+void flush_tlb_all(void);
+void flush_tlb_mm(struct mm_struct *mm);
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end);
+#else /* CONFIG_SMP */
 #define flush_tlb_all() local_flush_tlb_all()
 #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
 
@@ -37,34 +42,6 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 }
 
 #define flush_tlb_mm(mm) flush_tlb_all()
-
-#else /* CONFIG_SMP */
-
-#include <asm/sbi.h>
-
-static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
-				     unsigned long size)
-{
-	struct cpumask hmask;
-
-	riscv_cpuid_to_hartid_mask(cmask, &hmask);
-	sbi_remote_sfence_vma(hmask.bits, start, size);
-}
-
-#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
-
-#define flush_tlb_range(vma, start, end) \
-	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
-
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long addr)
-{
-	flush_tlb_range(vma, addr, addr + PAGE_SIZE);
-}
-
-#define flush_tlb_mm(mm)				\
-	remote_sfence_vma(mm_cpumask(mm), 0, -1)
-
 #endif /* CONFIG_SMP */
 
 /* Flush a range of kernel pages */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 74055e1d6f21..9d9a17335686 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,4 +13,7 @@ obj-y += cacheflush.o
 obj-y += context.o
 obj-y += sifive_l2_cache.o
 
+ifeq ($(CONFIG_MMU),y)
+obj-$(CONFIG_SMP) += tlbflush.o
+endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
new file mode 100644
index 000000000000..df93b26f1b9d
--- /dev/null
+++ b/arch/riscv/mm/tlbflush.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <asm/sbi.h>
+
+void flush_tlb_all(void)
+{
+	sbi_remote_sfence_vma(NULL, 0, -1);
+}
+
+static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
+		unsigned long size)
+{
+	struct cpumask hmask;
+
+	riscv_cpuid_to_hartid_mask(cmask, &hmask);
+	sbi_remote_sfence_vma(hmask.bits, start, size);
+}
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end)
+{
+	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
+}
-- 
2.20.1

