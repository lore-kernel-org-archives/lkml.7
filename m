Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D92C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2692E243D1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfE3BfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:35:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:4704 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfE3BfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:35:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 18:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,529,1549958400"; 
   d="scan'208";a="179779343"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.196.133]) ([10.239.196.133])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2019 18:35:14 -0700
Subject: Re: [LKP] [SUNRPC] 0472e47660: fsmark.app_overhead 16.0% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190520055434.GZ31424@shao2-debian>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <f1abba58-5fd2-5f26-74cc-f72724cfa13f@linux.intel.com>
Date:   Thu, 30 May 2019 09:35:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190520055434.GZ31424@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On 5/20/2019 1:54 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 16.0% improvement of fsmark.app_overhead due to commit:
> 
> 
> commit: 0472e476604998c127f3c80d291113e77c5676ac ("SUNRPC: Convert socket page send code to use iov_iter()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: fsmark
> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
> with following parameters:
> 
> 	iterations: 1x
> 	nr_threads: 64t
> 	disk: 1BRD_48G
> 	fs: xfs
> 	fs2: nfsv4
> 	filesize: 4M
> 	test_size: 40G
> 	sync_method: fsyncBeforeClose
> 	cpufreq_governor: performance
> 
> test-description: The fsmark is a file system benchmark to test synchronous write workloads, for example, mail servers workload.
> test-url: https://sourceforge.net/projects/fsmark/
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>    gcc-7/performance/1BRD_48G/4M/nfsv4/xfs/1x/x86_64-rhel-7.6/64t/debian-x86_64-2018-04-03.cgz/fsyncBeforeClose/lkp-ivb-ep01/40G/fsmark
> 
> commit:
>    e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use iov_iter_kvec()")
>    0472e47660 ("SUNRPC: Convert socket page send code to use iov_iter()")
> 
> e791f8e9380d945e 0472e476604998c127f3c80d291
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :4           50%           2:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>           %stddev     %change         %stddev
>               \          |                \
>    15118573 ±  2%     +16.0%   17538083        fsmark.app_overhead
>      510.93           -22.7%     395.12        fsmark.files_per_sec
>       24.90           +22.8%      30.57        fsmark.time.elapsed_time
>       24.90           +22.8%      30.57        fsmark.time.elapsed_time.max
>      288.00 ±  2%     -27.8%     208.00        fsmark.time.percent_of_cpu_this_job_got
>       70.03 ±  2%     -11.3%      62.14        fsmark.time.system_time
>     4391964           -16.7%    3658341        meminfo.max_used_kB
>        6.10 ±  4%      +1.9        7.97 ±  3%  mpstat.cpu.all.iowait%
>        0.27            -0.0        0.24 ±  3%  mpstat.cpu.all.soft%
>    13668070 ± 40%    +118.0%   29801846 ± 19%  numa-numastat.node0.local_node
>    13677774 ± 40%    +117.9%   29810258 ± 19%  numa-numastat.node0.numa_hit
>        5.70 ±  3%     +32.1%       7.53 ±  3%  iostat.cpu.iowait
>       16.42 ±  2%      -5.8%      15.47        iostat.cpu.system
>        2.57            -4.1%       2.46        iostat.cpu.user
>     1406781 ±  2%     -15.5%    1188498        vmstat.io.bo
>      251792 ±  3%     -16.6%     209928        vmstat.system.cs
>       84841            -1.9%      83239        vmstat.system.in
>    97374502 ± 20%     +66.1%  1.617e+08 ± 17%  cpuidle.C1E.time
>      573934 ± 19%     +44.6%     829662 ± 26%  cpuidle.C1E.usage
>   5.892e+08 ±  8%     +15.3%  6.796e+08 ±  2%  cpuidle.C6.time
>     1968016 ±  3%     -15.1%    1670867 ±  3%  cpuidle.POLL.time
>      106420 ± 47%     +86.2%     198108 ± 35%  numa-meminfo.node0.Active
>      106037 ± 48%     +86.2%     197395 ± 35%  numa-meminfo.node0.Active(anon)
>      105052 ± 48%     +86.6%     196037 ± 35%  numa-meminfo.node0.AnonPages
>      212876 ± 24%     -41.5%     124572 ± 56%  numa-meminfo.node1.Active
>      211801 ± 24%     -41.5%     123822 ± 56%  numa-meminfo.node1.Active(anon)
>      208559 ± 24%     -42.2%     120547 ± 57%  numa-meminfo.node1.AnonPages
>        9955            +1.6%      10116        proc-vmstat.nr_kernel_stack
>      452.25 ± 59%    +280.9%       1722 ±100%  proc-vmstat.numa_hint_faults_local
>    33817303           +55.0%   52421773 ±  5%  proc-vmstat.numa_hit
>    33804286           +55.0%   52408807 ±  5%  proc-vmstat.numa_local
>    33923002           +81.8%   61663426 ±  5%  proc-vmstat.pgalloc_normal
>      184765            +9.3%     201985        proc-vmstat.pgfault
>    12840986          +216.0%   40581327 ±  7%  proc-vmstat.pgfree
>       31447 ± 11%     -26.1%      23253 ± 13%  sched_debug.cfs_rq:/.min_vruntime.max
>        4241 ±  3%     -12.2%       3724 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       20631 ± 11%     -36.7%      13069 ± 29%  sched_debug.cfs_rq:/.spread0.max
>        4238 ±  4%     -12.1%       3724 ± 11%  sched_debug.cfs_rq:/.spread0.stddev
>      497105 ± 19%     -16.0%     417777 ±  4%  sched_debug.cpu.avg_idle.avg
>       21199 ± 10%     -12.0%      18650 ±  3%  sched_debug.cpu.nr_load_updates.max
>        2229 ± 10%     -15.0%       1895 ±  4%  sched_debug.cpu.nr_load_updates.stddev
>        4.86 ±  5%     -23.6%       3.72 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
>      524.75 ±  2%     -10.7%     468.50        turbostat.Avg_MHz
>        5.26 ± 41%      -1.6        3.66 ±  2%  turbostat.C1%
>      573633 ± 19%     +44.6%     829267 ± 26%  turbostat.C1E
>        8.53 ± 20%      +3.4       11.88 ± 17%  turbostat.C1E%
>       76.75            -6.4%      71.86        turbostat.CorWatt
>     2534071 ±  2%     +16.2%    2943968        turbostat.IRQ
>        2.89 ± 24%     +52.9%       4.42 ± 22%  turbostat.Pkg%pc2
>      104.28            -4.6%      99.51        turbostat.PkgWatt
>        2289           +18.8%       2720        turbostat.SMI
>       26496 ± 47%     +86.2%      49347 ± 35%  numa-vmstat.node0.nr_active_anon
>       26251 ± 48%     +86.7%      49008 ± 35%  numa-vmstat.node0.nr_anon_pages
>       26496 ± 47%     +86.2%      49347 ± 35%  numa-vmstat.node0.nr_zone_active_anon
>     8272770 ± 35%     +99.6%   16515977 ± 17%  numa-vmstat.node0.numa_hit
>     8199681 ± 36%    +100.9%   16474282 ± 17%  numa-vmstat.node0.numa_local
>       52953 ± 24%     -41.5%      30956 ± 56%  numa-vmstat.node1.nr_active_anon
>       52144 ± 24%     -42.2%      30136 ± 57%  numa-vmstat.node1.nr_anon_pages
>        2899 ±  2%     -19.4%       2336 ± 10%  numa-vmstat.node1.nr_writeback
>       52953 ± 24%     -41.5%      30956 ± 56%  numa-vmstat.node1.nr_zone_active_anon
>        4549 ±  8%     -18.9%       3689 ±  7%  numa-vmstat.node1.nr_zone_write_pending
>       43.25            -1.6       41.69        perf-stat.i.cache-miss-rate%
>      286377 ±  2%     -19.1%     231819 ±  2%  perf-stat.i.context-switches
>   2.258e+10 ±  4%     -16.2%  1.893e+10 ± 10%  perf-stat.i.cpu-cycles
>        4084           -34.0%       2696 ±  2%  perf-stat.i.cpu-migrations
>    21563675 ± 24%     -30.8%   14929445 ±  5%  perf-stat.i.dTLB-load-misses
>     1996341 ± 16%     -25.7%    1482826 ±  6%  perf-stat.i.dTLB-store-misses
>   2.313e+09 ±  4%     -11.7%  2.042e+09 ±  6%  perf-stat.i.dTLB-stores
>       75.93            -1.3       74.66        perf-stat.i.iTLB-load-miss-rate%
>     1561381 ±  3%     -13.4%    1351731        perf-stat.i.iTLB-load-misses
>      549643 ±  4%     -10.1%     494255 ±  3%  perf-stat.i.iTLB-loads
>        6423           -10.0%       5779        perf-stat.i.minor-faults
>       31.72 ±  2%      +4.4       36.14        perf-stat.i.node-load-miss-rate%
>    23492890           +23.5%   29020305 ±  3%  perf-stat.i.node-load-misses
>       15.13 ±  8%      +7.9       23.02 ±  3%  perf-stat.i.node-store-miss-rate%
>    11517615           +71.3%   19734054 ±  2%  perf-stat.i.node-store-misses
>        6423           -10.0%       5779        perf-stat.i.page-faults
>       16.88 ± 14%     +33.4%      22.52 ± 23%  perf-stat.overall.MPKI
>       46.67            -2.4       44.31        perf-stat.overall.cache-miss-rate%
>       31.96            +4.8       36.72        perf-stat.overall.node-load-miss-rate%
>       13.85            +8.0       21.87        perf-stat.overall.node-store-miss-rate%
>   2.266e+08            +2.8%  2.331e+08 ±  2%  perf-stat.ps.cache-references
>      275634 ±  2%     -18.5%     224718 ±  2%  perf-stat.ps.context-switches
>   2.174e+10 ±  4%     -15.6%  1.835e+10 ± 10%  perf-stat.ps.cpu-cycles
>        3931           -33.5%       2614 ±  2%  perf-stat.ps.cpu-migrations
>    20746040 ± 24%     -30.2%   14476157 ±  5%  perf-stat.ps.dTLB-load-misses
>     1921077 ± 16%     -25.2%    1437750 ±  6%  perf-stat.ps.dTLB-store-misses
>   2.227e+09 ±  4%     -11.1%  1.979e+09 ±  6%  perf-stat.ps.dTLB-stores
>     1503433 ±  3%     -12.8%    1310741        perf-stat.ps.iTLB-load-misses
>      529058 ±  4%      -9.4%     479204 ±  3%  perf-stat.ps.iTLB-loads
>        6200            -9.4%       5620        perf-stat.ps.minor-faults
>    22613159           +24.4%   28133123 ±  3%  perf-stat.ps.node-load-misses
>    11085254           +72.6%   19131576 ±  2%  perf-stat.ps.node-store-misses
>        6200            -9.4%       5620        perf-stat.ps.page-faults
>        7008 ± 13%     +55.2%      10876 ± 31%  softirqs.CPU1.NET_RX
>        6509 ±  4%     +51.8%       9883 ± 27%  softirqs.CPU1.RCU
>        7294 ± 13%     +36.7%       9974 ±  8%  softirqs.CPU10.RCU
>        7800 ± 14%     +85.5%      14469 ± 23%  softirqs.CPU12.NET_RX
>        5697 ± 43%     +77.5%      10110 ± 24%  softirqs.CPU13.NET_RX
>       15944 ±  9%     +14.6%      18278 ± 12%  softirqs.CPU14.TIMER
>        6064 ± 19%     +68.6%      10223 ± 31%  softirqs.CPU15.NET_RX
>        7796 ± 14%     +80.3%      14059 ± 25%  softirqs.CPU16.NET_RX
>       15934 ± 10%     +22.1%      19452 ± 11%  softirqs.CPU18.TIMER
>        6725 ±  7%     +40.0%       9413 ± 18%  softirqs.CPU19.NET_RX
>        5710 ±  3%     +53.4%       8756 ± 12%  softirqs.CPU20.RCU
>        7018 ± 14%     +65.5%      11616 ± 40%  softirqs.CPU21.NET_RX
>        6389 ± 18%     +66.9%      10666 ± 31%  softirqs.CPU23.NET_RX
>        7259 ±  7%     +36.1%       9881 ±  6%  softirqs.CPU24.RCU
>        6491 ± 20%     +58.5%      10289 ± 33%  softirqs.CPU25.NET_RX
>        7090 ± 10%     +58.7%      11256 ± 29%  softirqs.CPU27.NET_RX
>        6333 ± 27%     +70.3%      10786 ± 27%  softirqs.CPU29.NET_RX
>        5813 ± 20%     +84.2%      10706 ± 36%  softirqs.CPU3.NET_RX
>        7041 ± 23%    +105.7%      14483 ± 21%  softirqs.CPU30.NET_RX
>        6654 ±  7%     +64.1%      10918 ± 29%  softirqs.CPU31.NET_RX
>       18019 ± 10%     +11.1%      20016 ±  7%  softirqs.CPU31.TIMER
>        4666 ±  8%    +104.0%       9518 ± 23%  softirqs.CPU32.RCU
>       15721 ± 16%     +35.9%      21371 ± 11%  softirqs.CPU32.TIMER
>       15684 ± 13%     +40.0%      21959 ± 18%  softirqs.CPU34.TIMER
>        6489 ± 15%     +69.7%      11013 ± 37%  softirqs.CPU35.NET_RX
>        7930 ±  7%     +82.1%      14442 ± 29%  softirqs.CPU36.NET_RX
>       15744 ± 14%     +24.3%      19563 ±  6%  softirqs.CPU36.TIMER
>        7028 ± 13%     +29.3%       9085 ± 11%  softirqs.CPU39.NET_RX
>        7491 ± 22%    +100.4%      15011 ± 24%  softirqs.CPU4.NET_RX
>        6119 ± 13%     +58.7%       9710 ± 37%  softirqs.CPU5.NET_RX
>        6980 ±  8%     +47.8%      10318 ± 42%  softirqs.CPU7.NET_RX
>      285674           +65.7%     473395        softirqs.NET_RX
>      267950 ±  5%     +21.1%     324597        softirqs.RCU
>      238298 ±  2%     +15.1%     274371 ±  2%  softirqs.SCHED
>      689305 ±  3%     +14.1%     786236 ±  3%  softirqs.TIMER
>       56196 ±  2%     +19.9%      67389        interrupts.CPU0.LOC:Local_timer_interrupts
>       55971 ±  2%     +19.7%      67005        interrupts.CPU1.LOC:Local_timer_interrupts
>        5265 ± 17%     -32.2%       3568 ± 29%  interrupts.CPU1.RES:Rescheduling_interrupts
>       56163 ±  2%     +19.2%      66960        interrupts.CPU10.LOC:Local_timer_interrupts
>       56178 ±  2%     +19.5%      67139        interrupts.CPU11.LOC:Local_timer_interrupts
>        4669 ± 15%     -30.3%       3253 ± 29%  interrupts.CPU11.RES:Rescheduling_interrupts
>       56081           +19.7%      67142        interrupts.CPU12.LOC:Local_timer_interrupts
>       55999 ±  2%     +19.5%      66893        interrupts.CPU13.LOC:Local_timer_interrupts
>        4746 ± 23%     -30.0%       3324 ± 29%  interrupts.CPU13.RES:Rescheduling_interrupts
>       55991 ±  2%     +19.5%      66898        interrupts.CPU14.LOC:Local_timer_interrupts
>       55855 ±  2%     +20.0%      67031        interrupts.CPU15.LOC:Local_timer_interrupts
>       55943 ±  2%     +19.9%      67087        interrupts.CPU16.LOC:Local_timer_interrupts
>       56164           +18.9%      66802        interrupts.CPU17.LOC:Local_timer_interrupts
>        4579 ± 20%     -45.6%       2492 ± 16%  interrupts.CPU17.RES:Rescheduling_interrupts
>       55913 ±  2%     +19.6%      66860        interrupts.CPU18.LOC:Local_timer_interrupts
>       55820 ±  2%     +19.7%      66822        interrupts.CPU19.LOC:Local_timer_interrupts
>        4733 ± 17%     -35.5%       3052 ± 21%  interrupts.CPU19.RES:Rescheduling_interrupts
>       55989 ±  2%     +20.0%      67177        interrupts.CPU2.LOC:Local_timer_interrupts
>       55891 ±  2%     +20.3%      67258        interrupts.CPU20.LOC:Local_timer_interrupts
>       55966 ±  2%     +19.6%      66921        interrupts.CPU21.LOC:Local_timer_interrupts
>        4920 ± 21%     -33.4%       3278 ± 31%  interrupts.CPU21.RES:Rescheduling_interrupts
>       55945 ±  2%     +19.9%      67098        interrupts.CPU22.LOC:Local_timer_interrupts
>       55945 ±  2%     +19.9%      67073        interrupts.CPU23.LOC:Local_timer_interrupts
>        4972 ± 24%     -34.1%       3277 ± 36%  interrupts.CPU23.RES:Rescheduling_interrupts
>       56093 ±  2%     +19.8%      67185        interrupts.CPU24.LOC:Local_timer_interrupts
>       55910 ±  2%     +19.7%      66914        interrupts.CPU25.LOC:Local_timer_interrupts
>        4660 ± 25%     -28.9%       3313 ± 34%  interrupts.CPU25.RES:Rescheduling_interrupts
>       56105 ±  2%     +18.8%      66631        interrupts.CPU26.LOC:Local_timer_interrupts
>       55928 ±  2%     +19.5%      66827        interrupts.CPU27.LOC:Local_timer_interrupts
>       55934 ±  2%     +19.3%      66740        interrupts.CPU28.LOC:Local_timer_interrupts
>       55918 ±  2%     +19.5%      66812        interrupts.CPU29.LOC:Local_timer_interrupts
>        4825 ± 22%     -30.3%       3362 ± 30%  interrupts.CPU29.RES:Rescheduling_interrupts
>       55920 ±  2%     +19.8%      67004        interrupts.CPU3.LOC:Local_timer_interrupts
>       56007 ±  2%     +19.5%      66917        interrupts.CPU30.LOC:Local_timer_interrupts
>       56238           +18.8%      66838        interrupts.CPU31.LOC:Local_timer_interrupts
>        4859 ± 21%     -33.0%       3257 ± 36%  interrupts.CPU31.RES:Rescheduling_interrupts
>       56099           +19.3%      66921        interrupts.CPU32.LOC:Local_timer_interrupts
>       55963 ±  2%     +19.5%      66866        interrupts.CPU33.LOC:Local_timer_interrupts
>       55992 ±  2%     +19.2%      66767        interrupts.CPU34.LOC:Local_timer_interrupts
>       55964 ±  2%     +19.6%      66939        interrupts.CPU35.LOC:Local_timer_interrupts
>        4797 ± 26%     -33.6%       3185 ± 38%  interrupts.CPU35.RES:Rescheduling_interrupts
>       55770 ±  2%     +20.2%      67016        interrupts.CPU36.LOC:Local_timer_interrupts
>       55889           +20.0%      67095        interrupts.CPU37.LOC:Local_timer_interrupts
>       56140 ±  2%     +18.9%      66743        interrupts.CPU38.LOC:Local_timer_interrupts
>       56040 ±  2%     +19.2%      66828        interrupts.CPU39.LOC:Local_timer_interrupts
>        5126 ± 23%     -40.5%       3052 ± 11%  interrupts.CPU39.RES:Rescheduling_interrupts
>       56022 ±  2%     +19.9%      67149        interrupts.CPU4.LOC:Local_timer_interrupts
>       55850 ±  2%     +20.1%      67066        interrupts.CPU5.LOC:Local_timer_interrupts
>        4741 ± 23%     -31.9%       3227 ± 29%  interrupts.CPU5.RES:Rescheduling_interrupts
>       55912           +19.5%      66798        interrupts.CPU6.LOC:Local_timer_interrupts
>       56062 ±  2%     +19.6%      67052        interrupts.CPU7.LOC:Local_timer_interrupts
>       56118           +19.6%      67142        interrupts.CPU8.LOC:Local_timer_interrupts
>       56110 ±  2%     +19.6%      67121        interrupts.CPU9.LOC:Local_timer_interrupts
>        2216 ± 43%     -69.4%     677.50 ±112%  interrupts.CPU9.NMI:Non-maskable_interrupts
>        2216 ± 43%     -69.4%     677.50 ±112%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
>     2240009 ±  2%     +19.6%    2678940        interrupts.LOC:Local_timer_interrupts
>      168296 ±  3%     -10.1%     151314        interrupts.RES:Rescheduling_interrupts
>       20.37            -3.3       17.04 ±  5%  perf-profile.calltrace.cycles-pp.svc_process_common.svc_process.nfsd.kthread.ret_from_fork
>       20.38            -3.3       17.04 ±  5%  perf-profile.calltrace.cycles-pp.svc_process.nfsd.kthread.ret_from_fork
>       20.27            -3.3       16.95 ±  5%  perf-profile.calltrace.cycles-pp.nfsd_dispatch.svc_process_common.svc_process.nfsd.kthread
>       20.21            -3.3       16.91 ±  5%  perf-profile.calltrace.cycles-pp.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process.nfsd
>       26.02            -3.1       22.91 ±  4%  perf-profile.calltrace.cycles-pp.nfsd.kthread.ret_from_fork
>        9.04 ±  2%      -1.9        7.18 ±  7%  perf-profile.calltrace.cycles-pp.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
>        9.02 ±  2%      -1.9        7.17 ±  7%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound
>        9.02 ±  2%      -1.9        7.16 ±  7%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.do_iter_readv_writev.do_iter_write.nfsd_vfs_write.nfsd4_write
>        9.03 ±  2%      -1.9        7.18 ±  7%  perf-profile.calltrace.cycles-pp.do_iter_write.nfsd_vfs_write.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch
>        9.07 ±  2%      -1.9        7.22 ±  7%  perf-profile.calltrace.cycles-pp.nfsd4_write.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
>       10.50 ±  2%      -1.4        9.06 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_fsync.nfsd_commit.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
>       10.51 ±  2%      -1.4        9.08 ±  4%  perf-profile.calltrace.cycles-pp.nfsd_commit.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
>       10.45 ±  2%      -1.4        9.02 ±  4%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.nfsd_commit.nfsd4_proc_compound.nfsd_dispatch
>        9.82 ±  3%      -1.4        8.45 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.nfsd_commit.nfsd4_proc_compound
>        9.82 ±  3%      -1.4        8.45 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.nfsd_commit
>        9.82 ±  3%      -1.4        8.45 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
>       10.61 ±  5%      -1.1        9.46 ±  4%  perf-profile.calltrace.cycles-pp.write
>        7.54            -1.1        6.41 ±  6%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.do_iter_readv_writev.do_iter_write
>        7.54            -1.1        6.41 ±  6%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.do_iter_readv_writev.do_iter_write.nfsd_vfs_write
>       10.27 ±  5%      -1.1        9.15 ±  4%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        7.49            -1.1        6.37 ±  6%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.do_iter_readv_writev
>       10.23 ±  5%      -1.1        9.11 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       10.35 ±  5%      -1.1        9.23 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       10.08 ±  5%      -1.1        8.96 ±  4%  perf-profile.calltrace.cycles-pp.__vfs_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       10.33 ±  5%      -1.1        9.22 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       10.05 ±  5%      -1.1        8.95 ±  4%  perf-profile.calltrace.cycles-pp.nfs_file_write.__vfs_write.vfs_write.ksys_write.do_syscall_64
>        9.80 ±  5%      -1.1        8.73 ±  4%  perf-profile.calltrace.cycles-pp.generic_perform_write.nfs_file_write.__vfs_write.vfs_write.ksys_write
>        5.31 ±  5%      -1.0        4.27 ±  5%  perf-profile.calltrace.cycles-pp.rpc_free_task.rpc_async_release.process_one_work.worker_thread.kthread
>        5.31 ±  5%      -1.0        4.27 ±  5%  perf-profile.calltrace.cycles-pp.rpc_async_release.process_one_work.worker_thread.kthread.ret_from_fork
>        4.38 ±  5%      -1.0        3.35 ±  2%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.svc_recvfrom.svc_tcp_recvfrom.svc_recv
>        4.38 ±  6%      -1.0        3.36 ±  2%  perf-profile.calltrace.cycles-pp.inet_recvmsg.svc_recvfrom.svc_tcp_recvfrom.svc_recv.nfsd
>        4.39 ±  6%      -1.0        3.40 ±  2%  perf-profile.calltrace.cycles-pp.svc_recvfrom.svc_tcp_recvfrom.svc_recv.nfsd.kthread
>        3.53 ±  5%      -0.9        2.62 ±  3%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.svc_recvfrom.svc_tcp_recvfrom
>        3.52 ±  5%      -0.9        2.62 ±  3%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.svc_recvfrom
>        5.01 ±  6%      -0.9        4.14 ±  3%  perf-profile.calltrace.cycles-pp.fsync
>        4.09 ±  7%      -0.8        3.24 ±  5%  perf-profile.calltrace.cycles-pp.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work.worker_thread
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.calltrace.cycles-pp.nfs_file_fsync.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
>        5.84 ±  2%      -0.8        5.01 ±  4%  perf-profile.calltrace.cycles-pp.write_cache_pages.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
>        1.15 ±  7%      -0.8        0.36 ±100%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_failed.call_rwsem_down_write_failed.down_write.xfs_ilock
>        4.38 ±  7%      -0.8        3.59 ±  3%  perf-profile.calltrace.cycles-pp.filemap_write_and_wait_range.nfs_file_fsync.do_fsync.__x64_sys_fsync.do_syscall_64
>        5.17 ±  2%      -0.8        4.39 ±  5%  perf-profile.calltrace.cycles-pp.xfs_do_writepage.write_cache_pages.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range
>        4.89 ±  4%      -0.7        4.18 ±  5%  perf-profile.calltrace.cycles-pp.brd_insert_page.brd_do_bvec.brd_make_request.generic_make_request.submit_bio
>        1.38 ±  9%      -0.7        0.68 ± 22%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_buffered_aio_write.do_iter_readv_writev.do_iter_write
>        1.38 ±  9%      -0.7        0.68 ± 22%  perf-profile.calltrace.cycles-pp.call_rwsem_down_write_failed.down_write.xfs_ilock.xfs_file_buffered_aio_write.do_iter_readv_writev
>        1.38 ±  9%      -0.7        0.68 ± 22%  perf-profile.calltrace.cycles-pp.rwsem_down_write_failed.call_rwsem_down_write_failed.down_write.xfs_ilock.xfs_file_buffered_aio_write
>        1.38 ±  9%      -0.7        0.68 ± 22%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_aio_write.do_iter_readv_writev.do_iter_write.nfsd_vfs_write
>        4.01 ±  3%      -0.6        3.40 ±  5%  perf-profile.calltrace.cycles-pp.brd_make_request.generic_make_request.submit_bio.xfs_add_to_ioend.xfs_do_writepage
>        4.01 ±  3%      -0.6        3.40 ±  5%  perf-profile.calltrace.cycles-pp.submit_bio.xfs_add_to_ioend.xfs_do_writepage.write_cache_pages.xfs_vm_writepages
>        4.01 ±  3%      -0.6        3.40 ±  5%  perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.xfs_add_to_ioend.xfs_do_writepage.write_cache_pages
>        3.99 ±  3%      -0.6        3.38 ±  5%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_make_request.generic_make_request.submit_bio.xfs_add_to_ioend
>        4.11 ±  3%      -0.6        3.51 ±  4%  perf-profile.calltrace.cycles-pp.xfs_add_to_ioend.xfs_do_writepage.write_cache_pages.xfs_vm_writepages.do_writepages
>        3.97 ±  5%      -0.5        3.43 ±  4%  perf-profile.calltrace.cycles-pp.submit_bio.xfs_submit_ioend.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range
>        3.97 ±  5%      -0.5        3.43 ±  4%  perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.xfs_submit_ioend.xfs_vm_writepages.do_writepages
>        3.98 ±  5%      -0.5        3.44 ±  4%  perf-profile.calltrace.cycles-pp.xfs_submit_ioend.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
>        3.96 ±  5%      -0.5        3.43 ±  4%  perf-profile.calltrace.cycles-pp.brd_make_request.generic_make_request.submit_bio.xfs_submit_ioend.xfs_vm_writepages
>        3.92 ±  5%      -0.5        3.40 ±  4%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_make_request.generic_make_request.submit_bio.xfs_submit_ioend
>        2.89 ±  6%      -0.5        2.38 ±  6%  perf-profile.calltrace.cycles-pp.nfs_end_page_writeback.nfs_write_completion.rpc_free_task.rpc_async_release.process_one_work
>        2.77 ± 10%      -0.5        2.28 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.filemap_write_and_wait_range.nfs_file_fsync.do_fsync.__x64_sys_fsync
>        2.77 ± 10%      -0.5        2.28 ±  2%  perf-profile.calltrace.cycles-pp.nfs_writepages.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.nfs_file_fsync
>        2.77 ± 10%      -0.5        2.28 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.nfs_file_fsync.do_fsync
>        2.74 ± 10%      -0.5        2.25 ±  2%  perf-profile.calltrace.cycles-pp.write_cache_pages.nfs_writepages.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range
>        3.12 ±  7%      -0.5        2.64 ±  4%  perf-profile.calltrace.cycles-pp.nfs_write_begin.generic_perform_write.nfs_file_write.__vfs_write.vfs_write
>        2.93 ±  7%      -0.5        2.47 ±  3%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.nfs_write_begin.generic_perform_write.nfs_file_write.__vfs_write
>        3.37 ±  4%      -0.5        2.91 ±  4%  perf-profile.calltrace.cycles-pp.nfs_write_end.generic_perform_write.nfs_file_write.__vfs_write.vfs_write
>        2.51 ±  4%      -0.4        2.06 ±  7%  perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec
>        3.12 ±  5%      -0.4        2.68 ±  7%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec.brd_make_request.generic_make_request
>        2.91 ±  5%      -0.4        2.48 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
>        3.02 ±  5%      -0.4        2.59 ±  7%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec.brd_make_request
>        2.59 ±  4%      -0.4        2.18 ±  5%  perf-profile.calltrace.cycles-pp.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write.__vfs_write
>        2.84 ±  7%      -0.4        2.43 ±  3%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.nfs_write_begin.generic_perform_write.nfs_file_write
>        3.27            -0.4        2.86 ±  6%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
>        3.20            -0.4        2.79 ±  6%  perf-profile.calltrace.cycles-pp.memcpy_erms.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
>        2.85 ±  5%      -0.4        2.44 ±  3%  perf-profile.calltrace.cycles-pp.memcpy_erms._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg
>        2.50 ±  4%      -0.4        2.14 ±  7%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
>        2.41 ±  4%      -0.4        2.06 ±  7%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
>        2.02 ± 11%      -0.3        1.67 ±  3%  perf-profile.calltrace.cycles-pp.nfs_writepages_callback.write_cache_pages.nfs_writepages.do_writepages.__filemap_fdatawrite_range
>        0.60 ±  8%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
>        1.96 ± 11%      -0.3        1.62 ±  3%  perf-profile.calltrace.cycles-pp.nfs_do_writepage.nfs_writepages_callback.write_cache_pages.nfs_writepages.do_writepages
>        1.55 ±  2%      -0.3        1.22 ±  5%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
>        2.35 ±  4%      -0.3        2.03 ±  7%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
>        1.60 ±  2%      -0.3        1.32 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_file_fsync.do_fsync.__x64_sys_fsync
>        1.49 ±  6%      -0.2        1.24 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_make_request.generic_make_request
>        1.03 ±  6%      -0.2        0.80 ±  7%  perf-profile.calltrace.cycles-pp.end_page_writeback.nfs_end_page_writeback.nfs_write_completion.rpc_free_task.rpc_async_release
>        0.97 ±  7%      -0.2        0.74 ±  9%  perf-profile.calltrace.cycles-pp.test_clear_page_writeback.end_page_writeback.nfs_end_page_writeback.nfs_write_completion.rpc_free_task
>        1.45 ±  6%      -0.2        1.23 ±  4%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.nfs_write_begin.generic_perform_write
>        0.97 ±  4%      -0.2        0.77 ±  3%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
>        1.22 ±  6%      -0.2        1.03 ±  6%  perf-profile.calltrace.cycles-pp.nfs_commit_release_pages.nfs_commit_release.rpc_free_task.rpc_async_release.process_one_work
>        1.22 ±  6%      -0.2        1.03 ±  5%  perf-profile.calltrace.cycles-pp.nfs_commit_release.rpc_free_task.rpc_async_release.process_one_work.worker_thread
>        1.25 ±  5%      -0.2        1.06 ±  8%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
>        1.06 ±  2%      -0.2        0.87 ±  4%  perf-profile.calltrace.cycles-pp.wait_on_page_bit_common.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_file_fsync.do_fsync
>        1.27 ±  5%      -0.2        1.11 ±  6%  perf-profile.calltrace.cycles-pp.wake_up_page_bit.nfs_end_page_writeback.nfs_write_completion.rpc_free_task.rpc_async_release
>        0.78 ±  8%      -0.2        0.63 ±  6%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write
>        1.11 ±  7%      -0.1        0.99 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_page_bit.nfs_end_page_writeback.nfs_write_completion.rpc_free_task
>        0.68            -0.1        0.57 ±  5%  perf-profile.calltrace.cycles-pp.nfs_create_request.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write
>        1.04 ±  7%      -0.1        0.93 ±  5%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.wake_up_page_bit.nfs_end_page_writeback.nfs_write_completion
>        1.02 ±  8%      -0.1        0.92 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.wake_up_page_bit.nfs_end_page_writeback
>        0.71 ±  2%      -0.1        0.60 ±  8%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.wait_on_page_bit_common.__filemap_fdatawait_range
>        0.72 ±  2%      -0.1        0.61 ±  8%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.wait_on_page_bit_common.__filemap_fdatawait_range.filemap_write_and_wait_range
>        0.72            -0.1        0.62 ±  7%  perf-profile.calltrace.cycles-pp.io_schedule.wait_on_page_bit_common.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_file_fsync
>        0.93 ±  5%      -0.1        0.83 ±  5%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.pagecache_get_page.grab_cache_page_write_begin.nfs_write_begin.generic_perform_write
>        0.73            -0.1        0.67 ±  5%  perf-profile.calltrace.cycles-pp.end_page_writeback.xfs_destroy_ioend.process_one_work.worker_thread.kthread
>        4.86 ±  6%      +0.5        5.39        perf-profile.calltrace.cycles-pp.svc_recv.nfsd.kthread.ret_from_fork
>        0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.svc_recv.nfsd.kthread
>        0.00            +0.6        0.59 ±  6%  perf-profile.calltrace.cycles-pp.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
>        0.00            +0.6        0.63 ±  6%  perf-profile.calltrace.cycles-pp.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
>        0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.svc_recv.nfsd.kthread.ret_from_fork
>        0.00            +0.7        0.74 ±  8%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
>        0.00            +0.9        0.86 ±  8%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xs_sendpages
>        9.98 ±  4%      +2.5       12.44 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>        9.61 ±  4%      +2.5       12.15 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>       47.02 ±  3%      +2.7       49.68 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64
>        0.00            +3.5        3.54 ±  3%  perf-profile.calltrace.cycles-pp.memcpy_erms.memcpy_from_page._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg
>        0.00            +3.6        3.56 ±  3%  perf-profile.calltrace.cycles-pp.memcpy_from_page._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
>        0.00            +3.7        3.67 ±  3%  perf-profile.calltrace.cycles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xs_sendpages
>        2.29 ±  6%      +3.8        6.05 ±  3%  perf-profile.calltrace.cycles-pp.rpc_async_schedule.process_one_work.worker_thread.kthread.ret_from_fork
>        2.28 ±  6%      +3.8        6.05 ±  3%  perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread.kthread
>        1.86 ±  3%      +3.8        5.64 ±  4%  perf-profile.calltrace.cycles-pp.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread
>        1.85 ±  3%      +3.8        5.64 ±  4%  perf-profile.calltrace.cycles-pp.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work
>        1.80 ±  4%      +3.8        5.60 ±  4%  perf-profile.calltrace.cycles-pp.xs_tcp_send_request.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule
>        1.79 ±  3%      +3.8        5.60 ±  4%  perf-profile.calltrace.cycles-pp.xs_sendpages.xs_tcp_send_request.xprt_transmit.call_transmit.__rpc_execute
>        0.00            +5.5        5.47 ±  4%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xs_sendpages.xs_tcp_send_request
>        0.00            +5.6        5.56 ±  4%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.xs_sendpages.xs_tcp_send_request.xprt_transmit
>        0.00            +5.6        5.57 ±  4%  perf-profile.calltrace.cycles-pp.sock_sendmsg.xs_sendpages.xs_tcp_send_request.xprt_transmit.call_transmit
>       20.37            -3.3       17.04 ±  5%  perf-profile.children.cycles-pp.svc_process_common
>       20.38            -3.3       17.04 ±  5%  perf-profile.children.cycles-pp.svc_process
>       20.27            -3.3       16.95 ±  5%  perf-profile.children.cycles-pp.nfsd_dispatch
>       20.21            -3.3       16.91 ±  5%  perf-profile.children.cycles-pp.nfsd4_proc_compound
>       26.02            -3.1       22.91 ±  4%  perf-profile.children.cycles-pp.nfsd
>       15.88 ±  5%      -1.9       13.95 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       15.87 ±  5%      -1.9       13.95 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
>       12.61 ±  3%      -1.9       10.73 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
>       12.60 ±  3%      -1.9       10.73 ±  3%  perf-profile.children.cycles-pp.do_writepages
>        9.04 ±  2%      -1.9        7.18 ±  7%  perf-profile.children.cycles-pp.nfsd_vfs_write
>        9.02 ±  2%      -1.9        7.17 ±  7%  perf-profile.children.cycles-pp.do_iter_readv_writev
>        9.02 ±  2%      -1.9        7.16 ±  7%  perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
>        9.03 ±  2%      -1.9        7.18 ±  7%  perf-profile.children.cycles-pp.do_iter_write
>        9.07 ±  2%      -1.9        7.22 ±  7%  perf-profile.children.cycles-pp.nfsd4_write
>        2.21 ±  4%      -1.8        0.41 ±  4%  perf-profile.children.cycles-pp.inet_sendpage
>        2.17 ±  4%      -1.8        0.40 ±  5%  perf-profile.children.cycles-pp.tcp_sendpage
>       10.50 ±  2%      -1.4        9.06 ±  4%  perf-profile.children.cycles-pp.xfs_file_fsync
>       10.51 ±  2%      -1.4        9.08 ±  4%  perf-profile.children.cycles-pp.nfsd_commit
>       10.45 ±  2%      -1.4        9.02 ±  4%  perf-profile.children.cycles-pp.file_write_and_wait_range
>        9.82 ±  3%      -1.4        8.45 ±  3%  perf-profile.children.cycles-pp.xfs_vm_writepages
>        8.59 ±  4%      -1.3        7.27 ±  4%  perf-profile.children.cycles-pp.write_cache_pages
>        8.02 ±  4%      -1.2        6.87 ±  4%  perf-profile.children.cycles-pp.submit_bio
>        8.02 ±  4%      -1.2        6.87 ±  4%  perf-profile.children.cycles-pp.generic_make_request
>        8.00 ±  4%      -1.1        6.85 ±  4%  perf-profile.children.cycles-pp.brd_make_request
>        7.94 ±  4%      -1.1        6.79 ±  4%  perf-profile.children.cycles-pp.brd_do_bvec
>       10.63 ±  5%      -1.1        9.49 ±  4%  perf-profile.children.cycles-pp.write
>        7.55            -1.1        6.41 ±  5%  perf-profile.children.cycles-pp.iomap_apply
>        7.54            -1.1        6.41 ±  6%  perf-profile.children.cycles-pp.iomap_file_buffered_write
>       10.28 ±  5%      -1.1        9.16 ±  4%  perf-profile.children.cycles-pp.ksys_write
>        7.50            -1.1        6.37 ±  6%  perf-profile.children.cycles-pp.iomap_write_actor
>        4.68 ±  5%      -1.1        3.56 ±  2%  perf-profile.children.cycles-pp.inet_recvmsg
>        4.68 ±  5%      -1.1        3.56 ±  2%  perf-profile.children.cycles-pp.tcp_recvmsg
>       10.24 ±  5%      -1.1        9.12 ±  4%  perf-profile.children.cycles-pp.vfs_write
>       10.08 ±  5%      -1.1        8.98 ±  4%  perf-profile.children.cycles-pp.__vfs_write
>       10.05 ±  5%      -1.1        8.95 ±  4%  perf-profile.children.cycles-pp.nfs_file_write
>        5.51 ±  5%      -1.1        4.43 ±  5%  perf-profile.children.cycles-pp.rpc_free_task
>        9.82 ±  5%      -1.1        8.74 ±  4%  perf-profile.children.cycles-pp.generic_perform_write
>        1.39 ±  5%      -1.1        0.32 ±  4%  perf-profile.children.cycles-pp.tcp_sendpage_locked
>        1.36 ±  5%      -1.1        0.31 ±  5%  perf-profile.children.cycles-pp.do_tcp_sendpages
>        5.31 ±  5%      -1.0        4.27 ±  5%  perf-profile.children.cycles-pp.rpc_async_release
>        4.39 ±  6%      -1.0        3.40 ±  2%  perf-profile.children.cycles-pp.svc_recvfrom
>        3.55 ±  5%      -0.9        2.64 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
>        3.55 ±  5%      -0.9        2.64 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
>        5.01 ±  6%      -0.9        4.15 ±  3%  perf-profile.children.cycles-pp.fsync
>        4.09 ±  7%      -0.9        3.24 ±  5%  perf-profile.children.cycles-pp.nfs_write_completion
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.children.cycles-pp.__x64_sys_fsync
>        4.91 ±  6%      -0.8        4.07 ±  3%  perf-profile.children.cycles-pp.nfs_file_fsync
>        4.90 ±  6%      -0.8        4.05 ±  3%  perf-profile.children.cycles-pp.do_fsync
>        5.36 ±  4%      -0.8        4.53 ±  5%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
>        4.39 ±  7%      -0.8        3.60 ±  2%  perf-profile.children.cycles-pp.filemap_write_and_wait_range
>        5.18 ±  2%      -0.8        4.40 ±  5%  perf-profile.children.cycles-pp.xfs_do_writepage
>        5.21 ±  4%      -0.7        4.47 ±  5%  perf-profile.children.cycles-pp.pagecache_get_page
>        4.90 ±  4%      -0.7        4.19 ±  5%  perf-profile.children.cycles-pp.brd_insert_page
>        1.38 ±  9%      -0.7        0.68 ± 22%  perf-profile.children.cycles-pp.xfs_ilock
>        1.41 ±  8%      -0.7        0.71 ± 22%  perf-profile.children.cycles-pp.call_rwsem_down_write_failed
>        1.41 ±  8%      -0.7        0.71 ± 22%  perf-profile.children.cycles-pp.rwsem_down_write_failed
>        1.44 ±  7%      -0.7        0.74 ± 21%  perf-profile.children.cycles-pp.down_write
>        4.12 ±  3%      -0.6        3.52 ±  4%  perf-profile.children.cycles-pp.xfs_add_to_ioend
>        1.18 ±  6%      -0.6        0.61 ± 21%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>        3.98 ±  5%      -0.5        3.44 ±  4%  perf-profile.children.cycles-pp.xfs_submit_ioend
>        6.25            -0.5        5.72 ±  4%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
>        2.89 ±  6%      -0.5        2.38 ±  6%  perf-profile.children.cycles-pp.nfs_end_page_writeback
>        2.78 ± 10%      -0.5        2.29 ±  2%  perf-profile.children.cycles-pp.nfs_writepages
>        3.12 ±  7%      -0.5        2.64 ±  4%  perf-profile.children.cycles-pp.nfs_write_begin
>        3.37 ±  4%      -0.5        2.91 ±  4%  perf-profile.children.cycles-pp.nfs_write_end
>        2.54 ±  4%      -0.5        2.08 ±  7%  perf-profile.children.cycles-pp.clear_page_erms
>        2.92 ±  5%      -0.4        2.48 ±  3%  perf-profile.children.cycles-pp._copy_to_iter
>        2.60 ±  4%      -0.4        2.18 ±  5%  perf-profile.children.cycles-pp.nfs_updatepage
>        2.71 ±  4%      -0.4        2.29 ±  6%  perf-profile.children.cycles-pp.add_to_page_cache_lru
>        0.75 ±  3%      -0.4        0.37 ±  6%  perf-profile.children.cycles-pp.release_sock
>        2.51 ±  4%      -0.4        2.15 ±  7%  perf-profile.children.cycles-pp.iomap_write_begin
>        2.02 ± 10%      -0.3        1.67 ±  3%  perf-profile.children.cycles-pp.nfs_writepages_callback
>        2.23 ±  2%      -0.3        1.89 ±  4%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
>        0.82 ±  7%      -0.3        0.47 ±  7%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
>        1.96 ± 11%      -0.3        1.63 ±  3%  perf-profile.children.cycles-pp.nfs_do_writepage
>        1.55 ±  2%      -0.3        1.22 ±  5%  perf-profile.children.cycles-pp.iomap_write_end
>        0.78 ±  7%      -0.3        0.48 ±  6%  perf-profile.children.cycles-pp.svc_send
>        1.78 ±  3%      -0.3        1.48 ±  4%  perf-profile.children.cycles-pp.end_page_writeback
>        1.73 ±  3%      -0.3        1.45 ±  4%  perf-profile.children.cycles-pp.test_clear_page_writeback
>        0.90 ±  5%      -0.3        0.63 ±  8%  perf-profile.children.cycles-pp.xas_load
>        0.35 ± 14%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.simple_copy_to_iter
>        1.78 ±  4%      -0.2        1.54 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
>        0.43 ±  6%      -0.2        0.19 ±  7%  perf-profile.children.cycles-pp.lock_sock_nested
>        1.41 ±  5%      -0.2        1.18 ±  4%  perf-profile.children.cycles-pp.nfs_commit_release
>        1.41 ±  5%      -0.2        1.18 ±  4%  perf-profile.children.cycles-pp.nfs_commit_release_pages
>        1.95 ±  4%      -0.2        1.72 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
>        0.64 ±  8%      -0.2        0.41 ±  4%  perf-profile.children.cycles-pp.svc_tcp_sendto
>        0.63 ±  8%      -0.2        0.41 ±  5%  perf-profile.children.cycles-pp.svc_sendto
>        0.62 ±  8%      -0.2        0.41 ±  5%  perf-profile.children.cycles-pp.svc_send_common
>        0.62 ±  8%      -0.2        0.41 ±  5%  perf-profile.children.cycles-pp.kernel_sendpage
>        1.65 ±  5%      -0.2        1.44 ±  7%  perf-profile.children.cycles-pp.autoremove_wake_function
>        1.34 ±  3%      -0.2        1.14 ±  3%  perf-profile.children.cycles-pp.wait_on_page_bit_common
>        0.98 ±  4%      -0.2        0.79 ±  2%  perf-profile.children.cycles-pp.poll_idle
>        0.26 ±  8%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_bh
>        1.59 ±  5%      -0.2        1.42 ±  5%  perf-profile.children.cycles-pp.schedule
>        0.79 ±  5%      -0.2        0.62 ±  4%  perf-profile.children.cycles-pp.tcp_v6_do_rcv
>        0.64 ±  5%      -0.2        0.47 ±  8%  perf-profile.children.cycles-pp.tcp_v6_rcv
>        0.34 ± 12%      -0.2        0.18 ± 20%  perf-profile.children.cycles-pp.xas_start
>        0.24 ± 26%      -0.2        0.08 ± 40%  perf-profile.children.cycles-pp.osq_lock
>        0.76 ±  5%      -0.2        0.61 ±  5%  perf-profile.children.cycles-pp.tcp_rcv_established
>        0.49 ± 26%      -0.2        0.34 ± 14%  perf-profile.children.cycles-pp.nfs_request_add_commit_list
>        0.66 ±  5%      -0.1        0.52 ±  8%  perf-profile.children.cycles-pp.ip6_input
>        0.66 ±  4%      -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.ip6_input_finish
>        0.65 ±  4%      -0.1        0.51 ±  9%  perf-profile.children.cycles-pp.ip6_protocol_deliver_rcu
>        0.79 ±  8%      -0.1        0.64 ±  7%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
>        0.83 ±  6%      -0.1        0.69 ±  8%  perf-profile.children.cycles-pp.__nfs_commit_inode
>        0.42 ±  4%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.xs_stream_data_receive_workfn
>        0.42 ±  4%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.xs_stream_data_receive
>        0.70 ±  4%      -0.1        0.56 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>        0.71 ±  4%      -0.1        0.58 ±  8%  perf-profile.children.cycles-pp.ipv6_rcv
>        0.86 ±  6%      -0.1        0.73 ±  6%  perf-profile.children.cycles-pp.__local_bh_enable_ip
>        0.78 ±  5%      -0.1        0.65 ±  8%  perf-profile.children.cycles-pp.process_backlog
>        0.45 ± 14%      -0.1        0.32 ± 14%  perf-profile.children.cycles-pp.__mutex_lock
>        1.06 ±  4%      -0.1        0.93 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        0.86 ±  6%      -0.1        0.73 ±  9%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
>        0.75 ±  5%      -0.1        0.63 ±  8%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
>        0.61 ±  8%      -0.1        0.49 ±  9%  perf-profile.children.cycles-pp.iomap_set_page_dirty
>        0.94 ±  5%      -0.1        0.81 ±  8%  perf-profile.children.cycles-pp.__lru_cache_add
>        0.82 ±  6%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
>        0.80 ±  6%      -0.1        0.68 ±  7%  perf-profile.children.cycles-pp.net_rx_action
>        0.94 ±  2%      -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.io_schedule
>        0.81 ±  7%      -0.1        0.70 ±  7%  perf-profile.children.cycles-pp.do_softirq_own_stack
>        0.69            -0.1        0.58 ±  5%  perf-profile.children.cycles-pp.nfs_create_request
>        0.62 ±  4%      -0.1        0.51 ±  5%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
>        0.32 ±  4%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp.xs_sock_recvmsg
>        0.49 ± 12%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
>        0.82 ±  6%      -0.1        0.72 ±  7%  perf-profile.children.cycles-pp.do_softirq
>        0.32 ± 10%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.xfs_map_blocks
>        0.40 ± 13%      -0.1        0.30 ± 12%  perf-profile.children.cycles-pp.mutex_spin_on_owner
>        0.47 ±  2%      -0.1        0.38 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
>        0.26 ±  4%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.__wake_up_common_lock
>        0.52 ±  6%      -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.account_page_dirtied
>        0.22 ± 16%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.__check_object_size
>        0.50 ±  8%      -0.1        0.42 ±  7%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
>        0.41 ±  3%      -0.1        0.33 ± 14%  perf-profile.children.cycles-pp.__set_page_dirty
>        0.31 ± 11%      -0.1        0.24 ± 11%  perf-profile.children.cycles-pp.nfs_io_completion_release
>        0.41 ±  8%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.nfs_inode_remove_request
>        0.25 ±  9%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.xfs_iomap_write_allocate
>        0.33 ±  8%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.___might_sleep
>        0.25 ±  5%      -0.1        0.18 ± 15%  perf-profile.children.cycles-pp.__xa_set_mark
>        0.31 ±  9%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.nfs_scan_commit_list
>        0.25 ±  5%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
>        0.45 ±  6%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.nfs_lock_and_join_requests
>        0.50 ±  4%      -0.1        0.45 ±  5%  perf-profile.children.cycles-pp.nfs_page_group_destroy
>        0.19 ± 11%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.xfs_bmap_btalloc
>        0.21 ±  2%      -0.1        0.15 ± 14%  perf-profile.children.cycles-pp.__lock_sock
>        0.17 ±  8%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent
>        0.18 ±  9%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.xfs_alloc_vextent
>        0.20 ± 12%      -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.xfs_bmapi_write
>        0.30 ±  9%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
>        0.16 ±  8%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_near
>        0.16 ± 15%      -0.0        0.12 ± 17%  perf-profile.children.cycles-pp.__generic_write_end
>        0.48 ±  2%      -0.0        0.44 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
>        0.31 ±  2%      -0.0        0.27 ± 10%  perf-profile.children.cycles-pp.release_pages
>        0.20 ±  4%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.nfs_initiate_commit
>        0.17 ± 10%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__might_sleep
>        0.29 ±  6%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.dec_zone_page_state
>        0.23 ±  7%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.__pagevec_release
>        0.19 ±  9%      -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.nfs_get_lock_context
>        0.17 ± 13%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.check_preempt_curr
>        0.09 ± 17%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.memset_erms
>        0.14 ±  8%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.nfs_request_remove_commit_list
>        0.07 ± 10%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.xfs_defer_finish_noroll
>        0.15 ±  5%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__nfs_find_lock_context
>        0.19 ±  4%      -0.0        0.16 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
>        0.17 ±  8%      -0.0        0.15 ± 10%  perf-profile.children.cycles-pp.vfs_create
>        0.16 ±  2%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__fprop_inc_percpu_max
>        0.16 ±  8%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.xfs_create
>        0.10 ±  4%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.xfs_file_aio_write_checks
>        0.11 ± 10%      -0.0        0.08 ± 15%  perf-profile.children.cycles-pp.nfs_pageio_doio
>        0.11 ± 10%      -0.0        0.08 ± 15%  perf-profile.children.cycles-pp.nfs_generic_pg_pgios
>        0.19 ±  4%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
>        0.15 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__xfs_trans_commit
>        0.08 ± 15%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
>        0.06 ± 15%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.selinux_ip_postroute
>        0.08 ± 16%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.nf_hook_slow
>        0.04 ± 60%      +0.0        0.08 ± 19%  perf-profile.children.cycles-pp.__inc_numa_state
>        0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.get_task_policy
>        0.41 ±  6%      +0.0        0.46        perf-profile.children.cycles-pp.__release_sock
>        0.14 ± 11%      +0.1        0.19 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
>        0.09 ± 17%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.svc_xprt_do_enqueue
>        0.14 ± 10%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
>        0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.free_unref_page_commit
>        0.10 ± 11%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.iov_iter_advance
>        0.17 ±  9%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.tcp_ack
>        0.11 ± 21%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.schedule_timeout
>        0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.free_one_page
>        0.23 ± 12%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__kfree_skb
>        0.10 ±  4%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.xas_create
>        0.12 ± 17%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.skb_release_data
>        0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__free_pages_ok
>        0.00            +0.2        0.21 ±  9%  perf-profile.children.cycles-pp.skb_page_frag_refill
>        0.00            +0.2        0.22 ±  9%  perf-profile.children.cycles-pp.sk_page_frag_refill
>        0.00            +0.2        0.25 ±  5%  perf-profile.children.cycles-pp.__sk_flush_backlog
>        0.03 ±100%      +0.4        0.39 ±  7%  perf-profile.children.cycles-pp.free_pcppages_bulk
>        0.07 ± 29%      +0.5        0.54 ±  6%  perf-profile.children.cycles-pp.free_unref_page
>        4.86 ±  6%      +0.5        5.40 ±  2%  perf-profile.children.cycles-pp.svc_recv
>        9.98 ±  4%      +2.5       12.44 ±  4%  perf-profile.children.cycles-pp.worker_thread
>        9.61 ±  4%      +2.5       12.15 ±  4%  perf-profile.children.cycles-pp.process_one_work
>       47.02 ±  3%      +2.7       49.68 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64
>       47.02 ±  3%      +2.7       49.68 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
>       47.02 ±  3%      +2.7       49.69 ±  4%  perf-profile.children.cycles-pp.do_idle
>        6.12 ±  2%      +2.8        8.88 ±  3%  perf-profile.children.cycles-pp.memcpy_erms
>        0.00            +3.6        3.58 ±  3%  perf-profile.children.cycles-pp.memcpy_from_page
>        0.00            +3.7        3.68 ±  3%  perf-profile.children.cycles-pp._copy_from_iter_full
>        2.43 ±  6%      +3.8        6.20 ±  3%  perf-profile.children.cycles-pp.__rpc_execute
>        2.29 ±  6%      +3.8        6.05 ±  3%  perf-profile.children.cycles-pp.rpc_async_schedule
>        1.93 ±  3%      +3.8        5.71 ±  4%  perf-profile.children.cycles-pp.call_transmit
>        1.92 ±  4%      +3.8        5.71 ±  4%  perf-profile.children.cycles-pp.xprt_transmit
>        1.87 ±  4%      +3.8        5.67 ±  4%  perf-profile.children.cycles-pp.xs_tcp_send_request
>        1.86 ±  4%      +3.8        5.67 ±  4%  perf-profile.children.cycles-pp.xs_sendpages
>        0.21 ±  7%      +5.3        5.54 ±  4%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
>        0.24 ±  8%      +5.4        5.63 ±  4%  perf-profile.children.cycles-pp.tcp_sendmsg
>        0.25 ±  9%      +5.4        5.64 ±  4%  perf-profile.children.cycles-pp.sock_sendmsg
>        1.17 ±  7%      -0.6        0.61 ± 21%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>        2.50 ±  4%      -0.5        2.05 ±  7%  perf-profile.self.cycles-pp.clear_page_erms
>        2.46 ±  4%      -0.4        2.06 ±  5%  perf-profile.self.cycles-pp.brd_do_bvec
>        0.22 ± 10%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.__skb_datagram_iter
>        1.53 ±  6%      -0.2        1.34 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
>        0.91 ±  4%      -0.2        0.74 ±  2%  perf-profile.self.cycles-pp.poll_idle
>        0.24 ± 25%      -0.2        0.08 ± 40%  perf-profile.self.cycles-pp.osq_lock
>        0.74 ± 14%      -0.2        0.59 ± 10%  perf-profile.self.cycles-pp.nfs_do_writepage
>        0.32 ± 13%      -0.1        0.17 ± 18%  perf-profile.self.cycles-pp.xas_start
>        0.97 ±  3%      -0.1        0.84 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        0.57 ±  6%      -0.1        0.45 ±  9%  perf-profile.self.cycles-pp.xas_load
>        0.55 ± 10%      -0.1        0.43 ±  7%  perf-profile.self.cycles-pp.__schedule
>        0.14 ± 12%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp._raw_spin_lock_bh
>        0.53 ±  8%      -0.1        0.43 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>        0.40 ± 13%      -0.1        0.30 ± 12%  perf-profile.self.cycles-pp.mutex_spin_on_owner
>        0.33 ±  8%      -0.1        0.24 ± 12%  perf-profile.self.cycles-pp.nfs_end_page_writeback
>        0.74 ±  6%      -0.1        0.65 ±  8%  perf-profile.self.cycles-pp.nfs_updatepage
>        0.40 ±  8%      -0.1        0.31 ± 11%  perf-profile.self.cycles-pp.__test_set_page_writeback
>        0.50 ±  8%      -0.1        0.41 ±  7%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
>        0.56 ±  5%      -0.1        0.48 ±  8%  perf-profile.self.cycles-pp.try_to_wake_up
>        0.38 ±  8%      -0.1        0.30 ±  5%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>        0.28 ±  9%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.iomap_write_end
>        0.45 ±  7%      -0.1        0.38 ±  6%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
>        0.15 ± 14%      -0.1        0.08 ± 27%  perf-profile.self.cycles-pp.add_to_page_cache_lru
>        0.43 ±  6%      -0.1        0.36        perf-profile.self.cycles-pp.clear_page_dirty_for_io
>        0.51 ±  8%      -0.1        0.45 ±  7%  perf-profile.self.cycles-pp.test_clear_page_writeback
>        0.20 ±  9%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.xas_store
>        0.31 ±  8%      -0.1        0.25 ±  4%  perf-profile.self.cycles-pp.___might_sleep
>        0.15 ± 20%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.__check_object_size
>        0.22 ±  6%      -0.1        0.17 ± 10%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
>        0.08 ± 11%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>        0.28 ±  4%      -0.0        0.24 ± 10%  perf-profile.self.cycles-pp.release_pages
>        0.27 ±  8%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.dec_zone_page_state
>        0.19 ±  6%      -0.0        0.15 ± 12%  perf-profile.self.cycles-pp.kmem_cache_alloc
>        0.15 ± 10%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.__might_sleep
>        0.25 ± 10%      -0.0        0.21 ±  6%  perf-profile.self.cycles-pp.wait_on_page_bit_common
>        0.07 ± 12%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.___slab_alloc
>        0.23 ±  7%      -0.0        0.20 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>        0.18 ±  5%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.select_task_rq_fair
>        0.14 ±  5%      -0.0        0.11 ± 17%  perf-profile.self.cycles-pp.alloc_pages_current
>        0.09 ± 16%      -0.0        0.06 ± 20%  perf-profile.self.cycles-pp.memset_erms
>        0.10 ±  8%      -0.0        0.07        perf-profile.self.cycles-pp._cond_resched
>        0.15 ±  4%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__nfs_find_lock_context
>        0.11 ± 13%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.nfs_request_add_commit_list_locked
>        0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.nfs_request_remove_commit_list
>        0.08 ± 10%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
>        0.08 ± 10%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.nfs_request_add_commit_list
>        0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
>        0.08 ± 13%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
>        0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.run_timer_softirq
>        0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.get_task_policy
>        0.03 ±100%      +0.0        0.07 ± 17%  perf-profile.self.cycles-pp.__inc_numa_state
>        0.03 ±102%      +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.svc_recv
>        0.11 ± 13%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp.__list_add_valid
>        0.09 ± 14%      +0.1        0.16 ±  9%  perf-profile.self.cycles-pp.iov_iter_advance
>        0.06 ± 13%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.xas_create
>        0.00            +0.1        0.15 ± 14%  perf-profile.self.cycles-pp.tcp_sendmsg_locked
>        0.00            +0.2        0.20 ± 11%  perf-profile.self.cycles-pp.free_pcppages_bulk
>        0.04 ± 60%      +0.2        0.28 ±  7%  perf-profile.self.cycles-pp.svc_tcp_recvfrom
>        1.25            +0.3        1.52 ±  5%  perf-profile.self.cycles-pp.get_page_from_freelist
>        6.04 ±  2%      +2.7        8.74 ±  3%  perf-profile.self.cycles-pp.memcpy_erms
> 
> 
>                                                                                  
>                        fsmark.time.percent_of_cpu_this_job_got
>                                                                                  
>    320 +-+-------------------------------------------------------------------+
>        |                                                                     |
>    300 +-++.                                                          +      |
>        |.   +..    .+.     +..  +..                              +. .. +  .+.|
>    280 +-+     +.+.   +.. :    +    .+..+.  .+.  .+.  .+.+..   ..  +    +.   |
>        |                  :   +    +      +.   +.   +.       .+              |
>    260 +-+               +                                  +                |
>        |                                                                     |
>    240 +-+                                                                   |
>        |                                                                     |
>    220 +-+                                                                   |
>        |       O                                         O  O O  O O  O      |
>    200 O-+       O  O      O       O           O  O O  O                     |
>        |  O O         O  O    O O    O  O O  O                               |
>    180 +-+-------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                              fsmark.time.elapsed_time
>                                                                                  
>    32 +-+O-------------------------------------------------------------------+
>       O    O    O       O O  O O  O O  O  O O                                |
>    31 +-+     O    O O                         O O  O O    O  O O  O O       |
>    30 +-+                                                O                   |
>       |                                                                      |
>    29 +-+                                                                    |
>    28 +-+                                                                    |
>       |                                                                      |
>    27 +-+                                                                    |
>    26 +-+                                                    .+              |
>       |                 +         +                 +.+.. .+.  +  .+.  .+.   |
>    25 +-+             .. +  .+   + :   +..+.+..+. ..     +      +.   +.   +..|
>    24 +-+    .+.+..+.+    +.  + +  : ..          +                           |
>       |  +.+.                  +    +                                        |
>    23 +-+--------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                            fsmark.time.elapsed_time.max
>                                                                                  
>    32 +-+O-------------------------------------------------------------------+
>       O    O    O       O O  O O  O O  O  O O                                |
>    31 +-+     O    O O                         O O  O O    O  O O  O O       |
>    30 +-+                                                O                   |
>       |                                                                      |
>    29 +-+                                                                    |
>    28 +-+                                                                    |
>       |                                                                      |
>    27 +-+                                                                    |
>    26 +-+                                                    .+              |
>       |                 +         +                 +.+.. .+.  +  .+.  .+.   |
>    25 +-+             .. +  .+   + :   +..+.+..+. ..     +      +.   +.   +..|
>    24 +-+    .+.+..+.+    +.  + +  : ..          +                           |
>       |  +.+.                  +    +                                        |
>    23 +-+--------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                 fsmark.files_per_sec
>                                                                                  
>    520 +-+-------------------------------------------------------------------+
>        |..     +.+.  +     +.. .+.. :            .+.    .+..         .+.+..+ |
>    500 +-+            +.. +   +     :   +.+..+.+.   +..+        .+.+.        |
>    480 +-+               +         +                        +.+.             |
>        |                                                                     |
>    460 +-+                                                                   |
>        |                                                                     |
>    440 +-+                                                                   |
>        |                                                                     |
>    420 +-+                                                                   |
>    400 +-+                                               O                   |
>        |                                       O  O O  O    O O  O O  O      |
>    380 O-+     O O  O O  O O            O O  O                               |
>        |  O O                 O O  O O                                       |
>    360 +-+-------------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 
> 
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
> 

Do you have time to take a look at this regression?

-- 
Zhengjun Xing
