Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF5C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDEE2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfDDJrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:47:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfDDJq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ECFD168F;
        Thu,  4 Apr 2019 02:46:59 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D1A3F819;
        Thu,  4 Apr 2019 02:46:55 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64/mm: Enable ZONE_DEVICE
To:     Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>, james.morse@arm.com,
        Mark Rutland <mark.rutland@arm.com>, cpandya@codeaurora.org,
        arunks@codeaurora.org, osalvador@suse.de,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>, cai@lca.pw,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-7-git-send-email-anshuman.khandual@arm.com>
 <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com>
 <0d72db39-e20d-1cbd-368e-74dda9b6c936@arm.com>
 <CAPcyv4h5YskvjR306FsHnVHpPjnT4s2JPJXgk6CxiMz8bjhqkg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a16a9867-7019-10ab-1901-c114bcd8712b@arm.com>
Date:   Thu, 4 Apr 2019 10:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h5YskvjR306FsHnVHpPjnT4s2JPJXgk6CxiMz8bjhqkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 06:04, Dan Williams wrote:
> On Wed, Apr 3, 2019 at 9:42 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 04/03/2019 07:28 PM, Robin Murphy wrote:
>>> [ +Dan, Jerome ]
>>>
>>> On 03/04/2019 05:30, Anshuman Khandual wrote:
>>>> Arch implementation for functions which create or destroy vmemmap mapping
>>>> (vmemmap_populate, vmemmap_free) can comprehend and allocate from inside
>>>> device memory range through driver provided vmem_altmap structure which
>>>> fulfils all requirements to enable ZONE_DEVICE on the platform. Hence just
>>>
>>> ZONE_DEVICE is about more than just altmap support, no?
>>
>> Hot plugging the memory into a dev->numa_node's ZONE_DEVICE and initializing the
>> struct pages for it has stand alone and self contained use case. The driver could
>> just want to manage the memory itself but with struct pages either in the RAM or
>> in the device memory range through struct vmem_altmap. The driver may not choose
>> to opt for HMM, FS DAX, P2PDMA (use cases of ZONE_DEVICE) where it may have to
>> map these pages into any user pagetable which would necessitate support for
>> pte|pmd|pud_devmap.
> 
> What's left for ZONE_DEVICE if none of the above cases are used?
> 
>> Though I am still working towards getting HMM, FS DAX, P2PDMA enabled on arm64,
>> IMHO ZONE_DEVICE is self contained and can be evaluated in itself.
> 
> I'm not convinced. What's the specific use case.

The fundamental "roadmap" reason we've been doing this is to enable 
further NVDIMM/pmem development (libpmem/Qemu/etc.) on arm64. The fact 
that ZONE_DEVICE immediately opens the door to the various other stuff 
that the CCIX folks have interest in is a definite bonus, so it would 
certainly be preferable to get arm64 on par with the current state of 
things rather than try to subdivide the scope further.

I started working on this from the ZONE_DEVICE end, but got bogged down 
in trying to replace my copied-from-s390 dummy hot-remove implementation 
with something proper. Anshuman has stepped in to help with hot-remove 
(since we also have cloud folks wanting that for its own sake), so is 
effectively coming at the problem from the opposite direction, and I'll 
be the first to admit that we've not managed the greatest job of meeting 
in the middle and coordinating our upstream story; sorry about that :)

Let me freshen up my devmap patches and post them properly, since that 
discussion doesn't have to happen in the context of hot-remove; they're 
effectively just parallel dependencies for ZONE_DEVICE.

Robin.

>>
>>>
>>>> enable ZONE_DEVICE by subscribing to ARCH_HAS_ZONE_DEVICE. But this is only
>>>> applicable for ARM64_4K_PAGES (ARM64_SWAPPER_USES_SECTION_MAPS) only which
>>>> creates vmemmap section mappings and utilize vmem_altmap structure.
>>>
>>> What prevents it from working with other page sizes? One of the foremost use-cases for our 52-bit VA/PA support is to enable mapping large quantities of persistent memory, so we really do need this for 64K pages too. FWIW, it appears not to be an issue for PowerPC.
>>
>>
>> On !AR64_4K_PAGES vmemmap_populate() calls vmemmap_populate_basepages() which
>> does not support struct vmem_altmap right now. Originally was planning to send
>> the vmemmap_populate_basepages() enablement patches separately but will post it
>> here for review.
>>
>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    arch/arm64/Kconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index db3e625..b5d8cf5 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -31,6 +31,7 @@ config ARM64
>>>>        select ARCH_HAS_SYSCALL_WRAPPER
>>>>        select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
>>>>        select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>>> +    select ARCH_HAS_ZONE_DEVICE if ARM64_4K_PAGES
>>>
>>> IIRC certain configurations (HMM?) don't even build if you just turn this on alone (although of course things may have changed elsewhere in the meantime) - crucially, though, from previous discussions[1] it seems fundamentally unsafe, since I don't think we can guarantee that nobody will touch the corners of ZONE_DEVICE that also require pte_devmap in order not to go subtly wrong. I did get as far as cooking up some patches to sort that out [2][3] which I never got round to posting for their own sake, so please consider picking those up as part of this series.
>>
>> In the previous discussion mentioned here [1] it sort of indicates that we
>> cannot have a viable (ARCH_HAS_ZONE_DEVICE=y but !__HAVE_ARCH_PTE_DEVMAP). I
>> dont understand why !
> 
> Because ZONE_DEVICE was specifically invented to solve get_user_pages() for DAX.
> 
>> The driver can just hotplug the range into ZONE_DEVICE,
>> manage the memory itself without mapping them to user page table ever.
> 
> Then why do you even need 'struct page' objects?
> 
>> IIUC
>> ZONE_DEVICE must not need user mapped device PFN support.
> 
> No, you don't understand correctly, or I don't understand how you plan
> to use ZONE_DEVICE outside it's intended use case.
> 
>> All the corner case
>> problems discussed previously come in once these new 'device PFN' memory which
>> is now in ZONE_DEVICE get mapped into user page table.
>>
>>>
>>> Robin.
>>>
>>>>        select ARCH_HAVE_NMI_SAFE_CMPXCHG
>>>>        select ARCH_INLINE_READ_LOCK if !PREEMPT
>>>>        select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
>>>>
>>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/CAA9_cmfA9GS+1M1aSyv1ty5jKY3iho3CERhnRAruWJW3PfmpgA@mail.gmail.com/#t
>>> [2] http://linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=61816b833afdb56b49c2e58f5289ae18809e5d67
>>> [3] http://linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a5a16560eb1becf9a1d4cc0d03d6b5e76da4f4e1
>>> (apologies to anyone if the linux-arm.org server is being flaky as usual and requires a few tries to respond properly)
>>
>> I have not evaluated pte_devmap(). Will consider [3] when enabling it. But
>> I still dont understand why ZONE_DEVICE can not be enabled and used from a
>> driver which never requires user mapping or pte|pmd|pud_devmap() support.
> 
> Because there are mm paths that make assumptions about ZONE_DEVICE
> that your use case might violate.
> 
