Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3778F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfC2JU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:20:27 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:4019 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbfC2JU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:20:26 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 7DB014740; Fri, 29 Mar 2019 10:20:25 +0100 (CET)
Date:   Fri, 29 Mar 2019 10:20:25 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190329092025.2cw3igplwzrij2sr@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <23dcfb4a-339b-dcaf-c037-331f82fdef5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23dcfb4a-339b-dcaf-c037-331f82fdef5a@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:56:37AM +0100, David Hildenbrand wrote:
> Oh okay, so actually the way I guessed it would be now.
> 
> While this makes totally sense, I'll have to look how it is currently
> handled, meaning if there is a change. I somewhat remembering that
> delayed struct pages initialization would initialize vmmap per section,
> not per memory resource.

Uhm, the memmap array for each section is built early during boot.
We actually do not care about deferred struct pages initialization there.
What we do is:

- We go through all memblock regions marked as memory
- We mark the sections within those regions present
- We initialize those sections and build the corresponding memmap array

The thing is that sparse_init_nid() allocates/reserves a buffer big enough
to allocate the memmap array for all those sections, and for each memmap
array to need to allocate, we consume it from that buffer, using contigous
memory.

Have a look at:

- sparse_memory_present_with_active_regions()
- sparse_init()
- sparse_init_nid
- sparse_buffer_init

> But as I work on 10 things differently, my mind sometimes seems to
> forget stuff in order to replace it with random nonsense. Will look into
> the details to not have to ask too many dumb questions.
> 
> > 
> > So, the taken approach is to allocate the vmemmap data corresponging to the
> > whole DIMM/memory-device/memory-resource from the beginning of its memory.
> > 
> > In the example from above, the vmemmap data for both sections is allocated from
> > the beginning of the first section:
> > 
> > memmap array takes 2MB per section, so 512 pfns.
> > If we add 2 sections:
> > 
> > [  pfn#0  ]  \
> > [  ...    ]  |  vmemmap used for memmap array
> > [pfn#1023 ]  /  
> > 
> > [pfn#1024 ]  \
> > [  ...    ]  |  used as normal memory
> > [pfn#65536]  /
> > 
> > So, out of 256M, we get 252M to use as a real memory, as 4M will be used for
> > building the memmap array.
> > 
> > Actually, it can happen that depending on how big a DIMM/memory-device is,
> > the first/s memblock is fully used for the memmap array (of course, this
> > can only be seen when adding a huge DIMM/memory-device).
> > 
> 
> Just stating here, that with your code, add_memory() and remove_memory()
> always have to be called in the same granularity. Will have to see if
> that implies a change.

Well, I only tested it in such scenario yes, but I think that ACPI code
enforces that somehow.
I will take a closer look though.

-- 
Oscar Salvador
SUSE L3
