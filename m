Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2013CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4FA2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634268AbfJRO4F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfJRO4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81E618A1C8F;
        Fri, 18 Oct 2019 14:56:04 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2961860600;
        Fri, 18 Oct 2019 14:56:04 +0000 (UTC)
Date:   Fri, 18 Oct 2019 08:56:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     aarcange@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/type1: remove hugepage checks in
 is_invalid_reserved_pfn()
Message-ID: <20191018085602.17f2edbb@x1.home>
In-Reply-To: <ae787a52-a7ed-f7b8-074f-ab8883037ac0@linux.alibaba.com>
References: <1d6b7e1c40783f2db4c6cb15bf679a94222ec6a3.1570073993.git.luoben@linux.alibaba.com>
        <20191003164133.GG13922@redhat.com>
        <ae787a52-a7ed-f7b8-074f-ab8883037ac0@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 18 Oct 2019 14:56:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 14:42:32 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> A friendly reminder :)
> 

Thanks Ben!  I've added this to the vfio next branch for v5.5 with
Andrea's R-b.  Thanks,

Alex

> 在 2019/10/4 上午12:41, Andrea Arcangeli 写道:
> > On Thu, Oct 03, 2019 at 11:49:42AM +0800, Ben Luo wrote:  
> >> Currently, no hugepage split code can transfer the reserved bit
> >> from head to tail during the split, so checking the head can't make
> >> a difference in a racing condition with hugepage spliting.
> >>
> >> The buddy wouldn't allow a driver to allocate an hugepage if any
> >> subpage is reserved in the e820 map at boot, if any driver sets the
> >> reserved bit of head page before mapping the hugepage in userland,
> >> it needs to set the reserved bit in all subpages to be safe.
> >>
> >> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>  
> > Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> >
> >  
> >> ---
> >>   drivers/vfio/vfio_iommu_type1.c | 26 ++++----------------------
> >>   1 file changed, 4 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 054391f..e2019ba 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -287,31 +287,13 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
> >>    * Some mappings aren't backed by a struct page, for example an mmap'd
> >>    * MMIO range for our own or another device.  These use a different
> >>    * pfn conversion and shouldn't be tracked as locked pages.
> >> + * For compound pages, any driver that sets the reserved bit in head
> >> + * page needs to set the reserved bit in all subpages to be safe.
> >>    */
> >>   static bool is_invalid_reserved_pfn(unsigned long pfn)
> >>   {
> >> -	if (pfn_valid(pfn)) {
> >> -		bool reserved;
> >> -		struct page *tail = pfn_to_page(pfn);
> >> -		struct page *head = compound_head(tail);
> >> -		reserved = !!(PageReserved(head));
> >> -		if (head != tail) {
> >> -			/*
> >> -			 * "head" is not a dangling pointer
> >> -			 * (compound_head takes care of that)
> >> -			 * but the hugepage may have been split
> >> -			 * from under us (and we may not hold a
> >> -			 * reference count on the head page so it can
> >> -			 * be reused before we run PageReferenced), so
> >> -			 * we've to check PageTail before returning
> >> -			 * what we just read.
> >> -			 */
> >> -			smp_rmb();
> >> -			if (PageTail(tail))
> >> -				return reserved;
> >> -		}
> >> -		return PageReserved(tail);
> >> -	}
> >> +	if (pfn_valid(pfn))
> >> +		return PageReserved(pfn_to_page(pfn));
> >>   
> >>   	return true;
> >>   }
> >> -- 
> >> 1.8.3.1
> >>  

