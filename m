Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBC7C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41EA2464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Asq26IOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfLEOEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:04:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45830 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:04:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id r11so1331539pjp.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4U/eRKLWH+P5sMJLg1gBzVLKge0A2yZRS0R5HxW/2Q=;
        b=Asq26IOS4TK4UH/qiyh65Rf6Gr9j+ebjMp/2ndN/f+KYSq7JoZhW7CZZ9l0NUtx7F/
         D971GvtNwZ9/Qe+xfSy1AxrMHUomDx1ah/2ishZe6/U0/f+D78ScE6nZr2haNxoGneyD
         1zGIhbom3N20ZR2ykUs4QpDlxZcovOxbWDBv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4U/eRKLWH+P5sMJLg1gBzVLKge0A2yZRS0R5HxW/2Q=;
        b=RTFHSpAQnSWFelpr5iYeFLQFa/6w3Mq5TzEsqtPYbHKKd2XGudrLI+vYlaczZ5nniw
         dEtCGW8gKDeYAdd0bz8TnxktHgufuAXMnbGZG7a6C7yIa3DGvfDf7DxK5WKpz83+a+7X
         iCVGl53vPhwpje57leXJbN6535nR3LyWq4Kf8ylU6/TaQBVE9sv9p9swuvXYtchqSt6Z
         IocvNuOAVd2qqRQlAagHBW/GYPfsuowYWH6ohALmy9fVBX2f//ppNvCmv7nAcgGyWCDz
         4V9YZzt8I75UA19moyjKERr5n12AT5td4CzrTHboyhvc3XWuo+Sjg+dZVpLtKhnEm9Qc
         qUOQ==
X-Gm-Message-State: APjAAAVdIwBcsz1KOcxjXPmUBQKymj3a+zwOPY/1MvkvppQcGRlIFEEo
        ouuCYItuf7IoVQnkpdiIMtVMdg==
X-Google-Smtp-Source: APXvYqxGnHj16INKJIl3VHlcRQsBG6NIPPJh7U8CsqZ9o1m2ipnW1nsPbtHWYsdeFTLs3zRnM8rE8w==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr9434121plf.213.1575554653485;
        Thu, 05 Dec 2019 06:04:13 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-61b9-031c-bed1-3502.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:61b9:31c:bed1:3502])
        by smtp.gmail.com with ESMTPSA id q185sm12628423pfq.110.2019.12.05.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:04:12 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     daniel@iogearbox.net, cai@lca.pw, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/3] mm: add apply_to_existing_pages helper
Date:   Fri,  6 Dec 2019 01:04:05 +1100
Message-Id: <20191205140407.1874-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apply_to_page_range takes an address range, and if any parts of it
are not covered by the existing page table hierarchy, it allocates
memory to fill them in.

In some use cases, this is not what we want - we want to be able to
operate exclusively on PTEs that are already in the tables.

Add apply_to_existing_pages for this. Adjust the walker functions
for apply_to_page_range to take 'create', which switches them between
the old and new modes.

This will be used in KASAN vmalloc.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/mm.h |   3 ++
 mm/memory.c        | 131 +++++++++++++++++++++++++++++++++------------
 2 files changed, 99 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c97ea3b694e6..f4dba827d76e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2621,6 +2621,9 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
+extern int apply_to_existing_pages(struct mm_struct *mm, unsigned long address,
+				   unsigned long size, pte_fn_t fn,
+				   void *data);
 
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
diff --git a/mm/memory.c b/mm/memory.c
index 606da187d1de..e508ba7e0a19 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2021,26 +2021,34 @@ EXPORT_SYMBOL(vm_iomap_memory);
 
 static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 				     unsigned long addr, unsigned long end,
-				     pte_fn_t fn, void *data)
+				     pte_fn_t fn, void *data, bool create)
 {
 	pte_t *pte;
-	int err;
+	int err = 0;
 	spinlock_t *uninitialized_var(ptl);
 
-	pte = (mm == &init_mm) ?
-		pte_alloc_kernel(pmd, addr) :
-		pte_alloc_map_lock(mm, pmd, addr, &ptl);
-	if (!pte)
-		return -ENOMEM;
+	if (create) {
+		pte = (mm == &init_mm) ?
+			pte_alloc_kernel(pmd, addr) :
+			pte_alloc_map_lock(mm, pmd, addr, &ptl);
+		if (!pte)
+			return -ENOMEM;
+	} else {
+		pte = (mm == &init_mm) ?
+			pte_offset_kernel(pmd, addr) :
+			pte_offset_map_lock(mm, pmd, addr, &ptl);
+	}
 
 	BUG_ON(pmd_huge(*pmd));
 
 	arch_enter_lazy_mmu_mode();
 
 	do {
-		err = fn(pte++, addr, data);
-		if (err)
-			break;
+		if (create || !pte_none(*pte)) {
+			err = fn(pte++, addr, data);
+			if (err)
+				break;
+		}
 	} while (addr += PAGE_SIZE, addr != end);
 
 	arch_leave_lazy_mmu_mode();
@@ -2052,62 +2060,83 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 				     unsigned long addr, unsigned long end,
-				     pte_fn_t fn, void *data)
+				     pte_fn_t fn, void *data, bool create)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	int err;
+	int err = 0;
 
 	BUG_ON(pud_huge(*pud));
 
-	pmd = pmd_alloc(mm, pud, addr);
-	if (!pmd)
-		return -ENOMEM;
+	if (create) {
+		pmd = pmd_alloc(mm, pud, addr);
+		if (!pmd)
+			return -ENOMEM;
+	} else {
+		pmd = pmd_offset(pud, addr);
+	}
 	do {
 		next = pmd_addr_end(addr, end);
-		err = apply_to_pte_range(mm, pmd, addr, next, fn, data);
-		if (err)
-			break;
+		if (create || !pmd_none_or_clear_bad(pmd)) {
+			err = apply_to_pte_range(mm, pmd, addr, next, fn, data,
+						 create);
+			if (err)
+				break;
+		}
 	} while (pmd++, addr = next, addr != end);
 	return err;
 }
 
 static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
 				     unsigned long addr, unsigned long end,
-				     pte_fn_t fn, void *data)
+				     pte_fn_t fn, void *data, bool create)
 {
 	pud_t *pud;
 	unsigned long next;
-	int err;
+	int err = 0;
 
-	pud = pud_alloc(mm, p4d, addr);
-	if (!pud)
-		return -ENOMEM;
+	if (create) {
+		pud = pud_alloc(mm, p4d, addr);
+		if (!pud)
+			return -ENOMEM;
+	} else {
+		pud = pud_offset(p4d, addr);
+	}
 	do {
 		next = pud_addr_end(addr, end);
-		err = apply_to_pmd_range(mm, pud, addr, next, fn, data);
-		if (err)
-			break;
+		if (create || !pud_none_or_clear_bad(pud)) {
+			err = apply_to_pmd_range(mm, pud, addr, next, fn, data,
+						 create);
+			if (err)
+				break;
+		}
 	} while (pud++, addr = next, addr != end);
 	return err;
 }
 
 static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 				     unsigned long addr, unsigned long end,
-				     pte_fn_t fn, void *data)
+				     pte_fn_t fn, void *data, bool create)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	int err;
+	int err = 0;
 
-	p4d = p4d_alloc(mm, pgd, addr);
-	if (!p4d)
-		return -ENOMEM;
+	if (create) {
+		p4d = p4d_alloc(mm, pgd, addr);
+		if (!p4d)
+			return -ENOMEM;
+	} else {
+		p4d = p4d_offset(pgd, addr);
+	}
 	do {
 		next = p4d_addr_end(addr, end);
-		err = apply_to_pud_range(mm, p4d, addr, next, fn, data);
-		if (err)
-			break;
+		if (create || !p4d_none_or_clear_bad(p4d)) {
+			err = apply_to_pud_range(mm, p4d, addr, next, fn, data,
+						 create);
+			if (err)
+				break;
+		}
 	} while (p4d++, addr = next, addr != end);
 	return err;
 }
@@ -2130,7 +2159,7 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data);
+		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, true);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
@@ -2139,6 +2168,38 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_page_range);
 
+/*
+ * Scan a region of virtual memory, calling a provided function on
+ * each leaf page table where it exists.
+ *
+ * Unlike apply_to_page_range, this does _not_ fill in page tables
+ * where they are absent.
+ */
+int apply_to_existing_pages(struct mm_struct *mm, unsigned long addr,
+			    unsigned long size, pte_fn_t fn, void *data)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	unsigned long end = addr + size;
+	int err = 0;
+
+	if (WARN_ON(addr >= end))
+		return -EINVAL;
+
+	pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, false);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(apply_to_existing_pages);
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
-- 
2.20.1

