Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099BBC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C959D21783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfKMLUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:20:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:49382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbfKMLUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:20:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C93BDB504;
        Wed, 13 Nov 2019 11:20:45 +0000 (UTC)
Date:   Wed, 13 Nov 2019 11:20:42 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191113112042.GG28938@suse.de>
References: <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
 <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
 <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
 <20191029151549.GO31513@dhcp22.suse.cz>
 <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
 <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com>
 <20191105130253.GO22672@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com>
 <20191106073521.GC8314@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911061330030.155572@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911061330030.155572@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:32:37PM -0800, David Rientjes wrote:
> On Wed, 6 Nov 2019, Michal Hocko wrote:
> 
> > > I don't see any 
> > > indication that this allocation would behave any different than the code 
> > > that Andrea experienced swap storms with, but now worse if remote memory 
> > > is in the same state local memory is when he's using __GFP_THISNODE.
> > 
> > The primary reason for the extensive swapping was exactly the __GFP_THISNODE
> > in conjunction with an unbounded direct reclaim AFAIR.
> > 
> > The whole point of the Vlastimil's patch is to have an optimistic local
> > node allocation first and the full gfp context one in the fallback path.
> > If our full gfp context doesn't really work well then we can revisit
> > that of course but that should happen at alloc_hugepage_direct_gfpmask
> > level.
> 
> Since the patch reverts the precaution put into the page allocator to not 
> attempt reclaim if the allocation order is significantly large and the 
> return value from compaction specifies it is unlikely to succed on its 
> own, I believe Vlastimil's patch will cause the same regression that 
> Andrea saw is the whole host is low on memory and/or significantly 
> fragmented.  So the suggestion was that he test this change to make sure 
> we aren't introducing a regression for his workload.

TLDR: I do not have evidence that Vlastimil's patch causes more swapping
	but more information is needed from Andrea on exactly how he's
	testing this. It's not clear to me what was originally tested
	and whether memory just had to be full or whether it had to be
	fragmented. If fragmented, then we have to agree on what an
	appropriate mechanism is for fragmenting memory. Hypothetical
	kernel modules that don't exist do not count.

I put together a testcase whereby a virtual machine is deployed, started
and then time how long it takes to run memhog on 80% of the guests
physical memory. I varied how large the virtual machine is and ran it on
a 2-socket machine so that the smaller tests would be single node and
the larger tests would span both nodes. Before each startup, a large
file is read to fill the memory with pagecache.

kvmstart
                              5.2.0                  5.3.0              5.4.0-rc6              5.4.0-rc6
                            vanilla                vanilla                vanilla          thptweak-v1r1
Amean     5         3.43 (   0.00%)        3.44 (  -0.29%)        3.44 (  -0.19%)        3.39 (   1.07%)
Amean     14       11.18 (   0.00%)       14.59 ( -30.53%)       14.85 ( -32.80%)       10.30 (   7.87%)
Amean     23       20.89 (   0.00%)       18.45 (  11.70%)       24.92 ( -19.29%)       24.88 ( -19.12%)
Amean     32       51.69 (   0.00%)       30.07 (  41.82%)       30.93 (  40.16%)       47.97 (   7.20%)
Amean     41       51.44 (   0.00%)       29.99 *  41.71%*       60.75 ( -18.08%)       77.44 * -50.54%*
Amean     50       81.85 (   0.00%)       60.37 (  26.25%)       98.09 ( -19.84%)      125.59 * -53.43%*

Units are in seconds to run memhog. "Amean 5" is for a 5G virtual
machine. Target machine is 2-socket with 64G of RAM so at 32 you'd expect
that that the machine is larger than a NUMA node. It's set to cutoff at
a virtual machine 80% the size of physical memory.

I used 5.2 as a baseline as 5.3 is where THP allocations changed behaviour
which was reverted later and then tweaked.

The results show that 5.4.0-rc6 in general is slower to fault all the
memory of the virtual machine even before you'd expect the machine to be
larger than a NUMA node. The patch works better for smaller machines and
worse for larger machines

                                          5.2.0          5.3.0      5.4.0-rc6      5.4.0-rc6
                                        vanilla        vanilla        vanilla  thptweak-v1r1
Ops Swap Ins                         1442665.00     1400209.00     1289549.00     1762479.00
Ops Swap Outs                        2291255.00     1689554.00     2222256.00     2885280.00
Ops Kswapd efficiency %                   98.74          91.06          75.73          49.75
Ops Kswapd velocity                     7875.25        7973.52        8035.11        9129.89
Ops Direct efficiency %                   99.54          98.22          94.47          87.80
Ops Direct velocity                     5042.27        4982.09        7238.28        9251.50
Ops Percentage direct scans               39.03          38.46          47.39          50.33
Ops Page writes by reclaim           2291779.00     1689555.00     2222771.00     2885334.00
Ops Page writes file                     524.00           1.00         515.00          54.00
Ops Page writes anon                 2291255.00     1689554.00     2222256.00     2885280.00
Ops Page reclaim immediate              2548.00          76.00         367.00         710.00
Ops Sector Reads                   320255172.00   309217632.00   264732588.00   269864268.00
Ops Sector Writes                   63264744.00    60776604.00    62860244.00    65572608.00
Ops Page rescued immediate                 0.00           0.00           0.00           0.00
Ops Slabs scanned                     595876.00      246334.00     1018425.00     1390506.00
Ops Direct inode steals                   49.00           5.00           0.00           8.00
Ops Kswapd inode steals             24118244.00    28126116.00    12866766.00    12943742.00
Ops Kswapd skipped wait                    0.00           0.00           0.00           0.00
Ops THP fault alloc                   164266.00      204790.00      188055.00      190899.00
Ops THP fault fallback                 49345.00        8614.00       25454.00       22650.00
Ops THP collapse alloc                   132.00         139.00         116.00         121.00
Ops THP collapse fail                      4.00           0.00           1.00           2.00
Ops THP split                          15789.00        5642.00       18119.00       49169.00
Ops THP split failed                       0.00           0.00           0.00           0.00
Ops Compaction stalls                 139794.00       52054.00      214361.00      226514.00
Ops Compaction success                 19004.00       17786.00       39430.00       35922.00
Ops Compaction failures               120790.00       34268.00      174931.00      190592.00
Ops Compaction efficiency                 13.59          34.17          18.39          15.86
Ops Page migrate success            11427696.00    12758554.00    22010443.00    21668849.00
Ops Page migrate failure            11559690.00    10403623.00    13514889.00    13212313.00
Ops Compaction pages isolated       23217363.00    20560760.00    46945743.00    47574686.00
Ops Compaction migrate scanned      19925995.00    16224351.00    49565044.00    58595534.00
Ops Compaction free scanned         68708150.00    47235800.00   134685089.00   153518780.00
Ops Compact scan efficiency               29.00          34.35          36.80          38.17
Ops Compaction cost                    12604.40       13893.25       24274.97       23991.33
Ops Kcompactd wake                       100.00         172.00         100.00         258.00
Ops Kcompactd migrate scanned          33135.00       55797.00      113344.00      948026.00
Ops Kcompactd free scanned            335005.00      310265.00      174353.00      686434.00
Ops NUMA alloc hit                  98173280.00    77063265.00    82393545.00    70699591.00
Ops NUMA alloc miss                 22834593.00    20306614.00    12296731.00    24085033.00
Ops NUMA interleave hit                    0.00           0.00           0.00           0.00
Ops NUMA alloc local                98163641.00    77059289.00    82384101.00    70697814.00
Ops NUMA base-page range updates    53170070.00    41093095.00    62202747.00    71769257.00
Ops NUMA PTE updates                15041942.00     2726887.00    12972411.00    21418665.00
Ops NUMA PMD updates                   74469.00       74934.00       96153.00       98341.00
Ops NUMA hint faults                11492208.00     2337770.00     9146157.00    16587622.00
Ops NUMA hint local faults %         6465386.00     1080902.00     7087393.00    12336942.00
Ops NUMA hint local percent               56.26          46.24          77.49          74.37
Ops NUMA pages migrated               560888.00     3004903.00      336032.00      195839.00
Ops AutoNUMA cost                      57843.89       12033.59       46172.59       83444.22

There is a lot here. Both 5.4.0-rc6 and the tweak had more memory placed
locally (NUMA hint local percent). *All* kernels swapped pages in an out
with 5.4.0-rc6 being as bad as 5.2.0-vanilla and the patch making this
slightly but not considerably worse.

5.3.0 was generally more successful at allocating huge pages (THP fault
fallback) with 5.4.0-rc6 being much worse at allocating huge pages and
the tweak not making much of a difference.

So the patch is a mix of good and bad in this case. However, the test
case has notable limitations and more information would be needed from
Andrea on exactly how he was evaluating KVM start times.

1. memhog is single threaded which means that one node is likely to be
   filled first, spillover while the first node reclaims. This means that
   swapping is somewhat inevitable on NUMA machines with this load. We
   could run multiple instances but that would have very variable results.

2. Reading a single large file forces reclaim but it definitely is not
   fragmenting memory. However, we never all agreed on how a machine
   should be fragmented to be useful for this sort of test. Mentioning
   hypothetical kernel modules that don't exist is not good enough.
   Creating massive amounts of small files with fragment memory to some
   extent but not aggressively. Doing that while memhog is running
   would help but the results would be very variable.

This particular test is hard to reproduce even though it's in mmtests as
configs/config-workload-kvmstart-memhog-frag-singlefile because the test
relies on KVM helper scripts to deploy, start and stop the virtual
machine. These scripts exist outside of mmtests and belong to a set of
tools I use to schedule, execute and report on tests across a range of
machines.

I also ran a THP faulting benchmark with fio running in the background
in a configuration that tends to fragment memory (mmtests config
workload-thpfioscale-madvhugepage) with ext4 as a backing filesystem for
fio.


                                        5.2.0                  5.3.0              5.4.0-rc6              5.4.0-rc6
                                      vanilla                vanilla                vanilla          thptweak-v1r1
Min       fault-base-5      958.00 (   0.00%)     1980.00 (-106.68%)     1083.00 ( -13.05%)     1406.00 ( -46.76%)
Min       fault-huge-5      297.00 (   0.00%)      309.00 (  -4.04%)      431.00 ( -45.12%)      324.00 (  -9.09%)
Min       fault-both-5      297.00 (   0.00%)      309.00 (  -4.04%)      431.00 ( -45.12%)      324.00 (  -9.09%)
Amean     fault-base-5     2517.81 (   0.00%)     8886.23 *-252.94%*     4851.98 * -92.71%*     8223.64 *-226.62%*
Amean     fault-huge-5     2781.67 (   0.00%)    10397.46 *-273.78%*     3596.91 * -29.31%*     7139.44 *-156.66%*
Amean     fault-both-5     2662.24 (   0.00%)     9916.03 *-272.47%*     3990.46 * -49.89%*     7367.48 *-176.74%*
Stddev    fault-base-5     2713.85 (   0.00%)    24331.73 (-796.58%)     5530.37 (-103.78%)    27048.99 (-896.70%)
Stddev    fault-huge-5     3740.46 (   0.00%)    39529.80 (-956.82%)     5428.68 ( -45.13%)    23418.76 (-526.09%)
Stddev    fault-both-5     3317.75 (   0.00%)    35408.44 (-967.24%)     5491.27 ( -65.51%)    24229.15 (-630.29%)
CoeffVar  fault-base-5      107.79 (   0.00%)      273.81 (-154.03%)      113.98 (  -5.75%)      328.92 (-205.16%)
CoeffVar  fault-huge-5      134.47 (   0.00%)      380.19 (-182.73%)      150.93 ( -12.24%)      328.02 (-143.94%)
CoeffVar  fault-both-5      124.62 (   0.00%)      357.08 (-186.53%)      137.61 ( -10.42%)      328.87 (-163.89%)
Max       fault-base-5    88873.00 (   0.00%)   386539.00 (-334.93%)   115638.00 ( -30.12%)   486930.00 (-447.89%)
Max       fault-huge-5    63735.00 (   0.00%)   602544.00 (-845.39%)   139082.00 (-118.22%)   426777.00 (-569.61%)
Max       fault-both-5    88873.00 (   0.00%)   602544.00 (-577.98%)   139082.00 ( -56.50%)   486930.00 (-447.89%)
BAmean-50 fault-base-5     1192.71 (   0.00%)     3101.71 (-160.06%)     2170.91 ( -82.02%)     2692.97 (-125.79%)
BAmean-50 fault-huge-5      756.99 (   0.00%)      972.96 ( -28.53%)     1112.99 ( -47.03%)     1168.70 ( -54.39%)
BAmean-50 fault-both-5      953.65 (   0.00%)     1455.39 ( -52.61%)     1319.56 ( -38.37%)     1375.04 ( -44.19%)
BAmean-95 fault-base-5     2109.87 (   0.00%)     4941.87 (-134.23%)     4056.10 ( -92.24%)     4672.90 (-121.48%)
BAmean-95 fault-huge-5     2158.64 (   0.00%)     3867.03 ( -79.14%)     2766.41 ( -28.16%)     3395.88 ( -57.32%)
BAmean-95 fault-both-5     2127.00 (   0.00%)     4183.64 ( -96.69%)     3169.07 ( -48.99%)     3666.57 ( -72.38%)
BAmean-99 fault-base-5     2349.85 (   0.00%)     6811.21 (-189.86%)     4512.17 ( -92.02%)     5738.18 (-144.19%)
BAmean-99 fault-huge-5     2538.90 (   0.00%)     7109.96 (-180.04%)     3225.96 ( -27.06%)     5194.97 (-104.61%)
BAmean-99 fault-both-5     2443.68 (   0.00%)     6952.77 (-184.52%)     3626.66 ( -48.41%)     5300.01 (-116.89%)

thpfioscale Percentage Faults Huge
                                   5.2.0                  5.3.0              5.4.0-rc6              5.4.0-rc6
                                 vanilla                vanilla                vanilla          thptweak-v1r1
Percentage huge-5       54.74 (   0.00%)       68.14 (  24.49%)       68.64 (  25.40%)       78.97 (  44.27%)

In this case, 5.4.0-rc6 has lower latency when allocating pages whether
THP is used or a fallback to base pages. The patch has latency somewhere
between 5.2 and 5.4-rc6 indicating that more effort is being made.
However, as expected the allocation success rate of the patch is higher
than all the others. This indicates the higher latency is due to the
additional work done to allocate the page.

Finally I ran a benchmark that faults memory in such a way as to expect
high compaction activity

usemem
                                  5.2.0                  5.3.0              5.4.0-rc6              5.4.0-rc6
                                vanilla                vanilla                vanilla          thptweak-v1r1
Amean     elsp-1       42.09 (   0.00%)       26.59 *  36.84%*       36.75 (  12.70%)       40.23 (   4.42%)
Amean     elsp-3       32.96 (   0.00%)        7.48 *  77.29%*        8.73 *  73.50%*       11.49 *  65.15%*
Amean     elsp-4        5.69 (   0.00%)        5.85 *  -2.81%*        5.68 (   0.18%)        5.68 (   0.18%)

                                          5.2.0          5.3.0      5.4.0-rc6      5.4.0-rc6
                                        vanilla        vanilla        vanilla  thptweak-v1r1
Ops Swap Ins                         2937652.00           0.00      695423.00      224792.00
Ops Swap Outs                        3647757.00           0.00      797035.00      262654.00

This is showing that 5.3.0 does not swap at all and is the fastest,
5.4.0-rc6 introduced swapping and the patch reduced it somewhat.

So, the patch behaves more or less as expected and I'm not seeing
clear evidence that the patch makes swapping more likely as feared by
David. However, the kvm testcase is very limited and needs more information
on exactly how Andrea was testing it to induce swap storms. I can easily
make guesses but chances are that I'll guess wrong.

-- 
Mel Gorman
SUSE Labs
