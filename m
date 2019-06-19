Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8BC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C912166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfFSO0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:26:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbfFSO0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:26:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF0F3344;
        Wed, 19 Jun 2019 07:26:40 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BED283F246;
        Wed, 19 Jun 2019 07:26:39 -0700 (PDT)
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-2-jean-philippe.brucker@arm.com>
 <20190611103625.00001399@huawei.com>
 <62d1f310-0cba-4d55-0f16-68bba3c64927@arm.com>
 <20190611111333.425ce809@jacob-builder>
 <13e19d8c-8918-a3bb-f398-2ac41c71d307@arm.com>
 <20190618100508.7835780f@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1d62b2e1-fe8c-066d-34e0-f7929f6a78e2@arm.com>
Date:   Wed, 19 Jun 2019 15:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618100508.7835780f@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 18:05, Jacob Pan wrote:
> On Tue, 18 Jun 2019 15:22:20 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 11/06/2019 19:13, Jacob Pan wrote:
>>>>>> +/**
>>>>>> + * ioasid_find - Find IOASID data
>>>>>> + * @set: the IOASID set
>>>>>> + * @ioasid: the IOASID to find
>>>>>> + * @getter: function to call on the found object
>>>>>> + *
>>>>>> + * The optional getter function allows to take a reference to
>>>>>> the found object
>>>>>> + * under the rcu lock. The function can also check if the object
>>>>>> is still valid:
>>>>>> + * if @getter returns false, then the object is invalid and NULL
>>>>>> is returned.
>>>>>> + *
>>>>>> + * If the IOASID has been allocated for this set, return the
>>>>>> private pointer
>>>>>> + * passed to ioasid_alloc. Private data can be NULL if not set.
>>>>>> Return an error
>>>>>> + * if the IOASID is not found or does not belong to the set.    
>>>>>
>>>>> Perhaps should make it clear that @set can be null.    
>>>>
>>>> Indeed. But I'm not sure allowing @set to be NULL is such a good
>>>> idea, because the data type associated to an ioasid depends on its
>>>> set. For example SVA will put an mm_struct in there, and auxiliary
>>>> domains use some structure private to the IOMMU domain.
>>>>  
>>> I am not sure we need to count on @set to decipher data type.
>>> Whoever does the allocation and owns the IOASID should knows its
>>> own data type. My thought was that @set is only used to group IDs,
>>> permission check etc.
>>>   
>>>> Jacob, could me make @set mandatory, or do you see a use for a
>>>> global search? If @set is NULL, then callers can check if the
>>>> return pointer is NULL, but will run into trouble if they try to
>>>> dereference it. 
>>> A global search use case can be for PRQ. IOMMU driver gets a IOASID
>>> (first interrupt then retrieve from a queue), it has no idea which
>>> @set it belongs to. But the data types are the same for all IOASIDs
>>> used by the IOMMU.  
>>
>> They aren't when we use a generic SVA handler. Following a call to
>> iommu_sva_bind_device(), iommu-sva.c allocates an IOASID and store an
>> mm_struct. If auxiliary domains are also enabled for the device,
>> following a call to iommu_aux_attach_device() the IOMMU driver
>> allocates an IOASID and stores some private object.
>>
>> Now for example the IOMMU driver receives a PPR and calls
>> ioasid_find() with @set = NULL. ioasid_find() may return either an
>> mm_struct or a private object, and the driver cannot know which it is
>> so the returned value is unusable.
> I think we might have a misunderstanding of what ioasid_set is. Or i
> have misused your original intention for it:) So my understanding of an
> ioasid_set is to identify a sub set of IOASIDs that
> 1. shares the same data type
> 2. belongs to the same permission group, owner.

In my case it's mostly #1. The two IOASID sets (SVA and AUX) are managed
by different modules (iommu-sva and arm-smmu-v3). Since we don't do
scalable IOV, the two sets are shared_ioasid and private_ioasid, with
either an mm or NULL as private data (but we might need to store a
domain for private IOASIDs at some point). So at the moment passing a
NULL set to ioasid_find() would work for us as well.

However in a non-virtualization scenario, a device driver could define
its own set and allocate an IOASID for its own use, associating some
private structure with it. If it somehow causes a PRQ on that IOASID,
the IOMMU driver shouldn't attempt to access the device driver's private
structure. So I do think we need to be careful with global
ioasid_find(). Given that any driver in the system can use the
allocator, we won't be able to keep assuming that all objects stored in
there are of one type.

> Our usage is #2., we put a mm_struct as the set to do permission
> check. E.g VFIO can check guest PASID ownership based on QEMU process
> mm. This will make sure IOASID allocated by one guest can only be used
> by the same guest.
> 
> For IOASID used for sva bind, let it be native or guest sva, we always
> have the same data type. Therefore, when page request handler gets
> called to search with ioasid_find(), it knows its data type. An
> additional flag will tell if it is a guest bind or native bind.
> 
> I was under the assumption that aux domain and its IOASID is a 1:1
> mapping, there is no need for a search. Or even it needs to search, it
> will be searched by the same caller that did the allocation, therefore
> it knows what private data type is.
>
> In addition, aux domain is used for request w/o PASID. And PPR for
> request w/o PASID is not to be supported. So there would not be a need
> to search from page request handler.
> 
> Now if we take the above assumption away, and use ioasid_set strictly
> to differentiate the data types (Usage #1). Then I agree we can get
> rid of NULL set and global search.
> 
> That would require we converge on the generic sva_bind for both
> native and guest. The additional implication is that VFIO layer has to
> be SVA struct aware in order to sanitize the mm_struct for guest bind.
> i.e. check guest ownership by using QEMU process mm. Whereas we have
> today, VFIO just use IOASID set as mm to check ownership, no need to
> know the type.

Thanks for the explanation, I think I understand a little better after
taking a closer look at your v4.

> Can we keep the NULL set for now and remove it __after__ we converge on
> the sva bind flows?

Sure, let's revisit this later

Thanks,
Jean
