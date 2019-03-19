Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3165C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF31213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCSIFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:05:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:43610 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfCSIFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:05:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 01:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="128201049"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2019 01:05:18 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
To:     Christoph Hellwig <hch@infradead.org>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
 <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
 <c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
 <20190313161029.GA23513@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c1ffee0a-24d2-df53-0689-23b0d8ef065d@linux.intel.com>
Date:   Tue, 19 Mar 2019 15:59:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190313161029.GA23513@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 3/14/19 12:10 AM, Christoph Hellwig wrote:
> On Wed, Mar 13, 2019 at 10:31:52AM +0800, Lu Baolu wrote:
>> Hi again,
>>
>> On 3/13/19 10:04 AM, Lu Baolu wrote:
>>> Hi,
>>>
>>> On 3/13/19 12:38 AM, Christoph Hellwig wrote:
>>>> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>>>>> This adds the APIs for bounce buffer specified domain
>>>>> map() and unmap(). The start and end partial pages will
>>>>> be mapped with bounce buffered pages instead. This will
>>>>> enhance the security of DMA buffer by isolating the DMA
>>>>> attacks from malicious devices.
>>>>
>>>> Please reuse the swiotlb code instead of reinventing it.
>>>>
>>
>> Just looked into the code again. At least we could reuse below
>> functions:
>>
>> swiotlb_tbl_map_single()
>> swiotlb_tbl_unmap_single()
>> swiotlb_tbl_sync_single()
>>
>> Anything else?
> 
> Yes, that is probably about the level you want to reuse, given that the
> next higher layer already has hooks into the direct mapping code.
> 

I am trying to change my code to reuse swiotlb. But I found that swiotlb
might not be suitable for my case.

Below is what I got with swiotlb_map():

phy_addr        size    tlb_addr
--------------------------------
0x167eec330     0x8     0x85dc6000
0x167eef5c0     0x40    0x85dc6800
0x167eec330     0x8     0x85dc7000
0x167eef5c0     0x40    0x85dc7800

But what I expected to get is:

phy_addr        size    tlb_addr
--------------------------------
0x167eec330     0x8     0xAAAAA330
0x167eef5c0     0x40    0xBBBBB5c0
0x167eec330     0x8     0xCCCCC330
0x167eef5c0     0x40    0xDDDDD5c0

, where 0xXXXXXX000 is the physical address of a bounced page.

Basically, I want a bounce page to replace a leaf page in the vt-d page
table, which maps a buffer with size less than a PAGE_SIZE.

Best regards,
Lu Baolu
