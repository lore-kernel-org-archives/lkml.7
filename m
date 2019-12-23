Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9097520715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPcB/x/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLWNlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:41:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45839 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfLWNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:41:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so12619821lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZQ8NEVAQNmBNs8XG+70ZUbhD+rV6oYpD7kjtkhyDs8=;
        b=XPcB/x/EvUM6UxYFSxCJ+OPTtZB5g1+6X1znaPCx0IyLbDswKBYemUEWJpKwbVbeXr
         MFR8+zERQ2UbPYJXg/IL0sq3t1usee8BpvS9/bLko5hFD1cRr+DV50F7cDKYD/JBtxg5
         S6BeBUnR1U7tWJ2LVmZsdL4P0Gj0a8V7th0sULZOCFXmuYwUuMtHUC7f68rUMzJivgp6
         QolgrYBhgH7eQo2EsnVDAleHH1D5efY4K03ts4BP0bHhZmn3FlY2x3ncsPYa+q6lMHOK
         XLmQ50pcpogOO6a2z0tAAtMtGnvLCbuc7MaJNNNOmHPyhI0iibE6SaUywuhZhfsoarH4
         B7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZQ8NEVAQNmBNs8XG+70ZUbhD+rV6oYpD7kjtkhyDs8=;
        b=ROgHQeHL2u9or1DD3/H+JU10qmkNM1UvRHe7hsVMp5APhpjBI+6B6B41NyxIz9zbJW
         OxmGbdgS8a1RU/u7BYdy3N/ux1JK3fl+b2glWFk6+88/3QUfX4ojShl4yiztJ/Sdjr7T
         MaQhmGsXxwBTHu3EVsxGnvZ/4txYzcyVgvVr9iGEZexFUY/IYk2rAnW4TXogRXkkhDTU
         ToMOMXO9AMqn0lYF2o+yyo/HMWugMZp0jZ3Zhof+DSOTRtvyBIFi3Bj3nEI1pPHGFjZ7
         sl4ZVBhWkFxlIpwLkAPIDvHIZh42/py0AHdiryAmtno4K2tTGfMRX0rM7Zkz7Oua17bY
         UcSw==
X-Gm-Message-State: APjAAAWx5FUNAKoxcweNiSM6rM9PLimtfUVO81OKhamYVmVN25P2G0JX
        9m3P8F0Fup79K2+5MwyuamWZ4wS8D6g2BvAU4+FS0A==
X-Google-Smtp-Source: APXvYqyDa4kCVpstafe4ZaPH4YOs2KnpgPRstWcpWXrxHYgg9sd4f8I94zR0ciXBsJUp+NbPCTp1aFJtPQKaSZ/O2GQ=
X-Received: by 2002:ac2:44d9:: with SMTP id d25mr17623493lfm.15.1577108500511;
 Mon, 23 Dec 2019 05:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20191220084252.GL3178@techsingularity.net> <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
In-Reply-To: <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 Dec 2019 14:41:29 +0100
Message-ID: <CAKfTPtAofsnOw6Yvz2GY=9OfX45mFNwv1pdu4OJXvmsOae6YbQ@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 at 14:31, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 20 Dec 2019 at 09:42, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Changelog since V1
> > o Alter code flow                                               vincent.guittot
> > o Use idle CPUs for comparison instead of sum_nr_running        vincent.guittot
> > o Note that the division is still in place. Without it and taking
> >   imbalance_adj into account before the cutoff, two NUMA domains
> >   do not converage as being equally balanced when the number of
> >   busy tasks equals the size of one domain (50% of the sum).
> >   Some data is in the changelog.
> >
> > The CPU load balancer balances between different domains to spread load
> > and strives to have equal balance everywhere. Communicating tasks can
> > migrate so they are topologically close to each other but these decisions
> > are independent. On a lightly loaded NUMA machine, two communicating tasks
> > pulled together at wakeup time can be pushed apart by the load balancer.
> > In isolation, the load balancer decision is fine but it ignores the tasks
> > data locality and the wakeup/LB paths continually conflict. NUMA balancing
> > is also a factor but it also simply conflicts with the load balancer.
> >
> > This patch allows a degree of imbalance to exist between NUMA domains
> > based on the imbalance_pct defined by the scheduler domain. This slight
> > imbalance is allowed until the scheduler domain reaches almost 50%
> > utilisation at which point other factors like HT utilisation and memory
> > bandwidth come into play. While not commented upon in the code, the cutoff
> > is important for memory-bound parallelised non-communicating workloads
> > that do not fully utilise the entire machine. This is not necessarily the
> > best universal cut-off point but it appeared appropriate for a variety
> > of workloads and machines.
> >
> > The most obvious impact is on netperf TCP_STREAM -- two simple
> > communicating tasks with some softirq offloaded depending on the
> > transmission rate.
> >
> > 2-socket Haswell machine 48 core, HT enabled
> > netperf-tcp -- mmtests config config-network-netperf-unbound
> >                               baseline              lbnuma-v1
> > Hmean     64         666.68 (   0.00%)      667.31 (   0.09%)
> > Hmean     128       1276.18 (   0.00%)     1288.92 *   1.00%*
> > Hmean     256       2366.78 (   0.00%)     2422.22 *   2.34%*
> > Hmean     1024      8123.94 (   0.00%)     8464.15 *   4.19%*
> > Hmean     2048     12962.45 (   0.00%)    13693.79 *   5.64%*
> > Hmean     3312     17709.24 (   0.00%)    17494.23 (  -1.21%)
> > Hmean     4096     19756.01 (   0.00%)    19472.58 (  -1.43%)
> > Hmean     8192     27469.59 (   0.00%)    27787.32 (   1.16%)
> > Hmean     16384    30062.82 (   0.00%)    30657.62 *   1.98%*
> > Stddev    64           2.64 (   0.00%)        2.09 (  20.76%)
> > Stddev    128          6.22 (   0.00%)        6.48 (  -4.28%)
> > Stddev    256          9.75 (   0.00%)       22.85 (-134.30%)
> > Stddev    1024        69.62 (   0.00%)       58.41 (  16.11%)
> > Stddev    2048        72.73 (   0.00%)       83.47 ( -14.77%)
> > Stddev    3312       412.35 (   0.00%)       75.77 (  81.63%)
> > Stddev    4096       345.02 (   0.00%)      297.01 (  13.91%)
> > Stddev    8192       280.09 (   0.00%)      485.36 ( -73.29%)
> > Stddev    16384      452.99 (   0.00%)      250.21 (  44.76%)
> >
> > Fairly small impact on average performance but note how much the standard
> > deviation is reduced in many cases. A clearer story is visible from the
> > NUMA Balancing stats
> >
> > Ops NUMA base-page range updates       21596.00         282.00
> > Ops NUMA PTE updates                   21596.00         282.00
> > Ops NUMA PMD updates                       0.00           0.00
> > Ops NUMA hint faults                   17786.00         137.00
> > Ops NUMA hint local faults %            9916.00         137.00
> > Ops NUMA hint local percent               55.75         100.00
> > Ops NUMA pages migrated                 4231.00           0.00
> >
> > Without the patch, only 55.75% of sampled accesses are local.
> > With the patch, 100% of sampled accesses are local. A 2-socket
> > Broadwell showed better results on average but are not presented
> > for brevity. The patch holds up for 4-socket boxes as well
> >
> > 4-socket Haswell machine, 144 core, HT enabled
> > netperf-tcp
> >
> >                               baseline              lbnuma-v1
> > Hmean     64         953.51 (   0.00%)      977.27 *   2.49%*
> > Hmean     128       1826.48 (   0.00%)     1863.37 *   2.02%*
> > Hmean     256       3295.19 (   0.00%)     3329.37 (   1.04%)
> > Hmean     1024     10915.40 (   0.00%)    11339.60 *   3.89%*
> > Hmean     2048     17833.82 (   0.00%)    19066.12 *   6.91%*
> > Hmean     3312     22690.72 (   0.00%)    24048.92 *   5.99%*
> > Hmean     4096     24422.23 (   0.00%)    26606.60 *   8.94%*
> > Hmean     8192     31250.11 (   0.00%)    33374.62 *   6.80%*
> > Hmean     16384    37033.70 (   0.00%)    38684.28 *   4.46%*
> > Hmean     16384    37033.70 (   0.00%)    38732.22 *   4.59%*
> >
> > On this machine, the baseline measured 58.11% locality for sampled accesses
> > and 100% local accesses with the patch. Similarly, the patch holds up
> > for 2-socket machines with multiple L3 caches such as the AMD Epyc 2
> >
> > 2-socket EPYC-2 machine, 256 cores
> > netperf-tcp
> > Hmean     64        1564.63 (   0.00%)     1550.59 (  -0.90%)
> > Hmean     128       3028.83 (   0.00%)     3030.48 (   0.05%)
> > Hmean     256       5733.47 (   0.00%)     5769.51 (   0.63%)
> > Hmean     1024     18936.04 (   0.00%)    19216.15 *   1.48%*
> > Hmean     2048     27589.77 (   0.00%)    28200.45 *   2.21%*
> > Hmean     3312     35361.97 (   0.00%)    35881.94 *   1.47%*
> > Hmean     4096     37965.59 (   0.00%)    38702.01 *   1.94%*
> > Hmean     8192     48499.92 (   0.00%)    49530.62 *   2.13%*
> > Hmean     16384    54249.96 (   0.00%)    55937.24 *   3.11%*
> >
> > For amusement purposes, here are two graphs showing CPU utilisation on
> > the 2-socket Haswell machine over time based on mpstat with the ordering
> > of the CPUs based on topology.
> >
> > http://www.skynet.ie/~mel/postings/lbnuma-20191218/netperf-tcp-mpstat-baseline.png
> > http://www.skynet.ie/~mel/postings/lbnuma-20191218/netperf-tcp-mpstat-lbnuma-v1r1.png
> >
> > The lines on the left match up CPUs that are HT siblings or on the same
> > node. The machine has only one L3 cache per NUMA node or that would also
> > be shown.  It should be very clear from the images that the baseline
> > kernel spread the load with lighter utilisation across nodes while the
> > patched kernel had heavy utilisation of fewer CPUs on one node.
> >
> > Hackbench generally shows good results across machines with some
> > differences depending on whether threads or sockets are used as well as
> > pipes or sockets.  This is the *worst* result from the 2-socket Haswell
> > machine
> >
> > 2-socket Haswell machine 48 core, HT enabled
> > hackbench-process-pipes -- mmtests config config-scheduler-unbound
> >                            5.5.0-rc1              5.5.0-rc1
> >                             baseline              lbnuma-v1
> > Amean     1        1.2580 (   0.00%)      1.2393 (   1.48%)
> > Amean     4        5.3293 (   0.00%)      5.2683 *   1.14%*
> > Amean     7        8.9067 (   0.00%)      8.7130 *   2.17%*
> > Amean     12      14.9577 (   0.00%)     14.5773 *   2.54%*
> > Amean     21      25.9570 (   0.00%)     25.6657 *   1.12%*
> > Amean     30      37.7287 (   0.00%)     37.1277 *   1.59%*
> > Amean     48      61.6757 (   0.00%)     60.0433 *   2.65%*
> > Amean     79     100.4740 (   0.00%)     98.4507 (   2.01%)
> > Amean     110    141.2450 (   0.00%)    136.8900 *   3.08%*
> > Amean     141    179.7747 (   0.00%)    174.5110 *   2.93%*
> > Amean     172    221.0700 (   0.00%)    214.7857 *   2.84%*
> > Amean     192    245.2007 (   0.00%)    238.3680 *   2.79%*
> >
> > An earlier prototype of the patch showed major regressions for NAS C-class
> > when running with only half of the available CPUs -- 20-30% performance
> > hits were measured at the time. With this version of the patch, the impact
> > is marginal. In this case, the patch is lbnuma-v2 where as nodivide is a
> > patch discussed during review that avoids a divide by putting the cutoff
> > at exactly 50% instead of accounting for imbalance_adj.
> >
> > NAS-C class OMP -- mmtests config hpc-nas-c-class-omp-half
> >                              baseline               nodivide              lbnuma-v1
> > Amean     bt.C       64.29 (   0.00%)       76.33 * -18.72%*       69.55 *  -8.17%*
> > Amean     cg.C       26.33 (   0.00%)       26.26 (   0.27%)       26.36 (  -0.11%)
> > Amean     ep.C       10.26 (   0.00%)       10.29 (  -0.31%)       10.26 (  -0.04%)
> > Amean     ft.C       17.98 (   0.00%)       19.73 *  -9.71%*       19.51 *  -8.52%*
> > Amean     is.C        0.99 (   0.00%)        0.99 (   0.40%)        0.99 (   0.00%)
> > Amean     lu.C       51.72 (   0.00%)       48.57 (   6.09%)       48.68 *   5.88%*
> > Amean     mg.C        8.12 (   0.00%)        8.27 (  -1.82%)        8.24 (  -1.50%)
> > Amean     sp.C       82.76 (   0.00%)       86.06 *  -3.99%*       83.42 (  -0.80%)
> > Amean     ua.C       58.64 (   0.00%)       57.66 (   1.67%)       57.79 (   1.45%)
> >
> > There is some impact but there is a degree of variability and the ones
> > showing impact are mainly workloads that are mostly parallelised
> > and communicate infrequently between tests. It's a corner case where
> > the workload benefits heavily from spreading wide and early which is
> > not common. This is intended to illustrate the worst case measured.
> >
> > In general, the patch simply seeks to avoid unnecessarily cross-node
> > migrations when a machine is lightly loaded but shows benefits for other
> > workloads. While tests are still running, so far it seems to benefit
> > light-utilisation smaller workloads on large machines and does not appear
> > to do any harm to larger or parallelised workloads.
> >
> > [valentin.schneider@arm.com: Reformat code flow, correct comment, use idle_cpus]
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  kernel/sched/fair.c | 37 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 08a233e97a01..60a780e1420e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8637,10 +8637,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >         /*
> >          * Try to use spare capacity of local group without overloading it or
> >          * emptying busiest.
> > -        * XXX Spreading tasks across NUMA nodes is not always the best policy
> > -        * and special care should be taken for SD_NUMA domain level before
> > -        * spreading the tasks. For now, load_balance() fully relies on
> > -        * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
> >          */
> >         if (local->group_type == group_has_spare) {
> >                 if (busiest->group_type > group_fully_busy) {
> > @@ -8671,6 +8667,39 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                         return;
> >                 }
> >
> > +               /* Consider allowing a small imbalance between NUMA groups */
> > +               if (env->sd->flags & SD_NUMA) {
> > +                       unsigned int imbalance_adj, imbalance_max;
> > +
> > +                       /*
> > +                        * imbalance_adj is the allowable degree of imbalance
> > +                        * to exist between two NUMA domains. It's calculated
> > +                        * relative to imbalance_pct with a minimum of two
> > +                        * tasks or idle CPUs. The choice of two is due to
> > +                        * the most basic case of two communicating tasks
> > +                        * that should remain on the same NUMA node after
> > +                        * wakeup.
> > +                        */
> > +                       imbalance_adj = max(2U, (busiest->group_weight *
> > +                               (env->sd->imbalance_pct - 100) / 100) >> 1);
> > +
> > +                       /*
> > +                        * Ignore small imbalances unless the busiest sd has
> > +                        * almost half as many busy CPUs as there are
> > +                        * available CPUs in the busiest group. Note that
> > +                        * it is not exactly half as imbalance_adj must be
> > +                        * accounted for or the two domains do not converge
> > +                        * as equally balanced if the number of busy tasks is
> > +                        * roughly the size of one NUMA domain.
> > +                        */
> > +                       imbalance_max = (busiest->group_weight >> 1) + imbalance_adj;
> > +                       if (env->imbalance <= imbalance_adj &&
>
> AFAICT, env->imbalance is undefined there. I have tried your patch
> with the below instead
>
> -                       if (env->imbalance <= imbalance_adj &&
> -                           busiest->idle_cpus >= imbalance_max) {
> +                       if (busiest->idle_cpus >= imbalance_max) {
>
> Sorry for the delay but running tests tooks more time than expected. I
> have applied your patch on top of v5.5-rc3+apparmor fix

I forgot to mentionned that the platform that used for the tests, is a
2 nodes 224 CPUs arm64

> I can see an improvement for
> hackbench -l (256000/#grp) -g #grp
>   1 groups    14.197 +/-0.95%   12.127 +/-1.19% (+14.58%)
>
> I haven't seen any difference otherwise
>
> > +                           busiest->idle_cpus >= imbalance_max) {
> > +                               env->imbalance = 0;
> > +                               return;
> > +                       }
> > +               }
> > +
> >                 if (busiest->group_weight == 1 || sds->prefer_sibling) {
> >                         unsigned int nr_diff = busiest->sum_nr_running;
> >                         /*
