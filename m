Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5CC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D0A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437115AbfFLDPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:15:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:29460 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406820AbfFLDPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:15:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 20:15:38 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 20:15:32 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v4 3/9] swiotlb: Zero out bounce buffer for untrusted
 device
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-4-baolu.lu@linux.intel.com>
 <20190610154553.GT28796@char.us.oracle.com>
 <ec6ac2ba-7b88-2bcf-aa95-f8981b258c5c@linux.intel.com>
 <20190612010518.GB22479@char.us.oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8ad77caa-3245-4d06-314d-c4a92aa0f2ac@linux.intel.com>
Date:   Wed, 12 Jun 2019 11:08:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612010518.GB22479@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/12/19 9:05 AM, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 12, 2019 at 08:43:40AM +0800, Lu Baolu wrote:
>> Hi Konrad,
>>
>> Thanks a lot for your reviewing.
>>
>> On 6/10/19 11:45 PM, Konrad Rzeszutek Wilk wrote:
>>> On Mon, Jun 03, 2019 at 09:16:14AM +0800, Lu Baolu wrote:
>>>> This is necessary to avoid exposing valid kernel data to any
>>>> milicious device.
>>>
>>> malicious
>>
>> Yes, thanks.
>>
>>>
>>>>
>>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    kernel/dma/swiotlb.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>>> index f956f785645a..ed41eb7f6131 100644
>>>> --- a/kernel/dma/swiotlb.c
>>>> +++ b/kernel/dma/swiotlb.c
>>>> @@ -35,6 +35,7 @@
>>>>    #include <linux/scatterlist.h>
>>>>    #include <linux/mem_encrypt.h>
>>>>    #include <linux/set_memory.h>
>>>> +#include <linux/pci.h>
>>>>    #ifdef CONFIG_DEBUG_FS
>>>>    #include <linux/debugfs.h>
>>>>    #endif
>>>> @@ -560,6 +561,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>>>    	 */
>>>>    	for (i = 0; i < nslots; i++)
>>>>    		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
>>>> +
>>>> +	/* Zero out the bounce buffer if the consumer is untrusted. */
>>>> +	if (dev_is_untrusted(hwdev))
>>>> +		memset(phys_to_virt(tlb_addr), 0, alloc_size);
>>>
>>> What if the alloc_size is less than a PAGE? Should this at least have ALIGN or such?
>>
>> It's the consumer (iommu subsystem) who requires this to be page
>> aligned. For swiotlb, it just clears out all data in the allocated
>> bounce buffer.
> 
> I am thinking that the if you don't memset the full page the malicious hardware could read stale date from the rest of the page
> that hasn't been cleared?

Yes. My point is that this should be guaranteed by the bounce page
implementation in iommu.

Best regards,
Baolu

> 
>>
>> Best regards,
>> Baolu
>>
>>>
>>>> +
>>>>    	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>>>>    	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>>>>    		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
>>>> -- 
>>>> 2.17.1
>>>>
>>>
> 
