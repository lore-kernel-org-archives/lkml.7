Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B4C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6865221726
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560258503;
	bh=/hz58urQHm2wqHN6CibGtL4QUw2sgjPTeMFopPrRQso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YmBT/OeeGoapMryZSCmuGNu0ym8wwqeBaMCSvkzXBW65bU7cWwPYDOJxgUsfBMkrN
	 9dwF3Ys+haazFJkNOa1g285aTpL9H4KWvpjW0AgD0EfpjmaDQ8FB1FpRZ9M8dmjf6B
	 9feZ9M61lT4nK07o/LXRI6MQ6k4PY1nyb0oIJe8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfFKNIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfFKNIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:08:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5CA9ADD4;
        Tue, 11 Jun 2019 13:08:20 +0000 (UTC)
Date:   Tue, 11 Jun 2019 15:08:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Chengang (L)" <cg.chen@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "pavel.tatashin@microsoft.com" <pavel.tatashin@microsoft.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: align up min_free_kbytes to multipy of 4
Message-ID: <20190611130820.GI2388@dhcp22.suse.cz>
References: <D27E5778F399414A8B5D5F672064BAD8B3E5FB7B@dggemi529-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D27E5778F399414A8B5D5F672064BAD8B3E5FB7B@dggemi529-mbs.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-06-19 12:16:35, Chengang (L) wrote:
> Hi Michal
> 
> 
> >On Sun 09-06-19 17:10:28, ChenGang wrote:
> >> Usually the value of min_free_kbytes is multiply of 4, and in this 
> >> case ,the right shift is ok.
> >> But if it's not, the right-shifting operation will lose the low 2 
> >> bits, and this cause kernel don't reserve enough memory.
> >> So it's necessary to align the value of min_free_kbytes to multiply of 4.
> >> For example, if min_free_kbytes is 64, then should keep 16 pages, but 
> >> if min_free_kbytes is 65 or 66, then should keep 17 pages.
> 
> >Could you describe the actual problem? Do we ever generate min_free_kbytes that would lead to unexpected reserves or is this trying to compensate for those values being configured from the userspace? If later why do we care at all?
> 
> >Have you seen this to be an actual problem or is this mostly motivated by the code reading?
> 
> I haven't seen an actual problem, and it's motivated by code
> reading.  Users can configure this value through interface
> /proc/sys/vm/min_free_kbytes, so I think a bit precious is better.

The interface is intended for admins and they should better know what
they are doing, right? Using an ad-hoc valus is not something that is a
common usecase.

That being said, your change makes the code slightly harder to read and
the benefit is not entirely clear from the changelog (which btw. sounds
like there is a real problem which is not described in the user visible
terms). So if you really believe this change is worth it, then make sure
you justify it by exaplain what is a negative consequence of a dubious
value set by an admin.

> >> Signed-off-by: ChenGang <cg.chen@huawei.com>
> >> ---
> >>  mm/page_alloc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c index d66bc8a..1baeeba 
> >> 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
> >>  
> >>  static void __setup_per_zone_wmarks(void)  {
> >> -	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
> >> +	unsigned long pages_min =
> >> +		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);
> >>  	unsigned long lowmem_pages = 0;
> >>  	struct zone *zone;
> >>  	unsigned long flags;
> >> --
> >> 1.8.5.6
> >> 
> 
> >-- 
> >Michal Hocko
> >SUSE Labs

-- 
Michal Hocko
SUSE Labs
