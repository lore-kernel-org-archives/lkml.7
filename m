Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25627C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22622183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfC2IaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:30:12 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:19758 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbfC2IaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:30:12 -0400
Received: by suse.de (Postfix, from userid 1000)
        id E08F6473C; Fri, 29 Mar 2019 09:30:10 +0100 (CET)
Date:   Fri, 29 Mar 2019 09:30:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190329083006.j7j54nq6pdiffe7v@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:09:06PM +0100, David Hildenbrand wrote:
> On 28.03.19 14:43, Oscar Salvador wrote:
> > Hi,
> > 
> > since last two RFCs were almost unnoticed (thanks David for the feedback),
> > I decided to re-work some parts to make it more simple and give it a more
> > testing, and drop the RFC, to see if it gets more attention.
> > I also added David's feedback, so now all users of add_memory/__add_memory/
> > add_memory_resource can specify whether they want to use this feature or not.
> 
> Terrific, I will also definetly try to make use of that in the next
> virito-mem prototype (looks like I'll finally have time to look into it
> again).

Great, I would like to see how this works there :-).

> I guess one important thing to mention is that it is no longer possible
> to remove memory in a different granularity it was added. I slightly
> remember that ACPI code sometimes "reuses" parts of already added
> memory. We would have to validate that this can indeed not be an issue.
> 
> drivers/acpi/acpi_memhotplug.c:
> 
> result = __add_memory(node, info->start_addr, info->length);
> if (result && result != -EEXIST)
> 	continue;
> 
> What would happen when removing this dimm (->remove_memory())

Yeah, I see the point.
Well, we are safe here because the vmemmap data is being allocated in
every call to __add_memory/add_memory/add_memory_resource.

E.g:

* Being memblock granularity 128M

# object_add memory-backend-ram,id=ram0,size=256M
# device_add pc-dimm,id=dimm0,memdev=ram0,node=1

I am not sure how ACPI gets to split the DIMM in memory resources
(aka mem_device->res_list), but it does not really matter.
For each mem_device->res_list item, we will make a call to __add_memory,
which will allocate the vmemmap data for __that__ item, we do not care
about the others.

And when removing the DIMM, acpi_memory_remove_memory will make a call to
__remove_memory() for each mem_device->res_list item, and that will take
care of free up the vmemmap data.

Now, with all my tests, ACPI always considered a DIMM a single memory resource,
but maybe under different circumstances it gets to split it in different mem
resources.
But it does not really matter, as vmemmap data is being created and isolated in
every call to __add_memory.

> Also have a look at
> 
> arch/powerpc/platforms/powernv/memtrace.c
> 
> I consider it evil code. It will simply try to offline+unplug *some*
> memory it finds in *some granularity*. Not sure if this might be
> problematic-

Heh, memtrace from powerpc ^^, I saw some oddities coming from there, but
with my code though because I did not get to test that in concret.
But I am interested to see if it can trigger something, so I will be testing
that the next days.

> Would there be any "safety net" for adding/removing memory in different
> granularities?

Uhm, I do not think we need it, or at least I cannot think of a case where this
could cause trouble with the current design.
Can you think of any? 

Thanks David ;-)

-- 
Oscar Salvador
SUSE L3
