Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56ECC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD420675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfDYVb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:31:56 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:55114 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726611AbfDYVbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:31:55 -0400
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id EA1841C2551
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:31:46 +0100 (IST)
Received: (qmail 7761 invoked from network); 25 Apr 2019 21:31:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Apr 2019 21:31:46 -0000
Date:   Thu, 25 Apr 2019 22:31:45 +0100
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
Message-ID: <20190425213145.GY18914@techsingularity.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190425185343.GA122353@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:53:43PM +0200, Ingo Molnar wrote:
> > I don't have the data in a format that can be present everything in a clear
> > format but here is an attempt anyway. This is long but the central point
> > that when when a machine is lightly loaded, HT Off generally performs
> > better than HT On and even when heavily utilised, it's still not a
> > guaranteed loss. I only suggest reading after this if you have coffee
> > and time. Ideally all this would be updated with a comparison to core
> > scheduling but I may not get it queued on my test grid before I leave
> > for LSF/MM and besides, the authors pushing this feature should be able
> > to provide supporting data justifying the complexity of the series.
> 
> BTW., a side note: I'd suggest introducing a runtime toggle 'nosmt' 
> facility, i.e. turn a system between SMT and non-SMT execution runtime, 
> with full reversability between these states and no restrictions.
> 
> That should make both benchmarking more convenient (no kernel reboots and 
> kernel parameters to check), and it would also make it easier for system 
> administrators to experiment with how SMT and no-SMT affects their 
> typical workloads.
> 

Noted, I wasn't aware of the option Thomas laid out but even if I was, I
probably would have used the boot parameter anyway. The grid automation
reboots between tests and it knows how to add/remove kernel command
lines so it's trivial for me to setup. There is definite value for live
experimentation as long as they know to keep an eye on the CPU enumeration
when setting up cpumasks.

> > Here is a tbench comparison scaling from a low thread count to a high
> > thread count. I picked tbench because it's relatively uncomplicated and
> > tends to be reasonable at spotting scheduler regressions. The kernel
> > version is old but for the purposes of this discussion, it doesn't matter
> > 
> > 1-socket Skylake (8 logical CPUs HT On, 4 logical CPUs HT Off)
> 
> Side question: while obviously most of the core-sched interest is 
> concentrated around Intel's HyperThreading SMT, I'm wondering whether you 
> have any data regarding AMD systems - in particular Ryzen based CPUs 
> appear to have a pretty robust SMT implementation.
> 

Unfortunately not. Such machines are available internally but they are
heavily used for functional enablement. This might change in the future
and if so, I'll queue the test.

> > 2-socket Broadwell (80 logical CPUs HT On, 40 logical CPUs HT Off)
> > 
> >                                 smt                  nosmt
> > Hmean     1        514.28 (   0.00%)      540.90 *   5.18%*
> > Hmean     2        982.19 (   0.00%)     1042.98 *   6.19%*
> > Hmean     4       1820.02 (   0.00%)     1943.38 *   6.78%*
> > Hmean     8       3356.73 (   0.00%)     3655.92 *   8.91%*
> > Hmean     16      6240.53 (   0.00%)     7057.57 *  13.09%*
> > Hmean     32     10584.60 (   0.00%)    15934.82 *  50.55%*
> > Hmean     64     24967.92 (   0.00%)    21103.79 * -15.48%*
> > Hmean     128    27106.28 (   0.00%)    20822.46 * -23.18%*
> > Hmean     256    28345.15 (   0.00%)    21625.67 * -23.71%*
> > Hmean     320    28358.54 (   0.00%)    21768.70 * -23.24%*
> > Stddev    1          2.10 (   0.00%)        3.44 ( -63.59%)
> > Stddev    2          2.46 (   0.00%)        4.83 ( -95.91%)
> > Stddev    4          7.57 (   0.00%)        6.14 (  18.86%)
> > Stddev    8          6.53 (   0.00%)       11.80 ( -80.79%)
> > Stddev    16        11.23 (   0.00%)       16.03 ( -42.74%)
> > Stddev    32        18.99 (   0.00%)       22.04 ( -16.10%)
> > Stddev    64        10.86 (   0.00%)       14.31 ( -31.71%)
> > Stddev    128       25.10 (   0.00%)       16.08 (  35.93%)
> > Stddev    256       29.95 (   0.00%)       71.39 (-138.36%)
> > 
> > Same -- performance is better until the machine gets saturated and
> > disabling HT hits scaling limits earlier.
> 
> Interesting. This strongly suggests sub-optimal SMT-scheduling in the 
> non-saturated HT case, i.e. a scheduler balancing bug.
> 

Yeah, it does but mpstat didn't appear to indicate that SMT siblings are
being used prematurely so it's a bit of a curiousity.

> As long as loads are clearly below the physical cores count (which they 
> are in the early phases of your table) the scheduler should spread tasks 
> without overlapping two tasks on the same core.
> 

It should, but it's not perfect. For example, wake_affine_idle does not
take sibling activity into account even though select_idle_sibling *may*
take it into account. Even select_idle_sibling in its fast path may use
an SMT sibling instead of searching.

There are also potential side-effects with cpuidle. Some workloads
migration around the socket as they are communicating because of how the
search for an idle CPU works. With SMT on, there is potentially a longer
opportunity for a core to reach a deep c-state and incur a bigger wakeup
latency. This is a very weak theory but I've seen cases where latency
sensitive workloads with only two communicating tasks are affected by
CPUs reaching low c-states due to migrations.

> Clearly it doesn't.
> 

It's more that it's best effort to wakeup quickly instead of being perfect
by using an expensive search every time.

> > SpecJBB 2005 is ancient but it does lend itself to easily scaling the
> > number of active tasks so here is a sample of the performance as
> > utilisation ramped up to saturation
> > 
> > 2-socket
> > Hmean     tput-1     48655.00 (   0.00%)    48762.00 *   0.22%*
> > Hmean     tput-8    387341.00 (   0.00%)   390062.00 *   0.70%*
> > Hmean     tput-15   660993.00 (   0.00%)   659832.00 *  -0.18%*
> > Hmean     tput-22   916898.00 (   0.00%)   913570.00 *  -0.36%*
> > Hmean     tput-29  1178601.00 (   0.00%)  1169843.00 *  -0.74%*
> > Hmean     tput-36  1292377.00 (   0.00%)  1387003.00 *   7.32%*
> > Hmean     tput-43  1458913.00 (   0.00%)  1508172.00 *   3.38%*
> > Hmean     tput-50  1411975.00 (   0.00%)  1513536.00 *   7.19%*
> > Hmean     tput-57  1417937.00 (   0.00%)  1495513.00 *   5.47%*
> > Hmean     tput-64  1396242.00 (   0.00%)  1477433.00 *   5.81%*
> > Hmean     tput-71  1349055.00 (   0.00%)  1472856.00 *   9.18%*
> > Hmean     tput-78  1265738.00 (   0.00%)  1453846.00 *  14.86%*
> > Hmean     tput-79  1307367.00 (   0.00%)  1446572.00 *  10.65%*
> > Hmean     tput-80  1309718.00 (   0.00%)  1449384.00 *  10.66%*
> > 
> > This was the most surprising result -- HT off was generally a benefit
> > even when the counts were higher than the available CPUs and I'm not
> > sure why. It's also interesting with HT off that the chances of keeping
> > a workload local to a node are reduced as a socket gets saturated earlier
> > but the load balancer is generally moving tasks around and NUMA Balancing
> > is also in play. Still, it shows that disabling HT is not a universal loss.
> 
> Interesting indeed. Could there be some batch execution benefit, i.e. by 
> having fewer CPUs to execute on the tasks do not crowd out and trash 
> die/socket level caches as badly?

That could be the case. It also could be an example where tasks getting
starved allow others to make more progress and the high-level metric looks
better. That is usually a pattern seen with IO though, not CPU scheduling.

> With no-HT the workload had more 
> threads than CPUs to execute on and the tasks were forced into neat 
> queues of execution and cache trashing would be limited to the short 
> period after a task was scheduled in?
> 
> If this was on the 40-physical-core Broadwell system and the 'X' tput-X 
> roughly correlates to CPU utilization then this seems plausible, as the 
> improvements start roughly at the ~tput-40 bondary and increase 
> afterwards.
> 

Indeed, it's very plausible.

> > netperf is inherently about two tasks. For UDP_STREAM, it shows almost
> > no difference and it's within noise. TCP_STREAM was interesting
> > 
> > Hmean     64        1154.23 (   0.00%)     1162.69 *   0.73%*
> > Hmean     128       2194.67 (   0.00%)     2230.90 *   1.65%*
> > Hmean     256       3867.89 (   0.00%)     3929.99 *   1.61%*
> > Hmean     1024     12714.52 (   0.00%)    12913.81 *   1.57%*
> > Hmean     2048     21141.11 (   0.00%)    21266.89 (   0.59%)
> > Hmean     3312     27945.71 (   0.00%)    28354.82 (   1.46%)
> > Hmean     4096     30594.24 (   0.00%)    30666.15 (   0.24%)
> > Hmean     8192     37462.58 (   0.00%)    36901.45 (  -1.50%)
> > Hmean     16384    42947.02 (   0.00%)    43565.98 *   1.44%*
> > Stddev    64           2.21 (   0.00%)        4.02 ( -81.62%)
> > Stddev    128         18.45 (   0.00%)       11.11 (  39.79%)
> > Stddev    256         30.84 (   0.00%)       22.10 (  28.33%)
> > Stddev    1024       141.46 (   0.00%)       56.54 (  60.03%)
> > Stddev    2048       200.39 (   0.00%)       75.56 (  62.29%)
> > Stddev    3312       411.11 (   0.00%)      286.97 (  30.20%)
> > Stddev    4096       299.86 (   0.00%)      322.44 (  -7.53%)
> > Stddev    8192       418.80 (   0.00%)      635.63 ( -51.77%)
> > Stddev    16384      661.57 (   0.00%)      206.73 (  68.75%)
> > 
> > The performance difference is marginal but variance is much reduced
> > by disabling HT. Now, it's important to note that this particular test
> > did not control for c-states and it did not bind tasks so there are a
> > lot of potential sources of noise. I didn't control for them because
> > I don't think many normal users would properly take concerns like that
> > into account. MMtests is able to control for those factors so it could
> > be independently checked.
> 
> Interesting. This too suggests suboptimal scheduling: with just 2 tasks 
> there might be two major modes of execution: either the two tasks end up 
> on the same physical core or not. If the scheduler isn't entirely 
> consistent about this choice then we might see big variations in 
> execution, depending on whether running the two tasks on different 
> physical cores is better to performance or not.
> 

netperf is interesting because ksoftirqd is also involved so it's actually
three tasks that are communicating. Typically SMT siblings are not used
by the communicating task but they get intermittently migrated to new
cores even though the machine is mostly idle.

> This stddev artifact could be narrowed down further by using taskset to 
> force the benchmark on 2 logical CPUs, and by making those 2 CPUs HT 
> siblings or not we could see which execution is the more optimal one. 

So this test was based on config-global-dhp__network-netperf-unbound from
mmtests. There are also config-global-dhp__network-netperf-cross-socket.
What that configuration does is pin the server and client to two CPUs
that are on the same socket but not HT siblings (HT siblings is done by
config-global-dhp__network-netperf-cross-ht). The two cross-* configs also
set c-state to 1 because the tasks do not always have equal utilisation
allow c-state exit latency to cause variants. That said, the effect is
much more visible on sockperf than it is on netperf.

Assuming I do another round, I'll add the configs that pin tasks and
control for c-states.

> 
> My prediction, which is easily falsifiable is that stddev noise should 
> reduce dramatically in such a 2-CPU restricted 'taskset' based affinity 
> jail, *regardless* of whether the two CPUs are actually on the same 
> physical core or not.
> 

I can confirm that you are right when sockperf is used. That reports
per-packet latencies so variance is easier to spot. Every time I've
optimised for hackbench though, something else fell down a hole that was
more realistic so I usually give up and try again later.

> > hackbench is the most obvious loser. This is for processes communicating
> > via pipes.
> > 
> > Amean     1        0.7343 (   0.00%)      1.1377 * -54.93%*
> > Amean     4        1.1647 (   0.00%)      2.1543 * -84.97%*
> > Amean     7        1.6770 (   0.00%)      3.1300 * -86.64%*
> > Amean     12       2.4500 (   0.00%)      4.6447 * -89.58%*
> > Amean     21       3.9927 (   0.00%)      6.8250 * -70.94%*
> > Amean     30       5.5320 (   0.00%)      8.6433 * -56.24%*
> > Amean     48       8.4723 (   0.00%)     12.1890 * -43.87%*
> > Amean     79      12.3760 (   0.00%)     17.8347 * -44.11%*
> > Amean     110     16.0257 (   0.00%)     23.1373 * -44.38%*
> > Amean     141     20.7070 (   0.00%)     29.8537 * -44.17%*
> > Amean     172     25.1507 (   0.00%)     37.4830 * -49.03%*
> > Amean     203     28.5303 (   0.00%)     43.5220 * -52.55%*
> > Amean     234     33.8233 (   0.00%)     51.5403 * -52.38%*
> > Amean     265     37.8703 (   0.00%)     58.1860 * -53.65%*
> > Amean     296     43.8303 (   0.00%)     64.9223 * -48.12%*
> > Stddev    1        0.0040 (   0.00%)      0.0117 (-189.97%)
> > Stddev    4        0.0046 (   0.00%)      0.0766 (-1557.56%)
> > Stddev    7        0.0333 (   0.00%)      0.0991 (-197.83%)
> > Stddev    12       0.0425 (   0.00%)      0.1303 (-206.90%)
> > Stddev    21       0.0337 (   0.00%)      0.4138 (-1127.60%)
> > Stddev    30       0.0295 (   0.00%)      0.1551 (-424.94%)
> > Stddev    48       0.0445 (   0.00%)      0.2056 (-361.71%)
> > Stddev    79       0.0350 (   0.00%)      0.4118 (-1076.56%)
> > Stddev    110      0.0655 (   0.00%)      0.3685 (-462.72%)
> > Stddev    141      0.3670 (   0.00%)      0.5488 ( -49.55%)
> > Stddev    172      0.7375 (   0.00%)      1.0806 ( -46.52%)
> > Stddev    203      0.0817 (   0.00%)      1.6920 (-1970.11%)
> > Stddev    234      0.8210 (   0.00%)      1.4036 ( -70.97%)
> > Stddev    265      0.9337 (   0.00%)      1.1025 ( -18.08%)
> > Stddev    296      1.5688 (   0.00%)      0.4154 (  73.52%)
> > 
> > The problem with hackbench is that "1" above doesn't represent 1 task,
> > it represents 1 group and so the machine gets saturated relatively
> > quickly and it's super sensitive to cores being idle and available to
> > make quick progress.
> 
> hackbench is also super sensitive to the same group of ~20 tasks being 
> able to progress at once, and hence is pretty noisy.
> 
> The flip-over between hackbench being able to progress effectively and a 
> half-scheduled group hindering all the others seems to be super 
> non-deterministic and can be triggered by random events both within 
> hackbench, and other things happening on the machine.
> 

Indeed.

> So while hackbench is somewhat artificial in its intensity and load 
> levels, it still matches messaging server peak loads so it's still 
> consider it an imporant metric of scheduling quality.
> 

Typically I end up using hackbench as a canary. It can detect when
something is wrong, not necessarily that real workloads care.

> I'm wondering whether the scheduler could do anything to reduce the 
> non-determinism of hackbench.
> 
> BTW., note that 'perf bench scheduling' is a hackbench work-alike:
> 
>  dagon:~/tip> perf bench sched messaging
>  # Running 'sched/messaging' benchmark:
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>      Total time: 0.158 [sec]
> 
> It also has a threaded variant (which is a hackbench-pthread work-alike):
> 
>  dagon:~/tip> perf bench sched messaging --thread --group 20
>  # Running 'sched/messaging' benchmark:
>  # 20 sender and receiver threads per group
>  # 20 groups == 800 threads run
> 
>      Total time: 0.265 [sec]
> 
> I'm trying to distill the most important scheduler micro-benchmarks into 
> 'perf bench':
> 
>   dagon:~/tip> perf bench sched
> 
>         # List of available benchmarks for collection 'sched':
> 
>      messaging: Benchmark for scheduling and IPC
>           pipe: Benchmark for pipe() between two processes
>            all: Run all scheduler benchmarks
> 
> which is still stuck at a very low count of 2 benchmarks currently.
> :-)
> 

FWIW, mmtests does have support for running perf bench for some loads. I
just never converted "hackbench" over to the perf variant because I
didn't want to discard old data. Poor justification I know.

> > Kernel building which is all anyone ever cares about is a mixed bag
> > 
> > 1-socket
> > Amean     elsp-2       420.45 (   0.00%)      240.80 *  42.73%*
> > Amean     elsp-4       363.54 (   0.00%)      135.09 *  62.84%*
> > Amean     elsp-8       105.40 (   0.00%)      131.46 * -24.73%*
> > Amean     elsp-16      106.61 (   0.00%)      133.57 * -25.29%*
> > 
> > 2-socket
> > Amean     elsp-2        406.76 (   0.00%)      448.57 ( -10.28%)
> > Amean     elsp-4        235.22 (   0.00%)      289.48 ( -23.07%)
> > Amean     elsp-8        152.36 (   0.00%)      116.76 (  23.37%)
> > Amean     elsp-16        64.50 (   0.00%)       52.12 *  19.20%*
> > Amean     elsp-32        30.28 (   0.00%)       28.24 *   6.74%*
> > Amean     elsp-64        21.67 (   0.00%)       23.00 *  -6.13%*
> > Amean     elsp-128       20.57 (   0.00%)       23.57 * -14.60%*
> > Amean     elsp-160       20.64 (   0.00%)       23.63 * -14.50%*
> > Stddev    elsp-2         75.35 (   0.00%)       35.00 (  53.55%)
> > Stddev    elsp-4         71.12 (   0.00%)       86.09 ( -21.05%)
> > Stddev    elsp-8         43.05 (   0.00%)       10.67 (  75.22%)
> > Stddev    elsp-16         4.08 (   0.00%)        2.31 (  43.41%)
> > Stddev    elsp-32         0.51 (   0.00%)        0.76 ( -48.60%)
> > Stddev    elsp-64         0.38 (   0.00%)        0.61 ( -60.72%)
> > Stddev    elsp-128        0.13 (   0.00%)        0.41 (-207.53%)
> > Stddev    elsp-160        0.08 (   0.00%)        0.20 (-147.93%)
> > 
> > 1-socket matches other patterns, the 2-socket was weird. Variability was
> > nuts for low number of jobs. It's also not universal. I had tested in a
> > 2-socket Haswell machine and it showed different results
> > 
> > Amean     elsp-2       447.91 (   0.00%)      467.43 (  -4.36%)
> > Amean     elsp-4       284.47 (   0.00%)      248.37 (  12.69%)
> > Amean     elsp-8       166.20 (   0.00%)      129.23 (  22.24%)
> > Amean     elsp-16       63.89 (   0.00%)       55.63 *  12.93%*
> > Amean     elsp-32       36.80 (   0.00%)       35.87 *   2.54%*
> > Amean     elsp-64       30.97 (   0.00%)       36.94 * -19.28%*
> > Amean     elsp-96       31.66 (   0.00%)       37.32 * -17.89%*
> > Stddev    elsp-2        58.08 (   0.00%)       57.93 (   0.25%)
> > Stddev    elsp-4        65.31 (   0.00%)       41.56 (  36.36%)
> > Stddev    elsp-8        68.32 (   0.00%)       15.61 (  77.15%)
> > Stddev    elsp-16        3.68 (   0.00%)        2.43 (  33.87%)
> > Stddev    elsp-32        0.29 (   0.00%)        0.97 (-239.75%)
> > Stddev    elsp-64        0.36 (   0.00%)        0.24 (  32.10%)
> > Stddev    elsp-96        0.30 (   0.00%)        0.31 (  -5.11%)
> > 
> > Still not a perfect match to the general pattern for 2 build jobs and a
> > bit variable but otherwise the pattern holds -- performs better until the
> > machine is saturated. Kernel builds (or compilation builds) are always a
> > bit off as a benchmark as it has a mix of parallel and serialised tasks
> > that are non-deterministic.
> 
> Interesting.
> 
> Here too I'm wondering whether the scheduler could do something to 
> improve the saturated case: which *is* an important workload, as kernel 
> hackers tend to over-load their systems a bit when building kernel, to 
> make sure the system is at least 100% utilized. ;-)
> 

Every so often I try but I never managed to settle on a heuristic that
helped this case without breaking others. The biggest hurdle is that
typically things are better if migrations are low but it's hard to do
that in a way that does not also stack tasks on the same CPUs prematurely.

> > ep is the embarassingly parallel problem and it shows with half the cores
> > with HT off, we take a 38.76% performance hit. However, even that is not
> > universally true as cg for example did not parallelise as well and only
> > performacne 4.42% worse even with HT off.
> 
> Very interesting. I'm wondering what kind of workload 'ep' is exactly, 
> and would love to have a work-alike in 'perf sched bench'.
> 

I never looked too closely. It's characterised in the paper "THE NAS
PARALLEL BENCHMARKS" as follows;

	An embarrassingly parallel kernel. It provides an estimate of
	the upper achievable limits for floating point performance, i.e.,
	the performance without significant interprocessor communication.

> Do these benchmarks over-saturate by default, and is this really 
> representative of how all the large compute cluster folks are *using* 
> MPI?
> 

No, they don't. They are configured with a thread count with some
limitations if MPI is used (some problems require the degree of
parallelisation to be a power-of-two for example). In this case I compared
a "full" configuration for HT Off against a "half" configuration for HT
On so that both configurations used the same number of cores.

> I thought the more common pattern was to closely tailor MPI parallelism 
> to available (logical) cores parallelism, to minimize shared cache 
> trashing in an oversubscribed scenario, but I could be wrong.
> 

It is although it depends on the exact application, but in this test I
didn't do a setup like that.

> > I can show a comparison with equal levels of parallelisation but with 
> > HT off, it is a completely broken configuration and I do not think a 
> > comparison like that makes any sense.
> 
> I would still be interested in that comparison, because I'd like
> to learn whether there's any true *inherent* performance advantage to 
> HyperThreading for that particular workload, for exactly tuned 
> parallelism.
> 

It really isn't a fair comparison. MPI seems to behave very differently
when a machine is saturated. It's documented as changing its behaviour
as it tries to avoid the worst consequences of saturation.

Curiously, the results on the 2-socket machine were not as bad as I
feared when the HT configuration is running with twice the number of
threads as there are CPUs

Amean     bt      771.15 (   0.00%)     1086.74 * -40.93%*
Amean     cg      445.92 (   0.00%)      543.41 * -21.86%*
Amean     ep       70.01 (   0.00%)       96.29 * -37.53%*
Amean     is       16.75 (   0.00%)       21.19 * -26.51%*
Amean     lu      882.84 (   0.00%)      595.14 *  32.59%*
Amean     mg       84.10 (   0.00%)       80.02 *   4.84%*
Amean     sp     1353.88 (   0.00%)     1384.10 *  -2.23%*

> Even if nobody is going to run the NPB/NAS benchmark that way.
> 
> > I didn't do any comparison that could represent Cloud. However, I think
> > it's worth noting that HT may be popular there for packing lots of virtual
> > machines onto a single host and over-subscribing. HT would intuitively
> > have an advantage there *but* it depends heavily on the utilisation and
> > whether there is sustained VCPU activity where the number of active VCPUs
> > exceeds physical CPUs when HT is off. There is also the question whether
> > performance even matters on such configurations but anything cloud related
> > will be "how long is a piece of string" and "it depends".
> 
> Intuitively I'd guess that because all the cloud providers are pushing 
> for core-sched HT is probably a win in cloud benchmarks, if not for the 
> pesky security problems. ;-)
> 

Indeed. When it gets down to it, I expect they have better data on what
average utilisation of physical cores are as a ratio to vcpus.

> > So there you have it, HT Off is not a guaranteed loss and can be a gain
> > so it should be considered as an alternative to core scheduling. The case
> > where HT makes a big difference is when a workload is CPU or memory bound
> > and the number of active tasks exceeds the number of CPUs on a socket
> > and again when number of active tasks exceeds the number of CPUs in the
> > whole machine.
> 
> Fascinating measurements, thanks a lot Mel for doing these!
> 

My pleasure!

-- 
Mel Gorman
SUSE Labs
