Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C087C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A4520700
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDDFD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:03:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51648 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfDDFDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:03:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496C7A78;
        Wed,  3 Apr 2019 22:03:24 -0700 (PDT)
Received: from [10.162.40.100] (p8cg001049571a15.blr.arm.com [10.162.40.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 182453F557;
        Wed,  3 Apr 2019 22:03:17 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64/mm: Enable ZONE_DEVICE
To:     Jerome Glisse <jglisse@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mhocko@suse.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, david@redhat.com, cai@lca.pw
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-7-git-send-email-anshuman.khandual@arm.com>
 <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com>
 <20190403160722.GB12818@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4507c5b0-0a96-6e28-d98c-06e3a696551c@arm.com>
Date:   Thu, 4 Apr 2019 10:33:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190403160722.GB12818@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2019 09:37 PM, Jerome Glisse wrote:
> On Wed, Apr 03, 2019 at 02:58:28PM +0100, Robin Murphy wrote:
>> [ +Dan, Jerome ]
>>
>> On 03/04/2019 05:30, Anshuman Khandual wrote:
>>> Arch implementation for functions which create or destroy vmemmap mapping
>>> (vmemmap_populate, vmemmap_free) can comprehend and allocate from inside
>>> device memory range through driver provided vmem_altmap structure which
>>> fulfils all requirements to enable ZONE_DEVICE on the platform. Hence just
>>
>> ZONE_DEVICE is about more than just altmap support, no?
>>
>>> enable ZONE_DEVICE by subscribing to ARCH_HAS_ZONE_DEVICE. But this is only
>>> applicable for ARM64_4K_PAGES (ARM64_SWAPPER_USES_SECTION_MAPS) only which
>>> creates vmemmap section mappings and utilize vmem_altmap structure.
>>
>> What prevents it from working with other page sizes? One of the foremost
>> use-cases for our 52-bit VA/PA support is to enable mapping large quantities
>> of persistent memory, so we really do need this for 64K pages too. FWIW, it
>> appears not to be an issue for PowerPC.
>>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>   arch/arm64/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index db3e625..b5d8cf5 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -31,6 +31,7 @@ config ARM64
>>>   	select ARCH_HAS_SYSCALL_WRAPPER
>>>   	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
>>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>> +	select ARCH_HAS_ZONE_DEVICE if ARM64_4K_PAGES
>>
>> IIRC certain configurations (HMM?) don't even build if you just turn this on
>> alone (although of course things may have changed elsewhere in the meantime)
>> - crucially, though, from previous discussions[1] it seems fundamentally
>> unsafe, since I don't think we can guarantee that nobody will touch the
>> corners of ZONE_DEVICE that also require pte_devmap in order not to go
>> subtly wrong. I did get as far as cooking up some patches to sort that out
>> [2][3] which I never got round to posting for their own sake, so please
>> consider picking those up as part of this series.
> 
> Correct _do not_ enable ZONE_DEVICE without support for pte_devmap detection.

Driver managed ZONE_DEVICE memory which never maps into user page table is not
a valid use case for ZONE_DEVICE ? Also what about MEMORY_DEVICE_PRIVATE ? That
can never be mapped into user page table. A driver can still manage these non
coherent memory through it's struct pages (which will be allocated inside RAM)

> If you want some feature of ZONE_DEVICE. Like HMM as while DAX does require
> pte_devmap, HMM device private does not. So you would first have to split
> ZONE_DEVICE into more sub-features kconfig option.

CONFIG_ZONE_DEVICE does not do that already ! All it says is that a device
memory range can be plugged into ZONE_DEVICE either as PRIVATE (non-coherent)
or PUBLIC/PCI_P2PDMA (coherent) memory without mandating anything about how
these memory will be further used.

> 
> What is the end use case you are looking for ? Persistent memory ?

Persistent memory is one of the primary use cases.
