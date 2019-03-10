Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A477C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED946206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ne3qu3Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCJBTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:19:15 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51260 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfCJBTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 20:19:14 -0500
Received: by mail-qt1-f202.google.com with SMTP id s8so1655581qth.18
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 17:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+4D1c6JWSWE8QT+yoi5CUv0ZKRIbRAhMzGEdnkssg9A=;
        b=ne3qu3FxuNnaxTHNaR0KvnSI+dxHillTroSbc2a23I9NeDzowB1PzvJmROLLgBDQkQ
         4isyzzDBrnqmSk42wEbalVZQRdtGPCAh3G/B2qqSQtX3/BY5STPBC/0sf8VymLZxZnqv
         TFyb/EiMA0LE7HOd2jjMWMn2DLhBGtYXdC/SxMBWDrB+9bVk7z2HS1cqhsOLbpOYAqnq
         EWEylhDMVOFJ8n8MACWSvz57cSQhFCTOFpDGhLPApw5kwjO/4JcLuQBWDIBdVRtBa8MN
         6AY17se4aFWkWszozRMszsYdPmcuPedaKhntA1DBHOnvx8MI+7RGhbs5ZQZ6UykgKoku
         kghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+4D1c6JWSWE8QT+yoi5CUv0ZKRIbRAhMzGEdnkssg9A=;
        b=UZ/Ntf93243UBI7Wb+VgL5nyncCneXQ6+PwxL95Cn7sM51P+G1aDo4NwmVqXAbMMrh
         pYySSdpXuJ9MBIMixDWqDosUoquf+2dJh7uYWsNLVxSUkDaPZYQcu4jNhl7/ttRNz+O9
         iF62AqUM/9FgbM+GTza7d8g6B8PuOfJ+6ttfzO39Gys48qUOJwGDOxtqQcuSsc1GcnSk
         S+YMab/ieTfCbWm6vElk+4tQGnGHx1cg/7T8LygD0rrkDK3mdad5avNnse+dBizAd46d
         Sj0C5psSvuAk9WWtkk/TXeQ/dgeX1kNshboekFEZJE294/Evaxmfe191Gz2wV3cT5/PV
         dLPw==
X-Gm-Message-State: APjAAAXKU5hBhR22oQPoabyGUAu3CbqBmDzpavJK/HNqA4hN3r0aAfgd
        tCRgIadcQzzSQF45MyiNlIrMBsNdd98=
X-Google-Smtp-Source: APXvYqzdCq/8JWJo7I6dgNrFQli0gtIFsccTph2MG2IS/kBQfoPBV4rNembCgH+TWILl3RUeNtEXGWzHp7A=
X-Received: by 2002:ac8:1997:: with SMTP id u23mr15120422qtj.11.1552180753103;
 Sat, 09 Mar 2019 17:19:13 -0800 (PST)
Date:   Sat,  9 Mar 2019 18:19:06 -0700
In-Reply-To: <20190310011906.254635-1-yuzhao@google.com>
Message-Id: <20190310011906.254635-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20190218231319.178224-1-yuzhao@google.com> <20190310011906.254635-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v3 3/3] arm64: mm: enable per pmd page table lock
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

Switch from per mm_struct to per pmd page table lock by enabling
ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
large system.

I'm not sure if there is contention on mm->page_table_lock. Given
the option comes at no cost (apart from initializing more spin
locks), why not enable it now.

We only do so when pmd is not folded, so we don't mistakenly call
pgtable_pmd_page_ctor() on pud or p4d in pgd_pgtable_alloc(). (We
check shift against PMD_SHIFT, which is same as PUD_SHIFT when pmd
is folded).

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 arch/arm64/include/asm/tlb.h     |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cfbf307d6dc4..a3b1b789f766 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y if PGTABLE_LEVELS > 2
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c73bf0..dabba4b2c61f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -33,12 +33,22 @@
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	struct page *page;
+
+	page = alloc_page(PGALLOC_GFP);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page_address(page);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
+	pgtable_pmd_page_dtor(virt_to_page(pmdp));
 	free_page((unsigned long)pmdp);
 }
 
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc951b6e..4e3becfed387 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pmdp));
+	struct page *page = virt_to_page(pmdp);
+
+	pgtable_pmd_page_dtor(page);
+	tlb_remove_table(tlb, page);
 }
 #endif
 
-- 
2.21.0.360.g471c308f928-goog

