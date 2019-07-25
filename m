Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8F22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbfGYJkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:40:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387533AbfGYJkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B419ABE9;
        Thu, 25 Jul 2019 09:40:37 +0000 (UTC)
Date:   Thu, 25 Jul 2019 11:40:34 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mm,memory_hotplug: Introduce MHP_VMEMMAP_FLAGS
Message-ID: <20190725094030.GA16069@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-3-osalvador@suse.de>
 <CAPcyv4hvu+wp4tJJNW70jp2G_rNabyvzGMvDTS3PzkDCAFztYg@mail.gmail.com>
 <20190725092751.GA15964@linux>
 <71a30086-b093-48a4-389f-7e407898718f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71a30086-b093-48a4-389f-7e407898718f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:30:23AM +0200, David Hildenbrand wrote:
> On 25.07.19 11:27, Oscar Salvador wrote:
> > On Wed, Jul 24, 2019 at 01:11:52PM -0700, Dan Williams wrote:
> >> On Tue, Jun 25, 2019 at 12:53 AM Oscar Salvador <osalvador@suse.de> wrote:
> >>>
> >>> This patch introduces MHP_MEMMAP_DEVICE and MHP_MEMMAP_MEMBLOCK flags,
> >>> and prepares the callers that add memory to take a "flags" parameter.
> >>> This "flags" parameter will be evaluated later on in Patch#3
> >>> to init mhp_restrictions struct.
> >>>
> >>> The callers are:
> >>>
> >>> add_memory
> >>> __add_memory
> >>> add_memory_resource
> >>>
> >>> Unfortunately, we do not have a single entry point to add memory, as depending
> >>> on the requisites of the caller, they want to hook up in different places,
> >>> (e.g: Xen reserve_additional_memory()), so we have to spread the parameter
> >>> in the three callers.
> >>>
> >>> The flags are either MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK, and only differ
> >>> in the way they allocate vmemmap pages within the memory blocks.
> >>>
> >>> MHP_MEMMAP_MEMBLOCK:
> >>>         - With this flag, we will allocate vmemmap pages in each memory block.
> >>>           This means that if we hot-add a range that spans multiple memory blocks,
> >>>           we will use the beginning of each memory block for the vmemmap pages.
> >>>           This strategy is good for cases where the caller wants the flexiblity
> >>>           to hot-remove memory in a different granularity than when it was added.
> >>>
> >>>           E.g:
> >>>                 We allocate a range (x,y], that spans 3 memory blocks, and given
> >>>                 memory block size = 128MB.
> >>>                 [memblock#0  ]
> >>>                 [0 - 511 pfns      ] - vmemmaps for section#0
> >>>                 [512 - 32767 pfns  ] - normal memory
> >>>
> >>>                 [memblock#1 ]
> >>>                 [32768 - 33279 pfns] - vmemmaps for section#1
> >>>                 [33280 - 65535 pfns] - normal memory
> >>>
> >>>                 [memblock#2 ]
> >>>                 [65536 - 66047 pfns] - vmemmap for section#2
> >>>                 [66048 - 98304 pfns] - normal memory
> >>>
> >>> MHP_MEMMAP_DEVICE:
> >>>         - With this flag, we will store all vmemmap pages at the beginning of
> >>>           hot-added memory.
> >>>
> >>>           E.g:
> >>>                 We allocate a range (x,y], that spans 3 memory blocks, and given
> >>>                 memory block size = 128MB.
> >>>                 [memblock #0 ]
> >>>                 [0 - 1533 pfns    ] - vmemmap for section#{0-2}
> >>>                 [1534 - 98304 pfns] - normal memory
> >>>
> >>> When using larger memory blocks (1GB or 2GB), the principle is the same.
> >>>
> >>> Of course, MHP_MEMMAP_DEVICE is nicer when it comes to have a large contigous
> >>> area, while MHP_MEMMAP_MEMBLOCK allows us to have flexibility when removing the
> >>> memory.
> >>
> >> Concept and patch looks good to me, but I don't quite like the
> >> proliferation of the _DEVICE naming, in theory it need not necessarily
> >> be ZONE_DEVICE that is the only user of that flag. I also think it
> >> might be useful to assign a flag for the default 'allocate from RAM'
> >> case, just so the code is explicit. So, how about:
> > 
> > Well, MHP_MEMMAP_DEVICE is not tied to ZONE_DEVICE.
> > MHP_MEMMAP_DEVICE was chosen to make a difference between:
> > 
> >  * allocate memmap pages for the whole memory-device
> >  * allocate memmap pages on each memoryblock that this memory-device spans
> 
> I agree that DEVICE is misleading here, you are assuming a one-to-one
> mapping between a device and add_memory(). You are actually taliing
> about "allocate a single chunk of mmap pages for the whole memory range
> that is added - which could consist of multiple memory blocks".

Well, I could not come up with a better name.

MHP_MEMMAP_ALL?
MHP_MEMMAP_WHOLE?

I will send v3 shortly and then we can think of a better name.

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
> 

-- 
Oscar Salvador
SUSE L3
