Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D342C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EA12245D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6eUuQsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKMOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:33:58 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44665 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfKMOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:33:58 -0500
Received: by mail-io1-f67.google.com with SMTP id j20so2724250ioo.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BQmjZQiWT8bVVkFzXHxJjbXTvbbS3EqHBTQO22i2qsA=;
        b=Y6eUuQsQVlRPgvQ/NudDHWCmCfg4m9khCPjLHCwUR6HZKS/URvJcotGLQx4k3B7TPr
         jbCR8ds+9A7Qk2PrmQYLPX6Py2TZYb+HLkCpdqvr5Ip1nlNgrvQml4fEACiM4uVhDgyG
         8Y4+C8/jq1kZlajk6830Iwbw1uwU5wBCzt4fDhhVkEZs7+mRg9fqnaQ3q9peMYrcJmWX
         1ZG+nAVpJIk/Ap9o5AWM/UITIJccQbXR3J1XP6ELk43a/t9McToKsL4BG5rxaWdNwovx
         bXefUV3FMBG/kJGDHrvPQ1zPOvtg/1Nc51Yrs37sytA4B6vZZiB30s44rWwA0mspAb1U
         21AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BQmjZQiWT8bVVkFzXHxJjbXTvbbS3EqHBTQO22i2qsA=;
        b=K3byqpkQtVOMt+gbIkevZ+QYIhbURG9Bx+y1IdObOVsbZm2DXOocw7o5ag18Hlq901
         267oFfYavOMyXPONXCjexJ+NyeHVabHLU+sktmW2XfiCJF3nk6lyFVwCmaI1N5DrlX+j
         VbNYBaZywO6WHBIyQvTH0grIsUUiIBH8dD7lcphGxWGGMY5uK2NkzrhT98yyt0hEB4cX
         iarDX+bCBOCY+g7D5dDVCCMOT4HW6L0XH9ifqaf2QqhV969dp5yZ0/SNM6JxUi3IGEmn
         ifGB3FC22sWJZEoncpAKFezYf3mCVtU+aKmD/21rgcZKKlynkZtNYx/kt4mnhOeheh6v
         09Mg==
X-Gm-Message-State: APjAAAWhrK1z79FpEZeCHUD0ZUtSpBt5WZzg6tQfA5zj9SC/5JkqiefL
        euLfTd5UHpT6yy0JT+etP75dzryruiUsoIY8TQaKKg==
X-Google-Smtp-Source: APXvYqymu0ZWWMkHIEPnvs07IM0rh/207zKwPzlc+4ycomMq9knLBITxBgNBOVGQxbD/UtbD3i5hAUq0YAUGKotjqYg=
X-Received: by 2002:a5e:8e02:: with SMTP id a2mr3694915ion.269.1573655635912;
 Wed, 13 Nov 2019 06:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20191108083513.GB29418@shao2-debian> <20191113103501.GD65640@shbuild999.sh.intel.com>
In-Reply-To: <20191113103501.GD65640@shbuild999.sh.intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 13 Nov 2019 06:33:44 -0800
Message-ID: <CANn89iLnzk5bGzSD5RHa6yuny6c_iaRBE4MfKhTqbTzeX_aZ6A@mail.gmail.com>
Subject: Re: [LKP] [net] 19f92a030c: apachebench.requests_per_second -37.9% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Willy Tarreau <w@1wt.eu>,
        Yue Cao <ycao009@ucr.edu>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:35 AM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Eric,
>
> On Fri, Nov 08, 2019 at 04:35:13PM +0800, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a -37.9% regression of apachebench.requests_per_second =
due to commit:
> >
> > commit: 19f92a030ca6d772ab44b22ee6a01378a8cb32d4 ("net: increase SOMAXC=
ONN to 4096")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> Any thought on this? The test is actually:
>
>         sysctl -w net.ipv4.tcp_syncookies=3D0

I have no plan trying to understand why anyone would disable syncookies .
This is a non starter really, since this makes a server vulnerable to
a trivial DOS attack.

Since the test changes a sysctl, you also can change other sysctls if
you really need to show a ' number of transactions' for a particular
benchmark.

The change on SOMAXCONN was driven by a security issue, and security
comes first.



>         enable_apache_mod auth_basic authn_core authn_file authz_core aut=
hz_host authz_user access_compat
>         systemctl restart apache2
>         ab -k -q -t 300 -n 1000000 -c 4000 127.0.0.1/
>
> And some info about apachebench result is:
>
> w/o patch:
>
>         Connection Times (ms)
>                       min  mean[+/-sd] median   max
>         Connect:        0    0  19.5      0    7145
>         Processing:     0    4 110.0      3   21647
>         Waiting:        0    2  92.4      1   21646
>         Total:          0    4 121.1      3   24762
>
> w/ patch:
>
>         Connection Times (ms)
>                       min  mean[+/-sd] median   max
>         Connect:        0    0  43.2      0    7143
>         Processing:     0   19 640.4      3   38708
>         Waiting:        0   24 796.5      1   38708
>         Total:          0   19 657.5      3   39725
>
>
> Thanks,
> Feng
>
> >
> > in testcase: apachebench
> > on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with =
48G memory
> > with following parameters:
> >
> >       runtime: 300s
> >       concurrency: 4000
> >       cluster: cs-localhost
> >       cpufreq_governor: performance
> >       ucode: 0x7000019
> >
> > test-description: apachebench is a tool for benchmarking your Apache Hy=
pertext Transfer Protocol (HTTP) server.
> > test-url: https://httpd.apache.org/docs/2.4/programs/ab.html
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+---------------------------------------------------=
---------------+
> > | testcase: change | apachebench: apachebench.requests_per_second -37.5=
% regression   |
> > | test machine     | 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz w=
ith 48G memory |
> > | test parameters  | cluster=3Dcs-localhost                            =
                 |
> > |                  | concurrency=3D8000                                =
                 |
> > |                  | cpufreq_governor=3Dperformance                    =
                 |
> > |                  | runtime=3D300s                                    =
                 |
> > |                  | ucode=3D0x7000019                                 =
                 |
> > +------------------+---------------------------------------------------=
---------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
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
> > cluster/compiler/concurrency/cpufreq_governor/kconfig/rootfs/runtime/tb=
ox_group/testcase/ucode:
> >   cs-localhost/gcc-7/4000/performance/x86_64-rhel-7.6/debian-x86_64-201=
9-09-23.cgz/300s/lkp-bdw-de1/apachebench/0x7000019
> >
> > commit:
> >   6d6f0383b6 ("netdevsim: Fix use-after-free during device dismantle")
> >   19f92a030c ("net: increase SOMAXCONN to 4096")
> >
> > 6d6f0383b697f004 19f92a030ca6d772ab44b22ee6a
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >      22640 =C2=B1  4%     +71.1%      38734        apachebench.connecti=
on_time.processing.max
> >      24701           +60.9%      39743        apachebench.connection_ti=
me.total.max
> >      22639 =C2=B1  4%     +71.1%      38734        apachebench.connecti=
on_time.waiting.max
> >      24701        +15042.0       39743        apachebench.max_latency.1=
00%
> >      40454           -37.9%      25128        apachebench.requests_per_=
second
> >      25.69           +58.8%      40.79        apachebench.time.elapsed_=
time
> >      25.69           +58.8%      40.79        apachebench.time.elapsed_=
time.max
> >      79.00           -37.0%      49.75        apachebench.time.percent_=
of_cpu_this_job_got
> >      98.88           +61.0%     159.18        apachebench.time_per_requ=
est
> >     434631           -37.9%     269889        apachebench.transfer_rate
> >    1.5e+08 =C2=B1 18%    +109.5%  3.141e+08 =C2=B1 27%  cpuidle.C3.time
> >     578957 =C2=B1  7%     +64.1%     949934 =C2=B1 12%  cpuidle.C3.usag=
e
> >      79085 =C2=B1  4%     +24.8%      98720        meminfo.AnonHugePage=
s
> >      41176           +14.2%      47013        meminfo.PageTables
> >      69429           -34.9%      45222        meminfo.max_used_kB
> >      63.48           +12.7       76.15        mpstat.cpu.all.idle%
> >       2.42 =C2=B1  2%      -0.9        1.56        mpstat.cpu.all.soft%
> >      15.30            -5.2       10.13        mpstat.cpu.all.sys%
> >      18.80            -6.6       12.16        mpstat.cpu.all.usr%
> >      65.00           +17.7%      76.50        vmstat.cpu.id
> >      17.00           -35.3%      11.00        vmstat.cpu.us
> >       7.00 =C2=B1 24%     -50.0%       3.50 =C2=B1 14%  vmstat.procs.r
> >      62957           -33.3%      42012        vmstat.system.cs
> >      33174            -1.4%      32693        vmstat.system.in
> >       5394 =C2=B1  5%     +16.3%       6272 =C2=B1  6%  sched_debug.cfs=
_rq:/.min_vruntime.stddev
> >       5396 =C2=B1  5%     +16.3%       6275 =C2=B1  6%  sched_debug.cfs=
_rq:/.spread0.stddev
> >      33982 =C2=B1 48%     -83.3%       5676 =C2=B1 47%  sched_debug.cpu=
.avg_idle.min
> >      26.75 =C2=B1 77%    +169.8%      72.17 =C2=B1 41%  sched_debug.cpu=
.sched_count.avg
> >     212.00 =C2=B1 90%    +168.2%     568.50 =C2=B1 50%  sched_debug.cpu=
.sched_count.max
> >      52.30 =C2=B1 89%    +182.5%     147.73 =C2=B1 48%  sched_debug.cpu=
.sched_count.stddev
> >      11.33 =C2=B1 80%    +193.9%      33.30 =C2=B1 42%  sched_debug.cpu=
.sched_goidle.avg
> >     104.50 =C2=B1 92%    +170.6%     282.75 =C2=B1 50%  sched_debug.cpu=
.sched_goidle.max
> >      26.18 =C2=B1 90%    +183.9%      74.31 =C2=B1 48%  sched_debug.cpu=
.sched_goidle.stddev
> >     959.00           -32.0%     652.00        turbostat.Avg_MHz
> >      39.01           -11.2       27.79        turbostat.Busy%
> >       1.46 =C2=B1  7%      -0.5        0.96 =C2=B1  5%  turbostat.C1%
> >       9.58 =C2=B1  4%      -3.2        6.38        turbostat.C1E%
> >     578646 =C2=B1  7%     +64.1%     949626 =C2=B1 12%  turbostat.C3
> >     940073           +51.1%    1420298        turbostat.IRQ
> >       2.20 =C2=B1 22%    +159.7%       5.71 =C2=B1 12%  turbostat.Pkg%p=
c2
> >      31.22           -17.2%      25.86        turbostat.PkgWatt
> >       4.74            -7.5%       4.39        turbostat.RAMWatt
> >      93184            -1.6%      91678        proc-vmstat.nr_active_ano=
n
> >      92970            -1.8%      91314        proc-vmstat.nr_anon_pages
> >     288405            +1.0%     291286        proc-vmstat.nr_file_pages
> >       8307            +6.3%       8831        proc-vmstat.nr_kernel_sta=
ck
> >      10315           +14.2%      11783        proc-vmstat.nr_page_table=
_pages
> >      21499            +6.0%      22798        proc-vmstat.nr_slab_unrec=
laimable
> >     284131            +1.0%     286977        proc-vmstat.nr_unevictabl=
e
> >      93184            -1.6%      91678        proc-vmstat.nr_zone_activ=
e_anon
> >     284131            +1.0%     286977        proc-vmstat.nr_zone_unevi=
ctable
> >     198874 =C2=B1  2%     +43.7%     285772 =C2=B1 16%  proc-vmstat.num=
a_hit
> >     198874 =C2=B1  2%     +43.7%     285772 =C2=B1 16%  proc-vmstat.num=
a_local
> >     249594 =C2=B1  3%     +59.6%     398267 =C2=B1 13%  proc-vmstat.pga=
lloc_normal
> >    1216885           +12.7%    1371283 =C2=B1  3%  proc-vmstat.pgfault
> >     179705 =C2=B1 16%     +82.9%     328634 =C2=B1 21%  proc-vmstat.pgf=
ree
> >     346.25 =C2=B1  5%    +133.5%     808.50 =C2=B1  2%  slabinfo.TCPv6.=
active_objs
> >     346.25 =C2=B1  5%    +134.4%     811.75 =C2=B1  2%  slabinfo.TCPv6.=
num_objs
> >      22966           +15.6%      26559        slabinfo.anon_vma.active_=
objs
> >      23091           +15.5%      26664        slabinfo.anon_vma.num_obj=
s
> >      69747           +16.1%      81011        slabinfo.anon_vma_chain.a=
ctive_objs
> >       1094           +15.9%       1269        slabinfo.anon_vma_chain.a=
ctive_slabs
> >      70092           +15.9%      81259        slabinfo.anon_vma_chain.n=
um_objs
> >       1094           +15.9%       1269        slabinfo.anon_vma_chain.n=
um_slabs
> >       1649           +12.9%       1861        slabinfo.cred_jar.active_=
objs
> >       1649           +12.9%       1861        slabinfo.cred_jar.num_obj=
s
> >       4924           +20.0%       5907        slabinfo.pid.active_objs
> >       4931           +19.9%       5912        slabinfo.pid.num_objs
> >     266.50 =C2=B1  3%    +299.2%       1063        slabinfo.request_soc=
k_TCP.active_objs
> >     266.50 =C2=B1  3%    +299.2%       1063        slabinfo.request_soc=
k_TCP.num_objs
> >      11.50 =C2=B1  4%   +1700.0%     207.00 =C2=B1  4%  slabinfo.tw_soc=
k_TCPv6.active_objs
> >      11.50 =C2=B1  4%   +1700.0%     207.00 =C2=B1  4%  slabinfo.tw_soc=
k_TCPv6.num_objs
> >      41682           +16.0%      48360        slabinfo.vm_area_struct.a=
ctive_objs
> >       1046           +15.7%       1211        slabinfo.vm_area_struct.a=
ctive_slabs
> >      41879           +15.7%      48468        slabinfo.vm_area_struct.n=
um_objs
> >       1046           +15.7%       1211        slabinfo.vm_area_struct.n=
um_slabs
> >       4276 =C2=B1  2%     +10.0%       4705 =C2=B1  2%  slabinfo.vmap_a=
rea.num_objs
> >      21.25 =C2=B1 27%   +3438.8%     752.00 =C2=B1 83%  interrupts.36:I=
R-PCI-MSI.2621443-edge.eth0-TxRx-2
> >      21.25 =C2=B1 20%   +1777.6%     399.00 =C2=B1155%  interrupts.38:I=
R-PCI-MSI.2621445-edge.eth0-TxRx-4
> >      54333           +54.3%      83826        interrupts.CPU0.LOC:Local=
_timer_interrupts
> >      54370           +54.6%      84072        interrupts.CPU1.LOC:Local=
_timer_interrupts
> >      21.25 =C2=B1 27%   +3438.8%     752.00 =C2=B1 83%  interrupts.CPU1=
0.36:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
> >      54236           +54.7%      83925        interrupts.CPU10.LOC:Loca=
l_timer_interrupts
> >      54223           +54.3%      83655        interrupts.CPU11.LOC:Loca=
l_timer_interrupts
> >     377.75 =C2=B1 21%     +27.1%     480.25 =C2=B1 10%  interrupts.CPU1=
1.RES:Rescheduling_interrupts
> >      21.25 =C2=B1 20%   +1777.6%     399.00 =C2=B1155%  interrupts.CPU1=
2.38:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
> >      54279           +54.1%      83646        interrupts.CPU12.LOC:Loca=
l_timer_interrupts
> >      53683           +55.3%      83365        interrupts.CPU13.LOC:Loca=
l_timer_interrupts
> >      53887           +55.7%      83903        interrupts.CPU14.LOC:Loca=
l_timer_interrupts
> >      54156           +54.7%      83803        interrupts.CPU15.LOC:Loca=
l_timer_interrupts
> >      54041           +55.1%      83806        interrupts.CPU2.LOC:Local=
_timer_interrupts
> >      54042           +55.4%      83991        interrupts.CPU3.LOC:Local=
_timer_interrupts
> >      54081           +55.2%      83938        interrupts.CPU4.LOC:Local=
_timer_interrupts
> >      54322           +54.9%      84166        interrupts.CPU5.LOC:Local=
_timer_interrupts
> >      53586           +56.5%      83849        interrupts.CPU6.LOC:Local=
_timer_interrupts
> >      54049           +55.2%      83892        interrupts.CPU7.LOC:Local=
_timer_interrupts
> >      54056           +54.9%      83751        interrupts.CPU8.LOC:Local=
_timer_interrupts
> >      53862           +54.7%      83331        interrupts.CPU9.LOC:Local=
_timer_interrupts
> >     865212           +55.0%    1340925        interrupts.LOC:Local_time=
r_interrupts
> >      16477 =C2=B1  4%     +32.2%      21779 =C2=B1  8%  softirqs.CPU0.T=
IMER
> >      18508 =C2=B1 15%     +39.9%      25891 =C2=B1 17%  softirqs.CPU1.T=
IMER
> >      16625 =C2=B1  8%     +21.3%      20166 =C2=B1  7%  softirqs.CPU10.=
TIMER
> >       5906 =C2=B1 21%     +62.5%       9597 =C2=B1 13%  softirqs.CPU12.=
SCHED
> >      17474 =C2=B1 12%     +29.4%      22610 =C2=B1  7%  softirqs.CPU12.=
TIMER
> >       7680 =C2=B1 11%     +20.4%       9246 =C2=B1 14%  softirqs.CPU13.=
SCHED
> >      45558 =C2=B1 36%     -37.8%      28320 =C2=B1 25%  softirqs.CPU14.=
NET_RX
> >      15365 =C2=B1  4%     +40.7%      21622 =C2=B1  5%  softirqs.CPU14.=
TIMER
> >       8084 =C2=B1  4%     +18.7%       9599 =C2=B1 12%  softirqs.CPU15.=
RCU
> >      16433 =C2=B1  4%     +41.2%      23203 =C2=B1 14%  softirqs.CPU2.T=
IMER
> >       8436 =C2=B1  7%     +19.9%      10117 =C2=B1 10%  softirqs.CPU3.R=
CU
> >      15992 =C2=B1  3%     +48.5%      23742 =C2=B1 18%  softirqs.CPU3.T=
IMER
> >      17389 =C2=B1 14%     +38.7%      24116 =C2=B1 11%  softirqs.CPU4.T=
IMER
> >      17749 =C2=B1 13%     +42.2%      25235 =C2=B1 15%  softirqs.CPU5.T=
IMER
> >      16528 =C2=B1  9%     +28.3%      21200 =C2=B1  2%  softirqs.CPU6.T=
IMER
> >       8321 =C2=B1  8%     +31.3%      10929 =C2=B1  5%  softirqs.CPU7.R=
CU
> >      18024 =C2=B1  8%     +28.8%      23212 =C2=B1  5%  softirqs.CPU7.T=
IMER
> >      15717 =C2=B1  5%     +27.1%      19983 =C2=B1  7%  softirqs.CPU8.T=
IMER
> >       7383 =C2=B1 11%     +30.5%       9632 =C2=B1  9%  softirqs.CPU9.S=
CHED
> >      16342 =C2=B1 18%     +41.0%      23037 =C2=B1 10%  softirqs.CPU9.T=
IMER
> >     148013           +10.2%     163086 =C2=B1  2%  softirqs.RCU
> >     112139           +28.0%     143569        softirqs.SCHED
> >     276690 =C2=B1  3%     +30.4%     360747 =C2=B1  3%  softirqs.TIMER
> >  1.453e+09           -36.2%  9.273e+08        perf-stat.i.branch-instru=
ctions
> >   67671486           -35.9%   43396843 =C2=B1  2%  perf-stat.i.branch-m=
isses
> >  5.188e+08           -35.3%  3.357e+08        perf-stat.i.cache-misses
> >  5.188e+08           -35.3%  3.357e+08        perf-stat.i.cache-referen=
ces
> >      71149           -36.0%      45536        perf-stat.i.context-switc=
hes
> >       2.92 =C2=B1  6%     +38.4%       4.04 =C2=B1  5%  perf-stat.i.cpi
> >  1.581e+10           -33.8%  1.046e+10        perf-stat.i.cpu-cycles
> >       1957 =C2=B1  6%     -35.4%       1264 =C2=B1  5%  perf-stat.i.cpu=
-migrations
> >      40.76 =C2=B1  2%     +33.0%      54.21        perf-stat.i.cycles-b=
etween-cache-misses
> >       0.64 =C2=B1  2%      +0.2        0.86 =C2=B1  2%  perf-stat.i.dTL=
B-load-miss-rate%
> >   10720126 =C2=B1  2%     -34.0%    7071299        perf-stat.i.dTLB-loa=
d-misses
> >   2.05e+09           -35.8%  1.315e+09        perf-stat.i.dTLB-loads
> >       0.16            +0.0        0.18 =C2=B1  5%  perf-stat.i.dTLB-sto=
re-miss-rate%
> >    1688635           -31.7%    1153595        perf-stat.i.dTLB-store-mi=
sses
> >   1.17e+09           -33.5%  7.777e+08        perf-stat.i.dTLB-stores
> >      61.00 =C2=B1  6%      +8.7       69.70 =C2=B1  2%  perf-stat.i.iTL=
B-load-miss-rate%
> >   13112146 =C2=B1 10%     -38.5%    8061589 =C2=B1 13%  perf-stat.i.iTL=
B-load-misses
> >    9827689 =C2=B1  3%     -37.1%    6184316        perf-stat.i.iTLB-loa=
ds
> >      7e+09           -36.2%  4.469e+09        perf-stat.i.instructions
> >       0.42 =C2=B1  2%     -22.2%       0.33 =C2=B1  3%  perf-stat.i.ipc
> >      45909           -32.4%      31036        perf-stat.i.minor-faults
> >      45909           -32.4%      31036        perf-stat.i.page-faults
> >       2.26            +3.6%       2.34        perf-stat.overall.cpi
> >      30.47            +2.3%      31.16        perf-stat.overall.cycles-=
between-cache-misses
> >       0.44            -3.5%       0.43        perf-stat.overall.ipc
> >  1.398e+09           -35.3%  9.049e+08        perf-stat.ps.branch-instr=
uctions
> >   65124290           -35.0%   42353120 =C2=B1  2%  perf-stat.ps.branch-=
misses
> >  4.993e+08           -34.4%  3.276e+08        perf-stat.ps.cache-misses
> >  4.993e+08           -34.4%  3.276e+08        perf-stat.ps.cache-refere=
nces
> >      68469           -35.1%      44440        perf-stat.ps.context-swit=
ches
> >  1.521e+10           -32.9%  1.021e+10        perf-stat.ps.cpu-cycles
> >       1884 =C2=B1  6%     -34.5%       1234 =C2=B1  5%  perf-stat.ps.cp=
u-migrations
> >   10314734 =C2=B1  2%     -33.1%    6899548        perf-stat.ps.dTLB-lo=
ad-misses
> >  1.973e+09           -34.9%  1.283e+09        perf-stat.ps.dTLB-loads
> >    1624883           -30.7%    1125668        perf-stat.ps.dTLB-store-m=
isses
> >  1.126e+09           -32.6%  7.589e+08        perf-stat.ps.dTLB-stores
> >   12617676 =C2=B1 10%     -37.7%    7866427 =C2=B1 13%  perf-stat.ps.iT=
LB-load-misses
> >    9458687 =C2=B1  3%     -36.2%    6036594        perf-stat.ps.iTLB-lo=
ads
> >  6.736e+09           -35.3%  4.361e+09        perf-stat.ps.instructions
> >      44179           -31.4%      30288        perf-stat.ps.minor-faults
> >      30791            +1.4%      31223        perf-stat.ps.msec
> >      44179           -31.4%      30288        perf-stat.ps.page-faults
> >      21.96 =C2=B1 69%     -22.0        0.00        perf-profile.calltra=
ce.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      21.96 =C2=B1 69%     -22.0        0.00        perf-profile.calltra=
ce.cycles-pp.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
> >      18.63 =C2=B1 89%     -18.6        0.00        perf-profile.calltra=
ce.cycles-pp.search_binary_handler.__do_execve_file.__x64_sys_execve.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
> >      18.63 =C2=B1 89%     -18.6        0.00        perf-profile.calltra=
ce.cycles-pp.load_elf_binary.search_binary_handler.__do_execve_file.__x64_s=
ys_execve.do_syscall_64
> >      13.15 =C2=B1 67%      -8.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_=
startup_entry
> >       8.81 =C2=B1133%      -8.0        0.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.ret_from_fork
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.secondary_startup_64
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.start_secondary.secondary_startup_64
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_start=
up_64
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.s=
econdary_startup_64
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_ent=
ry.start_secondary
> >       6.70 =C2=B1100%      -6.7        0.00        perf-profile.calltra=
ce.cycles-pp.__clear_user.load_elf_binary.search_binary_handler.__do_execve=
_file.__x64_sys_execve
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.calltra=
ce.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_group_exit
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.calltra=
ce.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.do_exit
> >       4.79 =C2=B1108%      -4.0        0.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.mmput.do_exit.do_group_exit.get_signal.do_signal
> >       4.79 =C2=B1108%      -4.0        0.83 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.get_signal
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__enable.e=
vsel__enable.evlist__enable
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_e=
vsel__enable.evsel__enable
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.event_function_call.perf_event_for_each_child._perf_ioctl=
.perf_ioctl.do_vfs_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_f=
or_each_child._perf_ioctl.perf_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.__libc_start_main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.main.__libc_start_main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.run_builtin.main.__libc_start_main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.evlist__enable.cmd_record.run_builtin.main.__libc_start_m=
ain
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.evsel__enable.evlist__enable.cmd_record.run_builtin.main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.perf_evsel__enable.evsel__enable.evlist__enable.cmd_recor=
d.run_builtin
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.ioctl.perf_evsel__enable.evsel__enable.evlist__enable.cmd=
_record
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.ioctl.perf_evsel__enable
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.ksys_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64=
_after_hwframe.ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.perf_ioctl.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl.do_sys=
call_64
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp._perf_ioctl.perf_ioctl.do_vfs_ioctl.ksys_ioctl.__x64_sys_=
ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.perf_event_for_each_child._perf_ioctl.perf_ioctl.do_vfs_i=
octl.ksys_ioctl
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.=
do_syscall_64
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_exit.do_group_exit.get_signal.do_signal.exit_to_usermo=
de_loop
> >      12.92 =C2=B1100%     +12.1       25.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after=
_hwframe
> >      12.92 =C2=B1100%     +12.1       25.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
> >      12.92 =C2=B1100%     +12.1       25.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >      11.25 =C2=B1101%     +13.8       25.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_sysca=
ll_64
> >       9.58 =C2=B1108%     +15.4       25.00 =C2=B1173%  perf-profile.ca=
lltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_grou=
p
> >      21.96 =C2=B1 69%     -22.0        0.00        perf-profile.childre=
n.cycles-pp.__x64_sys_execve
> >      21.96 =C2=B1 69%     -22.0        0.00        perf-profile.childre=
n.cycles-pp.__do_execve_file
> >      18.63 =C2=B1 89%     -18.6        0.00        perf-profile.childre=
n.cycles-pp.search_binary_handler
> >      18.63 =C2=B1 89%     -18.6        0.00        perf-profile.childre=
n.cycles-pp.load_elf_binary
> >      13.15 =C2=B1 67%      -8.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.intel_idle
> >       8.81 =C2=B1133%      -8.0        0.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.ret_from_fork
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.secondary_startup_64
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.start_secondary
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.cpu_startup_entry
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.do_idle
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter
> >      13.15 =C2=B1 67%      -7.3        5.83 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter_state
> >       6.70 =C2=B1100%      -6.7        0.00        perf-profile.childre=
n.cycles-pp.__clear_user
> >       6.46 =C2=B1100%      -6.5        0.00        perf-profile.childre=
n.cycles-pp.handle_mm_fault
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.childre=
n.cycles-pp.page_fault
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.childre=
n.cycles-pp.do_page_fault
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.childre=
n.cycles-pp.__do_page_fault
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.childre=
n.cycles-pp.free_pgtables
> >       4.79 =C2=B1108%      -4.8        0.00        perf-profile.childre=
n.cycles-pp.unlink_file_vma
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.__libc_start_main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.main
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.run_builtin
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.cmd_record
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.evlist__enable
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.evsel__enable
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.perf_evsel__enable
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.ksys_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.do_vfs_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.perf_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp._perf_ioctl
> >       5.24 =C2=B1112%      -0.2        5.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.perf_event_for_each_child
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.exit_to_usermode_loop
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.do_signal
> >       4.79 =C2=B1108%      +8.5       13.33 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.get_signal
> >       5.24 =C2=B1112%      +8.9       14.17 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.event_function_call
> >       5.24 =C2=B1112%      +8.9       14.17 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.smp_call_function_single
> >      12.92 =C2=B1100%     +12.1       25.00 =C2=B1173%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_exit_group
> >      13.15 =C2=B1 67%      -8.2        5.00 =C2=B1173%  perf-profile.se=
lf.cycles-pp.intel_idle
> >       6.46 =C2=B1100%      -6.5        0.00        perf-profile.self.cy=
cles-pp.unmap_page_range
> >       5.24 =C2=B1112%      +8.9       14.17 =C2=B1173%  perf-profile.se=
lf.cycles-pp.smp_call_function_single
> >
