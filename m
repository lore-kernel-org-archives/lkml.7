Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD3CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6D620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfHAHjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:39:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfHAHjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:39:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79E7FB11C;
        Thu,  1 Aug 2019 07:39:43 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:39:40 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Allocate memmap from hotadded memory
Message-ID: <20190801073931.GA16659@linux>
References: <20190725160207.19579-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725160207.19579-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:02:02PM +0200, Oscar Salvador wrote:
> Here we go with v3.
> 
> v3 -> v2:
>         * Rewrite about vmemmap pages handling.
>           Prior to this version, I was (ab)using hugepages fields
>           from struct page, while here I am officially adding a new
>           sub-page type with the fields I need.
> 
>         * Drop MHP_MEMMAP_{MEMBLOCK,DEVICE} in favor of MHP_MEMMAP_ON_MEMORY.
>           While I am still not 100% if this the right decision, and while I
>           still see some gaining in having MHP_MEMMAP_{MEMBLOCK,DEVICE},
>           having only one flag ease the code.
>           If the user wants to allocate memmaps per memblock, it'll
>           have to call add_memory() variants with memory-block granularity.
> 
>           If we happen to have a more clear usecase MHP_MEMMAP_MEMBLOCK
>           flag in the future, so user does not have to bother about the way
>           it calls add_memory() variants, but only pass a flag, we can add it.
>           Actually, I already had the code, so add it in the future is going to be
>           easy.
> 
>         * Granularity check when hot-removing memory.
>           Just checking that the granularity is the same.
> 
> [Testing]
> 
>  - x86_64: small and large memblocks (128MB, 1G and 2G)
> 
> So far, only acpi memory hotplug uses the new flag.
> The other callers can be changed depending on their needs.
> 
> [Coverletter]
> 
> This is another step to make memory hotplug more usable. The primary
> goal of this patchset is to reduce memory overhead of the hot-added
> memory (at least for SPARSEMEM_VMEMMAP memory model). The current way we use
> to populate memmap (struct page array) has two main drawbacks:
> 
> a) it consumes an additional memory until the hotadded memory itself is
>    onlined and
> b) memmap might end up on a different numa node which is especially true
>    for movable_node configuration.
> 
> a) it is a problem especially for memory hotplug based memory "ballooning"
>    solutions when the delay between physical memory hotplug and the
>    onlining can lead to OOM and that led to introduction of hacks like auto
>    onlining (see 31bc3858ea3e ("memory-hotplug: add automatic onlining
>    policy for the newly added memory")).
> 
> b) can have performance drawbacks.
> 
> One way to mitigate all these issues is to simply allocate memmap array
> (which is the largest memory footprint of the physical memory hotplug)
> from the hot-added memory itself. SPARSEMEM_VMEMMAP memory model allows
> us to map any pfn range so the memory doesn't need to be online to be
> usable for the array. See patch 3 for more details.
> This feature is only usable when CONFIG_SPARSEMEM_VMEMMAP is set.
> 
> [Overall design]:
> 
> Implementation wise we reuse vmem_altmap infrastructure to override
> the default allocator used by vmemap_populate. Once the memmap is
> allocated we need a way to mark altmap pfns used for the allocation.
> If MHP_MEMMAP_ON_MEMORY flag was passed, we set up the layout of the
> altmap structure at the beginning of __add_pages(), and then we call
> mark_vmemmap_pages().
> 
> MHP_MEMMAP_ON_MEMORY flag parameter will specify to allocate memmaps
> from the hot-added range.
> If callers wants memmaps to be allocated per memory block, it will
> have to call add_memory() variants in memory-block granularity
> spanning the whole range, while if it wants to allocate memmaps
> per whole memory range, just one call will do.
> 
> Want to add 384MB (3 sections, 3 memory-blocks)
> e.g:
> 
> add_memory(0x1000, size_memory_block);
> add_memory(0x2000, size_memory_block);
> add_memory(0x3000, size_memory_block);
> 
> or
> 
> add_memory(0x1000, size_memory_block * 3);
> 
> One thing worth mention is that vmemmap pages residing in movable memory is not a
> show-stopper for that memory to be offlined/migrated away.
> Vmemmap pages are just ignored in that case and they stick around until sections
> referred by those vmemmap pages are hot-removed.

Gentle ping :-)

-- 
Oscar Salvador
SUSE L3
