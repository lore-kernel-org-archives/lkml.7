Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A9C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F1D222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570078817;
	bh=05Js0E/+lflQhaIU5guBkuP134uDFLA2BySe2LnNdgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kELlwWTpFAEKLUck72TKZR8EN6bKvGRurSPD2DepnJQUkiBg4LDkvJKTbb6GwWD5H
	 JjsuBRjzuZluCGCyRJqy4M4c9EzxNqTscaR0GfgOp37KFLQhva6yC8Nj3ouxoXdDdP
	 5tKyWBl+NR98fFS509YOdUP1+YN+kZ5MfsWlXULc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJCFAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:00:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfJCFAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:00:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B537CAF5D;
        Thu,  3 Oct 2019 05:00:11 +0000 (UTC)
Date:   Thu, 3 Oct 2019 07:00:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
Message-ID: <20191003050010.GA24174@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
 <CAHk-=wgTqcdgyWjsj0Kip-2GLqx+dkWGoUTKmxCT3VN7Ya2bSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTqcdgyWjsj0Kip-2GLqx+dkWGoUTKmxCT3VN7Ya2bSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-10-19 16:37:57, Linus Torvalds wrote:
> On Wed, Oct 2, 2019 at 4:03 PM David Rientjes <rientjes@google.com> wrote:
> >
> > Since hugetlb allocations have explicitly preferred to loop and do reclaim
> > and compaction, exempt them from this new behavior at least for the time
> > being.  It is not shown that hugetlb allocation success rate has been
> > impacted by commit b39d0ee2632d but hugetlb allocations are admittedly
> > beyond the scope of what the patch is intended to address (thp
> > allocations).
> 
> I'd like to see some numbers to show that this special case makes sense.

http://lkml.kernel.org/r/20191001054343.GA15624@dhcp22.suse.cz
While the test is somehow artificial it is not too much different from
real workloads which do preallocate a non trivial (50% in my case) of
memory for hugetlb pages. Having a moderately utilized memory (by page
cache in my case) is not really unexpected.

> I understand the "this is what it used to do, and hugetlbfs wasn't the
> intended recipient of the new semantics", and I don't think the patch
> is wrong.

This is not only about this used to work. It is an expected and
documented semantic of __GFP_RETRY_MAYFAIL

 * %__GFP_RETRY_MAYFAIL: The VM implementation will retry memory reclaim
 * procedures that have previously failed if there is some indication
 * that progress has been made else where.  It can wait for other
 * tasks to attempt high level approaches to freeing memory such as
 * compaction (which removes fragmentation) and page-out.
 * There is still a definite limit to the number of retries, but it is
 * a larger limit than with %__GFP_NORETRY.
 * Allocations with this flag may fail, but only when there is
 * genuinely little unused memory. While these allocations do not
 * directly trigger the OOM killer, their failure indicates that
 * the system is likely to need to use the OOM killer soon.  The
 * caller must handle failure, but can reasonably do so by failing
 * a higher-level request, or completing it only in a much less
 * efficient manner.
 
> But at the same time, we do know that swap storms happen for other
> loads, and if we say "hugetlbfs is different" then there should at
> least be some rationale for why it's different other than "history".
> Some actual "yes, we _want_ the possibile swap storms, because load
> XYZ".
> 
> And I don't mean microbenchmark numbers for "look, behavior changed".
> I mean "look, this is a real load, and now it runs X% slower because
> it relied on this hugetlbfs behavior".

It is not about running slower. It is about not getting the expected
amount of hugetlb pages requested by admin who knows that that size is
needed.
-- 
Michal Hocko
SUSE Labs
