Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C014EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777C223401
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QEzqOaMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHUScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43651 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfHUScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so2700793qkd.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UobsZTX+eLQtr9T9VqdG92i+2f5TXXZcK9SCG7MF8qg=;
        b=QEzqOaMTpb3YFn1I5I4NkPaq/6TdVRpHoJToErKfHCsSsgu54Jh2qZ6Asn9xOpJDHf
         OYKOaz/wrRPAB11fi0Nbu3HcaDwQUa3n/7NKqoBG848ePcvjhkw8w0ybUHH7q/nFQziA
         Ib4mRqcg0X8qkoIaGBtEQBb8thu9+o2wzzr5ji0430zmfcQfQ07hSHRKG7wqi18aZze9
         fdJtFizq6PHRpac39dwUSZTyOL44IaNab1daPt4GO0Z7quLPGrPzTmuBQ++a0Mg3k8Mt
         iDM8OkVGrofJhpgT962fa+aMNcOuSGK7/4AGZ85NoyGXO8bBIhu0iA9YntDgZt/ByfDW
         ikhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UobsZTX+eLQtr9T9VqdG92i+2f5TXXZcK9SCG7MF8qg=;
        b=K8maCNKPdd4MuhYvJJOlZQyZEYFJJ1/ljaSUtqd6ftkxKkGBjKeUV9O7Ov1uOJlaCh
         5oWwQdDn6PGUhDubhzXDrOhfV1P/kIfFHwBirn0LEP3gMAd4jboCOFKGyoRyELvQJo2v
         bzK1GZZps36/Gm1Aikcw83RLrUqLvftS5Z1ZF+sm+Iv4X6jqnEQVUB4zc8TNVbrw6EHj
         Fzks4Akbw4Z4HI1TLbFRf7WJm7VHqveu7EAPXOJ9rMhQEhF+sLTV1KJI1eO8N5DHZZK5
         6Mb+nu/l9tLrtHG97KM7E3tj7I2Ho23lASBZKiSVJU9uPy/FT4PjrbIsFEmlr2SM4daQ
         4Stg==
X-Gm-Message-State: APjAAAVnB+CDGPBqMdveInVpxIY2manNt7mz15BRTsuScteB/gj6g1ra
        +viqruA9Fg6c5+9Y5+0Fy+cMsw==
X-Google-Smtp-Source: APXvYqzrmAHthkBucTw7Pz1PD7L9WQI22N4SlR2m8/PyTnzs6dD3bD9oa1IP1aGOq9CdhNq8iykLvA==
X-Received: by 2002:a05:620a:31b:: with SMTP id s27mr33736990qkm.438.1566412336086;
        Wed, 21 Aug 2019 11:32:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:15 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 07/17] arm64, hibernate: move page handling function to new trans_pgd.c
Date:   Wed, 21 Aug 2019 14:31:54 -0400
Message-Id: <20190821183204.23576-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we abstracted the required functions move them to a new home.
Later, we will generalize these function in order to be useful outside
of hibernation.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                 |   4 +
 arch/arm64/include/asm/trans_pgd.h |  20 +++
 arch/arm64/kernel/hibernate.c      | 199 +--------------------------
 arch/arm64/mm/Makefile             |   1 +
 arch/arm64/mm/trans_pgd.c          | 211 +++++++++++++++++++++++++++++
 5 files changed, 237 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/mm/trans_pgd.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..91a7416ffe4e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -999,6 +999,10 @@ config CRASH_DUMP
 
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config TRANS_TABLE
+	def_bool y
+	depends on HIBERNATION || KEXEC_CORE
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
new file mode 100644
index 000000000000..c7b5402b7d87
--- /dev/null
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ */
+
+#ifndef _ASM_TRANS_TABLE_H
+#define _ASM_TRANS_TABLE_H
+
+#include <linux/bits.h>
+#include <asm/pgtable-types.h>
+
+int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+			  unsigned long end);
+
+int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
+		       pgprot_t pgprot);
+
+#endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 2e29d620b56c..6ee81bbaa37f 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -16,7 +16,6 @@
 #define pr_fmt(x) "hibernate: " x
 #include <linux/cpu.h>
 #include <linux/kvm_host.h>
-#include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/sched.h>
 #include <linux/suspend.h>
@@ -31,14 +30,12 @@
 #include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
-#include <asm/pgtable-hwdef.h>
 #include <asm/sections.h>
 #include <asm/smp.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/sysreg.h>
+#include <asm/trans_pgd.h>
 #include <asm/virt.h>
 
 /*
@@ -182,45 +179,6 @@ int arch_hibernation_header_restore(void *addr)
 }
 EXPORT_SYMBOL(arch_hibernation_header_restore);
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
-		       unsigned long dst_addr,
-		       pgprot_t pgprot)
-{
-	pgd_t *pgdp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
-	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pudp)
-			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
-	}
-
-	pudp = pud_offset(pgdp, dst_addr);
-	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pmdp)
-			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
-	}
-
-	pmdp = pmd_offset(pudp, dst_addr);
-	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = (void *)get_safe_page(GFP_ATOMIC);
-		if (!ptep)
-			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
-	}
-
-	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
-
-	return 0;
-}
-
 /*
  * Copies length bytes, starting at src_start into an new page,
  * perform cache maintentance, then maps it at the specified address low
@@ -339,161 +297,6 @@ int swsusp_arch_suspend(void)
 	return ret;
 }
 
-static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
-{
-	pte_t pte = READ_ONCE(*src_ptep);
-
-	if (pte_valid(pte)) {
-		/*
-		 * Resume will overwrite areas that may be marked
-		 * read only (code, rodata). Clear the RDONLY bit from
-		 * the temporary mappings we use during restore.
-		 */
-		set_pte(dst_ptep, pte_mkwrite(pte));
-	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
-		/*
-		 * debug_pagealloc will removed the PTE_VALID bit if
-		 * the page isn't in use by the resume kernel. It may have
-		 * been in use by the original kernel, in which case we need
-		 * to put it back in our copy to do the restore.
-		 *
-		 * Before marking this entry valid, check the pfn should
-		 * be mapped.
-		 */
-		BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite(pte)));
-	}
-}
-
-static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
-		    unsigned long end)
-{
-	pte_t *src_ptep;
-	pte_t *dst_ptep;
-	unsigned long addr = start;
-
-	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
-	if (!dst_ptep)
-		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
-	dst_ptep = pte_offset_kernel(dst_pmdp, start);
-
-	src_ptep = pte_offset_kernel(src_pmdp, start);
-	do {
-		_copy_pte(dst_ptep, src_ptep, addr);
-	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
-
-	return 0;
-}
-
-static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
-		    unsigned long end)
-{
-	pmd_t *src_pmdp;
-	pmd_t *dst_pmdp;
-	unsigned long next;
-	unsigned long addr = start;
-
-	if (pud_none(READ_ONCE(*dst_pudp))) {
-		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
-		if (!dst_pmdp)
-			return -ENOMEM;
-		pud_populate(&init_mm, dst_pudp, dst_pmdp);
-	}
-	dst_pmdp = pmd_offset(dst_pudp, start);
-
-	src_pmdp = pmd_offset(src_pudp, start);
-	do {
-		pmd_t pmd = READ_ONCE(*src_pmdp);
-
-		next = pmd_addr_end(addr, end);
-		if (pmd_none(pmd))
-			continue;
-		if (pmd_table(pmd)) {
-			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
-				return -ENOMEM;
-		} else {
-			set_pmd(dst_pmdp,
-				__pmd(pmd_val(pmd) & ~PMD_SECT_RDONLY));
-		}
-	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
-
-	return 0;
-}
-
-static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
-		    unsigned long end)
-{
-	pud_t *dst_pudp;
-	pud_t *src_pudp;
-	unsigned long next;
-	unsigned long addr = start;
-
-	if (pgd_none(READ_ONCE(*dst_pgdp))) {
-		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
-		if (!dst_pudp)
-			return -ENOMEM;
-		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
-	}
-	dst_pudp = pud_offset(dst_pgdp, start);
-
-	src_pudp = pud_offset(src_pgdp, start);
-	do {
-		pud_t pud = READ_ONCE(*src_pudp);
-
-		next = pud_addr_end(addr, end);
-		if (pud_none(pud))
-			continue;
-		if (pud_table(pud)) {
-			if (copy_pmd(dst_pudp, src_pudp, addr, next))
-				return -ENOMEM;
-		} else {
-			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
-		}
-	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
-
-	return 0;
-}
-
-static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
-			    unsigned long end)
-{
-	unsigned long next;
-	unsigned long addr = start;
-	pgd_t *src_pgdp = pgd_offset_k(start);
-
-	dst_pgdp = pgd_offset_raw(dst_pgdp, start);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none(READ_ONCE(*src_pgdp)))
-			continue;
-		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
-			return -ENOMEM;
-	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
-
-	return 0;
-}
-
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end)
-{
-	int rc;
-	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
-
-	if (!trans_pgd) {
-		pr_err("Failed to allocate memory for temporary page tables.\n");
-		return -ENOMEM;
-	}
-
-	rc = copy_page_tables(trans_pgd, start, end);
-	if (!rc)
-		*dst_pgdp = trans_pgd;
-
-	return rc;
-}
-
 /*
  * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
  *
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..f3002f1d0e61 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -6,6 +6,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM64_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
+obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 KASAN_SANITIZE_physaddr.o	+= n
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
new file mode 100644
index 000000000000..00b62d8640c2
--- /dev/null
+++ b/arch/arm64/mm/trans_pgd.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ */
+
+/*
+ * Transitional tables are used during system transferring from one world to
+ * another: such as during hibernate restore, and kexec reboots. During these
+ * phases one cannot rely on page table not being overwritten.
+ *
+ */
+
+#include <asm/trans_pgd.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <linux/suspend.h>
+
+static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
+{
+	pte_t pte = READ_ONCE(*src_ptep);
+
+	if (pte_valid(pte)) {
+		/*
+		 * Resume will overwrite areas that may be marked
+		 * read only (code, rodata). Clear the RDONLY bit from
+		 * the temporary mappings we use during restore.
+		 */
+		set_pte(dst_ptep, pte_mkwrite(pte));
+	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
+		/*
+		 * debug_pagealloc will removed the PTE_VALID bit if
+		 * the page isn't in use by the resume kernel. It may have
+		 * been in use by the original kernel, in which case we need
+		 * to put it back in our copy to do the restore.
+		 *
+		 * Before marking this entry valid, check the pfn should
+		 * be mapped.
+		 */
+		BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite(pte)));
+	}
+}
+
+static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
+		    unsigned long end)
+{
+	pte_t *src_ptep;
+	pte_t *dst_ptep;
+	unsigned long addr = start;
+
+	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
+	if (!dst_ptep)
+		return -ENOMEM;
+	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
+	dst_ptep = pte_offset_kernel(dst_pmdp, start);
+
+	src_ptep = pte_offset_kernel(src_pmdp, start);
+	do {
+		_copy_pte(dst_ptep, src_ptep, addr);
+	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
+
+	return 0;
+}
+
+static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
+		    unsigned long end)
+{
+	pmd_t *src_pmdp;
+	pmd_t *dst_pmdp;
+	unsigned long next;
+	unsigned long addr = start;
+
+	if (pud_none(READ_ONCE(*dst_pudp))) {
+		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
+		if (!dst_pmdp)
+			return -ENOMEM;
+		pud_populate(&init_mm, dst_pudp, dst_pmdp);
+	}
+	dst_pmdp = pmd_offset(dst_pudp, start);
+
+	src_pmdp = pmd_offset(src_pudp, start);
+	do {
+		pmd_t pmd = READ_ONCE(*src_pmdp);
+
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(pmd))
+			continue;
+		if (pmd_table(pmd)) {
+			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
+				return -ENOMEM;
+		} else {
+			set_pmd(dst_pmdp,
+				__pmd(pmd_val(pmd) & ~PMD_SECT_RDONLY));
+		}
+	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
+
+	return 0;
+}
+
+static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
+		    unsigned long end)
+{
+	pud_t *dst_pudp;
+	pud_t *src_pudp;
+	unsigned long next;
+	unsigned long addr = start;
+
+	if (pgd_none(READ_ONCE(*dst_pgdp))) {
+		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
+		if (!dst_pudp)
+			return -ENOMEM;
+		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
+	}
+	dst_pudp = pud_offset(dst_pgdp, start);
+
+	src_pudp = pud_offset(src_pgdp, start);
+	do {
+		pud_t pud = READ_ONCE(*src_pudp);
+
+		next = pud_addr_end(addr, end);
+		if (pud_none(pud))
+			continue;
+		if (pud_table(pud)) {
+			if (copy_pmd(dst_pudp, src_pudp, addr, next))
+				return -ENOMEM;
+		} else {
+			set_pud(dst_pudp,
+				__pud(pud_val(pud) & ~PMD_SECT_RDONLY));
+		}
+	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
+
+	return 0;
+}
+
+static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
+			    unsigned long end)
+{
+	unsigned long next;
+	unsigned long addr = start;
+	pgd_t *src_pgdp = pgd_offset_k(start);
+
+	dst_pgdp = pgd_offset_raw(dst_pgdp, start);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(READ_ONCE(*src_pgdp)))
+			continue;
+		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
+			return -ENOMEM;
+	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
+
+	return 0;
+}
+
+int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+			  unsigned long end)
+{
+	int rc;
+	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
+
+	if (!trans_pgd) {
+		pr_err("Failed to allocate memory for temporary page tables.\n");
+		return -ENOMEM;
+	}
+
+	rc = copy_page_tables(trans_pgd, start, end);
+	if (!rc)
+		*dst_pgdp = trans_pgd;
+
+	return rc;
+}
+
+int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
+		       pgprot_t pgprot)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
+	if (pgd_none(READ_ONCE(*pgdp))) {
+		pudp = (void *)get_safe_page(GFP_ATOMIC);
+		if (!pudp)
+			return -ENOMEM;
+		pgd_populate(&init_mm, pgdp, pudp);
+	}
+
+	pudp = pud_offset(pgdp, dst_addr);
+	if (pud_none(READ_ONCE(*pudp))) {
+		pmdp = (void *)get_safe_page(GFP_ATOMIC);
+		if (!pmdp)
+			return -ENOMEM;
+		pud_populate(&init_mm, pudp, pmdp);
+	}
+
+	pmdp = pmd_offset(pudp, dst_addr);
+	if (pmd_none(READ_ONCE(*pmdp))) {
+		ptep = (void *)get_safe_page(GFP_ATOMIC);
+		if (!ptep)
+			return -ENOMEM;
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+
+	ptep = pte_offset_kernel(pmdp, dst_addr);
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
+
+	return 0;
+}
-- 
2.23.0

