Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36038C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F47620673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfD2LG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:06:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfD2LG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:06:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F026280D;
        Mon, 29 Apr 2019 04:06:56 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE03A3F5AF;
        Mon, 29 Apr 2019 04:06:53 -0700 (PDT)
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To:     Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
 <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
 <20190423061232.GB12762@lst.de>
 <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
 <20190424144532.GA21480@lst.de>
 <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
 <20190426150433.GA19930@lst.de>
 <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
Date:   Mon, 29 Apr 2019 12:06:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 06:10, Lu Baolu wrote:
> Hi Christoph,
> 
> On 4/26/19 11:04 PM, Christoph Hellwig wrote:
>> On Thu, Apr 25, 2019 at 10:07:19AM +0800, Lu Baolu wrote:
>>> This is not VT-d specific. It's just how generic IOMMU works.
>>>
>>> Normally, IOMMU works in paging mode. So if a driver issues DMA with
>>> IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
>>> But we should never expect IOMMU to remap 0xAAAA0123 with physical
>>> address of 0xBBBB0000. That's the reason why I said that IOMMU will not
>>> work there.
>>
>> Well, with the iommu it doesn't happen.  With swiotlb it obviosuly
>> can happen, so drivers are fine with it.  Why would that suddenly
>> become an issue when swiotlb is called from the iommu code?
>>
> 
> I would say IOMMU is DMA remapping, not DMA engine. :-)

I'm not sure I really follow the issue here - if we're copying the 
buffer to the bounce page(s) there's no conceptual difference from 
copying it to SWIOTLB slot(s), so there should be no need to worry about 
the original in-page offset.

 From the reply up-thread I guess you're trying to include an 
optimisation to only copy the head and tail of the buffer if it spans 
multiple pages, and directly map the ones in the middle, but AFAICS 
that's going to tie you to also using strict mode for TLB maintenance, 
which may not be a win overall depending on the balance between 
invalidation bandwidth vs. memcpy bandwidth. At least if we use standard 
SWIOTLB logic to always copy the whole thing, we should be able to 
release the bounce pages via the flush queue to allow 'safe' lazy unmaps.

Either way I think it would be worth just implementing the 
straightforward version first, then coming back to consider 
optimisations later.

Robin.
