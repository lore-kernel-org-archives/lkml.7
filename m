Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A4AC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025E522CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGZJaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:30:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:55374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfGZJaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:30:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 474DFB609;
        Fri, 26 Jul 2019 09:30:02 +0000 (UTC)
Date:   Fri, 26 Jul 2019 11:29:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY
Message-ID: <20190726092959.GB26268@linux>
References: <20190725160207.19579-1-osalvador@suse.de>
 <20190725160207.19579-2-osalvador@suse.de>
 <8b60e40a-1e8a-1f7c-a31d-ad2e511decd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b60e40a-1e8a-1f7c-a31d-ad2e511decd5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 10:34:47AM +0200, David Hildenbrand wrote:
> > Want to add 384MB (3 sections, 3 memory-blocks)
> > e.g:
> > 
> > 	add_memory(0x1000, size_memory_block);
> > 	add_memory(0x2000, size_memory_block);
> > 	add_memory(0x3000, size_memory_block);
> > 
> > 	[memblock#0  ]
> > 	[0 - 511 pfns      ] - vmemmaps for section#0
> > 	[512 - 32767 pfns  ] - normal memory
> > 
> > 	[memblock#1 ]
> > 	[32768 - 33279 pfns] - vmemmaps for section#1
> > 	[33280 - 65535 pfns] - normal memory
> > 
> > 	[memblock#2 ]
> > 	[65536 - 66047 pfns] - vmemmap for section#2
> > 	[66048 - 98304 pfns] - normal memory
> 
> I wouldn't even care about documenting this right now. We have no user
> so far, so spending 50% of the description on this topic isn't really
> needed IMHO :)

Fair enough, I could drop it.
Was just trying to be extra clear.

> 
> > 
> > or
> > 	add_memory(0x1000, size_memory_block * 3);
> > 
> > 	[memblock #0 ]
> >         [0 - 1533 pfns    ] - vmemmap for section#{0-2}
> >         [1534 - 98304 pfns] - normal memory
> > 
> > When using larger memory blocks (1GB or 2GB), the principle is the same.
> > 
> > Of course, per whole-range granularity is nicer when it comes to have a large
> > contigous area, while per memory-block granularity allows us to have flexibility
> > when removing the memory.
> 
> E.g., in my virtio-mem I am currently adding all memory blocks
> separately either way (to guranatee that remove_memory() works cleanly -
> see __release_memory_resource()), and to control the amount of
> not-offlined memory blocks (e.g., to make user space is actually
> onlining them). As it's just a prototype, this might change of course in
> the future.

What is virtio-mem for? Did it that raised from a need?
Is it something you could try this patch on?

> >  /*
> > + * We want memmap (struct page array) to be allocated from the hotadded range.
> > + * To do so, there are two possible ways depending on what the caller wants.
> > + * 1) Allocate memmap pages whole hot-added range.
> > + *    Here the caller will only call any add_memory() variant with the whole
> > + *    memory address.
> > + * 2) Allocate memmap pages per memblock
> > + *    Here, the caller will call any add_memory() variant per memblock
> > + *    granularity.
> > + * The former implies that we will use the beginning of the hot-added range
> > + * to store the memmap pages of the whole range, while the latter implies
> > + * that we will use the beginning of each memblock to store its own memmap
> > + * pages.
> 
> Can you make this documentation only state how MHP_MEMMAP_ON_MEMORY
> works? (IOW, shrink it heavily to what we actually implement)

Sure.

> Apart from the requested description/documentation changes
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for having a look David ;-)
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb

-- 
Oscar Salvador
SUSE L3
