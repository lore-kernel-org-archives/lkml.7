Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA218C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B422084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Sok0tvbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfLDP77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46957 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfLDP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id f5so298821qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CRoxRB8IFeyVTKMx5ypVP5zpyTfws7d6gsb5dpS33vY=;
        b=Sok0tvbQLMnworXiNYVhIsHwglGthkb3F+IhAdIcuhFulkUCzxnNQoenHOV9jZOFjI
         j+LhEcYyCn9ROvSInEYKmOhJuEOPmmQ08vXVphxlZ2ehSYtzVB52PEXPd228QW3V74bh
         cAaSTg7fOOZQ3NITCQCB1rwrp/WGVCUOy6xrabpfn66awnzPzV69K6GT9ulg6YMTgbXj
         uRAuoIS70KFRfBdgKsaRb61RQkg7X6LVBK5drx/E0YOZIem865LxPGCr5r703CATQc8U
         rOrWA2d25zRlVOYA7M4U9udGrIjq30jlrkiJt8irQv3CKskg4Iik/g8iaoL+WRUNkLv6
         6VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRoxRB8IFeyVTKMx5ypVP5zpyTfws7d6gsb5dpS33vY=;
        b=CGQbDs8h22ETHpX/gH7HcuAzMHnfSq9TnPC1Se6CJifmPOsMQCCIzXR3OAMMUY5b2r
         iLbBuUZMjVgoLoQzJhNAjaxJuH2K5JxlHPxU9O1RZRFKP6ue5bQeovZokMk/rhdneHsJ
         EKA/eRFSKc8HdO9RYW8Etuoe1uhqJao0UcDyXG1U6MZ67lOjc3tUiRHSE5bv5I7bTneA
         nYluRkv8ZEt3QHPkxgsalxIlG1wSilZAp92kL3hlMypQH7oZS3A3KiKtC6fBEv8c7ag4
         OJEJZbXvdbuoX6ockIfkqJmA/bmHbSTCeOQ+XcMNSkBmBzPQB++N3QH+6kZJD5wFL2DM
         8u2w==
X-Gm-Message-State: APjAAAW3x4/2/iGGQPi+rTPZVKjxCF9ikW09Ec6oPCTWqJ36pvHASgCI
        lhfPzenl4Tdkbe30e1VCWf+QMA==
X-Google-Smtp-Source: APXvYqyVmMQxr7dKNkbJcOcAyAvUUs0ErG6tRUeh+GTtJpJDytBoHcBnlTjVSMoH9TY9Eceuj5dpxQ==
X-Received: by 2002:a37:514:: with SMTP id 20mr3502735qkf.321.1575475191178;
        Wed, 04 Dec 2019 07:59:51 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:50 -0800 (PST)
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
Subject: [PATCH v8 07/25] arm64: hibernate: remove gotos as they are not needed
Date:   Wed,  4 Dec 2019 10:59:20 -0500
Message-Id: <20191204155938.2279686-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, gotos are used to handle cleanup after exception, but in case of
create_safe_exec_page and swsusp_arch_resume there are no clean-ups. So,
simply return the errors directly.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 49 ++++++++++++-----------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 34297716643f..83c41a2f8400 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -198,7 +198,6 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
-	int rc = 0;
 	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -206,47 +205,37 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	pte_t *ptep;
 	unsigned long dst = get_safe_page(GFP_ATOMIC);
 
-	if (!dst) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!dst)
+		return -ENOMEM;
 
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
 	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!trans_pgd)
+		return -ENOMEM;
 
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pudp) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		if (!pudp)
+			return -ENOMEM;
 		pgd_populate(&init_mm, pgdp, pudp);
 	}
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
 		pmdp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pmdp) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		if (!pmdp)
+			return -ENOMEM;
 		pud_populate(&init_mm, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
 		ptep = (void *)get_safe_page(GFP_ATOMIC);
-		if (!ptep) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		if (!ptep)
+			return -ENOMEM;
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
@@ -272,8 +261,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
 
-out:
-	return rc;
+	return 0;
 }
 
 #define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
@@ -482,7 +470,7 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
  */
 int swsusp_arch_resume(void)
 {
-	int rc = 0;
+	int rc;
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
@@ -498,12 +486,11 @@ int swsusp_arch_resume(void)
 	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
 	if (!tmp_pg_dir) {
 		pr_err("Failed to allocate memory for temporary page tables.\n");
-		rc = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, PAGE_END);
 	if (rc)
-		goto out;
+		return rc;
 
 	/*
 	 * We need a zero page that is zero before & after resume in order to
@@ -512,8 +499,7 @@ int swsusp_arch_resume(void)
 	zero_page = (void *)get_safe_page(GFP_ATOMIC);
 	if (!zero_page) {
 		pr_err("Failed to allocate zero page.\n");
-		rc = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	/*
@@ -531,7 +517,7 @@ int swsusp_arch_resume(void)
 				   &phys_hibernate_exit);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
-		goto out;
+		return rc;
 	}
 
 	/*
@@ -558,8 +544,7 @@ int swsusp_arch_resume(void)
 		       resume_hdr.reenter_kernel, restore_pblist,
 		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
 
-out:
-	return rc;
+	return 0;
 }
 
 int hibernate_resume_nonboot_cpu_disable(void)
-- 
2.24.0

