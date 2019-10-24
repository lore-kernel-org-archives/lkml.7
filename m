Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0149C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B576B21925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571906570;
	bh=5fEwwB5rKQ1U8XwzHcNMpdLLlKwOhuGZXveUb4nVNII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tiwrt8qkAsunPM8PNz5LAhPj2i4h+mLI3nQ0zQ3t0p5j7Ktbzg4mS5hpWvqYMkFH3
	 UVhMudAzNX0ZkLNgtyeAfwmjxa1MXJzFiJuvysMMyQUvDqRxvnBDrViyNVuaq3X58W
	 2uX9+IKwo+FhkrvCxLHYGz721FIXkpNdUxwlG3Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438301AbfJXImt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:42:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727079AbfJXImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:42:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D604B597;
        Thu, 24 Oct 2019 08:42:46 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:42:41 +0200
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
Message-ID: <20191024084241.GV17610@dhcp22.suse.cz>
References: <20191016140350.GD317@dhcp22.suse.cz>
 <7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
 <20191018081524.GD5017@dhcp22.suse.cz>
 <83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
 <20191018111843.GH5017@dhcp22.suse.cz>
 <709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
 <20191022122326.GL9379@dhcp22.suse.cz>
 <b4be42a4-cbfc-8706-cc94-26211ddcbe4a@redhat.com>
 <20191023094345.GL754@dhcp22.suse.cz>
 <ad2aef12-61ac-f019-90d1-59637255f9e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2aef12-61ac-f019-90d1-59637255f9e3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 12:03:51, David Hildenbrand wrote:
> >Do you see any downsides?
> 
> The only downside I see is that we get more false negatives on
> has_unmovable_pages(), eventually resulting in the offlining stage after
> isolation to loop forever (as some PageOffline() pages are not movable
> (especially, XEN balloon, HyperV balloon), there won't be progress).
> 
> I somewhat don't like forcing everybody that uses PageOffline() (especially
> all users of balloon compaction) to implement memory notifiers just to avoid
> that. Maybe, we even want to use PageOffline() in the future in the core
> (e.g., for memory holes instead of PG_reserved or similar).

There is only a handful of those and we need to deal with them anyway.
If you do not want to enforce them to create their own notifiers then we
can accomodate the hotplug code. __test_page_isolated_in_pageblock resp.
the call chain up can distinguish temporary and permanent failures
(EAGAIN vs. EBUSY). The current state when we always return EBUSY and
keep retrying for ever is not optimal at all, right? A referenced PageOffline
could be an example of EBUSY all other failures where we are effectively
waiting for pages to get freed finaly would be EAGAIN.

It is a bit late in the process because a large portion of the work has
been done already but this doesn't sound like something to lose sleep
over.
-- 
Michal Hocko
SUSE Labs
