Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE36FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E69121A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="d3QjW2W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436908AbfJPUBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36536 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436888AbfJPUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so24012772qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kjFZz1G4ugH0NKdqzmA4xYVTuBGkmMH5xSN576uyAO4=;
        b=d3QjW2W3a1uBTmmIMFG0sc8+tYx0/OVet1O2zr6IQkBkiooOeGabdTXBEr1KCrSroJ
         Ds5NhGlGHM5L41CdhNAeR+LS71N+uAp5DJke6AnM9QQY418Ktw+OTSrzW40FHKGq88g8
         X3RPjgAFtqDBCrH4ffwL5zSk4UycGnhz+hLRMKoMRCM4imhPMmQEZXckosT+0B/nYi3g
         nQmFR9iUvmPw9xtIFsADL22jCfmY0JZwxSMHwQDUakR0qEVA7vFmMXcKqGnzfAYhUz8L
         IflUZi5pc0nFEq5KJIjiLLtCgCoqveG2K+nagkxx8M/Z48ZaFJgkC7XqytMQM/E+Dejd
         XCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjFZz1G4ugH0NKdqzmA4xYVTuBGkmMH5xSN576uyAO4=;
        b=KoDm4juVQz5bV8HgVuABEjpJMjT3PI+edtssWzbi2PKSh8cgSvuzR21Ilt1CxbMc/S
         I7ROPRaWaT9rB04IRJD280i/syrqvUimTnlFaDAHH7yn0RpgyEXdRwtklsbfV1lwTJ/i
         IQpGXGsI5RSeyzgnT7bNzgIJX7XHwpBEVyv/XfjD4lJP575f2/TOQ/eNjnjQW+KJ/tkv
         IhBgNsSuMKmEAV+s7hPaTOw7nBo6aa+NvSDOJT3omZVPRCjt3ilg8h1sPgA6c88DizRy
         DK1IqE+9cY/lrzkhd3BETIhNyM5tpwOGuLOtfPqOmSbiXf/dY/2khOSWXAqH8hLiSvEn
         TYWQ==
X-Gm-Message-State: APjAAAXZVNlB4aeNZvag7HHRNFYhvI0ULpUsBiC3/XJHR4RuS2pjR4p6
        3jO9jHZGbJAua3UhFSJWWDDK3w==
X-Google-Smtp-Source: APXvYqw7n+rHBNtSkcB67+6NLb5nupsbBYrCacnem74iT36XKjodM7eEhPYV0nl+ZJEvFFdveb12HQ==
X-Received: by 2002:a05:620a:12c7:: with SMTP id e7mr42096476qkl.162.1571256056534;
        Wed, 16 Oct 2019 13:00:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:55 -0700 (PDT)
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
Subject: [PATCH v7 12/25] arm64: trans_pgd: make trans_pgd_map_page generic
Date:   Wed, 16 Oct 2019 16:00:21 -0400
Message-Id: <20191016200034.1342308-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec is going to use a different allocator, so make
trans_pgd_map_page to accept allocator as an argument, and also
kexec is going to use a different map protection, so also pass
it via argument.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/include/asm/trans_pgd.h | 18 ++++++++++++++++--
 arch/arm64/kernel/hibernate.c      | 12 +++++++++++-
 arch/arm64/mm/trans_pgd.c          | 27 +++++++++++++++++++++------
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index c7b5402b7d87..bb38f73aa7aa 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -11,10 +11,24 @@
 #include <linux/bits.h>
 #include <asm/pgtable-types.h>
 
+/*
+ * trans_alloc_page
+ *	- Allocator that should return exactly one zeroed page, if this
+ *	 allocator fails, trans_pgd returns -ENOMEM error.
+ *
+ * trans_alloc_arg
+ *	- Passed to trans_alloc_page as an argument
+ */
+
+struct trans_pgd_info {
+	void * (*trans_alloc_page)(void *arg);
+	void *trans_alloc_arg;
+};
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end);
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
-		       pgprot_t pgprot);
+int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
+		       void *page, unsigned long dst_addr, pgprot_t pgprot);
 
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 3d6f0fd73591..607bb1fbc349 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -179,6 +179,11 @@ int arch_hibernation_header_restore(void *addr)
 }
 EXPORT_SYMBOL(arch_hibernation_header_restore);
 
+static void *hibernate_page_alloc(void *arg)
+{
+	return (void *)get_safe_page((gfp_t)(unsigned long)arg);
+}
+
 /*
  * Copies length bytes, starting at src_start into an new page,
  * perform cache maintenance, then maps it at the specified address low
@@ -195,6 +200,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+	};
+
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
 	pgd_t *trans_pgd;
 	int rc;
@@ -209,7 +219,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (!trans_pgd)
 		return -ENOMEM;
 
-	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
+	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
 				PAGE_KERNEL_EXEC);
 	if (rc)
 		return rc;
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 5ac712b92439..1142dde8c02f 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -25,6 +25,11 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 
+static void *trans_alloc(struct trans_pgd_info *info)
+{
+	return info->trans_alloc_page(info->trans_alloc_arg);
+}
+
 static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
 	pte_t pte = READ_ONCE(*src_ptep);
@@ -180,8 +185,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 	return rc;
 }
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
-		       pgprot_t pgprot)
+/*
+ * Add map entry to trans_pgd for a base-size page at PTE level.
+ * info:	contains allocator and its argument
+ * trans_pgd:	page table in which new map is added.
+ * page:	page to be mapped.
+ * dst_addr:	new VA address for the pages
+ * pgprot:	protection for the page.
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ */
+int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
+		       void *page, unsigned long dst_addr, pgprot_t pgprot)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -190,7 +205,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
 
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
+		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
 		pgd_populate(&init_mm, pgdp, pudp);
@@ -198,7 +213,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = (void *)get_safe_page(GFP_ATOMIC);
+		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
 		pud_populate(&init_mm, pudp, pmdp);
@@ -206,14 +221,14 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = (void *)get_safe_page(GFP_ATOMIC);
+		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), pgprot));
 
 	return 0;
 }
-- 
2.23.0

