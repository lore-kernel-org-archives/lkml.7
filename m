Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BFFFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58DD20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571224116;
	bh=9h5rk5wG9u0PrxLqHEh7Pu8GaErpedAh6B+yh8QNHEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UPcrW4eEeRnJicRhfmmKYYDnaf3fqZEDLyovE9J3pghQRLYgvgGSYhQfH4vB4mRNC
	 2FTbh3J6jV4vZ6gh0dNVXzXaHVeTwfE7lHmpTzS2BF7CuJcuF67MEuGgo/NVE3I+Wm
	 dp+IA6w8yL+kx0iiw0Uwt6G3IWFmUWDS/RJI6jlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392610AbfJPLIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfJPLIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:08:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 096DDB1FF;
        Wed, 16 Oct 2019 11:08:32 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:08:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
Message-ID: <20191016110831.GV317@dhcp22.suse.cz>
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <c7ac9f99-a34f-c553-b216-b847d093cae9@redhat.com>
 <20191016085123.GO317@dhcp22.suse.cz>
 <679b5c66-8f1b-ec4d-64dd-13fbc440917d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679b5c66-8f1b-ec4d-64dd-13fbc440917d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 10:56:16, David Hildenbrand wrote:
> On 16.10.19 10:51, Michal Hocko wrote:
> > On Wed 16-10-19 10:08:21, David Hildenbrand wrote:
> > > On 16.10.19 09:34, Anshuman Khandual wrote:
> > [...]
> > > > +static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
> > > > +				   unsigned long nr_pages)
> > > > +{
> > > > +	unsigned long i, end_pfn = start_pfn + nr_pages;
> > > > +	struct page *page;
> > > > +
> > > > +	for (i = start_pfn; i < end_pfn; i++) {
> > > > +		page = pfn_to_online_page(i);
> > > > +		if (!page)
> > > > +			return false;
> > > > +
> > > > +		if (page_zone(page) != z)
> > > > +			return false;
> > > > +
> > > > +		if (PageReserved(page))
> > > > +			return false;
> > > > +
> > > > +		if (page_count(page) > 0)
> > > > +			return false;
> > > > +
> > > > +		if (PageHuge(page))
> > > > +			return false;
> > > > +	}
> > > 
> > > We might still try to allocate a lot of ranges that contain unmovable data
> > > (we could avoid isolating a lot of page blocks in the first place). I'd love
> > > to see something like pfn_range_movable() (similar, but different to
> > > is_mem_section_removable(), which uses has_unmovable_pages()).
> > 
> > Just to make sure I understand. Do you want has_unmovable_pages to be
> > called inside pfn_range_valid_contig?
> 
> I think this requires more thought, as has_unmovable_pages() works on
> pageblocks only AFAIK. If you try to allocate < MAX_ORDER - 1, you could get
> a lot of false positives.
> 
> E.g., if a free "MAX_ORDER - 1" page spans two pageblocks and you only test
> the second pageblock, you might detect "unmovable" if not taking proper care
> of the "bigger" free page. (alloc_contig_range() properly works around that
> issue)

OK, I see your point. You are right that false positives are possible. I
would deal with those in a separate patch though.

> > [...]
> > > > +struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
> > > > +				int nid, nodemask_t *nodemask)
> > > > +{
> > > > +	unsigned long ret, pfn, flags;
> > > > +	struct zonelist *zonelist;
> > > > +	struct zone *zone;
> > > > +	struct zoneref *z;
> > > > +
> > > > +	zonelist = node_zonelist(nid, gfp_mask);
> > > > +	for_each_zone_zonelist_nodemask(zone, z, zonelist,
> > > > +					gfp_zone(gfp_mask), nodemask) {
> > > 
> > > One important part is to never use the MOVABLE zone here (otherwise
> > > unmovable data would end up on the movable zone). But I guess the caller is
> > > responsible for that (not pass GFP_MOVABLE) like gigantic pages do.
> > 
> > Well, if the caller uses GFP_MOVABLE then the movability should be
> > implemented in some form. If that is not the case then it is a bug on
> > the caller behalf.
> > 
> > > > +		spin_lock_irqsave(&zone->lock, flags);
> > > > +
> > > > +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> > > 
> > > This alignment does not make too much sense when allowing passing in !power
> > > of two orders. Maybe the caller should specify the requested alignment
> > > instead? Or should we enforce this to be aligned to make our life easier for
> > > now?
> > 
> > Are there any usecases that would require than the page alignment?
> 
> Gigantic pages have to be aligned AFAIK.

Aligned to what? I do not see any guarantee like that in the existing
code.

-- 
Michal Hocko
SUSE Labs
