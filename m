Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5F3C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1F8256BC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crTKnWtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfE3MV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:21:57 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46691 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3MV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:21:57 -0400
Received: by mail-yb1-f194.google.com with SMTP id p8so2065594ybo.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NnsaH28rSkNhM9OfhrPBidJOtlqfRkKKRilA563pxwY=;
        b=crTKnWtveZx2uXebNTQhcZyiArda4wlvCuh8tMcgKRMqIf3cLn2DsZq26llk3WMjUA
         k0YFezZWKgLSTOWGkyV0lp+0+bIT16r5rpOw+olkmaQQwpITOXyWRon5MQMRIp3IatY6
         VuamzuPrx3fnpT1YGpkC4Js/NZuXDD5gXtcaDc+JpvEEy1xymJ2vRO/S3GBezvshufwd
         FJYwoFa+p9slboqqKGLHJ2R3oll9C0Z0tgmA+YB0uPHZx93mGmKNZkY3lKAc6Bv5k9mD
         RQV7Y11QaTHPlErflfS7GgTsbvjTzk0NbqlZaumbMwdHK2qqOCsNiD+MILlGKZ/3k9tN
         kfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NnsaH28rSkNhM9OfhrPBidJOtlqfRkKKRilA563pxwY=;
        b=lS+ZTzhEGYq8bEpTlFQ/sOsqr9J8/iTa9EuHvyMomUfz8VJRC28P3S+Km2d67yLHgS
         y46qScMfckbbt+ThFuZQ1LnqbY5JoYyR+jDAWqo/Pnr5sp6k+sZYxyqEzBcCO86ka6vK
         9GHOfhS0fsJe7nbYi2FdsfP3rGvWfeI+mX/tl3GicKx0owxu688j3yL1B9qVWO3blc9R
         NFccjCDXbY3rEBT3i92C/xcvy/nC4YbKBPjHj4hFTrZtd7nAoh8+wfWftQCNl35Ma6QO
         uhcdCLAe1G8Y0DnmxyB8AyJBB3sAD7ir3eD/2KkrfSJg3kcDslxpqNrmtFRtIZIue/ws
         vI9w==
X-Gm-Message-State: APjAAAXosZMnGCC5hw9jg8btdgZ0BypPYQmM5UYeOMe22PWkGNyxL23t
        9S2Q8sJzdaScWQO8g9X4JOI31mosL0wBUZddOZ4XYbJ5gr0=
X-Google-Smtp-Source: APXvYqyF/ukWLXnnYAWemeI3R+wowhSCVbDr0eEAJXKAuSVkd/yQXPjwlquSyTzWNF2K9UX/9COYkWzF1ozZUdFwWZE=
X-Received: by 2002:a25:55d7:: with SMTP id j206mr1574481ybb.234.1559218912454;
 Thu, 30 May 2019 05:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190403063436.GG20952@shao2-debian> <20190530103048.hfld4t4m37jsg4yo@shbuild888>
In-Reply-To: <20190530103048.hfld4t4m37jsg4yo@shbuild888>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 May 2019 05:21:40 -0700
Message-ID: <CANn89iL4TYBYVnRhzVAH8UXSptStnYkZ+Rq3swzsMWngRJmGCA@mail.gmail.com>
Subject: Re: [LKP] [tcp] 8b27dae5a2: netperf.Throughput_Mbps -25.7% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>, "lkp@01.org" <lkp@01.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 3:31 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Wed, Apr 03, 2019 at 02:34:36PM +0800, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a -25.7% regression of netperf.Throughput_Mbps due to c=
ommit:
> >
> >
> > commit: 8b27dae5a2e89a61c46c6dbc76c040c0e6d0ed4c ("tcp: add one skb cac=
he for rx")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> Hi Eric,
>
> Could you help to check this? thanks,
>

Hmmm... patch is old and had some bugs that have been fixed.

What numbers do you have with more recent kernels ?



> - Feng
>
>
> >
> > in testcase: netperf
> > on test machine: 104 threads Skylake with 192G memory
> > with following parameters:
> >
> >       ip: ipv4
> >       runtime: 900s
> >       nr_threads: 200%
> >       cluster: cs-localhost
> >       test: TCP_STREAM
> >       cpufreq_governor: performance
> >
> > test-description: Netperf is a benchmark that can be use to measure var=
ious aspect of networking performance.
> > test-url: http://www.netperf.org/netperf/
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+---------------------------------------------------=
-+
> > | testcase: change | netperf: netperf.Throughput_Mbps -25.6% regression=
 |
> > | test machine     | 104 threads Skylake with 192G memory              =
 |
> > | test parameters  | cluster=3Dcs-localhost                            =
   |
> > |                  | cpufreq_governor=3Dperformance                    =
   |
> > |                  | ip=3Dipv4                                         =
   |
> > |                  | nr_threads=3D200%                                 =
   |
> > |                  | runtime=3D900s                                    =
   |
> > |                  | test=3DTCP_MAERTS                                 =
   |
> > +------------------+---------------------------------------------------=
-+
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/=
tbox_group/test/testcase:
> >   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.6/200%/debian-x86_6=
4-2018-04-03.cgz/900s/lkp-skl-fpga01/TCP_STREAM/netperf
> >
> > commit:
> >   472c2e07ee ("tcp: add one skb cache for tx")
> >   8b27dae5a2 ("tcp: add one skb cache for rx")
> >
> > 472c2e07eef04514 8b27dae5a2e89a61c46c6dbc76c
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >           1:4          -25%            :4     dmesg.WARNING:at#for_ip_i=
nterrupt_entry/0x
> >            :4           25%           1:4     dmesg.WARNING:at_ip_ip_fi=
nish_output2/0x
> >          %stddev     %change         %stddev
> >              \          |                \
> >       3939           -25.7%       2925        netperf.Throughput_Mbps
> >     819330           -25.7%     608425        netperf.Throughput_total_=
Mbps
> >  3.725e+09           -25.8%  2.764e+09        netperf.time.involuntary_=
context_switches
> >       7399            -1.8%       7266        netperf.time.percent_of_c=
pu_this_job_got
> >      65271            -1.0%      64597        netperf.time.system_time
> >       1529           -34.0%       1009        netperf.time.user_time
> >  5.626e+09           -25.7%  4.178e+09        netperf.workload
> >      12.36 =C2=B1  4%      +6.5       18.84        mpstat.cpu.all.soft%
> >       2.95 =C2=B1  2%      -0.8        2.15        mpstat.cpu.all.usr%
> >  9.557e+08           +13.2%  1.082e+09        numa-numastat.node0.local=
_node
> >  9.557e+08           +13.2%  1.082e+09        numa-numastat.node0.numa_=
hit
> >  4.845e+08 =C2=B1  2%     +11.6%  5.407e+08        numa-vmstat.node0.nu=
ma_hit
> >  4.845e+08 =C2=B1  2%     +11.6%  5.406e+08        numa-vmstat.node0.nu=
ma_local
> >       2662 =C2=B1  2%      +4.2%       2774        turbostat.Avg_MHz
> >       1.87 =C2=B1 86%     -66.1%       0.63 =C2=B1  9%  turbostat.CPU%c=
1
> >      94.75 =C2=B1  2%      +2.4%      97.00        vmstat.cpu.sy
> >    8145843 =C2=B1  2%     -24.7%    6134835        vmstat.system.cs
> >     224329            -0.8%     222470        vmstat.system.in
> >  1.884e+09           +10.9%   2.09e+09        proc-vmstat.numa_hit
> >  1.884e+09           +10.9%  2.089e+09        proc-vmstat.numa_local
> >  1.506e+10           +10.9%  1.671e+10        proc-vmstat.pgalloc_norma=
l
> >  1.506e+10           +10.9%  1.671e+10        proc-vmstat.pgfree
> >       2104 =C2=B1  8%     +86.4%       3922 =C2=B1 58%  sched_debug.cpu=
.avg_idle.min
> >   35810547           -25.7%   26600377        sched_debug.cpu.nr_switch=
es.avg
> >   37423347           -25.1%   28047296        sched_debug.cpu.nr_switch=
es.max
> >   32860210           -25.5%   24491190        sched_debug.cpu.nr_switch=
es.min
> >     968.00 =C2=B1  4%     -18.2%     792.00 =C2=B1  7%  slabinfo.kmallo=
c-rcl-128.active_objs
> >     968.00 =C2=B1  4%     -18.2%     792.00 =C2=B1  7%  slabinfo.kmallo=
c-rcl-128.num_objs
> >      16611 =C2=B1  2%      +6.1%      17628 =C2=B1  4%  slabinfo.skbuff=
_fclone_cache.active_objs
> >      16827 =C2=B1  2%      +5.7%      17794 =C2=B1  4%  slabinfo.skbuff=
_fclone_cache.num_objs
> >      18.78 =C2=B1  5%     +28.9%      24.21        perf-stat.i.MPKI
> >  1.942e+10 =C2=B1  2%     -21.1%  1.531e+10        perf-stat.i.branch-i=
nstructions
> >       2.08 =C2=B1  6%      -0.1        1.97        perf-stat.i.branch-m=
iss-rate%
> >  3.892e+08 =C2=B1  2%     -22.6%  3.014e+08        perf-stat.i.branch-m=
isses
> >  1.767e+09 =C2=B1  2%      +4.3%  1.842e+09        perf-stat.i.cache-re=
ferences
> >    8171306 =C2=B1  2%     -24.7%    6151961        perf-stat.i.context-=
switches
> >       2.88 =C2=B1  2%     +31.0%       3.78        perf-stat.i.cpi
> >  2.761e+11 =C2=B1  2%      +4.2%  2.876e+11        perf-stat.i.cpu-cycl=
es
> >       1.10 =C2=B1  3%      -0.1        0.97        perf-stat.i.dTLB-loa=
d-miss-rate%
> >  3.254e+08 =C2=B1  4%     -32.1%  2.208e+08        perf-stat.i.dTLB-loa=
d-misses
> >  2.893e+10 =C2=B1  2%     -21.9%   2.26e+10        perf-stat.i.dTLB-loa=
ds
> >   58990104 =C2=B1  5%     -25.8%   43766302        perf-stat.i.dTLB-sto=
re-misses
> >  1.658e+10 =C2=B1  2%     -23.6%  1.266e+10        perf-stat.i.dTLB-sto=
res
> >      55.76            -3.4       52.34        perf-stat.i.iTLB-load-mis=
s-rate%
> >   63191122 =C2=B1  2%     -29.1%   44815478        perf-stat.i.iTLB-loa=
d-misses
> >   49413835 =C2=B1  2%     -17.7%   40661018        perf-stat.i.iTLB-loa=
ds
> >  9.688e+10 =C2=B1  2%     -21.5%  7.605e+10        perf-stat.i.instruct=
ions
> >       1607 =C2=B1  3%      +8.1%       1737        perf-stat.i.instruct=
ions-per-iTLB-miss
> >       0.35           -24.3%       0.27        perf-stat.i.ipc
> >      86243 =C2=B1 29%     +52.4%     131400 =C2=B1 18%  perf-stat.i.nod=
e-stores
> >      18.24           +32.8%      24.23        perf-stat.overall.MPKI
> >       2.00            -0.0        1.97        perf-stat.overall.branch-=
miss-rate%
> >       2.85           +32.7%       3.78        perf-stat.overall.cpi
> >       1.11 =C2=B1  3%      -0.1        0.97        perf-stat.overall.dT=
LB-load-miss-rate%
> >      56.12            -3.7       52.43        perf-stat.overall.iTLB-lo=
ad-miss-rate%
> >       1533 =C2=B1  2%     +10.7%       1697        perf-stat.overall.in=
structions-per-iTLB-miss
> >       0.35           -24.6%       0.26        perf-stat.overall.ipc
> >      15748            +4.3%      16430        perf-stat.overall.path-le=
ngth
> >  1.939e+10 =C2=B1  2%     -21.1%   1.53e+10        perf-stat.ps.branch-=
instructions
> >  3.887e+08 =C2=B1  2%     -22.5%  3.011e+08        perf-stat.ps.branch-=
misses
> >  1.764e+09 =C2=B1  2%      +4.3%   1.84e+09        perf-stat.ps.cache-r=
eferences
> >    8161286 =C2=B1  2%     -24.7%    6144845        perf-stat.ps.context=
-switches
> >  2.757e+11 =C2=B1  2%      +4.2%  2.872e+11        perf-stat.ps.cpu-cyc=
les
> >   3.25e+08 =C2=B1  4%     -32.1%  2.206e+08        perf-stat.ps.dTLB-lo=
ad-misses
> >  2.889e+10 =C2=B1  2%     -21.8%  2.258e+10        perf-stat.ps.dTLB-lo=
ads
> >   58916703 =C2=B1  5%     -25.8%   43714633        perf-stat.ps.dTLB-st=
ore-misses
> >  1.656e+10 =C2=B1  2%     -23.6%  1.265e+10        perf-stat.ps.dTLB-st=
ores
> >   63112575 =C2=B1  2%     -29.1%   44762927        perf-stat.ps.iTLB-lo=
ad-misses
> >   49353553 =C2=B1  2%     -17.7%   40614004        perf-stat.ps.iTLB-lo=
ads
> >  9.676e+10 =C2=B1  2%     -21.5%  7.596e+10        perf-stat.ps.instruc=
tions
> >      86182 =C2=B1 29%     +52.3%     131291 =C2=B1 18%  perf-stat.ps.no=
de-stores
> >   8.86e+13           -22.5%  6.864e+13        perf-stat.total.instructi=
ons
> >     136251 =C2=B1  8%     -18.5%     110991 =C2=B1 10%  interrupts.CPU1=
.RES:Rescheduling_interrupts
> >     128756 =C2=B1  3%     -18.6%     104869 =C2=B1  6%  interrupts.CPU1=
0.RES:Rescheduling_interrupts
> >     119826 =C2=B1  6%     -12.1%     105329 =C2=B1  4%  interrupts.CPU1=
00.RES:Rescheduling_interrupts
> >     121133 =C2=B1 10%     -17.9%      99457        interrupts.CPU101.RE=
S:Rescheduling_interrupts
> >       9051 =C2=B1  3%     +14.1%      10328        interrupts.CPU102.CA=
L:Function_call_interrupts
> >     131446 =C2=B1  7%     -17.8%     108104 =C2=B1  9%  interrupts.CPU1=
02.RES:Rescheduling_interrupts
> >     124627 =C2=B1  2%     -16.6%     103971 =C2=B1  9%  interrupts.CPU1=
2.RES:Rescheduling_interrupts
> >     131072 =C2=B1 11%     -19.9%     105033 =C2=B1  4%  interrupts.CPU1=
3.RES:Rescheduling_interrupts
> >     127845 =C2=B1  8%     -17.0%     106112 =C2=B1  9%  interrupts.CPU1=
4.RES:Rescheduling_interrupts
> >     126159 =C2=B1 10%     -20.6%     100111 =C2=B1 11%  interrupts.CPU1=
5.RES:Rescheduling_interrupts
> >     132232 =C2=B1  5%     -17.9%     108535 =C2=B1  7%  interrupts.CPU1=
7.RES:Rescheduling_interrupts
> >     127157 =C2=B1  4%     -17.3%     105165 =C2=B1 11%  interrupts.CPU1=
8.RES:Rescheduling_interrupts
> >     127948 =C2=B1  2%     -15.5%     108165 =C2=B1 11%  interrupts.CPU1=
9.RES:Rescheduling_interrupts
> >     122716 =C2=B1  6%     -14.0%     105519 =C2=B1 11%  interrupts.CPU2=
3.RES:Rescheduling_interrupts
> >     130754 =C2=B1  5%     -20.3%     104222 =C2=B1  9%  interrupts.CPU2=
4.RES:Rescheduling_interrupts
> >     126283 =C2=B1  4%     -16.6%     105320 =C2=B1  6%  interrupts.CPU2=
7.RES:Rescheduling_interrupts
> >       8997 =C2=B1  3%     -12.4%       7883 =C2=B1  9%  interrupts.CPU2=
8.CAL:Function_call_interrupts
> >     128467 =C2=B1  5%     -20.9%     101674 =C2=B1 11%  interrupts.CPU2=
9.RES:Rescheduling_interrupts
> >     133914 =C2=B1  6%     -26.0%      99089 =C2=B1 10%  interrupts.CPU3=
.RES:Rescheduling_interrupts
> >       8987 =C2=B1  3%     -11.9%       7922 =C2=B1  7%  interrupts.CPU3=
1.CAL:Function_call_interrupts
> >     115389 =C2=B1  9%     -17.7%      94962 =C2=B1  5%  interrupts.CPU3=
1.RES:Rescheduling_interrupts
> >       8830 =C2=B1  5%     -12.1%       7759 =C2=B1  4%  interrupts.CPU3=
2.CAL:Function_call_interrupts
> >     134198 =C2=B1  6%     -19.6%     107954 =C2=B1  6%  interrupts.CPU3=
3.RES:Rescheduling_interrupts
> >       8940 =C2=B1  3%      -8.8%       8154 =C2=B1  4%  interrupts.CPU3=
4.CAL:Function_call_interrupts
> >     123678 =C2=B1 12%     -17.1%     102582 =C2=B1  2%  interrupts.CPU3=
4.RES:Rescheduling_interrupts
> >       8969 =C2=B1  3%      -9.2%       8143 =C2=B1  4%  interrupts.CPU3=
5.CAL:Function_call_interrupts
> >     118372 =C2=B1  8%     -10.9%     105507 =C2=B1  9%  interrupts.CPU3=
5.RES:Rescheduling_interrupts
> >       8958 =C2=B1  3%      -9.2%       8131 =C2=B1  4%  interrupts.CPU3=
6.CAL:Function_call_interrupts
> >     132196 =C2=B1  3%     -16.2%     110761 =C2=B1  7%  interrupts.CPU4=
.RES:Rescheduling_interrupts
> >     123005 =C2=B1  6%     -17.2%     101838 =C2=B1  3%  interrupts.CPU4=
0.RES:Rescheduling_interrupts
> >     132802 =C2=B1 15%     -23.6%     101521 =C2=B1 11%  interrupts.CPU4=
3.RES:Rescheduling_interrupts
> >     131107 =C2=B1  4%     -25.6%      97566 =C2=B1  3%  interrupts.CPU4=
4.RES:Rescheduling_interrupts
> >     127673 =C2=B1  8%     -24.0%      97028 =C2=B1  6%  interrupts.CPU4=
7.RES:Rescheduling_interrupts
> >     123709 =C2=B1  6%     -14.3%     106030 =C2=B1 12%  interrupts.CPU4=
8.RES:Rescheduling_interrupts
> >     123709 =C2=B1  7%     -12.4%     108355 =C2=B1  6%  interrupts.CPU4=
9.RES:Rescheduling_interrupts
> >     135382 =C2=B1  5%     -20.7%     107334 =C2=B1  3%  interrupts.CPU5=
1.RES:Rescheduling_interrupts
> >     130424 =C2=B1  4%     -17.4%     107704 =C2=B1  6%  interrupts.CPU5=
2.RES:Rescheduling_interrupts
> >     129234 =C2=B1  8%     -18.6%     105171 =C2=B1 10%  interrupts.CPU5=
3.RES:Rescheduling_interrupts
> >     131374 =C2=B1  6%     -18.8%     106699 =C2=B1  6%  interrupts.CPU5=
4.RES:Rescheduling_interrupts
> >     126141 =C2=B1 10%     -14.7%     107626 =C2=B1 11%  interrupts.CPU5=
7.RES:Rescheduling_interrupts
> >     133750 =C2=B1  9%     -19.9%     107102        interrupts.CPU6.RES:=
Rescheduling_interrupts
> >     119663 =C2=B1  5%     -16.7%      99633 =C2=B1  3%  interrupts.CPU6=
0.RES:Rescheduling_interrupts
> >     121078 =C2=B1  7%     -13.6%     104670 =C2=B1  9%  interrupts.CPU6=
1.RES:Rescheduling_interrupts
> >     121662 =C2=B1  5%     -15.3%     102992 =C2=B1 10%  interrupts.CPU6=
3.RES:Rescheduling_interrupts
> >     118130 =C2=B1  2%     -15.1%     100310 =C2=B1  5%  interrupts.CPU6=
5.RES:Rescheduling_interrupts
> >     128075 =C2=B1  6%     -18.4%     104495 =C2=B1  8%  interrupts.CPU6=
7.RES:Rescheduling_interrupts
> >     124700 =C2=B1  6%     -15.7%     105149 =C2=B1  4%  interrupts.CPU6=
8.RES:Rescheduling_interrupts
> >     119607 =C2=B1  9%     -12.7%     104432 =C2=B1  6%  interrupts.CPU7=
.RES:Rescheduling_interrupts
> >     119288 =C2=B1  4%     -11.8%     105251 =C2=B1  6%  interrupts.CPU7=
1.RES:Rescheduling_interrupts
> >     125678 =C2=B1  7%     -18.7%     102141 =C2=B1  8%  interrupts.CPU7=
2.RES:Rescheduling_interrupts
> >     130174 =C2=B1  5%     -19.8%     104394 =C2=B1  3%  interrupts.CPU7=
4.RES:Rescheduling_interrupts
> >       9215 =C2=B1  2%      +9.8%      10119 =C2=B1  4%  interrupts.CPU7=
6.CAL:Function_call_interrupts
> >     113784 =C2=B1  8%     -10.6%     101686 =C2=B1  7%  interrupts.CPU7=
8.RES:Rescheduling_interrupts
> >     122103 =C2=B1  5%     -16.2%     102305 =C2=B1  5%  interrupts.CPU7=
9.RES:Rescheduling_interrupts
> >     122242 =C2=B1  3%     -23.8%      93153 =C2=B1  8%  interrupts.CPU8=
1.RES:Rescheduling_interrupts
> >       9154 =C2=B1  3%     +10.3%      10092 =C2=B1  4%  interrupts.CPU8=
2.CAL:Function_call_interrupts
> >     116414 =C2=B1  3%     -18.8%      94476 =C2=B1  9%  interrupts.CPU8=
2.RES:Rescheduling_interrupts
> >     128558 =C2=B1 12%     -24.5%      97067 =C2=B1  2%  interrupts.CPU8=
3.RES:Rescheduling_interrupts
> >       9147 =C2=B1  3%     +10.2%      10078 =C2=B1  4%  interrupts.CPU8=
4.CAL:Function_call_interrupts
> >     122842 =C2=B1  9%     -19.8%      98521 =C2=B1  2%  interrupts.CPU8=
4.RES:Rescheduling_interrupts
> >       9081 =C2=B1  3%     +10.9%      10071 =C2=B1  4%  interrupts.CPU8=
5.CAL:Function_call_interrupts
> >       9130 =C2=B1  2%     +10.2%      10065 =C2=B1  4%  interrupts.CPU8=
6.CAL:Function_call_interrupts
> >       9068 =C2=B1  3%     +10.9%      10057 =C2=B1  5%  interrupts.CPU8=
7.CAL:Function_call_interrupts
> >       9068 =C2=B1  3%     +10.8%      10050 =C2=B1  5%  interrupts.CPU8=
8.CAL:Function_call_interrupts
> >     122119 =C2=B1  5%     -20.1%      97576 =C2=B1  3%  interrupts.CPU8=
8.RES:Rescheduling_interrupts
> >       9065 =C2=B1  3%     +12.8%      10223 =C2=B1  2%  interrupts.CPU8=
9.CAL:Function_call_interrupts
> >     124799 =C2=B1  6%     -20.4%      99390 =C2=B1  8%  interrupts.CPU8=
9.RES:Rescheduling_interrupts
> >     130362 =C2=B1  2%     -12.6%     113981 =C2=B1  5%  interrupts.CPU9=
.RES:Rescheduling_interrupts
> >       8902           +12.7%      10035 =C2=B1  5%  interrupts.CPU90.CAL=
:Function_call_interrupts
> >       9062 =C2=B1  3%     +10.7%      10028 =C2=B1  5%  interrupts.CPU9=
1.CAL:Function_call_interrupts
> >     119442 =C2=B1  8%     -24.1%      90611 =C2=B1  2%  interrupts.CPU9=
1.RES:Rescheduling_interrupts
> >       9058 =C2=B1  3%     +10.7%      10023 =C2=B1  5%  interrupts.CPU9=
2.CAL:Function_call_interrupts
> >     117081 =C2=B1 10%     -21.2%      92294 =C2=B1 12%  interrupts.CPU9=
2.RES:Rescheduling_interrupts
> >       9058 =C2=B1  3%     +10.6%      10017 =C2=B1  5%  interrupts.CPU9=
3.CAL:Function_call_interrupts
> >     130977 =C2=B1 17%     -27.7%      94702 =C2=B1  6%  interrupts.CPU9=
4.RES:Rescheduling_interrupts
> >       9055 =C2=B1  3%     +10.5%      10003 =C2=B1  5%  interrupts.CPU9=
5.CAL:Function_call_interrupts
> >     116952 =C2=B1  4%     -12.4%     102488 =C2=B1 10%  interrupts.CPU9=
5.RES:Rescheduling_interrupts
> >       9054 =C2=B1  3%     +10.4%       9995 =C2=B1  5%  interrupts.CPU9=
6.CAL:Function_call_interrupts
> >       9054 =C2=B1  3%     +10.3%       9990 =C2=B1  5%  interrupts.CPU9=
7.CAL:Function_call_interrupts
> >     118634 =C2=B1  5%     -12.7%     103578 =C2=B1  9%  interrupts.CPU9=
8.RES:Rescheduling_interrupts
> >     116356 =C2=B1 10%     -16.5%      97115 =C2=B1  7%  interrupts.CPU9=
9.RES:Rescheduling_interrupts
> >   12787758 =C2=B1  2%     -14.8%   10896246        interrupts.RES:Resch=
eduling_interrupts
> >      10.84           -10.8        0.00        perf-profile.calltrace.cy=
cles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_so=
ck
> >      10.56           -10.6        0.00        perf-profile.calltrace.cy=
cles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__rel=
ease_sock
> >      10.16           -10.2        0.00        perf-profile.calltrace.cy=
cles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_=
do_rcv
> >      10.07           -10.1        0.00        perf-profile.calltrace.cy=
cles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_es=
tablished
> >       9.71            -9.7        0.00        perf-profile.calltrace.cy=
cles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tc=
p_ack
> >       9.57            -9.6        0.00        perf-profile.calltrace.cy=
cles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clea=
n_rtx_queue
> >      21.28            -6.8       14.49        perf-profile.calltrace.cy=
cles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      21.19            -6.8       14.43        perf-profile.calltrace.cy=
cles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
> >      20.57            -6.6       14.00        perf-profile.calltrace.cy=
cles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
> >      20.46            -6.5       13.93        perf-profile.calltrace.cy=
cles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_sysca=
ll_64
> >      16.37            -3.0       13.34        perf-profile.calltrace.cy=
cles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
> >      16.18            -3.0       13.21        perf-profile.calltrace.cy=
cles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
> >       7.01 =C2=B1  4%      -2.4        4.61        perf-profile.calltra=
ce.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deli=
ver_finish.ip_local_deliver
> >       6.90 =C2=B1  5%      -2.4        4.54        perf-profile.calltra=
ce.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliv=
er_rcu.ip_local_deliver_finish
> >       7.71 =C2=B1  2%      -2.2        5.51        perf-profile.calltra=
ce.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom=
.__x64_sys_recvfrom
> >       7.69 =C2=B1  2%      -2.2        5.49        perf-profile.calltra=
ce.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_re=
cvmsg.__sys_recvfrom
> >       6.19 =C2=B1  5%      -2.1        4.10        perf-profile.calltra=
ce.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv=
.ip_protocol_deliver_rcu
> >       6.04 =C2=B1  5%      -2.0        4.00        perf-profile.calltra=
ce.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tc=
p_v4_do_rcv.tcp_v4_rcv
> >       5.89 =C2=B1  6%      -2.0        3.90        perf-profile.calltra=
ce.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_r=
cv_established.tcp_v4_do_rcv
> >       7.03 =C2=B1  2%      -2.0        5.04        perf-profile.calltra=
ce.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_r=
ecvmsg.inet_recvmsg
> >       5.71 =C2=B1  6%      -1.9        3.78        perf-profile.calltra=
ce.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def=
_readable.tcp_rcv_established
> >      13.46            -1.9       11.54        perf-profile.calltrace.cy=
cles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> >       6.86 =C2=B1  2%      -1.9        4.93        perf-profile.calltra=
ce.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_it=
er.tcp_recvmsg
> >       6.72 =C2=B1  2%      -1.9        4.83 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__sk=
b_datagram_iter.skb_copy_datagram_iter
> >      13.26            -1.8       11.41        perf-profile.calltrace.cy=
cles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_s=
endmsg
> >       5.49            -1.8        3.67        perf-profile.calltrace.cy=
cles-pp.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recv=
from
> >       2.62 =C2=B1 14%      -1.8        0.82 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wak=
e_up_common_lock.sock_def_readable
> >       5.29            -1.7        3.61        perf-profile.calltrace.cy=
cles-pp.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sy=
s_recvfrom
> >       4.80            -1.6        3.17        perf-profile.calltrace.cy=
cles-pp.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> >       4.59            -1.6        3.02        perf-profile.calltrace.cy=
cles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg
> >       4.50            -1.5        2.96        perf-profile.calltrace.cy=
cles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg
> >       4.41            -1.5        2.90        perf-profile.calltrace.cy=
cles-pp.__sched_text_start.schedule.schedule_timeout.wait_woken.sk_wait_dat=
a
> >       4.81            -1.5        3.31        perf-profile.calltrace.cy=
cles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_r=
ecvfrom
> >      10.13            -1.5        8.63        perf-profile.calltrace.cy=
cles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__=
sys_sendto
> >       9.79            -1.4        8.36        perf-profile.calltrace.cy=
cles-pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sen=
dmsg
> >       2.14            -1.4        0.73        perf-profile.calltrace.cy=
cles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_l=
ock.sock_def_readable
> >       4.34            -1.4        2.96        perf-profile.calltrace.cy=
cles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvm=
sg
> >       9.60            -1.4        8.23        perf-profile.calltrace.cy=
cles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_send=
msg_locked.tcp_sendmsg
> >       2.10 =C2=B1 34%      -1.4        0.73 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__=
wake_up_common.__wake_up_common_lock
> >       2.08            -1.4        0.71        perf-profile.calltrace.cy=
cles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.=
__wake_up_common_lock
> >       3.88 =C2=B1  2%      -1.2        2.71        perf-profile.calltra=
ce.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__s=
ys_sendto
> >       3.71            -1.2        2.55        perf-profile.calltrace.cy=
cles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_=
recvmsg
> >       3.56 =C2=B1  2%      -1.1        2.49        perf-profile.calltra=
ce.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendm=
sg.sock_sendmsg
> >       3.32 =C2=B1  2%      -1.0        2.34        perf-profile.calltra=
ce.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_=
locked.tcp_sendmsg
> >       1.56            -0.9        0.61 =C2=B1  2%  perf-profile.calltra=
ce.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit._=
_tcp_transmit_skb
> >       3.14 =C2=B1  2%      -0.9        2.22        perf-profile.calltra=
ce.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tc=
p_sendmsg_locked
> >       1.77            -0.6        1.16        perf-profile.calltrace.cy=
cles-pp.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout.wait=
_woken
> >       7.43 =C2=B1  2%      -0.6        6.87        perf-profile.calltra=
ce.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_=
sendmsg.__sys_sendto
> >       7.41 =C2=B1  2%      -0.6        6.85        perf-profile.calltra=
ce.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tc=
p_sendmsg.sock_sendmsg
> >       1.39            -0.5        0.87        perf-profile.calltrace.cy=
cles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.34            -0.5        0.84        perf-profile.calltrace.cy=
cles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after=
_hwframe
> >       1.30            -0.5        0.81        perf-profile.calltrace.cy=
cles-pp.__sched_text_start.schedule.exit_to_usermode_loop.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
> >       1.09            -0.4        0.72        perf-profile.calltrace.cy=
cles-pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock=
_sendmsg
> >       1.20            -0.4        0.84        perf-profile.calltrace.cy=
cles-pp.__switch_to
> >       1.09            -0.3        0.76        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64
> >       6.67 =C2=B1  2%      -0.3        6.38        perf-profile.calltra=
ce.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tc=
p_sendmsg_locked.tcp_sendmsg
> >       0.83            -0.3        0.56        perf-profile.calltrace.cy=
cles-pp.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_l=
ocked.tcp_sendmsg
> >       0.84            -0.3        0.57        perf-profile.calltrace.cy=
cles-pp.switch_mm_irqs_off.__sched_text_start.schedule.schedule_timeout.wai=
t_woken
> >       0.95            -0.3        0.69        perf-profile.calltrace.cy=
cles-pp.syscall_return_via_sysret
> >       0.75 =C2=B1  2%      -0.2        0.52        perf-profile.calltra=
ce.cycles-pp._cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sen=
dmsg
> >       0.73 =C2=B1  2%      -0.2        0.51        perf-profile.calltra=
ce.cycles-pp.preempt_schedule_common._cond_resched.__release_sock.release_s=
ock.tcp_sendmsg
> >       9.41            +1.1       10.47        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data.__kfr=
ee_skb
> >       9.29            +1.1       10.39        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__fre=
e_pages_ok.skb_release_data
> >      95.31            +1.4       96.67        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe
> >      95.15            +1.4       96.56        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      11.02            +7.2       18.20        perf-profile.calltrace.cy=
cles-pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__s=
ys_sendto
> >      12.28 =C2=B1  2%      +7.2       19.51        perf-profile.calltra=
ce.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xm=
it.__tcp_transmit_skb
> >      12.21 =C2=B1  2%      +7.3       19.47        perf-profile.calltra=
ce.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__=
ip_queue_xmit
> >      12.00 =C2=B1  2%      +7.3       19.34        perf-profile.calltra=
ce.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish=
_output2.ip_output
> >      11.98 =C2=B1  2%      +7.3       19.32        perf-profile.calltra=
ce.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__lo=
cal_bh_enable_ip.ip_finish_output2
> >      11.74 =C2=B1  2%      +7.4       19.14        perf-profile.calltra=
ce.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.d=
o_softirq.__local_bh_enable_ip
> >      11.43 =C2=B1  2%      +7.4       18.87        perf-profile.calltra=
ce.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_sof=
tirq_own_stack.do_softirq
> >      11.37 =C2=B1  2%      +7.5       18.83        perf-profile.calltra=
ce.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb=
.tcp_write_xmit
> >       9.15            +7.5       16.67        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__fre=
e_pages_ok.___pskb_trim
> >       9.26            +7.5       16.80        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim.sk_stream=
_alloc_skb
> >       9.43            +7.6       17.01        perf-profile.calltrace.cy=
cles-pp.free_one_page.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_=
sendmsg_locked
> >       9.79            +7.6       17.37        perf-profile.calltrace.cy=
cles-pp.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.soc=
k_sendmsg
> >      10.97 =C2=B1  2%      +7.6       18.56        perf-profile.calltra=
ce.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__s=
oftirqentry_text_start.do_softirq_own_stack
> >       9.59            +7.6       17.22        perf-profile.calltrace.cy=
cles-pp.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked=
.tcp_sendmsg
> >      10.64 =C2=B1  3%      +7.7       18.30        perf-profile.calltra=
ce.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_act=
ion.__softirqentry_text_start
> >      10.11 =C2=B1  3%      +7.8       17.94        perf-profile.calltra=
ce.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_b=
acklog.net_rx_action
> >       9.96 =C2=B1  3%      +7.9       17.82        perf-profile.calltra=
ce.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receiv=
e_skb_one_core.process_backlog
> >       3.91 =C2=B1  2%      +7.9       11.79        perf-profile.calltra=
ce.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__=
release_sock.release_sock
> >       3.91 =C2=B1  2%      +7.9       11.79        perf-profile.calltra=
ce.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.t=
cp_v4_do_rcv.__release_sock
> >       9.90 =C2=B1  3%      +7.9       17.79        perf-profile.calltra=
ce.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliv=
er.ip_rcv.__netif_receive_skb_one_core
> >       9.71 =C2=B1  3%      +8.0       17.67        perf-profile.calltra=
ce.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_=
local_deliver.ip_rcv
> >       3.58 =C2=B1  2%      +8.0       11.60        perf-profile.calltra=
ce.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tc=
p_rcv_established.tcp_v4_do_rcv
> >       3.34 =C2=B1  2%      +8.1       11.45        perf-profile.calltra=
ce.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_p=
ending_frames.tcp_rcv_established
> >       9.05 =C2=B1  2%      +8.1       17.17        perf-profile.calltra=
ce.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__=
tcp_push_pending_frames
> >      18.39            +8.7       27.12        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_fr=
om_freelist.__alloc_pages_nodemask.skb_page_frag_refill
> >      18.58            +8.7       27.31        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemas=
k.skb_page_frag_refill.sk_page_frag_refill
> >      19.93            +8.7       28.67        perf-profile.calltrace.cy=
cles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__s=
ys_sendto
> >      19.92            +8.7       28.66        perf-profile.calltrace.cy=
cles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sen=
dmsg.sock_sendmsg
> >      19.70            +8.7       28.45        perf-profile.calltrace.cy=
cles-pp.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.=
sk_page_frag_refill.tcp_sendmsg_locked
> >      19.77            +8.8       28.54        perf-profile.calltrace.cy=
cles-pp.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp=
_sendmsg_locked.tcp_sendmsg
> >      72.20            +8.8       81.00        perf-profile.calltrace.cy=
cles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      72.09            +8.8       80.92        perf-profile.calltrace.cy=
cles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
> >      71.49            +9.0       80.48        perf-profile.calltrace.cy=
cles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >      71.15            +9.1       80.24        perf-profile.calltrace.cy=
cles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_6=
4
> >       0.00           +10.6       10.61        perf-profile.calltrace.cy=
cles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_r=
cv
> >       0.00           +10.7       10.72        perf-profile.calltrace.cy=
cles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol=
_deliver_rcu
> >       0.00           +11.0       10.98        perf-profile.calltrace.cy=
cles-pp.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_=
local_deliver_finish
> >       0.00           +11.1       11.11        perf-profile.calltrace.cy=
cles-pp.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_fin=
ish.ip_local_deliver
> >      54.40           +12.2       66.63        perf-profile.calltrace.cy=
cles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_=
sendto
> >   32407497           -26.7%   23748191        softirqs.CPU0.NET_RX
> >   31936171 =C2=B1  3%     -23.8%   24347695        softirqs.CPU1.NET_RX
> >   31995720 =C2=B1  3%     -23.5%   24474810        softirqs.CPU10.NET_R=
X
> >   31851135           -28.4%   22807522        softirqs.CPU100.NET_RX
> >   31165470 =C2=B1  2%     -27.9%   22460444 =C2=B1  2%  softirqs.CPU101=
.NET_RX
> >   30427682 =C2=B1  3%     -27.8%   21964060 =C2=B1  2%  softirqs.CPU102=
.NET_RX
> >   31822429           -30.3%   22190016 =C2=B1  2%  softirqs.CPU103.NET_=
RX
> >   31794681 =C2=B1  3%     -24.0%   24170873 =C2=B1  2%  softirqs.CPU11.=
NET_RX
> >   31337588 =C2=B1  3%     -25.0%   23487789 =C2=B1  2%  softirqs.CPU12.=
NET_RX
> >   30982384 =C2=B1  3%     -21.6%   24285912        softirqs.CPU13.NET_R=
X
> >   31985249 =C2=B1  2%     -24.5%   24135878 =C2=B1  2%  softirqs.CPU14.=
NET_RX
> >   31569639 =C2=B1  3%     -23.4%   24173977 =C2=B1  2%  softirqs.CPU15.=
NET_RX
> >   31672651 =C2=B1  2%     -23.7%   24152941 =C2=B1  2%  softirqs.CPU16.=
NET_RX
> >   31845476 =C2=B1  2%     -23.4%   24406051        softirqs.CPU17.NET_R=
X
> >   32237888           -24.4%   24378972        softirqs.CPU18.NET_RX
> >   32390163           -25.7%   24060765        softirqs.CPU19.NET_RX
> >   32518154           -26.3%   23981309 =C2=B1  2%  softirqs.CPU2.NET_RX
> >   31625849 =C2=B1  2%     -26.0%   23391632 =C2=B1  2%  softirqs.CPU20.=
NET_RX
> >   31800991 =C2=B1  2%     -24.2%   24096267 =C2=B1  2%  softirqs.CPU21.=
NET_RX
> >   32165283 =C2=B1  2%     -23.9%   24484882        softirqs.CPU22.NET_R=
X
> >   32096347 =C2=B1  3%     -24.6%   24198018 =C2=B1  2%  softirqs.CPU23.=
NET_RX
> >   32606868           -24.9%   24498919        softirqs.CPU24.NET_RX
> >   31333059 =C2=B1  2%     -23.5%   23972392 =C2=B1  2%  softirqs.CPU25.=
NET_RX
> >   29740104 =C2=B1  3%     -23.9%   22620846        softirqs.CPU26.NET_R=
X
> >       8933 =C2=B1 31%     -24.6%       6736 =C2=B1  7%  softirqs.CPU26.=
SCHED
> >   31426927           -28.2%   22574373 =C2=B1  2%  softirqs.CPU27.NET_R=
X
> >   31494409           -27.6%   22811958        softirqs.CPU28.NET_RX
> >   31749609           -29.8%   22274240 =C2=B1  2%  softirqs.CPU29.NET_R=
X
> >   31359195 =C2=B1  3%     -23.3%   24058233        softirqs.CPU3.NET_RX
> >   31891532           -28.5%   22801967        softirqs.CPU30.NET_RX
> >   31022930 =C2=B1  3%     -26.6%   22780850        softirqs.CPU31.NET_R=
X
> >   31633941           -28.0%   22773366        softirqs.CPU32.NET_RX
> >   31064582 =C2=B1  3%     -28.2%   22291648 =C2=B1  2%  softirqs.CPU33.=
NET_RX
> >   30670424 =C2=B1  2%     -26.0%   22706259        softirqs.CPU34.NET_R=
X
> >   31155193 =C2=B1  3%     -28.3%   22336447 =C2=B1  2%  softirqs.CPU35.=
NET_RX
> >   31767721           -29.3%   22462506 =C2=B1  2%  softirqs.CPU36.NET_R=
X
> >   31702765           -27.9%   22848963        softirqs.CPU37.NET_RX
> >   31618979           -28.8%   22498908 =C2=B1  2%  softirqs.CPU38.NET_R=
X
> >       8157 =C2=B1 30%     -22.3%       6342        softirqs.CPU38.SCHED
> >   31178503 =C2=B1  2%     -28.8%   22206116 =C2=B1  2%  softirqs.CPU39.=
NET_RX
> >   31543118 =C2=B1  3%     -22.7%   24378208        softirqs.CPU4.NET_RX
> >   29993167 =C2=B1  3%     -26.6%   22006508        softirqs.CPU40.NET_R=
X
> >   31389405 =C2=B1  2%     -27.4%   22777491        softirqs.CPU41.NET_R=
X
> >   31225889 =C2=B1  3%     -28.1%   22466787 =C2=B1  2%  softirqs.CPU42.=
NET_RX
> >   31122849 =C2=B1  3%     -27.5%   22548782        softirqs.CPU43.NET_R=
X
> >   30449949 =C2=B1  3%     -26.7%   22314973 =C2=B1  2%  softirqs.CPU44.=
NET_RX
> >   30708016 =C2=B1  3%     -26.5%   22575709        softirqs.CPU45.NET_R=
X
> >   30869514 =C2=B1  2%     -27.1%   22517203        softirqs.CPU46.NET_R=
X
> >   30349340 =C2=B1  3%     -26.7%   22238899 =C2=B1  2%  softirqs.CPU47.=
NET_RX
> >   31690538           -27.9%   22844885        softirqs.CPU48.NET_RX
> >   31442996           -27.6%   22774395        softirqs.CPU49.NET_RX
> >   32539333           -24.8%   24475876        softirqs.CPU5.NET_RX
> >   31777443           -28.1%   22839894        softirqs.CPU50.NET_RX
> >   30319039 =C2=B1  4%     -25.8%   22488386        softirqs.CPU51.NET_R=
X
> >   32358234           -24.7%   24364666        softirqs.CPU52.NET_RX
> >   31051127 =C2=B1  3%     -23.5%   23764585 =C2=B1  2%  softirqs.CPU53.=
NET_RX
> >   31368731 =C2=B1  3%     -22.3%   24384593        softirqs.CPU54.NET_R=
X
> >   32739188           -26.5%   24063678 =C2=B1  2%  softirqs.CPU55.NET_R=
X
> >   32587893           -25.0%   24425586        softirqs.CPU56.NET_RX
> >   31762403 =C2=B1  3%     -24.6%   23947521        softirqs.CPU57.NET_R=
X
> >   32342624           -25.5%   24095598        softirqs.CPU58.NET_RX
> >   31850813 =C2=B1  3%     -23.7%   24310413        softirqs.CPU59.NET_R=
X
> >   32296552           -26.1%   23882250 =C2=B1  2%  softirqs.CPU6.NET_RX
> >   31208970 =C2=B1  3%     -23.9%   23735529 =C2=B1  2%  softirqs.CPU60.=
NET_RX
> >   32655061           -25.7%   24259328        softirqs.CPU61.NET_RX
> >   31834306 =C2=B1  3%     -23.2%   24436288        softirqs.CPU62.NET_R=
X
> >   32492263           -25.7%   24146807 =C2=B1  2%  softirqs.CPU63.NET_R=
X
> >   32160041           -24.6%   24237812        softirqs.CPU64.NET_RX
> >   32146792           -25.1%   24083142        softirqs.CPU65.NET_RX
> >   31886509 =C2=B1  3%     -24.3%   24153287 =C2=B1  2%  softirqs.CPU66.=
NET_RX
> >   31124000 =C2=B1  2%     -21.2%   24534615        softirqs.CPU67.NET_R=
X
> >   31606731 =C2=B1  3%     -23.7%   24115056 =C2=B1  2%  softirqs.CPU68.=
NET_RX
> >   31809649 =C2=B1  4%     -27.3%   23140437        softirqs.CPU69.NET_R=
X
> >   31832502 =C2=B1  3%     -23.8%   24256886        softirqs.CPU7.NET_RX
> >   31934664 =C2=B1  2%     -23.5%   24445503        softirqs.CPU70.NET_R=
X
> >   32283512           -24.5%   24374573        softirqs.CPU71.NET_RX
> >   31559429 =C2=B1  3%     -23.0%   24304361        softirqs.CPU72.NET_R=
X
> >   32519181           -26.5%   23915099 =C2=B1  2%  softirqs.CPU73.NET_R=
X
> >   32064639 =C2=B1  3%     -23.5%   24531236        softirqs.CPU74.NET_R=
X
> >   32552635           -25.2%   24358616        softirqs.CPU75.NET_RX
> >   32574031           -25.1%   24391309        softirqs.CPU76.NET_RX
> >   29891561           -18.3%   24435768        softirqs.CPU77.NET_RX
> >   30558797 =C2=B1  3%     -27.1%   22290753 =C2=B1  2%  softirqs.CPU78.=
NET_RX
> >   30913524 =C2=B1  3%     -27.1%   22542484        softirqs.CPU79.NET_R=
X
> >   32338939           -25.2%   24184482        softirqs.CPU8.NET_RX
> >   29930689 =C2=B1  3%     -24.3%   22649621        softirqs.CPU80.NET_R=
X
> >   31789053           -29.3%   22471154 =C2=B1  2%  softirqs.CPU81.NET_R=
X
> >   31080841 =C2=B1  3%     -28.0%   22371709 =C2=B1  2%  softirqs.CPU82.=
NET_RX
> >   31004904 =C2=B1  3%     -28.0%   22335427        softirqs.CPU83.NET_R=
X
> >   30902184 =C2=B1  2%     -26.4%   22746371        softirqs.CPU84.NET_R=
X
> >   31508332           -28.4%   22567097        softirqs.CPU85.NET_RX
> >   31437975           -29.0%   22331821 =C2=B1  2%  softirqs.CPU86.NET_R=
X
> >   31025912 =C2=B1  3%     -26.1%   22913093        softirqs.CPU87.NET_R=
X
> >   30270422 =C2=B1  2%     -25.2%   22636977 =C2=B1  2%  softirqs.CPU88.=
NET_RX
> >   30385565 =C2=B1  4%     -26.0%   22499521 =C2=B1  2%  softirqs.CPU89.=
NET_RX
> >   31577940 =C2=B1  3%     -22.4%   24489124        softirqs.CPU9.NET_RX
> >   30152844 =C2=B1  3%     -24.7%   22717462        softirqs.CPU90.NET_R=
X
> >   29900183 =C2=B1  2%     -24.9%   22460973        softirqs.CPU91.NET_R=
X
> >   31952707           -28.9%   22715130        softirqs.CPU92.NET_RX
> >   30820437 =C2=B1  3%     -26.6%   22619907 =C2=B1  2%  softirqs.CPU93.=
NET_RX
> >   30627580 =C2=B1  3%     -25.6%   22790846        softirqs.CPU94.NET_R=
X
> >   31367872           -27.7%   22670545        softirqs.CPU95.NET_RX
> >   31045007 =C2=B1  3%     -26.5%   22818368        softirqs.CPU96.NET_R=
X
> >   30842779 =C2=B1  3%     -28.2%   22143073 =C2=B1  2%  softirqs.CPU97.=
NET_RX
> >   30173663 =C2=B1  3%     -24.8%   22686608        softirqs.CPU98.NET_R=
X
> >   30750855 =C2=B1  3%     -25.6%   22870339        softirqs.CPU99.NET_R=
X
> >  3.273e+09           -25.8%   2.43e+09        softirqs.NET_RX
> >
> >
> >
> >                               netperf.Throughput_Mbps
> >
> >   4000 +-+-------------------------------------------------------------=
-----+
> >        |                                                               =
     |
> >   3500 +-+                                                             =
     |
> >   3000 +-+                                                             =
     |
> >        O   O O  OO OOO OO OO OOO OO OO OO OOO OO OO OO                 =
     |
> >   2500 +-+                                                             =
     |
> >        |                                                               =
     |
> >   2000 +-+                                                             =
     |
> >        |                                                               =
     |
> >   1500 +-+                                                             =
     |
> >   1000 +-+                                                             =
     |
> >        |                                                               =
     |
> >    500 +-+                                                             =
     |
> >        |                                                               =
     |
> >      0 +O+O---O--------------------------------------------------------=
-----+
> >
> >
> >                             netperf.Throughput_total_Mbps
> >
> >   900000 +-+-----------------------------------------------------------=
-----+
> >          |+.++.+++.++.+++.++.+++.++.+++.++.+++.+++.++.+++.++.+++.++.+++=
.++.+|
> >   800000 +-+                                                           =
     |
> >   700000 +-+                                                           =
     |
> >          |                              O                              =
     |
> >   600000 O-+ O O O OO OOO OO OOO OO OOO  O OOO OOO OO O                =
     |
> >   500000 +-+                                                           =
     |
> >          |                                                             =
     |
> >   400000 +-+                                                           =
     |
> >   300000 +-+                                                           =
     |
> >          |                                                             =
     |
> >   200000 +-+                                                           =
     |
> >   100000 +-+                                                           =
     |
> >          |                                                             =
     |
> >        0 +O+O---O------------------------------------------------------=
-----+
> >
> >
> >                                   netperf.workload
> >
> >   6e+09 +-+------------------------------------------------------------=
-----+
> >         |+.++.++.+++.++.+++.++.++.+++.++.+++.++.++.+++.++.+++.++.++.+++=
.++.+|
> >   5e+09 +-+                                                            =
     |
> >         |                                                              =
     |
> >         O   O O  OOO OO OOO OO OO OOO OO OOO OO OO OOO                 =
     |
> >   4e+09 +-+                                                            =
     |
> >         |                                                              =
     |
> >   3e+09 +-+                                                            =
     |
> >         |                                                              =
     |
> >   2e+09 +-+                                                            =
     |
> >         |                                                              =
     |
> >         |                                                              =
     |
> >   1e+09 +-+                                                            =
     |
> >         |                                                              =
     |
> >       0 +O+O---O-------------------------------------------------------=
-----+
> >
> >
> >                               netperf.time.user_time
> >
> >   2000 +-+-------------------------------------------------------------=
-----+
> >   1800 +-+                       +                               +     =
     |
> >        |                        : :                             + :    =
     |
> >   1600 +-+       +. + .++.++. + : +.+ .++.   .++.++. +       .++  +    =
.++.+|
> >   1400 +-+++.++.+  + +       + +     +    +++       + +.++.++      +.++=
     |
> >        |                                                               =
     |
> >   1200 +-+                                                             =
     |
> >   1000 O-+ O    OO OOO OO OO OOO OO OO OO OOO OO OO OO                 =
     |
> >    800 +-+                                                             =
     |
> >        |                                                               =
     |
> >    600 +-+                                                             =
     |
> >    400 +-+                                                             =
     |
> >        |                                                               =
     |
> >    200 +-+                                                             =
     |
> >      0 +O+O--OO--------------------------------------------------------=
-----+
> >
> >
> >                      netperf.time.percent_of_cpu_this_job_got
> >
> >   8000 +-+-------------------------------------------------------------=
-----+
> >        O+.+O.++.OO.OOO.OO.OO.OOO.OO.OO.OO.OOO.OO.OO.OO+.++.++.++.+++.++=
.++.+|
> >   7000 +-+                                                             =
     |
> >   6000 +-+                                                             =
     |
> >        |                                                               =
     |
> >   5000 +-+                                                             =
     |
> >        |                                                               =
     |
> >   4000 +-+                                                             =
     |
> >        |                                                               =
     |
> >   3000 +-+                                                             =
     |
> >   2000 +-+                                                             =
     |
> >        |                                                               =
     |
> >   1000 +-+                                                             =
     |
> >        |                                                               =
     |
> >      0 +O+O--OO--------------------------------------------------------=
-----+
> >
> >
> >                        netperf.time.involuntary_context_switches
> >
> >     4e+09 +-+----------------------------------------------------------=
-----+
> >           |+.++.+++.+++.++.+++.+++.++.+++.+++.++.+++.+++.++.+++.+++.++.=
+++.+|
> >   3.5e+09 +-+                                                          =
     |
> >     3e+09 +-+                                                          =
     |
> >           O   O   O OOO OO OOO OOO OO OOO OOO OO OOO OO                =
     |
> >   2.5e+09 +-+                                                          =
     |
> >           |                                                            =
     |
> >     2e+09 +-+                                                          =
     |
> >           |                                                            =
     |
> >   1.5e+09 +-+                                                          =
     |
> >     1e+09 +-+                                                          =
     |
> >           |                                                            =
     |
> >     5e+08 +-+                                                          =
     |
> >           |                                                            =
     |
> >         0 +O+O--OO-----------------------------------------------------=
-----+
> >
> >
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> >
> > ***********************************************************************=
****************************
> > lkp-skl-fpga01: 104 threads Skylake with 192G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/=
tbox_group/test/testcase:
> >   cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.6/200%/debian-x86_6=
4-2018-04-03.cgz/900s/lkp-skl-fpga01/TCP_MAERTS/netperf
> >
> > commit:
> >   472c2e07ee ("tcp: add one skb cache for tx")
> >   8b27dae5a2 ("tcp: add one skb cache for rx")
> >
> > 472c2e07eef04514 8b27dae5a2e89a61c46c6dbc76c
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >       3933           -25.6%       2926        netperf.Throughput_Mbps
> >     818124           -25.6%     608758        netperf.Throughput_total_=
Mbps
> >      57423 =C2=B1 19%     -41.1%      33817        netperf.time.involun=
tary_context_switches
> >       3010            +3.7%       3122        netperf.time.percent_of_c=
pu_this_job_got
> >      25432            +3.9%      26424        netperf.time.system_time
> >  3.735e+09           -25.6%  2.778e+09        netperf.time.voluntary_co=
ntext_switches
> >  5.618e+09           -25.6%   4.18e+09        netperf.workload
> >     194721 =C2=B1 22%     +41.3%     275069 =C2=B1  2%  cpuidle.C6.usag=
e
> >      13.00 =C2=B1  7%      +5.9       18.86        mpstat.cpu.all.soft%
> >       3.39 =C2=B1  5%      -1.2        2.23        mpstat.cpu.all.usr%
> >  9.539e+08           +13.2%   1.08e+09        numa-numastat.node0.local=
_node
> >  9.539e+08           +13.2%   1.08e+09        numa-numastat.node0.numa_=
hit
> >  4.767e+08           +13.1%  5.389e+08        numa-vmstat.node0.numa_hi=
t
> >  4.767e+08           +13.1%  5.389e+08        numa-vmstat.node0.numa_lo=
cal
> >      95.75            +1.3%      97.00        vmstat.cpu.sy
> >    8245666           -25.5%    6142829        vmstat.system.cs
> >       2696            +2.9%       2775        turbostat.Avg_MHz
> >       0.89 =C2=B1  5%     -32.4%       0.60        turbostat.CPU%c1
> >     108.00            -1.6%     106.23        turbostat.RAMWatt
> >  1.881e+09           +11.2%  2.091e+09        proc-vmstat.numa_hit
> >  1.881e+09           +11.2%  2.091e+09        proc-vmstat.numa_local
> >  1.504e+10           +11.2%  1.672e+10        proc-vmstat.pgalloc_norma=
l
> >  1.504e+10           +11.2%  1.672e+10        proc-vmstat.pgfree
> >       4053 =C2=B1 15%     +19.6%       4848 =C2=B1 13%  slabinfo.eventp=
oll_pwq.active_objs
> >       4053 =C2=B1 15%     +19.6%       4848 =C2=B1 13%  slabinfo.eventp=
oll_pwq.num_objs
> >     545.50 =C2=B1 11%     -17.1%     452.00 =C2=B1 11%  slabinfo.kernfs=
_iattrs_cache.active_objs
> >     545.50 =C2=B1 11%     -17.1%     452.00 =C2=B1 11%  slabinfo.kernfs=
_iattrs_cache.num_objs
> >      12.31 =C2=B1 12%     +25.1%      15.40        sched_debug.cfs_rq:/=
.load_avg.stddev
> >    1449447 =C2=B1 23%     -29.2%    1026327 =C2=B1 22%  sched_debug.cfs=
_rq:/.min_vruntime.stddev
> >       0.78 =C2=B1 66%    +155.6%       2.00 =C2=B1 11%  sched_debug.cfs=
_rq:/.removed.load_avg.avg
> >       5.98 =C2=B1 60%     +84.9%      11.05 =C2=B1  4%  sched_debug.cfs=
_rq:/.removed.load_avg.stddev
> >      35.94 =C2=B1 66%    +156.2%      92.09 =C2=B1 11%  sched_debug.cfs=
_rq:/.removed.runnable_sum.avg
> >     274.98 =C2=B1 60%     +85.4%     509.82 =C2=B1  4%  sched_debug.cfs=
_rq:/.removed.runnable_sum.stddev
> >       0.39 =C2=B1 66%    +115.0%       0.84 =C2=B1 11%  sched_debug.cfs=
_rq:/.removed.util_avg.avg
> >       1.75 =C2=B1 14%     +32.1%       2.31 =C2=B1 12%  sched_debug.cfs=
_rq:/.runnable_load_avg.min
> >      98724 =C2=B1 85%     -66.3%      33282 =C2=B1 85%  sched_debug.cfs=
_rq:/.runnable_weight.max
> >   -3346961           -44.2%   -1868641        sched_debug.cfs_rq:/.spre=
ad0.min
> >    1449347 =C2=B1 23%     -29.2%    1026220 =C2=B1 22%  sched_debug.cfs=
_rq:/.spread0.stddev
> >     156728 =C2=B1 15%     +49.0%     233530 =C2=B1 14%  sched_debug.cpu=
.avg_idle.avg
> >     260031 =C2=B1  9%     +33.3%     346707 =C2=B1 10%  sched_debug.cpu=
.avg_idle.stddev
> >      20.54 =C2=B1  5%     -10.2%      18.44 =C2=B1  2%  sched_debug.cpu=
.clock.stddev
> >      20.54 =C2=B1  5%     -10.2%      18.44 =C2=B1  2%  sched_debug.cpu=
.clock_task.stddev
> >   35742943           -25.6%   26602562        sched_debug.cpu.nr_switch=
es.avg
> >   37162589           -24.6%   28014480        sched_debug.cpu.nr_switch=
es.max
> >   32371186           -24.3%   24512619        sched_debug.cpu.nr_switch=
es.min
> >      18.74           +29.7%      24.31        perf-stat.i.MPKI
> >  1.938e+10           -20.9%  1.534e+10        perf-stat.i.branch-instru=
ctions
> >       2.05            -0.1        1.98        perf-stat.i.branch-miss-r=
ate%
> >  3.961e+08           -23.4%  3.033e+08        perf-stat.i.branch-misses
> >       0.74 =C2=B1 31%      -0.4        0.38 =C2=B1 18%  perf-stat.i.cac=
he-miss-rate%
> >   12929011 =C2=B1 32%     -49.1%    6575616 =C2=B1 19%  perf-stat.i.cac=
he-misses
> >  1.813e+09            +2.3%  1.854e+09        perf-stat.i.cache-referen=
ces
> >    8267879           -25.5%    6157361        perf-stat.i.context-switc=
hes
> >       2.89           +30.6%       3.77        perf-stat.i.cpi
> >  2.794e+11            +2.9%  2.876e+11        perf-stat.i.cpu-cycles
> >      23942 =C2=B1 24%     +97.5%      47291 =C2=B1 21%  perf-stat.i.cyc=
les-between-cache-misses
> >       1.13            -0.1        0.99        perf-stat.i.dTLB-load-mis=
s-rate%
> >  3.331e+08           -31.8%  2.274e+08        perf-stat.i.dTLB-load-mis=
ses
> >    2.9e+10           -22.0%  2.263e+10        perf-stat.i.dTLB-loads
> >   60002134 =C2=B1  2%     -26.3%   44193691 =C2=B1  2%  perf-stat.i.dTL=
B-store-misses
> >  1.664e+10           -23.6%  1.271e+10        perf-stat.i.dTLB-stores
> >      58.26            -4.7       53.57        perf-stat.i.iTLB-load-mis=
s-rate%
> >   70291090           -31.0%   48469793        perf-stat.i.iTLB-load-mis=
ses
> >   50169394           -16.5%   41890643        perf-stat.i.iTLB-loads
> >  9.677e+10           -21.2%  7.624e+10        perf-stat.i.instructions
> >       1410           +13.6%       1602        perf-stat.i.instructions-=
per-iTLB-miss
> >       0.35           -23.4%       0.27        perf-stat.i.ipc
> >    2150902 =C2=B1 41%     -42.7%    1233268 =C2=B1 27%  perf-stat.i.nod=
e-load-misses
> >     652857 =C2=B1 24%     -39.8%     393122 =C2=B1 15%  perf-stat.i.nod=
e-loads
> >      77.08 =C2=B1 11%     -20.6       56.48 =C2=B1 14%  perf-stat.i.nod=
e-store-miss-rate%
> >     386848 =C2=B1 40%     -64.7%     136565 =C2=B1 27%  perf-stat.i.nod=
e-store-misses
> >      18.74           +29.8%      24.32        perf-stat.overall.MPKI
> >       2.04            -0.1        1.98        perf-stat.overall.branch-=
miss-rate%
> >       0.71 =C2=B1 32%      -0.4        0.35 =C2=B1 20%  perf-stat.overa=
ll.cache-miss-rate%
> >       2.89           +30.6%       3.77        perf-stat.overall.cpi
> >      23413 =C2=B1 23%     +95.0%      45644 =C2=B1 21%  perf-stat.overa=
ll.cycles-between-cache-misses
> >       1.14            -0.1        0.99        perf-stat.overall.dTLB-lo=
ad-miss-rate%
> >      58.35            -4.7       53.64        perf-stat.overall.iTLB-lo=
ad-miss-rate%
> >       1376           +14.3%       1573        perf-stat.overall.instruc=
tions-per-iTLB-miss
> >       0.35           -23.4%       0.27        perf-stat.overall.ipc
> >      75.96 =C2=B1 13%     -20.1       55.89 =C2=B1 14%  perf-stat.overa=
ll.node-store-miss-rate%
> >      15545            +5.9%      16457        perf-stat.overall.path-le=
ngth
> >  1.936e+10           -20.9%  1.532e+10        perf-stat.ps.branch-instr=
uctions
> >  3.956e+08           -23.4%   3.03e+08        perf-stat.ps.branch-misse=
s
> >   12917167 =C2=B1 32%     -49.1%    6568704 =C2=B1 19%  perf-stat.ps.ca=
che-misses
> >  1.811e+09            +2.3%  1.852e+09        perf-stat.ps.cache-refere=
nces
> >    8258274           -25.5%    6150289        perf-stat.ps.context-swit=
ches
> >  2.791e+11            +2.9%  2.872e+11        perf-stat.ps.cpu-cycles
> >  3.328e+08           -31.8%  2.271e+08        perf-stat.ps.dTLB-load-mi=
sses
> >  2.897e+10           -22.0%   2.26e+10        perf-stat.ps.dTLB-loads
> >   59931265 =C2=B1  2%     -26.3%   44142618 =C2=B1  2%  perf-stat.ps.dT=
LB-store-misses
> >  1.662e+10           -23.6%  1.269e+10        perf-stat.ps.dTLB-stores
> >   70208114           -31.0%   48413951        perf-stat.ps.iTLB-load-mi=
sses
> >   50111323           -16.5%   41842519        perf-stat.ps.iTLB-loads
> >  9.666e+10           -21.2%  7.616e+10        perf-stat.ps.instructions
> >    2148559 =C2=B1 41%     -42.7%    1231893 =C2=B1 27%  perf-stat.ps.no=
de-load-misses
> >     653248 =C2=B1 24%     -39.9%     392846 =C2=B1 15%  perf-stat.ps.no=
de-loads
> >     386418 =C2=B1 40%     -64.7%     136417 =C2=B1 27%  perf-stat.ps.no=
de-store-misses
> >  8.733e+13           -21.2%  6.879e+13        perf-stat.total.instructi=
ons
> >     887.50 =C2=B1 21%    +961.1%       9417 =C2=B1122%  interrupts.39:P=
CI-MSI.67633154-edge.eth0-TxRx-1
> >     906772            +4.4%     946334        interrupts.CAL:Function_c=
all_interrupts
> >     128451 =C2=B1  3%     -20.1%     102684 =C2=B1 11%  interrupts.CPU1=
.RES:Rescheduling_interrupts
> >     122297 =C2=B1 12%     -20.1%      97767 =C2=B1  5%  interrupts.CPU1=
00.RES:Rescheduling_interrupts
> >     114996 =C2=B1  8%     -12.8%     100315 =C2=B1  5%  interrupts.CPU1=
01.RES:Rescheduling_interrupts
> >       8676 =C2=B1  2%     +14.9%       9972 =C2=B1  3%  interrupts.CPU1=
02.CAL:Function_call_interrupts
> >     145573 =C2=B1 15%     -30.4%     101298 =C2=B1  9%  interrupts.CPU1=
02.RES:Rescheduling_interrupts
> >       8795           +13.2%       9956 =C2=B1  3%  interrupts.CPU103.CA=
L:Function_call_interrupts
> >     129834 =C2=B1  7%     -15.4%     109820 =C2=B1  9%  interrupts.CPU1=
1.RES:Rescheduling_interrupts
> >     122266 =C2=B1  5%     -18.3%      99893 =C2=B1  4%  interrupts.CPU1=
3.RES:Rescheduling_interrupts
> >     133695 =C2=B1  4%     -23.7%     101984 =C2=B1  5%  interrupts.CPU1=
4.RES:Rescheduling_interrupts
> >     115773 =C2=B1  7%     -18.6%      94202 =C2=B1  8%  interrupts.CPU1=
8.RES:Rescheduling_interrupts
> >     120005 =C2=B1  3%     -15.7%     101149 =C2=B1  8%  interrupts.CPU2=
7.RES:Rescheduling_interrupts
> >     119584 =C2=B1  3%     -19.5%      96286 =C2=B1  6%  interrupts.CPU2=
9.RES:Rescheduling_interrupts
> >     127064 =C2=B1  7%     -15.1%     107858 =C2=B1  5%  interrupts.CPU3=
0.RES:Rescheduling_interrupts
> >     887.50 =C2=B1 21%    +961.1%       9417 =C2=B1122%  interrupts.CPU3=
1.39:PCI-MSI.67633154-edge.eth0-TxRx-1
> >     118974 =C2=B1 11%     -17.1%      98609 =C2=B1  7%  interrupts.CPU3=
3.RES:Rescheduling_interrupts
> >     125463 =C2=B1 13%     -23.9%      95477 =C2=B1  5%  interrupts.CPU3=
4.RES:Rescheduling_interrupts
> >     125126 =C2=B1 16%     -21.7%      97997 =C2=B1  7%  interrupts.CPU3=
5.RES:Rescheduling_interrupts
> >     133035 =C2=B1 12%     -28.2%      95517 =C2=B1 10%  interrupts.CPU3=
7.RES:Rescheduling_interrupts
> >     120167 =C2=B1 11%     -24.5%      90782 =C2=B1  8%  interrupts.CPU3=
8.RES:Rescheduling_interrupts
> >     125040 =C2=B1  3%     -19.8%     100223 =C2=B1  7%  interrupts.CPU4=
2.RES:Rescheduling_interrupts
> >     119768 =C2=B1 15%     -16.6%      99882        interrupts.CPU43.RES=
:Rescheduling_interrupts
> >     125986 =C2=B1  7%     -18.9%     102226 =C2=B1  8%  interrupts.CPU4=
5.RES:Rescheduling_interrupts
> >     124516 =C2=B1 10%     -15.7%     104961 =C2=B1  5%  interrupts.CPU4=
8.RES:Rescheduling_interrupts
> >     125647 =C2=B1  5%     -22.8%      96970 =C2=B1  3%  interrupts.CPU4=
9.RES:Rescheduling_interrupts
> >     131345 =C2=B1  5%     -17.2%     108796 =C2=B1  3%  interrupts.CPU5=
1.RES:Rescheduling_interrupts
> >     127858 =C2=B1  3%     -18.9%     103683 =C2=B1  5%  interrupts.CPU5=
3.RES:Rescheduling_interrupts
> >     125241 =C2=B1 15%     -18.7%     101797 =C2=B1  5%  interrupts.CPU5=
4.RES:Rescheduling_interrupts
> >     133398 =C2=B1  7%     -22.1%     103961 =C2=B1  3%  interrupts.CPU5=
6.RES:Rescheduling_interrupts
> >     129732 =C2=B1 10%     -24.2%      98324 =C2=B1  4%  interrupts.CPU6=
.RES:Rescheduling_interrupts
> >     132858 =C2=B1 12%     -20.5%     105623 =C2=B1  9%  interrupts.CPU6=
0.RES:Rescheduling_interrupts
> >     123442 =C2=B1  5%     -20.7%      97934 =C2=B1  4%  interrupts.CPU6=
4.RES:Rescheduling_interrupts
> >     132863 =C2=B1  3%     -20.2%     106040 =C2=B1  4%  interrupts.CPU6=
5.RES:Rescheduling_interrupts
> >       9002           +10.7%       9967 =C2=B1  2%  interrupts.CPU66.CAL=
:Function_call_interrupts
> >       8999           +10.7%       9958 =C2=B1  2%  interrupts.CPU67.CAL=
:Function_call_interrupts
> >       8774 =C2=B1  5%     +13.4%       9951 =C2=B1  2%  interrupts.CPU6=
8.CAL:Function_call_interrupts
> >       8991           +10.6%       9945 =C2=B1  2%  interrupts.CPU69.CAL=
:Function_call_interrupts
> >     125949 =C2=B1  9%     -15.0%     107048 =C2=B1  4%  interrupts.CPU6=
9.RES:Rescheduling_interrupts
> >     123443 =C2=B1  8%     -15.7%     104008 =C2=B1  8%  interrupts.CPU7=
.RES:Rescheduling_interrupts
> >       8987           +10.6%       9938 =C2=B1  2%  interrupts.CPU70.CAL=
:Function_call_interrupts
> >       8983           +10.5%       9927 =C2=B1  2%  interrupts.CPU71.CAL=
:Function_call_interrupts
> >     122925 =C2=B1 12%     -18.0%     100786 =C2=B1  8%  interrupts.CPU7=
1.RES:Rescheduling_interrupts
> >       8925           +11.0%       9910 =C2=B1  2%  interrupts.CPU73.CAL=
:Function_call_interrupts
> >     126258 =C2=B1  7%     -19.4%     101773 =C2=B1  7%  interrupts.CPU7=
3.RES:Rescheduling_interrupts
> >     129281 =C2=B1  6%     -18.1%     105945 =C2=B1  5%  interrupts.CPU7=
4.RES:Rescheduling_interrupts
> >       8969           +10.3%       9893 =C2=B1  2%  interrupts.CPU75.CAL=
:Function_call_interrupts
> >       8966           +10.3%       9887 =C2=B1  2%  interrupts.CPU76.CAL=
:Function_call_interrupts
> >       8965           +10.1%       9870 =C2=B1  2%  interrupts.CPU77.CAL=
:Function_call_interrupts
> >     129057 =C2=B1  9%     -24.7%      97240 =C2=B1  3%  interrupts.CPU7=
7.RES:Rescheduling_interrupts
> >       8683 =C2=B1  5%     +13.7%       9874 =C2=B1  2%  interrupts.CPU7=
8.CAL:Function_call_interrupts
> >     129114 =C2=B1  9%     -27.6%      93483 =C2=B1  4%  interrupts.CPU7=
8.RES:Rescheduling_interrupts
> >       8685 =C2=B1  4%     +13.6%       9865 =C2=B1  2%  interrupts.CPU7=
9.CAL:Function_call_interrupts
> >     121386 =C2=B1  7%     -18.7%      98627 =C2=B1  5%  interrupts.CPU8=
.RES:Rescheduling_interrupts
> >       8956           +10.1%       9864 =C2=B1  2%  interrupts.CPU80.CAL=
:Function_call_interrupts
> >     125015 =C2=B1 11%     -24.1%      94918 =C2=B1  5%  interrupts.CPU8=
0.RES:Rescheduling_interrupts
> >       8633 =C2=B1  7%     +14.2%       9856 =C2=B1  2%  interrupts.CPU8=
1.CAL:Function_call_interrupts
> >     132492 =C2=B1  4%     -20.7%     105014 =C2=B1  4%  interrupts.CPU8=
1.RES:Rescheduling_interrupts
> >       8857 =C2=B1  2%     +11.2%       9848 =C2=B1  2%  interrupts.CPU8=
2.CAL:Function_call_interrupts
> >     111387 =C2=B1  6%     -13.8%      96026 =C2=B1  8%  interrupts.CPU8=
2.RES:Rescheduling_interrupts
> >     112445 =C2=B1  6%      -9.6%     101699 =C2=B1  7%  interrupts.CPU8=
3.RES:Rescheduling_interrupts
> >     121973 =C2=B1  7%     -21.1%      96217 =C2=B1  6%  interrupts.CPU8=
4.RES:Rescheduling_interrupts
> >       8883           +10.6%       9822 =C2=B1  2%  interrupts.CPU85.CAL=
:Function_call_interrupts
> >     115045 =C2=B1  6%     -16.3%      96249 =C2=B1  4%  interrupts.CPU8=
5.RES:Rescheduling_interrupts
> >       8668 =C2=B1  3%     +12.6%       9762        interrupts.CPU86.CAL=
:Function_call_interrupts
> >       8579 =C2=B1  3%     +14.3%       9806 =C2=B1  2%  interrupts.CPU8=
7.CAL:Function_call_interrupts
> >       8719 =C2=B1  2%     +12.4%       9797 =C2=B1  2%  interrupts.CPU8=
8.CAL:Function_call_interrupts
> >       8769           +11.6%       9788 =C2=B1  2%  interrupts.CPU89.CAL=
:Function_call_interrupts
> >     131248 =C2=B1  9%     -27.5%      95130 =C2=B1  9%  interrupts.CPU9=
.RES:Rescheduling_interrupts
> >       8766           +11.6%       9780 =C2=B1  2%  interrupts.CPU90.CAL=
:Function_call_interrupts
> >     121573 =C2=B1  6%     -14.4%     104044 =C2=B1  8%  interrupts.CPU9=
0.RES:Rescheduling_interrupts
> >       8762           +11.5%       9768 =C2=B1  2%  interrupts.CPU91.CAL=
:Function_call_interrupts
> >     125741 =C2=B1  6%     -21.2%      99116 =C2=B1 10%  interrupts.CPU9=
1.RES:Rescheduling_interrupts
> >       8764           +11.3%       9754 =C2=B1  2%  interrupts.CPU92.CAL=
:Function_call_interrupts
> >     125340 =C2=B1  7%     -21.1%      98921 =C2=B1  6%  interrupts.CPU9=
2.RES:Rescheduling_interrupts
> >       8620 =C2=B1  4%     +13.0%       9743 =C2=B1  2%  interrupts.CPU9=
3.CAL:Function_call_interrupts
> >     129358 =C2=B1 10%     -25.0%      97082 =C2=B1  6%  interrupts.CPU9=
3.RES:Rescheduling_interrupts
> >       8753           +11.2%       9730 =C2=B1  2%  interrupts.CPU94.CAL=
:Function_call_interrupts
> >       8750           +11.1%       9719 =C2=B1  2%  interrupts.CPU95.CAL=
:Function_call_interrupts
> >     115441 =C2=B1  6%     -15.6%      97484 =C2=B1  8%  interrupts.CPU9=
5.RES:Rescheduling_interrupts
> >     121213 =C2=B1  5%     -17.0%     100662 =C2=B1 12%  interrupts.CPU9=
9.RES:Rescheduling_interrupts
> >   12650754 =C2=B1  3%     -14.8%   10783909        interrupts.RES:Resch=
eduling_interrupts
> >     176.50 =C2=B1 59%     -79.7%      35.75 =C2=B1 47%  interrupts.TLB:=
TLB_shootdowns
> >      10.98           -11.0        0.00        perf-profile.calltrace.cy=
cles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_so=
ck
> >      10.70           -10.7        0.00        perf-profile.calltrace.cy=
cles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__rel=
ease_sock
> >      10.29           -10.3        0.00        perf-profile.calltrace.cy=
cles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_=
do_rcv
> >      10.20           -10.2        0.00        perf-profile.calltrace.cy=
cles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_es=
tablished
> >       9.82            -9.8        0.00        perf-profile.calltrace.cy=
cles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tc=
p_ack
> >       9.68            -9.7        0.00        perf-profile.calltrace.cy=
cles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clea=
n_rtx_queue
> >      21.27            -6.8       14.52        perf-profile.calltrace.cy=
cles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      21.18            -6.7       14.46        perf-profile.calltrace.cy=
cles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
> >      20.54            -6.5       14.04        perf-profile.calltrace.cy=
cles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
> >      20.43            -6.5       13.96        perf-profile.calltrace.cy=
cles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_sysca=
ll_64
> >      16.41            -3.1       13.34        perf-profile.calltrace.cy=
cles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
> >      16.22            -3.0       13.21        perf-profile.calltrace.cy=
cles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
> >       7.69            -2.2        5.51        perf-profile.calltrace.cy=
cles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x6=
4_sys_recvfrom
> >       7.67            -2.2        5.50        perf-profile.calltrace.cy=
cles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg=
.__sys_recvfrom
> >       6.75 =C2=B1  6%      -2.2        4.60 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local=
_deliver_finish.ip_local_deliver
> >      13.64            -2.1       11.53        perf-profile.calltrace.cy=
cles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> >      13.43            -2.0       11.40        perf-profile.calltrace.cy=
cles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_s=
endmsg
> >       7.00            -2.0        5.04        perf-profile.calltrace.cy=
cles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvms=
g.inet_recvmsg
> >       6.83            -1.9        4.93        perf-profile.calltrace.cy=
cles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tc=
p_recvmsg
> >       6.70            -1.9        4.83        perf-profile.calltrace.cy=
cles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram=
_iter.skb_copy_datagram_iter
> >       6.39 =C2=B1  3%      -1.9        4.53        perf-profile.calltra=
ce.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliv=
er_rcu.ip_local_deliver_finish
> >       5.43            -1.7        3.69        perf-profile.calltrace.cy=
cles-pp.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recv=
from
> >       5.31            -1.7        3.59        perf-profile.calltrace.cy=
cles-pp.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sy=
s_recvfrom
> >       5.68 =C2=B1  3%      -1.6        4.11 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v=
4_rcv.ip_protocol_deliver_rcu
> >       4.76            -1.6        3.19        perf-profile.calltrace.cy=
cles-pp.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
> >       4.84            -1.5        3.30        perf-profile.calltrace.cy=
cles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_r=
ecvfrom
> >       4.56            -1.5        3.04        perf-profile.calltrace.cy=
cles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg
> >       5.51 =C2=B1  3%      -1.5        4.01 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_establish=
ed.tcp_v4_do_rcv.tcp_v4_rcv
> >       4.48            -1.5        2.99        perf-profile.calltrace.cy=
cles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg
> >       4.39            -1.5        2.92        perf-profile.calltrace.cy=
cles-pp.__sched_text_start.schedule.schedule_timeout.wait_woken.sk_wait_dat=
a
> >       5.36 =C2=B1  3%      -1.5        3.90 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.=
tcp_rcv_established.tcp_v4_do_rcv
> >       5.19 =C2=B1  3%      -1.4        3.78 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.soc=
k_def_readable.tcp_rcv_established
> >       4.37            -1.4        2.96        perf-profile.calltrace.cy=
cles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvm=
sg
> >       2.14            -1.4        0.73        perf-profile.calltrace.cy=
cles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_l=
ock.sock_def_readable
> >      10.04            -1.4        8.65        perf-profile.calltrace.cy=
cles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__=
sys_sendto
> >       2.08            -1.4        0.70        perf-profile.calltrace.cy=
cles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.=
__wake_up_common_lock
> >       9.73            -1.3        8.42        perf-profile.calltrace.cy=
cles-pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sen=
dmsg
> >       9.56            -1.3        8.29        perf-profile.calltrace.cy=
cles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_send=
msg_locked.tcp_sendmsg
> >       3.73            -1.2        2.55        perf-profile.calltrace.cy=
cles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_=
recvmsg
> >       3.78 =C2=B1  2%      -1.1        2.68        perf-profile.calltra=
ce.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__s=
ys_sendto
> >       1.86 =C2=B1 30%      -1.0        0.84 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wak=
e_up_common_lock.sock_def_readable
> >       3.46 =C2=B1  2%      -1.0        2.46        perf-profile.calltra=
ce.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendm=
sg.sock_sendmsg
> >       1.51 =C2=B1  6%      -0.9        0.61        perf-profile.calltra=
ce.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit._=
_tcp_transmit_skb
> >       3.22 =C2=B1  2%      -0.9        2.33        perf-profile.calltra=
ce.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_=
locked.tcp_sendmsg
> >       3.02 =C2=B1  2%      -0.8        2.21        perf-profile.calltra=
ce.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tc=
p_sendmsg_locked
> >       1.78            -0.6        1.16        perf-profile.calltrace.cy=
cles-pp.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout.wait=
_woken
> >       7.18 =C2=B1  2%      -0.6        6.58 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.=
sock_sendmsg.__sys_sendto
> >       7.16 =C2=B1  2%      -0.6        6.56 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_lock=
ed.tcp_sendmsg.sock_sendmsg
> >       1.37            -0.5        0.88        perf-profile.calltrace.cy=
cles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.33            -0.5        0.84        perf-profile.calltrace.cy=
cles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after=
_hwframe
> >       1.29            -0.5        0.82        perf-profile.calltrace.cy=
cles-pp.__sched_text_start.schedule.exit_to_usermode_loop.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
> >       0.71            -0.5        0.25 =C2=B1100%  perf-profile.calltra=
ce.cycles-pp.__sched_text_start.preempt_schedule_common._cond_resched.__rel=
ease_sock.release_sock
> >       1.20            -0.4        0.82        perf-profile.calltrace.cy=
cles-pp.__switch_to
> >       1.09            -0.4        0.72        perf-profile.calltrace.cy=
cles-pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock=
_sendmsg
> >       1.09            -0.3        0.77        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64
> >       6.42 =C2=B1  2%      -0.3        6.09 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_fram=
es.tcp_sendmsg_locked.tcp_sendmsg
> >       0.83            -0.3        0.56        perf-profile.calltrace.cy=
cles-pp.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_l=
ocked.tcp_sendmsg
> >       0.84            -0.3        0.58 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.switch_mm_irqs_off.__sched_text_start.schedule.schedule_timeou=
t.wait_woken
> >       0.94            -0.3        0.68        perf-profile.calltrace.cy=
cles-pp.syscall_return_via_sysret
> >       0.74            -0.2        0.53        perf-profile.calltrace.cy=
cles-pp._cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
> >       0.73            -0.2        0.52        perf-profile.calltrace.cy=
cles-pp.preempt_schedule_common._cond_resched.__release_sock.release_sock.t=
cp_sendmsg
> >       9.51            +0.7       10.17        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data.__kfr=
ee_skb
> >       9.38            +0.7       10.08        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__fre=
e_pages_ok.skb_release_data
> >      95.32            +1.4       96.69        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe
> >      95.16            +1.4       96.58        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      11.17            +7.3       18.47        perf-profile.calltrace.cy=
cles-pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__s=
ys_sendto
> >      11.81 =C2=B1  2%      +7.4       19.18        perf-profile.calltra=
ce.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xm=
it.__tcp_transmit_skb
> >      11.74 =C2=B1  2%      +7.4       19.15        perf-profile.calltra=
ce.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__=
ip_queue_xmit
> >      11.52 =C2=B1  2%      +7.5       18.98        perf-profile.calltra=
ce.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__lo=
cal_bh_enable_ip.ip_finish_output2
> >      11.55 =C2=B1  2%      +7.5       19.01        perf-profile.calltra=
ce.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish=
_output2.ip_output
> >      11.27 =C2=B1  2%      +7.5       18.81        perf-profile.calltra=
ce.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.d=
o_softirq.__local_bh_enable_ip
> >      10.95 =C2=B1  2%      +7.6       18.55        perf-profile.calltra=
ce.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_sof=
tirq_own_stack.do_softirq
> >       9.28            +7.6       16.91        perf-profile.calltrace.cy=
cles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__fre=
e_pages_ok.___pskb_trim
> >       9.39            +7.7       17.05        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.free_one_page.__free_pages_ok.___pskb_trim.sk_stream=
_alloc_skb
> >      10.83 =C2=B1  2%      +7.7       18.52        perf-profile.calltra=
ce.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb=
.tcp_write_xmit
> >       9.57            +7.7       17.27        perf-profile.calltrace.cy=
cles-pp.free_one_page.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_=
sendmsg_locked
> >       9.94            +7.7       17.64        perf-profile.calltrace.cy=
cles-pp.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.soc=
k_sendmsg
> >      10.49 =C2=B1  2%      +7.7       18.23        perf-profile.calltra=
ce.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__s=
oftirqentry_text_start.do_softirq_own_stack
> >       9.73            +7.8       17.49        perf-profile.calltrace.cy=
cles-pp.__free_pages_ok.___pskb_trim.sk_stream_alloc_skb.tcp_sendmsg_locked=
.tcp_sendmsg
> >      10.16 =C2=B1  2%      +7.8       17.98        perf-profile.calltra=
ce.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_act=
ion.__softirqentry_text_start
> >       3.79            +8.0       11.77        perf-profile.calltrace.cy=
cles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__relea=
se_sock.release_sock
> >       3.78            +8.0       11.77        perf-profile.calltrace.cy=
cles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4=
_do_rcv.__release_sock
> >       9.61 =C2=B1  2%      +8.0       17.61        perf-profile.calltra=
ce.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_b=
acklog.net_rx_action
> >       9.45 =C2=B1  2%      +8.1       17.50        perf-profile.calltra=
ce.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receiv=
e_skb_one_core.process_backlog
> >       9.40 =C2=B1  2%      +8.1       17.47        perf-profile.calltra=
ce.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliv=
er.ip_rcv.__netif_receive_skb_one_core
> >       9.21 =C2=B1  2%      +8.1       17.35        perf-profile.calltra=
ce.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_=
local_deliver.ip_rcv
> >       3.44            +8.1       11.58        perf-profile.calltrace.cy=
cles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv=
_established.tcp_v4_do_rcv
> >       8.65 =C2=B1  2%      +8.2       16.88        perf-profile.calltra=
ce.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__=
tcp_push_pending_frames
> >       3.21            +8.2       11.44        perf-profile.calltrace.cy=
cles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pendin=
g_frames.tcp_rcv_established
> >      18.55 =C2=B1  2%      +8.6       27.14        perf-profile.calltra=
ce.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_pa=
ge_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill
> >      20.09 =C2=B1  2%      +8.6       28.68        perf-profile.calltra=
ce.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendms=
g.__sys_sendto
> >      19.87 =C2=B1  2%      +8.6       28.45        perf-profile.calltra=
ce.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_re=
fill.sk_page_frag_refill.tcp_sendmsg_locked
> >      20.08 =C2=B1  2%      +8.6       28.67        perf-profile.calltra=
ce.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tc=
p_sendmsg.sock_sendmsg
> >      18.74 =C2=B1  2%      +8.6       27.34        perf-profile.calltra=
ce.cycles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_no=
demask.skb_page_frag_refill.sk_page_frag_refill
> >      19.94 =C2=B1  2%      +8.6       28.53        perf-profile.calltra=
ce.cycles-pp.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refil=
l.tcp_sendmsg_locked.tcp_sendmsg
> >      72.24            +8.7       80.98        perf-profile.calltrace.cy=
cles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      72.13            +8.8       80.91        perf-profile.calltrace.cy=
cles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
> >      71.52            +9.0       80.48        perf-profile.calltrace.cy=
cles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >      71.18            +9.1       80.25        perf-profile.calltrace.cy=
cles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_6=
4
> >       0.00           +10.3       10.29        perf-profile.calltrace.cy=
cles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_r=
cv
> >       0.00           +10.4       10.41        perf-profile.calltrace.cy=
cles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol=
_deliver_rcu
> >       0.00           +10.7       10.66        perf-profile.calltrace.cy=
cles-pp.skb_release_data.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_=
local_deliver_finish
> >       0.00           +10.8       10.81        perf-profile.calltrace.cy=
cles-pp.__kfree_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_fin=
ish.ip_local_deliver
> >      54.39           +12.2       66.64        perf-profile.calltrace.cy=
cles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_=
sendto
> >   31487988 =C2=B1  3%     -23.2%   24183132        softirqs.CPU0.NET_RX
> >   32151929           -26.1%   23765617 =C2=B1  2%  softirqs.CPU1.NET_RX
> >   31962684 =C2=B1  3%     -23.5%   24458409        softirqs.CPU10.NET_R=
X
> >   31110228 =C2=B1  3%     -26.2%   22964939        softirqs.CPU100.NET_=
RX
> >   31626866           -27.6%   22906397        softirqs.CPU101.NET_RX
> >   29779153 =C2=B1  3%     -22.9%   22969929        softirqs.CPU102.NET_=
RX
> >   31513116           -27.3%   22920216        softirqs.CPU103.NET_RX
> >   31713243 =C2=B1  2%     -24.9%   23826688 =C2=B1  2%  softirqs.CPU11.=
NET_RX
> >   32072474           -26.1%   23696606 =C2=B1  2%  softirqs.CPU12.NET_R=
X
> >   32279430           -24.8%   24260634        softirqs.CPU13.NET_RX
> >   31697375 =C2=B1  3%     -23.0%   24406003        softirqs.CPU14.NET_R=
X
> >   32278026           -24.7%   24317293        softirqs.CPU15.NET_RX
> >   31162122 =C2=B1  3%     -21.7%   24396540        softirqs.CPU16.NET_R=
X
> >   32209863           -24.2%   24418327        softirqs.CPU17.NET_RX
> >   32329002           -25.6%   24054387 =C2=B1  2%  softirqs.CPU18.NET_R=
X
> >   32127509           -24.5%   24258223        softirqs.CPU19.NET_RX
> >   32217120           -25.2%   24089001        softirqs.CPU2.NET_RX
> >   31415502 =C2=B1  3%     -22.5%   24349881        softirqs.CPU20.NET_R=
X
> >   32186243           -25.0%   24137967        softirqs.CPU21.NET_RX
> >   32271735           -26.9%   23586468 =C2=B1  2%  softirqs.CPU22.NET_R=
X
> >   31871656 =C2=B1  3%     -23.8%   24292511        softirqs.CPU23.NET_R=
X
> >   32321894           -25.2%   24177260        softirqs.CPU24.NET_RX
> >   31969188           -24.7%   24057006        softirqs.CPU25.NET_RX
> >   30938777           -27.7%   22360933 =C2=B1  2%  softirqs.CPU26.NET_R=
X
> >   30118051 =C2=B1  3%     -25.9%   22321500 =C2=B1  2%  softirqs.CPU27.=
NET_RX
> >   31079253           -28.1%   22337317 =C2=B1  2%  softirqs.CPU28.NET_R=
X
> >   31429166           -27.6%   22746093 =C2=B1  2%  softirqs.CPU29.NET_R=
X
> >   30485045 =C2=B1  3%     -20.5%   24221128 =C2=B1  2%  softirqs.CPU3.N=
ET_RX
> >   30912223 =C2=B1  2%     -26.8%   22622183 =C2=B1  2%  softirqs.CPU30.=
NET_RX
> >   31357027           -27.6%   22717601        softirqs.CPU31.NET_RX
> >   31052178           -27.3%   22565776 =C2=B1  2%  softirqs.CPU32.NET_R=
X
> >   31101262           -28.2%   22323348 =C2=B1  2%  softirqs.CPU33.NET_R=
X
> >   31331660           -27.7%   22656208        softirqs.CPU34.NET_RX
> >   30833278 =C2=B1  3%     -25.4%   22998777        softirqs.CPU35.NET_R=
X
> >   30738161 =C2=B1  3%     -25.2%   22998898        softirqs.CPU36.NET_R=
X
> >   30881460 =C2=B1  4%     -26.6%   22671426        softirqs.CPU37.NET_R=
X
> >   31140748           -27.4%   22621903        softirqs.CPU38.NET_RX
> >   31218654           -27.3%   22684067        softirqs.CPU39.NET_RX
> >   32583070           -24.8%   24513384        softirqs.CPU4.NET_RX
> >   31462139           -28.4%   22517351        softirqs.CPU40.NET_RX
> >   31566697           -27.9%   22768461        softirqs.CPU41.NET_RX
> >   30975279 =C2=B1  2%     -27.2%   22555119        softirqs.CPU42.NET_R=
X
> >   30718280 =C2=B1  3%     -26.2%   22661320 =C2=B1  2%  softirqs.CPU43.=
NET_RX
> >   31283332           -27.3%   22740697        softirqs.CPU44.NET_RX
> >   30983467           -26.4%   22794814        softirqs.CPU45.NET_RX
> >   30658730 =C2=B1  4%     -28.4%   21946934 =C2=B1  2%  softirqs.CPU46.=
NET_RX
> >   31181856           -26.5%   22929226        softirqs.CPU47.NET_RX
> >   31037938 =C2=B1  2%     -26.9%   22691892 =C2=B1  2%  softirqs.CPU48.=
NET_RX
> >   30911500 =C2=B1  2%     -26.3%   22777693        softirqs.CPU49.NET_R=
X
> >   31802923 =C2=B1  3%     -23.9%   24204592        softirqs.CPU5.NET_RX
> >   31517206           -28.1%   22648510        softirqs.CPU50.NET_RX
> >   30660453 =C2=B1  3%     -27.2%   22327925 =C2=B1  2%  softirqs.CPU51.=
NET_RX
> >   31819962 =C2=B1  2%     -23.9%   24206194        softirqs.CPU52.NET_R=
X
> >   32142649           -26.4%   23668373 =C2=B1  2%  softirqs.CPU53.NET_R=
X
> >   32149559           -24.2%   24360340        softirqs.CPU54.NET_RX
> >   32425853           -26.4%   23854082 =C2=B1  2%  softirqs.CPU55.NET_R=
X
> >   31817157 =C2=B1  2%     -24.3%   24096785        softirqs.CPU56.NET_R=
X
> >   31640490 =C2=B1  3%     -24.4%   23920278 =C2=B1  2%  softirqs.CPU57.=
NET_RX
> >   31650729 =C2=B1  3%     -23.1%   24327421        softirqs.CPU58.NET_R=
X
> >   31269148 =C2=B1  3%     -22.3%   24307789        softirqs.CPU59.NET_R=
X
> >   31030416 =C2=B1  4%     -22.0%   24203694        softirqs.CPU6.NET_RX
> >   32255424           -25.2%   24141973 =C2=B1  2%  softirqs.CPU60.NET_R=
X
> >   32245715           -25.1%   24167151 =C2=B1  2%  softirqs.CPU61.NET_R=
X
> >   31763163 =C2=B1  2%     -23.1%   24415760        softirqs.CPU62.NET_R=
X
> >   31632095 =C2=B1  3%     -22.7%   24451397        softirqs.CPU63.NET_R=
X
> >   31490930 =C2=B1  2%     -24.2%   23879322        softirqs.CPU64.NET_R=
X
> >   31516754 =C2=B1  3%     -23.5%   24108737        softirqs.CPU65.NET_R=
X
> >   32359236           -24.5%   24440756        softirqs.CPU66.NET_RX
> >   31784935 =C2=B1  3%     -23.9%   24195033 =C2=B1  2%  softirqs.CPU67.=
NET_RX
> >   30967426 =C2=B1  4%     -21.8%   24208434        softirqs.CPU68.NET_R=
X
> >   32208978           -27.9%   23223363        softirqs.CPU69.NET_RX
> >   31534273 =C2=B1  3%     -23.6%   24083955        softirqs.CPU7.NET_RX
> >   31800791 =C2=B1  2%     -23.3%   24375677        softirqs.CPU70.NET_R=
X
> >   31511220 =C2=B1  3%     -23.1%   24225232        softirqs.CPU71.NET_R=
X
> >   32055308           -25.2%   23985501 =C2=B1  2%  softirqs.CPU72.NET_R=
X
> >   32255683           -24.3%   24425926        softirqs.CPU73.NET_RX
> >   31808226 =C2=B1  2%     -23.7%   24280351 =C2=B1  2%  softirqs.CPU74.=
NET_RX
> >   31994746 =C2=B1  3%     -25.5%   23828432 =C2=B1  2%  softirqs.CPU75.=
NET_RX
> >   31732779 =C2=B1  3%     -24.0%   24121773 =C2=B1  2%  softirqs.CPU76.=
NET_RX
> >   31249558 =C2=B1  2%     -23.8%   23816726 =C2=B1  2%  softirqs.CPU77.=
NET_RX
> >   29102709 =C2=B1  3%     -24.1%   22087804 =C2=B1  2%  softirqs.CPU78.=
NET_RX
> >   31050911           -26.3%   22879670        softirqs.CPU79.NET_RX
> >   32385972           -25.5%   24114907        softirqs.CPU8.NET_RX
> >   31250746           -26.8%   22865137        softirqs.CPU80.NET_RX
> >   30970512 =C2=B1  3%     -27.5%   22460428 =C2=B1  2%  softirqs.CPU81.=
NET_RX
> >   30769035 =C2=B1  3%     -26.4%   22640114        softirqs.CPU82.NET_R=
X
> >   31163906           -28.0%   22426881 =C2=B1  2%  softirqs.CPU83.NET_R=
X
> >   30833151 =C2=B1  2%     -26.9%   22535706        softirqs.CPU84.NET_R=
X
> >   31213448           -27.8%   22530613 =C2=B1  2%  softirqs.CPU85.NET_R=
X
> >   31299014           -27.8%   22598945 =C2=B1  2%  softirqs.CPU86.NET_R=
X
> >   31380574           -26.8%   22966556        softirqs.CPU87.NET_RX
> >   31419156           -26.9%   22966072        softirqs.CPU88.NET_RX
> >   31485946           -29.0%   22360125 =C2=B1  2%  softirqs.CPU89.NET_R=
X
> >   32266157           -25.9%   23914440 =C2=B1  2%  softirqs.CPU9.NET_RX
> >   30336933 =C2=B1  3%     -25.9%   22489963        softirqs.CPU90.NET_R=
X
> >   30595348 =C2=B1  3%     -26.1%   22614928        softirqs.CPU91.NET_R=
X
> >   30924249 =C2=B1  2%     -26.0%   22894665        softirqs.CPU92.NET_R=
X
> >   30593902 =C2=B1  2%     -24.8%   23001426        softirqs.CPU93.NET_R=
X
> >   31556110           -29.2%   22330354 =C2=B1  2%  softirqs.CPU94.NET_R=
X
> >   30668287 =C2=B1  3%     -29.0%   21759470        softirqs.CPU95.NET_R=
X
> >   31245897           -26.9%   22847267        softirqs.CPU96.NET_RX
> >   31136421           -28.7%   22213048 =C2=B1  2%  softirqs.CPU97.NET_R=
X
> >   30013471 =C2=B1  4%     -23.9%   22844117        softirqs.CPU98.NET_R=
X
> >   31291344           -28.5%   22378868 =C2=B1  2%  softirqs.CPU99.NET_R=
X
> >  3.269e+09           -25.6%  2.431e+09        softirqs.NET_RX
> >
> >
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >
> >
> > Thanks,
> > Rong Chen
> >
