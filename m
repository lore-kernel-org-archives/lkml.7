Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36644C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6642173E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="l+p8+edO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHQCrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:47:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33007 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHQCqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id v38so8258462qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YcRiD81CkGA/tiGkEwYWkDWZvYJnW8+40y1Dv0r42/8=;
        b=l+p8+edOT71ecECp/u3tuhk3eamkWriWn5ws7p7UJAZCeqR7QgvXu6HxZKWdU7tRwJ
         UUtPACIFNZF+eStlnshfs4kvXDNRIMzyYMJWusoTQ3Chewjw32LETYU7RV2ejjvGFY1j
         R7djYTkVxGAOeWVwSx5wdHkDns8SbXlC8L5ECHyzW0RHLkO4xvSOtS80IZ9cs6L1stig
         3pbKsKq4Pm2dFO0SZIYeFOC146IAJshB/M9rfARer8wtZ5DkuVtj5GBUmf8nDP7QQrvB
         mQoAFnQOsMvesegMQSau8Hsley1Fg4tKSbpDObFqFyNOMOwuVewaUpD4CtySzvddH5/S
         VjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcRiD81CkGA/tiGkEwYWkDWZvYJnW8+40y1Dv0r42/8=;
        b=meeepIoYTY84e7UTzMAvEslOQFE5CLecTzVNU/mLxXDq0RbJ3nHgk0ZhxL2SwhwS9s
         735W1kf6ISeu27JWAX6lVfJIzjkj2d1I/IQNtTK/GNGxVqC//wdYTE5blthCF+eH+JVX
         ISCpvGJestjU+SUnIbNvfyb0GSYZWAqZZ0pl7Okd6LKpQOQNvGH+3QHdmPHIz0pVeL/r
         oLFfURHeVlJWneAVRl8MBxjuXKfLCthB9mXVGHJo2XQxBuKaaSZ56rPt90bVdO4UEE76
         FMYT8+d5vb0imiY1/sR7RSuNYXilEA9fTtIrzrSRqx5lredjJukV8jSHupYjdBD6A53a
         l06Q==
X-Gm-Message-State: APjAAAVocdTgwh0KWlSYg1DVlQ5RiSfzYWQtucmS0jtuC1jbk4TZZbv+
        Gz+xlZLNp2s+lgm460WKUaq0Ag==
X-Google-Smtp-Source: APXvYqzkvUJTKF443y0fqKhgWTNB+cG/M187ziS8mkOR9Fisvx3ycBpiOm4doD2LJHgEFGwqmKufxg==
X-Received: by 2002:ac8:7b56:: with SMTP id m22mr4350519qtu.390.1566010003981;
        Fri, 16 Aug 2019 19:46:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:43 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 09/14] arm64, trans_table: complete generalization of trans_tables
Date:   Fri, 16 Aug 2019 22:46:24 -0400
Message-Id: <20190817024629.26611-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the last private functions in page table copy path generlized for use
outside of hibernate.

Switch to use the provided allocator, flags, and source page table. Also,
unify all copy function implementations to reduce the possibility of bugs.
All page table levels are implemented symmetrically.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/mm/trans_table.c | 204 ++++++++++++++++++++----------------
 1 file changed, 113 insertions(+), 91 deletions(-)

diff --git a/arch/arm64/mm/trans_table.c b/arch/arm64/mm/trans_table.c
index 815e40bb1316..ce0f24806eaa 100644
--- a/arch/arm64/mm/trans_table.c
+++ b/arch/arm64/mm/trans_table.c
@@ -27,139 +27,161 @@ static void *trans_alloc(struct trans_table_info *info)
 	return page;
 }
 
-static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
+static int trans_table_copy_pte(struct trans_table_info *info, pte_t *dst_ptep,
+				pte_t *src_ptep, unsigned long start,
+				unsigned long end)
 {
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
 	unsigned long addr = start;
+	int i = pte_index(addr);
 
-	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
-	if (!dst_ptep)
-		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
-	dst_ptep = pte_offset_kernel(dst_pmdp, start);
-
-	src_ptep = pte_offset_kernel(src_pmdp, start);
 	do {
-		_copy_pte(dst_ptep, src_ptep, addr);
-	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
+		pte_t src_pte = READ_ONCE(src_ptep[i]);
+
+		if (pte_none(src_pte))
+			continue;
+		if (info->trans_flags & TRANS_MKWRITE)
+			src_pte = pte_mkwrite(src_pte);
+		if (info->trans_flags & TRANS_MKVALID)
+			src_pte = pte_mkpresent(src_pte);
+		if (info->trans_flags & TRANS_CHECKPFN) {
+			if (!pfn_valid(pte_pfn(src_pte)))
+				return -ENXIO;
+		}
+		set_pte(&dst_ptep[i], src_pte);
+	} while (addr += PAGE_SIZE, i++, addr != end && i < PTRS_PER_PTE);
 
 	return 0;
 }
 
-static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
-		    unsigned long end)
+static int trans_table_copy_pmd(struct trans_table_info *info, pmd_t *dst_pmdp,
+				pmd_t *src_pmdp, unsigned long start,
+				unsigned long end)
 {
-	pmd_t *src_pmdp;
-	pmd_t *dst_pmdp;
 	unsigned long next;
 	unsigned long addr = start;
+	int i = pmd_index(addr);
+	int rc;
 
-	if (pud_none(READ_ONCE(*dst_pudp))) {
-		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
-		if (!dst_pmdp)
-			return -ENOMEM;
-		pud_populate(&init_mm, dst_pudp, dst_pmdp);
-	}
-	dst_pmdp = pmd_offset(dst_pudp, start);
-
-	src_pmdp = pmd_offset(src_pudp, start);
 	do {
-		pmd_t pmd = READ_ONCE(*src_pmdp);
+		pmd_t src_pmd = READ_ONCE(src_pmdp[i]);
+		pmd_t dst_pmd = READ_ONCE(dst_pmdp[i]);
+		pte_t *dst_ptep, *src_ptep;
 
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(pmd))
+		if (pmd_none(src_pmd))
+			continue;
+
+		if (!pmd_table(src_pmd)) {
+			if (info->trans_flags & TRANS_MKWRITE)
+				pmd_val(src_pmd) &= ~PMD_SECT_RDONLY;
+			set_pmd(&dst_pmdp[i], src_pmd);
 			continue;
-		if (pmd_table(pmd)) {
-			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
+		}
+
+		if (pmd_none(dst_pmd)) {
+			pte_t *t = trans_alloc(info);
+
+			if (!t)
 				return -ENOMEM;
-		} else {
-			set_pmd(dst_pmdp,
-				__pmd(pmd_val(pmd) & ~PMD_SECT_RDONLY));
+
+			__pmd_populate(&dst_pmdp[i], __pa(t), PTE_TYPE_PAGE);
+			dst_pmd = READ_ONCE(dst_pmdp[i]);
 		}
-	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
+
+		src_ptep = __va(pmd_page_paddr(src_pmd));
+		dst_ptep = __va(pmd_page_paddr(dst_pmd));
+
+		rc = trans_table_copy_pte(info, dst_ptep, src_ptep, addr, next);
+		if (rc)
+			return rc;
+	} while (addr = next, i++, addr != end && i < PTRS_PER_PMD);
 
 	return 0;
 }
 
-static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
-		    unsigned long end)
+static int trans_table_copy_pud(struct trans_table_info *info, pud_t *dst_pudp,
+				pud_t *src_pudp, unsigned long start,
+				unsigned long end)
 {
-	pud_t *dst_pudp;
-	pud_t *src_pudp;
 	unsigned long next;
 	unsigned long addr = start;
+	int i = pud_index(addr);
+	int rc;
 
-	if (pgd_none(READ_ONCE(*dst_pgdp))) {
-		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
-		if (!dst_pudp)
-			return -ENOMEM;
-		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
-	}
-	dst_pudp = pud_offset(dst_pgdp, start);
-
-	src_pudp = pud_offset(src_pgdp, start);
 	do {
-		pud_t pud = READ_ONCE(*src_pudp);
+		pud_t src_pud = READ_ONCE(src_pudp[i]);
+		pud_t dst_pud = READ_ONCE(dst_pudp[i]);
+		pmd_t *dst_pmdp, *src_pmdp;
 
 		next = pud_addr_end(addr, end);
-		if (pud_none(pud))
+		if (pud_none(src_pud))
 			continue;
-		if (pud_table(pud)) {
-			if (copy_pmd(dst_pudp, src_pudp, addr, next))
+
+		if (!pud_table(src_pud)) {
+			if (info->trans_flags & TRANS_MKWRITE)
+				pud_val(src_pud) &= ~PUD_SECT_RDONLY;
+			set_pud(&dst_pudp[i], src_pud);
+			continue;
+		}
+
+		if (pud_none(dst_pud)) {
+			pmd_t *t = trans_alloc(info);
+
+			if (!t)
 				return -ENOMEM;
-		} else {
-			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
+
+			__pud_populate(&dst_pudp[i], __pa(t), PMD_TYPE_TABLE);
+			dst_pud = READ_ONCE(dst_pudp[i]);
 		}
-	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
+
+		src_pmdp = __va(pud_page_paddr(src_pud));
+		dst_pmdp = __va(pud_page_paddr(dst_pud));
+
+		rc = trans_table_copy_pmd(info, dst_pmdp, src_pmdp, addr, next);
+		if (rc)
+			return rc;
+	} while (addr = next, i++, addr != end && i < PTRS_PER_PUD);
 
 	return 0;
 }
 
-static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
-			    unsigned long end)
+static int trans_table_copy_pgd(struct trans_table_info *info, pgd_t *dst_pgdp,
+				pgd_t *src_pgdp, unsigned long start,
+				unsigned long end)
 {
 	unsigned long next;
 	unsigned long addr = start;
-	pgd_t *src_pgdp = pgd_offset_k(start);
+	int i = pgd_index(addr);
+	int rc;
 
-	dst_pgdp = pgd_offset_raw(dst_pgdp, start);
 	do {
+		pgd_t src_pgd;
+		pgd_t dst_pgd;
+		pud_t *dst_pudp, *src_pudp;
+
+		src_pgd = READ_ONCE(src_pgdp[i]);
+		dst_pgd = READ_ONCE(dst_pgdp[i]);
 		next = pgd_addr_end(addr, end);
-		if (pgd_none(READ_ONCE(*src_pgdp)))
+		if (pgd_none(src_pgd))
 			continue;
-		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
-			return -ENOMEM;
-	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
+
+		if (pgd_none(dst_pgd)) {
+			pud_t *t = trans_alloc(info);
+
+			if (!t)
+				return -ENOMEM;
+
+			__pgd_populate(&dst_pgdp[i], __pa(t), PUD_TYPE_TABLE);
+			dst_pgd = READ_ONCE(dst_pgdp[i]);
+		}
+
+		src_pudp = __va(pgd_page_paddr(src_pgd));
+		dst_pudp = __va(pgd_page_paddr(dst_pgd));
+
+		rc = trans_table_copy_pud(info, dst_pudp, src_pudp, addr, next);
+		if (rc)
+			return rc;
+	} while (addr = next, i++, addr != end && i < PTRS_PER_PGD);
 
 	return 0;
 }
@@ -186,7 +208,7 @@ int trans_table_create_copy(struct trans_table_info *info, pgd_t **trans_table,
 	if (rc)
 		return rc;
 
-	return copy_page_tables(*trans_table, start, end);
+	return trans_table_copy_pgd(info, *trans_table, from_table, start, end);
 }
 
 int trans_table_map_page(struct trans_table_info *info, pgd_t *trans_table,
-- 
2.22.1

