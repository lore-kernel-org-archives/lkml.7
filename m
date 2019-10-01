Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2BAC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5539A2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569908633;
	bh=PEPqOtXUVKERT26ncnRQCD8tjgG/HVa50imxFoWfKD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dTgxNsSxPXqCQ2Oxv07pvxLLb5/gczMwxKPEud8xp361KakbHTVedIP35SSEFVqaF
	 8xRDko156jWRb0U9Y+myNY5ws95Tjc3HRPhOLaFwnhA7nH1Xbw0hwHrG8zEzKJ4VzG
	 YvB8GsShe38BTFx6wYJQwvZfh1I6OathdSBen+mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfJAFnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 01:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbfJAFnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:43:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44934AEE9;
        Tue,  1 Oct 2019 05:43:46 +0000 (UTC)
Date:   Tue, 1 Oct 2019 07:43:43 +0200
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
Message-ID: <20191001054343.GA15624@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930112817.GC15942@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-09-19 13:28:17, Michal Hocko wrote:
[...]
> Do not get me wrong, but we have a quite a long history of fine tuning
> for THP by adding kludges here and there and they usually turnout to
> break something else. I really want to get to understand the underlying
> problem and base a solution on it rather than "__GFP_THISNODE can cause
> overreclaim so pick up a break out condition and hope for the best".

I didn't really get to any testing earlier but I was really suspecting
that hugetlb will be the first one affected because it uses
__GFP_RETRY_MAYFAIL - aka it really wants to succeed as much as possible
because this is a direct admin request to preallocate a specific number
of huge pages. The patch 3 doesn't really make any difference for those
requests.

Here is a very simple test I've done. Single NUMA node with 1G of
memory. Populate the memory with a clean page cache. That is both easy
to compact and reclaim and then try to allocate 512M worth of hugetlb
pages.
root@test1:~# cat hugetlb_test.sh
#!/bin/sh

set -x
echo 0 > /proc/sys/vm/nr_hugepages
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
dd if=/mnt/data/file-1G of=/dev/null bs=$((4<<10))
TS=$(date +%s)
cp /proc/vmstat vmstat.$TS.before
echo 256 > /proc/sys/vm/nr_hugepages
cat /proc/sys/vm/nr_hugepages
cp /proc/vmstat vmstat.$TS.after

The results for 2 consecutive runs on clean 5.3
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.0694 s, 51.0 MB/s
+ date +%s
+ TS=1569905284
+ cp /proc/vmstat vmstat.1569905284.before
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
256
+ cp /proc/vmstat vmstat.1569905284.after
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.7548 s, 49.4 MB/s
+ date +%s
+ TS=1569905311
+ cp /proc/vmstat vmstat.1569905311.before
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
256
+ cp /proc/vmstat vmstat.1569905311.after

so we get all the requested huge pages to the pool.

Now with first 3 patches of this series applied (the last one doesn't
make any difference for hugetlb allocations).

root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 20.1815 s, 53.2 MB/s
+ date +%s
+ TS=1569905516
+ cp /proc/vmstat vmstat.1569905516.before
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
11
+ cp /proc/vmstat vmstat.1569905516.after
root@test1:~# sh hugetlb_test.sh
+ echo 0
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.9485 s, 48.9 MB/s
+ date +%s
+ TS=1569905541
+ cp /proc/vmstat vmstat.1569905541.before
+ echo 256
+ cat /proc/sys/vm/nr_hugepages
12
+ cp /proc/vmstat vmstat.1569905541.after

so we do not get more that 12 huge pages which is really poor. Although
hugetlb pages tend to be allocated early after the boot they are still
an explicit admin request and having less than 5% success rate is really
bad. If anything the __GFP_RETRY_MAYFAIL needs to be reflected in the
code.

I can provide vmstat files if anybody is interested.

Then I have tried another test for THP. It is essentially the same
thing. Populate the page cache to simulate a quite common case of memory
being used for the cache and then populate 512M anonymous area with
MADV_HUGEPAG set on it:
$ cat thp_test.sh
#!/bin/sh

set -x
echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
dd if=/mnt/data/file-1G of=/dev/null bs=$((4<<10))
TS=$(date +%s)
cp /proc/vmstat vmstat.$TS.before
./mem_eater nowait 500M
cp /proc/vmstat vmstat.$TS.after

mem_eater is essentially (mmap, madvise, and touch page by page dummy
app).

Again clean 5.3 kernel

root@test1:~# sh thp_test.sh 
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 20.8575 s, 51.5 MB/s
+ date +%s
+ TS=1569906274
+ cp /proc/vmstat vmstat.1569906274.before
+ ./mem_eater nowait 500M
7f55e8282000-7f5607682000 rw-p 00000000 00:00 0 
Size:             512000 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              512000 kB
Pss:              512000 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    512000 kB
Referenced:       260616 kB
Anonymous:        512000 kB
LazyFree:              0 kB
AnonHugePages:    509952 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
+ cp /proc/vmstat vmstat.1569906274.after

root@test1:~# sh thp_test.sh
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.8648 s, 49.1 MB/s
+ date +%s
+ TS=1569906333
+ cp /proc/vmstat vmstat.1569906333.before
+ ./mem_eater nowait 500M
7f26625cd000-7f26819cd000 rw-p 00000000 00:00 0
Size:             512000 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              512000 kB
Pss:              512000 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    512000 kB
Referenced:       259892 kB
Anonymous:        512000 kB
LazyFree:              0 kB
AnonHugePages:    509952 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
+ cp /proc/vmstat vmstat.1569906333.after

We are getting quite consistent 99% THP utilization.

grep "pgsteal_direct\|pgsteal_kswapd\|allocstall_movable\|compact_stall" vmstat.1569906333.{before,after}
vmstat.1569906333.before:allocstall_movable 29
vmstat.1569906333.before:pgsteal_kswapd 206760
vmstat.1569906333.before:pgsteal_direct 30162
vmstat.1569906333.before:compact_stall 29
vmstat.1569906333.after:allocstall_movable 65
vmstat.1569906333.after:pgsteal_kswapd 298688
vmstat.1569906333.after:pgsteal_direct 67645
vmstat.1569906333.after:compact_stall 66

Hit the direct compaction 37 times and reclaimed 146M in direct 359M by
kswapd which is 505M in total which is not bad for 512M request.

5.3 + 3 patches (This is a non-NUMA machine so the only difference the
4th patch would make is timing because it just retries 2 times on the
same node).
root@test1:~# sh thp_test.sh
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.0732 s, 51.0 MB/s
+ date +%s
+ TS=1569906542
+ cp /proc/vmstat vmstat.1569906542.before
+ ./mem_eater nowait 500M
7f2799e08000-7f27b9208000 rw-p 00000000 00:00 0
Size:             512000 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              512000 kB
Pss:              512000 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    512000 kB
Referenced:       294944 kB
Anonymous:        512000 kB
LazyFree:              0 kB
AnonHugePages:    477184 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
+ cp /proc/vmstat vmstat.1569906542.after
root@test1:~# sh thp_test.sh
+ echo 3
+ echo 1
+ dd if=/mnt/data/file-1G of=/dev/null bs=4096
262144+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 21.9239 s, 49.0 MB/s
+ date +%s
+ TS=1569906569
+ cp /proc/vmstat vmstat.1569906569.before
+ ./mem_eater nowait 500M
7fa29a234000-7fa2b9634000 rw-p 00000000 00:00 0
Size:             512000 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              512000 kB
Pss:              512000 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    512000 kB
Referenced:       253480 kB
Anonymous:        512000 kB
LazyFree:              0 kB
AnonHugePages:    460800 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:            1
+ cp /proc/vmstat vmstat.1569906569.after

The drop down in the utilization is not that rapid here but it shows that the
results are not very stable as well.

grep "pgsteal_direct\|pgsteal_kswapd\|allocstall_movable\|compact_stall" vmstat.1569906569.{before,after}
vmstat.1569906569.before:allocstall_movable 52
vmstat.1569906569.before:pgsteal_kswapd 182617
vmstat.1569906569.before:pgsteal_direct 54281
vmstat.1569906569.before:compact_stall 85
vmstat.1569906569.after:allocstall_movable 64
vmstat.1569906569.after:pgsteal_kswapd 296840
vmstat.1569906569.after:pgsteal_direct 66778
vmstat.1569906569.after:compact_stall 191

We have hit the direct compaction 106 times and reclaimed 48M from
direct and 446M from kswapd totaling 494M reclaimed in total. Slightly
less than with clean 5.3 but I would consider it within noise.

I didn't really get to analyze numbers very deeply but from a very
preliminary look it seems that the bailout based on the watermark check
is causing volatility because it depends on the kswapd activity in the
background. Please note that this is pretty much the ideal case when
the reclaimable memory is essentially free to drop. If kswapd starts
fighting to get memory reclaimed then the THP utilization is likely to drop
down as well. On the other hand it is fair to say that it is really hard
to tell what would compaction do under those conditions.

I also didn't really get to test any NUMA aspect of the change yet. I
still do hope that David can share something I can play with
because I do not want to create something completely artificial.
-- 
Michal Hocko
SUSE Labs
