Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BAC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964B21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KemMiArf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfHQCqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39993 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfHQCqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id e8so8202988qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K4mtuNsym73dHWEDL4hJM0gd2cT9s68JdquM/qnM6EE=;
        b=KemMiArfhB/bkmgPhLe269DxdJ2sfUaz9BBRBWeEwBei3UcHKilv5YTdxNIM4RiWZH
         Lom5gHj4hJWo1eaeNJD82dMK3k2fH0A5/ReY1tb8n89jgfH9sJymNlsHbUReswF741Ee
         D6XAyOB5PE3OJRfWPTXL7s49Q2cskfn/e6NkuL9zjzno9KVLjDTcc6sP7R0OOIkFKtit
         5jdvxdN8IjqB75e7PwasKxUnAxP2j8IdmYiNE7eLGhlFq1ZcUQLsE2Y/r6NPFy3Ajc1O
         HvoVAdk5fv0xOTZIGQZmY96Kd3bjixZ21+14XkaZMM1xQJg/N2IKZsH4DVlHDwJs6nP2
         PhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4mtuNsym73dHWEDL4hJM0gd2cT9s68JdquM/qnM6EE=;
        b=QiviixVgAAWthaNGmFOGbBOgDdywlrKD4aQ299el6KqVCa+pxK3Y7nGd5SSAwY1+SG
         xJg8W3MVTWpsUIrbFuPx25NLjOfVIcac5sGYaE50hax4xGiFDlCXb0hz0XyyA8SNqLzQ
         2vsVzEwkZgp0Sru1iiXcbuWDbLzmyGoS0PIQ38yFjg5CvK+niVu6Fohn/w0qxMKRSt48
         p0fvPQMhu4uCiz5fYfDtIczUeC/XGsU65PerMisfRa14eRX/SymzwkIz1NbAazU3FGUS
         0L2p/Gxjj9OtnGiGcJ2bfQWIoO7/LF27QSSJsUEg+n2/GkFFfoP1NmF3ftXMAEMKMCXB
         lWSQ==
X-Gm-Message-State: APjAAAVhJx74vZtXig+h4PBna3I611LefUwtr6TBrXHKaUaPRLyjzTXV
        FLozteWrs+s2t60xqyY2k46bRA==
X-Google-Smtp-Source: APXvYqwLah3JFnz5InFyJaEdMbrmW5wa4z0VC1v4yTqNJxq6j6zENAvViIR8vGnHzPMR31kzpHCCug==
X-Received: by 2002:a0c:ffc5:: with SMTP id h5mr3894666qvv.43.1566009994194;
        Fri, 16 Aug 2019 19:46:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:33 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 02/14] arm64, hibernate: create_safe_exec_page cleanup
Date:   Fri, 16 Aug 2019 22:46:17 -0400
Message-Id: <20190817024629.26611-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_safe_exec_page() is going to be split into two parts in preparation
of moving page table handling code out of hibernate.c

Remove allocator parameter, and rename dst to page. Also, remove the
goto's, as we can return directly without cleanups.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 60 +++++++++++++++--------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9341fcc6e809..96b6f8da7e49 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -196,57 +196,51 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
  */
 static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
-				 phys_addr_t *phys_dst_addr,
-				 void *(*allocator)(gfp_t mask),
-				 gfp_t mask)
+				 phys_addr_t *phys_dst_addr)
 {
-	int rc = 0;
+	void *page = (void *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_table;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	unsigned long dst = (unsigned long)allocator(mask);
 
-	if (!dst) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!page)
+		return -ENOMEM;
+
+	memcpy((void *)page, src_start, length);
+	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	memcpy((void *)dst, src_start, length);
-	__flush_icache_range(dst, dst + length);
+	trans_table = (void *)get_safe_page(GFP_ATOMIC);
+	if (!trans_table)
+		return -ENOMEM;
 
-	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
+	pgdp = pgd_offset_raw(trans_table, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = allocator(mask);
-		if (!pudp) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		pudp = (void *)get_safe_page(GFP_ATOMIC);
+		if (!pudp)
+			return -ENOMEM;
 		pgd_populate(&init_mm, pgdp, pudp);
 	}
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = allocator(mask);
-		if (!pmdp) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		pmdp = (void *)get_safe_page(GFP_ATOMIC);
+		if (!pmdp)
+			return -ENOMEM;
 		pud_populate(&init_mm, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = allocator(mask);
-		if (!ptep) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		ptep = (void *)get_safe_page(GFP_ATOMIC);
+		if (!ptep)
+			return -ENOMEM;
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(dst), PAGE_KERNEL_EXEC));
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
 
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
@@ -262,13 +256,12 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
+	write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);
 	isb();
 
-	*phys_dst_addr = virt_to_phys((void *)dst);
+	*phys_dst_addr = virt_to_phys((void *)page);
 
-out:
-	return rc;
+	return 0;
 }
 
 #define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
@@ -523,8 +516,7 @@ int swsusp_arch_resume(void)
 	 */
 	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
 				   (unsigned long)hibernate_exit,
-				   &phys_hibernate_exit,
-				   (void *)get_safe_page, GFP_ATOMIC);
+				   &phys_hibernate_exit);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
 		goto out;
-- 
2.22.1

