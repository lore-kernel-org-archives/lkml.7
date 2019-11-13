Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66460222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKMKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:35:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:64155 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKMKfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:35:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 02:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="194631026"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2019 02:35:01 -0800
Date:   Wed, 13 Nov 2019 18:35:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Willy Tarreau <w@1wt.eu>,
        Yue Cao <ycao009@ucr.edu>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [LKP] [net] 19f92a030c: apachebench.requests_per_second -37.9%
 regression
Message-ID: <20191113103501.GD65640@shbuild999.sh.intel.com>
References: <20191108083513.GB29418@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108083513.GB29418@shao2-debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Nov 08, 2019 at 04:35:13PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -37.9% regression of apachebench.requests_per_second due to commit:
> 
> commit: 19f92a030ca6d772ab44b22ee6a01378a8cb32d4 ("net: increase SOMAXCONN to 4096")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Any thought on this? The test is actually: 

	sysctl -w net.ipv4.tcp_syncookies=0
	enable_apache_mod auth_basic authn_core authn_file authz_core authz_host authz_user access_compat
	systemctl restart apache2
	ab -k -q -t 300 -n 1000000 -c 4000 127.0.0.1/

And some info about apachebench result is:

w/o patch:
	
	Connection Times (ms)
		      min  mean[+/-sd] median   max
	Connect:        0    0  19.5      0    7145
	Processing:     0    4 110.0      3   21647
	Waiting:        0    2  92.4      1   21646
	Total:          0    4 121.1      3   24762

w/ patch:

	Connection Times (ms)
		      min  mean[+/-sd] median   max
	Connect:        0    0  43.2      0    7143
	Processing:     0   19 640.4      3   38708
	Waiting:        0   24 796.5      1   38708
	Total:          0   19 657.5      3   39725


Thanks,
Feng

> 
> in testcase: apachebench
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory
> with following parameters:
> 
> 	runtime: 300s
> 	concurrency: 4000
> 	cluster: cs-localhost
> 	cpufreq_governor: performance
> 	ucode: 0x7000019
> 
> test-description: apachebench is a tool for benchmarking your Apache Hypertext Transfer Protocol (HTTP) server.
> test-url: https://httpd.apache.org/docs/2.4/programs/ab.html
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+------------------------------------------------------------------+
> | testcase: change | apachebench: apachebench.requests_per_second -37.5% regression   |
> | test machine     | 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory |
> | test parameters  | cluster=cs-localhost                                             |
> |                  | concurrency=8000                                                 |
> |                  | cpufreq_governor=performance                                     |
> |                  | runtime=300s                                                     |
> |                  | ucode=0x7000019                                                  |
> +------------------+------------------------------------------------------------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> =========================================================================================
> cluster/compiler/concurrency/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/testcase/ucode:
>   cs-localhost/gcc-7/4000/performance/x86_64-rhel-7.6/debian-x86_64-2019-09-23.cgz/300s/lkp-bdw-de1/apachebench/0x7000019
> 
> commit: 
>   6d6f0383b6 ("netdevsim: Fix use-after-free during device dismantle")
>   19f92a030c ("net: increase SOMAXCONN to 4096")
> 
> 6d6f0383b697f004 19f92a030ca6d772ab44b22ee6a 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      22640 ±  4%     +71.1%      38734        apachebench.connection_time.processing.max
>      24701           +60.9%      39743        apachebench.connection_time.total.max
>      22639 ±  4%     +71.1%      38734        apachebench.connection_time.waiting.max
>      24701        +15042.0       39743        apachebench.max_latency.100%
>      40454           -37.9%      25128        apachebench.requests_per_second
>      25.69           +58.8%      40.79        apachebench.time.elapsed_time
>      25.69           +58.8%      40.79        apachebench.time.elapsed_time.max
>      79.00           -37.0%      49.75        apachebench.time.percent_of_cpu_this_job_got
>      98.88           +61.0%     159.18        apachebench.time_per_request
>     434631           -37.9%     269889        apachebench.transfer_rate
>    1.5e+08 ± 18%    +109.5%  3.141e+08 ± 27%  cpuidle.C3.time
>     578957 ±  7%     +64.1%     949934 ± 12%  cpuidle.C3.usage
>      79085 ±  4%     +24.8%      98720        meminfo.AnonHugePages
>      41176           +14.2%      47013        meminfo.PageTables
>      69429           -34.9%      45222        meminfo.max_used_kB
>      63.48           +12.7       76.15        mpstat.cpu.all.idle%
>       2.42 ±  2%      -0.9        1.56        mpstat.cpu.all.soft%
>      15.30            -5.2       10.13        mpstat.cpu.all.sys%
>      18.80            -6.6       12.16        mpstat.cpu.all.usr%
>      65.00           +17.7%      76.50        vmstat.cpu.id
>      17.00           -35.3%      11.00        vmstat.cpu.us
>       7.00 ± 24%     -50.0%       3.50 ± 14%  vmstat.procs.r
>      62957           -33.3%      42012        vmstat.system.cs
>      33174            -1.4%      32693        vmstat.system.in
>       5394 ±  5%     +16.3%       6272 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       5396 ±  5%     +16.3%       6275 ±  6%  sched_debug.cfs_rq:/.spread0.stddev
>      33982 ± 48%     -83.3%       5676 ± 47%  sched_debug.cpu.avg_idle.min
>      26.75 ± 77%    +169.8%      72.17 ± 41%  sched_debug.cpu.sched_count.avg
>     212.00 ± 90%    +168.2%     568.50 ± 50%  sched_debug.cpu.sched_count.max
>      52.30 ± 89%    +182.5%     147.73 ± 48%  sched_debug.cpu.sched_count.stddev
>      11.33 ± 80%    +193.9%      33.30 ± 42%  sched_debug.cpu.sched_goidle.avg
>     104.50 ± 92%    +170.6%     282.75 ± 50%  sched_debug.cpu.sched_goidle.max
>      26.18 ± 90%    +183.9%      74.31 ± 48%  sched_debug.cpu.sched_goidle.stddev
>     959.00           -32.0%     652.00        turbostat.Avg_MHz
>      39.01           -11.2       27.79        turbostat.Busy%
>       1.46 ±  7%      -0.5        0.96 ±  5%  turbostat.C1%
>       9.58 ±  4%      -3.2        6.38        turbostat.C1E%
>     578646 ±  7%     +64.1%     949626 ± 12%  turbostat.C3
>     940073           +51.1%    1420298        turbostat.IRQ
>       2.20 ± 22%    +159.7%       5.71 ± 12%  turbostat.Pkg%pc2
>      31.22           -17.2%      25.86        turbostat.PkgWatt
>       4.74            -7.5%       4.39        turbostat.RAMWatt
>      93184            -1.6%      91678        proc-vmstat.nr_active_anon
>      92970            -1.8%      91314        proc-vmstat.nr_anon_pages
>     288405            +1.0%     291286        proc-vmstat.nr_file_pages
>       8307            +6.3%       8831        proc-vmstat.nr_kernel_stack
>      10315           +14.2%      11783        proc-vmstat.nr_page_table_pages
>      21499            +6.0%      22798        proc-vmstat.nr_slab_unreclaimable
>     284131            +1.0%     286977        proc-vmstat.nr_unevictable
>      93184            -1.6%      91678        proc-vmstat.nr_zone_active_anon
>     284131            +1.0%     286977        proc-vmstat.nr_zone_unevictable
>     198874 ±  2%     +43.7%     285772 ± 16%  proc-vmstat.numa_hit
>     198874 ±  2%     +43.7%     285772 ± 16%  proc-vmstat.numa_local
>     249594 ±  3%     +59.6%     398267 ± 13%  proc-vmstat.pgalloc_normal
>    1216885           +12.7%    1371283 ±  3%  proc-vmstat.pgfault
>     179705 ± 16%     +82.9%     328634 ± 21%  proc-vmstat.pgfree
>     346.25 ±  5%    +133.5%     808.50 ±  2%  slabinfo.TCPv6.active_objs
>     346.25 ±  5%    +134.4%     811.75 ±  2%  slabinfo.TCPv6.num_objs
>      22966           +15.6%      26559        slabinfo.anon_vma.active_objs
>      23091           +15.5%      26664        slabinfo.anon_vma.num_objs
>      69747           +16.1%      81011        slabinfo.anon_vma_chain.active_objs
>       1094           +15.9%       1269        slabinfo.anon_vma_chain.active_slabs
>      70092           +15.9%      81259        slabinfo.anon_vma_chain.num_objs
>       1094           +15.9%       1269        slabinfo.anon_vma_chain.num_slabs
>       1649           +12.9%       1861        slabinfo.cred_jar.active_objs
>       1649           +12.9%       1861        slabinfo.cred_jar.num_objs
>       4924           +20.0%       5907        slabinfo.pid.active_objs
>       4931           +19.9%       5912        slabinfo.pid.num_objs
>     266.50 ±  3%    +299.2%       1063        slabinfo.request_sock_TCP.active_objs
>     266.50 ±  3%    +299.2%       1063        slabinfo.request_sock_TCP.num_objs
>      11.50 ±  4%   +1700.0%     207.00 ±  4%  slabinfo.tw_sock_TCPv6.active_objs
>      11.50 ±  4%   +1700.0%     207.00 ±  4%  slabinfo.tw_sock_TCPv6.num_objs
>      41682           +16.0%      48360        slabinfo.vm_area_struct.active_objs
>       1046           +15.7%       1211        slabinfo.vm_area_struct.active_slabs
>      41879           +15.7%      48468        slabinfo.vm_area_struct.num_objs
>       1046           +15.7%       1211        slabinfo.vm_area_struct.num_slabs
>       4276 ±  2%     +10.0%       4705 ±  2%  slabinfo.vmap_area.num_objs
>      21.25 ± 27%   +3438.8%     752.00 ± 83%  interrupts.36:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
>      21.25 ± 20%   +1777.6%     399.00 ±155%  interrupts.38:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
>      54333           +54.3%      83826        interrupts.CPU0.LOC:Local_timer_interrupts
>      54370           +54.6%      84072        interrupts.CPU1.LOC:Local_timer_interrupts
>      21.25 ± 27%   +3438.8%     752.00 ± 83%  interrupts.CPU10.36:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
>      54236           +54.7%      83925        interrupts.CPU10.LOC:Local_timer_interrupts
>      54223           +54.3%      83655        interrupts.CPU11.LOC:Local_timer_interrupts
>     377.75 ± 21%     +27.1%     480.25 ± 10%  interrupts.CPU11.RES:Rescheduling_interrupts
>      21.25 ± 20%   +1777.6%     399.00 ±155%  interrupts.CPU12.38:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
>      54279           +54.1%      83646        interrupts.CPU12.LOC:Local_timer_interrupts
>      53683           +55.3%      83365        interrupts.CPU13.LOC:Local_timer_interrupts
>      53887           +55.7%      83903        interrupts.CPU14.LOC:Local_timer_interrupts
>      54156           +54.7%      83803        interrupts.CPU15.LOC:Local_timer_interrupts
>      54041           +55.1%      83806        interrupts.CPU2.LOC:Local_timer_interrupts
>      54042           +55.4%      83991        interrupts.CPU3.LOC:Local_timer_interrupts
>      54081           +55.2%      83938        interrupts.CPU4.LOC:Local_timer_interrupts
>      54322           +54.9%      84166        interrupts.CPU5.LOC:Local_timer_interrupts
>      53586           +56.5%      83849        interrupts.CPU6.LOC:Local_timer_interrupts
>      54049           +55.2%      83892        interrupts.CPU7.LOC:Local_timer_interrupts
>      54056           +54.9%      83751        interrupts.CPU8.LOC:Local_timer_interrupts
>      53862           +54.7%      83331        interrupts.CPU9.LOC:Local_timer_interrupts
>     865212           +55.0%    1340925        interrupts.LOC:Local_timer_interrupts
>      16477 ±  4%     +32.2%      21779 ±  8%  softirqs.CPU0.TIMER
>      18508 ± 15%     +39.9%      25891 ± 17%  softirqs.CPU1.TIMER
>      16625 ±  8%     +21.3%      20166 ±  7%  softirqs.CPU10.TIMER
>       5906 ± 21%     +62.5%       9597 ± 13%  softirqs.CPU12.SCHED
>      17474 ± 12%     +29.4%      22610 ±  7%  softirqs.CPU12.TIMER
>       7680 ± 11%     +20.4%       9246 ± 14%  softirqs.CPU13.SCHED
>      45558 ± 36%     -37.8%      28320 ± 25%  softirqs.CPU14.NET_RX
>      15365 ±  4%     +40.7%      21622 ±  5%  softirqs.CPU14.TIMER
>       8084 ±  4%     +18.7%       9599 ± 12%  softirqs.CPU15.RCU
>      16433 ±  4%     +41.2%      23203 ± 14%  softirqs.CPU2.TIMER
>       8436 ±  7%     +19.9%      10117 ± 10%  softirqs.CPU3.RCU
>      15992 ±  3%     +48.5%      23742 ± 18%  softirqs.CPU3.TIMER
>      17389 ± 14%     +38.7%      24116 ± 11%  softirqs.CPU4.TIMER
>      17749 ± 13%     +42.2%      25235 ± 15%  softirqs.CPU5.TIMER
>      16528 ±  9%     +28.3%      21200 ±  2%  softirqs.CPU6.TIMER
>       8321 ±  8%     +31.3%      10929 ±  5%  softirqs.CPU7.RCU
>      18024 ±  8%     +28.8%      23212 ±  5%  softirqs.CPU7.TIMER
>      15717 ±  5%     +27.1%      19983 ±  7%  softirqs.CPU8.TIMER
>       7383 ± 11%     +30.5%       9632 ±  9%  softirqs.CPU9.SCHED
>      16342 ± 18%     +41.0%      23037 ± 10%  softirqs.CPU9.TIMER
>     148013           +10.2%     163086 ±  2%  softirqs.RCU
>     112139           +28.0%     143569        softirqs.SCHED
>     276690 ±  3%     +30.4%     360747 ±  3%  softirqs.TIMER
>  1.453e+09           -36.2%  9.273e+08        perf-stat.i.branch-instructions
>   67671486           -35.9%   43396843 ±  2%  perf-stat.i.branch-misses
>  5.188e+08           -35.3%  3.357e+08        perf-stat.i.cache-misses
>  5.188e+08           -35.3%  3.357e+08        perf-stat.i.cache-references
>      71149           -36.0%      45536        perf-stat.i.context-switches
>       2.92 ±  6%     +38.4%       4.04 ±  5%  perf-stat.i.cpi
>  1.581e+10           -33.8%  1.046e+10        perf-stat.i.cpu-cycles
>       1957 ±  6%     -35.4%       1264 ±  5%  perf-stat.i.cpu-migrations
>      40.76 ±  2%     +33.0%      54.21        perf-stat.i.cycles-between-cache-misses
>       0.64 ±  2%      +0.2        0.86 ±  2%  perf-stat.i.dTLB-load-miss-rate%
>   10720126 ±  2%     -34.0%    7071299        perf-stat.i.dTLB-load-misses
>   2.05e+09           -35.8%  1.315e+09        perf-stat.i.dTLB-loads
>       0.16            +0.0        0.18 ±  5%  perf-stat.i.dTLB-store-miss-rate%
>    1688635           -31.7%    1153595        perf-stat.i.dTLB-store-misses
>   1.17e+09           -33.5%  7.777e+08        perf-stat.i.dTLB-stores
>      61.00 ±  6%      +8.7       69.70 ±  2%  perf-stat.i.iTLB-load-miss-rate%
>   13112146 ± 10%     -38.5%    8061589 ± 13%  perf-stat.i.iTLB-load-misses
>    9827689 ±  3%     -37.1%    6184316        perf-stat.i.iTLB-loads
>      7e+09           -36.2%  4.469e+09        perf-stat.i.instructions
>       0.42 ±  2%     -22.2%       0.33 ±  3%  perf-stat.i.ipc
>      45909           -32.4%      31036        perf-stat.i.minor-faults
>      45909           -32.4%      31036        perf-stat.i.page-faults
>       2.26            +3.6%       2.34        perf-stat.overall.cpi
>      30.47            +2.3%      31.16        perf-stat.overall.cycles-between-cache-misses
>       0.44            -3.5%       0.43        perf-stat.overall.ipc
>  1.398e+09           -35.3%  9.049e+08        perf-stat.ps.branch-instructions
>   65124290           -35.0%   42353120 ±  2%  perf-stat.ps.branch-misses
>  4.993e+08           -34.4%  3.276e+08        perf-stat.ps.cache-misses
>  4.993e+08           -34.4%  3.276e+08        perf-stat.ps.cache-references
>      68469           -35.1%      44440        perf-stat.ps.context-switches
>  1.521e+10           -32.9%  1.021e+10        perf-stat.ps.cpu-cycles
>       1884 ±  6%     -34.5%       1234 ±  5%  perf-stat.ps.cpu-migrations
>   10314734 ±  2%     -33.1%    6899548        perf-stat.ps.dTLB-load-misses
>  1.973e+09           -34.9%  1.283e+09        perf-stat.ps.dTLB-loads
>    1624883           -30.7%    1125668        perf-stat.ps.dTLB-store-misses
>  1.126e+09           -32.6%  7.589e+08        perf-stat.ps.dTLB-stores
>   12617676 ± 10%     -37.7%    7866427 ± 13%  perf-stat.ps.iTLB-load-misses
>    9458687 ±  3%     -36.2%    6036594        perf-stat.ps.iTLB-loads
>  6.736e+09           -35.3%  4.361e+09        perf-stat.ps.instructions
>      44179           -31.4%      30288        perf-stat.ps.minor-faults
>      30791            +1.4%      31223        perf-stat.ps.msec
>      44179           -31.4%      30288        perf-stat.ps.page-faults
>      21.96 ± 69%     -22.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      21.96 ± 69%     -22.0        0.00        perf-profile.calltrace.cycles-pp.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.63 ± 89%     -18.6        0.00        perf-profile.calltrace.cycles-pp.search_binary_handler.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.63 ± 89%     -18.6        0.00        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.__do_execve_file.__x64_sys_execve.do_syscall_64
>      13.15 ± 67%      -8.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>       8.81 ±133%      -8.0        0.83 ±173%  perf-profile.calltrace.cycles-pp.ret_from_fork
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.calltrace.cycles-pp.secondary_startup_64
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       6.70 ±100%      -6.7        0.00        perf-profile.calltrace.cycles-pp.__clear_user.load_elf_binary.search_binary_handler.__do_execve_file.__x64_sys_execve
>       4.79 ±108%      -4.8        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_group_exit
>       4.79 ±108%      -4.8        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.do_exit
>       4.79 ±108%      -4.0        0.83 ±173%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.get_signal.do_signal
>       4.79 ±108%      -4.0        0.83 ±173%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.get_signal
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__enable.evsel__enable.evlist__enable
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__enable.evsel__enable
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl.do_vfs_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.__libc_start_main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.evlist__enable.cmd_record.run_builtin.main.__libc_start_main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.evsel__enable.evlist__enable.cmd_record.run_builtin.main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.perf_evsel__enable.evsel__enable.evlist__enable.cmd_record.run_builtin
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.ioctl.perf_evsel__enable.evsel__enable.evlist__enable.cmd_record
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__enable
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.ksys_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.perf_ioctl.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl.do_syscall_64
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp._perf_ioctl.perf_ioctl.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.calltrace.cycles-pp.perf_event_for_each_child._perf_ioctl.perf_ioctl.do_vfs_ioctl.ksys_ioctl
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.calltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.do_signal.exit_to_usermode_loop
>      12.92 ±100%     +12.1       25.00 ±173%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      12.92 ±100%     +12.1       25.00 ±173%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      12.92 ±100%     +12.1       25.00 ±173%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      11.25 ±101%     +13.8       25.00 ±173%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       9.58 ±108%     +15.4       25.00 ±173%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
>      21.96 ± 69%     -22.0        0.00        perf-profile.children.cycles-pp.__x64_sys_execve
>      21.96 ± 69%     -22.0        0.00        perf-profile.children.cycles-pp.__do_execve_file
>      18.63 ± 89%     -18.6        0.00        perf-profile.children.cycles-pp.search_binary_handler
>      18.63 ± 89%     -18.6        0.00        perf-profile.children.cycles-pp.load_elf_binary
>      13.15 ± 67%      -8.2        5.00 ±173%  perf-profile.children.cycles-pp.intel_idle
>       8.81 ±133%      -8.0        0.83 ±173%  perf-profile.children.cycles-pp.ret_from_fork
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.children.cycles-pp.secondary_startup_64
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.children.cycles-pp.start_secondary
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.children.cycles-pp.cpu_startup_entry
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.children.cycles-pp.do_idle
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.children.cycles-pp.cpuidle_enter
>      13.15 ± 67%      -7.3        5.83 ±173%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       6.70 ±100%      -6.7        0.00        perf-profile.children.cycles-pp.__clear_user
>       6.46 ±100%      -6.5        0.00        perf-profile.children.cycles-pp.handle_mm_fault
>       4.79 ±108%      -4.8        0.00        perf-profile.children.cycles-pp.page_fault
>       4.79 ±108%      -4.8        0.00        perf-profile.children.cycles-pp.do_page_fault
>       4.79 ±108%      -4.8        0.00        perf-profile.children.cycles-pp.__do_page_fault
>       4.79 ±108%      -4.8        0.00        perf-profile.children.cycles-pp.free_pgtables
>       4.79 ±108%      -4.8        0.00        perf-profile.children.cycles-pp.unlink_file_vma
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.__libc_start_main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.main
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.run_builtin
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.cmd_record
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.evlist__enable
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.evsel__enable
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.perf_evsel__enable
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.__x64_sys_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.ksys_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.do_vfs_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.perf_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp._perf_ioctl
>       5.24 ±112%      -0.2        5.00 ±173%  perf-profile.children.cycles-pp.perf_event_for_each_child
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.children.cycles-pp.exit_to_usermode_loop
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.children.cycles-pp.do_signal
>       4.79 ±108%      +8.5       13.33 ±173%  perf-profile.children.cycles-pp.get_signal
>       5.24 ±112%      +8.9       14.17 ±173%  perf-profile.children.cycles-pp.event_function_call
>       5.24 ±112%      +8.9       14.17 ±173%  perf-profile.children.cycles-pp.smp_call_function_single
>      12.92 ±100%     +12.1       25.00 ±173%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>      13.15 ± 67%      -8.2        5.00 ±173%  perf-profile.self.cycles-pp.intel_idle
>       6.46 ±100%      -6.5        0.00        perf-profile.self.cycles-pp.unmap_page_range
>       5.24 ±112%      +8.9       14.17 ±173%  perf-profile.self.cycles-pp.smp_call_function_single
> 
