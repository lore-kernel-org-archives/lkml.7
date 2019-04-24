Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE76C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfDXIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:19:28 -0400
Received: from foss.arm.com ([217.140.101.70]:39542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfDXIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C46380D;
        Wed, 24 Apr 2019 01:19:27 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FDCE3F5AF;
        Wed, 24 Apr 2019 01:19:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:19:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mhocko@suse.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V2 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20190424081837.ldpe74i7uspupxdv@blommer>
References: <1555221553-18845-3-git-send-email-anshuman.khandual@arm.com>
 <20190415134841.GC13990@lakrids.cambridge.arm.com>
 <2faba38b-ab79-2dda-1b3c-ada5054d91fa@arm.com>
 <20190417142154.GA393@lakrids.cambridge.arm.com>
 <bba0b71c-2d04-d589-e2bf-5de37806548f@arm.com>
 <20190417173948.GB15589@lakrids.cambridge.arm.com>
 <1bdae67b-fcd6-7868-8a92-c8a306c04ec6@arm.com>
 <97413c39-a4a9-ea1b-7093-eb18f950aad7@arm.com>
 <20190423160525.GD56999@lakrids.cambridge.arm.com>
 <ebb9aba0-5ca3-41ed-4183-9d72a354f529@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb9aba0-5ca3-41ed-4183-9d72a354f529@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:29:28AM +0530, Anshuman Khandual wrote:
> On 04/23/2019 09:35 PM, Mark Rutland wrote:
> > On Tue, Apr 23, 2019 at 01:01:58PM +0530, Anshuman Khandual wrote:
> >> Generic usage for init_mm.pagetable_lock
> >>
> >> Unless I have missed something else these are the generic init_mm kernel page table
> >> modifiers at runtime (at least which uses init_mm.page_table_lock)
> >>
> >> 	1. ioremap_page_range()		/* Mapped I/O memory area */
> >> 	2. apply_to_page_range()	/* Change existing kernel linear map */
> >> 	3. vmap_page_range()		/* Vmalloc area */
> > 
> > Internally, those all use the __p??_alloc() functions to handle racy
> > additions by transiently taking the PTL when installing a new table, but
> > otherwise walk kernel tables _without_ the PTL held. Note that none of
> > these ever free an intermediate level of table.
> 
> Right they dont free intermediate level page table but I was curious about the
> only the leaf level modifications.

Sure thing; I just wanted to point that out explicitly for everyone else's
benefit. :)

> > I believe that the idea is that operations on separate VMAs should never
> 
> I guess you meant kernel virtual range with 'VMA' but not the actual VMA which is
> vm_area_struct applicable only for the user space not the kernel.

Sure. In the kernel we'd reserve a kernel VA range with a vm_struct via
get_vm_area() or similar.

The key point is that we reserve page-granular VA ranges which cannot overlap
at the leaf level (but may share intermediate levels of table). Whoever owns
that area is in charge of necessary mutual exclusion for the leaf entries.

> > conflict at the leaf level, and operations on the same VMA should be
> > serialised somehow w.r.t. that VMA.
> 
> AFAICT see there is nothing other than hotplug lock i.e mem_hotplug_lock which
> prevents concurrent init_mm modifications and the current situation is only safe
> because some how these VA areas dont overlap with respect to intermediate page
> table level spans.

Here I was ignoring hotplug to describe the general principle (which I've
expanded upon above).

> > AFAICT, these functions are _never_ called on the linear/direct map or
> > vmemmap VA ranges, and whether or not these can conflict with hot-remove
> > is entirely dependent on whether those ranges can share a level of table
> > with the vmalloc region.
> 
> Right but all these VA ranges (linear, vmemmap, vmalloc) are wired in on init_mm
> hence wondering if it is prudent to assume layout scheme which varies a lot based
> on different architectures while deciding possible race protections.

One thing to consider is that we could turn this implicit assumption into a
requirement, if this isn't too invasive.

> Wondering why these user should not call [get|put]_online_mems() to prevent
> race with hotplug.

I suspect that this is because they were written before memory hotplug was
added, and they were never reconsidered in the presence of hot-remove.

> Will try this out.
> 
> Unless generic MM expects these VA ranges (linear, vmemmap, vmalloc) layout to be
> in certain manner from the platform guaranteeing non-overlap at intermediate level
> page table spans. Only then we would not a lock.

I think that we might be able to make this a requirement for hot-remove. I
suspect this happens to be the case in practice by chance, even if it isn't
strictly guaranteed.

> > Do you know how likely that is to occur? e.g. what proportion of the
> 
> TBH I dont know.
> 
> > vmalloc region may share a level of table with the linear or vmemmap
> > regions in a typical arm64 or x86 configuration? Can we deliberately
> > provoke this failure case?
> 
> I have not enumerated those yet but there are multiple configs on arm64 and
> probably on x86 which decides kernel VA space layout causing these potential
> races. But regardless its not right to assume on vmalloc range span and not
> take a lock.
> 
> Not sure how to provoke this failure case from user space with simple hotplug
> because vmalloc physical allocation normally cannot be controlled without a
> hacked kernel change.

I believe that we can write a module which:

 - Looks at the various memory ranges, and determines whether they may share an
   intermediate level of table.
 - reserves a potentially-conflicting region with __get_vm_area_node()
 - in a loop, maps/unmaps something in that range

... while in parallel, adding/removing a potentially-conflicting region of
memory.

So long as we have the same sort of serialization we'd have for a regular
vmalloc(), ioremap() of vmap(), that would be sufficient to demonstrate that
this is a real problem.

[...]

> > Is it possible to avoid these specific conflicts (ignoring ptdump) by
> > aligning VA regions such that they cannot share intermediate levels of
> > table?
> 
> Kernel VA space layout is platform specific where core MM does not mandate much. 
> Hence generic modifiers should not make any assumptions regarding it but protect
> themselves with locks. Doing any thing other than that is just pushing the problem
> to future.

My point is that we can make this a _requirement_ of the core code, which we
could document and enforce.

Thanks,
Mark.
