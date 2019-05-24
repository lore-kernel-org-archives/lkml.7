Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E420868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbfEXU3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:29:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403760AbfEXU3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:29:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 940B630821B3;
        Fri, 24 May 2019 20:29:35 +0000 (UTC)
Received: from ultra.random (ovpn-120-242.rdu2.redhat.com [10.10.120.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51E0868B02;
        Fri, 24 May 2019 20:29:32 +0000 (UTC)
Date:   Fri, 24 May 2019 16:29:31 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
Message-ID: <20190524202931.GB11202@redhat.com>
References: <20190503223146.2312-1-aarcange@redhat.com>
 <20190503223146.2312-3-aarcange@redhat.com>
 <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
 <20190520153621.GL18914@techsingularity.net>
 <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 24 May 2019 20:29:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Thu, May 23, 2019 at 05:57:37PM -0700, Andrew Morton wrote:
> On Mon, 20 May 2019 10:54:16 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > We are going in circles, *yes* there is a problem for potential swap 
> > storms today because of the poor interaction between memory compaction and 
> > directed reclaim but this is a result of a poor API that does not allow 
> > userspace to specify that its workload really will span multiple sockets 
> > so faulting remotely is the best course of action.  The fix is not to 
> > cause regressions for others who have implemented a userspace stack that 
> > is based on the past 3+ years of long standing behavior or for specialized 
> > workloads where it is known that it spans multiple sockets so we want some 
> > kind of different behavior.  We need to provide a clear and stable API to 
> > define these terms for the page allocator that is independent of any 
> > global setting of thp enabled, defrag, zone_reclaim_mode, etc.  It's 
> > workload dependent.
> 
> um, who is going to do this work?

That's a good question. It's going to be a not simple patch to
backport to -stable: it'll be intrusive and it will affect
mm/page_alloc.c significantly so it'll reject heavy. I wouldn't
consider it -stable material at least in the short term, it will
require some testing.

This is why applying a simple fix that avoids the swap storms (and the
swap-less pathological THP regression for vfio device assignment GUP
pinning) is preferable before adding an alloc_pages_multi_order (or
equivalent) so that it'll be the allocator that will decide when
exactly to fallback from 2M to 4k depending on the NUMA distance and
memory availability during the zonelist walk. The basic idea is to
call alloc_pages just once (not first for 2M and then for 4k) and
alloc_pages will decide which page "order" to return.

> Implementing a new API doesn't help existing userspace which is hurting
> from the problem which this patch addresses.

Yes, we can't change all apps that may not fit in a single NUMA
node. Currently it's unsafe to turn "transparent_hugepages/defrag =
always" or the bad behavior can then materialize also outside of
MADV_HUGEPAGE. Those apps that use MADV_HUGEPAGE on their long lived
allocations (i.e. guest physical memory) like qemu are affected even
with the default "defrag = madvise". Those apps are using
MADV_HUGEPAGE for more than 3 years and they are widely used and open
source of course.

> It does appear to me that this patch does more good than harm for the
> totality of kernel users, so I'm inclined to push it through and to try
> to talk Linus out of reverting it again.  

That sounds great. It's also what 3 enterprise distributions had to do
already.

As Mel described in detail, remote THP can't be slower than the swap
I/O (even if we'd swap on a nvdimm it wouldn't change this).

As Michael suggested a dynamic "numa_node_id()" mbind could be pursued
orthogonally to still be able to retain the current upstream behavior
for small apps that can fit in the node and do extremely long lived
static allocations and that don't care if they cause a swap storm
during startup. All we argue about is the default "defrag = always"
and MADV_HUGEPAGE behavior.

The current behavior of "defrag = always" and MADV_HUGEPAGE is way
more aggressive than zone_reclaim_mode in fact, which is also not
enabled by default for similar reasons (but enabling zone_reclaim_mode
by default would cause much less risk of pathological regressions to
large workloads that can't fit in a single node). Enabling
zone_reclaim_mode would eventually fallback to remote nodes
gracefully. As opposed the fallback to remote nodes with
__GFP_THISNODE can only happen after the 2M allocation has failed and
the problem is that 2M allocation don't fail because
compaction+reclaim interleaving keeps succeeding by swapping out more
and more memory, which would the perfectly right behavior for
compaction+reclaim interleaving if only the whole system would be out
of memory in all nodes (and it isn't).

The false positive result from the automated testing (where swapping
overall performance decreased because fariness increased) wasn't
anybody's fault and so the revert at the end of the merge window was a
safe approach. So we can try again to fix it now.

Thanks!
Andrea
