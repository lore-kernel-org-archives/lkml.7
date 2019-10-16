Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10066FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D821B21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571240750;
	bh=N+lMNue3nkoWG4pd4huo8h6kYuieTJBDhC1B/GGCZFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=loeEKp98sn6CQaz0MW/03Brye0Ax+/EPs6ZrAMCZchhL8/gEDxtpbrxZzgOcs6kWt
	 c9H5d0wkDgwsDydV1/NA5MYBULz31JhoPL2Vwm9xlNgyrl6cg1lq/90gO6XB+URwTb
	 VwO+hg8clOTd5Fkzg85/ggGUsbGpL74cIlOBAF04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405628AbfJPPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:45:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:49492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404969AbfJPPpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:45:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1E46B12C;
        Wed, 16 Oct 2019 15:45:46 +0000 (UTC)
Date:   Wed, 16 Oct 2019 17:45:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
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
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
Message-ID: <20191016154545.GF317@dhcp22.suse.cz>
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
 <20191016115119.GA317@dhcp22.suse.cz>
 <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
 <20191016124149.GB317@dhcp22.suse.cz>
 <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 21:01:19, Anshuman Khandual wrote:
> 
> 
> On 10/16/2019 06:11 PM, Michal Hocko wrote:
> > On Wed 16-10-19 14:29:05, David Hildenbrand wrote:
> >> On 16.10.19 13:51, Michal Hocko wrote:
> >>> On Wed 16-10-19 16:43:57, Anshuman Khandual wrote:
> >>>>
> >>>>
> >>>> On 10/16/2019 04:39 PM, David Hildenbrand wrote:
> >>> [...]
> >>>>> Just to make sure, you ignored my comment regarding alignment
> >>>>> although I explicitly mentioned it a second time? Thanks.
> >>>>
> >>>> I had asked Michal explicitly what to be included for the respin. Anyways
> >>>> seems like the previous thread is active again. I am happy to incorporate
> >>>> anything new getting agreed on there.
> >>>
> >>> Your patch is using the same alignment as the original code would do. If
> >>> an explicit alignement is needed then this can be added on top, right?
> >>>
> >>
> >> Again, the "issue" I see here is that we could now pass in numbers that are
> >> not a power of two. For gigantic pages it was clear that we always have a
> >> number of two. The alignment does not make any sense otherwise.
> 
> ALIGN() does expect nr_pages two be power of two otherwise the mask
> value might not be correct, affecting start pfn value for a zone.
> 
> #define ALIGN(x, a)             	__ALIGN_KERNEL((x), (a))
> #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))

Yes it doesn't really provide a sensible result but does it matter?
 
> >> What I'm asking for is
> >>
> >> a) Document "The resulting PFN is aligned to nr_pages" and "nr_pages should
> >> be a power of two".
> > 
> > OK, this makes sense.
> Sure, will add this to the alloc_contig_pages() helper description and
> in the commit message as well.
> 
> > 
> >> b) Eventually adding something like
> >>
> >> if (WARN_ON_ONCE(!is_power_of_2(nr_pages)))
> >> 	return NULL;
> > 
> > I am not sure this is really needed.
> > 
> Just wondering why not ? Ideally if we are documenting that nr_pages should be
> power of two, then we should abort erring allocation request with an warning. Is
> it because allocation can still succeed for non-power-of-two requests despite
> possible problem with mask and alignment ? Hence there is no need to abort it.

What would we do about the warning? There are only three ways to go
about this a) reguire power of two nr_pages and always align to that b)
do not restrict nr_pages and align implicitly to what makes sense (power
of two on proper size and arbitrary page aligned otherwise) and c) allow
an explicit alignment.

The simplest way forward is b) because that doesn't really require any
code changes. And I thought the main point of this patch was to provide
something as simple as possible. a) would be only slightly more
complicated but I am wondering why should be restrict the size of the
allocation when there is nothing inherent to do so.
-- 
Michal Hocko
SUSE Labs
