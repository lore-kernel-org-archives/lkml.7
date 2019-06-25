Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D86C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6C920659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfFYHxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:53:06 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:56493 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfFYHxG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 25 Jun 2019 03:53:06 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 25 Jun 2019 09:53:04 +0200
Received: from suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 25 Jun 2019 08:52:33 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        david@redhat.com, anshuman.khandual@arm.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/5] Allocate memmap from hotadded memory
Date:   Tue, 25 Jun 2019 09:52:22 +0200
Message-Id: <20190625075227.15193-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It has been while since I sent previous version [1].

In this version I added some feedback I got back then, like letting
the caller decide whether he wants allocating per memory block or
per memory range (patch#2), and having the chance to disable vmemmap when
users want to expose all hotpluggable memory to userspace (patch#5).

[Testing]

While I could test last version on powerpc, and Huawei's fellows helped me out
testing it on arm64, this time I could only test it on x86_64.
The codebase is quite the same, so I would not expect surprises.

 - x86_64: small and large memblocks (128MB, 1G and 2G)
 - Kernel module that adds memory spanning multiple memblocks
   and remove that memory in a different granularity.

So far, only acpi memory hotplug uses the new flag.
The other callers can be changed depending on their needs.

Of course, more testing and feedback is appreciated.

[Coverletter]

This is another step to make memory hotplug more usable. The primary
goal of this patchset is to reduce memory overhead of the hot-added
memory (at least for SPARSEMEM_VMEMMAP memory model). The current way we use
to populate memmap (struct page array) has two main drawbacks:

a) it consumes an additional memory until the hotadded memory itself is
   onlined and
b) memmap might end up on a different numa node which is especially true
   for movable_node configuration.

a) it is a problem especially for memory hotplug based memory "ballooning"
   solutions when the delay between physical memory hotplug and the
   onlining can lead to OOM and that led to introduction of hacks like auto
   onlining (see 31bc3858ea3e ("memory-hotplug: add automatic onlining
   policy for the newly added memory")).

b) can have performance drawbacks.

Another minor case is that I have seen hot-add operations failing on archs
because they were running out of order-x pages.
E.g On powerpc, in certain configurations, we use order-8 pages,
and given 64KB base pagesize, that is 16MB.
If we run out of those, we just fail the operation and we cannot add
more memory.
We could fallback to base pages as x86_64 does, but we can do better.

One way to mitigate all these issues is to simply allocate memmap array
(which is the largest memory footprint of the physical memory hotplug)
from the hot-added memory itself. SPARSEMEM_VMEMMAP memory model allows
us to map any pfn range so the memory doesn't need to be online to be
usable for the array. See patch 3 for more details.
This feature is only usable when CONFIG_SPARSEMEM_VMEMMAP is set.

[Overall design]:

Implementation wise we reuse vmem_altmap infrastructure to override
the default allocator used by vmemap_populate. Once the memmap is
allocated we need a way to mark altmap pfns used for the allocation.
If MHP_MEMMAP_{DEVICE,MEMBLOCK} flag was passed, we set up the layout of the
altmap structure at the beginning of __add_pages(), and then we call
mark_vmemmap_pages().

The flags are either MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK, and only differ
in the way they allocate vmemmap pages within the memory blocks.

MHP_MEMMAP_MEMBLOCK:
        - With this flag, we will allocate vmemmap pages in each memory block.
          This means that if we hot-add a range that spans multiple memory blocks,
          we will use the beginning of each memory block for the vmemmap pages.
          This strategy is good for cases where the caller wants the flexiblity
          to hot-remove memory in a different granularity than when it was added.

MHP_MEMMAP_DEVICE:
        - With this flag, we will store all vmemmap pages at the beginning of
          hot-added memory.

So it is a tradeoff of flexiblity vs contigous memory.
More info on the above can be found in patch#2.

Depending on which flag is passed (MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK),
mark_vmemmap_pages() gets called at a different stage.
With MHP_MEMMAP_MEMBLOCK, we call it once we have populated the sections
fitting in a single memblock, while with MHP_MEMMAP_DEVICE we wait until all
sections have been populated.

mark_vmemmap_pages() marks the pages as vmemmap and sets some metadata:

The current layout of the Vmemmap pages are:

        [Head->refcount] : Nr sections used by this altmap
        [Head->private]  : Nr of vmemmap pages
        [Tail->freelist] : Pointer to the head page

This is done to easy the computation we need in some places.
E.g:

Example 1)
We hot-add 1GB on x86_64 (memory block 128MB) using
MHP_MEMMAP_DEVICE:

head->_refcount = 8 sections
head->private = 4096 vmemmap pages
tail's->freelist = head

Example 2)
We hot-add 1GB on x86_64 using MHP_MEMMAP_MEMBLOCK:

[at the beginning of each memblock]
head->_refcount = 1 section
head->private = 512 vmemmap pages
tail's->freelist = head

We have the refcount because when using MHP_MEMMAP_DEVICE, we need to know
how much do we have to defer the call to vmemmap_free().
The thing is that the first pages of the hot-added range are used to create
the memmap mapping, so we cannot remove those first, otherwise we would blow up
when accessing the other pages.

What we do is that since when we hot-remove a memory-range, sections are being
removed sequentially, we wait until we hit the last section, and then we free
the hole range to vmemmap_free backwards.
We know that it is the last section because in every pass we
decrease head->_refcount, and when it reaches 0, we got our last section.

We also have to be careful about those pages during online and offline
operations. They are simply skipped, so online will keep them
reserved and so unusable for any other purpose and offline ignores them
so they do not block the offline operation.

One thing worth mention is that vmemmap pages residing in movable memory is not a
show-stopper for that memory to be offlined/migrated away.
Vmemmap pages are just ignored in that case and they stick around until sections
referred by those vmemmap pages are hot-removed.

[1] https://patchwork.kernel.org/cover/10875017/

Oscar Salvador (5):
  drivers/base/memory: Remove unneeded check in
    remove_memory_block_devices
  mm,memory_hotplug: Introduce MHP_VMEMMAP_FLAGS
  mm,memory_hotplug: Introduce Vmemmap page helpers
  mm,memory_hotplug: allocate memmap from the added memory range for
    sparse-vmemmap
  mm,memory_hotplug: Allow userspace to enable/disable vmemmap

 arch/arm64/mm/mmu.c            |   5 +-
 arch/powerpc/mm/init_64.c      |   7 ++
 arch/s390/mm/init.c            |   6 ++
 arch/x86/mm/init_64.c          |  10 +++
 drivers/acpi/acpi_memhotplug.c |   2 +-
 drivers/base/memory.c          |  41 +++++++++--
 drivers/dax/kmem.c             |   2 +-
 drivers/hv/hv_balloon.c        |   2 +-
 drivers/s390/char/sclp_cmd.c   |   2 +-
 drivers/xen/balloon.c          |   2 +-
 include/linux/memory_hotplug.h |  31 ++++++++-
 include/linux/memremap.h       |   2 +-
 include/linux/page-flags.h     |  34 +++++++++
 mm/compaction.c                |   7 ++
 mm/memory_hotplug.c            | 152 ++++++++++++++++++++++++++++++++++-------
 mm/page_alloc.c                |  22 +++++-
 mm/page_isolation.c            |  14 +++-
 mm/sparse.c                    |  93 +++++++++++++++++++++++++
 mm/util.c                      |   2 +
 19 files changed, 394 insertions(+), 42 deletions(-)

-- 
2.12.3

