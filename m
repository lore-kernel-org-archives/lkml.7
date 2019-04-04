Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6983CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDD92075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfDDIXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:23:55 -0400
Received: from foss.arm.com ([217.140.101.70]:54228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDDIXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:23:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E851C80D;
        Thu,  4 Apr 2019 01:23:53 -0700 (PDT)
Received: from [10.162.40.100] (p8cg001049571a15.blr.arm.com [10.162.40.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD773F557;
        Thu,  4 Apr 2019 01:23:47 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/mm: Enable memory hot remove
To:     Robin Murphy <robin.murphy@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, david@redhat.com,
        cai@lca.pw, pasha.tatashin@oracle.com,
        Stephen Bates <sbates@raithlin.com>, james.morse@arm.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
 <f2ea761c-49b2-88f6-14fa-5aaec57952cb@deltatee.com>
 <85fbfe49-d49e-fd6e-21dd-ff4d9808610b@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <755a1c1a-12ac-e081-c315-117de53f7a4b@arm.com>
Date:   Thu, 4 Apr 2019 13:53:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <85fbfe49-d49e-fd6e-21dd-ff4d9808610b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2019 11:27 PM, Robin Murphy wrote:
> On 03/04/2019 18:32, Logan Gunthorpe wrote:
>>
>>
>> On 2019-04-02 10:30 p.m., Anshuman Khandual wrote:
>>> Memory removal from an arch perspective involves tearing down two different
>>> kernel based mappings i.e vmemmap and linear while releasing related page
>>> table pages allocated for the physical memory range to be removed.
>>>
>>> Define a common kernel page table tear down helper remove_pagetable() which
>>> can be used to unmap given kernel virtual address range. In effect it can
>>> tear down both vmemap or kernel linear mappings. This new helper is called
>>> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
>>> The argument 'direct' here identifies kernel linear mappings.
>>>
>>> Vmemmap mappings page table pages are allocated through sparse mem helper
>>> functions like vmemmap_alloc_block() which does not cycle the pages through
>>> pgtable_page_ctor() constructs. Hence while removing it skips corresponding
>>> destructor construct pgtable_page_dtor().
>>>
>>> While here update arch_add_mempory() to handle __add_pages() failures by
>>> just unmapping recently added kernel linear mapping. Now enable memory hot
>>> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>>>
>>> This implementation is overall inspired from kernel page table tear down
>>> procedure on X86 architecture.
>>
>> I've been working on very similar things for RISC-V. In fact, I'm
>> currently in progress on a very similar stripped down version of
>> remove_pagetable(). (Though I'm fairly certain I've done a bunch of
>> stuff wrong.)
>>
>> Would it be possible to move this work into common code that can be used
>> by all arches? Seems like, to start, we should be able to support both
>> arm64 and RISC-V... and maybe even x86 too.
>>
>> I'd be happy to help integrate and test such functions in RISC-V.

I am more inclined towards consolidating remove_pagetable() across platforms
like arm64 and RISC-V (probably others). But there are clear distinctions
between user page table and kernel page table tear down process.

> 
> Indeed, I had hoped we might be able to piggyback off generic code for this anyway,
> given that we have generic pagetable code which knows how to free process pagetables,
> and kernel pagetables are also pagetables.

But there are differences. To list some

* Freeing mapped and pagetable pages

	- Memory hot remove deals with both vmemmap and linear mappings
	- Selectively call pgtable_page_dtor() for linear mappings (arch specific)
	- Not actually freeing PTE|PMD|PUD mapped pages for linear mappings
	- Freeing mapped pages for vmemap mappings

* TLB shootdown

	- User page table process uses mmu_gather mechanism for TLB flush
	- Kernel page table tear down can do with less TLB flush invocations
		- Dont have to care about flush deferral etc

* THP and HugeTLB

	- Kernel page table tear down procedure does not have to understand THP or HugeTLB
	- Though it has to understand possible arch specific special block mappings

		- Specific kernel linear mappings on arm64
			- PUD|PMD|CONT_PMD|CONT_PTE large page mappings

		- Specific vmemmap mappings on arm64
			- PMD large or PTE mappings

	-User page table tear down procedure needs to understand THP and HugeTLB

* Page table locking

	- Kernel procedure locks init_mm.page_table_lock while clearing an individual entry
	- Kernel procedure does not have to worry about mmap_sem

* ZONE_DEVICE struct vmem_altmap

	- Kernel page table tear down procedure needs to accommodate 'struct vmem_altmap' when
	vmemmap mappings are created with pages allocated from 'struct vmem_altmap' (ZONE_DEVICE)
	rather than buddy allocator or memblock.
