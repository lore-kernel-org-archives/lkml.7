Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EADC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C3D25CEB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfE3PXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:23:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:2113 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfE3PXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:23:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 08:23:40 -0700
X-ExtLoop1: 1
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2019 08:23:36 -0700
Date:   Thu, 30 May 2019 23:23:14 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>, "lkp@01.org" <lkp@01.org>,
        "David S. Miller" <davem@davemloft.net>, ying.huang@intel.com
Subject: Re: [LKP] [tcp] 8b27dae5a2: netperf.Throughput_Mbps -25.7% regression
Message-ID: <20190530152314.ise5ycz6sdwfygph@shbuild888>
References: <20190403063436.GG20952@shao2-debian>
 <20190530103048.hfld4t4m37jsg4yo@shbuild888>
 <CANn89iL4TYBYVnRhzVAH8UXSptStnYkZ+Rq3swzsMWngRJmGCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL4TYBYVnRhzVAH8UXSptStnYkZ+Rq3swzsMWngRJmGCA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, May 30, 2019 at 05:21:40AM -0700, Eric Dumazet wrote:
> On Thu, May 30, 2019 at 3:31 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > On Wed, Apr 03, 2019 at 02:34:36PM +0800, kernel test robot wrote:
> > > Greeting,
> > >
> > > FYI, we noticed a -25.7% regression of netperf.Throughput_Mbps due to commit:
> > >
> > >
> > > commit: 8b27dae5a2e89a61c46c6dbc76c040c0e6d0ed4c ("tcp: add one skb cache for rx")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > Hi Eric,
> >
> > Could you help to check this? thanks,
> >
> 
> Hmmm... patch is old and had some bugs that have been fixed.
> 
> What numbers do you have with more recent kernels ?


I just run the test  with 5.2-rc2, and the regression is still there.

Thanks,
Feng

> 
> 
> 
> > - Feng
> >
> >
> > >
> > > in testcase: netperf
> > > on test machine: 104 threads Skylake with 192G memory
> > > with following parameters:
> > >
> > >       ip: ipv4
> > >       runtime: 900s
> > >       nr_threads: 200%
> > >       cluster: cs-localhost
> > >       test: TCP_STREAM
> > >       cpufreq_governor: performance
> > >
> > > test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> > > test-url: http://www.netperf.org/netperf/
> > >
> > > In addition to that, the commit also has significant impact on the following tests:
> > >
> > > +------------------+----------------------------------------------------+
> > > | testcase: change | netperf: netperf.Throughput_Mbps -25.6% regression |
> > > | test machine     | 104 threads Skylake with 192G memory               |
> > > | test parameters  | cluster=cs-localhost                               |
> > > |                  | cpufreq_governor=performance                       |
> > > |                  | ip=ipv4                                            |
> > > |                  | nr_threads=200%                                    |
> > > |                  | runtime=900s                                       |
> > > |                  | test=TCP_MAERTS                                    |
> > > +------------------+----------------------------------------------------+
> > >
> > >
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install job.yaml  # job file is attached in this email
> > >         bin/lkp run     job.yaml
> > >
> > > =========================================================================================
> > > cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
> > >   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.6/200%/debian-x86_64-2018-04-03.cgz/900s/lkp-skl-fpga01/TCP_STREAM/netperf
> > >
> > > commit:
> > >   472c2e07ee ("tcp: add one skb cache for tx")
> > >   8b27dae5a2 ("tcp: add one skb cache for rx")
> > >
> > > 472c2e07eef04514 8b27dae5a2e89a61c46c6dbc76c
> > > ---------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs
> > >            |             |             |
> > >           1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
> > >            :4           25%           1:4     dmesg.WARNING:at_ip_ip_finish_output2/0x
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >       3939           -25.7%       2925        netperf.Throughput_Mbps
> > >     819330           -25.7%     608425        netperf.Throughput_total_Mbps
> > >  3.725e+09           -25.8%  2.764e+09        netperf.time.involuntary_context_switches
> > >       7399            -1.8%       7266        netperf.time.percent_of_cpu_this_job_got
> > >      65271            -1.0%      64597        netperf.time.system_time
> > >       1529           -34.0%       1009        netperf.time.user_time
> > >  5.626e+09           -25.7%  4.178e+09        netperf.workload
> > >      12.36 ±  4%      +6.5       18.84        mpstat.cpu.all.soft%
> > >       2.95 ±  2%      -0.8        2.15        mpstat.cpu.all.usr%
> > >  9.557e+08           +13.2%  1.082e+09        numa-numastat.node0.local_node
> > >  9.557e+08           +13.2%  1.082e+09        numa-numastat.node0.numa_hit
> > >  4.845e+08 ±  2%     +11.6%  5.407e+08        numa-vmstat.node0.numa_hit
> > >  4.845e+08 ±  2%     +11.6%  5.406e+08        numa-vmstat.node0.numa_local
> > >       2662 ±  2%      +4.2%       2774        turbostat.Avg_MHz
> > >       1.87 ± 86%     -66.1%       0.63 ±  9%  turbostat.CPU%c1
> > >      94.75 ±  2%      +2.4%      97.00        vmstat.cpu.sy
> > >    8145843 ±  2%     -24.7%    6134835        vmstat.system.cs
> > >     224329            -0.8%     222470        vmstat.system.in
> > >  1.884e+09           +10.9%   2.09e+09        proc-vmstat.numa_hit
> > >  1.884e+09           +10.9%  2.089e+09        proc-vmstat.numa_local
> > >  1.506e+10           +10.9%  1.671e+10        proc-vmstat.pgalloc_normal
> > >  1.506e+10           +10.9%  1.671e+10        proc-vmstat.pgfree
> > >       2104 ±  8%     +86.4%       3922 ± 58%  sched_debug.cpu.avg_idle.min
> > >   35810547           -25.7%   26600377        sched_debug.cpu.nr_switches.avg
> > >   37423347           -25.1%   28047296        sched_debug.cpu.nr_switches.max
> > >   32860210           -25.5%   24491190        sched_debug.cpu.nr_switches.min
> > >     968.00 ±  4%     -18.2%     792.00 ±  7%  slabinfo.kmalloc-rcl-128.active_objs
> > >     968.00 ±  4%     -18.2%     792.00 ±  7%  slabinfo.kmalloc-rcl-128.num_objs
> > >      16611 ±  2%      +6.1%      17628 ±  4%  slabinfo.skbuff_fclone_cache.active_objs
> > >      16827 ±  2%      +5.7%      17794 ±  4%  slabinfo.skbuff_fclone_cache.num_objs
> > >      18.78 ±  5%     +28.9%      24.21        perf-stat.i.MPKI
> > >  1.942e+10 ±  2%     -21.1%  1.531e+10        perf-stat.i.branch-instructions
> > >       2.08 ±  6%      -0.1        1.97        perf-stat.i.branch-miss-rate%
> > >  3.892e+08 ±  2%     -22.6%  3.014e+08        perf-stat.i.branch-misses
> > >  1.767e+09 ±  2%      +4.3%  1.842e+09        perf-stat.i.cache-references
> > >    8171306 ±  2%     -24.7%    6151961        perf-stat.i.context-switches
> > >       2.88 ±  2%     +31.0%       3.78        perf-stat.i.cpi
> > >  2.761e+11 ±  2%      +4.2%  2.876e+11        perf-stat.i.cpu-cycles
> > >       1.10 ±  3%      -0.1        0.97        perf-stat.i.dTLB-load-miss-rate%
> > >  3.254e+08 ±  4%     -32.1%  2.208e+08        perf-stat.i.dTLB-load-misses
> > >  2.893e+10 ±  2%     -21.9%   2.26e+10        perf-stat.i.dTLB-loads
> > >   58990104 ±  5%     -25.8%   43766302        perf-stat.i.dTLB-store-misses
> > >  1.658e+10 ±  2%     -23.6%  1.266e+10        perf-stat.i.dTLB-stores
> > >      55.76            -3.4       52.34        perf-stat.i.iTLB-load-miss-rate%
> > >   63191122 ±  2%     -29.1%   44815478        perf-stat.i.iTLB-load-misses
> > >   49413835 ±  2%     -17.7%   40661018        perf-stat.i.iTLB-loads
> > >  9.688e+10 ±  2%     -21.5%  7.605e+10        perf-stat.i.instructions
> > >       1607 ±  3%      +8.1%       1737        perf-stat.i.instructions-per-iTLB-miss
> > >       0.35           -24.3%       0.27        perf-stat.i.ipc
> > >      86243 ± 29%     +52.4%     131400 ± 18%  perf-stat.i.node-stores
> > >      18.24           +32.8%      24.23        perf-stat.overall.MPKI
> > >       2.00            -0.0        1.97        perf-stat.overall.branch-miss-rate%
> > >       2.85           +32.7%       3.78        perf-stat.overall.cpi
> > >       1.11 ±  3%      -0.1        0.97        perf-stat.overall.dTLB-load-miss-rate%
> > >      56.12            -3.7       52.43        perf-stat.overall.iTLB-load-miss-rate%
> > >       1533 ±  2%     +10.7%       1697        perf-stat.overall.instructions-per-iTLB-miss
> > >       0.35           -24.6%       0.26        perf-stat.overall.ipc
> > >      15748            +4.3%      16430        perf-stat.overall.path-length
> > >  1.939e+10 ±  2%     -21.1%   1.53e+10        perf-stat.ps.branch-instructions
> > >  3.887e+08 ±  2%     -22.5%  3.011e+08        perf-stat.ps.branch-misses
> > >  1.764e+09 ±  2%      +4.3%   1.84e+09        perf-stat.ps.cache-references
> > >    8161286 ±  2%     -24.7%    6144845        perf-stat.ps.context-switches
> > >  2.757e+11 ±  2%      +4.2%  2.872e+11        perf-stat.ps.cpu-cycles
> > >   3.25e+08 ±  4%     -32.1%  2.206e+08        perf-stat.ps.dTLB-load-misses
> > >  2.889e+10 ±  2%     -21.8%  2.258e+10        perf-stat.ps.dTLB-loads
> > >   58916703 ±  5%     -25.8%   43714633        perf-stat.ps.dTLB-store-misses
> > >  1.656e+10 ±  2%     -23.6%  1.265e+10        perf-stat.ps.dTLB-stores
> > >   63112575 ±  2%     -29.1%   44762927        perf-stat.ps.iTLB-load-misses
> > >   49353553 ±  2%     -17.7%   40614004        perf-stat.ps.iTLB-loads
> > >  9.676e+10 ±  2%     -21.5%  7.596e+10        perf-stat.ps.instructions
> > >      86182 ± 29%     +52.3%     131291 ± 18%  perf-stat.ps.node-stores
> > >   8.86e+13           -22.5%  6.864e+13        perf-stat.total.instructions
> > >     136251 ±  8%     -18.5%     110991 ± 10%  interrupts.CPU1.RES:Rescheduling_interrupts
> > >     128756 ±  3%     -18.6%     104869 ±  6%  interrupts.CPU10.RES:Rescheduling_interrupts
> > >     119826 ±  6%     -12.1%     105329 ±  4%  interrupts.CPU100.RES:Rescheduling_interrupts
> > >     121133 ± 10%     -17.9%      99457        interrupts.CPU101.RES:Rescheduling_interrupts
> > >       9051 ±  3%     +14.1%      10328        interrupts.CPU102.CAL:Function_call_interrupts
> > >     131446 ±  7%     -17.8%     108104 ±  9%  interrupts.CPU102.RES:Rescheduling_interrupts
> > >     124627 ±  2%     -16.6%     103971 ±  9%  interrupts.CPU12.RES:Rescheduling_interrupts
> > >     131072 ± 11%     -19.9%     105033 ±  4%  interrupts.CPU13.RES:Rescheduling_interrupts
> > >     127845 ±  8%     -17.0%     106112 ±  9%  interrupts.CPU14.RES:Rescheduling_interrupts
> > >     126159 ± 10%     -20.6%     100111 ± 11%  interrupts.CPU15.RES:Rescheduling_interrupts
> > >     132232 ±  5%     -17.9%     108535 ±  7%  interrupts.CPU17.RES:Rescheduling_interrupts
> > >     127157 ±  4%     -17.3%     105165 ± 11%  interrupts.CPU18.RES:Rescheduling_interrupts
> > >     127948 ±  2%     -15.5%     108165 ± 11%  interrupts.CPU19.RES:Rescheduling_interrupts
> > >     122716 ±  6%     -14.0%     105519 ± 11%  interrupts.CPU23.RES:Rescheduling_interrupts
> > >     130754 ±  5%     -20.3%     104222 ±  9%  interrupts.CPU24.RES:Rescheduling_interrupts
> > >     126283 ±  4%     -16.6%     105320 ±  6%  interrupts.CPU27.RES:Rescheduling_interrupts
> > >       8997 ±  3%     -12.4%       7883 ±  9%  interrupts.CPU28.CAL:Function_call_interrupts
> > >     128467 ±  5%     -20.9%     101674 ± 11%  interrupts.CPU29.RES:Rescheduling_interrupts
> > >     133914 ±  6%     -26.0%      99089 ± 10%  interrupts.CPU3.RES:Rescheduling_interrupts
> > >       8987 ±  3%     -11.9%       7922 ±  7%  interrupts.CPU31.CAL:Function_call_interrupts
> > >     115389 ±  9%     -17.7%      94962 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
> > >       8830 ±  5%     -12.1%       7759 ±  4%  interrupts.CPU32.CAL:Function_call_interrupts
> > >     134198 ±  6%     -19.6%     107954 ±  6%  interrupts.CPU33.RES:Rescheduling_interrupts
> > >       8940 ±  3%      -8.8%       8154 ±  4%  interrupts.CPU34.CAL:Function_call_interrupts
> > >     123678 ± 12%     -17.1%     102582 ±  2%  interrupts.CPU34.RES:Rescheduling_interrupts
> > >       8969 ±  3%      -9.2%       8143 ±  4%  interrupts.CPU35.CAL:Function_call_interrupts
> > >     118372 ±  8%     -10.9%     105507 ±  9%  interrupts.CPU35.RES:Rescheduling_interrupts
> > >       8958 ±  3%      -9.2%       8131 ±  4%  interrupts.CPU36.CAL:Function_call_interrupts
> > >     132196 ±  3%     -16.2%     110761 ±  7%  interrupts.CPU4.RES:Rescheduling_interrupts
> > >     123005 ±  6%     -17.2%     101838 ±  3%  interrupts.CPU40.RES:Rescheduling_interrupts
> > >     132802 ± 15%     -23.6%     101521 ± 11%  interrupts.CPU43.RES:Rescheduling_interrupts
> > >     131107 ±  4%     -25.6%      97566 ±  3%  interrupts.CPU44.RES:Rescheduling_interrupts
> > >     127673 ±  8%     -24.0%      97028 ±  6%  interrupts.CPU47.RES:Rescheduling_interrupts
> > >     123709 ±  6%     -14.3%     106030 ± 12%  interrupts.CPU48.RES:Rescheduling_interrupts
> > >     123709 ±  7%     -12.4%     108355 ±  6%  interrupts.CPU49.RES:Rescheduling_interrupts
> > >     135382 ±  5%     -20.7%     107334 ±  3%  interrupts.CPU51.RES:Rescheduling_interrupts
> > >     130424 ±  4%     -17.4%     107704 ±  6%  interrupts.CPU52.RES:Rescheduling_interrupts
> > >     129234 ±  8%     -18.6%     105171 ± 10%  interrupts.CPU53.RES:Rescheduling_interrupts
> > >     131374 ±  6%     -18.8%     106699 ±  6%  interrupts.CPU54.RES:Rescheduling_interrupts
> > >     126141 ± 10%     -14.7%     107626 ± 11%  interrupts.CPU57.RES:Rescheduling_interrupts
> > >     133750 ±  9%     -19.9%     107102        interrupts.CPU6.RES:Rescheduling_interrupts
> > >     119663 ±  5%     -16.7%      99633 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
> > >     121078 ±  7%     -13.6%     104670 ±  9%  interrupts.CPU61.RES:Rescheduling_interrupts
> > >     121662 ±  5%     -15.3%     102992 ± 10%  interrupts.CPU63.RES:Rescheduling_interrupts
> > >     118130 ±  2%     -15.1%     100310 ±  5%  interrupts.CPU65.RES:Rescheduling_interrupts
> > >     128075 ±  6%     -18.4%     104495 ±  8%  interrupts.CPU67.RES:Rescheduling_interrupts
> > >     124700 ±  6%     -15.7%     105149 ±  4%  interrupts.CPU68.RES:Rescheduling_interrupts
> > >     119607 ±  9%     -12.7%     104432 ±  6%  interrupts.CPU7.RES:Rescheduling_interrupts
> > >     119288 ±  4%     -11.8%     105251 ±  6%  interrupts.CPU71.RES:Rescheduling_interrupts
> > >     125678 ±  7%     -18.7%     102141 ±  8%  interrupts.CPU72.RES:Rescheduling_interrupts
> > >     130174 ±  5%     -19.8%     104394 ±  3%  interrupts.CPU74.RES:Rescheduling_interrupts
> > >       9215 ±  2%      +9.8%      10119 ±  4%  interrupts.CPU76.CAL:Function_call_interrupts
> > >     113784 ±  8%     -10.6%     101686 ±  7%  interrupts.CPU78.RES:Rescheduling_interrupts
> > >     122103 ±  5%     -16.2%     102305 ±  5%  interrupts.CPU79.RES:Rescheduling_interrupts
> > >     122242 ±  3%     -23.8%      93153 ±  8%  interrupts.CPU81.RES:Rescheduling_interrupts
> > >       9154 ±  3%     +10.3%      10092 ±  4%  interrupts.CPU82.CAL:Function_call_interrupts
> > >     116414 ±  3%     -18.8%      94476 ±  9%  interrupts.CPU82.RES:Rescheduling_interrupts
> > >     128558 ± 12%     -24.5%      97067 ±  2%  interrupts.CPU83.RES:Rescheduling_interrupts
> > >       9147 ±  3%     +10.2%      10078 ±  4%  interrupts.CPU84.CAL:Function_call_interrupts
> > >     122842 ±  9%     -19.8%      98521 ±  2%  interrupts.CPU84.RES:Rescheduling_interrupts
> > >       9081 ±  3%     +10.9%      10071 ±  4%  interrupts.CPU85.CAL:Function_call_interrupts
> > >       9130 ±  2%     +10.2%      10065 ±  4%  interrupts.CPU86.CAL:Function_call_interrupts
> > >       9068 ±  3%     +10.9%      10057 ±  5%  interrupts.CPU87.CAL:Function_call_interrupts
> > >       9068 ±  3%     +10.8%      10050 ±  5%  interrupts.CPU88.CAL:Function_call_interrupts
> > >     122119 ±  5%     -20.1%      97576 ±  3%  interrupts.CPU88.RES:Rescheduling_interrupts
> > >       9065 ±  3%     +12.8%      10223 ±  2%  interrupts.CPU89.CAL:Function_call_interrupts
> > >     124799 ±  6%     -20.4%      99390 ±  8%  interrupts.CPU89.RES:Rescheduling_interrupts
> > >     130362 ±  2%     -12.6%     113981 ±  5%  interrupts.CPU9.RES:Rescheduling_interrupts
> > >       8902           +12.7%      10035 ±  5%  interrupts.CPU90.CAL:Function_call_interrupts
> > >       9062 ±  3%     +10.7%      10028 ±  5%  interrupts.CPU91.CAL:Function_call_interrupts
> > >     119442 ±  8%     -24.1%      90611 ±  2%  interrupts.CPU91.RES:Rescheduling_interrupts
> > >       9058 ±  3%     +10.7%      10023 ±  5%  interrupts.CPU92.CAL:Function_call_interrupts
> > >     117081 ± 10%     -21.2%      92294 ± 12%  interrupts.CPU92.RES:Rescheduling_interrupts
> > >       9058 ±  3%     +10.6%      10017 ±  5%  interrupts.CPU93.CAL:Function_call_interrupts
> > >     130977 ± 17%     -27.7%      94702 ±  6%  interrupts.CPU94.RES:Rescheduling_interrupts
> > >       9055 ±  3%     +10.5%      10003 ±  5%  interrupts.CPU95.CAL:Function_call_interrupts
> > >     116952 ±  4%     -12.4%     102488 ± 10%  interrupts.CPU95.RES:Rescheduling_interrupts
> > >       9054 ±  3%     +10.4%       9995 ±  5%  interrupts.CPU96.CAL:Function_call_interrupts
> > >       9054 ±  3%     +10.3%       9990 ±  5%  interrupts.CPU97.CAL:Function_call_interrupts
> > >     118634 ±  5%     -12.7%     103578 ±  9%  interrupts.CPU98.RES:Rescheduling_interrupts
> > >     116356 ± 10%     -16.5%      97115 ±  7%  interrupts.CPU99.RES:Rescheduling_interrupts
> > >   12787758 ±  2%     -14.8%   10896246        interrupts.RES:Rescheduling_interrupts
> > >      10.84           -10.8        0.00        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
> > >      10.56           -10.6        0.00        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
> > >      10.16           -10.2        0.00        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
> > >      10.07           -10.1        0.00        perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
> > >       9.71            -9.7        0.00        perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack
> > >       9.57            -9.6        0.00        perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue
> > >      21.28            -6.8       14.49        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      21.19            -6.8       14.43        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      20.57            -6.6       14.00        perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      20.46            -6.5       13.93        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
> > >      16.37            -3.0       13.34        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
> > >      16.18            -3.0       13.21        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       7.01 ±  4%      -2.4        4.61        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
> > >       6.90 ±  5%      -2.4        4.54        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
> > >       7.71 ±  2%      -2.2        5.51        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
> > >       7.69 ±  2%      -2.2        5.49        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> > >       6.19 ±  5%      -2.1        4.10        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
> > >       6.04 ±  5%      -2.0        4.00        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
> > >       5.89 ±  6%      -2.0        3.90        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
> > >       7.03 ±  2%      -2.0        5.04        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
> > >       5.71 ±  6%      -1.9        3.78        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
> > >      13.46            -1.9       11.54        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> > >       6.86 ±  2%      -1.9        4.93        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg
> > >       6.72 ±  2%      -1.9        4.83 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
> > >      13.26            -1.8       11.41        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
> > >       5.49            -1.8        3.67        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
> > >       2.62 ± 14%      -1.8        0.82 ±  5%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
> > >       5.29            -1.7        3.61        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
> > >       4.80            -1.6        3.17        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> > >       4.59            -1.6        3.02        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg
> > >       4.50            -1.5        2.96        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg
> > >       4.41            -1.5        2.90        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.wait_woken.sk_wait_data
> > >       4.81            -1.5        3.31        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> > >      10.13            -1.5        8.63        perf-profile.calltrace.cycles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       9.79            -1.4        8.36        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       2.14            -1.4        0.73        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
> > >       4.34            -1.4        2.96        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg
> > >       9.60            -1.4        8.23        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg
> > >       2.10 ± 34%      -1.4        0.73 ±  6%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock
> > >       2.08            -1.4        0.71        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
> > >       3.88 ±  2%      -1.2        2.71        perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       3.71            -1.2        2.55        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg
> > >       3.56 ±  2%      -1.1        2.49        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       3.32 ±  2%      -1.0        2.34        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
> > >       1.56            -0.9        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
> > >       3.14 ±  2%      -0.9        2.22        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
> > >       1.77            -0.6        1.16        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout.wait_woken
> > >       7.43 ±  2%      -0.6        6.87        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       7.41 ±  2%      -0.6        6.85        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       1.39            -0.5        0.87        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       1.34            -0.5        0.84        perf-profile.calltrace.cycles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       1.30            -0.5        0.81        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       1.09            -0.4        0.72        perf-profile.calltrace.cycles-pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       1.20            -0.4        0.84        perf-profile.calltrace.cycles-pp.__switch_to
> > >       1.09            -0.3        0.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
> > >       6.67 ±  2%      -0.3        6.38        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
> > >       0.83            -0.3        0.56        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
> > >       0.84            -0.3        0.57        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__sched_text_start.schedule.schedule_timeout.wait_woken
> > >       0.95            -0.3        0.69        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
> > >       0.75 ±  2%      -0.2        0.52        perf-profile.calltrace.cycles-pp._cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> > >       0.73 ±  2%      -0.2        0.51        perf-profile.calltrace.cycles-pp.preempt_schedule_common._cond_resched.__release_sock.release_sock.tcp_sendmsg
> > >       9.41            +1.1       10.47        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb
> > >       9.29            +1.1       10.39        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data
> > >      95.31            +1.4       96.67        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
> > >      95.15            +1.4       96.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      11.02            +7.2       18.20        perf-profile.calltrace.cycles-pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >      12.28 ±  2%      +7.2       19.51        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
> > >      12.21 ±  2%      +7.3       19.47        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
> > >      12.00 ±  2%      +7.3       19.34        perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
> > >      11.98 ±  2%      +7.3       19.32        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
> > >      11.74 ±  2%      +7.4       19.14        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
> > >      11.43 ±  2%      +7.4       18.87        perf-profile.calltrace.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq
> > >      11.37 ±  2%      +7.5       18.83        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
> > >       9.15            +7.5       16.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim
> > >       9.26            +7.5       16.80        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb
> > >       9.43            +7.6       17.01        perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked
> > >       9.79            +7.6       17.37        perf-profile.calltrace.cycles-pp.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >      10.97 ±  2%      +7.6       18.56        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack
> > >       9.59            +7.6       17.22        perf-profile.calltrace.cycles-pp.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
> > >      10.64 ±  3%      +7.7       18.30        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start
> > >      10.11 ±  3%      +7.8       17.94        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action
> > >       9.96 ±  3%      +7.9       17.82        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
> > >       3.91 ±  2%      +7.9       11.79        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
> > >       3.91 ±  2%      +7.9       11.79        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
> > >       9.90 ±  3%      +7.9       17.79        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
> > >       9.71 ±  3%      +8.0       17.67        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
> > >       3.58 ±  2%      +8.0       11.60        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
> > >       3.34 ±  2%      +8.1       11.45        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
> > >       9.05 ±  2%      +8.1       17.17        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
> > >      18.39            +8.7       27.12        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill
> > >      18.58            +8.7       27.31        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill
> > >      19.93            +8.7       28.67        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >      19.92            +8.7       28.66        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >      19.70            +8.7       28.45        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
> > >      19.77            +8.8       28.54        perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
> > >      72.20            +8.8       81.00        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      72.09            +8.8       80.92        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      71.49            +9.0       80.48        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      71.15            +9.1       80.24        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
> > >       0.00           +10.6       10.61        perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_rcv
> > >       0.00           +10.7       10.72        perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu
> > >       0.00           +11.0       10.98        perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
> > >       0.00           +11.1       11.11        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
> > >      54.40           +12.2       66.63        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
> > >   32407497           -26.7%   23748191        softirqs.CPU0.NET_RX
> > >   31936171 ±  3%     -23.8%   24347695        softirqs.CPU1.NET_RX
> > >   31995720 ±  3%     -23.5%   24474810        softirqs.CPU10.NET_RX
> > >   31851135           -28.4%   22807522        softirqs.CPU100.NET_RX
> > >   31165470 ±  2%     -27.9%   22460444 ±  2%  softirqs.CPU101.NET_RX
> > >   30427682 ±  3%     -27.8%   21964060 ±  2%  softirqs.CPU102.NET_RX
> > >   31822429           -30.3%   22190016 ±  2%  softirqs.CPU103.NET_RX
> > >   31794681 ±  3%     -24.0%   24170873 ±  2%  softirqs.CPU11.NET_RX
> > >   31337588 ±  3%     -25.0%   23487789 ±  2%  softirqs.CPU12.NET_RX
> > >   30982384 ±  3%     -21.6%   24285912        softirqs.CPU13.NET_RX
> > >   31985249 ±  2%     -24.5%   24135878 ±  2%  softirqs.CPU14.NET_RX
> > >   31569639 ±  3%     -23.4%   24173977 ±  2%  softirqs.CPU15.NET_RX
> > >   31672651 ±  2%     -23.7%   24152941 ±  2%  softirqs.CPU16.NET_RX
> > >   31845476 ±  2%     -23.4%   24406051        softirqs.CPU17.NET_RX
> > >   32237888           -24.4%   24378972        softirqs.CPU18.NET_RX
> > >   32390163           -25.7%   24060765        softirqs.CPU19.NET_RX
> > >   32518154           -26.3%   23981309 ±  2%  softirqs.CPU2.NET_RX
> > >   31625849 ±  2%     -26.0%   23391632 ±  2%  softirqs.CPU20.NET_RX
> > >   31800991 ±  2%     -24.2%   24096267 ±  2%  softirqs.CPU21.NET_RX
> > >   32165283 ±  2%     -23.9%   24484882        softirqs.CPU22.NET_RX
> > >   32096347 ±  3%     -24.6%   24198018 ±  2%  softirqs.CPU23.NET_RX
> > >   32606868           -24.9%   24498919        softirqs.CPU24.NET_RX
> > >   31333059 ±  2%     -23.5%   23972392 ±  2%  softirqs.CPU25.NET_RX
> > >   29740104 ±  3%     -23.9%   22620846        softirqs.CPU26.NET_RX
> > >       8933 ± 31%     -24.6%       6736 ±  7%  softirqs.CPU26.SCHED
> > >   31426927           -28.2%   22574373 ±  2%  softirqs.CPU27.NET_RX
> > >   31494409           -27.6%   22811958        softirqs.CPU28.NET_RX
> > >   31749609           -29.8%   22274240 ±  2%  softirqs.CPU29.NET_RX
> > >   31359195 ±  3%     -23.3%   24058233        softirqs.CPU3.NET_RX
> > >   31891532           -28.5%   22801967        softirqs.CPU30.NET_RX
> > >   31022930 ±  3%     -26.6%   22780850        softirqs.CPU31.NET_RX
> > >   31633941           -28.0%   22773366        softirqs.CPU32.NET_RX
> > >   31064582 ±  3%     -28.2%   22291648 ±  2%  softirqs.CPU33.NET_RX
> > >   30670424 ±  2%     -26.0%   22706259        softirqs.CPU34.NET_RX
> > >   31155193 ±  3%     -28.3%   22336447 ±  2%  softirqs.CPU35.NET_RX
> > >   31767721           -29.3%   22462506 ±  2%  softirqs.CPU36.NET_RX
> > >   31702765           -27.9%   22848963        softirqs.CPU37.NET_RX
> > >   31618979           -28.8%   22498908 ±  2%  softirqs.CPU38.NET_RX
> > >       8157 ± 30%     -22.3%       6342        softirqs.CPU38.SCHED
> > >   31178503 ±  2%     -28.8%   22206116 ±  2%  softirqs.CPU39.NET_RX
> > >   31543118 ±  3%     -22.7%   24378208        softirqs.CPU4.NET_RX
> > >   29993167 ±  3%     -26.6%   22006508        softirqs.CPU40.NET_RX
> > >   31389405 ±  2%     -27.4%   22777491        softirqs.CPU41.NET_RX
> > >   31225889 ±  3%     -28.1%   22466787 ±  2%  softirqs.CPU42.NET_RX
> > >   31122849 ±  3%     -27.5%   22548782        softirqs.CPU43.NET_RX
> > >   30449949 ±  3%     -26.7%   22314973 ±  2%  softirqs.CPU44.NET_RX
> > >   30708016 ±  3%     -26.5%   22575709        softirqs.CPU45.NET_RX
> > >   30869514 ±  2%     -27.1%   22517203        softirqs.CPU46.NET_RX
> > >   30349340 ±  3%     -26.7%   22238899 ±  2%  softirqs.CPU47.NET_RX
> > >   31690538           -27.9%   22844885        softirqs.CPU48.NET_RX
> > >   31442996           -27.6%   22774395        softirqs.CPU49.NET_RX
> > >   32539333           -24.8%   24475876        softirqs.CPU5.NET_RX
> > >   31777443           -28.1%   22839894        softirqs.CPU50.NET_RX
> > >   30319039 ±  4%     -25.8%   22488386        softirqs.CPU51.NET_RX
> > >   32358234           -24.7%   24364666        softirqs.CPU52.NET_RX
> > >   31051127 ±  3%     -23.5%   23764585 ±  2%  softirqs.CPU53.NET_RX
> > >   31368731 ±  3%     -22.3%   24384593        softirqs.CPU54.NET_RX
> > >   32739188           -26.5%   24063678 ±  2%  softirqs.CPU55.NET_RX
> > >   32587893           -25.0%   24425586        softirqs.CPU56.NET_RX
> > >   31762403 ±  3%     -24.6%   23947521        softirqs.CPU57.NET_RX
> > >   32342624           -25.5%   24095598        softirqs.CPU58.NET_RX
> > >   31850813 ±  3%     -23.7%   24310413        softirqs.CPU59.NET_RX
> > >   32296552           -26.1%   23882250 ±  2%  softirqs.CPU6.NET_RX
> > >   31208970 ±  3%     -23.9%   23735529 ±  2%  softirqs.CPU60.NET_RX
> > >   32655061           -25.7%   24259328        softirqs.CPU61.NET_RX
> > >   31834306 ±  3%     -23.2%   24436288        softirqs.CPU62.NET_RX
> > >   32492263           -25.7%   24146807 ±  2%  softirqs.CPU63.NET_RX
> > >   32160041           -24.6%   24237812        softirqs.CPU64.NET_RX
> > >   32146792           -25.1%   24083142        softirqs.CPU65.NET_RX
> > >   31886509 ±  3%     -24.3%   24153287 ±  2%  softirqs.CPU66.NET_RX
> > >   31124000 ±  2%     -21.2%   24534615        softirqs.CPU67.NET_RX
> > >   31606731 ±  3%     -23.7%   24115056 ±  2%  softirqs.CPU68.NET_RX
> > >   31809649 ±  4%     -27.3%   23140437        softirqs.CPU69.NET_RX
> > >   31832502 ±  3%     -23.8%   24256886        softirqs.CPU7.NET_RX
> > >   31934664 ±  2%     -23.5%   24445503        softirqs.CPU70.NET_RX
> > >   32283512           -24.5%   24374573        softirqs.CPU71.NET_RX
> > >   31559429 ±  3%     -23.0%   24304361        softirqs.CPU72.NET_RX
> > >   32519181           -26.5%   23915099 ±  2%  softirqs.CPU73.NET_RX
> > >   32064639 ±  3%     -23.5%   24531236        softirqs.CPU74.NET_RX
> > >   32552635           -25.2%   24358616        softirqs.CPU75.NET_RX
> > >   32574031           -25.1%   24391309        softirqs.CPU76.NET_RX
> > >   29891561           -18.3%   24435768        softirqs.CPU77.NET_RX
> > >   30558797 ±  3%     -27.1%   22290753 ±  2%  softirqs.CPU78.NET_RX
> > >   30913524 ±  3%     -27.1%   22542484        softirqs.CPU79.NET_RX
> > >   32338939           -25.2%   24184482        softirqs.CPU8.NET_RX
> > >   29930689 ±  3%     -24.3%   22649621        softirqs.CPU80.NET_RX
> > >   31789053           -29.3%   22471154 ±  2%  softirqs.CPU81.NET_RX
> > >   31080841 ±  3%     -28.0%   22371709 ±  2%  softirqs.CPU82.NET_RX
> > >   31004904 ±  3%     -28.0%   22335427        softirqs.CPU83.NET_RX
> > >   30902184 ±  2%     -26.4%   22746371        softirqs.CPU84.NET_RX
> > >   31508332           -28.4%   22567097        softirqs.CPU85.NET_RX
> > >   31437975           -29.0%   22331821 ±  2%  softirqs.CPU86.NET_RX
> > >   31025912 ±  3%     -26.1%   22913093        softirqs.CPU87.NET_RX
> > >   30270422 ±  2%     -25.2%   22636977 ±  2%  softirqs.CPU88.NET_RX
> > >   30385565 ±  4%     -26.0%   22499521 ±  2%  softirqs.CPU89.NET_RX
> > >   31577940 ±  3%     -22.4%   24489124        softirqs.CPU9.NET_RX
> > >   30152844 ±  3%     -24.7%   22717462        softirqs.CPU90.NET_RX
> > >   29900183 ±  2%     -24.9%   22460973        softirqs.CPU91.NET_RX
> > >   31952707           -28.9%   22715130        softirqs.CPU92.NET_RX
> > >   30820437 ±  3%     -26.6%   22619907 ±  2%  softirqs.CPU93.NET_RX
> > >   30627580 ±  3%     -25.6%   22790846        softirqs.CPU94.NET_RX
> > >   31367872           -27.7%   22670545        softirqs.CPU95.NET_RX
> > >   31045007 ±  3%     -26.5%   22818368        softirqs.CPU96.NET_RX
> > >   30842779 ±  3%     -28.2%   22143073 ±  2%  softirqs.CPU97.NET_RX
> > >   30173663 ±  3%     -24.8%   22686608        softirqs.CPU98.NET_RX
> > >   30750855 ±  3%     -25.6%   22870339        softirqs.CPU99.NET_RX
> > >  3.273e+09           -25.8%   2.43e+09        softirqs.NET_RX
> > >
> > >
> > >
> > >                               netperf.Throughput_Mbps
> > >
> > >   4000 +-+------------------------------------------------------------------+
> > >        |                                                                    |
> > >   3500 +-+                                                                  |
> > >   3000 +-+                                                                  |
> > >        O   O O  OO OOO OO OO OOO OO OO OO OOO OO OO OO                      |
> > >   2500 +-+                                                                  |
> > >        |                                                                    |
> > >   2000 +-+                                                                  |
> > >        |                                                                    |
> > >   1500 +-+                                                                  |
> > >   1000 +-+                                                                  |
> > >        |                                                                    |
> > >    500 +-+                                                                  |
> > >        |                                                                    |
> > >      0 +O+O---O-------------------------------------------------------------+
> > >
> > >
> > >                             netperf.Throughput_total_Mbps
> > >
> > >   900000 +-+----------------------------------------------------------------+
> > >          |+.++.+++.++.+++.++.+++.++.+++.++.+++.+++.++.+++.++.+++.++.+++.++.+|
> > >   800000 +-+                                                                |
> > >   700000 +-+                                                                |
> > >          |                              O                                   |
> > >   600000 O-+ O O O OO OOO OO OOO OO OOO  O OOO OOO OO O                     |
> > >   500000 +-+                                                                |
> > >          |                                                                  |
> > >   400000 +-+                                                                |
> > >   300000 +-+                                                                |
> > >          |                                                                  |
> > >   200000 +-+                                                                |
> > >   100000 +-+                                                                |
> > >          |                                                                  |
> > >        0 +O+O---O-----------------------------------------------------------+
> > >
> > >
> > >                                   netperf.workload
> > >
> > >   6e+09 +-+-----------------------------------------------------------------+
> > >         |+.++.++.+++.++.+++.++.++.+++.++.+++.++.++.+++.++.+++.++.++.+++.++.+|
> > >   5e+09 +-+                                                                 |
> > >         |                                                                   |
> > >         O   O O  OOO OO OOO OO OO OOO OO OOO OO OO OOO                      |
> > >   4e+09 +-+                                                                 |
> > >         |                                                                   |
> > >   3e+09 +-+                                                                 |
> > >         |                                                                   |
> > >   2e+09 +-+                                                                 |
> > >         |                                                                   |
> > >         |                                                                   |
> > >   1e+09 +-+                                                                 |
> > >         |                                                                   |
> > >       0 +O+O---O------------------------------------------------------------+
> > >
> > >
> > >                               netperf.time.user_time
> > >
> > >   2000 +-+------------------------------------------------------------------+
> > >   1800 +-+                       +                               +          |
> > >        |                        : :                             + :         |
> > >   1600 +-+       +. + .++.++. + : +.+ .++.   .++.++. +       .++  +    .++.+|
> > >   1400 +-+++.++.+  + +       + +     +    +++       + +.++.++      +.++     |
> > >        |                                                                    |
> > >   1200 +-+                                                                  |
> > >   1000 O-+ O    OO OOO OO OO OOO OO OO OO OOO OO OO OO                      |
> > >    800 +-+                                                                  |
> > >        |                                                                    |
> > >    600 +-+                                                                  |
> > >    400 +-+                                                                  |
> > >        |                                                                    |
> > >    200 +-+                                                                  |
> > >      0 +O+O--OO-------------------------------------------------------------+
> > >
> > >
> > >                      netperf.time.percent_of_cpu_this_job_got
> > >
> > >   8000 +-+------------------------------------------------------------------+
> > >        O+.+O.++.OO.OOO.OO.OO.OOO.OO.OO.OO.OOO.OO.OO.OO+.++.++.++.+++.++.++.+|
> > >   7000 +-+                                                                  |
> > >   6000 +-+                                                                  |
> > >        |                                                                    |
> > >   5000 +-+                                                                  |
> > >        |                                                                    |
> > >   4000 +-+                                                                  |
> > >        |                                                                    |
> > >   3000 +-+                                                                  |
> > >   2000 +-+                                                                  |
> > >        |                                                                    |
> > >   1000 +-+                                                                  |
> > >        |                                                                    |
> > >      0 +O+O--OO-------------------------------------------------------------+
> > >
> > >
> > >                        netperf.time.involuntary_context_switches
> > >
> > >     4e+09 +-+---------------------------------------------------------------+
> > >           |+.++.+++.+++.++.+++.+++.++.+++.+++.++.+++.+++.++.+++.+++.++.+++.+|
> > >   3.5e+09 +-+                                                               |
> > >     3e+09 +-+                                                               |
> > >           O   O   O OOO OO OOO OOO OO OOO OOO OO OOO OO                     |
> > >   2.5e+09 +-+                                                               |
> > >           |                                                                 |
> > >     2e+09 +-+                                                               |
> > >           |                                                                 |
> > >   1.5e+09 +-+                                                               |
> > >     1e+09 +-+                                                               |
> > >           |                                                                 |
> > >     5e+08 +-+                                                               |
> > >           |                                                                 |
> > >         0 +O+O--OO----------------------------------------------------------+
> > >
> > >
> > > [*] bisect-good sample
> > > [O] bisect-bad  sample
> > >
> > > ***************************************************************************************************
> > > lkp-skl-fpga01: 104 threads Skylake with 192G memory
> > > =========================================================================================
> > > cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
> > >   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.6/200%/debian-x86_64-2018-04-03.cgz/900s/lkp-skl-fpga01/TCP_MAERTS/netperf
> > >
> > > commit:
> > >   472c2e07ee ("tcp: add one skb cache for tx")
> > >   8b27dae5a2 ("tcp: add one skb cache for rx")
> > >
> > > 472c2e07eef04514 8b27dae5a2e89a61c46c6dbc76c
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >       3933           -25.6%       2926        netperf.Throughput_Mbps
> > >     818124           -25.6%     608758        netperf.Throughput_total_Mbps
> > >      57423 ± 19%     -41.1%      33817        netperf.time.involuntary_context_switches
> > >       3010            +3.7%       3122        netperf.time.percent_of_cpu_this_job_got
> > >      25432            +3.9%      26424        netperf.time.system_time
> > >  3.735e+09           -25.6%  2.778e+09        netperf.time.voluntary_context_switches
> > >  5.618e+09           -25.6%   4.18e+09        netperf.workload
> > >     194721 ± 22%     +41.3%     275069 ±  2%  cpuidle.C6.usage
> > >      13.00 ±  7%      +5.9       18.86        mpstat.cpu.all.soft%
> > >       3.39 ±  5%      -1.2        2.23        mpstat.cpu.all.usr%
> > >  9.539e+08           +13.2%   1.08e+09        numa-numastat.node0.local_node
> > >  9.539e+08           +13.2%   1.08e+09        numa-numastat.node0.numa_hit
> > >  4.767e+08           +13.1%  5.389e+08        numa-vmstat.node0.numa_hit
> > >  4.767e+08           +13.1%  5.389e+08        numa-vmstat.node0.numa_local
> > >      95.75            +1.3%      97.00        vmstat.cpu.sy
> > >    8245666           -25.5%    6142829        vmstat.system.cs
> > >       2696            +2.9%       2775        turbostat.Avg_MHz
> > >       0.89 ±  5%     -32.4%       0.60        turbostat.CPU%c1
> > >     108.00            -1.6%     106.23        turbostat.RAMWatt
> > >  1.881e+09           +11.2%  2.091e+09        proc-vmstat.numa_hit
> > >  1.881e+09           +11.2%  2.091e+09        proc-vmstat.numa_local
> > >  1.504e+10           +11.2%  1.672e+10        proc-vmstat.pgalloc_normal
> > >  1.504e+10           +11.2%  1.672e+10        proc-vmstat.pgfree
> > >       4053 ± 15%     +19.6%       4848 ± 13%  slabinfo.eventpoll_pwq.active_objs
> > >       4053 ± 15%     +19.6%       4848 ± 13%  slabinfo.eventpoll_pwq.num_objs
> > >     545.50 ± 11%     -17.1%     452.00 ± 11%  slabinfo.kernfs_iattrs_cache.active_objs
> > >     545.50 ± 11%     -17.1%     452.00 ± 11%  slabinfo.kernfs_iattrs_cache.num_objs
> > >      12.31 ± 12%     +25.1%      15.40        sched_debug.cfs_rq:/.load_avg.stddev
> > >    1449447 ± 23%     -29.2%    1026327 ± 22%  sched_debug.cfs_rq:/.min_vruntime.stddev
> > >       0.78 ± 66%    +155.6%       2.00 ± 11%  sched_debug.cfs_rq:/.removed.load_avg.avg
> > >       5.98 ± 60%     +84.9%      11.05 ±  4%  sched_debug.cfs_rq:/.removed.load_avg.stddev
> > >      35.94 ± 66%    +156.2%      92.09 ± 11%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
> > >     274.98 ± 60%     +85.4%     509.82 ±  4%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
> > >       0.39 ± 66%    +115.0%       0.84 ± 11%  sched_debug.cfs_rq:/.removed.util_avg.avg
> > >       1.75 ± 14%     +32.1%       2.31 ± 12%  sched_debug.cfs_rq:/.runnable_load_avg.min
> > >      98724 ± 85%     -66.3%      33282 ± 85%  sched_debug.cfs_rq:/.runnable_weight.max
> > >   -3346961           -44.2%   -1868641        sched_debug.cfs_rq:/.spread0.min
> > >    1449347 ± 23%     -29.2%    1026220 ± 22%  sched_debug.cfs_rq:/.spread0.stddev
> > >     156728 ± 15%     +49.0%     233530 ± 14%  sched_debug.cpu.avg_idle.avg
> > >     260031 ±  9%     +33.3%     346707 ± 10%  sched_debug.cpu.avg_idle.stddev
> > >      20.54 ±  5%     -10.2%      18.44 ±  2%  sched_debug.cpu.clock.stddev
> > >      20.54 ±  5%     -10.2%      18.44 ±  2%  sched_debug.cpu.clock_task.stddev
> > >   35742943           -25.6%   26602562        sched_debug.cpu.nr_switches.avg
> > >   37162589           -24.6%   28014480        sched_debug.cpu.nr_switches.max
> > >   32371186           -24.3%   24512619        sched_debug.cpu.nr_switches.min
> > >      18.74           +29.7%      24.31        perf-stat.i.MPKI
> > >  1.938e+10           -20.9%  1.534e+10        perf-stat.i.branch-instructions
> > >       2.05            -0.1        1.98        perf-stat.i.branch-miss-rate%
> > >  3.961e+08           -23.4%  3.033e+08        perf-stat.i.branch-misses
> > >       0.74 ± 31%      -0.4        0.38 ± 18%  perf-stat.i.cache-miss-rate%
> > >   12929011 ± 32%     -49.1%    6575616 ± 19%  perf-stat.i.cache-misses
> > >  1.813e+09            +2.3%  1.854e+09        perf-stat.i.cache-references
> > >    8267879           -25.5%    6157361        perf-stat.i.context-switches
> > >       2.89           +30.6%       3.77        perf-stat.i.cpi
> > >  2.794e+11            +2.9%  2.876e+11        perf-stat.i.cpu-cycles
> > >      23942 ± 24%     +97.5%      47291 ± 21%  perf-stat.i.cycles-between-cache-misses
> > >       1.13            -0.1        0.99        perf-stat.i.dTLB-load-miss-rate%
> > >  3.331e+08           -31.8%  2.274e+08        perf-stat.i.dTLB-load-misses
> > >    2.9e+10           -22.0%  2.263e+10        perf-stat.i.dTLB-loads
> > >   60002134 ±  2%     -26.3%   44193691 ±  2%  perf-stat.i.dTLB-store-misses
> > >  1.664e+10           -23.6%  1.271e+10        perf-stat.i.dTLB-stores
> > >      58.26            -4.7       53.57        perf-stat.i.iTLB-load-miss-rate%
> > >   70291090           -31.0%   48469793        perf-stat.i.iTLB-load-misses
> > >   50169394           -16.5%   41890643        perf-stat.i.iTLB-loads
> > >  9.677e+10           -21.2%  7.624e+10        perf-stat.i.instructions
> > >       1410           +13.6%       1602        perf-stat.i.instructions-per-iTLB-miss
> > >       0.35           -23.4%       0.27        perf-stat.i.ipc
> > >    2150902 ± 41%     -42.7%    1233268 ± 27%  perf-stat.i.node-load-misses
> > >     652857 ± 24%     -39.8%     393122 ± 15%  perf-stat.i.node-loads
> > >      77.08 ± 11%     -20.6       56.48 ± 14%  perf-stat.i.node-store-miss-rate%
> > >     386848 ± 40%     -64.7%     136565 ± 27%  perf-stat.i.node-store-misses
> > >      18.74           +29.8%      24.32        perf-stat.overall.MPKI
> > >       2.04            -0.1        1.98        perf-stat.overall.branch-miss-rate%
> > >       0.71 ± 32%      -0.4        0.35 ± 20%  perf-stat.overall.cache-miss-rate%
> > >       2.89           +30.6%       3.77        perf-stat.overall.cpi
> > >      23413 ± 23%     +95.0%      45644 ± 21%  perf-stat.overall.cycles-between-cache-misses
> > >       1.14            -0.1        0.99        perf-stat.overall.dTLB-load-miss-rate%
> > >      58.35            -4.7       53.64        perf-stat.overall.iTLB-load-miss-rate%
> > >       1376           +14.3%       1573        perf-stat.overall.instructions-per-iTLB-miss
> > >       0.35           -23.4%       0.27        perf-stat.overall.ipc
> > >      75.96 ± 13%     -20.1       55.89 ± 14%  perf-stat.overall.node-store-miss-rate%
> > >      15545            +5.9%      16457        perf-stat.overall.path-length
> > >  1.936e+10           -20.9%  1.532e+10        perf-stat.ps.branch-instructions
> > >  3.956e+08           -23.4%   3.03e+08        perf-stat.ps.branch-misses
> > >   12917167 ± 32%     -49.1%    6568704 ± 19%  perf-stat.ps.cache-misses
> > >  1.811e+09            +2.3%  1.852e+09        perf-stat.ps.cache-references
> > >    8258274           -25.5%    6150289        perf-stat.ps.context-switches
> > >  2.791e+11            +2.9%  2.872e+11        perf-stat.ps.cpu-cycles
> > >  3.328e+08           -31.8%  2.271e+08        perf-stat.ps.dTLB-load-misses
> > >  2.897e+10           -22.0%   2.26e+10        perf-stat.ps.dTLB-loads
> > >   59931265 ±  2%     -26.3%   44142618 ±  2%  perf-stat.ps.dTLB-store-misses
> > >  1.662e+10           -23.6%  1.269e+10        perf-stat.ps.dTLB-stores
> > >   70208114           -31.0%   48413951        perf-stat.ps.iTLB-load-misses
> > >   50111323           -16.5%   41842519        perf-stat.ps.iTLB-loads
> > >  9.666e+10           -21.2%  7.616e+10        perf-stat.ps.instructions
> > >    2148559 ± 41%     -42.7%    1231893 ± 27%  perf-stat.ps.node-load-misses
> > >     653248 ± 24%     -39.9%     392846 ± 15%  perf-stat.ps.node-loads
> > >     386418 ± 40%     -64.7%     136417 ± 27%  perf-stat.ps.node-store-misses
> > >  8.733e+13           -21.2%  6.879e+13        perf-stat.total.instructions
> > >     887.50 ± 21%    +961.1%       9417 ±122%  interrupts.39:PCI-MSI.67633154-edge.eth0-TxRx-1
> > >     906772            +4.4%     946334        interrupts.CAL:Function_call_interrupts
> > >     128451 ±  3%     -20.1%     102684 ± 11%  interrupts.CPU1.RES:Rescheduling_interrupts
> > >     122297 ± 12%     -20.1%      97767 ±  5%  interrupts.CPU100.RES:Rescheduling_interrupts
> > >     114996 ±  8%     -12.8%     100315 ±  5%  interrupts.CPU101.RES:Rescheduling_interrupts
> > >       8676 ±  2%     +14.9%       9972 ±  3%  interrupts.CPU102.CAL:Function_call_interrupts
> > >     145573 ± 15%     -30.4%     101298 ±  9%  interrupts.CPU102.RES:Rescheduling_interrupts
> > >       8795           +13.2%       9956 ±  3%  interrupts.CPU103.CAL:Function_call_interrupts
> > >     129834 ±  7%     -15.4%     109820 ±  9%  interrupts.CPU11.RES:Rescheduling_interrupts
> > >     122266 ±  5%     -18.3%      99893 ±  4%  interrupts.CPU13.RES:Rescheduling_interrupts
> > >     133695 ±  4%     -23.7%     101984 ±  5%  interrupts.CPU14.RES:Rescheduling_interrupts
> > >     115773 ±  7%     -18.6%      94202 ±  8%  interrupts.CPU18.RES:Rescheduling_interrupts
> > >     120005 ±  3%     -15.7%     101149 ±  8%  interrupts.CPU27.RES:Rescheduling_interrupts
> > >     119584 ±  3%     -19.5%      96286 ±  6%  interrupts.CPU29.RES:Rescheduling_interrupts
> > >     127064 ±  7%     -15.1%     107858 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
> > >     887.50 ± 21%    +961.1%       9417 ±122%  interrupts.CPU31.39:PCI-MSI.67633154-edge.eth0-TxRx-1
> > >     118974 ± 11%     -17.1%      98609 ±  7%  interrupts.CPU33.RES:Rescheduling_interrupts
> > >     125463 ± 13%     -23.9%      95477 ±  5%  interrupts.CPU34.RES:Rescheduling_interrupts
> > >     125126 ± 16%     -21.7%      97997 ±  7%  interrupts.CPU35.RES:Rescheduling_interrupts
> > >     133035 ± 12%     -28.2%      95517 ± 10%  interrupts.CPU37.RES:Rescheduling_interrupts
> > >     120167 ± 11%     -24.5%      90782 ±  8%  interrupts.CPU38.RES:Rescheduling_interrupts
> > >     125040 ±  3%     -19.8%     100223 ±  7%  interrupts.CPU42.RES:Rescheduling_interrupts
> > >     119768 ± 15%     -16.6%      99882        interrupts.CPU43.RES:Rescheduling_interrupts
> > >     125986 ±  7%     -18.9%     102226 ±  8%  interrupts.CPU45.RES:Rescheduling_interrupts
> > >     124516 ± 10%     -15.7%     104961 ±  5%  interrupts.CPU48.RES:Rescheduling_interrupts
> > >     125647 ±  5%     -22.8%      96970 ±  3%  interrupts.CPU49.RES:Rescheduling_interrupts
> > >     131345 ±  5%     -17.2%     108796 ±  3%  interrupts.CPU51.RES:Rescheduling_interrupts
> > >     127858 ±  3%     -18.9%     103683 ±  5%  interrupts.CPU53.RES:Rescheduling_interrupts
> > >     125241 ± 15%     -18.7%     101797 ±  5%  interrupts.CPU54.RES:Rescheduling_interrupts
> > >     133398 ±  7%     -22.1%     103961 ±  3%  interrupts.CPU56.RES:Rescheduling_interrupts
> > >     129732 ± 10%     -24.2%      98324 ±  4%  interrupts.CPU6.RES:Rescheduling_interrupts
> > >     132858 ± 12%     -20.5%     105623 ±  9%  interrupts.CPU60.RES:Rescheduling_interrupts
> > >     123442 ±  5%     -20.7%      97934 ±  4%  interrupts.CPU64.RES:Rescheduling_interrupts
> > >     132863 ±  3%     -20.2%     106040 ±  4%  interrupts.CPU65.RES:Rescheduling_interrupts
> > >       9002           +10.7%       9967 ±  2%  interrupts.CPU66.CAL:Function_call_interrupts
> > >       8999           +10.7%       9958 ±  2%  interrupts.CPU67.CAL:Function_call_interrupts
> > >       8774 ±  5%     +13.4%       9951 ±  2%  interrupts.CPU68.CAL:Function_call_interrupts
> > >       8991           +10.6%       9945 ±  2%  interrupts.CPU69.CAL:Function_call_interrupts
> > >     125949 ±  9%     -15.0%     107048 ±  4%  interrupts.CPU69.RES:Rescheduling_interrupts
> > >     123443 ±  8%     -15.7%     104008 ±  8%  interrupts.CPU7.RES:Rescheduling_interrupts
> > >       8987           +10.6%       9938 ±  2%  interrupts.CPU70.CAL:Function_call_interrupts
> > >       8983           +10.5%       9927 ±  2%  interrupts.CPU71.CAL:Function_call_interrupts
> > >     122925 ± 12%     -18.0%     100786 ±  8%  interrupts.CPU71.RES:Rescheduling_interrupts
> > >       8925           +11.0%       9910 ±  2%  interrupts.CPU73.CAL:Function_call_interrupts
> > >     126258 ±  7%     -19.4%     101773 ±  7%  interrupts.CPU73.RES:Rescheduling_interrupts
> > >     129281 ±  6%     -18.1%     105945 ±  5%  interrupts.CPU74.RES:Rescheduling_interrupts
> > >       8969           +10.3%       9893 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
> > >       8966           +10.3%       9887 ±  2%  interrupts.CPU76.CAL:Function_call_interrupts
> > >       8965           +10.1%       9870 ±  2%  interrupts.CPU77.CAL:Function_call_interrupts
> > >     129057 ±  9%     -24.7%      97240 ±  3%  interrupts.CPU77.RES:Rescheduling_interrupts
> > >       8683 ±  5%     +13.7%       9874 ±  2%  interrupts.CPU78.CAL:Function_call_interrupts
> > >     129114 ±  9%     -27.6%      93483 ±  4%  interrupts.CPU78.RES:Rescheduling_interrupts
> > >       8685 ±  4%     +13.6%       9865 ±  2%  interrupts.CPU79.CAL:Function_call_interrupts
> > >     121386 ±  7%     -18.7%      98627 ±  5%  interrupts.CPU8.RES:Rescheduling_interrupts
> > >       8956           +10.1%       9864 ±  2%  interrupts.CPU80.CAL:Function_call_interrupts
> > >     125015 ± 11%     -24.1%      94918 ±  5%  interrupts.CPU80.RES:Rescheduling_interrupts
> > >       8633 ±  7%     +14.2%       9856 ±  2%  interrupts.CPU81.CAL:Function_call_interrupts
> > >     132492 ±  4%     -20.7%     105014 ±  4%  interrupts.CPU81.RES:Rescheduling_interrupts
> > >       8857 ±  2%     +11.2%       9848 ±  2%  interrupts.CPU82.CAL:Function_call_interrupts
> > >     111387 ±  6%     -13.8%      96026 ±  8%  interrupts.CPU82.RES:Rescheduling_interrupts
> > >     112445 ±  6%      -9.6%     101699 ±  7%  interrupts.CPU83.RES:Rescheduling_interrupts
> > >     121973 ±  7%     -21.1%      96217 ±  6%  interrupts.CPU84.RES:Rescheduling_interrupts
> > >       8883           +10.6%       9822 ±  2%  interrupts.CPU85.CAL:Function_call_interrupts
> > >     115045 ±  6%     -16.3%      96249 ±  4%  interrupts.CPU85.RES:Rescheduling_interrupts
> > >       8668 ±  3%     +12.6%       9762        interrupts.CPU86.CAL:Function_call_interrupts
> > >       8579 ±  3%     +14.3%       9806 ±  2%  interrupts.CPU87.CAL:Function_call_interrupts
> > >       8719 ±  2%     +12.4%       9797 ±  2%  interrupts.CPU88.CAL:Function_call_interrupts
> > >       8769           +11.6%       9788 ±  2%  interrupts.CPU89.CAL:Function_call_interrupts
> > >     131248 ±  9%     -27.5%      95130 ±  9%  interrupts.CPU9.RES:Rescheduling_interrupts
> > >       8766           +11.6%       9780 ±  2%  interrupts.CPU90.CAL:Function_call_interrupts
> > >     121573 ±  6%     -14.4%     104044 ±  8%  interrupts.CPU90.RES:Rescheduling_interrupts
> > >       8762           +11.5%       9768 ±  2%  interrupts.CPU91.CAL:Function_call_interrupts
> > >     125741 ±  6%     -21.2%      99116 ± 10%  interrupts.CPU91.RES:Rescheduling_interrupts
> > >       8764           +11.3%       9754 ±  2%  interrupts.CPU92.CAL:Function_call_interrupts
> > >     125340 ±  7%     -21.1%      98921 ±  6%  interrupts.CPU92.RES:Rescheduling_interrupts
> > >       8620 ±  4%     +13.0%       9743 ±  2%  interrupts.CPU93.CAL:Function_call_interrupts
> > >     129358 ± 10%     -25.0%      97082 ±  6%  interrupts.CPU93.RES:Rescheduling_interrupts
> > >       8753           +11.2%       9730 ±  2%  interrupts.CPU94.CAL:Function_call_interrupts
> > >       8750           +11.1%       9719 ±  2%  interrupts.CPU95.CAL:Function_call_interrupts
> > >     115441 ±  6%     -15.6%      97484 ±  8%  interrupts.CPU95.RES:Rescheduling_interrupts
> > >     121213 ±  5%     -17.0%     100662 ± 12%  interrupts.CPU99.RES:Rescheduling_interrupts
> > >   12650754 ±  3%     -14.8%   10783909        interrupts.RES:Rescheduling_interrupts
> > >     176.50 ± 59%     -79.7%      35.75 ± 47%  interrupts.TLB:TLB_shootdowns
> > >      10.98           -11.0        0.00        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
> > >      10.70           -10.7        0.00        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
> > >      10.29           -10.3        0.00        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
> > >      10.20           -10.2        0.00        perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
> > >       9.82            -9.8        0.00        perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack
> > >       9.68            -9.7        0.00        perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue
> > >      21.27            -6.8       14.52        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      21.18            -6.7       14.46        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      20.54            -6.5       14.04        perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      20.43            -6.5       13.96        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
> > >      16.41            -3.1       13.34        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
> > >      16.22            -3.0       13.21        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       7.69            -2.2        5.51        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
> > >       7.67            -2.2        5.50        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> > >       6.75 ±  6%      -2.2        4.60 ±  2%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
> > >      13.64            -2.1       11.53        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> > >      13.43            -2.0       11.40        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
> > >       7.00            -2.0        5.04        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
> > >       6.83            -1.9        4.93        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg
> > >       6.70            -1.9        4.83        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
> > >       6.39 ±  3%      -1.9        4.53        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
> > >       5.43            -1.7        3.69        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
> > >       5.31            -1.7        3.59        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
> > >       5.68 ±  3%      -1.6        4.11 ±  2%  perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
> > >       4.76            -1.6        3.19        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> > >       4.84            -1.5        3.30        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> > >       4.56            -1.5        3.04        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg
> > >       5.51 ±  3%      -1.5        4.01 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
> > >       4.48            -1.5        2.99        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg
> > >       4.39            -1.5        2.92        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.wait_woken.sk_wait_data
> > >       5.36 ±  3%      -1.5        3.90 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
> > >       5.19 ±  3%      -1.4        3.78 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
> > >       4.37            -1.4        2.96        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg
> > >       2.14            -1.4        0.73        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
> > >      10.04            -1.4        8.65        perf-profile.calltrace.cycles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       2.08            -1.4        0.70        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
> > >       9.73            -1.3        8.42        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       9.56            -1.3        8.29        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg
> > >       3.73            -1.2        2.55        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg
> > >       3.78 ±  2%      -1.1        2.68        perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       1.86 ± 30%      -1.0        0.84 ±  4%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
> > >       3.46 ±  2%      -1.0        2.46        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       1.51 ±  6%      -0.9        0.61        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
> > >       3.22 ±  2%      -0.9        2.33        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
> > >       3.02 ±  2%      -0.8        2.21        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
> > >       1.78            -0.6        1.16        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout.wait_woken
> > >       7.18 ±  2%      -0.6        6.58 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >       7.16 ±  2%      -0.6        6.56 ±  2%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       1.37            -0.5        0.88        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       1.33            -0.5        0.84        perf-profile.calltrace.cycles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       1.29            -0.5        0.82        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       0.71            -0.5        0.25 ±100%  perf-profile.calltrace.cycles-pp.__sched_text_start.preempt_schedule_common._cond_resched.__release_sock.release_sock
> > >       1.20            -0.4        0.82        perf-profile.calltrace.cycles-pp.__switch_to
> > >       1.09            -0.4        0.72        perf-profile.calltrace.cycles-pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >       1.09            -0.3        0.77        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
> > >       6.42 ±  2%      -0.3        6.09 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
> > >       0.83            -0.3        0.56        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
> > >       0.84            -0.3        0.58 ±  3%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__sched_text_start.schedule.schedule_timeout.wait_woken
> > >       0.94            -0.3        0.68        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
> > >       0.74            -0.2        0.53        perf-profile.calltrace.cycles-pp._cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> > >       0.73            -0.2        0.52        perf-profile.calltrace.cycles-pp.preempt_schedule_common._cond_resched.__release_sock.release_sock.tcp_sendmsg
> > >       9.51            +0.7       10.17        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb
> > >       9.38            +0.7       10.08        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data
> > >      95.32            +1.4       96.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
> > >      95.16            +1.4       96.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      11.17            +7.3       18.47        perf-profile.calltrace.cycles-pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >      11.81 ±  2%      +7.4       19.18        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
> > >      11.74 ±  2%      +7.4       19.15        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
> > >      11.52 ±  2%      +7.5       18.98        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
> > >      11.55 ±  2%      +7.5       19.01        perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
> > >      11.27 ±  2%      +7.5       18.81        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
> > >      10.95 ±  2%      +7.6       18.55        perf-profile.calltrace.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq
> > >       9.28            +7.6       16.91        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim
> > >       9.39            +7.7       17.05        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb
> > >      10.83 ±  2%      +7.7       18.52        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
> > >       9.57            +7.7       17.27        perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked
> > >       9.94            +7.7       17.64        perf-profile.calltrace.cycles-pp.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >      10.49 ±  2%      +7.7       18.23        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack
> > >       9.73            +7.8       17.49        perf-profile.calltrace.cycles-pp.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
> > >      10.16 ±  2%      +7.8       17.98        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start
> > >       3.79            +8.0       11.77        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
> > >       3.78            +8.0       11.77        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
> > >       9.61 ±  2%      +8.0       17.61        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action
> > >       9.45 ±  2%      +8.1       17.50        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
> > >       9.40 ±  2%      +8.1       17.47        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
> > >       9.21 ±  2%      +8.1       17.35        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
> > >       3.44            +8.1       11.58        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
> > >       8.65 ±  2%      +8.2       16.88        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
> > >       3.21            +8.2       11.44        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
> > >      18.55 ±  2%      +8.6       27.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill
> > >      20.09 ±  2%      +8.6       28.68        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
> > >      19.87 ±  2%      +8.6       28.45        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
> > >      20.08 ±  2%      +8.6       28.67        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > >      18.74 ±  2%      +8.6       27.34        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill
> > >      19.94 ±  2%      +8.6       28.53        perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
> > >      72.24            +8.7       80.98        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      72.13            +8.8       80.91        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      71.52            +9.0       80.48        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >      71.18            +9.1       80.25        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
> > >       0.00           +10.3       10.29        perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_rcv
> > >       0.00           +10.4       10.41        perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu
> > >       0.00           +10.7       10.66        perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
> > >       0.00           +10.8       10.81        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
> > >      54.39           +12.2       66.64        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
> > >   31487988 ±  3%     -23.2%   24183132        softirqs.CPU0.NET_RX
> > >   32151929           -26.1%   23765617 ±  2%  softirqs.CPU1.NET_RX
> > >   31962684 ±  3%     -23.5%   24458409        softirqs.CPU10.NET_RX
> > >   31110228 ±  3%     -26.2%   22964939        softirqs.CPU100.NET_RX
> > >   31626866           -27.6%   22906397        softirqs.CPU101.NET_RX
> > >   29779153 ±  3%     -22.9%   22969929        softirqs.CPU102.NET_RX
> > >   31513116           -27.3%   22920216        softirqs.CPU103.NET_RX
> > >   31713243 ±  2%     -24.9%   23826688 ±  2%  softirqs.CPU11.NET_RX
> > >   32072474           -26.1%   23696606 ±  2%  softirqs.CPU12.NET_RX
> > >   32279430           -24.8%   24260634        softirqs.CPU13.NET_RX
> > >   31697375 ±  3%     -23.0%   24406003        softirqs.CPU14.NET_RX
> > >   32278026           -24.7%   24317293        softirqs.CPU15.NET_RX
> > >   31162122 ±  3%     -21.7%   24396540        softirqs.CPU16.NET_RX
> > >   32209863           -24.2%   24418327        softirqs.CPU17.NET_RX
> > >   32329002           -25.6%   24054387 ±  2%  softirqs.CPU18.NET_RX
> > >   32127509           -24.5%   24258223        softirqs.CPU19.NET_RX
> > >   32217120           -25.2%   24089001        softirqs.CPU2.NET_RX
> > >   31415502 ±  3%     -22.5%   24349881        softirqs.CPU20.NET_RX
> > >   32186243           -25.0%   24137967        softirqs.CPU21.NET_RX
> > >   32271735           -26.9%   23586468 ±  2%  softirqs.CPU22.NET_RX
> > >   31871656 ±  3%     -23.8%   24292511        softirqs.CPU23.NET_RX
> > >   32321894           -25.2%   24177260        softirqs.CPU24.NET_RX
> > >   31969188           -24.7%   24057006        softirqs.CPU25.NET_RX
> > >   30938777           -27.7%   22360933 ±  2%  softirqs.CPU26.NET_RX
> > >   30118051 ±  3%     -25.9%   22321500 ±  2%  softirqs.CPU27.NET_RX
> > >   31079253           -28.1%   22337317 ±  2%  softirqs.CPU28.NET_RX
> > >   31429166           -27.6%   22746093 ±  2%  softirqs.CPU29.NET_RX
> > >   30485045 ±  3%     -20.5%   24221128 ±  2%  softirqs.CPU3.NET_RX
> > >   30912223 ±  2%     -26.8%   22622183 ±  2%  softirqs.CPU30.NET_RX
> > >   31357027           -27.6%   22717601        softirqs.CPU31.NET_RX
> > >   31052178           -27.3%   22565776 ±  2%  softirqs.CPU32.NET_RX
> > >   31101262           -28.2%   22323348 ±  2%  softirqs.CPU33.NET_RX
> > >   31331660           -27.7%   22656208        softirqs.CPU34.NET_RX
> > >   30833278 ±  3%     -25.4%   22998777        softirqs.CPU35.NET_RX
> > >   30738161 ±  3%     -25.2%   22998898        softirqs.CPU36.NET_RX
> > >   30881460 ±  4%     -26.6%   22671426        softirqs.CPU37.NET_RX
> > >   31140748           -27.4%   22621903        softirqs.CPU38.NET_RX
> > >   31218654           -27.3%   22684067        softirqs.CPU39.NET_RX
> > >   32583070           -24.8%   24513384        softirqs.CPU4.NET_RX
> > >   31462139           -28.4%   22517351        softirqs.CPU40.NET_RX
> > >   31566697           -27.9%   22768461        softirqs.CPU41.NET_RX
> > >   30975279 ±  2%     -27.2%   22555119        softirqs.CPU42.NET_RX
> > >   30718280 ±  3%     -26.2%   22661320 ±  2%  softirqs.CPU43.NET_RX
> > >   31283332           -27.3%   22740697        softirqs.CPU44.NET_RX
> > >   30983467           -26.4%   22794814        softirqs.CPU45.NET_RX
> > >   30658730 ±  4%     -28.4%   21946934 ±  2%  softirqs.CPU46.NET_RX
> > >   31181856           -26.5%   22929226        softirqs.CPU47.NET_RX
> > >   31037938 ±  2%     -26.9%   22691892 ±  2%  softirqs.CPU48.NET_RX
> > >   30911500 ±  2%     -26.3%   22777693        softirqs.CPU49.NET_RX
> > >   31802923 ±  3%     -23.9%   24204592        softirqs.CPU5.NET_RX
> > >   31517206           -28.1%   22648510        softirqs.CPU50.NET_RX
> > >   30660453 ±  3%     -27.2%   22327925 ±  2%  softirqs.CPU51.NET_RX
> > >   31819962 ±  2%     -23.9%   24206194        softirqs.CPU52.NET_RX
> > >   32142649           -26.4%   23668373 ±  2%  softirqs.CPU53.NET_RX
> > >   32149559           -24.2%   24360340        softirqs.CPU54.NET_RX
> > >   32425853           -26.4%   23854082 ±  2%  softirqs.CPU55.NET_RX
> > >   31817157 ±  2%     -24.3%   24096785        softirqs.CPU56.NET_RX
> > >   31640490 ±  3%     -24.4%   23920278 ±  2%  softirqs.CPU57.NET_RX
> > >   31650729 ±  3%     -23.1%   24327421        softirqs.CPU58.NET_RX
> > >   31269148 ±  3%     -22.3%   24307789        softirqs.CPU59.NET_RX
> > >   31030416 ±  4%     -22.0%   24203694        softirqs.CPU6.NET_RX
> > >   32255424           -25.2%   24141973 ±  2%  softirqs.CPU60.NET_RX
> > >   32245715           -25.1%   24167151 ±  2%  softirqs.CPU61.NET_RX
> > >   31763163 ±  2%     -23.1%   24415760        softirqs.CPU62.NET_RX
> > >   31632095 ±  3%     -22.7%   24451397        softirqs.CPU63.NET_RX
> > >   31490930 ±  2%     -24.2%   23879322        softirqs.CPU64.NET_RX
> > >   31516754 ±  3%     -23.5%   24108737        softirqs.CPU65.NET_RX
> > >   32359236           -24.5%   24440756        softirqs.CPU66.NET_RX
> > >   31784935 ±  3%     -23.9%   24195033 ±  2%  softirqs.CPU67.NET_RX
> > >   30967426 ±  4%     -21.8%   24208434        softirqs.CPU68.NET_RX
> > >   32208978           -27.9%   23223363        softirqs.CPU69.NET_RX
> > >   31534273 ±  3%     -23.6%   24083955        softirqs.CPU7.NET_RX
> > >   31800791 ±  2%     -23.3%   24375677        softirqs.CPU70.NET_RX
> > >   31511220 ±  3%     -23.1%   24225232        softirqs.CPU71.NET_RX
> > >   32055308           -25.2%   23985501 ±  2%  softirqs.CPU72.NET_RX
> > >   32255683           -24.3%   24425926        softirqs.CPU73.NET_RX
> > >   31808226 ±  2%     -23.7%   24280351 ±  2%  softirqs.CPU74.NET_RX
> > >   31994746 ±  3%     -25.5%   23828432 ±  2%  softirqs.CPU75.NET_RX
> > >   31732779 ±  3%     -24.0%   24121773 ±  2%  softirqs.CPU76.NET_RX
> > >   31249558 ±  2%     -23.8%   23816726 ±  2%  softirqs.CPU77.NET_RX
> > >   29102709 ±  3%     -24.1%   22087804 ±  2%  softirqs.CPU78.NET_RX
> > >   31050911           -26.3%   22879670        softirqs.CPU79.NET_RX
> > >   32385972           -25.5%   24114907        softirqs.CPU8.NET_RX
> > >   31250746           -26.8%   22865137        softirqs.CPU80.NET_RX
> > >   30970512 ±  3%     -27.5%   22460428 ±  2%  softirqs.CPU81.NET_RX
> > >   30769035 ±  3%     -26.4%   22640114        softirqs.CPU82.NET_RX
> > >   31163906           -28.0%   22426881 ±  2%  softirqs.CPU83.NET_RX
> > >   30833151 ±  2%     -26.9%   22535706        softirqs.CPU84.NET_RX
> > >   31213448           -27.8%   22530613 ±  2%  softirqs.CPU85.NET_RX
> > >   31299014           -27.8%   22598945 ±  2%  softirqs.CPU86.NET_RX
> > >   31380574           -26.8%   22966556        softirqs.CPU87.NET_RX
> > >   31419156           -26.9%   22966072        softirqs.CPU88.NET_RX
> > >   31485946           -29.0%   22360125 ±  2%  softirqs.CPU89.NET_RX
> > >   32266157           -25.9%   23914440 ±  2%  softirqs.CPU9.NET_RX
> > >   30336933 ±  3%     -25.9%   22489963        softirqs.CPU90.NET_RX
> > >   30595348 ±  3%     -26.1%   22614928        softirqs.CPU91.NET_RX
> > >   30924249 ±  2%     -26.0%   22894665        softirqs.CPU92.NET_RX
> > >   30593902 ±  2%     -24.8%   23001426        softirqs.CPU93.NET_RX
> > >   31556110           -29.2%   22330354 ±  2%  softirqs.CPU94.NET_RX
> > >   30668287 ±  3%     -29.0%   21759470        softirqs.CPU95.NET_RX
> > >   31245897           -26.9%   22847267        softirqs.CPU96.NET_RX
> > >   31136421           -28.7%   22213048 ±  2%  softirqs.CPU97.NET_RX
> > >   30013471 ±  4%     -23.9%   22844117        softirqs.CPU98.NET_RX
> > >   31291344           -28.5%   22378868 ±  2%  softirqs.CPU99.NET_RX
> > >  3.269e+09           -25.6%  2.431e+09        softirqs.NET_RX
> > >
> > >
> > >
> > >
> > >
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are provided
> > > for informational purposes only. Any difference in system hardware or software
> > > design or configuration may affect actual performance.
> > >
> > >
> > > Thanks,
> > > Rong Chen
> > >
