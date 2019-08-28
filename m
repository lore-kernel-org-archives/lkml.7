Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880A6C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E45208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfH1PzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:55:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59943 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfH1PzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:55:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97C663007C30;
        Wed, 28 Aug 2019 15:55:03 +0000 (UTC)
Received: from x1.home (ovpn-116-131.phx2.redhat.com [10.3.116.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C30A31001B14;
        Wed, 28 Aug 2019 15:55:02 +0000 (UTC)
Date:   Wed, 28 Aug 2019 09:55:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v2] vfio/type1: avoid redundant PageReserved checking
Message-ID: <20190828095501.12e71bd3@x1.home>
In-Reply-To: <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
References: <20190827124041.4f986005@x1.home>
        <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Aug 2019 15:55:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 12:28:04 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> currently, if the page is not a tail of compound page, it will be
> checked twice for the same thing.
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 054391f..d0f7346 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  static bool is_invalid_reserved_pfn(unsigned long pfn)
>  {
>  	if (pfn_valid(pfn)) {
> -		bool reserved;
>  		struct page *tail = pfn_to_page(pfn);
>  		struct page *head = compound_head(tail);
> -		reserved = !!(PageReserved(head));
>  		if (head != tail) {
> +			bool reserved = PageReserved(head);
>  			/*
>  			 * "head" is not a dangling pointer
>  			 * (compound_head takes care of that)

Thinking more about this, the code here was originally just a copy of
kvm_is_mmio_pfn() which was simplified in v3.12 with the commit below.
Should we instead do the same thing here?  Thanks,

Alex

commit 11feeb498086a3a5907b8148bdf1786a9b18fc55
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Thu Jul 25 03:04:38 2013 +0200

    kvm: optimize away THP checks in kvm_is_mmio_pfn()
    
    The checks on PG_reserved in the page structure on head and tail pages
    aren't necessary because split_huge_page wouldn't transfer the
    PG_reserved bit from head to tail anyway.
    
    This was a forward-thinking check done in the case PageReserved was
    set by a driver-owned page mapped in userland with something like
    remap_pfn_range in a VM_PFNMAP region, but using hugepmds (not
    possible right now). It was meant to be very safe, but it's overkill
    as it's unlikely split_huge_page could ever run without the driver
    noticing and tearing down the hugepage itself.
    
    And if a driver in the future will really want to map a reserved
    hugepage in userland using an huge pmd it should simply take care of
    marking all subpages reserved too to keep KVM safe. This of course
    would require such a hypothetical driver to tear down the huge pmd
    itself and splitting the hugepage itself, instead of relaying on
    split_huge_page, but that sounds very reasonable, especially
    considering split_huge_page wouldn't currently transfer the reserved
    bit anyway.
    
    Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
    Signed-off-by: Gleb Natapov <gleb@redhat.com>

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d2836788561e..0fc25aed79a8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -102,28 +102,8 @@ static bool largepages_enabled = true;
 
 bool kvm_is_mmio_pfn(pfn_t pfn)
 {
-       if (pfn_valid(pfn)) {
-               int reserved;
-               struct page *tail = pfn_to_page(pfn);
-               struct page *head = compound_trans_head(tail);
-               reserved = PageReserved(head);
-               if (head != tail) {
-                       /*
-                        * "head" is not a dangling pointer
-                        * (compound_trans_head takes care of that)
-                        * but the hugepage may have been splitted
-                        * from under us (and we may not hold a
-                        * reference count on the head page so it can
-                        * be reused before we run PageReferenced), so
-                        * we've to check PageTail before returning
-                        * what we just read.
-                        */
-                       smp_rmb();
-                       if (PageTail(tail))
-                               return reserved;
-               }
-               return PageReserved(tail);
-       }
+       if (pfn_valid(pfn))
+               return PageReserved(pfn_to_page(pfn));
 
        return true;
 }
