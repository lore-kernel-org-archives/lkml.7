Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1121AC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD81720665
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pJNlYalm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGLMtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:49:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38447 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfGLMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:49:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so6268221qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1otLjh7Y2YNNBGtagKu/uUbBSlHY2oeN5f+/FpCKpM0=;
        b=pJNlYalmQY+ZfwKDrR3kVoZiL3wl49j/vXP5+9kQth7vz8xGZuO/2BfLXCAJqAtr9L
         HBxBcrtfzdn9lHATE7tsDzRFfvqTQfRj3y0OGL39BTq9asrZiM82YUP5o7ZH7UWyl3rM
         mOP99vzJj3B/uZVmdIKKhoncFjSiiSJO99AfzFED+sjHUUWQSH88eW/vcwgIzyYKFmai
         a7BvVls6q1lKmNV9UYZTx324yYF9jg8lqY7/a57HzPuxCUEEfSf7nMEIFSjvkG5GQ4B5
         c9EkY3FBRIVG/2mDE2UoPI0jpV2kWPXDpsJyd2MQE5eqkLRD3b+RMMUn8DDMtoncE65n
         dLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1otLjh7Y2YNNBGtagKu/uUbBSlHY2oeN5f+/FpCKpM0=;
        b=Txc7SbVcx2t3q4OjPXuMp7eLswy7XXiOiVoGNTxvzhxgBMGy/AdcJhF90xEUiDU0BZ
         d5GeUfO/bKw7YyoupM8+y9aERLk6MyvzNVrdLMl87CReFBHjso6p9MCMP2IdRmrQiVVm
         UIpii54wxLCwgNF6RWqD2483W1LixA0XTQ0H4SI5YSvp5RT/dTv3uNSO4puhEJTsJK5I
         vpXcvbKPGI4Er4IcfNoRxvSStbcGiW6EIHtHLzoU91YlBPEsjs+CVIJVDFt7U9UvxcBI
         9qV28h80H0NGWOe6zNsBwPDlsaIRS7a3VVsdr1bRRyf9wXB6WY7ygv2JgzuO8g9OEx8i
         qltA==
X-Gm-Message-State: APjAAAXohc1g4qKLgdKv4YtUL3fQ5P9m8SwGHjlFa8p3hm2Qa2DoHnC6
        oJv3g1rxXaDELZsn2DmkIeqRThsR6t7Png==
X-Google-Smtp-Source: APXvYqwqQ4ZSQLTIFDn8NDMApgTnMWwiaurAOlzFiHOr+uQJmEZoG3cOoZobfQ6sCmSECu9q6dRgCw==
X-Received: by 2002:a05:620a:1270:: with SMTP id b16mr5965708qkl.333.1562935750634;
        Fri, 12 Jul 2019 05:49:10 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h40sm4536993qth.4.2019.07.12.05.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 05:49:09 -0700 (PDT)
Message-ID: <1562935747.8510.26.camel@lca.pw>
Subject: Re: [patch 105/147] arm64: switch to generic version of pte
 allocation
From:   Qian Cai <cai@lca.pw>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, anton.ivanov@cambridgegreys.com,
        aou@eecs.berkeley.edu, arnd@arndb.de, catalin.marinas@arm.com,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        green.hu@gmail.com, guoren@kernel.org, gxt@pku.edu.cn,
        lftan@altera.com, linux@armlinux.org.uk, mattst88@gmail.com,
        mhocko@suse.com, mm-commits@vger.kernel.org, mpe@ellerman.id.au,
        palmer@sifive.com, paul.burton@mips.com, ralf@linux-mips.org,
        ren_guo@c-sky.com, richard@nod.at, rkuo@codeaurora.org,
        rppt@linux.ibm.com, sammy@sammy.net, torvalds@linux-foundation.org,
        willy@infradead.org
Date:   Fri, 12 Jul 2019 08:49:07 -0400
In-Reply-To: <20190712035802.eeH5anzpz%akpm@linux-foundation.org>
References: <20190712035802.eeH5anzpz%akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, this patch is slightly off. There is one delta need to apply (ignore
the part in pgtable.h which has already in mainline via the commit 615c48ad8f42
"arm64/mm: don't initialize pgd_cache twice") in.

https://lore.kernel.org/linux-mm/20190617151252.GF16810@rapoport-lnx/

On Thu, 2019-07-11 at 20:58 -0700, akpm@linux-foundation.org wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> Subject: arm64: switch to generic version of pte allocation
> 
> The PTE allocations in arm64 are identical to the generic ones modulo the
> GFP flags.
> 
> Using the generic pte_alloc_one() functions ensures that the user page
> tables are allocated with __GFP_ACCOUNT set.
> 
> The arm64 definition of PGALLOC_GFP is removed and replaced with
> GFP_PGTABLE_USER for p[gum]d_alloc_one() for the user page tables andpgtable.h
> 
> GFP_PGTABLE_KERNEL for the kernel page tables. The KVM memory cache is now
> using GFP_PGTABLE_USER.
> 
> The mappings created with create_pgd_mapping() are now using
> GFP_PGTABLE_KERNEL.
> 
> The conversion to the generic version of pte_free_kernel() removes the NULL
> check for pte.
> 
> The pte_free() version on arm64 is identical to the generic one and
> can be simply dropped.
> 
> [cai@lca.pw: fix a bogus GFP flag in pgd_alloc()]
>   Link: http://lkml.kernel.org/r/1559656836-24940-1-git-send-email-cai@lca.pw
> Link: http://lkml.kernel.org/r/1557296232-15361-5-git-send-email-rppt@linux.ib
> m.com
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Guo Ren <ren_guo@c-sky.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Sam Creasey <sammy@sammy.net>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm64/include/asm/pgalloc.h |   47 ++++-------------------------
>  arch/arm64/mm/mmu.c              |    2 -
>  arch/arm64/mm/pgd.c              |    9 ++++-
>  virt/kvm/arm/mmu.c               |    2 -
>  4 files changed, 17 insertions(+), 43 deletions(-)
> 
> --- a/arch/arm64/include/asm/pgalloc.h~arm64-switch-to-generic-version-of-pte-
> allocation
> +++ a/arch/arm64/include/asm/pgalloc.h
> @@ -13,18 +13,23 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  
> +#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
> +
>  #define check_pgt_cache()		do { } while (0)
>  
> -#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
>  #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
>  
>  #if CONFIG_PGTABLE_LEVELS > 2
>  
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> +	gfp_t gfp = GFP_PGTABLE_USER;
>  	struct page *page;
>  
> -	page = alloc_page(PGALLOC_GFP);
> +	if (mm == &init_mm)
> +		gfp = GFP_PGTABLE_KERNEL;
> +
> +	page = alloc_page(gfp);
>  	if (!page)
>  		return NULL;
>  	if (!pgtable_pmd_page_ctor(page)) {
> @@ -61,7 +66,7 @@ static inline void __pud_populate(pud_t
>  
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	return (pud_t *)__get_free_page(PGALLOC_GFP);
> +	return (pud_t *)__get_free_page(GFP_PGTABLE_USER);
>  }
>  
>  static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
> @@ -89,42 +94,6 @@ static inline void __pgd_populate(pgd_t
>  extern pgd_t *pgd_alloc(struct mm_struct *mm);
>  extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
>  
> -static inline pte_t *
> -pte_alloc_one_kernel(struct mm_struct *mm)
> -{
> -	return (pte_t *)__get_free_page(PGALLOC_GFP);
> -}
> -
> -static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm)
> -{
> -	struct page *pte;
> -
> -	pte = alloc_pages(PGALLOC_GFP, 0);
> -	if (!pte)
> -		return NULL;
> -	if (!pgtable_page_ctor(pte)) {
> -		__free_page(pte);
> -		return NULL;
> -	}
> -	return pte;
> -}
> -
> -/*
> - * Free a PTE table.
> - */
> -static inline void pte_free_kernel(struct mm_struct *mm, pte_t *ptep)
> -{
> -	if (ptep)
> -		free_page((unsigned long)ptep);
> -}
> -
> -static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
> -{
> -	pgtable_page_dtor(pte);
> -	__free_page(pte);
> -}
> -
>  static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
>  				  pmdval_t prot)
>  {
> --- a/arch/arm64/mm/mmu.c~arm64-switch-to-generic-version-of-pte-allocation
> +++ a/arch/arm64/mm/mmu.c
> @@ -362,7 +362,7 @@ static void __create_pgd_mapping(pgd_t *
>  
>  static phys_addr_t __pgd_pgtable_alloc(int shift)
>  {
> -	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> +	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
>  	BUG_ON(!ptr);
>  
>  	/* Ensure the zeroed page is visible to the page table walker */
> --- a/arch/arm64/mm/pgd.c~arm64-switch-to-generic-version-of-pte-allocation
> +++ a/arch/arm64/mm/pgd.c
> @@ -19,10 +19,15 @@ static struct kmem_cache *pgd_cache __ro
>  
>  pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> +	gfp_t gfp = GFP_PGTABLE_USER;
> +
> +	if (unlikely(mm == &init_mm))
> +		gfp = GFP_PGTABLE_KERNEL;
> +
>  	if (PGD_SIZE == PAGE_SIZE)
> -		return (pgd_t *)__get_free_page(PGALLOC_GFP);
> +		return (pgd_t *)__get_free_page(gfp);
>  	else
> -		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
> +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);
>  }
>  
>  void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> --- a/virt/kvm/arm/mmu.c~arm64-switch-to-generic-version-of-pte-allocation
> +++ a/virt/kvm/arm/mmu.c
> @@ -129,7 +129,7 @@ static int mmu_topup_memory_cache(struct
>  	if (cache->nobjs >= min)
>  		return 0;
>  	while (cache->nobjs < max) {
> -		page = (void *)__get_free_page(PGALLOC_GFP);
> +		page = (void *)__get_free_page(GFP_PGTABLE_USER);
>  		if (!page)
>  			return -ENOMEM;
>  		cache->objects[cache->nobjs++] = page;
> _
