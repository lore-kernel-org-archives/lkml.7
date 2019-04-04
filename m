Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24091C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C120855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijTFYlRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfDDUYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:24:08 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51016 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfDDUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:24:05 -0400
Received: by mail-qk1-f202.google.com with SMTP id d8so3153604qkk.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bQ0sQyIId1gc5GI/6sG0i+XMj4HgpGtF7leH+EhLTRc=;
        b=ijTFYlRoW4d47hWxBRHQLu/ateNtiTcTZ+8xQ0HbOLuEwCH9dLLlDdCkYuyztCMp2o
         mXNiyTtABt6twjeB+s9nV2Kdw8ly+2WDriO4gnJLLcnKCqFMxb5ga5GT1835KhFx8SnY
         7qa/VMYbhRGXltNIg9YdtfqW4UaIs2gyv2C3qVSjTb0YTPr3kFtkrLulCjYuPj8L9Lfx
         Lht/51UA74SPfHmlvFZmQwVHKnwA7GBODxFpS4EfsmMiyDj7+oajwvNvXRGvJaMq+oSA
         tmn6M7u/c3vwhUIHuMggwT1WToIBTF4OXiUJ1xYG+jbhchiANICU0GXr5ku6Fyt+6048
         cXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bQ0sQyIId1gc5GI/6sG0i+XMj4HgpGtF7leH+EhLTRc=;
        b=f8YtcppxVtr6YuRtNvupYbSSVQDjQ8kB3Hth80SGo4FLYwBFyBsTz5zpqDPKjdqKat
         qHNx5MISIPQgHK2k/uBOUHk663o6Bf1yD6zmJOI87JGiYYiNd3S0IW3DD2OwqgFkE0cM
         9EZciTX5LBXv5WTHfbkWMO2qxHCSR9GufXJI+hax0r3Xd0tyzMldeRPJ8v+0PzPtAswk
         EhheQ4pXiJ7iVeiygdRfGiWVmfHv4Nh6Cu1YjWtFILv1vk/VCzclDajmeemGVk9JhFR5
         tSx+5piQgdOEEuOE6+SFy2To3iEBy648bQ8LT24kwnAKg2lotrtA6BjRcwRchqMeDJkz
         il8g==
X-Gm-Message-State: APjAAAXcXSeMI8O7ZydiNhNJaiEiYzpNaaHotFlb/jTyco8EIxFUY5c0
        bGmYLiIKd71WsXfpZhS4eVva91+O
X-Google-Smtp-Source: APXvYqweExkGubWO86xzjg+OVs3wkuGafcUO9nmeR10fv77Ltl1p85rnr+gCrj0y4oMZjzw64K7LVGog
X-Received: by 2002:ac8:2e7a:: with SMTP id s55mr1261618qta.34.1554409444323;
 Thu, 04 Apr 2019 13:24:04 -0700 (PDT)
Date:   Thu,  4 Apr 2019 16:23:43 -0400
In-Reply-To: <20190404202345.133553-1-brho@google.com>
Message-Id: <20190404202345.133553-2-brho@google.com>
Mime-Version: 1.0
References: <20190404202345.133553-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 1/3] mm: make dev_pagemap_mapping_shift() externally visible
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@intel.com,
        yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM has a use case for determining the size of a dax mapping.  The KVM
code has easy access to the address and the mm; hence the change in
parameters.

Signed-off-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fe52e266016e..c09e2f4c9bac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -963,6 +963,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm);
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc8b51744579..6779c163c4f4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -265,40 +265,6 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
-{
-	unsigned long address = vma_address(page, vma);
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset(vma->vm_mm, address);
-	if (!pgd_present(*pgd))
-		return 0;
-	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
-		return 0;
-	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
-		return 0;
-	if (pud_devmap(*pud))
-		return PUD_SHIFT;
-	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
-		return 0;
-	if (pmd_devmap(*pmd))
-		return PMD_SHIFT;
-	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		return 0;
-	if (pte_devmap(*pte))
-		return PAGE_SHIFT;
-	return 0;
-}
-
 /*
  * Failure handling: if we can't find or can't kill a process there's
  * not much we can do.	We just print a message and ignore otherwise.
@@ -329,7 +295,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	tk->addr = page_address_in_vma(p, vma);
 	tk->addr_valid = 1;
 	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
+		tk->size_shift =
+			dev_pagemap_mapping_shift(vma_address(page, vma),
+						  vma->vm_mm);
 	else
 		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
diff --git a/mm/util.c b/mm/util.c
index f94a1ac09cd8..24444e35a7ed 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -795,3 +795,37 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 out:
 	return res;
 }
+
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		return 0;
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return 0;
+	pud = pud_offset(p4d, address);
+	if (!pud_present(*pud))
+		return 0;
+	if (pud_devmap(*pud))
+		return PUD_SHIFT;
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(*pmd))
+		return 0;
+	if (pmd_devmap(*pmd))
+		return PMD_SHIFT;
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		return 0;
+	if (pte_devmap(*pte))
+		return PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
-- 
2.21.0.392.gf8f6787159e-goog

