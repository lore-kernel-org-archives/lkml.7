Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7F222DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Z9XdTfPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfHUScX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46374 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfHUScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id j15so4201315qtl.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zx3wi4rxE69hFoeINMbvlrOQdd3v0rMCcWlwgMe+7ro=;
        b=Z9XdTfPQsqrX+ihCr/4v6ItjEm2fTEBbeWz31i5BDIZiOLzaaHMtsuH2gtjkTF6ELA
         7yXqP1MI/fSXDCZ14zn/alA5HSSTPmUHomhmG+JDDkx1iLsTl7o/Iqcn9rPRE3VmTc/X
         /ox8ZTwPDgqdEsBMlW32tnbBoHwMhgBeTxLUP0uouGygQ/O3Fa5pNUVp9reQpI62FyCX
         R3eJo+7FXskAW2/gAKFmeWDiSo7F5wlSMNy8J29CwUOFu7Obx7iEVrbyGTfDJ4oC7JZx
         oOnvCDR8AxKmVTLp02PdeBuOzlYNu4WasPK9T7Aj8+N3bmKh30clQWsDfamV/Ov+aWlZ
         y0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zx3wi4rxE69hFoeINMbvlrOQdd3v0rMCcWlwgMe+7ro=;
        b=UNSixenfksBby+eYTpGe5zp5Mep4LwhczVxD1fd9h+1fA98LpUl7jXbvC3JN4sb9Zh
         FINDodRyuc28S2irds+2UPrJN15L2W2joyesDbnPDiTBnv9eDjaWHDGA5e1JrxDsziiq
         uthqHTaWyKzLlR/0sTZBWtKvKaiIFXCCQ7ap6qd2/pgSSCsjVhfevAYn+S8y/ccSuk6+
         BkDC9CfSMxiurrcUa5uuk++A2rV8umAOHoL2kdFCocfE2DNEssgaLJCr+Zltqv/0JBks
         LC3AFWuF/D4ogVaQCCv0C8TZdJT2EJqBRiE0LKqcqV1o++FvwnURlGCfRuqJvRNfxR3B
         m3gQ==
X-Gm-Message-State: APjAAAUh9wfXTK4BBjnABA17Hwc4DbGOfgHVMlxi2fZ3VE7FWNNHYuIn
        /04Doa9TnZqwlvDZ/gchndqRpw==
X-Google-Smtp-Source: APXvYqwWbwptxQVbDLDq/ThfodFBbNa157DjIxH5pnCxaJLPGWLsptjdu2SMPi7VujUE6fDJ2uoQLg==
X-Received: by 2002:ad4:45e3:: with SMTP id q3mr19092758qvu.140.1566412340641;
        Wed, 21 Aug 2019 11:32:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:20 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 10/17] arm64, trans_pgd: adjust trans_pgd_create_copy interface
Date:   Wed, 21 Aug 2019 14:31:57 -0400
Message-Id: <20190821183204.23576-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make trans_pgd_create_copy inline with the other functions in
trans_pgd: use the trans_pgd_info argument, and also use the
trans_pgd_create_empty.

Note, that the functions that are called by trans_pgd_create_copy are
not yet adjusted to be compliant with trans_pgd: they do not yet use
the provided allocator, do not check for generic errors, and do not yet
use the flags in info argument.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  7 ++++++-
 arch/arm64/kernel/hibernate.c      | 31 ++++++++++++++++++++++++++++--
 arch/arm64/mm/trans_pgd.c          | 17 ++++++----------
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 26e5a63676b5..f4a5f255d4a7 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -43,7 +43,12 @@ struct trans_pgd_info {
 /* Create and empty trans_pgd page table */
 int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd);
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+/*
+ * Create trans_pgd and copy entries from from_table to trans_pgd in range
+ * [start, end)
+ */
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  pgd_t *from_table, unsigned long start,
 			  unsigned long end);
 
 /*
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 8c2641a9bb09..8bb602e91065 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -323,15 +323,42 @@ int swsusp_arch_resume(void)
 	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+		/*
+		 * Resume will overwrite areas that may be marked read only
+		 * (code, rodata). Clear the RDONLY bit from the temporary
+		 * mappings we use during restore.
+		 */
+		.trans_flags		= TRANS_MKWRITE,
+	};
+
+	/*
+	 * debug_pagealloc will removed the PTE_VALID bit if the page isn't in
+	 * use by the resume kernel. It may have been in use by the original
+	 * kernel, in which case we need to put it back in our copy to do the
+	 * restore.
+	 *
+	 * Before marking this entry valid, check the pfn should be mapped.
+	 */
+	if (debug_pagealloc_enabled())
+		trans_info.trans_flags |= (TRANS_MKVALID | TRANS_CHECKPFN);
 
 	/*
 	 * Restoring the memory image will overwrite the ttbr1 page tables.
 	 * Create a second copy of just the linear map, and use this when
 	 * restoring.
 	 */
-	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
-	if (rc)
+	rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, init_mm.pgd,
+				   PAGE_OFFSET, 0);
+	if (rc) {
+		if (rc == -ENOMEM)
+			pr_err("Failed to allocate memory for temporary page tables.\n");
+		else if (rc == -ENXIO)
+			pr_err("Tried to set PTE for PFN that does not exist\n");
 		goto out;
+	}
 
 	/*
 	 * We need a zero page that is zero before & after resume in order to
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index ece797aa1841..7d8734709b61 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -176,22 +176,17 @@ int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd)
 	return 0;
 }
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  pgd_t *from_table, unsigned long start,
 			  unsigned long end)
 {
 	int rc;
-	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
 
-	if (!trans_pgd) {
-		pr_err("Failed to allocate memory for temporary page tables.\n");
-		return -ENOMEM;
-	}
-
-	rc = copy_page_tables(trans_pgd, start, end);
-	if (!rc)
-		*dst_pgdp = trans_pgd;
+	rc = trans_pgd_create_empty(info, trans_pgd);
+	if (rc)
+		return rc;
 
-	return rc;
+	return copy_page_tables(*trans_pgd, start, end);
 }
 
 int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
-- 
2.23.0

