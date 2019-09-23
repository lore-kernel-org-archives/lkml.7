Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049FEC11FF5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA4A20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CPIvhWyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502759AbfIWUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:35:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502739AbfIWUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:35:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so7528691pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0EOgOzC/oEWFwgj/ixSy1OIk0JJ0SJsV3TAjT5pKIqM=;
        b=CPIvhWyUZcRrOERzBXnm8NVod3Lz0EekzpI+HT9/0qPDAN5sJrr0ccuT6cd26HaYQw
         4HqLwkvwtvsW16PThfn5CcaxcCOvoeYG7kRROoLTmGXPLcATsR+jb/Tu9Q9XsKBTtL6e
         7UKwoy4roT127UNaG+wULaMJ/QudC8UP8dfV53g53ZVOdkNLeE01siF3zr6UQX5IIO4M
         7YYK8QXwDo7GtoUnzHx6xgJ/LCqsVbmaE1hJFBbLOMsWDjZy7NNZlbwZO9rszXKdUzTw
         /BAlV8cHslYklDY1DvlksKSQjC8Wf8u0g4iuLwrFshPFXDRPmRKGqZ8oRP2VrDcUAU8c
         gY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EOgOzC/oEWFwgj/ixSy1OIk0JJ0SJsV3TAjT5pKIqM=;
        b=Le4FeviLpxM0alHzeBb0lq5AEDpo9hLv8izHKJZHuOoso888L4mgPfW0CzXJT1lPTS
         eYZzDIJmbCojuYLcwOyO5/bB1urJqQlAKfc39eLGyzaJNa6l71Z8JpoxUJ6ra88gtlIo
         IAvinaaPKWlodp1KSvbWIWMq+E3nMNmqiWRg/5QggP3gVhOQS+KZBTG3t18PJE01zeYK
         78qP75d4Ve6dw6lVbSU9N1R9xeocC4jxnm3Lra2hCqhCsr4npXoJQRL0pOYOwkVHc4O/
         KNteG/qJexz2vvZ1TcXMxcIeolVhhApkzwXXRcuarT/RLNSX7DTcojCYLhUJZZCGwrwZ
         dYXw==
X-Gm-Message-State: APjAAAVim5DZY+G0Mh0vLKRBdq7fGXWtDuMf0xrgOhX217KSyEZVycFV
        pQyy90sj15/HOiRN8d4Dz5tLhg==
X-Google-Smtp-Source: APXvYqzk4PEiRcRY0wzdMVTx/a35uezaICJ1+dmTU6m9Qd/bDXD3whUmiEY04msSdaMk0eJWp3ROMg==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr1348810pjp.69.1569270900881;
        Mon, 23 Sep 2019 13:35:00 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:35:00 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 09/17] arm64: hibernate: move page handling function to new trans_pgd.c
Date:   Mon, 23 Sep 2019 16:34:19 -0400
Message-Id: <20190923203427.294286-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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
 arch/arm64/kernel/hibernate.c      | 199 +-------------------------
 arch/arm64/mm/Makefile             |   1 +
 arch/arm64/mm/trans_pgd.c          | 219 +++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/mm/trans_pgd.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 37c610963eee..789b90b80e48 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1017,6 +1017,10 @@ config CRASH_DUMP
 
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
index ded9034b9d39..d6346ad23f87 100644
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
  * perform cache maintenance, then maps it at the specified address low
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
-				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
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
index 000000000000..5ac712b92439
--- /dev/null
+++ b/arch/arm64/mm/trans_pgd.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Transitional page tables for kexec and hibernate
+ *
+ * This file derived from: arch/arm64/kernel/hibernate.c
+ *
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ *
+ */
+
+/*
+ * Transitional tables are used during system transferring from one world to
+ * another: such as during hibernate restore, and kexec reboots. During these
+ * phases one cannot rely on page table not being overwritten. This is because
+ * hibernate and kexec can overwrite the current page tables during transition.
+ */
+
+#include <asm/trans_pgd.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <linux/suspend.h>
+#include <linux/bug.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
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
+				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
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

