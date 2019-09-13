Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE2AC4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F127E2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbfIMSF2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 14:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387471AbfIMSF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:05:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FEB5307CDFC;
        Fri, 13 Sep 2019 18:05:27 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4855F60600;
        Fri, 13 Sep 2019 18:05:27 +0000 (UTC)
Date:   Fri, 13 Sep 2019 12:05:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v2] vfio/type1: avoid redundant PageReserved checking
Message-ID: <20190913120526.363e7592@x1.home>
In-Reply-To: <5c9c57ba-ca5f-f080-3bb0-417a08788235@linux.alibaba.com>
References: <20190827124041.4f986005@x1.home>
        <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
        <20190828095501.12e71bd3@x1.home>
        <6c234632-b7e9-45c7-3d70-51a4c83161f6@linux.alibaba.com>
        <20190829110601.6dd74052@x1.home>
        <5c9c57ba-ca5f-f080-3bb0-417a08788235@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 13 Sep 2019 18:05:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2019 15:32:42 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> 在 2019/8/30 上午1:06, Alex Williamson 写道:
> > On Fri, 30 Aug 2019 00:58:22 +0800
> > Ben Luo <luoben@linux.alibaba.com> wrote:
> >  
> >> 在 2019/8/28 下午11:55, Alex Williamson 写道:  
> >>> On Wed, 28 Aug 2019 12:28:04 +0800
> >>> Ben Luo <luoben@linux.alibaba.com> wrote:
> >>>     
> >>>> currently, if the page is not a tail of compound page, it will be
> >>>> checked twice for the same thing.
> >>>>
> >>>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> >>>> ---
> >>>>    drivers/vfio/vfio_iommu_type1.c | 3 +--
> >>>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >>>> index 054391f..d0f7346 100644
> >>>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>>> @@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> >>>>    static bool is_invalid_reserved_pfn(unsigned long pfn)
> >>>>    {
> >>>>    	if (pfn_valid(pfn)) {
> >>>> -		bool reserved;
> >>>>    		struct page *tail = pfn_to_page(pfn);
> >>>>    		struct page *head = compound_head(tail);
> >>>> -		reserved = !!(PageReserved(head));
> >>>>    		if (head != tail) {
> >>>> +			bool reserved = PageReserved(head);
> >>>>    			/*
> >>>>    			 * "head" is not a dangling pointer
> >>>>    			 * (compound_head takes care of that)  
> >>> Thinking more about this, the code here was originally just a copy of
> >>> kvm_is_mmio_pfn() which was simplified in v3.12 with the commit below.
> >>> Should we instead do the same thing here?  Thanks,
> >>>
> >>> Alex  
> >> ok, and kvm_is_mmio_pfn() has also been updated since then, I will take
> >> a look at that and compose a new patch  
> > I'm not sure if the further updates are quite as relevant for vfio, but
> > appreciate your review of them.  Thanks,
> >
> > Alex  
> 
> After studying the related code, my personal understandings are:
> 
> kvm_is_mmio_pfn() is used to find out whether a memory range is MMIO 
> mapped so that to set
> the proper MTRR TYPE to spte.
> 
> is_invalid_reserved_pfn() is used in two scenarios:
>      1. to tell whether a page should be counted against user's mlock 
> limits, as the function's name
> implies, all 'invalid' PFNs who are not backed by struct page and those 
> reserved pages (including
> zero page and those from NVDIMM DAX) should be excluded.
> 2. to check if we have got a valid and pinned pfn for the vma 
> with VM_PFNMAP flag.
> 
> So, for the zero page and 'RAM' backed PFNs without 'struct page', 
> kvm_is_mmio_pfn() should
> return false because they are not MMIO and are cacheable, but 
> is_invalid_reserved_pfn() should
> return true since they are truely reserved or invalid and should not be 
> counted against user's
> mlock limits.
> 
> For fsdax-page, current get_user_pages() returns -EOPNOTSUPP, and VFIO 
> also returns this
> error code to user, seems not support fsdax for now, so there is no 
> chance to call into
> is_invalid_reserved_pfn() currently, if fsdax is to be supported, not 
> only this function needs to be
> updated, vaddr_get_pfn() also needs some changes.
> 
> Now, with the assumption that PFNs of compound pages with reserved bit 
> set in head will not be
> passed to is_invalid_reserved_pfn(), we can simplify this function to:
> 
> static bool is_invalid_reserved_pfn(unsigned long pfn)
> {
>          if (pfn_valid(pfn))
>                  return PageReserved(pfn_to_page(pfn));
> 
>          return true;
> }
> 
> But, I am not sure if the assumption above is true, if not, we still 
> need to check the reserved bit of
> head for a tail page as this PATCH v2 does.

I believe what you've described is correct.  Andrea, have we missed
anything?  Thanks,

Alex


> >  
> >>> commit 11feeb498086a3a5907b8148bdf1786a9b18fc55
> >>> Author: Andrea Arcangeli <aarcange@redhat.com>
> >>> Date:   Thu Jul 25 03:04:38 2013 +0200
> >>>
> >>>       kvm: optimize away THP checks in kvm_is_mmio_pfn()
> >>>       
> >>>       The checks on PG_reserved in the page structure on head and tail pages
> >>>       aren't necessary because split_huge_page wouldn't transfer the
> >>>       PG_reserved bit from head to tail anyway.
> >>>       
> >>>       This was a forward-thinking check done in the case PageReserved was
> >>>       set by a driver-owned page mapped in userland with something like
> >>>       remap_pfn_range in a VM_PFNMAP region, but using hugepmds (not
> >>>       possible right now). It was meant to be very safe, but it's overkill
> >>>       as it's unlikely split_huge_page could ever run without the driver
> >>>       noticing and tearing down the hugepage itself.
> >>>       
> >>>       And if a driver in the future will really want to map a reserved
> >>>       hugepage in userland using an huge pmd it should simply take care of
> >>>       marking all subpages reserved too to keep KVM safe. This of course
> >>>       would require such a hypothetical driver to tear down the huge pmd
> >>>       itself and splitting the hugepage itself, instead of relaying on
> >>>       split_huge_page, but that sounds very reasonable, especially
> >>>       considering split_huge_page wouldn't currently transfer the reserved
> >>>       bit anyway.
> >>>       
> >>>       Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> >>>       Signed-off-by: Gleb Natapov <gleb@redhat.com>
> >>>
> >>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >>> index d2836788561e..0fc25aed79a8 100644
> >>> --- a/virt/kvm/kvm_main.c
> >>> +++ b/virt/kvm/kvm_main.c
> >>> @@ -102,28 +102,8 @@ static bool largepages_enabled = true;
> >>>    
> >>>    bool kvm_is_mmio_pfn(pfn_t pfn)
> >>>    {
> >>> -       if (pfn_valid(pfn)) {
> >>> -               int reserved;
> >>> -               struct page *tail = pfn_to_page(pfn);
> >>> -               struct page *head = compound_trans_head(tail);
> >>> -               reserved = PageReserved(head);
> >>> -               if (head != tail) {
> >>> -                       /*
> >>> -                        * "head" is not a dangling pointer
> >>> -                        * (compound_trans_head takes care of that)
> >>> -                        * but the hugepage may have been splitted
> >>> -                        * from under us (and we may not hold a
> >>> -                        * reference count on the head page so it can
> >>> -                        * be reused before we run PageReferenced), so
> >>> -                        * we've to check PageTail before returning
> >>> -                        * what we just read.
> >>> -                        */
> >>> -                       smp_rmb();
> >>> -                       if (PageTail(tail))
> >>> -                               return reserved;
> >>> -               }
> >>> -               return PageReserved(tail);
> >>> -       }
> >>> +       if (pfn_valid(pfn))
> >>> +               return PageReserved(pfn_to_page(pfn));
> >>>    
> >>>           return true;
> >>>    }  

