Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FD821850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfB1EuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:50:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:7621 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfB1EuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:50:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 20:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,422,1544515200"; 
   d="yaml'?scan'208";a="127834669"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2019 20:49:59 -0800
Date:   Thu, 28 Feb 2019 12:50:15 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: [LKP] [rcu]  7e28c5af4e:  will-it-scale.per_process_ops 84.7%
 improvement
Message-ID: <20190228045015.GB10770@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 84.7% improvement of will-it-scale.per_process_ops due to commit:


commit: 7e28c5af4ef6b539334aa5de40feca0c041c94df ("rcu: Eliminate ->rcu_qs_ctr from the rcu_dynticks structure")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: will-it-scale
on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
with following parameters:

	nr_task: 100%
	mode: process
	test: brk1
	cpufreq_governor: performance

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale



Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-7/performance/x86_64-rhel-7.2/process/100%/debian-x86_64-2018-04-03.cgz/lkp-knm01/brk1/will-it-scale

commit: 
  c5bacd9417 ("rcu: Motivate Tiny RCU forward progress")
  7e28c5af4e ("rcu: Eliminate ->rcu_qs_ctr from the rcu_dynticks structure")

c5bacd94173ec49d 7e28c5af4ef6b539334aa5de40 
---------------- -------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     48605           +84.7%      89756 ±  4%  will-it-scale.per_process_ops
  13998509           +84.7%   25850040 ±  4%  will-it-scale.workload
      0.01 ± 63%      -0.0        0.00 ±131%  mpstat.cpu.soft%
     11.86 ±  3%      -1.2       10.65 ±  4%  mpstat.cpu.usr%
    662910           +15.8%     767829 ±  3%  numa-numastat.node0.local_node
    662889           +15.8%     767801 ±  3%  numa-numastat.node0.numa_hit
      2149 ±  4%     -16.9%       1785 ±  2%  vmstat.system.cs
    727237 ±  3%     -14.9%     618668        vmstat.system.in
    284156 ±  4%     +32.5%     376625        numa-meminfo.node0.Active
    283908 ±  4%     +32.6%     376374        numa-meminfo.node0.Active(anon)
    110629 ± 15%     -77.7%      24625 ± 18%  numa-meminfo.node0.Inactive
    110393 ± 15%     -77.9%      24400 ± 19%  numa-meminfo.node0.Inactive(anon)
    284255 ±  4%     +32.5%     376666        meminfo.Active
    284007 ±  4%     +32.5%     376415        meminfo.Active(anon)
    110855 ± 15%     -77.8%      24620 ± 18%  meminfo.Inactive
    110619 ± 15%     -77.9%      24395 ± 19%  meminfo.Inactive(anon)
      8.00 ±173%  +11303.1%     912.25 ± 87%  meminfo.Mlocked
     11072           -15.7%       9338 ±  3%  meminfo.max_used_kB
     71004 ±  4%     +32.6%      94124        numa-vmstat.node0.nr_active_anon
     27812 ± 15%     -78.1%       6100 ± 19%  numa-vmstat.node0.nr_inactive_anon
      1.00 ±173%  +13100.0%     132.00 ± 87%  numa-vmstat.node0.nr_mlock
     71002 ±  4%     +32.6%      94122        numa-vmstat.node0.nr_zone_active_anon
     27811 ± 15%     -78.1%       6100 ± 19%  numa-vmstat.node0.nr_zone_inactive_anon
      1.00 ±173%   +9450.0%      95.50 ± 87%  numa-vmstat.node1.nr_mlock
     70939 ±  4%     +32.8%      94186        proc-vmstat.nr_active_anon
     27523 ± 15%     -77.8%       6101 ± 19%  proc-vmstat.nr_inactive_anon
      2.25 ±173%  +10044.4%     228.25 ± 86%  proc-vmstat.nr_mlock
     70939 ±  4%     +32.8%      94186        proc-vmstat.nr_zone_active_anon
     27523 ± 15%     -77.8%       6101 ± 19%  proc-vmstat.nr_zone_inactive_anon
    680060           +15.8%     787707 ±  2%  proc-vmstat.numa_hit
    680060           +15.8%     787707 ±  2%  proc-vmstat.numa_local
    140509 ± 10%     -45.3%      76820 ± 24%  proc-vmstat.numa_pte_updates
    895.50 ± 30%    +480.0%       5193 ± 36%  proc-vmstat.pgactivate
    774283           +13.9%     882060 ±  3%  proc-vmstat.pgalloc_normal
    653457           +21.9%     796258 ±  3%  proc-vmstat.pgfault
    610954 ±  2%     +32.4%     808662 ±  3%  proc-vmstat.pgfree
      5299 ±  6%    +106.4%      10939 ± 36%  softirqs.CPU10.RCU
    106293 ±  5%     +28.2%     136274 ± 15%  softirqs.CPU126.TIMER
    108234 ±  6%     +26.3%     136696 ± 15%  softirqs.CPU127.TIMER
    109747 ±  7%     +26.4%     138696 ± 11%  softirqs.CPU135.TIMER
    111732 ±  8%     +24.4%     138967 ± 11%  softirqs.CPU138.TIMER
    107031 ±  8%     +26.7%     135558 ± 14%  softirqs.CPU148.TIMER
    100841           +23.1%     124155 ± 15%  softirqs.CPU15.TIMER
    104640 ±  4%     +27.8%     133719 ± 16%  softirqs.CPU172.TIMER
    103142 ±  3%     +30.9%     135023 ± 13%  softirqs.CPU190.TIMER
    106698 ± 10%     +27.5%     136023 ± 13%  softirqs.CPU197.TIMER
    110268 ±  2%     +22.5%     135052 ± 12%  softirqs.CPU205.TIMER
    106111 ±  8%     +23.9%     131436 ± 14%  softirqs.CPU206.TIMER
    106894 ±  6%     +28.7%     137574 ± 14%  softirqs.CPU213.TIMER
    108418 ±  8%     +28.3%     139100 ± 12%  softirqs.CPU214.TIMER
    100170 ± 10%     +32.8%     132978 ± 15%  softirqs.CPU215.TIMER
    100836 ±  2%     +30.3%     131406 ± 17%  softirqs.CPU217.TIMER
    112497 ±  8%     +22.9%     138291 ± 13%  softirqs.CPU219.TIMER
    108669 ± 10%     +22.1%     132720 ± 15%  softirqs.CPU220.TIMER
    108584 ±  8%     +25.5%     136230 ± 13%  softirqs.CPU227.TIMER
    106251 ±  6%     +28.6%     136686 ± 11%  softirqs.CPU236.TIMER
    105296 ±  7%     +31.3%     138251 ± 12%  softirqs.CPU238.TIMER
      3915 ±  8%     +77.4%       6945 ± 30%  softirqs.CPU249.RCU
    101465 ±  2%     +26.5%     128388 ± 19%  softirqs.CPU271.TIMER
    104242 ±  8%     +23.7%     128907 ± 17%  softirqs.CPU70.TIMER
    107020 ±  7%     +26.9%     135845 ± 13%  softirqs.CPU92.TIMER
 9.659e+09 ± 10%     +16.3%  1.124e+10 ±  3%  perf-stat.i.branch-instructions
      6.69            +1.0        7.69 ±  2%  perf-stat.i.branch-miss-rate%
 6.443e+08 ± 10%     +33.3%   8.59e+08 ±  2%  perf-stat.i.branch-misses
      4.10 ±  6%      +0.9        5.04 ± 10%  perf-stat.i.cache-miss-rate%
  67464898 ± 10%     +25.2%   84491315 ±  4%  perf-stat.i.cache-misses
      2820 ± 13%     -32.4%       1906 ±  3%  perf-stat.i.context-switches
     15.34           -37.0%       9.67 ±  3%  perf-stat.i.cpi
 7.067e+11 ± 11%     -30.2%  4.932e+11 ±  4%  perf-stat.i.cpu-cycles
     71.93 ± 10%     -41.9%      41.79 ±  9%  perf-stat.i.cpu-migrations
      2.36            -0.0        2.33        perf-stat.i.iTLB-load-miss-rate%
 1.106e+09 ± 10%     +15.1%  1.273e+09 ±  2%  perf-stat.i.iTLB-load-misses
 4.569e+10 ± 10%     +17.0%  5.345e+10 ±  3%  perf-stat.i.iTLB-loads
 4.621e+10 ± 10%     +16.1%  5.364e+10 ±  3%  perf-stat.i.instructions
      0.07           +64.1%       0.11 ±  3%  perf-stat.i.ipc
      3524 ± 11%     -18.3%       2878        perf-stat.i.minor-faults
    993359 ± 11%     -32.0%     675215 ±  2%  perf-stat.i.msec
      3529 ± 11%     -18.5%       2878        perf-stat.i.page-faults
      6.67            +1.0        7.65        perf-stat.overall.branch-miss-rate%
      3.91            +0.6        4.54 ±  3%  perf-stat.overall.cache-miss-rate%
     15.28           -39.8%       9.20 ±  3%  perf-stat.overall.cpi
      2.36            -0.0        2.33        perf-stat.overall.iTLB-load-miss-rate%
     41.78            +0.9%      42.13        perf-stat.overall.instructions-per-iTLB-miss
      0.07           +66.4%       0.11 ±  3%  perf-stat.overall.ipc
    580565            -5.5%     548645        perf-stat.overall.path-length
 1.699e+12           +74.9%  2.971e+12 ±  4%  perf-stat.total.branch-instructions
 1.133e+11          +100.6%  2.272e+11 ±  5%  perf-stat.total.branch-misses
 1.186e+10           +88.0%   2.23e+10        perf-stat.total.cache-misses
 3.032e+11           +62.2%  4.918e+11 ±  2%  perf-stat.total.cache-references
 1.242e+14            +4.8%  1.302e+14        perf-stat.total.cpu-cycles
     12654           -13.0%      11014 ±  5%  perf-stat.total.cpu-migrations
 1.945e+11           +73.0%  3.365e+11 ±  3%  perf-stat.total.iTLB-load-misses
 8.038e+12           +75.8%  1.413e+13 ±  4%  perf-stat.total.iTLB-loads
 8.127e+12           +74.5%  1.418e+13 ±  4%  perf-stat.total.instructions
    619183           +22.9%     760791 ±  3%  perf-stat.total.minor-faults
    620031           +22.7%     760750 ±  3%  perf-stat.total.page-faults
  23472574 ± 28%     -50.0%   11736977 ± 60%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1380731 ± 28%     -46.9%     733243 ± 66%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    109109           +17.1%     127734        sched_debug.cfs_rq:/.exec_clock.avg
    115740           +12.4%     130080        sched_debug.cfs_rq:/.exec_clock.max
      4252 ±  4%     -50.4%       2110 ± 36%  sched_debug.cfs_rq:/.exec_clock.stddev
      6243 ± 12%     -14.0%       5369 ± 15%  sched_debug.cfs_rq:/.load.avg
    887713 ± 24%     -30.6%     616115 ± 43%  sched_debug.cfs_rq:/.load.max
     53788 ± 23%     -30.4%      37427 ± 40%  sched_debug.cfs_rq:/.load.stddev
  23472574 ± 28%     -50.0%   11736977 ± 60%  sched_debug.cfs_rq:/.max_vruntime.max
   1380731 ± 28%     -46.9%     733243 ± 66%  sched_debug.cfs_rq:/.max_vruntime.stddev
  36862110           +17.8%   43411425        sched_debug.cfs_rq:/.min_vruntime.avg
  39448691           +12.5%   44387703        sched_debug.cfs_rq:/.min_vruntime.max
   1668979 ±  3%     -45.0%     917652 ± 30%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.38 ±  9%      -9.1%       1.25 ±  6%  sched_debug.cfs_rq:/.nr_running.max
      0.56 ± 19%     +42.2%       0.80        sched_debug.cfs_rq:/.nr_running.min
      0.07 ± 13%     -32.7%       0.05 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
      2.25 ±  3%     -51.5%       1.09 ±  2%  sched_debug.cfs_rq:/.nr_spread_over.avg
      6235 ± 12%     -14.0%       5361 ± 16%  sched_debug.cfs_rq:/.runnable_weight.avg
    887713 ± 24%     -30.6%     616088 ± 43%  sched_debug.cfs_rq:/.runnable_weight.max
     53791 ± 23%     -30.4%      37423 ± 40%  sched_debug.cfs_rq:/.runnable_weight.stddev
    513480 ± 46%     -68.1%     163689 ± 16%  sched_debug.cfs_rq:/.spread0.avg
    992070 ± 25%     -55.6%     440313 ±  8%  sched_debug.cfs_rq:/.spread0.max
    271.31 ± 25%     +54.1%     418.15 ± 23%  sched_debug.cfs_rq:/.util_avg.min
     71.69 ±  6%     -14.9%      61.03 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    638.86           +18.5%     756.85 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    131.07 ±  2%     -17.0%     108.78 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1617727 ±  4%     -24.5%    1222141 ± 11%  sched_debug.cpu.avg_idle.avg
    167800 ±  2%     +13.3%     190124 ±  4%  sched_debug.cpu.clock.avg
    174380           +10.3%     192313 ±  4%  sched_debug.cpu.clock.max
    161230 ±  2%     +16.5%     187888 ±  4%  sched_debug.cpu.clock.min
      3797 ±  4%     -66.4%       1276 ±  8%  sched_debug.cpu.clock.stddev
    167800 ±  2%     +13.3%     190124 ±  4%  sched_debug.cpu.clock_task.avg
    174380           +10.3%     192313 ±  4%  sched_debug.cpu.clock_task.max
    161230 ±  2%     +16.5%     187888 ±  4%  sched_debug.cpu.clock_task.min
      3797 ±  4%     -66.4%       1276 ±  8%  sched_debug.cpu.clock_task.stddev
      5416 ±  2%     +15.6%       6262 ±  5%  sched_debug.cpu.curr->pid.max
      2045 ± 18%     +20.6%       2466 ±  3%  sched_debug.cpu.curr->pid.min
    892728 ±  7%     -37.5%     557989 ±  5%  sched_debug.cpu.max_idle_balance_cost.avg
   4113479 ± 18%     -51.6%    1989769 ± 36%  sched_debug.cpu.max_idle_balance_cost.max
    461057 ± 17%     -67.6%     149491 ± 36%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  4%     -65.8%       0.00 ± 23%  sched_debug.cpu.next_balance.stddev
    117031           +16.4%     136279        sched_debug.cpu.nr_load_updates.avg
    139472 ±  3%     +16.0%     161763 ±  4%  sched_debug.cpu.nr_load_updates.max
    109218           +22.1%     133390        sched_debug.cpu.nr_load_updates.min
      3910 ±  3%     -46.0%       2111 ± 19%  sched_debug.cpu.nr_load_updates.stddev
      0.16 ±  4%     -19.4%       0.13 ±  3%  sched_debug.cpu.nr_running.stddev
      1108           +12.5%       1247 ±  2%  sched_debug.cpu.nr_switches.avg
     26767 ± 16%     +60.1%      42860 ± 15%  sched_debug.cpu.nr_switches.max
      2342 ±  4%     +34.2%       3144 ±  7%  sched_debug.cpu.nr_switches.stddev
     29066 ± 11%     +83.5%      53341 ± 36%  sched_debug.cpu.sched_count.max
      2473 ±  2%     +61.3%       3988 ± 33%  sched_debug.cpu.sched_count.stddev
    275.25 ±  3%     +33.5%     367.54        sched_debug.cpu.ttwu_count.avg
     10910 ± 17%     +67.3%      18254 ± 13%  sched_debug.cpu.ttwu_count.max
     50.31 ±  2%     +19.9%      60.30 ±  2%  sched_debug.cpu.ttwu_count.min
    832.06 ± 10%     +46.1%       1215 ±  7%  sched_debug.cpu.ttwu_count.stddev
    176.33           +42.8%     251.81 ±  2%  sched_debug.cpu.ttwu_local.avg
     10535 ± 18%     +69.7%      17877 ± 14%  sched_debug.cpu.ttwu_local.max
     31.56           +15.2%      36.35        sched_debug.cpu.ttwu_local.min
    729.04 ± 13%     +57.2%       1146 ±  9%  sched_debug.cpu.ttwu_local.stddev
    161164 ±  2%     +16.6%     187864 ±  4%  sched_debug.cpu_clk
    160513 ±  2%     +16.6%     187213 ±  4%  sched_debug.ktime
      1.31 ± 24%     +39.1%       1.82        sched_debug.rt_rq:/.rt_runtime.stddev
    161891 ±  2%     +16.3%     188213 ±  4%  sched_debug.sched_clk
    745.75 ± 61%     -87.9%      90.25 ±173%  interrupts.36:IR-PCI-MSI.2621442-edge.eth1-TxRx-1
    961.75 ± 48%     -75.5%     235.25 ±173%  interrupts.37:IR-PCI-MSI.2621443-edge.eth1-TxRx-2
      4649 ± 16%     -25.2%       3475 ±  3%  interrupts.CPU100.NMI:Non-maskable_interrupts
      4649 ± 16%     -25.2%       3475 ±  3%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     30.50 ± 17%    +277.9%     115.25 ± 49%  interrupts.CPU109.RES:Rescheduling_interrupts
    552027 ±  5%     +12.2%     619466 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
    274.50 ± 59%     -44.9%     151.25 ± 92%  interrupts.CPU116.RES:Rescheduling_interrupts
     37.50 ± 47%    +323.3%     158.75 ± 43%  interrupts.CPU121.RES:Rescheduling_interrupts
      7275 ± 12%     -45.9%       3937 ± 25%  interrupts.CPU125.NMI:Non-maskable_interrupts
      7275 ± 12%     -45.9%       3937 ± 25%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      5151 ± 34%     -32.6%       3470 ±  6%  interrupts.CPU140.NMI:Non-maskable_interrupts
      5151 ± 34%     -32.6%       3470 ±  6%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
      5589 ± 28%     -26.0%       4134 ± 32%  interrupts.CPU153.NMI:Non-maskable_interrupts
      5589 ± 28%     -26.0%       4134 ± 32%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    745.75 ± 61%     -87.9%      90.25 ±173%  interrupts.CPU16.36:IR-PCI-MSI.2621442-edge.eth1-TxRx-1
    961.75 ± 48%     -75.5%     235.25 ±173%  interrupts.CPU17.37:IR-PCI-MSI.2621443-edge.eth1-TxRx-2
      6606 ± 25%     -38.6%       4057 ± 27%  interrupts.CPU171.NMI:Non-maskable_interrupts
      6606 ± 25%     -38.6%       4057 ± 27%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      5916 ± 21%     -28.9%       4205 ± 28%  interrupts.CPU172.NMI:Non-maskable_interrupts
      5916 ± 21%     -28.9%       4205 ± 28%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
     85.50 ± 36%     -79.2%      17.75 ± 72%  interrupts.CPU176.RES:Rescheduling_interrupts
     74.00 ± 79%     -79.1%      15.50 ± 27%  interrupts.CPU177.RES:Rescheduling_interrupts
      6513 ± 21%     -36.4%       4139 ± 24%  interrupts.CPU180.NMI:Non-maskable_interrupts
      6513 ± 21%     -36.4%       4139 ± 24%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
     17.50 ± 32%    +371.4%      82.50 ±101%  interrupts.CPU181.RES:Rescheduling_interrupts
     41.00 ±101%    +232.9%     136.50 ± 79%  interrupts.CPU183.RES:Rescheduling_interrupts
      5998 ± 31%     -29.3%       4238 ± 18%  interrupts.CPU192.NMI:Non-maskable_interrupts
      5998 ± 31%     -29.3%       4238 ± 18%  interrupts.CPU192.PMI:Performance_monitoring_interrupts
      5812 ± 21%     -40.6%       3450 ±  4%  interrupts.CPU198.NMI:Non-maskable_interrupts
      5812 ± 21%     -40.6%       3450 ±  4%  interrupts.CPU198.PMI:Performance_monitoring_interrupts
      5605 ± 22%     -27.0%       4093 ± 26%  interrupts.CPU200.NMI:Non-maskable_interrupts
      5605 ± 22%     -27.0%       4093 ± 26%  interrupts.CPU200.PMI:Performance_monitoring_interrupts
      5528 ± 27%     -38.1%       3423 ±  2%  interrupts.CPU212.NMI:Non-maskable_interrupts
      5528 ± 27%     -38.1%       3423 ±  2%  interrupts.CPU212.PMI:Performance_monitoring_interrupts
      6447 ± 27%     -31.2%       4433 ± 39%  interrupts.CPU216.NMI:Non-maskable_interrupts
      6447 ± 27%     -31.2%       4433 ± 39%  interrupts.CPU216.PMI:Performance_monitoring_interrupts
    561218 ±  5%     +10.4%     619618 ±  2%  interrupts.CPU220.LOC:Local_timer_interrupts
    201.00 ±134%     -85.0%      30.25 ± 53%  interrupts.CPU228.RES:Rescheduling_interrupts
      5757 ± 22%     -35.4%       3719 ±  4%  interrupts.CPU229.NMI:Non-maskable_interrupts
      5757 ± 22%     -35.4%       3719 ±  4%  interrupts.CPU229.PMI:Performance_monitoring_interrupts
    165.75 ± 46%     -70.6%      48.75 ±103%  interrupts.CPU230.RES:Rescheduling_interrupts
     23.75 ± 38%    +346.3%     106.00 ± 87%  interrupts.CPU236.RES:Rescheduling_interrupts
      4576 ± 15%     -26.0%       3385 ±  3%  interrupts.CPU248.NMI:Non-maskable_interrupts
      4576 ± 15%     -26.0%       3385 ±  3%  interrupts.CPU248.PMI:Performance_monitoring_interrupts
    606.75 ±140%     -92.7%      44.00 ± 69%  interrupts.CPU252.RES:Rescheduling_interrupts
     80.00 ± 62%     -67.5%      26.00 ± 30%  interrupts.CPU256.RES:Rescheduling_interrupts
      5696 ± 30%     -26.9%       4164 ± 26%  interrupts.CPU259.NMI:Non-maskable_interrupts
      5696 ± 30%     -26.9%       4164 ± 26%  interrupts.CPU259.PMI:Performance_monitoring_interrupts
      1796 ± 99%     -76.2%     428.00 ± 45%  interrupts.CPU26.RES:Rescheduling_interrupts
    109.50 ± 70%     -66.0%      37.25 ± 55%  interrupts.CPU266.RES:Rescheduling_interrupts
    143.00 ± 38%     -69.1%      44.25 ± 90%  interrupts.CPU271.RES:Rescheduling_interrupts
      5526 ± 29%     -34.5%       3619        interrupts.CPU278.NMI:Non-maskable_interrupts
      5526 ± 29%     -34.5%       3619        interrupts.CPU278.PMI:Performance_monitoring_interrupts
     94.75 ± 42%     -55.1%      42.50 ± 64%  interrupts.CPU278.RES:Rescheduling_interrupts
      6671 ± 19%     -31.4%       4579 ± 31%  interrupts.CPU281.NMI:Non-maskable_interrupts
      6671 ± 19%     -31.4%       4579 ± 31%  interrupts.CPU281.PMI:Performance_monitoring_interrupts
      7140 ± 25%     -45.1%       3917 ±  2%  interrupts.CPU37.NMI:Non-maskable_interrupts
      7140 ± 25%     -45.1%       3917 ±  2%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      6176 ± 29%     -37.9%       3834 ±  3%  interrupts.CPU38.NMI:Non-maskable_interrupts
      6176 ± 29%     -37.9%       3834 ±  3%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    968.50 ±109%     -75.0%     241.75 ± 42%  interrupts.CPU38.RES:Rescheduling_interrupts
      6057 ± 24%     -28.2%       4352 ± 23%  interrupts.CPU41.NMI:Non-maskable_interrupts
      6057 ± 24%     -28.2%       4352 ± 23%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    120.00 ± 99%    +376.2%     571.50 ± 85%  interrupts.CPU47.RES:Rescheduling_interrupts
    177.75 ± 31%    +247.4%     617.50 ± 88%  interrupts.CPU48.RES:Rescheduling_interrupts
    110.00 ± 83%    +116.6%     238.25 ± 26%  interrupts.CPU49.RES:Rescheduling_interrupts
      6925 ± 22%     -45.4%       3781 ±  3%  interrupts.CPU50.NMI:Non-maskable_interrupts
      6925 ± 22%     -45.4%       3781 ±  3%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    180.25 ± 97%    +685.2%       1415 ±115%  interrupts.CPU51.RES:Rescheduling_interrupts
    182.50 ± 53%   +1719.2%       3320 ± 62%  interrupts.CPU52.RES:Rescheduling_interrupts
      5043 ± 18%     -26.0%       3730 ±  5%  interrupts.CPU57.NMI:Non-maskable_interrupts
      5043 ± 18%     -26.0%       3730 ±  5%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      3655 ±  9%     +33.0%       4863 ± 21%  interrupts.CPU60.NMI:Non-maskable_interrupts
      3655 ±  9%     +33.0%       4863 ± 21%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
      6130 ± 24%     -28.1%       4410 ± 21%  interrupts.CPU64.NMI:Non-maskable_interrupts
      6130 ± 24%     -28.1%       4410 ± 21%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
      5811 ± 25%     -36.1%       3713        interrupts.CPU76.NMI:Non-maskable_interrupts
      5811 ± 25%     -36.1%       3713        interrupts.CPU76.PMI:Performance_monitoring_interrupts
      6036 ± 28%     -39.4%       3660 ±  5%  interrupts.CPU80.NMI:Non-maskable_interrupts
      6036 ± 28%     -39.4%       3660 ±  5%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
      6494 ± 25%     -43.9%       3640 ±  5%  interrupts.CPU82.NMI:Non-maskable_interrupts
      6494 ± 25%     -43.9%       3640 ±  5%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      6881 ± 13%     -48.8%       3522 ±  3%  interrupts.CPU84.NMI:Non-maskable_interrupts
      6881 ± 13%     -48.8%       3522 ±  3%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    110.75 ± 19%    +119.4%     243.00 ± 19%  interrupts.CPU9.RES:Rescheduling_interrupts


                                                                                
                            will-it-scale.per_process_ops                       
                                                                                
  95000 +-+-----------------------------------O-----------------------------+   
  90000 +-+              O  O   O O               O                         |   
        |               O O  OO  O               O                          |   
  85000 +-+         OOO                  O O   O                            |   
  80000 +-+    OO O                       O  O                              |   
        |    O                       O O                                    |   
  75000 +-+O     O                                                          |   
  70000 OO+ O                      O  O                                     |   
  65000 +-+                                                                 |   
        |                                                                   |   
  60000 +-+                                                                 |   
  55000 +-+     +    +     .+  .+ ++.                                       |   
        | .+++.+ ++.+ :.+ +  ++  +   +++.+++.++  +   .+++.+     +. +        |   
  50000 +-+           +  +                     :+ +++      + .++  + ++.+++.+|   
  45000 +-+-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/will-it-scale-100.yaml
suite: will-it-scale
testcase: will-it-scale
category: benchmark
nr_task: 100%
will-it-scale:
  mode: process
  test: brk1
job_origin: "/lkp/lkp/.src-20181229-091801/allot/cyclic:p1:linux-devel:devel-hourly/lkp-knm01/will-it-scale-100.yaml"

#! queue options
queue: bisect
testbox: lkp-knm01
tbox_group: lkp-knm01
submit_id: 5c2b509f0b9a935849d3d1a6
job_file: "/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-brk1-debian-x86_64-2018-04-03.cgz-7e28c5af4ef6b539334aa5de40feca0c041c94df-20190101-22601-1ncxbj9-0.yaml"
id: 3b65780fc5b8920f2e29ad867cd42a75eee7bd74
queuer_version: "/lkp/lkp/.src-20181229-164014"

#! hosts/lkp-knm01

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
commit: 7e28c5af4ef6b539334aa5de40feca0c041c94df

#! default params
kconfig: x86_64-rhel-7.2
compiler: gcc-7
rootfs: debian-x86_64-2018-04-03.cgz
enqueue_time: 2019-01-01 19:35:59.961441013 +08:00
_id: 5c2b509f0b9a935849d3d1a6
_rt: "/result/will-it-scale/performance-process-100%-brk1/lkp-knm01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/7e28c5af4ef6b539334aa5de40feca0c041c94df"

#! schedule options
user: lkp
head_commit: ab4756ff8ee9144cb7045eff9043ed2c6522e3b1
base_commit: 8fe28cb58bcb235034b64cbbb7550a8a43fd88be
branch: linux-devel/devel-hourly-2018123112
result_root: "/result/will-it-scale/performance-process-100%-brk1/lkp-knm01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/7e28c5af4ef6b539334aa5de40feca0c041c94df/0"
scheduler_version: "/lkp/lkp/.src-20181229-164014"
LKP_SERVER: inn
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-2018-04-03.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-brk1-debian-x86_64-2018-04-03.cgz-7e28c5af4ef6b539334aa5de40feca0c041c94df-20190101-22601-1ncxbj9-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.2
- branch=linux-devel/devel-hourly-2018123112
- commit=7e28c5af4ef6b539334aa5de40feca0c041c94df
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/7e28c5af4ef6b539334aa5de40feca0c041c94df/vmlinuz-4.19.0-rc1-00100-g7e28c5a
- max_uptime=1500
- RESULT_ROOT=/result/will-it-scale/performance-process-100%-brk1/lkp-knm01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/7e28c5af4ef6b539334aa5de40feca0c041c94df/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.2/gcc-7/7e28c5af4ef6b539334aa5de40feca0c041c94df/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/will-it-scale_2018-05-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/will-it-scale-x86_64-decad85_2018-06-07.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2018-06-19.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2018-05-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2018-05-18.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-01-01.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-e1ef035d272e_2019-01-01.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2016-11-15.cgz"
lkp_initrd: "/lkp/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20181229-164014/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
model: Knights Mill
nr_node: 1
nr_cpu: 288
memory: 80G
hdd_partitions: 
swap_partitions: LABEL=SWAP
rootfs_partition: LABEL=LKP-ROOTFS

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.2/gcc-7/7e28c5af4ef6b539334aa5de40feca0c041c94df/vmlinuz-4.19.0-rc1-00100-g7e28c5a"
dequeue_time: 2019-01-01 20:16:40.604583551 +08:00
job_state: finished
loadavg: 60.12 134.31 72.59 1/1845 11197
start_time: '1546345124'
end_time: '1546345447'
version: "/lkp/lkp/.src-20181229-164014"

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "python2" "./runtest.py" "brk1" "295" "process" "288"

--M9NhX3UHpAaciwkO--
