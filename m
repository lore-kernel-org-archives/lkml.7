Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF42C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F73217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfDYIxp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:53:45 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:52852 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYIxp (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Thu, 25 Apr 2019 04:53:45 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 25 Apr 2019 02:53:44 -0600
Message-Id: <5CC175950200007800228E80@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Thu, 25 Apr 2019 02:53:41 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/3] xen/swiotlb: fix condition for
 calling xen_destroy_contiguous_region()
References: <20190423105457.17502-1-jgross@suse.com>
 <20190423105457.17502-2-jgross@suse.com>
In-Reply-To: <20190423105457.17502-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 23.04.19 at 12:54, <jgross@suse.com> wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -360,8 +360,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (((dev_addr + size - 1 <= dma_mask)) ||
> -	    range_straddles_page_boundary(phys, size))
> +	if ((dev_addr + size - 1 <= dma_mask) &&
> +	    !WARN_ON(range_straddles_page_boundary(phys, size)))
>  		xen_destroy_contiguous_region(phys, order);

On the allocation side we have

	if (((dev_addr + size - 1 <= dma_mask)) &&
	    !range_straddles_page_boundary(phys, size))
		*dma_handle = dev_addr;
	else {
		if (xen_create_contiguous_region(phys, order,
						 fls64(dma_mask), dma_handle) != 0) {
			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
			return NULL;
		}
	}

which is (as far as the function call is concerned)

	if ((dev_addr + size - 1 > dma_mask) ||
	    range_straddles_page_boundary(phys, size))
		xen_create_contiguous_region(...);

So I don't think your transformation is correct. Even worse, both
parts of the condition in xen_swiotlb_free_coherent() act on an
address that is the _result_ of the prior
xen_create_contiguous_region(), i.e. the address should always
match _both_ criteria anyway. Whereas what you really want is
undo the xen_create_contiguous_region() only when it actually
was called. Otherwise you also shatter contiguous allocations
that were contiguous already for other reasons (perhaps just
luck).

Jan


