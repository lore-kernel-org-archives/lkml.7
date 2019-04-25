Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E2C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA222081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDYOq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:46:26 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:44668 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbfDYOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:46:26 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id F399C98932
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:46:20 +0000 (UTC)
Received: (qmail 21849 invoked from network); 25 Apr 2019 14:46:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Apr 2019 14:46:20 -0000
Date:   Thu, 25 Apr 2019 15:46:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190425144619.GX18914@techsingularity.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190425095508.GA8387@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:55:08AM +0200, Ingo Molnar wrote:
> > > Would it be possible to post the results with HT off as well ?
> > 
> > What's the point here to turn HT off? The latency is sensitive to the
> > relationship
> > between the task number and CPU number. Usually less CPU number, more run
> > queue wait time, and worse result.
> 
> HT-off numbers are mandatory: turning HT off is by far the simplest way 
> to solve the security bugs in these CPUs.
> 
> Any core-scheduling solution *must* perform better than HT-off for all 
> relevant workloads, otherwise what's the point?
> 

I agree. Not only should HT-off be evaluated but it should properly
evaluate for different levels of machine utilisation to get a complete
picture.

Around the same time this was first posted and because of kernel
warnings from L1TF, I did a preliminary evaluation of HT On vs HT Off
using nosmt -- this is sub-optimal in itself but it was convenient. The
conventional wisdom that HT gets a 30% boost appears to be primarily based
on academic papers evaluating HPC workloads on a Pentium 4 with a focus
on embarassingly parallel problems which is the ideal case for HT but not
the universal case. The conventional wisdom is questionable at best. The
only modern comparisons I could find were focused on games primarily
which I think hit scaling limits before HT is a factor in some cases.

I don't have the data in a format that can be present everything in a clear
format but here is an attempt anyway. This is long but the central point
that when when a machine is lightly loaded, HT Off generally performs
better than HT On and even when heavily utilised, it's still not a
guaranteed loss. I only suggest reading after this if you have coffee
and time. Ideally all this would be updated with a comparison to core
scheduling but I may not get it queued on my test grid before I leave
for LSF/MM and besides, the authors pushing this feature should be able
to provide supporting data justifying the complexity of the series.

Here is a tbench comparison scaling from a low thread count to a high
thread count. I picked tbench because it's relatively uncomplicated and
tends to be reasonable at spotting scheduler regressions. The kernel
version is old but for the purposes of this discussion, it doesn't matter

1-socket Skylake (8 logical CPUs HT On, 4 logical CPUs HT Off)
                                smt                  nosmt
Hmean     1       484.00 (   0.00%)      519.95 *   7.43%*
Hmean     2       925.02 (   0.00%)     1022.28 *  10.51%*
Hmean     4      1730.34 (   0.00%)     2029.81 *  17.31%*
Hmean     8      2883.57 (   0.00%)     2040.89 * -29.22%*
Hmean     16     2830.61 (   0.00%)     2039.74 * -27.94%*
Hmean     32     2855.54 (   0.00%)     2042.70 * -28.47%*
Stddev    1         1.16 (   0.00%)        0.62 (  46.43%)
Stddev    2         1.31 (   0.00%)        1.00 (  23.32%)
Stddev    4         4.89 (   0.00%)       12.86 (-163.14%)
Stddev    8         4.30 (   0.00%)        2.53 (  40.99%)
Stddev    16        3.38 (   0.00%)        5.92 ( -75.08%)
Stddev    32        5.47 (   0.00%)       14.28 (-160.77%)

Note that disabling HT performs better when cores are available but hits
scaling limits past 4 CPUs when the machine is saturated with HT off.
It's similar with 2 sockets

2-socket Broadwell (80 logical CPUs HT On, 40 logical CPUs HT Off)

                                smt                  nosmt
Hmean     1        514.28 (   0.00%)      540.90 *   5.18%*
Hmean     2        982.19 (   0.00%)     1042.98 *   6.19%*
Hmean     4       1820.02 (   0.00%)     1943.38 *   6.78%*
Hmean     8       3356.73 (   0.00%)     3655.92 *   8.91%*
Hmean     16      6240.53 (   0.00%)     7057.57 *  13.09%*
Hmean     32     10584.60 (   0.00%)    15934.82 *  50.55%*
Hmean     64     24967.92 (   0.00%)    21103.79 * -15.48%*
Hmean     128    27106.28 (   0.00%)    20822.46 * -23.18%*
Hmean     256    28345.15 (   0.00%)    21625.67 * -23.71%*
Hmean     320    28358.54 (   0.00%)    21768.70 * -23.24%*
Stddev    1          2.10 (   0.00%)        3.44 ( -63.59%)
Stddev    2          2.46 (   0.00%)        4.83 ( -95.91%)
Stddev    4          7.57 (   0.00%)        6.14 (  18.86%)
Stddev    8          6.53 (   0.00%)       11.80 ( -80.79%)
Stddev    16        11.23 (   0.00%)       16.03 ( -42.74%)
Stddev    32        18.99 (   0.00%)       22.04 ( -16.10%)
Stddev    64        10.86 (   0.00%)       14.31 ( -31.71%)
Stddev    128       25.10 (   0.00%)       16.08 (  35.93%)
Stddev    256       29.95 (   0.00%)       71.39 (-138.36%)

Same -- performance is better until the machine gets saturated and
disabling HT hits scaling limits earlier.

The workload "mutilate" is a load generator for memcached that is meant
to simulate a workload interesting to Facebook.

1-socket
Hmean     1    28570.67 (   0.00%)    31632.92 *  10.72%*
Hmean     3    76904.93 (   0.00%)    89644.73 *  16.57%*
Hmean     5   107487.40 (   0.00%)    93418.09 * -13.09%*
Hmean     7   103066.62 (   0.00%)    79843.72 * -22.53%*
Hmean     8   103921.65 (   0.00%)    76378.18 * -26.50%*
Stddev    1      112.37 (   0.00%)      261.61 (-132.82%)
Stddev    3      272.29 (   0.00%)      641.41 (-135.56%)
Stddev    5      406.75 (   0.00%)     1240.15 (-204.89%)
Stddev    7     2402.02 (   0.00%)     1336.68 (  44.35%)
Stddev    8     1139.90 (   0.00%)      393.56 (  65.47%)

2-socket
Hmean     1     24571.95 (   0.00%)    24891.45 (   1.30%)
Hmean     4    106963.43 (   0.00%)   103955.79 (  -2.81%)
Hmean     7    154328.47 (   0.00%)   169782.56 *  10.01%*
Hmean     12   235108.36 (   0.00%)   236544.96 (   0.61%)
Hmean     21   238619.16 (   0.00%)   234542.88 *  -1.71%*
Hmean     30   240198.02 (   0.00%)   237758.38 (  -1.02%)
Hmean     48   212573.72 (   0.00%)   172633.74 * -18.79%*
Hmean     79   140937.97 (   0.00%)   112915.07 * -19.88%*
Hmean     80   134204.84 (   0.00%)   116904.93 ( -12.89%)
Stddev    1        40.95 (   0.00%)      284.57 (-594.84%)
Stddev    4      7556.84 (   0.00%)     2176.60 (  71.20%)
Stddev    7     10279.89 (   0.00%)     3510.15 (  65.85%)
Stddev    12     2534.03 (   0.00%)     1513.61 (  40.27%)
Stddev    21     1118.59 (   0.00%)     1662.31 ( -48.61%)
Stddev    30     3540.20 (   0.00%)     2056.37 (  41.91%)
Stddev    48    24206.00 (   0.00%)     6247.74 (  74.19%)
Stddev    79    21650.80 (   0.00%)     5395.35 (  75.08%)
Stddev    80    26769.15 (   0.00%)     5665.14 (  78.84%)

Less clear-cut. Performance is better with HT off on Skylake but similar
until the machine is saturated on Broadwell.

With pgbench running a read-only workload we see

2-socket
Hmean     1      13226.78 (   0.00%)    14971.99 *  13.19%*
Hmean     6      39820.61 (   0.00%)    35036.50 * -12.01%*
Hmean     12     66707.55 (   0.00%)    61403.63 *  -7.95%*
Hmean     22    108748.16 (   0.00%)   110223.97 *   1.36%*
Hmean     30    121964.05 (   0.00%)   121837.03 (  -0.10%)
Hmean     48    121530.97 (   0.00%)   117855.86 *  -3.02%*
Hmean     80    116034.43 (   0.00%)   121826.25 *   4.99%*
Hmean     110   125441.59 (   0.00%)   122180.19 *  -2.60%*
Hmean     142   117908.18 (   0.00%)   117531.41 (  -0.32%)
Hmean     160   119343.50 (   0.00%)   115725.11 *  -3.03%*

Mix of results -- single client is better, 6 and 12 clients regressed for
some reason and after that, it's mostly flat. Hence, HT for this database
load makes very little difference because the performance limits are not
based on CPUs being immediately available.

SpecJBB 2005 is ancient but it does lend itself to easily scaling the
number of active tasks so here is a sample of the performance as
utilisation ramped up to saturation

2-socket
Hmean     tput-1     48655.00 (   0.00%)    48762.00 *   0.22%*
Hmean     tput-8    387341.00 (   0.00%)   390062.00 *   0.70%*
Hmean     tput-15   660993.00 (   0.00%)   659832.00 *  -0.18%*
Hmean     tput-22   916898.00 (   0.00%)   913570.00 *  -0.36%*
Hmean     tput-29  1178601.00 (   0.00%)  1169843.00 *  -0.74%*
Hmean     tput-36  1292377.00 (   0.00%)  1387003.00 *   7.32%*
Hmean     tput-43  1458913.00 (   0.00%)  1508172.00 *   3.38%*
Hmean     tput-50  1411975.00 (   0.00%)  1513536.00 *   7.19%*
Hmean     tput-57  1417937.00 (   0.00%)  1495513.00 *   5.47%*
Hmean     tput-64  1396242.00 (   0.00%)  1477433.00 *   5.81%*
Hmean     tput-71  1349055.00 (   0.00%)  1472856.00 *   9.18%*
Hmean     tput-78  1265738.00 (   0.00%)  1453846.00 *  14.86%*
Hmean     tput-79  1307367.00 (   0.00%)  1446572.00 *  10.65%*
Hmean     tput-80  1309718.00 (   0.00%)  1449384.00 *  10.66%*

This was the most surprising result -- HT off was generally a benefit
even when the counts were higher than the available CPUs and I'm not
sure why. It's also interesting with HT off that the chances of keeping
a workload local to a node are reduced as a socket gets saturated earlier
but the load balancer is generally moving tasks around and NUMA Balancing
is also in play. Still, it shows that disabling HT is not a universal loss.

netperf is inherently about two tasks. For UDP_STREAM, it shows almost
no difference and it's within noise. TCP_STREAM was interesting

Hmean     64        1154.23 (   0.00%)     1162.69 *   0.73%*
Hmean     128       2194.67 (   0.00%)     2230.90 *   1.65%*
Hmean     256       3867.89 (   0.00%)     3929.99 *   1.61%*
Hmean     1024     12714.52 (   0.00%)    12913.81 *   1.57%*
Hmean     2048     21141.11 (   0.00%)    21266.89 (   0.59%)
Hmean     3312     27945.71 (   0.00%)    28354.82 (   1.46%)
Hmean     4096     30594.24 (   0.00%)    30666.15 (   0.24%)
Hmean     8192     37462.58 (   0.00%)    36901.45 (  -1.50%)
Hmean     16384    42947.02 (   0.00%)    43565.98 *   1.44%*
Stddev    64           2.21 (   0.00%)        4.02 ( -81.62%)
Stddev    128         18.45 (   0.00%)       11.11 (  39.79%)
Stddev    256         30.84 (   0.00%)       22.10 (  28.33%)
Stddev    1024       141.46 (   0.00%)       56.54 (  60.03%)
Stddev    2048       200.39 (   0.00%)       75.56 (  62.29%)
Stddev    3312       411.11 (   0.00%)      286.97 (  30.20%)
Stddev    4096       299.86 (   0.00%)      322.44 (  -7.53%)
Stddev    8192       418.80 (   0.00%)      635.63 ( -51.77%)
Stddev    16384      661.57 (   0.00%)      206.73 (  68.75%)

The performance difference is marginal but variance is much reduced
by disabling HT. Now, it's important to note that this particular test
did not control for c-states and it did not bind tasks so there are a
lot of potential sources of noise. I didn't control for them because
I don't think many normal users would properly take concerns like that
into account. MMtests is able to control for those factors so it could
be independently checked.

hackbench is the most obvious loser. This is for processes communicating
via pipes.

Amean     1        0.7343 (   0.00%)      1.1377 * -54.93%*
Amean     4        1.1647 (   0.00%)      2.1543 * -84.97%*
Amean     7        1.6770 (   0.00%)      3.1300 * -86.64%*
Amean     12       2.4500 (   0.00%)      4.6447 * -89.58%*
Amean     21       3.9927 (   0.00%)      6.8250 * -70.94%*
Amean     30       5.5320 (   0.00%)      8.6433 * -56.24%*
Amean     48       8.4723 (   0.00%)     12.1890 * -43.87%*
Amean     79      12.3760 (   0.00%)     17.8347 * -44.11%*
Amean     110     16.0257 (   0.00%)     23.1373 * -44.38%*
Amean     141     20.7070 (   0.00%)     29.8537 * -44.17%*
Amean     172     25.1507 (   0.00%)     37.4830 * -49.03%*
Amean     203     28.5303 (   0.00%)     43.5220 * -52.55%*
Amean     234     33.8233 (   0.00%)     51.5403 * -52.38%*
Amean     265     37.8703 (   0.00%)     58.1860 * -53.65%*
Amean     296     43.8303 (   0.00%)     64.9223 * -48.12%*
Stddev    1        0.0040 (   0.00%)      0.0117 (-189.97%)
Stddev    4        0.0046 (   0.00%)      0.0766 (-1557.56%)
Stddev    7        0.0333 (   0.00%)      0.0991 (-197.83%)
Stddev    12       0.0425 (   0.00%)      0.1303 (-206.90%)
Stddev    21       0.0337 (   0.00%)      0.4138 (-1127.60%)
Stddev    30       0.0295 (   0.00%)      0.1551 (-424.94%)
Stddev    48       0.0445 (   0.00%)      0.2056 (-361.71%)
Stddev    79       0.0350 (   0.00%)      0.4118 (-1076.56%)
Stddev    110      0.0655 (   0.00%)      0.3685 (-462.72%)
Stddev    141      0.3670 (   0.00%)      0.5488 ( -49.55%)
Stddev    172      0.7375 (   0.00%)      1.0806 ( -46.52%)
Stddev    203      0.0817 (   0.00%)      1.6920 (-1970.11%)
Stddev    234      0.8210 (   0.00%)      1.4036 ( -70.97%)
Stddev    265      0.9337 (   0.00%)      1.1025 ( -18.08%)
Stddev    296      1.5688 (   0.00%)      0.4154 (  73.52%)

The problem with hackbench is that "1" above doesn't represent 1 task,
it represents 1 group and so the machine gets saturated relatively
quickly and it's super sensitive to cores being idle and available to
make quick progress.

Kernel building which is all anyone ever cares about is a mixed bag

1-socket
Amean     elsp-2       420.45 (   0.00%)      240.80 *  42.73%*
Amean     elsp-4       363.54 (   0.00%)      135.09 *  62.84%*
Amean     elsp-8       105.40 (   0.00%)      131.46 * -24.73%*
Amean     elsp-16      106.61 (   0.00%)      133.57 * -25.29%*

2-socket
Amean     elsp-2        406.76 (   0.00%)      448.57 ( -10.28%)
Amean     elsp-4        235.22 (   0.00%)      289.48 ( -23.07%)
Amean     elsp-8        152.36 (   0.00%)      116.76 (  23.37%)
Amean     elsp-16        64.50 (   0.00%)       52.12 *  19.20%*
Amean     elsp-32        30.28 (   0.00%)       28.24 *   6.74%*
Amean     elsp-64        21.67 (   0.00%)       23.00 *  -6.13%*
Amean     elsp-128       20.57 (   0.00%)       23.57 * -14.60%*
Amean     elsp-160       20.64 (   0.00%)       23.63 * -14.50%*
Stddev    elsp-2         75.35 (   0.00%)       35.00 (  53.55%)
Stddev    elsp-4         71.12 (   0.00%)       86.09 ( -21.05%)
Stddev    elsp-8         43.05 (   0.00%)       10.67 (  75.22%)
Stddev    elsp-16         4.08 (   0.00%)        2.31 (  43.41%)
Stddev    elsp-32         0.51 (   0.00%)        0.76 ( -48.60%)
Stddev    elsp-64         0.38 (   0.00%)        0.61 ( -60.72%)
Stddev    elsp-128        0.13 (   0.00%)        0.41 (-207.53%)
Stddev    elsp-160        0.08 (   0.00%)        0.20 (-147.93%)

1-socket matches other patterns, the 2-socket was weird. Variability was
nuts for low number of jobs. It's also not universal. I had tested in a
2-socket Haswell machine and it showed different results

Amean     elsp-2       447.91 (   0.00%)      467.43 (  -4.36%)
Amean     elsp-4       284.47 (   0.00%)      248.37 (  12.69%)
Amean     elsp-8       166.20 (   0.00%)      129.23 (  22.24%)
Amean     elsp-16       63.89 (   0.00%)       55.63 *  12.93%*
Amean     elsp-32       36.80 (   0.00%)       35.87 *   2.54%*
Amean     elsp-64       30.97 (   0.00%)       36.94 * -19.28%*
Amean     elsp-96       31.66 (   0.00%)       37.32 * -17.89%*
Stddev    elsp-2        58.08 (   0.00%)       57.93 (   0.25%)
Stddev    elsp-4        65.31 (   0.00%)       41.56 (  36.36%)
Stddev    elsp-8        68.32 (   0.00%)       15.61 (  77.15%)
Stddev    elsp-16        3.68 (   0.00%)        2.43 (  33.87%)
Stddev    elsp-32        0.29 (   0.00%)        0.97 (-239.75%)
Stddev    elsp-64        0.36 (   0.00%)        0.24 (  32.10%)
Stddev    elsp-96        0.30 (   0.00%)        0.31 (  -5.11%)

Still not a perfect match to the general pattern for 2 build jobs and a
bit variable but otherwise the pattern holds -- performs better until the
machine is saturated. Kernel builds (or compilation builds) are always a
bit off as a benchmark as it has a mix of parallel and serialised tasks
that are non-deterministic.

With the NASA Parallel Benchmark (NPB, aka NAS) it's trickier to do a
valid comparison. Over-saturating NAS decimates performance but there
are limits on the exact thread counts that can be used for MPI. OpenMP
is less restrictive but here is an MPI comparison anyway comparing a
fully loaded HT On with fully loaded HT Off -- this is crucial, HT Off
has half the level of parallelisation

Amean     bt      771.15 (   0.00%)      926.98 * -20.21%*
Amean     cg      445.92 (   0.00%)      465.65 *  -4.42%*
Amean     ep       70.01 (   0.00%)       97.15 * -38.76%*
Amean     is       16.75 (   0.00%)       19.08 * -13.95%*
Amean     lu      882.84 (   0.00%)      902.60 *  -2.24%*
Amean     mg       84.10 (   0.00%)       95.95 * -14.10%*
Amean     sp     1353.88 (   0.00%)     1372.23 *  -1.36%*

ep is the embarassingly parallel problem and it shows with half the cores
with HT off, we take a 38.76% performance hit. However, even that is not
universally true as cg for example did not parallelise as well and only
performacne 4.42% worse even with HT off. I can show a comparison with
equal levels of parallelisation but with HT off, it is a completely broken
configuration and I do not think a comparison like that makes any sense.

I didn't do any comparison that could represent Cloud. However, I think
it's worth noting that HT may be popular there for packing lots of virtual
machines onto a single host and over-subscribing. HT would intuitively
have an advantage there *but* it depends heavily on the utilisation and
whether there is sustained VCPU activity where the number of active VCPUs
exceeds physical CPUs when HT is off. There is also the question whether
performance even matters on such configurations but anything cloud related
will be "how long is a piece of string" and "it depends".

So there you have it, HT Off is not a guaranteed loss and can be a gain
so it should be considered as an alternative to core scheduling. The case
where HT makes a big difference is when a workload is CPU or memory bound
and the number of active tasks exceeds the number of CPUs on a socket
and again when number of active tasks exceeds the number of CPUs in the
whole machine.

-- 
Mel Gorman
SUSE Labs
