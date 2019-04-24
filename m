Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D042148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfDXIjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfDXIjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:39:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6A203082B02;
        Wed, 24 Apr 2019 08:39:04 +0000 (UTC)
Received: from xz-x1 (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A39FC5C239;
        Wed, 24 Apr 2019 08:38:52 +0000 (UTC)
Date:   Wed, 24 Apr 2019 16:38:49 +0800
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
Subject: Re: [PATCH v3 14/28] userfaultfd: wp: handle COW properly for uffd-wp
Message-ID: <20190424083849.GE2753@xz-x1>
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-15-peterx@redhat.com>
 <20190418202558.GK3288@redhat.com>
 <20190419062650.GF13323@xz-x1>
 <20190419150253.GA3311@redhat.com>
 <20190422122010.GA25896@xz-x1>
 <20190422145402.GB3450@redhat.com>
 <20190423030030.GA21301@xz-x1>
 <20190423153456.GA3288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423153456.GA3288@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Apr 2019 08:39:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:34:56AM -0400, Jerome Glisse wrote:
> On Tue, Apr 23, 2019 at 11:00:30AM +0800, Peter Xu wrote:
> > On Mon, Apr 22, 2019 at 10:54:02AM -0400, Jerome Glisse wrote:
> > > On Mon, Apr 22, 2019 at 08:20:10PM +0800, Peter Xu wrote:
> > > > On Fri, Apr 19, 2019 at 11:02:53AM -0400, Jerome Glisse wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > > +			if (uffd_wp_resolve) {
> > > > > > > > +				/* If the fault is resolved already, skip */
> > > > > > > > +				if (!pte_uffd_wp(*pte))
> > > > > > > > +					continue;
> > > > > > > > +				page = vm_normal_page(vma, addr, oldpte);
> > > > > > > > +				if (!page || page_mapcount(page) > 1) {
> > > > > > > > +					struct vm_fault vmf = {
> > > > > > > > +						.vma = vma,
> > > > > > > > +						.address = addr & PAGE_MASK,
> > > > > > > > +						.page = page,
> > > > > > > > +						.orig_pte = oldpte,
> > > > > > > > +						.pmd = pmd,
> > > > > > > > +						/* pte and ptl not needed */
> > > > > > > > +					};
> > > > > > > > +					vm_fault_t ret;
> > > > > > > > +
> > > > > > > > +					if (page)
> > > > > > > > +						get_page(page);
> > > > > > > > +					arch_leave_lazy_mmu_mode();
> > > > > > > > +					pte_unmap_unlock(pte, ptl);
> > > > > > > > +					ret = wp_page_copy(&vmf);
> > > > > > > > +					/* PTE is changed, or OOM */
> > > > > > > > +					if (ret == 0)
> > > > > > > > +						/* It's done by others */
> > > > > > > > +						continue;
> > > > > > > 
> > > > > > > This is wrong if ret == 0 you still need to remap the pte before
> > > > > > > continuing as otherwise you will go to next pte without the page
> > > > > > > table lock for the directory. So 0 case must be handled after
> > > > > > > arch_enter_lazy_mmu_mode() below.
> > > > > > > 
> > > > > > > Sorry i should have catch that in previous review.
> > > > > > 
> > > > > > My fault to not have noticed it since the very beginning... thanks for
> > > > > > spotting that.
> > > > > > 
> > > > > > I'm squashing below changes into the patch:
> > > > > 
> > > > > 
> > > > > Well thinking of this some more i think you should use do_wp_page() and
> > > > > not wp_page_copy() it would avoid bunch of code above and also you are
> > > > > not properly handling KSM page or page in the swap cache. Instead of
> > > > > duplicating same code that is in do_wp_page() it would be better to call
> > > > > it here.
> > > > 
> > > > Yeah it makes sense to me.  Then here's my plan:
> > > > 
> > > > - I'll need to drop previous patch "export wp_page_copy" since then
> > > >   it'll be not needed
> > > > 
> > > > - I'll introduce another patch to split current do_wp_page() and
> > > >   introduce function "wp_page_copy_cont" (better suggestion on the
> > > >   naming would be welcomed) which contains most of the wp handling
> > > >   that'll be needed for change_pte_range() in this patch and isolate
> > > >   the uffd handling:
> > > > 
> > > > static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > > > 	__releases(vmf->ptl)
> > > > {
> > > > 	struct vm_area_struct *vma = vmf->vma;
> > > > 
> > > > 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> > > > 		pte_unmap_unlock(vmf->pte, vmf->ptl);
> > > > 		return handle_userfault(vmf, VM_UFFD_WP);
> > > > 	}
> > > > 
> > > > 	return do_wp_page_cont(vmf);
> > > > }
> > > > 
> > > > Then I can probably use do_wp_page_cont() in this patch.
> > > 
> > > Instead i would keep the do_wp_page name and do:
> > >     static vm_fault_t do_userfaultfd_wp_page(struct vm_fault *vmf) {
> > >         ... // what you have above
> > >         return do_wp_page(vmf);
> > >     }
> > > 
> > > Naming wise i think it would be better to keep do_wp_page() as
> > > is.
> > 
> > In case I misunderstood... what I've proposed will be simply:
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 64bd8075f054..ab98a1eb4702 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2497,6 +2497,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >                 return handle_userfault(vmf, VM_UFFD_WP);
> >         }
> > 
> > +       return do_wp_page_cont(vmf);
> > +}
> > +
> > +vm_fault_t do_wp_page_cont(struct vm_fault *vmf)
> > +       __releases(vmf->ptl)
> > +{
> > +       struct vm_area_struct *vma = vmf->vma;
> > +
> >         vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
> >         if (!vmf->page) {
> >                 /*
> > 
> > And the other proposal is:
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 64bd8075f054..a73792127553 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2469,6 +2469,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
> >         return VM_FAULT_WRITE;
> >  }
> > 
> > +static vm_fault_t do_wp_page(struct vm_fault *vmf);
> > +
> >  /*
> >   * This routine handles present pages, when users try to write
> >   * to a shared page. It is done by copying the page to a new address
> > @@ -2487,7 +2489,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
> >   * but allow concurrent faults), with pte both mapped and locked.
> >   * We return with mmap_sem still held, but pte unmapped and unlocked.
> >   */
> > -static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > +static vm_fault_t do_userfaultfd_wp_page(struct vm_fault *vmf)
> >         __releases(vmf->ptl)
> >  {
> >         struct vm_area_struct *vma = vmf->vma;
> > @@ -2497,6 +2499,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >                 return handle_userfault(vmf, VM_UFFD_WP);
> >         }
> > 
> > +       return do_wp_page(vmf);
> > +}
> > +
> > +static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > +       __releases(vmf->ptl)
> > +{
> > +       struct vm_area_struct *vma = vmf->vma;
> > +
> >         vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
> >         if (!vmf->page) {
> >                 /*
> > @@ -2869,7 +2879,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         }
> > 
> >         if (vmf->flags & FAULT_FLAG_WRITE) {
> > -               ret |= do_wp_page(vmf);
> > +               ret |= do_userfaultfd_wp_page(vmf);
> >                 if (ret & VM_FAULT_ERROR)
> >                         ret &= VM_FAULT_ERROR;
> >                 goto out;
> > @@ -3831,7 +3841,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> >                 goto unlock;
> >         if (vmf->flags & FAULT_FLAG_WRITE) {
> >                 if (!pte_write(entry))
> > -                       return do_wp_page(vmf);
> > +                       return do_userfaultfd_wp_page(vmf);
> >                 entry = pte_mkdirty(entry);
> >         }
> >         entry = pte_mkyoung(entry);
> > 
> > I would prefer the 1st approach since it not only contains fewer lines
> > of changes because it does not touch callers, and also the naming in
> > the 2nd approach can be a bit confusing (calling
> > do_userfaultfd_wp_page in handle_pte_fault may let people think of an
> > userfault-only path but actually it covers the general path).  But if
> > you really like the 2nd one I can use that too.
> 
> Maybe move the userfaultfd code to a small helper, call it first in
> call site of do_wp_page() and do_wp_page() if it does not fire ie:
> 
> bool do_userfaultfd_wp(struct vm_fault *vmf, int ret)
> {
>     if (handleuserfault) return true;
>     return false;
> }
> 
> then
>      if (vmf->flags & FAULT_FLAG_WRITE) {
>             if (do_userfaultfd_wp(vmf, tmp)) {
>                 ret |= tmp;
>             } else
>                 ret |= do_wp_page(vmf);
>             if (ret & VM_FAULT_ERROR)
>                 ret &= VM_FAULT_ERROR;
>             goto out;
> 
> and:
>     if (vmf->flags & FAULT_FLAG_WRITE) {
>         if (!pte_write(entry)) {
>             if (do_userfaultfd_wp(vmf, ret))
>                 return ret;
>             else
>                 return do_wp_page(vmf);
>         }

But then we will be duplicating the code patterns somehow? :-/

I'll think them over...  Thanks for all these suggestions!

-- 
Peter Xu
