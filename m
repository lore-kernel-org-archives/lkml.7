Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F47C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B306F22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VGVxsXxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfHUScO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42333 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfHUScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so4233636qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eQcqgkViU39lFjlil3M8Svf5iGtzpDKWpUSwhlO3OFw=;
        b=VGVxsXxZVLgXe5xWt0w3J/cqZt4mPm3JCoyIMlx5/qCn3/rV+mpLZawysJ4O+rAw6f
         rcWCltuXomYefOmYS9boAk8MlSKZLFLpez1T2eU5UAOqBtCk+eYnrncQN08lpCSdkGyf
         PIsqybRE87/1zUPakM9BVxyUVwgSzcG8e5BR8hciBGCYtpef1hxwksC/bkTpUh63Nu1z
         r0dkWmNaCt6fZ3R/kbEqGqQMcBBJJlmFx2gVi5g4eCZFia+JeGbvB2BJNqBqglpwB9Jf
         fmNp4wajHEt1++t2qwnHfsKFYrMhCXmXUTxxMoR3CJGBHUqEsKoJ+KSJJuoJouAB+CBk
         jgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQcqgkViU39lFjlil3M8Svf5iGtzpDKWpUSwhlO3OFw=;
        b=h9/cn3cp8SglSJWAWdVf3/xvrztDh8uQkkC7EieBNg3RW0Pgi2kJMqA9pVN0iYpCiQ
         cxpW3fnDvA8cg+rG+3efoQb3j5hpvLhbzI5HPymgHU9skoeFA/PeLlleqeoGWt00DPfU
         7QLDSfMVMhUSt0U/Yj1cgLc9Jy/AEVznke1RjQeUF7PIrVnlLSRPziy39RDd8coCd2XR
         oVIbtJ/H4bswg3RfmcIw9zY7wWHMb5wMBH3OqGDaWe+6wSd+GP+A9kzeVj/xY7Ut1GSy
         JcZW2nMooevlL8JGDDuefpeCk6VzY41QpsiGLFdpwnNpeLvr81YBfrBWJ6Rnt3iOT2Eu
         hoaQ==
X-Gm-Message-State: APjAAAVAXzkdT2upcpAXiSw/rdKOSqSRferOtHL1LeZY15EQ3zeWMqs+
        SDWOcjMFxWZrCumLws1XLWhRAQ==
X-Google-Smtp-Source: APXvYqyiSUshBCv3Qv8uDRoW17fIP4H2R6mRVwcxyZZdx7O0GxR1GLWG+PqB5n8Xzz5Ldks8Zgr+lA==
X-Received: by 2002:a0c:8910:: with SMTP id 16mr19279920qvp.55.1566412330418;
        Wed, 21 Aug 2019 11:32:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:09 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 03/17] arm64, hibernate: remove gotos in create_safe_exec_page
Date:   Wed, 21 Aug 2019 14:31:50 -0400
Message-Id: <20190821183204.23576-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, gotos are used to handle cleanup after exception, but
in case of create_safe_exec_page there are no clean-ups. So,
simply return the errors directly.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 4bb4d17a6a7c..c8211108ec11 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -198,17 +198,14 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
-	int rc = 0;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
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
@@ -216,30 +213,24 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	pgdp = pgd_offset_raw((void *)get_safe_page(GFP_ATOMIC), dst_addr);
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
 
@@ -265,8 +256,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
 
-out:
-	return rc;
+	return 0;
 }
 
 #define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
-- 
2.23.0

