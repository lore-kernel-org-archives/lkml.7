Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551E0215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569919068;
	bh=Nx7zfT5/Hy/7vGGdbwpW8dlbOF5zB13EgV+T1TiVqeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nptq8hhPooLWF1bsxSBIIrvuEVWoszPcrRVbRNyrlpxlbzUnN/IOeIlZTbZhcdjhM
	 YHdERbhY1BFKng0LiwA/HnLiKH96QSzKoLtnVzz4pMddAae7f5dUBaV0GlJPuW6YK5
	 K8V4wBb7VYXMgaC0EDX4l1kuzcLx52ueFfTFwMyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbfJAIhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:37:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:36832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727957AbfJAIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5517FAF27;
        Tue,  1 Oct 2019 08:37:44 +0000 (UTC)
Date:   Tue, 1 Oct 2019 10:37:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191001083743.GC15624@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001054343.GA15624@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-10-19 07:43:43, Michal Hocko wrote:
[...]
> I also didn't really get to test any NUMA aspect of the change yet. I
> still do hope that David can share something I can play with
> because I do not want to create something completely artificial.

I have split out my kvm machine into two nodes to get at least some
idea how these patches behave
$ numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 2
node 0 size: 475 MB
node 0 free: 432 MB
node 1 cpus: 1 3
node 1 size: 503 MB
node 1 free: 458 MB

Again, I am using the simple page cache full of memory and mmap less
than the full capacity of node 1 with a preferred numa policy:
root@test1:~# cat thp_test.sh
#!/bin/sh

set -x
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
dd if=/mnt/data/file-1G of=/dev/null bs=$((4<<10))
TS=$(date +%s)
cp /proc/vmstat vmstat.$TS.before
numactl --preferred 1 ./mem_eater nowait 400M
cp /proc/vmstat vmstat.$TS.after

First run with 5.3 and without THP
$ echo never > /sys/kernel/mm/transparent_hugepage/enabled
root@test1:~# sh thp_test.sh 
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.938 s, 48.9 MB/s
+ date +%s
+ TS=1569914851
+ cp /proc/vmstat vmstat.1569914851.before
+ numactl --preferred 1 ./mem_eater nowait 400M
7f4bdefec000-7f4bf7fec000 rw-p 00000000 00:00 0 
Size:             409600 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              409600 kB
Pss:              409600 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    409600 kB
Referenced:       344460 kB
Anonymous:        409600 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            0
7f4bdefec000 prefer:1 anon=102400 dirty=102400 active=86115 N0=41963 N1=60437 kernelpagesize_kB=4
+ cp /proc/vmstat vmstat.1569914851.after

Few more runs:
7fd0f248b000 prefer:1 anon=102400 dirty=102400 active=86909 N0=40079 N1=62321 kernelpagesize_kB=4
7f2a69fc3000 prefer:1 anon=102400 dirty=102400 active=85244 N0=44455 N1=57945 kernelpagesize_kB=4

So we get around 56-60% pages to the preferred node

Now let's enable THPs
root@test1:~# echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
root@test1:~# sh thp_test.sh
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.8665 s, 49.1 MB/s
+ date +%s
+ TS=1569915082
+ cp /proc/vmstat vmstat.1569915082.before
+ numactl --preferred 1 ./mem_eater nowait 400M
7f05c6dee000-7f05dfdee000 rw-p 00000000 00:00 0
Size:             409600 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              409600 kB
Pss:              409600 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    409600 kB
Referenced:       210872 kB
Anonymous:        409600 kB
LazyFree:              0 kB
AnonHugePages:    407552 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
7f05c6dee000 prefer:1 anon=102400 dirty=102400 active=52718 N0=50688 N1=51712 kernelpagesize_kB=4
+ cp /proc/vmstat vmstat.1569915082.after

Few more runs
AnonHugePages:    407552 kB
7effca1b9000 prefer:1 anon=102400 dirty=102400 active=65977 N0=53760 N1=48640 kernelpagesize_kB=4

AnonHugePages:    407552 kB
7f474bfc4000 prefer:1 anon=102400 dirty=102400 active=52676 N0=8704 N1=93696 kernelpagesize_kB=4

The utilization is again almost 100% and the preferred node usage
varied a lot between 47-91%. The last one looks like the result we would
like to achieve, right?

Now with 5.3 + all 4 patches this time:
root@test1:~# sh thp_test.sh
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.5368 s, 49.9 MB/s
+ date +%s
+ TS=1569915403
+ cp /proc/vmstat vmstat.1569915403.before
+ numactl --preferred 1 ./mem_eater nowait 400M
7f8114ab4000-7f812dab4000 rw-p 00000000 00:00 0
Size:             409600 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              409600 kB
Pss:              409600 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    409600 kB
Referenced:       207568 kB
Anonymous:        409600 kB
LazyFree:              0 kB
AnonHugePages:    401408 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
7f8114ab4000 prefer:1 anon=102400 dirty=102400 active=51892 N0=3072 N1=99328 kernelpagesize_kB=4
+ cp /proc/vmstat vmstat.1569915403.after

Few more runs:
AnonHugePages:    376832 kB
7f37a1404000 prefer:1 anon=102400 dirty=102400 active=55204 N0=23153 N1=79247 kernelpagesize_kB=4

AnonHugePages:    372736 kB
7f4abe4af000 prefer:1 anon=102400 dirty=102400 active=52399 N0=23646 N1=78754 kernelpagesize_kB=4

The THP utilization varies again and the locality is higher in average
76+%.  Which is even higher than the base page case. I was really
wondering what is the reason for that So I've added a simple debugging
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8caab1f81a52..565f667f6dcb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2140,9 +2140,11 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 			 * to prefer hugepage backing, retry allowing remote
 			 * memory as well.
 			 */
-			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
+			if (!page && (gfp & __GFP_DIRECT_RECLAIM)) {
 				page = __alloc_pages_node(hpage_node,
 						gfp | __GFP_NORETRY, order);
+				printk("XXX: %s\n", !page ? "fail" : hpage_node == page_to_nid(page)?"match":"fallback");
+			}
 
 			goto out;
 		}

Cases like
AnonHugePages:    407552 kB
7f3ab2ebf000 prefer:1 anon=102400 dirty=102400 active=77503 N0=43520 N1=58880 kernelpagesize_kB=4
     85 XXX: fallback
a very successful ones on the other hand
AnonHugePages:    280576 kB
7feffd9c2000 prefer:1 anon=102400 dirty=102400 active=52563 N0=3131 N1=99269 kernelpagesize_kB=4
     62 XXX: fail
      3 XXX: fallback

Note that 62 failing THPs is 31744 pages which also explains much higher
locality I suspect (we simply allocate small pages from the preferred
node).

This is just a very trivial test and I still have to grasp the outcome.
My current feeling is that the whole thing is very timing specific and
the higher local utilization depends on somebody else doing a reclaim
on our behalf with patches applied.

5.3 without any patches behaves more stable although there is a slightly
higher off node THP success rate but it also seems that the same
overall THP success rate can be achieved from the local node as well so
performing compaction would make more sense for those.

With the simple hack on top of 5.3
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9c9194959271..414d0eaa6287 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4685,7 +4685,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 {
 	struct page *page;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
-	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
+	gfp_t alloc_mask, first_alloc_mask; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
 	/*
@@ -4711,7 +4711,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp_mask);
 
 	/* First allocation attempt */
-	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
+	first_alloc_mask = alloc_mask;
+	if (order && (alloc_mask & __GFP_DIRECT_RECLAIM))
+		first_alloc_mask |= __GFP_THISNODE;
+	page = get_page_from_freelist(first_alloc_mask, order, alloc_flags, &ac);
 	if (likely(page))
 		goto out;
 
I am getting
AnonHugePages:    407552 kB
7f88a67ca000 prefer:1 anon=102400 dirty=102400 active=60362 N0=39424 N1=62976 kernelpagesize_kB=4

AnonHugePages:    407552 kB
7f18f0de5000 prefer:1 anon=102400 dirty=102400 active=51685 N0=34720 N1=67680 kernelpagesize_kB=4

AnonHugePages:    407552 kB
7f443f89e000 prefer:1 anon=102400 dirty=102400 active=52382 N0=62976 N1=39424 kernelpagesize_kB=4

While first two rounds looked very promising with 60%+ locality with a
consistent THP utilization then the locality went crazy so there is
more to look into. The fast path still seems to make some difference
though.
-- 
Michal Hocko
SUSE Labs
