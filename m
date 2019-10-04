Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372AE2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="clKcHMsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfJDSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:52:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43611 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbfJDSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so9902389qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=54zhWvY2wVoS8DJjdyrocZPF+2/4Isg+VJgEApzMseg=;
        b=clKcHMsmjTpHH3OdNrwlbLhjAkR10UEmyN/5Hr45JAN10sl2Re/vKrJh4N/kvALzmk
         lBcisdj1WvImpsbnmXJ1mwDOE0aEHX9lfTIr+w6nRSGjVv3KqXMPE/4ocyvyRujXtX5e
         cQzkg3sJz35x3v71nQdKUVEjL5jyYMlfNudeQoQpVAe907holo/8AuWImu0S06infI+4
         +eoVMAQFhg1Q/InMS5A9iXJSQDhCLo3rxabuCxDTFG2fcoUTm53DzRq8ZkLGQqYfRHO1
         SjzdZTSKRsmwyWbT3wYZy00rHoLpdKRaWSIjr8CovhmFuyt2zGRKy4vpnKahn8pa01l9
         d2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54zhWvY2wVoS8DJjdyrocZPF+2/4Isg+VJgEApzMseg=;
        b=q4qjil0KuTaw8qXBQl1qsBzjW+y2oV5xTfHwFRbpxqlmkYuKsMjgupfYcZQj90inkW
         IcY8TxQ0M63flaGQeM5T2/TXcpsAksRNGNLy3wj8r23YZ3stlXyiGmpPSB4uoJxd1/gR
         7UsJfQr7cCp/vO1/DxI1z2tajk1M3K4g4T1Da5Hp7UwX6fLxLgQJdXlWCCUF58kctjDg
         4ieubUi+1vHSKS5GV4BvAc47m6RcvY+9Q3cvcUDhVQ8Z2lvsDtSu2ajnIwA2x8pLKtNP
         7BwU0LWlqghJD1y1M29qMxkpewOjdmI0c03kNge6I4bts4AhaGB+mON2sakZkOuGhshX
         RHug==
X-Gm-Message-State: APjAAAUZJolO9150JZN1At0E6QrDHrDFHXeWsD3zIrr0BnyTAXh3nvan
        tigFd6pyfPZUQz7rPiPde37xmg==
X-Google-Smtp-Source: APXvYqx3gD+tgmqQ0cXfgo5BJssAjcZrG+1Efd6yRD2VM0Zt+ehTi79Qh6rI5YiRVN2mvUf/qxvjag==
X-Received: by 2002:ac8:6ed9:: with SMTP id f25mr17203741qtv.207.1570215164478;
        Fri, 04 Oct 2019 11:52:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:43 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 05/17] arm64: hibernate: remove gotos as they are not needed
Date:   Fri,  4 Oct 2019 14:52:22 -0400
Message-Id: <20191004185234.31471-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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

