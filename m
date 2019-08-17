Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A272AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F021019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="W88elMS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfHQCqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43679 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHQCqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so6317486qkd.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ekaKdccxVH9Vd+/E5UI//vE0AEA91U4VJzNQTwl8d/E=;
        b=W88elMS7kW8jg3EvlTR8TpaW28BxanfKAEZA1T8tCbXzGsz62pHn2DbtF/0gi1MvG6
         QnxWiMVsfkxQUm0Ae/FuzabuFMIch0uoq5Zhg7oba7ZeKDDAzmXRQ2n1IvGcQFjc8nYV
         m4/JkZyrt8pdX01FitiJJx0cPgVJ/FhH5Tu9IkA2IMuX557W2Y50K7mGgQhAzvNA1s7Q
         wWqVrMrxEqH7/ouO/0/KTzJm5DoKmotecr6ZDZVSYpvnvvHXAki018cukTq6oT85R9s1
         ylwJHOA8a1x0T03lSz9YDdycI4Gy2dKPQXITbseL26rSf0oItWq1y+PT+gj0RZzI1Xzc
         2brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekaKdccxVH9Vd+/E5UI//vE0AEA91U4VJzNQTwl8d/E=;
        b=mRn8/W5akkdEe4zKOPVM3lHN//ooaOXLg4JBVYkBt1LMHynssB2Bl+nLmeLD++Gb6D
         jVk1/4haOHPu2+PV0XTpMsUKyJRTrAz1ItIp43OwVsvlSD7yWLxxpHGe4CWb8AG4UXLh
         7sZlz29bCx9G9W25l5FHHcySQllEcVApR8VNaVyFOAJWp8b6gBz03Q2dvSZDhZR+KJy5
         QR+bnXDmyyM/46iDOjF51dUAp9zV5mg7086UqX5OZWi9R6b775o8Dwxka3s8EoeRgjkK
         vYl1wgm4tiaK/zitH5Kw98U4pqZ3QY3qZMTebWsYRW+NahT5vmUK9advIrXpQwKTOjHZ
         5vWA==
X-Gm-Message-State: APjAAAUFQTnVat2Uj9rY8aPX63Fqz7JO4RlegtaM6KrtVbZk7I+OFbLU
        DKIOpJ/eL8ZVeT9R7XNk5TY/MQ==
X-Google-Smtp-Source: APXvYqwwaSAihWvkXLVrmpYscesC91A5cT8+kN1NZAN7lWtU4GZ2OM1L0rSQkXGfKeYYArAeLuF39A==
X-Received: by 2002:a37:6905:: with SMTP id e5mr11456548qkc.121.1566010001248;
        Fri, 16 Aug 2019 19:46:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:40 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 07/14] arm64, trans_table: adjust trans_table_create_copy interface
Date:   Fri, 16 Aug 2019 22:46:22 -0400
Message-Id: <20190817024629.26611-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make trans_table_create_copy inline with the other functions in
trans_table: use the trans_table_info argument, and also use the
trans_table_create_empty.

Note, that the functions that are called by trans_table_create_copy are
not yet adjusted to be compliant with trans_table: they do not yet use
the provided allocator, do not check for generic errors, and do not yet
use the flags in info argument.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_table.h |  7 ++++++-
 arch/arm64/kernel/hibernate.c        | 31 ++++++++++++++++++++++++++--
 arch/arm64/mm/trans_table.c          | 17 ++++++---------
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/trans_table.h b/arch/arm64/include/asm/trans_table.h
index 02d3a0333dc9..8c296bd3e10f 100644
--- a/arch/arm64/include/asm/trans_table.h
+++ b/arch/arm64/include/asm/trans_table.h
@@ -44,7 +44,12 @@ struct trans_table_info {
 int trans_table_create_empty(struct trans_table_info *info,
 			     pgd_t **trans_table);
 
-int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
+/*
+ * Create trans table and copy entries from from_table to trans_table in range
+ * [start, end)
+ */
+int trans_table_create_copy(struct trans_table_info *info, pgd_t **trans_table,
+			    pgd_t *from_table, unsigned long start,
 			    unsigned long end);
 
 /*
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 3a7b362e5a58..6fbaff769c1d 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -323,15 +323,42 @@ int swsusp_arch_resume(void)
 	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
+	struct trans_table_info trans_info = {
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
-	rc = trans_table_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
-	if (rc)
+	rc = trans_table_create_copy(&trans_info, &tmp_pg_dir, init_mm.pgd,
+				     PAGE_OFFSET, 0);
+	if (rc) {
+		if (rc == -ENOMEM)
+			pr_err("Failed to allocate memory for temporary page tables.\n");
+		else if (rc == -ENXIO)
+			pr_err("Tried to set PTE for PFN that does not exist\n");
 		goto out;
+	}
 
 	/*
 	 * We need a zero page that is zero before & after resume in order to
diff --git a/arch/arm64/mm/trans_table.c b/arch/arm64/mm/trans_table.c
index 6deb35f83118..634293ffb54c 100644
--- a/arch/arm64/mm/trans_table.c
+++ b/arch/arm64/mm/trans_table.c
@@ -176,22 +176,17 @@ int trans_table_create_empty(struct trans_table_info *info, pgd_t **trans_table)
 	return 0;
 }
 
-int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
+int trans_table_create_copy(struct trans_table_info *info, pgd_t **trans_table,
+			    pgd_t *from_table, unsigned long start,
 			    unsigned long end)
 {
 	int rc;
-	pgd_t *trans_table = (pgd_t *)get_safe_page(GFP_ATOMIC);
 
-	if (!trans_table) {
-		pr_err("Failed to allocate memory for temporary page tables.\n");
-		return -ENOMEM;
-	}
-
-	rc = copy_page_tables(trans_table, start, end);
-	if (!rc)
-		*dst_pgdp = trans_table;
+	rc = trans_table_create_empty(info, trans_table);
+	if (rc)
+		return rc;
 
-	return rc;
+	return copy_page_tables(*trans_table, start, end);
 }
 
 int trans_table_map_page(struct trans_table_info *info, pgd_t *trans_table,
-- 
2.22.1

