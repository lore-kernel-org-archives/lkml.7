Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1560C11FF7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D4B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="T60+YUHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502714AbfIWUey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:34:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44361 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502698AbfIWUev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:34:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so6991187pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=54zhWvY2wVoS8DJjdyrocZPF+2/4Isg+VJgEApzMseg=;
        b=T60+YUHd1pT2vUT24jaOnMItUPfL3L23oM9QlMa+jsQhTAMmE/Y6MOdB9kPjxsU2YE
         s0+Pj9I26CF7T263iX4+bryVjK3tjDXFjfcOSBZdy7hV7MpKa4gjlFgld8gCis5i0WKu
         DA5x0mdvLTvptlXKZYlRoL1Td1daAq/CiJc4sgJPCp/DOfklSjrpaiuYytsyCwDbIPep
         RrMtL9f00tDwSIjrtVkqS7eAQK9SjIWmyh9i5SqhoiJMe5ly6HuMgRWYiOWumRtRxhtF
         MIQP2OUZMi20ZuYed85vWrpjF7HIlaVilmAfvJ0kbcEB92CCSNdKtM1cYEJ0Wqv69SHa
         Igrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54zhWvY2wVoS8DJjdyrocZPF+2/4Isg+VJgEApzMseg=;
        b=rdNdpKai1Uq37hTn1M7viJ18EXWPLFy+w6fg5Zq0BC6u3TXyJXNnWKECE7Z8dY0PJ5
         RyqVUwglde3ST1NWpYC2iYqoiXyspGHesXjLq+KD93vI+Dz8tB/inurO2XoLAJuZ/onV
         iAdXRJWf+9/mWtTTyYwFKAozqY/7fotc94QC41vi1vhQ5PC4AiLxRgqf8yhifmmEdfCE
         X1cNtivV8mjb4+VEgafseSVMFwVHtvi0uzGDVNmXoLS+W4RTLdcRPpYOlpUZmFhN0Kg3
         V7lxId0In4+eNKCzviUV7oH1Sqh0nE8bzfWetvUo26uIkagQVz9GEizDQUJFKw0GD5ew
         3Wgg==
X-Gm-Message-State: APjAAAVjoaq0CuSBbq9rCNoQZDQ7qeSHRkHZU9knlW96/jPCX/xxH/ce
        rc+G4+j4VIaqUamp9rK3kUgoTQ==
X-Google-Smtp-Source: APXvYqwUHTTCL6RSrWrnHViIB5bAHeudUhgSk3W0cjjZa1o+jEKfZ6t0y0OfB7SpczrqbsafTznlZg==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr1704614plb.42.1569270890214;
        Mon, 23 Sep 2019 13:34:50 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:34:49 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 05/17] arm64: hibernate: remove gotos as they are not needed
Date:   Mon, 23 Sep 2019 16:34:15 -0400
Message-Id: <20190923203427.294286-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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
2.23.0

