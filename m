Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB90C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935CA20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEQDPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:15:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35064 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQDPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:15:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C33915AD;
        Thu, 16 May 2019 20:15:29 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4D93F5AF;
        Thu, 16 May 2019 20:15:18 -0700 (PDT)
Subject: Re: [PATCH V3 4/4] arm64/mm: Enable memory hot remove
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mhocko@suse.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-5-git-send-email-anshuman.khandual@arm.com>
 <20190515114911.GC23983@lakrids.cambridge.arm.com>
 <499ebd4b-c905-dd99-3fc7-66050d89dc35@arm.com>
 <20190516105741.GC40960@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f83469e3-c514-cc37-a7d0-c8b57e242ebe@arm.com>
Date:   Fri, 17 May 2019 08:45:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190516105741.GC40960@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/16/2019 04:27 PM, Mark Rutland wrote:
> On Thu, May 16, 2019 at 11:04:48AM +0530, Anshuman Khandual wrote:
>> On 05/15/2019 05:19 PM, Mark Rutland wrote:
>>> On Tue, May 14, 2019 at 02:30:07PM +0530, Anshuman Khandual wrote:
>>>> Memory removal from an arch perspective involves tearing down two different
>>>> kernel based mappings i.e vmemmap and linear while releasing related page
>>>> table and any mapped pages allocated for given physical memory range to be
>>>> removed.
>>>>
>>>> Define a common kernel page table tear down helper remove_pagetable() which
>>>> can be used to unmap given kernel virtual address range. In effect it can
>>>> tear down both vmemap or kernel linear mappings. This new helper is called
>>>> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
>>>>
>>>> For linear mapping there are no actual allocated pages which are mapped to
>>>> create the translation. Any pfn on a given entry is derived from physical
>>>> address (__va(PA) --> PA) whose linear translation is to be created. They
>>>> need not be freed as they were never allocated in the first place. But for
>>>> vmemmap which is a real virtual mapping (like vmalloc) physical pages are
>>>> allocated either from buddy or memblock which get mapped in the kernel page
>>>> table. These allocated and mapped pages need to be freed during translation
>>>> tear down. But page table pages need to be freed in both these cases.
>>>
>>> As previously discussed, we should only hot-remove memory which was
>>> hot-added, so we shouldn't encounter memory allocated from memblock.
>>
>> Right, not applicable any more. Will drop this word.
>>
>>>> These mappings need to be differentiated while deciding if a mapped page at
>>>> any level i.e [pte|pmd|pud]_page() should be freed or not. Callers for the
>>>> mapping tear down process should pass on 'sparse_vmap' variable identifying
>>>> kernel vmemmap mappings.
>>>
>>> I think that you can simplify the paragraphs above down to:
>>>
>>>   The arch code for hot-remove must tear down portions of the linear map
>>>   and vmemmap corresponding to memory being removed. In both cases the
>>>   page tables mapping these regions must be freed, and when sparse
>>>   vmemmap is in use the memory backing the vmemmap must also be freed.
>>>
>>>   This patch adds a new remove_pagetable() helper which can be used to
>>>   tear down either region, and calls it from vmemmap_free() and
>>>   ___remove_pgd_mapping(). The sparse_vmap argument determines whether
>>>   the backing memory will be freed.
>>
>> The current one is bit more descriptive on detail. Anyways will replace with
>> the above writeup if that is preferred.
> 
> I would prefer the suggested form above, as it's easier to extract the
> necessary details from it.

Fair enough.

> 
> [...]
> 
>>>> +static void
>>>> +remove_pagetable(unsigned long start, unsigned long end, bool sparse_vmap)
>>>> +{
>>>> +	unsigned long addr, next;
>>>> +	pud_t *pudp_base;
>>>> +	pgd_t *pgdp;
>>>> +
>>>> +	spin_lock(&init_mm.page_table_lock);
>>>
>>> It would be good to explain why we need to take the ptl here.
>>
>> Will update both commit message and add an in-code comment here.
>>
>>>
>>> IIUC that shouldn't be necessary for the linear map. Am I mistaken?
>>
>> Its not absolutely necessary for linear map right now because both memory hot
>> plug & ptdump which modifies or walks the page table ranges respectively take
>> memory hotplug lock. That apart, no other callers creates or destroys linear
>> mapping at runtime.
>>
>>>
>>> Is there a specific race when tearing down the vmemmap?
>>
>> This is trickier than linear map. vmemmap additions would be protected with
>> memory hotplug lock but this can potential collide with vmalloc/IO regions.
>> Even if they dont right now that will be because they dont share intermediate
>> page table levels.
> 
> Sure; if we could just state something like:
> 
>   The vmemmap region may share levels of table with the vmalloc region.
>   Take the ptl so that we can safely free potentially-sahred tables.
> 
> ... I think that would be sufficient.

Will do.
