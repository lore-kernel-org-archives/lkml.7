Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F929C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F59C21734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfGYHSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:18:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:21527 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387562AbfGYHSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:18:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 00:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="181373984"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2019 00:18:37 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
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
To:     Christoph Hellwig <hch@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
 <20190725031717.32317-3-baolu.lu@linux.intel.com>
 <20190725054413.GC24527@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
Date:   Thu, 25 Jul 2019 15:18:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725054413.GC24527@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 7/25/19 1:44 PM, Christoph Hellwig wrote:
>>   /* Check if the dev needs to go through non-identity map and unmap process.*/
>>   static bool iommu_need_mapping(struct device *dev)
>>   {
>> -	int ret;
>> -
>>   	if (iommu_dummy(dev))
>>   		return false;
>>   
>> -	ret = identity_mapping(dev);
>> -	if (ret) {
>> -		u64 dma_mask = *dev->dma_mask;
>> -
>> -		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
>> -			dma_mask = dev->coherent_dma_mask;
>> -
>> -		if (dma_mask >= dma_get_required_mask(dev))
>> -			return false;
> 
> Don't we need to keep this bit so that we still allow the IOMMU
> to act if the device has a too small DMA mask to address all memory in
> the system, even if if it should otherwise be identity mapped?
> 

This checking happens only when device is using an identity mapped
domain. If the device has a small DMA mask, swiotlb will be used for
high memory access.

This is supposed to be handled in dma_direct_map_page():

         if (unlikely(!dma_direct_possible(dev, dma_addr, size)) &&
             !swiotlb_map(dev, &phys, &dma_addr, size, dir, attrs)) {
                 report_addr(dev, dma_addr, size);
                 return DMA_MAPPING_ERROR;
         }

Best regards,
Baolu
