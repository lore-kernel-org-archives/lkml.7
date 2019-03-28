Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B34EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D827221773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfC1Gir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:38:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:35656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfC1Gir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:38:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 23:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,278,1549958400"; 
   d="scan'208";a="126541690"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2019 23:38:44 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
To:     Christoph Hellwig <hch@infradead.org>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
 <20190327064823.GA13309@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
Date:   Thu, 28 Mar 2019 14:33:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327064823.GA13309@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/27/19 2:48 PM, Christoph Hellwig wrote:
> On Wed, Mar 27, 2019 at 02:34:56PM +0800, Lu Baolu wrote:
>>    - During the v1 review cycle, we discussed the possibility
>>      of reusing swiotlb code to avoid code dumplication, but
>>      we found the swiotlb implementations are not ready for the
>>      use of bounce page pool.
>>      https://lkml.org/lkml/2019/3/19/259
> 
> So make it ready.  You too can contribute to common code.  Robin
> also explicitly asked to make the bounce policy iommu-subsystem wide.
> 

Sure. I am glad to make the code common. I will try to make it with a
new version.

For the swiotlb APIs, I am thinking about keeping current APIs untouched
and adding below new ones for bounce page.

/**
  * swiotlb_bounce_page_map - create a bounce page mapping
  * @dev: the device
  * @phys: the physical address of the buffer requiring bounce
  * @size: the size of the buffer
  * @align: IOMMU page align
  * @dir: DMA direction
  * @attrs: DMA attributions
  *
  * This creates a swiotlb bounce page mapping for the buffer at @phys,
  * and in case of DMAing to the device copy the data into it as well.
  * Return the tlb addr on success, otherwise DMA_MAPPING_ERROR.
  */
dma_addr_t
swiotlb_bounce_page_map(struct device *dev, phys_addr_t phys,
                         size_t size, unsigned long align,
                         enum dma_data_direction dir, unsigned long attrs)
{
         return 0;
}

/**
  * swiotlb_bounce_page_unmap - destroy a bounce page mapping
  * @dev: the device
  * @tlb_addr: the tlb address of the buffer requiring bounce
  * @size: the size of the buffer
  * @align: IOMMU page align
  * @dir: DMA direction
  * @attrs: DMA attributions
  *
  * This destroys a swiotlb bounce page mapping for the buffer at @tlb_addr,
  * and in case of DMAing from the device copy the data from it as well.
  */
void
swiotlb_bounce_page_unmap(struct device *dev, phys_addr_t tlb_addr,
                           size_t size, unsigned long align,
                           enum dma_data_direction dir, unsigned long attrs)
{
}

/**
  * swiotlb_bounce_page_sync - sync bounce page mapping
  * @dev: the device
  * @tlb_addr: the tlb address of the buffer requiring bounce
  * @size: the size of the buffer
  * @align: IOMMU page align
  * @dir: DMA direction
  * @attrs: DMA attributions
  *
  * This syncs a swiotlb bounce page mapping for the buffer at @tlb_addr.
  */
void
swiotlb_bounce_page_sync(struct device *dev, phys_addr_t tlb_addr,
                           size_t size, unsigned long align,
                           enum dma_data_direction dir, unsigned long attrs)
{
}

Any comments?

Best regards,
Lu Baolu
