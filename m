Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6757C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666F02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBNdWh+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCLA6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:58:14 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:50271 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfCLA6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:58:10 -0400
Received: by mail-it1-f201.google.com with SMTP id i63so794609itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GuInaEquY9cKCo+/R3bLL1KFcpfX5BwU8EHfq1hu08M=;
        b=HBNdWh+/H/UQD3+xTCC5Gk1vTOFdi8buqG7IOzQCbqWRid+PcTT/T4iKPfX1Muy57H
         mA9gcEpPcKUv1DaJBopn5SU1wwyHnz+qqvQzVQiKuH4IuAZHw8WmPDHRTekZ4RoJuPoI
         k8fyIUxtuU7UBUmfFhSlmXIqDkwkNUo2QrkJLaPkIgWzkEwroQQwBNFou6cniBzdTUeU
         pguYiLIcrrFrKPeCm6lJ2yAvRHkaGHnYB9ACSfOKeP/GH7Q1zppaEI6Nk5aSRMS5Mt3C
         9GOsSCQ8e1rnKd9uYUOK1sUbi9ceU8L2Dtpr15+FePDmyFg81CK03OWXDcm0/xCUaK9T
         fuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GuInaEquY9cKCo+/R3bLL1KFcpfX5BwU8EHfq1hu08M=;
        b=LLYysdWezUU73jj5wOk3r5vCSPTaN58sDcHZ0OJAF7wM17JjwdxZOCf0rmAcuL4tQe
         RrrYEjaBhTi4Te9SNWaPAo7UCQGIF8ZJXzTe9nJfRouBSHaGm5eyzIoVYASQuFG8TYip
         hEGeWSLx+AAeCdAzXed6ViEKD1Y8wGs2NV39/2vIt9C7WdtnC1YOc/HOkth4QMCfuDjk
         D4LPWZFKtqooZzqB6vRaqrRkwDmcnzGrXXxf5t+dmrgrKKOOpLznOrFHUdy5zCmZvSbm
         9SBWW+1LYMNDIHuC7m6UwFMqY6AL8VwwU36hdFvlsjG/8YIrD8MOYMqZkSPLZ3xtnMiS
         5a+Q==
X-Gm-Message-State: APjAAAWOvtl7KbqWSIIjemOh6QtzOglPJ9mCmJ7CzZRWEZpGTPrFfrtm
        D8cJmBBCEy9aMHhooQkopDuZyIY3nr8=
X-Google-Smtp-Source: APXvYqxhul1R8mnVTm2ANYck/U0sQICDmCd8jsCIgw/3U8ahE12sg7YNMdshwxSVxfvSc2y++gz3qAvURMY=
X-Received: by 2002:a24:6b55:: with SMTP id v82mr545054itc.37.1552352288828;
 Mon, 11 Mar 2019 17:58:08 -0700 (PDT)
Date:   Mon, 11 Mar 2019 18:57:49 -0600
In-Reply-To: <20190312005749.30166-1-yuzhao@google.com>
Message-Id: <20190312005749.30166-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20190310011906.254635-1-yuzhao@google.com> <20190312005749.30166-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v4 4/4] arm64: mm: enable per pmd page table lock
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
pgtable_pmd_page_ctor() on pud or p4d in pgd_pgtable_alloc().

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

