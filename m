Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86454C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2540A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfEPHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:43:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:32101 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfEPHn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:43:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 00:43:19 -0700
X-ExtLoop1: 1
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2019 00:43:13 -0700
Date:   Thu, 16 May 2019 15:43:35 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: [mm]  e0ee0e7107:  reaim.jobs_per_min -9.7% regression
Message-ID: <20190516074335.GP31424@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -9.7% regression of reaim.jobs_per_min due to commit:


commit: e0ee0e71078abbcadd4cbc38fb8570551fccc103 ("mm: memcontrol: track LRU counts in the vmstats array")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: reaim
on test machine: 256 threads Knights Landing with 96G memory
with following parameters:

	runtime: 300s
	nr_task: 100%
	test: shared
	cpufreq_governor: performance

test-description: REAIM is an updated and improved version of AIM 7 benchmark.
test-url: https://sourceforge.net/projects/re-aim-7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min -6.4% regression  |
| test machine     | 256 threads Knights Landing with 96G memory |
| test parameters  | cpufreq_governor=performance                |
|                  | nr_task=100%                                |
|                  | runtime=300s                                |
|                  | test=custom                                 |
+------------------+---------------------------------------------+


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-7/performance/x86_64-kexec/100%/debian-x86_64-2018-04-03.cgz/300s/lkp-knl-f1/shared/reaim

commit: 
  132bb8cfc9 ("mm/vmscan: add tracepoints for node reclaim")
  e0ee0e7107 ("mm: memcontrol: track LRU counts in the vmstats array")

132bb8cfc9e08123 e0ee0e71078abbcadd4cbc38fb8 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at_ip___perf_sw_event/0x
          1:4          -25%            :4     dmesg.WARNING:at_ip_perf_event_mmap_output/0x
          1:4          -14%           0:4     perf-profile.children.cycles-pp.error_entry
          0:4           -7%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    354.75           +51.5%     537.30        reaim.child_systime
    846.05            -1.5%     833.57        reaim.child_utime
    258457            -9.7%     233491        reaim.jobs_per_min
      1009            -9.7%     912.08        reaim.jobs_per_min_child
    271636           -10.2%     243888        reaim.max_jobs_per_min
      5.77           +10.7%       6.39        reaim.parent_time
      3.48            -4.0%       3.34        reaim.std_dev_percent
      0.18            +6.9%       0.19        reaim.std_dev_time
 1.571e+08            -6.5%  1.469e+08        reaim.time.minor_page_faults
     15125            +5.9%      16024        reaim.time.percent_of_cpu_this_job_got
     13607           +41.4%      19246        reaim.time.system_time
     32376            -7.9%      29814        reaim.time.user_time
   3686835            -3.5%    3558535        reaim.time.voluntary_context_switches
    979200            -6.5%     915200        reaim.workload
      8183 ±  4%      -5.0%       7772        boot-time.idle
    855.50            +5.3%     901.25        turbostat.Avg_MHz
      0.06 ± 12%      +0.0        0.07 ±  6%  mpstat.cpu.all.soft%
     19.22            +6.5       25.75        mpstat.cpu.all.sys%
     39.25            -8.3%      36.00        vmstat.cpu.id
     40.25            -8.1%      37.00        vmstat.cpu.us
     41194           -10.1%      37034        vmstat.system.cs
     84717            +2.0%      86446        proc-vmstat.nr_anon_pages
     36962            +1.3%      37432        proc-vmstat.nr_kernel_stack
      4004            +6.2%       4254        proc-vmstat.nr_page_table_pages
    112276            -1.0%     111112        proc-vmstat.nr_unevictable
    112276            -1.0%     111112        proc-vmstat.nr_zone_unevictable
 1.392e+08            -6.5%  1.301e+08        proc-vmstat.numa_hit
 1.392e+08            -6.5%  1.301e+08        proc-vmstat.numa_local
 1.435e+08            -6.5%  1.341e+08        proc-vmstat.pgalloc_normal
 1.581e+08            -6.5%  1.479e+08        proc-vmstat.pgfault
 1.433e+08            -6.5%   1.34e+08        proc-vmstat.pgfree
     16.78            -4.8%      15.97        perf-stat.i.MPKI
 6.825e+09            +9.8%  7.492e+09        perf-stat.i.branch-instructions
      5.27            -0.5        4.80        perf-stat.i.branch-miss-rate%
 3.543e+08            -4.0%  3.401e+08        perf-stat.i.branch-misses
 1.982e+08            -9.5%  1.793e+08        perf-stat.i.cache-misses
 8.335e+08            -9.9%  7.513e+08        perf-stat.i.cache-references
     41018           -11.3%      36372        perf-stat.i.context-switches
      4.05            +5.3%       4.26        perf-stat.i.cpi
 2.153e+11            +4.2%  2.244e+11        perf-stat.i.cpu-cycles
     10767            -1.7%      10583        perf-stat.i.cpu-migrations
      1168            +9.5%       1279        perf-stat.i.cycles-between-cache-misses
      0.41 ±  3%      -0.0        0.39 ±  2%  perf-stat.i.iTLB-load-miss-rate%
  1.49e+08            -9.3%  1.351e+08        perf-stat.i.iTLB-load-misses
 5.884e+10            -2.2%  5.757e+10        perf-stat.i.iTLB-loads
 5.891e+10            -2.1%  5.765e+10        perf-stat.i.instructions
    345.23            +6.4%     367.49        perf-stat.i.instructions-per-iTLB-miss
      0.27            -4.4%       0.26        perf-stat.i.ipc
    505400            -8.3%     463221        perf-stat.i.minor-faults
    505782            -8.2%     464301        perf-stat.i.page-faults
     14.24            -7.0%      13.24        perf-stat.overall.MPKI
      5.19            -0.7        4.51        perf-stat.overall.branch-miss-rate%
      3.67            +7.3%       3.93        perf-stat.overall.cpi
      1083           +15.0%       1245        perf-stat.overall.cycles-between-cache-misses
      0.25            -0.0        0.23        perf-stat.overall.iTLB-load-miss-rate%
    394.61            +7.7%     425.12        perf-stat.overall.instructions-per-iTLB-miss
      0.27            -6.8%       0.25        perf-stat.overall.ipc
  18168438            +5.6%   19180280        perf-stat.overall.path-length
 6.885e+09           +11.8%  7.696e+09        perf-stat.ps.branch-instructions
 3.573e+08            -2.8%  3.472e+08        perf-stat.ps.branch-misses
 2.002e+08            -8.2%  1.838e+08        perf-stat.ps.cache-misses
  8.42e+08            -8.5%  7.704e+08        perf-stat.ps.cache-references
     41367           -10.1%      37187        perf-stat.ps.context-switches
 2.168e+11            +5.6%  2.289e+11        perf-stat.ps.cpu-cycles
 1.498e+08            -8.7%  1.369e+08        perf-stat.ps.iTLB-load-misses
 5.907e+10            -1.6%  5.813e+10        perf-stat.ps.iTLB-loads
 5.913e+10            -1.6%  5.818e+10        perf-stat.ps.instructions
    509899            -7.0%     474333        perf-stat.ps.minor-faults
    510054            -7.0%     474504        perf-stat.ps.page-faults
      4217 ± 23%     -54.4%       1922 ± 50%  sched_debug.cfs_rq:/.MIN_vruntime.avg
     19262 ± 16%     -39.4%      11671 ± 43%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    714672 ±  4%     -65.5%     246257 ± 54%  sched_debug.cfs_rq:/.load.avg
   2193271 ±  4%     -33.9%    1450530 ± 12%  sched_debug.cfs_rq:/.load.max
    363196 ±  5%     -46.6%     193839 ± 19%  sched_debug.cfs_rq:/.load.stddev
    807.18 ±  2%     -64.1%     289.75 ± 54%  sched_debug.cfs_rq:/.load_avg.avg
      2746 ±  4%     -46.3%       1474 ± 17%  sched_debug.cfs_rq:/.load_avg.max
    429.01 ±  6%     -51.6%     207.43 ± 27%  sched_debug.cfs_rq:/.load_avg.stddev
      4217 ± 23%     -54.4%       1922 ± 50%  sched_debug.cfs_rq:/.max_vruntime.avg
     19262 ± 16%     -39.4%      11671 ± 43%  sched_debug.cfs_rq:/.max_vruntime.stddev
    106211 ± 10%     +12.6%     119612 ±  9%  sched_debug.cfs_rq:/.min_vruntime.avg
      4309 ± 12%     +57.2%       6774 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.68 ±  4%     -65.6%       0.23 ± 54%  sched_debug.cfs_rq:/.nr_running.avg
      2.09 ±  4%     -33.9%       1.38 ± 12%  sched_debug.cfs_rq:/.nr_running.max
      0.35 ±  5%     -46.5%       0.19 ± 19%  sched_debug.cfs_rq:/.nr_running.stddev
     26.92 ± 12%     -66.9%       8.91 ± 64%  sched_debug.cfs_rq:/.removed.load_avg.avg
    903.40 ± 13%     -59.1%     369.11 ± 34%  sched_debug.cfs_rq:/.removed.load_avg.max
    135.87 ± 10%     -65.6%      46.79 ± 49%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      1242 ± 12%     -66.9%     411.23 ± 64%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
     42017 ± 13%     -59.3%      17080 ± 34%  sched_debug.cfs_rq:/.removed.runnable_sum.max
      6273 ± 10%     -65.6%       2159 ± 49%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
      9.52 ± 18%     -65.3%       3.30 ± 65%  sched_debug.cfs_rq:/.removed.util_avg.avg
    477.28 ± 26%     -60.5%     188.61 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.max
     52.24 ± 20%     -62.9%      19.36 ± 47%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    599.76 ±  4%     -66.0%     203.73 ± 55%  sched_debug.cfs_rq:/.runnable_load_avg.avg
      1853 ± 10%     -36.3%       1180 ± 11%  sched_debug.cfs_rq:/.runnable_load_avg.max
    327.58 ±  6%     -50.4%     162.60 ± 25%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
    714331 ±  4%     -65.6%     246087 ± 54%  sched_debug.cfs_rq:/.runnable_weight.avg
   2193271 ±  4%     -33.9%    1450530 ± 12%  sched_debug.cfs_rq:/.runnable_weight.max
    363491 ±  5%     -46.6%     194117 ± 19%  sched_debug.cfs_rq:/.runnable_weight.stddev
      0.02 ± 27%     -74.6%       0.00 ±173%  sched_debug.cfs_rq:/.spread.avg
      3.72 ± 24%     -73.1%       1.00 ±173%  sched_debug.cfs_rq:/.spread.max
      0.23 ± 25%     -73.3%       0.06 ±173%  sched_debug.cfs_rq:/.spread.stddev
      4322 ± 12%     +56.8%       6778 ± 17%  sched_debug.cfs_rq:/.spread0.stddev
    588.53 ±  5%     -65.5%     203.04 ± 54%  sched_debug.cfs_rq:/.util_avg.avg
      1526 ±  3%     -25.6%       1135 ±  6%  sched_debug.cfs_rq:/.util_avg.max
    261.05 ± 10%     -43.5%     147.41 ± 23%  sched_debug.cfs_rq:/.util_avg.stddev
    264.02 ±  7%     -74.8%      66.65 ± 57%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    995.26 ±  4%     -52.0%     478.00 ± 45%  sched_debug.cfs_rq:/.util_est_enqueued.max
    243.52 ±  7%     -64.7%      85.98 ± 53%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    390455 ± 20%     -57.3%     166866 ± 36%  sched_debug.cpu.avg_idle.min
    226.75 ±  2%     -25.5%     168.89 ± 12%  sched_debug.cpu.clock.stddev
    226.75 ±  2%     -25.5%     168.90 ± 12%  sched_debug.cpu.clock_task.stddev
    613.49 ±  5%     -66.7%     204.24 ± 55%  sched_debug.cpu.cpu_load[0].avg
      1916 ±  8%     -31.4%       1315 ± 13%  sched_debug.cpu.cpu_load[0].max
    322.12 ±  9%     -49.0%     164.31 ± 26%  sched_debug.cpu.cpu_load[0].stddev
    612.63 ±  4%     -66.7%     204.28 ± 55%  sched_debug.cpu.cpu_load[1].avg
      1448 ±  6%     -20.3%       1154 ±  7%  sched_debug.cpu.cpu_load[1].max
     51.78 ± 45%     -90.2%       5.08 ±104%  sched_debug.cpu.cpu_load[1].min
    250.21 ±  9%     -43.8%     140.58 ± 23%  sched_debug.cpu.cpu_load[1].stddev
    611.42 ±  4%     -66.7%     203.50 ± 55%  sched_debug.cpu.cpu_load[2].avg
      1252 ±  5%     -15.2%       1062 ±  3%  sched_debug.cpu.cpu_load[2].max
    135.63 ± 18%     -82.0%      24.42 ± 81%  sched_debug.cpu.cpu_load[2].min
    215.74 ± 11%     -40.6%     128.23 ± 21%  sched_debug.cpu.cpu_load[2].stddev
    609.77 ±  4%     -66.8%     202.56 ± 55%  sched_debug.cpu.cpu_load[3].avg
      1151 ±  3%     -12.2%       1011 ±  4%  sched_debug.cpu.cpu_load[3].max
    205.74 ± 15%     -75.6%      50.25 ± 79%  sched_debug.cpu.cpu_load[3].min
    190.83 ± 13%     -37.8%     118.60 ± 20%  sched_debug.cpu.cpu_load[3].stddev
    607.50 ±  4%     -67.0%     200.70 ± 55%  sched_debug.cpu.cpu_load[4].avg
      1089           -10.0%     980.43 ±  4%  sched_debug.cpu.cpu_load[4].max
    256.25 ± 18%     -67.6%      83.04 ± 73%  sched_debug.cpu.cpu_load[4].min
    167.61 ± 15%     -35.3%     108.38 ± 19%  sched_debug.cpu.cpu_load[4].stddev
     70051 ±  6%     -54.1%      32128 ± 57%  sched_debug.cpu.curr->pid.avg
    110232 ± 11%     +21.5%     133898 ±  2%  sched_debug.cpu.curr->pid.max
     25722 ± 11%     -28.5%      18384 ± 31%  sched_debug.cpu.curr->pid.stddev
    717007 ±  4%     -65.9%     244497 ± 54%  sched_debug.cpu.load.avg
   2202009 ±  8%     -32.1%    1494220 ± 16%  sched_debug.cpu.load.max
    362781 ±  6%     -46.5%     193973 ± 21%  sched_debug.cpu.load.stddev
   1560619 ± 10%     -16.2%    1308544 ±  9%  sched_debug.cpu.max_idle_balance_cost.max
     27189 ±  9%     +12.5%      30587 ±  8%  sched_debug.cpu.nr_load_updates.avg
     32217 ±  6%     +10.8%      35703 ±  6%  sched_debug.cpu.nr_load_updates.max
      0.69 ±  4%     -65.8%       0.23 ± 54%  sched_debug.cpu.nr_running.avg
      2.14 ±  7%     -25.3%       1.60 ± 14%  sched_debug.cpu.nr_running.max
      0.35 ±  4%     -44.7%       0.19 ± 19%  sched_debug.cpu.nr_running.stddev
      0.07 ± 33%     -64.9%       0.02 ± 64%  sched_debug.cpu.nr_uninterruptible.avg
    -50.05           -20.8%     -39.62        sched_debug.cpu.nr_uninterruptible.min
     15965 ± 13%     -17.7%      13134 ±  2%  softirqs.CPU0.RCU
     14739 ±  2%      -7.2%      13674 ±  2%  softirqs.CPU10.RCU
     14520 ±  2%     -10.5%      12992        softirqs.CPU101.RCU
     14419 ±  4%      -9.0%      13118 ±  2%  softirqs.CPU102.RCU
     14295            -9.3%      12973 ±  4%  softirqs.CPU105.RCU
     14450 ±  2%      -9.1%      13132 ±  3%  softirqs.CPU107.RCU
     14557           -10.2%      13079 ±  3%  softirqs.CPU117.RCU
     15307 ±  3%     -13.0%      13310        softirqs.CPU12.RCU
     14527 ±  2%     -11.5%      12854 ±  3%  softirqs.CPU120.RCU
     14528 ±  2%     -10.1%      13064        softirqs.CPU124.RCU
     13801 ±  4%      -7.8%      12720 ±  4%  softirqs.CPU126.RCU
     16009 ± 11%     -18.8%      13006 ±  2%  softirqs.CPU128.RCU
     14451 ±  2%     -11.0%      12863 ±  2%  softirqs.CPU132.RCU
     14587 ±  2%     -11.5%      12909        softirqs.CPU133.RCU
     14456 ±  2%      -8.9%      13176        softirqs.CPU134.RCU
     14647 ±  3%     -10.7%      13083 ±  3%  softirqs.CPU137.RCU
     14962 ±  4%     -13.1%      13006        softirqs.CPU138.RCU
     15605 ±  2%     -11.7%      13787 ±  2%  softirqs.CPU14.RCU
     14723 ±  6%     -12.2%      12924 ±  4%  softirqs.CPU141.RCU
     14650 ±  2%     -11.3%      13001 ±  3%  softirqs.CPU143.RCU
     14291 ±  2%      -7.5%      13216 ±  4%  softirqs.CPU145.RCU
     14868           -12.6%      12995        softirqs.CPU146.RCU
     14472 ±  2%     -10.5%      12949 ±  3%  softirqs.CPU149.RCU
     14753 ±  4%     -13.4%      12781 ±  3%  softirqs.CPU150.RCU
     14562           -12.0%      12822 ±  2%  softirqs.CPU161.RCU
     14278 ±  3%      -9.7%      12891        softirqs.CPU162.RCU
     14449 ±  3%     -10.2%      12979 ±  4%  softirqs.CPU164.RCU
     14495 ±  3%      -9.9%      13062 ±  3%  softirqs.CPU165.RCU
     14399 ±  2%     -10.2%      12924 ±  2%  softirqs.CPU166.RCU
     14401 ±  2%      -9.3%      13057 ±  3%  softirqs.CPU172.RCU
     14401 ±  2%      -9.5%      13035 ±  3%  softirqs.CPU174.RCU
     14463 ±  2%     -11.9%      12744 ±  3%  softirqs.CPU175.RCU
     14662 ±  3%     -15.0%      12470 ±  3%  softirqs.CPU176.RCU
     14217 ±  2%     -10.3%      12747        softirqs.CPU177.RCU
     14353           -12.2%      12609 ±  2%  softirqs.CPU178.RCU
     14584 ±  4%      -9.7%      13176 ±  2%  softirqs.CPU180.RCU
     14634 ±  4%     -11.4%      12959        softirqs.CPU181.RCU
     14266 ±  2%     -10.1%      12829        softirqs.CPU182.RCU
     14132 ±  2%      -9.6%      12775        softirqs.CPU187.RCU
     14422 ±  2%      -9.0%      13117        softirqs.CPU189.RCU
     14897           -10.4%      13354 ±  2%  softirqs.CPU19.RCU
     14188 ±  3%      -8.7%      12960 ±  3%  softirqs.CPU192.RCU
     14661 ±  2%     -11.9%      12915        softirqs.CPU193.RCU
     14273 ±  3%     -12.8%      12447 ±  3%  softirqs.CPU195.RCU
     14598 ±  4%     -11.1%      12982 ±  2%  softirqs.CPU196.RCU
     14317            -8.7%      13072 ±  2%  softirqs.CPU197.RCU
     14935 ±  4%     -11.1%      13276 ±  3%  softirqs.CPU2.RCU
     14713 ±  3%     -11.0%      13091        softirqs.CPU20.RCU
     14969 ±  8%     -13.2%      12995        softirqs.CPU202.RCU
     14035 ±  2%     -10.0%      12635 ±  5%  softirqs.CPU204.RCU
     14391            -9.3%      13057        softirqs.CPU205.RCU
     14269 ±  2%      -9.6%      12901 ±  2%  softirqs.CPU210.RCU
     13875 ±  2%      -8.6%      12688 ±  3%  softirqs.CPU212.RCU
     14473 ±  3%     -11.8%      12762 ±  3%  softirqs.CPU215.RCU
     14018 ±  3%      -8.3%      12857 ±  2%  softirqs.CPU217.RCU
     14293           -10.7%      12763 ±  2%  softirqs.CPU218.RCU
     15547 ±  5%     -12.7%      13574 ±  2%  softirqs.CPU22.RCU
     14565 ±  4%     -12.9%      12684        softirqs.CPU220.RCU
     14330            -9.1%      13019 ±  4%  softirqs.CPU222.RCU
     14243 ±  2%     -11.9%      12553 ±  2%  softirqs.CPU224.RCU
     14285            -9.9%      12877        softirqs.CPU225.RCU
     14166 ±  3%     -10.9%      12618        softirqs.CPU226.RCU
     14706 ±  3%      -9.4%      13327 ±  3%  softirqs.CPU23.RCU
     14274 ±  3%     -10.6%      12757 ±  2%  softirqs.CPU233.RCU
     14493 ±  5%      -9.6%      13107 ±  5%  softirqs.CPU234.RCU
     14461           -10.1%      13004 ±  4%  softirqs.CPU235.RCU
     14364 ±  3%     -10.9%      12796 ±  2%  softirqs.CPU240.RCU
     14362           -11.6%      12697 ±  3%  softirqs.CPU243.RCU
     14230           -10.0%      12808 ±  2%  softirqs.CPU252.RCU
     14329            -9.7%      12940        softirqs.CPU253.RCU
     14219 ±  2%      -8.4%      13025 ±  2%  softirqs.CPU254.RCU
     14329 ±  3%     -10.0%      12893 ±  2%  softirqs.CPU255.RCU
     14655            -9.5%      13256 ±  3%  softirqs.CPU27.RCU
     15363 ±  4%     -14.5%      13133        softirqs.CPU28.RCU
     14860 ±  3%      -9.8%      13411 ±  2%  softirqs.CPU29.RCU
     15220 ±  2%     -13.0%      13240 ±  2%  softirqs.CPU30.RCU
     14560            -9.0%      13256        softirqs.CPU34.RCU
     14936 ±  4%     -11.6%      13200        softirqs.CPU39.RCU
     14911           -11.8%      13153 ±  2%  softirqs.CPU4.RCU
     14799 ±  2%     -10.8%      13205 ±  5%  softirqs.CPU40.RCU
     14690 ±  3%      -9.8%      13253        softirqs.CPU43.RCU
     14774 ±  3%     -12.9%      12866        softirqs.CPU47.RCU
     14891 ±  3%      -9.4%      13499 ±  2%  softirqs.CPU49.RCU
     14584            -9.7%      13166 ±  3%  softirqs.CPU54.RCU
     15391 ±  6%     -15.7%      12967 ±  3%  softirqs.CPU56.RCU
     14426 ±  3%      -7.7%      13317 ±  2%  softirqs.CPU57.RCU
     14552 ±  2%     -10.0%      13096        softirqs.CPU59.RCU
     14506 ±  2%      -9.9%      13070        softirqs.CPU60.RCU
     15038 ±  7%     -12.6%      13149 ±  3%  softirqs.CPU61.RCU
     14664 ±  3%      -9.0%      13348 ±  2%  softirqs.CPU68.RCU
     14879 ±  3%     -10.9%      13253 ±  4%  softirqs.CPU69.RCU
     14654            -7.9%      13490 ±  3%  softirqs.CPU7.RCU
     14834 ±  6%     -11.6%      13110        softirqs.CPU72.RCU
     14535 ±  4%      -9.9%      13101 ±  3%  softirqs.CPU81.RCU
     14696           -12.4%      12877 ±  5%  softirqs.CPU83.RCU
     14985 ±  3%     -11.4%      13271 ±  3%  softirqs.CPU9.RCU
     14731 ±  2%     -10.4%      13202        softirqs.CPU90.RCU
     14256 ±  3%      -8.7%      13011 ±  3%  softirqs.CPU92.RCU
     14459 ±  6%     -10.3%      12975        softirqs.CPU95.RCU
     14365 ±  2%     -10.4%      12875 ±  3%  softirqs.CPU97.RCU
     14698            -9.4%      13321 ±  2%  softirqs.CPU98.RCU
   1709728            -4.0%    1641546        interrupts.CAL:Function_call_interrupts
      2081 ±  9%     +69.5%       3527 ± 32%  interrupts.CPU0.NMI:Non-maskable_interrupts
      2081 ±  9%     +69.5%       3527 ± 32%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    716.25 ±  6%     -16.9%     595.25 ±  4%  interrupts.CPU0.TLB:TLB_shootdowns
      2086 ±  6%     +41.2%       2946 ± 34%  interrupts.CPU1.NMI:Non-maskable_interrupts
      2086 ±  6%     +41.2%       2946 ± 34%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    727.50 ±  7%     -13.7%     628.00 ±  6%  interrupts.CPU1.TLB:TLB_shootdowns
    750.25           -20.2%     599.00 ±  6%  interrupts.CPU100.TLB:TLB_shootdowns
    769.25 ±  5%     -19.5%     619.00        interrupts.CPU101.TLB:TLB_shootdowns
    742.75 ±  9%     -14.0%     638.75 ±  2%  interrupts.CPU102.TLB:TLB_shootdowns
    777.50 ±  2%     -24.8%     584.75 ±  3%  interrupts.CPU103.TLB:TLB_shootdowns
    738.00           -17.9%     605.75        interrupts.CPU104.TLB:TLB_shootdowns
    724.75 ±  2%     -15.3%     614.00 ±  8%  interrupts.CPU105.TLB:TLB_shootdowns
    759.00 ±  7%     -20.0%     607.00 ±  4%  interrupts.CPU106.TLB:TLB_shootdowns
    784.75           -21.9%     612.50 ±  6%  interrupts.CPU108.TLB:TLB_shootdowns
    723.25 ±  2%     -16.6%     603.50 ±  7%  interrupts.CPU109.TLB:TLB_shootdowns
      4237 ±  4%      +8.3%       4591 ±  4%  interrupts.CPU11.RES:Rescheduling_interrupts
    723.00 ±  7%     -14.1%     621.00 ±  2%  interrupts.CPU11.TLB:TLB_shootdowns
    744.50           -18.8%     604.75 ±  6%  interrupts.CPU110.TLB:TLB_shootdowns
    749.50 ±  2%     -21.5%     588.00 ±  4%  interrupts.CPU111.TLB:TLB_shootdowns
    747.50 ±  3%     -18.1%     612.25 ±  8%  interrupts.CPU112.TLB:TLB_shootdowns
    746.00 ±  7%     -19.1%     603.75 ±  4%  interrupts.CPU113.TLB:TLB_shootdowns
    737.00 ±  8%     -13.3%     638.75 ±  4%  interrupts.CPU114.TLB:TLB_shootdowns
    775.25 ±  2%     -21.2%     611.00 ±  5%  interrupts.CPU115.TLB:TLB_shootdowns
    756.50 ±  4%     -20.5%     601.75        interrupts.CPU116.TLB:TLB_shootdowns
    781.50 ±  3%     -23.4%     599.00 ±  7%  interrupts.CPU117.TLB:TLB_shootdowns
    744.25 ±  5%     -14.7%     634.75 ±  4%  interrupts.CPU118.TLB:TLB_shootdowns
    767.50 ±  4%     -15.8%     646.50 ±  7%  interrupts.CPU119.TLB:TLB_shootdowns
    742.25           -15.3%     628.75 ±  3%  interrupts.CPU12.TLB:TLB_shootdowns
      2085 ±  6%     +41.4%       2949 ± 38%  interrupts.CPU120.NMI:Non-maskable_interrupts
      2085 ±  6%     +41.4%       2949 ± 38%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
    781.25           -24.5%     589.75 ±  4%  interrupts.CPU120.TLB:TLB_shootdowns
    748.25           -16.2%     626.75 ±  3%  interrupts.CPU121.TLB:TLB_shootdowns
    746.00 ±  3%     -19.5%     600.50 ±  9%  interrupts.CPU122.TLB:TLB_shootdowns
      2083 ±  6%     +67.9%       3497 ± 36%  interrupts.CPU123.NMI:Non-maskable_interrupts
      2083 ±  6%     +67.9%       3497 ± 36%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
    727.25 ±  4%     -18.0%     596.25 ±  6%  interrupts.CPU123.TLB:TLB_shootdowns
      2098 ±  8%     +65.8%       3480 ± 34%  interrupts.CPU124.NMI:Non-maskable_interrupts
      2098 ±  8%     +65.8%       3480 ± 34%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
    775.25 ±  2%     -19.0%     628.00 ±  7%  interrupts.CPU124.TLB:TLB_shootdowns
      2061 ±  8%    +101.9%       4162 ± 27%  interrupts.CPU125.NMI:Non-maskable_interrupts
      2061 ±  8%    +101.9%       4162 ± 27%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
    756.00 ±  2%     -19.4%     609.00 ±  4%  interrupts.CPU125.TLB:TLB_shootdowns
      2076 ±  5%     +67.4%       3475 ± 35%  interrupts.CPU126.NMI:Non-maskable_interrupts
      2076 ±  5%     +67.4%       3475 ± 35%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    718.25 ±  2%     -16.0%     603.25 ±  3%  interrupts.CPU126.TLB:TLB_shootdowns
      2057 ±  4%     +66.9%       3434 ± 33%  interrupts.CPU127.NMI:Non-maskable_interrupts
      2057 ±  4%     +66.9%       3434 ± 33%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    762.25 ±  8%     -11.3%     676.25 ±  7%  interrupts.CPU127.TLB:TLB_shootdowns
      2097 ±  7%     +65.7%       3474 ± 34%  interrupts.CPU128.NMI:Non-maskable_interrupts
      2097 ±  7%     +65.7%       3474 ± 34%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    758.75 ±  5%     -17.1%     629.00 ±  2%  interrupts.CPU128.TLB:TLB_shootdowns
      2077 ±  5%     +72.4%       3580 ± 33%  interrupts.CPU129.NMI:Non-maskable_interrupts
      2077 ±  5%     +72.4%       3580 ± 33%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    760.75 ±  4%     -23.1%     585.25        interrupts.CPU129.TLB:TLB_shootdowns
    730.50 ±  2%     -13.2%     634.00 ±  3%  interrupts.CPU13.TLB:TLB_shootdowns
      2081 ±  7%     +71.6%       3570 ± 33%  interrupts.CPU130.NMI:Non-maskable_interrupts
      2081 ±  7%     +71.6%       3570 ± 33%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    703.50 ±  6%     -13.1%     611.50 ±  3%  interrupts.CPU130.TLB:TLB_shootdowns
      2084 ±  5%     +69.4%       3531 ± 34%  interrupts.CPU131.NMI:Non-maskable_interrupts
      2084 ±  5%     +69.4%       3531 ± 34%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
    760.75 ±  5%     -19.8%     609.75 ±  2%  interrupts.CPU131.TLB:TLB_shootdowns
    745.50 ±  4%     -19.8%     597.75 ±  6%  interrupts.CPU132.TLB:TLB_shootdowns
      2062 ±  8%     +41.4%       2917 ± 36%  interrupts.CPU133.NMI:Non-maskable_interrupts
      2062 ±  8%     +41.4%       2917 ± 36%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
    744.25 ±  2%     -19.5%     598.75 ±  2%  interrupts.CPU133.TLB:TLB_shootdowns
    766.75 ±  3%     -15.6%     647.50 ±  5%  interrupts.CPU134.TLB:TLB_shootdowns
    778.50 ±  8%     -23.8%     593.25 ± 10%  interrupts.CPU135.TLB:TLB_shootdowns
      2065 ±  5%     +43.5%       2963 ± 35%  interrupts.CPU136.NMI:Non-maskable_interrupts
      2065 ±  5%     +43.5%       2963 ± 35%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    766.25           -22.0%     597.75 ±  5%  interrupts.CPU136.TLB:TLB_shootdowns
    721.75 ±  6%     -11.8%     636.25 ±  7%  interrupts.CPU137.TLB:TLB_shootdowns
      2132 ±  5%     +10.4%       2355 ±  2%  interrupts.CPU138.NMI:Non-maskable_interrupts
      2132 ±  5%     +10.4%       2355 ±  2%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    753.75 ±  7%     -21.0%     595.75 ±  6%  interrupts.CPU138.TLB:TLB_shootdowns
      2054 ±  6%     +16.0%       2384        interrupts.CPU139.NMI:Non-maskable_interrupts
      2054 ±  6%     +16.0%       2384        interrupts.CPU139.PMI:Performance_monitoring_interrupts
    744.50 ±  7%     -17.4%     614.75 ±  6%  interrupts.CPU139.TLB:TLB_shootdowns
    812.50 ±  7%     -24.5%     613.50 ±  5%  interrupts.CPU14.TLB:TLB_shootdowns
      2093 ±  3%     +10.2%       2307 ±  4%  interrupts.CPU140.NMI:Non-maskable_interrupts
      2093 ±  3%     +10.2%       2307 ±  4%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    736.25 ±  2%     -18.0%     604.00 ± 12%  interrupts.CPU140.TLB:TLB_shootdowns
      4098 ±  4%      +8.0%       4425 ±  4%  interrupts.CPU141.RES:Rescheduling_interrupts
    724.50           -18.5%     590.75 ±  4%  interrupts.CPU141.TLB:TLB_shootdowns
    720.00 ±  3%     -14.8%     613.75 ±  3%  interrupts.CPU142.TLB:TLB_shootdowns
      2096 ±  8%     +65.1%       3461 ± 33%  interrupts.CPU143.NMI:Non-maskable_interrupts
      2096 ±  8%     +65.1%       3461 ± 33%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    762.25 ±  4%     -16.2%     638.75 ±  4%  interrupts.CPU143.TLB:TLB_shootdowns
    752.25 ±  2%     -20.2%     600.00 ± 11%  interrupts.CPU144.TLB:TLB_shootdowns
      4290 ±  4%      +7.1%       4593 ±  4%  interrupts.CPU145.RES:Rescheduling_interrupts
    757.00 ±  4%     -21.3%     595.50 ±  5%  interrupts.CPU145.TLB:TLB_shootdowns
      2080 ±  4%     +43.0%       2976 ± 32%  interrupts.CPU146.NMI:Non-maskable_interrupts
      2080 ±  4%     +43.0%       2976 ± 32%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      4138 ±  3%     +12.3%       4647        interrupts.CPU147.RES:Rescheduling_interrupts
    748.50 ±  6%     -21.2%     589.75 ±  7%  interrupts.CPU147.TLB:TLB_shootdowns
      2095 ±  6%     +41.0%       2956 ± 35%  interrupts.CPU148.NMI:Non-maskable_interrupts
      2095 ±  6%     +41.0%       2956 ± 35%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    705.00 ±  5%     -16.1%     591.75 ±  2%  interrupts.CPU148.TLB:TLB_shootdowns
    810.50 ±  3%     -23.5%     620.00 ±  6%  interrupts.CPU149.TLB:TLB_shootdowns
    766.50 ±  3%     -22.8%     592.00 ±  5%  interrupts.CPU15.TLB:TLB_shootdowns
      2053 ±  7%     +42.4%       2925 ± 34%  interrupts.CPU150.NMI:Non-maskable_interrupts
      2053 ±  7%     +42.4%       2925 ± 34%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
    786.25           -24.5%     593.25 ±  7%  interrupts.CPU150.TLB:TLB_shootdowns
    762.00 ±  4%     -22.0%     594.25 ±  7%  interrupts.CPU151.TLB:TLB_shootdowns
    741.50 ±  4%     -16.6%     618.75 ±  6%  interrupts.CPU152.TLB:TLB_shootdowns
      2095 ±  5%     +41.5%       2965 ± 36%  interrupts.CPU153.NMI:Non-maskable_interrupts
      2095 ±  5%     +41.5%       2965 ± 36%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    737.00 ±  7%     -20.9%     583.25 ± 10%  interrupts.CPU153.TLB:TLB_shootdowns
      2105 ±  2%     +39.0%       2926 ± 35%  interrupts.CPU154.NMI:Non-maskable_interrupts
      2105 ±  2%     +39.0%       2926 ± 35%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
    729.75 ±  3%     -17.7%     600.75 ±  5%  interrupts.CPU154.TLB:TLB_shootdowns
      2051 ±  6%     +41.9%       2911 ± 34%  interrupts.CPU155.NMI:Non-maskable_interrupts
      2051 ±  6%     +41.9%       2911 ± 34%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    745.00 ±  3%     -21.3%     586.00 ±  2%  interrupts.CPU155.TLB:TLB_shootdowns
    719.50 ±  3%     -17.2%     595.75 ±  4%  interrupts.CPU156.TLB:TLB_shootdowns
      2089 ±  6%     +40.3%       2931 ± 37%  interrupts.CPU157.NMI:Non-maskable_interrupts
      2089 ±  6%     +40.3%       2931 ± 37%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
    767.50 ±  4%     -17.7%     632.00 ±  2%  interrupts.CPU157.TLB:TLB_shootdowns
    734.00 ±  7%     -17.4%     606.25 ±  8%  interrupts.CPU158.TLB:TLB_shootdowns
    731.50           -15.5%     618.00 ±  4%  interrupts.CPU159.TLB:TLB_shootdowns
      2093 ±  6%     +13.1%       2368 ±  2%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2093 ±  6%     +13.1%       2368 ±  2%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    725.50 ±  5%     -15.5%     612.75 ±  9%  interrupts.CPU16.TLB:TLB_shootdowns
      2049 ±  6%     +41.8%       2906 ± 36%  interrupts.CPU161.NMI:Non-maskable_interrupts
      2049 ±  6%     +41.8%       2906 ± 36%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
    760.00 ±  3%     -19.5%     612.00 ±  2%  interrupts.CPU161.TLB:TLB_shootdowns
      2137 ±  5%     +62.2%       3466 ± 32%  interrupts.CPU162.NMI:Non-maskable_interrupts
      2137 ±  5%     +62.2%       3466 ± 32%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
    724.75 ±  5%     -12.6%     633.75 ±  5%  interrupts.CPU162.TLB:TLB_shootdowns
    744.75 ±  4%     -17.3%     615.75        interrupts.CPU163.TLB:TLB_shootdowns
      2056 ±  8%     +40.0%       2879 ± 31%  interrupts.CPU164.NMI:Non-maskable_interrupts
      2056 ±  8%     +40.0%       2879 ± 31%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    745.50 ±  2%     -17.0%     618.75 ±  3%  interrupts.CPU164.TLB:TLB_shootdowns
    761.50 ±  9%     -17.3%     629.50 ±  7%  interrupts.CPU165.TLB:TLB_shootdowns
    776.25 ±  5%     -20.4%     618.00 ±  4%  interrupts.CPU166.TLB:TLB_shootdowns
      2069 ±  6%     +40.2%       2901 ± 33%  interrupts.CPU167.NMI:Non-maskable_interrupts
      2069 ±  6%     +40.2%       2901 ± 33%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
    757.75 ±  5%     -21.0%     599.00 ±  2%  interrupts.CPU167.TLB:TLB_shootdowns
      2085 ±  6%     +68.4%       3511 ± 31%  interrupts.CPU168.NMI:Non-maskable_interrupts
      2085 ±  6%     +68.4%       3511 ± 31%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
    752.00 ±  2%     -21.0%     594.25 ±  4%  interrupts.CPU168.TLB:TLB_shootdowns
    695.50 ±  2%     -16.5%     580.50 ±  7%  interrupts.CPU169.TLB:TLB_shootdowns
    745.00 ±  6%     -16.8%     619.75 ±  3%  interrupts.CPU17.TLB:TLB_shootdowns
      2084 ±  5%     +66.7%       3475 ± 31%  interrupts.CPU170.NMI:Non-maskable_interrupts
      2084 ±  5%     +66.7%       3475 ± 31%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    706.75           -16.6%     589.75 ±  5%  interrupts.CPU170.TLB:TLB_shootdowns
      2107 ±  6%     +65.0%       3478 ± 29%  interrupts.CPU171.NMI:Non-maskable_interrupts
      2107 ±  6%     +65.0%       3478 ± 29%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
    715.75 ±  5%     -13.6%     618.75 ±  2%  interrupts.CPU171.TLB:TLB_shootdowns
      2065 ±  5%     +63.8%       3383 ± 30%  interrupts.CPU172.NMI:Non-maskable_interrupts
      2065 ±  5%     +63.8%       3383 ± 30%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    737.00 ±  6%     -11.1%     655.00 ±  4%  interrupts.CPU172.TLB:TLB_shootdowns
      2057 ±  6%     +67.5%       3445 ± 31%  interrupts.CPU173.NMI:Non-maskable_interrupts
      2057 ±  6%     +67.5%       3445 ± 31%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    751.75 ±  3%     -18.4%     613.75 ±  5%  interrupts.CPU173.TLB:TLB_shootdowns
      2083 ±  8%     +67.2%       3483 ± 32%  interrupts.CPU174.NMI:Non-maskable_interrupts
      2083 ±  8%     +67.2%       3483 ± 32%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    741.25 ±  4%     -17.4%     612.00 ±  4%  interrupts.CPU174.TLB:TLB_shootdowns
      2067 ±  3%     +67.7%       3466 ± 33%  interrupts.CPU175.NMI:Non-maskable_interrupts
      2067 ±  3%     +67.7%       3466 ± 33%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    747.00 ±  4%     -21.4%     587.50 ±  6%  interrupts.CPU175.TLB:TLB_shootdowns
      2071 ±  7%     +67.9%       3478 ± 32%  interrupts.CPU176.NMI:Non-maskable_interrupts
      2071 ±  7%     +67.9%       3478 ± 32%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    788.75 ±  4%     -29.3%     557.50 ±  3%  interrupts.CPU176.TLB:TLB_shootdowns
      2117 ±  9%     +63.0%       3450 ± 33%  interrupts.CPU177.NMI:Non-maskable_interrupts
      2117 ±  9%     +63.0%       3450 ± 33%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
    763.25 ±  5%     -18.3%     623.25 ±  2%  interrupts.CPU177.TLB:TLB_shootdowns
      2081 ±  8%     +67.6%       3488 ± 31%  interrupts.CPU178.NMI:Non-maskable_interrupts
      2081 ±  8%     +67.6%       3488 ± 31%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    768.25           -22.1%     598.25 ±  3%  interrupts.CPU178.TLB:TLB_shootdowns
      2104 ±  6%     +66.3%       3500 ± 33%  interrupts.CPU179.NMI:Non-maskable_interrupts
      2104 ±  6%     +66.3%       3500 ± 33%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    716.00 ±  3%     -14.4%     613.25 ±  4%  interrupts.CPU179.TLB:TLB_shootdowns
    746.50 ±  8%     -18.3%     610.00 ±  6%  interrupts.CPU18.TLB:TLB_shootdowns
      2130 ±  7%     +64.4%       3501 ± 32%  interrupts.CPU180.NMI:Non-maskable_interrupts
      2130 ±  7%     +64.4%       3501 ± 32%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
      2078 ±  8%     +63.9%       3406 ± 29%  interrupts.CPU181.NMI:Non-maskable_interrupts
      2078 ±  8%     +63.9%       3406 ± 29%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
    795.50           -24.6%     600.00 ±  4%  interrupts.CPU181.TLB:TLB_shootdowns
      2094 ±  9%     +66.3%       3483 ± 31%  interrupts.CPU182.NMI:Non-maskable_interrupts
      2094 ±  9%     +66.3%       3483 ± 31%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
    757.00 ±  5%     -20.4%     602.75 ±  8%  interrupts.CPU182.TLB:TLB_shootdowns
    763.00 ±  4%     -16.6%     636.50 ±  5%  interrupts.CPU183.TLB:TLB_shootdowns
      2544 ± 25%     +40.6%       3576 ± 34%  interrupts.CPU184.NMI:Non-maskable_interrupts
      2544 ± 25%     +40.6%       3576 ± 34%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    772.25 ±  3%     -22.1%     601.75 ±  6%  interrupts.CPU184.TLB:TLB_shootdowns
    745.75 ±  4%     -18.0%     611.75 ±  3%  interrupts.CPU185.TLB:TLB_shootdowns
    764.75 ±  3%     -16.8%     636.50 ±  2%  interrupts.CPU186.TLB:TLB_shootdowns
    712.00 ±  6%     -14.3%     610.00 ±  9%  interrupts.CPU188.TLB:TLB_shootdowns
    771.50 ±  2%     -19.0%     624.75 ±  6%  interrupts.CPU189.TLB:TLB_shootdowns
    763.00 ±  4%     -16.5%     636.75 ±  4%  interrupts.CPU19.TLB:TLB_shootdowns
    719.25 ±  3%     -18.1%     588.75 ±  6%  interrupts.CPU190.TLB:TLB_shootdowns
    758.00           -20.3%     604.25 ± 11%  interrupts.CPU191.TLB:TLB_shootdowns
    745.00 ±  4%     -24.1%     565.50 ±  6%  interrupts.CPU193.TLB:TLB_shootdowns
    713.00 ±  3%     -14.8%     607.25 ±  6%  interrupts.CPU194.TLB:TLB_shootdowns
    717.00 ±  2%     -14.3%     614.75 ±  5%  interrupts.CPU196.TLB:TLB_shootdowns
    722.50 ±  4%     -14.7%     616.50 ±  5%  interrupts.CPU197.TLB:TLB_shootdowns
    833.75 ±  8%     -25.7%     619.25 ±  7%  interrupts.CPU2.TLB:TLB_shootdowns
    748.75 ±  2%     -16.3%     626.75 ±  2%  interrupts.CPU20.TLB:TLB_shootdowns
    719.00 ±  3%     -14.8%     612.25 ±  5%  interrupts.CPU200.TLB:TLB_shootdowns
    753.50 ±  4%     -20.7%     597.25 ±  6%  interrupts.CPU201.TLB:TLB_shootdowns
    752.50 ±  3%     -17.9%     617.50 ±  5%  interrupts.CPU202.TLB:TLB_shootdowns
    747.00 ±  4%     -24.4%     565.00 ±  4%  interrupts.CPU203.TLB:TLB_shootdowns
    725.75 ±  6%     -20.6%     576.00 ±  9%  interrupts.CPU204.TLB:TLB_shootdowns
    750.00 ±  3%     -16.0%     629.75 ±  8%  interrupts.CPU205.TLB:TLB_shootdowns
    778.00 ±  2%     -21.9%     607.25 ±  5%  interrupts.CPU206.TLB:TLB_shootdowns
      2554 ± 28%     +34.4%       3432 ± 32%  interrupts.CPU207.NMI:Non-maskable_interrupts
      2554 ± 28%     +34.4%       3432 ± 32%  interrupts.CPU207.PMI:Performance_monitoring_interrupts
    762.00 ±  4%     -19.8%     611.50 ±  5%  interrupts.CPU207.TLB:TLB_shootdowns
      2611 ± 33%     +34.7%       3517 ± 33%  interrupts.CPU208.NMI:Non-maskable_interrupts
      2611 ± 33%     +34.7%       3517 ± 33%  interrupts.CPU208.PMI:Performance_monitoring_interrupts
    694.50 ±  7%     -17.9%     570.50 ±  6%  interrupts.CPU208.TLB:TLB_shootdowns
    776.50 ±  5%     -20.0%     621.25 ±  3%  interrupts.CPU209.TLB:TLB_shootdowns
    746.25 ±  6%     -17.5%     616.00 ±  9%  interrupts.CPU21.TLB:TLB_shootdowns
    736.00 ±  6%     -19.6%     592.00 ±  9%  interrupts.CPU210.TLB:TLB_shootdowns
    742.25 ±  3%     -16.1%     622.75 ±  2%  interrupts.CPU211.TLB:TLB_shootdowns
    743.00 ±  3%     -17.7%     611.75 ±  6%  interrupts.CPU212.TLB:TLB_shootdowns
    713.50 ±  4%     -14.1%     612.75        interrupts.CPU213.TLB:TLB_shootdowns
    716.00 ±  3%     -15.9%     602.50 ± 10%  interrupts.CPU214.TLB:TLB_shootdowns
    782.00           -16.6%     652.25        interrupts.CPU215.TLB:TLB_shootdowns
    746.50 ±  5%     -10.0%     671.75 ±  5%  interrupts.CPU216.TLB:TLB_shootdowns
    728.25 ±  4%     -15.2%     617.75 ±  4%  interrupts.CPU218.TLB:TLB_shootdowns
    771.75           -18.5%     629.25 ±  7%  interrupts.CPU219.TLB:TLB_shootdowns
    740.75 ±  7%     -14.3%     634.75 ±  8%  interrupts.CPU22.TLB:TLB_shootdowns
    760.25 ±  5%     -18.7%     618.00 ±  4%  interrupts.CPU220.TLB:TLB_shootdowns
    775.00 ±  2%     -24.5%     584.75 ±  6%  interrupts.CPU221.TLB:TLB_shootdowns
    758.75           -17.9%     623.00 ±  4%  interrupts.CPU222.TLB:TLB_shootdowns
    775.00 ±  4%     -22.5%     600.25 ±  5%  interrupts.CPU223.TLB:TLB_shootdowns
    712.75 ±  5%     -19.0%     577.25 ±  7%  interrupts.CPU224.TLB:TLB_shootdowns
    728.25 ±  5%     -15.8%     613.25 ±  6%  interrupts.CPU225.TLB:TLB_shootdowns
      2495 ± 32%     +36.4%       3402 ± 31%  interrupts.CPU226.NMI:Non-maskable_interrupts
      2495 ± 32%     +36.4%       3402 ± 31%  interrupts.CPU226.PMI:Performance_monitoring_interrupts
    782.25 ±  5%     -23.0%     602.25 ±  3%  interrupts.CPU226.TLB:TLB_shootdowns
    737.25 ±  6%     -17.0%     612.25 ±  3%  interrupts.CPU227.TLB:TLB_shootdowns
    780.25 ±  5%     -20.0%     624.00 ±  8%  interrupts.CPU228.TLB:TLB_shootdowns
    750.50 ±  7%     -18.1%     614.75 ±  4%  interrupts.CPU229.TLB:TLB_shootdowns
    786.75 ±  3%     -20.7%     623.75 ±  3%  interrupts.CPU23.TLB:TLB_shootdowns
    768.25 ±  3%     -16.7%     640.00        interrupts.CPU230.TLB:TLB_shootdowns
    737.00 ±  5%     -14.3%     631.75 ±  2%  interrupts.CPU231.TLB:TLB_shootdowns
    745.00 ±  6%     -19.0%     603.50 ±  4%  interrupts.CPU232.TLB:TLB_shootdowns
    758.25 ±  3%     -22.7%     586.50 ±  8%  interrupts.CPU233.TLB:TLB_shootdowns
    748.75 ±  4%     -24.1%     568.50 ±  2%  interrupts.CPU234.TLB:TLB_shootdowns
    746.25 ±  3%     -15.9%     627.25 ±  6%  interrupts.CPU235.TLB:TLB_shootdowns
    720.00 ±  2%     -12.8%     628.00 ±  8%  interrupts.CPU236.TLB:TLB_shootdowns
    752.25 ±  7%     -22.9%     579.75 ±  2%  interrupts.CPU237.TLB:TLB_shootdowns
    750.75 ±  3%     -16.4%     628.00        interrupts.CPU238.TLB:TLB_shootdowns
    708.75 ±  5%     -15.3%     600.50 ±  5%  interrupts.CPU239.TLB:TLB_shootdowns
    759.50 ±  3%     -19.5%     611.25 ±  3%  interrupts.CPU24.TLB:TLB_shootdowns
    729.00 ±  4%     -15.7%     614.25 ±  2%  interrupts.CPU240.TLB:TLB_shootdowns
    769.50 ±  3%     -22.4%     597.00 ±  3%  interrupts.CPU241.TLB:TLB_shootdowns
    757.25 ±  5%     -15.5%     639.75 ±  6%  interrupts.CPU242.TLB:TLB_shootdowns
    733.25 ±  4%     -19.5%     590.00 ±  4%  interrupts.CPU243.TLB:TLB_shootdowns
    743.75 ±  4%     -20.2%     593.25 ±  4%  interrupts.CPU244.TLB:TLB_shootdowns
    744.00 ±  4%     -16.5%     621.50 ±  6%  interrupts.CPU245.TLB:TLB_shootdowns
    739.00 ±  4%     -19.8%     593.00 ±  6%  interrupts.CPU246.TLB:TLB_shootdowns
    779.25 ±  3%     -22.2%     606.50 ±  4%  interrupts.CPU247.TLB:TLB_shootdowns
      4115 ±  5%     +10.8%       4560 ±  2%  interrupts.CPU248.RES:Rescheduling_interrupts
    724.00 ±  4%     -18.4%     591.00 ±  5%  interrupts.CPU248.TLB:TLB_shootdowns
    704.50 ±  3%     -13.3%     611.00 ±  5%  interrupts.CPU249.TLB:TLB_shootdowns
    791.50 ±  5%     -19.9%     633.75 ±  5%  interrupts.CPU25.TLB:TLB_shootdowns
    747.50 ±  3%     -26.0%     553.00 ±  3%  interrupts.CPU250.TLB:TLB_shootdowns
    724.75 ±  2%     -21.1%     572.00 ±  6%  interrupts.CPU251.TLB:TLB_shootdowns
    726.50 ±  7%     -21.5%     570.25 ±  7%  interrupts.CPU252.TLB:TLB_shootdowns
    735.25 ±  4%     -18.7%     597.50 ±  6%  interrupts.CPU253.TLB:TLB_shootdowns
    760.00 ±  5%     -19.3%     613.50 ±  3%  interrupts.CPU254.TLB:TLB_shootdowns
    696.25 ±  4%     -12.4%     609.75 ±  5%  interrupts.CPU255.TLB:TLB_shootdowns
      2191 ±112%     -71.9%     616.50 ±  4%  interrupts.CPU26.TLB:TLB_shootdowns
    737.25 ±  2%     -15.1%     625.75 ±  3%  interrupts.CPU27.TLB:TLB_shootdowns
    797.00 ±  5%     -21.7%     624.25 ±  6%  interrupts.CPU28.TLB:TLB_shootdowns
    780.00 ±  4%     -16.7%     650.00 ±  5%  interrupts.CPU29.TLB:TLB_shootdowns
      2042 ±  3%     +41.1%       2881 ± 33%  interrupts.CPU3.NMI:Non-maskable_interrupts
      2042 ±  3%     +41.1%       2881 ± 33%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    765.50 ±  2%     -21.7%     599.25 ±  4%  interrupts.CPU3.TLB:TLB_shootdowns
    789.25 ±  3%     -15.4%     667.50 ±  4%  interrupts.CPU30.TLB:TLB_shootdowns
    751.75 ±  3%     -16.9%     624.50 ±  2%  interrupts.CPU31.TLB:TLB_shootdowns
    757.75           -15.5%     640.00 ±  6%  interrupts.CPU32.TLB:TLB_shootdowns
    746.00 ±  3%     -16.3%     624.25 ±  4%  interrupts.CPU35.TLB:TLB_shootdowns
    771.00 ±  5%     -22.6%     597.00 ±  6%  interrupts.CPU36.TLB:TLB_shootdowns
    752.50 ±  5%     -21.5%     590.50 ±  7%  interrupts.CPU37.TLB:TLB_shootdowns
    757.00 ±  6%     -21.8%     591.75 ±  7%  interrupts.CPU38.TLB:TLB_shootdowns
      2539 ± 33%     +40.4%       3564 ± 33%  interrupts.CPU39.NMI:Non-maskable_interrupts
      2539 ± 33%     +40.4%       3564 ± 33%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    761.50           -17.5%     628.50 ±  7%  interrupts.CPU4.TLB:TLB_shootdowns
    763.00 ±  5%     -20.2%     609.00 ±  5%  interrupts.CPU40.TLB:TLB_shootdowns
    766.75 ±  3%     -13.4%     664.00 ±  3%  interrupts.CPU41.TLB:TLB_shootdowns
    761.00 ±  3%     -17.9%     624.75 ±  5%  interrupts.CPU42.TLB:TLB_shootdowns
    798.00 ±  2%     -19.3%     644.25 ±  6%  interrupts.CPU44.TLB:TLB_shootdowns
      1631 ± 86%     -62.5%     611.00 ±  6%  interrupts.CPU45.TLB:TLB_shootdowns
    775.25 ±  6%     -18.8%     629.50 ±  3%  interrupts.CPU46.TLB:TLB_shootdowns
    810.75 ±  5%     -27.4%     588.25        interrupts.CPU47.TLB:TLB_shootdowns
    774.00 ±  5%     -21.4%     608.75 ±  5%  interrupts.CPU48.TLB:TLB_shootdowns
    762.25 ±  7%     -18.0%     624.75 ±  4%  interrupts.CPU49.TLB:TLB_shootdowns
    746.75 ±  4%     -15.3%     632.25 ±  3%  interrupts.CPU5.TLB:TLB_shootdowns
    762.75 ±  4%     -12.5%     667.25 ±  2%  interrupts.CPU50.TLB:TLB_shootdowns
    775.50 ±  6%     -16.3%     648.75 ±  7%  interrupts.CPU51.TLB:TLB_shootdowns
    783.00 ±  4%     -22.9%     604.00 ±  4%  interrupts.CPU52.TLB:TLB_shootdowns
    805.50 ±  6%     -21.7%     630.50 ±  7%  interrupts.CPU53.TLB:TLB_shootdowns
    736.25 ±  6%     -14.7%     628.25 ±  5%  interrupts.CPU54.TLB:TLB_shootdowns
    794.25 ±  8%     -19.9%     636.50 ±  3%  interrupts.CPU55.TLB:TLB_shootdowns
    752.25 ±  4%     -19.8%     603.25 ±  4%  interrupts.CPU56.TLB:TLB_shootdowns
    751.75 ±  4%     -17.9%     617.00 ±  5%  interrupts.CPU57.TLB:TLB_shootdowns
    773.00           -21.6%     606.25 ±  6%  interrupts.CPU59.TLB:TLB_shootdowns
    763.75 ±  2%     -14.4%     654.00 ±  4%  interrupts.CPU6.TLB:TLB_shootdowns
    767.50 ±  5%     -18.0%     629.50 ±  5%  interrupts.CPU60.TLB:TLB_shootdowns
    770.50 ±  3%     -21.3%     606.75 ±  7%  interrupts.CPU61.TLB:TLB_shootdowns
    761.25 ±  7%     -22.2%     592.00 ±  2%  interrupts.CPU62.TLB:TLB_shootdowns
    759.50 ±  5%     -14.4%     650.00 ±  4%  interrupts.CPU63.TLB:TLB_shootdowns
    720.50 ±  2%     -18.3%     588.75 ±  4%  interrupts.CPU64.TLB:TLB_shootdowns
    732.50 ±  4%     -12.5%     641.25 ± 10%  interrupts.CPU65.TLB:TLB_shootdowns
    784.00           -24.1%     594.75 ± 11%  interrupts.CPU66.TLB:TLB_shootdowns
    782.50 ±  7%     -18.5%     637.75 ±  6%  interrupts.CPU67.TLB:TLB_shootdowns
    792.25 ±  6%     -22.2%     616.00 ±  9%  interrupts.CPU68.TLB:TLB_shootdowns
    782.50 ±  4%     -23.7%     597.25 ±  6%  interrupts.CPU69.TLB:TLB_shootdowns
    729.75 ±  2%     -18.9%     591.50 ±  4%  interrupts.CPU7.TLB:TLB_shootdowns
    753.50 ±  4%     -14.6%     643.50 ±  3%  interrupts.CPU70.TLB:TLB_shootdowns
    721.50 ±  5%     -15.3%     610.75 ±  6%  interrupts.CPU71.TLB:TLB_shootdowns
    742.00 ±  2%     -15.6%     626.25 ±  4%  interrupts.CPU72.TLB:TLB_shootdowns
    760.00 ±  5%     -15.5%     642.25 ±  8%  interrupts.CPU73.TLB:TLB_shootdowns
      2106 ±  8%     +40.2%       2953 ± 33%  interrupts.CPU74.NMI:Non-maskable_interrupts
      2106 ±  8%     +40.2%       2953 ± 33%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    740.25 ±  3%     -19.6%     595.25 ±  2%  interrupts.CPU75.TLB:TLB_shootdowns
      2074 ±  3%     +38.4%       2871 ± 35%  interrupts.CPU76.NMI:Non-maskable_interrupts
      2074 ±  3%     +38.4%       2871 ± 35%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    727.50 ±  6%     -11.7%     642.25 ±  3%  interrupts.CPU76.TLB:TLB_shootdowns
      4049 ±  5%     +12.4%       4551 ±  4%  interrupts.CPU77.RES:Rescheduling_interrupts
      2089 ±  7%     +13.4%       2368 ±  3%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2089 ±  7%     +13.4%       2368 ±  3%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    736.75 ±  3%     -16.9%     612.50 ±  6%  interrupts.CPU78.TLB:TLB_shootdowns
    727.50 ±  4%     -13.3%     631.00 ±  8%  interrupts.CPU79.TLB:TLB_shootdowns
      3278 ±133%     -81.1%     619.75 ±  8%  interrupts.CPU8.TLB:TLB_shootdowns
    751.50 ±  4%     -20.2%     599.50 ±  2%  interrupts.CPU80.TLB:TLB_shootdowns
    762.75 ±  4%     -23.3%     585.25 ±  4%  interrupts.CPU81.TLB:TLB_shootdowns
    772.25           -23.8%     588.25 ±  6%  interrupts.CPU82.TLB:TLB_shootdowns
    778.50 ±  5%     -26.3%     573.50 ±  5%  interrupts.CPU83.TLB:TLB_shootdowns
    765.00           -25.1%     572.75 ±  3%  interrupts.CPU84.TLB:TLB_shootdowns
    707.25 ±  3%     -15.1%     600.25 ±  3%  interrupts.CPU85.TLB:TLB_shootdowns
    711.50 ±  2%     -17.8%     584.50 ±  3%  interrupts.CPU86.TLB:TLB_shootdowns
    734.75 ±  5%     -14.2%     630.75 ±  8%  interrupts.CPU87.TLB:TLB_shootdowns
    754.75 ±  3%     -18.6%     614.50 ±  5%  interrupts.CPU88.TLB:TLB_shootdowns
    792.00 ±  4%     -21.8%     619.25 ±  4%  interrupts.CPU89.TLB:TLB_shootdowns
    796.25 ± 10%     -20.6%     632.00 ± 11%  interrupts.CPU90.TLB:TLB_shootdowns
    742.50 ±  3%     -18.4%     606.00 ±  5%  interrupts.CPU91.TLB:TLB_shootdowns
    742.75 ±  8%     -15.8%     625.50 ±  6%  interrupts.CPU92.TLB:TLB_shootdowns
    785.00 ± 12%     -19.9%     629.00 ±  3%  interrupts.CPU93.TLB:TLB_shootdowns
    771.00 ±  2%     -20.7%     611.50 ±  4%  interrupts.CPU94.TLB:TLB_shootdowns
    754.25 ±  6%     -16.2%     632.25 ±  7%  interrupts.CPU95.TLB:TLB_shootdowns
    717.25 ±  3%     -16.9%     596.25 ±  5%  interrupts.CPU96.TLB:TLB_shootdowns
    724.25 ±  4%     -18.5%     590.25 ±  6%  interrupts.CPU97.TLB:TLB_shootdowns
    763.75 ±  5%     -20.1%     610.00 ±  6%  interrupts.CPU98.TLB:TLB_shootdowns
    753.75 ±  3%     -20.8%     596.75 ±  6%  interrupts.CPU99.TLB:TLB_shootdowns
    198926           -17.7%     163726 ±  2%  interrupts.TLB:TLB_shootdowns
     48.69 ± 15%     -24.0       24.74 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     48.56 ± 15%     -23.8       24.71 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.90 ± 31%      -6.9        0.00        perf-profile.calltrace.cycles-pp.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.62 ± 12%      -4.9        4.72 ±  8%  perf-profile.calltrace.cycles-pp.page_fault
      9.28 ± 12%      -4.7        4.57 ±  8%  perf-profile.calltrace.cycles-pp.__do_page_fault.page_fault
     21.08 ±  9%      -4.3       16.76 ±  9%  perf-profile.calltrace.cycles-pp.__wake_up_parent.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.08 ±  9%      -4.3       16.76 ±  9%  perf-profile.calltrace.cycles-pp.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.08 ±  9%      -4.3       16.76 ±  9%  perf-profile.calltrace.cycles-pp.do_exit.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.41 ± 12%      -4.2        4.19 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.page_fault
      4.20 ± 38%      -4.2        0.00        perf-profile.calltrace.cycles-pp.__do_munmap.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.17 ± 13%      -4.1        4.08 ±  8%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      3.62 ± 24%      -3.3        0.33 ±105%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.58 ± 24%      -3.2        0.33 ±105%  perf-profile.calltrace.cycles-pp.do_execve.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.83 ± 10%      -3.2       15.67 ±  9%  perf-profile.calltrace.cycles-pp.mmput.do_exit.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64
     18.80 ± 10%      -3.1       15.66 ±  9%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.__ia32_sys_exit_group.__wake_up_parent
      3.40 ± 16%      -2.7        0.68 ± 21%  perf-profile.calltrace.cycles-pp._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.39 ± 12%      -2.7        5.68 ± 10%  perf-profile.calltrace.cycles-pp.__do_execve_file.do_execve.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.71 ± 16%      -2.4        0.32 ±100%  perf-profile.calltrace.cycles-pp.copy_process._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.62 ± 12%      -1.8        3.82 ±  5%  perf-profile.calltrace.cycles-pp.search_binary_handler.__do_execve_file.do_execve.__x64_sys_execve.do_syscall_64
      5.58 ± 12%      -1.8        3.81 ±  5%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.__do_execve_file.do_execve.__x64_sys_execve
      2.29 ± 10%      -1.4        0.84 ± 30%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74 ± 24%      -1.4        1.32 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      2.72 ± 24%      -1.4        1.31 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      2.72 ± 24%      -1.4        1.31 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      2.72 ± 24%      -1.4        1.31 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.93 ±  9%      -1.0        0.90 ±  5%  perf-profile.calltrace.cycles-pp.filemap_map_pages.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      1.97 ± 26%      -1.0        0.98 ±  6%  perf-profile.calltrace.cycles-pp.mwait_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.82 ±  8%      -1.0        0.84 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork
      2.13 ±  7%      -1.0        1.17 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.__ia32_sys_exit_group
      3.37 ± 13%      -1.0        2.42 ±  7%  perf-profile.calltrace.cycles-pp.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file.do_execve
      1.88 ± 27%      -0.9        0.94 ±  6%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.mwait_idle.do_idle.cpu_startup_entry.start_secondary
      5.33 ± 10%      -0.9        4.39 ± 10%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.30 ± 13%      -0.9        2.38 ±  7%  perf-profile.calltrace.cycles-pp.mmput.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file
      2.02 ±  7%      -0.9        1.10 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
      2.61 ±  9%      -0.9        1.75 ± 11%  perf-profile.calltrace.cycles-pp.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      1.69 ± 26%      -0.8        0.85 ±  6%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.mwait_idle.do_idle.cpu_startup_entry
      1.61 ±  6%      -0.8        0.78 ±  5%  perf-profile.calltrace.cycles-pp.do_task_dead.do_exit.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64
      1.61 ±  6%      -0.8        0.78 ±  5%  perf-profile.calltrace.cycles-pp.__sched_text_start.do_task_dead.do_exit.__ia32_sys_exit_group.__wake_up_parent
      1.62 ±  7%      -0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.51 ±  7%      -0.8        0.72 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.do_task_dead.do_exit.__ia32_sys_exit_group
      2.44 ±  9%      -0.8        1.68 ± 11%  perf-profile.calltrace.cycles-pp.wp_page_copy.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fault
      1.46 ±  7%      -0.8        0.70 ±  5%  perf-profile.calltrace.cycles-pp.load_balance.pick_next_task_fair.__sched_text_start.do_task_dead.do_exit
      1.04 ±  6%      -0.7        0.30 ±100%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.__ia32_sys_exit_group
      1.35 ±  7%      -0.7        0.65 ±  5%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.pick_next_task_fair.__sched_text_start.do_task_dead
      0.84 ±  9%      -0.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  9%      -0.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.09 ± 11%      -0.5        1.60 ± 24%  perf-profile.calltrace.cycles-pp.__lru_cache_add.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      2.06 ± 11%      -0.5        1.59 ± 24%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__lru_cache_add.__handle_mm_fault.handle_mm_fault.__do_page_fault
      1.06 ±  9%      -0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.__libc_fork
      1.96 ± 11%      -0.4        1.53 ± 24%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.__handle_mm_fault.handle_mm_fault
      1.96 ± 11%      -0.4        1.53 ± 24%  perf-profile.calltrace.cycles-pp.queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.__handle_mm_fault
      0.99 ± 10%      -0.4        0.57 ±  6%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      1.26 ± 17%      -0.3        0.95 ± 10%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ± 17%      -0.3        0.95 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.25 ± 16%      -0.3        0.95 ± 10%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.22 ± 17%      -0.3        0.94 ± 10%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.65 ±  6%      +0.1        0.77 ±  7%  perf-profile.calltrace.cycles-pp.__vm_munmap.elf_map.load_elf_binary.search_binary_handler.__do_execve_file
      0.64 ±  6%      +0.1        0.77 ±  7%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.elf_map.load_elf_binary.search_binary_handler
      0.60 ±  6%      +0.1        0.73 ±  9%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.exit_mmap.mmput.flush_old_exec
      0.59 ±  6%      +0.1        0.72 ±  7%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.elf_map.load_elf_binary
      0.60 ±  6%      +0.1        0.73 ±  9%  perf-profile.calltrace.cycles-pp.lru_add_drain.exit_mmap.mmput.flush_old_exec.load_elf_binary
      0.56 ±  6%      +0.1        0.70 ±  7%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.elf_map
      0.38 ±101%      +0.5        0.86 ±  2%  perf-profile.calltrace.cycles-pp.div_short
      4.81 ±  3%      +0.5        5.35 ±  4%  perf-profile.calltrace.cycles-pp.do_execve.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.82 ±  3%      +0.5        5.37 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.82 ±  3%      +0.5        5.37 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.82 ±  3%      +0.5        5.37 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.36 ±103%      +0.6        0.91 ±  3%  perf-profile.calltrace.cycles-pp.div_int
      4.83 ±  3%      +0.6        5.39 ±  4%  perf-profile.calltrace.cycles-pp.execve
      0.44 ±101%      +0.7        1.14 ±  3%  perf-profile.calltrace.cycles-pp._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork.fork_test
      0.44 ±101%      +0.7        1.14 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork.fork_test
      0.44 ±101%      +0.7        1.14 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork.fork_test
      0.44 ±101%      +0.7        1.17        perf-profile.calltrace.cycles-pp.do_brk_flags.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.47 ±101%      +0.8        1.22 ±  2%  perf-profile.calltrace.cycles-pp.div_long
      1.07 ± 45%      +0.8        1.86        perf-profile.calltrace.cycles-pp.div_double
      0.52 ±101%      +0.8        1.31 ±  2%  perf-profile.calltrace.cycles-pp.div_float
      0.44 ±101%      +0.9        1.29 ±  9%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault.page_test
      0.53 ±101%      +0.9        1.39 ±  2%  perf-profile.calltrace.cycles-pp.__libc_fork.fork_test
      0.45 ±101%      +0.9        1.31 ±  9%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.page_fault.page_test
      0.47 ±101%      +0.9        1.36 ±  9%  perf-profile.calltrace.cycles-pp.__do_page_fault.page_fault.page_test
      0.47 ±101%      +0.9        1.38 ±  9%  perf-profile.calltrace.cycles-pp.page_fault.page_test
      0.49 ±101%      +0.9        1.43 ±  9%  perf-profile.calltrace.cycles-pp.page_test
      0.59 ±101%      +1.0        1.55 ±  2%  perf-profile.calltrace.cycles-pp.fork_test
      1.79 ± 45%      +1.4        3.19        perf-profile.calltrace.cycles-pp.array_rtns
      1.84 ± 40%      +1.5        3.34 ±  3%  perf-profile.calltrace.cycles-pp.sieve
      0.34 ±102%      +1.7        2.02 ± 15%  perf-profile.calltrace.cycles-pp.add_short.add_short
      1.04 ± 48%      +2.4        3.44 ±  9%  perf-profile.calltrace.cycles-pp.mul_double.mul_double
      0.62 ±101%      +2.7        3.36 ± 15%  perf-profile.calltrace.cycles-pp.add_long.add_long
      0.66 ±103%      +2.8        3.47 ± 10%  perf-profile.calltrace.cycles-pp.mul_float.mul_float
      0.56 ±103%      +2.8        3.40 ± 15%  perf-profile.calltrace.cycles-pp.add_int.add_int
      1.42 ±101%      +3.1        4.53 ±  9%  perf-profile.calltrace.cycles-pp.__do_munmap.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.66 ±102%      +3.2        3.89 ± 14%  perf-profile.calltrace.cycles-pp.string_rtns_1
      0.79 ±102%      +3.5        4.28 ± 16%  perf-profile.calltrace.cycles-pp.add_float.add_float
      2.44 ± 64%      +3.6        6.03 ±  6%  perf-profile.calltrace.cycles-pp.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      2.48 ± 64%      +3.6        6.11 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      2.50 ± 64%      +3.7        6.15 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      2.66 ± 62%      +3.8        6.45 ±  6%  perf-profile.calltrace.cycles-pp.brk
      1.45 ± 61%      +5.1        6.52 ± 14%  perf-profile.calltrace.cycles-pp.add_double.add_double
     63.15 ±  8%     -19.7       43.46 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     62.94 ±  8%     -19.6       43.36 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
     12.51 ±  7%      -4.7        7.79 ±  6%  perf-profile.children.cycles-pp.page_fault
     11.99 ±  7%      -4.5        7.47 ±  7%  perf-profile.children.cycles-pp.__do_page_fault
     21.14 ±  9%      -4.3       16.81 ±  9%  perf-profile.children.cycles-pp.__wake_up_parent
     21.14 ±  9%      -4.3       16.81 ±  9%  perf-profile.children.cycles-pp.__ia32_sys_exit_group
     21.14 ±  9%      -4.3       16.81 ±  9%  perf-profile.children.cycles-pp.do_exit
     22.98 ± 11%      -4.1       18.86 ±  9%  perf-profile.children.cycles-pp.mmput
     22.93 ± 11%      -4.1       18.84 ±  9%  perf-profile.children.cycles-pp.exit_mmap
     11.01 ±  7%      -4.0        6.97 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
     10.70 ±  7%      -3.9        6.79 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      9.35 ±  6%      -3.1        6.26 ±  8%  perf-profile.children.cycles-pp.__se_sys_brk
      5.24 ±  7%      -2.8        2.47 ±  5%  perf-profile.children.cycles-pp.__sched_text_start
      8.46 ± 12%      -2.5        5.93 ±  8%  perf-profile.children.cycles-pp.__x64_sys_execve
      8.41 ± 12%      -2.5        5.90 ±  8%  perf-profile.children.cycles-pp.__do_execve_file
      8.41 ± 12%      -2.5        5.90 ±  8%  perf-profile.children.cycles-pp.do_execve
      4.56 ±  8%      -2.4        2.13 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.51 ±  8%      -2.4        2.11 ±  4%  perf-profile.children.cycles-pp.load_balance
      4.84 ±  7%      -2.4        2.46 ±  7%  perf-profile.children.cycles-pp._do_fork
      5.40 ± 16%      -2.3        3.06 ±  3%  perf-profile.children.cycles-pp.apic_timer_interrupt
     12.99 ± 12%      -2.3       10.71 ±  9%  perf-profile.children.cycles-pp.__do_munmap
      4.20 ±  8%      -2.3        1.94 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      4.95 ± 15%      -2.3        2.69 ±  4%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
     12.40 ± 12%      -2.0       10.40 ± 10%  perf-profile.children.cycles-pp.unmap_region
      6.93 ± 12%      -1.9        5.05 ±  8%  perf-profile.children.cycles-pp.search_binary_handler
      6.89 ± 12%      -1.9        5.03 ±  8%  perf-profile.children.cycles-pp.load_elf_binary
      3.76 ±  7%      -1.9        1.89 ±  7%  perf-profile.children.cycles-pp.copy_process
      3.32 ±  8%      -1.8        1.55 ±  5%  perf-profile.children.cycles-pp.schedule
      2.79 ±  8%      -1.5        1.31 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
      2.74 ± 24%      -1.4        1.32 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64
      2.74 ± 24%      -1.4        1.32 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
      2.74 ± 24%      -1.4        1.32 ±  6%  perf-profile.children.cycles-pp.do_idle
      2.72 ± 24%      -1.4        1.31 ±  6%  perf-profile.children.cycles-pp.start_secondary
      2.88 ±  7%      -1.4        1.47 ±  9%  perf-profile.children.cycles-pp.dup_mm
      3.00 ±  7%      -1.4        1.65 ±  5%  perf-profile.children.cycles-pp.unmap_vmas
      2.79 ±  8%      -1.3        1.48 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      2.86 ±  7%      -1.3        1.56 ±  5%  perf-profile.children.cycles-pp.unmap_page_range
      5.58 ± 13%      -1.2        4.37 ±  8%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      2.30 ±  8%      -1.2        1.11 ±  4%  perf-profile.children.cycles-pp.do_sys_open
      5.50 ± 13%      -1.2        4.32 ±  8%  perf-profile.children.cycles-pp.do_mmap
      5.31 ± 13%      -1.1        4.22 ±  8%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.05 ±  8%      -1.1        0.96 ±  5%  perf-profile.children.cycles-pp.__se_sys_wait4
      2.04 ±  8%      -1.1        0.96 ±  5%  perf-profile.children.cycles-pp.kernel_wait4
      2.02 ±  8%      -1.1        0.95 ±  5%  perf-profile.children.cycles-pp.do_wait
      2.13 ± 27%      -1.1        1.06 ±  6%  perf-profile.children.cycles-pp.mwait_idle
      5.26 ± 14%      -1.1        4.19 ±  9%  perf-profile.children.cycles-pp.mmap_region
      2.06 ±  9%      -1.1        1.01 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      2.01 ±  8%      -1.0        0.98 ±  4%  perf-profile.children.cycles-pp.path_openat
      4.23 ± 13%      -1.0        3.23 ±  9%  perf-profile.children.cycles-pp.flush_old_exec
      2.19 ± 13%      -1.0        1.20 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.96 ±  7%      -0.9        1.01 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      1.63 ±  8%      -0.9        0.77 ± 15%  perf-profile.children.cycles-pp.down_write
      2.93 ±  8%      -0.9        2.08 ±  9%  perf-profile.children.cycles-pp.do_wp_page
      1.76 ±  7%      -0.8        0.92 ± 13%  perf-profile.children.cycles-pp.free_pgtables
      1.61 ±  6%      -0.8        0.78 ±  5%  perf-profile.children.cycles-pp.do_task_dead
      1.84 ± 20%      -0.8        1.01 ±  4%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.62 ±  7%      -0.8        0.82 ±  4%  perf-profile.children.cycles-pp.kthread
      1.57 ±  8%      -0.8        0.79 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap
      1.63 ± 17%      -0.8        0.87 ±  6%  perf-profile.children.cycles-pp.irq_exit
      2.73 ±  8%      -0.8        1.97 ±  9%  perf-profile.children.cycles-pp.wp_page_copy
      1.67 ± 11%      -0.8        0.92 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.45 ±  8%      -0.7        0.75 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      1.39 ±  9%      -0.7        0.71 ±  6%  perf-profile.children.cycles-pp.__vma_adjust
      1.19 ± 10%      -0.6        0.54 ± 20%  perf-profile.children.cycles-pp.rwsem_down_write_failed
      1.42 ±  7%      -0.6        0.77 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.19 ± 20%      -0.6        0.55 ± 19%  perf-profile.children.cycles-pp.ksys_write
      1.32 ±  9%      -0.6        0.70 ±  3%  perf-profile.children.cycles-pp.filename_lookup
      1.14 ± 19%      -0.6        0.52 ± 19%  perf-profile.children.cycles-pp.vfs_write
      1.25 ±  9%      -0.6        0.67 ±  3%  perf-profile.children.cycles-pp.path_lookupat
      1.06 ± 18%      -0.6        0.49 ± 19%  perf-profile.children.cycles-pp.new_sync_write
      3.71 ± 10%      -0.6        3.15 ± 12%  perf-profile.children.cycles-pp.__lru_cache_add
      1.30 ± 28%      -0.6        0.74 ±  5%  perf-profile.children.cycles-pp.rcu_core
      1.13 ±  9%      -0.5        0.58 ±  3%  perf-profile.children.cycles-pp.walk_component
      1.00 ± 10%      -0.5        0.47 ± 21%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.07 ±  9%      -0.5        0.55 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.99 ± 17%      -0.5        0.47 ±  5%  perf-profile.children.cycles-pp.update_nohz_stats
      0.98 ±  8%      -0.5        0.47 ±  2%  perf-profile.children.cycles-pp.vma_merge
      1.08 ±  8%      -0.5        0.58 ±  4%  perf-profile.children.cycles-pp.alloc_set_pte
      0.94 ±  4%      -0.5        0.44 ± 25%  perf-profile.children.cycles-pp.try_to_wake_up
      0.99 ±  7%      -0.5        0.49 ±  6%  perf-profile.children.cycles-pp.alloc_pages_vma
      1.02 ±  5%      -0.5        0.54 ±  6%  perf-profile.children.cycles-pp.wake_up_new_task
      0.89 ±  7%      -0.5        0.41 ±  6%  perf-profile.children.cycles-pp.source_load
      1.05 ± 11%      -0.5        0.59 ±  2%  perf-profile.children.cycles-pp.setlocale
      0.95 ±  8%      -0.5        0.49 ±  6%  perf-profile.children.cycles-pp.copy_page_range
      0.90 ±  6%      -0.4        0.45 ±  5%  perf-profile.children.cycles-pp.anon_vma_fork
      0.99 ± 10%      -0.4        0.57 ±  6%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.91 ±  9%      -0.4        0.49 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      0.92 ±  9%      -0.4        0.51 ±  8%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.92 ±  9%      -0.4        0.51 ±  8%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.84 ±  8%      -0.4        0.44 ±  4%  perf-profile.children.cycles-pp.vfs_read
      0.87 ± 10%      -0.4        0.48 ±  9%  perf-profile.children.cycles-pp.__split_vma
      0.78 ±  7%      -0.4        0.39 ±  7%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.94 ±  8%      -0.4        0.55 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.87 ±  9%      -0.4        0.48 ±  8%  perf-profile.children.cycles-pp.mprotect_fixup
      0.91 ±  8%      -0.4        0.53 ±  7%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.78 ±  7%      -0.4        0.40 ±  8%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.61 ±  8%      -0.4        0.25 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.77 ±  8%      -0.4        0.41 ±  6%  perf-profile.children.cycles-pp.page_remove_rmap
      0.75 ±  6%      -0.4        0.40 ±  4%  perf-profile.children.cycles-pp.ksys_read
      1.49 ± 14%      -0.3        1.15 ±  8%  perf-profile.children.cycles-pp.elf_map
      0.73 ±  8%      -0.3        0.39 ±  5%  perf-profile.children.cycles-pp.___might_sleep
      0.75 ±  9%      -0.3        0.41 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.77 ± 10%      -0.3        0.42 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      0.69 ±  7%      -0.3        0.34 ±  5%  perf-profile.children.cycles-pp.anon_vma_clone
      0.64 ±  9%      -0.3        0.30 ±  5%  perf-profile.children.cycles-pp.new_sync_read
      0.66 ±  8%      -0.3        0.33 ±  8%  perf-profile.children.cycles-pp.find_vma
      1.34 ± 13%      -0.3        1.01 ±  8%  perf-profile.children.cycles-pp.load_script
      0.66 ±  9%      -0.3        0.36 ±  4%  perf-profile.children.cycles-pp.wait4
      0.57 ± 12%      -0.3        0.27 ± 33%  perf-profile.children.cycles-pp.osq_lock
      0.71 ± 11%      -0.3        0.40 ±  2%  perf-profile.children.cycles-pp.__se_sys_newstat
      0.63 ±  6%      -0.3        0.33 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.64 ±  5%      -0.3        0.34 ±  5%  perf-profile.children.cycles-pp.target_load
      0.77 ±  7%      -0.3        0.48 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.62 ± 10%      -0.3        0.33 ±  5%  perf-profile.children.cycles-pp.do_faccessat
      0.61 ±  7%      -0.3        0.32 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      0.64 ±  9%      -0.3        0.35 ± 14%  perf-profile.children.cycles-pp.unlink_file_vma
      0.52 ±  9%      -0.3        0.26 ±  6%  perf-profile.children.cycles-pp.lookup_slow
      0.46 ±  8%      -0.3        0.20 ±  8%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.54 ±  7%      -0.3        0.28 ±  7%  perf-profile.children.cycles-pp._cond_resched
      0.46 ± 13%      -0.3        0.21 ± 47%  perf-profile.children.cycles-pp.rwsem_wake
      0.60 ± 11%      -0.3        0.35 ±  6%  perf-profile.children.cycles-pp.copy_strings
      0.53 ±  9%      -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.52 ±  8%      -0.2        0.27 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      0.53 ±  8%      -0.2        0.28 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      0.44 ± 14%      -0.2        0.20 ± 45%  perf-profile.children.cycles-pp.wake_up_q
      0.45 ±  8%      -0.2        0.21 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
      0.45 ±  6%      -0.2        0.23 ±  9%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.52 ±  9%      -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.sched_exec
      0.46 ± 13%      -0.2        0.24 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.45 ± 49%      -0.2        0.23 ± 37%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.44 ± 10%      -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.__lookup_slow
      0.57 ±  9%      -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.41 ±  8%      -0.2        0.20 ±  4%  perf-profile.children.cycles-pp.get_unmapped_area
      0.47 ± 10%      -0.2        0.27 ±  5%  perf-profile.children.cycles-pp.mmap64
      0.42 ± 10%      -0.2        0.22 ±  7%  perf-profile.children.cycles-pp.__might_sleep
      0.56 ± 10%      -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.dput
      0.39 ±  7%      -0.2        0.19 ±  4%  perf-profile.children.cycles-pp.cpumask_next_and
      0.37 ±  9%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.43 ±  9%      -0.2        0.24 ±  6%  perf-profile.children.cycles-pp.__clear_user
      0.41 ±  8%      -0.2        0.22 ±  5%  perf-profile.children.cycles-pp.prep_new_page
      0.31 ±  8%      -0.2        0.12 ±  9%  perf-profile.children.cycles-pp.pipe_write
      0.40 ±  8%      -0.2        0.21 ±  6%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.42 ±  9%      -0.2        0.24 ±  6%  perf-profile.children.cycles-pp.padzero
      0.48 ±  9%      -0.2        0.30 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.38 ± 11%      -0.2        0.20 ±  7%  perf-profile.children.cycles-pp.pte_alloc_one
      0.36 ± 10%      -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.33 ±  7%      -0.2        0.15 ±  5%  perf-profile.children.cycles-pp.find_next_and_bit
      0.33 ± 10%      -0.2        0.16 ±  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.31 ± 10%      -0.2        0.14 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.55 ± 12%      -0.2        0.39 ± 10%  perf-profile.children.cycles-pp.__lock_text_start
      0.46 ±  9%      -0.2        0.30 ±  7%  perf-profile.children.cycles-pp.__fput
      0.34 ±  8%      -0.2        0.18 ±  4%  perf-profile.children.cycles-pp.lock_page_memcg
      0.34 ±  9%      -0.2        0.18 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.33 ± 10%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.38 ± 11%      -0.2        0.21 ± 12%  perf-profile.children.cycles-pp.vma_link
      0.33 ±  8%      -0.2        0.17 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      0.32 ± 10%      -0.2        0.16 ±  7%  perf-profile.children.cycles-pp.vmacache_find
      0.32 ±  5%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.28 ±  7%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.32 ±  9%      -0.2        0.16 ±  7%  perf-profile.children.cycles-pp.wake_up_page_bit
      0.32 ±  5%      -0.2        0.16 ±  6%  perf-profile.children.cycles-pp.do_signal
      0.27 ±  8%      -0.2        0.12 ± 11%  perf-profile.children.cycles-pp.pipe_read
      0.26 ± 19%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.ktime_get
      0.30 ± 10%      -0.2        0.15 ±  8%  perf-profile.children.cycles-pp.wait_consider_task
      0.30 ± 11%      -0.2        0.15 ±  4%  perf-profile.children.cycles-pp.vma_gap_update
      0.35 ± 10%      -0.2        0.20 ±  2%  perf-profile.children.cycles-pp._dl_addr
      0.32 ±  8%      -0.2        0.17 ±  7%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.30 ±  9%      -0.2        0.15 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_try_charge_delay
      0.27 ± 10%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.down_write_killable
      0.27 ± 17%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.32 ± 12%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.24 ±  7%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      0.31 ± 10%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.remove_vma
      0.39 ±  6%      -0.1        0.25 ±  7%  perf-profile.children.cycles-pp.do_unlinkat
      0.24 ±  8%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.pipe_wait
      0.26 ±  9%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.sock_write_iter
      0.34 ±  9%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp._fini
      0.30 ± 10%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.schedule_tail
      0.25 ± 10%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.sock_sendmsg
      0.36 ±  7%      -0.1        0.23 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.29 ±  9%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.25 ± 10%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.release_task
      0.24 ± 10%      -0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__pte_alloc
      0.21 ±  9%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.23 ± 11%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__se_sys_getdents
      0.30 ± 11%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.sync
      0.30 ± 11%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.30 ± 11%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.ksys_sync
      0.27 ± 10%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.28 ± 10%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.cpumask_next
      0.20 ±  8%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.25 ±  9%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.terminate_walk
      0.22 ± 12%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.iterate_dir
      0.20 ± 17%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.idle_cpu
      0.24 ±  9%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.__do_fault
      0.27 ± 10%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.iterate_supers
      0.21 ± 11%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.dcache_readdir
      0.26 ±  9%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.find_next_bit
      0.29 ± 10%      -0.1        0.17 ±  6%  perf-profile.children.cycles-pp.__get_user_pages
      0.28 ±  9%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.27 ±  9%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.__put_user_4
      0.24 ± 10%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.__get_free_pages
      0.24 ± 10%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      0.24 ±  7%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.23 ±  9%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.23 ± 12%      -0.1        0.12        perf-profile.children.cycles-pp.vma_compute_subtree_gap
      0.23 ±  9%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.23 ±  3%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.21 ±  5%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.24 ±  9%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.__slab_free
      0.23 ± 11%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.21 ±  7%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.23 ± 11%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.20 ±  9%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.filemap_fault
      0.14 ± 24%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.free_work
      0.25 ± 11%      -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.16 ± 11%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.21 ± 10%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.path_put
      0.21 ± 13%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.18 ±  7%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
      0.18 ±  8%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.strlcpy
      0.14 ± 24%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.__vunmap
      0.20 ± 10%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.copy_page
      0.16 ±  9%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__se_sys_kill
      0.15 ± 22%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.process_one_work
      0.23 ±  8%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.17 ± 25%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.32 ± 11%      -0.1        0.23 ± 11%  perf-profile.children.cycles-pp.dentry_kill
      0.17 ±  8%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.up_write
      0.16 ±  6%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ip_finish_output2
      0.20 ± 10%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.19 ±  3%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp._vm_normal_page
      0.17 ± 12%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.19 ± 15%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.strnlen_user
      0.23 ±  6%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.11 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__se_sys_newlstat
      0.19 ± 16%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.do_open_execat
      0.30 ± 12%      -0.1        0.22 ± 11%  perf-profile.children.cycles-pp.__dentry_kill
      0.18 ±  8%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.16 ±  9%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.17 ± 10%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.xas_find
      0.16 ± 11%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.16 ±  8%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.activate_task
      0.15 ±  8%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.find_vma_links
      0.14 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.sock_read_iter
      0.15 ± 12%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.filldir
      0.15 ±  9%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.11 ± 13%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.kill_pid_info
      0.16 ±  7%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.d_path
      0.15 ± 10%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.15 ± 16%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.clockevents_program_event
      0.15 ±  5%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.unlock_page
      0.14 ±  8%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.14 ± 11%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.10 ± 10%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.process_backlog
      0.16 ± 11%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.mark_page_accessed
      0.15 ± 10%      -0.1        0.08        perf-profile.children.cycles-pp.update_rq_clock
      0.16 ±  9%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.change_protection
      0.15 ± 10%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.15 ±  8%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__put_anon_vma
      0.14 ± 10%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.io_schedule
      0.14 ± 11%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__lock_page_killable
      0.13 ± 28%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.10 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
      0.16 ± 11%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.15 ± 12%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.unlazy_walk
      0.15 ± 11%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__x64_sys_connect
      0.15 ± 11%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__sys_connect
      0.13 ±  9%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.10 ± 11%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.tcp_write_xmit
      0.18 ±  8%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.16 ±  9%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.btrfs_sync_fs
      0.17 ± 12%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.do_notify_parent
      0.16 ±  9%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.do_writepages
      0.14 ±  7%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp._IO_file_open
      0.14 ± 11%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.14 ±  9%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.mm_init
      0.12 ± 11%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__send_signal
      0.16 ± 11%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.setup_arg_pages
      0.15 ±  8%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.sync_regs
      0.14 ±  7%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.simple_lookup
      0.15 ± 11%      -0.1        0.08        perf-profile.children.cycles-pp.__vma_link_rb
      0.14 ± 13%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.strncpy_from_user
      0.14 ±  8%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.free_pgd_range
      0.14 ± 15%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.do_dentry_open
      0.13 ± 14%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.12 ± 10%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.do_truncate
      0.11 ±  8%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.get_signal
      0.09 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.perf_event_task_output
      0.09 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.unix_find_other
      0.12 ±  7%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.do_softirq
      0.15 ± 10%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_compare
      0.15 ± 10%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.btree_writepages
      0.16 ± 11%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.copy_strings_kernel
      0.14 ± 11%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.time
      0.13 ± 12%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.unix_stream_connect
      0.12 ±  8%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.perf_event_task
      0.12 ± 10%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tcp_sendmsg
      0.12 ± 10%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__ip_queue_xmit
      0.10 ± 10%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.__call_rcu
      0.09 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.09 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__rb_erase_color
      0.09 ± 14%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.12 ± 11%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
      0.11 ±  9%      -0.1        0.05        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.15 ± 10%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.09 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__strcasecmp
      0.09 ± 10%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.12 ±  4%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.find_get_entry
      0.12 ± 13%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.path_init
      0.12 ±  9%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__se_sys_close
      0.12 ±  7%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.fsnotify
      0.11 ± 11%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.14 ±  9%      -0.1        0.08        perf-profile.children.cycles-pp.trailing_symlink
      0.11 ± 11%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__bitmap_weight
      0.08 ± 10%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.vm_area_alloc
      0.14 ±  8%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.connect
      0.13 ± 11%      -0.1        0.07        perf-profile.children.cycles-pp.pagecache_get_page
      0.12 ± 10%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.12 ±  8%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__pmd_alloc
      0.12 ± 12%      -0.1        0.06        perf-profile.children.cycles-pp.kernel_read
      0.12 ± 12%      -0.1        0.06        perf-profile.children.cycles-pp.kfree
      0.15 ± 10%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.getenv
      0.12 ± 30%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.rcu_irq_enter
      0.11 ± 10%      -0.1        0.05        perf-profile.children.cycles-pp.khugepaged_enter_vma_merge
      0.11 ± 10%      -0.1        0.05        perf-profile.children.cycles-pp.net_rx_action
      0.08 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.d_alloc
      0.08 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.finish_fault
      0.13 ±  5%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.d_add
      0.12 ± 15%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.open_exec
      0.12 ±  8%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.pgd_alloc
      0.18 ±  6%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.malloc
      0.08 ± 10%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__alloc_fd
      0.11 ± 10%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__alloc_file
      0.11 ±  4%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.10 ± 15%      -0.1        0.05        perf-profile.children.cycles-pp.sched_clock
      0.12 ± 13%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.user_path_at_empty
      0.12 ± 10%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__pud_alloc
      0.12 ± 17%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.11 ± 13%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.legitimize_path
      0.09 ±  7%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.__vsnprintf_chk
      0.09 ±  7%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.filp_close
      0.11 ± 10%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.10 ±  8%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.10 ±  7%      -0.1        0.05        perf-profile.children.cycles-pp.ttwu_do_activate
      0.10 ±  8%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.24 ± 13%      -0.0        0.19 ±  8%  perf-profile.children.cycles-pp.getpwuid_r
      0.12 ± 11%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp._copy_from_user
      0.12 ± 10%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.shift_arg_pages
      0.12 ± 13%      -0.0        0.07        perf-profile.children.cycles-pp.__fxstat64
      0.12 ±  7%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.11 ± 16%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.09 ± 16%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.mem_cgroup_throttle_swaprate
      0.14 ± 10%      -0.0        0.09        perf-profile.children.cycles-pp.strlen
      0.10 ± 10%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__d_lookup_done
      0.09 ±  5%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.stop_one_cpu
      0.11 ±  9%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.11 ±  9%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.11 ± 14%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_user_arg_ptr
      0.11 ± 14%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.complete_walk
      0.11 ± 14%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.touch_atime
      0.10 ± 12%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__se_sys_newfstat
      0.10 ±  7%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.prepend_path
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.10 ± 15%      -0.0        0.05        perf-profile.children.cycles-pp.native_sched_clock
      0.10 ±  8%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.__follow_mount_rcu
      0.10 ± 10%      -0.0        0.06        perf-profile.children.cycles-pp.__update_load_avg_se
      0.09 ± 11%      -0.0        0.05        perf-profile.children.cycles-pp.unmap_single_vma
      0.09 ± 11%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.atime_needs_update
      0.09 ±  8%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.09 ± 13%      -0.0        0.05        perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.09 ± 22%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.09 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.count
      0.09 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      0.10 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.09 ± 12%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.09 ±  9%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.decay_load
      0.09 ± 22%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.09 ± 11%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.open64
      0.07 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._exit
      0.08 ±  5%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.vsnprintf
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp._IO_vfscanf
      0.25            +0.0        0.30 ± 10%  perf-profile.children.cycles-pp.munmap
      0.01 ±173%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.compar1
      0.01 ±173%      +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.vsscanf
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.sighandler
      0.21 ± 20%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.read
      0.04 ±102%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.mem_rtns_1
      0.00            +0.1        0.09 ± 21%  perf-profile.children.cycles-pp.__ctype_tolower_loc
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.__ctype_toupper_loc
      0.02 ±173%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.__waitpid
      0.12 ± 46%      +0.2        0.28 ±  4%  perf-profile.children.cycles-pp.close
      0.21 ± 42%      +0.2        0.38 ±  2%  perf-profile.children.cycles-pp.write
      0.07 ±102%      +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.unlink
      0.26 ± 43%      +0.2        0.46 ±  3%  perf-profile.children.cycles-pp.creat
      0.26 ± 49%      +0.2        0.48 ±  3%  perf-profile.children.cycles-pp.wait
      0.07 ± 72%      +0.3        0.33 ±  9%  perf-profile.children.cycles-pp.exec_test
      0.55 ± 38%      +0.3        0.86        perf-profile.children.cycles-pp.div_short
      0.52 ± 40%      +0.4        0.91 ±  3%  perf-profile.children.cycles-pp.div_int
      0.68 ± 39%      +0.5        1.22 ±  2%  perf-profile.children.cycles-pp.div_long
      0.73 ± 44%      +0.6        1.31 ±  2%  perf-profile.children.cycles-pp.div_float
      4.86 ±  3%      +0.6        5.50 ±  4%  perf-profile.children.cycles-pp.execve
      1.08 ± 45%      +0.8        1.87 ±  2%  perf-profile.children.cycles-pp.div_double
      0.76 ± 57%      +0.8        1.56 ±  2%  perf-profile.children.cycles-pp.fork_test
      0.61 ± 65%      +0.8        1.46 ±  9%  perf-profile.children.cycles-pp.page_test
      1.80 ± 45%      +1.4        3.20        perf-profile.children.cycles-pp.array_rtns
      1.85 ± 40%      +1.5        3.35 ±  3%  perf-profile.children.cycles-pp.sieve
      0.45 ± 53%      +1.6        2.03 ± 15%  perf-profile.children.cycles-pp.add_short
      1.04 ± 48%      +2.4        3.45 ± 10%  perf-profile.children.cycles-pp.mul_double
      0.79 ± 59%      +2.6        3.37 ± 15%  perf-profile.children.cycles-pp.add_long
      0.89 ± 53%      +2.6        3.48 ± 10%  perf-profile.children.cycles-pp.mul_float
      0.75 ± 52%      +2.7        3.42 ± 15%  perf-profile.children.cycles-pp.add_int
      0.87 ± 58%      +3.1        3.95 ± 14%  perf-profile.children.cycles-pp.string_rtns_1
      1.03 ± 57%      +3.3        4.29 ± 16%  perf-profile.children.cycles-pp.add_float
      2.68 ± 62%      +3.8        6.48 ±  6%  perf-profile.children.cycles-pp.brk
      1.45 ± 61%      +5.1        6.55 ± 14%  perf-profile.children.cycles-pp.add_double
      1.87 ±  8%      -1.0        0.86 ±  5%  perf-profile.self.cycles-pp.find_busiest_group
      1.38 ±  8%      -0.6        0.73 ±  3%  perf-profile.self.cycles-pp.filemap_map_pages
      1.40 ±  6%      -0.6        0.77 ±  6%  perf-profile.self.cycles-pp.unmap_page_range
      0.98 ± 17%      -0.5        0.47 ±  4%  perf-profile.self.cycles-pp.update_nohz_stats
      0.88 ±  7%      -0.5        0.41 ±  7%  perf-profile.self.cycles-pp.source_load
      0.82 ±  6%      -0.4        0.46 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.72 ±  8%      -0.3        0.39 ±  5%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.70 ±  8%      -0.3        0.38 ±  5%  perf-profile.self.cycles-pp.___might_sleep
      0.60 ±  7%      -0.3        0.29 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.56 ± 12%      -0.3        0.26 ± 33%  perf-profile.self.cycles-pp.osq_lock
      0.62 ±  5%      -0.3        0.33 ±  6%  perf-profile.self.cycles-pp.target_load
      0.58 ±  9%      -0.3        0.31 ±  7%  perf-profile.self.cycles-pp.page_remove_rmap
      0.51 ±  8%      -0.2        0.26 ±  9%  perf-profile.self.cycles-pp.copy_page_range
      0.50 ± 10%      -0.2        0.26 ±  6%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.49 ±  9%      -0.2        0.27 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.45 ±  6%      -0.2        0.23 ±  9%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.43 ±  9%      -0.2        0.21 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap
      0.44 ± 13%      -0.2        0.23 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.45 ±  6%      -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.49 ± 26%      -0.2        0.28 ±  4%  perf-profile.self.cycles-pp.smp_apic_timer_interrupt
      0.36 ±  7%      -0.2        0.16 ±  9%  perf-profile.self.cycles-pp.try_to_wake_up
      0.44 ±  7%      -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.alloc_set_pte
      0.39 ±  9%      -0.2        0.20 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.36 ±  7%      -0.2        0.18 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.38 ± 10%      -0.2        0.19 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.34 ±  6%      -0.2        0.16 ± 10%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.34 ± 10%      -0.2        0.17 ±  3%  perf-profile.self.cycles-pp.__vma_adjust
      0.34 ± 10%      -0.2        0.18 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.33 ±  7%      -0.2        0.17 ±  5%  perf-profile.self.cycles-pp.__do_page_fault
      0.32 ± 10%      -0.2        0.16 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.31 ±  8%      -0.2        0.15 ±  5%  perf-profile.self.cycles-pp.find_next_and_bit
      0.32 ±  7%      -0.2        0.16 ±  5%  perf-profile.self.cycles-pp.lock_page_memcg
      0.32 ±  8%      -0.2        0.16 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.30 ±  5%      -0.2        0.15 ± 10%  perf-profile.self.cycles-pp.find_vma
      0.30 ± 10%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.vmacache_find
      0.34 ± 10%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp._dl_addr
      0.30 ±  4%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.27 ± 33%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.mwait_idle
      0.27 ± 12%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.27 ±  8%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.28 ±  7%      -0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.21 ± 19%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.ktime_get
      0.20 ± 17%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.idle_cpu
      0.27 ±  7%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.handle_mm_fault
      0.21 ±  7%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.22 ± 13%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.vma_compute_subtree_gap
      0.24 ± 10%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.find_next_bit
      0.21 ±  9%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp._cond_resched
      0.20 ±  9%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.23 ±  9%      -0.1        0.13 ±  7%  perf-profile.self.cycles-pp.__slab_free
      0.22 ±  8%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.20 ±  9%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.vma_merge
      0.18 ± 11%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__se_sys_brk
      0.20 ± 21%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.24 ± 13%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.21 ± 13%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.18 ±  6%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.strlcpy
      0.20 ±  5%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.20 ±  8%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.rcu_all_qs
      0.19 ±  6%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.down_write
      0.21 ±  8%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.20 ±  4%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.22 ±  9%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.20 ±  8%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.19 ± 10%      -0.1        0.10 ±  7%  perf-profile.self.cycles-pp.copy_page
      0.16 ±  9%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.do_brk_flags
      0.18 ± 15%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.18 ± 10%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.link_path_walk
      0.16 ±  9%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.up_write
      0.16 ± 11%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.17 ±  2%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp._vm_normal_page
      0.15 ±  7%      -0.1        0.07        perf-profile.self.cycles-pp.find_vma_links
      0.13 ±  5%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.load_balance
      0.10 ±  8%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.16 ± 10%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.14 ± 26%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.15 ± 14%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.strnlen_user
      0.15 ±  8%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.sync_regs
      0.13 ±  3%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.unlock_page
      0.12 ±  6%      -0.1        0.06        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.09 ±  7%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.queued_read_lock_slowpath
      0.11 ± 14%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.__bitmap_weight
      0.15 ±  7%      -0.1        0.08 ± 15%  perf-profile.self.cycles-pp.wp_page_copy
      0.13 ±  9%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.path_openat
      0.10 ± 10%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.down_write_killable
      0.09 ±  9%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.11 ±  4%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.fsnotify
      0.10 ±  8%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.get_unmapped_area
      0.14 ± 10%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.mark_page_accessed
      0.11 ± 11%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__sched_text_start
      0.10 ±  8%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.vma_gap_update
      0.11 ±  9%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.kfree
      0.08 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.vm_area_dup
      0.11 ±  9%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.dup_mm
      0.10 ± 11%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.copy_process
      0.08 ±  8%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.prep_new_page
      0.11 ± 11%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.lookup_fast
      0.09 ±  4%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.11 ± 11%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.change_protection
      0.11 ± 18%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__lock_text_start
      0.08 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.12 ± 15%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.anon_vma_clone
      0.11 ± 11%      -0.1        0.06        perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.09 ±  9%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.update_rq_clock
      0.09 ± 26%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.rcu_irq_enter
      0.08 ±  5%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.10 ± 11%      -0.0        0.05        perf-profile.self.cycles-pp.walk_component
      0.10 ± 17%      -0.0        0.05        perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.10 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.__unlock_page_memcg
      0.12 ± 11%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.inode_permission
      0.10 ±  8%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.10 ±  9%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.do_wp_page
      0.11 ±  7%      -0.0        0.07        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.08 ± 14%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.task_tick_fair
      0.09 ± 13%      -0.0        0.05        perf-profile.self.cycles-pp.mem_cgroup_charge_statistics
      0.11 ± 10%      -0.0        0.07        perf-profile.self.cycles-pp.strlen
      0.09 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.decay_load
      0.13 ±  6%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.malloc
      0.10 ± 10%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.06 ±  9%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.vfprintf
      0.01 ±173%      +0.0        0.05 ±  9%  perf-profile.self.cycles-pp.compar1
      0.04 ±102%      +0.1        0.09        perf-profile.self.cycles-pp.brk
      0.04 ±102%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.mem_rtns_1
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.__ctype_tolower_loc
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.__ctype_toupper_loc
      0.55 ± 38%      +0.3        0.85 ±  2%  perf-profile.self.cycles-pp.div_short
      0.52 ± 40%      +0.4        0.90 ±  3%  perf-profile.self.cycles-pp.div_int
      0.67 ± 40%      +0.5        1.20 ±  2%  perf-profile.self.cycles-pp.div_long
      0.72 ± 44%      +0.6        1.29 ±  2%  perf-profile.self.cycles-pp.div_float
      1.06 ± 45%      +0.8        1.83        perf-profile.self.cycles-pp.div_double
      1.77 ± 45%      +1.4        3.15        perf-profile.self.cycles-pp.array_rtns
      1.83 ± 40%      +1.5        3.30 ±  3%  perf-profile.self.cycles-pp.sieve
      0.44 ± 53%      +1.5        1.98 ± 15%  perf-profile.self.cycles-pp.add_short
      1.02 ± 48%      +2.4        3.38 ±  9%  perf-profile.self.cycles-pp.mul_double
      0.78 ± 59%      +2.5        3.30 ± 15%  perf-profile.self.cycles-pp.add_long
      0.87 ± 52%      +2.5        3.42 ± 10%  perf-profile.self.cycles-pp.mul_float
      0.74 ± 52%      +2.6        3.34 ± 15%  perf-profile.self.cycles-pp.add_int
      0.85 ± 58%      +3.0        3.86 ± 14%  perf-profile.self.cycles-pp.string_rtns_1
      1.01 ± 57%      +3.2        4.21 ± 16%  perf-profile.self.cycles-pp.add_float
      1.43 ± 61%      +5.0        6.42 ± 14%  perf-profile.self.cycles-pp.add_double


                                                                                
                                reaim.time.user_time                            
                                                                                
  33500 +-+-----------------------------------------------------------------+   
        |+  + + ++ +  +  + ++  +  +++             + +  + ++  +  ++   ++++ + |   
  33000 +-+ : : :: :  :  : ::  :  :::             : :  : ::  :  ::   :  : : |   
  32500 +-+::: :  :::: :: :: :: :::  :           ::: :: :: :: :: :: :    : :|   
        | ++++ +  ++++ ++ ++ ++ +++  ++++++ ++++++++ ++ ++ ++ ++ ++++    + +|   
  32000 +-+                                +                                |   
  31500 +-+                                                                 |   
        |                                                                   |   
  31000 +-+                                                                 |   
  30500 +-+                                                                 |   
        |O  O                                                               |   
  30000 +-+   OOOOOO O      OOOO  OOOO                                      |   
  29500 +-+                                                                 |   
        O OOOO     OO OOOOOO      O   O                                     |   
  29000 +-+---------------------OO------------------------------------------+   
                                                                                
                                                                                                                                                                
                               reaim.time.system_time                           
                                                                                
  22000 +-+-----------------------------------------------------------------+   
        |   OO                                                              |   
  21000 OOOOO                                                               |   
  20000 +-+                                                                 |   
        |        OO OO OOOOO      OO O                                      |   
  19000 +-+   OOO  O  O     O O OOO O O                                     |   
  18000 +-+                  O O                                            |   
        |                                                                   |   
  17000 +-+                                                                 |   
  16000 +-+                                                                 |   
        |                                                                   |   
  15000 +-+                                                                 |   
  14000 +-+ ++     +  + +  +   + +    ++  + +   ++  + +  +   + +  +         |   
        |+ ++ ++++++ + + ++++ + + ++++  ++++ +++  ++ + ++++ + + ++ +  + ++++|   
  13000 +-+-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       reaim.time.percent_of_cpu_this_job_got                   
                                                                                
  16800 +-+-----------------------------------------------------------------+   
        |   OO                                                              |   
  16600 OOOOO                                                               |   
  16400 +-+                                                                 |   
        |                                                                   |   
  16200 +-+            OOOOO                                                |   
  16000 +-+   OOOOOOOOO    OO O O OO OO                                     |   
        |                    O O OO O                                       |   
  15800 +-+                                                                 |   
  15600 +-+                                                                 |   
        |                                                                   |   
  15400 +-+  +          +        +                    +        +            |   
  15200 +-+ + : ++++  ++ : +   ++ :+   +  + ++ +++  ++ : +   ++ :++         |   
        |+++  ++   +++   ++ +++   + +++ ++++  +   ++   ++ +++   ++ ++ ++++++|   
  15000 +-+-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             reaim.time.minor_page_faults                       
                                                                                
  1.62e+08 +-+--------------------------------------------------------------+   
   1.6e+08 +-++  + +  +  + + ++  + + ++            + +  ++ +  + + +  ++++++ |   
           |: :  : :  :  : : ::  : : ::            : :  :: :  : : :  :   :: |   
  1.58e+08 +-+::: : :: :::: : ::: :::  :          : : :: :: :::: : ::    : :|   
  1.56e+08 +-++++ + ++ ++++ + +++ +++  ++++++++++++ + ++ ++ ++++ + ++    + +|   
           |                                                                |   
  1.54e+08 +-+                                                              |   
  1.52e+08 +-+                                                              |   
   1.5e+08 +-+                                                              |   
           |                                                                |   
  1.48e+08 +O+O  OOOOO  O     OOOO O OOO                                    |   
  1.46e+08 +-+                                                              |   
           |                                                                |   
  1.44e+08 O-OOOO     OO OOOOOO   OOO   O                                   |   
  1.42e+08 +-+--------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 reaim.parent_time                              
                                                                                
  6.6 +-+-------------------------------------------------------------------+   
      |                                                                     |   
  6.5 +-+O O       O     OO                                                 |   
  6.4 OOO O    O  O OOOOO      O OO OO                                      |   
      |     OOO OO              O  O                                        |   
  6.3 +-+                  OOOO                                             |   
  6.2 +-+                                                                   |   
      |                                                                     |   
  6.1 +-+                                                                   |   
    6 +-+                                                                   |   
      |                                                                     |   
  5.9 +-+                                                                   |   
  5.8 +-+                            ++  + +  ++                   +     + +|   
      |+++++ + ++++++++ + ++++++ + ++  ++++ ++  ++++++ + ++++++ + + :+   :+ |   
  5.7 +-+-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                reaim.child_systime                             
                                                                                
  650 +-+-------------------------------------------------------------------+   
      |                                                                     |   
  600 +-+O O                                                                |   
      OOO O                                                                 |   
  550 +-+         OO OOOOOO    O    OO                                      |   
      |     OOOOOO  O      O O OOOOO                                        |   
  500 +-+                   O O                                             |   
      |                                                                     |   
  450 +-+                                                                   |   
      |                                                                     |   
  400 +-+                                                                   |   
      |    +    ++    +   +    +     ++  ++++ +++    +   +    +   +         |   
  350 +-++++++++  ++++ +++ ++++++++++  +++   +   ++++ +++ ++++ +++ +++++ +++|   
      |                                                                 +   |   
  300 +-+-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 reaim.jobs_per_min                             
                                                                                
  265000 +-+----------------------------------------------------------------+   
         |     +          +       +                    +        +      +    |   
  260000 +-++++ ++++++++++++++++++ ++++  +    +  ++++++ ++++++++ ++ +++ +++ |   
  255000 +-+                           ++ +++++++                 ++     + +|   
         |                                                                  |   
  250000 +-+                                                                |   
         |                                                                  |   
  245000 +-+                                                                |   
         |                                                                  |   
  240000 +-+                                                                |   
  235000 +-+   OO  O         OOOO                                           |   
         OO O    OOOO O O O     O OOOOOO                                    |   
  230000 +-OOOO      O O OOOO    O                                          |   
         |                                                                  |   
  225000 +-+----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             reaim.jobs_per_min_child                           
                                                                                
  1040 +-+------------------------------------------------------------------+   
       |                                                                    |   
  1020 +-+++ ++++  ++++ +++ ++++ +++++        +  ++++++++ ++++++++  +++++ + |   
  1000 +-+  +    ++    +   +    +    + +++++ ++ +     +  +     +  ++     + +|   
       |                              +     +  +                            |   
   980 +-+                                                                  |   
       |                                                                    |   
   960 +-+                                                                  |   
       |                                                                    |   
   940 +-+                                                                  |   
   920 +-+   O              OOO                                             |   
       |O  O  OOOOOOO            OOOOO                                      |   
   900 O-OO         OOOOOOOO   OO                                           |   
       |   OO                                                               |   
   880 +-+------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               reaim.max_jobs_per_min                           
                                                                                
  280000 +-+----------------------------------------------------------------+   
         | +   + + + +    +++ +   + +            + +   + +++    + +   +     |   
  275000 +-+: + ::+++ :  +:: + : + :::  +      + :+ : + :: +:  + :: ++ ++   |   
  270000 +-+++  +     +++ +    ++  + ++ :++ +++ :   ++  +   +++  +: :    +++|   
         |                             +   +    +                 +:        |   
  265000 +-+                                                       +        |   
  260000 +-+                                                                |   
         |                                                                  |   
  255000 +-+                                                                |   
  250000 +-+            O O  O O                                            |   
         |            O    O  O O    O                                      |   
  245000 +-+   OOOOO        O   OO OO                                       |   
  240000 OOOO O     OO O OO       O   OO                                    |   
         |   O                                                              |   
  235000 +-+----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   reaim.workload                               
                                                                                
   1e+06 +-+----------------------------------------------------------------+   
         |: :  : :: :  :  :: :  : : ::            :  : : : : :  : :  :   :: |   
  980000 +-+::: :  : :: ::: : :::: :  :          : :::: : ::: :: :: :    : :|   
         | ++++ +  + ++ +++ + ++++ +  ++++++++++++ ++++ + +++ ++ ++++    + +|   
         |                                                                  |   
  960000 +-+                                                                |   
         |                                                                  |   
  940000 +-+                                                                |   
         |                                                                  |   
  920000 +O+O  OOOOO  O      OOOO O OOO                                     |   
         |                                                                  |   
         |                                                                  |   
  900000 O-OOOO     OO OOOOOO   OO O   O                                    |   
         |                                                                  |   
  880000 +-+----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-knl-f1: 256 threads Knights Landing with 96G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-7/performance/x86_64-kexec/100%/debian-x86_64-2018-04-03.cgz/300s/lkp-knl-f1/custom/reaim

commit: 
  132bb8cfc9 ("mm/vmscan: add tracepoints for node reclaim")
  e0ee0e7107 ("mm: memcontrol: track LRU counts in the vmstats array")

132bb8cfc9e08123 e0ee0e71078abbcadd4cbc38fb8 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at_ip_rwsem_down_write_failed/0x
          0:4           -4%           0:4     perf-profile.children.cycles-pp.error_entry
          0:4           -2%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      1237           +16.4%       1440        reaim.child_systime
    493.27            -1.9%     483.74        reaim.child_utime
    160864            -6.4%     150564        reaim.jobs_per_min
    628.38            -6.4%     588.14        reaim.jobs_per_min_child
    165870            -4.9%     157763        reaim.max_jobs_per_min
      9.07            +6.8%       9.69        reaim.parent_time
      4.38            -4.7%       4.17        reaim.std_dev_percent
    303.71            +1.6%     308.61        reaim.time.elapsed_time
    303.71            +1.6%     308.61        reaim.time.elapsed_time.max
   1065525            +4.4%    1112193        reaim.time.involuntary_context_switches
 1.476e+08            -3.6%  1.423e+08        reaim.time.minor_page_faults
     15406            +5.4%      16231        reaim.time.percent_of_cpu_this_job_got
     33460           +12.1%      37503        reaim.time.system_time
     13332            -5.6%      12591        reaim.time.user_time
   3982248            -2.4%    3885242        reaim.time.voluntary_context_switches
    691200            -3.7%     665600        reaim.workload
      0.10 ± 13%      +0.0        0.13 ±  5%  mpstat.cpu.all.soft%
    738.00 ±  4%     -12.7%     644.25 ±  7%  slabinfo.pool_workqueue.active_objs
    877.25            +4.7%     918.25        turbostat.Avg_MHz
     23998           +36.0%      32648 ± 14%  meminfo.Inactive
     23802           +36.4%      32468 ± 14%  meminfo.Inactive(anon)
     40841 ±  2%     +24.6%      50883 ± 10%  meminfo.Mapped
     23996           +36.1%      32656 ± 14%  numa-meminfo.node0.Inactive
     23800           +36.5%      32476 ± 14%  numa-meminfo.node0.Inactive(anon)
     31597 ±  2%     +31.3%      41475 ± 12%  numa-meminfo.node0.Mapped
      5950           +36.8%       8137 ± 15%  numa-vmstat.node0.nr_inactive_anon
      7926 ±  2%     +31.5%      10420 ± 13%  numa-vmstat.node0.nr_mapped
      5950           +36.8%       8137 ± 15%  numa-vmstat.node0.nr_zone_inactive_anon
     38.00            -8.6%      34.75        vmstat.cpu.id
     17.00            -5.9%      16.00        vmstat.cpu.us
     43525            -8.9%      39670        vmstat.system.cs
     98219            +2.2%     100365        proc-vmstat.nr_anon_pages
      5950           +36.5%       8122 ± 14%  proc-vmstat.nr_inactive_anon
     10199 ±  2%     +24.8%      12727 ± 10%  proc-vmstat.nr_mapped
      4738            +2.6%       4860        proc-vmstat.nr_page_table_pages
     32778            +1.8%      33362        proc-vmstat.nr_slab_reclaimable
      5950           +36.5%       8122 ± 14%  proc-vmstat.nr_zone_inactive_anon
 1.351e+08            -3.8%    1.3e+08        proc-vmstat.numa_hit
 1.351e+08            -3.8%    1.3e+08        proc-vmstat.numa_local
     11249          +135.1%      26444 ± 31%  proc-vmstat.pgactivate
 1.393e+08            -3.8%   1.34e+08        proc-vmstat.pgalloc_normal
 1.486e+08            -3.6%  1.432e+08        proc-vmstat.pgfault
 1.392e+08            -3.8%  1.339e+08        proc-vmstat.pgfree
     12135            -8.5%      11102        softirqs.CPU103.SCHED
     10997 ±  4%      -9.9%       9911        softirqs.CPU105.RCU
     12084            -8.8%      11026 ±  2%  softirqs.CPU107.SCHED
     11362 ±  4%      -7.6%      10496 ±  3%  softirqs.CPU13.RCU
     11108 ±  3%      -9.8%      10022 ±  2%  softirqs.CPU138.RCU
     11863 ±  3%      -8.5%      10850 ±  2%  softirqs.CPU166.SCHED
     12082 ±  3%      -8.8%      11020 ±  3%  softirqs.CPU176.SCHED
     12278 ±  3%      -8.7%      11214 ±  3%  softirqs.CPU180.SCHED
     11364 ±  2%      -8.1%      10447        softirqs.CPU19.RCU
     11916            -8.4%      10916 ±  2%  softirqs.CPU229.SCHED
     11917 ±  3%      -6.3%      11163        softirqs.CPU237.SCHED
     24555           +14.3%      28073 ±  9%  softirqs.CPU62.TIMER
     11934 ±  3%      -8.3%      10938 ±  3%  softirqs.CPU88.SCHED
     12130 ±  4%      -8.6%      11089        softirqs.CPU91.SCHED
    382134 ±  7%     -17.3%     315992 ±  6%  sched_debug.cfs_rq:/.load.stddev
      2321 ±  8%     -19.4%       1871 ±  7%  sched_debug.cfs_rq:/.load_avg.max
    362.14 ±  6%     -20.7%     287.21 ±  6%  sched_debug.cfs_rq:/.load_avg.stddev
    113433 ± 10%     +19.5%     135582        sched_debug.cfs_rq:/.min_vruntime.avg
      0.36 ±  7%     -17.2%       0.30 ±  6%  sched_debug.cfs_rq:/.nr_running.stddev
      1660 ± 11%     -25.7%       1234 ± 13%  sched_debug.cfs_rq:/.runnable_load_avg.max
    382831 ±  7%     -17.5%     315857 ±  6%  sched_debug.cfs_rq:/.runnable_weight.stddev
    -15729           -38.6%      -9661        sched_debug.cfs_rq:/.spread0.avg
      1328           -11.8%       1172 ±  5%  sched_debug.cfs_rq:/.util_avg.max
      3.60 ± 37%     -66.4%       1.21 ± 20%  sched_debug.cfs_rq:/.util_avg.min
     83.47 ± 16%     -40.9%      49.34 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    928.92           -20.4%     739.50 ± 14%  sched_debug.cfs_rq:/.util_est_enqueued.max
    143.09 ±  5%     -25.6%     106.43 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    296723           +10.2%     327081 ±  6%  sched_debug.cpu.avg_idle.stddev
      1612 ±  6%     -20.0%       1289 ±  4%  sched_debug.cpu.cpu_load[0].max
    145794 ±  4%     -19.5%     117398 ±  2%  sched_debug.cpu.curr->pid.max
     54164 ± 10%     -37.7%      33724 ±  3%  sched_debug.cpu.curr->pid.stddev
    382014 ±  7%     -18.0%     313316 ±  7%  sched_debug.cpu.load.stddev
     29683 ±  9%     +17.0%      34729        sched_debug.cpu.nr_load_updates.avg
     34848 ±  7%     +13.2%      39440        sched_debug.cpu.nr_load_updates.max
      2.10 ±  4%      -8.7%       1.92 ±  7%  sched_debug.cpu.nr_running.max
      0.37 ±  7%     -18.3%       0.30 ±  7%  sched_debug.cpu.nr_running.stddev
     21.80 ±  6%     +12.9%      24.62 ±  2%  sched_debug.cpu.nr_uninterruptible.stddev
     37.47            -5.1%      35.58        perf-stat.i.MPKI
 1.101e+10            +3.5%   1.14e+10        perf-stat.i.branch-instructions
      3.14            -0.1        3.02        perf-stat.i.branch-miss-rate%
 3.006e+08            -1.9%  2.949e+08        perf-stat.i.branch-misses
     28.84            -0.3       28.52        perf-stat.i.cache-miss-rate%
  5.44e+08            -5.0%  5.166e+08        perf-stat.i.cache-misses
 1.608e+09            -4.0%  1.544e+09        perf-stat.i.cache-references
     40600           -10.1%      36480        perf-stat.i.context-switches
      5.32            +2.0%       5.43        perf-stat.i.cpi
 2.146e+11            +3.7%  2.225e+11        perf-stat.i.cpu-cycles
      8829            -2.7%       8594        perf-stat.i.cpu-migrations
    613.87            +9.8%     674.08        perf-stat.i.cycles-between-cache-misses
  64777117            -5.9%   60975942        perf-stat.i.iTLB-load-misses
 4.035e+10            +1.3%  4.086e+10        perf-stat.i.iTLB-loads
 4.052e+10            +1.3%  4.105e+10        perf-stat.i.instructions
    564.50            +5.9%     598.00        perf-stat.i.instructions-per-iTLB-miss
      0.21            -2.1%       0.20        perf-stat.i.ipc
    443323            -6.7%     413740        perf-stat.i.minor-faults
    446984            -6.3%     418725        perf-stat.i.page-faults
     37.89            -7.2%      35.14        perf-stat.overall.MPKI
      2.66            -0.2        2.49        perf-stat.overall.branch-miss-rate%
     32.69            -0.7       32.02        perf-stat.overall.cache-miss-rate%
      5.42            +3.4%       5.60        perf-stat.overall.cpi
    437.32           +13.8%     497.60        perf-stat.overall.cycles-between-cache-misses
      0.17            -0.0        0.15        perf-stat.overall.iTLB-load-miss-rate%
    605.56            +7.1%     648.47        perf-stat.overall.instructions-per-iTLB-miss
      0.18            -3.3%       0.18        perf-stat.overall.ipc
  17899119            +6.7%   19106380        perf-stat.overall.path-length
 1.145e+10            +4.3%  1.193e+10        perf-stat.ps.branch-instructions
 3.048e+08            -2.6%  2.968e+08        perf-stat.ps.branch-misses
 5.101e+08            -8.0%  4.693e+08        perf-stat.ps.cache-misses
  1.56e+09            -6.1%  1.466e+09        perf-stat.ps.cache-references
     43547            -9.0%      39648        perf-stat.ps.context-switches
 2.231e+11            +4.7%  2.335e+11        perf-stat.ps.cpu-cycles
  68011741            -5.4%   64313813        perf-stat.ps.iTLB-load-misses
  4.11e+10            +1.3%  4.164e+10        perf-stat.ps.iTLB-loads
 4.118e+10            +1.3%  4.171e+10        perf-stat.ps.instructions
    478582            -5.3%     452988        perf-stat.ps.minor-faults
    479075            -5.3%     453567        perf-stat.ps.page-faults
 1.237e+13            +2.8%  1.272e+13        perf-stat.total.instructions
   1283034            -3.6%    1236666        interrupts.CAL:Function_call_interrupts
      2603 ± 35%     +50.3%       3913 ± 24%  interrupts.CPU1.NMI:Non-maskable_interrupts
      2603 ± 35%     +50.3%       3913 ± 24%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    602.00 ±  5%     -14.3%     516.00 ±  5%  interrupts.CPU10.TLB:TLB_shootdowns
      2050 ±  6%     +50.3%       3082 ± 26%  interrupts.CPU100.NMI:Non-maskable_interrupts
      2050 ±  6%     +50.3%       3082 ± 26%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    581.50 ±  7%     -17.6%     479.00 ±  8%  interrupts.CPU102.TLB:TLB_shootdowns
    557.50 ±  4%     -13.5%     482.25 ±  3%  interrupts.CPU103.TLB:TLB_shootdowns
    574.50 ±  3%     -18.5%     468.50 ±  5%  interrupts.CPU106.TLB:TLB_shootdowns
      2218 ±  5%     +10.3%       2448 ±  3%  interrupts.CPU108.RES:Rescheduling_interrupts
    564.25 ±  6%     -16.1%     473.50 ± 10%  interrupts.CPU108.TLB:TLB_shootdowns
      2225 ±  3%     +13.5%       2525 ±  3%  interrupts.CPU109.RES:Rescheduling_interrupts
    581.75 ±  7%     -22.8%     449.00 ±  6%  interrupts.CPU110.TLB:TLB_shootdowns
      2220           +12.1%       2489 ±  4%  interrupts.CPU111.RES:Rescheduling_interrupts
    530.00 ±  3%     -10.5%     474.25 ±  5%  interrupts.CPU111.TLB:TLB_shootdowns
      2262           +10.9%       2508 ±  5%  interrupts.CPU113.RES:Rescheduling_interrupts
    571.00           -11.7%     504.00        interrupts.CPU113.TLB:TLB_shootdowns
    541.75 ±  5%     -11.7%     478.50 ±  5%  interrupts.CPU114.TLB:TLB_shootdowns
      2243 ±  2%      +9.2%       2451 ±  5%  interrupts.CPU118.RES:Rescheduling_interrupts
    569.50 ±  7%     -13.5%     492.50 ±  6%  interrupts.CPU119.TLB:TLB_shootdowns
      2289            +9.2%       2499 ±  2%  interrupts.CPU12.RES:Rescheduling_interrupts
    547.75           -15.1%     465.25 ±  8%  interrupts.CPU12.TLB:TLB_shootdowns
    532.75 ±  4%      -9.3%     483.25        interrupts.CPU120.TLB:TLB_shootdowns
      2948 ± 34%     +47.0%       4334 ±  5%  interrupts.CPU121.NMI:Non-maskable_interrupts
      2948 ± 34%     +47.0%       4334 ±  5%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    557.75 ±  3%     -14.9%     474.75 ±  2%  interrupts.CPU121.TLB:TLB_shootdowns
      2221           +10.7%       2458 ±  3%  interrupts.CPU123.RES:Rescheduling_interrupts
      2222 ±  4%     +10.5%       2455 ±  4%  interrupts.CPU124.RES:Rescheduling_interrupts
    539.00 ±  6%      -9.0%     490.25 ±  7%  interrupts.CPU125.TLB:TLB_shootdowns
      2277            +9.2%       2488 ±  2%  interrupts.CPU126.RES:Rescheduling_interrupts
    578.25 ±  5%     -13.3%     501.50 ±  7%  interrupts.CPU126.TLB:TLB_shootdowns
    565.75 ±  4%     -15.6%     477.25 ±  3%  interrupts.CPU127.TLB:TLB_shootdowns
      2233 ±  2%     +10.4%       2464 ±  5%  interrupts.CPU128.RES:Rescheduling_interrupts
    551.00 ±  3%     -13.4%     477.00 ±  2%  interrupts.CPU128.TLB:TLB_shootdowns
    568.25 ±  5%     -17.1%     471.00 ±  7%  interrupts.CPU129.TLB:TLB_shootdowns
      2105 ±  2%     +86.3%       3922 ± 21%  interrupts.CPU13.NMI:Non-maskable_interrupts
      2105 ±  2%     +86.3%       3922 ± 21%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    582.25 ±  5%     -12.4%     510.00 ±  8%  interrupts.CPU130.TLB:TLB_shootdowns
      2218 ±  3%     +12.9%       2504 ±  7%  interrupts.CPU132.RES:Rescheduling_interrupts
    556.00 ±  4%     -10.8%     495.75 ±  7%  interrupts.CPU132.TLB:TLB_shootdowns
    551.00 ±  3%     -11.2%     489.25 ±  4%  interrupts.CPU133.TLB:TLB_shootdowns
    580.75 ±  6%     -19.3%     468.75 ±  4%  interrupts.CPU135.TLB:TLB_shootdowns
    562.00 ±  4%     -17.7%     462.50        interrupts.CPU136.TLB:TLB_shootdowns
    536.25 ±  7%      -9.4%     485.75 ±  2%  interrupts.CPU137.TLB:TLB_shootdowns
      2331 ±  4%     +12.3%       2616 ±  5%  interrupts.CPU14.RES:Rescheduling_interrupts
    566.25 ±  5%     -13.7%     488.75 ± 10%  interrupts.CPU140.TLB:TLB_shootdowns
      2652 ± 40%     +67.8%       4451 ±  4%  interrupts.CPU141.NMI:Non-maskable_interrupts
      2652 ± 40%     +67.8%       4451 ±  4%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    594.00 ±  6%     -17.6%     489.25 ±  8%  interrupts.CPU141.TLB:TLB_shootdowns
      2179 ±  4%     +13.2%       2466 ±  4%  interrupts.CPU143.RES:Rescheduling_interrupts
    557.50 ±  5%     -13.8%     480.50 ±  5%  interrupts.CPU143.TLB:TLB_shootdowns
    569.25 ±  4%      -9.9%     513.00 ±  5%  interrupts.CPU145.TLB:TLB_shootdowns
    581.75 ±  7%     -17.5%     480.00        interrupts.CPU147.TLB:TLB_shootdowns
    538.75 ±  6%      -9.3%     488.75 ±  2%  interrupts.CPU15.TLB:TLB_shootdowns
      2191 ±  4%     +10.2%       2414 ±  3%  interrupts.CPU150.RES:Rescheduling_interrupts
    565.50 ±  7%     -17.4%     467.00 ±  7%  interrupts.CPU153.TLB:TLB_shootdowns
    529.75 ±  4%     -12.5%     463.75 ±  7%  interrupts.CPU155.TLB:TLB_shootdowns
      2127 ±  2%     +15.5%       2457 ±  4%  interrupts.CPU156.RES:Rescheduling_interrupts
    555.75 ±  8%     -18.1%     455.00 ±  3%  interrupts.CPU157.TLB:TLB_shootdowns
    573.50 ±  9%     -17.5%     473.25 ±  4%  interrupts.CPU158.TLB:TLB_shootdowns
      2079           +60.8%       3344 ± 33%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2079           +60.8%       3344 ± 33%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      3694 ± 24%     -43.7%       2078 ±  6%  interrupts.CPU160.NMI:Non-maskable_interrupts
      3694 ± 24%     -43.7%       2078 ±  6%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
      2072 ±  3%     +46.2%       3029 ± 26%  interrupts.CPU161.NMI:Non-maskable_interrupts
      2072 ±  3%     +46.2%       3029 ± 26%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
    531.00           -10.2%     477.00 ±  2%  interrupts.CPU161.TLB:TLB_shootdowns
    545.25 ±  3%     -15.6%     460.25 ±  8%  interrupts.CPU162.TLB:TLB_shootdowns
    561.00 ±  5%     -20.7%     444.75 ±  7%  interrupts.CPU163.TLB:TLB_shootdowns
    543.75 ±  8%     -14.5%     465.00 ±  6%  interrupts.CPU166.TLB:TLB_shootdowns
    584.75 ± 10%     -16.2%     490.25 ±  4%  interrupts.CPU167.TLB:TLB_shootdowns
    550.50 ±  4%     -10.3%     494.00 ±  7%  interrupts.CPU168.TLB:TLB_shootdowns
    545.25 ±  8%     -20.7%     432.25 ±  3%  interrupts.CPU169.TLB:TLB_shootdowns
      2572 ± 31%     +29.1%       3321 ± 34%  interrupts.CPU17.NMI:Non-maskable_interrupts
      2572 ± 31%     +29.1%       3321 ± 34%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    550.00 ±  2%     -16.0%     461.75 ±  6%  interrupts.CPU170.TLB:TLB_shootdowns
    549.00 ±  6%     -12.6%     479.75 ±  6%  interrupts.CPU172.TLB:TLB_shootdowns
      2229 ±  4%     +15.0%       2563 ±  3%  interrupts.CPU173.RES:Rescheduling_interrupts
    560.75 ±  3%     -13.6%     484.50 ±  9%  interrupts.CPU173.TLB:TLB_shootdowns
    535.75 ±  4%     -11.2%     475.75 ±  6%  interrupts.CPU174.TLB:TLB_shootdowns
    560.00 ±  9%     -14.1%     481.25 ±  3%  interrupts.CPU175.TLB:TLB_shootdowns
    534.50 ±  4%     -13.7%     461.25 ±  2%  interrupts.CPU176.TLB:TLB_shootdowns
    547.25 ±  4%     -12.4%     479.25 ±  3%  interrupts.CPU177.TLB:TLB_shootdowns
      2152           +13.3%       2438 ±  3%  interrupts.CPU178.RES:Rescheduling_interrupts
    532.00 ±  5%     -11.7%     469.50 ±  4%  interrupts.CPU179.TLB:TLB_shootdowns
    620.25 ±  9%     -11.6%     548.50 ±  3%  interrupts.CPU18.TLB:TLB_shootdowns
    547.50 ±  5%     -14.1%     470.50 ±  7%  interrupts.CPU181.TLB:TLB_shootdowns
      2185 ±  2%     +18.0%       2578 ±  6%  interrupts.CPU182.RES:Rescheduling_interrupts
    545.25 ±  6%     -14.4%     466.50 ±  3%  interrupts.CPU182.TLB:TLB_shootdowns
    543.00 ±  6%      -9.5%     491.50 ±  5%  interrupts.CPU183.TLB:TLB_shootdowns
    567.75 ±  2%     -17.6%     467.75 ±  3%  interrupts.CPU184.TLB:TLB_shootdowns
    533.25 ±  4%     -13.5%     461.00 ±  6%  interrupts.CPU185.TLB:TLB_shootdowns
      2211 ±  5%     +10.9%       2453 ±  3%  interrupts.CPU186.RES:Rescheduling_interrupts
      2237 ±  3%      +8.4%       2426 ±  4%  interrupts.CPU187.RES:Rescheduling_interrupts
      2293 ±  3%      +8.6%       2490 ±  4%  interrupts.CPU189.RES:Rescheduling_interrupts
    557.25 ±  3%     -16.8%     463.50 ±  2%  interrupts.CPU191.TLB:TLB_shootdowns
    533.75 ±  7%     -11.4%     472.75 ±  6%  interrupts.CPU193.TLB:TLB_shootdowns
      3709 ± 23%     -44.1%       2074 ±  8%  interrupts.CPU194.NMI:Non-maskable_interrupts
      3709 ± 23%     -44.1%       2074 ±  8%  interrupts.CPU194.PMI:Performance_monitoring_interrupts
    535.25 ±  2%     -14.0%     460.25 ±  4%  interrupts.CPU194.TLB:TLB_shootdowns
      2518 ± 34%     +48.5%       3739 ± 26%  interrupts.CPU196.NMI:Non-maskable_interrupts
      2518 ± 34%     +48.5%       3739 ± 26%  interrupts.CPU196.PMI:Performance_monitoring_interrupts
    567.25 ±  7%     -12.7%     495.25 ±  5%  interrupts.CPU196.TLB:TLB_shootdowns
    550.50 ±  5%     -15.3%     466.50 ±  9%  interrupts.CPU198.TLB:TLB_shootdowns
    581.00 ±  4%     -16.0%     488.00 ±  7%  interrupts.CPU199.TLB:TLB_shootdowns
      2145           +50.9%       3236 ± 28%  interrupts.CPU2.NMI:Non-maskable_interrupts
      2145           +50.9%       3236 ± 28%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      3704 ± 23%     -40.7%       2196 ±  7%  interrupts.CPU20.NMI:Non-maskable_interrupts
      3704 ± 23%     -40.7%       2196 ±  7%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      2236 ±  4%     +13.9%       2546 ±  2%  interrupts.CPU20.RES:Rescheduling_interrupts
      2319            +8.8%       2523 ±  5%  interrupts.CPU201.RES:Rescheduling_interrupts
      2214 ±  7%     +13.8%       2520 ±  2%  interrupts.CPU204.RES:Rescheduling_interrupts
    548.00 ±  8%      -8.1%     503.75 ±  6%  interrupts.CPU205.TLB:TLB_shootdowns
      2561 ± 34%     +47.2%       3771 ± 25%  interrupts.CPU206.NMI:Non-maskable_interrupts
      2561 ± 34%     +47.2%       3771 ± 25%  interrupts.CPU206.PMI:Performance_monitoring_interrupts
      2065 ±  3%     +23.1%       2543 ±  9%  interrupts.CPU207.RES:Rescheduling_interrupts
      4366 ±  8%     -51.3%       2127 ± 10%  interrupts.CPU208.NMI:Non-maskable_interrupts
      4366 ±  8%     -51.3%       2127 ± 10%  interrupts.CPU208.PMI:Performance_monitoring_interrupts
      2167 ±  3%     +15.2%       2498 ±  3%  interrupts.CPU208.RES:Rescheduling_interrupts
    683.25 ± 36%     -34.7%     446.00 ± 10%  interrupts.CPU208.TLB:TLB_shootdowns
    555.50 ±  8%     -11.7%     490.25 ±  8%  interrupts.CPU209.TLB:TLB_shootdowns
      2132 ±  2%     +17.5%       2506 ±  3%  interrupts.CPU21.RES:Rescheduling_interrupts
    576.25 ±  5%     -17.5%     475.50 ±  9%  interrupts.CPU210.TLB:TLB_shootdowns
    542.75 ±  4%     -14.9%     462.00 ±  5%  interrupts.CPU212.TLB:TLB_shootdowns
      2127 ±  4%     +16.1%       2470 ±  7%  interrupts.CPU213.RES:Rescheduling_interrupts
    544.00 ±  2%     -11.8%     480.00 ±  7%  interrupts.CPU213.TLB:TLB_shootdowns
    576.75 ±  6%     -16.3%     483.00 ±  5%  interrupts.CPU214.TLB:TLB_shootdowns
    565.75 ±  7%     -10.4%     506.75 ±  4%  interrupts.CPU218.TLB:TLB_shootdowns
      2262 ±  3%     +13.3%       2563 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
    616.25 ±  7%     -20.0%     493.25 ±  2%  interrupts.CPU22.TLB:TLB_shootdowns
      2178 ±  2%     +12.6%       2452 ±  5%  interrupts.CPU220.RES:Rescheduling_interrupts
    566.50 ±  4%     -17.3%     468.75 ±  3%  interrupts.CPU223.TLB:TLB_shootdowns
    542.75 ±  3%     -12.9%     473.00 ± 10%  interrupts.CPU224.TLB:TLB_shootdowns
    558.25 ±  4%     -18.4%     455.50 ±  8%  interrupts.CPU226.TLB:TLB_shootdowns
      2456 ± 33%     +29.1%       3171 ± 31%  interrupts.CPU227.NMI:Non-maskable_interrupts
      2456 ± 33%     +29.1%       3171 ± 31%  interrupts.CPU227.PMI:Performance_monitoring_interrupts
      2207 ±  3%     +12.3%       2478 ±  2%  interrupts.CPU227.RES:Rescheduling_interrupts
    549.00 ±  3%     -14.0%     472.25 ±  7%  interrupts.CPU229.TLB:TLB_shootdowns
    556.00 ±  5%     -12.4%     487.00 ±  6%  interrupts.CPU23.TLB:TLB_shootdowns
    555.50 ±  3%     -14.2%     476.50 ±  6%  interrupts.CPU230.TLB:TLB_shootdowns
      2050           +60.6%       3293 ± 37%  interrupts.CPU231.NMI:Non-maskable_interrupts
      2050           +60.6%       3293 ± 37%  interrupts.CPU231.PMI:Performance_monitoring_interrupts
    566.25 ±  6%     -19.8%     454.00 ±  5%  interrupts.CPU231.TLB:TLB_shootdowns
      2047 ±  3%    +108.9%       4275 ±  9%  interrupts.CPU232.NMI:Non-maskable_interrupts
      2047 ±  3%    +108.9%       4275 ±  9%  interrupts.CPU232.PMI:Performance_monitoring_interrupts
    547.00 ±  5%     -13.4%     473.75 ± 10%  interrupts.CPU233.TLB:TLB_shootdowns
      2068 ±  5%    +104.1%       4222 ±  7%  interrupts.CPU235.NMI:Non-maskable_interrupts
      2068 ±  5%    +104.1%       4222 ±  7%  interrupts.CPU235.PMI:Performance_monitoring_interrupts
    581.25 ± 14%     -15.2%     492.75 ±  9%  interrupts.CPU235.TLB:TLB_shootdowns
      2043 ±  3%    +104.3%       4173 ±  7%  interrupts.CPU236.NMI:Non-maskable_interrupts
      2043 ±  3%    +104.3%       4173 ±  7%  interrupts.CPU236.PMI:Performance_monitoring_interrupts
    574.75 ±  4%     -13.6%     496.75 ±  8%  interrupts.CPU237.TLB:TLB_shootdowns
    562.25 ±  9%     -16.1%     472.00 ±  4%  interrupts.CPU239.TLB:TLB_shootdowns
    616.25 ± 13%     -19.6%     495.25 ±  3%  interrupts.CPU24.TLB:TLB_shootdowns
      2271           +11.6%       2536 ±  3%  interrupts.CPU240.RES:Rescheduling_interrupts
      2266 ±  4%      +8.1%       2450 ±  5%  interrupts.CPU241.RES:Rescheduling_interrupts
      2099 ±  4%     +55.5%       3263 ± 25%  interrupts.CPU243.NMI:Non-maskable_interrupts
      2099 ±  4%     +55.5%       3263 ± 25%  interrupts.CPU243.PMI:Performance_monitoring_interrupts
    558.75 ±  6%     -15.7%     470.75 ±  2%  interrupts.CPU243.TLB:TLB_shootdowns
      2205 ±  4%     +10.3%       2433 ±  5%  interrupts.CPU244.RES:Rescheduling_interrupts
    556.75 ±  4%     -10.6%     497.75 ±  5%  interrupts.CPU244.TLB:TLB_shootdowns
    577.75 ±  7%     -13.7%     498.75 ±  5%  interrupts.CPU245.TLB:TLB_shootdowns
      2204 ±  5%     +12.0%       2468 ±  2%  interrupts.CPU246.RES:Rescheduling_interrupts
    551.50 ±  7%     -15.5%     466.00 ±  7%  interrupts.CPU246.TLB:TLB_shootdowns
    555.75 ±  3%     -16.7%     463.00 ±  6%  interrupts.CPU247.TLB:TLB_shootdowns
      2017 ±  2%     +65.7%       3343 ± 37%  interrupts.CPU249.NMI:Non-maskable_interrupts
      2017 ±  2%     +65.7%       3343 ± 37%  interrupts.CPU249.PMI:Performance_monitoring_interrupts
    581.25 ±  7%     -14.7%     496.00 ±  6%  interrupts.CPU249.TLB:TLB_shootdowns
    563.50 ±  5%     -14.9%     479.75 ±  6%  interrupts.CPU250.TLB:TLB_shootdowns
      2222           +12.4%       2498 ±  3%  interrupts.CPU252.RES:Rescheduling_interrupts
    565.25 ±  3%     -13.4%     489.25 ±  6%  interrupts.CPU252.TLB:TLB_shootdowns
    584.25 ±  2%     -16.2%     489.75 ± 12%  interrupts.CPU253.TLB:TLB_shootdowns
    543.00 ±  6%      -9.0%     494.25 ±  5%  interrupts.CPU27.TLB:TLB_shootdowns
    578.00 ±  4%     -14.8%     492.25 ±  2%  interrupts.CPU28.TLB:TLB_shootdowns
      2222 ±  3%     +11.2%       2472 ±  2%  interrupts.CPU29.RES:Rescheduling_interrupts
    529.75 ±  4%      -8.2%     486.50 ±  7%  interrupts.CPU29.TLB:TLB_shootdowns
      2508 ±  5%     +13.5%       2846 ±  5%  interrupts.CPU3.RES:Rescheduling_interrupts
    531.25 ±  7%     -14.7%     453.00 ±  6%  interrupts.CPU3.TLB:TLB_shootdowns
      2241 ±  4%      +8.6%       2433 ±  2%  interrupts.CPU31.RES:Rescheduling_interrupts
    603.75 ±  7%     -15.4%     510.75        interrupts.CPU31.TLB:TLB_shootdowns
    578.00 ±  3%     -19.2%     467.00 ±  7%  interrupts.CPU33.TLB:TLB_shootdowns
    583.75 ±  5%     -17.0%     484.50 ±  5%  interrupts.CPU34.TLB:TLB_shootdowns
      2136 ±  3%     +17.7%       2514 ±  2%  interrupts.CPU35.RES:Rescheduling_interrupts
    561.00 ±  4%     -11.6%     495.75 ±  6%  interrupts.CPU36.TLB:TLB_shootdowns
    559.50 ±  5%     -14.7%     477.25 ±  7%  interrupts.CPU38.TLB:TLB_shootdowns
      2085 ±  3%     +32.8%       2769 ± 30%  interrupts.CPU39.NMI:Non-maskable_interrupts
      2085 ±  3%     +32.8%       2769 ± 30%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    599.75           -15.9%     504.25 ±  7%  interrupts.CPU39.TLB:TLB_shootdowns
      2390 ±  4%     +12.1%       2680 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    563.00 ±  5%     -10.2%     505.50 ±  6%  interrupts.CPU4.TLB:TLB_shootdowns
      2523 ± 32%     +29.6%       3271 ± 28%  interrupts.CPU40.NMI:Non-maskable_interrupts
      2523 ± 32%     +29.6%       3271 ± 28%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    596.75 ± 10%     -15.1%     506.50 ±  5%  interrupts.CPU40.TLB:TLB_shootdowns
    539.50 ±  8%     -10.6%     482.50 ±  2%  interrupts.CPU41.TLB:TLB_shootdowns
    569.50 ±  4%     -19.3%     459.50 ±  4%  interrupts.CPU42.TLB:TLB_shootdowns
      2291 ±  4%     +11.8%       2562 ±  5%  interrupts.CPU43.RES:Rescheduling_interrupts
      2194           +10.4%       2424 ±  3%  interrupts.CPU44.RES:Rescheduling_interrupts
    600.25 ±  4%     -18.1%     491.50 ±  6%  interrupts.CPU44.TLB:TLB_shootdowns
    541.25 ±  4%     -15.5%     457.50 ±  3%  interrupts.CPU5.TLB:TLB_shootdowns
    551.75 ±  8%     -14.0%     474.25 ±  2%  interrupts.CPU50.TLB:TLB_shootdowns
    578.75 ±  3%     -15.6%     488.75 ±  7%  interrupts.CPU54.TLB:TLB_shootdowns
      2175 ±  7%     +13.2%       2461 ±  6%  interrupts.CPU55.RES:Rescheduling_interrupts
    570.50 ±  8%     -16.3%     477.50 ±  4%  interrupts.CPU56.TLB:TLB_shootdowns
      1866 ±120%     -74.9%     467.50 ±  5%  interrupts.CPU57.TLB:TLB_shootdowns
      2020 ±  2%     +37.5%       2777 ± 31%  interrupts.CPU58.NMI:Non-maskable_interrupts
      2020 ±  2%     +37.5%       2777 ± 31%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    613.50 ± 10%     -18.7%     498.75 ±  3%  interrupts.CPU58.TLB:TLB_shootdowns
      2315           +13.2%       2621 ±  2%  interrupts.CPU6.RES:Rescheduling_interrupts
    568.00 ±  3%     -13.4%     492.00 ±  6%  interrupts.CPU60.TLB:TLB_shootdowns
      2139 ±  4%     +12.2%       2399 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
    570.25 ±  6%     -14.8%     485.75 ±  7%  interrupts.CPU62.TLB:TLB_shootdowns
    550.00 ±  2%     -14.1%     472.25 ±  2%  interrupts.CPU63.TLB:TLB_shootdowns
    568.25 ±  4%     -15.8%     478.50 ±  3%  interrupts.CPU64.TLB:TLB_shootdowns
      2355 ±  4%      +6.1%       2499 ±  3%  interrupts.CPU65.RES:Rescheduling_interrupts
    579.25 ±  9%     -12.2%     508.75 ±  4%  interrupts.CPU65.TLB:TLB_shootdowns
    582.00 ±  3%     -12.7%     508.00 ±  3%  interrupts.CPU68.TLB:TLB_shootdowns
    592.50 ±  7%     -12.7%     517.00 ±  4%  interrupts.CPU7.TLB:TLB_shootdowns
    561.00 ±  6%     -13.5%     485.25 ±  3%  interrupts.CPU70.TLB:TLB_shootdowns
      2171 ±  7%     +11.7%       2425 ±  5%  interrupts.CPU72.RES:Rescheduling_interrupts
    540.25 ±  3%     -14.3%     463.25 ±  5%  interrupts.CPU72.TLB:TLB_shootdowns
      2240           +10.3%       2470 ±  2%  interrupts.CPU73.RES:Rescheduling_interrupts
    548.00 ±  3%     -12.7%     478.25 ±  8%  interrupts.CPU73.TLB:TLB_shootdowns
    572.25 ±  7%     -11.5%     506.25 ±  6%  interrupts.CPU74.TLB:TLB_shootdowns
    564.25 ±  4%     -14.4%     483.00 ± 13%  interrupts.CPU77.TLB:TLB_shootdowns
    558.75 ±  5%     -11.4%     495.25 ±  5%  interrupts.CPU79.TLB:TLB_shootdowns
    579.25 ± 11%     -22.9%     446.75 ±  3%  interrupts.CPU80.TLB:TLB_shootdowns
    519.00 ±  8%      -9.1%     471.75 ±  5%  interrupts.CPU81.TLB:TLB_shootdowns
      2161 ±  3%     +44.2%       3117 ± 27%  interrupts.CPU82.NMI:Non-maskable_interrupts
      2161 ±  3%     +44.2%       3117 ± 27%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    563.50 ±  3%     -16.9%     468.00 ±  4%  interrupts.CPU83.TLB:TLB_shootdowns
      2232 ±  4%     +11.3%       2484 ±  5%  interrupts.CPU84.RES:Rescheduling_interrupts
      2080           +83.1%       3808 ± 21%  interrupts.CPU85.NMI:Non-maskable_interrupts
      2080           +83.1%       3808 ± 21%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    558.75 ±  5%     -19.0%     452.50 ±  6%  interrupts.CPU85.TLB:TLB_shootdowns
      2054 ±  2%     +75.3%       3600 ± 18%  interrupts.CPU86.NMI:Non-maskable_interrupts
      2054 ±  2%     +75.3%       3600 ± 18%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
      2098 ±  2%     +18.0%       2476 ±  3%  interrupts.CPU89.RES:Rescheduling_interrupts
    578.50 ±  8%     -14.6%     493.75 ±  3%  interrupts.CPU89.TLB:TLB_shootdowns
    545.25           -11.1%     484.75 ±  4%  interrupts.CPU90.TLB:TLB_shootdowns
    556.00 ±  8%     -15.5%     470.00 ± 11%  interrupts.CPU93.TLB:TLB_shootdowns
      2279 ±  3%      +9.2%       2490 ±  2%  interrupts.CPU94.RES:Rescheduling_interrupts
    561.25 ±  4%     -20.1%     448.25 ±  9%  interrupts.CPU95.TLB:TLB_shootdowns
      2514 ± 35%     +47.7%       3713 ± 25%  interrupts.CPU96.NMI:Non-maskable_interrupts
      2514 ± 35%     +47.7%       3713 ± 25%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    574.50 ±  3%     -11.6%     508.00        interrupts.CPU97.TLB:TLB_shootdowns
    554.75 ±  3%     -13.0%     482.50 ±  7%  interrupts.CPU98.TLB:TLB_shootdowns
     63.84 ±  3%     -12.6       51.28 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     63.78 ±  3%     -12.5       51.26 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.58 ± 10%      -5.6        2.00 ± 46%  perf-profile.calltrace.cycles-pp.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.20 ± 10%      -5.3        1.89 ± 47%  perf-profile.calltrace.cycles-pp.__do_munmap.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.78 ±  4%      -3.1        7.68 ±  3%  perf-profile.calltrace.cycles-pp.page_fault
     10.53 ±  4%      -3.0        7.51 ±  3%  perf-profile.calltrace.cycles-pp.__do_page_fault.page_fault
      9.89 ±  4%      -2.8        7.09 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.page_fault
      9.71 ±  4%      -2.7        6.96 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      4.14 ±  4%      -2.1        2.06 ± 26%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.12 ±  4%      -2.1        2.05 ± 25%  perf-profile.calltrace.cycles-pp.do_execve.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.79            -1.6        8.21 ±  4%  perf-profile.calltrace.cycles-pp.__do_execve_file.do_execve.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.63 ±  6%      -1.4        1.21 ± 14%  perf-profile.calltrace.cycles-pp._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.87            -1.4        7.51 ±  4%  perf-profile.calltrace.cycles-pp.search_binary_handler.__do_execve_file.do_execve.__x64_sys_execve.do_syscall_64
      8.86            -1.4        7.50 ±  4%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.__do_execve_file.do_execve.__x64_sys_execve
      2.13 ±  6%      -1.1        0.99 ± 14%  perf-profile.calltrace.cycles-pp.copy_process._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.39 ±  8%      -0.9        0.50 ± 60%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.21 ±  7%      -0.9        0.33 ±100%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.80 ±  2%      -0.8        4.95 ±  4%  perf-profile.calltrace.cycles-pp.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file.do_execve
      5.75 ±  2%      -0.8        4.92 ±  4%  perf-profile.calltrace.cycles-pp.mmput.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file
      5.75 ±  2%      -0.8        4.91 ±  4%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.flush_old_exec.load_elf_binary.search_binary_handler
      3.79 ±  2%      -0.7        3.09 ±  9%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.__vm_munmap
      3.00 ±  2%      -0.6        2.44 ± 11%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.flush_old_exec.load_elf_binary
      3.00 ±  2%      -0.6        2.43 ± 11%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput.flush_old_exec
      1.97 ±  2%      -0.5        1.45 ± 16%  perf-profile.calltrace.cycles-pp.lru_add_drain.exit_mmap.mmput.flush_old_exec.load_elf_binary
      1.97 ±  2%      -0.5        1.45 ± 16%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.exit_mmap.mmput.flush_old_exec
      2.02            -0.5        1.49 ± 15%  perf-profile.calltrace.cycles-pp.__vm_munmap.elf_map.load_elf_binary.search_binary_handler.__do_execve_file
      4.40 ±  2%      -0.5        3.87 ±  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.01            -0.5        1.49 ± 15%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.elf_map.load_elf_binary.search_binary_handler
      4.38 ±  2%      -0.5        3.86 ±  4%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.37 ±  2%      -0.5        3.85 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.31 ±  2%      -0.5        3.81 ±  4%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.93            -0.5        1.44 ± 14%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.elf_map.load_elf_binary
      2.25            -0.5        1.76 ± 14%  perf-profile.calltrace.cycles-pp.elf_map.load_elf_binary.search_binary_handler.__do_execve_file.do_execve
      1.37 ± 29%      -0.5        0.89 ±  9%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.89            -0.5        1.42 ± 14%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.elf_map
      4.00 ±  2%      -0.4        3.56 ±  4%  perf-profile.calltrace.cycles-pp.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      3.91 ±  2%      -0.4        3.48 ±  4%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      3.79 ±  2%      -0.4        3.37 ±  4%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.mmap_region.do_mmap
      3.78 ±  2%      -0.4        3.37 ±  4%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.mmap_region
      1.22 ± 32%      -0.4        0.83 ±  9%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      6.90            -0.4        6.52 ±  2%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.exit_mmap.mmput
      0.74 ± 36%      -0.3        0.41 ± 58%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.08 ±  3%      -0.3        1.76 ±  5%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.08 ±  3%      -0.3        1.76 ±  5%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.08 ±  3%      -0.3        1.76 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.06 ±  3%      -0.3        1.75 ±  5%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.83 ± 25%      -0.3        0.52 ± 68%  perf-profile.calltrace.cycles-pp.__strcspn_sse42
      0.83 ± 25%      -0.3        0.52 ± 68%  perf-profile.calltrace.cycles-pp.generic_start_main.__strcspn_sse42
      0.83 ± 25%      -0.3        0.52 ± 68%  perf-profile.calltrace.cycles-pp.main.generic_start_main.__strcspn_sse42
      0.83 ± 25%      -0.3        0.52 ± 68%  perf-profile.calltrace.cycles-pp.run_builtin.main.generic_start_main.__strcspn_sse42
      0.70 ±  8%      -0.3        0.42 ± 57%  perf-profile.calltrace.cycles-pp.__libc_fork
      6.36            -0.3        6.09 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.exit_mmap
      1.16            -0.3        0.90 ±  6%  perf-profile.calltrace.cycles-pp.filemap_map_pages.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      1.90 ±  2%      -0.2        1.67 ±  5%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.83 ±  2%      -0.2        0.62 ±  6%  perf-profile.calltrace.cycles-pp.setlocale
      1.40 ±  2%      -0.2        1.20 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.__ia32_sys_exit_group
      1.32 ±  2%      -0.2        1.14 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
      0.56 ±  7%      -0.2        0.39 ± 57%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.do_wait.kernel_wait4.__se_sys_wait4
      0.56 ±  7%      -0.2        0.39 ± 57%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__se_sys_wait4.do_syscall_64
      0.81 ±  7%      -0.1        0.68 ±  5%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__se_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.46            +0.3        3.79 ±  5%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__se_sys_brk.do_syscall_64
      3.46            +0.3        3.79 ±  5%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.__se_sys_brk
      4.21            +0.4        4.63        perf-profile.calltrace.cycles-pp.__lru_cache_add.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault
      4.19            +0.4        4.62        perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__lru_cache_add.__handle_mm_fault.handle_mm_fault.__do_page_fault
      4.08            +0.4        4.51        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.__handle_mm_fault.handle_mm_fault
      4.08            +0.4        4.51        perf-profile.calltrace.cycles-pp.queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.__lru_cache_add.__handle_mm_fault
      5.68            +0.5        6.17 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.67            +0.5        6.16 ±  2%  perf-profile.calltrace.cycles-pp.do_execve.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.68            +0.5        6.17 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      5.68            +0.5        6.17 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.69            +0.5        6.18 ±  2%  perf-profile.calltrace.cycles-pp.execve
      0.00            +0.5        0.53 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.5        0.55 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp.write
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.kernel_wait4.__se_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait
      0.00            +0.7        0.69 ±  5%  perf-profile.calltrace.cycles-pp.__se_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait
      0.00            +0.7        0.71 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +0.7        0.72 ± 14%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +0.7        0.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      0.00            +0.7        0.73 ± 14%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      0.00            +0.8        0.76 ±  5%  perf-profile.calltrace.cycles-pp.wait
      0.00            +0.8        0.76 ±  2%  perf-profile.calltrace.cycles-pp.creat
      0.00            +0.8        0.77 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      0.00            +0.8        0.77 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
      0.00            +0.8        0.80 ± 14%  perf-profile.calltrace.cycles-pp.close
      7.00            +0.8        7.80 ±  3%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap.__se_sys_brk
      7.00            +0.8        7.81 ±  3%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__se_sys_brk.do_syscall_64
      6.96            +0.8        7.77 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
      6.82            +0.8        7.63 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region
     36.51            +1.0       37.46        perf-profile.calltrace.cycles-pp.__wake_up_parent.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.50            +1.0       37.46        perf-profile.calltrace.cycles-pp.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.50            +1.0       37.46        perf-profile.calltrace.cycles-pp.do_exit.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±173%      +1.1        1.24 ±  8%  perf-profile.calltrace.cycles-pp.copy_process._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     34.96            +1.1       36.06        perf-profile.calltrace.cycles-pp.mmput.do_exit.__ia32_sys_exit_group.__wake_up_parent.do_syscall_64
     34.94            +1.1       36.04        perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.__ia32_sys_exit_group.__wake_up_parent
     27.71            +1.2       28.90 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.do_exit.__ia32_sys_exit_group
     27.70            +1.2       28.89 ±  2%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput.do_exit
      0.33 ±103%      +1.2        1.57 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork.fork_test
      0.33 ±103%      +1.2        1.57 ±  8%  perf-profile.calltrace.cycles-pp._do_fork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork.fork_test
      0.33 ±103%      +1.2        1.57 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork.fork_test
      0.54 ± 64%      +1.4        1.92 ±  9%  perf-profile.calltrace.cycles-pp.__libc_fork.fork_test
     10.54            +1.4       11.96        perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ± 29%      +1.5        2.19 ±  9%  perf-profile.calltrace.cycles-pp.fork_test
     36.05            +1.6       37.63        perf-profile.calltrace.cycles-pp.queued_spin_lock_slowpath._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu
      1.27 ± 24%      +2.4        3.66 ±  7%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.page_fault.page_test
      1.27 ± 24%      +2.4        3.69 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.page_fault.page_test
      1.31 ± 24%      +2.4        3.76 ±  7%  perf-profile.calltrace.cycles-pp.__do_page_fault.page_fault.page_test
      1.32 ± 24%      +2.5        3.79 ±  7%  perf-profile.calltrace.cycles-pp.page_fault.page_test
      1.36 ± 24%      +2.5        3.87 ±  7%  perf-profile.calltrace.cycles-pp.page_test
      2.21 ± 32%      +3.5        5.69 ± 18%  perf-profile.calltrace.cycles-pp.sieve
      3.39 ± 24%      +6.7       10.11 ±  8%  perf-profile.calltrace.cycles-pp.__do_munmap.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.58 ± 23%      +6.9       10.48 ±  7%  perf-profile.calltrace.cycles-pp.__se_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.60 ± 23%      +6.9       10.50 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      3.60 ± 23%      +6.9       10.50 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.63 ± 23%      +7.0       10.59 ±  7%  perf-profile.calltrace.cycles-pp.brk
     78.36            -2.0       76.33        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     78.28            -2.0       76.27        perf-profile.children.cycles-pp.do_syscall_64
      9.82            -1.6        8.23 ±  4%  perf-profile.children.cycles-pp.__x64_sys_execve
      9.79            -1.6        8.21 ±  4%  perf-profile.children.cycles-pp.__do_execve_file
      9.79            -1.6        8.21 ±  4%  perf-profile.children.cycles-pp.do_execve
      8.87            -1.4        7.51 ±  4%  perf-profile.children.cycles-pp.search_binary_handler
      8.86            -1.4        7.50 ±  4%  perf-profile.children.cycles-pp.load_elf_binary
      5.80 ±  2%      -0.9        4.95 ±  4%  perf-profile.children.cycles-pp.flush_old_exec
      4.92 ±  2%      -0.6        4.28 ±  4%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      4.88 ±  2%      -0.6        4.24 ±  4%  perf-profile.children.cycles-pp.do_mmap
      3.60 ±  8%      -0.6        2.97 ±  5%  perf-profile.children.cycles-pp.apic_timer_interrupt
      3.31 ±  9%      -0.6        2.69 ±  6%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      4.73 ±  2%      -0.6        4.13 ±  4%  perf-profile.children.cycles-pp.mmap_region
      4.71 ±  2%      -0.6        4.12 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     18.98            -0.5       18.43 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
      1.31 ± 41%      -0.5        0.79 ±  7%  perf-profile.children.cycles-pp.__softirqentry_text_start
      3.69 ±  2%      -0.5        3.18 ±  4%  perf-profile.children.cycles-pp._do_fork
     13.72            -0.5       13.23        perf-profile.children.cycles-pp.page_fault
     13.33            -0.4       12.88        perf-profile.children.cycles-pp.__do_page_fault
      4.21            -0.4        3.79 ±  4%  perf-profile.children.cycles-pp.__vm_munmap
      2.94 ±  3%      -0.4        2.52 ±  4%  perf-profile.children.cycles-pp.copy_process
      1.48 ± 27%      -0.4        1.07 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      1.22 ± 32%      -0.4        0.83 ±  9%  perf-profile.children.cycles-pp.kthread
      1.09 ± 29%      -0.4        0.73 ±  7%  perf-profile.children.cycles-pp.irq_exit
      2.29 ±  5%      -0.3        1.97 ±  3%  perf-profile.children.cycles-pp.dup_mm
      2.25            -0.3        1.94 ±  4%  perf-profile.children.cycles-pp.elf_map
      1.89            -0.3        1.58 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      1.77 ±  8%      -0.3        1.46 ±  6%  perf-profile.children.cycles-pp.do_sys_open
     12.60            -0.3       12.30        perf-profile.children.cycles-pp.handle_mm_fault
      1.61 ± 10%      -0.3        1.32 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      1.79            -0.3        1.50 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      1.58 ± 10%      -0.3        1.29 ±  6%  perf-profile.children.cycles-pp.path_openat
     12.36            -0.3       12.08        perf-profile.children.cycles-pp.__handle_mm_fault
      1.37 ± 16%      -0.3        1.10 ± 18%  perf-profile.children.cycles-pp.ksys_write
      0.66 ± 36%      -0.3        0.40 ± 57%  perf-profile.children.cycles-pp.cmd_record
      0.64 ± 37%      -0.3        0.39 ± 57%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      1.32 ± 15%      -0.3        1.07 ± 18%  perf-profile.children.cycles-pp.vfs_write
      0.63 ± 36%      -0.2        0.38 ± 56%  perf-profile.children.cycles-pp.perf_mmap__push
      1.64            -0.2        1.40 ±  4%  perf-profile.children.cycles-pp.filemap_map_pages
      0.60 ± 36%      -0.2        0.36 ± 56%  perf-profile.children.cycles-pp.record__pushfn
      0.58 ± 36%      -0.2        0.35 ± 56%  perf-profile.children.cycles-pp.__libc_write
      0.55 ± 39%      -0.2        0.32 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.24 ± 15%      -0.2        1.02 ± 18%  perf-profile.children.cycles-pp.new_sync_write
      1.55 ±  4%      -0.2        1.34 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.83 ± 25%      -0.2        0.62 ± 37%  perf-profile.children.cycles-pp.__strcspn_sse42
      0.83 ± 25%      -0.2        0.62 ± 37%  perf-profile.children.cycles-pp.generic_start_main
      0.83 ± 25%      -0.2        0.62 ± 37%  perf-profile.children.cycles-pp.main
      0.83 ± 25%      -0.2        0.62 ± 37%  perf-profile.children.cycles-pp.run_builtin
      0.83 ±  2%      -0.2        0.62 ±  6%  perf-profile.children.cycles-pp.setlocale
      1.76 ±  3%      -0.2        1.56 ±  4%  perf-profile.children.cycles-pp.evict
      1.09 ±  2%      -0.2        0.89 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      1.75 ±  3%      -0.2        1.54 ±  3%  perf-profile.children.cycles-pp.shmem_truncate_range
      1.75 ±  3%      -0.2        1.55 ±  4%  perf-profile.children.cycles-pp.shmem_evict_inode
      1.74 ±  3%      -0.2        1.54 ±  3%  perf-profile.children.cycles-pp.shmem_undo_range
      0.66 ± 26%      -0.2        0.47 ± 35%  perf-profile.children.cycles-pp.generic_file_write_iter
      1.71 ±  3%      -0.2        1.52 ±  4%  perf-profile.children.cycles-pp.__pagevec_release
      0.64 ± 27%      -0.2        0.45 ± 35%  perf-profile.children.cycles-pp.__generic_file_write_iter
      1.21 ±  4%      -0.2        1.03 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.73 ±  3%      -0.2        1.55 ±  3%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.60 ± 28%      -0.2        0.43 ± 35%  perf-profile.children.cycles-pp.generic_perform_write
      2.20            -0.2        2.03 ±  4%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.46 ±  3%      -0.2        1.30 ±  4%  perf-profile.children.cycles-pp.dput
      1.48 ±  3%      -0.2        1.33 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.82            -0.2        0.67 ±  3%  perf-profile.children.cycles-pp.copy_page_range
      0.93 ±  2%      -0.1        0.79 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.44 ±  5%      -0.1        1.29 ±  4%  perf-profile.children.cycles-pp.do_wait
      0.74 ±  2%      -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.alloc_pages_vma
      1.46 ±  5%      -0.1        1.31 ±  4%  perf-profile.children.cycles-pp.__se_sys_wait4
      1.46 ±  5%      -0.1        1.31 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
      0.80 ±  2%      -0.1        0.66 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.27 ± 60%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.d_alloc_parallel
      1.41 ±  3%      -0.1        1.27 ±  4%  perf-profile.children.cycles-pp.__fput
      1.33 ±  3%      -0.1        1.19 ±  5%  perf-profile.children.cycles-pp.dentry_kill
      1.32 ±  3%      -0.1        1.19 ±  4%  perf-profile.children.cycles-pp.__dentry_kill
      0.58            -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.walk_component
      0.71 ±  3%      -0.1        0.59 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.74 ±  4%      -0.1        0.62        perf-profile.children.cycles-pp.source_load
      0.52 ±  2%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.filename_lookup
      0.72 ±  2%      -0.1        0.60 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      0.45 ± 25%      -0.1        0.34 ± 33%  perf-profile.children.cycles-pp.shmem_getpage
      0.26 ± 43%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.51 ±  4%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap
      0.45 ± 27%      -0.1        0.34 ± 33%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.49 ±  2%      -0.1        0.39 ±  6%  perf-profile.children.cycles-pp.link_path_walk
      0.49 ±  3%      -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.47 ±  3%      -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
      0.61 ±  2%      -0.1        0.51 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.41 ±  2%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.61            -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.alloc_set_pte
      0.39            -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.copy_strings
      0.46 ± 15%      -0.1        0.38 ±  8%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.38 ±  2%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp.wait4
      0.46 ± 14%      -0.1        0.37 ±  8%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.46            -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.49 ±  5%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.do_brk_flags
      0.82 ±  3%      -0.1        0.74 ±  2%  perf-profile.children.cycles-pp.__lock_text_start
      0.70 ±  3%      -0.1        0.62 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
      0.33 ±  2%      -0.1        0.25 ±  7%  perf-profile.children.cycles-pp.__clear_user
      0.32 ±  2%      -0.1        0.24 ±  7%  perf-profile.children.cycles-pp.padzero
      0.30 ±  2%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.sched_exec
      0.35 ±  2%      -0.1        0.28 ±  6%  perf-profile.children.cycles-pp.mmap64
      0.25            -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.__se_sys_newstat
      0.66 ±  3%      -0.1        0.59 ±  4%  perf-profile.children.cycles-pp.anon_vma_fork
      0.29 ±  2%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.29 ±  2%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.ksys_sync
      0.29 ±  2%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.sync
      0.30 ±  5%      -0.1        0.23 ±  7%  perf-profile.children.cycles-pp.do_faccessat
      0.46            -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.38 ±  3%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.30 ±  4%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.find_vma
      0.33 ±  4%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.29            -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.27 ±  4%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.iterate_supers
      0.28 ±  2%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.lookup_fast
      0.31 ±  5%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.42 ±  2%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.target_load
      0.25 ±  5%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.28 ±  3%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp._cond_resched
      0.27 ±  6%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.lookup_slow
      0.22 ±  7%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.__lookup_slow
      0.28 ±  5%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.28 ±  3%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.pte_alloc_one
      0.33 ±  3%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.30 ±  2%      -0.0        0.25 ±  4%  perf-profile.children.cycles-pp.prep_new_page
      0.21 ± 10%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.wake_up_page_bit
      0.21 ±  3%      -0.0        0.16 ±  9%  perf-profile.children.cycles-pp.__get_user_pages
      0.20 ±  2%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.21 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__xstat64
      0.50 ±  2%      -0.0        0.45 ±  4%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.25 ±  3%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.55 ±  2%      -0.0        0.51 ±  5%  perf-profile.children.cycles-pp.new_sync_read
      0.23 ±  3%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_try_charge_delay
      0.37            -0.0        0.32 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.16 ±  6%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__do_fault
      0.47 ±  3%      -0.0        0.43 ±  3%  perf-profile.children.cycles-pp.anon_vma_clone
      0.18 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
      0.35 ±  3%      -0.0        0.31 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      0.15 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.get_unmapped_area
      0.22 ±  3%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.15 ±  2%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.31 ±  2%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.15 ±  2%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.do_writepages
      0.23 ±  2%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.20 ±  3%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.20 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__pte_alloc
      0.15 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.btrfs_sync_fs
      0.15 ±  2%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.06            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.path_parentat
      0.06            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.perf_exclude_event
      0.18 ±  4%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp._dl_addr
      0.28 ±  3%      -0.0        0.25 ±  4%  perf-profile.children.cycles-pp.cpumask_next_and
      0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.vma_merge
      0.15 ±  4%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_compare
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.btree_writepages
      0.25 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.sock_write_iter
      0.25            -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.sock_sendmsg
      0.23            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.wait_consider_task
      0.23 ±  2%      -0.0        0.19 ±  7%  perf-profile.children.cycles-pp.schedule_idle
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.cpumask_next
      0.12 ± 14%      -0.0        0.09 ± 27%  perf-profile.children.cycles-pp.mark_page_accessed
      0.15 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.vmacache_find
      0.13 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.do_open_execat
      0.13 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.filemap_fault
      0.23 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.17 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.getname_flags
      0.14 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.24 ±  5%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.find_next_and_bit
      0.21 ±  2%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.20 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.16 ±  5%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.13 ±  3%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.14 ±  3%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
      0.12 ±  7%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.strnlen_user
      0.11 ±  3%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.setup_arg_pages
      0.24 ±  3%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__put_user_4
      0.18 ±  2%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp._vm_normal_page
      0.23 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.schedule_tail
      0.24            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.do_signal
      0.19 ±  6%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.__get_free_pages
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.release_task
      0.17 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.17 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.find_next_bit
      0.16 ±  5%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.13            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.terminate_walk
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.12 ±  3%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.copy_strings_kernel
      0.11            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.path_put
      0.07 ±  7%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.__call_rcu
      0.14 ±  7%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.09 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ip_finish_output2
      0.11 ±  7%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.activate_task
      0.09 ±  8%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__lock_page_killable
      0.06 ±  6%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.perf_swevent_event
      0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.14 ±  7%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.copy_page
      0.11 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.mm_init
      0.10 ±  8%      -0.0        0.08        perf-profile.children.cycles-pp.enqueue_task_fair
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.update_curr
      0.08 ±  5%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.d_path
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.open_exec
      0.17 ±  2%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.remove_vma
      0.17 ±  2%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.iterate_dir
      0.16            -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.dcache_readdir
      0.12 ±  3%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.inode_permission
      0.12 ±  4%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.do_notify_parent
      0.11 ±  4%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.sync_regs
      0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.09 ±  7%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.io_schedule
      0.06            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.kfree
      0.06            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.cpumask_any_but
      0.06            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.bad_range
      0.18 ±  2%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.lock_page_memcg
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.14 ±  5%      -0.0        0.12        perf-profile.children.cycles-pp.vm_area_dup
      0.14 ±  6%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.ktime_get
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.path_init
      0.11 ±  4%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xas_load
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp._IO_file_open
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.tcp_sendmsg
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12            -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.unlazy_walk
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.simple_lookup
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.vma_gap_update
      0.13            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__fxstat64
      0.08 ± 10%      -0.0        0.06        perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.up_write
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_write_xmit
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.unlock_page
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.shift_arg_pages
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.d_add
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.ttwu_do_activate
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.11 ±  4%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.update_blocked_averages
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.do_softirq
      0.12 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.do_softirq_own_stack
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.09            -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.pgd_alloc
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.time
      0.23            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.process_backlog
      0.07 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.11            -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.net_rx_action
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp._copy_to_user
      0.10 ±  5%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
      0.10 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.free_pgd_range
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__se_sys_close
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rcu_irq_enter
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.strncpy_from_user
      0.07 ± 12%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.vma_compute_subtree_gap
      0.07 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__alloc_file
      0.11 ±  4%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__vma_link_rb
      0.07            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp._copy_from_user
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_throttle_swaprate
      0.07            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.decay_load
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.08            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.get_signal
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.03 ±100%      +0.0        0.06        perf-profile.children.cycles-pp._exit
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__lxstat64
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.link
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.sighandler
      0.01 ±173%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.__waitpid
      0.11 ± 28%      +0.1        0.23 ±  9%  perf-profile.children.cycles-pp.munmap
      0.11 ± 23%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.kill
      0.18 ± 20%      +0.2        0.41 ±  4%  perf-profile.children.cycles-pp.read
      0.10 ± 28%      +0.2        0.35 ± 14%  perf-profile.children.cycles-pp.unlink
      0.27 ± 22%      +0.4        0.64 ±  4%  perf-profile.children.cycles-pp.write
      0.28 ± 33%      +0.5        0.76 ±  5%  perf-profile.children.cycles-pp.wait
      0.29 ± 36%      +0.5        0.78 ±  2%  perf-profile.children.cycles-pp.creat
      5.69            +0.5        6.18 ±  2%  perf-profile.children.cycles-pp.execve
      7.81            +0.5        8.33 ±  2%  perf-profile.children.cycles-pp.__lru_cache_add
     18.84            +0.5       19.38 ±  2%  perf-profile.children.cycles-pp.__do_munmap
     18.61            +0.6       19.20 ±  2%  perf-profile.children.cycles-pp.unmap_region
      0.23 ± 31%      +0.6        0.81 ± 13%  perf-profile.children.cycles-pp.close
     36.54            +1.0       37.51        perf-profile.children.cycles-pp.__ia32_sys_exit_group
     36.54            +1.0       37.51        perf-profile.children.cycles-pp.do_exit
     36.55            +1.0       37.52        perf-profile.children.cycles-pp.__wake_up_parent
      1.37 ± 13%      +1.1        2.48 ±  6%  perf-profile.children.cycles-pp.__libc_fork
     11.18            +1.3       12.49        perf-profile.children.cycles-pp.__se_sys_brk
      0.74 ± 29%      +1.5        2.20 ±  9%  perf-profile.children.cycles-pp.fork_test
     39.50            +1.6       41.11        perf-profile.children.cycles-pp.release_pages
     37.92            +1.8       39.67        perf-profile.children.cycles-pp.tlb_finish_mmu
     37.89            +1.8       39.64        perf-profile.children.cycles-pp.tlb_flush_mmu
     64.47            +1.8       66.28        perf-profile.children.cycles-pp.queued_spin_lock_slowpath
     63.94            +2.0       65.91        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.37 ± 24%      +2.5        3.90 ±  7%  perf-profile.children.cycles-pp.page_test
      2.22 ± 32%      +3.5        5.70 ± 18%  perf-profile.children.cycles-pp.sieve
      3.64 ± 23%      +7.0       10.59 ±  7%  perf-profile.children.cycles-pp.brk
      1.48            -0.2        1.29 ±  4%  perf-profile.self.cycles-pp.find_busiest_group
      0.92 ±  2%      -0.2        0.76 ±  2%  perf-profile.self.cycles-pp.unmap_page_range
      0.73 ±  4%      -0.1        0.61 ±  2%  perf-profile.self.cycles-pp.source_load
      0.81            -0.1        0.69 ±  5%  perf-profile.self.cycles-pp.filemap_map_pages
      0.24 ± 43%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.46            -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.copy_page_range
      0.56 ±  2%      -0.1        0.46 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.39 ±  3%      -0.1        0.32 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.61            -0.1        0.54 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.29 ±  5%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.33 ±  3%      -0.1        0.27 ±  4%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.27 ±  5%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.36 ±  2%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.30            -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.26 ±  4%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.__do_page_fault
      0.41 ±  2%      -0.1        0.36 ±  3%  perf-profile.self.cycles-pp.target_load
      0.23 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.24 ±  5%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.22 ±  3%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.35            -0.0        0.31 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.25            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.alloc_set_pte
      0.19 ±  5%      -0.0        0.16 ±  8%  perf-profile.self.cycles-pp.smp_apic_timer_interrupt
      0.17 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.30 ±  2%      -0.0        0.26 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.20 ±  2%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.23            -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      0.17 ±  4%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp._dl_addr
      0.16 ±  4%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.find_next_bit
      0.21 ±  5%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.idle_cpu
      0.23 ±  5%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.find_next_and_bit
      0.18 ±  2%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ± 10%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.14 ±  6%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.13 ±  5%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.find_vma
      0.12 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.12 ±  4%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.14 ± 11%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.vmacache_find
      0.14 ±  6%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.copy_page
      0.09 ±  5%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.strnlen_user
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.16 ±  2%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.lock_page_memcg
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.06            -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.kfree
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.10 ±  4%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.10 ±  5%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.perf_event_mmap
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__vma_adjust
      0.12 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp._vm_normal_page
      0.11 ±  3%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.sync_regs
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.link_path_walk
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.11 ±  4%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.ktime_get
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.vma_compute_subtree_gap
      0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__sched_text_start
      0.11 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.wp_page_copy
      0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.inode_permission
      0.07            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.07            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.decay_load
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp._cond_resched
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.mark_page_accessed
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.07            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.09            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.path_openat
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.mem_cgroup_charge_statistics
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.page_test
     64.46            +1.8       66.28        perf-profile.self.cycles-pp.queued_spin_lock_slowpath
      2.18 ± 32%      +3.4        5.61 ± 18%  perf-profile.self.cycles-pp.sieve





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.1.0-10179-ge0ee0e7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.1.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
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
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
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
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS_PROC is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
CONFIG_SYSCTL_SYSCALL=y
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
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
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
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
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
CONFIG_GENERIC_HWEIGHT=y
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
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
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
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
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
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=512
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
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
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
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
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
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
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
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
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
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
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_MMU_AUDIT is not set
CONFIG_VHOST_NET=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
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
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
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
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y

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
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
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
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=m
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
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
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
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
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
# CONFIG_FAILOVER is not set
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
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
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
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=m
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
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
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
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
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
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
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
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
CONFIG_ATA_PIIX=y
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
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=m
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
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
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
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
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_TYPHOON=y
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
CONFIG_PCNET32=y
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=y
CONFIG_ATL1=y
CONFIG_ATL1E=y
CONFIG_ATL1C=y
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
CONFIG_ULI526X=y
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=y
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
# CONFIG_E1000E_HWTS is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=y
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
CONFIG_VXGE=y
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_NE2K_PCI=y
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=y
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=y
CONFIG_SIS190=y
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=y
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_GENERIC is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_VELOCITY=y
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_FIXED_PHY is not set
CONFIG_ICPLUS_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
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
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=y
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
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
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
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
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DP_CEC is not set

#
# ARM devices
#

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

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
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=1024
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
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
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=y
# CONFIG_USB_WUSB_CBAF is not set

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
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_WHCI_HCD=y
CONFIG_USB_HWA_HCD=y
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_HWA=y
CONFIG_UWB_WHCI=y
CONFIG_UWB_I1480U=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="n"
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
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
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
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_SIFIVE is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
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
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
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
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
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
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
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
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_ACL is not set
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

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
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
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
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=m
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BTREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
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
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

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
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

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
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
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
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
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
# CONFIG_LATENCYTOP is not set
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
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
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
# CONFIG_TEST_VMALLOC is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
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
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='reaim'
	export testcase='reaim'
	export category='benchmark'
	export runtime=300
	export nr_task=256
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='lkp-knl-f1'
	export tbox_group='lkp-knl-f1'
	export submit_id='5cdc3e500b9a93acba95ac94'
	export job_file='/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0-20190516-44218-1ixjktp-3.yaml'
	export id='e97f8d2591ad1dd6d4153d4df4a6449f1cda47ea'
	export queuer_version='/lkp/lkp/.src-20190515-213058'
	export arch='x86_64'
	export avoid_nfs=1
	export commit='e0ee0e71078abbcadd4cbc38fb8570551fccc103'
	export kconfig='x86_64-kexec'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-05-16 00:29:06 +0800'
	export _id='5cdc3e520b9a93acba95ac95'
	export _rt='/result/reaim/performance-100%-300s-shared/lkp-knl-f1/debian-x86_64-2018-04-03.cgz/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103'
	export user='lkp'
	export head_commit='ee3f24bef720fc4c48d27175f03cc3a627f753d3'
	export base_commit='e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd'
	export branch='linux-devel/devel-hourly-2019051505'
	export result_root='/result/reaim/performance-100%-300s-shared/lkp-knl-f1/debian-x86_64-2018-04-03.cgz/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/3'
	export scheduler_version='/lkp/lkp/.src-20190515-213058'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0-20190516-44218-1ixjktp-3.yaml
ARCH=x86_64
kconfig=x86_64-kexec
branch=linux-devel/devel-hourly-2019051505
commit=e0ee0e71078abbcadd4cbc38fb8570551fccc103
BOOT_IMAGE=/pkg/linux/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/vmlinuz-5.1.0-10179-ge0ee0e7
max_uptime=1500
RESULT_ROOT=/result/reaim/performance-100%-300s-shared/lkp-knl-f1/debian-x86_64-2018-04-03.cgz/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/3
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
	export modules_initrd='/pkg/linux/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-04-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/reaim_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/reaim-x86_64-_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-05-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-37624b58542f_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-04-24.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='Knights Landing'
	export nr_node=2
	export nr_cpu=256
	export memory='96G'
	export nr_ssd_partitions=
	export swap_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export job_origin='/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0-20190516-44218-1ixjktp-3.yaml'
	export kernel='/pkg/linux/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/vmlinuz-5.1.0-10179-ge0ee0e7'
	export dequeue_time='2019-05-16 00:42:37 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0-20190516-44218-1ixjktp-3.cgz'

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

	run_test test='shared' $LKP_SRC/tests/wrapper reaim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper reaim
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

	$LKP_SRC/stats/wrapper time reaim.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! /lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0ee0-20190515-7820-1k26v66-0.yaml

#! /lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debia-20190515-25086-olwdzd-0.yaml

#! jobs/reaim-100.yaml
suite: reaim
testcase: reaim
category: benchmark
runtime: 300s
nr_task: 100%
reaim:
  test: shared

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-knl-f1
tbox_group: lkp-knl-f1
submit_id: 5cdc16ff58d12a1e8c563c47
job_file: "/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0ee0-20190515-7820-1k26v66-0.yaml"
id: 2d628e5fafb102cbe4f3bcebccd1b2ff9c72dc2e
queuer_version: "/lkp/lkp/src"
arch: x86_64

#! hosts/lkp-knl-f1

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

#! include/reaim
avoid_nfs: 1

#! include/queue/cyclic
commit: e0ee0e71078abbcadd4cbc38fb8570551fccc103

#! include/testbox/lkp-knl-f1
kconfig: x86_64-kexec

#! default params
compiler: gcc-7
rootfs: debian-x86_64-2018-04-03.cgz
enqueue_time: 2019-05-15 21:41:21.600187448 +08:00
_id: 5cdc16ff58d12a1e8c563c47
_rt: "/result/reaim/performance-100%-300s-shared/lkp-knl-f1/debian-x86_64-2018-04-03.cgz/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103"

#! schedule options
user: lkp
head_commit: ee3f24bef720fc4c48d27175f03cc3a627f753d3
base_commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
branch: linux-devel/devel-hourly-2019051505
result_root: "/result/reaim/performance-100%-300s-shared/lkp-knl-f1/debian-x86_64-2018-04-03.cgz/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/0"
scheduler_version: "/lkp/lkp/.src-20190515-213058"
LKP_SERVER: inn
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-2018-04-03.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0ee0-20190515-7820-1k26v66-0.yaml
- ARCH=x86_64
- kconfig=x86_64-kexec
- branch=linux-devel/devel-hourly-2019051505
- commit=e0ee0e71078abbcadd4cbc38fb8570551fccc103
- BOOT_IMAGE=/pkg/linux/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/vmlinuz-5.1.0-10179-ge0ee0e7
- max_uptime=1500
- RESULT_ROOT=/result/reaim/performance-100%-300s-shared/lkp-knl-f1/debian-x86_64-2018-04-03.cgz/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/0
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
modules_initrd: "/pkg/linux/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-04-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/reaim_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/reaim-x86_64-_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-05-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-37624b58542f_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-04-24.cgz"
lkp_initrd: "/lkp/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190514-184333/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
schedule_notify_address: 
model: Knights Landing
nr_node: 2
nr_cpu: 256
memory: 96G
nr_ssd_partitions: 
swap_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS

#! user overrides
job_origin: "/lkp/jobs/scheduled/lkp-knl-f1/reaim-performance-100%-300s-shared-debian-x86_64-2018-04-03.cgz-e0ee0-20190515-7820-1k26v66-0.yaml"
kernel: "/pkg/linux/x86_64-kexec/gcc-7/e0ee0e71078abbcadd4cbc38fb8570551fccc103/vmlinuz-5.1.0-10179-ge0ee0e7"
dequeue_time: 2019-05-15 21:54:35.348192077 +08:00

#! /lkp/lkp/.src-20190515-213058/include/site/inn
job_state: finished
loadavg: 35.50 85.70 47.15 1/1657 122870
start_time: '1557928553'
end_time: '1557928861'
version: "/lkp/lkp/.src-20190515-213058"

--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cp data/workfile.shared .
mkdir -p /fs/shm
umount /fs/shm
mount -t tmpfs tmpfs /fs/shm
echo FILESIZE 10k > reaim.config
echo POOLSIZE 1m >> reaim.config
echo DISKDIR /fs/shm  >> reaim.config
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s256 -e256 -i256 -fworkfile.shared -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100

--1y1tiN5hVw5cPBDe--
