Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D70C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C966206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfIRAR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:17:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:42635 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfIRARz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:17:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 17:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,518,1559545200"; 
   d="yaml'?scan'208";a="387738814"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2019 17:17:45 -0700
Date:   Wed, 18 Sep 2019 08:17:36 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: c25aa432ff:  aim9.dir_rtns_1.ops_per_sec -24.5% regression
Message-ID: <20190918001736.GK15734@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EWehNWXqjd1oOl26"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EWehNWXqjd1oOl26
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -24.5% regression of aim9.dir_rtns_1.ops_per_sec due to commit:


commit: c25aa432ff56e179bf5414edff3aa430d2b260c0 ("Fix the locking in dcache_readdir() and friends")
https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master

in testcase: aim9
on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
with following parameters:

	testtime: 300s
	test: dir_rtns_1
	cpufreq_governor: performance
	ucode: 0x21

test-description: Suite IX is the "AIM Independent Resource Benchmark:" the famous synthetic benchmark.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite9/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min -50.3% regression                            |
| test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory |
| test parameters  | cpufreq_governor=performance                                           |
|                  | iterations=4                                                           |
|                  | nr_task=1600%                                                          |
|                  | test=new_fserver                                                       |
|                  | ucode=0x14                                                             |
+------------------+------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min -59.8% regression                            |
| test machine     | 40 threads Skylake-SP with 64G memory                                  |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_task=100%                                                           |
|                  | runtime=300s                                                           |
|                  | test=five_sec                                                          |
+------------------+------------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime/ucode:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2019-05-14.cgz/lkp-ivb-d03/dir_rtns_1/aim9/300s/0x21

commit: 
  v5.3-rc8
  c25aa432ff ("Fix the locking in dcache_readdir() and friends")

        v5.3-rc8 c25aa432ff56e179bf5414edff3 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:10         -10%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
  10737284           -24.5%    8106889        aim9.dir_rtns_1.ops_per_sec
    237.48 ±  3%      +6.0%     251.63        aim9.time.system_time
     62.52 ± 12%     -22.6%      48.37 ±  3%  aim9.time.user_time
    236.00 ± 20%     +34.0%     316.25 ± 13%  interrupts.TLB:TLB_shootdowns
    995.80            -2.1%     974.50        proc-vmstat.nr_page_table_pages
      9.01 ±  8%      +3.9%       9.36        turbostat.CorWatt
      1.89 ±  9%      -0.4        1.45 ±  4%  perf-stat.overall.branch-miss-rate%
      0.07 ±  7%      -0.0        0.05 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      1083 ±  2%     +28.9%       1396        slabinfo.kmalloc-96.active_objs
      1083 ±  2%     +28.9%       1396        slabinfo.kmalloc-96.num_objs
    350.54 ± 12%    -100.0%       0.00        uptime.boot
      1032 ± 13%    -100.0%       0.00        uptime.idle
     33.73 ±  3%     -14.5%      28.85        boot-time.boot
     16.42           -27.9%      11.83        boot-time.dhcp
     92.75 ±  4%     -15.0%      78.83 ±  2%  boot-time.idle
     42588 ± 20%     -55.8%      18820 ± 19%  sched_debug.cfs_rq:/.min_vruntime.min
    223305 ± 35%     -59.0%      91580 ± 62%  sched_debug.cpu.nr_switches.min
    209863 ± 38%     -60.6%      82590 ± 72%  sched_debug.cpu.sched_count.min
    104206 ± 38%     -60.8%      40872 ± 72%  sched_debug.cpu.sched_goidle.min
    108070 ± 36%     -55.4%      48248 ± 56%  sched_debug.cpu.ttwu_count.min
      8864 ±164%     -90.6%     829.50 ± 18%  softirqs.CPU1.NET_RX
     53368 ±  9%     -17.5%      44030 ±  7%  softirqs.CPU1.RCU
     57265 ±  8%     -24.0%      43541 ±  6%  softirqs.CPU2.RCU
      8867 ±164%     -90.6%     832.25 ± 18%  softirqs.NET_RX
    232862 ±  7%     -15.8%     196000        softirqs.RCU


                                                                                
                              aim9.dir_rtns_1.ops_per_sec                       
                                                                                
  1.15e+07 +-+--------------------------------------------------------------+   
           |                                                                |   
   1.1e+07 +-+.++.+.+.+. +.                                                 |   
  1.05e+07 +-+          +  +.+.+.++.+.+.+.+.++.+.+.+.++.+.+.+.++.+.+.+.++.+.|   
           |                                                                |   
     1e+07 +-+                                                              |   
           |                                                                |   
   9.5e+06 +-+                                                              |   
           |                                                                |   
     9e+06 +-+                                                              |   
   8.5e+06 +-+                                                              |   
           |        O O                                                     |   
     8e+06 O-O OO O     OO O O   OO O O O O OO O                            |   
           |                   O                                            |   
   7.5e+06 +-+--------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-hsw-4ex1: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/4/x86_64-rhel-7.6/1600%/debian-x86_64-2019-05-14.cgz/lkp-hsw-4ex1/new_fserver/reaim/0x14

commit: 
  v5.3-rc8
  c25aa432ff ("Fix the locking in dcache_readdir() and friends")

        v5.3-rc8 c25aa432ff56e179bf5414edff3 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :5           80%           4:4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
           :5           80%           4:4     dmesg.WARNING:stack_recursion
           :5            6%           0:4     perf-profile.children.cycles-pp.error_entry
           :5            5%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    974.07 ±  5%    +369.4%       4572        reaim.child_systime
    533.10            +7.9%     575.36        reaim.child_utime
    702350 ±  2%     -50.3%     348823        reaim.jobs_per_min
    304.84 ±  2%     -50.3%     151.40        reaim.jobs_per_min_child
    726474 ±  5%     -51.6%     351343        reaim.max_jobs_per_min
     19.32 ±  2%    +101.0%      38.84        reaim.parent_time
      1.57 ± 20%    +111.6%       3.33 ±  6%  reaim.std_dev_time
     86.26 ±  2%     +90.5%     164.31        reaim.time.elapsed_time
     86.26 ±  2%     +90.5%     164.31        reaim.time.elapsed_time.max
   1103817 ±  2%    +433.3%    5886270        reaim.time.involuntary_context_switches
      6998 ±  5%     +79.1%      12531        reaim.time.percent_of_cpu_this_job_got
      3898 ±  5%    +369.2%      18291        reaim.time.system_time
      2132            +7.9%       2301        reaim.time.user_time
   5665936 ±  5%     -44.9%    3122983 ±  2%  reaim.time.voluntary_context_switches
      6.21 ±200%     +71.7       77.89        mpstat.cpu.all.sys%
     36169           -65.9%      12315 ±119%  numa-numastat.node1.other_node
  60688505 ± 96%     -92.1%    4766886 ± 63%  cpuidle.C1.time
   5004123 ± 24%     -54.8%    2263546 ± 28%  cpuidle.C6.usage
    129468 ± 87%     -80.1%      25813 ± 37%  cpuidle.POLL.usage
     51.80 ±  5%     -73.9%      13.50 ±  6%  vmstat.cpu.id
     31.20 ±  6%    +145.2%      76.50        vmstat.cpu.sy
     15.40 ±  3%     -48.1%       8.00        vmstat.cpu.us
    221.40 ±188%     -98.2%       4.00        vmstat.memory.buff
     69.40 ±  4%   +1756.3%       1288 ±  2%  vmstat.procs.r
    161883 ±  3%     -54.2%      74189        vmstat.system.cs
    284538 ±  2%      +4.6%     297656        vmstat.system.in
      4095 ± 85%     -95.5%     184.00        meminfo.Active(file)
     90710 ±  6%     +54.1%     139798 ±  2%  meminfo.AnonHugePages
    221.40 ±188%     -98.2%       4.00        meminfo.Buffers
     20078           +22.7%      24641        meminfo.Inactive(anon)
      4513 ± 76%     -91.1%     401.75        meminfo.Inactive(file)
     87204 ±  8%     -20.8%      69072        meminfo.KernelStack
     26350           +27.6%      33626 ±  3%  meminfo.Mapped
    194971 ±  6%     -26.1%     144085        meminfo.PageTables
     29002 ±  3%    +130.6%      66867 ±  2%  meminfo.Shmem
     62892 ±  3%     -50.9%      30862 ±  3%  meminfo.max_used_kB
     49945 ± 13%     +32.3%      66056 ± 25%  numa-vmstat.node0.nr_active_anon
      2598           +25.1%       3250 ±  9%  numa-vmstat.node0.nr_mapped
     49945 ± 13%     +32.3%      66058 ± 25%  numa-vmstat.node0.nr_zone_active_anon
      1342 ±  4%     +51.9%       2039 ± 13%  numa-vmstat.node1.nr_mapped
    677.20 ± 30%    +829.4%       6294 ± 72%  numa-vmstat.node1.nr_shmem
      4425 ± 13%     +96.9%       8713 ± 22%  numa-vmstat.node1.nr_slab_reclaimable
     17546 ± 14%     -51.9%       8446 ±  2%  numa-vmstat.node2.nr_kernel_stack
      1386 ±  6%     +19.6%       1659        numa-vmstat.node2.nr_mapped
      9779 ± 17%     -56.7%       4238        numa-vmstat.node2.nr_page_table_pages
      1397 ±  6%     +23.0%       1718 ±  3%  numa-vmstat.node3.nr_mapped
    200422 ± 13%     +31.6%     263797 ± 26%  numa-meminfo.node0.Active
    199769 ± 13%     +32.0%     263705 ± 26%  numa-meminfo.node0.Active(anon)
     10405           +19.5%      12438 ±  6%  numa-meminfo.node0.Mapped
     17709 ± 13%     +96.6%      34815 ± 22%  numa-meminfo.node1.KReclaimable
      5293           +35.6%       7177 ±  5%  numa-meminfo.node1.Mapped
     17709 ± 13%     +96.6%      34815 ± 22%  numa-meminfo.node1.SReclaimable
      2719 ± 28%    +827.3%      25218 ± 72%  numa-meminfo.node1.Shmem
     17339 ± 14%     -51.9%       8339        numa-meminfo.node2.KernelStack
      5326           +22.3%       6515 ±  2%  numa-meminfo.node2.Mapped
    935903 ±  6%     -15.4%     792162 ±  4%  numa-meminfo.node2.MemUsed
     37917 ± 17%     -56.6%      16472 ±  2%  numa-meminfo.node2.PageTables
      5359 ±  2%     +23.7%       6629        numa-meminfo.node3.Mapped
      1430 ±  5%     +75.8%       2514        turbostat.Avg_MHz
     49.72 ±  5%     +37.3       87.03        turbostat.Busy%
      0.48 ± 97%      -0.5        0.02 ± 74%  turbostat.C1%
      1.83 ± 72%      -1.6        0.22 ± 95%  turbostat.C1E%
   4978906 ± 24%     -55.3%    2225217 ± 28%  turbostat.C6
     24.84 ± 41%     -18.6        6.23 ± 44%  turbostat.C6%
     35.44 ± 10%     -78.7%       7.54 ± 13%  turbostat.CPU%c1
  25377912 ±  3%     +95.3%   49560495        turbostat.IRQ
      6.03 ± 18%     -50.7%       2.97 ± 13%  turbostat.Pkg%pc2
     52.60            +8.8%      57.25        turbostat.PkgTmp
    481.55            +8.9%     524.46        turbostat.PkgWatt
     71.44           -10.3%      64.11        turbostat.RAMWatt
      1014 ± 86%     -95.5%      46.00        proc-vmstat.nr_active_file
    266745            +2.6%     273756        proc-vmstat.nr_file_pages
      5019           +23.6%       6204 ±  2%  proc-vmstat.nr_inactive_anon
     87480 ±  7%     -21.2%      68892        proc-vmstat.nr_kernel_stack
      6705           +28.5%       8619 ±  3%  proc-vmstat.nr_mapped
     48724 ±  4%     -26.8%      35668        proc-vmstat.nr_page_table_pages
      7251 ±  4%    +131.3%      16774 ±  2%  proc-vmstat.nr_shmem
     26548 ±  2%      +5.5%      28002        proc-vmstat.nr_slab_reclaimable
      1014 ± 86%     -95.5%      46.00        proc-vmstat.nr_zone_active_file
      5019           +23.6%       6204 ±  2%  proc-vmstat.nr_zone_inactive_anon
      9467 ± 25%   +4921.9%     475427 ±  2%  proc-vmstat.numa_hint_faults
      5952 ± 50%   +1081.9%      70353 ± 11%  proc-vmstat.numa_hint_faults_local
      4022 ± 64%   +9981.2%     405544        proc-vmstat.numa_pages_migrated
     30981 ± 35%   +1806.8%     590759 ±  3%  proc-vmstat.numa_pte_updates
      8469 ± 13%    +269.7%      31316 ±  2%  proc-vmstat.pgactivate
      4022 ± 64%   +9981.2%     405544        proc-vmstat.pgmigrate_success
     13901 ±106%    +543.8%      89506 ± 23%  syscalls.sys_close.max
    371.60           +10.3%     409.75 ±  2%  syscalls.sys_close.min
      5908 ±140%    -100.0%       0.00        syscalls.sys_fcntl.max
    730.40 ± 43%    -100.0%       0.00        syscalls.sys_fcntl.med
    445.60 ±  9%    -100.0%       0.00        syscalls.sys_fcntl.min
   9998493 ± 58%    -1e+07        0.00        syscalls.sys_fcntl.noise.2%
   7913309 ± 72%  -7.9e+06        0.00        syscalls.sys_fcntl.noise.25%
   9850263 ± 58%  -9.9e+06        0.00        syscalls.sys_fcntl.noise.5%
   5762893 ± 65%  -5.8e+06        0.00        syscalls.sys_fcntl.noise.50%
   3613837 ± 78%  -3.6e+06        0.00        syscalls.sys_fcntl.noise.75%
     74776 ± 45%    -100.0%       0.00        syscalls.sys_open.max
     12598 ± 12%    -100.0%       0.00        syscalls.sys_open.med
      3075 ±  3%    -100.0%       0.00        syscalls.sys_open.min
 1.841e+08 ± 46%  -1.8e+08        0.00        syscalls.sys_open.noise.100%
  3.21e+08 ± 31%  -3.2e+08        0.00        syscalls.sys_open.noise.2%
 2.819e+08 ± 37%  -2.8e+08        0.00        syscalls.sys_open.noise.25%
 3.196e+08 ± 32%  -3.2e+08        0.00        syscalls.sys_open.noise.5%
 2.229e+08 ± 40%  -2.2e+08        0.00        syscalls.sys_open.noise.50%
 1.942e+08 ± 45%  -1.9e+08        0.00        syscalls.sys_open.noise.75%
     49712 ± 12%     +19.0%      59178        slabinfo.cred_jar.active_objs
      1185 ± 12%     +19.2%       1413        slabinfo.cred_jar.active_slabs
     49798 ± 12%     +19.2%      59370        slabinfo.cred_jar.num_objs
      1185 ± 12%     +19.2%       1413        slabinfo.cred_jar.num_slabs
    144167           +19.7%     172618        slabinfo.dentry.active_objs
      3441           +20.3%       4139        slabinfo.dentry.active_slabs
    144551           +20.3%     173873        slabinfo.dentry.num_objs
      3441           +20.3%       4139        slabinfo.dentry.num_slabs
     12550           +23.3%      15477        slabinfo.files_cache.active_objs
     12550           +23.3%      15477        slabinfo.files_cache.num_objs
     66195 ±  5%     +12.9%      74764        slabinfo.kmalloc-32.active_objs
     66419 ±  4%     +12.6%      74796        slabinfo.kmalloc-32.num_objs
     18996 ±  6%     +17.6%      22336 ±  3%  slabinfo.kmalloc-512.active_objs
     19054 ±  6%     +17.5%      22397 ±  3%  slabinfo.kmalloc-512.num_objs
      2443 ± 56%     -62.5%     916.75 ±  7%  slabinfo.mnt_cache.active_objs
      2443 ± 56%     -62.5%     916.75 ±  7%  slabinfo.mnt_cache.num_objs
     16201           +43.1%      23192        slabinfo.pid.active_objs
    252.80           +43.1%     361.75        slabinfo.pid.active_slabs
     16201           +43.1%      23192        slabinfo.pid.num_objs
    252.80           +43.1%     361.75        slabinfo.pid.num_slabs
     10514           -10.8%       9381        slabinfo.skbuff_ext_cache.active_objs
     10514           -10.8%       9381        slabinfo.skbuff_ext_cache.num_objs
     14587           +54.1%      22475        slabinfo.task_delay_info.active_objs
    285.40           +54.3%     440.25        slabinfo.task_delay_info.active_slabs
     14587           +54.1%      22475        slabinfo.task_delay_info.num_objs
    285.40           +54.3%     440.25        slabinfo.task_delay_info.num_slabs
     14167           -22.6%      10967        slabinfo.tw_sock_TCP.active_objs
     14167           -22.6%      10967        slabinfo.tw_sock_TCP.num_objs
     38389 ±  4%     -10.3%      34421        slabinfo.vmap_area.num_objs
     14871 ±  6%    +258.6%      53333        sched_debug.cfs_rq:/.exec_clock.avg
     16004 ±  6%    +241.9%      54724        sched_debug.cfs_rq:/.exec_clock.max
     14470 ±  6%    +257.8%      51779        sched_debug.cfs_rq:/.exec_clock.min
    205.66 ±  7%     +40.1%     288.22 ± 10%  sched_debug.cfs_rq:/.exec_clock.stddev
   2925622 ±  4%    +313.9%   12108233        sched_debug.cfs_rq:/.min_vruntime.avg
   3282312 ±  4%    +332.8%   14204517        sched_debug.cfs_rq:/.min_vruntime.max
   2666158 ±  3%    +268.0%    9810521        sched_debug.cfs_rq:/.min_vruntime.min
    114081 ± 21%    +631.6%     834667 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.24 ± 11%    +111.0%       0.50 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
      0.40 ±  7%     -33.8%       0.27 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
      0.54 ± 24%     +57.0%       0.85 ± 18%  sched_debug.cfs_rq:/.nr_spread_over.avg
      1.56 ± 34%     +73.3%       2.69 ±  6%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      1.10 ± 48%    +181.4%       3.09 ±  8%  sched_debug.cfs_rq:/.runnable_load_avg.avg
     11046 ±1411%  +10937.8%    1219317 ± 75%  sched_debug.cfs_rq:/.spread0.avg
    366674 ± 53%    +801.8%    3306795 ± 21%  sched_debug.cfs_rq:/.spread0.max
    113914 ± 22%    +629.9%     831418 ±  8%  sched_debug.cfs_rq:/.spread0.stddev
    515.65 ±  2%     +34.1%     691.75        sched_debug.cfs_rq:/.util_avg.avg
      1258 ± 11%     +24.0%       1559 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    198.09 ±  9%     +38.0%     273.36 ± 14%  sched_debug.cfs_rq:/.util_avg.stddev
     26.17 ± 15%    +737.1%     219.09 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    621.80 ± 10%     +49.5%     929.83 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
     86.81 ±  7%    +124.7%     195.07 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    151517 ± 17%     +98.9%     301317 ± 10%  sched_debug.cpu.avg_idle.min
    203625           -23.2%     156355 ±  8%  sched_debug.cpu.avg_idle.stddev
     76306 ±  6%     +36.5%     104168        sched_debug.cpu.clock.avg
     76380 ±  6%     +36.6%     104325        sched_debug.cpu.clock.max
     76233 ±  6%     +36.4%     103978        sched_debug.cpu.clock.min
     42.51 ± 37%    +138.6%     101.41 ± 27%  sched_debug.cpu.clock.stddev
     76306 ±  6%     +36.5%     104168        sched_debug.cpu.clock_task.avg
     76380 ±  6%     +36.6%     104325        sched_debug.cpu.clock_task.max
     76233 ±  6%     +36.4%     103978        sched_debug.cpu.clock_task.min
     42.51 ± 37%    +138.6%     101.41 ± 27%  sched_debug.cpu.clock_task.stddev
     17054 ± 20%    +182.6%      48202 ±  8%  sched_debug.cpu.curr->pid.avg
     23542 ± 17%     -31.3%      16180 ± 24%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 19%     +93.0%       0.00 ± 26%  sched_debug.cpu.next_balance.stddev
      0.24 ±  6%   +1978.8%       5.01 ±  7%  sched_debug.cpu.nr_running.avg
      1.70 ± 23%    +689.2%      13.42 ±  9%  sched_debug.cpu.nr_running.max
      0.41 ±  4%    +693.8%       3.27 ±  7%  sched_debug.cpu.nr_running.stddev
     37009 ±  2%     -12.5%      32385        sched_debug.cpu.nr_switches.avg
     34675 ±  2%     -23.8%      26414 ±  4%  sched_debug.cpu.nr_switches.min
      1602 ±  9%     +78.3%       2858 ± 11%  sched_debug.cpu.nr_switches.stddev
    161.70 ± 14%    +181.7%     455.58 ±  3%  sched_debug.cpu.nr_uninterruptible.max
   -134.10          +102.5%    -271.58        sched_debug.cpu.nr_uninterruptible.min
     54.83 ±  4%    +101.6%     110.54 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
     37523 ±  3%     -14.9%      31950        sched_debug.cpu.sched_count.avg
     35820 ±  3%     -27.0%      26151 ±  4%  sched_debug.cpu.sched_count.min
     14142 ±  3%     -80.5%       2760 ± 11%  sched_debug.cpu.sched_goidle.avg
     15920 ±  4%     -71.7%       4497 ±  8%  sched_debug.cpu.sched_goidle.max
     13439 ±  3%     -83.0%       2278 ± 13%  sched_debug.cpu.sched_goidle.min
    380.74 ±  5%     -41.3%     223.32 ±  7%  sched_debug.cpu.sched_goidle.stddev
     19327 ±  4%     -46.5%      10340 ±  3%  sched_debug.cpu.ttwu_count.avg
     21405 ±  5%     -32.3%      14485        sched_debug.cpu.ttwu_count.max
     18496 ±  4%     -61.4%       7140 ±  9%  sched_debug.cpu.ttwu_count.min
    437.98 ±  8%    +208.0%       1349 ± 14%  sched_debug.cpu.ttwu_count.stddev
      3460 ±  4%     +53.9%       5325        sched_debug.cpu.ttwu_local.avg
      3838 ± 11%    +113.3%       8186 ±  2%  sched_debug.cpu.ttwu_local.max
     96.74 ± 20%    +813.8%     884.09 ± 11%  sched_debug.cpu.ttwu_local.stddev
     76232 ±  6%     +36.4%     103977        sched_debug.cpu_clk
     72105 ±  6%     +38.5%      99852        sched_debug.ktime
     80664 ±  6%     +34.2%     108284        sched_debug.sched_clk
      7.81 ±  4%     -48.1%       4.06 ± 10%  perf-stat.i.MPKI
      1.15 ±  6%      -0.6        0.58 ±  7%  perf-stat.i.branch-miss-rate%
 2.236e+08 ±  3%     -49.3%  1.133e+08        perf-stat.i.branch-misses
     10.98 ±  2%      +4.5       15.44        perf-stat.i.cache-miss-rate%
  89688973           -44.8%   49526702 ±  2%  perf-stat.i.cache-misses
 7.707e+08           -55.7%  3.416e+08        perf-stat.i.cache-references
    168615 ±  3%     -55.2%      75476        perf-stat.i.context-switches
      1.69           +82.3%       3.08        perf-stat.i.cpi
 2.099e+11 ±  5%     +73.5%  3.642e+11        perf-stat.i.cpu-cycles
     42151 ±  4%     -59.2%      17214        perf-stat.i.cpu-migrations
      3502 ± 10%    +145.1%       8585 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.21 ± 10%      -0.1        0.11 ±  5%  perf-stat.i.dTLB-load-miss-rate%
  54901094 ± 10%     -53.7%   25404025 ±  5%  perf-stat.i.dTLB-load-misses
 3.465e+10 ±  4%     -18.8%  2.812e+10        perf-stat.i.dTLB-loads
      0.16 ±  3%      -0.0        0.15        perf-stat.i.dTLB-store-miss-rate%
  14591260           -49.9%    7314258        perf-stat.i.dTLB-store-misses
 9.372e+09 ±  2%     -47.5%  4.916e+09        perf-stat.i.dTLB-stores
  21067187 ± 34%     -56.1%    9252522 ±  3%  perf-stat.i.iTLB-load-misses
  18488057 ±  2%     -52.1%    8855174        perf-stat.i.iTLB-loads
 1.462e+11 ±  4%     -17.3%  1.208e+11        perf-stat.i.instructions
      7561 ± 21%     +98.0%      14967 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.68           -46.7%       0.36        perf-stat.i.ipc
   2136093 ±  2%     -47.5%    1121364        perf-stat.i.minor-faults
     85.28            +5.1       90.39        perf-stat.i.node-load-miss-rate%
  56756067 ±  2%     -44.1%   31711944 ±  2%  perf-stat.i.node-load-misses
   9460156 ± 10%     -62.2%    3572069 ±  3%  perf-stat.i.node-loads
     61.99            +9.9       71.89        perf-stat.i.node-store-miss-rate%
  14769993 ±  3%     -31.0%   10190547        perf-stat.i.node-store-misses
   8354399 ±  2%     -53.0%    3927636 ±  2%  perf-stat.i.node-stores
   2135997 ±  2%     -47.5%    1121285        perf-stat.i.page-faults
      5.28 ±  3%     -46.4%       2.83        perf-stat.overall.MPKI
      0.90 ±  2%      -0.5        0.45        perf-stat.overall.branch-miss-rate%
     11.64 ±  2%      +2.9       14.50        perf-stat.overall.cache-miss-rate%
      1.44          +110.0%       3.01        perf-stat.overall.cpi
      2341 ±  5%    +214.1%       7356 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.16 ± 11%      -0.1        0.09 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.16            -0.0        0.15        perf-stat.overall.dTLB-store-miss-rate%
      7543 ± 23%     +73.3%      13070 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.70           -52.4%       0.33        perf-stat.overall.ipc
     85.72            +4.2       89.88        perf-stat.overall.node-load-miss-rate%
     63.86            +8.3       72.18        perf-stat.overall.node-store-miss-rate%
  13536429 ±  2%     +58.4%   21440653        perf-stat.overall.path-length
 2.208e+08 ±  3%     -49.0%  1.126e+08        perf-stat.ps.branch-misses
  88541048           -44.4%   49201919 ±  2%  perf-stat.ps.cache-misses
 7.609e+08           -55.4%  3.394e+08        perf-stat.ps.cache-references
    166451 ±  3%     -55.0%      74981        perf-stat.ps.context-switches
 2.073e+11 ±  5%     +74.5%  3.618e+11        perf-stat.ps.cpu-cycles
     41608 ±  4%     -58.9%      17102        perf-stat.ps.cpu-migrations
  54207242 ± 10%     -53.4%   25241374 ±  5%  perf-stat.ps.dTLB-load-misses
 3.421e+10 ±  4%     -18.3%  2.794e+10        perf-stat.ps.dTLB-loads
  14407262           -49.6%    7267595        perf-stat.ps.dTLB-store-misses
 9.253e+09 ±  2%     -47.2%  4.884e+09        perf-stat.ps.dTLB-stores
  20801760 ± 34%     -55.8%    9193108 ±  3%  perf-stat.ps.iTLB-load-misses
  18254567           -51.8%    8798415        perf-stat.ps.iTLB-loads
 1.443e+11 ±  4%     -16.8%    1.2e+11        perf-stat.ps.instructions
   2108967 ±  2%     -47.2%    1114047        perf-stat.ps.minor-faults
  56028576 ±  2%     -43.8%   31503751 ±  2%  perf-stat.ps.node-load-misses
   9340740 ± 10%     -62.0%    3549428 ±  3%  perf-stat.ps.node-loads
  14580026 ±  3%     -30.6%   10123053        perf-stat.ps.node-store-misses
   8247850 ±  2%     -52.7%    3902264 ±  2%  perf-stat.ps.node-stores
   2108872 ±  2%     -47.2%    1113990        perf-stat.ps.page-faults
 1.248e+13 ±  2%     +58.4%  1.976e+13        perf-stat.total.instructions
     46.59 ± 33%     -46.6        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64
     45.59 ± 30%     -45.6        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     45.59 ± 30%     -45.6        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     45.59 ± 30%     -45.6        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     45.09 ± 29%     -45.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     44.59 ± 28%     -44.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     44.53 ± 30%     -44.5        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     12.61 ± 55%     -12.6        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.61 ± 55%     -12.6        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.48 ± 60%     -12.5        0.00        perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
     12.48 ± 60%     -12.5        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.ksys_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.perf_ioctl.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl.do_syscall_64
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp._perf_ioctl.perf_ioctl.do_vfs_ioctl.ksys_ioctl.__x64_sys_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.perf_event_for_each_child._perf_ioctl.perf_ioctl.do_vfs_ioctl.ksys_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl.do_vfs_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl
      6.88 ± 86%      -6.9        0.00        perf-profile.calltrace.cycles-pp.show_interrupts.seq_read.proc_reg_read.vfs_read.ksys_read
      0.00            +0.6        0.61 ± 18%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_dir_lseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dcache_dir_lseek.ksys_lseek.do_syscall_64
      0.00            +0.7        0.66 ± 18%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.dcache_dir_lseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.73 ± 18%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
      0.00            +0.8        0.76 ± 18%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
      0.00            +0.8        0.77 ± 18%  perf-profile.calltrace.cycles-pp.page_fault
      0.00            +0.8        0.80 ± 12%  perf-profile.calltrace.cycles-pp.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.80 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.0        1.97        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents
      0.00            +2.0        1.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
     31.61 ± 35%     +65.5       97.14        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.61 ± 35%     +65.5       97.15        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00           +89.5       89.45        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00           +89.7       89.72        perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents
      0.00           +90.4       90.35        perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      0.00           +92.6       92.56        perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +92.6       92.58        perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +92.6       92.59        perf-profile.calltrace.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.59 ± 33%     -46.6        0.00        perf-profile.children.cycles-pp.secondary_startup_64
     46.59 ± 33%     -46.6        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     46.59 ± 33%     -46.6        0.00        perf-profile.children.cycles-pp.do_idle
     46.09 ± 31%     -46.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     46.09 ± 31%     -46.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     45.59 ± 30%     -45.6        0.00        perf-profile.children.cycles-pp.start_secondary
     44.53 ± 30%     -44.5        0.00        perf-profile.children.cycles-pp.intel_idle
     16.09 ± 31%     -16.1        0.00        perf-profile.children.cycles-pp.seq_read
     16.09 ± 31%     -16.1        0.01 ±173%  perf-profile.children.cycles-pp.ksys_read
     16.09 ± 31%     -16.0        0.04 ± 59%  perf-profile.children.cycles-pp.vfs_read
     12.48 ± 60%     -12.5        0.00        perf-profile.children.cycles-pp.proc_reg_read
      9.86 ± 73%      -9.9        0.00        perf-profile.children.cycles-pp.event_function_call
      9.86 ± 73%      -9.9        0.00        perf-profile.children.cycles-pp.smp_call_function_single
      8.39 ± 53%      -8.4        0.00        perf-profile.children.cycles-pp.vsnprintf
      8.39 ± 53%      -8.4        0.00        perf-profile.children.cycles-pp.seq_printf
      8.39 ± 53%      -8.4        0.00        perf-profile.children.cycles-pp.seq_vprintf
      8.57 ± 54%      -8.1        0.49 ± 12%  perf-profile.children.cycles-pp.do_group_exit
      8.57 ± 54%      -8.1        0.49 ± 12%  perf-profile.children.cycles-pp.do_exit
      7.93 ± 70%      -7.9        0.00        perf-profile.children.cycles-pp.__x64_sys_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.children.cycles-pp.ksys_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.children.cycles-pp.do_vfs_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.children.cycles-pp.perf_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.children.cycles-pp._perf_ioctl
      7.93 ± 70%      -7.9        0.00        perf-profile.children.cycles-pp.perf_event_for_each_child
      6.88 ± 86%      -6.9        0.00        perf-profile.children.cycles-pp.show_interrupts
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.iterate_supers
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.sock_write_iter
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.ksys_sync
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.sync
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.mmap64
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.alloc_set_pte
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.__vm_munmap
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.page_remove_rmap
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.trailing_symlink
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.syscall_slow_exit_work
      0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.ftrace_syscall_enter
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.unlazy_walk
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.legitimize_path
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.vma_link
      0.00            +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.00            +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.copy_strings
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.do_unlinkat
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.elf_map
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.mprotect_fixup
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.do_open_execat
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.prep_new_page
      0.00            +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.__vma_adjust
      0.00            +0.2        0.16 ± 20%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.2        0.16 ±  6%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.2        0.18 ± 19%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.2        0.19 ± 14%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.2        0.19 ±  6%  perf-profile.children.cycles-pp.filldir
      0.00            +0.2        0.19 ± 32%  perf-profile.children.cycles-pp.anon_vma_clone
      0.00            +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.2        0.21 ± 32%  perf-profile.children.cycles-pp.anon_vma_fork
      0.00            +0.2        0.21 ± 19%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.2        0.21 ± 11%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.2        0.23 ± 11%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.2        0.24 ± 20%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.00            +0.3        0.26        perf-profile.children.cycles-pp.lockref_get
      0.00            +0.3        0.26 ± 21%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.3        0.28 ± 21%  perf-profile.children.cycles-pp.do_anonymous_page
      0.00            +0.3        0.29 ±  2%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.00            +0.3        0.31 ± 15%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.3        0.32 ± 22%  perf-profile.children.cycles-pp.unmap_region
      0.00            +0.3        0.32 ± 24%  perf-profile.children.cycles-pp.unlink_file_vma
      0.00            +0.3        0.33 ± 17%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.3        0.33 ± 20%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.4        0.35 ± 17%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.4        0.40 ± 23%  perf-profile.children.cycles-pp.__x64_sys_brk
      0.00            +0.4        0.43 ± 18%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.4        0.43 ± 19%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.5        0.45 ±  7%  perf-profile.children.cycles-pp.execve
      0.00            +0.5        0.45 ± 18%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.5        0.45 ±  3%  perf-profile.children.cycles-pp.dput
      0.00            +0.5        0.47 ± 22%  perf-profile.children.cycles-pp.__do_munmap
      0.00            +0.5        0.50 ± 22%  perf-profile.children.cycles-pp.dup_mm
      0.00            +0.5        0.52 ± 18%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.6        0.61 ± 19%  perf-profile.children.cycles-pp.osq_lock
      0.00            +0.6        0.61 ± 23%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.6        0.65 ± 12%  perf-profile.children.cycles-pp.flush_old_exec
      0.00            +0.7        0.67        perf-profile.children.cycles-pp.ksys_lseek
      0.00            +0.7        0.67        perf-profile.children.cycles-pp.dcache_dir_lseek
      0.00            +0.7        0.67 ± 22%  perf-profile.children.cycles-pp.__x64_sys_clone
      0.00            +0.7        0.67 ± 22%  perf-profile.children.cycles-pp._do_fork
      0.00            +0.7        0.73 ± 17%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.00            +0.7        0.73 ± 17%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.00            +0.9        0.92 ± 11%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.9        0.92 ± 11%  perf-profile.children.cycles-pp.search_binary_handler
      0.00            +1.2        1.25 ± 10%  perf-profile.children.cycles-pp.__do_execve_file
      0.00            +1.3        1.26 ± 10%  perf-profile.children.cycles-pp.__x64_sys_execve
     44.28 ± 29%     +53.8       98.11        perf-profile.children.cycles-pp.do_syscall_64
     44.28 ± 29%     +53.8       98.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00           +90.4       90.36        perf-profile.children.cycles-pp.scan_positives
      0.00           +92.4       92.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00           +92.6       92.56        perf-profile.children.cycles-pp.dcache_readdir
      0.00           +92.6       92.58        perf-profile.children.cycles-pp.iterate_dir
      0.00           +92.6       92.59        perf-profile.children.cycles-pp.__x64_sys_getdents
      0.00           +92.7       92.67        perf-profile.children.cycles-pp._raw_spin_lock
     44.53 ± 30%     -44.5        0.00        perf-profile.self.cycles-pp.intel_idle
      7.88 ± 63%      -7.9        0.00        perf-profile.self.cycles-pp.smp_call_function_single
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.dput
      0.00            +0.1        0.06 ± 22%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.scan_positives
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.09 ±  8%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.2        0.20 ± 18%  perf-profile.self.cycles-pp.unmap_page_range
      0.00            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.00            +0.2        0.22 ± 17%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.2        0.24        perf-profile.self.cycles-pp.lockref_get
      0.00            +0.3        0.34 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.6        0.61 ± 19%  perf-profile.self.cycles-pp.osq_lock
      0.00           +91.7       91.68        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     32880 ±  6%     +90.5%      62627 ±  4%  softirqs.CPU0.NET_RX
     25398 ±  5%     +92.4%      48874 ±  3%  softirqs.CPU0.RCU
     18925 ±  4%     -27.3%      13759 ±  9%  softirqs.CPU0.SCHED
     35946 ± 12%     +95.2%      70168 ±  4%  softirqs.CPU0.TIMER
     33491 ±  4%     +14.4%      38311 ±  8%  softirqs.CPU1.NET_RX
     25321           +73.8%      44003 ±  7%  softirqs.CPU1.RCU
     13939 ±  6%     -57.0%       5990 ±  2%  softirqs.CPU1.SCHED
     34380 ±  5%     +95.2%      67096        softirqs.CPU1.TIMER
     33820 ±  4%     -13.8%      29157 ±  6%  softirqs.CPU10.NET_RX
     25151 ±  3%     +50.2%      37787 ±  3%  softirqs.CPU10.RCU
     12437           -54.5%       5664 ±  3%  softirqs.CPU10.SCHED
     36098 ± 18%     +81.6%      65571 ±  2%  softirqs.CPU10.TIMER
     24707 ±  3%     +58.3%      39115 ±  7%  softirqs.CPU100.RCU
     12179 ±  2%     -55.4%       5427 ±  2%  softirqs.CPU100.SCHED
     31949 ±  5%    +108.1%      66486 ±  2%  softirqs.CPU100.TIMER
     24759 ±  2%     +63.4%      40457 ±  4%  softirqs.CPU101.RCU
     12018 ±  2%     -54.5%       5463 ±  3%  softirqs.CPU101.SCHED
     31671 ±  5%    +110.3%      66607 ±  3%  softirqs.CPU101.TIMER
     33227 ±  3%      -9.7%      30000 ±  3%  softirqs.CPU102.NET_RX
     24740 ±  2%     +62.2%      40123 ±  2%  softirqs.CPU102.RCU
     12165           -55.7%       5384        softirqs.CPU102.SCHED
     32184 ±  3%    +107.6%      66826 ±  3%  softirqs.CPU102.TIMER
     24620 ±  3%     +68.2%      41407 ±  6%  softirqs.CPU103.RCU
     12218           -55.9%       5390 ±  3%  softirqs.CPU103.SCHED
     31987 ±  3%    +110.9%      67461 ±  2%  softirqs.CPU103.TIMER
     24439 ±  2%     +59.7%      39031 ±  8%  softirqs.CPU104.RCU
     12153           -55.6%       5390 ±  2%  softirqs.CPU104.SCHED
     31702 ±  5%    +108.0%      65931 ±  2%  softirqs.CPU104.TIMER
     24794 ±  3%     +68.1%      41675 ±  2%  softirqs.CPU105.RCU
     12132           -55.7%       5372        softirqs.CPU105.SCHED
     31923 ±  4%    +109.3%      66799 ±  3%  softirqs.CPU105.TIMER
     24945           +67.8%      41857 ±  2%  softirqs.CPU106.RCU
     12351           -57.3%       5276        softirqs.CPU106.SCHED
     31840 ±  6%    +110.9%      67156 ±  2%  softirqs.CPU106.TIMER
     31027 ±  3%     +14.0%      35361 ±  2%  softirqs.CPU107.NET_RX
     24923 ±  3%     +58.0%      39390 ±  4%  softirqs.CPU107.RCU
     12246 ±  3%     -56.9%       5276 ±  2%  softirqs.CPU107.SCHED
     35785 ± 15%     +87.7%      67182 ±  3%  softirqs.CPU107.TIMER
     31808 ±  2%     +10.0%      34986 ±  2%  softirqs.CPU108.NET_RX
     23941 ±  3%     +64.8%      39454 ±  3%  softirqs.CPU108.RCU
     12250           -56.3%       5348 ±  2%  softirqs.CPU108.SCHED
     32171 ±  3%    +106.8%      66539 ±  3%  softirqs.CPU108.TIMER
     23430           +67.4%      39214 ±  2%  softirqs.CPU109.RCU
     12345           -57.6%       5240 ±  2%  softirqs.CPU109.SCHED
     31654 ±  6%    +108.2%      65894 ±  3%  softirqs.CPU109.TIMER
     24957           +63.0%      40670 ±  2%  softirqs.CPU11.RCU
     12238           -55.0%       5504        softirqs.CPU11.SCHED
     32936 ±  5%     +98.6%      65425        softirqs.CPU11.TIMER
     23470           +60.9%      37753 ±  4%  softirqs.CPU110.RCU
     12233           -56.5%       5315 ±  2%  softirqs.CPU110.SCHED
     31574 ±  4%    +106.3%      65149 ±  3%  softirqs.CPU110.TIMER
     23754 ±  3%     +65.0%      39198 ±  2%  softirqs.CPU111.RCU
     12294 ±  2%     -56.7%       5320 ±  4%  softirqs.CPU111.SCHED
     31621 ±  6%    +109.2%      66164 ±  4%  softirqs.CPU111.TIMER
     24501 ±  3%     +63.2%      39984 ±  6%  softirqs.CPU112.RCU
     12300           -56.2%       5390 ±  2%  softirqs.CPU112.SCHED
     31431 ±  7%    +108.7%      65605 ±  2%  softirqs.CPU112.TIMER
     24236 ±  3%     +59.5%      38649 ±  3%  softirqs.CPU113.RCU
     12235           -56.1%       5372 ±  3%  softirqs.CPU113.SCHED
     31477 ±  5%    +110.9%      66393 ±  3%  softirqs.CPU113.TIMER
     23918 ±  2%     +74.1%      41632 ±  5%  softirqs.CPU114.RCU
     12120           -56.9%       5230 ±  3%  softirqs.CPU114.SCHED
     31043 ±  6%    +117.0%      67373 ±  2%  softirqs.CPU114.TIMER
     23870 ±  3%     +67.5%      39994 ±  2%  softirqs.CPU115.RCU
     12152           -56.8%       5244 ±  3%  softirqs.CPU115.SCHED
     31090 ±  5%    +110.4%      65417 ±  3%  softirqs.CPU115.TIMER
     24381 ±  3%     +69.5%      41327 ±  2%  softirqs.CPU116.RCU
     12180           -55.8%       5385 ±  4%  softirqs.CPU116.SCHED
     31161 ±  4%    +110.5%      65583 ±  3%  softirqs.CPU116.TIMER
     24105 ±  3%     +64.3%      39596 ±  2%  softirqs.CPU117.RCU
     12245 ±  2%     -56.5%       5332 ±  3%  softirqs.CPU117.SCHED
     31071 ±  6%    +107.8%      64554 ±  2%  softirqs.CPU117.TIMER
     24243 ±  2%     +65.0%      39998 ±  3%  softirqs.CPU118.RCU
     12196           -56.5%       5306 ±  3%  softirqs.CPU118.SCHED
     31022 ±  6%    +113.2%      66153 ±  8%  softirqs.CPU118.TIMER
     24461 ±  2%     +67.0%      40856 ±  3%  softirqs.CPU119.RCU
     12201           -56.0%       5374 ±  2%  softirqs.CPU119.SCHED
     31038 ±  5%    +109.6%      65051 ±  3%  softirqs.CPU119.TIMER
     25689 ±  3%     +58.8%      40790 ±  3%  softirqs.CPU12.RCU
     12754 ±  4%     -53.8%       5896 ±  7%  softirqs.CPU12.SCHED
     34040 ±  4%     +94.1%      66070 ±  2%  softirqs.CPU12.TIMER
     24199 ±  4%     +59.9%      38705 ±  3%  softirqs.CPU120.RCU
     12161           -56.1%       5334 ±  3%  softirqs.CPU120.SCHED
     31181 ±  6%    +109.9%      65459 ±  2%  softirqs.CPU120.TIMER
     24323 ±  3%     +70.2%      41402 ±  6%  softirqs.CPU121.RCU
     12149 ±  2%     -55.8%       5374        softirqs.CPU121.SCHED
     31274 ±  5%    +110.7%      65899 ±  3%  softirqs.CPU121.TIMER
     24070           +64.9%      39696 ±  5%  softirqs.CPU122.RCU
     12219           -56.6%       5308 ±  2%  softirqs.CPU122.SCHED
     30813 ±  6%    +113.0%      65646 ±  3%  softirqs.CPU122.TIMER
     24443 ±  3%     +66.6%      40733 ±  6%  softirqs.CPU123.RCU
     12216           -56.6%       5305 ±  2%  softirqs.CPU123.SCHED
     31625 ±  3%    +106.6%      65352 ±  2%  softirqs.CPU123.TIMER
     24106 ±  4%     +72.8%      41654 ±  6%  softirqs.CPU124.RCU
     12221           -57.3%       5224 ±  3%  softirqs.CPU124.SCHED
     34283 ± 19%     +90.2%      65209 ±  3%  softirqs.CPU124.TIMER
     31526 ±  4%     +21.9%      38439 ±  6%  softirqs.CPU125.NET_RX
     24921 ±  3%     +74.7%      43545 ±  2%  softirqs.CPU125.RCU
     12064           -57.9%       5076 ±  3%  softirqs.CPU125.SCHED
     36729 ± 28%     +77.9%      65327 ±  3%  softirqs.CPU125.TIMER
     22563 ±  2%     +56.3%      35269 ±  2%  softirqs.CPU126.RCU
     12344           -57.0%       5312 ±  5%  softirqs.CPU126.SCHED
     34649 ± 10%     +96.4%      68050        softirqs.CPU126.TIMER
     22909 ±  5%     +56.9%      35937 ±  4%  softirqs.CPU127.RCU
     12224           -56.0%       5382 ±  4%  softirqs.CPU127.SCHED
     34517 ± 11%     +97.5%      68176 ±  2%  softirqs.CPU127.TIMER
     31807 ±  4%     -13.3%      27562 ±  7%  softirqs.CPU128.NET_RX
     24183 ±  2%     +55.0%      37490 ±  4%  softirqs.CPU128.RCU
     12490 ±  5%     -56.3%       5458 ±  4%  softirqs.CPU128.SCHED
     35137 ± 13%     +93.6%      68014        softirqs.CPU128.TIMER
     24089 ±  3%     +63.7%      39431        softirqs.CPU129.RCU
     12188           -55.3%       5451 ±  4%  softirqs.CPU129.SCHED
     33914 ± 12%    +100.4%      67968 ±  2%  softirqs.CPU129.TIMER
     25273 ±  3%     +56.6%      39572 ±  5%  softirqs.CPU13.RCU
     12637 ±  3%     -55.7%       5603 ±  2%  softirqs.CPU13.SCHED
     33802 ±  5%     +94.3%      65673        softirqs.CPU13.TIMER
     23685 ±  2%     +66.2%      39377 ±  6%  softirqs.CPU130.RCU
     12126           -55.5%       5398 ±  5%  softirqs.CPU130.SCHED
     33510 ± 13%    +100.1%      67046        softirqs.CPU130.TIMER
     23999           +57.7%      37854 ±  7%  softirqs.CPU131.RCU
     12197           -56.7%       5276 ±  5%  softirqs.CPU131.SCHED
     34206 ± 13%     +95.4%      66850 ±  2%  softirqs.CPU131.TIMER
     24042 ±  2%     +63.7%      39357 ±  2%  softirqs.CPU132.RCU
     12218           -55.6%       5430 ±  6%  softirqs.CPU132.SCHED
     34156 ± 13%    +101.3%      68765 ±  5%  softirqs.CPU132.TIMER
     23903           +58.2%      37808        softirqs.CPU133.RCU
     12177 ±  2%     -55.2%       5453 ±  7%  softirqs.CPU133.SCHED
     33658 ± 13%     +99.9%      67289 ±  2%  softirqs.CPU133.TIMER
     32970 ±  8%     -19.6%      26519 ±  3%  softirqs.CPU134.NET_RX
     24205 ±  3%     +46.8%      35535 ±  2%  softirqs.CPU134.RCU
     12268 ±  2%     -56.8%       5299 ±  5%  softirqs.CPU134.SCHED
     34386 ± 12%     +94.0%      66713        softirqs.CPU134.TIMER
     24222 ±  2%     +64.8%      39926 ±  4%  softirqs.CPU135.RCU
     12166           -55.5%       5413 ±  5%  softirqs.CPU135.SCHED
     34115 ± 11%     +96.1%      66896 ±  2%  softirqs.CPU135.TIMER
     24071           +59.7%      38437        softirqs.CPU136.RCU
     12183           -56.0%       5360 ±  5%  softirqs.CPU136.SCHED
     33528 ± 13%     +98.8%      66644        softirqs.CPU136.TIMER
     24074           +63.3%      39305 ±  5%  softirqs.CPU137.RCU
     12294           -56.1%       5398 ±  3%  softirqs.CPU137.SCHED
     34273 ± 11%     +97.2%      67573        softirqs.CPU137.TIMER
     24238           +62.3%      39350 ±  3%  softirqs.CPU138.RCU
     12153           -53.4%       5662 ±  9%  softirqs.CPU138.SCHED
     34121 ± 12%    +100.9%      68558 ±  2%  softirqs.CPU138.TIMER
     32743 ±  4%     -12.7%      28593        softirqs.CPU139.NET_RX
     24195 ±  2%     +55.4%      37590 ±  4%  softirqs.CPU139.RCU
     12303 ±  2%     -56.6%       5345 ±  4%  softirqs.CPU139.SCHED
     34923 ± 12%     +91.1%      66742        softirqs.CPU139.TIMER
     24778           +61.1%      39921 ±  2%  softirqs.CPU14.RCU
     12551 ±  2%     -50.9%       6160 ±  7%  softirqs.CPU14.SCHED
     32848 ±  4%     +99.0%      65358        softirqs.CPU14.TIMER
     24141 ±  4%     +60.1%      38650 ±  2%  softirqs.CPU140.RCU
     12208           -56.1%       5360 ±  4%  softirqs.CPU140.SCHED
     35506 ± 14%     +86.6%      66263 ±  2%  softirqs.CPU140.TIMER
     24172           +62.7%      39317 ±  3%  softirqs.CPU141.RCU
     12195           -56.8%       5273 ±  4%  softirqs.CPU141.SCHED
     34000 ± 12%     +97.6%      67183        softirqs.CPU141.TIMER
     24124 ±  3%     +57.6%      38028 ±  3%  softirqs.CPU142.RCU
     12384 ±  2%     -58.1%       5184 ±  4%  softirqs.CPU142.SCHED
     35100 ± 11%     +90.2%      66765        softirqs.CPU142.TIMER
     32113 ±  4%     +14.5%      36769 ±  7%  softirqs.CPU143.NET_RX
     24365 ±  2%     +70.2%      41480 ±  2%  softirqs.CPU143.RCU
     12316 ±  2%     -58.2%       5142 ±  3%  softirqs.CPU143.SCHED
     34556 ± 16%     +97.0%      68080 ±  2%  softirqs.CPU143.TIMER
     25019           +66.1%      41553 ±  3%  softirqs.CPU15.RCU
     12343           -53.4%       5746 ±  4%  softirqs.CPU15.SCHED
     32981 ±  6%    +101.9%      66580        softirqs.CPU15.TIMER
     24662 ±  4%     +55.8%      38421 ±  5%  softirqs.CPU16.RCU
     12688 ±  2%     -55.4%       5663 ±  4%  softirqs.CPU16.SCHED
     36953 ± 16%     +77.9%      65729        softirqs.CPU16.TIMER
     23400           +59.8%      37399 ±  3%  softirqs.CPU17.RCU
     12271           -54.3%       5606 ±  4%  softirqs.CPU17.SCHED
     32962 ±  4%     +99.4%      65740        softirqs.CPU17.TIMER
     32683 ±  4%     +82.5%      59647 ±  6%  softirqs.CPU18.NET_RX
     25103           +93.7%      48633 ±  3%  softirqs.CPU18.RCU
     12041 ±  2%     -54.5%       5483        softirqs.CPU18.SCHED
     33409 ±  4%    +108.3%      69578 ±  2%  softirqs.CPU18.TIMER
     25220 ±  5%     +58.9%      40086 ±  4%  softirqs.CPU19.RCU
     12067 ±  2%     -54.8%       5451        softirqs.CPU19.SCHED
     32427 ±  7%    +123.1%      72334 ± 12%  softirqs.CPU19.TIMER
     24832           +59.6%      39643 ±  3%  softirqs.CPU2.RCU
     12492           -50.5%       6180 ± 13%  softirqs.CPU2.SCHED
     32947 ±  4%    +101.7%      66462 ±  4%  softirqs.CPU2.TIMER
     24815 ±  3%     +68.6%      41835 ± 10%  softirqs.CPU20.RCU
     12286 ±  3%     -55.8%       5429 ±  2%  softirqs.CPU20.SCHED
     32890 ±  5%    +107.8%      68352 ±  2%  softirqs.CPU20.TIMER
     24938           +61.6%      40295 ±  3%  softirqs.CPU21.RCU
     12108 ±  2%     -54.9%       5458 ±  2%  softirqs.CPU21.SCHED
     32404 ±  7%    +112.4%      68832 ±  3%  softirqs.CPU21.TIMER
     24826 ±  2%     +58.5%      39357 ±  5%  softirqs.CPU22.RCU
     12072 ±  2%     -53.7%       5593 ±  5%  softirqs.CPU22.SCHED
     32154 ±  7%    +111.1%      67878 ±  2%  softirqs.CPU22.TIMER
     24864 ±  2%     +60.8%      39976 ±  3%  softirqs.CPU23.RCU
     12241 ±  2%     -54.6%       5562 ±  6%  softirqs.CPU23.SCHED
     32703 ±  7%    +111.0%      69007 ±  2%  softirqs.CPU23.TIMER
     24810           +69.9%      42140 ±  3%  softirqs.CPU24.RCU
     12193 ±  2%     -55.2%       5456 ±  3%  softirqs.CPU24.SCHED
     32970 ±  4%    +120.7%      72768 ± 11%  softirqs.CPU24.TIMER
     24934 ±  2%     +65.3%      41215 ±  3%  softirqs.CPU25.RCU
     12152           -54.8%       5498 ±  4%  softirqs.CPU25.SCHED
     32698 ±  4%    +111.2%      69066 ±  2%  softirqs.CPU25.TIMER
     24577 ±  3%     +57.3%      38666 ±  6%  softirqs.CPU26.RCU
     12053 ±  2%     -55.1%       5417        softirqs.CPU26.SCHED
     32230 ±  7%    +113.0%      68637 ±  3%  softirqs.CPU26.TIMER
     24775 ±  2%     +63.6%      40543 ±  5%  softirqs.CPU27.RCU
     12099           -55.5%       5383 ±  2%  softirqs.CPU27.SCHED
     32104 ±  7%    +109.5%      67262 ±  3%  softirqs.CPU27.TIMER
     25675 ±  4%     +54.7%      39729 ±  7%  softirqs.CPU28.RCU
     12071 ±  2%     -55.1%       5418 ±  3%  softirqs.CPU28.SCHED
     33737 ± 12%     +99.7%      67371 ±  3%  softirqs.CPU28.TIMER
     25228           +59.9%      40345 ±  4%  softirqs.CPU29.RCU
     12133 ±  2%     -54.2%       5553 ±  3%  softirqs.CPU29.SCHED
     32465 ±  7%    +110.9%      68455 ±  4%  softirqs.CPU29.TIMER
     24951 ±  3%     +65.2%      41231 ±  2%  softirqs.CPU3.RCU
     12450 ±  3%     -54.8%       5625 ±  3%  softirqs.CPU3.SCHED
     33392 ±  5%     +99.6%      66639        softirqs.CPU3.TIMER
     33399 ±  4%     -10.3%      29952 ±  3%  softirqs.CPU30.NET_RX
     25084           +61.4%      40475 ±  3%  softirqs.CPU30.RCU
     12063           -54.7%       5465 ±  3%  softirqs.CPU30.SCHED
     32439 ±  6%    +112.5%      68936 ±  2%  softirqs.CPU30.TIMER
     24885           +66.9%      41535 ±  2%  softirqs.CPU31.RCU
     12068 ±  2%     -55.6%       5359 ±  3%  softirqs.CPU31.SCHED
     32361 ±  6%    +110.8%      68212 ±  2%  softirqs.CPU31.TIMER
     23899           +55.7%      37215 ±  2%  softirqs.CPU32.RCU
     12029 ±  2%     -55.1%       5404 ±  2%  softirqs.CPU32.SCHED
     31832 ±  7%    +110.6%      67051 ±  3%  softirqs.CPU32.TIMER
     24330           +50.6%      36632 ±  6%  softirqs.CPU33.RCU
     12072 ±  2%     -55.4%       5387        softirqs.CPU33.SCHED
     32112 ±  7%    +111.4%      67901 ±  3%  softirqs.CPU33.TIMER
     24059 ±  2%     +64.6%      39606 ±  5%  softirqs.CPU34.RCU
     12144 ±  2%     -54.7%       5495 ±  2%  softirqs.CPU34.SCHED
     32796 ±  4%    +110.2%      68951 ±  3%  softirqs.CPU34.TIMER
     24298 ±  4%     +54.5%      37545 ±  3%  softirqs.CPU35.RCU
     12084 ±  2%     -54.8%       5456        softirqs.CPU35.SCHED
     34343 ±  4%     +98.1%      68034 ±  4%  softirqs.CPU35.TIMER
     32113 ±  7%     +75.2%      56274 ±  5%  softirqs.CPU36.NET_RX
     25252 ±  2%     +95.5%      49362 ±  7%  softirqs.CPU36.RCU
     12053           -57.6%       5106 ±  4%  softirqs.CPU36.SCHED
     33373 ± 10%     +99.9%      66724 ±  3%  softirqs.CPU36.TIMER
     31916 ±  4%      +8.3%      34563 ±  9%  softirqs.CPU37.NET_RX
     24445           +77.4%      43376 ±  8%  softirqs.CPU37.RCU
     12279           -56.4%       5353 ±  4%  softirqs.CPU37.SCHED
     32827 ±  4%    +103.7%      66873 ±  3%  softirqs.CPU37.TIMER
     24202 ±  2%     +66.9%      40397 ±  3%  softirqs.CPU38.RCU
     12242 ±  3%     -56.6%       5318 ±  2%  softirqs.CPU38.SCHED
     32220 ±  7%    +104.3%      65816 ±  2%  softirqs.CPU38.TIMER
     24995 ±  3%     +61.5%      40361 ±  2%  softirqs.CPU39.RCU
     12351 ±  2%     -56.9%       5325 ±  2%  softirqs.CPU39.SCHED
     33095 ±  5%    +102.9%      67141 ±  4%  softirqs.CPU39.TIMER
     24962 ±  4%     +61.4%      40287 ±  4%  softirqs.CPU4.RCU
     12670 ±  5%     -55.5%       5644        softirqs.CPU4.SCHED
     33083 ±  8%     +97.3%      65259 ±  2%  softirqs.CPU4.TIMER
     24785 ±  2%     +56.7%      38833 ±  2%  softirqs.CPU40.RCU
     12227           -56.7%       5290 ±  3%  softirqs.CPU40.SCHED
     32252 ±  4%    +105.3%      66205 ±  2%  softirqs.CPU40.TIMER
     24830 ±  2%     +58.6%      39390 ±  5%  softirqs.CPU41.RCU
     12190 ±  2%     -55.3%       5451 ±  3%  softirqs.CPU41.SCHED
     32764 ±  4%    +106.5%      67668 ±  3%  softirqs.CPU41.TIMER
     24908 ±  2%     +61.7%      40267 ±  7%  softirqs.CPU42.RCU
     12228           -56.1%       5369 ±  4%  softirqs.CPU42.SCHED
     33001 ±  4%    +103.2%      67051 ±  3%  softirqs.CPU42.TIMER
     24541 ±  4%     +73.6%      42601 ±  9%  softirqs.CPU43.RCU
     12244           -56.6%       5311        softirqs.CPU43.SCHED
     32548 ±  2%    +103.4%      66213 ±  2%  softirqs.CPU43.TIMER
     25055 ±  3%     +58.6%      39742 ±  2%  softirqs.CPU44.RCU
     12298           -56.9%       5298 ±  2%  softirqs.CPU44.SCHED
     32642 ±  2%    +103.2%      66331 ±  3%  softirqs.CPU44.TIMER
     24533 ±  2%     +61.7%      39681 ±  3%  softirqs.CPU45.RCU
     12200           -56.1%       5359 ±  2%  softirqs.CPU45.SCHED
     32233 ±  4%    +102.5%      65281 ±  2%  softirqs.CPU45.TIMER
     24562 ±  2%     +65.0%      40539 ±  5%  softirqs.CPU46.RCU
     12212           -56.3%       5331 ±  3%  softirqs.CPU46.SCHED
     32135 ±  4%    +115.3%      69195 ± 14%  softirqs.CPU46.TIMER
     24887 ±  2%     +59.3%      39655 ±  6%  softirqs.CPU47.RCU
     12319           -55.9%       5430 ±  3%  softirqs.CPU47.SCHED
     32744 ±  3%    +102.3%      66248 ±  3%  softirqs.CPU47.TIMER
     30949 ±  5%      +9.8%      33972 ±  5%  softirqs.CPU48.NET_RX
     24181 ±  2%     +65.9%      40112 ±  2%  softirqs.CPU48.RCU
     12214 ±  2%     -57.2%       5232 ±  3%  softirqs.CPU48.SCHED
     32368 ±  4%    +103.9%      65996 ±  2%  softirqs.CPU48.TIMER
     23672 ±  2%     +68.0%      39769 ±  2%  softirqs.CPU49.RCU
     12153           -56.6%       5278 ±  4%  softirqs.CPU49.SCHED
     31992 ±  4%    +107.4%      66341 ±  3%  softirqs.CPU49.TIMER
     24517           +64.9%      40431 ±  5%  softirqs.CPU5.RCU
     12287 ±  2%     -54.1%       5635 ±  3%  softirqs.CPU5.SCHED
     33167 ±  7%    +100.9%      66618        softirqs.CPU5.TIMER
     24647 ±  3%     +57.9%      38920 ±  3%  softirqs.CPU50.RCU
     12381           -57.1%       5313 ±  4%  softirqs.CPU50.SCHED
     32544 ±  4%    +102.6%      65935 ±  3%  softirqs.CPU50.TIMER
     24080           +63.2%      39288 ±  4%  softirqs.CPU51.RCU
     12280           -56.6%       5335 ±  2%  softirqs.CPU51.SCHED
     32298 ±  5%    +104.5%      66048 ±  2%  softirqs.CPU51.TIMER
     23846 ±  4%     +63.8%      39064 ±  3%  softirqs.CPU52.RCU
     12270           -56.7%       5318 ±  4%  softirqs.CPU52.SCHED
     31697 ±  6%    +107.5%      65758 ±  3%  softirqs.CPU52.TIMER
     23817 ±  3%     +65.3%      39361 ±  3%  softirqs.CPU53.RCU
     12323           -56.0%       5418 ±  3%  softirqs.CPU53.SCHED
     32260 ±  5%    +105.5%      66289 ±  2%  softirqs.CPU53.TIMER
     32779 ±  5%     +69.4%      55529 ±  7%  softirqs.CPU54.NET_RX
     24263 ±  4%    +108.6%      50606 ±  3%  softirqs.CPU54.RCU
     12038           -57.7%       5094 ±  5%  softirqs.CPU54.SCHED
     33076 ±  3%    +124.0%      74078 ±  4%  softirqs.CPU54.TIMER
     24644 ±  2%     +61.5%      39794 ±  4%  softirqs.CPU55.RCU
     12192           -56.4%       5315 ±  3%  softirqs.CPU55.SCHED
     35512 ± 10%     +92.7%      68439 ±  2%  softirqs.CPU55.TIMER
     24124 ±  2%     +64.3%      39643 ±  3%  softirqs.CPU56.RCU
     12081 ±  2%     -55.6%       5368 ±  4%  softirqs.CPU56.SCHED
     34625 ± 11%     +98.0%      68554 ±  2%  softirqs.CPU56.TIMER
     24714 ±  5%     +50.1%      37097 ±  8%  softirqs.CPU57.RCU
     12138           -55.6%       5394 ±  6%  softirqs.CPU57.SCHED
     35052 ± 10%     +96.1%      68722 ±  2%  softirqs.CPU57.TIMER
     25108 ±  5%     +49.0%      37413 ±  3%  softirqs.CPU58.RCU
     12260 ±  3%     -56.3%       5356 ±  4%  softirqs.CPU58.SCHED
     34828 ± 11%     +94.3%      67675        softirqs.CPU58.TIMER
     24415           +66.7%      40695 ±  3%  softirqs.CPU59.RCU
     12079 ±  2%     -53.2%       5650 ±  8%  softirqs.CPU59.SCHED
     34861 ± 11%     +97.1%      68720 ±  2%  softirqs.CPU59.TIMER
     24775 ±  2%     +51.3%      37481 ±  4%  softirqs.CPU6.RCU
     12239           -55.4%       5454 ±  3%  softirqs.CPU6.SCHED
     32901 ±  5%     +99.8%      65734        softirqs.CPU6.TIMER
     23936 ±  2%     +67.1%      39997 ±  2%  softirqs.CPU60.RCU
     12266 ±  2%     -54.5%       5579 ±  5%  softirqs.CPU60.SCHED
     35131 ± 11%    +108.4%      73199 ± 12%  softirqs.CPU60.TIMER
     24270           +64.0%      39792 ±  4%  softirqs.CPU61.RCU
     12120           -55.0%       5454 ±  6%  softirqs.CPU61.SCHED
     34830 ± 11%     +95.8%      68210 ±  2%  softirqs.CPU61.TIMER
     24329 ±  3%     +65.4%      40240        softirqs.CPU62.RCU
     12170           -56.2%       5334 ±  5%  softirqs.CPU62.SCHED
     34755 ± 11%     +95.1%      67825        softirqs.CPU62.TIMER
     24634 ±  5%     +65.9%      40877        softirqs.CPU63.RCU
     12232 ±  2%     -56.6%       5310 ±  3%  softirqs.CPU63.SCHED
     34589 ± 12%     +94.6%      67305        softirqs.CPU63.TIMER
     23915 ±  2%     +59.2%      38069 ±  6%  softirqs.CPU64.RCU
     12132           -56.1%       5331 ±  4%  softirqs.CPU64.SCHED
     34820 ± 11%     +92.5%      67019        softirqs.CPU64.TIMER
     24085 ±  2%     +65.2%      39789 ±  6%  softirqs.CPU65.RCU
     12199           -56.4%       5317 ±  5%  softirqs.CPU65.SCHED
     34939 ± 11%     +94.5%      67941 ±  2%  softirqs.CPU65.TIMER
     24158 ±  2%     +60.6%      38808 ±  3%  softirqs.CPU66.RCU
     12302 ±  3%     -55.0%       5533 ±  4%  softirqs.CPU66.SCHED
     35273 ± 10%     +95.2%      68870        softirqs.CPU66.TIMER
     24238 ±  3%     +59.2%      38595 ±  5%  softirqs.CPU67.RCU
     12257 ±  3%     -56.4%       5350 ±  3%  softirqs.CPU67.SCHED
     34892 ± 12%     +93.8%      67609        softirqs.CPU67.TIMER
     23837 ±  2%     +59.8%      38084 ±  3%  softirqs.CPU68.RCU
     12131           -55.9%       5350 ±  4%  softirqs.CPU68.SCHED
     34312 ± 12%     +95.6%      67105 ±  2%  softirqs.CPU68.TIMER
     33022 ±  4%      -7.5%      30547 ±  6%  softirqs.CPU69.NET_RX
     24120           +59.0%      38340 ±  3%  softirqs.CPU69.RCU
     12151           -56.3%       5305 ±  5%  softirqs.CPU69.SCHED
     34753 ± 11%     +96.1%      68169        softirqs.CPU69.TIMER
     24811 ±  2%     +58.1%      39221 ±  5%  softirqs.CPU7.RCU
     12399           -55.1%       5570 ±  3%  softirqs.CPU7.SCHED
     33362 ±  4%     +99.0%      66394        softirqs.CPU7.TIMER
     23635           +66.2%      39282 ±  8%  softirqs.CPU70.RCU
     12089           -54.9%       5454 ±  4%  softirqs.CPU70.SCHED
     34200 ± 12%     +99.1%      68099        softirqs.CPU70.TIMER
     24861 ±  3%     +53.1%      38074 ±  2%  softirqs.CPU71.RCU
     12334 ±  3%     -55.3%       5518 ±  4%  softirqs.CPU71.SCHED
     35345 ± 12%     +96.6%      69483 ±  2%  softirqs.CPU71.TIMER
     25404 ±  8%     +69.3%      43021 ±  2%  softirqs.CPU72.RCU
     12300           -54.6%       5586 ±  2%  softirqs.CPU72.SCHED
     33571 ±  3%     +99.2%      66865 ±  3%  softirqs.CPU72.TIMER
     27330 ±  8%     +58.9%      43429 ±  4%  softirqs.CPU73.RCU
     12230           -50.8%       6020 ±  7%  softirqs.CPU73.SCHED
     34691 ± 10%    +107.9%      72111        softirqs.CPU73.TIMER
     24478 ±  3%     +57.6%      38576 ±  3%  softirqs.CPU74.RCU
     12440 ±  2%     -48.6%       6393 ± 15%  softirqs.CPU74.SCHED
     31951 ±  5%    +108.5%      66623        softirqs.CPU74.TIMER
     24409 ±  4%     +56.8%      38278 ±  2%  softirqs.CPU75.RCU
     12616 ±  4%     -56.4%       5499 ±  3%  softirqs.CPU75.SCHED
     32214 ±  7%    +101.2%      64810        softirqs.CPU75.TIMER
     24477 ±  3%     +67.8%      41063 ±  2%  softirqs.CPU76.RCU
     13283 ±  7%     -56.2%       5811 ± 11%  softirqs.CPU76.SCHED
     34009 ±  3%     +92.1%      65320 ±  3%  softirqs.CPU76.TIMER
     24389 ±  4%     +52.6%      37212 ±  4%  softirqs.CPU77.RCU
     12795 ±  6%     -57.1%       5489 ±  2%  softirqs.CPU77.SCHED
     33503 ±  6%     +95.1%      65375        softirqs.CPU77.TIMER
     24646 ±  3%     +60.3%      39498 ±  4%  softirqs.CPU78.RCU
     12388           -54.5%       5635 ±  3%  softirqs.CPU78.SCHED
     32707 ±  4%     +98.9%      65047        softirqs.CPU78.TIMER
     24664 ±  3%     +55.8%      38420 ±  3%  softirqs.CPU79.RCU
     12442           -52.0%       5966 ±  8%  softirqs.CPU79.SCHED
     32637 ±  7%    +101.8%      65870        softirqs.CPU79.TIMER
     24657 ±  2%     +51.7%      37416 ±  3%  softirqs.CPU8.RCU
     12187           -54.6%       5537        softirqs.CPU8.SCHED
     32798 ±  5%     +99.6%      65481 ±  2%  softirqs.CPU8.TIMER
     24345           +64.8%      40121 ±  8%  softirqs.CPU80.RCU
     12221           -55.0%       5497 ±  6%  softirqs.CPU80.SCHED
     31718 ±  7%    +110.1%      66644 ±  3%  softirqs.CPU80.TIMER
     25228 ±  6%     +56.7%      39526 ±  7%  softirqs.CPU81.RCU
     12386 ±  4%     -55.0%       5570 ±  2%  softirqs.CPU81.SCHED
     32215 ± 10%    +101.1%      64781 ±  2%  softirqs.CPU81.TIMER
     24412 ±  3%     +61.9%      39515 ±  4%  softirqs.CPU82.RCU
     12407 ±  2%     -55.3%       5549 ±  4%  softirqs.CPU82.SCHED
     31370 ±  8%    +106.6%      64822 ±  2%  softirqs.CPU82.TIMER
     24802 ±  2%     +61.0%      39921 ±  3%  softirqs.CPU83.RCU
     12305 ±  2%     -52.4%       5860 ± 10%  softirqs.CPU83.SCHED
     31872 ±  7%    +106.0%      65666        softirqs.CPU83.TIMER
     24904 ±  2%     +60.8%      40056 ±  6%  softirqs.CPU84.RCU
     12321 ±  2%     -55.2%       5515 ±  3%  softirqs.CPU84.SCHED
     32098 ±  7%    +101.9%      64794        softirqs.CPU84.TIMER
     24708 ±  2%     +62.0%      40028 ±  4%  softirqs.CPU85.RCU
     12326 ±  2%     -54.4%       5619 ±  3%  softirqs.CPU85.SCHED
     31907 ±  7%    +103.4%      64910        softirqs.CPU85.TIMER
     24350 ±  3%     +60.9%      39183 ±  2%  softirqs.CPU86.RCU
     12867 ±  9%     -57.0%       5530 ±  3%  softirqs.CPU86.SCHED
     33096 ± 10%     +93.2%      63953        softirqs.CPU86.TIMER
     24533           +59.7%      39168 ±  4%  softirqs.CPU87.RCU
     12259           -55.2%       5491 ±  2%  softirqs.CPU87.SCHED
     32237 ±  4%    +101.0%      64792        softirqs.CPU87.TIMER
     24503 ±  2%     +58.2%      38762 ±  4%  softirqs.CPU88.RCU
     12315 ±  2%     -55.7%       5461 ±  3%  softirqs.CPU88.SCHED
     31555 ±  6%    +105.5%      64843 ±  2%  softirqs.CPU88.TIMER
     31872 ±  2%      +9.9%      35015 ±  4%  softirqs.CPU89.NET_RX
     24323 ±  2%     +62.5%      39523 ±  3%  softirqs.CPU89.RCU
     12139           -56.4%       5295 ±  4%  softirqs.CPU89.SCHED
     31361 ±  7%    +107.1%      64959        softirqs.CPU89.TIMER
     24811           +56.1%      38739        softirqs.CPU9.RCU
     12269           -54.3%       5611        softirqs.CPU9.SCHED
     32708 ±  4%    +100.5%      65586        softirqs.CPU9.TIMER
     23846 ±  2%     +71.4%      40869 ±  6%  softirqs.CPU90.RCU
     12083           -54.6%       5484 ±  2%  softirqs.CPU90.SCHED
     31978 ±  5%    +115.7%      68969 ±  2%  softirqs.CPU90.TIMER
     23909           +64.2%      39262 ±  3%  softirqs.CPU91.RCU
     12182 ±  2%     -55.5%       5419 ±  2%  softirqs.CPU91.SCHED
     32333 ±  5%    +114.8%      69445 ±  7%  softirqs.CPU91.TIMER
     24459 ±  5%     +58.6%      38802 ±  2%  softirqs.CPU92.RCU
     12233 ±  3%     -54.9%       5513        softirqs.CPU92.SCHED
     31923 ±  8%    +111.4%      67497 ±  3%  softirqs.CPU92.TIMER
     23956 ±  3%     +55.4%      37232 ±  4%  softirqs.CPU93.RCU
     12060           -54.9%       5444 ±  3%  softirqs.CPU93.SCHED
     31700 ±  4%    +113.5%      67674 ±  3%  softirqs.CPU93.TIMER
     24216 ±  2%     +54.9%      37500 ±  2%  softirqs.CPU94.RCU
     12081           -55.3%       5406 ±  3%  softirqs.CPU94.SCHED
     31673 ±  4%    +108.0%      65865 ±  3%  softirqs.CPU94.TIMER
     23964           +62.1%      38845 ±  5%  softirqs.CPU95.RCU
     12150 ±  2%     -54.9%       5476 ±  3%  softirqs.CPU95.SCHED
     32008 ±  4%    +113.3%      68263 ±  2%  softirqs.CPU95.TIMER
     24141 ±  3%     +59.2%      38434 ±  9%  softirqs.CPU96.RCU
     12030 ±  2%     -55.0%       5409 ±  2%  softirqs.CPU96.SCHED
     31452 ±  6%    +120.2%      69260 ±  5%  softirqs.CPU96.TIMER
     24751 ±  2%     +64.1%      40624 ±  4%  softirqs.CPU97.RCU
     12299 ±  2%     -53.4%       5733 ± 13%  softirqs.CPU97.SCHED
     32018 ±  8%    +116.2%      69225 ±  3%  softirqs.CPU97.TIMER
     24415           +64.6%      40179 ±  4%  softirqs.CPU98.RCU
     12363 ±  2%     -55.2%       5533 ±  3%  softirqs.CPU98.SCHED
     32551 ±  5%    +111.0%      68668 ±  3%  softirqs.CPU98.TIMER
     24365           +62.0%      39473 ±  6%  softirqs.CPU99.RCU
     12120           -56.0%       5336 ±  2%  softirqs.CPU99.SCHED
     31938 ±  4%    +105.7%      65704 ±  3%  softirqs.CPU99.TIMER
   3524303           +62.8%    5738376        softirqs.RCU
   1772799           -55.2%     793641 ±  2%  softirqs.SCHED
   4760101 ±  6%    +102.9%    9657988        softirqs.TIMER
     84.40 ± 11%    +200.9%     254.00 ± 53%  interrupts.45:PCI-MSI.1572864-edge.eth0-TxRx-0
     99.60 ±103%    +195.9%     294.75 ± 67%  interrupts.46:PCI-MSI.1572865-edge.eth0-TxRx-1
     48.40 ±  8%    +217.1%     153.50 ± 46%  interrupts.49:PCI-MSI.1572868-edge.eth0-TxRx-4
     47.60 ±  9%    +575.4%     321.50 ±101%  interrupts.50:PCI-MSI.1572869-edge.eth0-TxRx-5
     49.60 ± 14%    +219.1%     158.25 ± 81%  interrupts.51:PCI-MSI.1572870-edge.eth0-TxRx-6
     53.40 ± 20%    +116.3%     115.50 ± 41%  interrupts.53:PCI-MSI.1572872-edge.eth0-TxRx-8
     50.80 ± 12%    +260.2%     183.00 ± 70%  interrupts.54:PCI-MSI.1572873-edge.eth0-TxRx-9
     56.60 ± 34%    +282.5%     216.50 ± 98%  interrupts.55:PCI-MSI.1572874-edge.eth0-TxRx-10
     47.80 ±  9%     +92.5%      92.00 ± 10%  interrupts.56:PCI-MSI.1572875-edge.eth0-TxRx-11
     73.80 ± 60%    +157.8%     190.25 ± 59%  interrupts.60:PCI-MSI.1572879-edge.eth0-TxRx-15
     50.20 ± 29%    +148.0%     124.50 ± 57%  interrupts.63:PCI-MSI.1572882-edge.eth0-TxRx-18
     43.40 ±  3%    +116.0%      93.75 ± 21%  interrupts.64:PCI-MSI.1572883-edge.eth0-TxRx-19
     43.60 ±  5%    +156.9%     112.00 ± 47%  interrupts.79:PCI-MSI.1572898-edge.eth0-TxRx-34
     45.80 ±  3%    +262.4%     166.00 ± 89%  interrupts.89:PCI-MSI.1572908-edge.eth0-TxRx-44
     43.40          +276.2%     163.25 ± 86%  interrupts.91:PCI-MSI.1572910-edge.eth0-TxRx-46
    290577 ±  2%      +6.7%     310061        interrupts.CAL:Function_call_interrupts
     84.40 ± 11%    +200.9%     254.00 ± 53%  interrupts.CPU0.45:PCI-MSI.1572864-edge.eth0-TxRx-0
    172039 ±  3%     +91.5%     329481        interrupts.CPU0.LOC:Local_timer_interrupts
      3015 ± 16%    +222.9%       9737 ± 10%  interrupts.CPU0.RES:Rescheduling_interrupts
    674.80 ±  6%     -69.7%     204.25 ± 17%  interrupts.CPU0.TLB:TLB_shootdowns
     99.60 ±103%    +195.9%     294.75 ± 67%  interrupts.CPU1.46:PCI-MSI.1572865-edge.eth0-TxRx-1
    171895 ±  3%     +91.3%     328778        interrupts.CPU1.LOC:Local_timer_interrupts
      0.60 ±133%  +7.7e+05%       4611 ± 77%  interrupts.CPU1.NMI:Non-maskable_interrupts
      0.60 ±133%  +7.7e+05%       4611 ± 77%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      2372 ± 26%    +183.5%       6726 ±  9%  interrupts.CPU1.RES:Rescheduling_interrupts
    663.00 ± 11%     -53.1%     310.75 ± 62%  interrupts.CPU1.TLB:TLB_shootdowns
     56.60 ± 34%    +282.5%     216.50 ± 98%  interrupts.CPU10.55:PCI-MSI.1572874-edge.eth0-TxRx-10
    171489 ±  3%     +91.7%     328815        interrupts.CPU10.LOC:Local_timer_interrupts
      1.00 ±200%    +2e+05%       2042 ±171%  interrupts.CPU10.NMI:Non-maskable_interrupts
      1.00 ±200%    +2e+05%       2042 ±171%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      2060 ±  5%    +128.3%       4705 ± 10%  interrupts.CPU10.RES:Rescheduling_interrupts
    660.20 ±  6%     -73.0%     178.25 ± 11%  interrupts.CPU10.TLB:TLB_shootdowns
      1997 ±  3%     +13.1%       2258 ±  2%  interrupts.CPU100.CAL:Function_call_interrupts
    171254 ±  3%     +91.5%     327958        interrupts.CPU100.LOC:Local_timer_interrupts
      0.20 ±200%  +3.1e+06%       6112 ± 33%  interrupts.CPU100.NMI:Non-maskable_interrupts
      0.20 ±200%  +3.1e+06%       6112 ± 33%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      2062 ±  3%    +172.4%       5616 ± 18%  interrupts.CPU100.RES:Rescheduling_interrupts
    674.80 ±  4%     -71.1%     195.00 ± 13%  interrupts.CPU100.TLB:TLB_shootdowns
      1999 ±  3%     +11.4%       2226        interrupts.CPU101.CAL:Function_call_interrupts
    171223 ±  3%     +91.5%     327873        interrupts.CPU101.LOC:Local_timer_interrupts
      1965 ±  7%    +165.7%       5221 ±  6%  interrupts.CPU101.RES:Rescheduling_interrupts
    661.20 ±  5%     -71.3%     189.50 ± 15%  interrupts.CPU101.TLB:TLB_shootdowns
      2012 ±  4%      +7.7%       2166 ±  4%  interrupts.CPU102.CAL:Function_call_interrupts
    171442 ±  3%     +91.6%     328516        interrupts.CPU102.LOC:Local_timer_interrupts
      0.40 ±200%  +5.2e+05%       2085 ±168%  interrupts.CPU102.NMI:Non-maskable_interrupts
      0.40 ±200%  +5.2e+05%       2085 ±168%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
      2007 ±  6%    +180.2%       5625 ±  5%  interrupts.CPU102.RES:Rescheduling_interrupts
    655.40 ±  5%     -71.4%     187.75 ± 17%  interrupts.CPU102.TLB:TLB_shootdowns
    171477 ±  3%     +91.4%     328225        interrupts.CPU103.LOC:Local_timer_interrupts
      1989 ±  7%    +187.4%       5717 ± 11%  interrupts.CPU103.RES:Rescheduling_interrupts
    676.00 ±  7%     -71.1%     195.50 ± 12%  interrupts.CPU103.TLB:TLB_shootdowns
      2026 ±  6%     +10.4%       2238        interrupts.CPU104.CAL:Function_call_interrupts
    171488 ±  3%     +91.3%     328042        interrupts.CPU104.LOC:Local_timer_interrupts
      1984 ±  7%    +145.5%       4871 ± 16%  interrupts.CPU104.RES:Rescheduling_interrupts
    694.00 ± 10%     -68.9%     216.00        interrupts.CPU104.TLB:TLB_shootdowns
      1978 ±  4%     +12.2%       2219 ±  3%  interrupts.CPU105.CAL:Function_call_interrupts
    171452 ±  3%     +91.3%     328061        interrupts.CPU105.LOC:Local_timer_interrupts
      0.20 ±200%  +2.5e+06%       5086 ± 66%  interrupts.CPU105.NMI:Non-maskable_interrupts
      0.40 ±122%  +1.3e+06%       5086 ± 66%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
      1974 ±  6%    +182.6%       5580 ±  6%  interrupts.CPU105.RES:Rescheduling_interrupts
    654.40 ±  5%     -50.9%     321.25 ± 52%  interrupts.CPU105.TLB:TLB_shootdowns
    171446 ±  3%     +91.3%     328043        interrupts.CPU106.LOC:Local_timer_interrupts
      2027 ±  6%    +171.9%       5512 ± 14%  interrupts.CPU106.RES:Rescheduling_interrupts
    681.00 ±  8%     -43.2%     386.75 ± 37%  interrupts.CPU106.TLB:TLB_shootdowns
      1996 ±  5%     +13.2%       2259 ±  2%  interrupts.CPU107.CAL:Function_call_interrupts
    172012 ±  3%     +90.9%     328373        interrupts.CPU107.LOC:Local_timer_interrupts
      2045 ±  4%    +134.8%       4803 ±  2%  interrupts.CPU107.RES:Rescheduling_interrupts
    664.40 ±  5%     -29.9%     465.75 ±  8%  interrupts.CPU107.TLB:TLB_shootdowns
    171722 ±  3%     +91.1%     328177        interrupts.CPU108.LOC:Local_timer_interrupts
      2083 ±  4%    +164.9%       5520 ±  4%  interrupts.CPU108.RES:Rescheduling_interrupts
    669.00 ±  7%     -72.2%     185.75 ± 19%  interrupts.CPU108.TLB:TLB_shootdowns
    171940 ±  3%     +90.8%     328087        interrupts.CPU109.LOC:Local_timer_interrupts
      2162 ±  4%    +163.6%       5700        interrupts.CPU109.RES:Rescheduling_interrupts
    658.40 ± 11%     -71.7%     186.25 ±  8%  interrupts.CPU109.TLB:TLB_shootdowns
     47.80 ±  9%     +92.5%      92.00 ± 10%  interrupts.CPU11.56:PCI-MSI.1572875-edge.eth0-TxRx-11
    171355 ±  3%     +91.7%     328506        interrupts.CPU11.LOC:Local_timer_interrupts
      1999 ±  7%    +180.5%       5607 ± 11%  interrupts.CPU11.RES:Rescheduling_interrupts
    656.80 ± 10%     -56.8%     283.75 ± 69%  interrupts.CPU11.TLB:TLB_shootdowns
    171947 ±  3%     +91.1%     328670        interrupts.CPU110.LOC:Local_timer_interrupts
      2128 ±  7%    +152.5%       5373 ± 10%  interrupts.CPU110.RES:Rescheduling_interrupts
    637.60 ±  2%     -69.8%     192.25 ± 13%  interrupts.CPU110.TLB:TLB_shootdowns
    171834 ±  3%     +91.0%     328281        interrupts.CPU111.LOC:Local_timer_interrupts
      0.20 ±200%  +1.5e+06%       3074 ±110%  interrupts.CPU111.NMI:Non-maskable_interrupts
      0.20 ±200%  +1.5e+06%       3074 ±110%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
      2127 ±  5%    +172.2%       5789 ±  5%  interrupts.CPU111.RES:Rescheduling_interrupts
    678.00 ±  4%     -71.6%     192.75 ±  6%  interrupts.CPU111.TLB:TLB_shootdowns
      2024 ±  2%      +8.2%       2190        interrupts.CPU112.CAL:Function_call_interrupts
    172020 ±  3%     +90.8%     328201        interrupts.CPU112.LOC:Local_timer_interrupts
      2059 ±  7%    +181.8%       5802 ± 17%  interrupts.CPU112.RES:Rescheduling_interrupts
    667.00 ±  5%     -70.8%     194.75 ± 10%  interrupts.CPU112.TLB:TLB_shootdowns
    171971 ±  3%     +91.0%     328455        interrupts.CPU113.LOC:Local_timer_interrupts
      2124 ±  7%    +152.2%       5356 ± 10%  interrupts.CPU113.RES:Rescheduling_interrupts
    691.40 ±  6%     -73.1%     185.75 ±  7%  interrupts.CPU113.TLB:TLB_shootdowns
    171490 ±  3%     +91.5%     328333        interrupts.CPU114.LOC:Local_timer_interrupts
      2139 ±  8%    +171.4%       5808 ± 10%  interrupts.CPU114.RES:Rescheduling_interrupts
    670.00 ±  8%     -71.4%     191.75 ± 12%  interrupts.CPU114.TLB:TLB_shootdowns
    171734 ±  3%     +91.2%     328288        interrupts.CPU115.LOC:Local_timer_interrupts
      2249 ±  7%    +153.1%       5693 ±  6%  interrupts.CPU115.RES:Rescheduling_interrupts
    704.60 ±  9%     -74.2%     182.00 ±  5%  interrupts.CPU115.TLB:TLB_shootdowns
    171747 ±  3%     +91.1%     328259        interrupts.CPU116.LOC:Local_timer_interrupts
      0.40 ±200%  +8.8e+05%       3504 ± 86%  interrupts.CPU116.NMI:Non-maskable_interrupts
      0.40 ±200%  +8.8e+05%       3504 ± 86%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
      2073 ±  3%    +197.1%       6159 ±  3%  interrupts.CPU116.RES:Rescheduling_interrupts
    676.40 ± 12%     -71.8%     190.50 ± 13%  interrupts.CPU116.TLB:TLB_shootdowns
    171731 ±  3%     +90.9%     327915        interrupts.CPU117.LOC:Local_timer_interrupts
      2031 ±  6%    +174.0%       5565 ± 10%  interrupts.CPU117.RES:Rescheduling_interrupts
    683.40 ±  7%     -74.7%     173.00 ± 16%  interrupts.CPU117.TLB:TLB_shootdowns
    171736 ±  3%     +91.3%     328505        interrupts.CPU118.LOC:Local_timer_interrupts
      2003 ±  8%    +175.0%       5510 ±  8%  interrupts.CPU118.RES:Rescheduling_interrupts
    683.20 ±  8%     -72.3%     189.00 ±  9%  interrupts.CPU118.TLB:TLB_shootdowns
      2019 ±  2%      +8.9%       2199 ±  4%  interrupts.CPU119.CAL:Function_call_interrupts
    171751 ±  3%     +90.7%     327535        interrupts.CPU119.LOC:Local_timer_interrupts
      0.20 ±200%    +2e+06%       4060 ± 99%  interrupts.CPU119.NMI:Non-maskable_interrupts
      0.20 ±200%    +2e+06%       4060 ± 99%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
      2034 ±  4%    +179.4%       5683 ± 10%  interrupts.CPU119.RES:Rescheduling_interrupts
    652.80 ±  4%     -69.1%     202.00 ± 12%  interrupts.CPU119.TLB:TLB_shootdowns
      1969 ±  4%     +10.4%       2175 ±  3%  interrupts.CPU12.CAL:Function_call_interrupts
    172076 ±  3%     +90.7%     328076        interrupts.CPU12.LOC:Local_timer_interrupts
      1988 ±  6%    +177.3%       5512 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
    644.00 ±  7%     -71.3%     185.00 ± 13%  interrupts.CPU12.TLB:TLB_shootdowns
    171754 ±  3%     +90.7%     327535        interrupts.CPU120.LOC:Local_timer_interrupts
      1978 ±  7%    +158.0%       5103 ± 10%  interrupts.CPU120.RES:Rescheduling_interrupts
    671.20 ±  5%     -74.0%     174.25 ±  4%  interrupts.CPU120.TLB:TLB_shootdowns
    171469 ±  3%     +91.2%     327892        interrupts.CPU121.LOC:Local_timer_interrupts
      1978 ±  8%    +169.3%       5328 ±  6%  interrupts.CPU121.RES:Rescheduling_interrupts
    658.00 ±  8%     -70.4%     194.50 ± 17%  interrupts.CPU121.TLB:TLB_shootdowns
    171964 ±  3%     +91.0%     328514        interrupts.CPU122.LOC:Local_timer_interrupts
      1942 ±  8%    +176.3%       5367 ±  7%  interrupts.CPU122.RES:Rescheduling_interrupts
    697.00 ± 10%     -71.1%     201.75 ± 18%  interrupts.CPU122.TLB:TLB_shootdowns
    171713 ±  3%     +90.7%     327518        interrupts.CPU123.LOC:Local_timer_interrupts
      0.20 ±200%  +4.1e+06%       8127        interrupts.CPU123.NMI:Non-maskable_interrupts
      0.20 ±200%  +4.1e+06%       8127        interrupts.CPU123.PMI:Performance_monitoring_interrupts
      1979 ±  8%    +186.4%       5669 ± 10%  interrupts.CPU123.RES:Rescheduling_interrupts
    660.20 ±  4%     -64.2%     236.50 ± 11%  interrupts.CPU123.TLB:TLB_shootdowns
    171869 ±  3%     +90.7%     327685        interrupts.CPU124.LOC:Local_timer_interrupts
      0.40 ±200%  +1.3e+06%       5083 ± 66%  interrupts.CPU124.NMI:Non-maskable_interrupts
      0.40 ±200%  +1.3e+06%       5083 ± 66%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
      1976 ±  8%    +184.1%       5615 ±  9%  interrupts.CPU124.RES:Rescheduling_interrupts
    702.20 ±  6%     -48.6%     361.25 ± 21%  interrupts.CPU124.TLB:TLB_shootdowns
    172125 ±  3%     +90.6%     328114        interrupts.CPU125.LOC:Local_timer_interrupts
      0.60 ±133%  +1.1e+05%     644.00 ±112%  interrupts.CPU125.NMI:Non-maskable_interrupts
      0.60 ±133%  +1.1e+05%     644.00 ±112%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      1961 ±  5%    +210.2%       6085 ±  4%  interrupts.CPU125.RES:Rescheduling_interrupts
    678.00 ± 10%     -29.2%     479.75 ± 15%  interrupts.CPU125.TLB:TLB_shootdowns
    171660 ±  3%     +91.5%     328655        interrupts.CPU126.LOC:Local_timer_interrupts
      2243 ±  8%    +114.5%       4811 ±  5%  interrupts.CPU126.RES:Rescheduling_interrupts
    678.20 ±  6%     -72.0%     190.00 ±  3%  interrupts.CPU126.TLB:TLB_shootdowns
    171995 ±  3%     +91.4%     329137        interrupts.CPU127.LOC:Local_timer_interrupts
      2217 ±  8%    +145.6%       5447 ± 12%  interrupts.CPU127.RES:Rescheduling_interrupts
    699.60 ±  8%     -74.1%     181.00 ± 20%  interrupts.CPU127.TLB:TLB_shootdowns
    171462 ±  3%     +92.0%     329168        interrupts.CPU128.LOC:Local_timer_interrupts
      2162 ±  5%    +126.6%       4899 ±  7%  interrupts.CPU128.RES:Rescheduling_interrupts
    693.20 ± 12%     -75.3%     171.25 ±  7%  interrupts.CPU128.TLB:TLB_shootdowns
    171468 ±  3%     +91.7%     328657        interrupts.CPU129.LOC:Local_timer_interrupts
      2227 ±  7%    +139.2%       5328 ±  5%  interrupts.CPU129.RES:Rescheduling_interrupts
    686.80 ±  8%     -71.2%     197.75 ± 12%  interrupts.CPU129.TLB:TLB_shootdowns
      1993 ±  2%      +9.7%       2186 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
    171990 ±  3%     +91.6%     329485        interrupts.CPU13.LOC:Local_timer_interrupts
      1927 ±  9%    +164.2%       5093 ±  8%  interrupts.CPU13.RES:Rescheduling_interrupts
    675.00 ±  7%     -71.9%     189.50 ±  3%  interrupts.CPU13.TLB:TLB_shootdowns
    171390 ±  3%     +91.2%     327627        interrupts.CPU130.LOC:Local_timer_interrupts
      2094 ±  5%    +181.8%       5900 ± 16%  interrupts.CPU130.RES:Rescheduling_interrupts
    645.40 ± 10%     -56.1%     283.50 ± 50%  interrupts.CPU130.TLB:TLB_shootdowns
      2027            +8.6%       2200 ±  3%  interrupts.CPU131.CAL:Function_call_interrupts
    171777 ±  3%     +90.7%     327558        interrupts.CPU131.LOC:Local_timer_interrupts
      0.60 ±133%  +8.5e+05%       5099 ± 66%  interrupts.CPU131.NMI:Non-maskable_interrupts
      0.60 ±133%  +8.5e+05%       5099 ± 66%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
      2102 ±  5%    +135.3%       4945 ± 13%  interrupts.CPU131.RES:Rescheduling_interrupts
    681.60 ±  7%     -74.6%     173.25 ± 15%  interrupts.CPU131.TLB:TLB_shootdowns
    171527 ±  3%     +91.2%     327916        interrupts.CPU132.LOC:Local_timer_interrupts
      2137 ±  4%    +139.0%       5109 ±  4%  interrupts.CPU132.RES:Rescheduling_interrupts
    690.80 ± 10%     -71.7%     195.25 ± 13%  interrupts.CPU132.TLB:TLB_shootdowns
      2084 ±  2%      +5.2%       2193 ±  3%  interrupts.CPU133.CAL:Function_call_interrupts
    171293 ±  3%     +91.2%     327596        interrupts.CPU133.LOC:Local_timer_interrupts
      0.20 ±200%    +2e+06%       4074 ± 70%  interrupts.CPU133.NMI:Non-maskable_interrupts
      0.20 ±200%    +2e+06%       4074 ± 70%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
      2199 ±  6%    +139.5%       5267 ±  5%  interrupts.CPU133.RES:Rescheduling_interrupts
    687.00 ±  6%     -72.7%     187.50 ± 11%  interrupts.CPU133.TLB:TLB_shootdowns
    171538 ±  3%     +91.0%     327649        interrupts.CPU134.LOC:Local_timer_interrupts
      2067 ±  4%    +124.6%       4643 ± 10%  interrupts.CPU134.RES:Rescheduling_interrupts
    704.40 ±  5%     -73.1%     189.25 ± 15%  interrupts.CPU134.TLB:TLB_shootdowns
    171809 ±  3%     +91.2%     328578        interrupts.CPU135.LOC:Local_timer_interrupts
      2018 ±  8%    +159.9%       5245 ±  6%  interrupts.CPU135.RES:Rescheduling_interrupts
    678.80 ±  8%     -73.6%     179.00 ± 14%  interrupts.CPU135.TLB:TLB_shootdowns
    171565 ±  3%     +91.1%     327903        interrupts.CPU136.LOC:Local_timer_interrupts
      1.60 ±145%  +97071.9%       1554 ±101%  interrupts.CPU136.NMI:Non-maskable_interrupts
      1.60 ±145%  +97071.9%       1554 ±101%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
      2093 ±  4%    +153.7%       5310 ±  5%  interrupts.CPU136.RES:Rescheduling_interrupts
    710.40 ±  9%     -72.1%     198.50 ± 11%  interrupts.CPU136.TLB:TLB_shootdowns
      2022 ±  3%      +8.9%       2202 ±  2%  interrupts.CPU137.CAL:Function_call_interrupts
    171491 ±  3%     +91.5%     328426        interrupts.CPU137.LOC:Local_timer_interrupts
      2013 ±  6%    +179.9%       5635 ±  9%  interrupts.CPU137.RES:Rescheduling_interrupts
    685.00 ±  5%     -72.8%     186.25 ± 11%  interrupts.CPU137.TLB:TLB_shootdowns
      2004 ±  2%      +9.5%       2194 ±  3%  interrupts.CPU138.CAL:Function_call_interrupts
    171271 ±  3%     +91.4%     327834        interrupts.CPU138.LOC:Local_timer_interrupts
      0.20 ±200%  +2.7e+06%       5367 ± 55%  interrupts.CPU138.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.7e+06%       5367 ± 55%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      1932 ±  9%    +166.1%       5141 ±  7%  interrupts.CPU138.RES:Rescheduling_interrupts
    659.40 ±  4%     -69.1%     203.50 ± 11%  interrupts.CPU138.TLB:TLB_shootdowns
      1985 ±  4%     +11.3%       2210 ±  2%  interrupts.CPU139.CAL:Function_call_interrupts
    171830 ±  3%     +90.9%     328045        interrupts.CPU139.LOC:Local_timer_interrupts
      0.20 ±200%  +1.9e+06%       3791 ± 77%  interrupts.CPU139.NMI:Non-maskable_interrupts
      0.20 ±200%  +1.9e+06%       3791 ± 77%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
      1898 ±  9%    +180.5%       5326 ± 11%  interrupts.CPU139.RES:Rescheduling_interrupts
    679.80 ± 11%     -73.4%     180.50 ±  5%  interrupts.CPU139.TLB:TLB_shootdowns
    171720 ±  3%     +91.2%     328348        interrupts.CPU14.LOC:Local_timer_interrupts
      1.00 ±126%  +5.1e+05%       5088 ± 66%  interrupts.CPU14.NMI:Non-maskable_interrupts
      1.00 ±126%  +5.1e+05%       5088 ± 66%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
      2132 ±  5%    +148.4%       5298 ±  4%  interrupts.CPU14.RES:Rescheduling_interrupts
    700.60 ±  5%     -72.1%     195.75 ± 10%  interrupts.CPU14.TLB:TLB_shootdowns
      2026 ±  4%     +10.4%       2237        interrupts.CPU140.CAL:Function_call_interrupts
    171332 ±  3%     +91.5%     328159        interrupts.CPU140.LOC:Local_timer_interrupts
      0.00       +6.8e+105%       6832 ± 32%  interrupts.CPU140.NMI:Non-maskable_interrupts
      0.00       +6.8e+105%       6832 ± 32%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
      2110 ±  9%    +156.1%       5405 ±  2%  interrupts.CPU140.RES:Rescheduling_interrupts
    666.00 ± 10%     -67.0%     219.75 ±  8%  interrupts.CPU140.TLB:TLB_shootdowns
    171275 ±  3%     +91.2%     327526        interrupts.CPU141.LOC:Local_timer_interrupts
      2021 ±  8%    +180.0%       5659 ±  9%  interrupts.CPU141.RES:Rescheduling_interrupts
    646.60 ±  6%     -62.4%     243.25 ±  8%  interrupts.CPU141.TLB:TLB_shootdowns
    171492 ±  3%     +91.2%     327819        interrupts.CPU142.LOC:Local_timer_interrupts
      1960 ±  6%    +169.2%       5277 ±  5%  interrupts.CPU142.RES:Rescheduling_interrupts
    662.80 ±  4%     -59.0%     271.50 ± 17%  interrupts.CPU142.TLB:TLB_shootdowns
      2005           +13.5%       2277        interrupts.CPU143.CAL:Function_call_interrupts
    171792 ±  3%     +90.7%     327629        interrupts.CPU143.LOC:Local_timer_interrupts
      0.60 ±133%  +8.6e+05%       5159 ± 64%  interrupts.CPU143.NMI:Non-maskable_interrupts
      0.60 ±133%  +8.6e+05%       5159 ± 64%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
      1880 ±  5%    +209.7%       5823 ± 15%  interrupts.CPU143.RES:Rescheduling_interrupts
    662.00 ±  6%     -31.6%     452.75 ± 17%  interrupts.CPU143.TLB:TLB_shootdowns
     73.80 ± 60%    +157.8%     190.25 ± 59%  interrupts.CPU15.60:PCI-MSI.1572879-edge.eth0-TxRx-15
    171706 ±  3%     +91.9%     329574        interrupts.CPU15.LOC:Local_timer_interrupts
      2028 ±  6%    +179.6%       5671 ±  6%  interrupts.CPU15.RES:Rescheduling_interrupts
    672.20 ±  8%     -68.0%     215.25 ± 25%  interrupts.CPU15.TLB:TLB_shootdowns
    171883 ±  3%     +91.5%     329138        interrupts.CPU16.LOC:Local_timer_interrupts
      2021 ± 10%    +162.5%       5307 ± 11%  interrupts.CPU16.RES:Rescheduling_interrupts
    666.20 ±  3%     -71.2%     191.75 ±  9%  interrupts.CPU16.TLB:TLB_shootdowns
      1996 ±  4%     +10.6%       2207        interrupts.CPU17.CAL:Function_call_interrupts
    171324 ±  3%     +92.0%     328951        interrupts.CPU17.LOC:Local_timer_interrupts
      1.60 ±170%  +4.4e+05%       6967 ± 24%  interrupts.CPU17.NMI:Non-maskable_interrupts
      1.60 ±170%  +4.4e+05%       6967 ± 24%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
      1952 ±  5%    +169.6%       5263 ±  9%  interrupts.CPU17.RES:Rescheduling_interrupts
    657.80 ±  8%     -67.1%     216.25 ± 15%  interrupts.CPU17.TLB:TLB_shootdowns
     50.20 ± 29%    +148.0%     124.50 ± 57%  interrupts.CPU18.63:PCI-MSI.1572882-edge.eth0-TxRx-18
      1978 ±  4%      +8.4%       2144 ±  2%  interrupts.CPU18.CAL:Function_call_interrupts
    171903 ±  3%     +91.7%     329492        interrupts.CPU18.LOC:Local_timer_interrupts
      2199 ±  4%    +310.2%       9022 ±  2%  interrupts.CPU18.RES:Rescheduling_interrupts
    679.40 ±  3%     -68.6%     213.50 ±  8%  interrupts.CPU18.TLB:TLB_shootdowns
     43.40 ±  3%    +116.0%      93.75 ± 21%  interrupts.CPU19.64:PCI-MSI.1572883-edge.eth0-TxRx-19
    171643 ±  3%     +91.3%     328400        interrupts.CPU19.LOC:Local_timer_interrupts
      2225 ±  8%    +166.9%       5941 ± 11%  interrupts.CPU19.RES:Rescheduling_interrupts
    678.80 ±  8%     -72.2%     189.00 ± 12%  interrupts.CPU19.TLB:TLB_shootdowns
    172035 ±  3%     +91.4%     329205        interrupts.CPU2.LOC:Local_timer_interrupts
      2131 ± 11%    +165.9%       5668 ±  7%  interrupts.CPU2.RES:Rescheduling_interrupts
    674.00 ±  5%     -71.5%     192.25 ± 13%  interrupts.CPU2.TLB:TLB_shootdowns
    171579 ±  3%     +92.2%     329723        interrupts.CPU20.LOC:Local_timer_interrupts
      2225 ± 15%    +161.0%       5807 ± 15%  interrupts.CPU20.RES:Rescheduling_interrupts
    672.80 ±  6%     -70.3%     200.00 ± 15%  interrupts.CPU20.TLB:TLB_shootdowns
      1983 ±  4%     +10.8%       2197 ±  5%  interrupts.CPU21.CAL:Function_call_interrupts
    171590 ±  3%     +92.2%     329770        interrupts.CPU21.LOC:Local_timer_interrupts
      2173 ±  9%    +154.7%       5535 ± 11%  interrupts.CPU21.RES:Rescheduling_interrupts
    652.40 ±  5%     -70.1%     194.75 ± 18%  interrupts.CPU21.TLB:TLB_shootdowns
    171281 ±  3%     +92.5%     329714        interrupts.CPU22.LOC:Local_timer_interrupts
      2025 ±  7%    +156.8%       5200 ± 13%  interrupts.CPU22.RES:Rescheduling_interrupts
    669.60 ± 11%     -73.6%     176.50 ± 10%  interrupts.CPU22.TLB:TLB_shootdowns
    171215 ±  3%     +92.1%     328970        interrupts.CPU23.LOC:Local_timer_interrupts
      2033 ±  6%    +166.4%       5416 ±  8%  interrupts.CPU23.RES:Rescheduling_interrupts
    646.00 ±  7%     -70.9%     188.00 ± 17%  interrupts.CPU23.TLB:TLB_shootdowns
    171242 ±  3%     +92.1%     329038        interrupts.CPU24.LOC:Local_timer_interrupts
      2130 ±  7%    +166.0%       5666 ±  8%  interrupts.CPU24.RES:Rescheduling_interrupts
    656.80 ±  9%     -71.2%     189.00 ± 15%  interrupts.CPU24.TLB:TLB_shootdowns
    171535 ±  3%     +91.8%     328926        interrupts.CPU25.LOC:Local_timer_interrupts
      0.20 ±200%  +3.5e+06%       7027 ± 24%  interrupts.CPU25.NMI:Non-maskable_interrupts
      0.20 ±200%  +3.5e+06%       7027 ± 24%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      2202 ±  6%    +162.4%       5779 ±  5%  interrupts.CPU25.RES:Rescheduling_interrupts
    662.00 ±  6%     -71.7%     187.25 ± 12%  interrupts.CPU25.TLB:TLB_shootdowns
      1981 ±  3%     +11.4%       2207 ±  2%  interrupts.CPU26.CAL:Function_call_interrupts
    171219 ±  3%     +92.2%     329045        interrupts.CPU26.LOC:Local_timer_interrupts
      2097          +147.8%       5198 ±  8%  interrupts.CPU26.RES:Rescheduling_interrupts
    636.60 ±  6%     -70.6%     187.25 ± 10%  interrupts.CPU26.TLB:TLB_shootdowns
    171186 ±  3%     +92.5%     329474        interrupts.CPU27.LOC:Local_timer_interrupts
      2109 ±  6%    +152.2%       5319 ± 10%  interrupts.CPU27.RES:Rescheduling_interrupts
    712.60 ±  7%     -71.0%     206.50 ±  4%  interrupts.CPU27.TLB:TLB_shootdowns
    171360 ±  3%     +92.5%     329839        interrupts.CPU28.LOC:Local_timer_interrupts
      2177 ±  9%    +158.5%       5629 ± 18%  interrupts.CPU28.RES:Rescheduling_interrupts
    723.00 ±  3%     -72.5%     198.50 ± 14%  interrupts.CPU28.TLB:TLB_shootdowns
    171382 ±  3%     +92.4%     329701        interrupts.CPU29.LOC:Local_timer_interrupts
      2097 ±  3%    +142.6%       5087 ± 12%  interrupts.CPU29.RES:Rescheduling_interrupts
    674.60 ±  5%     -71.9%     189.50 ± 12%  interrupts.CPU29.TLB:TLB_shootdowns
    171555 ±  3%     +92.3%     329818        interrupts.CPU3.LOC:Local_timer_interrupts
      1.20 ±200%  +2.6e+05%       3111 ±106%  interrupts.CPU3.NMI:Non-maskable_interrupts
      1.20 ±200%  +2.6e+05%       3111 ±106%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
      2104 ± 13%    +153.7%       5338 ±  2%  interrupts.CPU3.RES:Rescheduling_interrupts
    675.00 ±  7%     -74.0%     175.25 ±  7%  interrupts.CPU3.TLB:TLB_shootdowns
      1965 ±  4%      +9.3%       2147 ±  2%  interrupts.CPU30.CAL:Function_call_interrupts
    171188 ±  3%     +91.9%     328572        interrupts.CPU30.LOC:Local_timer_interrupts
      2031 ±  8%    +158.6%       5252 ±  6%  interrupts.CPU30.RES:Rescheduling_interrupts
    641.20 ±  9%     -71.4%     183.25 ± 14%  interrupts.CPU30.TLB:TLB_shootdowns
    171228 ±  3%     +91.9%     328574        interrupts.CPU31.LOC:Local_timer_interrupts
      2028 ±  6%    +165.9%       5394 ±  4%  interrupts.CPU31.RES:Rescheduling_interrupts
    680.60 ±  6%     -74.9%     170.75 ± 14%  interrupts.CPU31.TLB:TLB_shootdowns
    171220 ±  3%     +92.2%     329111        interrupts.CPU32.LOC:Local_timer_interrupts
      2027 ±  3%    +171.2%       5499 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
    699.00 ±  8%     -72.5%     192.50 ±  6%  interrupts.CPU32.TLB:TLB_shootdowns
    171195 ±  3%     +92.3%     329290        interrupts.CPU33.LOC:Local_timer_interrupts
      2098 ±  5%    +131.0%       4848 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
    649.60 ± 12%     -71.6%     184.25 ± 11%  interrupts.CPU33.TLB:TLB_shootdowns
     43.60 ±  5%    +156.9%     112.00 ± 47%  interrupts.CPU34.79:PCI-MSI.1572898-edge.eth0-TxRx-34
    171203 ±  3%     +92.6%     329761        interrupts.CPU34.LOC:Local_timer_interrupts
      1981 ±  7%    +202.3%       5990 ±  5%  interrupts.CPU34.RES:Rescheduling_interrupts
    670.20 ±  3%     -69.5%     204.50 ±  8%  interrupts.CPU34.TLB:TLB_shootdowns
      1958 ±  3%      +8.8%       2130        interrupts.CPU35.CAL:Function_call_interrupts
    171220 ±  3%     +92.4%     329444        interrupts.CPU35.LOC:Local_timer_interrupts
      0.00         +2e+105%       2044 ±172%  interrupts.CPU35.NMI:Non-maskable_interrupts
      0.00         +2e+105%       2044 ±172%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      1954 ±  5%    +168.3%       5243 ±  9%  interrupts.CPU35.RES:Rescheduling_interrupts
    648.60 ±  8%     -68.0%     207.25 ±  8%  interrupts.CPU35.TLB:TLB_shootdowns
    171623 ±  3%     +91.2%     328225        interrupts.CPU36.LOC:Local_timer_interrupts
      0.00       +4.1e+105%       4080 ± 99%  interrupts.CPU36.NMI:Non-maskable_interrupts
      0.00       +4.1e+105%       4080 ± 99%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      2219 ±  2%    +262.4%       8044 ± 10%  interrupts.CPU36.RES:Rescheduling_interrupts
    684.20 ±  4%     -68.8%     213.50 ± 18%  interrupts.CPU36.TLB:TLB_shootdowns
    171869 ±  3%     +91.2%     328543        interrupts.CPU37.LOC:Local_timer_interrupts
      2027 ±  5%    +205.6%       6194 ±  9%  interrupts.CPU37.RES:Rescheduling_interrupts
    653.60 ±  5%     -69.9%     196.50 ± 22%  interrupts.CPU37.TLB:TLB_shootdowns
    171761 ±  3%     +91.6%     329021        interrupts.CPU38.LOC:Local_timer_interrupts
      0.40 ±122%  +5.2e+05%       2064 ±170%  interrupts.CPU38.NMI:Non-maskable_interrupts
      0.40 ±122%  +5.2e+05%       2064 ±170%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      2063 ±  7%    +173.8%       5649 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
    683.80 ±  9%     -73.6%     180.50 ± 12%  interrupts.CPU38.TLB:TLB_shootdowns
    171734 ±  3%     +91.0%     328002        interrupts.CPU39.LOC:Local_timer_interrupts
      0.20 ±200%  +2.2e+06%       4416 ± 85%  interrupts.CPU39.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.2e+06%       4416 ± 85%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      2080 ±  5%    +143.9%       5074 ±  5%  interrupts.CPU39.RES:Rescheduling_interrupts
    693.00 ±  7%     -74.2%     179.00 ±  7%  interrupts.CPU39.TLB:TLB_shootdowns
     48.40 ±  8%    +217.1%     153.50 ± 46%  interrupts.CPU4.49:PCI-MSI.1572868-edge.eth0-TxRx-4
    171419 ±  3%     +91.7%     328648        interrupts.CPU4.LOC:Local_timer_interrupts
      2265 ± 21%    +141.2%       5464 ± 10%  interrupts.CPU4.RES:Rescheduling_interrupts
    679.60 ±  6%     -73.2%     182.00 ±  8%  interrupts.CPU4.TLB:TLB_shootdowns
    171483 ±  3%     +91.4%     328227        interrupts.CPU40.LOC:Local_timer_interrupts
      0.20 ±200%  +2.2e+06%       4412 ± 84%  interrupts.CPU40.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.2e+06%       4412 ± 84%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      1983 ±  4%    +138.8%       4736 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
    692.60 ±  7%     -70.6%     203.50 ± 14%  interrupts.CPU40.TLB:TLB_shootdowns
    171841 ±  3%     +91.4%     328925        interrupts.CPU41.LOC:Local_timer_interrupts
      2038 ±  7%    +164.7%       5395 ±  8%  interrupts.CPU41.RES:Rescheduling_interrupts
    661.60 ±  7%     -72.8%     180.25 ±  8%  interrupts.CPU41.TLB:TLB_shootdowns
    172145 ±  3%     +90.8%     328473        interrupts.CPU42.LOC:Local_timer_interrupts
      2137 ±  4%    +160.5%       5567 ± 17%  interrupts.CPU42.RES:Rescheduling_interrupts
    695.80 ±  7%     -70.8%     203.00 ± 12%  interrupts.CPU42.TLB:TLB_shootdowns
    171786 ±  3%     +91.4%     328883        interrupts.CPU43.LOC:Local_timer_interrupts
      2109 ±  5%    +192.3%       6166 ± 16%  interrupts.CPU43.RES:Rescheduling_interrupts
    637.80 ±  8%     -68.4%     201.75 ± 23%  interrupts.CPU43.TLB:TLB_shootdowns
     45.80 ±  3%    +262.4%     166.00 ± 89%  interrupts.CPU44.89:PCI-MSI.1572908-edge.eth0-TxRx-44
    172181 ±  3%     +91.2%     329194        interrupts.CPU44.LOC:Local_timer_interrupts
      1998 ±  4%    +169.3%       5382 ±  8%  interrupts.CPU44.RES:Rescheduling_interrupts
    650.20           -71.0%     188.50 ± 10%  interrupts.CPU44.TLB:TLB_shootdowns
    172100 ±  3%     +91.4%     329470        interrupts.CPU45.LOC:Local_timer_interrupts
      1948 ±  4%    +169.7%       5255 ±  8%  interrupts.CPU45.RES:Rescheduling_interrupts
    678.20 ±  4%     -68.9%     211.00 ±  5%  interrupts.CPU45.TLB:TLB_shootdowns
     43.40          +276.2%     163.25 ± 86%  interrupts.CPU46.91:PCI-MSI.1572910-edge.eth0-TxRx-46
    171969 ±  3%     +91.2%     328760        interrupts.CPU46.LOC:Local_timer_interrupts
      2061 ±  3%    +164.1%       5443 ±  5%  interrupts.CPU46.RES:Rescheduling_interrupts
    694.00 ±  8%     -72.3%     192.25 ±  4%  interrupts.CPU46.TLB:TLB_shootdowns
      1967 ±  4%      +8.1%       2127 ±  3%  interrupts.CPU47.CAL:Function_call_interrupts
    172302 ±  3%     +91.1%     329289        interrupts.CPU47.LOC:Local_timer_interrupts
      1985 ±  5%    +156.6%       5093 ± 11%  interrupts.CPU47.RES:Rescheduling_interrupts
    643.80 ±  9%     -71.1%     185.75 ±  3%  interrupts.CPU47.TLB:TLB_shootdowns
    171519 ±  3%     +91.5%     328520        interrupts.CPU48.LOC:Local_timer_interrupts
      1861 ±  5%    +204.6%       5670 ±  7%  interrupts.CPU48.RES:Rescheduling_interrupts
    692.40 ±  4%     -72.8%     188.00 ±  9%  interrupts.CPU48.TLB:TLB_shootdowns
    171497 ±  3%     +91.9%     329135        interrupts.CPU49.LOC:Local_timer_interrupts
      1991 ±  4%    +184.9%       5672 ±  7%  interrupts.CPU49.RES:Rescheduling_interrupts
    643.20 ±  5%     -71.4%     183.75 ± 10%  interrupts.CPU49.TLB:TLB_shootdowns
     47.60 ±  9%    +575.4%     321.50 ±101%  interrupts.CPU5.50:PCI-MSI.1572869-edge.eth0-TxRx-5
      1985 ±  2%     +11.0%       2203 ±  2%  interrupts.CPU5.CAL:Function_call_interrupts
    171461 ±  3%     +92.3%     329697        interrupts.CPU5.LOC:Local_timer_interrupts
      2044 ±  6%    +167.2%       5462 ±  9%  interrupts.CPU5.RES:Rescheduling_interrupts
    682.20           -68.8%     212.75 ±  3%  interrupts.CPU5.TLB:TLB_shootdowns
    172004 ±  3%     +91.0%     328534        interrupts.CPU50.LOC:Local_timer_interrupts
      1969 ±  3%    +180.9%       5531 ±  5%  interrupts.CPU50.RES:Rescheduling_interrupts
    628.60 ±  5%     -67.0%     207.25 ± 13%  interrupts.CPU50.TLB:TLB_shootdowns
    171985 ±  3%     +91.2%     328840        interrupts.CPU51.LOC:Local_timer_interrupts
      1999 ±  3%    +182.4%       5645 ±  8%  interrupts.CPU51.RES:Rescheduling_interrupts
    676.60 ± 10%     -72.9%     183.50 ± 12%  interrupts.CPU51.TLB:TLB_shootdowns
    171798 ±  3%     +91.2%     328535        interrupts.CPU52.LOC:Local_timer_interrupts
      2010 ±  2%    +156.1%       5148 ±  4%  interrupts.CPU52.RES:Rescheduling_interrupts
    652.20 ±  6%     -70.3%     194.00 ± 10%  interrupts.CPU52.TLB:TLB_shootdowns
      2008 ±  2%      +9.9%       2206 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
    172010 ±  3%     +91.7%     329806        interrupts.CPU53.LOC:Local_timer_interrupts
      0.60 ±133%  +1.2e+06%       7093 ± 24%  interrupts.CPU53.NMI:Non-maskable_interrupts
      0.60 ±133%  +1.2e+06%       7093 ± 24%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
      1911 ±  6%    +184.1%       5429 ±  3%  interrupts.CPU53.RES:Rescheduling_interrupts
    706.00 ±  6%     -71.3%     202.75 ± 15%  interrupts.CPU53.TLB:TLB_shootdowns
      1925 ±  8%     +12.1%       2158 ±  3%  interrupts.CPU54.CAL:Function_call_interrupts
    172195 ±  3%     +91.4%     329642        interrupts.CPU54.LOC:Local_timer_interrupts
      2146 ±  3%    +289.7%       8365 ±  9%  interrupts.CPU54.RES:Rescheduling_interrupts
    660.20 ±  2%     -68.3%     209.25 ±  8%  interrupts.CPU54.TLB:TLB_shootdowns
      2012 ±  3%      +8.2%       2176 ±  3%  interrupts.CPU55.CAL:Function_call_interrupts
    171420 ±  3%     +91.5%     328232        interrupts.CPU55.LOC:Local_timer_interrupts
      2005 ±  5%    +199.4%       6005 ±  9%  interrupts.CPU55.RES:Rescheduling_interrupts
    669.20 ±  7%     -67.2%     219.50 ± 22%  interrupts.CPU55.TLB:TLB_shootdowns
    171618 ±  3%     +91.3%     328244        interrupts.CPU56.LOC:Local_timer_interrupts
      1.20 ±200%  +2.3e+05%       2702 ±122%  interrupts.CPU56.NMI:Non-maskable_interrupts
      1.20 ±200%  +2.3e+05%       2702 ±122%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
      2127 ±  5%    +161.2%       5556 ±  4%  interrupts.CPU56.RES:Rescheduling_interrupts
    676.60 ±  6%     -71.5%     192.75 ± 16%  interrupts.CPU56.TLB:TLB_shootdowns
    171609 ±  3%     +91.5%     328586        interrupts.CPU57.LOC:Local_timer_interrupts
      2009 ±  4%    +138.9%       4799 ± 17%  interrupts.CPU57.RES:Rescheduling_interrupts
    680.00 ±  4%     -69.6%     207.00 ±  6%  interrupts.CPU57.TLB:TLB_shootdowns
    171580 ±  3%     +91.7%     328852        interrupts.CPU58.LOC:Local_timer_interrupts
      2011 ±  3%    +143.1%       4889 ± 10%  interrupts.CPU58.RES:Rescheduling_interrupts
    661.80 ±  4%     -69.7%     200.25 ±  6%  interrupts.CPU58.TLB:TLB_shootdowns
    171605 ±  3%     +91.8%     329150        interrupts.CPU59.LOC:Local_timer_interrupts
      2100 ±  6%    +171.1%       5694 ±  7%  interrupts.CPU59.RES:Rescheduling_interrupts
    701.60 ±  3%     -75.3%     173.00 ±  4%  interrupts.CPU59.TLB:TLB_shootdowns
     49.60 ± 14%    +219.1%     158.25 ± 81%  interrupts.CPU6.51:PCI-MSI.1572870-edge.eth0-TxRx-6
    171765 ±  3%     +91.8%     329376        interrupts.CPU6.LOC:Local_timer_interrupts
      2151 ±  6%    +117.4%       4678 ±  7%  interrupts.CPU6.RES:Rescheduling_interrupts
    678.40 ±  9%     -72.3%     187.75 ±  4%  interrupts.CPU6.TLB:TLB_shootdowns
      1987 ±  6%     +10.3%       2192 ±  3%  interrupts.CPU60.CAL:Function_call_interrupts
    171521 ±  3%     +92.2%     329634        interrupts.CPU60.LOC:Local_timer_interrupts
      2116 ±  9%    +170.6%       5725 ±  8%  interrupts.CPU60.RES:Rescheduling_interrupts
    657.80 ± 13%     -55.7%     291.50 ± 57%  interrupts.CPU60.TLB:TLB_shootdowns
    171423 ±  3%     +92.2%     329544        interrupts.CPU61.LOC:Local_timer_interrupts
      2087 ±  7%    +158.1%       5388 ±  5%  interrupts.CPU61.RES:Rescheduling_interrupts
    736.60 ± 19%     -67.1%     242.50 ± 23%  interrupts.CPU61.TLB:TLB_shootdowns
    171380 ±  3%     +92.0%     329093        interrupts.CPU62.LOC:Local_timer_interrupts
      0.20 ±200%  +1.1e+06%       2215 ±155%  interrupts.CPU62.NMI:Non-maskable_interrupts
      0.20 ±200%  +1.1e+06%       2215 ±155%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      2100 ±  7%    +159.6%       5452 ±  5%  interrupts.CPU62.RES:Rescheduling_interrupts
    668.20 ±  7%     -54.8%     302.00 ± 64%  interrupts.CPU62.TLB:TLB_shootdowns
    171838 ±  3%     +91.2%     328565        interrupts.CPU63.LOC:Local_timer_interrupts
      2115 ±  4%    +153.9%       5371 ±  3%  interrupts.CPU63.RES:Rescheduling_interrupts
    682.40 ±  5%     -73.4%     181.25 ±  9%  interrupts.CPU63.TLB:TLB_shootdowns
    171528 ±  3%     +91.9%     329122        interrupts.CPU64.LOC:Local_timer_interrupts
      2026 ±  9%    +147.6%       5016 ±  9%  interrupts.CPU64.RES:Rescheduling_interrupts
    667.00 ±  9%     -71.9%     187.25 ±  9%  interrupts.CPU64.TLB:TLB_shootdowns
    171655 ±  3%     +91.4%     328491        interrupts.CPU65.LOC:Local_timer_interrupts
      0.20 ±200%  +2.5e+06%       5065 ± 66%  interrupts.CPU65.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.5e+06%       5065 ± 66%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      2044 ±  5%    +175.1%       5623 ± 14%  interrupts.CPU65.RES:Rescheduling_interrupts
    685.20 ±  7%     -74.9%     172.00 ± 16%  interrupts.CPU65.TLB:TLB_shootdowns
    171729 ±  3%     +91.7%     329123        interrupts.CPU66.LOC:Local_timer_interrupts
      1986 ±  7%    +167.1%       5305 ±  9%  interrupts.CPU66.RES:Rescheduling_interrupts
    673.00 ±  8%     -73.3%     179.50 ± 15%  interrupts.CPU66.TLB:TLB_shootdowns
    171240 ±  3%     +91.8%     328499        interrupts.CPU67.LOC:Local_timer_interrupts
      2073 ±  6%    +164.2%       5477 ± 12%  interrupts.CPU67.RES:Rescheduling_interrupts
    658.20 ±  6%     -69.9%     198.00 ±  8%  interrupts.CPU67.TLB:TLB_shootdowns
    171501 ±  3%     +91.4%     328314        interrupts.CPU68.LOC:Local_timer_interrupts
      2129 ±  3%    +145.7%       5233 ± 10%  interrupts.CPU68.RES:Rescheduling_interrupts
    679.20 ±  8%     -72.9%     184.00 ± 12%  interrupts.CPU68.TLB:TLB_shootdowns
    171284 ±  3%     +92.0%     328935        interrupts.CPU69.LOC:Local_timer_interrupts
      0.20 ±200%  +2.5e+06%       5067 ± 66%  interrupts.CPU69.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.5e+06%       5067 ± 66%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
      2092 ±  5%    +158.6%       5411 ± 13%  interrupts.CPU69.RES:Rescheduling_interrupts
    657.80 ±  7%     -70.8%     192.25 ± 10%  interrupts.CPU69.TLB:TLB_shootdowns
    171884 ±  3%     +91.5%     329180        interrupts.CPU7.LOC:Local_timer_interrupts
      2175 ±  9%    +145.0%       5330 ±  9%  interrupts.CPU7.RES:Rescheduling_interrupts
    682.60 ±  5%     -72.9%     185.25 ± 13%  interrupts.CPU7.TLB:TLB_shootdowns
    171266 ±  3%     +92.4%     329503        interrupts.CPU70.LOC:Local_timer_interrupts
      2047 ±  8%    +165.3%       5432 ± 17%  interrupts.CPU70.RES:Rescheduling_interrupts
    648.20 ±  3%     -69.3%     199.00 ± 10%  interrupts.CPU70.TLB:TLB_shootdowns
    171903 ±  3%     +91.6%     329336        interrupts.CPU71.LOC:Local_timer_interrupts
      2248 ±  6%    +246.4%       7788 ±  3%  interrupts.CPU71.RES:Rescheduling_interrupts
    639.20 ±  7%     -69.7%     193.50 ± 11%  interrupts.CPU71.TLB:TLB_shootdowns
    171828 ±  3%     +91.1%     328415        interrupts.CPU72.LOC:Local_timer_interrupts
      2133 ±  9%    +192.9%       6247 ±  7%  interrupts.CPU72.RES:Rescheduling_interrupts
    677.20 ±  9%     -72.8%     184.00 ±  5%  interrupts.CPU72.TLB:TLB_shootdowns
    171696 ±  3%     +91.8%     329235        interrupts.CPU73.LOC:Local_timer_interrupts
      2196 ±  4%    +133.1%       5119 ±  3%  interrupts.CPU73.RES:Rescheduling_interrupts
    172062 ±  3%     +90.7%     328094        interrupts.CPU74.LOC:Local_timer_interrupts
      0.20 ±200%  +2.2e+06%       4449 ± 83%  interrupts.CPU74.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.2e+06%       4449 ± 83%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
      2112 ±  4%    +135.9%       4984 ±  4%  interrupts.CPU74.RES:Rescheduling_interrupts
    708.20 ±  7%     -74.8%     178.75 ± 15%  interrupts.CPU74.TLB:TLB_shootdowns
      2023 ±  5%     +10.0%       2225 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
    171521 ±  3%     +91.4%     328313        interrupts.CPU75.LOC:Local_timer_interrupts
      2180 ±  4%    +127.2%       4955 ± 12%  interrupts.CPU75.RES:Rescheduling_interrupts
    650.20 ± 10%     -72.2%     180.75 ± 10%  interrupts.CPU75.TLB:TLB_shootdowns
      1993 ±  5%     +10.5%       2202 ±  2%  interrupts.CPU76.CAL:Function_call_interrupts
    171606 ±  3%     +91.6%     328808        interrupts.CPU76.LOC:Local_timer_interrupts
      2034 ± 13%    +184.6%       5791 ±  9%  interrupts.CPU76.RES:Rescheduling_interrupts
    653.40 ±  8%     -68.7%     204.25 ±  3%  interrupts.CPU76.TLB:TLB_shootdowns
    171579 ±  3%     +91.3%     328271        interrupts.CPU77.LOC:Local_timer_interrupts
      2179 ±  7%    +124.5%       4893 ±  9%  interrupts.CPU77.RES:Rescheduling_interrupts
    663.80 ±  7%     -73.1%     178.50 ± 11%  interrupts.CPU77.TLB:TLB_shootdowns
      2007            +9.6%       2200 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
    171771 ±  3%     +91.1%     328302        interrupts.CPU78.LOC:Local_timer_interrupts
      1.20 ±200%  +5.9e+05%       7108 ± 24%  interrupts.CPU78.NMI:Non-maskable_interrupts
      1.40 ±200%  +5.1e+05%       7108 ± 24%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
      2121 ±  9%    +155.5%       5421 ± 17%  interrupts.CPU78.RES:Rescheduling_interrupts
    674.20 ±  4%     -72.8%     183.25 ± 12%  interrupts.CPU78.TLB:TLB_shootdowns
      2044            +8.5%       2217 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
    171741 ±  3%     +91.2%     328286        interrupts.CPU79.LOC:Local_timer_interrupts
      2182 ±  7%    +136.7%       5165 ±  4%  interrupts.CPU79.RES:Rescheduling_interrupts
    709.60 ±  7%     -76.3%     168.25 ± 10%  interrupts.CPU79.TLB:TLB_shootdowns
     53.40 ± 20%    +116.3%     115.50 ± 41%  interrupts.CPU8.53:PCI-MSI.1572872-edge.eth0-TxRx-8
      2030 ±  6%      +8.2%       2196 ±  3%  interrupts.CPU8.CAL:Function_call_interrupts
    171509 ±  3%     +91.4%     328271        interrupts.CPU8.LOC:Local_timer_interrupts
      2088 ±  9%    +125.3%       4705 ± 13%  interrupts.CPU8.RES:Rescheduling_interrupts
    683.20 ± 10%     -72.2%     189.75 ± 10%  interrupts.CPU8.TLB:TLB_shootdowns
    171476 ±  3%     +92.0%     329280        interrupts.CPU80.LOC:Local_timer_interrupts
      2100 ±  9%    +146.1%       5169 ± 11%  interrupts.CPU80.RES:Rescheduling_interrupts
    700.80 ±  8%     -75.5%     171.75 ± 13%  interrupts.CPU80.TLB:TLB_shootdowns
    171549 ±  3%     +91.2%     328017        interrupts.CPU81.LOC:Local_timer_interrupts
      2042 ±  6%    +163.6%       5383 ± 17%  interrupts.CPU81.RES:Rescheduling_interrupts
    691.60 ± 11%     -75.2%     171.25 ±  7%  interrupts.CPU81.TLB:TLB_shootdowns
    171162 ±  3%     +92.2%     329005        interrupts.CPU82.LOC:Local_timer_interrupts
      2111 ±  9%    +164.5%       5584 ± 10%  interrupts.CPU82.RES:Rescheduling_interrupts
    756.00 ± 22%     -76.0%     181.50 ± 10%  interrupts.CPU82.TLB:TLB_shootdowns
    171599 ±  3%     +91.7%     328905        interrupts.CPU83.LOC:Local_timer_interrupts
      2031 ±  7%    +160.4%       5291 ±  6%  interrupts.CPU83.RES:Rescheduling_interrupts
    692.60 ±  9%     -73.0%     187.25 ±  6%  interrupts.CPU83.TLB:TLB_shootdowns
    171687 ±  3%     +91.9%     329443        interrupts.CPU84.LOC:Local_timer_interrupts
      2065 ± 11%    +161.1%       5391 ± 11%  interrupts.CPU84.RES:Rescheduling_interrupts
    639.00 ±  6%     -68.5%     201.25 ± 17%  interrupts.CPU84.TLB:TLB_shootdowns
    171447 ±  3%     +91.4%     328221        interrupts.CPU85.LOC:Local_timer_interrupts
      2083 ±  8%    +158.1%       5377 ±  7%  interrupts.CPU85.RES:Rescheduling_interrupts
    686.20 ± 13%     -71.7%     194.50 ±  5%  interrupts.CPU85.TLB:TLB_shootdowns
      1969 ±  3%     +10.1%       2168 ±  3%  interrupts.CPU86.CAL:Function_call_interrupts
    171478 ±  3%     +91.3%     328034        interrupts.CPU86.LOC:Local_timer_interrupts
      2018 ±  7%    +154.8%       5143 ±  3%  interrupts.CPU86.RES:Rescheduling_interrupts
    650.40 ±  5%     -69.2%     200.25 ± 10%  interrupts.CPU86.TLB:TLB_shootdowns
    171464 ±  3%     +91.3%     327998        interrupts.CPU87.LOC:Local_timer_interrupts
      1999 ±  7%    +148.3%       4964 ± 16%  interrupts.CPU87.RES:Rescheduling_interrupts
    660.00 ±  8%     -58.9%     271.50 ±  9%  interrupts.CPU87.TLB:TLB_shootdowns
      1995 ±  2%     +11.9%       2234 ±  4%  interrupts.CPU88.CAL:Function_call_interrupts
    171447 ±  3%     +91.4%     328224        interrupts.CPU88.LOC:Local_timer_interrupts
      2028 ±  7%    +142.6%       4921 ±  9%  interrupts.CPU88.RES:Rescheduling_interrupts
    637.40 ±  6%     -53.0%     299.50 ± 11%  interrupts.CPU88.TLB:TLB_shootdowns
    171172 ±  3%     +92.0%     328732        interrupts.CPU89.LOC:Local_timer_interrupts
      2092 ±  9%    +141.7%       5056 ±  5%  interrupts.CPU89.RES:Rescheduling_interrupts
    719.20 ±  6%     -35.6%     463.50 ±  6%  interrupts.CPU89.TLB:TLB_shootdowns
     50.80 ± 12%    +260.2%     183.00 ± 70%  interrupts.CPU9.54:PCI-MSI.1572873-edge.eth0-TxRx-9
    171311 ±  3%     +92.2%     329182        interrupts.CPU9.LOC:Local_timer_interrupts
      0.40 ±200%    +1e+06%       4007 ± 99%  interrupts.CPU9.NMI:Non-maskable_interrupts
      0.40 ±200%    +1e+06%       4007 ± 99%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      2009 ±  8%    +158.4%       5192 ±  7%  interrupts.CPU9.RES:Rescheduling_interrupts
    680.20 ±  4%     -74.4%     174.25 ± 18%  interrupts.CPU9.TLB:TLB_shootdowns
    171203 ±  3%     +91.7%     328225        interrupts.CPU90.LOC:Local_timer_interrupts
      2212 ±  7%    +152.3%       5583 ±  8%  interrupts.CPU90.RES:Rescheduling_interrupts
    680.40 ±  8%     -73.5%     180.25 ±  9%  interrupts.CPU90.TLB:TLB_shootdowns
    171100 ±  3%     +92.4%     329277        interrupts.CPU91.LOC:Local_timer_interrupts
      2120 ±  7%    +183.1%       6001 ±  2%  interrupts.CPU91.RES:Rescheduling_interrupts
    653.40 ±  8%     -72.6%     178.75 ±  6%  interrupts.CPU91.TLB:TLB_shootdowns
    171687 ±  3%     +91.7%     329058        interrupts.CPU92.LOC:Local_timer_interrupts
      2155 ±  5%    +157.7%       5553 ± 11%  interrupts.CPU92.RES:Rescheduling_interrupts
    682.40 ±  3%     -75.4%     168.00 ± 16%  interrupts.CPU92.TLB:TLB_shootdowns
      2033 ±  4%      +5.6%       2148 ±  5%  interrupts.CPU93.CAL:Function_call_interrupts
    171364 ±  3%     +91.6%     328253        interrupts.CPU93.LOC:Local_timer_interrupts
      2149 ±  5%    +147.7%       5324 ±  8%  interrupts.CPU93.RES:Rescheduling_interrupts
    689.00 ±  7%     -72.6%     189.00 ± 17%  interrupts.CPU93.TLB:TLB_shootdowns
      1968 ±  2%     +10.2%       2169 ±  3%  interrupts.CPU94.CAL:Function_call_interrupts
    171238 ±  3%     +91.8%     328419        interrupts.CPU94.LOC:Local_timer_interrupts
      0.20 ±200%  +2.6e+06%       5100 ± 66%  interrupts.CPU94.NMI:Non-maskable_interrupts
      0.20 ±200%  +2.6e+06%       5100 ± 66%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      1997 ±  5%    +152.0%       5032 ±  7%  interrupts.CPU94.RES:Rescheduling_interrupts
    653.00 ± 10%     -71.1%     188.50 ±  7%  interrupts.CPU94.TLB:TLB_shootdowns
      1987 ±  3%      +8.8%       2161        interrupts.CPU95.CAL:Function_call_interrupts
    171216 ±  3%     +92.2%     329084        interrupts.CPU95.LOC:Local_timer_interrupts
      2092 ±  8%    +145.7%       5141 ±  9%  interrupts.CPU95.RES:Rescheduling_interrupts
    655.00 ±  9%     -70.8%     191.25 ±  8%  interrupts.CPU95.TLB:TLB_shootdowns
    171241 ±  3%     +91.8%     328359        interrupts.CPU96.LOC:Local_timer_interrupts
      2107 ±  6%    +152.6%       5324 ± 20%  interrupts.CPU96.RES:Rescheduling_interrupts
    687.00 ± 12%     -70.3%     203.75 ± 16%  interrupts.CPU96.TLB:TLB_shootdowns
    171596 ±  3%     +91.3%     328315        interrupts.CPU97.LOC:Local_timer_interrupts
      0.20 ±200%  +1.5e+06%       2922 ±108%  interrupts.CPU97.NMI:Non-maskable_interrupts
      0.20 ±200%  +1.5e+06%       2922 ±108%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
      2149 ±  7%    +167.0%       5739 ±  4%  interrupts.CPU97.RES:Rescheduling_interrupts
    690.20 ±  8%     -71.3%     197.75 ± 11%  interrupts.CPU97.TLB:TLB_shootdowns
    171654 ±  3%     +91.8%     329183        interrupts.CPU98.LOC:Local_timer_interrupts
      2117 ±  7%    +158.7%       5477 ± 10%  interrupts.CPU98.RES:Rescheduling_interrupts
    679.00 ±  5%     -71.9%     191.00 ± 11%  interrupts.CPU98.TLB:TLB_shootdowns
      1954 ±  5%     +12.9%       2207 ±  4%  interrupts.CPU99.CAL:Function_call_interrupts
    171535 ±  3%     +91.2%     327995        interrupts.CPU99.LOC:Local_timer_interrupts
      2007 ±  8%    +163.4%       5288 ± 11%  interrupts.CPU99.RES:Rescheduling_interrupts
    674.80 ±  5%     -71.9%     189.75 ± 11%  interrupts.CPU99.TLB:TLB_shootdowns
  24711158 ±  3%     +91.5%   47325356        interrupts.LOC:Local_timer_interrupts
     29.20 ± 23%  +1.9e+06%     554928 ±  4%  interrupts.NMI:Non-maskable_interrupts
     29.80 ± 26%  +1.9e+06%     554928 ±  4%  interrupts.PMI:Performance_monitoring_interrupts
    299442 ±  5%    +165.4%     794810        interrupts.RES:Rescheduling_interrupts
     97002 ±  5%     -68.9%      30138 ±  6%  interrupts.TLB:TLB_shootdowns



***************************************************************************************************
lkp-skl-sp2: 40 threads Skylake-SP with 64G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-7/performance/x86_64-rhel-7.6/100%/debian-x86_64-2019-05-14.cgz/300s/lkp-skl-sp2/five_sec/reaim

commit: 
  v5.3-rc8
  c25aa432ff ("Fix the locking in dcache_readdir() and friends")

        v5.3-rc8 c25aa432ff56e179bf5414edff3 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          8:9          -67%           2:4     perf-profile.children.cycles-pp.error_entry
          3:9          -32%           1:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      6.22          +373.3%      29.45        reaim.child_systime
      5.47            -1.9%       5.37        reaim.child_utime
    607359           -59.8%     244321        reaim.jobs_per_min
     15183           -59.8%       6108        reaim.jobs_per_min_child
    625263           -59.8%     251463        reaim.max_jobs_per_min
      0.39          +148.6%       0.97        reaim.parent_time
      2.42           -36.0%       1.55        reaim.std_dev_percent
      0.01           +39.0%       0.01 ±  2%  reaim.std_dev_time
    993328           -31.3%     682701        reaim.time.involuntary_context_switches
 1.506e+08           -19.3%  1.216e+08        reaim.time.minor_page_faults
    485.67          +139.7%       1164        reaim.time.percent_of_cpu_this_job_got
    779.28          +280.9%       2967        reaim.time.system_time
    685.51           -20.9%     542.23        reaim.time.user_time
   1760101           -25.6%    1309188        reaim.time.voluntary_context_switches
    500000           -19.4%     403000        reaim.workload
  88037929 ±112%     -93.4%    5831257 ± 21%  cpuidle.C1.time
     32271            +8.3%      34935 ±  5%  meminfo.Shmem
      2.73 ±141%     +23.4       26.17        mpstat.cpu.all.sys%
     87.00           -19.5%      70.00        vmstat.cpu.id
      6.00           +95.8%      11.75 ±  3%  vmstat.procs.r
     20309           -28.0%      14624        vmstat.system.cs
    430.67 ±  2%    +118.0%     939.00        turbostat.Avg_MHz
     16.60 ±  6%     +15.7       32.33        turbostat.Busy%
      2607 ±  4%     +11.6%       2911        turbostat.Bzy_MHz
      0.72 ±112%      -0.7        0.05 ± 19%  turbostat.C1%
     49.67 ±  3%     +11.7%      55.50 ±  2%  turbostat.PkgTmp
     59.03 ±  3%     +19.9%      70.77 ±  2%  turbostat.PkgWatt
     65464            +1.6%      66497        proc-vmstat.nr_active_anon
      3959            +1.3%       4009        proc-vmstat.nr_inactive_anon
      8064            +8.5%       8746 ±  5%  proc-vmstat.nr_shmem
     14242            +3.9%      14795        proc-vmstat.nr_slab_reclaimable
     30003            +6.6%      31993        proc-vmstat.nr_slab_unreclaimable
     65464            +1.6%      66497        proc-vmstat.nr_zone_active_anon
      3959            +1.3%       4009        proc-vmstat.nr_zone_inactive_anon
 1.449e+08           -19.0%  1.174e+08        proc-vmstat.numa_hit
 1.449e+08           -19.0%  1.174e+08        proc-vmstat.numa_local
     54650           -24.8%      41101 ±  2%  proc-vmstat.pgactivate
 1.488e+08           -18.5%  1.212e+08        proc-vmstat.pgalloc_normal
 1.511e+08           -19.2%  1.221e+08        proc-vmstat.pgfault
 1.487e+08           -18.5%  1.212e+08        proc-vmstat.pgfree
     15530 ±  8%    +183.2%      43987        sched_debug.cfs_rq:/.exec_clock.avg
     19327 ±  9%    +152.4%      48774 ±  2%  sched_debug.cfs_rq:/.exec_clock.max
     15028 ±  9%    +189.0%      43438        sched_debug.cfs_rq:/.exec_clock.min
    519329 ±  8%    +217.5%    1648932        sched_debug.cfs_rq:/.min_vruntime.avg
    592565 ±  8%    +192.3%    1732279        sched_debug.cfs_rq:/.min_vruntime.max
    506055 ±  8%    +220.3%    1620951        sched_debug.cfs_rq:/.min_vruntime.min
     15296 ± 12%     +21.9%      18648 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.31 ±  3%     -15.3%       0.27 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
      7.71 ± 14%     -14.1%       6.62 ±  3%  sched_debug.cfs_rq:/.nr_spread_over.avg
     -8861          +240.5%     -30178        sched_debug.cfs_rq:/.spread0.min
     15298 ± 12%     +21.9%      18650 ±  6%  sched_debug.cfs_rq:/.spread0.stddev
     24364           +30.1%      31710 ±  2%  sched_debug.cpu.curr->pid.max
     75188 ± 10%     -12.9%      65511 ±  3%  sched_debug.cpu.nr_switches.max
     61501 ±  9%     -17.0%      51030        sched_debug.cpu.nr_switches.min
     65.97 ±  8%     -51.8%      31.79 ±  6%  sched_debug.cpu.nr_uninterruptible.max
    -59.04           -52.0%     -28.33        sched_debug.cpu.nr_uninterruptible.min
     29.25 ±  8%     -54.5%      13.30 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     60640 ±  9%     -14.0%      52137        sched_debug.cpu.sched_count.min
     18734 ±  9%     -20.4%      14904        sched_debug.cpu.sched_goidle.avg
     23349 ± 13%     -21.4%      18342 ±  7%  sched_debug.cpu.sched_goidle.max
     17164 ±  8%     -21.6%      13449        sched_debug.cpu.sched_goidle.min
     30357 ± 10%     -14.4%      25976 ±  6%  sched_debug.cpu.ttwu_count.max
     22525 ±  9%     -13.7%      19441        sched_debug.cpu.ttwu_count.min
     12598 ±  9%     -14.6%      10762        sched_debug.cpu.ttwu_local.avg
     11819 ±  9%     -18.3%       9656        sched_debug.cpu.ttwu_local.min
    342.06 ± 10%     +38.8%     474.71 ±  4%  sched_debug.cpu.ttwu_local.stddev
      3224 ±  2%     -24.3%       2442 ±  2%  slabinfo.files_cache.active_objs
      3224 ±  2%     -24.3%       2442 ±  2%  slabinfo.files_cache.num_objs
     12508           +20.1%      15023        slabinfo.filp.active_objs
    406.50           +24.6%     506.50        slabinfo.filp.active_slabs
     13019           +24.6%      16221        slabinfo.filp.num_objs
    406.50           +24.6%     506.50        slabinfo.filp.num_slabs
     47295 ±  2%     +64.3%      77692        slabinfo.kmalloc-32.active_objs
    369.00 ±  2%     +64.4%     606.75        slabinfo.kmalloc-32.active_slabs
     47295 ±  2%     +64.4%      77754        slabinfo.kmalloc-32.num_objs
    369.00 ±  2%     +64.4%     606.75        slabinfo.kmalloc-32.num_slabs
      4124 ±  2%      +9.0%       4494        slabinfo.kmalloc-96.active_objs
      4124 ±  2%      +9.0%       4494        slabinfo.kmalloc-96.num_objs
      2641           -12.1%       2322        slabinfo.mm_struct.active_objs
      2645           -12.2%       2322        slabinfo.mm_struct.num_objs
    471.33 ±  4%     -29.2%     333.75        slabinfo.names_cache.active_objs
    472.00 ±  4%     -29.3%     333.75        slabinfo.names_cache.num_objs
      5122 ±  2%    +171.1%      13884 ±  3%  slabinfo.pid.active_objs
    159.50 ±  2%    +172.1%     434.00 ±  3%  slabinfo.pid.active_slabs
      5122 ±  2%    +171.4%      13902 ±  3%  slabinfo.pid.num_objs
    159.50 ±  2%    +172.1%     434.00 ±  3%  slabinfo.pid.num_slabs
     12356           +11.2%      13737        slabinfo.radix_tree_node.active_objs
     12356           +11.2%      13737        slabinfo.radix_tree_node.num_objs
      4633 ±  3%    +315.9%      19270 ±  5%  slabinfo.task_delay_info.active_objs
     90.33 ±  3%    +318.2%     377.75 ±  5%  slabinfo.task_delay_info.active_slabs
      4633 ±  3%    +316.4%      19293 ±  5%  slabinfo.task_delay_info.num_objs
     90.33 ±  3%    +318.2%     377.75 ±  5%  slabinfo.task_delay_info.num_slabs
      1002 ±  7%     +10.6%       1109 ±  4%  slabinfo.task_group.active_objs
      1002 ±  7%     +10.6%       1109 ±  4%  slabinfo.task_group.num_objs
    718.00           +31.9%     947.00        slabinfo.task_struct.active_objs
    721.33           +31.7%     949.75        slabinfo.task_struct.active_slabs
    721.33           +31.7%     949.75        slabinfo.task_struct.num_objs
    721.33           +31.7%     949.75        slabinfo.task_struct.num_slabs
 1.974e+09            -8.3%   1.81e+09        perf-stat.i.branch-instructions
  44078415 ±  4%     -16.8%   36675887 ±  3%  perf-stat.i.branch-misses
     20487           -28.1%      14738        perf-stat.i.context-switches
      2.28 ± 15%     +43.9%       3.28 ±  9%  perf-stat.i.cpi
 1.681e+10 ±  2%    +121.7%  3.726e+10        perf-stat.i.cpu-cycles
      6790           -11.9%       5981        perf-stat.i.cpu-migrations
      4811 ± 21%    +177.2%      13337 ±  3%  perf-stat.i.cycles-between-cache-misses
   5586501 ±  4%     -22.6%    4326672 ±  3%  perf-stat.i.dTLB-load-misses
 2.216e+09            -8.7%  2.024e+09        perf-stat.i.dTLB-loads
   2256014           -19.4%    1817946        perf-stat.i.dTLB-store-misses
 1.183e+09           -14.1%  1.016e+09        perf-stat.i.dTLB-stores
   2833080 ±  3%     -20.8%    2242853        perf-stat.i.iTLB-load-misses
   3130849 ±  3%     -20.5%    2489584 ±  5%  perf-stat.i.iTLB-loads
 1.274e+10           -12.0%  1.121e+10        perf-stat.i.instructions
      0.57 ±  7%     -43.5%       0.32 ±  9%  perf-stat.i.ipc
    494373           -19.1%     399780        perf-stat.i.minor-faults
    466636           -29.6%     328341        perf-stat.i.node-loads
    420352           -29.1%     297883        perf-stat.i.node-stores
    494372           -19.1%     399779        perf-stat.i.page-faults
      7.85 ± 10%     +27.6%      10.01 ±  6%  perf-stat.overall.MPKI
      2.89 ±  6%      -0.9        1.98 ±  2%  perf-stat.overall.cache-miss-rate%
      1.32 ±  2%    +152.0%       3.33        perf-stat.overall.cpi
      5913 ± 12%    +185.9%      16902 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.25 ±  4%      -0.0        0.21 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.19            -0.0        0.18        perf-stat.overall.dTLB-store-miss-rate%
      4501 ±  3%     +11.0%       4997        perf-stat.overall.instructions-per-iTLB-miss
      0.76 ±  2%     -60.3%       0.30        perf-stat.overall.ipc
   7673336            +9.0%    8364938        perf-stat.overall.path-length
 1.967e+09            -8.3%  1.803e+09        perf-stat.ps.branch-instructions
  43919446 ±  4%     -16.8%   36548681 ±  3%  perf-stat.ps.branch-misses
     20413           -28.0%      14687        perf-stat.ps.context-switches
 1.675e+10 ±  2%    +121.7%  3.713e+10        perf-stat.ps.cpu-cycles
      6765           -11.9%       5961        perf-stat.ps.cpu-migrations
   5566346 ±  4%     -22.5%    4311695 ±  3%  perf-stat.ps.dTLB-load-misses
 2.208e+09            -8.6%  2.017e+09        perf-stat.ps.dTLB-loads
   2247818           -19.4%    1811623        perf-stat.ps.dTLB-store-misses
 1.178e+09           -14.1%  1.013e+09        perf-stat.ps.dTLB-stores
   2822807 ±  3%     -20.8%    2235065        perf-stat.ps.iTLB-load-misses
   3119553 ±  3%     -20.5%    2480966 ±  5%  perf-stat.ps.iTLB-loads
 1.269e+10           -12.0%  1.117e+10        perf-stat.ps.instructions
    492573           -19.1%     398389        perf-stat.ps.minor-faults
    464939           -29.6%     327187        perf-stat.ps.node-loads
    418830           -29.1%     296848        perf-stat.ps.node-stores
    492571           -19.1%     398388        perf-stat.ps.page-faults
 3.837e+12           -12.1%  3.371e+12        perf-stat.total.instructions
     68081 ± 25%     -28.4%      48750 ±  2%  softirqs.CPU0.RCU
     47391 ±  2%     -18.3%      38735 ±  2%  softirqs.CPU0.SCHED
     69788 ± 28%     -28.8%      49655 ±  5%  softirqs.CPU1.RCU
     43805 ±  2%     -18.8%      35583 ±  3%  softirqs.CPU1.SCHED
     68684 ± 28%     -29.2%      48607 ±  2%  softirqs.CPU10.RCU
     43529           -19.8%      34910        softirqs.CPU10.SCHED
     70051 ± 28%     -30.7%      48537        softirqs.CPU11.RCU
     43194 ±  2%     -19.8%      34647        softirqs.CPU11.SCHED
     70700 ± 29%     -32.2%      47929 ±  3%  softirqs.CPU12.RCU
     43385           -20.2%      34627        softirqs.CPU12.SCHED
     69635 ± 29%     -29.6%      49022 ±  2%  softirqs.CPU13.RCU
     43467           -19.9%      34827        softirqs.CPU13.SCHED
     70042 ± 28%     -31.4%      48019        softirqs.CPU14.RCU
     43566           -20.0%      34844        softirqs.CPU14.SCHED
     68615 ± 23%     -30.0%      48004        softirqs.CPU15.RCU
     43551           -20.9%      34444 ±  3%  softirqs.CPU15.SCHED
     68956 ± 29%     -29.5%      48588        softirqs.CPU16.RCU
     43382 ±  2%     -20.0%      34688        softirqs.CPU16.SCHED
     68838 ± 28%     -30.0%      48199 ±  2%  softirqs.CPU17.RCU
     43248 ±  2%     -18.3%      35334        softirqs.CPU17.SCHED
     69832 ± 29%     -31.0%      48185 ±  2%  softirqs.CPU18.RCU
     43565           -19.8%      34933        softirqs.CPU18.SCHED
     70390 ± 27%     -31.5%      48194 ±  2%  softirqs.CPU19.RCU
     43751           -20.1%      34944 ±  2%  softirqs.CPU19.SCHED
     70951 ± 29%     -28.6%      50658 ±  3%  softirqs.CPU2.RCU
     43674           -18.8%      35451        softirqs.CPU2.SCHED
     67017 ± 27%     -30.2%      46799 ±  4%  softirqs.CPU20.RCU
     42724 ±  3%     -20.6%      33921 ±  2%  softirqs.CPU20.SCHED
     69448 ± 26%     -31.5%      47557 ±  5%  softirqs.CPU21.RCU
     42634 ±  3%     -21.2%      33598 ±  4%  softirqs.CPU21.SCHED
     70205 ± 28%     -30.2%      49019 ±  2%  softirqs.CPU22.RCU
     43095 ±  2%     -19.3%      34791 ±  2%  softirqs.CPU22.SCHED
     69650 ± 28%     -29.2%      49278 ±  2%  softirqs.CPU23.RCU
     42709 ±  3%     -19.6%      34357 ±  2%  softirqs.CPU23.SCHED
     70715 ± 27%     -29.4%      49931 ±  6%  softirqs.CPU24.RCU
     43271 ±  2%     -19.9%      34658 ±  2%  softirqs.CPU24.SCHED
     65798 ± 25%     -27.5%      47706 ±  3%  softirqs.CPU25.RCU
     42439 ±  3%     -19.8%      34039 ±  3%  softirqs.CPU25.SCHED
     68709 ± 27%     -29.5%      48407 ±  2%  softirqs.CPU26.RCU
     43611 ±  2%     -20.4%      34702 ±  2%  softirqs.CPU26.SCHED
     68583 ± 28%     -25.3%      51231 ±  4%  softirqs.CPU27.RCU
     42831 ±  3%     -19.2%      34610 ±  2%  softirqs.CPU27.SCHED
     69257 ± 30%     -31.0%      47815        softirqs.CPU28.RCU
     43331 ±  3%     -19.1%      35048 ±  2%  softirqs.CPU28.SCHED
     68505 ± 28%     -27.0%      49994 ±  4%  softirqs.CPU29.RCU
     42800 ±  2%     -19.0%      34662 ±  2%  softirqs.CPU29.SCHED
     69191 ± 27%     -30.3%      48224        softirqs.CPU3.RCU
     43047 ±  2%     -20.8%      34105        softirqs.CPU3.SCHED
     66269 ± 27%     -26.0%      49029        softirqs.CPU30.RCU
     43068 ±  2%     -18.4%      35157 ±  2%  softirqs.CPU30.SCHED
     68479 ± 30%     -29.4%      48317 ±  4%  softirqs.CPU31.RCU
     42535 ±  3%     -20.0%      34042 ±  3%  softirqs.CPU31.SCHED
     68527 ± 29%     -30.6%      47584 ±  2%  softirqs.CPU32.RCU
     43058 ±  3%     -19.8%      34534        softirqs.CPU32.SCHED
     68355 ± 28%     -30.9%      47245        softirqs.CPU33.RCU
     42745 ±  2%     -20.5%      33999 ±  3%  softirqs.CPU33.SCHED
     69529 ± 31%     -30.1%      48614 ±  3%  softirqs.CPU34.RCU
     43083 ±  3%     -20.1%      34412 ±  2%  softirqs.CPU34.SCHED
     65996 ± 23%     -28.6%      47121 ±  2%  softirqs.CPU35.RCU
     42912 ±  3%     -20.1%      34269 ±  3%  softirqs.CPU35.SCHED
     68304 ± 28%     -30.4%      47544 ±  3%  softirqs.CPU36.RCU
     43101 ±  2%     -19.0%      34913        softirqs.CPU36.SCHED
     67046 ± 24%     -27.6%      48512 ±  4%  softirqs.CPU37.RCU
     42931 ±  3%     -19.8%      34441 ±  3%  softirqs.CPU37.SCHED
     70731 ± 26%     -33.0%      47375        softirqs.CPU38.RCU
     43474 ±  2%     -21.1%      34304 ±  2%  softirqs.CPU38.SCHED
     68548 ± 30%     -29.2%      48541        softirqs.CPU39.RCU
     43160 ±  2%     -19.9%      34564 ±  2%  softirqs.CPU39.SCHED
     70726 ± 28%     -30.7%      49022        softirqs.CPU4.RCU
     43819           -19.6%      35235        softirqs.CPU4.SCHED
     67474 ± 23%     -29.6%      47511 ±  2%  softirqs.CPU5.RCU
     43311 ±  2%     -20.0%      34643        softirqs.CPU5.SCHED
     68699 ± 26%     -27.7%      49657 ±  2%  softirqs.CPU6.RCU
     43848           -19.7%      35206        softirqs.CPU6.SCHED
     69590 ± 28%     -28.8%      49566 ±  2%  softirqs.CPU7.RCU
     43520           -19.6%      34972        softirqs.CPU7.SCHED
     70189 ± 29%     -31.2%      48304 ±  3%  softirqs.CPU8.RCU
     43672           -20.0%      34928        softirqs.CPU8.SCHED
     70185 ± 30%     -31.9%      47787 ±  2%  softirqs.CPU9.RCU
     43832           -20.5%      34848        softirqs.CPU9.SCHED
   2760314 ± 28%     -29.7%    1940061        softirqs.RCU
   1734095 ±  2%     -19.8%    1390950 ±  2%  softirqs.SCHED
      9.33 ±195%   +4622.3%     440.75 ±163%  interrupts.55:PCI-MSI.54001685-edge.i40e-eth0-TxRx-20
      4.67 ±186%   +4694.6%     223.75 ±139%  interrupts.73:PCI-MSI.54001703-edge.i40e-eth0-TxRx-38
    275164           -30.0%     192713        interrupts.CAL:Function_call_interrupts
      6828           -30.1%       4774        interrupts.CPU0.CAL:Function_call_interrupts
      1340 ±  4%    +113.5%       2861 ± 12%  interrupts.CPU0.NMI:Non-maskable_interrupts
      1340 ±  4%    +113.5%       2861 ± 12%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      3847 ±  2%     -50.1%       1920        interrupts.CPU0.TLB:TLB_shootdowns
      6896           -28.5%       4927        interrupts.CPU1.CAL:Function_call_interrupts
      1301 ±  7%     +86.9%       2432 ± 22%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1301 ±  7%     +86.9%       2432 ± 22%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      3915           -48.8%       2005 ±  2%  interrupts.CPU1.TLB:TLB_shootdowns
      6886           -30.1%       4812 ±  2%  interrupts.CPU10.CAL:Function_call_interrupts
      1285 ±  5%    +117.8%       2799 ± 12%  interrupts.CPU10.NMI:Non-maskable_interrupts
      1285 ±  5%    +117.8%       2799 ± 12%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      3977 ±  2%     -51.7%       1921 ±  5%  interrupts.CPU10.TLB:TLB_shootdowns
      6901           -29.0%       4898 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
      1317 ±  3%    +111.7%       2788 ± 12%  interrupts.CPU11.NMI:Non-maskable_interrupts
      1317 ±  3%    +111.7%       2788 ± 12%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    614.67 ± 11%     +60.7%     988.00 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
      3961 ±  2%     -49.8%       1987 ±  2%  interrupts.CPU11.TLB:TLB_shootdowns
      6961           -30.5%       4837        interrupts.CPU12.CAL:Function_call_interrupts
      1301 ±  5%    +118.9%       2848 ± 14%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1301 ±  5%    +118.9%       2848 ± 14%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    633.83 ±  5%     +50.4%     953.50 ±  3%  interrupts.CPU12.RES:Rescheduling_interrupts
      4041           -52.3%       1929        interrupts.CPU12.TLB:TLB_shootdowns
      6981 ±  2%     -31.5%       4783 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
      1300 ±  4%    +118.1%       2836 ± 12%  interrupts.CPU13.NMI:Non-maskable_interrupts
      1300 ±  4%    +118.1%       2836 ± 12%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    600.33 ±  8%     +61.0%     966.75 ±  4%  interrupts.CPU13.RES:Rescheduling_interrupts
      4046 ±  3%     -52.7%       1913 ±  2%  interrupts.CPU13.TLB:TLB_shootdowns
      6954           -30.1%       4858        interrupts.CPU14.CAL:Function_call_interrupts
      1295 ±  4%    +117.0%       2810 ± 12%  interrupts.CPU14.NMI:Non-maskable_interrupts
      1295 ±  4%    +117.0%       2810 ± 12%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    588.83 ±  7%     +63.5%     962.50 ±  3%  interrupts.CPU14.RES:Rescheduling_interrupts
      3977 ±  3%     -49.5%       2007 ±  4%  interrupts.CPU14.TLB:TLB_shootdowns
      7004           -30.3%       4882        interrupts.CPU15.CAL:Function_call_interrupts
      1284 ±  3%    +119.4%       2817 ± 12%  interrupts.CPU15.NMI:Non-maskable_interrupts
      1284 ±  3%    +119.4%       2817 ± 12%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    572.83 ±  9%     +62.0%     928.00 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
      4051 ±  2%     -51.7%       1958 ±  3%  interrupts.CPU15.TLB:TLB_shootdowns
      6923           -29.9%       4854        interrupts.CPU16.CAL:Function_call_interrupts
      1288 ±  5%    +120.8%       2844 ± 13%  interrupts.CPU16.NMI:Non-maskable_interrupts
      1288 ±  5%    +120.8%       2844 ± 13%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    573.00 ±  5%     +66.0%     951.25 ±  3%  interrupts.CPU16.RES:Rescheduling_interrupts
      3954           -49.4%       2001 ±  4%  interrupts.CPU16.TLB:TLB_shootdowns
      6922 ±  2%     -29.8%       4857        interrupts.CPU17.CAL:Function_call_interrupts
      1317 ±  9%    +114.5%       2826 ± 12%  interrupts.CPU17.NMI:Non-maskable_interrupts
      1317 ±  9%    +114.5%       2826 ± 12%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    592.17 ±  6%     +67.3%     990.75 ±  7%  interrupts.CPU17.RES:Rescheduling_interrupts
      3995 ±  2%     -50.8%       1967        interrupts.CPU17.TLB:TLB_shootdowns
      6844 ±  2%     -29.5%       4823        interrupts.CPU18.CAL:Function_call_interrupts
      1287 ±  3%    +122.6%       2865 ± 15%  interrupts.CPU18.NMI:Non-maskable_interrupts
      1287 ±  3%    +122.6%       2865 ± 15%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    595.83 ±  8%     +70.9%       1018 ±  9%  interrupts.CPU18.RES:Rescheduling_interrupts
      3936 ±  2%     -50.2%       1961 ±  3%  interrupts.CPU18.TLB:TLB_shootdowns
      6780           -28.2%       4866        interrupts.CPU19.CAL:Function_call_interrupts
      1315 ±  5%    +115.7%       2836 ± 13%  interrupts.CPU19.NMI:Non-maskable_interrupts
      1315 ±  5%    +115.7%       2836 ± 13%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      3863           -48.6%       1986 ±  2%  interrupts.CPU19.TLB:TLB_shootdowns
      6876 ±  2%     -29.9%       4823        interrupts.CPU2.CAL:Function_call_interrupts
      1271 ±  4%     +88.0%       2390 ± 21%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1271 ±  4%     +88.0%       2390 ± 21%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    738.00 ± 26%     +90.7%       1407 ± 15%  interrupts.CPU2.RES:Rescheduling_interrupts
      3983 ±  2%     -51.9%       1917 ±  2%  interrupts.CPU2.TLB:TLB_shootdowns
      9.33 ±195%   +4617.0%     440.25 ±163%  interrupts.CPU20.55:PCI-MSI.54001685-edge.i40e-eth0-TxRx-20
      6804           -30.1%       4753        interrupts.CPU20.CAL:Function_call_interrupts
      1296 ±  4%    +117.4%       2818 ± 13%  interrupts.CPU20.NMI:Non-maskable_interrupts
      1296 ±  4%    +117.4%       2818 ± 13%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    608.00 ± 10%     +58.6%     964.00 ±  9%  interrupts.CPU20.RES:Rescheduling_interrupts
      3906 ±  2%     -52.4%       1857 ±  3%  interrupts.CPU20.TLB:TLB_shootdowns
      6846           -30.5%       4760        interrupts.CPU21.CAL:Function_call_interrupts
      1288 ±  4%    +119.4%       2825 ± 13%  interrupts.CPU21.NMI:Non-maskable_interrupts
      1288 ±  4%    +119.4%       2825 ± 13%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    625.50 ± 13%     +51.4%     946.75 ±  7%  interrupts.CPU21.RES:Rescheduling_interrupts
      3907           -52.2%       1867 ±  4%  interrupts.CPU21.TLB:TLB_shootdowns
      6894           -31.0%       4759 ±  2%  interrupts.CPU22.CAL:Function_call_interrupts
      1268 ±  5%    +121.6%       2810 ± 12%  interrupts.CPU22.NMI:Non-maskable_interrupts
      1268 ±  5%    +121.6%       2810 ± 12%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    646.33 ± 23%     +55.5%       1005 ±  4%  interrupts.CPU22.RES:Rescheduling_interrupts
      4018           -52.7%       1902 ±  4%  interrupts.CPU22.TLB:TLB_shootdowns
      6886 ±  2%     -29.5%       4858        interrupts.CPU23.CAL:Function_call_interrupts
      1306 ±  7%    +114.3%       2799 ± 13%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1306 ±  7%    +114.3%       2799 ± 13%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    615.67 ±  9%     +57.1%     967.00 ±  7%  interrupts.CPU23.RES:Rescheduling_interrupts
      3964 ±  3%     -51.3%       1929 ±  3%  interrupts.CPU23.TLB:TLB_shootdowns
      6843           -32.3%       4630 ±  2%  interrupts.CPU24.CAL:Function_call_interrupts
      1316 ±  6%    +112.7%       2800 ± 13%  interrupts.CPU24.NMI:Non-maskable_interrupts
      1316 ±  6%    +112.7%       2800 ± 13%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    631.00 ±  8%     +48.5%     936.75 ±  7%  interrupts.CPU24.RES:Rescheduling_interrupts
      3875 ±  3%     -53.2%       1815 ±  2%  interrupts.CPU24.TLB:TLB_shootdowns
      6834 ±  2%     -29.3%       4835        interrupts.CPU25.CAL:Function_call_interrupts
      1267 ±  5%    +119.2%       2778 ± 12%  interrupts.CPU25.NMI:Non-maskable_interrupts
      1267 ±  5%    +119.2%       2778 ± 12%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    587.00 ±  6%     +68.1%     986.75 ±  9%  interrupts.CPU25.RES:Rescheduling_interrupts
      3937           -50.9%       1931 ±  2%  interrupts.CPU25.TLB:TLB_shootdowns
      6795 ±  2%     -29.4%       4800        interrupts.CPU26.CAL:Function_call_interrupts
      1320 ± 10%    +111.5%       2793 ± 12%  interrupts.CPU26.NMI:Non-maskable_interrupts
      1320 ± 10%    +111.5%       2793 ± 12%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    590.33 ±  9%     +73.9%       1026 ±  7%  interrupts.CPU26.RES:Rescheduling_interrupts
      6507 ± 91%     -70.9%       1890        interrupts.CPU26.TLB:TLB_shootdowns
      6953           -31.0%       4800        interrupts.CPU27.CAL:Function_call_interrupts
      1272 ±  5%    +119.5%       2792 ± 12%  interrupts.CPU27.NMI:Non-maskable_interrupts
      1272 ±  5%    +119.5%       2792 ± 12%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    575.17 ± 10%     +78.1%       1024 ±  3%  interrupts.CPU27.RES:Rescheduling_interrupts
      4021 ±  2%     -52.7%       1901 ±  2%  interrupts.CPU27.TLB:TLB_shootdowns
      6871           -29.0%       4880        interrupts.CPU28.CAL:Function_call_interrupts
      1289 ±  4%    +118.4%       2817 ± 13%  interrupts.CPU28.NMI:Non-maskable_interrupts
      1289 ±  4%    +118.4%       2817 ± 13%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    578.67 ±  6%     +71.3%     991.50 ± 11%  interrupts.CPU28.RES:Rescheduling_interrupts
      3971           -51.5%       1927 ±  2%  interrupts.CPU28.TLB:TLB_shootdowns
      6874           -30.2%       4796        interrupts.CPU29.CAL:Function_call_interrupts
      1278 ±  5%    +120.0%       2813 ± 13%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1278 ±  5%    +120.0%       2813 ± 13%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    594.17 ± 17%     +71.4%       1018 ±  8%  interrupts.CPU29.RES:Rescheduling_interrupts
      3925 ±  2%     -52.0%       1882 ±  3%  interrupts.CPU29.TLB:TLB_shootdowns
      6892           -30.2%       4809 ±  2%  interrupts.CPU3.CAL:Function_call_interrupts
      1337 ±  9%     +79.1%       2396 ± 21%  interrupts.CPU3.NMI:Non-maskable_interrupts
      1337 ±  9%     +79.1%       2396 ± 21%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    664.17 ± 20%     +44.9%     962.25 ±  5%  interrupts.CPU3.RES:Rescheduling_interrupts
      3932           -50.6%       1944 ±  3%  interrupts.CPU3.TLB:TLB_shootdowns
      6951           -32.3%       4708 ±  2%  interrupts.CPU30.CAL:Function_call_interrupts
      1293 ±  4%    +116.8%       2803 ± 12%  interrupts.CPU30.NMI:Non-maskable_interrupts
      1293 ±  4%    +116.8%       2803 ± 12%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    604.00 ± 13%     +64.3%     992.50 ± 10%  interrupts.CPU30.RES:Rescheduling_interrupts
      3962 ±  2%     -53.9%       1828 ±  2%  interrupts.CPU30.TLB:TLB_shootdowns
      6916           -31.1%       4768        interrupts.CPU31.CAL:Function_call_interrupts
      1293 ±  4%    +116.2%       2796 ± 13%  interrupts.CPU31.NMI:Non-maskable_interrupts
      1293 ±  4%    +116.2%       2796 ± 13%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    614.33 ± 14%     +64.3%       1009 ±  6%  interrupts.CPU31.RES:Rescheduling_interrupts
      3977 ±  2%     -52.9%       1873 ±  3%  interrupts.CPU31.TLB:TLB_shootdowns
      6948 ±  2%     -30.9%       4804 ±  2%  interrupts.CPU32.CAL:Function_call_interrupts
      1273 ±  6%    +120.5%       2807 ± 13%  interrupts.CPU32.NMI:Non-maskable_interrupts
      1273 ±  6%    +120.5%       2807 ± 13%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    600.83 ± 10%     +64.0%     985.50 ±  7%  interrupts.CPU32.RES:Rescheduling_interrupts
      3998           -52.7%       1892 ±  2%  interrupts.CPU32.TLB:TLB_shootdowns
      6910 ±  2%     -30.5%       4802 ±  2%  interrupts.CPU33.CAL:Function_call_interrupts
      1289 ±  3%    +119.7%       2831 ± 13%  interrupts.CPU33.NMI:Non-maskable_interrupts
      1289 ±  3%    +119.7%       2831 ± 13%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    611.17 ± 15%     +65.2%       1009 ±  9%  interrupts.CPU33.RES:Rescheduling_interrupts
      3992 ±  3%     -52.9%       1881 ±  3%  interrupts.CPU33.TLB:TLB_shootdowns
      6870           -30.3%       4790        interrupts.CPU34.CAL:Function_call_interrupts
      1283 ±  4%    +119.1%       2811 ± 13%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1283 ±  4%    +119.1%       2811 ± 13%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    593.67 ± 11%     +58.5%     941.25 ±  8%  interrupts.CPU34.RES:Rescheduling_interrupts
      3919           -50.9%       1926 ±  2%  interrupts.CPU34.TLB:TLB_shootdowns
      6746           -29.3%       4771        interrupts.CPU35.CAL:Function_call_interrupts
      1275 ±  4%    +120.6%       2812 ± 13%  interrupts.CPU35.NMI:Non-maskable_interrupts
      1275 ±  4%    +120.6%       2812 ± 13%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    564.67 ± 10%     +71.6%     969.25 ±  8%  interrupts.CPU35.RES:Rescheduling_interrupts
      3883           -52.3%       1854 ±  4%  interrupts.CPU35.TLB:TLB_shootdowns
      6863           -30.3%       4781 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
      1279 ±  4%    +119.0%       2803 ± 12%  interrupts.CPU36.NMI:Non-maskable_interrupts
      1279 ±  4%    +119.0%       2803 ± 12%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    544.00 ±  7%     +89.2%       1029 ±  3%  interrupts.CPU36.RES:Rescheduling_interrupts
      3942 ±  2%     -51.5%       1913 ±  3%  interrupts.CPU36.TLB:TLB_shootdowns
      6930           -31.1%       4773        interrupts.CPU37.CAL:Function_call_interrupts
      1289 ±  5%    +122.7%       2872 ±  9%  interrupts.CPU37.NMI:Non-maskable_interrupts
      1289 ±  5%    +122.7%       2872 ±  9%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    596.17 ± 11%     +59.5%     951.00 ±  4%  interrupts.CPU37.RES:Rescheduling_interrupts
      4002 ±  2%     -53.0%       1880 ±  2%  interrupts.CPU37.TLB:TLB_shootdowns
      4.33 ±203%   +5057.7%     223.50 ±139%  interrupts.CPU38.73:PCI-MSI.54001703-edge.i40e-eth0-TxRx-38
      6714 ±  2%     -28.7%       4786        interrupts.CPU38.CAL:Function_call_interrupts
      1270 ±  4%    +123.3%       2837 ± 14%  interrupts.CPU38.NMI:Non-maskable_interrupts
      1270 ±  4%    +123.3%       2837 ± 14%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    604.83 ± 14%     +57.9%     955.00 ±  8%  interrupts.CPU38.RES:Rescheduling_interrupts
      3889 ±  2%     -51.5%       1886        interrupts.CPU38.TLB:TLB_shootdowns
      6771           -29.2%       4797        interrupts.CPU39.CAL:Function_call_interrupts
      1283 ±  5%    +119.8%       2821 ± 13%  interrupts.CPU39.NMI:Non-maskable_interrupts
      1283 ±  5%    +119.8%       2821 ± 13%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    602.00 ±  9%     +69.1%       1018 ±  2%  interrupts.CPU39.RES:Rescheduling_interrupts
      3840           -50.3%       1907 ±  3%  interrupts.CPU39.TLB:TLB_shootdowns
      6815           -28.2%       4893        interrupts.CPU4.CAL:Function_call_interrupts
      1310 ±  3%    +116.3%       2835 ± 13%  interrupts.CPU4.NMI:Non-maskable_interrupts
      1310 ±  3%    +116.3%       2835 ± 13%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    616.00 ± 11%     +55.4%     957.00 ±  3%  interrupts.CPU4.RES:Rescheduling_interrupts
      3905 ±  2%     -49.7%       1964 ±  3%  interrupts.CPU4.TLB:TLB_shootdowns
      6865           -29.6%       4831 ±  2%  interrupts.CPU5.CAL:Function_call_interrupts
      1257 ±  5%    +122.9%       2801 ± 13%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1257 ±  5%    +122.9%       2801 ± 13%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      3908 ±  2%     -51.7%       1889 ±  3%  interrupts.CPU5.TLB:TLB_shootdowns
      6892           -29.2%       4879 ±  2%  interrupts.CPU6.CAL:Function_call_interrupts
      1288 ±  6%    +116.4%       2787 ± 12%  interrupts.CPU6.NMI:Non-maskable_interrupts
      1288 ±  6%    +116.4%       2787 ± 12%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
      3925           -49.6%       1979 ±  4%  interrupts.CPU6.TLB:TLB_shootdowns
      6877 ±  2%     -28.7%       4905        interrupts.CPU7.CAL:Function_call_interrupts
      1295 ±  4%     +90.0%       2460 ± 29%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1295 ±  4%     +90.0%       2460 ± 29%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      3975 ±  3%     -50.2%       1979 ±  4%  interrupts.CPU7.TLB:TLB_shootdowns
      6971 ±  2%     -29.6%       4907 ±  2%  interrupts.CPU8.CAL:Function_call_interrupts
      1290 ±  4%    +118.2%       2814 ± 13%  interrupts.CPU8.NMI:Non-maskable_interrupts
      1290 ±  4%    +118.2%       2814 ± 13%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    616.50 ± 10%    +112.8%       1311 ± 30%  interrupts.CPU8.RES:Rescheduling_interrupts
      4013 ±  2%     -50.9%       1972 ±  3%  interrupts.CPU8.TLB:TLB_shootdowns
      6860           -29.6%       4832        interrupts.CPU9.CAL:Function_call_interrupts
      1275 ±  4%    +120.3%       2809 ± 13%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1275 ±  4%    +120.3%       2809 ± 13%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    595.50 ±  7%     +68.8%       1005 ±  9%  interrupts.CPU9.RES:Rescheduling_interrupts
      3940           -51.2%       1924        interrupts.CPU9.TLB:TLB_shootdowns
     51696 ±  4%    +114.9%     111109 ± 12%  interrupts.NMI:Non-maskable_interrupts
     51696 ±  4%    +114.9%     111109 ± 12%  interrupts.PMI:Performance_monitoring_interrupts
     25831 ±  7%     +59.1%      41091 ±  5%  interrupts.RES:Rescheduling_interrupts
    160595 ±  3%     -52.1%      76879        interrupts.TLB:TLB_shootdowns
     29.47 ± 12%     -18.8       10.65 ± 14%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     28.75 ± 12%     -18.4       10.38 ± 14%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     28.75 ± 12%     -18.4       10.38 ± 14%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     28.74 ± 12%     -18.4       10.38 ± 14%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     26.52 ± 12%     -16.9        9.63 ± 13%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     26.22 ± 12%     -16.7        9.54 ± 13%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     22.17 ± 11%     -14.0        8.14 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     11.24 ±  5%      -7.5        3.69 ± 14%  perf-profile.calltrace.cycles-pp.add_short.add_short
      7.25 ±  5%      -5.1        2.15 ± 13%  perf-profile.calltrace.cycles-pp.brk
      7.12 ±  5%      -4.8        2.30 ± 12%  perf-profile.calltrace.cycles-pp.execve
      7.04 ±  5%      -4.8        2.28 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      7.04 ±  5%      -4.8        2.28 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      7.04 ±  5%      -4.8        2.28 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.95 ±  5%      -4.7        2.25 ± 12%  perf-profile.calltrace.cycles-pp.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.47 ±  5%      -3.9        1.56 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      5.43 ±  5%      -3.9        1.55 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      5.48 ±  9%      -3.8        1.69 ± 13%  perf-profile.calltrace.cycles-pp.page_test
      5.08 ±  7%      -3.6        1.51 ±  8%  perf-profile.calltrace.cycles-pp.search_binary_handler.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.07 ±  7%      -3.6        1.51 ±  8%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.__do_execve_file.__x64_sys_execve.do_syscall_64
      5.41 ±  6%      -3.6        1.86 ±  3%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      4.71 ±  4%      -3.4        1.30 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.78 ±  6%      -2.6        1.20 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.78 ±  6%      -2.6        1.20 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.78 ±  6%      -2.6        1.20 ±  2%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.77 ± 19%      -2.5        1.24 ± 30%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      3.65 ±  4%      -2.4        1.30        perf-profile.calltrace.cycles-pp.filldir.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      3.81 ±  7%      -2.3        1.49 ±  9%  perf-profile.calltrace.cycles-pp.page_fault
      3.45 ± 20%      -2.3        1.14 ± 33%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      3.65 ±  7%      -2.2        1.43 ±  9%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
      3.07 ±  6%      -2.2        0.88 ± 14%  perf-profile.calltrace.cycles-pp.page_fault.page_test
      3.05 ±  6%      -2.2        0.88 ± 14%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault.page_test
      3.56 ±  7%      -2.2        1.40 ±  9%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
      2.79 ±  7%      -2.2        0.63 ± 13%  perf-profile.calltrace.cycles-pp.__do_munmap.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.16 ±  7%      -2.2        1.01 ± 12%  perf-profile.calltrace.cycles-pp.kill
      2.94 ±  6%      -2.1        0.84 ± 14%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault.page_test
      2.68 ±  7%      -2.1        0.60 ± 12%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.95 ±  5%      -2.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2.94 ±  5%      -2.0        0.89 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      3.16 ±  7%      -1.9        1.24 ±  9%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      2.35 ± 15%      -1.9        0.49 ± 58%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
      2.72 ±  8%      -1.9        0.86 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
      2.71 ±  8%      -1.9        0.85 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      2.58 ±  6%      -1.8        0.74 ±  8%  perf-profile.calltrace.cycles-pp.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file.__x64_sys_execve
      2.54 ±  5%      -1.8        0.71 ± 14%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.page_test
      2.48 ±  6%      -1.8        0.70 ±  9%  perf-profile.calltrace.cycles-pp.mmput.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file
      2.47 ±  6%      -1.8        0.70 ±  8%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.flush_old_exec.load_elf_binary.search_binary_handler
      1.99 ±  8%      -1.7        0.27 ±100%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__x64_sys_brk.do_syscall_64
      1.97 ±  8%      -1.7        0.27 ±100%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap.__x64_sys_brk
      2.01 ± 17%      -1.5        0.53 ± 62%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.59 ±  3%      -1.3        0.30 ±100%  perf-profile.calltrace.cycles-pp.do_brk_flags.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.58 ±  5%      -1.3        0.30 ±100%  perf-profile.calltrace.cycles-pp.sighandler
      1.54 ±  3%      -1.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.__x64_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.54 ±  3%      -1.3        0.28 ±100%  perf-profile.calltrace.cycles-pp._do_fork.__x64_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.52 ±  5%      -1.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.__libc_fork
      1.89 ±  6%      -1.2        0.69 ±  2%  perf-profile.calltrace.cycles-pp.setlocale
      1.47 ±  8%      -1.1        0.40 ± 58%  perf-profile.calltrace.cycles-pp.filemap_map_pages.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
      0.00            +0.6        0.64 ±  4%  perf-profile.calltrace.cycles-pp.dput.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents
      0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.lockref_get.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents
      0.00            +1.4        1.38 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents
      0.00            +1.4        1.40 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
     13.99 ±  4%     +56.1       70.07 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     13.94 ±  4%     +56.1       70.05 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +61.0       61.00 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00           +61.7       61.66 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents
      4.25 ±  4%     +61.9       66.19 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.24 ±  3%     +62.0       66.19 ±  2%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.14 ±  3%     +62.0       66.13 ±  2%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +63.4       63.37 ±  2%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
     29.48 ± 12%     -18.8       10.65 ± 14%  perf-profile.children.cycles-pp.do_idle
     29.47 ± 12%     -18.8       10.65 ± 14%  perf-profile.children.cycles-pp.secondary_startup_64
     29.47 ± 12%     -18.8       10.65 ± 14%  perf-profile.children.cycles-pp.cpu_startup_entry
     28.75 ± 12%     -18.4       10.38 ± 14%  perf-profile.children.cycles-pp.start_secondary
     27.19 ± 12%     -17.3        9.88 ± 13%  perf-profile.children.cycles-pp.cpuidle_enter
     27.18 ± 12%     -17.3        9.88 ± 13%  perf-profile.children.cycles-pp.cpuidle_enter_state
     22.33 ± 10%     -14.0        8.35 ± 10%  perf-profile.children.cycles-pp.intel_idle
     11.24 ±  5%      -7.5        3.70 ± 14%  perf-profile.children.cycles-pp.add_short
     10.34 ±  6%      -6.8        3.52 ±  3%  perf-profile.children.cycles-pp.page_fault
      9.01 ±  6%      -5.9        3.07 ±  3%  perf-profile.children.cycles-pp.do_page_fault
      8.77 ±  6%      -5.8        2.99 ±  3%  perf-profile.children.cycles-pp.__do_page_fault
      7.91 ±  6%      -5.2        2.68 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      7.31 ±  5%      -5.1        2.17 ± 13%  perf-profile.children.cycles-pp.brk
      7.53 ±  6%      -5.0        2.56 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      7.13 ±  5%      -4.8        2.30 ± 12%  perf-profile.children.cycles-pp.execve
      7.07 ±  5%      -4.6        2.46 ±  5%  perf-profile.children.cycles-pp.__x64_sys_execve
      6.98 ±  5%      -4.5        2.43 ±  5%  perf-profile.children.cycles-pp.__do_execve_file
      6.27 ±  7%      -4.3        1.98 ± 12%  perf-profile.children.cycles-pp.page_test
      5.43 ±  6%      -3.8        1.64 ±  2%  perf-profile.children.cycles-pp.mmput
      5.41 ±  6%      -3.8        1.64 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      5.09 ±  7%      -3.5        1.64        perf-profile.children.cycles-pp.search_binary_handler
      5.07 ±  7%      -3.4        1.63        perf-profile.children.cycles-pp.load_elf_binary
      4.71 ±  4%      -3.3        1.45 ±  2%  perf-profile.children.cycles-pp.__x64_sys_brk
      3.84 ±  7%      -2.9        0.98 ±  3%  perf-profile.children.cycles-pp.__do_munmap
      4.51 ± 16%      -2.8        1.70 ± 23%  perf-profile.children.cycles-pp.apic_timer_interrupt
      3.85 ±  5%      -2.6        1.22 ±  2%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.85 ±  5%      -2.6        1.22 ±  2%  perf-profile.children.cycles-pp.do_group_exit
      3.59 ±  7%      -2.6        0.96 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      3.85 ±  5%      -2.6        1.22 ±  2%  perf-profile.children.cycles-pp.do_exit
      3.55 ±  7%      -2.6        0.95 ±  3%  perf-profile.children.cycles-pp.tlb_flush_mmu
      4.14 ± 17%      -2.6        1.55 ± 24%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      3.39 ±  7%      -2.6        0.84 ±  3%  perf-profile.children.cycles-pp.unmap_region
      3.69 ±  4%      -2.4        1.32        perf-profile.children.cycles-pp.filldir
      3.20 ±  7%      -2.2        1.03 ± 12%  perf-profile.children.cycles-pp.kill
      2.25 ±  6%      -2.0        0.26 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.49 ±  6%      -1.9        0.55 ±  3%  perf-profile.children.cycles-pp.release_pages
      2.81 ±  5%      -1.9        0.92 ±  3%  perf-profile.children.cycles-pp.do_anonymous_page
      2.71 ±  4%      -1.8        0.90 ±  5%  perf-profile.children.cycles-pp.__x64_sys_clone
      2.71 ±  4%      -1.8        0.90 ±  5%  perf-profile.children.cycles-pp._do_fork
      2.58 ±  6%      -1.8        0.79        perf-profile.children.cycles-pp.flush_old_exec
      2.73 ±  7%      -1.8        0.94 ±  5%  perf-profile.children.cycles-pp.filemap_map_pages
      2.65 ±  6%      -1.8        0.88 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      2.53 ±  6%      -1.7        0.84 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      2.45 ±  4%      -1.6        0.80 ±  5%  perf-profile.children.cycles-pp.copy_process
      1.83 ±  5%      -1.5        0.35 ±  7%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      2.41 ± 14%      -1.4        0.97 ± 18%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.97 ±  8%      -1.4        0.60 ±  5%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      2.01 ±  5%      -1.3        0.69 ±  4%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      2.13 ±  7%      -1.3        0.85 ±  3%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      1.81 ±  8%      -1.3        0.54 ±  5%  perf-profile.children.cycles-pp.do_mmap
      1.89 ±  6%      -1.2        0.69 ±  2%  perf-profile.children.cycles-pp.setlocale
      1.75 ±  6%      -1.2        0.57 ±  4%  perf-profile.children.cycles-pp.dup_mm
      1.76 ±  4%      -1.2        0.59 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.59 ±  9%      -1.1        0.45 ±  5%  perf-profile.children.cycles-pp.mmap_region
      1.75 ±  4%      -1.1        0.63 ±  3%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      1.63 ± 17%      -1.1        0.54 ± 26%  perf-profile.children.cycles-pp.menu_select
      1.58 ±  5%      -1.1        0.52 ± 15%  perf-profile.children.cycles-pp.sighandler
      1.68 ±  3%      -1.0        0.64        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.50 ±  6%      -1.0        0.46 ±  5%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.55 ±  5%      -1.0        0.52 ±  3%  perf-profile.children.cycles-pp.__libc_fork
      1.65 ±  3%      -1.0        0.63 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
      1.51 ±  3%      -1.0        0.53 ±  3%  perf-profile.children.cycles-pp.do_signal
      1.49 ±  7%      -0.9        0.56 ±  2%  perf-profile.children.cycles-pp.do_sys_open
      1.42 ±  3%      -0.9        0.50        perf-profile.children.cycles-pp.native_irq_return_iret
      1.11 ±  3%      -0.9        0.18 ±  9%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      1.09 ±  3%      -0.9        0.18 ±  9%  perf-profile.children.cycles-pp.lru_add_drain
      1.53 ± 23%      -0.9        0.64 ± 25%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.36 ± 31%      -0.9        0.47 ± 37%  perf-profile.children.cycles-pp.irq_exit
      1.23 ±  7%      -0.9        0.37 ±  6%  perf-profile.children.cycles-pp.free_pgtables
      1.42 ±  5%      -0.9        0.56 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.30 ±  6%      -0.8        0.46 ±  4%  perf-profile.children.cycles-pp._dl_addr
      1.27 ±  6%      -0.8        0.45 ±  2%  perf-profile.children.cycles-pp.alloc_pages_vma
      1.03 ±  9%      -0.8        0.21 ±  8%  perf-profile.children.cycles-pp.sync
      1.01 ±  9%      -0.8        0.20 ± 10%  perf-profile.children.cycles-pp.__x64_sys_sync
      1.01 ±  9%      -0.8        0.20 ± 10%  perf-profile.children.cycles-pp.ksys_sync
      1.49 ±  7%      -0.8        0.69 ± 19%  perf-profile.children.cycles-pp.do_filp_open
      1.27 ±  9%      -0.8        0.48        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.48 ±  7%      -0.8        0.69 ± 18%  perf-profile.children.cycles-pp.path_openat
      0.95 ±  9%      -0.8        0.18 ± 11%  perf-profile.children.cycles-pp.iterate_supers
      1.22 ± 31%      -0.8        0.46 ± 37%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.08 ±  9%      -0.7        0.35 ± 14%  perf-profile.children.cycles-pp.write
      1.26 ±  7%      -0.7        0.53 ±  3%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      1.05 ±  8%      -0.7        0.33 ± 12%  perf-profile.children.cycles-pp.__vma_adjust
      1.07 ±  4%      -0.7        0.35 ±  4%  perf-profile.children.cycles-pp.prep_new_page
      1.15 ±  8%      -0.7        0.45 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func_common
      1.09 ±  4%      -0.7        0.40 ±  2%  perf-profile.children.cycles-pp.copy_strings
      1.12 ±  8%      -0.7        0.43        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.10 ±  4%      -0.7        0.42        perf-profile.children.cycles-pp.__check_object_size
      0.98 ±  4%      -0.7        0.33 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      1.01 ±  7%      -0.6        0.38 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.88 ± 11%      -0.6        0.26 ±  4%  perf-profile.children.cycles-pp.elf_map
      0.94 ± 11%      -0.6        0.32 ± 14%  perf-profile.children.cycles-pp.ksys_write
      0.87 ±  7%      -0.6        0.26 ± 13%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.91 ±  7%      -0.6        0.30 ±  3%  perf-profile.children.cycles-pp.page_remove_rmap
      0.87 ±  7%      -0.6        0.26 ± 13%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.85 ± 10%      -0.6        0.24 ± 15%  perf-profile.children.cycles-pp.__split_vma
      0.92 ± 11%      -0.6        0.32 ± 14%  perf-profile.children.cycles-pp.vfs_write
      0.86 ±  7%      -0.6        0.26 ± 12%  perf-profile.children.cycles-pp.mprotect_fixup
      0.79 ±  6%      -0.6        0.19 ±  4%  perf-profile.children.cycles-pp.__lru_cache_add
      0.95 ±  3%      -0.6        0.36        perf-profile.children.cycles-pp.perf_event_mmap
      0.89 ±  8%      -0.6        0.32        perf-profile.children.cycles-pp.link_path_walk
      0.87 ± 12%      -0.6        0.30 ± 16%  perf-profile.children.cycles-pp.new_sync_write
      0.86 ± 14%      -0.6        0.30 ±  9%  perf-profile.children.cycles-pp.vprintk_emit
      0.86 ± 12%      -0.5        0.31 ±  9%  perf-profile.children.cycles-pp.console_unlock
      0.75 ±  7%      -0.5        0.25 ±  5%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.80 ±  4%      -0.5        0.30 ±  4%  perf-profile.children.cycles-pp.__sched_text_start
      0.79 ± 14%      -0.5        0.29 ± 10%  perf-profile.children.cycles-pp.serial8250_console_write
      0.78 ± 16%      -0.5        0.28 ± 31%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.77 ±  8%      -0.5        0.27 ±  4%  perf-profile.children.cycles-pp.do_wp_page
      0.71 ±  4%      -0.5        0.22 ± 22%  perf-profile.children.cycles-pp.unlink
      0.57 ± 19%      -0.5        0.08 ± 41%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.80 ±  9%      -0.5        0.32 ±  7%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.79 ±  6%      -0.5        0.31 ±  5%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.88 ± 23%      -0.5        0.39 ± 22%  perf-profile.children.cycles-pp.tick_sched_timer
      0.76 ± 13%      -0.5        0.28 ± 11%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.71 ±  6%      -0.5        0.23 ±  5%  perf-profile.children.cycles-pp.filename_lookup
      0.75 ± 13%      -0.5        0.28 ± 10%  perf-profile.children.cycles-pp.uart_console_write
      0.66 ±  5%      -0.5        0.19 ±  6%  perf-profile.children.cycles-pp.__vm_munmap
      0.70 ±  5%      -0.5        0.23 ±  3%  perf-profile.children.cycles-pp.copy_page_range
      0.65 ± 12%      -0.5        0.18 ±  6%  perf-profile.children.cycles-pp.vma_link
      0.73 ± 13%      -0.5        0.27 ± 10%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.69 ±  6%      -0.5        0.22 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.54 ± 20%      -0.5        0.08 ± 41%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.68 ±  5%      -0.5        0.22        perf-profile.children.cycles-pp.copy_p4d_range
      0.69 ±  5%      -0.5        0.23 ±  4%  perf-profile.children.cycles-pp.mmap64
      0.72 ± 16%      -0.5        0.27 ± 13%  perf-profile.children.cycles-pp.start_kernel
      0.69 ±  9%      -0.4        0.24 ±  4%  perf-profile.children.cycles-pp.wp_page_copy
      0.69 ±  8%      -0.4        0.25 ± 10%  perf-profile.children.cycles-pp.alloc_set_pte
      0.66 ±  4%      -0.4        0.22 ± 10%  perf-profile.children.cycles-pp.__xstat64
      0.76 ±  4%      -0.4        0.32 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      0.70 ±  6%      -0.4        0.27 ±  5%  perf-profile.children.cycles-pp.sync_regs
      0.63 ±  7%      -0.4        0.21 ±  6%  perf-profile.children.cycles-pp.kill_something_info
      0.54 ± 15%      -0.4        0.14 ± 16%  perf-profile.children.cycles-pp.unlink_file_vma
      0.71 ±  7%      -0.4        0.31 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      0.72 ± 28%      -0.4        0.33 ± 26%  perf-profile.children.cycles-pp.tick_sched_handle
      0.58 ±  8%      -0.4        0.19 ±  6%  perf-profile.children.cycles-pp.walk_component
      0.56 ± 21%      -0.4        0.17 ± 25%  perf-profile.children.cycles-pp._fini
      0.56 ± 21%      -0.4        0.17 ± 25%  perf-profile.children.cycles-pp.devkmsg_write
      0.56 ± 21%      -0.4        0.17 ± 25%  perf-profile.children.cycles-pp.devkmsg_emit
      0.61 ± 26%      -0.4        0.22 ± 18%  perf-profile.children.cycles-pp.ktime_get
      0.54 ± 13%      -0.4        0.16 ± 17%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.56 ±  9%      -0.4        0.18 ±  7%  perf-profile.children.cycles-pp.kill_pid_info
      0.60 ± 13%      -0.4        0.22 ± 29%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.57 ± 16%      -0.4        0.21 ± 17%  perf-profile.children.cycles-pp.io_serial_in
      0.56 ±  7%      -0.4        0.19 ±  6%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.55 ±  4%      -0.4        0.18 ±  8%  perf-profile.children.cycles-pp.do_unlinkat
      0.67 ± 25%      -0.4        0.31 ± 26%  perf-profile.children.cycles-pp.update_process_times
      0.56 ± 10%      -0.4        0.20 ±  7%  perf-profile.children.cycles-pp.find_vma
      0.53 ± 10%      -0.4        0.17 ±  8%  perf-profile.children.cycles-pp.__might_fault
      0.54 ± 18%      -0.4        0.19 ± 19%  perf-profile.children.cycles-pp.clockevents_program_event
      0.53 ±  4%      -0.3        0.18 ±  9%  perf-profile.children.cycles-pp.strnlen_user
      0.52 ±  5%      -0.3        0.18 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.52 ±  4%      -0.3        0.18 ±  7%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.61 ±  6%      -0.3        0.28 ± 14%  perf-profile.children.cycles-pp.kthread
      0.49 ±  4%      -0.3        0.16 ±  9%  perf-profile.children.cycles-pp.vfs_statx
      0.47 ±  8%      -0.3        0.14 ± 10%  perf-profile.children.cycles-pp.__send_signal
      0.48 ± 10%      -0.3        0.16 ±  9%  perf-profile.children.cycles-pp.down_write
      0.50 ±  6%      -0.3        0.18 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.49 ± 12%      -0.3        0.17 ±  9%  perf-profile.children.cycles-pp.rcu_core
      0.50 ±  6%      -0.3        0.18 ± 10%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.49 ±  4%      -0.3        0.18 ± 12%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.47 ±  5%      -0.3        0.16 ±  8%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.46 ±  3%      -0.3        0.15 ± 16%  perf-profile.children.cycles-pp.creat
      0.55 ± 30%      -0.3        0.24 ± 21%  perf-profile.children.cycles-pp.load_balance
      0.43 ± 10%      -0.3        0.13 ±  6%  perf-profile.children.cycles-pp.do_send_sig_info
      0.43 ± 10%      -0.3        0.13 ± 19%  perf-profile.children.cycles-pp.link
      0.47 ± 10%      -0.3        0.17 ±  7%  perf-profile.children.cycles-pp.__clear_user
      0.46 ± 18%      -0.3        0.17 ± 28%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.46 ±  6%      -0.3        0.17 ±  4%  perf-profile.children.cycles-pp.security_inode_permission
      0.49 ± 11%      -0.3        0.20 ±  8%  perf-profile.children.cycles-pp.restore_sigcontext
      0.45 ±  7%      -0.3        0.15 ±  5%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.44 ±  7%      -0.3        0.15 ±  5%  perf-profile.children.cycles-pp.kernel_wait4
      0.44 ±  7%      -0.3        0.16 ±  4%  perf-profile.children.cycles-pp.get_unmapped_area
      0.42 ± 11%      -0.3        0.13 ±  8%  perf-profile.children.cycles-pp.anon_vma_fork
      0.43 ± 10%      -0.3        0.15 ±  3%  perf-profile.children.cycles-pp.create_elf_tables
      0.44 ±  6%      -0.3        0.16 ±  4%  perf-profile.children.cycles-pp.selinux_inode_permission
      0.44 ± 15%      -0.3        0.16 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      0.42 ±  9%      -0.3        0.15 ± 14%  perf-profile.children.cycles-pp.pte_alloc_one
      0.42 ±  7%      -0.3        0.15 ±  2%  perf-profile.children.cycles-pp.do_wait
      0.43 ±  7%      -0.3        0.17 ±  3%  perf-profile.children.cycles-pp.schedule
      0.41 ±  7%      -0.3        0.15 ±  4%  perf-profile.children.cycles-pp.fpu__clear
      0.44 ±  7%      -0.3        0.18 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.41 ±  8%      -0.3        0.15 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.44 ±  7%      -0.3        0.19 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_try_charge_delay
      0.40 ±  3%      -0.2        0.16 ±  5%  perf-profile.children.cycles-pp.vma_merge
      0.36 ±  8%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.do_faccessat
      0.36 ± 14%      -0.2        0.12 ± 11%  perf-profile.children.cycles-pp.do_linkat
      0.36 ± 14%      -0.2        0.12 ± 11%  perf-profile.children.cycles-pp.__x64_sys_link
      0.35 ± 10%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.anon_vma_clone
      0.37 ±  8%      -0.2        0.13 ±  5%  perf-profile.children.cycles-pp._copy_from_user
      0.38 ±  8%      -0.2        0.15 ± 11%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.36 ±  4%      -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.37 ±  8%      -0.2        0.13 ±  6%  perf-profile.children.cycles-pp.wait4
      0.37 ± 12%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.40 ± 11%      -0.2        0.16 ±  9%  perf-profile.children.cycles-pp.__fpu__restore_sig
      0.35 ± 15%      -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.34 ±  6%      -0.2        0.12 ±  5%  perf-profile.children.cycles-pp.up_write
      0.35 ± 11%      -0.2        0.14 ±  8%  perf-profile.children.cycles-pp.__might_sleep
      0.32 ± 11%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.get_signal
      0.30 ± 10%      -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.33 ±  5%      -0.2        0.12 ±  9%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.32 ±  8%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.31 ±  9%      -0.2        0.10 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      0.37 ± 21%      -0.2        0.16 ± 28%  perf-profile.children.cycles-pp.irq_work_run_list
      0.33 ±  6%      -0.2        0.12 ±  5%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.29 ±  8%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.down_read
      0.32 ± 22%      -0.2        0.12 ± 31%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.32 ±  9%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.__slab_free
      0.30 ± 11%      -0.2        0.10 ±  7%  perf-profile.children.cycles-pp.unlock_page
      0.31 ±  7%      -0.2        0.11        perf-profile.children.cycles-pp.free_unref_page_list
      0.39 ±  8%      -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.29 ±  6%      -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.__pte_alloc
      0.26 ± 42%      -0.2        0.07 ± 71%  perf-profile.children.cycles-pp.irq_enter
      0.30 ± 14%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.vfs_read
      0.32 ± 12%      -0.2        0.12 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.26 ± 11%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.28 ±  8%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.30 ± 24%      -0.2        0.12 ± 25%  perf-profile.children.cycles-pp.irq_work_run
      0.30 ± 24%      -0.2        0.12 ± 25%  perf-profile.children.cycles-pp.printk
      0.29 ± 11%      -0.2        0.11 ± 14%  perf-profile.children.cycles-pp.native_write_msr
      0.29 ±  7%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.30 ± 24%      -0.2        0.12 ± 24%  perf-profile.children.cycles-pp.irq_work_interrupt
      0.30 ± 24%      -0.2        0.12 ± 24%  perf-profile.children.cycles-pp.smp_irq_work_interrupt
      0.29 ± 11%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.time
      0.29 ± 11%      -0.2        0.12 ± 23%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.27 ± 12%      -0.2        0.09 ±  8%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.28 ±  8%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.__get_user_pages
      0.27 ±  8%      -0.2        0.09 ±  8%  perf-profile.children.cycles-pp.__get_free_pages
      0.29 ±  9%      -0.2        0.12 ±  3%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.27 ± 11%      -0.2        0.10 ± 18%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.27 ±  4%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.strncpy_from_user
      0.24 ±  5%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.remove_vma
      0.28 ± 14%      -0.2        0.12 ±  9%  perf-profile.children.cycles-pp.__x64_sys_rt_sigaction
      0.27 ± 14%      -0.2        0.10 ±  7%  perf-profile.children.cycles-pp.__fput
      0.23 ±  9%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.lookup_slow
      0.24 ± 17%      -0.2        0.08 ± 16%  perf-profile.children.cycles-pp.__lock_text_start
      0.31 ± 32%      -0.2        0.15 ± 20%  perf-profile.children.cycles-pp.find_busiest_group
      0.29 ± 11%      -0.2        0.13 ±  8%  perf-profile.children.cycles-pp._cond_resched
      0.21 ± 43%      -0.2        0.04 ±104%  perf-profile.children.cycles-pp.tick_irq_enter
      0.27 ±  9%      -0.2        0.11        perf-profile.children.cycles-pp.__generic_file_write_iter
      0.29 ±  7%      -0.2        0.13 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
      0.23 ±  7%      -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.25 ±  6%      -0.2        0.10 ±  8%  perf-profile.children.cycles-pp.__fxstat64
      0.22 ± 10%      -0.2        0.07 ± 21%  perf-profile.children.cycles-pp.dequeue_signal
      0.24 ± 12%      -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.do_notify_parent
      0.21 ± 12%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.__sigqueue_alloc
      0.24 ± 11%      -0.2        0.08 ± 27%  perf-profile.children.cycles-pp.find_next_bit
      0.24 ± 13%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.copy_page
      0.23 ± 10%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.enqueue_entity
      0.24 ± 14%      -0.2        0.08 ± 19%  perf-profile.children.cycles-pp.strlen
      0.23 ± 12%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.activate_task
      0.25 ±  9%      -0.1        0.10        perf-profile.children.cycles-pp.__virt_addr_valid
      0.29 ± 31%      -0.1        0.14 ± 18%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.24 ±  6%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.get_user_arg_ptr
      0.24 ±  5%      -0.1        0.09 ± 11%  perf-profile.children.cycles-pp.selinux_vm_enough_memory
      0.21 ±  9%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.sched_exec
      0.25 ± 11%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.generic_perform_write
      0.23 ± 13%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.vmacache_find
      0.23 ± 13%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.18 ± 10%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.__dequeue_signal
      0.20 ± 10%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__waitpid
      0.23 ± 13%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.setup_arg_pages
      0.22 ±  9%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.20 ± 11%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__lookup_slow
      0.21 ±  3%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.filename_parentat
      0.21 ±  9%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.read
      0.21 ±  7%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.alloc_empty_file
      0.21 ±  8%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.change_protection
      0.23 ±  5%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.avc_has_perm_noaudit
      0.20 ±  9%      -0.1        0.07 ± 17%  perf-profile.children.cycles-pp.wake_up_new_task
      0.21 ±  6%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.30 ± 23%      -0.1        0.17 ± 16%  perf-profile.children.cycles-pp.scheduler_tick
      0.21 ±  4%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.path_parentat
      0.19 ±  7%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__pmd_alloc
      0.22 ±  9%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.16 ± 11%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.filename_create
      0.21 ±  7%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.20 ± 15%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.new_sync_read
      0.19 ±  7%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.readdir64
      0.20 ±  8%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.copy_strings_kernel
      0.20 ±  7%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__alloc_file
      0.17 ±  7%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.21 ± 11%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.21 ± 16%      -0.1        0.09 ± 42%  perf-profile.children.cycles-pp.worker_thread
      0.19 ± 11%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.18 ± 18%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__strcasecmp
      0.19 ± 19%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.delay_tsc
      0.18 ± 11%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.18 ± 12%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.mm_init
      0.14 ± 17%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.kernel_read
      0.14 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__set_current_blocked
      0.14 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.vm_area_dup
      0.16 ± 10%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.14 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp._IO_file_open
      0.18 ±  9%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.cred_has_capability
      0.17 ± 11%      -0.1        0.06        perf-profile.children.cycles-pp.vma_compute_subtree_gap
      0.15 ± 12%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.close
      0.18 ± 12%      -0.1        0.07        perf-profile.children.cycles-pp.ptep_clear_flush
      0.15 ±  7%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.signal_wake_up_state
      0.15 ± 25%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.14 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.18 ±  7%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.count
      0.18 ± 11%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.ksys_read
      0.14 ± 11%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__vma_link_rb
      0.17 ± 14%      -0.1        0.06 ± 28%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.14 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.wait_consider_task
      0.15 ± 16%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.mark_page_accessed
      0.17 ± 14%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.security_mmap_addr
      0.16 ± 12%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.19 ± 17%      -0.1        0.09 ± 41%  perf-profile.children.cycles-pp.process_one_work
      0.13 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.vfprintf
      0.13 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.finish_task_switch
      0.14 ± 20%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.open_exec
      0.16 ±  8%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.pgd_alloc
      0.16 ±  8%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.memcpy_erms
      0.15 ± 13%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  5%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.down_write_killable
      0.12 ± 14%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.find_get_entry
      0.14 ±  7%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.inode_permission
      0.14 ± 18%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.__pud_alloc
      0.14 ±  6%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.malloc
      0.13 ± 14%      -0.1        0.04 ±110%  perf-profile.children.cycles-pp.__do_fault
      0.15 ± 13%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.terminate_walk
      0.17 ± 12%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.do_task_dead
      0.14 ± 13%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.12 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.group_send_sig_info
      0.13 ± 13%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.mem_cgroup_throttle_swaprate
      0.13 ± 19%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.__dentry_kill
      0.13 ± 37%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.13 ± 11%      -0.1        0.04 ± 63%  perf-profile.children.cycles-pp.shift_arg_pages
      0.14 ±  4%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__get_user_8
      0.11 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.16 ±  7%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.memset_erms
      0.15 ± 11%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.do_dentry_open
      0.10 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.free_pgd_range
      0.14 ± 15%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.11 ± 22%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.16 ± 12%      -0.1        0.08 ± 15%  perf-profile.children.cycles-pp.update_load_avg
      0.13 ± 13%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.up_read
      0.12 ± 14%      -0.1        0.05        perf-profile.children.cycles-pp.shmem_write_begin
      0.15 ±  9%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.try_charge
      0.10 ± 16%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.complete_walk
      0.09 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.fsnotify
      0.11 ± 20%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.ast_dirty_update
      0.11 ± 20%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.bit_cursor
      0.11 ± 20%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.soft_cursor
      0.10 ± 18%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.memcpy_toio
      0.10 ± 18%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.fb_flashcursor
      0.10 ±  6%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.update_curr
      0.09 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__slab_alloc
      0.11 ± 14%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_all_qs
      0.09 ± 14%      -0.0        0.05        perf-profile.children.cycles-pp.fpstate_init
      0.14 ± 10%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.14 ±  9%      +0.3        0.45 ± 13%  perf-profile.children.cycles-pp.lseek64
      0.11 ± 10%      +0.4        0.50 ±  3%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.40 ±  8%      +0.4        0.80 ±  3%  perf-profile.children.cycles-pp.dput
      0.00            +0.5        0.46 ±  4%  perf-profile.children.cycles-pp.dcache_dir_lseek
      0.00            +0.5        0.46 ±  5%  perf-profile.children.cycles-pp.ksys_lseek
      0.00            +0.9        0.95        perf-profile.children.cycles-pp.lockref_get
     38.17 ±  5%     +39.9       78.05 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     38.05 ±  5%     +40.0       78.00 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      2.47 ±  6%     +60.7       63.21 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.25 ±  4%     +61.9       66.19 ±  2%  perf-profile.children.cycles-pp.__x64_sys_getdents
      4.24 ±  3%     +62.0       66.19 ±  2%  perf-profile.children.cycles-pp.iterate_dir
      4.15 ±  3%     +62.0       66.13 ±  2%  perf-profile.children.cycles-pp.dcache_readdir
      1.43 ±  7%     +62.6       64.00 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00           +63.4       63.37 ±  2%  perf-profile.children.cycles-pp.scan_positives
     22.30 ± 10%     -14.0        8.34 ± 10%  perf-profile.self.cycles-pp.intel_idle
     11.15 ±  5%      -7.5        3.67 ± 14%  perf-profile.self.cycles-pp.add_short
      2.94 ±  7%      -1.8        1.17 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      1.88 ±  4%      -1.2        0.64 ±  2%  perf-profile.self.cycles-pp.filldir
      1.68 ±  6%      -1.1        0.58 ±  5%  perf-profile.self.cycles-pp.filemap_map_pages
      1.54 ±  3%      -1.0        0.59        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.42 ±  3%      -0.9        0.50        perf-profile.self.cycles-pp.native_irq_return_iret
      1.42 ±  6%      -0.9        0.56 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.29 ±  6%      -0.8        0.46 ±  3%  perf-profile.self.cycles-pp._dl_addr
      1.19 ±  5%      -0.8        0.39 ±  6%  perf-profile.self.cycles-pp.unmap_page_range
      1.24 ±  8%      -0.7        0.52 ±  3%  perf-profile.self.cycles-pp.prepare_exit_to_usermode
      1.04 ± 11%      -0.7        0.35 ± 11%  perf-profile.self.cycles-pp.page_test
      1.12 ±  8%      -0.7        0.43        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.98 ±  5%      -0.7        0.32 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      0.85 ±  7%      -0.6        0.25 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.87 ±  8%      -0.6        0.32 ±  3%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.81 ±  7%      -0.5        0.27 ±  5%  perf-profile.self.cycles-pp.page_remove_rmap
      0.70 ± 21%      -0.5        0.20 ± 12%  perf-profile.self.cycles-pp.menu_select
      0.69 ±  6%      -0.4        0.26 ±  5%  perf-profile.self.cycles-pp.sync_regs
      0.71 ±  6%      -0.4        0.29 ±  5%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.69 ±  7%      -0.4        0.30 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      0.52 ±  9%      -0.4        0.14 ±  7%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.57 ± 16%      -0.4        0.21 ± 17%  perf-profile.self.cycles-pp.io_serial_in
      0.52 ±  8%      -0.3        0.18 ±  6%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.46 ± 20%      -0.3        0.15 ± 21%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.44 ±  6%      -0.3        0.15 ±  8%  perf-profile.self.cycles-pp.strnlen_user
      0.40 ± 12%      -0.3        0.14 ±  6%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.41 ± 39%      -0.3        0.14 ± 33%  perf-profile.self.cycles-pp.ktime_get
      0.39 ±  8%      -0.2        0.15 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.38 ±  3%      -0.2        0.14 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.35 ± 14%      -0.2        0.11 ± 13%  perf-profile.self.cycles-pp.down_write
      0.35 ±  8%      -0.2        0.12 ± 10%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.33 ±  9%      -0.2        0.11 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.32 ±  9%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.33 ±  6%      -0.2        0.12 ±  5%  perf-profile.self.cycles-pp.up_write
      0.33 ±  6%      -0.2        0.12 ± 14%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.32 ±  5%      -0.2        0.11 ± 14%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.31 ±  8%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.32 ±  9%      -0.2        0.11 ±  7%  perf-profile.self.cycles-pp.__slab_free
      0.32 ± 10%      -0.2        0.12 ± 10%  perf-profile.self.cycles-pp.__might_sleep
      0.30 ± 16%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.30 ± 10%      -0.2        0.10 ± 12%  perf-profile.self.cycles-pp.find_vma
      0.25 ± 11%      -0.2        0.06 ± 11%  perf-profile.self.cycles-pp.down_read
      0.29 ±  7%      -0.2        0.10 ±  7%  perf-profile.self.cycles-pp.unlock_page
      0.29 ± 11%      -0.2        0.11 ± 14%  perf-profile.self.cycles-pp.native_write_msr
      0.26 ± 10%      -0.2        0.09 ± 12%  perf-profile.self.cycles-pp.copy_p4d_range
      0.26 ±  8%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.handle_mm_fault
      0.29 ± 13%      -0.2        0.12 ±  6%  perf-profile.self.cycles-pp.__fpu__restore_sig
      0.27 ± 10%      -0.2        0.10 ±  5%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.25 ± 10%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.25 ±  7%      -0.2        0.09 ±  9%  perf-profile.self.cycles-pp.selinux_inode_permission
      0.22 ± 10%      -0.2        0.07 ±  6%  perf-profile.self.cycles-pp.fpu__clear
      0.24 ± 11%      -0.2        0.09 ±  7%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.23 ± 12%      -0.2        0.08 ± 10%  perf-profile.self.cycles-pp.copy_page
      0.23 ±  9%      -0.2        0.08 ± 14%  perf-profile.self.cycles-pp.alloc_set_pte
      0.23 ±  6%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.perf_event_mmap
      0.19 ± 14%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.__sigqueue_alloc
      0.22 ± 13%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__do_page_fault
      0.24 ± 10%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.21 ±  8%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.22 ± 15%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.vmacache_find
      0.22 ± 12%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.21 ± 15%      -0.1        0.07 ± 31%  perf-profile.self.cycles-pp.find_next_bit
      0.23 ±  7%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.avc_has_perm_noaudit
      0.21 ±  9%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.18 ±  5%      -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.readdir64
      0.21 ±  6%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.18 ± 17%      -0.1        0.06 ± 59%  perf-profile.self.cycles-pp.strlen
      0.20 ±  6%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.17 ±  7%      -0.1        0.04 ± 59%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.20 ±  6%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.18 ± 15%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.14 ±  9%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__might_fault
      0.19 ± 19%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.delay_tsc
      0.22 ± 26%      -0.1        0.11 ± 18%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.19 ± 10%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.15 ± 20%      -0.1        0.04 ± 60%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.17 ± 10%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.vma_compute_subtree_gap
      0.17 ±  7%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__vma_adjust
      0.18 ± 10%      -0.1        0.07 ± 22%  perf-profile.self.cycles-pp.__lock_text_start
      0.13 ± 10%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.dcache_readdir
      0.15 ± 11%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.do_signal
      0.14 ± 37%      -0.1        0.03 ±105%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.14 ± 17%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.mark_page_accessed
      0.15 ±  8%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.15 ±  9%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.memcpy_erms
      0.15 ± 15%      -0.1        0.05        perf-profile.self.cycles-pp.__list_add_valid
      0.13 ±  9%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.__x64_sys_rt_sigreturn
      0.12 ± 12%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ± 15%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.do_brk_flags
      0.15 ±  6%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.memset_erms
      0.14 ±  4%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.__get_user_8
      0.11 ± 17%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.mem_cgroup_throttle_swaprate
      0.12 ± 16%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.10 ±  6%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.13 ± 13%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.up_read
      0.10 ± 18%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.memcpy_toio
      0.10 ± 12%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.malloc
      0.15 ± 10%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.try_charge
      0.10 ± 19%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp._cond_resched
      0.09 ± 12%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.fsnotify
      0.09 ±  5%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.__x64_sys_brk
      0.04 ± 71%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.dput
      0.00            +0.1        0.13        perf-profile.self.cycles-pp.scan_positives
      0.09 ± 10%      +0.4        0.46 ±  4%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.00            +0.9        0.93        perf-profile.self.cycles-pp.lockref_get
      2.46 ±  6%     +60.5       62.94 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--EWehNWXqjd1oOl26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.3.0-rc8-00001-gc25aa432ff56e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.3.0-rc8 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BD70528 is not set
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--EWehNWXqjd1oOl26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim9'
	export testcase='aim9'
	export category='benchmark'
	export job_origin='/lkp/lkp/.src-20190912-191544/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d03/aim9.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-d03'
	export tbox_group='lkp-ivb-d03'
	export submit_id='5d7ffaa04f89a81f298d3e92'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d03/aim9-performance-dir_rtns_1-300s-ucode=0x21-debian-x86_64-2019-05--20190917-7977-1pbmj9e-3.yaml'
	export id='389ba63e6d7131ef08b5f2a071b4543c367f8170'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=4
	export memory='4G'
	export nr_hdd_partitions=0
	export hdd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export brand='Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz'
	export commit='c25aa432ff56e179bf5414edff3aa430d2b260c0'
	export netconsole_port=6677
	export ucode='0x21'
	export rootfs='debian-x86_64-2019-05-14.cgz'
	export need_kconfig_hw='CONFIG_R8169=y'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2019-09-17 05:12:02 +0800'
	export _id='5d7ffaa24f89a81f298d3e93'
	export _rt='/result/aim9/performance-dir_rtns_1-300s-ucode=0x21/lkp-ivb-d03/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0'
	export user='lkp'
	export head_commit='d65844882d8c1e20687de636497c6257718c3350'
	export base_commit='4d856f72c10ecb060868ed10ff1b1453943fc6c8'
	export branch='linux-devel/devel-hourly-2019091615'
	export result_root='/result/aim9/performance-dir_rtns_1-300s-ucode=0x21/lkp-ivb-d03/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/3'
	export scheduler_version='/lkp/lkp/.src-20190916-231421'
	export LKP_SERVER='inn'
	export max_uptime=2137.32
	export initrd='/osimage/debian/debian-x86_64-2019-05-14.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-d03/aim9-performance-dir_rtns_1-300s-ucode=0x21-debian-x86_64-2019-05--20190917-7977-1pbmj9e-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019091615
commit=c25aa432ff56e179bf5414edff3aa430d2b260c0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/vmlinuz-5.3.0-rc8-00001-gc25aa432ff56e
max_uptime=2137
RESULT_ROOT=/result/aim9/performance-dir_rtns_1-300s-ucode=0x21/lkp-ivb-d03/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/aim9-x86_64-_2019-08-06.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-08-12.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-08-17.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-08-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-08-17.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-09-16.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-git-1_2019-09-06.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/sar-x86_64-ee28e4a-1_2019-09-16.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-08-21.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/vmlinuz-5.3.0-rc8-00001-gc25aa432ff56e'
	export dequeue_time='2019-09-17 05:22:25 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d03/aim9-performance-dir_rtns_1-300s-ucode=0x21-debian-x86_64-2019-05--20190917-7977-1pbmj9e-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test testtime=300 test='dir_rtns_1' $LKP_SRC/tests/wrapper aim9
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper aim9
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time aim9.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--EWehNWXqjd1oOl26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/aim9.yaml
suite: aim9
testcase: aim9
category: benchmark
aim9:
  testtime: 300s
  test: dir_rtns_1
job_origin: "/lkp/lkp/.src-20190912-191544/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d03/aim9.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-ivb-d03
tbox_group: lkp-ivb-d03
submit_id: 5d7ff5e64f89a81ec1a9ea65
job_file: "/lkp/jobs/scheduled/lkp-ivb-d03/aim9-performance-dir_rtns_1-300s-ucode=0x21-debian-x86_64-2019-05-14-20190917-7873-nw0cpn-0.yaml"
id: 1152106797ee19a4c2b1f2fe78a4b52d9d9ee61b
queuer_version: "/lkp-src"
arch: x86_64

#! hosts/lkp-ivb-d03
model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 4G
nr_hdd_partitions: 0
hdd_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz

#! include/category/benchmark
kmsg: 
boot-time: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: c25aa432ff56e179bf5414edff3aa430d2b260c0

#! include/testbox/lkp-ivb-d03
netconsole_port: 6677
ucode: '0x21'
rootfs: debian-x86_64-2019-05-14.cgz
need_kconfig_hw: CONFIG_R8169=y

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2019-09-17 04:51:53.883271834 +08:00
_id: 5d7ff5e64f89a81ec1a9ea65
_rt: "/result/aim9/performance-dir_rtns_1-300s-ucode=0x21/lkp-ivb-d03/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0"

#! schedule options
user: lkp
head_commit: d65844882d8c1e20687de636497c6257718c3350
base_commit: 4d856f72c10ecb060868ed10ff1b1453943fc6c8
branch: linux-devel/devel-hourly-2019091615
result_root: "/result/aim9/performance-dir_rtns_1-300s-ucode=0x21/lkp-ivb-d03/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/0"
scheduler_version: "/lkp/lkp/.src-20190916-231421"
LKP_SERVER: inn
max_uptime: 2137.32
initrd: "/osimage/debian/debian-x86_64-2019-05-14.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-d03/aim9-performance-dir_rtns_1-300s-ucode=0x21-debian-x86_64-2019-05-14-20190917-7873-nw0cpn-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2019091615
- commit=c25aa432ff56e179bf5414edff3aa430d2b260c0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/vmlinuz-5.3.0-rc8-00001-gc25aa432ff56e
- max_uptime=2137
- RESULT_ROOT=/result/aim9/performance-dir_rtns_1-300s-ucode=0x21/lkp-ivb-d03/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/0
- LKP_SERVER=inn
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/aim9-x86_64-_2019-08-06.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-08-12.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-08-17.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-08-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-08-17.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-09-16.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-git-1_2019-09-06.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/sar-x86_64-ee28e4a-1_2019-09-16.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-08-21.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190912-191544/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/c25aa432ff56e179bf5414edff3aa430d2b260c0/vmlinuz-5.3.0-rc8-00001-gc25aa432ff56e"
dequeue_time: 2019-09-17 04:55:45.147163725 +08:00

#! /lkp/lkp/.src-20190916-231421/include/site/inn
job_state: finished
loadavg: 0.85 0.67 0.32 1/136 5048
start_time: '1568667404'
end_time: '1568667704'
version: "/lkp/lkp/.src-20190916-231449"

--EWehNWXqjd1oOl26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done


--EWehNWXqjd1oOl26--
