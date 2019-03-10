Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66FAC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB85720815
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWYTqV2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCJBTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:19:12 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:50313 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfCJBTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 20:19:11 -0500
Received: by mail-io1-f74.google.com with SMTP id d7so1276179ios.17
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 17:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0N1MhcRbdixhLcojGjz1JbD9gYvKsU3sALAMDz5L+zQ=;
        b=EWYTqV2O2kn2zhIWcI3s1gmgxz1dXGxzOHPenWe89TDG4/8BxGz8vuObzzBtnXc8zn
         NjXgLS8HuTTvLpauBCevcESBrWxGSqM9g2cj56V1iqJmzZDUO9nPVoyciLxC6LzDzH3U
         UAbWy3JQJsk1VZSs7Nxw+1zz0XJAMe8cN4BhnZx3ojFoUW9IXD08xH/BzV3Tkwg0x1zk
         tnLSBiVVRYxYX+0fi4J0uoTiOugYrTudSji/00Whuzv81nFYtjnqB1W/h8Lc8kqO0L/m
         HU7+E5jphyonX4mohg03eaaVwiXnE+eC/FU8adSSlDYySBz4Y1BEqgHFtTl1zOHcicpu
         MlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0N1MhcRbdixhLcojGjz1JbD9gYvKsU3sALAMDz5L+zQ=;
        b=mBiaMC53kIa05sCV9r3/LZg8GJcZunHz3Gk4y2AJe62cLTb5MDa4yjwvCVX5zsrfAV
         ef3s2fYcsqPgBwa2a8+a6L+F6u5yoNM0kDQlrkNKfYCATGHO1XtUcbsE8sl/y7ar4kN/
         //QIMNVsNjMfLEiFWzX68Eb/vfB0/xfG9djnILTVq29EfhsfpLm4QtJqHEYcwcrPzcYR
         DmmNHOXktzRYhdVBy+udj8tnKSqOjf8+RxAEmGu/LKP0fhsR9zXgRgQMCxnzw3SIdAQg
         a+RjGZlDpWxdNNNMEiAMKHvDGNcLMqyMFQROJ9NDvwKmyUbfEGpLaNN4sN/dHQihflXR
         Q7uQ==
X-Gm-Message-State: APjAAAWJiTgHYc5a7O0z7sroSVwujXrnOYQM+3giX77xRz5bzJqnHJBy
        B0DBcMcSgEODWHvszoF1tsdHL+DiiO4=
X-Google-Smtp-Source: APXvYqxi62oUXl8WHRUPEaV20EFaBbDZc8udY7BAs1+oaagWSJIk8olRNZ0zRHkcRKgD12OX84VO25JPVVo=
X-Received: by 2002:a24:cd07:: with SMTP id l7mr17617268itg.22.1552180751250;
 Sat, 09 Mar 2019 17:19:11 -0800 (PST)
Date:   Sat,  9 Mar 2019 18:19:05 -0700
In-Reply-To: <20190310011906.254635-1-yuzhao@google.com>
Message-Id: <20190310011906.254635-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20190218231319.178224-1-yuzhao@google.com> <20190310011906.254635-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v3 2/3] arm64: mm: don't call page table ctors for init_mm
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_mm doesn't require page table lock to be initialized at
any level. Add a separate page table allocator for it, and the
new one skips page table ctors.

The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
calling them avoids memory leak in case we call pte_free_kernel()
on init_mm.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f704b291f2c5..d1dc2a2777aa 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
+static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
+{
+	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
+	BUG_ON(!ptr);
+
+	/* Ensure the zeroed page is visible to the page table walker */
+	dsb(ishst);
+	return __pa(ptr);
+}
+
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
@@ -594,7 +604,7 @@ static int __init map_entry_trampoline(void)
 	/* Map only the text into the trampoline page table */
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
-			     prot, pgd_pgtable_alloc, 0);
+			     prot, pgd_kernel_pgtable_alloc, 0);
 
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
@@ -1070,7 +1080,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
+			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
+			     flags);
 
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   altmap, want_memblock);
-- 
2.21.0.360.g471c308f928-goog

