Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A3C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BC021880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfGXVgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:36:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:57944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727373AbfGXVgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:36:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33E6CABC6;
        Wed, 24 Jul 2019 21:36:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Jul 2019 23:36:49 +0200
From:   osalvador@suse.de
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mm,memory_hotplug: Introduce MHP_VMEMMAP_FLAGS
In-Reply-To: <CAPcyv4hvu+wp4tJJNW70jp2G_rNabyvzGMvDTS3PzkDCAFztYg@mail.gmail.com>
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-3-osalvador@suse.de>
 <CAPcyv4hvu+wp4tJJNW70jp2G_rNabyvzGMvDTS3PzkDCAFztYg@mail.gmail.com>
Message-ID: <b9eb327f64e6727c5c2db474089d510d@suse.de>
X-Sender: osalvador@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-24 22:11, Dan Williams wrote:
> On Tue, Jun 25, 2019 at 12:53 AM Oscar Salvador <osalvador@suse.de> 
> wrote:
>> 
>> This patch introduces MHP_MEMMAP_DEVICE and MHP_MEMMAP_MEMBLOCK flags,
>> and prepares the callers that add memory to take a "flags" parameter.
>> This "flags" parameter will be evaluated later on in Patch#3
>> to init mhp_restrictions struct.
>> 
>> The callers are:
>> 
>> add_memory
>> __add_memory
>> add_memory_resource
>> 
>> Unfortunately, we do not have a single entry point to add memory, as 
>> depending
>> on the requisites of the caller, they want to hook up in different 
>> places,
>> (e.g: Xen reserve_additional_memory()), so we have to spread the 
>> parameter
>> in the three callers.
>> 
>> The flags are either MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK, and 
>> only differ
>> in the way they allocate vmemmap pages within the memory blocks.
>> 
>> MHP_MEMMAP_MEMBLOCK:
>>         - With this flag, we will allocate vmemmap pages in each 
>> memory block.
>>           This means that if we hot-add a range that spans multiple 
>> memory blocks,
>>           we will use the beginning of each memory block for the 
>> vmemmap pages.
>>           This strategy is good for cases where the caller wants the 
>> flexiblity
>>           to hot-remove memory in a different granularity than when it 
>> was added.
>> 
>>           E.g:
>>                 We allocate a range (x,y], that spans 3 memory blocks, 
>> and given
>>                 memory block size = 128MB.
>>                 [memblock#0  ]
>>                 [0 - 511 pfns      ] - vmemmaps for section#0
>>                 [512 - 32767 pfns  ] - normal memory
>> 
>>                 [memblock#1 ]
>>                 [32768 - 33279 pfns] - vmemmaps for section#1
>>                 [33280 - 65535 pfns] - normal memory
>> 
>>                 [memblock#2 ]
>>                 [65536 - 66047 pfns] - vmemmap for section#2
>>                 [66048 - 98304 pfns] - normal memory
>> 
>> MHP_MEMMAP_DEVICE:
>>         - With this flag, we will store all vmemmap pages at the 
>> beginning of
>>           hot-added memory.
>> 
>>           E.g:
>>                 We allocate a range (x,y], that spans 3 memory blocks, 
>> and given
>>                 memory block size = 128MB.
>>                 [memblock #0 ]
>>                 [0 - 1533 pfns    ] - vmemmap for section#{0-2}
>>                 [1534 - 98304 pfns] - normal memory
>> 
>> When using larger memory blocks (1GB or 2GB), the principle is the 
>> same.
>> 
>> Of course, MHP_MEMMAP_DEVICE is nicer when it comes to have a large 
>> contigous
>> area, while MHP_MEMMAP_MEMBLOCK allows us to have flexibility when 
>> removing the
>> memory.
> 
> Concept and patch looks good to me, but I don't quite like the
> proliferation of the _DEVICE naming, in theory it need not necessarily
> be ZONE_DEVICE that is the only user of that flag. I also think it
> might be useful to assign a flag for the default 'allocate from RAM'
> case, just so the code is explicit. So, how about:
> 
> MHP_MEMMAP_PAGE_ALLOC
> MHP_MEMMAP_MEMBLOCK
> MHP_MEMMAP_RESERVED
> 
> ...for the 3 cases?
> 
> Other than that, feel free to add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
  HI Dan,

I'll be sending V3 tomorrow, with some major rewrites (more simplified).

Thanks
