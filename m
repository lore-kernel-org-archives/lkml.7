Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C686C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C309213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfFROWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:22:52 -0400
Received: from foss.arm.com ([217.140.110.172]:43642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFROWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:22:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3BD2B;
        Tue, 18 Jun 2019 07:22:49 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC35F3F718;
        Tue, 18 Jun 2019 07:22:48 -0700 (PDT)
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
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
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <13e19d8c-8918-a3bb-f398-2ac41c71d307@arm.com>
Date:   Tue, 18 Jun 2019 15:22:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611111333.425ce809@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 19:13, Jacob Pan wrote:
>>>> +/**
>>>> + * ioasid_find - Find IOASID data
>>>> + * @set: the IOASID set
>>>> + * @ioasid: the IOASID to find
>>>> + * @getter: function to call on the found object
>>>> + *
>>>> + * The optional getter function allows to take a reference to the
>>>> found object
>>>> + * under the rcu lock. The function can also check if the object
>>>> is still valid:
>>>> + * if @getter returns false, then the object is invalid and NULL
>>>> is returned.
>>>> + *
>>>> + * If the IOASID has been allocated for this set, return the
>>>> private pointer
>>>> + * passed to ioasid_alloc. Private data can be NULL if not set.
>>>> Return an error
>>>> + * if the IOASID is not found or does not belong to the set.  
>>>
>>> Perhaps should make it clear that @set can be null.  
>>
>> Indeed. But I'm not sure allowing @set to be NULL is such a good idea,
>> because the data type associated to an ioasid depends on its set. For
>> example SVA will put an mm_struct in there, and auxiliary domains use
>> some structure private to the IOMMU domain.
>>
> I am not sure we need to count on @set to decipher data type. Whoever
> does the allocation and owns the IOASID should knows its own data type.
> My thought was that @set is only used to group IDs, permission check
> etc.
> 
>> Jacob, could me make @set mandatory, or do you see a use for a global
>> search? If @set is NULL, then callers can check if the return pointer
>> is NULL, but will run into trouble if they try to dereference it.
>>
> A global search use case can be for PRQ. IOMMU driver gets a IOASID
> (first interrupt then retrieve from a queue), it has no idea which
> @set it belongs to. But the data types are the same for all IOASIDs
> used by the IOMMU.

They aren't when we use a generic SVA handler. Following a call to
iommu_sva_bind_device(), iommu-sva.c allocates an IOASID and store an
mm_struct. If auxiliary domains are also enabled for the device,
following a call to iommu_aux_attach_device() the IOMMU driver allocates
an IOASID and stores some private object.

Now for example the IOMMU driver receives a PPR and calls ioasid_find()
with @set = NULL. ioasid_find() may return either an mm_struct or a
private object, and the driver cannot know which it is so the returned
value is unusable.

Thanks,
Jean
