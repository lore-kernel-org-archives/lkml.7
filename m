Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C06C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CD321743
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mBM/N/z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHQCqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41727 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfHQCqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so8194704qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fhpOZXqdUBODzNYqQty59G5Ge7iC8PlIDy+5W4I7/qk=;
        b=mBM/N/z8yGTKkYzwBN4o/dCrlkPlU17gfdIIzSulgS6UObI37vB1wBM5E6QzN8Edol
         +ZIF+vG/LQ4sxc0fhJFMx1EUVqlrj1DZKhZOG5CG+2qnASJdJfF++BFPASeRZHsrOQ7l
         5f5Lc2n5wxaoFUY9/BftGTkGUIh93/1fDGukg46wRC7GIydl3rlFzVY7RYr8PU6ldDDJ
         T2/7MEX8je/x6UAz61qYNb9xAA4NihykJGICQtRl9NHdCGBGDJiuoKt5p6G9UGaGsalu
         ARbq1ne4gYamC8J8nKiChRzS3vCLuqR2484D9RiHFr+NU6SCL7isdVmTwg3yDP1oz/ig
         Fbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhpOZXqdUBODzNYqQty59G5Ge7iC8PlIDy+5W4I7/qk=;
        b=qRzZ05Sw48WQxyWtbUim+LAxeFI6+mq/KeXDlWhJE2PIahcX9oLO9Hmwr/q7JJuzTh
         3aqzoVZP9LEkZXAUMxqGqzDvnuO5FjRviULxzmyRxFaZ5QMnAKvoDVxzViYSI3lMh9yU
         nqscLXbFI4hKwiGGMF8UqhDLdhnesH/nbITILh6yhk/vit9HxSQ31ZkICePOweKB3ikG
         l+KbecJHjDL2KUIN6eGK23qI5Luzg8ptT8e4fr/qCyAHUNI1cgeg9IJygi4l+Lx6Pp6a
         xzDJpFvuP/VZgxGh2sBSfiZs3UnIzP4Q6vOC/D59Z+GLzj+LjcNiostIANgtLeeQbljx
         2s1w==
X-Gm-Message-State: APjAAAVcR8Y3x2JVxaG7hP3PTYPx+9zo6H7BQyIKENBxn4KV9dkpNpZH
        Rpl+0eKovj4J3yVE0hI7D936z5IwPG8=
X-Google-Smtp-Source: APXvYqwmnAgW0ugL2Xh/QQG6ta19bkx2PHnTpQKH7KpRdc000K+gJIFau3+/d7lsbnc3Od8y2BFYyw==
X-Received: by 2002:a0c:d251:: with SMTP id o17mr3892714qvh.109.1566009995607;
        Fri, 16 Aug 2019 19:46:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:35 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 03/14] arm64, hibernate: add trans_table public functions
Date:   Fri, 16 Aug 2019 22:46:18 -0400
Message-Id: <20190817024629.26611-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_table_create_copy() and trans_table_map_page() are going to be
the basis for public interface of new subsystem that handles page
tables for cases which are between kernels: kexec, and hibernate.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 96 ++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 96b6f8da7e49..449d69b5651c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
 }
 EXPORT_SYMBOL(arch_hibernation_header_restore);
 
-/*
- * Copies length bytes, starting at src_start into an new page,
- * perform cache maintentance, then maps it at the specified address low
- * address as executable.
- *
- * This is used by hibernate to copy the code it needs to execute when
- * overwriting the kernel text. This function generates a new set of page
- * tables, which it loads into ttbr0.
- *
- * Length is provided as we probably only want 4K of data, even on a 64K
- * page system.
- */
-static int create_safe_exec_page(void *src_start, size_t length,
-				 unsigned long dst_addr,
-				 phys_addr_t *phys_dst_addr)
+int trans_table_map_page(pgd_t *trans_table, void *page,
+			 unsigned long dst_addr,
+			 pgprot_t pgprot)
 {
-	void *page = (void *)get_safe_page(GFP_ATOMIC);
-	pgd_t *trans_table;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	if (!page)
-		return -ENOMEM;
-
-	memcpy((void *)page, src_start, length);
-	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
-
-	trans_table = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_table)
-		return -ENOMEM;
-
 	pgdp = pgd_offset_raw(trans_table, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = (void *)get_safe_page(GFP_ATOMIC);
@@ -242,6 +218,44 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	ptep = pte_offset_kernel(pmdp, dst_addr);
 	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
 
+	return 0;
+}
+
+/*
+ * Copies length bytes, starting at src_start into an new page,
+ * perform cache maintentance, then maps it at the specified address low
+ * address as executable.
+ *
+ * This is used by hibernate to copy the code it needs to execute when
+ * overwriting the kernel text. This function generates a new set of page
+ * tables, which it loads into ttbr0.
+ *
+ * Length is provided as we probably only want 4K of data, even on a 64K
+ * page system.
+ */
+static int create_safe_exec_page(void *src_start, size_t length,
+				 unsigned long dst_addr,
+				 phys_addr_t *phys_dst_addr)
+{
+	void *page = (void *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_table;
+	int rc;
+
+	if (!page)
+		return -ENOMEM;
+
+	memcpy(page, src_start, length);
+	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
+
+	trans_table = (void *)get_safe_page(GFP_ATOMIC);
+	if (!trans_table)
+		return -ENOMEM;
+
+	rc = trans_table_map_page(trans_table, page, dst_addr,
+				  PAGE_KERNEL_EXEC);
+	if (rc)
+		return rc;
+
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
 	 * ensure that TLBs are free of any entries that may overlap with the
@@ -259,7 +273,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);
 	isb();
 
-	*phys_dst_addr = virt_to_phys((void *)page);
+	*phys_dst_addr = virt_to_phys(page);
 
 	return 0;
 }
@@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 	return 0;
 }
 
+int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
+			    unsigned long end)
+{
+	int rc;
+	pgd_t *trans_table = (pgd_t *)get_safe_page(GFP_ATOMIC);
+
+	if (!trans_table) {
+		pr_err("Failed to allocate memory for temporary page tables.\n");
+		return -ENOMEM;
+	}
+
+	rc = copy_page_tables(trans_table, start, end);
+	if (!rc)
+		*dst_pgdp = trans_table;
+
+	return rc;
+}
+
 /*
  * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
  *
@@ -483,13 +515,7 @@ int swsusp_arch_resume(void)
 	 * Create a second copy of just the linear map, and use this when
 	 * restoring.
 	 */
-	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
-	if (!tmp_pg_dir) {
-		pr_err("Failed to allocate memory for temporary page tables.\n");
-		rc = -ENOMEM;
-		goto out;
-	}
-	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
+	rc = trans_table_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
 	if (rc)
 		goto out;
 
-- 
2.22.1

