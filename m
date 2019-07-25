Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B29C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650E8229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbfGYLnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:43:53 -0400
Received: from verein.lst.de ([213.95.11.211]:60769 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbfGYLnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:43:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 137C168BFE; Thu, 25 Jul 2019 13:43:49 +0200 (CEST)
Date:   Thu, 25 Jul 2019 13:43:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
Message-ID: <20190725114348.GA30957@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com> <20190725031717.32317-3-baolu.lu@linux.intel.com> <20190725054413.GC24527@lst.de> <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 03:18:03PM +0800, Lu Baolu wrote:
>> Don't we need to keep this bit so that we still allow the IOMMU
>> to act if the device has a too small DMA mask to address all memory in
>> the system, even if if it should otherwise be identity mapped?
>>
>
> This checking happens only when device is using an identity mapped
> domain. If the device has a small DMA mask, swiotlb will be used for
> high memory access.
>
> This is supposed to be handled in dma_direct_map_page():
>
>         if (unlikely(!dma_direct_possible(dev, dma_addr, size)) &&
>             !swiotlb_map(dev, &phys, &dma_addr, size, dir, attrs)) {
>                 report_addr(dev, dma_addr, size);
>                 return DMA_MAPPING_ERROR;
>         }

Well, yes.  But the point is that the current code uses dynamic iommu
mappings even if the devices is in the identity mapped domain when the
dma mask іs too small to map all memory directly.  Your change means it
will now use swiotlb which is most likely going to be a lot more
expensive.  I don't think that this change is a good idea, and even if
we decide that this is a good idea after all that should be done in a
separate prep patch that explains the rationale.

> Best regards,
> Baolu
---end quoted text---
