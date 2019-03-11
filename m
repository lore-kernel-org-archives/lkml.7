Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD7C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akr6VVQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCKXLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:11:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52291 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCKXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:11:39 -0400
Received: by mail-it1-f196.google.com with SMTP id g17so1426277ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQ8xaS8h2fYbojq0arP/xyISP9DGV1Q5pEy67dnoLHk=;
        b=akr6VVQLAUmwWPCDyPKBcWtRHQZIYV9WsoybdAYHJbH+NDwLbiNiQo4XHeGBqkvmBJ
         jNk1sT0vRKf8UK6PB365SQdyjbNTP3GRUuj/ibF5+vhPJs8spEhOzRmkRM4FglLSPMCD
         1Ybm3rnhODYuK8hvtBH5dG/3DsfNx3MVPYtj0pHUnHWEYu67WJ5XgqbZfSu9ebme/TFN
         m7FoObLXHxl04LLHwFiL6oa1FdnTNOSFBtVLDeLNZnIx1Jf+N4uRAaEVSYUNX0jy9N/V
         UObR67/jDPGJ7SJwbu7/GRGt3nhgo8wN5Iqdojo/6GMqksr4Jzfl7N7ZAnBsSifN5+qw
         G7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQ8xaS8h2fYbojq0arP/xyISP9DGV1Q5pEy67dnoLHk=;
        b=Uy4mhAQJKZv/sEh+dhobV5jB2aLbUfLoiBp9qXdaOIXjppenIRmZi9JpQBsvQ9cu3f
         6CbQTEhAfRFWI2NbACGwr5Zu1XCnllGxA++oA+TEvmguNvGGbgyxB5AdxLP6jwHOSmUs
         Thh1nYNBUExnbgLcxtm9W1GIXUXmK0p94IG2W3fnl7jCcMmcRepWJoQLAZ+gBji63BNa
         0hFR+laLbE1EPglQriiYk02nGtbCGC7uVCn/gYULvQVZuUMrc+QiVKyMceY94JSFg5Tw
         9VlnqAykQYj1kPKq20NPb3WAz+Qqp+sNqtsRaa3tt4NpfNEpa5WLalGnCItv5BkkK2Y7
         C2dA==
X-Gm-Message-State: APjAAAVyyYFoVAgaZiYFK7JIsWHiSkQNfWSqd6euq0gwH7s5neuyyixR
        ylsRHfNfEctaS931UNr9sEMm7A==
X-Google-Smtp-Source: APXvYqwMcdqDIsHo+RT4qrhdUL6SBTvYE1XQYfNVhTWFiImkU6gfS1pNx9Cq0PRDj3KY9Jsf6Js3eQ==
X-Received: by 2002:a05:6638:398:: with SMTP id y24mr19937029jap.33.1552345898513;
        Mon, 11 Mar 2019 16:11:38 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id x24sm2849861ioa.50.2019.03.11.16.11.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 16:11:37 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:11:33 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
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
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] arm64: mm: enable per pmd page table lock
Message-ID: <20190311231133.GB207964@google.com>
References: <20190218231319.178224-1-yuzhao@google.com>
 <20190310011906.254635-1-yuzhao@google.com>
 <20190310011906.254635-3-yuzhao@google.com>
 <20190311121147.GA23361@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311121147.GA23361@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:12:28PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Sat, Mar 09, 2019 at 06:19:06PM -0700, Yu Zhao wrote:
> > Switch from per mm_struct to per pmd page table lock by enabling
> > ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> > large system.
> > 
> > I'm not sure if there is contention on mm->page_table_lock. Given
> > the option comes at no cost (apart from initializing more spin
> > locks), why not enable it now.
> > 
> > We only do so when pmd is not folded, so we don't mistakenly call
> > pgtable_pmd_page_ctor() on pud or p4d in pgd_pgtable_alloc(). (We
> > check shift against PMD_SHIFT, which is same as PUD_SHIFT when pmd
> > is folded).
> 
> Just to check, I take it pgtable_pmd_page_ctor() is now a NOP when the
> PMD is folded, and this last paragraph is stale?

Yes, and will remove it.

> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/Kconfig               |  3 +++
> >  arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
> >  arch/arm64/include/asm/tlb.h     |  5 ++++-
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index cfbf307d6dc4..a3b1b789f766 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
> >  config ARCH_HAS_CACHE_LINE_SIZE
> >  	def_bool y
> >  
> > +config ARCH_ENABLE_SPLIT_PMD_PTLOCK
> > +	def_bool y if PGTABLE_LEVELS > 2
> > +
> >  config SECCOMP
> >  	bool "Enable seccomp to safely compute untrusted bytecode"
> >  	---help---
> > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > index 52fa47c73bf0..dabba4b2c61f 100644
> > --- a/arch/arm64/include/asm/pgalloc.h
> > +++ b/arch/arm64/include/asm/pgalloc.h
> > @@ -33,12 +33,22 @@
> >  
> >  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  {
> > -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
> > +	struct page *page;
> > +
> > +	page = alloc_page(PGALLOC_GFP);
> > +	if (!page)
> > +		return NULL;
> > +	if (!pgtable_pmd_page_ctor(page)) {
> > +		__free_page(page);
> > +		return NULL;
> > +	}
> > +	return page_address(page);
> >  }
> >  
> >  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
> >  {
> >  	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
> > +	pgtable_pmd_page_dtor(virt_to_page(pmdp));
> >  	free_page((unsigned long)pmdp);
> >  }
> 
> It looks like arm64's existing stage-2 code is inconsistent across
> alloc/free, and IIUC this change might turn that into a real problem.
> Currently we allocate all levels of stage-2 table with
> __get_free_page(), but free them with p?d_free(). We always miss the
> ctor and always use the dtor.
> 
> Other than that, this patch looks fine to me, but I'd feel more
> comfortable if we could first fix the stage-2 code to free those stage-2
> tables without invoking the dtor.
> 
> Anshuman, IIRC you had a patch to fix the stage-2 code to not invoke the
> dtors. If so, could you please post that so that we could take it as a
> preparatory patch for this series?

Will do.

> Thanks,
> Mark.
> 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index 106fdc951b6e..4e3becfed387 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -62,7 +62,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> >  static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> >  				  unsigned long addr)
> >  {
> > -	tlb_remove_table(tlb, virt_to_page(pmdp));
> > +	struct page *page = virt_to_page(pmdp);
> > +
> > +	pgtable_pmd_page_dtor(page);
> > +	tlb_remove_table(tlb, page);
> >  }
> >  #endif
> >  
> > -- 
> > 2.21.0.360.g471c308f928-goog
> > 
