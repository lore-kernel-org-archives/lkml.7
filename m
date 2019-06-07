Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93745C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D4220B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559896379;
	bh=GabatJG+URwc/L3jrFGfQfwSdg5DMbnwNCD/Miw+Vbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bIJTs+nHtMM6gq3GfqSM9caJJmmrQhw5mbZqkgZTYSNBeIgflWzXE+M/cZTs8Dwxi
	 M93wja9t+3HPy2uY0I+YfjGi3iOjFT6UDqgp1SBlCuRLmyy4HXuqJ2I6eiwGeNzHKb
	 tC/46W+byvew0r+y54P56UiNT91lTpd4tuDJ4OEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFGIc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:32:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfFGIc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:32:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3AAFAF22;
        Fri,  7 Jun 2019 08:32:55 +0000 (UTC)
Date:   Fri, 7 Jun 2019 10:32:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
Message-ID: <20190607083255.GA18435@dhcp22.suse.cz>
References: <20190503223146.2312-3-aarcange@redhat.com>
 <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
 <20190520153621.GL18914@techsingularity.net>
 <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
 <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com>
 <20190531092236.GM6896@dhcp22.suse.cz>
 <alpine.DEB.2.21.1905311430120.92278@chino.kir.corp.google.com>
 <20190605093257.GC15685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1906061451001.121338@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906061451001.121338@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-06-19 15:12:40, David Rientjes wrote:
> On Wed, 5 Jun 2019, Michal Hocko wrote:
> 
> > > That's fine, but we also must be mindful of users who have used 
> > > MADV_HUGEPAGE over the past four years based on its hard-coded behavior 
> > > that would now regress as a result.
> > 
> > Absolutely, I am all for helping those usecases. First of all we need to
> > understand what those usecases are though. So far we have only seen very
> > vague claims about artificial worst case examples when a remote access
> > dominates the overall cost but that doesn't seem to be the case in real
> > life in my experience (e.g. numa balancing will correct things or the
> > over aggressive node reclaim tends to cause problems elsewhere etc.).
> > 
> 
> The usecase is a remap of a binary's text segment to transparent hugepages 
> by doing mmap() -> madvise(MADV_HUGEPAGE) -> mremap() and when this 
> happens on a locally fragmented node.  This happens at startup when we 
> aren't concerned about allocation latency: we want to compact.  We are 
> concerned with access latency thereafter as long as the process is 
> running.

You have indicated this previously but no call for a stand alone
reproducer was successful. It is really hard to optimize for such a
specialized workload without anything to play with. Btw. this is exactly
a case where I would expect numa balancing to converge to the optimal
placement. And if numabalancing is not an option than an explicit
mempolicy (e.g. the one suggested here) would be a good fit.

[...]

I will defer the compaction related stuff to Vlastimil and Mel who are
much more familiar with the current code.

> So my proposed change would be:
>  - give the page allocator a consistent indicator that compaction failed
>    because we are low on memory (make COMPACT_SKIPPED really mean this),
>  - if we get this in the page allocator and we are allocating thp, fail,
>    reclaim is unlikely to help here and is much more likely to be
>    disruptive
>      - we could retry compaction if we haven't scanned all memory and
>        were contended,
>  - if the hugepage allocation fails, have thp check watermarks for order-0 
>    pages without any padding,
>  - if watermarks succeed, fail the thp allocation: we can't allocate
>    because of fragmentation and it's better to return node local memory,

Doesn't this lead to the same THP low success rate we have seen with one
of the previous patches though?

Let me remind you of the previous semantic I was proposing
http://lkml.kernel.org/r/20181206091405.GD1286@dhcp22.suse.cz and that
didn't get shot down. Linus had some follow up ideas on how exactly
the fallback order should look like and that is fine. We should just
measure differences between local node cheep base page vs. remote THP on
_real_ workloads. Any microbenchmark which just measures a latency is
inherently misleading.

And really, fundamental problem here is that MADV_HUGEPAGE has gained 
a NUMA semantic without a due scrutiny leading to a broken interface
with side effects that are simply making the interface unusable for a
large part of usecases that the madvise was originaly designed for.
Until we find an agreement on this point we will be looping in a dead
end discussion, I am afraid.

-- 
Michal Hocko
SUSE Labs
