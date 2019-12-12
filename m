Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC8C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4B722527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAdkof8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfLLSW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:22:59 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50834 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbfLLSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:22:58 -0500
Received: by mail-pl1-f201.google.com with SMTP id s4so399700plp.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IvHeRx1oBCh9J6TLvVWdv2Gb1z0rpMzGcWyY+BXVgxo=;
        b=MAdkof8C2KW30AALfnNJO3vr9VoF0vmBXanMXL/vR51qGyvIZkGihOmBNe+C0or/8I
         NpO/KCC3oEKNcwp7NIyw7WnD6H+rCsDvTI30S8NWdXPxMl0MDaFljsm9JXiaxGx8tZCO
         d4KLSyqgiZeCGiJqkepl0hPb47CUKa9ToIY3jibKjBu4kZUmg7uhITO9RyP7k+b0KyoU
         zEcEs3lkMbzHsbNJ2xA4Mv3lS6SzC0mJbsHZ2qOxVL621b4e0Gt/qvA+mGVTzX9rJKB5
         /8rQMuMbnVTaGER/Xvhr4PwqP6nQELiDlJ6qv20w9iVMpmIsQeJffxIkfXKhEXwrX/ah
         Gvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IvHeRx1oBCh9J6TLvVWdv2Gb1z0rpMzGcWyY+BXVgxo=;
        b=ucQIWSTzSLen/ukcfU+liZYhR5NT9X7F+ObKePvLdK3hONsbWI9nl9eFm00T3KRXqX
         yQI0BAvCd6ae8YJJNGjcUdnVkobLEA3+qagq2A4w2mMswY5hL9Ii4sn5CeN/i7Q+g6G0
         g1bKUGNFqd64gjc3I1gn8N96u7w1wObD8i934veEdrcjCyDHD/9E7/IBxgd68ONUZ5on
         vpsrNDC9one9nECozkvULARNBC/tBoeJKeg+0zMFsh2zMrSioIKxSupc8i0aSUngHeJ5
         SaU/9iO8EhGvVAYpu1GJYXvZiEkCghu4/9GW/MZTv1fgIQLY/4TrdttLDZJT/y0wFX54
         8TBA==
X-Gm-Message-State: APjAAAVFsCUaSm/9T9MyuOWzibFzth6omNTBNlykHMY5jv3bZsZ3cVsy
        6A3thNYTBRdn8v1FX9D1r8Ezw2iY
X-Google-Smtp-Source: APXvYqwVXoFFdqVc4oFKrnkNNIY1YlbI3lRBL8mXjnVcsOoBTjQ2NnV0mup2jeDoJ+6bSYWUQLoZOkJ/
X-Received: by 2002:a63:a508:: with SMTP id n8mr11683668pgf.278.1576174977297;
 Thu, 12 Dec 2019 10:22:57 -0800 (PST)
Date:   Thu, 12 Dec 2019 13:22:37 -0500
In-Reply-To: <20191212182238.46535-1-brho@google.com>
Message-Id: <20191212182238.46535-2-brho@google.com>
Mime-Version: 1.0
References: <20191212182238.46535-1-brho@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally visible
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM has a use case for determining the size of a dax mapping.

The KVM code has easy access to the address and the mm, and
dev_pagemap_mapping_shift() needs only those parameters.  It was
deriving them from page and vma.  This commit changes those parameters
from (page, vma) to (address, mm).

Signed-off-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2adf95b3f9c..bfd1882dd5c6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1013,6 +1013,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
 
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm);
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3151c87dff73..bafa464c8290 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -261,40 +261,6 @@ void shake_page(struct page *p, int access)
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
@@ -324,7 +290,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 	tk->addr = page_address_in_vma(p, vma);
 	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
+		tk->size_shift =
+			dev_pagemap_mapping_shift(vma_address(page, vma),
+						  vma->vm_mm);
 	else
 		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
diff --git a/mm/util.c b/mm/util.c
index 3ad6db9a722e..59984e6b40ab 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -901,3 +901,37 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	kunmap_atomic(addr1);
 	return ret;
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
2.24.0.525.g8f36a354ae-goog

