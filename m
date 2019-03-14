Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD977C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3AC21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCNBGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:06:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:40215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfCNBGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:06:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 18:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,476,1544515200"; 
   d="scan'208";a="126775490"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2019 18:06:39 -0700
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
Message-ID: <b3e88984-d2ff-c23d-c4bd-3248e4e9487d@linux.intel.com>
Date:   Thu, 14 Mar 2019 09:01:16 +0800
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

Hi,

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

Okay. Thank you!

I will try to make this happen in v2.

Best regards,
Lu Baolu
