Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6EECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2F218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571747013;
	bh=CzOTWYzGHBxu2RnXQaWlSCzp43AOEwqG/Y7JvN1JDPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtpTMa3drc9IWJ4nts5I6SBKJ63aTf+BKNIXQVSPH2OzmzXAaC2sxK2xhSevEyUfR
	 YJHPwkk85fxAz+GwkmbMd/sFtiy/jhsDhdVXfavpajzsfOohXw6NonLJWFjFYmR8nn
	 n45hPLiDdCgGFoBZXfit+3D90YUKNvP1syaKSEWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbfJVMXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:23:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387575AbfJVMXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:23:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2896CB26A;
        Tue, 22 Oct 2019 12:23:28 +0000 (UTC)
Date:   Tue, 22 Oct 2019 14:23:26 +0200
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
Message-ID: <20191022122326.GL9379@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-7-david@redhat.com>
 <20191016114321.GX317@dhcp22.suse.cz>
 <36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
 <20191016140350.GD317@dhcp22.suse.cz>
 <7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
 <20191018081524.GD5017@dhcp22.suse.cz>
 <83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
 <20191018111843.GH5017@dhcp22.suse.cz>
 <709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 14:35:06, David Hildenbrand wrote:
> On 18.10.19 13:20, Michal Hocko wrote:
> > On Fri 18-10-19 10:50:24, David Hildenbrand wrote:
> > > On 18.10.19 10:15, Michal Hocko wrote:
[...]
> > > > for that - MEM_GOING_OFFLINE notification. This sounds like a good place
> > > > for the driver to decide whether it is safe to let the page go or not.
> > > 
> > > As I explained, this is too late and fragile. I post again what I posted
> > > before with some further explanations
> > > 
> > > __offline_pages() works like this:
> > > 
> > > 1) start_isolate_page_range()
> > > -> offline pages with a reference count of one will be detected as
> > > unmovable -> offlining aborted. (see below on the memory isolation notifier)
> > 
> > I am assuming that has_unmovable_pages would skip over those pages. Your
> > patch already does that, no?
> 
> Yes, this works IFF the reference count is 0 (IOW, this patch). Not with a
> reference count of 1 (unless the pages are movable, like with balloon
> compaction).

I am pretty sure that has_unmovable_pages can special these pages
regardless of the reference count for the memory hotplug. We already do
that for HWPoison pages.
 
> Please note that we have other users that use PG_offline + refcount >= 1
> (HyperV balloon, XEN). We should not affect these users (IOW,
> has_unmovable_pages() has to stop right there if we see one of these pages).

OK, this is exactly what I was worried about. I can see why you might
want to go an easier way and rule those users out but wouldn't be it
actually more reasonable to explicitly request PageOffline users to
implement MEM_GOING_OFFLINE and prepare their offlined pages for the
offlining operation or fail right there if that is not possible.
If you fail right there during the isolation phase then there is no way
to allow the offlining to proceed from that context.
 
> > > 2) memory_notify(MEM_GOING_OFFLINE, &arg);
> > > -> Here, we could release all pages to the buddy, clearing PG_offline
> > > -> PF_offline must not be cleared so dumping tools will not touch
> > >     these pages. There is a time where pages are !PageBuddy() and
> > >     !PageOffline().
> > 
> > Well, this is fully under control of the driver, no? Reference count
> > shouldn't play any role here AFAIU.
> 
> Yes, this is more a PG_offline issue. The reference count is an issue of
> reaching this call :) If we want to go via the buddy:
> 
> 1. Clear PG_offline
> 2. Free page (gets set PG_buddy)
> 
> Between 1 and 2, a dumping tool could not exclude these pages and therefore
> try to read from these pages. That is an issue IFF we want to return the
> pages back to the buddy instead of doing what I propose here.

If the driver is going to free page to the allocator then it would have
to claim the page back and so it is usable again. If it cannot free it
then it would simply set the reference count to 0. It can even keep the
PG_offline if necessary although I have to admit I am not really sure it
is necessary.

> > > 3) scan_movable_pages() ...
> 
> Please note that when we don't put the pages back to the buddy and don't
> implement something like I have in this patch, we'll loop/fail here.
> Especially if we have pages with PG_offline + refcount >= 1 .

You should have your reference count 0 at this stage as it is after
MEM_GOING_OFFLINE.
 
> > MEM_CANCEL_OFFLINE could gain the reference back to balance the
> > MEM_GOING_OFFLINE step.
> 
> The pages are already unisolated and could be used by the buddy. But again,
> I think you have an idea that tries to avoid putting pages to the buddy.

Yeah, set_page_count(page, 0) if you do not want to release that page
from the notifier context to reflect that the page is ok to be offlined
with the rest.
 
[...]

> > explicit control via the reference count which is the standard way to
> > control the struct page life cycle.
> > 
> > Anyway hooking into __put_page (which tends to be a hot path with
> > something that is barely used on most systems) doesn't sound nice to me.
> > This is the whole point which made me think about the whole reference
> > count approach in the first place.
> 
> Again, the race I think that is possible
> 
> somebody: get_page_unless_zero(page)
> virtio_mem: page_ref_dec(pfn_to_page(pfn)
> somebody: put_page() -> straight to the buddy

Who is that somebody? I thought that it is only the owner/driver to have
a control over the page. Also the above is not possible as long as the
owner/driver keeps a reference to the PageOffline page throughout the
time it is marked that way.
 
[...]

> > > > If you can let the page go then just drop the reference count. The page
> > > > is isolated already by that time. If you cannot let it go for whatever
> > > > reason you can fail the offlining.
> > > 
> > > We do have one hack in current MM code, which is the memory isolation
> > > notifier only used by CMM on PPC. It allows to "cheat" has_unmovable_pages()
> > > to skip over unmovable pages. But quite frankly, I rather want to get rid of
> > > that crap (something I am working on right now) than introduce new users.
> > > This stuff is racy as hell and for CMM, if memory offlining fails, the
> > > ballooned pages are suddenly part of the buddy. Fragile.
> > 
> > Could you be more specific please?
> 
> Let's take a look at how arch/powerpc/platforms/pseries/cmm.c handles it:
> 
> cmm_memory_isolate_cb() -> cmm_count_pages(arg):
> - Memory Isolation notifier callback
> - Count how many pages in the range to be isolated are in the ballooon
> - This makes has_unmovable_pages() succeed. Pages can be isolated.
> 
> cmm_memory_cb -> cmm_mem_going_offline(arg):
> - Memory notifier (online/offline)
> - Release all pages in the range to the buddy
> 
> If offlining fails, the pages are now in the buddy, no longer in the
> balloon. MEM_CANCEL_ONLINE is too late, because the range is already
> unisolated again and the pages might be in use.
> 
> For CMM it might not be that bad, because it can actually "reloan" any
> pages. In contrast, virtio-mem cannot simply go ahead and reuse random
> memory in unplugged. Any access to these pages would be evil. Giving them
> back to the buddy is dangerous.

Thanks, I was not aware of that code. But from what I understood this is
an outright bug in this code because cmm_mem_going_offline releases
pages to the buddy allocator which is something that is not recoverable
on a later failure.

-- 
Michal Hocko
SUSE Labs
