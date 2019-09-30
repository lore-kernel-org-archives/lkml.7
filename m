Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7025C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B091C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfI3Xfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfI3Xfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96E8D300C22E;
        Mon, 30 Sep 2019 23:35:41 +0000 (UTC)
Received: from mail (ovpn-125-159.rdu2.redhat.com [10.10.125.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE71D10013A1;
        Mon, 30 Sep 2019 23:35:38 +0000 (UTC)
Date:   Mon, 30 Sep 2019 19:35:38 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Ben Luo <luoben@linux.alibaba.com>, cohuck@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio/type1: avoid redundant PageReserved checking
Message-ID: <20190930233538.GA13922@redhat.com>
References: <20190827124041.4f986005@x1.home>
 <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
 <20190828095501.12e71bd3@x1.home>
 <6c234632-b7e9-45c7-3d70-51a4c83161f6@linux.alibaba.com>
 <20190829110601.6dd74052@x1.home>
 <5c9c57ba-ca5f-f080-3bb0-417a08788235@linux.alibaba.com>
 <20190913120526.363e7592@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913120526.363e7592@x1.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 30 Sep 2019 23:35:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 13, 2019 at 12:05:26PM -0600, Alex Williamson wrote:
> On Mon, 2 Sep 2019 15:32:42 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
> 
> > 在 2019/8/30 上午1:06, Alex Williamson 写道:
> > > On Fri, 30 Aug 2019 00:58:22 +0800
> > > Ben Luo <luoben@linux.alibaba.com> wrote:
> > >  
> > >> 在 2019/8/28 下午11:55, Alex Williamson 写道:  
> > >>> On Wed, 28 Aug 2019 12:28:04 +0800
> > >>> Ben Luo <luoben@linux.alibaba.com> wrote:
> > >>>     
> > >>>> currently, if the page is not a tail of compound page, it will be
> > >>>> checked twice for the same thing.
> > >>>>
> > >>>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> > >>>> ---
> > >>>>    drivers/vfio/vfio_iommu_type1.c | 3 +--
> > >>>>    1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > >>>> index 054391f..d0f7346 100644
> > >>>> --- a/drivers/vfio/vfio_iommu_type1.c
> > >>>> +++ b/drivers/vfio/vfio_iommu_type1.c
> > >>>> @@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> > >>>>    static bool is_invalid_reserved_pfn(unsigned long pfn)
> > >>>>    {
> > >>>>    	if (pfn_valid(pfn)) {
> > >>>> -		bool reserved;
> > >>>>    		struct page *tail = pfn_to_page(pfn);
> > >>>>    		struct page *head = compound_head(tail);
> > >>>> -		reserved = !!(PageReserved(head));
> > >>>>    		if (head != tail) {
> > >>>> +			bool reserved = PageReserved(head);
> > >>>>    			/*
> > >>>>    			 * "head" is not a dangling pointer
> > >>>>    			 * (compound_head takes care of that)  
> > >>> Thinking more about this, the code here was originally just a copy of
> > >>> kvm_is_mmio_pfn() which was simplified in v3.12 with the commit below.
> > >>> Should we instead do the same thing here?  Thanks,
> > >>>
> > >>> Alex  
> > >> ok, and kvm_is_mmio_pfn() has also been updated since then, I will take
> > >> a look at that and compose a new patch  
> > > I'm not sure if the further updates are quite as relevant for vfio, but
> > > appreciate your review of them.  Thanks,
> > >
> > > Alex  
> > 
> > After studying the related code, my personal understandings are:
> > 
> > kvm_is_mmio_pfn() is used to find out whether a memory range is MMIO 
> > mapped so that to set
> > the proper MTRR TYPE to spte.
> > 
> > is_invalid_reserved_pfn() is used in two scenarios:
> >      1. to tell whether a page should be counted against user's mlock 
> > limits, as the function's name
> > implies, all 'invalid' PFNs who are not backed by struct page and those 
> > reserved pages (including
> > zero page and those from NVDIMM DAX) should be excluded.
> > 2. to check if we have got a valid and pinned pfn for the vma 
> > with VM_PFNMAP flag.
> > 
> > So, for the zero page and 'RAM' backed PFNs without 'struct page', 
> > kvm_is_mmio_pfn() should
> > return false because they are not MMIO and are cacheable, but 
> > is_invalid_reserved_pfn() should
> > return true since they are truely reserved or invalid and should not be 
> > counted against user's
> > mlock limits.
> > 
> > For fsdax-page, current get_user_pages() returns -EOPNOTSUPP, and VFIO 
> > also returns this
> > error code to user, seems not support fsdax for now, so there is no 
> > chance to call into
> > is_invalid_reserved_pfn() currently, if fsdax is to be supported, not 
> > only this function needs to be
> > updated, vaddr_get_pfn() also needs some changes.
> > 
> > Now, with the assumption that PFNs of compound pages with reserved bit 
> > set in head will not be
> > passed to is_invalid_reserved_pfn(), we can simplify this function to:
> > 
> > static bool is_invalid_reserved_pfn(unsigned long pfn)
> > {
> >          if (pfn_valid(pfn))
> >                  return PageReserved(pfn_to_page(pfn));
> > 
> >          return true;
> > }
> > 
> > But, I am not sure if the assumption above is true, if not, we still 
> > need to check the reserved bit of
> > head for a tail page as this PATCH v2 does.
> 
> I believe what you've described is correct.  Andrea, have we missed
> anything?  Thanks,

Yes it looks good. The only reason for ever wanting to check the head
page reserved bit (instead of only checking the tail page reserved
bit) would be if any code would transfer the reserved bit from head to
tail during a hugepage split, but no hugepage split code can transfer
the reserved bit from head to tail during the split, so checking the
head can't make a difference.

The buddy wouldn't allow the driver to allocate an hugepage if any
subpage is reserved in the e820 map at boot, so non-RAM pages with a
backing struct page aren't an issue here. This was only meaningful for
PFNMAP in case the PG_reserved bit was set by the driver on a hugepage
before mapping it in userland, in which case the driver needs to set
the reserved bit in all subpages to be safe (not only in the head).

Thanks,
Andrea
