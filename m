Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623DEFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302AC218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571233528;
	bh=eQfVsPWtiaa76UEMfm4cgWSEE3cBsE3PaVSOzO1kv+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZNWkypY5nYxw2qKjHjPPEanVm9kJhN/AfOpAVU9asT/9r1fmfCdCi02o0Nhdmmo+w
	 qxBMYkygs4kDXgAD9otNDA6aW3b/OQb1dwnNUHUVfpo3hM/3nPdXfNgVvzQLHDN8Os
	 VDKNJm2Pj+ph6oHvgZ+NU/Fdy3dD4GlklaE4RtsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405471AbfJPNp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:43986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729093AbfJPNp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CD1CB68D;
        Wed, 16 Oct 2019 13:45:22 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:45:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
 a reference count of 0
Message-ID: <20191016134519.GC317@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-7-david@redhat.com>
 <20191016114321.GX317@dhcp22.suse.cz>
 <bd38d88d-19a7-275a-386d-f37cb76a3390@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd38d88d-19a7-275a-386d-f37cb76a3390@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 14:50:30, David Hildenbrand wrote:
> On 16.10.19 13:43, Michal Hocko wrote:
> > On Thu 19-09-19 16:22:25, David Hildenbrand wrote:
> > > virtio-mem wants to allow to offline memory blocks of which some parts
> > > were unplugged, especially, to later offline and remove completely
> > > unplugged memory blocks. The important part is that PageOffline() has
> > > to remain set until the section is offline, so these pages will never
> > > get accessed (e.g., when dumping). The pages should not be handed
> > > back to the buddy (which would require clearing PageOffline() and
> > > result in issues if offlining fails and the pages are suddenly in the
> > > buddy).
> > > 
> > > Let's use "PageOffline() + reference count = 0" as a sign to
> > > memory offlining code that these pages can simply be skipped when
> > > offlining, similar to free or HWPoison pages.
> > > 
> > > Pass flags to test_pages_isolated(), similar as already done for
> > > has_unmovable_pages(). Use a new flag to indicate the
> > > requirement of memory offlining to skip over these special pages.
> > > 
> > > In has_unmovable_pages(), make sure the pages won't be detected as
> > > movable. This is not strictly necessary, however makes e.g.,
> > > alloc_contig_range() stop early, trying to isolate such page blocks -
> > > compared to failing later when testing if all pages were isolated.
> > > 
> > > Also, make sure that when a reference to a PageOffline() page is
> > > dropped, that the page will not be returned to the buddy.
> > > 
> > > memory devices (like virtio-mem) that want to make use of this
> > > functionality have to make sure to synchronize against memory offlining,
> > > using the memory hotplug notifier.
> > > 
> > > Alternative: Allow to offline with a reference count of 1
> > > and use some other sign in the struct page that offlining is permitted.
> > 
> > Few questions. I do not see onlining code to take care of this special
> > case. What should happen when offline && online?
> 
> Once offline, the memmap is garbage. When onlining again:
> 
> a) memmap will be re-initialized
> b) online_page_callback_t will be called for every page in the section. The
> driver can mark them offline again and not give them to the buddy.
> c) section will be marked online.

But we can skip those pages when onlining and keep them in the offline
state right? We do not poison offlined pages.

There is state stored in the struct page. In other words this shouldn't
be really different from HWPoison pages. I cannot find the code that is
doing that and maybe we don't handle that. But we cannot simply online
hwpoisoned page. Offlining the range will not make a broken memory OK
all of the sudden. And your usecase sounds similar to me.

> The driver that marked these pages to be skipped when offlining is
> responsible for registering the online_page_callback_t callback where these
> pages will get excluded.
> 
> This is exactly the same as when onling a memory block that is partially
> populated (e.g., HpyerV balloon right now).
> 
> So it's effectively "re-initializing the memmap using the driver knowledge"
> when onlining.

I am not sure I follow. So you exclude those pages when onlining?

> > Should we allow to try_remove_memory to succeed with these pages?
> 
> I think we should first properly offline them (mark sections offline and
> memory blocks, fixup numbers, shrink zones ...). The we can cleanly remove
> the memory. (see [PATCH RFC v3 8/9] mm/memory_hotplug: Introduce
> offline_and_remove_memory())

I will have a look, but just to quick question. try_remove_memory would
fail if the range is offline (via user interface) but there are still some
pages in the driver Offline state?

> Once offline, the memmap is irrelevant and try_remove_memory() can do its
> job.
> 
> > Do we really have hook into __put_page? Why do we even care about the
> > reference count of those pages? Wouldn't it be just more consistent to
> > elevate the reference count (I guess this is what you suggest in the
> > last paragraph) and the virtio driver would return that page to the
> > buddy by regular put_page. This is also related to the above question
> > about the physical memory remove.
> 
> Returning them to the buddy is problematic for various reasons. Let's have a
> look at __offline_pages():
> 
> 1) start_isolate_page_range()
> -> offline pages with a reference count of one will be detected as unmovable
> -> BAD, we abort right away. We could hack around that.
> 
> 2) memory_notify(MEM_GOING_OFFLINE, &arg);
> -> Here, we could release all pages to the buddy, clearing PG_offline
> -> BAD, PF_offline must not be cleared so dumping tools will not touch
>    these pages. I don't see a way to hack around that.
> 
> 3) scan_movable_pages() ...
> 
> 4a) memory_notify(MEM_OFFLINE, &arg);
> 
> Perfect, it worked. Sections are offline.
> 
> 4b) undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>     memory_notify(MEM_CANCEL_OFFLINE, &arg);
> 
> -> Offlining failed for whatever reason.
> -> Pages are in the buddy, but we already un-isolated them. BAD.
> 
> By not going via the buddy we avoid these issues and can leave PG_offline
> set until the section is fully offline. Something that is very desirable for
> virtio-mem (and as far as I can tell also HyperV in the future).

I am not sure I follow. Maybe my original question was confusing. Let me
ask again. Why do we need to hook into __put_page?


> > [...]
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index d5d7944954b3..fef74720d8b4 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -8221,6 +8221,15 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> > >   		if (!page_ref_count(page)) {
> > >   			if (PageBuddy(page))
> > >   				iter += (1 << page_order(page)) - 1;
> > > +			/*
> > > +			* Memory devices allow to offline a page if it is
> > > +			* marked PG_offline and has a reference count of 0.
> > > +			* However, the pages are not movable as it would be
> > > +			* required e.g., for alloc_contig_range().
> > > +			*/
> > > +			if (PageOffline(page) && !(flags & SKIP_OFFLINE))
> > > +				if (++found > count)
> > > +					goto unmovable;
> > >   			continue;
> > >   		}
> > 
> > Do we really need to distinguish offline and hwpoison pages? They are
> > both unmovable for allocator purposes and offlineable for the hotplug,
> > right? Should we just hide them behind a helper and use it rather than
> > an explicit SKIP_$FOO?
> 
> Makes sense. It really boils down to "offline" vs. "allocate" use cases.
> 
> So maybe instead of "SKIP_FOO" something like "MEMORY_OFFLINE". ?

Yes, that would be a better fit.

-- 
Michal Hocko
SUSE Labs
