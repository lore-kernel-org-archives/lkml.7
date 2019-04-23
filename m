Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF4C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8B8218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556039170;
	bh=i2JIjq6aZqmQv7kstuBZrccA+R9sQNWobjLeh+18V/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=NfftnlZ6AI62LBzwFdsSZuuD7GFmhyPPsYLEHsTdKjw7muODOdCXisEq1w6ZKqDY3
	 VGgMhZkWajCwy3FER2ojarrQPJbYuiDfkIlnTvsRIavaPO6Pt1kufcnMw/sw+rvfAA
	 m4Pb9MRjr3+iXmLhZEPYkYQCO+/QL+FgENuEewiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfDWRGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfDWRGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:06:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B075821850;
        Tue, 23 Apr 2019 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556039168;
        bh=i2JIjq6aZqmQv7kstuBZrccA+R9sQNWobjLeh+18V/c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kzTSDLONeEaMkdNJaBpJTVTxUi+JRdWZL1srIKm1BwEa7hE/v6ODhR8nbhgBcoPV2
         D1k5kEj+JoiESav7hOBHHdfBDpl5MVGxwuicWbeF+Db629CAgchY99DQ5GTJJFMwrX
         j/5/0K6m7DUqpkm5w+odQmi4iMADi08L+czZz7Jo=
Date:   Tue, 23 Apr 2019 10:05:54 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Juergen Gross <jgross@suse.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org
Subject: Re: [PATCH 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
In-Reply-To: <20190423105457.17502-4-jgross@suse.com>
Message-ID: <alpine.DEB.2.10.1904230955190.24598@sstabellini-ThinkPad-X260>
References: <20190423105457.17502-1-jgross@suse.com> <20190423105457.17502-4-jgross@suse.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Juergen Gross wrote:
> Instead of always calling xen_destroy_contiguous_region() in case the
> memory is DMA-able for the used device, do so only in case it has been
> made DMA-able via xen_create_contiguous_region() before.
> 
> This will avoid a lot of xen_destroy_contiguous_region() calls for
> 64-bit capable devices.
> 
> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
> flag of the first allocated page can be used for remembering.

Although the patch looks OK, this sentence puzzles me. Why do you say
that the memory in question is owned by swiotlb-xen? Because it was
returned by xen_alloc_coherent_pages? Both the x86 and the Arm
implementation return fresh new memory, hence, it should be safe to set
the PageOwnerPriv1 flag?

My concern with this approach is with the semantics of PG_owner_priv_1.
Is a page marked with PG_owner_priv_1 only supposed to be used by the
owner?


> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/swiotlb-xen.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 43b6e65ae256..a72f181d8e20 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -321,6 +321,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
>  			return NULL;
>  		}
> +		SetPageOwnerPriv1(virt_to_page(ret));
>  	}
>  	memset(ret, 0, size);
>  	return ret;
> @@ -344,9 +345,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if ((dev_addr + size - 1 <= dma_mask) &&
> -	    !WARN_ON(range_straddles_page_boundary(phys, size)))
> -		xen_destroy_contiguous_region(phys, order);
> +	if (PageOwnerPriv1(virt_to_page(vaddr))) {
> +		if (!WARN_ON(range_straddles_page_boundary(phys, size)))
> +			xen_destroy_contiguous_region(phys, order);
> +		ClearPageOwnerPriv1(virt_to_page(vaddr));
> +	}
>  
>  	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
>  }
