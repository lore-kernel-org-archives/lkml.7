Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA64CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660BF222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571386531;
	bh=dbYTEPepwq2NXMQKLdUD/+pylufYh+qpruHzL+pgF0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z/cXE4PIJTDEH8scqnwpWRHkjhu8y2CQFI1sVulzHV+sp8zE75MTJ8lQ9uba+XYBZ
	 FpG9Y3TFGyoh+3LQzmZYQbXzEitJtBBbGeh7g/nEx4UAA2J0ca+yreV28SPYs20WCX
	 tueRiK7zifB8Tczz2IT04B5XFfYTRWq0iHgXuXNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442166AbfJRIPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:15:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731008AbfJRIPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:15:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21B5CB1A4;
        Fri, 18 Oct 2019 08:15:27 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:15:24 +0200
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
Message-ID: <20191018081524.GD5017@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-7-david@redhat.com>
 <20191016114321.GX317@dhcp22.suse.cz>
 <36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
 <20191016140350.GD317@dhcp22.suse.cz>
 <7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 16:14:52, David Hildenbrand wrote:
> On 16.10.19 16:03, Michal Hocko wrote:
[...]
> > But why cannot you keep the reference count at 1 (do get_page when
> > offlining the page)? In other words as long as the driver knows the page
> > has been returned to the host then it has ref count at 1. Once the page
> > is returned to the guest for whatever reason it can free it to the
> > system by clearing the offline state and put_page.
> 
> I think I explained how the reference count of 1 is problematic when wanting
> to offline the memory. After all that's the problem I try to solve: Keep
> PG_offline set until the memory is offline and make sure nobody will touch
> the page.

Please bear with me but I still believe that elevated reference count
has some merits. I do understand that you maintain your metadata to
recognize that the memory handed over to the hypervisor will not
magically appear after onlining. But I believe that you can achieve
the same with an elevated reference count and have a more robust design
as well.

Let's say that you still keep a reference to your offlined pages and
mark them offlined. That should make sure that no consumer of the
pfn_to_online_page will touch the page's content nor the state. Now
admin might want to offline/hotremove the whole memory block via sysfs.
An elevated reference count would prevent offlining to finish. And I
believe this is a good thing because the owner of the offline page might
still need to do something to "untrack" that page. We have an interface
for that - MEM_GOING_OFFLINE notification. This sounds like a good place
for the driver to decide whether it is safe to let the page go or not.
If you can let the page go then just drop the reference count. The page
is isolated already by that time. If you cannot let it go for whatever
reason you can fail the offlining.

An advantage is that the driver has the full control over offlining and
also you do not really have to track a new online request to do the
right thing.

Or do I still see it too simplistically and the notifier is not a good
place to handle the reference count?
-- 
Michal Hocko
SUSE Labs
