Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39290C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DECA2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436982AbfHIR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:57:11 -0400
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:34892 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfHIR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:57:11 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 83DE8985B6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2019 18:57:08 +0100 (IST)
Received: (qmail 23304 invoked from network); 9 Aug 2019 17:57:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.93])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Aug 2019 17:57:08 -0000
Date:   Fri, 9 Aug 2019 18:57:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: drop mark_page_access from the unmap path
Message-ID: <20190809175706.GO2739@techsingularity.net>
References: <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
 <20190806105509.GA94582@google.com>
 <20190809124305.GQ18351@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190809124305.GQ18351@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 02:43:24PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 19:55:09, Minchan Kim wrote:
> > On Wed, Jul 31, 2019 at 09:21:01AM +0200, Michal Hocko wrote:
> > > On Wed 31-07-19 14:44:47, Minchan Kim wrote:
> [...]
> > > > As Nick mentioned in the description, without mark_page_accessed in
> > > > zapping part, repeated mmap + touch + munmap never acticated the page
> > > > while several read(2) calls easily promote it.
> > > 
> > > And is this really a problem? If we refault the same page then the
> > > refaults detection should catch it no? In other words is the above still
> > > a problem these days?
> > 
> > I admit we have been not fair for them because read(2) syscall pages are
> > easily promoted regardless of zap timing unlike mmap-based pages.
> > 
> > However, if we remove the mark_page_accessed in the zap_pte_range, it
> > would make them more unfair in that read(2)-accessed pages are easily
> > promoted while mmap-based page should go through refault to be promoted.
> 
> I have really hard time to follow why an unmap special handling is
> making the overall state more reasonable.
> 
> Anyway, let me throw the patch for further discussion. Nick, Mel,
> Johannes what do you think?
> 

I won't be able to answer follow-ups to this for a while but here is some
superficial thinking.

Minimally, you should test PageReferenced before setting it like
mark_page_accessed does to avoid unnecessary atomics.  I know it wasn't
done that way before but there is no harm in addressing it now.

workingset_activation is necessarily expensive. It could speculatively
lookup memcg outside the RCU read lock and only acquire it if there is
something interesting to lookup. Probably not much help though.

Note that losing the potential workingset_activation from the patch
may have consequences if we are relying on refaults to fix this up. I'm
undecided as to what degree it matters.

That said, I do agree that the mark_page_accessed on page zapping may
be overkill given that it can be a very expensive call if the page
gets activated and it's potentially being called in the zap path at a
high frequency. It's also not a function that is particularly easy to
optimise if you want to cover all the cases that matter. It really would
be preferably to have knowledge of a workload that really cares about
the activations from mmap/touch/munmap.

mark_page_accessed is a hint, it's known that there are gaps with
it so we shouldn't pay too much of a cost on information that only
might be useful. If the system is under no memory pressure because the
workloads are tuned to fit in memory (e.g. database using direct IO)
then mark_page_accessed is only cost. We could avoid marking it accessed
entirely if PF_EXITING given that if a task is exiting, it's not a strong
indication that the page is of any interest.  Even if the page is heavily
shared page and one user exits, the other users will keep it referenced
and prevent reclaim anyway. The benefit is too marginal too.

Given the definite cost of mark_page_accessed in this path and the main
corner case being tasks that access pages via mmap/touch/munmap (which is
insanely expensive if done at high frequency), I think it's reasonable to
rely on SetPageReferenced giving the page another lap of the LRU in most
cases (the obvious exception being CMA forcing reclaim). That opinion
might change if there is a known example of a realistic workload that
would suffer from the lack of explicit activations from teardown context.

-- 
Mel Gorman
SUSE Labs
