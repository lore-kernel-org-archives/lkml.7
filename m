Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E40206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCDPwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:52:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfCDPwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:52:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6667EBD;
        Mon,  4 Mar 2019 07:52:39 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22F2F3F706;
        Mon,  4 Mar 2019 07:52:37 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
 <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
 <dc06dfd0-0ab6-6f0b-64c6-2587a2a55798@huawei.com>
 <5C78B89C.7040100@huawei.com> <e567cf93-4e34-e15e-9d98-5834bc63e234@arm.com>
 <5C7A1EE1.6020200@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7ed7da40-adbe-09b2-5124-baf62558987d@arm.com>
Date:   Mon, 4 Mar 2019 15:52:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C7A1EE1.6020200@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2019 06:12, Leizhen (ThunderTown) wrote:
> 
> 
> On 2019/3/1 19:07, Jean-Philippe Brucker wrote:
>> Hi Leizhen,
>>
>> On 01/03/2019 04:44, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2019/2/26 20:36, Hanjun Guo wrote:
>>>> Hi Jean,
>>>>
>>>> On 2019/1/31 22:55, Jean-Philippe Brucker wrote:
>>>>> Hi,
>>>>>
>>>>> On 31/01/2019 13:52, Zhen Lei wrote:
>>>>>> Currently, many peripherals are faster than before. For example, the top
>>>>>> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
>>>>>> when iommu page-table mapping enabled, it's hard to reach the top speed
>>>>>> in strict mode, because of frequently map and unmap operations. In order
>>>>>> to keep abreast of the times, I think it's better to set non-strict as
>>>>>> default.
>>>>>
>>>>> Most users won't be aware of this relaxation and will have their system
>>>>> vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
>>>>> Invalidation in
>>>>> http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf
>>> Hi Jean,
>>>
>>>     In fact, we have discussed the vulnerable of deferred invalidation before upstream
>>> the non-strict patches. The attacks maybe possible because of an untrusted device or
>>> the mistake of the device driver. And we limited the VFIO to still use strict mode.
>>>     As mentioned in the pdf, limit the freed memory with deferred invalidation only to
>>> be reused by the device, can mitigate the vulnerability. But it's too hard to implement
>>> it now.
>>>     A compromise maybe we only apply non-strict to (1) dma_free_coherent, because the
>>> memory is controlled by DMA common module, so we can make the memory to be freed after
>>> the global invalidation in the timer handler. (2) And provide some new APIs related to
>>> iommu_unmap_page/sg, these new APIs deferred invalidation. And the candiate device
>>> drivers update the APIs if they want to improve performance. (3) Make sure that only
>>> the trusted devices and trusted drivers can apply (1) and (2). For example, the driver
>>> must be built into kernel Image.
>>
>> Do we have a notion of untrusted kernel drivers? A userspace driver
> It seems impossible to have such driver. The modules insmod by root users should be
> guaranteed by themselves.
> 
>> (VFIO) is untrusted, ok. But a malicious driver loaded into the kernel
>> address space would have much easier ways to corrupt the system than to
>> exploit lazy mode...
> Yes, so that we have no need to consider untrusted drivers.
> 
>>
>> For (3), I agree that we should at least disallow lazy mode if
>> pci_dev->untrusted is set. At the moment it means that we require the
>> strictest IOMMU configuration for external-facing PCI ports, but it can
>> be extended to blacklist other vulnerable devices or locations.
> I plan to add an attribute file for each device, espcially for hotplug devices. And
> let the root users to decide which mode should be used, strict or non-strict. Becasue
> they should known whether the hot-plug divice is trusted or not.

Aside from the problem that without massive implementation changes 
strict/non-strict is at best a per-domain property, not a per-device 
one, I can't see this being particularly practical - surely the whole 
point of a malicious endpoint is that it's going to pretend to be some 
common device for which a 'trusted' kernel driver already exists? If 
you've chosen to trust *any* external device, I think you may as well 
have just set non-strict globally anyway. The effort involved in trying 
to implement super-fine-grained control seems hard to justify.

Robin.

>>
>> If you do (3) then maybe we don't need (1) and (2), which require a
>> tonne of work in the DMA and IOMMU layers (but would certainly be nice
>> to see, since it would also help handle ATS invalidation timeouts)
>>
>> Thanks,
>> Jean
>>
>>>     So that some high-end trusted devices use non-strict mode, and keep others still using
>>> strict mode. The drivers who want to use non-strict mode, should change to use new APIs
>>> by themselves.
>>>
>>>
>>>>>
>>>>> Why not keep the policy to secure by default, as we do for
>>>>> iommu.passthrough? And maybe add something similar to
>>>>> CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
>>>>> command-line argument or change the default config.
>>>>
>>>> Sorry for the late reply, it was Chinese new year, and we had a long discussion
>>>> internally, we are fine to add a Kconfig but not sure OS vendors will set it
>>>> to default y.
>>>>
>>>> OS vendors seems not happy to pass a command-line argument, to be honest,
>>>> this is our motivation to enable non-strict as default. Hope OS vendors
>>>> can see this email thread, and give some input here.
>>>>
>>>> Thanks
>>>> Hanjun
>>>>
>>>>
>>>> .
>>>>
>>>
>>
>>
>> .
>>
> 
