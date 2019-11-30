Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0740CC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08A12084D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhJ5Ugou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfK3UXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:23:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35872 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3UXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 15:23:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id f16so25037901lfm.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wrbV0tXjZHEOzs4EMoyLutxrJA68+pwcUuq338OygqY=;
        b=DhJ5UgouHItJkSWwJ96XBXLDJBegedwVsS76zhAQLklYKPvuQdBDH6q/V7iMZ2DLH+
         xhBVd2gLfV8VvCDl0u0flJw/lVv9eIX7+hnX/xXWGBzlRu5N0uVX41RKmOLWpLmOPFs7
         l++pXmb7hv3hRsJCkohMSenzqsjtKdoiIcM4NdwgZSwYai5cLLtfMNkFKazJGIxYsL8e
         I5y7NN4jV82/KEudMhJ4bPqZiRE/cMhOqZuxiEX2Vf/VBQ1hGSFSSeIGJBJ42TGOxtcR
         KjyXsKVU54fClzQGKja2VUyR1MYETUFJtaWZdZQvtMUDWXkxxD3d4KSjyEIPMca3V6Sv
         CYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wrbV0tXjZHEOzs4EMoyLutxrJA68+pwcUuq338OygqY=;
        b=ePyM+DQraZPuSyHOU5r8yTq7pybisRbS2w10Y0/YPp4CePudEcNyWU9kmJUVsKBRhz
         H1f7VAP6zC6014FqT80dwsh1ekHjSMWboG3c+dXqKhtSpd3vtT5AAvGoc8Ud2yV2b2QD
         seajJeS6WHcTSZUHh2ZFC7lirSWdTGWwTUF9xyMMbWE9HdSNMjqc1z6pwf887AyWTz5t
         f2jaj+9vUuOZoCTG1lsOvvfneDGOXOwY+30au7AbTDoWWasfOzWohUo0RAeWl5iQDcu8
         E1Ldknd0tZQZJtwDQIcP+9k5wr8pt2SEKUmAu6izc45e4ogRnEsVeMn7bZU+NATz3eGF
         n4DQ==
X-Gm-Message-State: APjAAAXbg4RM7eb9EpZVk3P1oJaOg8wp4uTmNA9/AXfOyDwoStZl4R5O
        GYPfcb5gKNMmdw2gOMz9Afisnofe27biB6QbUeA=
X-Google-Smtp-Source: APXvYqw1WfCTmnzaDVgxB1OjlwqNV6T0xFO5CRvBSDC7wuEULohl4+v3jNMeZVx7kiwZXJqL5wY0xg5H8WglhvWclmY=
X-Received: by 2002:ac2:51a6:: with SMTP id f6mr28026773lfk.174.1575145398792;
 Sat, 30 Nov 2019 12:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20191127005312.GD20422@shao2-debian>
In-Reply-To: <20191127005312.GD20422@shao2-debian>
Reply-To: mceier@gmail.com
From:   Mariusz Ceier <mceier@gmail.com>
Date:   Sat, 30 Nov 2019 20:23:07 +0000
Message-ID: <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
Subject: Re: [x86/mm/pat] 8d04a5f97a: phoronix-test-suite.glmark2.0.score
 -23.7% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can also confirm this - just bisected framebuffer rendering
performance regression on amdgpu and
8d04a5f97a5fa9d7afdf46eda3a5ceaa973a1bcc is the first bad commit
(leading to drop from around 260-300fps to about 60fps in CS:GO on
Fury X).

PS. Sorry for duplicate email (sending plain text only now, hopefully).

On Wed, 27 Nov 2019 at 00:56, kernel test robot <rong.a.chen@intel.com> wro=
te:
>
> Greeting,
>
> FYI, we noticed a -23.7% regression of phoronix-test-suite.glmark2.0.scor=
e due to commit:
>
>
> commit: 8d04a5f97a5fa9d7afdf46eda3a5ceaa973a1bcc ("x86/mm/pat: Convert th=
e PAT tree to a generic interval tree")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: phoronix-test-suite
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with=
 192G memory
> with following parameters:
>
>         need_x: true
>         test: glmark2-1.1.0
>         cpufreq_governor: performance
>         ucode: 0x500002b
>
> test-description: The Phoronix Test Suite is the most comprehensive testi=
ng and benchmarking platform available that provides an extensible framewor=
k for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
------------------------+
> | testcase: change | phoronix-test-suite: phoronix-test-suite.gtkperf.0.s=
econds 26.8% regression |
> | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz =
with 192G memory        |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                          |
> |                  | need_x=3Dtrue                                       =
                          |
> |                  | test=3Dgtkperf-1.2.1                                =
                          |
> |                  | ucode=3D0x500002b                                   =
                          |
> +------------------+-----------------------------------------------------=
------------------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/need_x/rootfs/tbox_group/test/testcase/=
ucode:
>   gcc-7/performance/x86_64-rhel-7.6/true/debian-x86_64-phoronix/lkp-csl-2=
sp8/glmark2-1.1.0/phoronix-test-suite/0x500002b
>
> commit:
>   9f4813b531 (" Linux 5.4-rc8")
>   8d04a5f97a ("x86/mm/pat: Convert the PAT tree to a generic interval tre=
e")
>
> 9f4813b531a0b8cc 8d04a5f97a5fa9d7afdf46eda3a
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           1:4          -25%            :4     dmesg.WARNING:at#for_ip_swa=
pgs_restore_regs_and_return_to_usermode/0x
>           2:4          -50%            :4     dmesg.WARNING:stack_recursi=
on
>          %stddev     %change         %stddev
>              \          |                \
>     290.50           -23.7%     221.75 =C2=B1  4%  phoronix-test-suite.gl=
mark2.0.score
>     210.25           -24.1%     159.50 =C2=B1  4%  phoronix-test-suite.gl=
mark2.1.score
>      35084           -19.8%      28122 =C2=B1  3%  vmstat.system.cs
>      16157            +1.6%      16415        proc-vmstat.nr_kernel_stack
>      17551            +2.0%      17909        proc-vmstat.nr_slab_reclaim=
able
>      46846            +2.4%      47962        proc-vmstat.nr_slab_unrecla=
imable
>     156401 =C2=B1 15%     -19.5%     125917 =C2=B1 11%  proc-vmstat.numa_=
hint_faults_local
>    2091859            -2.4%    2041250 =C2=B1  2%  proc-vmstat.pgfault
>      72.57 =C2=B1  2%     -10.0       62.61 =C2=B1 19%  perf-profile.call=
trace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_st=
artup_entry
>       1.25 =C2=B1  8%      -0.5        0.79 =C2=B1 58%  perf-profile.call=
trace.cycles-pp.irq_enter.smp_apic_timer_interrupt.apic_timer_interrupt.cpu=
idle_enter_state.cpuidle_enter
>       1.04 =C2=B1 10%      -0.4        0.66 =C2=B1 58%  perf-profile.call=
trace.cycles-pp.tick_irq_enter.irq_enter.smp_apic_timer_interrupt.apic_time=
r_interrupt.cpuidle_enter_state
>      72.70 =C2=B1  2%      -9.9       62.81 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.intel_idle
>       1.28 =C2=B1  8%      -0.3        0.94 =C2=B1 30%  perf-profile.chil=
dren.cycles-pp.irq_enter
>       1.08 =C2=B1  9%      -0.3        0.78 =C2=B1 28%  perf-profile.chil=
dren.cycles-pp.tick_irq_enter
>       0.47 =C2=B1 14%      -0.2        0.32 =C2=B1 39%  perf-profile.chil=
dren.cycles-pp.rcu_sched_clock_irq
>       0.48 =C2=B1  4%      -0.1        0.37 =C2=B1 32%  perf-profile.chil=
dren.cycles-pp.futex_wait_queue_me
>       0.16 =C2=B1 11%      -0.1        0.06 =C2=B1 63%  perf-profile.chil=
dren.cycles-pp.perf_event_task_tick
>       0.20 =C2=B1  5%      -0.1        0.10 =C2=B1 62%  perf-profile.chil=
dren.cycles-pp.rb_next
>       0.11 =C2=B1 15%      -0.1        0.03 =C2=B1100%  perf-profile.chil=
dren.cycles-pp.switch_mm_irqs_off
>       0.18 =C2=B1  7%      -0.1        0.10 =C2=B1 61%  perf-profile.chil=
dren.cycles-pp.update_ts_time_stats
>      72.59 =C2=B1  2%      -9.8       62.77 =C2=B1 19%  perf-profile.self=
.cycles-pp.intel_idle
>       0.16 =C2=B1 14%      -0.1        0.06 =C2=B1 63%  perf-profile.self=
.cycles-pp.perf_event_task_tick
>       0.18 =C2=B1  6%      -0.1        0.10 =C2=B1 65%  perf-profile.self=
.cycles-pp.rb_next
>   26427524           -30.2%   18439861 =C2=B1 11%  perf-stat.i.branch-mis=
ses
>  1.264e+08           -32.7%   85112641 =C2=B1 15%  perf-stat.i.cache-refe=
rences
>      35249           -19.8%      28261 =C2=B1  3%  perf-stat.i.context-sw=
itches
>    1663983 =C2=B1 10%     -47.0%     881904 =C2=B1 41%  perf-stat.i.dTLB-=
load-misses
>   2.55e+09 =C2=B1  3%     -29.5%  1.799e+09 =C2=B1 13%  perf-stat.i.dTLB-=
loads
>  1.123e+09 =C2=B1  2%      -6.9%  1.046e+09 =C2=B1  3%  perf-stat.i.dTLB-=
stores
>  1.112e+10           -15.7%  9.376e+09 =C2=B1  4%  perf-stat.i.instructio=
ns
>       6700           -21.1%       5289 =C2=B1  7%  perf-stat.i.instructio=
ns-per-iTLB-miss
>      92755 =C2=B1  4%      -5.2%      87901        perf-stat.i.node-loads
>       6929           -20.3%       5525 =C2=B1  7%  perf-stat.overall.inst=
ructions-per-iTLB-miss
>   26388462           -30.2%   18414499 =C2=B1 11%  perf-stat.ps.branch-mi=
sses
>  1.262e+08           -32.7%   84986397 =C2=B1 15%  perf-stat.ps.cache-ref=
erences
>      35191           -19.8%      28218 =C2=B1  3%  perf-stat.ps.context-s=
witches
>    1661390 =C2=B1 10%     -47.0%     880613 =C2=B1 41%  perf-stat.ps.dTLB=
-load-misses
>  2.546e+09 =C2=B1  3%     -29.4%  1.796e+09 =C2=B1 13%  perf-stat.ps.dTLB=
-loads
>  1.122e+09 =C2=B1  2%      -6.8%  1.045e+09 =C2=B1  3%  perf-stat.ps.dTLB=
-stores
>  1.111e+10           -15.7%  9.362e+09 =C2=B1  4%  perf-stat.ps.instructi=
ons
>      92587 =C2=B1  4%      -5.2%      87778        perf-stat.ps.node-load=
s
>  7.805e+12           -16.3%  6.535e+12 =C2=B1  4%  perf-stat.total.instru=
ctions
>     421893 =C2=B1 13%     -33.5%     280495 =C2=B1 17%  numa-meminfo.node=
0.Active
>     301962 =C2=B1 18%     -24.7%     227271 =C2=B1  3%  numa-meminfo.node=
0.Active(anon)
>     119930           -55.6%      53224 =C2=B1 75%  numa-meminfo.node0.Act=
ive(file)
>     289371 =C2=B1 19%     -23.6%     220986 =C2=B1  3%  numa-meminfo.node=
0.AnonPages
>    1599232           -46.1%     861252 =C2=B1 63%  numa-meminfo.node0.Fil=
ePages
>    1467294           -45.5%     800320 =C2=B1 63%  numa-meminfo.node0.Ina=
ctive
>     406871           -60.9%     159255 =C2=B1 92%  numa-meminfo.node0.Ina=
ctive(file)
>      10042 =C2=B1  2%     -14.2%       8615 =C2=B1 12%  numa-meminfo.node=
0.KernelStack
>     109027           -67.1%      35838 =C2=B1 78%  numa-meminfo.node0.Map=
ped
>    2488468 =C2=B1  2%     -36.4%    1582090 =C2=B1 41%  numa-meminfo.node=
0.MemUsed
>       4081 =C2=B1  3%     -53.1%       1913 =C2=B1 56%  numa-meminfo.node=
0.PageTables
>     169752 =C2=B1  3%     -15.8%     143010 =C2=B1 19%  numa-meminfo.node=
0.Slab
>     183294 =C2=B1 31%     +78.6%     327336 =C2=B1 16%  numa-meminfo.node=
1.Active
>     176459 =C2=B1 32%     +44.1%     254351 =C2=B1  4%  numa-meminfo.node=
1.Active(anon)
>       6834 =C2=B1 11%    +967.9%      72984 =C2=B1 57%  numa-meminfo.node=
1.Active(file)
>     171600 =C2=B1 33%     +42.0%     243637 =C2=B1  2%  numa-meminfo.node=
1.AnonPages
>      18539 =C2=B1  5%   +3986.1%     757532 =C2=B1 72%  numa-meminfo.node=
1.FilePages
>       6284 =C2=B1 14%  +10623.2%     673848 =C2=B1 75%  numa-meminfo.node=
1.Inactive
>       3812 =C2=B1 13%   +6513.3%     252099 =C2=B1 58%  numa-meminfo.node=
1.Inactive(file)
>       4526 =C2=B1 18%   +1622.5%      77962 =C2=B1 35%  numa-meminfo.node=
1.Mapped
>     477729 =C2=B1 11%    +190.4%    1387370 =C2=B1 48%  numa-meminfo.node=
1.MemUsed
>     704.00 =C2=B1 20%    +307.6%       2869 =C2=B1 37%  numa-meminfo.node=
1.PageTables
>      75486 =C2=B1 18%     -24.7%      56818 =C2=B1  3%  numa-vmstat.node0=
.nr_active_anon
>      29985           -55.6%      13304 =C2=B1 75%  numa-vmstat.node0.nr_a=
ctive_file
>      72338 =C2=B1 19%     -23.6%      55246 =C2=B1  3%  numa-vmstat.node0=
.nr_anon_pages
>     399807           -46.1%     215312 =C2=B1 63%  numa-vmstat.node0.nr_f=
ile_pages
>     101715           -60.9%      39814 =C2=B1 92%  numa-vmstat.node0.nr_i=
nactive_file
>      10043 =C2=B1  2%     -14.2%       8614 =C2=B1 12%  numa-vmstat.node0=
.nr_kernel_stack
>      27254           -67.1%       8959 =C2=B1 78%  numa-vmstat.node0.nr_m=
apped
>       1019 =C2=B1  3%     -53.2%     477.50 =C2=B1 56%  numa-vmstat.node0=
.nr_page_table_pages
>      75486 =C2=B1 18%     -24.7%      56818 =C2=B1  3%  numa-vmstat.node0=
.nr_zone_active_anon
>      29985           -55.6%      13304 =C2=B1 75%  numa-vmstat.node0.nr_z=
one_active_file
>     101715           -60.9%      39814 =C2=B1 92%  numa-vmstat.node0.nr_z=
one_inactive_file
>    1483935 =C2=B1  6%     -18.2%    1214502 =C2=B1 21%  numa-vmstat.node0=
.numa_local
>      44115 =C2=B1 32%     +44.2%      63599 =C2=B1  4%  numa-vmstat.node1=
.nr_active_anon
>       1708 =C2=B1 11%    +968.1%      18243 =C2=B1 57%  numa-vmstat.node1=
.nr_active_file
>      42900 =C2=B1 33%     +42.0%      60922 =C2=B1  2%  numa-vmstat.node1=
.nr_anon_pages
>       4635 =C2=B1  5%   +3985.9%     189382 =C2=B1 72%  numa-vmstat.node1=
.nr_file_pages
>     952.75 =C2=B1 13%   +6515.2%      63026 =C2=B1 58%  numa-vmstat.node1=
.nr_inactive_file
>       1131 =C2=B1 18%   +1623.5%      19492 =C2=B1 35%  numa-vmstat.node1=
.nr_mapped
>     176.00 =C2=B1 20%    +307.4%     717.00 =C2=B1 37%  numa-vmstat.node1=
.nr_page_table_pages
>      44115 =C2=B1 32%     +44.2%      63599 =C2=B1  4%  numa-vmstat.node1=
.nr_zone_active_anon
>       1708 =C2=B1 11%    +968.1%      18243 =C2=B1 57%  numa-vmstat.node1=
.nr_zone_active_file
>     952.75 =C2=B1 13%   +6515.2%      63026 =C2=B1 58%  numa-vmstat.node1=
.nr_zone_inactive_file
>       1546 =C2=B1  3%     +34.6%       2081 =C2=B1  6%  slabinfo.UNIX.act=
ive_objs
>       1546 =C2=B1  3%     +34.6%       2081 =C2=B1  6%  slabinfo.UNIX.num=
_objs
>       2089 =C2=B1  4%     +11.9%       2337 =C2=B1  7%  slabinfo.dmaengin=
e-unmap-16.active_objs
>       2089 =C2=B1  4%     +11.9%       2337 =C2=B1  7%  slabinfo.dmaengin=
e-unmap-16.num_objs
>      21286 =C2=B1  4%     +10.5%      23516 =C2=B1  5%  slabinfo.filp.act=
ive_objs
>      21594 =C2=B1  4%     +10.8%      23932 =C2=B1  4%  slabinfo.filp.num=
_objs
>       3632 =C2=B1  7%     +15.4%       4190 =C2=B1  7%  slabinfo.mnt_cach=
e.active_objs
>       3632 =C2=B1  7%     +15.4%       4190 =C2=B1  7%  slabinfo.mnt_cach=
e.num_objs
>       3343 =C2=B1  4%     +23.1%       4116 =C2=B1  7%  slabinfo.numa_pol=
icy.active_objs
>       3343 =C2=B1  4%     +23.1%       4116 =C2=B1  7%  slabinfo.numa_pol=
icy.num_objs
>       5711 =C2=B1  3%     +10.0%       6282 =C2=B1  4%  slabinfo.ovl_inod=
e.active_objs
>       5711 =C2=B1  3%     +10.0%       6282 =C2=B1  4%  slabinfo.ovl_inod=
e.num_objs
>       2143 =C2=B1  4%     +15.8%       2481 =C2=B1  7%  slabinfo.pool_wor=
kqueue.active_objs
>       2143 =C2=B1  4%     +15.8%       2481 =C2=B1  7%  slabinfo.pool_wor=
kqueue.num_objs
>       2309 =C2=B1  8%     +14.7%       2648 =C2=B1  6%  slabinfo.skbuff_e=
xt_cache.active_objs
>       2309 =C2=B1  8%     +14.7%       2648 =C2=B1  6%  slabinfo.skbuff_e=
xt_cache.num_objs
>       2785 =C2=B1  3%     +21.8%       3390 =C2=B1  4%  slabinfo.sock_ino=
de_cache.active_objs
>       2785 =C2=B1  3%     +21.8%       3390 =C2=B1  4%  slabinfo.sock_ino=
de_cache.num_objs
>       1300 =C2=B1  3%     +15.3%       1500 =C2=B1  8%  slabinfo.task_gro=
up.active_objs
>       1300 =C2=B1  3%     +15.3%       1500 =C2=B1  8%  slabinfo.task_gro=
up.num_objs
>     471.00 =C2=B1 12%     -33.1%     315.25 =C2=B1 31%  slabinfo.xfrm_sta=
te.active_objs
>     471.00 =C2=B1 12%     -33.1%     315.25 =C2=B1 31%  slabinfo.xfrm_sta=
te.num_objs
>      15189 =C2=B1  4%     -16.9%      12626 =C2=B1  4%  sched_debug.cfs_r=
q:/.exec_clock.avg
>      54802 =C2=B1  5%     -20.8%      43426 =C2=B1  7%  sched_debug.cfs_r=
q:/.load.avg
>      59.91 =C2=B1 51%     -38.0%      37.16 =C2=B1  5%  sched_debug.cfs_r=
q:/.load_avg.avg
>       2493 =C2=B1112%     -68.5%     784.19 =C2=B1  3%  sched_debug.cfs_r=
q:/.load_avg.max
>     320.29 =C2=B1 88%     -55.3%     143.18 =C2=B1  2%  sched_debug.cfs_r=
q:/.load_avg.stddev
>      68001 =C2=B1  4%     -12.7%      59359 =C2=B1  3%  sched_debug.cfs_r=
q:/.min_vruntime.avg
>      67912           -18.0%      55681 =C2=B1  8%  sched_debug.cfs_rq:/.m=
in_vruntime.stddev
>       0.11 =C2=B1  5%     -26.6%       0.08 =C2=B1  7%  sched_debug.cfs_r=
q:/.nr_running.avg
>       0.30 =C2=B1  2%     -11.0%       0.27 =C2=B1  3%  sched_debug.cfs_r=
q:/.nr_running.stddev
>      28.47 =C2=B1  6%     -16.1%      23.89 =C2=B1  6%  sched_debug.cfs_r=
q:/.runnable_load_avg.avg
>     754.35 =C2=B1  4%      -8.9%     687.54 =C2=B1  6%  sched_debug.cfs_r=
q:/.runnable_load_avg.max
>     127.97 =C2=B1  4%     -10.0%     115.24 =C2=B1  6%  sched_debug.cfs_r=
q:/.runnable_load_avg.stddev
>      54698 =C2=B1  5%     -20.6%      43419 =C2=B1  7%  sched_debug.cfs_r=
q:/.runnable_weight.avg
>      44849 =C2=B1 15%     -52.5%      21314 =C2=B1 60%  sched_debug.cfs_r=
q:/.spread0.avg
>      67914           -18.0%      55682 =C2=B1  8%  sched_debug.cfs_rq:/.s=
pread0.stddev
>     110.05 =C2=B1  2%     -20.3%      87.72 =C2=B1  2%  sched_debug.cfs_r=
q:/.util_avg.avg
>      22.41 =C2=B1  9%     -27.7%      16.21 =C2=B1 10%  sched_debug.cfs_r=
q:/.util_est_enqueued.avg
>       0.05 =C2=B1  4%     -10.7%       0.05 =C2=B1  4%  sched_debug.cpu.n=
r_running.avg
>     134130           -20.1%     107139 =C2=B1  3%  sched_debug.cpu.nr_swi=
tches.avg
>     764365 =C2=B1  4%     -25.1%     572854 =C2=B1  5%  sched_debug.cpu.n=
r_switches.max
>     212569 =C2=B1  2%     -22.1%     165622 =C2=B1  8%  sched_debug.cpu.n=
r_switches.stddev
>     131734           -20.5%     104682 =C2=B1  3%  sched_debug.cpu.sched_=
count.avg
>     760935 =C2=B1  5%     -25.2%     569239 =C2=B1  5%  sched_debug.cpu.s=
ched_count.max
>     212271 =C2=B1  2%     -22.0%     165483 =C2=B1  8%  sched_debug.cpu.s=
ched_count.stddev
>      65857           -20.5%      52334 =C2=B1  3%  sched_debug.cpu.sched_=
goidle.avg
>     380419 =C2=B1  5%     -25.2%     284602 =C2=B1  5%  sched_debug.cpu.s=
ched_goidle.max
>     106128 =C2=B1  2%     -22.0%      82735 =C2=B1  8%  sched_debug.cpu.s=
ched_goidle.stddev
>      65779           -20.6%      52253 =C2=B1  3%  sched_debug.cpu.ttwu_c=
ount.avg
>     164575 =C2=B1  4%     -15.1%     139787 =C2=B1 12%  sched_debug.cpu.t=
twu_count.stddev
>     925.77           +14.7%       1061 =C2=B1  4%  sched_debug.cpu.ttwu_l=
ocal.avg
>      95.00 =C2=B1 81%     -96.3%       3.50 =C2=B1 91%  interrupts.48:PCI=
-MSI.31981581-edge.i40e-eth0-TxRx-12
>      81.00 =C2=B1150%    -100.0%       0.00        interrupts.59:PCI-MSI.=
31981592-edge.i40e-eth0-TxRx-23
>       0.00       +4.9e+105%       4915 =C2=B1172%  interrupts.76:PCI-MSI.=
31981609-edge.i40e-eth0-TxRx-40
>      71.75 =C2=B1167%     -99.7%       0.25 =C2=B1173%  interrupts.82:PCI=
-MSI.31981615-edge.i40e-eth0-TxRx-46
>       1278 =C2=B1 29%   +1192.4%      16520 =C2=B1127%  interrupts.CPU1.R=
ES:Rescheduling_interrupts
>     410.50 =C2=B1 26%     -94.5%      22.50 =C2=B1173%  interrupts.CPU10.=
TLB:TLB_shootdowns
>      95.00 =C2=B1 81%     -97.4%       2.50 =C2=B1128%  interrupts.CPU12.=
48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
>     218.50 =C2=B1 82%     -91.5%      18.50 =C2=B1173%  interrupts.CPU12.=
TLB:TLB_shootdowns
>       1142           -64.1%     409.75 =C2=B1 92%  interrupts.CPU13.NMI:N=
on-maskable_interrupts
>       1142           -64.1%     409.75 =C2=B1 92%  interrupts.CPU13.PMI:P=
erformance_monitoring_interrupts
>      11287 =C2=B1167%     -98.6%     154.00 =C2=B1163%  interrupts.CPU13.=
RES:Rescheduling_interrupts
>       1141 =C2=B1  2%     -49.4%     578.00 =C2=B1 72%  interrupts.CPU15.=
NMI:Non-maskable_interrupts
>       1141 =C2=B1  2%     -49.4%     578.00 =C2=B1 72%  interrupts.CPU15.=
PMI:Performance_monitoring_interrupts
>       1124 =C2=B1  2%     -67.4%     366.75 =C2=B1115%  interrupts.CPU16.=
NMI:Non-maskable_interrupts
>       1124 =C2=B1  2%     -67.4%     366.75 =C2=B1115%  interrupts.CPU16.=
PMI:Performance_monitoring_interrupts
>     315.50 =C2=B1 62%     -69.3%      96.75 =C2=B1173%  interrupts.CPU17.=
TLB:TLB_shootdowns
>     137.25 =C2=B1 63%     -96.5%       4.75 =C2=B1161%  interrupts.CPU18.=
TLB:TLB_shootdowns
>     160.00 =C2=B1170%     -99.5%       0.75 =C2=B1110%  interrupts.CPU2.3=
8:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
>     506.25 =C2=B1 30%     -77.4%     114.50 =C2=B1 84%  interrupts.CPU2.T=
LB:TLB_shootdowns
>     241.25 =C2=B1 78%     -99.1%       2.25 =C2=B1173%  interrupts.CPU21.=
TLB:TLB_shootdowns
>     295.00 =C2=B1 56%     -79.1%      61.75 =C2=B1169%  interrupts.CPU22.=
TLB:TLB_shootdowns
>     723.25 =C2=B1 63%     -84.0%     116.00 =C2=B1167%  interrupts.CPU23.=
RES:Rescheduling_interrupts
>      24258 =C2=B1 60%     -96.5%     848.00 =C2=B1  5%  interrupts.CPU24.=
RES:Rescheduling_interrupts
>     254.75 =C2=B1 27%    +109.6%     534.00 =C2=B1 54%  interrupts.CPU24.=
TLB:TLB_shootdowns
>     124.25 =C2=B1 75%    +178.5%     346.00 =C2=B1 32%  interrupts.CPU25.=
TLB:TLB_shootdowns
>      70.00 =C2=B1173%    +362.9%     324.00 =C2=B1 89%  interrupts.CPU27.=
TLB:TLB_shootdowns
>      41.75 =C2=B1 84%  +1.9e+05%      77527 =C2=B1171%  interrupts.CPU28.=
RES:Rescheduling_interrupts
>       1088 =C2=B1 22%  +12337.9%     135324 =C2=B1 82%  interrupts.CPU3.R=
ES:Rescheduling_interrupts
>     546.00 =C2=B1 39%     -87.0%      71.25 =C2=B1 68%  interrupts.CPU4.T=
LB:TLB_shootdowns
>      26.25 =C2=B1 65%   +2721.0%     740.50 =C2=B1 82%  interrupts.CPU43.=
RES:Rescheduling_interrupts
>       4.50 =C2=B1104%   +8927.8%     406.25 =C2=B1 92%  interrupts.CPU47.=
TLB:TLB_shootdowns
>       1154 =C2=B1172%     -99.9%       1.50 =C2=B1137%  interrupts.CPU48.=
84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
>     435.50 =C2=B1 70%     -98.5%       6.75 =C2=B1 92%  interrupts.CPU48.=
RES:Rescheduling_interrupts
>     504.50 =C2=B1 62%     -99.8%       1.25 =C2=B1131%  interrupts.CPU49.=
RES:Rescheduling_interrupts
>     180.25 =C2=B1 72%    -100.0%       0.00        interrupts.CPU49.TLB:T=
LB_shootdowns
>       1605 =C2=B1 69%     -79.6%     327.75 =C2=B1 70%  interrupts.CPU5.N=
MI:Non-maskable_interrupts
>       1605 =C2=B1 69%     -79.6%     327.75 =C2=B1 70%  interrupts.CPU5.P=
MI:Performance_monitoring_interrupts
>     527.00 =C2=B1  8%     -96.6%      17.75 =C2=B1173%  interrupts.CPU5.T=
LB:TLB_shootdowns
>       1248 =C2=B1 44%     -77.9%     276.25 =C2=B1 84%  interrupts.CPU53.=
NMI:Non-maskable_interrupts
>       1248 =C2=B1 44%     -77.9%     276.25 =C2=B1 84%  interrupts.CPU53.=
PMI:Performance_monitoring_interrupts
>     613.00 =C2=B1100%     -99.5%       3.25 =C2=B1 88%  interrupts.CPU54.=
RES:Rescheduling_interrupts
>     165.50 =C2=B1 98%     -96.5%       5.75 =C2=B1173%  interrupts.CPU54.=
TLB:TLB_shootdowns
>     577.75 =C2=B1111%     -99.7%       1.75 =C2=B1116%  interrupts.CPU55.=
RES:Rescheduling_interrupts
>     668.25 =C2=B1 76%     -46.1%     360.50 =C2=B1123%  interrupts.CPU56.=
NMI:Non-maskable_interrupts
>     668.25 =C2=B1 76%     -46.1%     360.50 =C2=B1123%  interrupts.CPU56.=
PMI:Performance_monitoring_interrupts
>     390.50 =C2=B1111%     -87.8%      47.75 =C2=B1168%  interrupts.CPU56.=
RES:Rescheduling_interrupts
>     134.50 =C2=B1 64%     -74.2%      34.75 =C2=B1173%  interrupts.CPU56.=
TLB:TLB_shootdowns
>     356.50 =C2=B1 96%     -94.5%      19.50 =C2=B1 73%  interrupts.CPU59.=
RES:Rescheduling_interrupts
>      77.25 =C2=B1 57%     -99.0%       0.75 =C2=B1173%  interrupts.CPU59.=
TLB:TLB_shootdowns
>       1004 =C2=B1 24%     -62.6%     376.25 =C2=B1106%  interrupts.CPU61.=
NMI:Non-maskable_interrupts
>       1004 =C2=B1 24%     -62.6%     376.25 =C2=B1106%  interrupts.CPU61.=
PMI:Performance_monitoring_interrupts
>       1181 =C2=B1 34%     -96.8%      38.25 =C2=B1143%  interrupts.CPU61.=
RES:Rescheduling_interrupts
>     379.00 =C2=B1 65%     -97.8%       8.50 =C2=B1173%  interrupts.CPU61.=
TLB:TLB_shootdowns
>       2301 =C2=B1140%     -99.7%       6.50 =C2=B1 86%  interrupts.CPU62.=
RES:Rescheduling_interrupts
>      95.75 =C2=B1 59%     -92.4%       7.25 =C2=B1173%  interrupts.CPU62.=
TLB:TLB_shootdowns
>     433.75 =C2=B1 83%     -98.4%       6.75 =C2=B1139%  interrupts.CPU63.=
RES:Rescheduling_interrupts
>     103.00 =C2=B1 56%     -92.5%       7.75 =C2=B1173%  interrupts.CPU63.=
TLB:TLB_shootdowns
>     994.50 =C2=B1 23%     -62.2%     376.25 =C2=B1113%  interrupts.CPU64.=
NMI:Non-maskable_interrupts
>     994.50 =C2=B1 23%     -62.2%     376.25 =C2=B1113%  interrupts.CPU64.=
PMI:Performance_monitoring_interrupts
>     512.75 =C2=B1 65%     -98.2%       9.25 =C2=B1137%  interrupts.CPU64.=
RES:Rescheduling_interrupts
>     151.00 =C2=B1 61%     -99.7%       0.50 =C2=B1173%  interrupts.CPU64.=
TLB:TLB_shootdowns
>       1008 =C2=B1 44%     -94.9%      51.50 =C2=B1100%  interrupts.CPU67.=
RES:Rescheduling_interrupts
>     242.25 =C2=B1 79%     -96.0%       9.75 =C2=B1155%  interrupts.CPU67.=
TLB:TLB_shootdowns
>     779.50 =C2=B1 75%     -98.8%       9.50 =C2=B1126%  interrupts.CPU68.=
RES:Rescheduling_interrupts
>       1059 =C2=B1 43%     -93.1%      73.25 =C2=B1109%  interrupts.CPU69.=
RES:Rescheduling_interrupts
>     246.00 =C2=B1104%     -93.1%      17.00 =C2=B1173%  interrupts.CPU69.=
TLB:TLB_shootdowns
>       1054 =C2=B1152%     -98.1%      20.00 =C2=B1161%  interrupts.CPU7.R=
ES:Rescheduling_interrupts
>      66.00 =C2=B1 66%     -90.9%       6.00 =C2=B1173%  interrupts.CPU7.T=
LB:TLB_shootdowns
>       1056 =C2=B1 24%     -94.3%      59.75 =C2=B1125%  interrupts.CPU70.=
RES:Rescheduling_interrupts
>     224.75 =C2=B1 69%     -89.5%      23.50 =C2=B1163%  interrupts.CPU70.=
TLB:TLB_shootdowns
>       0.00       +1.1e+104%     107.00 =C2=B1 93%  interrupts.CPU72.TLB:T=
LB_shootdowns
>       9.00 =C2=B1137%   +3747.2%     346.25 =C2=B1 96%  interrupts.CPU73.=
RES:Rescheduling_interrupts
>       0.00       +2.3e+104%     230.00 =C2=B1133%  interrupts.CPU74.TLB:T=
LB_shootdowns
>       0.00       +1.6e+104%     165.00 =C2=B1 51%  interrupts.CPU75.TLB:T=
LB_shootdowns
>     537.75 =C2=B1 26%     -90.2%      52.50 =C2=B1113%  interrupts.CPU8.T=
LB:TLB_shootdowns
>       0.00       +9.8e+103%      97.50 =C2=B1 67%  interrupts.CPU83.TLB:T=
LB_shootdowns
>       0.00         +2e+104%     198.00 =C2=B1 49%  interrupts.CPU85.TLB:T=
LB_shootdowns
>      13.25 =C2=B1 59%    +809.4%     120.50 =C2=B1 75%  interrupts.CPU88.=
RES:Rescheduling_interrupts
>       5593 =C2=B1 51%     -93.2%     380.50 =C2=B1160%  interrupts.CPU9.R=
ES:Rescheduling_interrupts
>       0.75 =C2=B1 57%  +31033.3%     233.50 =C2=B1 89%  interrupts.CPU93.=
RES:Rescheduling_interrupts
>       0.50 =C2=B1100%  +47100.0%     236.00 =C2=B1115%  interrupts.CPU94.=
RES:Rescheduling_interrupts
>      16.25 =C2=B1169%   +3118.5%     523.00 =C2=B1 78%  interrupts.CPU95.=
RES:Rescheduling_interrupts
>       2.00 =C2=B1173%   +8037.5%     162.75 =C2=B1 67%  interrupts.CPU95.=
TLB:TLB_shootdowns
>      49869 =C2=B1  7%     +94.1%      96790 =C2=B1 11%  softirqs.CPU0.RCU
>      51718 =C2=B1  6%     +67.2%      86459 =C2=B1 11%  softirqs.CPU1.RCU
>      51281 =C2=B1  5%     +92.7%      98810 =C2=B1  7%  softirqs.CPU10.RC=
U
>      49686 =C2=B1 12%     +95.1%      96913 =C2=B1 11%  softirqs.CPU11.RC=
U
>      51222 =C2=B1  6%     +95.4%     100111 =C2=B1 11%  softirqs.CPU12.RC=
U
>      50980 =C2=B1  6%     +99.1%     101505 =C2=B1  6%  softirqs.CPU13.RC=
U
>      51046 =C2=B1  7%     +98.3%     101207 =C2=B1  6%  softirqs.CPU14.RC=
U
>      45578 =C2=B1 21%    +116.5%      98669 =C2=B1  8%  softirqs.CPU15.RC=
U
>      44168 =C2=B1  7%     +99.2%      87963 =C2=B1 11%  softirqs.CPU16.RC=
U
>      41610 =C2=B1  9%    +119.4%      91301 =C2=B1 13%  softirqs.CPU17.RC=
U
>      43759 =C2=B1  8%    +110.7%      92217 =C2=B1 11%  softirqs.CPU18.RC=
U
>      42902 =C2=B1  8%    +109.1%      89698 =C2=B1 10%  softirqs.CPU19.RC=
U
>      52217 =C2=B1  5%     +94.3%     101454 =C2=B1  5%  softirqs.CPU2.RCU
>      42704 =C2=B1  5%    +114.8%      91744 =C2=B1 10%  softirqs.CPU20.RC=
U
>      44910 =C2=B1  7%    +102.1%      90783 =C2=B1 10%  softirqs.CPU22.RC=
U
>      44991 =C2=B1  7%    +104.7%      92096 =C2=B1 11%  softirqs.CPU23.RC=
U
>      47098 =C2=B1 12%     +92.3%      90567 =C2=B1  9%  softirqs.CPU24.RC=
U
>     106586 =C2=B1  6%     -11.9%      93907 =C2=B1  3%  softirqs.CPU24.SC=
HED
>      42456 =C2=B1 12%     +99.8%      84830 =C2=B1  8%  softirqs.CPU25.RC=
U
>      47709 =C2=B1  6%     +82.9%      87250 =C2=B1 10%  softirqs.CPU26.RC=
U
>      50970 =C2=B1 13%     +73.4%      88408 =C2=B1 12%  softirqs.CPU27.RC=
U
>      51241 =C2=B1 13%     +67.2%      85676 =C2=B1 15%  softirqs.CPU28.RC=
U
>      50293 =C2=B1 13%     +80.0%      90528 =C2=B1 10%  softirqs.CPU29.RC=
U
>      53868 =C2=B1  4%     +84.6%      99454 =C2=B1 10%  softirqs.CPU3.RCU
>      44947 =C2=B1 14%     +98.9%      89421 =C2=B1  8%  softirqs.CPU31.RC=
U
>      54210 =C2=B1 19%     +86.6%     101147 =C2=B1  5%  softirqs.CPU32.RC=
U
>      58728 =C2=B1 15%     +70.0%      99864 =C2=B1  9%  softirqs.CPU33.RC=
U
>      55716 =C2=B1 18%     +87.2%     104278 =C2=B1  5%  softirqs.CPU34.RC=
U
>      58583 =C2=B1 15%     +77.6%     104065 =C2=B1  5%  softirqs.CPU35.RC=
U
>      58080 =C2=B1 14%     +82.0%     105718 =C2=B1  5%  softirqs.CPU36.RC=
U
>      50595 =C2=B1 12%     +95.7%      99025 =C2=B1  4%  softirqs.CPU37.RC=
U
>      53939 =C2=B1 13%     +82.0%      98153 =C2=B1  4%  softirqs.CPU38.RC=
U
>      53424 =C2=B1 14%     +90.6%     101817 =C2=B1  6%  softirqs.CPU39.RC=
U
>      52327 =C2=B1  5%     +96.8%     102971 =C2=B1  4%  softirqs.CPU4.RCU
>      54501 =C2=B1 14%     +87.8%     102330 =C2=B1  7%  softirqs.CPU40.RC=
U
>      53036 =C2=B1 35%     +92.4%     102050 =C2=B1  4%  softirqs.CPU41.RC=
U
>      60492 =C2=B1 14%     +69.9%     102761 =C2=B1  2%  softirqs.CPU42.RC=
U
>      57222 =C2=B1 15%     +69.7%      97101 =C2=B1  5%  softirqs.CPU43.RC=
U
>      58535 =C2=B1 14%     +76.2%     103127 =C2=B1  5%  softirqs.CPU44.RC=
U
>      57025 =C2=B1 14%     +76.3%     100515 =C2=B1  6%  softirqs.CPU45.RC=
U
>      60244 =C2=B1 17%     +63.4%      98447 =C2=B1  7%  softirqs.CPU46.RC=
U
>      57985 =C2=B1 14%     +68.9%      97910 =C2=B1 12%  softirqs.CPU47.RC=
U
>      49462 =C2=B1  6%     +95.9%      96879 =C2=B1 11%  softirqs.CPU48.RC=
U
>      49436 =C2=B1  4%     +92.7%      95249 =C2=B1 12%  softirqs.CPU49.RC=
U
>      52413 =C2=B1  5%     +88.8%      98965 =C2=B1 11%  softirqs.CPU5.RCU
>      51032 =C2=B1  6%    +104.5%     104382 =C2=B1  7%  softirqs.CPU50.RC=
U
>      45684 =C2=B1 30%    +117.7%      99464 =C2=B1 15%  softirqs.CPU51.RC=
U
>      51919 =C2=B1  5%    +103.2%     105507 =C2=B1  6%  softirqs.CPU52.RC=
U
>      52420 =C2=B1  4%     +95.6%     102530 =C2=B1 12%  softirqs.CPU53.RC=
U
>      49538 =C2=B1  9%    +112.3%     105146 =C2=B1  7%  softirqs.CPU54.RC=
U
>      49883 =C2=B1  7%    +103.9%     101712 =C2=B1  9%  softirqs.CPU55.RC=
U
>      49604 =C2=B1  6%     +95.9%      97166 =C2=B1  9%  softirqs.CPU56.RC=
U
>      51798 =C2=B1  4%     +98.5%     102805 =C2=B1  6%  softirqs.CPU57.RC=
U
>      49777 =C2=B1  8%     +99.7%      99405 =C2=B1  7%  softirqs.CPU58.RC=
U
>      49338 =C2=B1 14%    +105.1%     101169 =C2=B1 11%  softirqs.CPU59.RC=
U
>      49653 =C2=B1 10%    +106.2%     102399 =C2=B1  6%  softirqs.CPU6.RCU
>      51134 =C2=B1  6%     +98.8%     101668 =C2=B1 11%  softirqs.CPU60.RC=
U
>      50488 =C2=B1  7%    +102.4%     102180 =C2=B1  7%  softirqs.CPU61.RC=
U
>      50078 =C2=B1  6%    +102.7%     101522 =C2=B1  6%  softirqs.CPU62.RC=
U
>      51026 =C2=B1  5%     +99.6%     101832 =C2=B1  8%  softirqs.CPU63.RC=
U
>      42895 =C2=B1  7%    +107.0%      88783 =C2=B1 13%  softirqs.CPU64.RC=
U
>      42387 =C2=B1 11%    +113.3%      90430 =C2=B1 11%  softirqs.CPU65.RC=
U
>      43746 =C2=B1  8%    +108.8%      91341 =C2=B1 12%  softirqs.CPU66.RC=
U
>      40324 =C2=B1 12%    +121.3%      89240 =C2=B1 11%  softirqs.CPU67.RC=
U
>      41900 =C2=B1  6%    +114.6%      89917 =C2=B1 11%  softirqs.CPU68.RC=
U
>      44157 =C2=B1  7%    +104.3%      90228 =C2=B1 11%  softirqs.CPU69.RC=
U
>      50551 =C2=B1  9%     +97.0%      99596 =C2=B1  8%  softirqs.CPU7.RCU
>      44094 =C2=B1  7%    +107.9%      91683 =C2=B1 13%  softirqs.CPU70.RC=
U
>      44086 =C2=B1  7%    +106.8%      91179 =C2=B1 11%  softirqs.CPU71.RC=
U
>      46488 =C2=B1 15%     +90.2%      88422 =C2=B1  8%  softirqs.CPU72.RC=
U
>      42653 =C2=B1 12%     +99.2%      84953 =C2=B1  9%  softirqs.CPU73.RC=
U
>      48559 =C2=B1 12%     +76.5%      85713 =C2=B1 12%  softirqs.CPU74.RC=
U
>      51770 =C2=B1 16%     +73.0%      89572 =C2=B1  9%  softirqs.CPU75.RC=
U
>      50182 =C2=B1 14%     +72.4%      86513 =C2=B1 14%  softirqs.CPU76.RC=
U
>      50446 =C2=B1 14%     +77.7%      89651 =C2=B1 10%  softirqs.CPU77.RC=
U
>      49119 =C2=B1 13%     +84.9%      90818 =C2=B1  8%  softirqs.CPU78.RC=
U
>      45781 =C2=B1 15%     +93.5%      88595 =C2=B1  8%  softirqs.CPU79.RC=
U
>      50229 =C2=B1  6%     +96.4%      98632 =C2=B1  7%  softirqs.CPU8.RCU
>      45155 =C2=B1 36%    +128.7%     103272 =C2=B1  5%  softirqs.CPU80.RC=
U
>      58487 =C2=B1 14%     +77.0%     103508 =C2=B1  6%  softirqs.CPU81.RC=
U
>      55666 =C2=B1 18%     +87.0%     104094 =C2=B1  5%  softirqs.CPU82.RC=
U
>      58506 =C2=B1 14%     +77.7%     103963 =C2=B1  5%  softirqs.CPU83.RC=
U
>      58416 =C2=B1 14%     +80.3%     105297 =C2=B1  6%  softirqs.CPU84.RC=
U
>      51291 =C2=B1 12%     +95.8%     100447 =C2=B1  4%  softirqs.CPU85.RC=
U
>      54557 =C2=B1 13%     +82.1%      99356 =C2=B1  4%  softirqs.CPU86.RC=
U
>      54147 =C2=B1 13%     +89.8%     102754 =C2=B1  6%  softirqs.CPU87.RC=
U
>      55853 =C2=B1 14%     +82.1%     101688 =C2=B1  6%  softirqs.CPU88.RC=
U
>      59176 =C2=B1 16%     +70.8%     101077 =C2=B1  5%  softirqs.CPU89.RC=
U
>      52291 =C2=B1  6%     +93.8%     101344 =C2=B1  5%  softirqs.CPU9.RCU
>      60854 =C2=B1 15%     +69.0%     102864 =C2=B1  2%  softirqs.CPU90.RC=
U
>      57902 =C2=B1 12%     +70.1%      98501 =C2=B1  4%  softirqs.CPU91.RC=
U
>      59683 =C2=B1 15%     +73.3%     103419 =C2=B1  5%  softirqs.CPU92.RC=
U
>      57459 =C2=B1 14%     +78.5%     102584 =C2=B1  6%  softirqs.CPU93.RC=
U
>      59398 =C2=B1 13%     +63.2%      96927 =C2=B1  8%  softirqs.CPU94.RC=
U
>      56576 =C2=B1 15%     +76.2%      99664 =C2=B1 11%  softirqs.CPU95.RC=
U
>       5123 =C2=B1 16%    +168.1%      13739 =C2=B1  7%  softirqs.NET_RX
>    4882876 =C2=B1 10%     +90.1%    9282598 =C2=B1  6%  softirqs.RCU
>
>
>
>                         phoronix-test-suite.glmark2.0.score
>
>   300 +-+----------------------------------------------------------------=
---+
>       |  :     +.    +..+    +.       +..+.             +.      +        =
   |
>   250 +-+:                                                               =
   |
>       O :   O  O  O  O    O  O  O  O  O  O     O     O     O             =
   O
>       | :O              O                   O     O     O    O  O  O  O  =
O  |
>   200 +-+                                                                =
   |
>       | :                                                                =
   |
>   150 +-+                                                                =
   |
>       |:                                                                 =
   |
>   100 +-+                                                                =
   |
>       |:                                                                 =
   |
>       |:                                                                 =
   |
>    50 +-+                                                                =
   |
>       |                                                                  =
   |
>     0 +-+----------------------------------------------------------------=
---+
>
>
>                         phoronix-test-suite.glmark2.1.score
>
>   250 +-+----------------------------------------------------------------=
---+
>       |                                                                  =
   |
>       |  +..+..+..+..+..+.+..+..+..  .+..+..+..+..+..+..+..+.+..+        =
   |
>   200 +-+:                         +.                                    =
   |
>       |  :                               O                 O             =
   O
>       O :O  O  O  O  O  O O  O  O  O  O     O  O  O  O  O    O  O  O  O  =
O  |
>   150 +-+                                                                =
   |
>       | :                                                                =
   |
>   100 +-+                                                                =
   |
>       |:                                                                 =
   |
>       |:                                                                 =
   |
>    50 +-+                                                                =
   |
>       |:                                                                 =
   |
>       |                                                                  =
   |
>     0 +-+----------------------------------------------------------------=
---+
>
>
> [*] bisect-good sample
> [O] bisect-bad  sample
>
> *************************************************************************=
**************************
> lkp-csl-2sp8: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 19=
2G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/need_x/rootfs/tbox_group/test/testcase/=
ucode:
>   gcc-7/performance/x86_64-rhel-7.6/true/debian-x86_64-phoronix/lkp-csl-2=
sp8/gtkperf-1.2.1/phoronix-test-suite/0x500002b
>
> commit:
>   9f4813b531 (" Linux 5.4-rc8")
>   8d04a5f97a ("x86/mm/pat: Convert the PAT tree to a generic interval tre=
e")
>
> 9f4813b531a0b8cc 8d04a5f97a5fa9d7afdf46eda3a
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      10.34           +26.8%      13.11 =C2=B1  5%  phoronix-test-suite.gt=
kperf.0.seconds
>      62.29           +13.3%      70.56 =C2=B1  2%  phoronix-test-suite.ti=
me.elapsed_time
>      62.29           +13.3%      70.56 =C2=B1  2%  phoronix-test-suite.ti=
me.elapsed_time.max
>      46875           -12.5%      41002 =C2=B1  3%  meminfo.max_used_kB
>      29.85           +39.6%      41.68 =C2=B1 22%  boot-time.boot
>       2433           +48.7%       3617 =C2=B1 25%  boot-time.idle
>       1628           -11.4%       1442 =C2=B1  4%  vmstat.io.bi
>       9046           -11.6%       7993 =C2=B1  2%  vmstat.system.cs
>  1.954e+09 =C2=B1 69%    +226.7%  6.384e+09 =C2=B1  6%  cpuidle.C1E.time
>    6278082 =C2=B1 33%     +94.4%   12207082 =C2=B1 16%  cpuidle.C1E.usage
>  3.958e+09 =C2=B1 32%     -93.8%  2.444e+08 =C2=B1 10%  cpuidle.C6.time
>    5684464           -95.4%     262692 =C2=B1 13%  cpuidle.C6.usage
>       8.34 =C2=B1100%      -8.3        0.00        perf-profile.calltrace=
.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       8.34 =C2=B1100%      -8.3        0.00        perf-profile.calltrace=
.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hw=
frame
>       8.34 =C2=B1100%      -8.3        0.00        perf-profile.calltrace=
.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL=
_64_after_hwframe
>       5.28 =C2=B1100%      -3.2        2.08 =C2=B1173%  perf-profile.call=
trace.cycles-pp.mmput.do_exit.do_group_exit.get_signal.do_signal
>       5.28 =C2=B1100%      -3.2        2.08 =C2=B1173%  perf-profile.call=
trace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.get_signal
>       8.34 =C2=B1100%      -8.3        0.00        perf-profile.children.=
cycles-pp.do_sys_open
>       8.34 =C2=B1100%      -8.3        0.00        perf-profile.children.=
cycles-pp.do_filp_open
>       8.34 =C2=B1100%      -8.3        0.00        perf-profile.children.=
cycles-pp.path_openat
>       5.28 =C2=B1100%      -3.2        2.08 =C2=B1173%  perf-profile.chil=
dren.cycles-pp.mmput
>       5.28 =C2=B1100%      -3.2        2.08 =C2=B1173%  perf-profile.chil=
dren.cycles-pp.exit_mmap
>      17.00 =C2=B1 13%    +230.9%      56.25 =C2=B1 29%  sched_debug.cfs_r=
q:/.runnable_load_avg.max
>       3.87 =C2=B1 17%     +73.5%       6.71 =C2=B1 22%  sched_debug.cfs_r=
q:/.runnable_load_avg.stddev
>      25.25 =C2=B1 12%     -22.4%      19.58 =C2=B1 20%  sched_debug.cfs_r=
q:/.util_est_enqueued.avg
>      34397           +44.4%      49658 =C2=B1 29%  sched_debug.cpu.clock.=
avg
>      34402           +44.4%      49663 =C2=B1 29%  sched_debug.cpu.clock.=
max
>      34391           +44.4%      49654 =C2=B1 29%  sched_debug.cpu.clock.=
min
>      34397           +44.4%      49658 =C2=B1 29%  sched_debug.cpu.clock_=
task.avg
>      34402           +44.4%      49663 =C2=B1 29%  sched_debug.cpu.clock_=
task.max
>      34391           +44.4%      49654 =C2=B1 29%  sched_debug.cpu.clock_=
task.min
>       9.74 =C2=B1  5%     -11.5%       8.62 =C2=B1  4%  sched_debug.cpu.n=
r_uninterruptible.stddev
>      34393           +44.4%      49654 =C2=B1 29%  sched_debug.cpu_clk
>      31537           +48.4%      46795 =C2=B1 31%  sched_debug.ktime
>      34725           +44.0%      49988 =C2=B1 29%  sched_debug.sched_clk
>      96262            +2.1%      98322        proc-vmstat.nr_active_anon
>      29673            +1.4%      30100        proc-vmstat.nr_active_file
>      94407            +2.3%      96570        proc-vmstat.nr_anon_pages
>       1082            +1.5%       1099        proc-vmstat.nr_page_table_p=
ages
>      96262            +2.1%      98322        proc-vmstat.nr_zone_active_=
anon
>      29673            +1.4%      30100        proc-vmstat.nr_zone_active_=
file
>       7664 =C2=B1 27%    +172.9%      20912 =C2=B1 38%  proc-vmstat.numa_=
hint_faults
>       7507 =C2=B1 27%    +124.1%      16824 =C2=B1 38%  proc-vmstat.numa_=
hint_faults_local
>     328182            +5.9%     347387 =C2=B1  4%  proc-vmstat.numa_hit
>     309363            +6.2%     328630 =C2=B1  4%  proc-vmstat.numa_local
>      39400 =C2=B1 35%     +90.3%      74971 =C2=B1 42%  proc-vmstat.numa_=
pte_updates
>     370297            +7.5%     398082 =C2=B1  4%  proc-vmstat.pgalloc_no=
rmal
>     278665           +12.0%     312075 =C2=B1  4%  proc-vmstat.pgfault
>     269968 =C2=B1  2%     +10.9%     299343 =C2=B1  5%  proc-vmstat.pgfre=
e
>      16.26 =C2=B1 53%     -51.0%       7.96 =C2=B1  2%  perf-stat.i.MPKI
>  8.359e+08 =C2=B1  2%     -12.0%  7.355e+08 =C2=B1  5%  perf-stat.i.branc=
h-instructions
>       3.78 =C2=B1 21%      -1.0        2.76 =C2=B1  9%  perf-stat.i.branc=
h-miss-rate%
>   30272546 =C2=B1 11%     -25.3%   22600376 =C2=B1 15%  perf-stat.i.branc=
h-misses
>    1870084 =C2=B1  6%     -59.7%     752958 =C2=B1 15%  perf-stat.i.cache=
-misses
>   47650854 =C2=B1 37%     -46.3%   25593693 =C2=B1  2%  perf-stat.i.cache=
-references
>       9360           -12.3%       8208 =C2=B1  2%  perf-stat.i.context-sw=
itches
>  6.312e+09 =C2=B1  6%     -15.0%  5.364e+09 =C2=B1  2%  perf-stat.i.cpu-c=
ycles
>       3783 =C2=B1  9%    +176.2%      10448 =C2=B1 18%  perf-stat.i.cycle=
s-between-cache-misses
>       0.16 =C2=B1 40%      -0.1        0.01 =C2=B1 16%  perf-stat.i.dTLB-=
load-miss-rate%
>     921731 =C2=B1 27%     -87.9%     111653 =C2=B1 10%  perf-stat.i.dTLB-=
load-misses
>       0.05 =C2=B1 32%      -0.0        0.01 =C2=B1 21%  perf-stat.i.dTLB-=
store-miss-rate%
>     157895 =C2=B1 26%     -82.3%      28003 =C2=B1 22%  perf-stat.i.dTLB-=
store-misses
>      41.55 =C2=B1  4%      -3.5       38.06        perf-stat.i.iTLB-load-=
miss-rate%
>  3.826e+09 =C2=B1  2%     -11.9%  3.372e+09 =C2=B1  6%  perf-stat.i.instr=
uctions
>       9.33           -13.3%       8.09 =C2=B1  3%  perf-stat.i.major-faul=
ts
>      12.54 =C2=B1 38%     -39.3%       7.61 =C2=B1  5%  perf-stat.overall=
.MPKI
>       3.63 =C2=B1 13%      -0.6        3.06 =C2=B1 10%  perf-stat.overall=
.branch-miss-rate%
>       4.51 =C2=B1 35%      -1.6        2.94 =C2=B1 14%  perf-stat.overall=
.cache-miss-rate%
>       3391 =C2=B1 10%    +113.9%       7255 =C2=B1 12%  perf-stat.overall=
.cycles-between-cache-misses
>       0.10 =C2=B1 33%      -0.1        0.01 =C2=B1 14%  perf-stat.overall=
.dTLB-load-miss-rate%
>       0.04 =C2=B1 26%      -0.0        0.01 =C2=B1 23%  perf-stat.overall=
.dTLB-store-miss-rate%
>   8.23e+08 =C2=B1  2%     -11.9%  7.253e+08 =C2=B1  5%  perf-stat.ps.bran=
ch-instructions
>   29792047 =C2=B1 11%     -25.2%   22290398 =C2=B1 15%  perf-stat.ps.bran=
ch-misses
>    1841339 =C2=B1  6%     -59.6%     743171 =C2=B1 15%  perf-stat.ps.cach=
e-misses
>   46876977 =C2=B1 37%     -46.2%   25232671 =C2=B1  2%  perf-stat.ps.cach=
e-references
>       9205           -12.1%       8091 =C2=B1  2%  perf-stat.ps.context-s=
witches
>  6.211e+09 =C2=B1  6%     -14.8%  5.289e+09 =C2=B1  2%  perf-stat.ps.cpu-=
cycles
>     907015 =C2=B1 27%     -87.9%     110123 =C2=B1 10%  perf-stat.ps.dTLB=
-load-misses
>     155379 =C2=B1 26%     -82.2%      27623 =C2=B1 22%  perf-stat.ps.dTLB=
-store-misses
>  3.766e+09 =C2=B1  2%     -11.7%  3.325e+09 =C2=B1  6%  perf-stat.ps.inst=
ructions
>       9.21           -13.4%       7.98 =C2=B1  3%  perf-stat.ps.major-fau=
lts
>      16348 =C2=B1  5%     +33.4%      21802 =C2=B1  5%  softirqs.CPU0.SCH=
ED
>      11186 =C2=B1 15%     +37.7%      15406 =C2=B1 16%  softirqs.CPU1.SCH=
ED
>       9914 =C2=B1  8%     +48.9%      14762 =C2=B1 30%  softirqs.CPU10.SC=
HED
>       9645 =C2=B1  2%     +21.1%      11681 =C2=B1  4%  softirqs.CPU11.SC=
HED
>       9779 =C2=B1  3%     +17.1%      11450 =C2=B1  7%  softirqs.CPU13.SC=
HED
>       9805 =C2=B1  3%     +12.6%      11040 =C2=B1  6%  softirqs.CPU14.SC=
HED
>       9658 =C2=B1  2%     +25.3%      12104 =C2=B1 10%  softirqs.CPU15.SC=
HED
>      31797 =C2=B1  7%     +23.0%      39108 =C2=B1 14%  softirqs.CPU16.TI=
MER
>       9330 =C2=B1  6%     +29.9%      12116 =C2=B1  4%  softirqs.CPU17.SC=
HED
>      31554 =C2=B1 10%     +16.1%      36648 =C2=B1  6%  softirqs.CPU17.TI=
MER
>       9493 =C2=B1  4%     +21.9%      11574 =C2=B1  6%  softirqs.CPU18.SC=
HED
>       9700 =C2=B1  2%     +61.1%      15631 =C2=B1 47%  softirqs.CPU19.SC=
HED
>      10097 =C2=B1  4%     +20.7%      12186        softirqs.CPU2.SCHED
>       9731 =C2=B1  2%     +18.3%      11516 =C2=B1  3%  softirqs.CPU20.SC=
HED
>       9664 =C2=B1  3%     +18.1%      11413 =C2=B1  4%  softirqs.CPU21.SC=
HED
>       9810 =C2=B1  3%     +12.3%      11013 =C2=B1  6%  softirqs.CPU22.SC=
HED
>       9509 =C2=B1  3%     +20.0%      11407 =C2=B1  4%  softirqs.CPU23.SC=
HED
>       9355 =C2=B1  9%     +23.8%      11581 =C2=B1  8%  softirqs.CPU26.SC=
HED
>      34990           +24.1%      43413 =C2=B1  6%  softirqs.CPU26.TIMER
>       9577 =C2=B1  8%     +20.8%      11569 =C2=B1  4%  softirqs.CPU27.SC=
HED
>       9920 =C2=B1  2%     +15.5%      11462 =C2=B1  6%  softirqs.CPU28.SC=
HED
>      10084           +13.1%      11409 =C2=B1  4%  softirqs.CPU29.SCHED
>      30741 =C2=B1 10%     +27.7%      39262 =C2=B1  8%  softirqs.CPU3.TIM=
ER
>       9843           +18.7%      11688 =C2=B1  6%  softirqs.CPU30.SCHED
>       8609 =C2=B1 21%     +33.6%      11503 =C2=B1  4%  softirqs.CPU32.SC=
HED
>       9714 =C2=B1  2%     +22.8%      11927 =C2=B1  7%  softirqs.CPU33.SC=
HED
>       9695           +18.1%      11445 =C2=B1  5%  softirqs.CPU34.SCHED
>       8242 =C2=B1 30%     +39.4%      11488 =C2=B1  6%  softirqs.CPU35.SC=
HED
>       8035 =C2=B1 30%     +40.4%      11280 =C2=B1  5%  softirqs.CPU37.SC=
HED
>       9880           +17.7%      11627 =C2=B1  6%  softirqs.CPU46.SCHED
>       8892 =C2=B1  9%     +26.4%      11243 =C2=B1  8%  softirqs.CPU47.SC=
HED
>       9244 =C2=B1  7%     +16.8%      10799 =C2=B1  3%  softirqs.CPU49.SC=
HED
>       9617           +18.4%      11389 =C2=B1  3%  softirqs.CPU50.SCHED
>      31719 =C2=B1  7%     +12.5%      35691 =C2=B1  5%  softirqs.CPU50.TI=
MER
>       9366 =C2=B1  5%     +16.5%      10911 =C2=B1  3%  softirqs.CPU51.SC=
HED
>       9929 =C2=B1  3%     +22.9%      12207 =C2=B1  7%  softirqs.CPU53.SC=
HED
>       8616 =C2=B1 13%     +41.5%      12194 =C2=B1 10%  softirqs.CPU54.SC=
HED
>       9500 =C2=B1  3%     +15.4%      10962        softirqs.CPU55.SCHED
>      32014 =C2=B1  9%     +20.3%      38529 =C2=B1 15%  softirqs.CPU56.TI=
MER
>       9732 =C2=B1  6%     +16.2%      11310 =C2=B1  4%  softirqs.CPU59.SC=
HED
>       9628 =C2=B1  2%     +21.5%      11699 =C2=B1 10%  softirqs.CPU60.SC=
HED
>      10026 =C2=B1  5%     +10.9%      11124 =C2=B1  6%  softirqs.CPU62.SC=
HED
>       9585           +14.5%      10972 =C2=B1  8%  softirqs.CPU63.SCHED
>       9541 =C2=B1  3%     +21.4%      11586 =C2=B1 16%  softirqs.CPU64.SC=
HED
>       9035 =C2=B1 10%     +17.1%      10577 =C2=B1  7%  softirqs.CPU65.SC=
HED
>       9483 =C2=B1  2%     +20.2%      11401 =C2=B1  5%  softirqs.CPU66.SC=
HED
>       9026 =C2=B1 12%     +23.4%      11134 =C2=B1  4%  softirqs.CPU68.SC=
HED
>       9482 =C2=B1  2%     +13.8%      10787 =C2=B1  5%  softirqs.CPU69.SC=
HED
>       9658 =C2=B1  2%     +20.4%      11624 =C2=B1  4%  softirqs.CPU7.SCH=
ED
>       9764 =C2=B1  3%     +11.0%      10836 =C2=B1  5%  softirqs.CPU70.SC=
HED
>       9316 =C2=B1 11%     +18.8%      11072 =C2=B1 12%  softirqs.CPU74.SC=
HED
>       9963           +12.3%      11189 =C2=B1  6%  softirqs.CPU75.SCHED
>      10017           +14.1%      11425 =C2=B1  7%  softirqs.CPU76.SCHED
>       9788           +18.4%      11588 =C2=B1  5%  softirqs.CPU77.SCHED
>       9968           +16.3%      11591 =C2=B1  7%  softirqs.CPU78.SCHED
>       9911 =C2=B1  2%     +16.6%      11555 =C2=B1  5%  softirqs.CPU79.SC=
HED
>       9408 =C2=B1  2%     +19.7%      11258 =C2=B1  7%  softirqs.CPU80.SC=
HED
>      10027 =C2=B1  4%     +11.3%      11164 =C2=B1  5%  softirqs.CPU81.SC=
HED
>       9638 =C2=B1  3%     +14.3%      11019 =C2=B1  7%  softirqs.CPU82.SC=
HED
>       9551 =C2=B1  2%     +15.0%      10981 =C2=B1  8%  softirqs.CPU83.SC=
HED
>       9583 =C2=B1  4%     +18.8%      11389 =C2=B1  6%  softirqs.CPU84.SC=
HED
>       8173 =C2=B1 29%     +34.4%      10989 =C2=B1  7%  softirqs.CPU86.SC=
HED
>       9936 =C2=B1  4%     +14.8%      11410 =C2=B1  6%  softirqs.CPU9.SCH=
ED
>       8179 =C2=B1 30%     +37.6%      11257 =C2=B1 10%  softirqs.CPU91.SC=
HED
>       8077 =C2=B1 30%     +39.1%      11233 =C2=B1  8%  softirqs.CPU95.SC=
HED
>     919351 =C2=B1  7%     +19.9%    1102697 =C2=B1  4%  softirqs.SCHED
>    3193255 =C2=B1  2%     +11.6%    3563915 =C2=B1  6%  softirqs.TIMER
>      33.00 =C2=B1147%    -100.0%       0.00        interrupts.52:PCI-MSI.=
31981585-edge.i40e-eth0-TxRx-16
>     127.00           +15.4%     146.50 =C2=B1  3%  interrupts.9:IO-APIC.9=
-fasteoi.acpi
>     124159 =C2=B1  3%     +16.5%     144587 =C2=B1  3%  interrupts.CPU0.L=
OC:Local_timer_interrupts
>     127.00           +15.4%     146.50 =C2=B1  3%  interrupts.CPU1.9:IO-A=
PIC.9-fasteoi.acpi
>     123924 =C2=B1  3%     +16.7%     144656 =C2=B1  2%  interrupts.CPU1.L=
OC:Local_timer_interrupts
>     123637 =C2=B1  3%     +16.2%     143635 =C2=B1  4%  interrupts.CPU10.=
LOC:Local_timer_interrupts
>     123785 =C2=B1  3%     +15.3%     142755 =C2=B1  3%  interrupts.CPU11.=
LOC:Local_timer_interrupts
>     123691 =C2=B1  3%     +16.3%     143829 =C2=B1  3%  interrupts.CPU12.=
LOC:Local_timer_interrupts
>     123545 =C2=B1  3%     +15.7%     142970 =C2=B1  3%  interrupts.CPU13.=
LOC:Local_timer_interrupts
>     123726 =C2=B1  3%     +16.2%     143718 =C2=B1  3%  interrupts.CPU14.=
LOC:Local_timer_interrupts
>     123727 =C2=B1  3%     +15.2%     142493 =C2=B1  2%  interrupts.CPU15.=
LOC:Local_timer_interrupts
>     123761 =C2=B1  3%     +16.7%     144390 =C2=B1  3%  interrupts.CPU16.=
LOC:Local_timer_interrupts
>     123749 =C2=B1  3%     +16.9%     144632 =C2=B1  3%  interrupts.CPU17.=
LOC:Local_timer_interrupts
>     123660 =C2=B1  3%     +16.9%     144533 =C2=B1  3%  interrupts.CPU18.=
LOC:Local_timer_interrupts
>     123976 =C2=B1  3%     +17.0%     145106 =C2=B1  3%  interrupts.CPU19.=
LOC:Local_timer_interrupts
>     123983 =C2=B1  3%     +16.8%     144764 =C2=B1  3%  interrupts.CPU2.L=
OC:Local_timer_interrupts
>     123783 =C2=B1  3%     +16.7%     144400 =C2=B1  3%  interrupts.CPU20.=
LOC:Local_timer_interrupts
>     123924 =C2=B1  3%     +16.5%     144405 =C2=B1  3%  interrupts.CPU21.=
LOC:Local_timer_interrupts
>     124054 =C2=B1  3%     +15.9%     143768 =C2=B1  3%  interrupts.CPU22.=
LOC:Local_timer_interrupts
>     124085 =C2=B1  3%     +15.7%     143543 =C2=B1  3%  interrupts.CPU23.=
LOC:Local_timer_interrupts
>     110004 =C2=B1 22%     +30.5%     143553 =C2=B1  4%  interrupts.CPU24.=
LOC:Local_timer_interrupts
>     110068 =C2=B1 22%     +29.7%     142727 =C2=B1  3%  interrupts.CPU25.=
LOC:Local_timer_interrupts
>     110942 =C2=B1 22%     +29.6%     143774 =C2=B1  2%  interrupts.CPU26.=
LOC:Local_timer_interrupts
>     111894 =C2=B1 22%     +28.3%     143555 =C2=B1  4%  interrupts.CPU27.=
LOC:Local_timer_interrupts
>     111050 =C2=B1 22%     +29.3%     143625 =C2=B1  4%  interrupts.CPU28.=
LOC:Local_timer_interrupts
>     111805 =C2=B1 22%     +27.5%     142570 =C2=B1  3%  interrupts.CPU29.=
LOC:Local_timer_interrupts
>     122901 =C2=B1  3%     +17.6%     144537 =C2=B1  3%  interrupts.CPU3.L=
OC:Local_timer_interrupts
>     111025 =C2=B1 22%     +29.5%     143752 =C2=B1  4%  interrupts.CPU30.=
LOC:Local_timer_interrupts
>     110372 =C2=B1 21%     +29.3%     142764 =C2=B1  3%  interrupts.CPU31.=
LOC:Local_timer_interrupts
>     110041 =C2=B1 22%     +30.2%     143294 =C2=B1  3%  interrupts.CPU32.=
LOC:Local_timer_interrupts
>     110289 =C2=B1 21%     +29.4%     142737 =C2=B1  3%  interrupts.CPU33.=
LOC:Local_timer_interrupts
>       0.75 =C2=B1110%   +4200.0%      32.25 =C2=B1143%  interrupts.CPU33.=
RES:Rescheduling_interrupts
>     111042 =C2=B1 22%     +28.7%     142872 =C2=B1  4%  interrupts.CPU34.=
LOC:Local_timer_interrupts
>     110820 =C2=B1 22%     +29.6%     143676 =C2=B1  4%  interrupts.CPU35.=
LOC:Local_timer_interrupts
>     110849 =C2=B1 22%     +29.9%     143999 =C2=B1  4%  interrupts.CPU36.=
LOC:Local_timer_interrupts
>     110376 =C2=B1 22%     +30.4%     143915 =C2=B1  3%  interrupts.CPU37.=
LOC:Local_timer_interrupts
>     111593 =C2=B1 22%     +29.0%     143915 =C2=B1  4%  interrupts.CPU38.=
LOC:Local_timer_interrupts
>     111949 =C2=B1 22%     +27.1%     142241 =C2=B1  4%  interrupts.CPU39.=
LOC:Local_timer_interrupts
>     124261 =C2=B1  3%     +15.7%     143828 =C2=B1  3%  interrupts.CPU4.L=
OC:Local_timer_interrupts
>     111554 =C2=B1 22%     +27.5%     142286 =C2=B1  4%  interrupts.CPU40.=
LOC:Local_timer_interrupts
>     110802 =C2=B1 22%     +29.1%     143047 =C2=B1  4%  interrupts.CPU41.=
LOC:Local_timer_interrupts
>     111642 =C2=B1 22%     +29.4%     144476 =C2=B1  4%  interrupts.CPU42.=
LOC:Local_timer_interrupts
>     110980 =C2=B1 22%     +29.3%     143450 =C2=B1  4%  interrupts.CPU43.=
LOC:Local_timer_interrupts
>     111595 =C2=B1 22%     +27.4%     142158 =C2=B1  4%  interrupts.CPU44.=
LOC:Local_timer_interrupts
>     110926 =C2=B1 22%     +28.8%     142914 =C2=B1  4%  interrupts.CPU45.=
LOC:Local_timer_interrupts
>     111788 =C2=B1 22%     +28.5%     143694 =C2=B1  4%  interrupts.CPU46.=
LOC:Local_timer_interrupts
>     110789 =C2=B1 22%     +29.2%     143182 =C2=B1  4%  interrupts.CPU47.=
LOC:Local_timer_interrupts
>     123853 =C2=B1  3%     +16.0%     143633 =C2=B1  3%  interrupts.CPU48.=
LOC:Local_timer_interrupts
>     123954 =C2=B1  3%     +16.1%     143915 =C2=B1  3%  interrupts.CPU49.=
LOC:Local_timer_interrupts
>     125940 =C2=B1  5%     +14.2%     143844 =C2=B1  2%  interrupts.CPU5.L=
OC:Local_timer_interrupts
>     122996 =C2=B1  3%     +16.9%     143771 =C2=B1  3%  interrupts.CPU50.=
LOC:Local_timer_interrupts
>     123469 =C2=B1  3%     +16.3%     143600 =C2=B1  3%  interrupts.CPU51.=
LOC:Local_timer_interrupts
>     122963 =C2=B1  2%     +16.8%     143584 =C2=B1  3%  interrupts.CPU52.=
LOC:Local_timer_interrupts
>     123920 =C2=B1  3%     +16.7%     144558 =C2=B1  3%  interrupts.CPU53.=
LOC:Local_timer_interrupts
>     123791 =C2=B1  3%     +16.7%     144460 =C2=B1  3%  interrupts.CPU54.=
LOC:Local_timer_interrupts
>     123877 =C2=B1  3%     +16.6%     144392 =C2=B1  3%  interrupts.CPU55.=
LOC:Local_timer_interrupts
>     123809 =C2=B1  3%     +16.4%     144159 =C2=B1  3%  interrupts.CPU56.=
LOC:Local_timer_interrupts
>     123506 =C2=B1  3%     +16.6%     144033 =C2=B1  3%  interrupts.CPU57.=
LOC:Local_timer_interrupts
>     123672 =C2=B1  3%     +17.7%     145596 =C2=B1  4%  interrupts.CPU58.=
LOC:Local_timer_interrupts
>     123454 =C2=B1  3%     +16.8%     144178 =C2=B1  3%  interrupts.CPU59.=
LOC:Local_timer_interrupts
>     123108 =C2=B1  4%     +17.5%     144649 =C2=B1  3%  interrupts.CPU6.L=
OC:Local_timer_interrupts
>     123692 =C2=B1  3%     +16.1%     143634 =C2=B1  3%  interrupts.CPU60.=
LOC:Local_timer_interrupts
>     123855 =C2=B1  3%     +15.5%     143073 =C2=B1  3%  interrupts.CPU61.=
LOC:Local_timer_interrupts
>     123714 =C2=B1  3%     +16.2%     143797 =C2=B1  3%  interrupts.CPU62.=
LOC:Local_timer_interrupts
>     123863 =C2=B1  3%     +16.0%     143707 =C2=B1  3%  interrupts.CPU63.=
LOC:Local_timer_interrupts
>     123875 =C2=B1  3%     +15.9%     143543 =C2=B1  3%  interrupts.CPU64.=
LOC:Local_timer_interrupts
>     124440 =C2=B1  2%     +16.8%     145383 =C2=B1  2%  interrupts.CPU65.=
LOC:Local_timer_interrupts
>     124284 =C2=B1  2%     +15.9%     144070 =C2=B1  3%  interrupts.CPU66.=
LOC:Local_timer_interrupts
>     123799 =C2=B1  3%     +15.8%     143331 =C2=B1  3%  interrupts.CPU67.=
LOC:Local_timer_interrupts
>     123400 =C2=B1  3%     +17.0%     144332 =C2=B1  3%  interrupts.CPU68.=
LOC:Local_timer_interrupts
>     125156 =C2=B1  4%     +14.5%     143289 =C2=B1  3%  interrupts.CPU69.=
LOC:Local_timer_interrupts
>     124195 =C2=B1  3%     +16.3%     144402 =C2=B1  3%  interrupts.CPU7.L=
OC:Local_timer_interrupts
>     123791 =C2=B1  3%     +16.0%     143551 =C2=B1  3%  interrupts.CPU70.=
LOC:Local_timer_interrupts
>     123826 =C2=B1  3%     +15.7%     143277 =C2=B1  3%  interrupts.CPU71.=
LOC:Local_timer_interrupts
>     110101 =C2=B1 22%     +29.0%     141983 =C2=B1  4%  interrupts.CPU72.=
LOC:Local_timer_interrupts
>     110774 =C2=B1 22%     +28.3%     142100 =C2=B1  4%  interrupts.CPU73.=
LOC:Local_timer_interrupts
>     111785 =C2=B1 22%     +27.6%     142623 =C2=B1  3%  interrupts.CPU74.=
LOC:Local_timer_interrupts
>     111709 =C2=B1 22%     +29.2%     144354 =C2=B1  3%  interrupts.CPU75.=
LOC:Local_timer_interrupts
>     111739 =C2=B1 22%     +28.9%     143992 =C2=B1  3%  interrupts.CPU76.=
LOC:Local_timer_interrupts
>     111017 =C2=B1 22%     +29.7%     143954 =C2=B1  3%  interrupts.CPU77.=
LOC:Local_timer_interrupts
>     111625 =C2=B1 22%     +28.7%     143651 =C2=B1  3%  interrupts.CPU78.=
LOC:Local_timer_interrupts
>     110970 =C2=B1 22%     +29.5%     143695 =C2=B1  4%  interrupts.CPU79.=
LOC:Local_timer_interrupts
>     122666 =C2=B1  4%     +18.0%     144790 =C2=B1  3%  interrupts.CPU8.L=
OC:Local_timer_interrupts
>     109397 =C2=B1 21%     +32.0%     144381 =C2=B1  3%  interrupts.CPU80.=
LOC:Local_timer_interrupts
>     111101 =C2=B1 22%     +29.2%     143593 =C2=B1  3%  interrupts.CPU81.=
LOC:Local_timer_interrupts
>     110996 =C2=B1 22%     +28.0%     142033 =C2=B1  4%  interrupts.CPU82.=
LOC:Local_timer_interrupts
>     110733 =C2=B1 22%     +28.4%     142147 =C2=B1  4%  interrupts.CPU83.=
LOC:Local_timer_interrupts
>     110217 =C2=B1 22%     +30.5%     143787 =C2=B1  4%  interrupts.CPU84.=
LOC:Local_timer_interrupts
>     109986 =C2=B1 22%     +31.0%     144082 =C2=B1  3%  interrupts.CPU85.=
LOC:Local_timer_interrupts
>     110129 =C2=B1 22%     +30.2%     143365 =C2=B1  3%  interrupts.CPU86.=
LOC:Local_timer_interrupts
>     110749 =C2=B1 22%     +28.8%     142696 =C2=B1  4%  interrupts.CPU87.=
LOC:Local_timer_interrupts
>     110778 =C2=B1 22%     +29.8%     143804 =C2=B1  4%  interrupts.CPU88.=
LOC:Local_timer_interrupts
>     111348 =C2=B1 22%     +28.5%     143096 =C2=B1  4%  interrupts.CPU89.=
LOC:Local_timer_interrupts
>     123749 =C2=B1  3%     +16.1%     143677 =C2=B1  3%  interrupts.CPU9.L=
OC:Local_timer_interrupts
>     110728 =C2=B1 22%     +29.0%     142841 =C2=B1  4%  interrupts.CPU90.=
LOC:Local_timer_interrupts
>     110097 =C2=B1 22%     +30.1%     143207 =C2=B1  4%  interrupts.CPU91.=
LOC:Local_timer_interrupts
>     111533 =C2=B1 22%     +28.3%     143083 =C2=B1  4%  interrupts.CPU92.=
LOC:Local_timer_interrupts
>     110777 =C2=B1 22%     +29.0%     142893 =C2=B1  4%  interrupts.CPU93.=
LOC:Local_timer_interrupts
>     109394 =C2=B1 21%     +31.1%     143427 =C2=B1  4%  interrupts.CPU94.=
LOC:Local_timer_interrupts
>     110000 =C2=B1 22%     +30.0%     143027 =C2=B1  4%  interrupts.CPU95.=
LOC:Local_timer_interrupts
>   11264859 =C2=B1 12%     +22.4%   13788804 =C2=B1  3%  interrupts.LOC:Lo=
cal_timer_interrupts
>
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> Thanks,
> Rong Chen
>
