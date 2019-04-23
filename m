Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ADAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97D620693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfDWQFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:05:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58886 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWQFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:05:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BA8280D;
        Tue, 23 Apr 2019 09:05:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039593F5AF;
        Tue, 23 Apr 2019 09:05:27 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:05:25 +0100
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
Message-ID: <20190423160525.GD56999@lakrids.cambridge.arm.com>
References: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
 <1555221553-18845-3-git-send-email-anshuman.khandual@arm.com>
 <20190415134841.GC13990@lakrids.cambridge.arm.com>
 <2faba38b-ab79-2dda-1b3c-ada5054d91fa@arm.com>
 <20190417142154.GA393@lakrids.cambridge.arm.com>
 <bba0b71c-2d04-d589-e2bf-5de37806548f@arm.com>
 <20190417173948.GB15589@lakrids.cambridge.arm.com>
 <1bdae67b-fcd6-7868-8a92-c8a306c04ec6@arm.com>
 <97413c39-a4a9-ea1b-7093-eb18f950aad7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97413c39-a4a9-ea1b-7093-eb18f950aad7@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:01:58PM +0530, Anshuman Khandual wrote:
> Generic usage for init_mm.pagetable_lock
> 
> Unless I have missed something else these are the generic init_mm kernel page table
> modifiers at runtime (at least which uses init_mm.page_table_lock)
> 
> 	1. ioremap_page_range()		/* Mapped I/O memory area */
> 	2. apply_to_page_range()	/* Change existing kernel linear map */
> 	3. vmap_page_range()		/* Vmalloc area */

Internally, those all use the __p??_alloc() functions to handle racy
additions by transiently taking the PTL when installing a new table, but
otherwise walk kernel tables _without_ the PTL held. Note that none of
these ever free an intermediate level of table.

I believe that the idea is that operations on separate VMAs should never
conflict at the leaf level, and operations on the same VMA should be
serialised somehow w.r.t. that VMA.

AFAICT, these functions are _never_ called on the linear/direct map or
vmemmap VA ranges, and whether or not these can conflict with hot-remove
is entirely dependent on whether those ranges can share a level of table
with the vmalloc region.

Do you know how likely that is to occur? e.g. what proportion of the
vmalloc region may share a level of table with the linear or vmemmap
regions in a typical arm64 or x86 configuration? Can we deliberately
provoke this failure case?

[...]

> In all of the above.
> 
> - Page table pages [p4d|pud|pmd|pte]_alloc_[kernel] settings are
>   protected with init_mm.page_table_lock

Racy addition is protect in this manner.

> - Should not it require init_mm.page_table_lock for all leaf level
>   (PUD|PMD|PTE) modification as well ?

As above, I believe that the PTL is assumed to not be necessary there
since other mutual exclusion should be in effect to prevent racy
modification of leaf entries.

> - Should not this require init_mm.page_table_lock for page table walk
>   itself ?
> 
> Not taking an overall lock for all these three operations will
> potentially race with an ongoing memory hot remove operation which
> takes an overall lock as proposed. Wondering if this has this been
> safe till now ?

I suspect that the answer is that hot-remove is not thoroughly
stress-tested today, and conflicts are possible but rare.

As above, can we figure out how likely conflicts are, and try to come up
with a stress test?

Is it possible to avoid these specific conflicts (ignoring ptdump) by
aligning VA regions such that they cannot share intermediate levels of
table?

Thanks,
Mark.
