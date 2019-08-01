Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6219C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C179A216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfHAIjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfHAIjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B254B646;
        Thu,  1 Aug 2019 08:39:09 +0000 (UTC)
Date:   Thu, 1 Aug 2019 10:39:01 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Allocate memmap from hotadded memory
Message-ID: <20190801083856.GA17316@linux>
References: <20190725160207.19579-1-osalvador@suse.de>
 <20190801073931.GA16659@linux>
 <1e5776e4-d01e-fe86-57c3-1c3c27aae52f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5776e4-d01e-fe86-57c3-1c3c27aae52f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:17:23AM +0200, David Hildenbrand wrote:
> I am not yet sure about two things:
> 
> 
> 1. Checking uninitialized pages for PageVmemmap() when onlining. I
> consider this very bad.
> 
> I wonder if it would be better to remember for each memory block the pfn
> offset, which will be used when onlining/offlining.
> 
> I have some patches that convert online_pages() to
> __online_memory_block(struct memory block *mem) - which fits perfect to
> the current user. So taking the offset and processing only these pages
> when onlining would be easy. To do the same for offline_pages(), we
> first have to rework memtrace code. But when offlining, all memmaps have
> already been initialized.

This is true, I did not really like that either, but was one of the things
I came up.
I already have some ideas how to avoid checking the page, I will work on it.

> 2. Setting the Vmemmap pages to the zone of the online type. This would
> mean we would have unmovable data on pages marked to belong to the
> movable zone. I would suggest to always set them to the NORMAL zone when
> onlining - and inititalize the vmemmap of the vmemmap pages directly
> during add_memory() instead.

IMHO, having vmemmap pages in ZONE_MOVABLE do not matter that match.
They are not counted as managed_pages, and they are not show-stopper for
moving all the other data around (migrate), they are just skipped.
Conceptually, they are not pages we can deal with.

I thought they should lay wherever the range lays.
Having said that, I do not oppose to place them in ZONE_NORMAL, as they might
fit there better under the theory that ZONE_NORMAL have memory that might not be
movable/migratable.

As for initializing them in add_memory(), we cannot do that.
First problem is that we first need sparse_mem_map_populate to create
the mapping, and to take the pages from our altmap.

Then, we can access and initialize those pages.
So we cannot do that in add_memory() because that happens before.

And I really think that it fits much better in __add_pages than in add_memory.

Given said that, I would appreciate some comments in patches#3 and patches#4,
specially patch#4.
So I would like to collect some feedback in those before sending a new version.

Thanks David

-- 
Oscar Salvador
SUSE L3
