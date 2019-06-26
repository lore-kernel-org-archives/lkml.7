Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05737C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF8E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFZIDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:03:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfFZIDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16173AE20;
        Wed, 26 Jun 2019 08:03:07 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:03:03 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190626080249.GA30863@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:25:48AM +0200, David Hildenbrand wrote:
> > [Coverletter]
> > 
> > This is another step to make memory hotplug more usable. The primary
> > goal of this patchset is to reduce memory overhead of the hot-added
> > memory (at least for SPARSEMEM_VMEMMAP memory model). The current way we use
> > to populate memmap (struct page array) has two main drawbacks:

First off, thanks for looking into this :-)

> 
> Mental note: How will it be handled if a caller specifies "Allocate
> memmap from hotadded memory", but we are running under SPARSEMEM where
> we can't do this.

In add_memory_resource(), we have a call to mhp_check_correct_flags(), which is
in charge of checking if the flags passed are compliant with our configuration
among other things.
It also checks if both flags were passed (_MEMBLOCK|_DEVICE).

If a) any of the flags were specified and we are not on CONFIG_SPARSEMEM_VMEMMAP,
b) the flags are colliding with each other or c) the flags just do not make sense,
we print out a warning and drop the flags to 0, so we just ignore them.

I just realized that I can adjust the check even more (something for the next
version).

But to answer your question, flags are ignored under !CONFIG_SPARSEMEM_VMEMMAP.

> 
> > 
> > a) it consumes an additional memory until the hotadded memory itself is
> >    onlined and
> > b) memmap might end up on a different numa node which is especially true
> >    for movable_node configuration.
> > 
> > a) it is a problem especially for memory hotplug based memory "ballooning"
> >    solutions when the delay between physical memory hotplug and the
> >    onlining can lead to OOM and that led to introduction of hacks like auto
> >    onlining (see 31bc3858ea3e ("memory-hotplug: add automatic onlining
> >    policy for the newly added memory")).
> > 
> > b) can have performance drawbacks.
> > 
> > Another minor case is that I have seen hot-add operations failing on archs
> > because they were running out of order-x pages.
> > E.g On powerpc, in certain configurations, we use order-8 pages,
> > and given 64KB base pagesize, that is 16MB.
> > If we run out of those, we just fail the operation and we cannot add
> > more memory.
> 
> At least for SPARSEMEM, we fallback to vmalloc() to work around this
> issue. I haven't looked into the populate_section_memmap() internals
> yet. Can you point me at the code that performs this allocation?

Yes, on SPARSEMEM we first try to allocate the pages physical configuous, and
then fallback to vmalloc.
This is because on CONFIG_SPARSEMEM memory model, the translations pfn_to_page/
page_to_pfn do not expect the memory to be contiguous.

But that is not the case on CONFIG_SPARSEMEM_VMEMMAP.
We do expect the memory to be physical contigous there, that is why a simply
pfn_to_page/page_to_pfn is a matter of adding/substracting vmemmap/pfn.

Powerpc code is at:

https://elixir.bootlin.com/linux/v5.2-rc6/source/arch/powerpc/mm/init_64.c#L175



> So, assuming we add_memory(1GB, MHP_MEMMAP_DEVICE) and then
> remove_memory(128MB) of the added memory, this will work?

No, MHP_MEMMAP_DEVICE is meant to be used when hot-adding and hot-removing work
in the same granularity.
This is because all memmap pages will be stored at the beginning of the memory
range.
Allowing hot-removing in a different granularity on MHP_MEMMAP_DEVICE would imply
a lot of extra work.
For example, we would have to parse the vmemmap-head of the hot-removed range,
and punch a hole in there to clear the vmemmap pages, and then be very carefull
when deleting those pagetables.

So I followed Michal's advice, and I decided to let the caller specify if he
either wants to allocate per memory block or per hot-added range(device).
Where per memory block, allows us to do:

add_memory(1GB, MHP_MEMMAP_MEMBLOCK)
remove_memory(128MB)


> add_memory(8GB, MHP_MEMMAP_DEVICE)
> 
> For 8GB, we will need exactly 128MB of memmap if I did the math right.
> So exactly one section. This section will still be marked as being
> online (although not pages on it are actually online)?

Yap, 8GB will fill the first section with vmemmap pages.
It will be marked as online, yes.
This is not to diverge too much from what we have right now, and starting
treat some sections different than others.
E.g: Early sections that are used for memmap pages on early boot stage.

> > 
> > What we do is that since when we hot-remove a memory-range, sections are being
> > removed sequentially, we wait until we hit the last section, and then we free
> > the hole range to vmemmap_free backwards.
> > We know that it is the last section because in every pass we
> > decrease head->_refcount, and when it reaches 0, we got our last section.
> > 
> > We also have to be careful about those pages during online and offline
> > operations. They are simply skipped, so online will keep them
> > reserved and so unusable for any other purpose and offline ignores them
> > so they do not block the offline operation.
> 
> I assume that they will still be dumped normally by user space. (as they
> are described by a "memory resource" and not PG_Offline)

They are PG_Reserved.
Anyway, you mean by crash-tool?


-- 
Oscar Salvador
SUSE L3
