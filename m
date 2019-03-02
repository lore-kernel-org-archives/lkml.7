Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 06:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E66206DD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCBGNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 01:13:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbfCBGNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 01:13:01 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C2181738D0A63C084325;
        Sat,  2 Mar 2019 14:12:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 2 Mar 2019
 14:12:50 +0800
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
 <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
 <dc06dfd0-0ab6-6f0b-64c6-2587a2a55798@huawei.com>
 <5C78B89C.7040100@huawei.com> <e567cf93-4e34-e15e-9d98-5834bc63e234@arm.com>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5C7A1EE1.6020200@huawei.com>
Date:   Sat, 2 Mar 2019 14:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <e567cf93-4e34-e15e-9d98-5834bc63e234@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/1 19:07, Jean-Philippe Brucker wrote:
> Hi Leizhen,
> 
> On 01/03/2019 04:44, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2019/2/26 20:36, Hanjun Guo wrote:
>>> Hi Jean,
>>>
>>> On 2019/1/31 22:55, Jean-Philippe Brucker wrote:
>>>> Hi,
>>>>
>>>> On 31/01/2019 13:52, Zhen Lei wrote:
>>>>> Currently, many peripherals are faster than before. For example, the top
>>>>> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
>>>>> when iommu page-table mapping enabled, it's hard to reach the top speed
>>>>> in strict mode, because of frequently map and unmap operations. In order
>>>>> to keep abreast of the times, I think it's better to set non-strict as
>>>>> default.
>>>>
>>>> Most users won't be aware of this relaxation and will have their system
>>>> vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
>>>> Invalidation in
>>>> http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf
>> Hi Jean,
>>
>>    In fact, we have discussed the vulnerable of deferred invalidation before upstream
>> the non-strict patches. The attacks maybe possible because of an untrusted device or
>> the mistake of the device driver. And we limited the VFIO to still use strict mode.
>>    As mentioned in the pdf, limit the freed memory with deferred invalidation only to
>> be reused by the device, can mitigate the vulnerability. But it's too hard to implement
>> it now.
>>    A compromise maybe we only apply non-strict to (1) dma_free_coherent, because the
>> memory is controlled by DMA common module, so we can make the memory to be freed after
>> the global invalidation in the timer handler. (2) And provide some new APIs related to
>> iommu_unmap_page/sg, these new APIs deferred invalidation. And the candiate device
>> drivers update the APIs if they want to improve performance. (3) Make sure that only
>> the trusted devices and trusted drivers can apply (1) and (2). For example, the driver
>> must be built into kernel Image.
> 
> Do we have a notion of untrusted kernel drivers? A userspace driver
It seems impossible to have such driver. The modules insmod by root users should be
guaranteed by themselves.

> (VFIO) is untrusted, ok. But a malicious driver loaded into the kernel
> address space would have much easier ways to corrupt the system than to
> exploit lazy mode...
Yes, so that we have no need to consider untrusted drivers.

> 
> For (3), I agree that we should at least disallow lazy mode if
> pci_dev->untrusted is set. At the moment it means that we require the
> strictest IOMMU configuration for external-facing PCI ports, but it can
> be extended to blacklist other vulnerable devices or locations.
I plan to add an attribute file for each device, espcially for hotplug devices. And
let the root users to decide which mode should be used, strict or non-strict. Becasue
they should known whether the hot-plug divice is trusted or not.

> 
> If you do (3) then maybe we don't need (1) and (2), which require a
> tonne of work in the DMA and IOMMU layers (but would certainly be nice
> to see, since it would also help handle ATS invalidation timeouts)
> 
> Thanks,
> Jean
> 
>>    So that some high-end trusted devices use non-strict mode, and keep others still using
>> strict mode. The drivers who want to use non-strict mode, should change to use new APIs
>> by themselves.
>>
>>
>>>>
>>>> Why not keep the policy to secure by default, as we do for
>>>> iommu.passthrough? And maybe add something similar to
>>>> CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
>>>> command-line argument or change the default config.
>>>
>>> Sorry for the late reply, it was Chinese new year, and we had a long discussion
>>> internally, we are fine to add a Kconfig but not sure OS vendors will set it
>>> to default y.
>>>
>>> OS vendors seems not happy to pass a command-line argument, to be honest,
>>> this is our motivation to enable non-strict as default. Hope OS vendors
>>> can see this email thread, and give some input here.
>>>
>>> Thanks
>>> Hanjun
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 

-- 
Thanks!
BestRegards

