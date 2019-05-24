Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DACC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334612184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558731534;
	bh=fFzgp3n479Ejxq4l0Izq0W5hH7EErgnFzURn8ywDr6o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=GfgX+aerwju3Jbvpqfo1fItu+pXxYZAj/kg7WU5P6q3b2GZnUBA82xBiyOm6iZJtr
	 j6Z7yQ/Pl1G5NXBg8y+lz5MO3jfF/QZXoAU2N2fkb4RkhWvBX86e23YOtOWxDfSmQu
	 AzL2WfBFmgFKyg3lVoLjcW+5duaI1iUgcKdoeJfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404226AbfEXU6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbfEXU6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:58:52 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667CA2081C;
        Fri, 24 May 2019 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558731531;
        bh=fFzgp3n479Ejxq4l0Izq0W5hH7EErgnFzURn8ywDr6o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=owBJmx8MIMCiG6wU+qcTpmm4Cm7juj1Q8NhJ/CiTzs8MeQupcu9Iqs3V2XNU/W0o6
         pcGbRgOgpH0ZGFk+S5K2cnj8Im09Nc0qwac2NZm0xyllc6quLZeXea5j97lWQmMguX
         BKUrmpd8DR+kZ30PY3Ol4r7qE9YYg5I7e9Hr638E=
Date:   Fri, 24 May 2019 13:58:50 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Sergey Dyasli <sergey.dyasli@citrix.com>
cc:     iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Paul Durrant <paul.durrant@citrix.com>
Subject: Re: [PATCH v1] xen/swiotlb: rework early repeat code
In-Reply-To: <20190524144250.5102-1-sergey.dyasli@citrix.com>
Message-ID: <alpine.DEB.2.21.1905241358040.12214@sstabellini-ThinkPad-T480s>
References: <20190524144250.5102-1-sergey.dyasli@citrix.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Sergey Dyasli wrote:
> Current repeat code is plain broken for the early=true case. Xen exchanges
> all DMA (<4GB) pages that it can on the first xen_swiotlb_fixup() attempt.
> All further attempts with a halved region will fail immediately because
> all DMA pages already belong to Dom0.
> 
> Introduce contig_pages param for xen_swiotlb_fixup() to track the number
> of pages that were made contiguous in MFN space and use the same bootmem
> region while halving the memory requirements.
> 
> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>

Just FYI I am touching the same code to fix another unrelated bug, see:

https://marc.info/?l=xen-devel&m=155856767022893


> ---
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Paul Durrant <paul.durrant@citrix.com>
> ---
>  drivers/xen/swiotlb-xen.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 5dcb06fe9667..d2aba804d06c 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -142,7 +142,8 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
>  static int max_dma_bits = 32;
>  
>  static int
> -xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
> +xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs,
> +		  unsigned long *contig_pages)
>  {
>  	int i, rc;
>  	int dma_bits;
> @@ -156,10 +157,13 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
>  		int slabs = min(nslabs - i, (unsigned long)IO_TLB_SEGSIZE);
>  
>  		do {
> +			unsigned int order = get_order(slabs << IO_TLB_SHIFT);
>  			rc = xen_create_contiguous_region(
>  				p + (i << IO_TLB_SHIFT),
> -				get_order(slabs << IO_TLB_SHIFT),
> +				order,
>  				dma_bits, &dma_handle);
> +			if (rc == 0)
> +				*contig_pages += 1 << order;
>  		} while (rc && dma_bits++ < max_dma_bits);
>  		if (rc)
>  			return rc;
> @@ -202,7 +206,7 @@ static const char *xen_swiotlb_error(enum xen_swiotlb_err err)
>  }
>  int __ref xen_swiotlb_init(int verbose, bool early)
>  {
> -	unsigned long bytes, order;
> +	unsigned long bytes, order, contig_pages;
>  	int rc = -ENOMEM;
>  	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
>  	unsigned int repeat = 3;
> @@ -244,13 +248,32 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  	/*
>  	 * And replace that memory with pages under 4GB.
>  	 */
> +	contig_pages = 0;
>  	rc = xen_swiotlb_fixup(xen_io_tlb_start,
>  			       bytes,
> -			       xen_io_tlb_nslabs);
> +			       xen_io_tlb_nslabs,
> +			       &contig_pages);
>  	if (rc) {
> -		if (early)
> +		if (early) {
> +			unsigned long orig_bytes = bytes;
> +			while (repeat-- > 0) {
> +				xen_io_tlb_nslabs = max(1024UL, /* Min is 2MB */
> +						      (xen_io_tlb_nslabs >> 1));
> +				pr_info("Lowering to %luMB\n",
> +				     (xen_io_tlb_nslabs << IO_TLB_SHIFT) >> 20);
> +				bytes = xen_set_nslabs(xen_io_tlb_nslabs);
> +				order = get_order(xen_io_tlb_nslabs << IO_TLB_SHIFT);
> +				xen_io_tlb_end = xen_io_tlb_start + bytes;
> +				if (contig_pages >= (1ul << order)) {
> +					/* Enough pages were made contiguous */
> +					memblock_free(__pa(xen_io_tlb_start + bytes),
> +						     PAGE_ALIGN(orig_bytes - bytes));
> +					goto fixup_done;
> +				}
> +			}
>  			memblock_free(__pa(xen_io_tlb_start),
>  				      PAGE_ALIGN(bytes));
> +		}
>  		else {
>  			free_pages((unsigned long)xen_io_tlb_start, order);
>  			xen_io_tlb_start = NULL;
> @@ -258,6 +281,7 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  		m_ret = XEN_SWIOTLB_EFIXUP;
>  		goto error;
>  	}
> +fixup_done:
>  	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
>  	if (early) {
>  		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
> @@ -272,7 +296,7 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  
>  	return rc;
>  error:
> -	if (repeat--) {
> +	if (repeat-- > 0) {
>  		xen_io_tlb_nslabs = max(1024UL, /* Min is 2MB */
>  					(xen_io_tlb_nslabs >> 1));
>  		pr_info("Lowering to %luMB\n",
> -- 
> 2.17.1
> 
