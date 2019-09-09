Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A3C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE2F21A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FR9ZOvxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405616AbfIISNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:13:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44500 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405441AbfIISMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so17261354qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OYSYAxR9hpjcZxR27XmKlk/hxg4B/TFu6EwLNmqRAmg=;
        b=FR9ZOvxr2M6JU0I0ESVpP8goPEO2UmoaLl2ohLEsDRHg5D7xJZa5nMLO+tcG3UUv4Q
         jPvfWNulGgDDc27S7kXLt2bHg+ic/qkdhFfb2DP74wjXMLc9OKoTccKcAahUE9txaXmV
         30GgZBWAuMC4So1j6YOC7DZbibOMN0eq4owflXxkWCwadz1DalcUZrzxgCjPYD0jHxQs
         es9oD6OLExQLw2Ws/5rPY8lc3uSTK6+Kg79ajtc2H9k84lYvQXckpdGWIW59Fd8haU4p
         eJCZr0BfUHS8W+UBiHc0V11uWuTUdts3IOmlnh3SZOiRnDhVgqgDkBy2qkb0OzzajmGf
         C/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYSYAxR9hpjcZxR27XmKlk/hxg4B/TFu6EwLNmqRAmg=;
        b=h7eaFgiA7dENWjEawMVRoCtsPna7v1XwrLcjjfRNDw+Eqh93BjlyOvp6STfnqZWpMX
         yhTT2npKKCK9fyaESoE76vGjQ04e7hMFXsdK5aQtK3Xy+4syGlag6yPPiNnts/6AKhxn
         oPN7wB8XQ/vk9flqJrh77MFvjwL0nKPYKXOi0YadxH1bKhUXHy3Mxr5c/QJWCqJJciU7
         dfd1xkw5X9EuBnHB2oYdX3V2zSldMEqMwlNQmULyxeAQJMAr20I57qTBW0xNL2nhp9h+
         /VYTueeW/inFtYA2zHLeHcoseNj7DtrJASdF+zSN5onDab7foVbFgDjEFt4Hyh0iIaia
         A9ng==
X-Gm-Message-State: APjAAAUBZU4a77K1G+OpDwCYI7O7jE8XDVpY00u6MW+Mt7SQHquOwmp4
        DWCHGL50fXYmOr1aOaVsovpPng==
X-Google-Smtp-Source: APXvYqxRp8Tm+1I0aK4a7ZcVOHt+wp8ZLS97ne6JzF/PZ76S2Ge0Fq0VNbDWF8RMRFleadWuQJy0BQ==
X-Received: by 2002:a05:6214:4c2:: with SMTP id ck2mr15101338qvb.21.1568052755478;
        Mon, 09 Sep 2019 11:12:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:34 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 08/17] arm64: hibernate: add trans_pgd public functions
Date:   Mon,  9 Sep 2019 14:12:12 -0400
Message-Id: <20190909181221.309510-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_pgd_create_copy() and trans_pgd_map_page() are going to be
the basis for new shared code that handles page tables for cases
which are between kernels: kexec, and hibernate.

Note: Eventually, get_safe_page() will be moved into a function pointer
passed via argument, but for now keep it as is.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 94 ++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index da2b3c5e94cb..178488a902c7 100644
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
+ * perform cache maintenance, then maps it at the specified address low
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

