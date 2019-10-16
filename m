Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD06ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E986A2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbfJPIMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfJPIMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:12:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8D58801685;
        Wed, 16 Oct 2019 08:12:38 +0000 (UTC)
Received: from [10.36.117.237] (ovpn-117-237.ams2.redhat.com [10.36.117.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 424FB60852;
        Wed, 16 Oct 2019 08:12:23 +0000 (UTC)
Subject: Re: [PATCH RFC v3 0/9] virtio-mem: paravirtualized memory
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Wang <jasowang@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>, Len Brown <lenb@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yu Zhao <yuzhao@google.com>
References: <20190919142228.5483-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <237f70f5-76f7-59b3-072c-39578ba6f43a@redhat.com>
Date:   Wed, 16 Oct 2019 10:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919142228.5483-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 16 Oct 2019 08:12:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.19 16:22, David Hildenbrand wrote:
> Long time no RFC! I finally had time to get the next version of the Linux
> driver side of virtio-mem into shape, incorporating ideas and feedback from
> previous discussions.
> 
> This RFC is based on the series currently on the mm list:
> - [PATCH 0/3] Remove __online_page_set_limits()
> - [PATCH v1 0/3] mm/memory_hotplug: Export generic_online_page()
> - [PATCH v4 0/8] mm/memory_hotplug: Shrink zones before removing memory
> The current state (kept updated) is available on
> - https://github.com/davidhildenbrand/linux/tree/virtio-mem
> 
> The basic idea of virtio-mem is to provide a flexible,
> cross-architecture memory hot(un)plug solution that avoids many limitations
> imposed by existing technologies, architectures, and interfaces. More
> details can be found below and in linked material.
> 
> This RFC was only tested on x86-64, however, should theoretically work
> on any Linux architecture that implements memory hot(un)plug - like
> s390x. On x86-64, it is currently possible to add/remove memory to the
> system in >= 4MB granularity. Memory hotplug works very reliable. For
> memory unplug, there are no guarantees how much memory can actually get
> unplugged, it depends on the setup. I have plans to improve that in the
> future.
> 
> --------------------------------------------------------------------------
> 1. virtio-mem
> --------------------------------------------------------------------------
> 
> The basic idea behind virtio-mem was presented at KVM Forum 2018. The
> slides can be found at [1]. The previous RFC can be found at [2]. The
> first RFC can be found at [3]. However, the concept evolved over time. The
> KVM Forum slides roughly match the current design.
> 
> Patch #2 ("virtio-mem: Paravirtualized memory hotplug") contains quite some
> information, especially in "include/uapi/linux/virtio_mem.h":
> 
>    Each virtio-mem device manages a dedicated region in physical address
>    space. Each device can belong to a single NUMA node, multiple devices
>    for a single NUMA node are possible. A virtio-mem device is like a
>    "resizable DIMM" consisting of small memory blocks that can be plugged
>    or unplugged. The device driver is responsible for (un)plugging memory
>    blocks on demand.
> 
>    Virtio-mem devices can only operate on their assigned memory region in
>    order to (un)plug memory. A device cannot (un)plug memory belonging to
>    other devices.
> 
>    The "region_size" corresponds to the maximum amount of memory that can
>    be provided by a device. The "size" corresponds to the amount of memory
>    that is currently plugged. "requested_size" corresponds to a request
>    from the device to the device driver to (un)plug blocks. The
>    device driver should try to (un)plug blocks in order to reach the
>    "requested_size". It is impossible to plug more memory than requested.
> 
>    The "usable_region_size" represents the memory region that can actually
>    be used to (un)plug memory. It is always at least as big as the
>    "requested_size" and will grow dynamically. It will only shrink when
>    explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
> 
>    Memory in the usable region can usually be read, however, there are no
>    guarantees. It can happen that the device cannot process a request,
>    because it is busy. The device driver has to retry later.
> 
>    Usually, during system resets all memory will get unplugged, so the
>    device driver can start with a clean state. However, in specific
>    scenarios (if the device is busy) it can happen that the device still
>    has memory plugged. The device driver can request to unplug all memory
>    (VIRTIO_MEM_REQ_UNPLUG) - which might take a while to succeed if the
>    device is busy.
> 
> --------------------------------------------------------------------------
> 2. Linux Implementation
> --------------------------------------------------------------------------
> 
> This RFC reuses quite some existing MM infrastructure, however, has to
> expose some additional functionality.
> 
> Memory blocks (e.g., 128MB) are added/removed on demand. Within these
> memory blocks, subblocks (e.g., 4MB) are plugged/unplugged. The sizes
> depend on the target architecture, MAX_ORDER + pageblock_order, and
> the block size of a virtio-mem device.
> 
> add_memory()/try_remove_memory() is used to add/remove memory blocks.
> virtio-mem will not online memory blocks itself. This has to be done by
> user space, or configured into the kernel
> (CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE). virtio-mem will only unplug memory
> that was online to the ZONE_NORMAL. Memory is suggested to be onlined to
> the ZONE_NORMAL for now.
> 
> The memory hotplug notifier is used to properly synchronize against
> onlining/offlining of memory blocks and to track the states of memory
> blocks (including the zone memory blocks are onlined to). Locking is
> done similar to the PPC CMA implementation.
> 
> The set_online_page() callback is used to keep unplugged subblocks
> of a memory block fake-offline when onlining the memory block.
> generic_online_page() is used to fake-online plugged subblocks. This
> handling is similar to the Hyper-V balloon driver.
> 
> PG_offline is used to mark unplugged subblocks as offline, so e.g.,
> dumping tools (makedumpfile) will skip these pages. This is similar to
> other balloon drivers like virtio-balloon and Hyper-V.
> 
> PG_offline + reference count of 0 [new] is now also used to mark pages as
> a "skip" when offlining memory blocks. This allows to offline memory blocks
> that have partially unplugged subblocks - or are completely unplugged.
> 
> alloc_contig_range()/free_contig_range() [now exposed] is used to
> unplug/plug subblocks of memory blocks the are already exposed to Linux.
> 
> offline_and_remove_memory() [new] is used to offline a fully unplugged
> memory block and remove it from Linux.
> 
> 
> A lot of additional information can be found in the separate patches and
> as comments in the code itself.
> 
> --------------------------------------------------------------------------
> 3. Major changes since last RFC
> --------------------------------------------------------------------------
> 
> A lot of things changed, especially also on the QEMU + virtio side. The
> biggest changes on the Linux driver side are:
> - Onlining/offlining of subblocks is now emulated on top of memory blocks.
>    set_online_page()+alloc_contig_range()+free_contig_range() is now used
>    for that. Core MM does not have to be modified and will continue to
>    online/offline full memory blocks.
> - Onlining/offlining of memory blocks is no longer performed by virtio-mem.
> - Pg_offline is upstream and can be used. It is also used to allow
>    offlining of partially unplugged memory blocks.
> - Memory block states + subblocks are now tracked more space-efficient.
> - Proper kexec(), kdump(), driver unload, driver reload, ZONE_MOVABLE, ...
>    handling.
> 
> --------------------------------------------------------------------------
> 4. Future work
> --------------------------------------------------------------------------
> 
> The separate patches contain a lot of future work items. One of the next
> steps is to make memory unplug more likely to succeed - currently, there
> are no guarantees on how much memory can get unplugged again. I have
> various ideas on how to limit fragmentation of all memory blocks that
> virtio-mem added.
> 
> Memory hotplug:
> - Reduce the amount of memory resources if that turnes out to be an
>    issue. Or try to speed up relevant code paths to deal with many
>    resources.
> - Allocate the vmemmap from the added memory. Makes hotplug more likely
>    to succeed, the vmemmap is stored on the same NUMA node and that
>    unmovable memory will later not hinder unplug.
> 
> Memory hotunplug:
> - Performance improvements:
> -- Sense (lockless) if it make sense to try alloc_contig_range() at all
>     before directly trying to isolate and taking locks.
> -- Try to unplug bigger chunks if possible first.
> -- Identify free areas first, that don't have to be evacuated.
> - Make unplug more likely to succeed:
> -- The "issue" is that in the ZONE_NORMAL, the buddy will randomly
>     allocate memory. Only pageblocks somewhat limit fragmentation,
>     however we would want to limit fragmentation on subblock granularity
>     and even memory block granularity. One idea is to have a new
>     ZONE_PREFER_MOVABLE. Memory blocks will then be onlined to ZONE_NORMAL
>     / ZONE_PREFER_MOVABLE in a certain ratio per node (e.g.,
>     1:4). This makes unplug of quite some memory likely to succeed in most
>     setups. ZONE_PREFER_MOVABLE is then a mixture of ZONE_NORMAL and
>     ZONE_MOVABlE. Especially, movable data can end up on that zone, but
>     only if really required - avoiding running out of memory on ZONE
>     imbalances. The zone fallback order would be
>     MOVABLE=>PREFER_MOVABLE=>HIGHMEM=>NORMAL=>PREFER_MOVABLE=>DMA32=>DMA
> -- Allocate memmap from added memory. This way, less unmovable data can
>     end up on the memory blocks.
> -- Call drop_slab() before trying to unplug. Eventually shrink other
>     caches.
> - Better retry handling in case memory is busy. We certainly don't want
>    to try for ever in a short interval to try to get some memory back.
> - OOM handling, e.g., via an OOM handler.
> 
> --------------------------------------------------------------------------
> 5. Example Usage
> --------------------------------------------------------------------------
> 
> A very basic QEMU prototype (kept updated) is available at:
> - https://github.com/davidhildenbrand/qemu/tree/virtio-mem
> 
> It lacks various features, however works to test the guest driver side:
> - No support for resizable memory regions / memory backends
> - No protection of unplugged memory (esp., userfaultfd-wp)
> - No dump/migration/XXX optimizations to skip over unplugged memory
> 
> Start QEMU with two virtio-mem devices (one per NUMA node):
>   $ qemu-system-x86_64 -m 4G,maxmem=20G \
>    -smp sockets=2,cores=2 \
>    -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
>    [...]
>    -object memory-backend-ram,id=mem0,size=8G \
>    -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,requested-size=128M \
>    -object memory-backend-ram,id=mem1,size=8G \
>    -device virtio-mem-pci,id=vm1,memdev=mem1,node=1,requested-size=80M
> 
> Query the configuration:
>   QEMU 4.1.50 monitor - type 'help' for more information
>   (qemu) info memory-devices
>   Memory device [virtio-mem]: "vm0"
>     memaddr: 0x140000000
>     node: 0
>     requested-size: 134217728
>     size: 134217728
>     max-size: 8589934592
>     block-size: 2097152
>     memdev: /objects/mem0
>   Memory device [virtio-mem]: "vm1"
>     memaddr: 0x340000000
>     node: 1
>     requested-size: 83886080
>     size: 83886080
>     max-size: 8589934592
>     block-size: 2097152
>     memdev: /objects/mem1
> 
> Add some memory to node 1:
>   QEMU 4.1.50 monitor - type 'help' for more information
>   (qemu) qom-set vm1 requested-size 1G
> 
> Remove some memory from node 0:
>   QEMU 4.1.50 monitor - type 'help' for more information
>   (qemu) qom-set vm0 requested-size 64M
> 
> Query the configuration:
> (qemu) info memory-devices
> Memory device [virtio-mem]: "vm0"
>    memaddr: 0x140000000
>    node: 0
>    requested-size: 67108864
>    size: 67108864
>    max-size: 8589934592
>    block-size: 2097152
>    memdev: /objects/mem0
> Memory device [virtio-mem]: "vm1"
>    memaddr: 0x340000000
>    node: 1
>    requested-size: 1073741824
>    size: 1073741824
>    max-size: 8589934592
>    block-size: 2097152
>    memdev: /objects/mem1
> 
> --------------------------------------------------------------------------
> 6. Q/A
> --------------------------------------------------------------------------
> 
> Q: Why add/remove parts ("subblocks") of memory blocks/sections?
> A: Flexibility (section size depends on the architecture) - e.g., some
>     architectures have a section size of 2GB. Also, the memory block size
>     is variable (e.g., on x86-64). I want to avoid any such restrictions.
>     Some use cases want to add/remove memory in smaller granularities to a
>     VM (e.g., the Hyper-V balloon also implements this) - especially smaller
>     VMs like used for kata containers. Also, on memory unplug, it is more
>     reliable to free-up and unplug multiple small chunks instead
>     of one big chunk. E.g., if one page of a DIMM is either unmovable or
>     pinned, the DIMM can't get unplugged. This approach is basically a
>     compromise between DIMM-based memory hot(un)plug and balloon
>     inflation/deflation, which works mostly on page granularity.
> 
> Q: Why care about memory blocks?
> A: They are the way to tell user space about new memory. This way,
>     memory can get onlined/offlined by user space. Also, e.g., kdump
>     relies on udev events to reload kexec when memory blocks are
>     onlined/offlined. Memory blocks are the "real" memory hot(un)plug
>     granularity. Everything that's smaller has to be emulated "on top".
> 
> Q: Won't memory unplug of subblocks fragment memory?
> A: Yes and no. Unplugging e.g., >=4MB subblocks on x86-64 will not really
>     fragment memory like unplugging random pages like a balloon driver does.
>     Buddy merging will not be limited. However, any allocation that requires
>     bigger consecutive memory chunks (e.g., gigantic pages) might observe
>     the fragmentation. Possible solutions: Allocate gigantic huge pages
>     before unplugging memory, don't unplug memory, combine virtio-mem with
>     DIMM based memory or bigger initial memory. Remember, a virtio-mem
>     device will only unplug on the memory range it manages, not on other
>     DIMMs. Unplug of single memory blocks will result in similar
>     fragmentation in respect to gigantic huge pages.
> 
> Q: How reliable is memory unplug?
> A: There are no guarantees on how much memory can get unplugged
>     again. However, it is more likely to find 4MB chunks to unplug than
>     e.g., 128MB chunks. If memory is terribly fragmented, there is nothing
>     we can do - for now. I consider memory hotplug the first primary use
>     of virtio-mem. Memory unplug might usually work, but we want to improve
>     the performance and the amount of memory we can actually unplug later.
> 
> Q: Why not unplug from the ZONE_MOVABLE?
> A: Unplugged memory chunks are unmovable. Unmovable data must not end up
>     on the ZONE_MOVABLE - similar to gigantic pages - they will never be
>     allocated from ZONE_MOVABLE. Teaching MM to move unplugged chunks within
>     a device might be problematic and will require a new guest->hypervisor
>     command to move unplugged chunks. virtio-mem added memory can be onlined
>     to the ZONE_MOVABLE, but subblocks will not get unplugged from it.
> 
> Q: How big should the initial (!virtio-mem) memory of a VM be?
> A: virtio-mem memory will not go to the DMA zones. So to avoid running out
>     of DMA memory, I suggest something like 2-3GB on x86-64. But many
>     VMs can most probably deal with less DMA memory - depends on the use
>     case.
> 
> [1] https://events.linuxfoundation.org/wp-content/uploads/2017/12/virtio-mem-Paravirtualized-Memory-David-Hildenbrand-Red-Hat-1.pdf
> [2] https://lwn.net/Articles/755423/
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03870.html
> 
> ---
> 

Gentle ping. I want to continue working on this. I need feedback from MM 
people on ...

> David Hildenbrand (9):
>    ACPI: NUMA: export pxm_to_node
>    virtio-mem: Paravirtualized memory hotplug
>    virtio-mem: Paravirtualized memory hotunplug part 1
>    mm: Export alloc_contig_range() / free_contig_range()

... this patch, if it is okay to export alloc_contig_range() / 
free_contig_range() (see next patch how it is used)

>    virtio-mem: Paravirtualized memory hotunplug part 2
>    mm: Allow to offline PageOffline() pages with a reference count of 0

... this patch, to see if we can use "PageOffline() + refcount == 0" as 
a way to allow offlining memory with unplugged pieces. (see next patch 
how this is used)

>    virtio-mem: Allow to offline partially unplugged memory blocks
>    mm/memory_hotplug: Introduce offline_and_remove_memory()

... I assume this patch is not that debatable.

>    virtio-mem: Offline and remove completely unplugged memory blocks

So yeah, please feedback on

"mm: Export alloc_contig_range() / free_contig_range()" and "mm: Allow 
to offline PageOffline() pages with a reference count of 0", because 
they are the essential pieces apart from what we already have 
(generic_online_page(), memory notifiers ...)

Thanks!

-- 

Thanks,

David / dhildenb
