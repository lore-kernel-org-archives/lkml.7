Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685D9FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327D0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571229713;
	bh=3XsXnqm8KD7hd/CDFY4pwri49k+bqSguIkUqLxkvtR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o4H41OjyhCra7V2hXtV+x+1G3FsY1bKN8h7wOks6FaKq+UGVgJPW3xt8/3d1ZRaic
	 vwVIlTVFeja+3PxC9l2A6d+KOD3C44bMPmTtoOO9pqDYZhA3y107KMWl8V1N1eWzJd
	 lG8IWwEAjp+m3iDHfbFzQecs9MTMghcRbMfCcCFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393182AbfJPMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:41:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390395AbfJPMlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:41:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E948FB36C;
        Wed, 16 Oct 2019 12:41:49 +0000 (UTC)
Date:   Wed, 16 Oct 2019 14:41:49 +0200
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
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
Message-ID: <20191016124149.GB317@dhcp22.suse.cz>
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
 <20191016115119.GA317@dhcp22.suse.cz>
 <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 14:29:05, David Hildenbrand wrote:
> On 16.10.19 13:51, Michal Hocko wrote:
> > On Wed 16-10-19 16:43:57, Anshuman Khandual wrote:
> > > 
> > > 
> > > On 10/16/2019 04:39 PM, David Hildenbrand wrote:
> > [...]
> > > > Just to make sure, you ignored my comment regarding alignment
> > > > although I explicitly mentioned it a second time? Thanks.
> > > 
> > > I had asked Michal explicitly what to be included for the respin. Anyways
> > > seems like the previous thread is active again. I am happy to incorporate
> > > anything new getting agreed on there.
> > 
> > Your patch is using the same alignment as the original code would do. If
> > an explicit alignement is needed then this can be added on top, right?
> > 
> 
> Again, the "issue" I see here is that we could now pass in numbers that are
> not a power of two. For gigantic pages it was clear that we always have a
> number of two. The alignment does not make any sense otherwise.
> 
> What I'm asking for is
> 
> a) Document "The resulting PFN is aligned to nr_pages" and "nr_pages should
> be a power of two".

OK, this makes sense.

> b) Eventually adding something like
> 
> if (WARN_ON_ONCE(!is_power_of_2(nr_pages)))
> 	return NULL;

I am not sure this is really needed.

-- 
Michal Hocko
SUSE Labs
