Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEAC3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FBE21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="oXQfO2Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfHQCqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36770 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfHQCqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so8232496qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8WbcRUtcHS2GIYxAvuez1hxS2GbdOM3ZjGBgXllqxc8=;
        b=oXQfO2Fq0+QO8q1nxDXVLE8A340S8v0eM8eMEpfD8VCqrlolgOHZ/Jl4EOXvD1hBmN
         qUvUvJtldvU6AW3L+EyqAm5Fe/+a5+pIPehabKcS8bDJegz8Wnr8Zot1F8UHt5Sx9H0s
         oh904Zd6R9xJUn3e+uu59HVjR1rYCil+ohry7eNsDwnQ7TgpvGc+7ZAohfziUL/xB5Uf
         QigCZp1KU9V+ek+gKpoFh+7Y8AzwUZ3SvyQFDN/z9HvDer6uVe3fJhNIh7ndo41vaccT
         KCx+SSUXT0FW47qAr2agJ3tfNSttmXEfsU+J2R7GnC8Qe5qf2OT7EKa/vamIoTeHGcAI
         moAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WbcRUtcHS2GIYxAvuez1hxS2GbdOM3ZjGBgXllqxc8=;
        b=eaU4HMIv9LFqSKJZ7oJ1KshaKPPg8MVeem9GVuyQnNoo5yFIFjIH1I/6orLS0yVjNf
         fmOj95DLDSFU5NlhW8EtyhFhPdjTRlqW1pBH9vi1eVjUjSVwS8BnDNg7Q4VCrr0DNahm
         PUgjG70bWLWkXT3fG+cddvh1htdV3ni/c7WhqbIMvo8/tRLF+5lS845I7oikyxrnF/Ww
         NaduglgiNE4wvMuWWvScJRblduVjGebbXIsGZQKgUR2BfROwTMLTrgeRRUp19CStvUWQ
         fdIfu/AgZP/mQ69oXmaciNhyPikJPRZlS2D0LoQ0C6y2UBiPb9mfNtDIhcL+xMG6Rdcy
         v74Q==
X-Gm-Message-State: APjAAAWZ4YGp2WpL27CkLnM/ZJ5+7q8leFudz3itI9n8naksWETCcnXF
        4tBWHQ6TV3fIi/vMFjJfn1ODIA==
X-Google-Smtp-Source: APXvYqzw8XVlfyeSlginpUsJyP3V5lwU2lsl83ETWErVpn1VDaT1lh+VZAzw47gT8aBurcy+cJ6XLg==
X-Received: by 2002:ac8:128c:: with SMTP id y12mr11453271qti.242.1566009998439;
        Fri, 16 Aug 2019 19:46:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:37 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 05/14] arm64, trans_table: make trans_table_map_page generic
Date:   Fri, 16 Aug 2019 22:46:20 -0400
Message-Id: <20190817024629.26611-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, trans_table_map_page has assumptions that are relevant to
hibernate. But, to make it generic we must allow it to use any allocator
and also, can't assume that entries do not exist in the page table
already. Also, we can't use init_mm here.

Also, add "flags" for trans_table_info, they are going to be used
in copy functions once they are generalized.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_table.h | 40 +++++++++++++-
 arch/arm64/kernel/hibernate.c        | 13 ++++-
 arch/arm64/mm/trans_table.c          | 83 +++++++++++++++++++---------
 3 files changed, 107 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/trans_table.h b/arch/arm64/include/asm/trans_table.h
index f57b2ab2a0b8..1a57af09ded5 100644
--- a/arch/arm64/include/asm/trans_table.h
+++ b/arch/arm64/include/asm/trans_table.h
@@ -11,11 +11,45 @@
 #include <linux/bits.h>
 #include <asm/pgtable-types.h>
 
+/*
+ * trans_alloc_page
+ *	- Allocator that should return exactly one uninitilaized page, if this
+ *	 allocator fails, trans_table returns -ENOMEM error.
+ *
+ * trans_alloc_arg
+ *	- Passed to trans_alloc_page as an argument
+ *
+ * trans_flags
+ *	- bitmap with flags that control how page table is filled.
+ *	  TRANS_MKWRITE: during page table copy make PTE, PME, and PUD page
+ *			 writeable by removing RDONLY flag from PTE.
+ *	  TRANS_MKVALID: during page table copy, if PTE present, but not valid,
+ *			 make it valid.
+ *	  TRANS_CHECKPFN: During page table copy, for every PTE entry check that
+ *			  PFN that this PTE points to is valid. Otherwise return
+ *			  -ENXIO
+ */
+
+#define	TRANS_MKWRITE	BIT(0)
+#define	TRANS_MKVALID	BIT(1)
+#define	TRANS_CHECKPFN	BIT(2)
+
+struct trans_table_info {
+	void * (*trans_alloc_page)(void *arg);
+	void *trans_alloc_arg;
+	unsigned long trans_flags;
+};
+
 int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			    unsigned long end);
 
-int trans_table_map_page(pgd_t *trans_table, void *page,
-			 unsigned long dst_addr,
-			 pgprot_t pgprot);
+/*
+ * Add map entry to trans_table for a base-size page at PTE level.
+ * page:	page to be mapped.
+ * dst_addr:	new VA address for the pages
+ * pgprot:	protection for the page.
+ */
+int trans_table_map_page(struct trans_table_info *info, pgd_t *trans_table,
+			 void *page, unsigned long dst_addr, pgprot_t pgprot);
 
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 0cb858b3f503..524b68ec3233 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -179,6 +179,12 @@ int arch_hibernation_header_restore(void *addr)
 }
 EXPORT_SYMBOL(arch_hibernation_header_restore);
 
+static void *
+hibernate_page_alloc(void *arg)
+{
+	return (void *)get_safe_page((gfp_t)(unsigned long)arg);
+}
+
 /*
  * Copies length bytes, starting at src_start into an new page,
  * perform cache maintentance, then maps it at the specified address low
@@ -195,6 +201,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
+	struct trans_table_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+		.trans_flags		= 0,
+	};
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
 	pgd_t *trans_table;
 	int rc;
@@ -209,7 +220,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (!trans_table)
 		return -ENOMEM;
 
-	rc = trans_table_map_page(trans_table, page, dst_addr,
+	rc = trans_table_map_page(&trans_info, trans_table, page, dst_addr,
 				  PAGE_KERNEL_EXEC);
 	if (rc)
 		return rc;
diff --git a/arch/arm64/mm/trans_table.c b/arch/arm64/mm/trans_table.c
index b4bbb559d9cf..12f4b3cab6d6 100644
--- a/arch/arm64/mm/trans_table.c
+++ b/arch/arm64/mm/trans_table.c
@@ -17,6 +17,16 @@
 #include <asm/pgtable.h>
 #include <linux/suspend.h>
 
+static void *trans_alloc(struct trans_table_info *info)
+{
+	void *page = info->trans_alloc_page(info->trans_alloc_arg);
+
+	if (page)
+		clear_page(page);
+
+	return page;
+}
+
 static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
 	pte_t pte = READ_ONCE(*src_ptep);
@@ -172,41 +182,64 @@ int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
 	return rc;
 }
 
-int trans_table_map_page(pgd_t *trans_table, void *page,
-			 unsigned long dst_addr,
-			 pgprot_t pgprot)
+int trans_table_map_page(struct trans_table_info *info, pgd_t *trans_table,
+			 void *page, unsigned long dst_addr, pgprot_t pgprot)
 {
-	pgd_t *pgdp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	pgdp = pgd_offset_raw(trans_table, dst_addr);
-	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pudp)
+	int pgd_idx = pgd_index(dst_addr);
+	int pud_idx = pud_index(dst_addr);
+	int pmd_idx = pmd_index(dst_addr);
+	int pte_idx = pte_index(dst_addr);
+	pgd_t *pgdp = trans_table;
+	pgd_t pgd = READ_ONCE(pgdp[pgd_idx]);
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	if (pgd_none(pgd)) {
+		pud_t *t = trans_alloc(info);
+
+		if (!t)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
+
+		__pgd_populate(&pgdp[pgd_idx], __pa(t), PUD_TYPE_TABLE);
+		pgd = READ_ONCE(pgdp[pgd_idx]);
 	}
 
-	pudp = pud_offset(pgdp, dst_addr);
-	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pmdp)
+	pudp = __va(pgd_page_paddr(pgd));
+	pud = READ_ONCE(pudp[pud_idx]);
+	if (pud_sect(pud)) {
+		return -ENXIO;
+	} else if (pud_none(pud) || pud_sect(pud)) {
+		pmd_t *t = trans_alloc(info);
+
+		if (!t)
 			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
+
+		__pud_populate(&pudp[pud_idx], __pa(t), PMD_TYPE_TABLE);
+		pud = READ_ONCE(pudp[pud_idx]);
 	}
 
-	pmdp = pmd_offset(pudp, dst_addr);
-	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = (void *)get_safe_page(GFP_ATOMIC);
-		if (!ptep)
+	pmdp = __va(pud_page_paddr(pud));
+	pmd = READ_ONCE(pmdp[pmd_idx]);
+	if (pmd_sect(pmd)) {
+		return -ENXIO;
+	} else if (pmd_none(pmd) || pmd_sect(pmd)) {
+		pte_t *t = trans_alloc(info);
+
+		if (!t)
 			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
+
+		__pmd_populate(&pmdp[pmd_idx], __pa(t), PTE_TYPE_PAGE);
+		pmd = READ_ONCE(pmdp[pmd_idx]);
 	}
 
-	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
+	ptep = __va(pmd_page_paddr(pmd));
+	pte = READ_ONCE(ptep[pte_idx]);
+
+	if (!pte_none(pte))
+		return -ENXIO;
+
+	set_pte(&ptep[pte_idx], pfn_pte(virt_to_pfn(page), pgprot));
 
 	return 0;
 }
-- 
2.22.1

