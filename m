Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ADFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F682082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfCSLVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:21:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfCSLVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:21:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA02B174E;
        Tue, 19 Mar 2019 04:21:38 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056D83F614;
        Tue, 19 Mar 2019 04:21:36 -0700 (PDT)
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        ashok.raj@intel.com, alan.cox@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        pengfei.xu@intel.com, jacob.jun.pan@intel.com,
        David Woodhouse <dwmw2@infradead.org>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
 <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
 <c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
 <20190313161029.GA23513@infradead.org>
 <c1ffee0a-24d2-df53-0689-23b0d8ef065d@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <04703ea4-58e5-f833-5b39-1b68df2839ca@arm.com>
Date:   Tue, 19 Mar 2019 11:21:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c1ffee0a-24d2-df53-0689-23b0d8ef065d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 07:59, Lu Baolu wrote:
> Hi Christoph,
> 
> On 3/14/19 12:10 AM, Christoph Hellwig wrote:
>> On Wed, Mar 13, 2019 at 10:31:52AM +0800, Lu Baolu wrote:
>>> Hi again,
>>>
>>> On 3/13/19 10:04 AM, Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> On 3/13/19 12:38 AM, Christoph Hellwig wrote:
>>>>> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>>>>>> This adds the APIs for bounce buffer specified domain
>>>>>> map() and unmap(). The start and end partial pages will
>>>>>> be mapped with bounce buffered pages instead. This will
>>>>>> enhance the security of DMA buffer by isolating the DMA
>>>>>> attacks from malicious devices.
>>>>>
>>>>> Please reuse the swiotlb code instead of reinventing it.
>>>>>
>>>
>>> Just looked into the code again. At least we could reuse below
>>> functions:
>>>
>>> swiotlb_tbl_map_single()
>>> swiotlb_tbl_unmap_single()
>>> swiotlb_tbl_sync_single()
>>>
>>> Anything else?
>>
>> Yes, that is probably about the level you want to reuse, given that the
>> next higher layer already has hooks into the direct mapping code.
>>
> 
> I am trying to change my code to reuse swiotlb. But I found that swiotlb
> might not be suitable for my case.
> 
> Below is what I got with swiotlb_map():
> 
> phy_addr        size    tlb_addr
> --------------------------------
> 0x167eec330     0x8     0x85dc6000
> 0x167eef5c0     0x40    0x85dc6800
> 0x167eec330     0x8     0x85dc7000
> 0x167eef5c0     0x40    0x85dc7800
> 
> But what I expected to get is:
> 
> phy_addr        size    tlb_addr
> --------------------------------
> 0x167eec330     0x8     0xAAAAA330
> 0x167eef5c0     0x40    0xBBBBB5c0
> 0x167eec330     0x8     0xCCCCC330
> 0x167eef5c0     0x40    0xDDDDD5c0
> 
> , where 0xXXXXXX000 is the physical address of a bounced page.
> 
> Basically, I want a bounce page to replace a leaf page in the vt-d page
> table, which maps a buffer with size less than a PAGE_SIZE.

I'd imagine the thing to do would be to factor out the slot allocation 
in swiotlb_tbl_map_single() so that an IOMMU page pool/allocator can be 
hooked in as an alternative.

However we implement it, though, this should absolutely be a common 
IOMMU thing that all relevant DMA backends can opt into, and not 
specific to VT-d. I mean, it's already more or less the same concept as 
the PowerPC secure VM thing.

Robin.
