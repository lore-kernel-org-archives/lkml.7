Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E866C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C937123407
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ely0YyNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHUSdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:33:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43647 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfHUScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so2700725qkd.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l9jb5hA6eaKuXSVI8MuzDGzTx7v+w9klZ86rwAA4Jng=;
        b=Ely0YyNlfELpzJkNLBZ6tCh+x2oZPduqEJbdpVAIdJjuBuZ08orXhqBK8kSTmdxpKG
         3DhtMv7MVjeszi4Dnka+2ElxeO+PS+sgWrevAX4mz+N5X2sl2s7GbTxwuBMR52am6Ojy
         82/8Q+k6laD4MuSNs8GPF1An4A3v9MHI1H4yCbMmWC84gBafL79RZK2j9rd5PTM0v74r
         M1hEiG4LF78WQ2K3WpFcJy8gAErAiipQywMBfToZybRQ0GDJ669w2EdaeClUA53RB31k
         xF9RHu/eKSxaRlaIoGq3rc+HpF/8oaXrYFymGvfhc9nQBTXS0w1U2m5disp/WDM6iSUz
         X+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9jb5hA6eaKuXSVI8MuzDGzTx7v+w9klZ86rwAA4Jng=;
        b=K8q1U1cWiCFlrpJ0hEUOB0n6rzMwBzp4oPNFyb0z/VVj8HCJqdTPlSHmVxTIWAeFZd
         VQa0e1hxjb/2fRR9QdLf2SSxeHJtxDHoZxhC6EaUv5hlV+/4gJtqA49hrqT8UStVAiEo
         cBCL6s15IOxEOqwB7A76WE+hLOzD3KN+avEb4dg3Cuoj6fOf6h04zClsT6+YHt+otkIJ
         xldbuW9GGP1OsCQ3Qp4ocqtERl1L+oIhJfAshsQPMSml+SFbEWPSTtwdGvSlZExghzdv
         olEuejqzEiUZ3h1FmHkFv6I61EQ4TDjcLDKELt4yKvSEfra5ByTBOGGtFeKFfDuqu36c
         9EKw==
X-Gm-Message-State: APjAAAVDvVBp5XwWAdhiN3HnkDeWyCvZLgVCn4tYDseAHlwY3XIpqI/p
        161ZRlPBnPwAsevBUdDGAeYKTw==
X-Google-Smtp-Source: APXvYqxHgQaRlOVWJntWhFo07vZ1dix4igEC9t2rWWF4x62J24SR4I+sL+DMV+HL8idyYAodMoxNUA==
X-Received: by 2002:a37:a9c6:: with SMTP id s189mr32305876qke.191.1566412334706;
        Wed, 21 Aug 2019 11:32:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:14 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 06/17] arm64, hibernate: add trans_pgd public functions
Date:   Wed, 21 Aug 2019 14:31:53 -0400
Message-Id: <20190821183204.23576-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_pgd_create_copy() and trans_pgd_map_page() are going to be
the basis for public interface of new subsystem that handles page
tables for cases which are between kernels: kexec, and hibernate.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 94 ++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 750ecc7f2cbe..2e29d620b56c 100644
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
+int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
+		       unsigned long dst_addr,
+		       pgprot_t pgprot)
 {
-	void *page = (void *)get_safe_page(GFP_ATOMIC);
-	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	if (!page)
-		return -ENOMEM;
-
-	memcpy(page, src_start, length);
-	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
-
-	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd)
-		return -ENOMEM;
-
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
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
+	pgd_t *trans_pgd;
+	int rc;
+
+	if (!page)
+		return -ENOMEM;
+
+	memcpy(page, src_start, length);
+	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
+
+	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
+	if (!trans_pgd)
+		return -ENOMEM;
+
+	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
+				PAGE_KERNEL_EXEC);
+	if (rc)
+		return rc;
+
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
 	 * ensure that TLBs are free of any entries that may overlap with the
@@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 	return 0;
 }
 
+int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+			  unsigned long end)
+{
+	int rc;
+	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
+
+	if (!trans_pgd) {
+		pr_err("Failed to allocate memory for temporary page tables.\n");
+		return -ENOMEM;
+	}
+
+	rc = copy_page_tables(trans_pgd, start, end);
+	if (!rc)
+		*dst_pgdp = trans_pgd;
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
+	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
 	if (rc)
 		goto out;
 
-- 
2.23.0

