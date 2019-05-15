Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A03C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388FA20675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfEOMOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:14:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfEOLEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:04:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D949D80D;
        Wed, 15 May 2019 04:04:08 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37E733F703;
        Wed, 15 May 2019 04:04:07 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
 <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
 <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
 <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
 <20190513151637.79c273e2@jacob-builder>
 <0da76e57-76f6-06fa-d34e-30cd0c294984@redhat.com>
 <f319bd4c-3092-84e1-233a-34832551249e@arm.com>
 <20190514104401.79d563f4@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c068af08-15bd-c7c0-f5c2-7414832a6e9c@arm.com>
Date:   Wed, 15 May 2019 12:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514104401.79d563f4@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2019 18:44, Jacob Pan wrote:
> Hi Thank you both for the explanation.
> 
> On Tue, 14 May 2019 11:41:24 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 14/05/2019 08:36, Auger Eric wrote:
>>> Hi Jacob,
>>>
>>> On 5/14/19 12:16 AM, Jacob Pan wrote:  
>>>> On Mon, 13 May 2019 18:09:48 +0100
>>>> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
>>>>  
>>>>> On 13/05/2019 17:50, Auger Eric wrote:  
>>>>>>> struct iommu_inv_pasid_info {
>>>>>>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
>>>>>>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
>>>>>>> 	__u32	flags;
>>>>>>> 	__u32	archid;
>>>>>>> 	__u64	pasid;
>>>>>>> };    
>>>>>> I agree it does the job now. However it looks a bit strange to
>>>>>> do a PASID based invalidation in my case - SMMUv3 nested stage -
>>>>>> where I don't have any PASID involved.
>>>>>>
>>>>>> Couldn't we call it context based invalidation then? A context
>>>>>> can be tagged by a PASID or/and an ARCHID.    
>>>>>
>>>>> I think calling it "context" would be confusing as well (I
>>>>> shouldn't have used it earlier), since VT-d uses that name for
>>>>> device table entries (=STE on Arm SMMU). Maybe "addr_space"?
>>>>>  
>>>> I am still struggling to understand what ARCHID is after scanning
>>>> through SMMUv3.1 spec. It seems to be a constant for a given SMMU.
>>>> Why do you need to pass it down every time? Could you point to me
>>>> the document or explain a little more on ARCHID use cases.
>>>> We have three fileds called pasid under this struct
>>>> iommu_cache_invalidate_info{}
>>>> Gets confusing :)  
>>> archid is a generic term. That's why you did not find it in the
>>> spec ;-)
>>>
>>> On ARM SMMU the archid is called the ASID (Address Space ID, up to
>>> 16 bits. The ASID is stored in the Context Descriptor Entry (your
>>> PASID entry) and thus characterizes a given stage 1 translation
>>> "context"/"adress space".  
>>
>> Yes, another way to look at it is, for a given address space:
>> * PASID tags device-IOTLB (ATC) entries.
>> * ASID (here called archid) tags IOTLB entries.
>>
>> They could have the same value, but it depends on the guest's
>> allocation policy which isn't in our control. With my PASID patches
>> for SMMUv3, they have different values. So we need both fields if we
>> intend to invalidate both ATC and IOTLB with a single call.
>>
> For ASID invalidation, there is also page/address selective within an
> ASID, right? I guess it is CMD_TLBI_NH_VA?
> So the single call to invalidate both ATC & IOTLB should share the same
> address information. i.e.
> struct iommu_inv_addr_info {}
> 
> Just out of curiosity, what is the advantage of having guest tag its
> ATC with its own PASID? I thought you were planning to use custom
> ioasid allocator to get PASID from host.

Hm, for the moment I mostly considered the custom ioasid allocator for
Intel platforms. On Arm platforms the SR-IOV model where each VM has its
own PASID space is still very much on the table. This would be the only
model supported by a vSMMU emulation for example, since the SMMU doesn't
have PASID allocation commands.

> Also ASID is 16 bit as Eric said and PASID (substreamID?) is 20 bit,
> right?

Yes. Some implementations have 8-bit ASIDs, but I think those would be
on embedded rather than server class platforms. And yes, if it wasn't
confusing enough, the Arm SMMU uses "SubstreamID" (SSID) for PASIDs :)

Thanks,
Jean
