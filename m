Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A7C21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570518425;
	bh=eSo+O/rykN0oGwziBMAuGnezGlafHelv/62l9rrIrzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VJpVFBPwJGWsDcho40xpmbon3XzKayr8Bl4SNStglnlIkrKJOn6Cp2dqSqmHV2q2W
	 KMyVjM/GKNhTlBL9CZYQi8RZ+A7duoJZx/mJIssX/W5z29UPKkbMfZ4AkTmnEfH+1X
	 xk9WVVMk6JhgmDnYEc9S6K78DAJVt4/rKeLPEaEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfJHHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:07:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730128AbfJHHHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:07:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A4DCAE82;
        Tue,  8 Oct 2019 07:07:02 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:07:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
Message-ID: <20191008070701.GA6681@dhcp22.suse.cz>
References: <20191007075548.12456-1-mhocko@kernel.org>
 <312f4447-a260-8876-2f9d-f300c5c99dc3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <312f4447-a260-8876-2f9d-f300c5c99dc3@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 12:03:30, Mike Kravetz wrote:
> On 10/7/19 12:55 AM, Michal Hocko wrote:
> > From: David Rientjes <rientjes@google.com>
> > 
> > b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction
> > may not succeed") has chnaged the allocator to bail out from the
> > allocator early to prevent from a potentially excessive memory
> > reclaim. __GFP_RETRY_MAYFAIL is designed to retry the allocation,
> > reclaim and compaction loop as long as there is a reasonable chance to
> > make a forward progress. Neither COMPACT_SKIPPED nor COMPACT_DEFERRED
> > at the INIT_COMPACT_PRIORITY compaction attempt gives this feedback.
> > 
> > The most obvious affected subsystem is hugetlbfs which allocates huge
> > pages based on an admin request (or via admin configured overcommit).
> > I have done a simple test which tries to allocate half of the memory
> > for hugetlb pages while the memory is full of a clean page cache. This
> > is not an unusual situation because we try to cache as much of the
> > memory as possible and sysctl/sysfs interface to allocate huge pages is
> > there for flexibility to allocate hugetlb pages at any time.
> > 
> > System has 1GB of RAM and we are requesting 515MB worth of hugetlb pages
> > after the memory is prefilled by a clean page cache:
> > root@test1:~# cat hugetlb_test.sh
> > 
> > set -x
> > echo 0 > /proc/sys/vm/nr_hugepages
> > echo 3 > /proc/sys/vm/drop_caches
> > echo 1 > /proc/sys/vm/compact_memory
> > dd if=/mnt/data/file-1G of=/dev/null bs=$((4<<10))
> > TS=$(date +%s)
> > echo 256 > /proc/sys/vm/nr_hugepages
> > cat /proc/sys/vm/nr_hugepages
> > 
> > The results for 2 consecutive runs on clean 5.3
> > root@test1:~# sh hugetlb_test.sh
> > + echo 0
> > + echo 3
> > + echo 1
> > + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> > 262144+0 records in
> > 262144+0 records out
> > 1073741824 bytes (1.1 GB) copied, 21.0694 s, 51.0 MB/s
> > + date +%s
> > + TS=1569905284
> > + echo 256
> > + cat /proc/sys/vm/nr_hugepages
> > 256
> > root@test1:~# sh hugetlb_test.sh
> > + echo 0
> > + echo 3
> > + echo 1
> > + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> > 262144+0 records in
> > 262144+0 records out
> > 1073741824 bytes (1.1 GB) copied, 21.7548 s, 49.4 MB/s
> > + date +%s
> > + TS=1569905311
> > + echo 256
> > + cat /proc/sys/vm/nr_hugepages
> > 256
> > 
> > Now with b39d0ee2632d applied
> > root@test1:~# sh hugetlb_test.sh
> > + echo 0
> > + echo 3
> > + echo 1
> > + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> > 262144+0 records in
> > 262144+0 records out
> > 1073741824 bytes (1.1 GB) copied, 20.1815 s, 53.2 MB/s
> > + date +%s
> > + TS=1569905516
> > + echo 256
> > + cat /proc/sys/vm/nr_hugepages
> > 11
> > root@test1:~# sh hugetlb_test.sh
> > + echo 0
> > + echo 3
> > + echo 1
> > + dd if=/mnt/data/file-1G of=/dev/null bs=4096
> > 262144+0 records in
> > 262144+0 records out
> > 1073741824 bytes (1.1 GB) copied, 21.9485 s, 48.9 MB/s
> > + date +%s
> > + TS=1569905541
> > + echo 256
> > + cat /proc/sys/vm/nr_hugepages
> > 12
> > 
> > The success rate went down by factor of 20!
> > 
> > Although hugetlb allocation requests might fail and it is reasonable to
> > expect them to under extremely fragmented memory or when the memory is
> > under a heavy pressure but the above situation is not that case.
> > 
> > Fix the regression by reverting back to the previous behavior for
> > __GFP_RETRY_MAYFAIL requests and disable the beail out heuristic for
> > those requests.
> 
> Thank you Michal for doing this.
> 
> hugetlbfs allocations are commonly done via sysctl/sysfs shortly after boot
> where this may not be as much of an issue.  However, I am aware of at least
> three use cases where allocations are made after the system has been up and
> running for quite some time:
> - DB reconfiguration.  If sysctl/sysfs fails to get required number of huge
>   pages, system is rebooted to perform allocation after boot.
> - VM provisioning.  If unable get required number of huge pages, fall back
>   to base pages.
> - An application that does not preallocate pool, but rather allocates pages
>   at fault time for optimal NUMA locality.
> In all cases, I would expect b39d0ee2632d to cause regressions and noticable
> behavior changes.

Thanks a lot Mike. This is a very useful addition and I can see Andrew
has already added it to the changelog (thx). The usecase I keep hearing
most from the field is the first and the second one.

> My quick/limited testing in [1] was insufficient.  It was also mentioned that
> if something like b39d0ee2632d went forward, I would like exemptions for
> __GFP_RETRY_MAYFAIL requests as in this patch.
> 
> > 
> > [mhocko@suse.com: reworded changelog]
> > Fixes: b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction may not succeed")
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> FWIW,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!

> [1] https://lkml.kernel.org/r/3468b605-a3a9-6978-9699-57c52a90bd7e@oracle.com
> -- 
> Mike Kravetz

-- 
Michal Hocko
SUSE Labs
