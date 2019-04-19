Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF0FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23460222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfDSSSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfDSSSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AF9C83F3A;
        Fri, 19 Apr 2019 07:42:40 +0000 (UTC)
Received: from xz-x1 (ovpn-12-224.pek2.redhat.com [10.72.12.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8794D19C65;
        Fri, 19 Apr 2019 07:42:27 +0000 (UTC)
Date:   Fri, 19 Apr 2019 15:42:20 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 17/28] userfaultfd: wp: support swap and page migration
Message-ID: <20190419074220.GG13323@xz-x1>
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-18-peterx@redhat.com>
 <20190418205907.GL3288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418205907.GL3288@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Apr 2019 07:42:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 04:59:07PM -0400, Jerome Glisse wrote:
> On Wed, Mar 20, 2019 at 10:06:31AM +0800, Peter Xu wrote:
> > For either swap and page migration, we all use the bit 2 of the entry to
> > identify whether this entry is uffd write-protected.  It plays a similar
> > role as the existing soft dirty bit in swap entries but only for keeping
> > the uffd-wp tracking for a specific PTE/PMD.
> > 
> > Something special here is that when we want to recover the uffd-wp bit
> > from a swap/migration entry to the PTE bit we'll also need to take care
> > of the _PAGE_RW bit and make sure it's cleared, otherwise even with the
> > _PAGE_UFFD_WP bit we can't trap it at all.
> > 
> > Note that this patch removed two lines from "userfaultfd: wp: hook
> > userfault handler to write protection fault" where we try to remove the
> > VM_FAULT_WRITE from vmf->flags when uffd-wp is set for the VMA.  This
> > patch will still keep the write flag there.
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Some missing thing see below.
> 
> [...]
> 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6405d56debee..c3d57fa890f2 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -736,6 +736,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  				pte = swp_entry_to_pte(entry);
> >  				if (pte_swp_soft_dirty(*src_pte))
> >  					pte = pte_swp_mksoft_dirty(pte);
> > +				if (pte_swp_uffd_wp(*src_pte))
> > +					pte = pte_swp_mkuffd_wp(pte);
> >  				set_pte_at(src_mm, addr, src_pte, pte);
> >  			}
> >  		} else if (is_device_private_entry(entry)) {
> 
> You need to handle the is_device_private_entry() as the migration case
> too.

Hi, Jerome,

Yes I can simply add the handling, but I'd confess I haven't thought
clearly yet on how userfault-wp will be used with HMM (and that's
mostly because my unfamiliarity so far with HMM).  Could you give me
some hint on a most general and possible scenario?

> 
> 
> 
> > @@ -2825,6 +2827,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  	flush_icache_page(vma, page);
> >  	if (pte_swp_soft_dirty(vmf->orig_pte))
> >  		pte = pte_mksoft_dirty(pte);
> > +	if (pte_swp_uffd_wp(vmf->orig_pte)) {
> > +		pte = pte_mkuffd_wp(pte);
> > +		pte = pte_wrprotect(pte);
> > +	}
> >  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> >  	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> >  	vmf->orig_pte = pte;
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 181f5d2718a9..72cde187d4a1 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -241,6 +241,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
> >  		entry = pte_to_swp_entry(*pvmw.pte);
> >  		if (is_write_migration_entry(entry))
> >  			pte = maybe_mkwrite(pte, vma);
> > +		else if (pte_swp_uffd_wp(*pvmw.pte))
> > +			pte = pte_mkuffd_wp(pte);
> >  
> >  		if (unlikely(is_zone_device_page(new))) {
> >  			if (is_device_private_page(new)) {
> 
> You need to handle is_device_private_page() case ie mark its swap
> as uffd_wp

Yes I can do this too.

> 
> > @@ -2301,6 +2303,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >  			swp_pte = swp_entry_to_pte(entry);
> >  			if (pte_soft_dirty(pte))
> >  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> > +			if (pte_uffd_wp(pte))
> > +				swp_pte = pte_swp_mkuffd_wp(swp_pte);
> >  			set_pte_at(mm, addr, ptep, swp_pte);
> >
> >  			/*
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 855dddb07ff2..96c0f521099d 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -196,6 +196,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >  				newpte = swp_entry_to_pte(entry);
> >  				if (pte_swp_soft_dirty(oldpte))
> >  					newpte = pte_swp_mksoft_dirty(newpte);
> > +				if (pte_swp_uffd_wp(oldpte))
> > +					newpte = pte_swp_mkuffd_wp(newpte);
> >  				set_pte_at(mm, addr, pte, newpte);
> >  
> >  				pages++;
> 
> Need to handle is_write_device_private_entry() case just below
> that chunk.

This one is a bit special - because it's not only the private entries
that are missing but also all swap/migration entries, which is
explicitly handled by patch 25.  But I think I can just squash it into
this patch as you suggested.

Thanks,

-- 
Peter Xu
