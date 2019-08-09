Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F00C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B092214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565354609;
	bh=r0QJzeaj8zr29WVjE9HdJAZRj0A7iB3blal29rIll70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mqCQItHGgHapDaXHA8vthYx0yTb9rKWuhafvytdJh3uzhn+bABa51HhR0cc+3l9yJ
	 LLOS55sD7SYBCesU9U1nqbB9BelIOXyDt/cK2BFnz5R16RC2FlwAnzJWPrrZmcIUJx
	 vu2Q99HESRuQtw7AAw7TN9E7rGR5CsStykB99NxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbfHIMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:43:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406516AbfHIMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:43:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7472BAF10;
        Fri,  9 Aug 2019 12:43:25 +0000 (UTC)
Date:   Fri, 9 Aug 2019 14:43:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH] mm: drop mark_page_access from the unmap path
Message-ID: <20190809124305.GQ18351@dhcp22.suse.cz>
References: <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
 <20190806105509.GA94582@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806105509.GA94582@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 19:55:09, Minchan Kim wrote:
> On Wed, Jul 31, 2019 at 09:21:01AM +0200, Michal Hocko wrote:
> > On Wed 31-07-19 14:44:47, Minchan Kim wrote:
[...]
> > > As Nick mentioned in the description, without mark_page_accessed in
> > > zapping part, repeated mmap + touch + munmap never acticated the page
> > > while several read(2) calls easily promote it.
> > 
> > And is this really a problem? If we refault the same page then the
> > refaults detection should catch it no? In other words is the above still
> > a problem these days?
> 
> I admit we have been not fair for them because read(2) syscall pages are
> easily promoted regardless of zap timing unlike mmap-based pages.
> 
> However, if we remove the mark_page_accessed in the zap_pte_range, it
> would make them more unfair in that read(2)-accessed pages are easily
> promoted while mmap-based page should go through refault to be promoted.

I have really hard time to follow why an unmap special handling is
making the overall state more reasonable.

Anyway, let me throw the patch for further discussion. Nick, Mel,
Johannes what do you think?

From 3821c2e66347a2141358cabdc6224d9990276fec Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 9 Aug 2019 14:29:59 +0200
Subject: [PATCH] mm: drop mark_page_access from the unmap path

Minchan has noticed that mark_page_access can take quite some time
during unmap:
: I had a time to benchmark it via adding some trace_printk hooks between
: pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
: device is 2018 premium mobile device.
:
: I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
: task runs on little core even though it doesn't have any IPI and LRU
: lock contention. It's already too heavy.
:
: If I remove activate_page, 35-40% overhead of zap_pte_range is gone
: so most of overhead(about 0.7ms) comes from activate_page via
: mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
: accumulate up to several ms.

bf3f3bc5e734 ("mm: don't mark_page_accessed in fault path") has replaced
SetPageReferenced by mark_page_accessed arguing that the former is not
sufficient when mark_page_accessed is removed from the fault path
because it doesn't promote page to the active list. It is true that a
page that is mapped by a single process might not get promoted even when
referenced if the reclaim checks it after the unmap but does that matter
that much? Can we cosider the page hot if there are no other
users? Moreover we do have workingset detection in place since then and
so a next refault would activate the page if it was really hot one.

Drop the expensive mark_page_accessed and restore SetPageReferenced to
transfer the reference information into the struct page for now to
reduce the unmap overhead. Should we find workloads that noticeably
depend on this behavior we should find a way to make mark_page_accessed
less expensive.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..ced521df8ee7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1053,7 +1053,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				}
 				if (pte_young(ptent) &&
 				    likely(!(vma->vm_flags & VM_SEQ_READ)))
-					mark_page_accessed(page);
+					SetPageReferenced(page);
 			}
 			rss[mm_counter(page)]--;
 			page_remove_rmap(page, false);
-- 
2.20.1

-- 
Michal Hocko
SUSE Labs
