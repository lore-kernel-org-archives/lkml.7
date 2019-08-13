Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AAA20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtwUJ1g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfHMRXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:23:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36097 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfHMRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:23:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so1160036pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=if9i7zh0Qit/yKhgw7AU3xUn9wMFS6+DPvFYQ9IzgUM=;
        b=VtwUJ1g07ZQGByWFKuFyL++/c5nvno1F4aqLKJsYQmfBbQ5MTGe71PomB52/lhGyX8
         uFNnn55FnmpYekD06mwP82wA498ldCCstGkbdaamkBCd03VpR1Cdf2g9o8C8AXT+lK7Z
         KUOTBBk75tdbOXLAxSmE6tNsIAiAQzMozIj7Z/sRUFBSmEPytowcgm7Cd5wsbJtckLvU
         rgOGzjR2hjix3JREkZz33D+kHPb8P1RCjZ2aWsn2x+8x8s6ABhsu7kssG9ScCIDr9Xlr
         34Ox28ouhz+EwKjuBgKJ6btSZssQtWmp/y4Qmguw5rovtIF0DD/I4NiGpogBjG0bDnzA
         Y1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=if9i7zh0Qit/yKhgw7AU3xUn9wMFS6+DPvFYQ9IzgUM=;
        b=J/DR+70OonQeLi2q7iMcDRcZIhCiEHrg4bnz/u781arNdPWzFDTe3waA6KfahefH0t
         W3g/E/6Fnw+RlKWBqFmgggLFc4Cgl96Z5BJYivXb2KpktVwDgCReId9zhl0DSBLIT6oA
         eWnylVLYAZt3PFT4IswrxHggC65sE1MF7UbVoG79di6YzsGRhKTWGZgOFS3A5LL2koJA
         EtQ4BtDEZYfhaRzsEk6dLeVfap2VZjXYSCpdMjQXbGmFEpNrBlXI1m82mamyHqLs5biU
         1crgxgpE97NvOH4lU1PS9kXaj6luozMW2Nnd0LdppVYYPqYUVn0KV3hF40PMBm1jwJP+
         2SEQ==
X-Gm-Message-State: APjAAAUCYgs8YVBCY9t6HMFo/huzyODnmGiyRNxrRx5x2A0iykybC1lQ
        ACyKJ7fhaydvGX4hAvCEu7I=
X-Google-Smtp-Source: APXvYqwn4i2MuuhDE5aBojeK0YnwZSTVlstqtU4zNM2IkkD6QM4+wPBwPpEmI9B/lSG2uWedifx5Xg==
X-Received: by 2002:a17:90a:71ca:: with SMTP id m10mr3264191pjs.27.1565716992214;
        Tue, 13 Aug 2019 10:23:12 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id 203sm15071517pfz.107.2019.08.13.10.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 10:23:11 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:53:01 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     jhubbard@nvidia.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v5 1/1] sgi-gru: Remove *pte_lookup
 functions, Convert to get_user_page*()
Message-ID: <20190813172301.GA10228@bharath12345-Inspiron-5559>
References: <1565379497-29266-1-git-send-email-linux.bhar@gmail.com>
 <1565379497-29266-2-git-send-email-linux.bhar@gmail.com>
 <20190813145029.GA32451@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813145029.GA32451@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:50:29AM -0500, Dimitri Sivanich wrote:
> Bharath,
> 
> I do not believe that __get_user_pages_fast will work for the atomic case, as
> there is no guarantee that the 'current->mm' will be the correct one for the
> process in question, as the process might have moved away from the cpu that is
> handling interrupts for it's context.
So what your saying is, there may be cases where current->mm != gts->ts_mm
right? __get_user_pages_fast and get_user_pages do assume current->mm.

These changes were inspired a bit from kvm. In kvm/kvm_main.c,
hva_to_pfn_fast uses __get_user_pages_fast. THe comment above the
function states it runs in atomic context.

Just curious, get_user_pages also uses current->mm. Do you think that is
also an issue? 

Do you feel using get_user_pages_remote would be a better idea? We can
specify the mm_struct in get_user_pages_remote?

Thank you
Bharath
> On Sat, Aug 10, 2019 at 01:08:17AM +0530, Bharath Vedartham wrote:
> > For pages that were retained via get_user_pages*(), release those pages
> > via the new put_user_page*() routines, instead of via put_page() or
> > release_pages().
> > 
> > This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> > ("mm: introduce put_user_page*(), placeholder versions").
> > 
> > As part of this conversion, the *pte_lookup functions can be removed and
> > be easily replaced with get_user_pages_fast() functions. In the case of
> > atomic lookup, __get_user_pages_fast() is used, because it does not fall
> > back to the slow path: get_user_pages(). get_user_pages_fast(), on the other
> > hand, first calls __get_user_pages_fast(), but then falls back to the
> > slow path if __get_user_pages_fast() fails.
> > 
> > Also: remove unnecessary CONFIG_HUGETLB ifdefs.
> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Dimitri Sivanich <sivanich@sgi.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel-mentees@lists.linuxfoundation.org
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> > This is a fold of the 3 patches in the v2 patch series.
> > The review tags were given to the individual patches.
> > 
> > Changes since v3
> > 	- Used gup flags in get_user_pages_fast rather than
> > 	boolean flags.
> > Changes since v4
> > 	- Updated changelog according to John Hubbard.
> > ---
> >  drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
> >  1 file changed, 24 insertions(+), 88 deletions(-)
> > 
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> > index 4b713a8..304e9c5 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -166,96 +166,20 @@ static void get_clear_fault_map(struct gru_state *gru,
> >  }
> >  
> >  /*
> > - * Atomic (interrupt context) & non-atomic (user context) functions to
> > - * convert a vaddr into a physical address. The size of the page
> > - * is returned in pageshift.
> > - * 	returns:
> > - * 		  0 - successful
> > - * 		< 0 - error code
> > - * 		  1 - (atomic only) try again in non-atomic context
> > - */
> > -static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> > -				 unsigned long vaddr, int write,
> > -				 unsigned long *paddr, int *pageshift)
> > -{
> > -	struct page *page;
> > -
> > -#ifdef CONFIG_HUGETLB_PAGE
> > -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > -#else
> > -	*pageshift = PAGE_SHIFT;
> > -#endif
> > -	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
> > -		return -EFAULT;
> > -	*paddr = page_to_phys(page);
> > -	put_page(page);
> > -	return 0;
> > -}
> > -
> > -/*
> > - * atomic_pte_lookup
> > + * mmap_sem is already helod on entry to this function. This guarantees
> > + * existence of the page tables.
> >   *
> > - * Convert a user virtual address to a physical address
> >   * Only supports Intel large pages (2MB only) on x86_64.
> > - *	ZZZ - hugepage support is incomplete
> > - *
> > - * NOTE: mmap_sem is already held on entry to this function. This
> > - * guarantees existence of the page tables.
> > + *	ZZZ - hugepage support is incomplete.
> >   */
> > -static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
> > -	int write, unsigned long *paddr, int *pageshift)
> > -{
> > -	pgd_t *pgdp;
> > -	p4d_t *p4dp;
> > -	pud_t *pudp;
> > -	pmd_t *pmdp;
> > -	pte_t pte;
> > -
> > -	pgdp = pgd_offset(vma->vm_mm, vaddr);
> > -	if (unlikely(pgd_none(*pgdp)))
> > -		goto err;
> > -
> > -	p4dp = p4d_offset(pgdp, vaddr);
> > -	if (unlikely(p4d_none(*p4dp)))
> > -		goto err;
> > -
> > -	pudp = pud_offset(p4dp, vaddr);
> > -	if (unlikely(pud_none(*pudp)))
> > -		goto err;
> > -
> > -	pmdp = pmd_offset(pudp, vaddr);
> > -	if (unlikely(pmd_none(*pmdp)))
> > -		goto err;
> > -#ifdef CONFIG_X86_64
> > -	if (unlikely(pmd_large(*pmdp)))
> > -		pte = *(pte_t *) pmdp;
> > -	else
> > -#endif
> > -		pte = *pte_offset_kernel(pmdp, vaddr);
> > -
> > -	if (unlikely(!pte_present(pte) ||
> > -		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
> > -		return 1;
> > -
> > -	*paddr = pte_pfn(pte) << PAGE_SHIFT;
> > -#ifdef CONFIG_HUGETLB_PAGE
> > -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > -#else
> > -	*pageshift = PAGE_SHIFT;
> > -#endif
> > -	return 0;
> > -
> > -err:
> > -	return 1;
> > -}
> > -
> >  static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
> >  		    int write, int atomic, unsigned long *gpa, int *pageshift)
> >  {
> >  	struct mm_struct *mm = gts->ts_mm;
> >  	struct vm_area_struct *vma;
> >  	unsigned long paddr;
> > -	int ret, ps;
> > +	int ret;
> > +	struct page *page;
> >  
> >  	vma = find_vma(mm, vaddr);
> >  	if (!vma)
> > @@ -263,21 +187,33 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
> >  
> >  	/*
> >  	 * Atomic lookup is faster & usually works even if called in non-atomic
> > -	 * context.
> > +	 * context. get_user_pages_fast does atomic lookup before falling back to
> > +	 * slow gup.
> >  	 */
> >  	rmb();	/* Must/check ms_range_active before loading PTEs */
> > -	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
> > -	if (ret) {
> > -		if (atomic)
> > +	if (atomic) {
> > +		ret = __get_user_pages_fast(vaddr, 1, write, &page);
> > +		if (!ret)
> >  			goto upm;
> > -		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
> > +	} else {
> > +		ret = get_user_pages_fast(vaddr, 1, write ? FOLL_WRITE : 0, &page);
> > +		if (!ret)
> >  			goto inval;
> >  	}
> > +
> > +	paddr = page_to_phys(page);
> > +	put_user_page(page);
> > +
> > +	if (unlikely(is_vm_hugetlb_page(vma)))
> > +		*pageshift = HPAGE_SHIFT;
> > +	else
> > +		*pageshift = PAGE_SHIFT;
> > +
> >  	if (is_gru_paddr(paddr))
> >  		goto inval;
> > -	paddr = paddr & ~((1UL << ps) - 1);
> > +	paddr = paddr & ~((1UL << *pageshift) - 1);
> >  	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> > -	*pageshift = ps;
> > +
> >  	return VTOP_SUCCESS;
> >  
> >  inval:
> > -- 
> > 2.7.4
> > 
