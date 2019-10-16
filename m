Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB5FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22C42168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571234636;
	bh=rPwNWGPK+kIS6yZVHTUc/CnXQAH8Jr/Xa/VkkmskeGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XrK7DtZuDd+aqhNN3jI+9Du4Tj7Ht5zcCYTbibAoqhysgr+4mOI6yowFbfosyzuJ8
	 Zs9X8Ac5bm1dzGWrrU39qVhOqka+/mpgrdPumM9323HZDBRCizHH69Tde0fmqVZwsN
	 uLBISt0JcvuzlYCRLp4lDVSYA/px10Qq/dTQm7gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbfJPODz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:03:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729857AbfJPODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:03:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4972DAF41;
        Wed, 16 Oct 2019 14:03:52 +0000 (UTC)
Date:   Wed, 16 Oct 2019 16:03:50 +0200
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
Message-ID: <20191016140350.GD317@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-7-david@redhat.com>
 <20191016114321.GX317@dhcp22.suse.cz>
 <36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 15:45:06, David Hildenbrand wrote:
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
> > Should we allow to try_remove_memory to succeed with these pages?
> > Do we really have hook into __put_page? Why do we even care about the
> > reference count of those pages?
> 
> Oh, I forgot to answer this questions. The __put_page() change is necessary
> for the following race I identified:
> 
> Page has a refcount of 1 (e.g., allocated by virtio-mem using
> alloc_contig_range()).
> 
> a) kernel: get_page_unless_zero(page): refcount = 2
> b) virtio-mem: set page PG_offline, reduce refcount): refocunt = 1
> c) kernel: put_page(page): refcount = 0
> 
> The page would suddenly be given to the buddy. which is bad.

But why cannot you keep the reference count at 1 (do get_page when
offlining the page)? In other words as long as the driver knows the page
has been returned to the host then it has ref count at 1. Once the page
is returned to the guest for whatever reason it can free it to the
system by clearing the offline state and put_page.

An elevated ref count could help to detect that the memory hotremove is
not safe until the driver removes all potential metadata it might still
hold. You also know that memory online should skip such a page.

All in all your page is still in use by the driver and the life cycle is
controlled by that driver.

Or am I am missing something?
-- 
Michal Hocko
SUSE Labs
