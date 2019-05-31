Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A474BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796AF26567
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559294560;
	bh=QrveamkeJE3SIhnGt1ueuD+1GC8s5w6d1VlgzDBSCPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ivAYVxbI7iV0nRgg8Di6THPMEIpkmeD6T0i+o3O309LXLXjtq+fIwCuRux/aMIWew
	 C2NB6u13iRftTtjc0b/x31UWi0nmI6yDCYqW9QoJ8eHL0Lbh1ysNujrDKEnmL+PqH3
	 T84eXZ3SqZGMU7TvXZOzrXCAoBU3CJxo9DttGyEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfEaJWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbfEaJWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:22:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23EC6AFD2;
        Fri, 31 May 2019 09:22:37 +0000 (UTC)
Date:   Fri, 31 May 2019 11:22:36 +0200
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
Message-ID: <20190531092236.GM6896@dhcp22.suse.cz>
References: <20190503223146.2312-1-aarcange@redhat.com>
 <20190503223146.2312-3-aarcange@redhat.com>
 <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com>
 <20190520153621.GL18914@techsingularity.net>
 <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org>
 <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-05-19 14:24:33, David Rientjes wrote:
> On Thu, 23 May 2019, Andrew Morton wrote:
> 
> > > We are going in circles, *yes* there is a problem for potential swap 
> > > storms today because of the poor interaction between memory compaction and 
> > > directed reclaim but this is a result of a poor API that does not allow 
> > > userspace to specify that its workload really will span multiple sockets 
> > > so faulting remotely is the best course of action.  The fix is not to 
> > > cause regressions for others who have implemented a userspace stack that 
> > > is based on the past 3+ years of long standing behavior or for specialized 
> > > workloads where it is known that it spans multiple sockets so we want some 
> > > kind of different behavior.  We need to provide a clear and stable API to 
> > > define these terms for the page allocator that is independent of any 
> > > global setting of thp enabled, defrag, zone_reclaim_mode, etc.  It's 
> > > workload dependent.
> > 
> > um, who is going to do this work?
> > 
> > Implementing a new API doesn't help existing userspace which is hurting
> > from the problem which this patch addresses.
> > 
> 
> The problem which this patch addresses has apparently gone unreported for 
> 4+ years since

Can we finaly stop considering the time and focus on the what is the
most reasonable behavior in general case please? Conserving mistakes
based on an argument that we have them for many years is just not
productive. It is very well possible that workloads that suffer from
this simply run on older distribution kernels which are moving towards
newer kernels very slowly.

> commit 077fcf116c8c2bd7ee9487b645aa3b50368db7e1
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Wed Feb 11 15:27:12 2015 -0800
> 
>     mm/thp: allocate transparent hugepages on local node

Let me quote the commit message to the full lenght
"
    This make sure that we try to allocate hugepages from local node if
    allowed by mempolicy.  If we can't, we fallback to small page allocation
    based on mempolicy.  This is based on the observation that allocating
    pages on local node is more beneficial than allocating hugepages on remote
    node.

    With this patch applied we may find transparent huge page allocation
    failures if the current node doesn't have enough freee hugepages.  Before
    this patch such failures result in us retrying the allocation on other
    nodes in the numa node mask.
"

I do not see any single numbers backing those claims or any mention of a
workload that would benefit from the change. Besides that, we have seen
that THP on a remote (but close) node might be performing better per
Andrea's numbers. So those claims do not apply in general.

This is a general problem when making decisions on heuristics which are
not a clear cut. AFAICS there have been pretty good argments given that
_real_ workloads suffer from this change while a demonstration of a _real_
workload that is benefiting is still missing.

> My goal is to reach a solution that does not cause anybody to incur 
> performance penalties as a result of it.

That is certainly appreciated and I can offer my help there as well. But
I believe we should start with a code base that cannot generate a
swapping storm by a trivial code as demonstrated by Mel. A general idea
on how to approve the situation has been already outlined for a default
case and a new memory policy has been mentioned as well but we need
something to start with and neither of the two is compatible with the
__GFP_THISNODE behavior.

[...]

> The easiest solution would be to define the MADV_HUGEPAGE behavior 
> explicitly in sysfs: local or remote.  Defaut to local as the behavior 
> from the past four years and allow users to specify remote if their 
> workloads will span multiple sockets.  This is somewhat coarse but no more 
> than the thp defrag setting in sysfs today that defines defrag behavior 
> for everybody on the system.

This just makes the THP tunning even muddier. Really, can we start with
a code that doesn't blow up trivially and build on top? In other words
start with a less specialized usecase being covered and help more
specialized usecases to get what they need.

-- 
Michal Hocko
SUSE Labs
