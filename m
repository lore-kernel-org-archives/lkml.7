Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A423ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D614321A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n4gYF9Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436919AbfJPUBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42376 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436895AbfJPUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so23978555qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5o2YG8+5Z5dAjKqxigR03o3JcPhGsvi/WQlGzEuzFPY=;
        b=n4gYF9IcfNd9m5OZ9m+lE/VmjwZQYdbcZ2oc4U54k2IIPllhyHRoYz2dYV096R7Xo0
         jdEBvK22KEq/zQGN79DUUF/IhPGP9mjd9L+yWxk7fJOkSv+LOwq5NyluqYCLraLaSgcv
         cfPEoUiVYZdygDNzvhxf6II0STRZ/ibhq2ZnJFDBq3W/801I3ZfJvqjt4DdXZFWaiDGB
         OVML+4LwICOGAgwlk7VPknmU8w27k3FI5vCmCR8KsaH7xToX8EUjzuax6K3myfQuHKML
         Sll6hc4Dbv/B8/+tHMAvLnps4vZjS99cPhXceX80v5sPBuSKsGsMvumlX8DSjOEj1tQF
         IYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5o2YG8+5Z5dAjKqxigR03o3JcPhGsvi/WQlGzEuzFPY=;
        b=jFUkKUu7Q5MDpofoeW6WZn/xJ0onLCU1shGbJty6xq5oBU8r50x9Px+z+BFzpvO0G7
         taiyXeAW2VKclytvFmBi7akNIKJOf5TnyU74WzyNf7bGumVGe3Mnh3clTIXzIRQaTKKT
         tG+KuLZH9lo0Hku7M8+UEppLcMsRF2uwYqCdPT8P0tdpiPejTUcKZCrfuU6c0EoyD0WH
         OGikFeACA0W36XFe4Q4Yq2V/GORfW5eG/jCLUsF8JwvshyorbGM7jnK/5pIwxO6xTHO/
         U1eQaa8AyQahCJ/CL1t/Xm9x/jL6FiYE7xog1uONzxHb8le46oIhfIWdkx4lLsefFYGk
         rwXA==
X-Gm-Message-State: APjAAAVxtqtG1UAeELJxN2Gwr+GIRqXe7l9LDeVTAEdvU2ZH3PReIesX
        joJrj69aUEQPFVjn/04CmchXSw==
X-Google-Smtp-Source: APXvYqx6ejRrGJ4s3oxvsZy2e3AGkK+ndvOtIjPpHpCFZiTiCQ0jQrYqfBOx7SqOAF+u2qWXWQP7Ug==
X-Received: by 2002:a37:9fc7:: with SMTP id i190mr11956567qke.296.1571256058015;
        Wed, 16 Oct 2019 13:00:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:57 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 13/25] arm64: trans_pgd: pass allocator trans_pgd_create_copy
Date:   Wed, 16 Oct 2019 16:00:22 -0400
Message-Id: <20191016200034.1342308-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make trans_pgd_create_copy and its subroutines to use allocator that is
passed as an argument

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  4 +--
 arch/arm64/kernel/hibernate.c      |  7 ++++-
 arch/arm64/mm/trans_pgd.c          | 44 ++++++++++++++++++------------
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index bb38f73aa7aa..56613e83aa53 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -25,8 +25,8 @@ struct trans_pgd_info {
 	void *trans_alloc_arg;
 };
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end);
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  unsigned long start, unsigned long end);
 
 int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		       void *page, unsigned long dst_addr, pgprot_t pgprot);
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 607bb1fbc349..95e00536aa67 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -322,13 +322,18 @@ int swsusp_arch_resume(void)
 	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+	};
 
 	/*
 	 * Restoring the memory image will overwrite the ttbr1 page tables.
 	 * Create a second copy of just the linear map, and use this when
 	 * restoring.
 	 */
-	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, PAGE_END);
+	rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, PAGE_OFFSET,
+				   PAGE_END);
 	if (rc)
 		return rc;
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 1142dde8c02f..df3a10d36f62 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -57,14 +57,14 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 	}
 }
 
-static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
-		    unsigned long end)
+static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
+		    pmd_t *src_pmdp, unsigned long start, unsigned long end)
 {
 	pte_t *src_ptep;
 	pte_t *dst_ptep;
 	unsigned long addr = start;
 
-	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
+	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
 	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
@@ -78,8 +78,8 @@ static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
 	return 0;
 }
 
-static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
-		    unsigned long end)
+static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
+		    pud_t *src_pudp, unsigned long start, unsigned long end)
 {
 	pmd_t *src_pmdp;
 	pmd_t *dst_pmdp;
@@ -87,7 +87,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	unsigned long addr = start;
 
 	if (pud_none(READ_ONCE(*dst_pudp))) {
-		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
+		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
 		pud_populate(&init_mm, dst_pudp, dst_pmdp);
@@ -102,7 +102,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 		if (pmd_none(pmd))
 			continue;
 		if (pmd_table(pmd)) {
-			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
+			if (copy_pte(info, dst_pmdp, src_pmdp, addr, next))
 				return -ENOMEM;
 		} else {
 			set_pmd(dst_pmdp,
@@ -113,7 +113,8 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	return 0;
 }
 
-static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
+static int copy_pud(struct trans_pgd_info *info, pgd_t *dst_pgdp,
+		    pgd_t *src_pgdp, unsigned long start,
 		    unsigned long end)
 {
 	pud_t *dst_pudp;
@@ -122,7 +123,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	unsigned long addr = start;
 
 	if (pgd_none(READ_ONCE(*dst_pgdp))) {
-		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
+		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
 		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
@@ -137,7 +138,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 		if (pud_none(pud))
 			continue;
 		if (pud_table(pud)) {
-			if (copy_pmd(dst_pudp, src_pudp, addr, next))
+			if (copy_pmd(info, dst_pudp, src_pudp, addr, next))
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
@@ -148,8 +149,8 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	return 0;
 }
 
-static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
-			    unsigned long end)
+static int copy_page_tables(struct trans_pgd_info *info, pgd_t *dst_pgdp,
+			    unsigned long start, unsigned long end)
 {
 	unsigned long next;
 	unsigned long addr = start;
@@ -160,25 +161,34 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(READ_ONCE(*src_pgdp)))
 			continue;
-		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
+		if (copy_pud(info, dst_pgdp, src_pgdp, addr, next))
 			return -ENOMEM;
 	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
 
 	return 0;
 }
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end)
+/*
+ * Create trans_pgd and copy linear map.
+ * info:	contains allocator and its argument
+ * dst_pgdp:	new page table that is created, and to which map is copied.
+ * start:	Start of the interval (inclusive).
+ * end:		End of the interval (exclusive).
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ */
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **dst_pgdp,
+			  unsigned long start, unsigned long end)
 {
 	int rc;
-	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_pgd = trans_alloc(info);
 
 	if (!trans_pgd) {
 		pr_err("Failed to allocate memory for temporary page tables.\n");
 		return -ENOMEM;
 	}
 
-	rc = copy_page_tables(trans_pgd, start, end);
+	rc = copy_page_tables(info, trans_pgd, start, end);
 	if (!rc)
 		*dst_pgdp = trans_pgd;
 
-- 
2.23.0

