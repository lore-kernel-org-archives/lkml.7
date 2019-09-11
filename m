Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E2C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30E32089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfIKKfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:35:23 -0400
Received: from 8bytes.org ([81.169.241.247]:54016 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfIKKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:35:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5ACD7386; Wed, 11 Sep 2019 12:35:21 +0200 (CEST)
Date:   Wed, 11 Sep 2019 12:35:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/5] swiotlb: Split size parameter to map/unmap APIs
Message-ID: <20190911103517.GA21988@8bytes.org>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
 <20190906061452.30791-2-baolu.lu@linux.intel.com>
 <20190910151544.GA7585@char.us.oracle.com>
 <0b939480-cb99-46fe-374e-a31441d21486@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b939480-cb99-46fe-374e-a31441d21486@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 02:16:07PM +0800, Lu Baolu wrote:
> How about this change?
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 89066efa3840..22a7848caca3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -466,8 +466,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device
> *hwdev,
>                 pr_warn_once("%s is active and system is using DMA bounce
> buffers\n",
>                              sme_active() ? "SME" : "SEV");
> 
> -       if (WARN_ON(mapping_size > alloc_size))
> +       if (mapping_size > alloc_size) {
> +               dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes,
> alloc: %zd bytes)",
> +                             mapping_size, alloc_size);
>                 return (phys_addr_t)DMA_MAPPING_ERROR;
> +       }
> 
>         mask = dma_get_seg_boundary(hwdev);
> 
> @@ -584,9 +587,6 @@ void swiotlb_tbl_unmap_single(struct device *hwdev,
> phys_addr_t tlb_addr,
>         int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
>         phys_addr_t orig_addr = io_tlb_orig_addr[index];
> 
> -       if (WARN_ON(mapping_size > alloc_size))
> -               return;
> -
>         /*
>          * First, sync the memory before unmapping the entry
>          */

Folded that into the commit, thanks Lu Baolu.
