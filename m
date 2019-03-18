Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F35C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344542085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCRNfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:35:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:45581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfCRNfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:35:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="yaml'?scan'208";a="142985644"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2019 06:35:27 -0700
Date:   Mon, 18 Mar 2019 21:35:55 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, lkp@01.org
Subject: [LKP] [tmpfs, devtmpfs, ramfs, rootfs]  9d65ac8a35:
 vm-scalability.median -19.4% regression
Message-ID: <20190318133553.GB20018@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -19.4% regression of vm-scalability.median due to commit:


commit: 9d65ac8a35a75c7334cfa0f855215c91bb4e752b ("tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git mount-api-viro

in testcase: vm-scalability
on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
with following parameters:

	runtime: 300s
	size: 16G
	test: shm-pread-rand
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.median 17.0% improvement                |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                           |
|                  | runtime=300s                                                           |
|                  | size=256G                                                              |
|                  | test=lru-shm-rand                                                      |
+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.median -20.3% regression                |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                           |
|                  | runtime=300s                                                           |
|                  | size=16G                                                               |
|                  | test=shm-xread-rand                                                    |
+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.median -3.4% regression                 |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                           |
|                  | runtime=300s                                                           |
|                  | size=2T                                                                |
|                  | test=shm-xread-seq-mt                                                  |
+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.median -40.5% regression                |
| test machine     | 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory |
| test parameters  | cpufreq_governor=performance                                           |
|                  | runtime=300s                                                           |
|                  | size=16G                                                               |
|                  | test=shm-pread-rand                                                    |
|                  | ucode=0xb00002e                                                        |
+------------------+------------------------------------------------------------------------+


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2018-04-03.cgz/300s/16G/lkp-bdw-ep2/shm-pread-rand/vm-scalability

commit: 
  8055fb607e ("vfs: Convert smackfs to fs_context")
  9d65ac8a35 ("tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context")

8055fb607ebc82ea 9d65ac8a35a75c7334cfa0f8552 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     35.50           -50.0%      17.74        vm-scalability.free_time
     58652           -19.4%      47285        vm-scalability.median
   5153844           -19.5%    4147169        vm-scalability.throughput
    345.52            -6.6%     322.82        vm-scalability.time.elapsed_time
    345.52            -6.6%     322.82        vm-scalability.time.elapsed_time.max
    113751 ±  2%      -4.7%     108399 ±  2%  vm-scalability.time.involuntary_context_switches
  65947512           -50.0%   32974438        vm-scalability.time.maximum_resident_set_size
 1.362e+08           -50.0%   68095705        vm-scalability.time.minor_page_faults
      8553            +1.2%       8659        vm-scalability.time.percent_of_cpu_this_job_got
      5020           -49.4%       2539        vm-scalability.time.system_time
     24536            +3.6%      25415        vm-scalability.time.user_time
  1.55e+09           -19.6%  1.245e+09        vm-scalability.workload
   3583491           -19.8%    2873813        pmeter.performance_per_watt
 7.662e+08 ± 18%     -49.4%  3.875e+08 ± 37%  cpuidle.C6.time
    855882 ± 15%     -44.3%     476492 ± 34%  cpuidle.C6.usage
      1.46 ± 14%      -0.2        1.24 ±  8%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.30 ±100%      +0.4        0.68 ± 10%  perf-profile.calltrace.cycles-pp.read_tsc.ktime_get.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt
      2.83 ±  3%      -1.1        1.70 ±  6%  mpstat.cpu.all.idle%
     16.52            -7.6        8.96        mpstat.cpu.all.sys%
     80.64            +8.7       89.34        mpstat.cpu.all.usr%
     79.50           +10.7%      88.00        vmstat.cpu.us
  64655701           -48.2%   33511191        vmstat.memory.cache
  55573932           +65.7%   92083684        vmstat.memory.free
  10158808 ±  3%     -48.1%    5271382 ±  5%  numa-numastat.node0.local_node
  10167474 ±  3%     -48.1%    5281431 ±  5%  numa-numastat.node0.numa_hit
   9928425 ±  3%     -48.5%    5109232 ±  5%  numa-numastat.node1.local_node
   9937061 ±  3%     -48.5%    5116473 ±  5%  numa-numastat.node1.numa_hit
      9.68           +10.8%      10.72 ±  8%  sched_debug.cfs_rq:/.runnable_load_avg.avg
     24.21 ± 10%    +354.2%     109.96 ± 73%  sched_debug.cfs_rq:/.runnable_load_avg.max
      2.33 ±  9%    +380.7%      11.20 ± 75%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
    130581 ± 18%     +44.1%     188155 ± 17%  sched_debug.cpu.avg_idle.stddev
      2711            +1.1%       2741        turbostat.Avg_MHz
    845415 ± 15%     -44.9%     465446 ± 36%  turbostat.C6
      2.50 ± 18%      -1.2        1.34 ± 37%  turbostat.C6%
      0.94 ± 12%     -47.2%       0.49 ±  8%  turbostat.Pkg%pc2
     26.52            +2.8%      27.25        turbostat.RAMWatt
      3921 ±  5%     -13.9%       3375 ±  8%  slabinfo.kmalloc-rcl-64.active_objs
      3921 ±  5%     -13.9%       3375 ±  8%  slabinfo.kmalloc-rcl-64.num_objs
    742.00 ±  3%     -21.6%     582.00 ±  9%  slabinfo.kmem_cache_node.active_objs
    783.00 ±  3%     -20.4%     623.00 ±  8%  slabinfo.kmem_cache_node.num_objs
    272701           -46.8%     144966        slabinfo.radix_tree_node.active_objs
      4930           -47.2%       2604        slabinfo.radix_tree_node.active_slabs
    276130           -47.2%     145877        slabinfo.radix_tree_node.num_objs
      4930           -47.2%       2604        slabinfo.radix_tree_node.num_slabs
   4569892           -68.8%    1424560        meminfo.Active
   4569576           -68.8%    1424248        meminfo.Active(anon)
  64567907           -48.2%   33424445        meminfo.Cached
  64384458           -49.4%   32588466        meminfo.Committed_AS
  59013843           -47.4%   31022617        meminfo.Inactive
  59012549           -47.4%   31021325        meminfo.Inactive(anon)
    222415           -33.3%     148303        meminfo.KReclaimable
  58958501           -47.5%   30968794        meminfo.Mapped
  54904833           +66.6%   91471162        meminfo.MemAvailable
  55411629           +66.1%   92014991        meminfo.MemFree
  76480902           -47.9%   39877539        meminfo.Memused
  10903221           -49.3%    5527712        meminfo.PageTables
    222415           -33.3%     148303        meminfo.SReclaimable
  63339328           -49.2%   32202719        meminfo.Shmem
    351616           -20.9%     278049        meminfo.Slab
    238022           -44.9%     131123        meminfo.max_used_kB
   1141190           -68.8%     355914        proc-vmstat.nr_active_anon
   1368629           +66.7%    2281555        proc-vmstat.nr_dirty_background_threshold
   2740606           +66.7%    4568693        proc-vmstat.nr_dirty_threshold
  16135961           -48.2%    8356035        proc-vmstat.nr_file_pages
  13860684           +66.0%   23003344        proc-vmstat.nr_free_pages
  14748066           -47.4%    7755141        proc-vmstat.nr_inactive_anon
  14734654           -47.5%    7742396        proc-vmstat.nr_mapped
   2724876           -49.3%    1382176        proc-vmstat.nr_page_table_pages
  15828555           -49.1%    8050342        proc-vmstat.nr_shmem
     55601           -33.3%      37078        proc-vmstat.nr_slab_reclaimable
   1141190           -68.8%     355914        proc-vmstat.nr_zone_active_anon
  14748066           -47.4%    7755141        proc-vmstat.nr_zone_inactive_anon
  20129588           -48.2%   10426124        proc-vmstat.numa_hit
  20112280           -48.2%   10408815        proc-vmstat.numa_local
  16498333           -50.0%    8255747        proc-vmstat.pgactivate
  20220521           -48.1%   10503690        proc-vmstat.pgalloc_normal
 1.371e+08           -49.7%   68925453        proc-vmstat.pgfault
  19940928           -48.5%   10269082 ±  2%  proc-vmstat.pgfree
    222.75 ± 30%     +57.7%     351.25 ± 40%  interrupts.46:IR-PCI-MSI.1572876-edge.eth0-TxRx-12
    214.75 ± 30%     -26.2%     158.50        interrupts.76:IR-PCI-MSI.1572904-edge.eth0-TxRx-40
    174.25 ±  2%      -9.0%     158.50        interrupts.84:IR-PCI-MSI.1572912-edge.eth0-TxRx-48
    546.00 ±  2%      -8.9%     497.50        interrupts.9:IR-IO-APIC.9-fasteoi.acpi
    314943            -5.9%     296436        interrupts.CAL:Function_call_interrupts
    546.00 ±  2%      -8.9%     497.50        interrupts.CPU1.9:IR-IO-APIC.9-fasteoi.acpi
    222.75 ± 30%     +57.7%     351.25 ± 40%  interrupts.CPU12.46:IR-PCI-MSI.1572876-edge.eth0-TxRx-12
    937.75 ± 45%     -68.9%     292.00 ±106%  interrupts.CPU13.RES:Rescheduling_interrupts
    165.25 ± 82%    +146.3%     407.00 ± 16%  interrupts.CPU26.RES:Rescheduling_interrupts
      4933 ± 34%     +59.4%       7861        interrupts.CPU33.NMI:Non-maskable_interrupts
      4933 ± 34%     +59.4%       7861        interrupts.CPU33.PMI:Performance_monitoring_interrupts
      4951 ± 34%     +59.2%       7880        interrupts.CPU35.NMI:Non-maskable_interrupts
      4951 ± 34%     +59.2%       7880        interrupts.CPU35.PMI:Performance_monitoring_interrupts
    318.50 ± 59%    +142.9%     773.50 ± 48%  interrupts.CPU37.RES:Rescheduling_interrupts
    214.75 ± 30%     -26.2%     158.50        interrupts.CPU40.76:IR-PCI-MSI.1572904-edge.eth0-TxRx-40
    174.25 ±  2%      -9.0%     158.50        interrupts.CPU48.84:IR-PCI-MSI.1572912-edge.eth0-TxRx-48
    259.25 ± 90%     -75.5%      63.50 ± 84%  interrupts.CPU52.RES:Rescheduling_interrupts
     62.75 ±  3%    +549.8%     407.75 ± 48%  interrupts.CPU56.RES:Rescheduling_interrupts
    101.25 ± 18%     -41.5%      59.25 ± 41%  interrupts.CPU65.RES:Rescheduling_interrupts
    112.50 ± 88%     -77.3%      25.50 ± 58%  interrupts.CPU78.RES:Rescheduling_interrupts
   2329031 ±  2%     -68.6%     732077 ±  6%  numa-meminfo.node0.Active
   2328876 ±  2%     -68.6%     731939 ±  6%  numa-meminfo.node0.Active(anon)
  32528442           -47.6%   17046796        numa-meminfo.node0.FilePages
  29716367           -46.7%   15825723        numa-meminfo.node0.Inactive
  29715713           -46.7%   15825283        numa-meminfo.node0.Inactive(anon)
  29686207           -46.8%   15780849        numa-meminfo.node0.Mapped
  27255472 ±  4%     +66.0%   45237231        numa-meminfo.node0.MemFree
  38598666 ±  2%     -46.6%   20610335 ±  3%  numa-meminfo.node0.MemUsed
   5516070 ±  9%     -44.9%    3039561 ±  9%  numa-meminfo.node0.PageTables
  31920558           -48.5%   16434497        numa-meminfo.node0.Shmem
   2288090 ±  3%     -69.1%     706425 ±  6%  numa-meminfo.node1.Active
   2287930 ±  3%     -69.1%     706252 ±  6%  numa-meminfo.node1.Active(anon)
  32045048           -48.9%   16388773        numa-meminfo.node1.FilePages
  29254750           -48.1%   15193020        numa-meminfo.node1.Inactive
  29254110           -48.1%   15192167        numa-meminfo.node1.Inactive(anon)
  29229499           -48.1%   15183674        numa-meminfo.node1.Mapped
  28158551 ±  3%     +66.1%   46765793        numa-meminfo.node1.MemFree
  37879839 ±  2%     -49.1%   19279170 ±  3%  numa-meminfo.node1.MemUsed
   5382524 ± 10%     -53.7%    2490391 ± 11%  numa-meminfo.node1.PageTables
  31423310           -49.8%   15778300        numa-meminfo.node1.Shmem
    581468 ±  2%     -68.6%     182804 ±  6%  numa-vmstat.node0.nr_active_anon
   8125960           -47.5%    4262789        numa-vmstat.node0.nr_file_pages
   6821064 ±  4%     +65.8%   11307564        numa-vmstat.node0.nr_free_pages
   7423531           -46.7%    3957573        numa-vmstat.node0.nr_inactive_anon
   7416171           -46.8%    3946658        numa-vmstat.node0.nr_mapped
   1377979 ±  9%     -44.8%     760546 ±  9%  numa-vmstat.node0.nr_page_table_pages
   7973989           -48.5%    4109714        numa-vmstat.node0.nr_shmem
    581468 ±  2%     -68.6%     182804 ±  6%  numa-vmstat.node0.nr_zone_active_anon
   7423531           -46.7%    3957573        numa-vmstat.node0.nr_zone_inactive_anon
  10222865 ±  3%     -45.7%    5555074 ±  3%  numa-vmstat.node0.numa_hit
  10213690 ±  3%     -45.7%    5544531 ±  3%  numa-vmstat.node0.numa_local
    571252 ±  3%     -69.1%     176447 ±  6%  numa-vmstat.node1.nr_active_anon
   8005128           -48.8%    4098150        numa-vmstat.node1.nr_file_pages
   7046569 ±  3%     +65.9%   11690035        numa-vmstat.node1.nr_free_pages
   7308130           -48.0%    3799139        numa-vmstat.node1.nr_inactive_anon
   7302096           -48.0%    3797203        numa-vmstat.node1.nr_mapped
   1344848 ±  9%     -53.7%     623009 ± 11%  numa-vmstat.node1.nr_page_table_pages
   7849694           -49.7%    3945532        numa-vmstat.node1.nr_shmem
    571251 ±  3%     -69.1%     176446 ±  6%  numa-vmstat.node1.nr_zone_active_anon
   7308130           -48.0%    3799139        numa-vmstat.node1.nr_zone_inactive_anon
   9965690 ±  3%     -47.2%    5258034 ±  3%  numa-vmstat.node1.numa_hit
   9781491 ±  3%     -48.1%    5075833 ±  4%  numa-vmstat.node1.numa_local
    140703 ±  3%     -14.3%     120593 ±  6%  softirqs.CPU10.TIMER
    142725 ±  2%     -16.8%     118771 ±  5%  softirqs.CPU11.TIMER
    145496 ±  3%     -17.4%     120236 ±  5%  softirqs.CPU12.TIMER
    142496 ±  4%     -15.8%     119968 ±  5%  softirqs.CPU13.TIMER
    147287 ±  5%     -15.9%     123852 ±  7%  softirqs.CPU14.TIMER
    149316 ±  2%     -15.3%     126451 ±  7%  softirqs.CPU15.TIMER
    143888 ±  5%     -13.9%     123840 ±  7%  softirqs.CPU16.TIMER
    141273 ±  4%     -15.1%     120003 ±  5%  softirqs.CPU19.TIMER
    146948 ±  6%     -15.4%     124264 ±  7%  softirqs.CPU2.TIMER
    146064 ±  4%     -14.8%     124416 ±  7%  softirqs.CPU20.TIMER
    144060 ±  5%     -15.6%     121575 ±  6%  softirqs.CPU3.TIMER
    146000 ±  2%     -15.4%     123551 ±  6%  softirqs.CPU4.TIMER
     34170 ± 19%     +25.2%      42774 ±  7%  softirqs.CPU45.RCU
    143930 ±  5%     -13.6%     124408 ±  8%  softirqs.CPU46.TIMER
    145203 ±  5%     -15.6%     122528 ±  6%  softirqs.CPU47.TIMER
    143932 ±  4%     -15.1%     122182 ±  6%  softirqs.CPU48.TIMER
    142245 ±  4%     -14.2%     122017 ±  6%  softirqs.CPU49.TIMER
    141972 ±  4%     -14.1%     121995 ±  6%  softirqs.CPU5.TIMER
    145814 ±  4%     -13.5%     126067 ±  8%  softirqs.CPU50.TIMER
    143490 ±  5%     -13.2%     124617 ±  8%  softirqs.CPU51.TIMER
    144034           -15.8%     121348 ±  5%  softirqs.CPU52.TIMER
    140485 ±  3%     -14.0%     120835 ±  6%  softirqs.CPU54.TIMER
    140156 ±  2%     -15.0%     119090 ±  5%  softirqs.CPU55.TIMER
    142404 ±  3%     -16.3%     119214 ±  6%  softirqs.CPU56.TIMER
    141461 ±  4%     -16.1%     118734 ±  5%  softirqs.CPU57.TIMER
    145017 ±  5%     -15.2%     122909 ±  7%  softirqs.CPU58.TIMER
    146559 ±  4%     -13.5%     126754 ±  7%  softirqs.CPU59.TIMER
    146090 ±  5%     -14.2%     125326 ±  8%  softirqs.CPU6.TIMER
    143474 ±  4%     -14.6%     122493 ±  7%  softirqs.CPU60.TIMER
    138424 ±  5%     -13.5%     119705 ±  6%  softirqs.CPU61.TIMER
    141324 ±  4%     -15.2%     119813 ±  6%  softirqs.CPU63.TIMER
    146399 ±  3%     -15.6%     123495 ±  7%  softirqs.CPU64.TIMER
    144796 ±  5%     -13.6%     125089 ±  8%  softirqs.CPU7.TIMER
    144444           -16.0%     121322 ±  4%  softirqs.CPU8.TIMER
    144366 ±  3%     -14.5%     123476 ±  6%  softirqs.CPU9.TIMER
    335692           -15.1%     285135 ±  2%  softirqs.SCHED
  12267090 ±  3%      -9.0%   11168809 ±  2%  softirqs.TIMER
     27.35            +2.9%      28.15        perf-stat.i.MPKI
 8.823e+09            -1.4%  8.697e+09        perf-stat.i.branch-instructions
      0.15 ±  4%      -0.0        0.10 ±  8%  perf-stat.i.branch-miss-rate%
  10706236           -29.4%    7553569        perf-stat.i.branch-misses
     63.60            +4.2       67.76        perf-stat.i.cache-miss-rate%
 6.597e+08            +8.5%  7.154e+08        perf-stat.i.cache-misses
 9.614e+08            +5.4%  1.013e+09        perf-stat.i.cache-references
      6.44            +1.4%       6.53        perf-stat.i.cpi
 2.379e+11            +1.2%  2.408e+11        perf-stat.i.cpu-cycles
    657.07 ±  2%     -23.0%     505.74        perf-stat.i.cycles-between-cache-misses
      4.43            +0.4        4.84        perf-stat.i.dTLB-load-miss-rate%
 4.713e+08           +12.3%  5.294e+08        perf-stat.i.dTLB-load-misses
 3.296e+09            +5.8%  3.489e+09        perf-stat.i.dTLB-stores
    888133 ±  3%     -41.6%     518784 ±  6%  perf-stat.i.iTLB-load-misses
 3.784e+10            -1.3%  3.734e+10        perf-stat.i.instructions
      0.17            -4.7%       0.16        perf-stat.i.ipc
    394814           -46.2%     212352        perf-stat.i.minor-faults
     37.04            -3.7       33.29 ±  3%  perf-stat.i.node-load-miss-rate%
 1.848e+08           +10.2%  2.036e+08 ±  3%  perf-stat.i.node-load-misses
 4.608e+08            +9.3%  5.038e+08 ±  2%  perf-stat.i.node-loads
     32.56 ± 20%     -10.4       22.18 ± 16%  perf-stat.i.node-store-miss-rate%
   2252868           -44.9%    1240402        perf-stat.i.node-store-misses
   1551162           -41.4%     908499 ±  2%  perf-stat.i.node-stores
    394819           -46.2%     212359        perf-stat.i.page-faults
     25.34            +6.9%      27.09        perf-stat.overall.MPKI
      0.12            -0.0        0.09        perf-stat.overall.branch-miss-rate%
     68.59            +2.0       70.60        perf-stat.overall.cache-miss-rate%
      6.28            +2.6%       6.45        perf-stat.overall.cpi
    361.41            -6.7%     337.04        perf-stat.overall.cycles-between-cache-misses
      4.21            +0.5        4.73        perf-stat.overall.dTLB-load-miss-rate%
     42463 ±  3%     +69.3%      71884 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.16            -2.6%       0.16        perf-stat.overall.ipc
     59.20            -1.5       57.72        perf-stat.overall.node-store-miss-rate%
      8436           +14.7%       9672        perf-stat.overall.path-length
 8.808e+09            -1.5%  8.676e+09        perf-stat.ps.branch-instructions
  10767486           -29.4%    7602885        perf-stat.ps.branch-misses
 6.563e+08            +8.5%  7.123e+08        perf-stat.ps.cache-misses
  9.57e+08            +5.4%  1.009e+09        perf-stat.ps.cache-references
 2.372e+11            +1.2%  2.401e+11        perf-stat.ps.cpu-cycles
 4.688e+08           +12.4%   5.27e+08        perf-stat.ps.dTLB-load-misses
 3.283e+09            +5.9%  3.475e+09        perf-stat.ps.dTLB-stores
    890294 ±  3%     -41.6%     520318 ±  6%  perf-stat.ps.iTLB-load-misses
 3.777e+10            -1.4%  3.724e+10        perf-stat.ps.instructions
    395820           -46.2%     213017        perf-stat.ps.minor-faults
 1.839e+08           +10.2%  2.028e+08 ±  3%  perf-stat.ps.node-load-misses
 4.583e+08            +9.4%  5.015e+08 ±  2%  perf-stat.ps.node-loads
   2263230           -44.9%    1247828        perf-stat.ps.node-store-misses
   1559702           -41.4%     914092 ±  2%  perf-stat.ps.node-stores
    395820           -46.2%     213017        perf-stat.ps.page-faults
 1.307e+13            -7.9%  1.205e+13        perf-stat.total.instructions


                                                                                
                            vm-scalability.time.user_time                       
                                                                                
  25600 +-+-----------------------------------------------------------------+   
        O O O  O     OO   O                                                 |   
  25400 +-+  O   O O    O   OO O O O OO O O O OO O O                        |   
        |                                                                   |   
  25200 +-+                                                                 |   
        |                                                                   |   
  25000 +-+                                                                 |   
        |                                                                   |   
  24800 +-+                                                   +             |   
        |                                                    +:             |   
  24600 +-+                                                 +  :           +|   
        |  .++. .+   +   .+.  .+.+.    .+.+. .+            +   :.+.+.+.+ .+ |   
  24400 +-+    +  + + +.+   ++     +.++     +  +. .+.+.++.+    +        +   |   
        |          +                             +                          |   
  24200 +-+-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          vm-scalability.time.system_time                       
                                                                                
  5500 +-+------------------------------------------------------------------+   
       |       .+.+.                                                        |   
  5000 +-+.++.+     +.++.+.+.+.++.+.+.+.+.++.+.+.+.++.+.+.+.+ .+.+.+.+.++.+.|   
       |                                                     +              |   
       |                                                                    |   
  4500 +-+                                                                  |   
       |                                                                    |   
  4000 +-+                                                                  |   
       |                                                                    |   
  3500 +-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3000 +-+                                                                  |   
       |                                                                    |   
  2500 O-O-OO-O-O-O-O-OO-O-O-O-OO-O-O-O-O-OO-O-O-O-O------------------------+   
                                                                                
                                                                                                                                                                
                  vm-scalability.time.percent_of_cpu_this_job_got               
                                                                                
  8680 +-+------------------------------------------------------------------+   
       |   OO O        O   O    O                                           |   
  8660 O-O      O O O O  O   O O  O O O O OO O O O O                        |   
  8640 +-+                                                                  |   
       |                                                                    |   
  8620 +-+                                                                  |   
       |                                                                    |   
  8600 +-+                                                                  |   
       |                                                                    |   
  8580 +-+                                                                  |   
  8560 +-+  +    .+.            +        .+                                 |   
       |. .+ + .+   +. +. .+. .+ + .+. .+  :.+.+.    .+.+.+.++.+.+. .+.++.+.|   
  8540 +-+    +       +  +   +    +   +    +     +.++              +        |   
       |                                                                    |   
  8520 +-+------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         vm-scalability.time.elapsed_time                       
                                                                                
  350 +-+-------------------------------------------------------------------+   
      |       .+.                                                           |   
  345 +-+.+.++   +.+.+.++.+.+.+.+.++.+.+.+.+.+.++.+.+.+.+.++.+.+.+.+.++.+.+.|   
      |                                                                     |   
      |                                                                     |   
  340 +-+                                                                   |   
      |                                                                     |   
  335 +-+                                                                   |   
      |                                                                     |   
  330 +-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  325 +-+        O O   OO          O O       O                              |   
      O O O OO O     O    O O O O O    O O O   OO O                         |   
  320 +-+-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       vm-scalability.time.elapsed_time.max                     
                                                                                
  350 +-+-------------------------------------------------------------------+   
      |       .+.                                                           |   
  345 +-+.+.++   +.+.+.++.+.+.+.+.++.+.+.+.+.+.++.+.+.+.+.++.+.+.+.+.++.+.+.|   
      |                                                                     |   
      |                                                                     |   
  340 +-+                                                                   |   
      |                                                                     |   
  335 +-+                                                                   |   
      |                                                                     |   
  330 +-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  325 +-+        O O   OO          O O       O                              |   
      O O O OO O     O    O O O O O    O O O   OO O                         |   
  320 +-+-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     vm-scalability.time.maximum_resident_set_size              
                                                                                
    7e+07 +-+---------------------------------------------------------------+   
          |.++.+.+.++.+.+.++.+.+.++.+.+.++.+.++.+.+.++.+.+.++.+.+.++.+.+.++.|   
  6.5e+07 +-+                                                               |   
    6e+07 +-+                                                               |   
          |                                                                 |   
  5.5e+07 +-+                                                               |   
          |                                                                 |   
    5e+07 +-+                                                               |   
          |                                                                 |   
  4.5e+07 +-+                                                               |   
    4e+07 +-+                                                               |   
          |                                                                 |   
  3.5e+07 +-+                                                               |   
          O OO O O OO O O OO O O OO O O OO O OO O O O                       |   
    3e+07 +-+---------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         vm-scalability.time.minor_page_faults                  
                                                                                
  1.4e+08 +-+---------------------------------------------------------------+   
          |.++.+.+.++.+.+.++.+.+.++.+.+.++.+.++.+.+.++.+.+.++.+.+.++.+.+.++.|   
  1.3e+08 +-+                                                               |   
  1.2e+08 +-+                                                               |   
          |                                                                 |   
  1.1e+08 +-+                                                               |   
          |                                                                 |   
    1e+08 +-+                                                               |   
          |                                                                 |   
    9e+07 +-+                                                               |   
    8e+07 +-+                                                               |   
          |                                                                 |   
    7e+07 +-+                                                               |   
          O OO O O OO O O OO O O OO O O OO O OO O O O                       |   
    6e+07 +-+---------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               vm-scalability.throughput                        
                                                                                
  5.4e+06 +-+---------------------------------------------------------------+   
          |                                                                 |   
  5.2e+06 +-+ .+.+. +. .+.  .+.   +.+.+.  .+.++.+. .+ .+.+. +.+.+.++.+. .++.|   
          | ++     +  +   ++   +.+      ++        +  +     +           +    |   
    5e+06 +-+                                                               |   
          |                                                                 |   
  4.8e+06 +-+                                                               |   
          |                                                                 |   
  4.6e+06 +-+                                                               |   
          |                                                                 |   
  4.4e+06 +-+                                                               |   
          |                                                                 |   
  4.2e+06 O-+  O   O      OO O   O    O  O O    O O                         |   
          | OO   O  O O O      O  O O   O    OO     O                       |   
    4e+06 +-+---------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            vm-scalability.free_time                            
                                                                                
  38 +-+--------------------------------------------------------------------+   
  36 +-+     .+.+.     .+.                         .+.      .+.+.           |   
     |.+.+.++     +.+.+   ++.+.+.+.+.+.+.++.+.+.+.+   ++.+.+     +.+.++.+.+.|   
  34 +-+                                                                    |   
  32 +-+                                                                    |   
  30 +-+                                                                    |   
  28 +-+                                                                    |   
     |                                                                      |   
  26 +-+                                                                    |   
  24 +-+                                                                    |   
  22 +-+                                                                    |   
  20 +-+                                                                    |   
     |                                                                      |   
  18 O-O O OO O O O O O O OO O O O O O O OO O O O O                         |   
  16 +-+--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                vm-scalability.median                           
                                                                                
  60000 +-+-----------------------------------------------------------------+   
        |.   +.+. .+. +.+. .+   .+.+.+   .+.+.++. .+. .++.+.+.++.+.+.+.++.+.|   
  58000 +-+.+    +   +    +  +.+      +.+        +   +                      |   
        |                                                                   |   
  56000 +-+                                                                 |   
        |                                                                   |   
  54000 +-+                                                                 |   
        |                                                                   |   
  52000 +-+                                                                 |   
        |                                                                   |   
  50000 +-+                                                                 |   
        |                                                                   |   
  48000 O-+      O      O O O  O     O  O      O                            |   
        | O OO O   O OO      O   O    O   O O O  O O                        |   
  46000 +-+------------------------O----------------------------------------+   
                                                                                
                                                                                                                                                                
                                vm-scalability.workload                         
                                                                                
   1.6e+09 +-+--------------------------------------------------------------+   
           |.                .+.      +.      .+.           .+     +.       |   
  1.55e+09 +-++.+.+.++.+.++.+   ++.+.+  +.+.++   ++.+.++.+.+  +.+.+  +.+.++.|   
   1.5e+09 +-+                                                              |   
           |                                                                |   
  1.45e+09 +-+                                                              |   
           |                                                                |   
   1.4e+09 +-+                                                              |   
           |                                                                |   
  1.35e+09 +-+                                                              |   
   1.3e+09 +-+                                                              |   
           |                                                                |   
  1.25e+09 O-OO O O OO O OO O O  O    O O O O  O OO                         |   
           |                    O  O O       O      O                       |   
   1.2e+09 +-+--------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              pmeter.performance_per_watt                       
                                                                                
  3.7e+06 +-+---------------------------------------------------------------+   
          |  +.+.               .++.     +.+. +.            +. .+. +.       |   
  3.6e+06 +-+    +.++.+.+.++.+.+    +.+.+    +  +.+.++.+.+.+  +   +  +.+.++.|   
  3.5e+06 +-+                                                               |   
          |                                                                 |   
  3.4e+06 +-+                                                               |   
  3.3e+06 +-+                                                               |   
          |                                                                 |   
  3.2e+06 +-+                                                               |   
  3.1e+06 +-+                                                               |   
          |                                                                 |   
    3e+06 +-+                                                               |   
  2.9e+06 O-O             O  O   O                                          |   
          |  O O O OO O O  O   O  O O O OO O OO O O O                       |   
  2.8e+06 +-+---------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-bdw-ep2: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2018-04-03.cgz/300s/256G/lkp-bdw-ep2/lru-shm-rand/vm-scalability

commit: 
  8055fb607e ("vfs: Convert smackfs to fs_context")
  9d65ac8a35 ("tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context")

8055fb607ebc82ea 9d65ac8a35a75c7334cfa0f8552 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
      0.03           -52.0%       0.01        vm-scalability.free_time
     54285           +17.0%      63517        vm-scalability.median
      0.00 ± 27%    +218.7%       0.01 ±  3%  vm-scalability.median_stddev
   4776085           +16.8%    5576527        vm-scalability.throughput
    187.64            -6.7%     175.08        vm-scalability.time.elapsed_time
    187.64            -6.7%     175.08        vm-scalability.time.elapsed_time.max
    750512           -49.9%     376070        vm-scalability.time.maximum_resident_set_size
      5850            -8.4%       5361        vm-scalability.time.percent_of_cpu_this_job_got
    880.16            -6.5%     823.38        vm-scalability.time.system_time
     10097           -15.2%       8563        vm-scalability.time.user_time
     10295           +98.8%      20463        vm-scalability.time.voluntary_context_switches
     33.44            +5.3       38.74        mpstat.cpu.all.idle%
      0.00 ±100%      +0.0        0.00 ± 46%  mpstat.cpu.all.iowait%
    375.53            -1.5%     369.95        pmeter.Average_Active_Power
   1593388            +1.6%    1619557        pmeter.performance_per_watt
      1880            -7.6%       1737        turbostat.Avg_MHz
    184.21            -1.7%     181.07        turbostat.PkgWatt
     23.07            -5.2%      21.88        turbostat.RAMWatt
     33.75           +15.6%      39.00        vmstat.cpu.id
     60.00            -8.8%      54.75        vmstat.cpu.us
  55054325           -49.4%   27836911        vmstat.memory.cache
  75933593           +35.9%  1.032e+08        vmstat.memory.free
      1985           +43.8%       2855 ±  4%  vmstat.system.cs
     11984 ±  2%      +8.9%      13047        slabinfo.cred_jar.active_objs
     11984 ±  2%      +8.9%      13047        slabinfo.cred_jar.num_objs
      4107           +10.4%       4536        slabinfo.pid.active_objs
      4107           +10.4%       4536        slabinfo.pid.num_objs
    238266           -47.5%     125045        slabinfo.radix_tree_node.active_objs
      4278           -47.3%       2254        slabinfo.radix_tree_node.active_slabs
    239600           -47.3%     126312        slabinfo.radix_tree_node.num_objs
      4278           -47.3%       2254        slabinfo.radix_tree_node.num_slabs
    681.50 ±  3%     +35.4%     923.00 ± 10%  slabinfo.skbuff_ext_cache.active_objs
    681.50 ±  3%     +35.4%     923.00 ± 10%  slabinfo.skbuff_ext_cache.num_objs
  54983067           -49.6%   27699207        meminfo.Cached
  53998108           -50.6%   26652818        meminfo.Committed_AS
  53743330           -50.7%   26469267        meminfo.Inactive
  53741872           -50.8%   26467690        meminfo.Inactive(anon)
    201706           -32.7%     135684        meminfo.KReclaimable
  41309028           -54.4%   18841465        meminfo.Mapped
  75285897           +36.3%  1.026e+08        meminfo.MemAvailable
  75802933           +36.1%  1.032e+08        meminfo.MemFree
  56089597           -48.8%   28702330        meminfo.Memused
     91718           -50.0%      45872        meminfo.PageTables
    201706           -32.7%     135684        meminfo.SReclaimable
  53753761           -50.7%   26477700        meminfo.Shmem
    335668           -19.0%     272009        meminfo.Slab
    370692           -44.8%     204627        meminfo.max_used_kB
   6859775 ±  2%     -49.9%    3434155 ±  2%  numa-vmstat.node0.nr_file_pages
   9437339 ±  2%     +36.4%   12875285        numa-vmstat.node0.nr_free_pages
   6702347 ±  3%     -51.1%    3277184 ±  2%  numa-vmstat.node0.nr_inactive_anon
   5127207           -53.6%    2379043        numa-vmstat.node0.nr_mapped
     11593 ±  2%     -47.1%       6132        numa-vmstat.node0.nr_page_table_pages
   6703873 ±  3%     -51.1%    3279148 ±  2%  numa-vmstat.node0.nr_shmem
     26487 ±  3%     -27.4%      19231 ±  4%  numa-vmstat.node0.nr_slab_reclaimable
   6702334 ±  3%     -51.1%    3277168 ±  2%  numa-vmstat.node0.nr_zone_inactive_anon
   6855232 ±  3%     -49.1%    3488488 ±  3%  numa-vmstat.node1.nr_file_pages
   9544721 ±  2%     +35.4%   12924651        numa-vmstat.node1.nr_free_pages
   6702112 ±  3%     -50.2%    3337309 ±  3%  numa-vmstat.node1.nr_inactive_anon
   5115345           -54.6%    2324824        numa-vmstat.node1.nr_mapped
     11143 ±  2%     -51.8%       5368        numa-vmstat.node1.nr_page_table_pages
   6703548 ±  3%     -50.2%    3337861 ±  3%  numa-vmstat.node1.nr_shmem
     23866 ±  4%     -38.3%      14718 ±  6%  numa-vmstat.node1.nr_slab_reclaimable
   6702099 ±  3%     -50.2%    3337298 ±  3%  numa-vmstat.node1.nr_zone_inactive_anon
     78855 ±  6%     -12.1%      69301 ± 10%  softirqs.CPU22.TIMER
     20329 ±  9%     +16.7%      23727 ±  3%  softirqs.CPU28.RCU
     77548 ±  5%     -14.1%      66583 ± 11%  softirqs.CPU34.TIMER
     78632 ±  5%     -13.7%      67887 ± 11%  softirqs.CPU36.TIMER
     77969 ±  5%     -12.0%      68650 ± 10%  softirqs.CPU37.TIMER
     77859 ±  6%     -12.8%      67887 ± 11%  softirqs.CPU41.TIMER
     78802 ±  6%     -13.6%      68051 ± 11%  softirqs.CPU42.TIMER
      9417 ±  4%      +5.1%       9898 ±  5%  softirqs.CPU58.SCHED
     81061 ±  9%     -14.4%      69374 ±  8%  softirqs.CPU65.TIMER
      9601            +9.9%      10552 ±  7%  softirqs.CPU70.SCHED
     77194 ±  5%     -14.2%      66260 ± 11%  softirqs.CPU78.TIMER
     78250 ±  6%     -12.6%      68392 ± 10%  softirqs.CPU80.TIMER
     77574 ±  6%     -12.4%      67951 ± 10%  softirqs.CPU81.TIMER
     76944 ±  5%     -15.2%      65222 ± 13%  softirqs.CPU82.TIMER
     77169 ±  7%     -13.5%      66716 ± 11%  softirqs.CPU85.TIMER
     77530 ±  7%     -13.0%      67466 ± 11%  softirqs.CPU86.TIMER
    120.25           +58.8%     191.00        proc-vmstat.nr_dirtied
   1876748           +36.4%    2559252        proc-vmstat.nr_dirty_background_threshold
   3758164           +36.4%    5124848        proc-vmstat.nr_dirty_threshold
  13747341           -49.5%    6938038        proc-vmstat.nr_file_pages
  18949663           +36.1%   25784733        proc-vmstat.nr_free_pages
  13436775           -50.7%    6629895        proc-vmstat.nr_inactive_anon
    364.25            +8.1%     393.75        proc-vmstat.nr_inactive_file
  10320581           -54.7%    4678579        proc-vmstat.nr_mapped
     22830           -50.3%      11339        proc-vmstat.nr_page_table_pages
  13439754           -50.7%    6632403        proc-vmstat.nr_shmem
     50372           -32.7%      33900        proc-vmstat.nr_slab_reclaimable
     33490            +1.8%      34079        proc-vmstat.nr_slab_unreclaimable
    120.00           +42.9%     171.50        proc-vmstat.nr_written
  13436775           -50.7%    6629895        proc-vmstat.nr_zone_inactive_anon
    364.25            +8.1%     393.75        proc-vmstat.nr_zone_inactive_file
    496.75 ± 13%     +88.5%     936.50 ± 28%  proc-vmstat.numa_huge_pte_updates
    275761 ± 15%     +83.7%     506466 ± 26%  proc-vmstat.numa_pte_updates
    201.00 ± 57%     -52.6%      95.25 ±  6%  interrupts.41:IR-PCI-MSI.1572871-edge.eth0-TxRx-7
    206.75 ± 34%     -53.0%      97.25 ±  7%  interrupts.49:IR-PCI-MSI.1572879-edge.eth0-TxRx-15
    152.00 ± 63%     -42.9%      86.75        interrupts.52:IR-PCI-MSI.1572882-edge.eth0-TxRx-18
    124.75 ± 38%     -30.3%      87.00        interrupts.95:IR-PCI-MSI.1572923-edge.eth0-TxRx-59
      5664 ± 24%     -44.5%       3146 ± 33%  interrupts.CPU10.NMI:Non-maskable_interrupts
      5664 ± 24%     -44.5%       3146 ± 33%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    638.00 ± 45%     -81.1%     120.50 ± 63%  interrupts.CPU11.RES:Rescheduling_interrupts
    171.75 ± 40%     -65.9%      58.50 ± 38%  interrupts.CPU13.RES:Rescheduling_interrupts
    206.75 ± 34%     -53.0%      97.25 ±  7%  interrupts.CPU15.49:IR-PCI-MSI.1572879-edge.eth0-TxRx-15
    226.50 ±  8%     -55.1%     101.75 ± 41%  interrupts.CPU17.RES:Rescheduling_interrupts
    152.00 ± 63%     -42.9%      86.75        interrupts.CPU18.52:IR-PCI-MSI.1572882-edge.eth0-TxRx-18
    369764 ±  4%      -7.8%     341029 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
    128.00 ± 33%    +224.8%     415.75 ± 62%  interrupts.CPU38.RES:Rescheduling_interrupts
      1876 ±  7%     -29.2%       1328 ± 12%  interrupts.CPU43.RES:Rescheduling_interrupts
     82.25 ± 21%    +241.3%     280.75 ± 40%  interrupts.CPU49.RES:Rescheduling_interrupts
    326.00 ± 55%     -72.3%      90.25 ± 79%  interrupts.CPU51.RES:Rescheduling_interrupts
    124.75 ± 38%     -30.3%      87.00        interrupts.CPU59.95:IR-PCI-MSI.1572923-edge.eth0-TxRx-59
    201.00 ± 57%     -52.6%      95.25 ±  6%  interrupts.CPU7.41:IR-PCI-MSI.1572871-edge.eth0-TxRx-7
    116.75 ± 27%    +490.6%     689.50 ±103%  interrupts.CPU70.RES:Rescheduling_interrupts
     60.50 ± 53%    +339.3%     265.75 ± 48%  interrupts.CPU72.RES:Rescheduling_interrupts
     48.50 ± 64%    +862.4%     466.75 ± 60%  interrupts.CPU73.RES:Rescheduling_interrupts
    262.00 ± 14%    +112.4%     556.50 ± 11%  interrupts.TLB:TLB_shootdowns
  27405811 ±  2%     -49.9%   13728230 ±  2%  numa-meminfo.node0.FilePages
  26777106 ±  2%     -51.1%   13101235 ±  2%  numa-meminfo.node0.Inactive
  26776084 ±  2%     -51.1%   13100338 ±  2%  numa-meminfo.node0.Inactive(anon)
    105830 ±  3%     -27.3%      76923 ±  4%  numa-meminfo.node0.KReclaimable
  20465391           -53.7%    9474078        numa-meminfo.node0.Mapped
  37783048           +36.3%   51509577        numa-meminfo.node0.MemFree
  28064518 ±  2%     -48.9%   14344562 ±  2%  numa-meminfo.node0.MemUsed
     46263 ±  2%     -47.1%      24460        numa-meminfo.node0.PageTables
    105830 ±  3%     -27.3%      76923 ±  4%  numa-meminfo.node0.SReclaimable
  26782195 ±  2%     -51.1%   13108197 ±  2%  numa-meminfo.node0.Shmem
    179458 ±  3%     -13.1%     156022 ±  2%  numa-meminfo.node0.Slab
  27392441 ±  3%     -49.1%   13933317 ±  3%  numa-meminfo.node1.FilePages
  26780342 ±  3%     -50.2%   13329288 ±  3%  numa-meminfo.node1.Inactive
  26779908 ±  3%     -50.2%   13328609 ±  3%  numa-meminfo.node1.Inactive(anon)
     95194 ±  4%     -38.2%      58811 ±  6%  numa-meminfo.node1.KReclaimable
  20436709           -54.7%    9260997        numa-meminfo.node1.Mapped
  38207989 ±  2%     +35.4%   51719340        numa-meminfo.node1.MemFree
  27836974 ±  3%     -48.6%   14319050 ±  3%  numa-meminfo.node1.MemUsed
     44414 ±  3%     -51.8%      21393        numa-meminfo.node1.PageTables
     95194 ±  4%     -38.2%      58811 ±  6%  numa-meminfo.node1.SReclaimable
  26785705 ±  3%     -50.2%   13330801 ±  3%  numa-meminfo.node1.Shmem
    155528 ±  4%     -25.4%     116025 ±  3%  numa-meminfo.node1.Slab
     22.15 ±128%     -22.2        0.00        perf-profile.calltrace.cycles-pp.apic_timer_interrupt
     20.96 ±128%     -21.0        0.00        perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt
     16.69 ±127%     -16.7        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      5.32 ± 44%      -5.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.32 ± 44%      -5.3        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.03 ± 51%      -5.0        0.00        perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.03 ± 51%      -5.0        0.00        perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      5.03 ± 51%      -5.0        0.00        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.03 ± 51%      -5.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.01 ± 51%      -5.0        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      4.99 ± 51%      -5.0        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
      3.85 ± 63%      -3.7        0.19 ±173%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
      2.81 ± 39%      -2.3        0.52 ± 59%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.31 ± 33%      -2.0        0.29 ±101%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      2.31 ± 33%      -2.0        0.29 ±101%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      0.00            +1.3        1.25 ± 20%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma
      0.00            +1.3        1.27 ± 19%  perf-profile.calltrace.cycles-pp.clear_page_erms.shmem_getpage_gfp.shmem_fault.__do_fault.__handle_mm_fault
      0.00            +1.3        1.28 ± 20%  perf-profile.calltrace.cycles-pp._raw_spin_lock.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.00            +1.5        1.51 ±  6%  perf-profile.calltrace.cycles-pp.nrand48_r
      0.00            +1.7        1.65 ± 20%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page.shmem_alloc_and_acct_page
      0.00            +1.7        1.72 ± 20%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page.shmem_alloc_and_acct_page.shmem_getpage_gfp
      0.00            +1.8        1.76 ± 20%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.shmem_alloc_page.shmem_alloc_and_acct_page.shmem_getpage_gfp.shmem_fault
      0.00            +1.8        1.81 ± 20%  perf-profile.calltrace.cycles-pp.shmem_alloc_page.shmem_alloc_and_acct_page.shmem_getpage_gfp.shmem_fault.__do_fault
      0.00            +2.1        2.08 ± 20%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_acct_page.shmem_getpage_gfp.shmem_fault.__do_fault.__handle_mm_fault
      0.00            +3.2        3.20 ±  6%  perf-profile.calltrace.cycles-pp.do_rw_once
      0.00            +3.2        3.22 ± 20%  perf-profile.calltrace.cycles-pp.filemap_map_pages.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
      0.00            +4.8        4.83 ± 19%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_fault.__do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +4.9        4.92 ± 19%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault
      0.00            +4.9        4.94 ± 19%  perf-profile.calltrace.cycles-pp.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
      0.15 ±173%      +8.3        8.48 ± 19%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      0.00            +8.6        8.56 ± 19%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault.do_access
      0.00            +8.8        8.81 ± 19%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault.do_access
      0.00            +8.9        8.88 ± 19%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault.do_access
      0.00            +9.7        9.74 ± 22%  perf-profile.calltrace.cycles-pp.page_fault.do_access
      0.00           +86.0       86.00 ±  2%  perf-profile.calltrace.cycles-pp.do_access
     10007 ± 14%     -25.9%       7412 ±  9%  sched_debug.cfs_rq:/.load.avg
      7701 ± 14%     -20.4%       6130 ± 11%  sched_debug.cfs_rq:/.load.min
    300.23 ± 15%     +65.7%     497.54 ± 14%  sched_debug.cfs_rq:/.load_avg.max
   5164591 ± 15%     -58.4%    2147060 ± 33%  sched_debug.cfs_rq:/.min_vruntime.avg
   5239400 ± 15%     -58.1%    2195327 ± 33%  sched_debug.cfs_rq:/.min_vruntime.max
   5015129 ± 15%     -59.9%    2013293 ± 34%  sched_debug.cfs_rq:/.min_vruntime.min
     44715 ±  9%     -26.1%      33058 ± 26%  sched_debug.cfs_rq:/.min_vruntime.stddev
    211.40 ± 60%    +122.0%     469.33 ± 15%  sched_debug.cfs_rq:/.removed.load_avg.max
      9848 ± 60%    +121.4%      21804 ± 15%  sched_debug.cfs_rq:/.removed.runnable_sum.max
    101.17 ± 63%    +135.7%     238.46 ± 15%  sched_debug.cfs_rq:/.removed.util_avg.max
     16.56 ± 66%    +109.8%      34.74 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      9.01 ± 11%     -25.2%       6.75 ±  9%  sched_debug.cfs_rq:/.runnable_load_avg.avg
      9959 ± 15%     -27.2%       7246 ±  9%  sched_debug.cfs_rq:/.runnable_weight.avg
      7701 ± 14%     -20.4%       6130 ± 11%  sched_debug.cfs_rq:/.runnable_weight.min
    206600 ± 12%     -38.7%     126726 ± 44%  sched_debug.cfs_rq:/.spread0.max
     44588 ±  9%     -26.0%      33012 ± 26%  sched_debug.cfs_rq:/.spread0.stddev
    117594 ± 11%     -38.3%      72503 ± 17%  sched_debug.cpu.clock.avg
    117603 ± 11%     -38.3%      72514 ± 17%  sched_debug.cpu.clock.max
    117587 ± 11%     -38.4%      72490 ± 17%  sched_debug.cpu.clock.min
      4.58 ± 29%     +87.3%       8.58 ± 21%  sched_debug.cpu.clock.stddev
    117594 ± 11%     -38.3%      72503 ± 17%  sched_debug.cpu.clock_task.avg
    117603 ± 11%     -38.3%      72514 ± 17%  sched_debug.cpu.clock_task.max
    117587 ± 11%     -38.4%      72490 ± 17%  sched_debug.cpu.clock_task.min
      4.58 ± 29%     +87.3%       8.58 ± 21%  sched_debug.cpu.clock_task.stddev
      8.45 ±  4%     -19.0%       6.84 ± 10%  sched_debug.cpu.cpu_load[0].avg
      8.50 ±  4%     -18.5%       6.93 ±  9%  sched_debug.cpu.cpu_load[1].avg
      8.61 ±  6%     -17.5%       7.11 ±  8%  sched_debug.cpu.cpu_load[2].avg
     46.00 ± 44%     -52.5%      21.83 ±  8%  sched_debug.cpu.cpu_load[2].max
      8.71 ±  7%     -14.1%       7.48 ±  7%  sched_debug.cpu.cpu_load[3].avg
    636.96 ±  9%     -34.8%     415.44 ± 25%  sched_debug.cpu.curr->pid.stddev
      9061 ±  4%     -17.8%       7449 ±  9%  sched_debug.cpu.load.avg
      7701 ± 14%     -20.4%       6130 ± 11%  sched_debug.cpu.load.min
     88165 ± 14%     -50.9%      43299 ± 29%  sched_debug.cpu.nr_load_updates.avg
     94734 ± 13%     -47.3%      49931 ± 24%  sched_debug.cpu.nr_load_updates.max
     82786 ± 16%     -52.5%      39357 ± 33%  sched_debug.cpu.nr_load_updates.min
      0.22 ±  8%     +13.2%       0.25 ±  9%  sched_debug.cpu.nr_running.stddev
      2596 ± 12%     -26.1%       1919 ± 21%  sched_debug.cpu.nr_switches.avg
      0.01 ± 34%     +66.7%       0.01 ± 28%  sched_debug.cpu.nr_uninterruptible.avg
    117588 ± 11%     -38.4%      72490 ± 17%  sched_debug.cpu_clk
    113551 ± 11%     -39.7%      68449 ± 18%  sched_debug.ktime
    118269 ± 11%     -38.1%      73184 ± 17%  sched_debug.sched_clk
 9.024e+09            +7.9%   9.74e+09        perf-stat.i.branch-instructions
  19866561 ±  7%     +14.5%   22748472 ±  3%  perf-stat.i.branch-misses
     54.24           -10.3       43.91        perf-stat.i.cache-miss-rate%
 5.969e+08           -13.0%  5.193e+08        perf-stat.i.cache-misses
 8.353e+08            +5.1%  8.778e+08        perf-stat.i.cache-references
      1934           +45.9%       2822 ±  4%  perf-stat.i.context-switches
      3.58           -15.5%       3.02        perf-stat.i.cpi
 1.652e+11            -7.7%  1.524e+11        perf-stat.i.cpu-cycles
     65.64           +35.7%      89.04        perf-stat.i.cpu-migrations
      2.98            -0.5        2.50        perf-stat.i.dTLB-load-miss-rate%
 4.598e+08            -6.6%  4.293e+08        perf-stat.i.dTLB-load-misses
  1.13e+10            +8.0%   1.22e+10        perf-stat.i.dTLB-loads
 4.402e+09            +8.4%  4.774e+09        perf-stat.i.dTLB-stores
    207400 ± 15%     +44.9%     300452 ± 16%  perf-stat.i.iTLB-loads
 3.969e+10            +8.2%  4.296e+10        perf-stat.i.instructions
      0.33 ±  2%     +11.4%       0.37 ±  2%  perf-stat.i.ipc
    692836            +8.6%     752662        perf-stat.i.minor-faults
 5.794e+08           -14.0%  4.984e+08        perf-stat.i.node-loads
    692963            +8.6%     752688        perf-stat.i.page-faults
     21.03            -2.8%      20.43        perf-stat.overall.MPKI
     71.36           -12.2       59.15        perf-stat.overall.cache-miss-rate%
      4.16           -14.7%       3.55        perf-stat.overall.cpi
    277.07            +6.0%     293.58        perf-stat.overall.cycles-between-cache-misses
      3.90            -0.5        3.40        perf-stat.overall.dTLB-load-miss-rate%
     90.35            -3.2       87.17 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      0.24           +17.2%       0.28        perf-stat.overall.ipc
      0.69 ± 26%      +0.4        1.06 ±  6%  perf-stat.overall.node-load-miss-rate%
     12552            +1.1%      12694        perf-stat.overall.path-length
 8.991e+09            +8.0%  9.714e+09        perf-stat.ps.branch-instructions
  19970181 ±  7%     +13.7%   22702354 ±  3%  perf-stat.ps.branch-misses
 5.936e+08           -12.8%  5.177e+08        perf-stat.ps.cache-misses
 8.318e+08            +5.2%  8.753e+08        perf-stat.ps.cache-references
      1933           +45.4%       2811 ±  4%  perf-stat.ps.context-switches
 1.645e+11            -7.6%   1.52e+11        perf-stat.ps.cpu-cycles
     65.91           +35.2%      89.09        perf-stat.ps.cpu-migrations
 4.571e+08            -6.4%  4.279e+08        perf-stat.ps.dTLB-load-misses
 1.127e+10            +8.0%  1.217e+10        perf-stat.ps.dTLB-loads
 4.393e+09            +8.4%  4.763e+09        perf-stat.ps.dTLB-stores
    206653 ± 15%     +44.2%     297961 ± 16%  perf-stat.ps.iTLB-loads
 3.956e+10            +8.3%  4.285e+10        perf-stat.ps.instructions
    705038            +7.4%     757158        perf-stat.ps.minor-faults
  5.76e+08           -13.7%  4.968e+08        perf-stat.ps.node-loads
    705038            +7.4%     757158        perf-stat.ps.page-faults
  7.45e+12            +1.1%  7.535e+12        perf-stat.total.instructions



***************************************************************************************************
lkp-bdw-ep2: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2018-04-03.cgz/300s/16G/lkp-bdw-ep2/shm-xread-rand/vm-scalability

commit: 
  8055fb607e ("vfs: Convert smackfs to fs_context")
  9d65ac8a35 ("tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context")

8055fb607ebc82ea 9d65ac8a35a75c7334cfa0f8552 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
          1:4          -25%            :4     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
     58903           -20.3%      46946        vm-scalability.median
   5172452           -20.4%    4118440        vm-scalability.throughput
    345.95            -6.6%     323.08        vm-scalability.time.elapsed_time
    345.95            -6.6%     323.08        vm-scalability.time.elapsed_time.max
    111396            -2.5%     108605        vm-scalability.time.involuntary_context_switches
  65947596           -50.0%   32974445        vm-scalability.time.maximum_resident_set_size
 1.362e+08           -50.0%   68098904        vm-scalability.time.minor_page_faults
      8550            +1.3%       8658        vm-scalability.time.percent_of_cpu_this_job_got
      5087           -50.8%       2504        vm-scalability.time.system_time
     24495            +4.0%      25472        vm-scalability.time.user_time
 1.555e+09           -20.4%  1.238e+09        vm-scalability.workload
   3581144           -20.2%    2857829        pmeter.performance_per_watt
 5.284e+08 ± 28%     -68.8%   1.65e+08 ±100%  cpuidle.C3.time
   1327550 ± 17%     -62.5%     497618 ± 68%  cpuidle.C3.usage
      2.96 ±  3%      -1.2        1.71 ±  3%  mpstat.cpu.all.idle%
     16.71            -7.9        8.83        mpstat.cpu.all.sys%
     80.33            +9.1       89.46        mpstat.cpu.all.usr%
     79.25           +11.4%      88.25        vmstat.cpu.us
  64612119           -48.1%   33517986        vmstat.memory.cache
  55623598           +65.5%   92078368        vmstat.memory.free
   9977135           -48.5%    5142019 ±  4%  numa-numastat.node0.local_node
   9982886           -48.3%    5157733 ±  4%  numa-numastat.node0.numa_hit
  10111629           -48.2%    5237252 ±  4%  numa-numastat.node1.local_node
  10123206           -48.2%    5238834 ±  4%  numa-numastat.node1.numa_hit
     59844 ±  6%     +22.5%      73308 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
     59581 ±  6%     +22.5%      72962 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
      1101 ±  8%     +19.1%       1312 ±  9%  sched_debug.cpu.nr_load_updates.stddev
      3.75 ± 15%     -20.2%       2.99 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
     21350 ±  4%      -8.9%      19448 ±  4%  slabinfo.filp.active_objs
     21407 ±  4%      -8.8%      19515 ±  4%  slabinfo.filp.num_objs
    272341           -46.7%     145219        slabinfo.radix_tree_node.active_objs
      4924           -47.0%       2609        slabinfo.radix_tree_node.active_slabs
    275782           -47.0%     146146        slabinfo.radix_tree_node.num_objs
      4924           -47.0%       2609        slabinfo.radix_tree_node.num_slabs
      2709            +1.2%       2741        turbostat.Avg_MHz
   1327367 ± 17%     -62.5%     497393 ± 68%  turbostat.C3
      1.73 ± 28%      -1.2        0.57 ±101%  turbostat.C3%
      1.33 ± 11%     -43.2%       0.76 ± 19%  turbostat.CPU%c1
      1.06 ± 40%     -76.8%       0.24 ±131%  turbostat.CPU%c3
      0.84 ±  6%     -36.3%       0.53 ± 11%  turbostat.Pkg%pc2
     26.27            +3.1%      27.10        turbostat.RAMWatt
      1.72 ±  8%      -0.4        1.29 ± 18%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.generic_start_main.__strcspn_sse42
      1.29 ±  8%      -0.3        0.96 ± 21%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.run_builtin.main.generic_start_main
      1.11 ±  9%      -0.2        0.86 ± 21%  perf-profile.calltrace.cycles-pp.__libc_write.record__pushfn.perf_mmap__push.record__mmap_read_evlist.cmd_record
      0.00            +0.6        0.61 ± 11%  perf-profile.calltrace.cycles-pp.intel_pmu_disable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      1.31 ± 64%      +1.3        2.62 ± 34%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.printk.irq_work_run_list.irq_work_run
      1.31 ± 64%      +1.5        2.84 ± 28%  perf-profile.calltrace.cycles-pp.printk.irq_work_run_list.irq_work_run.smp_irq_work_interrupt.irq_work_interrupt
      1.31 ± 64%      +1.5        2.84 ± 28%  perf-profile.calltrace.cycles-pp.vprintk_emit.printk.irq_work_run_list.irq_work_run.smp_irq_work_interrupt
      0.57 ±112%      +1.8        2.37 ± 33%  perf-profile.calltrace.cycles-pp.irq_work_interrupt
      0.57 ±112%      +1.8        2.37 ± 33%  perf-profile.calltrace.cycles-pp.smp_irq_work_interrupt.irq_work_interrupt
      0.56 ±111%      +1.8        2.37 ± 33%  perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.smp_irq_work_interrupt.irq_work_interrupt
      0.56 ±111%      +1.8        2.37 ± 33%  perf-profile.calltrace.cycles-pp.irq_work_run.smp_irq_work_interrupt.irq_work_interrupt
   4619861           -69.2%    1421166        meminfo.Active
   4619538           -69.2%    1420846        meminfo.Active(anon)
  64499750           -48.1%   33455359        meminfo.Cached
  64314136           -49.3%   32618183        meminfo.Committed_AS
   7686210 ±  5%     -13.6%    6642659 ±  7%  meminfo.DirectMap2M
  58895884           -47.3%   31056924        meminfo.Inactive
  58894602           -47.3%   31055638        meminfo.Inactive(anon)
    222659           -33.3%     148512        meminfo.KReclaimable
  58840690           -47.3%   31002708        meminfo.Mapped
  54984886           +66.3%   91436602        meminfo.MemAvailable
  55491527           +65.8%   91980428        meminfo.MemFree
  76401003           -47.8%   39912102        meminfo.Memused
  10891829           -49.2%    5531713        meminfo.PageTables
    222659           -33.3%     148512        meminfo.SReclaimable
  63270909           -49.1%   32234167        meminfo.Shmem
    352176           -21.2%     277620        meminfo.Slab
    237668           -44.8%     131115        meminfo.max_used_kB
   1151943           -69.3%     353978        proc-vmstat.nr_active_anon
   1370541           +66.5%    2281328        proc-vmstat.nr_dirty_background_threshold
   2744434           +66.5%    4568236        proc-vmstat.nr_dirty_threshold
  16120020           -48.1%    8358289        proc-vmstat.nr_file_pages
  13879822           +65.7%   23001086        proc-vmstat.nr_free_pages
  14721414           -47.3%    7759335        proc-vmstat.nr_inactive_anon
  14708048           -47.3%    7746354        proc-vmstat.nr_mapped
   2720928           -49.2%    1382900        proc-vmstat.nr_page_table_pages
  15812549           -49.1%    8052730        proc-vmstat.nr_shmem
     55636           -33.3%      37097        proc-vmstat.nr_slab_reclaimable
   1151943           -69.3%     353978        proc-vmstat.nr_zone_active_anon
  14721414           -47.3%    7759335        proc-vmstat.nr_zone_inactive_anon
  20133051           -48.2%   10423588        proc-vmstat.numa_hit
  20115718           -48.3%   10406285        proc-vmstat.numa_local
  16498700           -50.0%    8255732        proc-vmstat.pgactivate
  20224085           -48.1%   10500895        proc-vmstat.pgalloc_normal
 1.371e+08           -49.7%   68932918        proc-vmstat.pgfault
  20127362           -48.1%   10441339        proc-vmstat.pgfree
    138366 ±  2%     -11.0%     123211 ±  5%  softirqs.CPU0.TIMER
    149690 ± 12%     -18.8%     121621 ±  6%  softirqs.CPU1.TIMER
    137396 ±  2%     -11.0%     122245 ±  7%  softirqs.CPU3.TIMER
     39705 ±  4%      -7.8%      36624        softirqs.CPU34.RCU
    145711 ±  7%     -15.4%     123281 ±  5%  softirqs.CPU4.TIMER
    149597 ±  6%     -16.0%     125654 ±  8%  softirqs.CPU45.TIMER
    140697 ±  3%     -12.1%     123678 ±  5%  softirqs.CPU46.TIMER
    139246 ±  3%     -12.0%     122571 ±  7%  softirqs.CPU47.TIMER
    148109 ± 11%     -17.4%     122387 ±  5%  softirqs.CPU48.TIMER
    144373 ±  3%     -13.8%     124384 ±  6%  softirqs.CPU50.TIMER
    142611 ±  3%     -12.9%     124165 ±  7%  softirqs.CPU51.TIMER
     35209 ±  5%      +7.6%      37869 ±  3%  softirqs.CPU53.RCU
    135035 ±  2%     -11.5%     119518 ±  5%  softirqs.CPU55.TIMER
    143106 ±  3%     -13.5%     123842 ±  6%  softirqs.CPU6.TIMER
    140285 ±  4%     -12.8%     122376 ±  6%  softirqs.CPU60.TIMER
    138943 ±  4%     -13.0%     120840 ±  6%  softirqs.CPU62.TIMER
     32370 ±  6%      -9.9%      29180 ±  3%  softirqs.CPU63.RCU
     36484 ±  7%     -11.2%      32394 ±  3%  softirqs.CPU64.RCU
    140860 ±  2%     -12.5%     123309 ±  7%  softirqs.CPU7.TIMER
    336771           -15.4%     284753 ±  2%  softirqs.SCHED
  12108815            -8.2%   11115408 ±  4%  softirqs.TIMER
    452.50 ± 73%     -62.2%     171.25 ±  3%  interrupts.37:IR-PCI-MSI.1572867-edge.eth0-TxRx-3
    486.50 ±106%     -64.0%     175.25        interrupts.48:IR-PCI-MSI.1572878-edge.eth0-TxRx-14
    174.75 ±  2%      -9.2%     158.75        interrupts.79:IR-PCI-MSI.1572907-edge.eth0-TxRx-43
    332281 ±  8%     -10.6%     296936        interrupts.CAL:Function_call_interrupts
    486.50 ±106%     -64.0%     175.25        interrupts.CPU14.48:IR-PCI-MSI.1572878-edge.eth0-TxRx-14
    300.50 ± 58%    +322.0%       1268 ± 45%  interrupts.CPU14.RES:Rescheduling_interrupts
    256.75 ± 52%    +251.6%     902.75 ± 66%  interrupts.CPU16.RES:Rescheduling_interrupts
    589.50 ± 56%     -83.0%     100.25 ± 50%  interrupts.CPU22.RES:Rescheduling_interrupts
      1365 ± 70%     -87.9%     165.00 ± 84%  interrupts.CPU26.RES:Rescheduling_interrupts
    452.50 ± 73%     -62.2%     171.25 ±  3%  interrupts.CPU3.37:IR-PCI-MSI.1572867-edge.eth0-TxRx-3
      3862 ±  7%     -12.1%       3394        interrupts.CPU30.CAL:Function_call_interrupts
    866.75 ± 75%     -70.1%     258.75 ± 40%  interrupts.CPU30.RES:Rescheduling_interrupts
    598.75 ± 12%     -59.1%     244.75 ± 41%  interrupts.CPU32.RES:Rescheduling_interrupts
    596.00 ± 40%     -65.3%     206.75 ± 33%  interrupts.CPU36.RES:Rescheduling_interrupts
      3847 ±  8%     -11.2%       3418        interrupts.CPU38.CAL:Function_call_interrupts
    956.00 ± 60%     -74.3%     245.50 ± 58%  interrupts.CPU38.RES:Rescheduling_interrupts
    822.75 ± 66%     -68.4%     260.25 ± 83%  interrupts.CPU39.RES:Rescheduling_interrupts
    751.00 ± 49%     -64.8%     264.50 ± 61%  interrupts.CPU40.RES:Rescheduling_interrupts
      3844 ±  8%     -12.5%       3362        interrupts.CPU41.CAL:Function_call_interrupts
    174.75 ±  2%      -9.2%     158.75        interrupts.CPU43.79:IR-PCI-MSI.1572907-edge.eth0-TxRx-43
      4278 ±  3%     -11.8%       3774 ±  3%  interrupts.CPU43.RES:Rescheduling_interrupts
      3865 ±  7%     -11.1%       3437        interrupts.CPU74.CAL:Function_call_interrupts
    252.50 ±147%     -96.9%       7.75 ± 29%  interrupts.CPU85.RES:Rescheduling_interrupts
    139.50 ± 19%     -59.1%      57.00 ±  3%  interrupts.TLB:TLB_shootdowns
   2363099           -71.2%     680111 ±  4%  numa-meminfo.node0.Active
   2362909           -71.2%     679995 ±  4%  numa-meminfo.node0.Active(anon)
    111665 ± 13%     -34.0%      73698 ± 38%  numa-meminfo.node0.AnonHugePages
    148248 ± 15%     -29.2%     105012 ± 31%  numa-meminfo.node0.AnonPages
  32253198           -49.0%   16433879 ±  2%  numa-meminfo.node0.FilePages
  29422844           -48.1%   15256374 ±  2%  numa-meminfo.node0.Inactive
  29422610           -48.2%   15255530 ±  2%  numa-meminfo.node0.Inactive(anon)
    116308 ± 24%     -50.9%      57155 ± 37%  numa-meminfo.node0.KReclaimable
  29376475           -48.1%   15241543 ±  2%  numa-meminfo.node0.Mapped
  27577954           +68.8%   46544763        numa-meminfo.node0.MemFree
  38269612           -49.5%   19322519 ±  4%  numa-meminfo.node0.MemUsed
   5406782 ±  5%     -55.3%    2416882 ± 14%  numa-meminfo.node0.PageTables
    116308 ± 24%     -50.9%      57155 ± 37%  numa-meminfo.node0.SReclaimable
  31637547           -50.0%   15830617 ±  2%  numa-meminfo.node0.Shmem
    188033 ± 14%     -32.4%     127088 ± 18%  numa-meminfo.node0.Slab
   2312677           -67.3%     755238 ±  3%  numa-meminfo.node1.Active
   2312544           -67.4%     755034 ±  3%  numa-meminfo.node1.Active(anon)
  32263670           -47.2%   17036666 ±  2%  numa-meminfo.node1.FilePages
  29433165           -46.3%   15800516 ±  2%  numa-meminfo.node1.Inactive
  29432116           -46.3%   15800075 ±  2%  numa-meminfo.node1.Inactive(anon)
  29424249           -46.4%   15760881 ±  2%  numa-meminfo.node1.Mapped
  27898977           +62.8%   45416266        numa-meminfo.node1.MemFree
  38145985           -46.0%   20608980 ±  3%  numa-meminfo.node1.MemUsed
   5485105 ±  5%     -43.1%    3119610 ± 11%  numa-meminfo.node1.PageTables
  31649432           -48.1%   16417690 ±  2%  numa-meminfo.node1.Shmem
    588255           -71.2%     169477 ±  4%  numa-vmstat.node0.nr_active_anon
     37057 ± 15%     -29.2%      26250 ± 31%  numa-vmstat.node0.nr_anon_pages
   8055464           -49.0%    4105442 ±  2%  numa-vmstat.node0.nr_file_pages
   6904034           +68.6%   11639744        numa-vmstat.node0.nr_free_pages
   7350295           -48.1%    3811386 ±  2%  numa-vmstat.node0.nr_inactive_anon
   7338831           -48.1%    3808003 ±  2%  numa-vmstat.node0.nr_mapped
   1349770 ±  5%     -55.3%     603819 ± 14%  numa-vmstat.node0.nr_page_table_pages
   7901552           -50.0%    3954627 ±  2%  numa-vmstat.node0.nr_shmem
     29044 ± 24%     -50.8%      14282 ± 37%  numa-vmstat.node0.nr_slab_reclaimable
    588255           -71.2%     169477 ±  4%  numa-vmstat.node0.nr_zone_active_anon
   7350295           -48.1%    3811386 ±  2%  numa-vmstat.node0.nr_zone_inactive_anon
  10146868           -47.4%    5340924 ±  3%  numa-vmstat.node0.numa_hit
  10140885           -47.5%    5324695 ±  3%  numa-vmstat.node0.numa_local
    575687           -67.3%     188231 ±  3%  numa-vmstat.node1.nr_active_anon
   8058042           -47.2%    4256182 ±  2%  numa-vmstat.node1.nr_file_pages
   6984514           +62.6%   11357293        numa-vmstat.node1.nr_free_pages
   7352606           -46.3%    3947550 ±  2%  numa-vmstat.node1.nr_inactive_anon
   7350701           -46.4%    3937932 ±  2%  numa-vmstat.node1.nr_mapped
   1369252 ±  5%     -43.1%     779777 ± 11%  numa-vmstat.node1.nr_page_table_pages
   7904483           -48.1%    4101439 ±  2%  numa-vmstat.node1.nr_shmem
    575687           -67.3%     188232 ±  3%  numa-vmstat.node1.nr_zone_active_anon
   7352606           -46.3%    3947550 ±  2%  numa-vmstat.node1.nr_zone_inactive_anon
  10040888           -45.5%    5472600 ±  3%  numa-vmstat.node1.numa_hit
   9853575           -46.3%    5296236 ±  3%  numa-vmstat.node1.numa_local
    187312 ±  3%      -5.8%     176363        numa-vmstat.node1.numa_other
     27.34            +3.1%      28.20        perf-stat.i.MPKI
 8.864e+09            -2.8%   8.62e+09        perf-stat.i.branch-instructions
      0.14 ± 11%      -0.0        0.10 ±  5%  perf-stat.i.branch-miss-rate%
  10769953           -28.8%    7671610 ±  2%  perf-stat.i.branch-misses
     63.11            +4.6       67.74        perf-stat.i.cache-miss-rate%
 6.599e+08            +7.4%   7.09e+08        perf-stat.i.cache-misses
 9.689e+08            +3.7%  1.005e+09        perf-stat.i.cache-references
      6.40            +3.1%       6.60        perf-stat.i.cpi
 2.378e+11            +1.3%  2.408e+11        perf-stat.i.cpu-cycles
     50.96 ±  9%     +18.2%      60.24 ±  4%  perf-stat.i.cpu-migrations
    661.83           -24.2%     501.47        perf-stat.i.cycles-between-cache-misses
      4.41            +0.5        4.87        perf-stat.i.dTLB-load-miss-rate%
  4.72e+08           +11.5%  5.265e+08        perf-stat.i.dTLB-load-misses
 3.311e+09            +4.5%   3.46e+09        perf-stat.i.dTLB-stores
   1137454 ± 40%     -52.2%     543479 ± 20%  perf-stat.i.iTLB-load-misses
     29208 ± 20%     -27.1%      21301 ±  7%  perf-stat.i.iTLB-loads
 3.802e+10            -2.6%  3.701e+10        perf-stat.i.instructions
      0.17            -5.5%       0.16        perf-stat.i.ipc
    394369           -46.2%     212356        perf-stat.i.minor-faults
 1.777e+08           +16.3%  2.067e+08 ±  5%  perf-stat.i.node-load-misses
   2262667           -45.2%    1240313        perf-stat.i.node-store-misses
   1570312           -43.7%     883357        perf-stat.i.node-stores
    394373           -46.2%     212361        perf-stat.i.page-faults
     25.41            +6.7%      27.11        perf-stat.overall.MPKI
      0.12            -0.0        0.09 ±  3%  perf-stat.overall.branch-miss-rate%
     68.09            +2.4       70.53        perf-stat.overall.cache-miss-rate%
      6.25            +4.1%       6.50        perf-stat.overall.cpi
    361.17            -5.8%     340.10        perf-stat.overall.cycles-between-cache-misses
      4.20            +0.5        4.74        perf-stat.overall.dTLB-load-miss-rate%
     97.33            -1.2       96.11        perf-stat.overall.iTLB-load-miss-rate%
     37498 ± 27%     +86.9%      70100 ± 15%  perf-stat.overall.instructions-per-iTLB-miss
      0.16            -3.9%       0.15        perf-stat.overall.ipc
      8461           +14.1%       9653        perf-stat.overall.path-length
 8.848e+09            -2.8%  8.599e+09        perf-stat.ps.branch-instructions
  10826438           -28.7%    7715583 ±  2%  perf-stat.ps.branch-misses
 6.566e+08            +7.5%  7.059e+08        perf-stat.ps.cache-misses
 9.644e+08            +3.8%  1.001e+09        perf-stat.ps.cache-references
 2.371e+11            +1.2%    2.4e+11        perf-stat.ps.cpu-cycles
     50.79 ±  9%     +18.2%      60.04 ±  4%  perf-stat.ps.cpu-migrations
 4.695e+08           +11.6%  5.242e+08        perf-stat.ps.dTLB-load-misses
 3.297e+09            +4.5%  3.447e+09        perf-stat.ps.dTLB-stores
   1138634 ± 40%     -52.2%     544577 ± 20%  perf-stat.ps.iTLB-load-misses
     29201 ± 20%     -27.0%      21308 ±  7%  perf-stat.ps.iTLB-loads
 3.795e+10            -2.7%  3.692e+10        perf-stat.ps.instructions
    395278           -46.1%     212887        perf-stat.ps.minor-faults
 1.768e+08           +16.4%  2.058e+08 ±  5%  perf-stat.ps.node-load-misses
   2273468           -45.1%    1248526        perf-stat.ps.node-store-misses
   1578735           -43.7%     888814        perf-stat.ps.node-stores
    395278           -46.1%     212887        perf-stat.ps.page-faults
 1.316e+13            -9.2%  1.195e+13        perf-stat.total.instructions



***************************************************************************************************
lkp-bdw-ep2: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2018-04-03.cgz/300s/2T/lkp-bdw-ep2/shm-xread-seq-mt/vm-scalability

commit: 
  8055fb607e ("vfs: Convert smackfs to fs_context")
  9d65ac8a35 ("tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context")

8055fb607ebc82ea 9d65ac8a35a75c7334cfa0f8552 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    196632            -3.4%     190033        vm-scalability.median
  17303638            -3.4%   16722968        vm-scalability.throughput
    305.58           -35.0%     198.68        vm-scalability.time.elapsed_time
    305.58           -35.0%     198.68        vm-scalability.time.elapsed_time.max
     51178 ±  3%     -35.2%      33182 ±  2%  vm-scalability.time.involuntary_context_switches
  50826393           -35.1%   32976181        vm-scalability.time.maximum_resident_set_size
 1.918e+08           -35.1%  1.245e+08        vm-scalability.time.minor_page_faults
      4352           -35.0%       2830        vm-scalability.time.system_time
      2028           -35.1%       1317        vm-scalability.time.user_time
 2.055e+08           -35.2%  1.332e+08        vm-scalability.time.voluntary_context_switches
 5.198e+09           -37.2%  3.264e+09        vm-scalability.workload
     26.86 ± 13%     -14.1%      23.07        boot-time.dhcp
  14360030           -37.1%    9036532        pmeter.performance_per_watt
  26669923           -33.6%   17698248        vmstat.memory.cache
      5.28            +0.5%       5.31        perf-stat.overall.MPKI
      3897            +3.4%       4029        perf-stat.overall.path-length
 2.026e+13           -35.1%  1.315e+13        perf-stat.total.instructions
  11133423           -35.0%    7236823        numa-numastat.node0.local_node
  11140682           -35.0%    7241254        numa-numastat.node0.numa_hit
  11164060           -35.1%    7246687        numa-numastat.node1.local_node
  11174175           -35.0%    7259603        numa-numastat.node1.numa_hit
  1.37e+08           -36.3%   87306795 ±  2%  turbostat.C1
  98317400 ±  2%     -33.7%   65227313 ±  3%  turbostat.C1E
   3598865 ±  4%     -30.4%    2503778 ± 13%  turbostat.C3
    624349 ± 18%     -52.6%     296068 ± 42%  turbostat.C6
  57984931           -34.5%   37968501        turbostat.IRQ
    618.75 ±  4%     +28.1%     792.75 ± 11%  slabinfo.file_lock_cache.active_objs
    618.75 ±  4%     +28.1%     792.75 ± 11%  slabinfo.file_lock_cache.num_objs
    116482           -30.4%      81085        slabinfo.radix_tree_node.active_objs
      2081           -30.4%       1448        slabinfo.radix_tree_node.active_slabs
    116572           -30.4%      81165        slabinfo.radix_tree_node.num_objs
      2081           -30.4%       1448        slabinfo.radix_tree_node.num_slabs
 1.043e+10 ±  2%     -34.1%  6.874e+09        cpuidle.C1.time
  1.37e+08           -36.3%   87314564 ±  2%  cpuidle.C1.usage
 8.491e+09 ±  3%     -36.1%  5.423e+09        cpuidle.C1E.time
  98317790 ±  2%     -33.7%   65227663 ±  3%  cpuidle.C1E.usage
   3599022 ±  4%     -30.4%    2504208 ± 13%  cpuidle.C3.usage
  4.81e+08 ± 22%     -51.2%  2.345e+08 ± 47%  cpuidle.C6.time
    639440 ± 18%     -52.1%     306262 ± 40%  cpuidle.C6.usage
 1.554e+08           -35.0%  1.011e+08        cpuidle.POLL.time
  41971317 ±  2%     -35.1%   27250494 ±  2%  cpuidle.POLL.usage
    171264           -11.7%     151295        meminfo.AnonHugePages
  26614721           -33.6%   17675359        meminfo.Cached
  26464318           -33.9%   17494063        meminfo.Committed_AS
  25363226           -35.2%   16441470        meminfo.Inactive
  25361926           -35.2%   16440177        meminfo.Inactive(anon)
    130801           -16.1%     109804        meminfo.KReclaimable
  24900911           -35.2%   16124722        meminfo.Mapped
  27556910           -32.5%   18604729        meminfo.Memused
     53313           -32.3%      36085        meminfo.PageTables
    130801           -16.1%     109804        meminfo.SReclaimable
  25386096           -35.2%   16454135        meminfo.Shmem
  13374369           -33.6%    8875998        numa-meminfo.node0.FilePages
  12746980           -35.2%    8253690        numa-meminfo.node0.Inactive
  12746045           -35.3%    8252964        numa-meminfo.node0.Inactive(anon)
  12511393           -35.3%    8091983        numa-meminfo.node0.Mapped
  13923310           -32.2%    9433317        numa-meminfo.node0.MemUsed
     26875 ±  4%     -30.5%      18681 ±  5%  numa-meminfo.node0.PageTables
  12758310           -35.2%    8262068        numa-meminfo.node0.Shmem
  13267153           -33.7%    8791711        numa-meminfo.node1.FilePages
  12642015           -35.3%    8179158        numa-meminfo.node1.Inactive
  12641650           -35.3%    8178592        numa-meminfo.node1.Inactive(anon)
     59135 ± 10%     -19.1%      47862 ±  9%  numa-meminfo.node1.KReclaimable
  12416665           -35.3%    8029295        numa-meminfo.node1.Mapped
  13659837           -32.9%    9163031        numa-meminfo.node1.MemUsed
     26452 ±  4%     -34.2%      17416 ±  6%  numa-meminfo.node1.PageTables
     59135 ± 10%     -19.1%      47862 ±  9%  numa-meminfo.node1.SReclaimable
  12653543           -35.3%    8183377        numa-meminfo.node1.Shmem
   3342451           -33.6%    2220433        numa-vmstat.node0.nr_file_pages
   3185349           -35.2%    2064637        numa-vmstat.node0.nr_inactive_anon
   3127155           -35.3%    2022977        numa-vmstat.node0.nr_mapped
      6720 ±  4%     -30.4%       4674 ±  5%  numa-vmstat.node0.nr_page_table_pages
   3188436           -35.2%    2066951        numa-vmstat.node0.nr_shmem
   3185348           -35.2%    2064635        numa-vmstat.node0.nr_zone_inactive_anon
   6174756           -31.8%    4213820        numa-vmstat.node0.numa_hit
   6167259           -31.7%    4209178        numa-vmstat.node0.numa_local
   3315635           -33.7%    2199341        numa-vmstat.node1.nr_file_pages
   3159256           -35.2%    2046053        numa-vmstat.node1.nr_inactive_anon
   3103543           -35.3%    2007364        numa-vmstat.node1.nr_mapped
      6615 ±  4%     -34.1%       4359 ±  6%  numa-vmstat.node1.nr_page_table_pages
   3162233           -35.3%    2047258        numa-vmstat.node1.nr_shmem
     14782 ± 10%     -19.1%      11965 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
   3159256           -35.2%    2046052        numa-vmstat.node1.nr_zone_inactive_anon
   6053005           -33.3%    4037539        numa-vmstat.node1.numa_hit
   5867194           -34.4%    3849828        numa-vmstat.node1.numa_local
     65705            -4.1%      63028        proc-vmstat.nr_active_anon
   2588819            +8.7%    2813043        proc-vmstat.nr_dirty_background_threshold
   5183970            +8.7%    5632966        proc-vmstat.nr_dirty_threshold
   6657180           -33.7%    4414871        proc-vmstat.nr_file_pages
  26080478            +8.6%   28326011        proc-vmstat.nr_free_pages
   6343697           -35.3%    4105826        proc-vmstat.nr_inactive_anon
   6229857           -35.3%    4029578        proc-vmstat.nr_mapped
     13336           -32.3%       9026        proc-vmstat.nr_page_table_pages
   6349763           -35.3%    4109305        proc-vmstat.nr_shmem
     32703           -16.1%      27439        proc-vmstat.nr_slab_reclaimable
     65705            -4.1%      63028        proc-vmstat.nr_zone_active_anon
   6343697           -35.3%    4105826        proc-vmstat.nr_zone_inactive_anon
    106482 ±  5%     -36.3%      67843 ±  4%  proc-vmstat.numa_hint_faults
     77337 ±  6%     -36.2%      49325 ±  5%  proc-vmstat.numa_hint_faults_local
  22342557           -35.0%   14525355        proc-vmstat.numa_hit
  22325169           -35.0%   14508002        proc-vmstat.numa_local
  22424699           -34.9%   14601937        proc-vmstat.pgalloc_normal
 1.926e+08           -35.1%   1.25e+08        proc-vmstat.pgfault
  21941855 ±  3%     -34.9%   14276115 ±  2%  proc-vmstat.pgfree
     10484 ± 11%     -26.3%       7724 ±  9%  sched_debug.cfs_rq:/.load.avg
     87787 ± 84%     -52.8%      41420 ±  3%  sched_debug.cfs_rq:/.load.max
     21156 ± 32%     -29.4%      14934 ±  4%  sched_debug.cfs_rq:/.load.stddev
    829431           -39.3%     503257        sched_debug.cfs_rq:/.min_vruntime.avg
    885846           -37.4%     554313        sched_debug.cfs_rq:/.min_vruntime.max
    812888           -39.6%     490860        sched_debug.cfs_rq:/.min_vruntime.min
      0.24 ±  9%     -20.8%       0.19 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
     10403 ± 11%     -25.5%       7752 ±  9%  sched_debug.cfs_rq:/.runnable_weight.avg
     86935 ± 85%     -55.1%      39045        sched_debug.cfs_rq:/.runnable_weight.max
     21021 ± 32%     -29.3%      14857 ±  3%  sched_debug.cfs_rq:/.runnable_weight.stddev
    101.34           +17.4%     118.95 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     56.89 ±  7%     -24.1%      43.20 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    109.31 ±  4%     -12.6%      95.54        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    195835           +24.1%     242941        sched_debug.cpu.avg_idle.avg
    347207 ±  4%     +40.1%     486352 ± 12%  sched_debug.cpu.avg_idle.max
     24654 ±  7%     +25.9%      31044 ±  3%  sched_debug.cpu.avg_idle.min
     62728 ±  2%     +35.0%      84672 ±  5%  sched_debug.cpu.avg_idle.stddev
    188539           -33.7%     125063        sched_debug.cpu.clock.avg
    188544           -33.7%     125068        sched_debug.cpu.clock.max
    188535           -33.7%     125059        sched_debug.cpu.clock.min
    188539           -33.7%     125063        sched_debug.cpu.clock_task.avg
    188544           -33.7%     125068        sched_debug.cpu.clock_task.max
    188535           -33.7%     125059        sched_debug.cpu.clock_task.min
      1.48 ± 10%     +23.5%       1.83 ±  4%  sched_debug.cpu.cpu_load[4].avg
     46.33 ± 23%     +51.5%      70.19 ± 14%  sched_debug.cpu.cpu_load[4].max
      5.42 ± 16%     +43.6%       7.78 ± 12%  sched_debug.cpu.cpu_load[4].stddev
      5561 ±  3%     -24.8%       4179        sched_debug.cpu.curr->pid.max
      1024 ±  5%     -17.9%     841.52 ±  2%  sched_debug.cpu.curr->pid.stddev
     11106 ±  7%     -24.9%       8336 ±  5%  sched_debug.cpu.load.avg
    129322 ±110%     -67.5%      41984        sched_debug.cpu.load.max
     24962 ± 51%     -38.6%      15338 ±  2%  sched_debug.cpu.load.stddev
    156214           -38.7%      95691        sched_debug.cpu.nr_load_updates.avg
    163995           -38.0%     101745        sched_debug.cpu.nr_load_updates.max
    154518           -39.0%      94297        sched_debug.cpu.nr_load_updates.min
      0.42 ±  3%      -7.1%       0.39 ±  2%  sched_debug.cpu.nr_running.stddev
   2318901           -40.3%    1383764        sched_debug.cpu.nr_switches.avg
   2333427           -40.2%    1395703        sched_debug.cpu.nr_switches.max
   2271583           -40.8%    1344471        sched_debug.cpu.nr_switches.min
      9275 ± 10%     -25.3%       6932 ±  3%  sched_debug.cpu.nr_switches.stddev
    797.75 ± 20%     -47.2%     421.50 ± 27%  sched_debug.cpu.nr_uninterruptible.max
    -83.38           -40.5%     -49.62        sched_debug.cpu.nr_uninterruptible.min
    103.08 ± 19%     -46.9%      54.75 ± 26%  sched_debug.cpu.nr_uninterruptible.stddev
    188535           -33.7%     125059        sched_debug.cpu_clk
    184490           -34.4%     121011        sched_debug.ktime
    189336           -33.6%     125753        sched_debug.sched_clk
     23387 ± 11%     -46.4%      12529 ±  8%  softirqs.CPU0.RCU
     53140 ±  2%     -32.1%      36067 ±  3%  softirqs.CPU0.SCHED
    105272           -33.0%      70585        softirqs.CPU0.TIMER
     23286 ±  6%     -43.3%      13211 ±  4%  softirqs.CPU1.RCU
     49935           -34.1%      32901        softirqs.CPU1.SCHED
     22010 ±  5%     -40.8%      13029 ±  8%  softirqs.CPU10.RCU
     48822           -34.2%      32141        softirqs.CPU10.SCHED
     90827           -33.3%      60569        softirqs.CPU10.TIMER
     21040 ±  3%     -38.2%      13007 ±  5%  softirqs.CPU11.RCU
     48693           -34.0%      32144        softirqs.CPU11.SCHED
     91941           -33.8%      60905        softirqs.CPU11.TIMER
     21612 ±  2%     -37.5%      13506 ± 11%  softirqs.CPU12.RCU
     48797           -34.0%      32190        softirqs.CPU12.SCHED
     91069           -33.2%      60853        softirqs.CPU12.TIMER
     21786 ±  4%     -39.5%      13186 ±  5%  softirqs.CPU13.RCU
     48857           -34.1%      32216        softirqs.CPU13.SCHED
     90779           -32.7%      61120        softirqs.CPU13.TIMER
     22220 ±  7%     -39.3%      13479 ±  7%  softirqs.CPU14.RCU
     49143           -34.2%      32358        softirqs.CPU14.SCHED
     91204           -33.5%      60616        softirqs.CPU14.TIMER
     23692 ±  5%     -38.4%      14592 ±  5%  softirqs.CPU15.RCU
     49566           -34.3%      32549        softirqs.CPU15.SCHED
     91630           -33.3%      61144        softirqs.CPU15.TIMER
     24311 ±  8%     -40.2%      14529 ±  8%  softirqs.CPU16.RCU
     49337           -34.3%      32437        softirqs.CPU16.SCHED
     91471           -33.5%      60868        softirqs.CPU16.TIMER
     23302 ±  4%     -40.3%      13901 ±  8%  softirqs.CPU17.RCU
     49014           -34.6%      32038        softirqs.CPU17.SCHED
     90966           -33.9%      60098        softirqs.CPU17.TIMER
     21200 ± 14%     -36.2%      13518 ±  9%  softirqs.CPU18.RCU
     49057           -34.5%      32148        softirqs.CPU18.SCHED
     90381           -32.8%      60699        softirqs.CPU18.TIMER
     24113 ±  4%     -41.4%      14141 ±  7%  softirqs.CPU19.RCU
     48660           -34.3%      31980        softirqs.CPU19.SCHED
     91470 ±  2%     -34.1%      60247        softirqs.CPU19.TIMER
     23240 ± 10%     -37.5%      14527 ± 13%  softirqs.CPU2.RCU
     49136           -34.5%      32178        softirqs.CPU2.SCHED
     93879 ±  5%     -35.5%      60529        softirqs.CPU2.TIMER
     23082 ±  6%     -39.3%      14017 ±  7%  softirqs.CPU20.RCU
     49277           -34.1%      32471        softirqs.CPU20.SCHED
     90735           -33.2%      60574        softirqs.CPU20.TIMER
     23969 ±  3%     -44.7%      13245 ± 19%  softirqs.CPU21.RCU
     49551           -34.4%      32527        softirqs.CPU21.SCHED
     91464           -33.4%      60882 ±  2%  softirqs.CPU21.TIMER
     23511 ±  2%     -35.2%      15246 ± 10%  softirqs.CPU22.RCU
     49923           -34.1%      32886        softirqs.CPU22.SCHED
     94860 ±  2%     -30.4%      66066 ±  3%  softirqs.CPU22.TIMER
     23929 ±  6%     -36.2%      15266 ±  8%  softirqs.CPU23.RCU
     49349           -34.4%      32378        softirqs.CPU23.SCHED
     90384           -33.4%      60213        softirqs.CPU23.TIMER
     23887           -41.6%      13950 ± 10%  softirqs.CPU24.RCU
     49063           -34.1%      32350        softirqs.CPU24.SCHED
     90207           -33.1%      60367        softirqs.CPU24.TIMER
     22154 ±  5%     -34.6%      14489 ± 10%  softirqs.CPU25.RCU
     48884           -34.6%      31954        softirqs.CPU25.SCHED
     90168           -33.6%      59883        softirqs.CPU25.TIMER
     23604 ±  5%     -40.7%      13995 ± 11%  softirqs.CPU26.RCU
     48998           -34.3%      32190        softirqs.CPU26.SCHED
     90213           -33.6%      59892        softirqs.CPU26.TIMER
     23856 ±  6%     -41.1%      14051 ± 11%  softirqs.CPU27.RCU
     49515 ±  2%     -35.2%      32087        softirqs.CPU27.SCHED
    107476 ± 27%     -43.9%      60265        softirqs.CPU27.TIMER
     23823 ±  6%     -42.5%      13695 ± 10%  softirqs.CPU28.RCU
     49693           -34.8%      32375        softirqs.CPU28.SCHED
     91425           -34.2%      60152        softirqs.CPU28.TIMER
     23682 ±  3%     -42.7%      13580 ±  7%  softirqs.CPU29.RCU
     49091           -34.5%      32166        softirqs.CPU29.SCHED
     90088           -33.4%      59978        softirqs.CPU29.TIMER
     21696 ±  2%     -40.8%      12836 ±  6%  softirqs.CPU3.RCU
     48756           -34.2%      32071        softirqs.CPU3.SCHED
     91187           -33.8%      60335        softirqs.CPU3.TIMER
     22322 ±  2%     -27.9%      16090 ± 15%  softirqs.CPU30.RCU
     48881           -34.5%      32036        softirqs.CPU30.SCHED
     89824           -33.1%      60087        softirqs.CPU30.TIMER
     22881 ±  2%     -37.4%      14324 ±  6%  softirqs.CPU31.RCU
     48763           -34.2%      32079        softirqs.CPU31.SCHED
     89807           -33.0%      60132        softirqs.CPU31.TIMER
     22369 ±  5%     -34.2%      14711 ±  5%  softirqs.CPU32.RCU
     48932           -34.4%      32089        softirqs.CPU32.SCHED
     90136           -33.7%      59771        softirqs.CPU32.TIMER
     24078 ±  2%     -39.2%      14637 ± 10%  softirqs.CPU33.RCU
     48900           -34.7%      31929        softirqs.CPU33.SCHED
     90381           -33.8%      59859        softirqs.CPU33.TIMER
     24794           -40.5%      14755 ±  2%  softirqs.CPU34.RCU
     48702           -34.2%      32059        softirqs.CPU34.SCHED
     89981           -33.4%      59949        softirqs.CPU34.TIMER
     23387 ±  3%     -42.0%      13563 ± 10%  softirqs.CPU35.RCU
     49175 ±  2%     -35.3%      31829        softirqs.CPU35.SCHED
    107101 ± 27%     -44.3%      59642        softirqs.CPU35.TIMER
     25396 ±  3%     -42.0%      14725 ±  6%  softirqs.CPU36.RCU
     49373           -34.3%      32419        softirqs.CPU36.SCHED
     90586           -33.6%      60171        softirqs.CPU36.TIMER
     24764           -38.0%      15347 ±  5%  softirqs.CPU37.RCU
     49240           -34.7%      32174        softirqs.CPU37.SCHED
     90693           -34.1%      59782        softirqs.CPU37.TIMER
     23986 ±  7%     -39.0%      14637 ±  4%  softirqs.CPU38.RCU
     49241           -34.7%      32166        softirqs.CPU38.SCHED
     91208           -34.2%      60034        softirqs.CPU38.TIMER
     25146 ±  3%     -39.7%      15168 ± 18%  softirqs.CPU39.RCU
     48951           -34.5%      32041        softirqs.CPU39.SCHED
     90295           -33.7%      59848        softirqs.CPU39.TIMER
     23881 ± 17%     -43.3%      13530 ±  9%  softirqs.CPU4.RCU
     48681           -33.6%      32306        softirqs.CPU4.SCHED
     90505           -33.1%      60561        softirqs.CPU4.TIMER
     23356 ±  2%     -38.3%      14402 ±  8%  softirqs.CPU40.RCU
     48722           -34.2%      32044        softirqs.CPU40.SCHED
     90099           -33.4%      60004        softirqs.CPU40.TIMER
     22071 ± 15%     -35.1%      14332 ±  4%  softirqs.CPU41.RCU
     49308           -34.5%      32280        softirqs.CPU41.SCHED
     92092 ±  2%     -34.6%      60238        softirqs.CPU41.TIMER
     24707 ±  4%     -37.5%      15453 ±  7%  softirqs.CPU42.RCU
     49464           -34.2%      32567 ±  2%  softirqs.CPU42.SCHED
     24420           -39.6%      14741 ± 13%  softirqs.CPU43.RCU
     49611           -34.5%      32473        softirqs.CPU43.SCHED
     91848           -34.1%      60524 ±  2%  softirqs.CPU43.TIMER
     19410           -42.4%      11182 ±  5%  softirqs.CPU44.RCU
     48878           -34.0%      32259        softirqs.CPU44.SCHED
     91387           -32.4%      61814 ±  3%  softirqs.CPU44.TIMER
     24101 ±  7%     -27.8%      17398 ±  8%  softirqs.CPU45.RCU
     49242           -34.0%      32508        softirqs.CPU45.SCHED
     92561           -28.0%      66676 ±  2%  softirqs.CPU45.TIMER
     23188           -40.1%      13895 ±  7%  softirqs.CPU46.RCU
     48916           -34.3%      32116        softirqs.CPU46.SCHED
     90678           -33.5%      60335        softirqs.CPU46.TIMER
     22800           -39.4%      13821 ±  9%  softirqs.CPU47.RCU
     48560           -34.1%      31984        softirqs.CPU47.SCHED
     91331           -34.1%      60166        softirqs.CPU47.TIMER
     23352 ±  6%     -39.1%      14232 ± 10%  softirqs.CPU48.RCU
     48942           -34.3%      32146        softirqs.CPU48.SCHED
     91248           -34.1%      60136        softirqs.CPU48.TIMER
     23095 ±  6%     -40.4%      13758 ± 11%  softirqs.CPU49.RCU
     48810           -34.6%      31944        softirqs.CPU49.SCHED
     90747           -33.8%      60083        softirqs.CPU49.TIMER
     23325 ±  5%     -41.0%      13769 ±  5%  softirqs.CPU5.RCU
     48805           -34.2%      32094        softirqs.CPU5.SCHED
     91617           -33.9%      60564        softirqs.CPU5.TIMER
     23644 ±  4%     -39.9%      14205 ± 10%  softirqs.CPU50.RCU
     48990           -34.2%      32236        softirqs.CPU50.SCHED
     90692           -33.2%      60554        softirqs.CPU50.TIMER
     23686 ±  7%     -35.6%      15252 ± 11%  softirqs.CPU51.RCU
     48956           -34.1%      32281        softirqs.CPU51.SCHED
     91604           -34.0%      60504        softirqs.CPU51.TIMER
     22432           -33.9%      14818 ± 11%  softirqs.CPU52.RCU
     48387           -33.6%      32125        softirqs.CPU52.SCHED
     90864           -33.4%      60497        softirqs.CPU52.TIMER
     23386 ±  3%     -42.4%      13472 ±  5%  softirqs.CPU53.RCU
     48886           -34.5%      32024        softirqs.CPU53.SCHED
     90647           -33.5%      60254        softirqs.CPU53.TIMER
     22531 ±  4%     -30.9%      15559 ± 20%  softirqs.CPU54.RCU
     48895           -34.4%      32072        softirqs.CPU54.SCHED
     90922           -33.1%      60853        softirqs.CPU54.TIMER
     22676 ±  3%     -41.7%      13215 ±  8%  softirqs.CPU55.RCU
     48288           -33.9%      31913        softirqs.CPU55.SCHED
     90143           -33.0%      60354        softirqs.CPU55.TIMER
     24427 ±  3%     -44.0%      13683 ±  7%  softirqs.CPU56.RCU
     49382 ±  2%     -34.9%      32138        softirqs.CPU56.SCHED
     91201 ±  2%     -33.5%      60678        softirqs.CPU56.TIMER
     24291 ±  7%     -43.1%      13816 ± 10%  softirqs.CPU57.RCU
     48663           -34.3%      31962        softirqs.CPU57.SCHED
     90697           -33.2%      60624        softirqs.CPU57.TIMER
     24129 ±  4%     -41.8%      14036 ±  7%  softirqs.CPU58.RCU
     49018           -34.4%      32175        softirqs.CPU58.SCHED
     90610           -32.9%      60790        softirqs.CPU58.TIMER
     24746 ±  5%     -46.0%      13369 ±  7%  softirqs.CPU59.RCU
     49153           -34.0%      32426        softirqs.CPU59.SCHED
     90884           -33.1%      60813        softirqs.CPU59.TIMER
     22574 ±  2%     -42.6%      12956 ±  6%  softirqs.CPU6.RCU
     49235           -33.8%      32587        softirqs.CPU6.SCHED
     91160           -33.2%      60871        softirqs.CPU6.TIMER
     24608           -42.8%      14077 ±  7%  softirqs.CPU60.RCU
     49107           -34.1%      32338        softirqs.CPU60.SCHED
     90958           -33.5%      60470        softirqs.CPU60.TIMER
     22744 ±  4%     -39.5%      13770 ±  7%  softirqs.CPU61.RCU
     48815           -34.5%      31981        softirqs.CPU61.SCHED
     90275           -33.6%      59942        softirqs.CPU61.TIMER
     22717 ±  5%     -36.3%      14470 ±  5%  softirqs.CPU62.RCU
     49262           -35.0%      32004        softirqs.CPU62.SCHED
    107526 ± 26%     -44.5%      59722        softirqs.CPU62.TIMER
     22121 ±  5%     -38.5%      13593 ± 13%  softirqs.CPU63.RCU
     48424           -34.2%      31850        softirqs.CPU63.SCHED
     89901           -32.9%      60354 ±  2%  softirqs.CPU63.TIMER
     23264 ±  2%     -39.4%      14093 ±  6%  softirqs.CPU64.RCU
     49293           -34.5%      32299        softirqs.CPU64.SCHED
     90911           -32.4%      61449 ±  2%  softirqs.CPU64.TIMER
     24129 ±  5%     -43.3%      13684 ±  8%  softirqs.CPU65.RCU
     49149           -34.0%      32419        softirqs.CPU65.SCHED
     25946 ±  2%     -41.5%      15171 ±  6%  softirqs.CPU66.RCU
     49445           -35.2%      32022        softirqs.CPU66.SCHED
     92374           -34.8%      60194        softirqs.CPU66.TIMER
     25811 ±  2%     -42.0%      14962 ±  6%  softirqs.CPU67.RCU
     49183           -34.6%      32190        softirqs.CPU67.SCHED
     90248           -33.4%      60104        softirqs.CPU67.TIMER
     25134 ±  4%     -39.9%      15098 ±  8%  softirqs.CPU68.RCU
     48943           -34.1%      32271        softirqs.CPU68.SCHED
     90171           -33.3%      60139        softirqs.CPU68.TIMER
     24403 ±  3%     -37.2%      15327 ±  6%  softirqs.CPU69.RCU
     48832           -34.7%      31872        softirqs.CPU69.SCHED
     90258           -34.3%      59311        softirqs.CPU69.TIMER
     21852 ±  2%     -38.8%      13364 ±  7%  softirqs.CPU7.RCU
     48924           -33.9%      32319        softirqs.CPU7.SCHED
     90908           -33.1%      60776        softirqs.CPU7.TIMER
     24793           -38.9%      15140 ±  8%  softirqs.CPU70.RCU
     48807           -34.5%      31953        softirqs.CPU70.SCHED
     90038           -33.8%      59613        softirqs.CPU70.TIMER
     23670 ± 18%     -37.0%      14906 ± 14%  softirqs.CPU71.RCU
     48849           -34.8%      31858        softirqs.CPU71.SCHED
     89585           -33.6%      59455        softirqs.CPU71.TIMER
     25855 ±  6%     -41.1%      15217 ± 10%  softirqs.CPU72.RCU
     49310           -34.6%      32228        softirqs.CPU72.SCHED
     90872           -34.3%      59745        softirqs.CPU72.TIMER
     25080 ±  5%     -41.8%      14604 ±  2%  softirqs.CPU73.RCU
     48907           -34.9%      31856        softirqs.CPU73.SCHED
     90081           -34.1%      59359        softirqs.CPU73.TIMER
     24380 ±  3%     -39.6%      14717 ±  5%  softirqs.CPU74.RCU
     48841           -34.5%      31975        softirqs.CPU74.SCHED
     89711           -33.6%      59559        softirqs.CPU74.TIMER
     20706 ±  3%     -37.8%      12883 ±  8%  softirqs.CPU75.RCU
     48773           -34.8%      31822        softirqs.CPU75.SCHED
     90101           -34.0%      59435        softirqs.CPU75.TIMER
     20385 ±  5%     -41.7%      11878 ±  4%  softirqs.CPU76.RCU
     48652           -34.5%      31876        softirqs.CPU76.SCHED
     90132           -34.2%      59276        softirqs.CPU76.TIMER
     20442 ±  2%     -41.4%      11984 ± 12%  softirqs.CPU77.RCU
     48664           -34.7%      31799        softirqs.CPU77.SCHED
     90078           -33.9%      59562        softirqs.CPU77.TIMER
     20243 ±  6%     -38.5%      12444 ±  7%  softirqs.CPU78.RCU
     48677           -34.8%      31717        softirqs.CPU78.SCHED
     89889           -34.0%      59362        softirqs.CPU78.TIMER
     19018 ± 11%     -36.0%      12162 ± 10%  softirqs.CPU79.RCU
     48810           -35.0%      31748        softirqs.CPU79.SCHED
     91123           -34.8%      59406        softirqs.CPU79.TIMER
     21869 ±  4%     -37.4%      13695 ±  6%  softirqs.CPU8.RCU
     48748           -33.9%      32209        softirqs.CPU8.SCHED
     90966           -33.2%      60779        softirqs.CPU8.TIMER
     20992 ±  2%     -41.1%      12368 ±  7%  softirqs.CPU80.RCU
     49104           -34.6%      32122        softirqs.CPU80.SCHED
     91143           -34.6%      59581        softirqs.CPU80.TIMER
     20507 ±  3%     -38.0%      12723 ± 11%  softirqs.CPU81.RCU
     49167           -34.8%      32054        softirqs.CPU81.SCHED
     90831           -34.7%      59322        softirqs.CPU81.TIMER
     23199 ± 12%     -46.1%      12507 ± 11%  softirqs.CPU82.RCU
     48908           -34.5%      32028        softirqs.CPU82.SCHED
     91215           -34.5%      59701        softirqs.CPU82.TIMER
     20694 ±  5%     -39.6%      12499 ± 13%  softirqs.CPU83.RCU
     48561           -34.5%      31797        softirqs.CPU83.SCHED
     89836           -34.1%      59238        softirqs.CPU83.TIMER
     20754           -41.2%      12210 ± 17%  softirqs.CPU84.RCU
     48475           -34.3%      31837        softirqs.CPU84.SCHED
     89895           -33.9%      59460        softirqs.CPU84.TIMER
     23132 ± 17%     -36.5%      14690 ± 23%  softirqs.CPU85.RCU
     49159           -34.3%      32273        softirqs.CPU85.SCHED
    108932 ± 25%     -44.9%      60058        softirqs.CPU85.TIMER
     20899 ±  6%     -43.5%      11811 ± 15%  softirqs.CPU86.RCU
     49019           -34.3%      32188        softirqs.CPU86.SCHED
     90158           -33.5%      59974        softirqs.CPU86.TIMER
     20364 ±  3%     -39.3%      12364 ± 10%  softirqs.CPU87.RCU
     48874           -34.1%      32209        softirqs.CPU87.SCHED
     22130 ±  4%     -38.5%      13603 ± 10%  softirqs.CPU9.RCU
     48933           -34.2%      32203        softirqs.CPU9.SCHED
     91213           -33.3%      60833        softirqs.CPU9.TIMER
   2029638 ±  2%     -39.6%    1226445 ±  6%  softirqs.RCU
   4316876           -34.4%    2833655        softirqs.SCHED
   8077949           -33.6%    5364474        softirqs.TIMER
    300.25           -34.7%     196.00        interrupts.168:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
    636.75 ± 89%     -82.4%     111.75 ±  8%  interrupts.37:IR-PCI-MSI.1572867-edge.eth0-TxRx-3
    194.50 ± 13%     -40.2%     116.25 ±  9%  interrupts.39:IR-PCI-MSI.1572869-edge.eth0-TxRx-5
    313.75 ± 48%     -51.2%     153.00 ± 41%  interrupts.41:IR-PCI-MSI.1572871-edge.eth0-TxRx-7
    181.00 ± 13%     -40.7%     107.25 ±  2%  interrupts.42:IR-PCI-MSI.1572872-edge.eth0-TxRx-8
    234.25 ± 38%     -46.2%     126.00 ± 15%  interrupts.43:IR-PCI-MSI.1572873-edge.eth0-TxRx-9
    168.00 ±  2%     -27.2%     122.25 ± 13%  interrupts.44:IR-PCI-MSI.1572874-edge.eth0-TxRx-10
    170.50 ±  5%     -29.8%     119.75 ±  7%  interrupts.45:IR-PCI-MSI.1572875-edge.eth0-TxRx-11
    248.75 ± 43%     -51.8%     120.00 ± 21%  interrupts.47:IR-PCI-MSI.1572877-edge.eth0-TxRx-13
    175.75 ±  5%     -38.3%     108.50 ±  6%  interrupts.48:IR-PCI-MSI.1572878-edge.eth0-TxRx-14
    151.50           -34.7%      99.00 ±  2%  interrupts.50:IR-PCI-MSI.1572880-edge.eth0-TxRx-16
    151.25           -34.4%      99.25 ±  2%  interrupts.51:IR-PCI-MSI.1572881-edge.eth0-TxRx-17
    151.25           -35.0%      98.25        interrupts.53:IR-PCI-MSI.1572883-edge.eth0-TxRx-19
    155.50 ±  4%     -36.8%      98.25        interrupts.54:IR-PCI-MSI.1572884-edge.eth0-TxRx-20
    150.25           -34.4%      98.50        interrupts.55:IR-PCI-MSI.1572885-edge.eth0-TxRx-21
    150.50           -33.2%     100.50 ±  4%  interrupts.56:IR-PCI-MSI.1572886-edge.eth0-TxRx-22
    150.00           -34.0%      99.00 ±  2%  interrupts.57:IR-PCI-MSI.1572887-edge.eth0-TxRx-23
    151.25           -26.9%     110.50 ± 20%  interrupts.58:IR-PCI-MSI.1572888-edge.eth0-TxRx-24
    150.00           -34.7%      98.00        interrupts.59:IR-PCI-MSI.1572889-edge.eth0-TxRx-25
    150.00           -34.5%      98.25        interrupts.60:IR-PCI-MSI.1572890-edge.eth0-TxRx-26
    150.00           -34.8%      97.75        interrupts.61:IR-PCI-MSI.1572891-edge.eth0-TxRx-27
    150.00           -30.8%     103.75 ±  8%  interrupts.63:IR-PCI-MSI.1572893-edge.eth0-TxRx-29
    152.25 ±  2%     -35.8%      97.75        interrupts.64:IR-PCI-MSI.1572894-edge.eth0-TxRx-30
    150.00           -34.8%      97.75        interrupts.65:IR-PCI-MSI.1572895-edge.eth0-TxRx-31
    151.00           -35.3%      97.75        interrupts.66:IR-PCI-MSI.1572896-edge.eth0-TxRx-32
    150.50           -35.0%      97.75        interrupts.67:IR-PCI-MSI.1572897-edge.eth0-TxRx-33
    150.00           -34.0%      99.00 ±  2%  interrupts.68:IR-PCI-MSI.1572898-edge.eth0-TxRx-34
    150.00           -34.8%      97.75        interrupts.69:IR-PCI-MSI.1572899-edge.eth0-TxRx-35
    150.25           -34.6%      98.25        interrupts.70:IR-PCI-MSI.1572900-edge.eth0-TxRx-36
    150.00           -34.5%      98.25        interrupts.71:IR-PCI-MSI.1572901-edge.eth0-TxRx-37
    150.00           -34.0%      99.00        interrupts.74:IR-PCI-MSI.1572902-edge.eth0-TxRx-38
    150.00           -34.8%      97.75        interrupts.75:IR-PCI-MSI.1572903-edge.eth0-TxRx-39
    150.00           -34.8%      97.75        interrupts.76:IR-PCI-MSI.1572904-edge.eth0-TxRx-40
    173.50 ± 22%     -41.9%     100.75 ±  5%  interrupts.77:IR-PCI-MSI.1572905-edge.eth0-TxRx-41
    150.00           -34.8%      97.75        interrupts.78:IR-PCI-MSI.1572906-edge.eth0-TxRx-42
    150.50           -35.0%      97.75        interrupts.79:IR-PCI-MSI.1572907-edge.eth0-TxRx-43
    155.75 ±  5%     -31.9%     106.00 ±  9%  interrupts.80:IR-PCI-MSI.1572908-edge.eth0-TxRx-44
    152.00           -34.5%      99.50 ±  2%  interrupts.81:IR-PCI-MSI.1572909-edge.eth0-TxRx-45
    150.25           -32.3%     101.75 ±  7%  interrupts.82:IR-PCI-MSI.1572910-edge.eth0-TxRx-46
    151.00           -34.3%      99.25 ±  2%  interrupts.83:IR-PCI-MSI.1572911-edge.eth0-TxRx-47
    173.50 ± 20%     -43.2%      98.50 ±  2%  interrupts.84:IR-PCI-MSI.1572912-edge.eth0-TxRx-48
    153.00 ±  3%     -34.6%     100.00 ±  4%  interrupts.85:IR-PCI-MSI.1572913-edge.eth0-TxRx-49
    158.00 ±  2%     -35.9%     101.25 ±  6%  interrupts.86:IR-PCI-MSI.1572914-edge.eth0-TxRx-50
    150.75           -33.5%     100.25 ±  4%  interrupts.87:IR-PCI-MSI.1572915-edge.eth0-TxRx-51
    151.00           -35.3%      97.75        interrupts.88:IR-PCI-MSI.1572916-edge.eth0-TxRx-52
    151.75           -33.9%     100.25 ±  5%  interrupts.89:IR-PCI-MSI.1572917-edge.eth0-TxRx-53
    154.00 ±  3%     -34.6%     100.75 ±  3%  interrupts.90:IR-PCI-MSI.1572918-edge.eth0-TxRx-54
    152.75           -36.0%      97.75        interrupts.92:IR-PCI-MSI.1572920-edge.eth0-TxRx-56
    150.75           -35.2%      97.75        interrupts.93:IR-PCI-MSI.1572921-edge.eth0-TxRx-57
    150.25           -34.9%      97.75        interrupts.94:IR-PCI-MSI.1572922-edge.eth0-TxRx-58
    152.25           -35.8%      97.75        interrupts.95:IR-PCI-MSI.1572923-edge.eth0-TxRx-59
    152.75 ±  2%     -36.0%      97.75        interrupts.96:IR-PCI-MSI.1572924-edge.eth0-TxRx-60
    150.75           -34.8%      98.25        interrupts.97:IR-PCI-MSI.1572925-edge.eth0-TxRx-61
    151.00           -35.1%      98.00        interrupts.98:IR-PCI-MSI.1572926-edge.eth0-TxRx-62
    468.50           -31.9%     319.00 ±  4%  interrupts.9:IR-IO-APIC.9-fasteoi.acpi
   1509329 ±  2%     -33.9%     998065 ±  2%  interrupts.CAL:Function_call_interrupts
     17097 ±  2%     -33.4%      11385 ±  2%  interrupts.CPU0.CAL:Function_call_interrupts
    613505           -34.9%     399429        interrupts.CPU0.LOC:Local_timer_interrupts
      8520 ±  2%     -34.4%       5585 ±  3%  interrupts.CPU0.RES:Rescheduling_interrupts
     15342 ±  2%     -34.4%      10057 ±  4%  interrupts.CPU0.TLB:TLB_shootdowns
    468.50           -31.9%     319.00 ±  4%  interrupts.CPU1.9:IR-IO-APIC.9-fasteoi.acpi
     17378           -34.8%      11337 ±  3%  interrupts.CPU1.CAL:Function_call_interrupts
    613323           -34.9%     399178        interrupts.CPU1.LOC:Local_timer_interrupts
      7227 ±  2%     -32.2%       4898 ±  4%  interrupts.CPU1.RES:Rescheduling_interrupts
     15741 ±  2%     -36.6%       9977 ±  3%  interrupts.CPU1.TLB:TLB_shootdowns
    168.00 ±  2%     -27.2%     122.25 ± 13%  interrupts.CPU10.44:IR-PCI-MSI.1572874-edge.eth0-TxRx-10
     17112 ±  2%     -34.0%      11300 ±  2%  interrupts.CPU10.CAL:Function_call_interrupts
    612934           -34.9%     399312        interrupts.CPU10.LOC:Local_timer_interrupts
      7060 ±  6%     -31.3%       4851 ± 10%  interrupts.CPU10.RES:Rescheduling_interrupts
     15429 ±  4%     -35.1%      10019 ±  3%  interrupts.CPU10.TLB:TLB_shootdowns
    170.50 ±  5%     -29.8%     119.75 ±  7%  interrupts.CPU11.45:IR-PCI-MSI.1572875-edge.eth0-TxRx-11
     16995 ±  2%     -33.1%      11364 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
    612683           -34.8%     399339        interrupts.CPU11.LOC:Local_timer_interrupts
      6990 ±  3%     -31.2%       4810 ±  7%  interrupts.CPU11.RES:Rescheduling_interrupts
     15186 ±  3%     -34.3%       9972 ±  2%  interrupts.CPU11.TLB:TLB_shootdowns
     16997 ±  2%     -33.3%      11338 ±  2%  interrupts.CPU12.CAL:Function_call_interrupts
    613339           -34.9%     399170        interrupts.CPU12.LOC:Local_timer_interrupts
      6990 ±  4%     -34.5%       4581 ±  5%  interrupts.CPU12.RES:Rescheduling_interrupts
     15108 ±  2%     -33.7%      10016 ±  2%  interrupts.CPU12.TLB:TLB_shootdowns
    248.75 ± 43%     -51.8%     120.00 ± 21%  interrupts.CPU13.47:IR-PCI-MSI.1572877-edge.eth0-TxRx-13
     16929 ±  3%     -33.5%      11263 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
    613134           -34.9%     399371        interrupts.CPU13.LOC:Local_timer_interrupts
      6704           -29.0%       4760 ±  9%  interrupts.CPU13.RES:Rescheduling_interrupts
     15192 ±  3%     -34.9%       9897 ±  3%  interrupts.CPU13.TLB:TLB_shootdowns
    175.75 ±  5%     -38.3%     108.50 ±  6%  interrupts.CPU14.48:IR-PCI-MSI.1572878-edge.eth0-TxRx-14
     16953 ±  3%     -32.9%      11371 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
    613112           -34.9%     399101        interrupts.CPU14.LOC:Local_timer_interrupts
      7159 ±  3%     -33.5%       4763 ± 10%  interrupts.CPU14.RES:Rescheduling_interrupts
     15301 ±  4%     -34.3%      10046 ±  3%  interrupts.CPU14.TLB:TLB_shootdowns
     17050 ±  3%     -34.3%      11210 ±  2%  interrupts.CPU15.CAL:Function_call_interrupts
    613127           -34.9%     399291        interrupts.CPU15.LOC:Local_timer_interrupts
      6944 ±  3%     -31.0%       4791 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
     15282 ±  4%     -34.8%       9966 ±  2%  interrupts.CPU15.TLB:TLB_shootdowns
    151.50           -34.7%      99.00 ±  2%  interrupts.CPU16.50:IR-PCI-MSI.1572880-edge.eth0-TxRx-16
     16919 ±  2%     -33.9%      11190        interrupts.CPU16.CAL:Function_call_interrupts
    613265           -34.9%     399128        interrupts.CPU16.LOC:Local_timer_interrupts
      7560 ±  5%     -30.1%       5288 ± 16%  interrupts.CPU16.RES:Rescheduling_interrupts
     15173 ±  3%     -35.1%       9849        interrupts.CPU16.TLB:TLB_shootdowns
    151.25           -34.4%      99.25 ±  2%  interrupts.CPU17.51:IR-PCI-MSI.1572881-edge.eth0-TxRx-17
     17067 ±  2%     -34.6%      11155 ±  2%  interrupts.CPU17.CAL:Function_call_interrupts
    613275           -35.0%     398883        interrupts.CPU17.LOC:Local_timer_interrupts
      7592 ±  7%     -35.3%       4915 ± 11%  interrupts.CPU17.RES:Rescheduling_interrupts
     15381 ±  2%     -36.3%       9799 ±  3%  interrupts.CPU17.TLB:TLB_shootdowns
     17064 ±  2%     -34.4%      11192 ±  3%  interrupts.CPU18.CAL:Function_call_interrupts
    612709           -34.9%     399089        interrupts.CPU18.LOC:Local_timer_interrupts
      7251 ±  4%     -33.4%       4827 ±  8%  interrupts.CPU18.RES:Rescheduling_interrupts
     15243 ±  3%     -35.4%       9843 ±  3%  interrupts.CPU18.TLB:TLB_shootdowns
    151.25           -35.0%      98.25        interrupts.CPU19.53:IR-PCI-MSI.1572883-edge.eth0-TxRx-19
     17054 ±  2%     -34.1%      11246 ±  2%  interrupts.CPU19.CAL:Function_call_interrupts
    612999           -34.9%     398997        interrupts.CPU19.LOC:Local_timer_interrupts
      7466 ±  7%     -32.5%       5037 ± 13%  interrupts.CPU19.RES:Rescheduling_interrupts
     15258 ±  2%     -35.0%       9920 ±  2%  interrupts.CPU19.TLB:TLB_shootdowns
     17162 ±  2%     -34.4%      11265 ±  2%  interrupts.CPU2.CAL:Function_call_interrupts
    613357           -34.9%     399326        interrupts.CPU2.LOC:Local_timer_interrupts
      7000           -34.7%       4569        interrupts.CPU2.RES:Rescheduling_interrupts
     15308 ±  3%     -34.7%       9989 ±  3%  interrupts.CPU2.TLB:TLB_shootdowns
    155.50 ±  4%     -36.8%      98.25        interrupts.CPU20.54:IR-PCI-MSI.1572884-edge.eth0-TxRx-20
     16990 ±  2%     -32.6%      11443 ±  2%  interrupts.CPU20.CAL:Function_call_interrupts
    613086           -34.9%     398881        interrupts.CPU20.LOC:Local_timer_interrupts
      7580 ±  6%     -34.3%       4981 ±  7%  interrupts.CPU20.RES:Rescheduling_interrupts
     15329 ±  4%     -34.3%      10066 ±  4%  interrupts.CPU20.TLB:TLB_shootdowns
    150.25           -34.4%      98.50        interrupts.CPU21.55:IR-PCI-MSI.1572885-edge.eth0-TxRx-21
     17255           -33.2%      11519 ±  2%  interrupts.CPU21.CAL:Function_call_interrupts
    613366           -35.0%     398819        interrupts.CPU21.LOC:Local_timer_interrupts
      7764 ±  6%     -30.2%       5418 ± 15%  interrupts.CPU21.RES:Rescheduling_interrupts
     15569 ±  2%     -34.2%      10252 ±  3%  interrupts.CPU21.TLB:TLB_shootdowns
    150.50           -33.2%     100.50 ±  4%  interrupts.CPU22.56:IR-PCI-MSI.1572886-edge.eth0-TxRx-22
     17100 ±  4%     -35.9%      10961        interrupts.CPU22.CAL:Function_call_interrupts
    613054           -34.9%     398855        interrupts.CPU22.LOC:Local_timer_interrupts
      7160 ±  3%     -30.4%       4981 ±  6%  interrupts.CPU22.RES:Rescheduling_interrupts
     15282 ±  5%     -36.4%       9717 ±  3%  interrupts.CPU22.TLB:TLB_shootdowns
    150.00           -34.0%      99.00 ±  2%  interrupts.CPU23.57:IR-PCI-MSI.1572887-edge.eth0-TxRx-23
     16840 ±  2%     -33.3%      11236 ±  3%  interrupts.CPU23.CAL:Function_call_interrupts
    613099           -34.9%     399413        interrupts.CPU23.LOC:Local_timer_interrupts
      6909 ±  2%     -34.8%       4505 ±  2%  interrupts.CPU23.RES:Rescheduling_interrupts
     15233 ±  3%     -34.9%       9923 ±  3%  interrupts.CPU23.TLB:TLB_shootdowns
    151.25           -26.9%     110.50 ± 20%  interrupts.CPU24.58:IR-PCI-MSI.1572888-edge.eth0-TxRx-24
     16924 ±  4%     -33.6%      11232 ±  2%  interrupts.CPU24.CAL:Function_call_interrupts
    613290           -34.9%     399537        interrupts.CPU24.LOC:Local_timer_interrupts
      6875 ±  2%     -35.2%       4455        interrupts.CPU24.RES:Rescheduling_interrupts
     15151 ±  4%     -34.6%       9909 ±  3%  interrupts.CPU24.TLB:TLB_shootdowns
    150.00           -34.7%      98.00        interrupts.CPU25.59:IR-PCI-MSI.1572889-edge.eth0-TxRx-25
     17010 ±  3%     -33.5%      11318 ±  2%  interrupts.CPU25.CAL:Function_call_interrupts
    613085           -34.9%     399411        interrupts.CPU25.LOC:Local_timer_interrupts
      6855 ±  2%     -35.4%       4426        interrupts.CPU25.RES:Rescheduling_interrupts
     15283 ±  3%     -34.4%      10020 ±  3%  interrupts.CPU25.TLB:TLB_shootdowns
    150.00           -34.5%      98.25        interrupts.CPU26.60:IR-PCI-MSI.1572890-edge.eth0-TxRx-26
     16806           -33.6%      11158 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
    613174           -34.9%     399071        interrupts.CPU26.LOC:Local_timer_interrupts
      3493           -37.5%       2181 ± 34%  interrupts.CPU26.NMI:Non-maskable_interrupts
      3493           -37.5%       2181 ± 34%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      6778           -34.7%       4424 ±  3%  interrupts.CPU26.RES:Rescheduling_interrupts
     14997 ±  2%     -34.8%       9782 ±  4%  interrupts.CPU26.TLB:TLB_shootdowns
    150.00           -34.8%      97.75        interrupts.CPU27.61:IR-PCI-MSI.1572891-edge.eth0-TxRx-27
     16913 ±  2%     -34.2%      11121        interrupts.CPU27.CAL:Function_call_interrupts
    613360           -34.8%     399689        interrupts.CPU27.LOC:Local_timer_interrupts
      6802 ±  3%     -34.3%       4472        interrupts.CPU27.RES:Rescheduling_interrupts
     15301 ±  2%     -36.0%       9800 ±  3%  interrupts.CPU27.TLB:TLB_shootdowns
     16746 ±  2%     -32.1%      11370 ±  3%  interrupts.CPU28.CAL:Function_call_interrupts
    613302           -34.9%     399103        interrupts.CPU28.LOC:Local_timer_interrupts
      6817           -35.2%       4419        interrupts.CPU28.RES:Rescheduling_interrupts
     14986 ±  2%     -32.7%      10081 ±  4%  interrupts.CPU28.TLB:TLB_shootdowns
    150.00           -30.8%     103.75 ±  8%  interrupts.CPU29.63:IR-PCI-MSI.1572893-edge.eth0-TxRx-29
     16799 ±  3%     -32.8%      11290 ±  2%  interrupts.CPU29.CAL:Function_call_interrupts
    613087           -34.9%     399053        interrupts.CPU29.LOC:Local_timer_interrupts
      7091           -35.9%       4544 ±  2%  interrupts.CPU29.RES:Rescheduling_interrupts
     15128 ±  3%     -34.1%       9969 ±  3%  interrupts.CPU29.TLB:TLB_shootdowns
    636.75 ± 89%     -82.4%     111.75 ±  8%  interrupts.CPU3.37:IR-PCI-MSI.1572867-edge.eth0-TxRx-3
     17112           -33.7%      11350 ±  3%  interrupts.CPU3.CAL:Function_call_interrupts
    613344           -34.9%     399272        interrupts.CPU3.LOC:Local_timer_interrupts
      6958           -35.2%       4512 ±  2%  interrupts.CPU3.RES:Rescheduling_interrupts
     15326 ±  2%     -34.7%      10005 ±  3%  interrupts.CPU3.TLB:TLB_shootdowns
    152.25 ±  2%     -35.8%      97.75        interrupts.CPU30.64:IR-PCI-MSI.1572894-edge.eth0-TxRx-30
     16811 ±  4%     -32.4%      11366 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
    612821           -34.9%     399173        interrupts.CPU30.LOC:Local_timer_interrupts
      6808           -34.2%       4481 ±  2%  interrupts.CPU30.RES:Rescheduling_interrupts
     15137 ±  3%     -33.8%      10017 ±  5%  interrupts.CPU30.TLB:TLB_shootdowns
    150.00           -34.8%      97.75        interrupts.CPU31.65:IR-PCI-MSI.1572895-edge.eth0-TxRx-31
     16767 ±  3%     -34.3%      11024 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
    612828           -34.8%     399360        interrupts.CPU31.LOC:Local_timer_interrupts
      6698           -34.4%       4395 ±  3%  interrupts.CPU31.RES:Rescheduling_interrupts
     14995 ±  3%     -35.1%       9735 ±  3%  interrupts.CPU31.TLB:TLB_shootdowns
    151.00           -35.3%      97.75        interrupts.CPU32.66:IR-PCI-MSI.1572896-edge.eth0-TxRx-32
     16901 ±  3%     -34.7%      11030 ±  3%  interrupts.CPU32.CAL:Function_call_interrupts
    613222           -34.9%     399170        interrupts.CPU32.LOC:Local_timer_interrupts
      6642           -34.3%       4367        interrupts.CPU32.RES:Rescheduling_interrupts
     15186 ±  3%     -35.6%       9786 ±  4%  interrupts.CPU32.TLB:TLB_shootdowns
    150.50           -35.0%      97.75        interrupts.CPU33.67:IR-PCI-MSI.1572897-edge.eth0-TxRx-33
     16916 ±  3%     -33.8%      11195 ±  3%  interrupts.CPU33.CAL:Function_call_interrupts
    613470           -34.9%     399097        interrupts.CPU33.LOC:Local_timer_interrupts
      6647           -35.0%       4320        interrupts.CPU33.RES:Rescheduling_interrupts
     15227 ±  4%     -35.1%       9881 ±  4%  interrupts.CPU33.TLB:TLB_shootdowns
    150.00           -34.0%      99.00 ±  2%  interrupts.CPU34.68:IR-PCI-MSI.1572898-edge.eth0-TxRx-34
     17071 ±  3%     -34.0%      11268 ±  2%  interrupts.CPU34.CAL:Function_call_interrupts
    613242           -34.8%     399545        interrupts.CPU34.LOC:Local_timer_interrupts
      6736           -35.2%       4368 ±  2%  interrupts.CPU34.RES:Rescheduling_interrupts
     15377 ±  3%     -35.8%       9868 ±  3%  interrupts.CPU34.TLB:TLB_shootdowns
    150.00           -34.8%      97.75        interrupts.CPU35.69:IR-PCI-MSI.1572899-edge.eth0-TxRx-35
     16750 ±  2%     -32.7%      11268 ±  3%  interrupts.CPU35.CAL:Function_call_interrupts
    613212           -34.9%     399142        interrupts.CPU35.LOC:Local_timer_interrupts
      6859 ±  2%     -36.8%       4335 ±  2%  interrupts.CPU35.RES:Rescheduling_interrupts
     15208 ±  2%     -34.1%      10025 ±  2%  interrupts.CPU35.TLB:TLB_shootdowns
    150.25           -34.6%      98.25        interrupts.CPU36.70:IR-PCI-MSI.1572900-edge.eth0-TxRx-36
     17078 ±  4%     -34.4%      11209 ±  5%  interrupts.CPU36.CAL:Function_call_interrupts
    613116           -34.9%     399228        interrupts.CPU36.LOC:Local_timer_interrupts
      6787 ±  2%     -34.7%       4430        interrupts.CPU36.RES:Rescheduling_interrupts
     15310 ±  5%     -35.1%       9943 ±  6%  interrupts.CPU36.TLB:TLB_shootdowns
    150.00           -34.5%      98.25        interrupts.CPU37.71:IR-PCI-MSI.1572901-edge.eth0-TxRx-37
     16861 ±  2%     -33.0%      11301        interrupts.CPU37.CAL:Function_call_interrupts
    613110           -34.9%     399095        interrupts.CPU37.LOC:Local_timer_interrupts
      6735           -31.8%       4594 ±  6%  interrupts.CPU37.RES:Rescheduling_interrupts
     15107 ±  3%     -33.7%      10022 ±  2%  interrupts.CPU37.TLB:TLB_shootdowns
    150.00           -34.0%      99.00        interrupts.CPU38.74:IR-PCI-MSI.1572902-edge.eth0-TxRx-38
     17011 ±  2%     -34.5%      11149 ±  2%  interrupts.CPU38.CAL:Function_call_interrupts
    613510           -35.0%     398940        interrupts.CPU38.LOC:Local_timer_interrupts
      6808           -35.2%       4411 ±  3%  interrupts.CPU38.RES:Rescheduling_interrupts
     15210 ±  2%     -35.2%       9859 ±  3%  interrupts.CPU38.TLB:TLB_shootdowns
    150.00           -34.8%      97.75        interrupts.CPU39.75:IR-PCI-MSI.1572903-edge.eth0-TxRx-39
     17110 ±  4%     -34.5%      11212 ±  2%  interrupts.CPU39.CAL:Function_call_interrupts
    613130           -34.9%     399017        interrupts.CPU39.LOC:Local_timer_interrupts
      6651           -34.2%       4380 ±  3%  interrupts.CPU39.RES:Rescheduling_interrupts
     15352 ±  4%     -36.1%       9802 ±  2%  interrupts.CPU39.TLB:TLB_shootdowns
     17310           -34.9%      11277 ±  2%  interrupts.CPU4.CAL:Function_call_interrupts
    613127           -34.9%     398947        interrupts.CPU4.LOC:Local_timer_interrupts
      7093 ±  2%     -36.0%       4537 ±  3%  interrupts.CPU4.RES:Rescheduling_interrupts
     15585 ±  2%     -36.5%       9895 ±  3%  interrupts.CPU4.TLB:TLB_shootdowns
    150.00           -34.8%      97.75        interrupts.CPU40.76:IR-PCI-MSI.1572904-edge.eth0-TxRx-40
     16608 ±  2%     -32.6%      11195 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
    613122           -34.9%     399262        interrupts.CPU40.LOC:Local_timer_interrupts
      6829           -35.1%       4433 ±  2%  interrupts.CPU40.RES:Rescheduling_interrupts
     14888 ±  3%     -33.1%       9967 ±  4%  interrupts.CPU40.TLB:TLB_shootdowns
    173.50 ± 22%     -41.9%     100.75 ±  5%  interrupts.CPU41.77:IR-PCI-MSI.1572905-edge.eth0-TxRx-41
     16915 ±  3%     -34.0%      11160 ±  3%  interrupts.CPU41.CAL:Function_call_interrupts
    612830           -34.8%     399521        interrupts.CPU41.LOC:Local_timer_interrupts
      6945           -35.8%       4461        interrupts.CPU41.RES:Rescheduling_interrupts
     15089 ±  3%     -34.6%       9861 ±  4%  interrupts.CPU41.TLB:TLB_shootdowns
    150.00           -34.8%      97.75        interrupts.CPU42.78:IR-PCI-MSI.1572906-edge.eth0-TxRx-42
     16853 ±  2%     -34.2%      11095 ±  3%  interrupts.CPU42.CAL:Function_call_interrupts
    613158           -34.9%     399462        interrupts.CPU42.LOC:Local_timer_interrupts
      7142           -36.3%       4548 ±  2%  interrupts.CPU42.RES:Rescheduling_interrupts
     15101 ±  3%     -34.2%       9944 ±  2%  interrupts.CPU42.TLB:TLB_shootdowns
    150.50           -35.0%      97.75        interrupts.CPU43.79:IR-PCI-MSI.1572907-edge.eth0-TxRx-43
     16990 ±  3%     -35.0%      11044 ±  5%  interrupts.CPU43.CAL:Function_call_interrupts
    613206           -34.9%     399419        interrupts.CPU43.LOC:Local_timer_interrupts
      7370 ±  7%     -34.6%       4818 ±  5%  interrupts.CPU43.RES:Rescheduling_interrupts
     15286 ±  3%     -35.6%       9842 ±  4%  interrupts.CPU43.TLB:TLB_shootdowns
    155.75 ±  5%     -31.9%     106.00 ±  9%  interrupts.CPU44.80:IR-PCI-MSI.1572908-edge.eth0-TxRx-44
     17243 ±  3%     -32.9%      11562 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
    612888           -34.9%     398776        interrupts.CPU44.LOC:Local_timer_interrupts
      7316 ±  4%     -30.8%       5064 ± 16%  interrupts.CPU44.RES:Rescheduling_interrupts
     15311 ±  4%     -34.0%      10110 ±  2%  interrupts.CPU44.TLB:TLB_shootdowns
    152.00           -34.5%      99.50 ±  2%  interrupts.CPU45.81:IR-PCI-MSI.1572909-edge.eth0-TxRx-45
     17412 ±  3%     -34.2%      11449 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
    613317           -34.9%     399022        interrupts.CPU45.LOC:Local_timer_interrupts
      7481 ±  6%     -32.4%       5058 ± 13%  interrupts.CPU45.RES:Rescheduling_interrupts
     15483 ±  4%     -35.0%      10069 ±  4%  interrupts.CPU45.TLB:TLB_shootdowns
    150.25           -32.3%     101.75 ±  7%  interrupts.CPU46.82:IR-PCI-MSI.1572910-edge.eth0-TxRx-46
     17328 ±  2%     -34.4%      11368 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
    613203           -34.9%     399405        interrupts.CPU46.LOC:Local_timer_interrupts
      7036 ±  4%     -21.9%       5494 ± 14%  interrupts.CPU46.RES:Rescheduling_interrupts
     15425 ±  3%     -35.8%       9909 ±  4%  interrupts.CPU46.TLB:TLB_shootdowns
    151.00           -34.3%      99.25 ±  2%  interrupts.CPU47.83:IR-PCI-MSI.1572911-edge.eth0-TxRx-47
     17441 ±  3%     -33.7%      11566 ±  2%  interrupts.CPU47.CAL:Function_call_interrupts
    613313           -35.0%     398878        interrupts.CPU47.LOC:Local_timer_interrupts
      7104 ±  8%     -22.3%       5520 ± 12%  interrupts.CPU47.RES:Rescheduling_interrupts
     15665 ±  4%     -35.7%      10072 ±  2%  interrupts.CPU47.TLB:TLB_shootdowns
    173.50 ± 20%     -43.2%      98.50 ±  2%  interrupts.CPU48.84:IR-PCI-MSI.1572912-edge.eth0-TxRx-48
     17185 ±  2%     -33.8%      11376 ±  3%  interrupts.CPU48.CAL:Function_call_interrupts
    613513           -35.0%     398931        interrupts.CPU48.LOC:Local_timer_interrupts
      6800 ±  2%     -15.0%       5781 ± 14%  interrupts.CPU48.RES:Rescheduling_interrupts
     15359 ±  3%     -35.4%       9923 ±  4%  interrupts.CPU48.TLB:TLB_shootdowns
    153.00 ±  3%     -34.6%     100.00 ±  4%  interrupts.CPU49.85:IR-PCI-MSI.1572913-edge.eth0-TxRx-49
     17198 ±  2%     -33.2%      11492 ±  2%  interrupts.CPU49.CAL:Function_call_interrupts
    613362           -34.9%     399274        interrupts.CPU49.LOC:Local_timer_interrupts
      7370 ± 11%     -25.8%       5471 ± 13%  interrupts.CPU49.RES:Rescheduling_interrupts
     15362 ±  2%     -34.6%      10040 ±  3%  interrupts.CPU49.TLB:TLB_shootdowns
    194.50 ± 13%     -40.2%     116.25 ±  9%  interrupts.CPU5.39:IR-PCI-MSI.1572869-edge.eth0-TxRx-5
     17030           -33.0%      11413 ±  3%  interrupts.CPU5.CAL:Function_call_interrupts
    613317           -34.9%     399142        interrupts.CPU5.LOC:Local_timer_interrupts
      6779           -33.4%       4518        interrupts.CPU5.RES:Rescheduling_interrupts
     15330 ±  2%     -34.1%      10109 ±  4%  interrupts.CPU5.TLB:TLB_shootdowns
    158.00 ±  2%     -35.9%     101.25 ±  6%  interrupts.CPU50.86:IR-PCI-MSI.1572914-edge.eth0-TxRx-50
     17405 ±  2%     -35.2%      11274 ±  2%  interrupts.CPU50.CAL:Function_call_interrupts
    613191           -34.9%     399039        interrupts.CPU50.LOC:Local_timer_interrupts
      7383 ±  9%     -18.7%       5999 ± 19%  interrupts.CPU50.RES:Rescheduling_interrupts
     15544 ±  3%     -36.5%       9867 ±  3%  interrupts.CPU50.TLB:TLB_shootdowns
    150.75           -33.5%     100.25 ±  4%  interrupts.CPU51.87:IR-PCI-MSI.1572915-edge.eth0-TxRx-51
     17259 ±  2%     -33.1%      11553 ±  2%  interrupts.CPU51.CAL:Function_call_interrupts
    613375           -34.9%     399496        interrupts.CPU51.LOC:Local_timer_interrupts
      6891 ±  3%     -21.1%       5437 ± 13%  interrupts.CPU51.RES:Rescheduling_interrupts
     15300 ±  3%     -34.2%      10069 ±  3%  interrupts.CPU51.TLB:TLB_shootdowns
    151.00           -35.3%      97.75        interrupts.CPU52.88:IR-PCI-MSI.1572916-edge.eth0-TxRx-52
     17093 ±  3%     -33.7%      11329 ±  2%  interrupts.CPU52.CAL:Function_call_interrupts
    613320           -34.9%     399031        interrupts.CPU52.LOC:Local_timer_interrupts
     15166 ±  4%     -35.1%       9843 ±  3%  interrupts.CPU52.TLB:TLB_shootdowns
    151.75           -33.9%     100.25 ±  5%  interrupts.CPU53.89:IR-PCI-MSI.1572917-edge.eth0-TxRx-53
     17344 ±  3%     -34.7%      11324 ±  2%  interrupts.CPU53.CAL:Function_call_interrupts
    613471           -34.9%     399086        interrupts.CPU53.LOC:Local_timer_interrupts
      6950 ±  4%     -24.8%       5228 ± 10%  interrupts.CPU53.RES:Rescheduling_interrupts
     15438 ±  5%     -35.4%       9975 ±  2%  interrupts.CPU53.TLB:TLB_shootdowns
    154.00 ±  3%     -34.6%     100.75 ±  3%  interrupts.CPU54.90:IR-PCI-MSI.1572918-edge.eth0-TxRx-54
     17340 ±  2%     -34.7%      11324        interrupts.CPU54.CAL:Function_call_interrupts
    613196           -34.9%     399217        interrupts.CPU54.LOC:Local_timer_interrupts
      6492           -33.3%       4328 ±  3%  interrupts.CPU54.RES:Rescheduling_interrupts
     15378 ±  2%     -36.3%       9801        interrupts.CPU54.TLB:TLB_shootdowns
     17001 ±  2%     -33.7%      11267 ±  2%  interrupts.CPU55.CAL:Function_call_interrupts
    613013           -34.9%     399160        interrupts.CPU55.LOC:Local_timer_interrupts
      6656           -33.2%       4448 ±  2%  interrupts.CPU55.RES:Rescheduling_interrupts
     15001 ±  2%     -33.9%       9919 ±  2%  interrupts.CPU55.TLB:TLB_shootdowns
    152.75           -36.0%      97.75        interrupts.CPU56.92:IR-PCI-MSI.1572920-edge.eth0-TxRx-56
     17235 ±  3%     -34.6%      11275 ±  2%  interrupts.CPU56.CAL:Function_call_interrupts
    613166           -34.8%     399584        interrupts.CPU56.LOC:Local_timer_interrupts
      6635           -35.3%       4291 ±  2%  interrupts.CPU56.RES:Rescheduling_interrupts
     15362 ±  4%     -36.0%       9833 ±  2%  interrupts.CPU56.TLB:TLB_shootdowns
    150.75           -35.2%      97.75        interrupts.CPU57.93:IR-PCI-MSI.1572921-edge.eth0-TxRx-57
     17396 ±  2%     -34.4%      11406 ±  2%  interrupts.CPU57.CAL:Function_call_interrupts
    613238           -34.9%     399281        interrupts.CPU57.LOC:Local_timer_interrupts
      6561           -34.7%       4285 ±  2%  interrupts.CPU57.RES:Rescheduling_interrupts
     15512 ±  3%     -35.4%      10026        interrupts.CPU57.TLB:TLB_shootdowns
    150.25           -34.9%      97.75        interrupts.CPU58.94:IR-PCI-MSI.1572922-edge.eth0-TxRx-58
     17247 ±  2%     -33.7%      11428 ±  2%  interrupts.CPU58.CAL:Function_call_interrupts
    612854           -34.9%     399031        interrupts.CPU58.LOC:Local_timer_interrupts
      6662 ±  3%     -34.4%       4372 ±  2%  interrupts.CPU58.RES:Rescheduling_interrupts
     15258 ±  3%     -33.8%      10107 ±  4%  interrupts.CPU58.TLB:TLB_shootdowns
    152.25           -35.8%      97.75        interrupts.CPU59.95:IR-PCI-MSI.1572923-edge.eth0-TxRx-59
     17107 ±  2%     -33.7%      11340 ±  3%  interrupts.CPU59.CAL:Function_call_interrupts
    613119           -34.9%     399361        interrupts.CPU59.LOC:Local_timer_interrupts
      6641           -34.3%       4366 ±  3%  interrupts.CPU59.RES:Rescheduling_interrupts
     15218 ±  3%     -35.4%       9830 ±  4%  interrupts.CPU59.TLB:TLB_shootdowns
     17106 ±  2%     -33.7%      11334 ±  3%  interrupts.CPU6.CAL:Function_call_interrupts
    613305           -34.9%     399214        interrupts.CPU6.LOC:Local_timer_interrupts
      6993           -33.6%       4641        interrupts.CPU6.RES:Rescheduling_interrupts
     15394 ±  3%     -34.9%      10025 ±  4%  interrupts.CPU6.TLB:TLB_shootdowns
    152.75 ±  2%     -36.0%      97.75        interrupts.CPU60.96:IR-PCI-MSI.1572924-edge.eth0-TxRx-60
     17467 ±  2%     -34.7%      11406 ±  2%  interrupts.CPU60.CAL:Function_call_interrupts
    613388           -34.9%     399057        interrupts.CPU60.LOC:Local_timer_interrupts
      6587           -34.5%       4312        interrupts.CPU60.RES:Rescheduling_interrupts
     15489 ±  2%     -35.9%       9926 ±  4%  interrupts.CPU60.TLB:TLB_shootdowns
    150.75           -34.8%      98.25        interrupts.CPU61.97:IR-PCI-MSI.1572925-edge.eth0-TxRx-61
     17174 ±  2%     -33.1%      11483 ±  3%  interrupts.CPU61.CAL:Function_call_interrupts
    613316           -34.9%     399016        interrupts.CPU61.LOC:Local_timer_interrupts
      6753           -37.2%       4238 ±  2%  interrupts.CPU61.RES:Rescheduling_interrupts
     15229 ±  2%     -34.0%      10052 ±  3%  interrupts.CPU61.TLB:TLB_shootdowns
    151.00           -35.1%      98.00        interrupts.CPU62.98:IR-PCI-MSI.1572926-edge.eth0-TxRx-62
     17516 ±  2%     -33.6%      11626        interrupts.CPU62.CAL:Function_call_interrupts
    613770           -35.0%     399191        interrupts.CPU62.LOC:Local_timer_interrupts
      6545 ±  4%     -35.0%       4258        interrupts.CPU62.RES:Rescheduling_interrupts
     15532 ±  4%     -34.6%      10153 ±  2%  interrupts.CPU62.TLB:TLB_shootdowns
     17679           -34.2%      11638        interrupts.CPU63.CAL:Function_call_interrupts
    613265           -34.9%     399043        interrupts.CPU63.LOC:Local_timer_interrupts
      6529           -34.3%       4289 ±  3%  interrupts.CPU63.RES:Rescheduling_interrupts
     15629 ±  2%     -35.4%      10092        interrupts.CPU63.TLB:TLB_shootdowns
     18420           -34.3%      12099        interrupts.CPU64.CAL:Function_call_interrupts
    613325           -35.0%     398840        interrupts.CPU64.LOC:Local_timer_interrupts
      6841 ±  2%     -36.9%       4315        interrupts.CPU64.RES:Rescheduling_interrupts
     16615           -36.3%      10588        interrupts.CPU64.TLB:TLB_shootdowns
    300.25           -34.7%     196.00        interrupts.CPU65.168:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
     20230           -34.6%      13236        interrupts.CPU65.CAL:Function_call_interrupts
    613229           -34.9%     398907        interrupts.CPU65.LOC:Local_timer_interrupts
      6698           -33.2%       4477 ±  3%  interrupts.CPU65.RES:Rescheduling_interrupts
     18313           -35.8%      11754 ±  2%  interrupts.CPU65.TLB:TLB_shootdowns
     17027 ±  2%     -34.0%      11234 ±  2%  interrupts.CPU66.CAL:Function_call_interrupts
    613528           -35.0%     398760        interrupts.CPU66.LOC:Local_timer_interrupts
      6751 ±  2%     -31.9%       4596 ±  2%  interrupts.CPU66.RES:Rescheduling_interrupts
     15165 ±  2%     -35.1%       9835 ±  2%  interrupts.CPU66.TLB:TLB_shootdowns
     17227 ±  2%     -34.2%      11338 ±  3%  interrupts.CPU67.CAL:Function_call_interrupts
    613109           -34.9%     399428        interrupts.CPU67.LOC:Local_timer_interrupts
      6672           -34.6%       4360 ±  3%  interrupts.CPU67.RES:Rescheduling_interrupts
     15363 ±  2%     -35.5%       9911 ±  3%  interrupts.CPU67.TLB:TLB_shootdowns
     17073 ±  4%     -34.2%      11236 ±  4%  interrupts.CPU68.CAL:Function_call_interrupts
    613025           -34.8%     399505        interrupts.CPU68.LOC:Local_timer_interrupts
      7266 ±  9%     -27.9%       5241 ± 20%  interrupts.CPU68.RES:Rescheduling_interrupts
     15088 ±  5%     -35.2%       9779 ±  4%  interrupts.CPU68.TLB:TLB_shootdowns
     17431 ±  2%     -34.5%      11419 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
    613029           -34.9%     398840        interrupts.CPU69.LOC:Local_timer_interrupts
      6829 ±  6%     -27.3%       4966 ± 18%  interrupts.CPU69.RES:Rescheduling_interrupts
     15503 ±  3%     -35.2%      10039 ±  3%  interrupts.CPU69.TLB:TLB_shootdowns
    313.75 ± 48%     -51.2%     153.00 ± 41%  interrupts.CPU7.41:IR-PCI-MSI.1572871-edge.eth0-TxRx-7
     17180 ±  2%     -34.6%      11241 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
    613068           -34.8%     399495        interrupts.CPU7.LOC:Local_timer_interrupts
      6808 ±  3%     -33.9%       4499 ±  2%  interrupts.CPU7.RES:Rescheduling_interrupts
     15576 ±  4%     -36.5%       9897 ±  3%  interrupts.CPU7.TLB:TLB_shootdowns
     17157 ±  3%     -32.0%      11669 ±  2%  interrupts.CPU70.CAL:Function_call_interrupts
    613420           -35.0%     398835        interrupts.CPU70.LOC:Local_timer_interrupts
      7200 ±  9%     -26.7%       5279 ± 20%  interrupts.CPU70.RES:Rescheduling_interrupts
     15149 ±  4%     -32.7%      10202        interrupts.CPU70.TLB:TLB_shootdowns
     17262 ±  3%     -35.2%      11192 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
    613347           -34.9%     399308        interrupts.CPU71.LOC:Local_timer_interrupts
      6664 ±  5%     -26.8%       4878 ± 12%  interrupts.CPU71.RES:Rescheduling_interrupts
     15261 ±  2%     -35.5%       9848 ±  4%  interrupts.CPU71.TLB:TLB_shootdowns
     16973 ±  3%     -32.5%      11449 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
    613044           -34.9%     398831        interrupts.CPU72.LOC:Local_timer_interrupts
      6953 ±  5%     -22.5%       5388 ± 22%  interrupts.CPU72.RES:Rescheduling_interrupts
     15156 ±  2%     -34.5%       9922 ±  3%  interrupts.CPU72.TLB:TLB_shootdowns
     16935 ±  4%     -33.8%      11209 ±  3%  interrupts.CPU73.CAL:Function_call_interrupts
    613165           -34.9%     398895        interrupts.CPU73.LOC:Local_timer_interrupts
      6883 ±  6%     -23.7%       5255 ± 19%  interrupts.CPU73.RES:Rescheduling_interrupts
     15114 ±  5%     -36.1%       9660 ±  3%  interrupts.CPU73.TLB:TLB_shootdowns
     17073 ±  4%     -34.3%      11210 ±  2%  interrupts.CPU74.CAL:Function_call_interrupts
    612878           -34.9%     399058        interrupts.CPU74.LOC:Local_timer_interrupts
      7117 ±  7%     -27.4%       5170 ± 20%  interrupts.CPU74.RES:Rescheduling_interrupts
     15094 ±  4%     -35.1%       9792 ±  3%  interrupts.CPU74.TLB:TLB_shootdowns
     17094 ±  4%     -33.8%      11312 ±  3%  interrupts.CPU75.CAL:Function_call_interrupts
    613073           -34.9%     399369        interrupts.CPU75.LOC:Local_timer_interrupts
      6853 ±  6%     -29.2%       4854 ± 15%  interrupts.CPU75.RES:Rescheduling_interrupts
     15135 ±  4%     -34.5%       9908 ±  3%  interrupts.CPU75.TLB:TLB_shootdowns
     17122 ±  2%     -34.9%      11145 ±  2%  interrupts.CPU76.CAL:Function_call_interrupts
    613050           -34.9%     398883        interrupts.CPU76.LOC:Local_timer_interrupts
     15173 ±  2%     -36.6%       9625 ±  2%  interrupts.CPU76.TLB:TLB_shootdowns
     17052 ±  3%     -33.7%      11299 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
    613093           -34.9%     399125        interrupts.CPU77.LOC:Local_timer_interrupts
      6560 ±  4%     -22.1%       5111 ± 16%  interrupts.CPU77.RES:Rescheduling_interrupts
     15198 ±  4%     -35.5%       9807 ±  4%  interrupts.CPU77.TLB:TLB_shootdowns
     17139 ±  3%     -34.2%      11277 ±  2%  interrupts.CPU78.CAL:Function_call_interrupts
    612965           -34.9%     398949        interrupts.CPU78.LOC:Local_timer_interrupts
      6482 ±  3%     -23.8%       4940 ± 16%  interrupts.CPU78.RES:Rescheduling_interrupts
     15040 ±  4%     -35.4%       9709 ±  3%  interrupts.CPU78.TLB:TLB_shootdowns
     17151 ±  3%     -34.2%      11285        interrupts.CPU79.CAL:Function_call_interrupts
    613303           -34.9%     399170        interrupts.CPU79.LOC:Local_timer_interrupts
      6341 ±  3%     -20.4%       5049 ± 14%  interrupts.CPU79.RES:Rescheduling_interrupts
     15184 ±  3%     -35.6%       9786 ±  2%  interrupts.CPU79.TLB:TLB_shootdowns
    181.00 ± 13%     -40.7%     107.25 ±  2%  interrupts.CPU8.42:IR-PCI-MSI.1572872-edge.eth0-TxRx-8
     17199 ±  3%     -34.4%      11289 ±  4%  interrupts.CPU8.CAL:Function_call_interrupts
    613751           -34.9%     399458        interrupts.CPU8.LOC:Local_timer_interrupts
      6973 ±  3%     -32.8%       4687 ±  7%  interrupts.CPU8.RES:Rescheduling_interrupts
     15590 ±  3%     -36.0%       9972 ±  4%  interrupts.CPU8.TLB:TLB_shootdowns
     17166 ±  2%     -34.2%      11291 ±  2%  interrupts.CPU80.CAL:Function_call_interrupts
    613399           -35.0%     399004        interrupts.CPU80.LOC:Local_timer_interrupts
      6620 ±  7%     -24.0%       5029 ± 14%  interrupts.CPU80.RES:Rescheduling_interrupts
     15230 ±  2%     -35.1%       9883 ±  4%  interrupts.CPU80.TLB:TLB_shootdowns
     17030 ±  3%     -34.6%      11138        interrupts.CPU81.CAL:Function_call_interrupts
    612912           -34.9%     398899        interrupts.CPU81.LOC:Local_timer_interrupts
      6721 ±  3%     -23.5%       5140 ± 13%  interrupts.CPU81.RES:Rescheduling_interrupts
     15109 ±  3%     -35.6%       9732        interrupts.CPU81.TLB:TLB_shootdowns
     17216 ±  2%     -33.5%      11445        interrupts.CPU82.CAL:Function_call_interrupts
    613178           -34.9%     399124        interrupts.CPU82.LOC:Local_timer_interrupts
      6755 ±  6%     -24.1%       5127 ± 16%  interrupts.CPU82.RES:Rescheduling_interrupts
     15239 ±  4%     -34.6%       9962 ±  3%  interrupts.CPU82.TLB:TLB_shootdowns
     17064 ±  2%     -33.6%      11324 ±  2%  interrupts.CPU83.CAL:Function_call_interrupts
    613016           -34.9%     398830        interrupts.CPU83.LOC:Local_timer_interrupts
      6518 ±  4%     -24.4%       4924 ± 14%  interrupts.CPU83.RES:Rescheduling_interrupts
     14901 ±  4%     -33.8%       9860 ±  2%  interrupts.CPU83.TLB:TLB_shootdowns
     16943 ±  4%     -33.3%      11307 ±  2%  interrupts.CPU84.CAL:Function_call_interrupts
    613118           -35.0%     398825        interrupts.CPU84.LOC:Local_timer_interrupts
      6408           -34.9%       4174 ±  3%  interrupts.CPU84.RES:Rescheduling_interrupts
     15001 ±  5%     -34.2%       9873 ±  5%  interrupts.CPU84.TLB:TLB_shootdowns
     17026 ±  3%     -33.0%      11409 ±  2%  interrupts.CPU85.CAL:Function_call_interrupts
    613015           -34.8%     399382        interrupts.CPU85.LOC:Local_timer_interrupts
      6570 ±  2%     -36.2%       4194 ±  2%  interrupts.CPU85.RES:Rescheduling_interrupts
     15036 ±  3%     -33.9%       9941 ±  3%  interrupts.CPU85.TLB:TLB_shootdowns
     16974 ±  3%     -32.7%      11421 ±  2%  interrupts.CPU86.CAL:Function_call_interrupts
    613071           -34.9%     398943        interrupts.CPU86.LOC:Local_timer_interrupts
      6707 ±  3%     -39.4%       4065        interrupts.CPU86.RES:Rescheduling_interrupts
     14987 ±  4%     -33.4%       9984 ±  2%  interrupts.CPU86.TLB:TLB_shootdowns
     17508 ±  3%     -34.1%      11539 ±  2%  interrupts.CPU87.CAL:Function_call_interrupts
    612946           -34.9%     398784        interrupts.CPU87.LOC:Local_timer_interrupts
      6458           -34.9%       4206 ±  2%  interrupts.CPU87.RES:Rescheduling_interrupts
     15514 ±  3%     -35.0%      10083 ±  3%  interrupts.CPU87.TLB:TLB_shootdowns
    234.25 ± 38%     -46.2%     126.00 ± 15%  interrupts.CPU9.43:IR-PCI-MSI.1572873-edge.eth0-TxRx-9
     17193 ±  2%     -33.8%      11381 ±  3%  interrupts.CPU9.CAL:Function_call_interrupts
    613335           -34.9%     399343        interrupts.CPU9.LOC:Local_timer_interrupts
      6942 ±  2%     -32.9%       4659 ±  5%  interrupts.CPU9.RES:Rescheduling_interrupts
     15489 ±  3%     -35.3%      10023 ±  5%  interrupts.CPU9.TLB:TLB_shootdowns
  53960435           -34.9%   35125153        interrupts.LOC:Local_timer_interrupts
    608241           -31.1%     419265        interrupts.RES:Rescheduling_interrupts
   1348227 ±  3%     -35.0%     876474 ±  2%  interrupts.TLB:TLB_shootdowns



***************************************************************************************************
lkp-bdw-ex2: 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2018-04-03.cgz/300s/16G/lkp-bdw-ex2/shm-pread-rand/vm-scalability/0xb00002e

commit: 
  8055fb607e ("vfs: Convert smackfs to fs_context")
  9d65ac8a35 ("tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context")

8055fb607ebc82ea 9d65ac8a35a75c7334cfa0f8552 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    215.00 ±  6%     -57.5%      91.46        vm-scalability.free_time
    114519           -40.5%      68132        vm-scalability.median
  21956336           -40.4%   13080254        vm-scalability.throughput
    562.26 ±  2%     -26.2%     414.68        vm-scalability.time.elapsed_time
    562.26 ±  2%     -26.2%     414.68        vm-scalability.time.elapsed_time.max
    243763 ±  3%     -24.7%     183433 ±  3%  vm-scalability.time.involuntary_context_switches
 2.476e+08           -50.0%  1.238e+08        vm-scalability.time.maximum_resident_set_size
 9.302e+08           -50.0%  4.651e+08        vm-scalability.time.minor_page_faults
     17588            +3.0%      18124        vm-scalability.time.percent_of_cpu_this_job_got
     66031 ±  4%     -55.3%      29529 ±  2%  vm-scalability.time.system_time
     32874           +38.8%      45629        vm-scalability.time.user_time
 6.598e+09           -40.4%  3.929e+09        vm-scalability.workload
 2.271e+08 ±160%     -96.1%    8752847 ±134%  cpuidle.C1E.time
   2191304 ±160%     -96.6%      73511 ±118%  cpuidle.C1E.usage
      8.46 ±  4%      -2.8        5.70 ±  3%  mpstat.cpu.all.idle%
     61.08           -24.0       37.06 ±  2%  mpstat.cpu.all.sys%
     30.46 ±  2%     +26.8       57.24        mpstat.cpu.all.usr%
      2379            +2.9%       2448        turbostat.Avg_MHz
   2187139 ±161%     -96.7%      71800 ±121%  turbostat.C1E
 2.084e+08 ±  5%     -23.2%    1.6e+08 ±  3%  turbostat.IRQ
      3.76 ±  8%     -35.2%       2.44 ± 11%  turbostat.Pkg%pc2
     49.49           +13.7%      56.25        turbostat.RAMWatt
     60.50           -39.7%      36.50 ±  2%  vmstat.cpu.sy
     30.00 ±  2%     +88.3%      56.50        vmstat.cpu.us
 2.176e+08           -47.3%  1.148e+08        vmstat.memory.cache
 1.955e+08           +72.4%  3.369e+08        vmstat.memory.free
      1731            -7.7%       1598        vmstat.system.cs
      5172 ±  9%     +18.9%       6147 ±  7%  slabinfo.kmalloc-rcl-64.active_objs
      5172 ±  9%     +18.9%       6147 ±  7%  slabinfo.kmalloc-rcl-64.num_objs
      2256 ±  2%     +80.7%       4077 ± 24%  slabinfo.pool_workqueue.active_objs
      2339 ±  2%     +77.8%       4160 ± 23%  slabinfo.pool_workqueue.num_objs
    953219           -48.1%     495186        slabinfo.radix_tree_node.active_objs
     17762           -48.8%       9086        slabinfo.radix_tree_node.active_slabs
    994715           -48.8%     508833        slabinfo.radix_tree_node.num_objs
     17762           -48.8%       9086        slabinfo.radix_tree_node.num_slabs
  21827780 ±  2%     -49.2%   11094619        numa-numastat.node0.local_node
  21836923 ±  2%     -49.1%   11111700        numa-numastat.node0.numa_hit
   5144327 ±  7%    -100.0%       0.00        numa-numastat.node0.numa_miss
   5153471 ±  7%     -99.7%      17082 ± 15%  numa-numastat.node0.other_node
  21688031           -50.9%   10645806        numa-numastat.node1.local_node
  21702081           -50.9%   10664473        numa-numastat.node1.numa_hit
  21521849           -50.2%   10714943        numa-numastat.node2.local_node
  21540579           -50.2%   10725912        numa-numastat.node2.numa_hit
  16542134           -31.6%   11315887        numa-numastat.node3.local_node
   5144327 ±  7%    -100.0%       0.00        numa-numastat.node3.numa_foreign
  16556145           -31.6%   11325232        numa-numastat.node3.numa_hit
  56607469 ±  4%     -69.7%   17172207        meminfo.Active
  56607225 ±  4%     -69.7%   17171908        meminfo.Active(anon)
 2.171e+08           -47.3%  1.144e+08        meminfo.Cached
     68155 ± 28%    +188.9%     196900        meminfo.CmaFree
 2.267e+08           -48.6%  1.164e+08        meminfo.Committed_AS
 1.595e+08           -39.7%   96248802        meminfo.Inactive
 1.595e+08           -39.7%   96247436        meminfo.Inactive(anon)
    655863           -42.3%     378738        meminfo.KReclaimable
 1.593e+08           -39.7%   96010805        meminfo.Mapped
 1.941e+08           +72.9%  3.355e+08        meminfo.MemAvailable
 1.954e+08           +72.4%  3.369e+08        meminfo.MemFree
 2.998e+08           -47.2%  1.582e+08        meminfo.Memused
      1488 ± 31%     -39.2%     904.50 ± 61%  meminfo.Mlocked
  80775082           -47.6%   42297345        meminfo.PageTables
    655863           -42.3%     378738        meminfo.SReclaimable
 2.159e+08           -47.6%  1.132e+08        meminfo.Shmem
    884970           -31.5%     606435        meminfo.Slab
    629206 ±  2%     -31.4%     431746        meminfo.max_used_kB
    346175 ±  4%    -100.0%       0.00        proc-vmstat.compact_daemon_free_scanned
    346175 ±  4%    -100.0%       0.00        proc-vmstat.compact_free_scanned
    570.00 ± 62%    -100.0%       0.00        proc-vmstat.compact_isolated
  14103663 ±  5%     -69.7%    4275680        proc-vmstat.nr_active_anon
   4841612           +72.8%    8368661        proc-vmstat.nr_dirty_background_threshold
   9695080           +72.8%   16757792        proc-vmstat.nr_dirty_threshold
  54241834           -47.3%   28609921        proc-vmstat.nr_file_pages
     17063 ± 28%    +188.5%      49225        proc-vmstat.nr_free_cma
  48899002           +72.2%   84221154        proc-vmstat.nr_free_pages
  39893226           -39.6%   24091372        proc-vmstat.nr_inactive_anon
  39833592           -39.7%   24032103        proc-vmstat.nr_mapped
    371.75 ± 31%     -39.4%     225.25 ± 61%  proc-vmstat.nr_mlock
  20181469           -47.6%   10577257        proc-vmstat.nr_page_table_pages
  53934410           -47.5%   28304267        proc-vmstat.nr_shmem
    163883           -42.2%      94716        proc-vmstat.nr_slab_reclaimable
  14103663 ±  5%     -69.7%    4275680        proc-vmstat.nr_zone_active_anon
  39893226           -39.6%   24091372        proc-vmstat.nr_zone_inactive_anon
   5144327 ±  7%    -100.0%       0.00        proc-vmstat.numa_foreign
    795.75 ± 64%     -57.6%     337.75 ± 37%  proc-vmstat.numa_hint_faults_local
  81660157           -46.3%   43850512        proc-vmstat.numa_hit
  81604218           -46.3%   43794445        proc-vmstat.numa_local
   5144327 ±  7%    -100.0%       0.00        proc-vmstat.numa_miss
   5200265 ±  7%     -98.9%      56067        proc-vmstat.numa_other
     46220 ± 13%     +29.0%      59622 ± 20%  proc-vmstat.numa_pte_updates
  61922169           -50.0%   30971532        proc-vmstat.pgactivate
  87033754           -49.4%   44002601        proc-vmstat.pgalloc_normal
 9.321e+08           -50.0%  4.665e+08        proc-vmstat.pgfault
  86980887           -49.6%   43814302        proc-vmstat.pgfree
      3767 ±154%    -100.0%       0.00        proc-vmstat.slabs_scanned
  50357480 ±  5%     -27.4%   36579520        sched_debug.cfs_rq:/.min_vruntime.avg
  50560150 ±  5%     -27.4%   36730022        sched_debug.cfs_rq:/.min_vruntime.max
  44524469 ±  5%     -23.4%   34123234        sched_debug.cfs_rq:/.min_vruntime.min
    590148 ± 10%     -57.1%     253421 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
     81.25 ± 57%     +76.9%     143.71        sched_debug.cfs_rq:/.removed.load_avg.max
      3747 ± 57%     +77.5%       6653        sched_debug.cfs_rq:/.removed.runnable_sum.max
     35.17 ± 64%     +94.5%      68.39 ± 10%  sched_debug.cfs_rq:/.removed.util_avg.max
    589754 ± 10%     -57.1%     252737 ±  5%  sched_debug.cfs_rq:/.spread0.stddev
      4.53 ± 59%     -81.1%       0.86        sched_debug.cfs_rq:/.util_est_enqueued.min
    235963 ± 28%     +75.9%     415151 ±  6%  sched_debug.cpu.avg_idle.min
    303930 ±  4%     -22.1%     236626        sched_debug.cpu.clock.avg
    303960 ±  4%     -22.1%     236658        sched_debug.cpu.clock.max
    303901 ±  4%     -22.1%     236595        sched_debug.cpu.clock.min
    303930 ±  4%     -22.1%     236626        sched_debug.cpu.clock_task.avg
    303960 ±  4%     -22.1%     236658        sched_debug.cpu.clock_task.max
    303901 ±  4%     -22.1%     236595        sched_debug.cpu.clock_task.min
     96.87 ±122%     -76.6%      22.68 ± 74%  sched_debug.cpu.cpu_load[1].max
     96.93 ±120%     -76.1%      23.18 ± 61%  sched_debug.cpu.cpu_load[2].max
     15.84 ±150%     -89.5%       1.66 ± 58%  sched_debug.cpu.cpu_load[2].stddev
    111.17 ±103%     -73.4%      29.54 ± 14%  sched_debug.cpu.cpu_load[4].max
     16.80 ±142%     -87.9%       2.03 ± 18%  sched_debug.cpu.cpu_load[4].stddev
      9877 ±  6%     -19.5%       7948 ±  3%  sched_debug.cpu.curr->pid.max
    584.07 ±  7%     -23.1%     448.87 ±  5%  sched_debug.cpu.curr->pid.stddev
    254169 ±  5%     -26.4%     187119        sched_debug.cpu.nr_load_updates.avg
    262340 ±  5%     -25.8%     194755        sched_debug.cpu.nr_load_updates.max
    252688 ±  5%     -26.5%     185657        sched_debug.cpu.nr_load_updates.min
      2718 ±  5%     -25.6%       2022        sched_debug.cpu.nr_switches.avg
     59267 ±  5%     -54.5%      26985 ± 18%  sched_debug.cpu.nr_switches.max
    668.49           -33.8%     442.32 ±  2%  sched_debug.cpu.nr_switches.min
      5785 ±  9%     -48.6%       2976 ±  9%  sched_debug.cpu.nr_switches.stddev
    303901 ±  4%     -22.1%     236595        sched_debug.cpu_clk
    298715 ±  4%     -22.5%     231407        sched_debug.ktime
      2.55 ±  2%     -15.3%       2.16        sched_debug.rt_rq:/.rt_runtime.stddev
    309168 ±  4%     -21.8%     241862        sched_debug.sched_clk
  18471535 ±  5%     -77.0%    4241496 ±  2%  numa-meminfo.node0.Active
  18471412 ±  5%     -77.0%    4241496 ±  2%  numa-meminfo.node0.Active(anon)
     45316 ± 83%     -83.9%       7279 ±169%  numa-meminfo.node0.AnonHugePages
  69167055           -58.7%   28537182        numa-meminfo.node0.FilePages
  50441137           -52.4%   24013491        numa-meminfo.node0.Inactive
  50440681           -52.4%   24013432        numa-meminfo.node0.Inactive(anon)
    175696 ± 16%     -33.9%     116201 ± 21%  numa-meminfo.node0.KReclaimable
  50371492           -52.5%   23946772        numa-meminfo.node0.Mapped
  41199474 ±  2%    +124.0%   92268263        numa-meminfo.node0.MemFree
  90697497           -56.3%   39648428        numa-meminfo.node0.MemUsed
  20892011           -49.3%   10586665        numa-meminfo.node0.PageTables
    175696 ± 16%     -33.9%     116201 ± 21%  numa-meminfo.node0.SReclaimable
  68851086           -59.0%   28236379        numa-meminfo.node0.Shmem
    315510 ±  5%      -4.7%     300790        numa-meminfo.node0.Unevictable
  14364208 ±  4%     -70.7%    4203376        numa-meminfo.node1.Active
  14364116 ±  4%     -70.7%    4203357        numa-meminfo.node1.Active(anon)
  54786209           -48.6%   28143332        numa-meminfo.node1.FilePages
  40191119 ±  2%     -41.1%   23668090        numa-meminfo.node1.Inactive
  40190539 ±  2%     -41.1%   23667849        numa-meminfo.node1.Inactive(anon)
    172189 ± 12%     -67.2%      56471 ±  9%  numa-meminfo.node1.KReclaimable
  40076004           -40.9%   23670206        numa-meminfo.node1.Mapped
  23566368 ±  2%    +156.0%   60331290        numa-meminfo.node1.MemFree
  75508237           -48.7%   38730169        numa-meminfo.node1.MemUsed
  20255361           -48.9%   10354337        numa-meminfo.node1.PageTables
    172189 ± 12%     -67.2%      56471 ±  9%  numa-meminfo.node1.SReclaimable
  54478406           -48.9%   27844350        numa-meminfo.node1.Shmem
    227127 ± 12%     -55.3%     101579 ±  8%  numa-meminfo.node1.Slab
  14137268 ±  5%     -69.3%    4335736        numa-meminfo.node2.Active
  14137268 ±  5%     -69.3%    4335664        numa-meminfo.node2.Active(anon)
  53846613           -47.3%   28403150        numa-meminfo.node2.FilePages
  39490579           -39.6%   23864915        numa-meminfo.node2.Inactive
  39490577           -39.6%   23864569        numa-meminfo.node2.Inactive(anon)
    140893 ± 11%     -44.2%      78596 ± 32%  numa-meminfo.node2.KReclaimable
  39492831           -39.6%   23867473        numa-meminfo.node2.Mapped
 1.239e+08           +28.3%  1.589e+08        numa-meminfo.node2.MemFree
  74275591           -47.2%   39218377        numa-meminfo.node2.MemUsed
  20036743           -47.7%   10479351        numa-meminfo.node2.PageTables
    140893 ± 11%     -44.2%      78596 ± 32%  numa-meminfo.node2.SReclaimable
  53547614           -47.5%   28100479        numa-meminfo.node2.Shmem
    188330 ± 11%     -34.7%     122900 ± 26%  numa-meminfo.node2.Slab
   9814197 ±  4%     -54.8%    4433185        numa-meminfo.node3.Active
   9814168 ±  4%     -54.8%    4432977        numa-meminfo.node3.Active(anon)
  38885936           -24.9%   29201047        numa-meminfo.node3.FilePages
  28797354           -14.7%   24554479        numa-meminfo.node3.Inactive
  28797285           -14.7%   24553758        numa-meminfo.node3.Inactive(anon)
  28739603           -15.2%   24378346        numa-meminfo.node3.Mapped
   7415082 ±  4%    +245.2%   25598601        numa-meminfo.node3.MemFree
  58633632           -31.0%   40450113        numa-meminfo.node3.MemUsed
  19344684           -44.3%   10783400        numa-meminfo.node3.PageTables
     45389 ± 15%     +37.2%      62274 ±  5%  numa-meminfo.node3.SUnreclaim
  38579011           -25.1%   28880887        numa-meminfo.node3.Shmem
     16.01           +44.7%      23.15 ±  2%  perf-stat.i.MPKI
 1.919e+10           -17.3%  1.586e+10        perf-stat.i.branch-instructions
  30643400 ±  3%     -27.7%   22140532 ±  2%  perf-stat.i.branch-misses
     53.75            +7.8       61.51        perf-stat.i.cache-miss-rate%
 5.552e+08 ±  2%     +44.4%  8.019e+08 ±  2%  perf-stat.i.cache-misses
  7.87e+08 ±  2%     +42.9%  1.124e+09 ±  2%  perf-stat.i.cache-references
      1685            -8.5%       1542        perf-stat.i.context-switches
      6.39           +23.8%       7.91        perf-stat.i.cpi
 4.532e+11            +3.2%  4.677e+11        perf-stat.i.cpu-cycles
     35.20           +12.3%      39.54        perf-stat.i.cpu-migrations
      2347 ±  5%     -36.1%       1499 ±  6%  perf-stat.i.cycles-between-cache-misses
      2.07 ±  2%      +1.3        3.37        perf-stat.i.dTLB-load-miss-rate%
 3.278e+08 ±  2%     +55.0%  5.079e+08 ±  2%  perf-stat.i.dTLB-load-misses
 2.133e+10           -14.1%  1.832e+10        perf-stat.i.dTLB-loads
 3.629e+09 ±  2%     +18.2%  4.291e+09        perf-stat.i.dTLB-stores
     82.40 ±  3%      +4.4       86.76        perf-stat.i.iTLB-load-miss-rate%
   3768060 ±  3%     -23.6%    2880473 ±  9%  perf-stat.i.iTLB-load-misses
 8.048e+10           -16.5%  6.722e+10        perf-stat.i.instructions
    476164 ± 21%     -22.8%     367493 ± 13%  perf-stat.i.instructions-per-iTLB-miss
      0.18           -19.1%       0.15        perf-stat.i.ipc
   1685065           -33.5%    1120936        perf-stat.i.minor-faults
     70.03           -11.7       58.35        perf-stat.i.node-load-miss-rate%
 2.147e+08 ±  2%     +50.7%  3.235e+08        perf-stat.i.node-load-misses
 2.767e+08 ±  4%     +57.7%  4.365e+08 ±  5%  perf-stat.i.node-loads
     56.11 ±  2%      -6.8       49.31 ±  3%  perf-stat.i.node-store-miss-rate%
  17332505 ±  4%     -29.8%   12161421        perf-stat.i.node-store-misses
   5218571 ±  3%     -32.7%    3514411        perf-stat.i.node-stores
   1685239           -33.5%    1121158        perf-stat.i.page-faults
      9.29 ±  3%     +72.7%      16.04 ±  2%  perf-stat.overall.MPKI
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-stat.overall.branch-miss-rate%
     69.96            +1.1       71.07        perf-stat.overall.cache-miss-rate%
      5.56           +23.1%       6.84        perf-stat.overall.cpi
    855.85 ±  3%     -29.9%     600.33 ±  2%  perf-stat.overall.cycles-between-cache-misses
      1.43 ±  4%      +1.2        2.58 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.18           -18.8%       0.15        perf-stat.overall.ipc
 1.953e+10           -17.4%  1.614e+10        perf-stat.ps.branch-instructions
  30805276 ±  3%     -27.0%   22503111 ±  2%  perf-stat.ps.branch-misses
 5.312e+08 ±  3%     +46.5%  7.784e+08 ±  3%  perf-stat.ps.cache-misses
 7.592e+08 ±  2%     +44.3%  1.095e+09 ±  2%  perf-stat.ps.cache-references
      1690            -8.4%       1548        perf-stat.ps.context-switches
 4.541e+11            +2.8%  4.669e+11        perf-stat.ps.cpu-cycles
     35.44           +12.2%      39.76        perf-stat.ps.cpu-migrations
 3.126e+08 ±  3%     +57.3%  4.918e+08 ±  2%  perf-stat.ps.dTLB-load-misses
  2.16e+10           -14.2%  1.854e+10        perf-stat.ps.dTLB-loads
 3.525e+09 ±  2%     +19.2%  4.204e+09        perf-stat.ps.dTLB-stores
   3719883 ±  3%     -22.2%    2895285 ±  9%  perf-stat.ps.iTLB-load-misses
 8.174e+10           -16.5%  6.826e+10        perf-stat.ps.instructions
   1656530 ±  2%     -32.2%    1123747        perf-stat.ps.minor-faults
  2.06e+08 ±  2%     +52.6%  3.142e+08        perf-stat.ps.node-load-misses
 2.622e+08 ±  4%     +60.9%   4.22e+08 ±  5%  perf-stat.ps.node-loads
  17222639 ±  4%     -28.9%   12250027        perf-stat.ps.node-store-misses
   5214549 ±  3%     -31.6%    3566921        perf-stat.ps.node-stores
   1656530 ±  2%     -32.2%    1123747        perf-stat.ps.page-faults
 4.603e+13 ±  3%     -38.4%  2.834e+13        perf-stat.total.instructions
   4608245 ±  5%     -76.9%    1063287 ±  2%  numa-vmstat.node0.nr_active_anon
  17297000           -58.8%    7131761        numa-vmstat.node0.nr_file_pages
  10294951 ±  2%    +124.1%   23070382        numa-vmstat.node0.nr_free_pages
  12625019           -52.5%    5997916        numa-vmstat.node0.nr_inactive_anon
    113.50 ± 75%     -87.2%      14.50 ±165%  numa-vmstat.node0.nr_inactive_file
  12607751           -52.6%    5981237        numa-vmstat.node0.nr_mapped
   5222723           -49.3%    2645940        numa-vmstat.node0.nr_page_table_pages
  17218007           -59.0%    7056560        numa-vmstat.node0.nr_shmem
     43945 ± 17%     -33.9%      29046 ± 21%  numa-vmstat.node0.nr_slab_reclaimable
     78877 ±  5%      -4.7%      75197        numa-vmstat.node0.nr_unevictable
   4608244 ±  5%     -76.9%    1063286 ±  2%  numa-vmstat.node0.nr_zone_active_anon
  12625019           -52.5%    5997917        numa-vmstat.node0.nr_zone_inactive_anon
    113.50 ± 75%     -87.2%      14.50 ±165%  numa-vmstat.node0.nr_zone_inactive_file
     78877 ±  5%      -4.7%      75197        numa-vmstat.node0.nr_zone_unevictable
  20496209           -47.2%   10820663        numa-vmstat.node0.numa_hit
  20485842           -47.3%   10802835        numa-vmstat.node0.numa_local
   4355055 ±  7%    -100.0%       0.00        numa-vmstat.node0.numa_miss
   4365424 ±  7%     -99.6%      17829 ± 17%  numa-vmstat.node0.numa_other
   3583662 ±  4%     -70.6%    1053714        numa-vmstat.node1.nr_active_anon
  13700707           -48.7%    7033341        numa-vmstat.node1.nr_file_pages
   5886203 ±  2%    +156.3%   15086088        numa-vmstat.node1.nr_free_pages
  10059153 ±  2%     -41.2%    5911596        numa-vmstat.node1.nr_inactive_anon
  10030599           -41.1%    5912140        numa-vmstat.node1.nr_mapped
   5065074           -48.9%    2587895        numa-vmstat.node1.nr_page_table_pages
  13623756           -48.9%    6958596        numa-vmstat.node1.nr_shmem
     43066 ± 12%     -67.2%      14114 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
   3583661 ±  4%     -70.6%    1053713        numa-vmstat.node1.nr_zone_active_anon
  10059153 ±  2%     -41.2%    5911596        numa-vmstat.node1.nr_zone_inactive_anon
  20377141           -49.2%   10344159        numa-vmstat.node1.numa_hit
  20266558           -49.5%   10229369        numa-vmstat.node1.numa_local
   3527033 ±  5%     -69.2%    1086778        numa-vmstat.node2.nr_active_anon
  13465915           -47.3%    7098298        numa-vmstat.node2.nr_file_pages
  30968456           +28.3%   39739868        numa-vmstat.node2.nr_free_pages
   9884179           -39.7%    5960783        numa-vmstat.node2.nr_inactive_anon
   9884755           -39.7%    5961458        numa-vmstat.node2.nr_mapped
     97.75 ± 52%     -51.7%      47.25 ± 59%  numa-vmstat.node2.nr_mlock
   5010526           -47.7%    2619130        numa-vmstat.node2.nr_page_table_pages
  13391165           -47.6%    7022630        numa-vmstat.node2.nr_shmem
     35241 ± 11%     -44.3%      19645 ± 32%  numa-vmstat.node2.nr_slab_reclaimable
   3527031 ±  5%     -69.2%    1086777        numa-vmstat.node2.nr_zone_active_anon
   9884180           -39.7%    5960783        numa-vmstat.node2.nr_zone_inactive_anon
  20161532           -48.2%   10447582        numa-vmstat.node2.numa_hit
  20046512           -48.4%   10340782 ±  2%  numa-vmstat.node2.numa_local
   2448498 ±  4%     -54.6%    1111165        numa-vmstat.node3.nr_active_anon
   9724748           -25.0%    7297701        numa-vmstat.node3.nr_file_pages
     17049 ± 28%    +188.7%      49225        numa-vmstat.node3.nr_free_cma
   1849256 ±  5%    +246.3%    6403109        numa-vmstat.node3.nr_free_pages
   7207631           -14.9%    6132959        numa-vmstat.node3.nr_inactive_anon
   7193198           -15.3%    6089173        numa-vmstat.node3.nr_mapped
   4837484           -44.3%    2695110        numa-vmstat.node3.nr_page_table_pages
   9648017           -25.2%    7217661        numa-vmstat.node3.nr_shmem
     11347 ± 15%     +37.2%      15568 ±  5%  numa-vmstat.node3.nr_slab_unreclaimable
   2448498 ±  4%     -54.6%    1111165        numa-vmstat.node3.nr_zone_active_anon
   7207633           -14.9%    6132959        numa-vmstat.node3.nr_zone_inactive_anon
   4355515 ±  7%    -100.0%       0.00        numa-vmstat.node3.numa_foreign
  15875416           -31.8%   10829284        numa-vmstat.node3.numa_hit
  15765227           -32.0%   10724232        numa-vmstat.node3.numa_local
     80.75           -79.3        1.45 ± 32%  perf-profile.calltrace.cycles-pp.page_fault
     80.62           -79.2        1.45 ± 32%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
     79.91           -78.5        1.41 ± 32%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
     76.84           -75.7        1.18 ± 31%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
     75.72           -74.6        1.10 ± 31%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
     73.06           -72.3        0.73 ± 62%  perf-profile.calltrace.cycles-pp.filemap_map_pages.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
     13.91 ±  3%     -13.9        0.00        perf-profile.calltrace.cycles-pp.xas_find.filemap_map_pages.__handle_mm_fault.handle_mm_fault.__do_page_fault
     13.02 ±  2%     -13.0        0.00        perf-profile.calltrace.cycles-pp.xas_load.xas_find.filemap_map_pages.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_next_event_base.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +0.6        0.57 ±  3%  perf-profile.calltrace.cycles-pp.account_entity_dequeue.reweight_entity.task_tick_fair.scheduler_tick.update_process_times
      0.00            +0.6        0.61 ± 10%  perf-profile.calltrace.cycles-pp.tick_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +0.7        0.68 ± 11%  perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.00            +0.8        0.77 ± 13%  perf-profile.calltrace.cycles-pp.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.8        0.78 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.8        0.78 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.8        0.78 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.8        0.78 ± 12%  perf-profile.calltrace.cycles-pp.execve
      0.00            +0.8        0.78 ± 22%  perf-profile.calltrace.cycles-pp.note_gp_changes.rcu_core.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt
      0.00            +0.8        0.79 ± 20%  perf-profile.calltrace.cycles-pp.perf_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.89 ± 23%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__read_nocancel
      0.00            +0.9        0.91 ±  8%  perf-profile.calltrace.cycles-pp.read_tsc.ktime_get_update_offsets_now.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.00            +0.9        0.92 ± 28%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.94 ± 26%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.95 ± 23%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__read_nocancel.perf_evsel__read_counter
      0.00            +1.0        0.95 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__read_nocancel.perf_evsel__read_counter.read_counters
      0.00            +1.0        0.96 ± 23%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__read_nocancel.perf_evsel__read_counter.read_counters.process_interval
      0.00            +1.0        1.02 ± 25%  perf-profile.calltrace.cycles-pp.__read_nocancel.perf_evsel__read_counter.read_counters.process_interval.__run_perf_stat
      0.00            +1.0        1.02 ± 15%  perf-profile.calltrace.cycles-pp.native_write_msr.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.0        1.03 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +1.0        1.03 ± 17%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
      0.00            +1.0        1.05 ± 16%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +1.1        1.06 ± 11%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +1.1        1.07 ± 17%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +1.1        1.08 ± 16%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.08 ±  7%  perf-profile.calltrace.cycles-pp.rcu_irq_enter.irq_enter.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +1.1        1.11 ± 17%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +1.1        1.12 ± 12%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.00            +1.1        1.13 ± 20%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.record__pushfn
      0.00            +1.1        1.15 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.record__pushfn.perf_mmap__push
      0.00            +1.1        1.15 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.00            +1.2        1.23 ± 21%  perf-profile.calltrace.cycles-pp.__libc_write.record__pushfn.perf_mmap__push.record__mmap_read_evlist.cmd_record
      0.00            +1.2        1.23 ± 19%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +1.2        1.23 ± 19%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +1.2        1.24 ± 21%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin
      0.00            +1.2        1.25 ± 11%  perf-profile.calltrace.cycles-pp.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
      0.00            +1.3        1.30 ±  8%  perf-profile.calltrace.cycles-pp.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +1.4        1.35 ± 10%  perf-profile.calltrace.cycles-pp.timerqueue_del.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.00            +1.5        1.48 ±  8%  perf-profile.calltrace.cycles-pp.reweight_entity.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +1.5        1.51 ± 27%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin.main
      0.00            +1.5        1.52 ± 16%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +1.5        1.54 ± 10%  perf-profile.calltrace.cycles-pp.update_cfs_group.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +1.6        1.57 ± 27%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.run_builtin.main.generic_start_main
      0.00            +1.7        1.66 ±  5%  perf-profile.calltrace.cycles-pp.run_timer_softirq.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +1.7        1.70 ±  4%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +1.8        1.81 ± 11%  perf-profile.calltrace.cycles-pp.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +1.8        1.82 ± 38%  perf-profile.calltrace.cycles-pp.ktime_get.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.00            +1.8        1.84 ±  3%  perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +1.9        1.88 ± 25%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.generic_start_main.__strcspn_sse42
      0.00            +1.9        1.94 ±  7%  perf-profile.calltrace.cycles-pp.__update_load_avg_se.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +2.0        1.99 ± 10%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi_write.smp_apic_timer_interrupt.apic_timer_interrupt
      2.86 ±  2%      +2.1        4.94 ±  5%  perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.00            +2.3        2.32 ± 10%  perf-profile.calltrace.cycles-pp.irq_enter.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +2.3        2.34 ± 16%  perf-profile.calltrace.cycles-pp.__strcspn_sse42
      0.00            +2.3        2.34 ± 16%  perf-profile.calltrace.cycles-pp.generic_start_main.__strcspn_sse42
      0.00            +2.3        2.34 ± 16%  perf-profile.calltrace.cycles-pp.main.generic_start_main.__strcspn_sse42
      0.00            +2.3        2.34 ± 16%  perf-profile.calltrace.cycles-pp.run_builtin.main.generic_start_main.__strcspn_sse42
      0.00            +2.4        2.35 ±  8%  perf-profile.calltrace.cycles-pp.native_write_msr.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt
      0.00            +2.6        2.63 ± 12%  perf-profile.calltrace.cycles-pp.hrtimer_active.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +2.7        2.67 ± 14%  perf-profile.calltrace.cycles-pp.account_user_time.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +2.7        2.72 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.28 ±100%      +2.7        3.00 ± 15%  perf-profile.calltrace.cycles-pp.run_local_timers.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +3.2        3.17 ± 11%  perf-profile.calltrace.cycles-pp.interrupt_entry.apic_timer_interrupt
      0.13 ±173%      +3.3        3.39 ±  6%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.64 ±  5%      +3.6        4.28 ± 18%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.40 ± 57%      +4.1        4.48 ± 16%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.70 ±  8%      +4.1        4.82 ± 14%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +4.2        4.20 ± 12%  perf-profile.calltrace.cycles-pp.interrupt_entry
      0.50 ± 57%      +5.1        5.55 ± 11%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.56 ±100%      +5.6        6.18 ± 14%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      1.22 ± 36%      +8.7        9.95 ±  8%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      1.98 ± 14%     +13.5       15.46 ±  4%  perf-profile.calltrace.cycles-pp.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      2.50 ± 16%     +17.3       19.75 ±  4%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      3.71 ± 14%     +25.2       28.93 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      3.75 ± 14%     +25.4       29.17 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      4.12 ± 15%     +28.0       32.13 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      5.44 ± 10%     +36.5       41.96 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      7.87 ± 12%     +52.8       60.66 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      9.07 ± 11%     +63.9       72.98 ±  2%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt
      9.49 ± 11%     +66.8       76.26 ±  3%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt
     29145 ±  6%     +24.4%      36253 ± 11%  softirqs.CPU0.RCU
    217767 ±  2%     -27.4%     158118        softirqs.CPU0.TIMER
      9218 ±  7%     -37.1%       5801 ±  4%  softirqs.CPU1.SCHED
    216877           -27.2%     157841 ±  2%  softirqs.CPU1.TIMER
     29224 ±  4%     +22.7%      35849 ±  9%  softirqs.CPU10.RCU
    212823           -27.2%     154948        softirqs.CPU10.TIMER
     28608 ±  2%     +24.4%      35592 ± 11%  softirqs.CPU100.RCU
      9960 ±  9%     -44.3%       5547 ±  2%  softirqs.CPU100.SCHED
    217762 ±  3%     -28.2%     156358 ±  2%  softirqs.CPU100.TIMER
     28221 ±  3%     +25.9%      35543 ±  7%  softirqs.CPU101.RCU
     10030 ±  9%     -44.8%       5531 ±  3%  softirqs.CPU101.SCHED
    213330 ±  2%     -27.1%     155497 ±  2%  softirqs.CPU101.TIMER
     30729 ±  6%     +18.2%      36319 ±  9%  softirqs.CPU102.RCU
    211774 ±  2%     -25.5%     157669 ±  2%  softirqs.CPU102.TIMER
     30529 ±  3%     +21.0%      36927 ±  8%  softirqs.CPU103.RCU
    216947 ±  2%     -25.8%     161011 ±  4%  softirqs.CPU103.TIMER
     30213 ±  3%     +20.0%      36247 ±  8%  softirqs.CPU104.RCU
    213075           -26.9%     155812        softirqs.CPU104.TIMER
    209569           -26.6%     153886        softirqs.CPU105.TIMER
     29186 ±  4%     +18.5%      34574 ±  8%  softirqs.CPU106.RCU
    211805           -27.3%     154034        softirqs.CPU106.TIMER
     28524 ±  4%     +23.1%      35122 ±  8%  softirqs.CPU107.RCU
    210468           -26.9%     153951        softirqs.CPU107.TIMER
     27750 ±  4%     +30.7%      36259 ± 11%  softirqs.CPU108.RCU
    210616           -26.2%     155349        softirqs.CPU108.TIMER
    211359           -26.7%     154900        softirqs.CPU109.TIMER
     27937 ±  2%     +29.2%      36106 ±  8%  softirqs.CPU11.RCU
    211910           -26.4%     155958        softirqs.CPU11.TIMER
     28330 ±  5%     +23.2%      34909 ±  9%  softirqs.CPU110.RCU
    209875 ±  2%     -26.6%     154082        softirqs.CPU110.TIMER
     29845           +24.7%      37207 ± 10%  softirqs.CPU111.RCU
    215365           -26.6%     158058        softirqs.CPU111.TIMER
     28227 ±  4%     +18.5%      33462 ±  9%  softirqs.CPU112.RCU
    212386           -26.0%     157093        softirqs.CPU112.TIMER
     28294 ±  3%     +20.8%      34173 ±  7%  softirqs.CPU113.RCU
    214104 ±  2%     -26.5%     157278        softirqs.CPU113.TIMER
     26006 ±  4%     +19.9%      31187 ± 11%  softirqs.CPU114.RCU
    209981 ±  2%     -25.8%     155737        softirqs.CPU114.TIMER
     26352           +23.8%      32622 ± 10%  softirqs.CPU115.RCU
    211348           -26.9%     154524        softirqs.CPU115.TIMER
     25313           +30.1%      32932 ± 10%  softirqs.CPU116.RCU
    209307 ±  2%     -26.2%     154459        softirqs.CPU116.TIMER
     27790 ±  3%     +21.1%      33645 ±  9%  softirqs.CPU117.RCU
     14353 ± 41%     -61.5%       5526        softirqs.CPU117.SCHED
    216127           -27.8%     156022        softirqs.CPU117.TIMER
     27594           +23.7%      34136 ±  9%  softirqs.CPU118.RCU
    213239           -26.2%     157404        softirqs.CPU118.TIMER
     26734 ±  2%     +26.9%      33914 ± 13%  softirqs.CPU119.RCU
    217805 ±  2%     -28.2%     156393        softirqs.CPU119.TIMER
     28426 ±  3%     +28.9%      36632 ±  7%  softirqs.CPU12.RCU
    211554           -26.1%     156337        softirqs.CPU12.TIMER
    214181           -29.5%     151083 ±  3%  softirqs.CPU120.TIMER
     26400 ±  4%     +19.5%      31545 ±  6%  softirqs.CPU121.RCU
    213728           -28.8%     152225 ±  2%  softirqs.CPU121.TIMER
     26915 ±  6%     +18.0%      31770 ±  8%  softirqs.CPU122.RCU
    215720           -29.2%     152784 ±  2%  softirqs.CPU122.TIMER
     26363 ±  4%     +17.3%      30931 ±  9%  softirqs.CPU123.RCU
    213604           -29.6%     150381 ±  2%  softirqs.CPU123.TIMER
     26061 ±  5%     +15.8%      30190 ±  7%  softirqs.CPU124.RCU
    214491           -29.7%     150877 ±  2%  softirqs.CPU124.TIMER
     24418 ±  9%     +21.2%      29595 ±  7%  softirqs.CPU125.RCU
    234269 ± 15%     -36.6%     148545        softirqs.CPU125.TIMER
    213994           -29.3%     151351 ±  2%  softirqs.CPU126.TIMER
    218150           -29.2%     154451 ±  3%  softirqs.CPU127.TIMER
     30129 ±  6%     +20.3%      36251 ±  4%  softirqs.CPU128.RCU
    212778           -29.8%     149285        softirqs.CPU128.TIMER
     28601 ±  4%     +17.1%      33489 ±  7%  softirqs.CPU129.RCU
    211017           -29.6%     148512        softirqs.CPU129.TIMER
     29009 ±  2%     +27.8%      37076 ± 13%  softirqs.CPU13.RCU
    211553           -25.7%     157235        softirqs.CPU13.TIMER
     30054 ±  2%     +14.6%      34428 ±  5%  softirqs.CPU130.RCU
    211668           -29.5%     149289        softirqs.CPU130.TIMER
    210962           -30.1%     147500        softirqs.CPU131.TIMER
     27424 ±  3%     +25.1%      34313 ± 10%  softirqs.CPU132.RCU
    210509           -29.7%     148005        softirqs.CPU132.TIMER
     28479 ±  5%     +18.3%      33678 ± 10%  softirqs.CPU133.RCU
    209659           -29.4%     148095        softirqs.CPU133.TIMER
     29238           +16.6%      34091 ±  6%  softirqs.CPU134.RCU
    209720           -28.9%     149136        softirqs.CPU134.TIMER
     29823 ±  4%     +22.1%      36417 ± 11%  softirqs.CPU135.RCU
    213130 ±  2%     -28.4%     152702        softirqs.CPU135.TIMER
     29568 ±  4%     +24.1%      36682 ± 10%  softirqs.CPU136.RCU
    213209           -28.6%     152225        softirqs.CPU136.TIMER
     29277 ±  6%     +21.8%      35668 ± 11%  softirqs.CPU137.RCU
    211313           -28.2%     151657        softirqs.CPU137.TIMER
     27785 ±  4%     +22.4%      34021 ±  9%  softirqs.CPU138.RCU
    209255           -29.2%     148208        softirqs.CPU138.TIMER
     29243 ±  7%     +22.5%      35809 ±  9%  softirqs.CPU139.RCU
    209904           -29.1%     148916        softirqs.CPU139.TIMER
     29039 ±  4%     +23.5%      35850 ±  9%  softirqs.CPU14.RCU
    210534           -26.3%     155172        softirqs.CPU14.TIMER
     29218 ±  4%     +18.2%      34550 ±  8%  softirqs.CPU140.RCU
    209494           -29.3%     148163        softirqs.CPU140.TIMER
     29462 ±  4%     +21.4%      35753 ± 10%  softirqs.CPU141.RCU
     10211 ± 24%     -46.8%       5437        softirqs.CPU141.SCHED
    214685           -29.3%     151777        softirqs.CPU141.TIMER
     29923 ±  5%     +21.5%      36371 ±  9%  softirqs.CPU142.RCU
    212589           -28.5%     152001        softirqs.CPU142.TIMER
     11765 ± 41%     -54.5%       5356 ±  3%  softirqs.CPU144.SCHED
    215272 ±  2%     -29.0%     152746 ±  3%  softirqs.CPU144.TIMER
    213970 ±  2%     -27.2%     155763 ±  4%  softirqs.CPU145.TIMER
     28812 ±  4%     +28.2%      36936 ±  7%  softirqs.CPU146.RCU
    214283 ±  2%     -27.6%     155116 ±  4%  softirqs.CPU146.TIMER
    213130 ±  2%     -28.4%     152595 ±  3%  softirqs.CPU147.TIMER
     28775 ±  3%     +20.9%      34792 ± 11%  softirqs.CPU148.RCU
    212692 ±  2%     -28.1%     152999 ±  2%  softirqs.CPU148.TIMER
     27922 ±  7%     +22.4%      34182 ±  7%  softirqs.CPU149.RCU
    210971 ±  2%     -28.8%     150272 ±  2%  softirqs.CPU149.TIMER
     30249 ±  2%     +26.6%      38281 ±  7%  softirqs.CPU15.RCU
    214745           -25.6%     159746        softirqs.CPU15.TIMER
     29659 ±  6%     +24.4%      36891 ±  7%  softirqs.CPU150.RCU
    214015 ±  2%     -27.4%     155400 ±  2%  softirqs.CPU150.TIMER
    214757 ±  2%     -27.3%     156125 ±  3%  softirqs.CPU151.TIMER
    213026 ±  2%     -28.1%     153079        softirqs.CPU152.TIMER
    211168 ±  2%     -28.0%     151973        softirqs.CPU154.TIMER
     27614 ±  4%     +28.8%      35579 ±  9%  softirqs.CPU155.RCU
    211854 ±  2%     -28.2%     152200 ±  2%  softirqs.CPU155.TIMER
    213570 ±  4%     -28.5%     152707 ±  2%  softirqs.CPU156.TIMER
     27943 ±  5%     +25.6%      35103 ± 11%  softirqs.CPU157.RCU
    209587 ±  2%     -27.3%     152304        softirqs.CPU157.TIMER
     28668 ±  7%     +18.8%      34067 ±  8%  softirqs.CPU158.RCU
    211389 ±  3%     -27.8%     152553        softirqs.CPU158.TIMER
     29430 ±  6%     +20.7%      35513 ±  7%  softirqs.CPU159.RCU
    215418 ±  2%     -27.1%     157044        softirqs.CPU159.TIMER
     28001           +25.7%      35196 ± 10%  softirqs.CPU16.RCU
    213858 ±  2%     -25.9%     158518        softirqs.CPU16.TIMER
    213063 ±  2%     -27.6%     154173        softirqs.CPU160.TIMER
    211516 ±  2%     -27.0%     154490 ±  2%  softirqs.CPU161.TIMER
     25585 ±  6%     +23.8%      31686 ±  9%  softirqs.CPU162.RCU
    209829           -26.9%     153281 ±  2%  softirqs.CPU162.TIMER
    211130 ±  2%     -28.3%     151472 ±  2%  softirqs.CPU163.TIMER
     24955 ±  6%     +22.3%      30511 ± 10%  softirqs.CPU164.RCU
    209894 ±  2%     -27.5%     152076        softirqs.CPU164.TIMER
    214094 ±  3%     -27.8%     154645 ±  2%  softirqs.CPU165.TIMER
    212640 ±  2%     -27.5%     154136 ±  2%  softirqs.CPU166.TIMER
    213221 ±  2%     -27.3%     154998 ±  2%  softirqs.CPU167.TIMER
    210353 ±  2%     -25.1%     157593 ±  4%  softirqs.CPU168.TIMER
     27406 ±  2%     +18.0%      32349 ±  5%  softirqs.CPU169.RCU
     10616 ± 28%     -46.2%       5713 ± 11%  softirqs.CPU169.SCHED
    211118 ±  2%     -25.9%     156352 ±  4%  softirqs.CPU169.TIMER
     28289 ±  2%     +23.7%      34995 ±  8%  softirqs.CPU17.RCU
    213930 ±  2%     -25.9%     158532        softirqs.CPU17.TIMER
     27171 ±  5%     +19.7%      32522 ±  7%  softirqs.CPU170.RCU
    211321           -25.2%     158100 ±  5%  softirqs.CPU170.TIMER
     26894 ±  4%     +15.6%      31098 ±  8%  softirqs.CPU171.RCU
    208881           -25.1%     156553 ±  4%  softirqs.CPU171.TIMER
     27119 ±  6%     +19.3%      32360 ± 11%  softirqs.CPU172.RCU
    208501 ±  2%     -25.1%     156093 ±  4%  softirqs.CPU172.TIMER
     27023 ±  4%     +13.8%      30753 ±  8%  softirqs.CPU173.RCU
    208591           -25.0%     156399 ±  4%  softirqs.CPU173.TIMER
     26902 ±  4%     +18.8%      31963 ±  7%  softirqs.CPU174.RCU
    209460           -24.9%     157321 ±  3%  softirqs.CPU174.TIMER
    209711           -24.8%     157732 ±  4%  softirqs.CPU175.TIMER
     29123 ±  2%     +17.2%      34136 ±  8%  softirqs.CPU176.RCU
    210342 ±  2%     -25.1%     157474 ±  3%  softirqs.CPU176.TIMER
     27889 ±  5%     +20.6%      33622 ±  7%  softirqs.CPU177.RCU
    208914           -26.0%     154671 ±  3%  softirqs.CPU177.TIMER
     28702 ±  4%     +17.5%      33727 ±  8%  softirqs.CPU178.RCU
    208987           -25.8%     155136 ±  3%  softirqs.CPU178.TIMER
     26399 ±  4%     +23.1%      32505 ±  7%  softirqs.CPU18.RCU
    212164 ±  3%     -26.3%     156318        softirqs.CPU18.TIMER
     26923 ±  2%     +25.9%      33899 ±  9%  softirqs.CPU180.RCU
    206649           -25.8%     153411 ±  3%  softirqs.CPU180.TIMER
     29044 ±  2%     +16.5%      33846 ±  8%  softirqs.CPU182.RCU
    207100           -24.9%     155487 ±  3%  softirqs.CPU182.TIMER
     29943 ±  4%     +19.6%      35825 ±  9%  softirqs.CPU183.RCU
    211346           -23.8%     161066 ±  4%  softirqs.CPU183.TIMER
     30396           +19.7%      36378 ±  8%  softirqs.CPU184.RCU
    211560 ±  2%     -24.3%     160103 ±  5%  softirqs.CPU184.TIMER
     30131 ±  4%     +20.4%      36266 ± 11%  softirqs.CPU185.RCU
    209560           -26.1%     154798 ±  4%  softirqs.CPU185.TIMER
     28558 ±  2%     +18.0%      33688 ±  6%  softirqs.CPU186.RCU
    208010           -25.3%     155330 ±  4%  softirqs.CPU186.TIMER
     28347 ±  4%     +22.3%      34665 ±  7%  softirqs.CPU187.RCU
    207505 ±  2%     -25.1%     155444 ±  4%  softirqs.CPU187.TIMER
     27965           +22.2%      34182 ±  6%  softirqs.CPU188.RCU
    207078           -25.8%     153553 ±  3%  softirqs.CPU188.TIMER
     29523 ±  3%     +24.9%      36885 ± 11%  softirqs.CPU189.RCU
    209950           -24.9%     157714 ±  4%  softirqs.CPU189.TIMER
     26998 ±  3%     +23.3%      33297 ± 11%  softirqs.CPU19.RCU
     11187 ± 35%     -50.7%       5512        softirqs.CPU19.SCHED
    212227           -26.8%     155367        softirqs.CPU19.TIMER
     31200 ±  4%     +18.8%      37055 ± 10%  softirqs.CPU190.RCU
    210981 ±  2%     -25.1%     158089 ±  4%  softirqs.CPU190.TIMER
     29706 ±  5%     +22.5%      36379 ± 10%  softirqs.CPU191.RCU
      9436 ± 11%     -42.7%       5409        softirqs.CPU191.SCHED
    210329 ±  2%     -25.2%     157288 ±  3%  softirqs.CPU191.TIMER
     33787 ±  6%     +15.9%      39161 ±  5%  softirqs.CPU2.RCU
      9510 ±  9%     -40.0%       5708 ±  5%  softirqs.CPU2.SCHED
    219099 ±  2%     -27.5%     158798 ±  2%  softirqs.CPU2.TIMER
     26575 ±  4%     +28.3%      34085 ± 12%  softirqs.CPU20.RCU
    209894 ±  2%     -26.0%     155372        softirqs.CPU20.TIMER
     28068 ±  2%     +23.8%      34762 ± 10%  softirqs.CPU21.RCU
     11463 ± 43%     -51.9%       5516 ±  3%  softirqs.CPU21.SCHED
    215404           -27.0%     157312        softirqs.CPU21.TIMER
     28546           +21.9%      34806 ±  9%  softirqs.CPU22.RCU
    215758           -26.5%     158668        softirqs.CPU22.TIMER
     27843 ±  5%     +22.1%      33985 ±  9%  softirqs.CPU23.RCU
    232587 ± 12%     -32.1%     158004        softirqs.CPU23.TIMER
    212941           -28.1%     153136 ±  4%  softirqs.CPU24.TIMER
     27069 ±  4%     +18.3%      32009 ±  7%  softirqs.CPU25.RCU
    213723           -29.2%     151408        softirqs.CPU25.TIMER
     27059 ±  5%     +20.9%      32720 ±  8%  softirqs.CPU26.RCU
    213330           -28.3%     152899 ±  2%  softirqs.CPU26.TIMER
    215235           -30.1%     150373        softirqs.CPU27.TIMER
     26865 ±  5%     +16.1%      31187 ± 10%  softirqs.CPU28.RCU
    213328           -29.5%     150306        softirqs.CPU28.TIMER
    216040 ±  2%     -30.9%     149343        softirqs.CPU29.TIMER
     29232 ±  8%     +24.4%      36373 ± 11%  softirqs.CPU3.RCU
    214112 ±  2%     -27.3%     155737        softirqs.CPU3.TIMER
    213977           -28.9%     152069 ±  2%  softirqs.CPU30.TIMER
    216119           -29.3%     152717        softirqs.CPU31.TIMER
     29690 ±  4%     +21.1%      35964 ±  9%  softirqs.CPU32.RCU
    213975           -29.5%     150912        softirqs.CPU32.TIMER
     30031 ±  5%     +16.0%      34848 ±  5%  softirqs.CPU33.RCU
    211751           -29.5%     149377        softirqs.CPU33.TIMER
     29447 ±  2%     +17.1%      34479 ±  6%  softirqs.CPU34.RCU
    211731           -29.1%     150214        softirqs.CPU34.TIMER
    212468           -30.3%     148061        softirqs.CPU35.TIMER
     28685 ±  3%     +21.0%      34706 ± 10%  softirqs.CPU36.RCU
    211353           -29.3%     149392        softirqs.CPU36.TIMER
     29378           +17.2%      34426 ±  8%  softirqs.CPU37.RCU
    210511           -29.1%     149216        softirqs.CPU37.TIMER
     29100 ±  3%     +19.3%      34726 ±  7%  softirqs.CPU38.RCU
    211042           -29.0%     149835        softirqs.CPU38.TIMER
     30780 ±  5%     +20.7%      37166 ± 10%  softirqs.CPU39.RCU
    214297           -28.0%     154259        softirqs.CPU39.TIMER
     28050 ± 10%     +27.3%      35705 ±  9%  softirqs.CPU4.RCU
    230797 ± 13%     -32.2%     156453        softirqs.CPU4.TIMER
     31115 ±  6%     +19.6%      37212 ±  7%  softirqs.CPU40.RCU
    214008           -28.9%     152207        softirqs.CPU40.TIMER
     30461 ±  2%     +21.0%      36863 ±  8%  softirqs.CPU41.RCU
    211998           -28.2%     152240        softirqs.CPU41.TIMER
    209853           -29.2%     148539        softirqs.CPU42.TIMER
    211190           -28.9%     150055        softirqs.CPU43.TIMER
     29662 ±  3%     +17.6%      34883 ±  6%  softirqs.CPU44.RCU
    210298           -29.2%     148797        softirqs.CPU44.TIMER
     30223 ±  2%     +21.3%      36674 ±  9%  softirqs.CPU45.RCU
    214317           -28.7%     152818        softirqs.CPU45.TIMER
     31143 ±  4%     +17.7%      36669 ±  8%  softirqs.CPU46.RCU
    213854           -28.7%     152573        softirqs.CPU46.TIMER
     30210 ±  7%     +16.2%      35106 ± 10%  softirqs.CPU47.RCU
    213016           -26.9%     155816 ±  4%  softirqs.CPU47.TIMER
     12279 ± 32%     -50.8%       6040 ±  4%  softirqs.CPU48.SCHED
    215529 ±  2%     -28.8%     153564 ±  2%  softirqs.CPU48.TIMER
    214485 ±  2%     -27.3%     155985 ±  2%  softirqs.CPU49.TIMER
     29001 ±  6%     +25.0%      36243 ± 11%  softirqs.CPU5.RCU
    213150 ±  2%     -26.5%     156591        softirqs.CPU5.TIMER
     30095 ±  6%     +26.6%      38108 ±  5%  softirqs.CPU50.RCU
    213823 ±  2%     -27.2%     155646 ±  3%  softirqs.CPU50.TIMER
     29786 ±  6%     +18.0%      35152 ±  6%  softirqs.CPU51.RCU
    213572 ±  2%     -27.9%     153947 ±  3%  softirqs.CPU51.TIMER
     29179 ±  7%     +22.9%      35870 ±  8%  softirqs.CPU52.RCU
    211849 ±  2%     -27.6%     153474 ±  2%  softirqs.CPU52.TIMER
     28466 ±  7%     +24.0%      35307 ±  7%  softirqs.CPU53.RCU
    211192 ±  2%     -28.1%     151907 ±  3%  softirqs.CPU53.TIMER
     29840 ±  6%     +24.2%      37051 ±  7%  softirqs.CPU54.RCU
      9283 ±  6%     -41.4%       5436 ±  2%  softirqs.CPU54.SCHED
    214709           -27.8%     154928 ±  2%  softirqs.CPU54.TIMER
    213817           -27.6%     154702 ±  2%  softirqs.CPU55.TIMER
    213041 ±  2%     -27.6%     154179        softirqs.CPU56.TIMER
    210655 ±  2%     -26.3%     155289 ±  4%  softirqs.CPU57.TIMER
     28635 ±  6%     +24.3%      35591 ±  8%  softirqs.CPU58.RCU
    211656 ±  2%     -27.7%     152960        softirqs.CPU58.TIMER
    211521 ±  2%     -28.0%     152333 ±  2%  softirqs.CPU59.TIMER
     30055 ±  6%     +25.7%      37781 ±  8%  softirqs.CPU6.RCU
    214308 ±  2%     -25.9%     158750        softirqs.CPU6.TIMER
     26190 ± 15%     +32.4%      34689 ± 10%  softirqs.CPU60.RCU
    230723 ± 17%     -34.0%     152286        softirqs.CPU60.TIMER
     29128 ±  8%     +20.8%      35172 ±  8%  softirqs.CPU61.RCU
    209907 ±  2%     -27.4%     152496        softirqs.CPU61.TIMER
    211588 ±  2%     -27.9%     152582 ±  2%  softirqs.CPU62.TIMER
     29021 ±  6%     +27.0%      36844 ±  8%  softirqs.CPU63.RCU
    215397 ±  2%     -27.4%     156430 ±  2%  softirqs.CPU63.TIMER
    213662 ±  2%     -26.9%     156219        softirqs.CPU64.TIMER
     28114 ±  6%     +21.2%      34068 ±  9%  softirqs.CPU65.RCU
    212010 ±  2%     -27.0%     154766 ±  2%  softirqs.CPU65.TIMER
     25998 ±  4%     +20.0%      31210 ±  8%  softirqs.CPU66.RCU
    210363           -26.8%     154005 ±  2%  softirqs.CPU66.TIMER
    211451 ±  2%     -27.7%     152858 ±  2%  softirqs.CPU67.TIMER
    211237 ±  2%     -27.9%     152242        softirqs.CPU68.TIMER
    215228 ±  3%     -27.8%     155486 ±  2%  softirqs.CPU69.TIMER
     30439 ±  3%     +24.0%      37741 ± 10%  softirqs.CPU7.RCU
    215223           -25.9%     159580 ±  2%  softirqs.CPU7.TIMER
    213071 ±  2%     -27.2%     155209 ±  2%  softirqs.CPU70.TIMER
    213980 ±  2%     -27.5%     155074 ±  2%  softirqs.CPU71.TIMER
     28881 ±  4%     +13.7%      32843 ±  6%  softirqs.CPU72.RCU
    211907           -25.9%     157058 ±  3%  softirqs.CPU72.TIMER
     29058 ±  6%     +12.5%      32698 ±  7%  softirqs.CPU73.RCU
    211007           -24.8%     158685 ±  4%  softirqs.CPU73.TIMER
     28375 ±  3%     +16.5%      33064 ±  8%  softirqs.CPU74.RCU
    211668 ±  2%     -25.6%     157524 ±  4%  softirqs.CPU74.TIMER
     28125 ±  3%     +12.1%      31521 ±  6%  softirqs.CPU75.RCU
    209642           -25.4%     156436 ±  4%  softirqs.CPU75.TIMER
    209402           -25.9%     155214 ±  3%  softirqs.CPU76.TIMER
     27497 ±  3%     +18.5%      32587 ±  8%  softirqs.CPU77.RCU
    209689           -26.0%     155272 ±  3%  softirqs.CPU77.TIMER
     28087 ±  5%     +14.2%      32086 ±  6%  softirqs.CPU78.RCU
    210243 ±  2%     -25.3%     157057 ±  3%  softirqs.CPU78.TIMER
    210500           -25.0%     157922 ±  3%  softirqs.CPU79.TIMER
     30154 ±  3%     +23.3%      37194 ± 10%  softirqs.CPU8.RCU
    213661           -26.5%     157104        softirqs.CPU8.TIMER
     30205 ±  2%     +18.3%      35728 ±  8%  softirqs.CPU80.RCU
    210461 ±  2%     -24.8%     158370 ±  3%  softirqs.CPU80.TIMER
    209770           -25.4%     156440 ±  4%  softirqs.CPU81.TIMER
     29093 ±  4%     +20.5%      35070 ±  9%  softirqs.CPU82.RCU
    210729           -25.7%     156479 ±  3%  softirqs.CPU82.TIMER
    209439           -23.9%     159332 ±  6%  softirqs.CPU83.TIMER
     27645 ±  3%     +23.8%      34212 ±  8%  softirqs.CPU84.RCU
    205990           -25.2%     154104 ±  4%  softirqs.CPU84.TIMER
     28885 ±  3%     +18.3%      34181 ± 10%  softirqs.CPU85.RCU
    208247           -23.1%     160056 ±  6%  softirqs.CPU85.TIMER
    207440           -24.8%     156032 ±  3%  softirqs.CPU86.TIMER
     29964 ±  2%     +22.7%      36780 ± 10%  softirqs.CPU87.RCU
    211431 ±  2%     -24.0%     160677 ±  4%  softirqs.CPU87.TIMER
     30822 ±  2%     +22.4%      37741 ±  8%  softirqs.CPU88.RCU
    212526 ±  2%     -24.3%     160844 ±  5%  softirqs.CPU88.TIMER
     30358 ±  3%     +22.6%      37218 ± 11%  softirqs.CPU89.RCU
    210377 ±  2%     -24.8%     158292 ±  5%  softirqs.CPU89.TIMER
      9451 ± 11%     -40.0%       5670 ±  3%  softirqs.CPU9.SCHED
    210373           -25.9%     155838        softirqs.CPU9.TIMER
     28924 ±  2%     +20.3%      34802 ± 11%  softirqs.CPU90.RCU
    208994           -25.3%     156215 ±  4%  softirqs.CPU90.TIMER
     29719 ±  5%     +20.0%      35662 ± 13%  softirqs.CPU91.RCU
    209303 ±  2%     -25.0%     156893 ±  4%  softirqs.CPU91.TIMER
     29396 ±  4%     +16.1%      34133 ±  8%  softirqs.CPU92.RCU
    208657 ±  2%     -25.5%     155510 ±  4%  softirqs.CPU92.TIMER
     30129 ±  2%     +23.2%      37117 ±  9%  softirqs.CPU93.RCU
    211711           -24.9%     158963 ±  4%  softirqs.CPU93.TIMER
     30322           +25.9%      38166 ±  8%  softirqs.CPU94.RCU
    212952 ±  2%     -25.2%     159367 ±  4%  softirqs.CPU94.TIMER
     29568 ±  3%     +26.7%      37477 ± 12%  softirqs.CPU95.RCU
    212568 ±  2%     -24.9%     159638 ±  3%  softirqs.CPU95.TIMER
    217764 ±  2%     -27.2%     158456 ±  3%  softirqs.CPU96.TIMER
     29691 ±  4%     +25.1%      37132 ± 10%  softirqs.CPU97.RCU
    215860 ±  2%     -26.9%     157889 ±  2%  softirqs.CPU97.TIMER
     29065 ±  3%     +26.0%      36621 ±  9%  softirqs.CPU98.RCU
    215163 ±  2%     -27.4%     156134 ±  2%  softirqs.CPU98.TIMER
     28538 ±  6%     +24.8%      35613 ±  9%  softirqs.CPU99.RCU
    212827 ±  2%     -26.9%     155544        softirqs.CPU99.TIMER
   5511110 ±  3%     +20.2%    6622475 ±  8%  softirqs.RCU
   1729142           -38.4%    1065258        softirqs.SCHED
  40805530           -27.1%   29737670        softirqs.TIMER
    622.00 ± 33%     -46.4%     333.50 ± 38%  interrupts.112:IR-PCI-MSI.1574914-edge.eth1-TxRx-2
    490.75 ± 69%     -55.5%     218.25 ±  5%  interrupts.113:IR-PCI-MSI.1574915-edge.eth1-TxRx-3
    366.25 ± 32%     -34.8%     238.75 ±  8%  interrupts.117:IR-PCI-MSI.1574919-edge.eth1-TxRx-7
    394.75 ± 30%     -41.0%     232.75 ± 12%  interrupts.124:IR-PCI-MSI.1574922-edge.eth1-TxRx-10
    456.50 ± 60%     -49.7%     229.75 ± 11%  interrupts.125:IR-PCI-MSI.1574923-edge.eth1-TxRx-11
    367.75 ± 38%     -40.0%     220.50 ±  7%  interrupts.127:IR-PCI-MSI.1574925-edge.eth1-TxRx-13
    323.75 ± 11%     -35.0%     210.50 ±  2%  interrupts.128:IR-PCI-MSI.1574926-edge.eth1-TxRx-14
    275.00 ±  2%     -25.1%     206.00        interrupts.130:IR-PCI-MSI.1574928-edge.eth1-TxRx-16
    277.75 ±  2%     -26.8%     203.25        interrupts.131:IR-PCI-MSI.1574929-edge.eth1-TxRx-17
    275.50 ±  2%     -25.2%     206.00 ±  2%  interrupts.132:IR-PCI-MSI.1574930-edge.eth1-TxRx-18
    277.50 ±  2%     -26.8%     203.25        interrupts.133:IR-PCI-MSI.1574931-edge.eth1-TxRx-19
    275.25 ±  2%     -26.2%     203.25        interrupts.134:IR-PCI-MSI.1574932-edge.eth1-TxRx-20
    282.25 ±  2%     -26.9%     206.25 ±  2%  interrupts.135:IR-PCI-MSI.1574933-edge.eth1-TxRx-21
    275.00 ±  2%     -26.1%     203.25        interrupts.136:IR-PCI-MSI.1574934-edge.eth1-TxRx-22
    277.00 ±  2%     -22.6%     214.50 ±  8%  interrupts.137:IR-PCI-MSI.1574935-edge.eth1-TxRx-23
    282.75           -27.3%     205.50        interrupts.138:IR-PCI-MSI.1574936-edge.eth1-TxRx-24
    275.50 ±  2%     -26.2%     203.25        interrupts.140:IR-PCI-MSI.1574938-edge.eth1-TxRx-26
    279.25 ±  2%     -27.2%     203.25        interrupts.141:IR-PCI-MSI.1574939-edge.eth1-TxRx-27
    275.00 ±  2%     -25.0%     206.25 ±  2%  interrupts.142:IR-PCI-MSI.1574940-edge.eth1-TxRx-28
    277.25 ±  2%     -26.7%     203.25        interrupts.143:IR-PCI-MSI.1574941-edge.eth1-TxRx-29
    275.50 ±  2%     -26.1%     203.50        interrupts.144:IR-PCI-MSI.1574942-edge.eth1-TxRx-30
    275.00 ±  2%     -26.1%     203.25        interrupts.145:IR-PCI-MSI.1574943-edge.eth1-TxRx-31
    275.75 ±  2%     -26.3%     203.25        interrupts.146:IR-PCI-MSI.1574944-edge.eth1-TxRx-32
    275.75 ±  2%     -26.2%     203.50        interrupts.147:IR-PCI-MSI.1574945-edge.eth1-TxRx-33
    329.50 ± 27%     -38.2%     203.50        interrupts.149:IR-PCI-MSI.1574947-edge.eth1-TxRx-35
    277.50 ±  2%     -26.8%     203.25        interrupts.150:IR-PCI-MSI.1574948-edge.eth1-TxRx-36
    275.25 ±  2%     -26.0%     203.75        interrupts.151:IR-PCI-MSI.1574949-edge.eth1-TxRx-37
    287.50 ±  5%     -29.3%     203.25        interrupts.152:IR-PCI-MSI.1574950-edge.eth1-TxRx-38
    275.00 ±  2%     -26.0%     203.50        interrupts.153:IR-PCI-MSI.1574951-edge.eth1-TxRx-39
    275.00 ±  2%     -26.1%     203.25        interrupts.154:IR-PCI-MSI.1574952-edge.eth1-TxRx-40
    275.00 ±  2%     -26.1%     203.25        interrupts.155:IR-PCI-MSI.1574953-edge.eth1-TxRx-41
    277.50 ±  2%     -26.7%     203.50        interrupts.156:IR-PCI-MSI.1574954-edge.eth1-TxRx-42
    275.00 ±  2%     -25.7%     204.25        interrupts.157:IR-PCI-MSI.1574955-edge.eth1-TxRx-43
    286.50 ±  6%     -28.9%     203.75        interrupts.158:IR-PCI-MSI.1574956-edge.eth1-TxRx-44
    277.50 ±  3%     -26.7%     203.50        interrupts.159:IR-PCI-MSI.1574957-edge.eth1-TxRx-45
    275.00 ±  2%     -26.1%     203.25        interrupts.160:IR-PCI-MSI.1574958-edge.eth1-TxRx-46
    275.00 ±  2%     -26.1%     203.25        interrupts.161:IR-PCI-MSI.1574959-edge.eth1-TxRx-47
    275.75 ±  2%     -25.5%     205.50        interrupts.163:IR-PCI-MSI.1574961-edge.eth1-TxRx-49
    275.00 ±  2%     -25.9%     203.75        interrupts.164:IR-PCI-MSI.1574962-edge.eth1-TxRx-50
    276.50 ±  3%     -26.5%     203.25        interrupts.165:IR-PCI-MSI.1574963-edge.eth1-TxRx-51
    275.00 ±  2%     -26.1%     203.25        interrupts.166:IR-PCI-MSI.1574964-edge.eth1-TxRx-52
    276.00 ±  2%     -26.4%     203.25        interrupts.167:IR-PCI-MSI.1574965-edge.eth1-TxRx-53
    275.50 ±  2%     -25.3%     205.75        interrupts.168:IR-PCI-MSI.1574966-edge.eth1-TxRx-54
    322.25 ± 24%     -36.9%     203.25        interrupts.169:IR-PCI-MSI.1574967-edge.eth1-TxRx-55
    275.50 ±  2%     -26.0%     203.75        interrupts.170:IR-PCI-MSI.1574968-edge.eth1-TxRx-56
    276.00 ±  2%     -26.2%     203.75        interrupts.171:IR-PCI-MSI.1574969-edge.eth1-TxRx-57
    275.00 ±  2%     -26.1%     203.25        interrupts.172:IR-PCI-MSI.1574970-edge.eth1-TxRx-58
    275.25 ±  2%     -26.2%     203.25        interrupts.173:IR-PCI-MSI.1574971-edge.eth1-TxRx-59
    275.00 ±  2%     -26.1%     203.25        interrupts.174:IR-PCI-MSI.1574972-edge.eth1-TxRx-60
    275.50 ±  2%     -26.1%     203.50        interrupts.175:IR-PCI-MSI.1574973-edge.eth1-TxRx-61
    275.25 ±  2%     -26.1%     203.50        interrupts.176:IR-PCI-MSI.1574974-edge.eth1-TxRx-62
   1130237 ± 13%     -25.8%     838335        interrupts.CAL:Function_call_interrupts
      5168 ±  8%     -15.7%       4359        interrupts.CPU0.CAL:Function_call_interrupts
   1076991 ±  4%     -24.1%     817359 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      5745 ± 13%     -24.4%       4341        interrupts.CPU1.CAL:Function_call_interrupts
   1068882 ±  5%     -23.5%     817312 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
    394.75 ± 30%     -41.0%     232.75 ± 12%  interrupts.CPU10.124:IR-PCI-MSI.1574922-edge.eth1-TxRx-10
      5748 ± 13%     -24.5%       4337 ±  2%  interrupts.CPU10.CAL:Function_call_interrupts
   1068622 ±  5%     -23.5%     817378 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
      6026 ± 11%     -27.9%       4345        interrupts.CPU100.CAL:Function_call_interrupts
   1070995 ±  5%     -23.7%     817171 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
      5836 ± 16%     -25.0%       4379        interrupts.CPU101.CAL:Function_call_interrupts
   1068645 ±  5%     -23.5%     817389 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
      5952 ± 13%     -28.4%       4261 ±  6%  interrupts.CPU102.CAL:Function_call_interrupts
   1068969 ±  5%     -23.6%     817155 ±  2%  interrupts.CPU102.LOC:Local_timer_interrupts
      5914 ± 13%     -25.7%       4395        interrupts.CPU103.CAL:Function_call_interrupts
   1068474 ±  5%     -23.5%     817266 ±  2%  interrupts.CPU103.LOC:Local_timer_interrupts
      5936 ± 13%     -26.1%       4386        interrupts.CPU104.CAL:Function_call_interrupts
   1068373 ±  5%     -23.5%     817256 ±  2%  interrupts.CPU104.LOC:Local_timer_interrupts
      5923 ± 13%     -26.1%       4377        interrupts.CPU105.CAL:Function_call_interrupts
   1067765 ±  5%     -23.5%     817318 ±  2%  interrupts.CPU105.LOC:Local_timer_interrupts
      5905 ± 13%     -26.0%       4371        interrupts.CPU106.CAL:Function_call_interrupts
   1068345 ±  5%     -23.5%     817168 ±  2%  interrupts.CPU106.LOC:Local_timer_interrupts
      5876 ± 13%     -24.7%       4422 ±  2%  interrupts.CPU107.CAL:Function_call_interrupts
   1068399 ±  5%     -23.5%     817241 ±  2%  interrupts.CPU107.LOC:Local_timer_interrupts
     26.25 ±106%    +361.0%     121.00 ± 77%  interrupts.CPU107.RES:Rescheduling_interrupts
      5870 ± 13%     -24.8%       4415 ±  2%  interrupts.CPU108.CAL:Function_call_interrupts
   1068321 ±  5%     -23.5%     817069 ±  2%  interrupts.CPU108.LOC:Local_timer_interrupts
      5847 ± 13%     -24.6%       4410 ±  2%  interrupts.CPU109.CAL:Function_call_interrupts
   1068358 ±  5%     -23.5%     817283 ±  2%  interrupts.CPU109.LOC:Local_timer_interrupts
     17.50 ± 69%    +718.6%     143.25 ± 48%  interrupts.CPU109.RES:Rescheduling_interrupts
    456.50 ± 60%     -49.7%     229.75 ± 11%  interrupts.CPU11.125:IR-PCI-MSI.1574923-edge.eth1-TxRx-11
      5727 ± 13%     -24.4%       4329 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
   1068652 ±  5%     -23.5%     817368 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      5832 ± 13%     -24.5%       4405 ±  2%  interrupts.CPU110.CAL:Function_call_interrupts
   1068111 ±  5%     -23.5%     817267 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
      5805 ± 13%     -24.7%       4373 ±  4%  interrupts.CPU111.CAL:Function_call_interrupts
   1068078 ±  5%     -23.5%     817185 ±  2%  interrupts.CPU111.LOC:Local_timer_interrupts
     25.75 ± 73%    +435.0%     137.75 ± 12%  interrupts.CPU111.RES:Rescheduling_interrupts
      5690 ± 11%     -23.1%       4378 ±  2%  interrupts.CPU112.CAL:Function_call_interrupts
   1068016 ±  5%     -23.5%     817236 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
      5888 ± 12%     -25.0%       4416 ±  2%  interrupts.CPU113.CAL:Function_call_interrupts
   1068115 ±  5%     -23.5%     817407 ±  2%  interrupts.CPU113.LOC:Local_timer_interrupts
      5754 ± 13%     -24.3%       4355 ±  3%  interrupts.CPU114.CAL:Function_call_interrupts
   1068245 ±  5%     -23.5%     817299 ±  2%  interrupts.CPU114.LOC:Local_timer_interrupts
      5746 ± 13%     -24.1%       4362 ±  2%  interrupts.CPU115.CAL:Function_call_interrupts
   1067729 ±  5%     -23.5%     817198 ±  2%  interrupts.CPU115.LOC:Local_timer_interrupts
      5728 ± 13%     -33.6%       3802 ± 24%  interrupts.CPU116.CAL:Function_call_interrupts
   1067531 ±  5%     -23.4%     817294 ±  2%  interrupts.CPU116.LOC:Local_timer_interrupts
   1067792 ±  5%     -23.5%     817380 ±  2%  interrupts.CPU117.LOC:Local_timer_interrupts
      5967 ± 14%     -36.3%       3800 ± 27%  interrupts.CPU118.CAL:Function_call_interrupts
   1068169 ±  5%     -23.5%     817269 ±  2%  interrupts.CPU118.LOC:Local_timer_interrupts
     57.75 ±126%    +802.6%     521.25 ± 82%  interrupts.CPU118.RES:Rescheduling_interrupts
      5948 ± 14%     -25.5%       4431 ±  2%  interrupts.CPU119.CAL:Function_call_interrupts
   1067702 ±  5%     -23.5%     816641 ±  2%  interrupts.CPU119.LOC:Local_timer_interrupts
      5766 ± 13%     -28.2%       4140 ±  5%  interrupts.CPU12.CAL:Function_call_interrupts
   1068501 ±  5%     -23.5%     817472 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
      5940 ± 14%     -25.6%       4419        interrupts.CPU120.CAL:Function_call_interrupts
   1064878 ±  6%     -23.4%     815435 ±  3%  interrupts.CPU120.LOC:Local_timer_interrupts
      5858 ± 14%     -24.6%       4414        interrupts.CPU121.CAL:Function_call_interrupts
   1064719 ±  5%     -23.4%     815464 ±  3%  interrupts.CPU121.LOC:Local_timer_interrupts
      5887 ± 14%     -24.8%       4429        interrupts.CPU122.CAL:Function_call_interrupts
   1064872 ±  6%     -23.4%     815208 ±  3%  interrupts.CPU122.LOC:Local_timer_interrupts
      5980 ± 12%     -25.9%       4428        interrupts.CPU123.CAL:Function_call_interrupts
   1065006 ±  5%     -23.4%     815282 ±  3%  interrupts.CPU123.LOC:Local_timer_interrupts
      5829 ± 14%     -24.2%       4417        interrupts.CPU124.CAL:Function_call_interrupts
   1064512 ±  6%     -23.4%     815486 ±  3%  interrupts.CPU124.LOC:Local_timer_interrupts
      5932 ± 12%     -25.1%       4443        interrupts.CPU125.CAL:Function_call_interrupts
   1064549 ±  6%     -23.4%     815278 ±  3%  interrupts.CPU125.LOC:Local_timer_interrupts
      5954 ± 12%     -24.9%       4472 ±  2%  interrupts.CPU126.CAL:Function_call_interrupts
   1064735 ±  6%     -23.4%     815395 ±  3%  interrupts.CPU126.LOC:Local_timer_interrupts
      5863 ± 12%     -23.9%       4461 ±  2%  interrupts.CPU127.CAL:Function_call_interrupts
   1064451 ±  6%     -23.4%     815262 ±  3%  interrupts.CPU127.LOC:Local_timer_interrupts
      5969 ± 13%     -25.5%       4448 ±  2%  interrupts.CPU128.CAL:Function_call_interrupts
   1064891 ±  6%     -23.4%     815290 ±  3%  interrupts.CPU128.LOC:Local_timer_interrupts
      6043 ± 12%     -26.6%       4438 ±  2%  interrupts.CPU129.CAL:Function_call_interrupts
   1064774 ±  6%     -23.4%     815476 ±  3%  interrupts.CPU129.LOC:Local_timer_interrupts
    367.75 ± 38%     -40.0%     220.50 ±  7%  interrupts.CPU13.127:IR-PCI-MSI.1574925-edge.eth1-TxRx-13
      5717 ± 13%     -24.5%       4319 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
   1068376 ±  5%     -23.5%     817463 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
      6034 ± 12%     -27.5%       4373        interrupts.CPU130.CAL:Function_call_interrupts
   1064663 ±  6%     -23.3%     816165 ±  3%  interrupts.CPU130.LOC:Local_timer_interrupts
      6006 ± 12%     -25.9%       4452 ±  2%  interrupts.CPU131.CAL:Function_call_interrupts
   1064736 ±  6%     -23.4%     815494 ±  3%  interrupts.CPU131.LOC:Local_timer_interrupts
      5985 ± 12%     -25.3%       4468        interrupts.CPU132.CAL:Function_call_interrupts
   1064863 ±  6%     -23.4%     815416 ±  3%  interrupts.CPU132.LOC:Local_timer_interrupts
      5966 ± 12%     -25.3%       4458        interrupts.CPU133.CAL:Function_call_interrupts
   1065070 ±  5%     -23.5%     815295 ±  3%  interrupts.CPU133.LOC:Local_timer_interrupts
      5949 ± 12%     -25.0%       4463 ±  2%  interrupts.CPU134.CAL:Function_call_interrupts
   1064865 ±  6%     -23.4%     815378 ±  3%  interrupts.CPU134.LOC:Local_timer_interrupts
      5941 ± 12%     -24.9%       4465 ±  2%  interrupts.CPU135.CAL:Function_call_interrupts
   1065166 ±  5%     -23.5%     815337 ±  3%  interrupts.CPU135.LOC:Local_timer_interrupts
      5928 ± 13%     -24.5%       4473        interrupts.CPU136.CAL:Function_call_interrupts
   1064619 ±  6%     -23.4%     815310 ±  3%  interrupts.CPU136.LOC:Local_timer_interrupts
      5910 ± 13%     -23.3%       4532 ±  2%  interrupts.CPU137.CAL:Function_call_interrupts
   1064777 ±  6%     -23.4%     815316 ±  3%  interrupts.CPU137.LOC:Local_timer_interrupts
      5898 ± 13%     -23.2%       4527 ±  2%  interrupts.CPU138.CAL:Function_call_interrupts
   1064691 ±  6%     -23.4%     815430 ±  3%  interrupts.CPU138.LOC:Local_timer_interrupts
      5932 ± 14%     -23.5%       4536 ±  2%  interrupts.CPU139.CAL:Function_call_interrupts
   1064513 ±  6%     -23.4%     815356 ±  3%  interrupts.CPU139.LOC:Local_timer_interrupts
    323.75 ± 11%     -35.0%     210.50 ±  2%  interrupts.CPU14.128:IR-PCI-MSI.1574926-edge.eth1-TxRx-14
      5741 ± 13%     -24.0%       4364 ±  3%  interrupts.CPU14.CAL:Function_call_interrupts
   1068480 ±  5%     -23.5%     817445 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
      5855 ± 13%     -22.9%       4515 ±  2%  interrupts.CPU140.CAL:Function_call_interrupts
   1064653 ±  6%     -23.4%     815425 ±  3%  interrupts.CPU140.LOC:Local_timer_interrupts
      5759 ± 14%     -21.7%       4508 ±  2%  interrupts.CPU141.CAL:Function_call_interrupts
   1064571 ±  6%     -23.4%     815503 ±  3%  interrupts.CPU141.LOC:Local_timer_interrupts
      5998 ± 15%     -25.2%       4486 ±  2%  interrupts.CPU142.CAL:Function_call_interrupts
   1064679 ±  6%     -23.4%     815652 ±  3%  interrupts.CPU142.LOC:Local_timer_interrupts
      6042 ± 14%     -25.5%       4499 ±  2%  interrupts.CPU143.CAL:Function_call_interrupts
   1064141 ±  5%     -23.4%     815097 ±  3%  interrupts.CPU143.LOC:Local_timer_interrupts
   1065178 ±  6%     -23.5%     815097 ±  3%  interrupts.CPU144.LOC:Local_timer_interrupts
      6094 ± 14%     -26.3%       4493        interrupts.CPU145.CAL:Function_call_interrupts
   1063968 ±  6%     -23.4%     814942 ±  3%  interrupts.CPU145.LOC:Local_timer_interrupts
      6150 ± 16%     -27.2%       4478        interrupts.CPU146.CAL:Function_call_interrupts
   1063995 ±  6%     -23.4%     815284 ±  3%  interrupts.CPU146.LOC:Local_timer_interrupts
      6077 ± 16%     -26.5%       4463        interrupts.CPU147.CAL:Function_call_interrupts
   1063615 ±  6%     -23.4%     815216 ±  3%  interrupts.CPU147.LOC:Local_timer_interrupts
      5995 ± 17%     -25.8%       4449        interrupts.CPU148.CAL:Function_call_interrupts
   1064104 ±  6%     -23.4%     815345 ±  3%  interrupts.CPU148.LOC:Local_timer_interrupts
      6104 ± 16%     -27.4%       4434        interrupts.CPU149.CAL:Function_call_interrupts
   1064084 ±  6%     -23.4%     815304 ±  3%  interrupts.CPU149.LOC:Local_timer_interrupts
      5698 ± 13%     -28.8%       4055 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
   1068242 ±  5%     -23.5%     817354 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
    105.25 ± 68%    +150.6%     263.75 ± 28%  interrupts.CPU15.RES:Rescheduling_interrupts
      6081 ± 16%     -27.2%       4426        interrupts.CPU150.CAL:Function_call_interrupts
   1063905 ±  6%     -23.4%     815031 ±  3%  interrupts.CPU150.LOC:Local_timer_interrupts
      6051 ± 16%     -27.1%       4410        interrupts.CPU151.CAL:Function_call_interrupts
   1064069 ±  6%     -23.4%     815211 ±  3%  interrupts.CPU151.LOC:Local_timer_interrupts
      5970 ± 17%     -26.4%       4393        interrupts.CPU152.CAL:Function_call_interrupts
   1064026 ±  6%     -23.4%     815122 ±  3%  interrupts.CPU152.LOC:Local_timer_interrupts
      6010 ± 16%     -26.4%       4422        interrupts.CPU153.CAL:Function_call_interrupts
   1064010 ±  6%     -23.4%     814655 ±  3%  interrupts.CPU153.LOC:Local_timer_interrupts
      5988 ± 15%     -26.5%       4403        interrupts.CPU154.CAL:Function_call_interrupts
   1064073 ±  6%     -23.4%     814984 ±  3%  interrupts.CPU154.LOC:Local_timer_interrupts
      5971 ± 15%     -26.1%       4415 ±  2%  interrupts.CPU155.CAL:Function_call_interrupts
   1063921 ±  6%     -23.4%     815049 ±  3%  interrupts.CPU155.LOC:Local_timer_interrupts
      5826 ± 12%     -24.3%       4410 ±  2%  interrupts.CPU156.CAL:Function_call_interrupts
   1063807 ±  6%     -23.4%     815023 ±  3%  interrupts.CPU156.LOC:Local_timer_interrupts
      6045 ± 14%     -27.7%       4372        interrupts.CPU157.CAL:Function_call_interrupts
   1064014 ±  6%     -23.4%     815142 ±  3%  interrupts.CPU157.LOC:Local_timer_interrupts
      6074 ± 13%     -27.2%       4419        interrupts.CPU158.CAL:Function_call_interrupts
   1064052 ±  6%     -23.4%     815046 ±  3%  interrupts.CPU158.LOC:Local_timer_interrupts
      6058 ± 13%     -27.2%       4407        interrupts.CPU159.CAL:Function_call_interrupts
   1064269 ±  6%     -23.4%     815019 ±  3%  interrupts.CPU159.LOC:Local_timer_interrupts
     34.75 ± 39%    +136.0%      82.00 ± 28%  interrupts.CPU159.RES:Rescheduling_interrupts
    275.00 ±  2%     -25.1%     206.00        interrupts.CPU16.130:IR-PCI-MSI.1574928-edge.eth1-TxRx-16
      5811 ± 12%     -26.1%       4293 ±  2%  interrupts.CPU16.CAL:Function_call_interrupts
   1068216 ±  5%     -23.5%     817684 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
      6048 ± 13%     -27.1%       4406        interrupts.CPU160.CAL:Function_call_interrupts
   1064260 ±  6%     -23.4%     814992 ±  3%  interrupts.CPU160.LOC:Local_timer_interrupts
      6097 ± 12%     -27.1%       4446 ±  2%  interrupts.CPU161.CAL:Function_call_interrupts
   1063884 ±  6%     -23.4%     815123 ±  3%  interrupts.CPU161.LOC:Local_timer_interrupts
      6088 ± 12%     -26.5%       4475 ±  2%  interrupts.CPU162.CAL:Function_call_interrupts
   1064094 ±  6%     -23.4%     815087 ±  3%  interrupts.CPU162.LOC:Local_timer_interrupts
      6095 ± 12%     -26.8%       4462 ±  2%  interrupts.CPU163.CAL:Function_call_interrupts
   1063849 ±  6%     -23.4%     814953 ±  3%  interrupts.CPU163.LOC:Local_timer_interrupts
      6066 ± 12%     -26.5%       4460 ±  2%  interrupts.CPU164.CAL:Function_call_interrupts
   1064007 ±  6%     -23.4%     815019 ±  3%  interrupts.CPU164.LOC:Local_timer_interrupts
      6051 ± 12%     -26.4%       4453 ±  2%  interrupts.CPU165.CAL:Function_call_interrupts
   1064298 ±  6%     -23.4%     815087 ±  3%  interrupts.CPU165.LOC:Local_timer_interrupts
      6021 ± 12%     -26.3%       4435 ±  2%  interrupts.CPU166.CAL:Function_call_interrupts
   1063918 ±  6%     -23.4%     815168 ±  3%  interrupts.CPU166.LOC:Local_timer_interrupts
      6040 ± 11%     -26.6%       4431        interrupts.CPU167.CAL:Function_call_interrupts
   1063652 ±  6%     -23.4%     815042 ±  3%  interrupts.CPU167.LOC:Local_timer_interrupts
      5976 ± 10%     -26.9%       4367        interrupts.CPU168.CAL:Function_call_interrupts
   1065599 ±  5%     -23.5%     815552 ±  3%  interrupts.CPU168.LOC:Local_timer_interrupts
     67.75 ± 42%     -60.9%      26.50 ± 32%  interrupts.CPU168.RES:Rescheduling_interrupts
      5943 ± 10%     -26.6%       4361        interrupts.CPU169.CAL:Function_call_interrupts
   1071958 ±  4%     -23.9%     815242 ±  3%  interrupts.CPU169.LOC:Local_timer_interrupts
    277.75 ±  2%     -26.8%     203.25        interrupts.CPU17.131:IR-PCI-MSI.1574929-edge.eth1-TxRx-17
      5799 ± 11%     -25.3%       4329        interrupts.CPU17.CAL:Function_call_interrupts
   1068555 ±  5%     -23.5%     817348 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
      6011 ± 11%     -26.3%       4433 ±  3%  interrupts.CPU170.CAL:Function_call_interrupts
   1065838 ±  5%     -23.5%     815377 ±  3%  interrupts.CPU170.LOC:Local_timer_interrupts
      6009 ± 11%     -28.9%       4272        interrupts.CPU171.CAL:Function_call_interrupts
   1065808 ±  5%     -23.5%     815373 ±  3%  interrupts.CPU171.LOC:Local_timer_interrupts
      6023 ± 10%     -26.9%       4400        interrupts.CPU172.CAL:Function_call_interrupts
   1065763 ±  5%     -23.5%     815383 ±  3%  interrupts.CPU172.LOC:Local_timer_interrupts
      6051 ± 10%     -27.6%       4384        interrupts.CPU173.CAL:Function_call_interrupts
   1065502 ±  5%     -23.5%     815500 ±  3%  interrupts.CPU173.LOC:Local_timer_interrupts
      6035 ± 10%     -29.6%       4247 ±  3%  interrupts.CPU174.CAL:Function_call_interrupts
   1065804 ±  5%     -23.5%     815599 ±  3%  interrupts.CPU174.LOC:Local_timer_interrupts
    166.75 ± 93%     -85.8%      23.75 ± 42%  interrupts.CPU174.RES:Rescheduling_interrupts
      6003 ± 10%     -27.2%       4371        interrupts.CPU175.CAL:Function_call_interrupts
   1065757 ±  5%     -23.5%     815380 ±  3%  interrupts.CPU175.LOC:Local_timer_interrupts
      5975 ± 10%     -26.9%       4366        interrupts.CPU176.CAL:Function_call_interrupts
   1065807 ±  5%     -23.5%     815586 ±  3%  interrupts.CPU176.LOC:Local_timer_interrupts
      5950 ± 10%     -25.9%       4407 ±  2%  interrupts.CPU177.CAL:Function_call_interrupts
   1065642 ±  5%     -23.5%     815627 ±  3%  interrupts.CPU177.LOC:Local_timer_interrupts
      5947 ± 13%     -26.0%       4399 ±  2%  interrupts.CPU178.CAL:Function_call_interrupts
   1065715 ±  5%     -23.5%     815417 ±  3%  interrupts.CPU178.LOC:Local_timer_interrupts
      5975 ± 13%     -26.3%       4404 ±  2%  interrupts.CPU179.CAL:Function_call_interrupts
   1065717 ±  5%     -23.5%     815743 ±  3%  interrupts.CPU179.LOC:Local_timer_interrupts
    275.50 ±  2%     -25.2%     206.00 ±  2%  interrupts.CPU18.132:IR-PCI-MSI.1574930-edge.eth1-TxRx-18
      5788 ± 12%     -25.0%       4339        interrupts.CPU18.CAL:Function_call_interrupts
   1068246 ±  5%     -23.5%     817433 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
      5949 ± 13%     -26.2%       4391 ±  2%  interrupts.CPU180.CAL:Function_call_interrupts
   1065442 ±  5%     -23.4%     815794 ±  3%  interrupts.CPU180.LOC:Local_timer_interrupts
      5979 ± 13%     -27.3%       4344 ±  3%  interrupts.CPU181.CAL:Function_call_interrupts
   1065736 ±  5%     -23.5%     815300 ±  3%  interrupts.CPU181.LOC:Local_timer_interrupts
      6071 ± 11%     -29.1%       4306        interrupts.CPU182.CAL:Function_call_interrupts
   1065585 ±  5%     -23.4%     815820 ±  3%  interrupts.CPU182.LOC:Local_timer_interrupts
      6225 ± 14%     -29.4%       4393 ±  2%  interrupts.CPU183.CAL:Function_call_interrupts
   1065689 ±  5%     -23.5%     815521 ±  3%  interrupts.CPU183.LOC:Local_timer_interrupts
      6149 ±  9%     -29.9%       4311 ±  4%  interrupts.CPU184.CAL:Function_call_interrupts
   1065475 ±  5%     -23.4%     815824 ±  3%  interrupts.CPU184.LOC:Local_timer_interrupts
      6308 ± 13%     -30.2%       4405 ±  2%  interrupts.CPU185.CAL:Function_call_interrupts
   1065480 ±  5%     -23.4%     815849 ±  3%  interrupts.CPU185.LOC:Local_timer_interrupts
      6253 ± 13%     -29.6%       4402        interrupts.CPU186.CAL:Function_call_interrupts
   1065724 ±  5%     -23.5%     815776 ±  3%  interrupts.CPU186.LOC:Local_timer_interrupts
      6276 ± 12%     -30.1%       4385        interrupts.CPU187.CAL:Function_call_interrupts
   1065407 ±  5%     -23.5%     815379 ±  3%  interrupts.CPU187.LOC:Local_timer_interrupts
      6265 ± 13%     -30.2%       4371        interrupts.CPU188.CAL:Function_call_interrupts
   1065783 ±  5%     -23.5%     815586 ±  3%  interrupts.CPU188.LOC:Local_timer_interrupts
      6256 ± 12%     -29.2%       4426 ±  2%  interrupts.CPU189.CAL:Function_call_interrupts
   1065486 ±  5%     -23.4%     815869 ±  3%  interrupts.CPU189.LOC:Local_timer_interrupts
     51.50 ± 40%    +248.5%     179.50 ± 41%  interrupts.CPU189.RES:Rescheduling_interrupts
    277.50 ±  2%     -26.8%     203.25        interrupts.CPU19.133:IR-PCI-MSI.1574931-edge.eth1-TxRx-19
      5780 ± 12%     -27.0%       4217 ±  3%  interrupts.CPU19.CAL:Function_call_interrupts
   1067443 ±  5%     -23.4%     817248 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
      6260 ± 12%     -30.6%       4343        interrupts.CPU190.CAL:Function_call_interrupts
   1065962 ±  5%     -23.5%     815771 ±  3%  interrupts.CPU190.LOC:Local_timer_interrupts
      5678 ±  2%     -23.2%       4362        interrupts.CPU191.CAL:Function_call_interrupts
   1067845 ±  5%     -23.6%     815805 ±  3%  interrupts.CPU191.LOC:Local_timer_interrupts
    622.00 ± 33%     -46.4%     333.50 ± 38%  interrupts.CPU2.112:IR-PCI-MSI.1574914-edge.eth1-TxRx-2
      5819 ± 14%     -25.0%       4362        interrupts.CPU2.CAL:Function_call_interrupts
   1068877 ±  5%     -23.5%     817462 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
    275.25 ±  2%     -26.2%     203.25        interrupts.CPU20.134:IR-PCI-MSI.1574932-edge.eth1-TxRx-20
      5767 ± 12%     -25.4%       4304        interrupts.CPU20.CAL:Function_call_interrupts
   1067225 ±  5%     -23.4%     817645 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
    282.25 ±  2%     -26.9%     206.25 ±  2%  interrupts.CPU21.135:IR-PCI-MSI.1574933-edge.eth1-TxRx-21
   1067560 ±  5%     -23.4%     817431 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU22.136:IR-PCI-MSI.1574934-edge.eth1-TxRx-22
      5735 ± 12%     -25.7%       4260 ±  2%  interrupts.CPU22.CAL:Function_call_interrupts
   1068543 ±  5%     -23.4%     818022 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
    277.00 ±  2%     -22.6%     214.50 ±  8%  interrupts.CPU23.137:IR-PCI-MSI.1574935-edge.eth1-TxRx-23
      5761 ± 12%     -25.8%       4274 ±  2%  interrupts.CPU23.CAL:Function_call_interrupts
   1068202 ±  5%     -23.4%     818386 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
    282.75           -27.3%     205.50        interrupts.CPU24.138:IR-PCI-MSI.1574936-edge.eth1-TxRx-24
      5578 ± 14%     -24.3%       4225 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
   1065105 ±  6%     -23.3%     817356 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      5702 ± 12%     -25.1%       4271 ±  3%  interrupts.CPU25.CAL:Function_call_interrupts
   1064814 ±  6%     -23.4%     815355 ±  3%  interrupts.CPU25.LOC:Local_timer_interrupts
    275.50 ±  2%     -26.2%     203.25        interrupts.CPU26.140:IR-PCI-MSI.1574938-edge.eth1-TxRx-26
      5764 ± 14%     -25.2%       4312        interrupts.CPU26.CAL:Function_call_interrupts
   1064800 ±  6%     -23.4%     815374 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
    279.25 ±  2%     -27.2%     203.25        interrupts.CPU27.141:IR-PCI-MSI.1574939-edge.eth1-TxRx-27
      5746 ± 14%     -24.7%       4329 ±  2%  interrupts.CPU27.CAL:Function_call_interrupts
   1064852 ±  5%     -23.4%     815240 ±  3%  interrupts.CPU27.LOC:Local_timer_interrupts
    275.00 ±  2%     -25.0%     206.25 ±  2%  interrupts.CPU28.142:IR-PCI-MSI.1574940-edge.eth1-TxRx-28
      5726 ± 15%     -24.6%       4320 ±  2%  interrupts.CPU28.CAL:Function_call_interrupts
   1064388 ±  6%     -23.4%     815276 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
    277.25 ±  2%     -26.7%     203.25        interrupts.CPU29.143:IR-PCI-MSI.1574941-edge.eth1-TxRx-29
      5790 ± 14%     -25.6%       4308 ±  2%  interrupts.CPU29.CAL:Function_call_interrupts
   1064453 ±  5%     -23.4%     815262 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
    490.75 ± 69%     -55.5%     218.25 ±  5%  interrupts.CPU3.113:IR-PCI-MSI.1574915-edge.eth1-TxRx-3
      5882 ± 13%     -25.9%       4360        interrupts.CPU3.CAL:Function_call_interrupts
   1068550 ±  5%     -23.6%     816515 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
    275.50 ±  2%     -26.1%     203.50        interrupts.CPU30.144:IR-PCI-MSI.1574942-edge.eth1-TxRx-30
      5826 ± 13%     -26.1%       4303 ±  2%  interrupts.CPU30.CAL:Function_call_interrupts
   1064980 ±  6%     -23.4%     815263 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU31.145:IR-PCI-MSI.1574943-edge.eth1-TxRx-31
      5804 ± 13%     -25.7%       4313 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
   1064921 ±  6%     -23.4%     815292 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
    275.75 ±  2%     -26.3%     203.25        interrupts.CPU32.146:IR-PCI-MSI.1574944-edge.eth1-TxRx-32
      5948 ± 12%     -28.0%       4285 ±  2%  interrupts.CPU32.CAL:Function_call_interrupts
   1064930 ±  6%     -23.4%     815278 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
    275.75 ±  2%     -26.2%     203.50        interrupts.CPU33.147:IR-PCI-MSI.1574945-edge.eth1-TxRx-33
      5887 ± 14%     -27.2%       4286        interrupts.CPU33.CAL:Function_call_interrupts
   1065309 ±  6%     -23.5%     815316 ±  3%  interrupts.CPU33.LOC:Local_timer_interrupts
      6023 ± 12%     -37.8%       3745 ± 27%  interrupts.CPU34.CAL:Function_call_interrupts
   1065254 ±  6%     -23.4%     816073 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
    329.50 ± 27%     -38.2%     203.50        interrupts.CPU35.149:IR-PCI-MSI.1574947-edge.eth1-TxRx-35
      5974 ± 13%     -28.2%       4291        interrupts.CPU35.CAL:Function_call_interrupts
   1065082 ±  5%     -23.5%     815313 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
    277.50 ±  2%     -26.8%     203.25        interrupts.CPU36.150:IR-PCI-MSI.1574948-edge.eth1-TxRx-36
      5939 ± 13%     -27.9%       4284        interrupts.CPU36.CAL:Function_call_interrupts
   1064962 ±  6%     -23.4%     815369 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
    275.25 ±  2%     -26.0%     203.75        interrupts.CPU37.151:IR-PCI-MSI.1574949-edge.eth1-TxRx-37
      5961 ± 14%     -28.0%       4291        interrupts.CPU37.CAL:Function_call_interrupts
   1064785 ±  5%     -23.4%     815349 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
     48.75 ± 62%    +392.3%     240.00 ±107%  interrupts.CPU37.RES:Rescheduling_interrupts
    287.50 ±  5%     -29.3%     203.25        interrupts.CPU38.152:IR-PCI-MSI.1574950-edge.eth1-TxRx-38
      5951 ± 14%     -28.1%       4281        interrupts.CPU38.CAL:Function_call_interrupts
   1065166 ±  6%     -23.5%     815295 ±  3%  interrupts.CPU38.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.0%     203.50        interrupts.CPU39.153:IR-PCI-MSI.1574951-edge.eth1-TxRx-39
      5921 ± 14%     -26.4%       4359        interrupts.CPU39.CAL:Function_call_interrupts
   1064741 ±  6%     -23.4%     815368 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
      5864 ± 13%     -25.8%       4352        interrupts.CPU4.CAL:Function_call_interrupts
   1068694 ±  5%     -23.5%     817464 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU40.154:IR-PCI-MSI.1574952-edge.eth1-TxRx-40
      5925 ± 13%     -26.1%       4379        interrupts.CPU40.CAL:Function_call_interrupts
   1064766 ±  6%     -23.4%     815403 ±  3%  interrupts.CPU40.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU41.155:IR-PCI-MSI.1574953-edge.eth1-TxRx-41
      5898 ± 14%     -25.4%       4402 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
   1064611 ±  6%     -23.4%     815405 ±  3%  interrupts.CPU41.LOC:Local_timer_interrupts
    277.50 ±  2%     -26.7%     203.50        interrupts.CPU42.156:IR-PCI-MSI.1574954-edge.eth1-TxRx-42
      5900 ± 12%     -25.5%       4398 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
   1064596 ±  6%     -23.4%     815474 ±  3%  interrupts.CPU42.LOC:Local_timer_interrupts
    275.00 ±  2%     -25.7%     204.25        interrupts.CPU43.157:IR-PCI-MSI.1574955-edge.eth1-TxRx-43
      5882 ± 12%     -25.2%       4402 ±  2%  interrupts.CPU43.CAL:Function_call_interrupts
   1064840 ±  6%     -23.4%     815462 ±  3%  interrupts.CPU43.LOC:Local_timer_interrupts
    316.50 ± 97%     -82.7%      54.75 ± 72%  interrupts.CPU43.RES:Rescheduling_interrupts
    286.50 ±  6%     -28.9%     203.75        interrupts.CPU44.158:IR-PCI-MSI.1574956-edge.eth1-TxRx-44
      5854 ± 12%     -24.4%       4423 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
   1064759 ±  6%     -23.4%     815360 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
    277.50 ±  3%     -26.7%     203.50        interrupts.CPU45.159:IR-PCI-MSI.1574957-edge.eth1-TxRx-45
      5938 ± 15%     -25.6%       4416 ±  2%  interrupts.CPU45.CAL:Function_call_interrupts
   1064747 ±  6%     -23.4%     815284 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU46.160:IR-PCI-MSI.1574958-edge.eth1-TxRx-46
      5927 ± 15%     -25.7%       4406 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
   1064796 ±  6%     -23.4%     815290 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU47.161:IR-PCI-MSI.1574959-edge.eth1-TxRx-47
      5798 ± 17%     -23.6%       4428        interrupts.CPU47.CAL:Function_call_interrupts
   1064870 ±  6%     -23.5%     815152 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
   1064667 ±  6%     -23.4%     815225 ±  3%  interrupts.CPU48.LOC:Local_timer_interrupts
    275.75 ±  2%     -25.5%     205.50        interrupts.CPU49.163:IR-PCI-MSI.1574961-edge.eth1-TxRx-49
      5868 ± 15%     -24.5%       4429        interrupts.CPU49.CAL:Function_call_interrupts
   1063758 ±  6%     -23.4%     815150 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
      5897 ± 13%     -26.6%       4327        interrupts.CPU5.CAL:Function_call_interrupts
   1068401 ±  5%     -23.5%     817222 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
    275.00 ±  2%     -25.9%     203.75        interrupts.CPU50.164:IR-PCI-MSI.1574962-edge.eth1-TxRx-50
      5833 ± 15%     -24.3%       4417        interrupts.CPU50.CAL:Function_call_interrupts
   1064005 ±  6%     -23.4%     815078 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
    276.50 ±  3%     -26.5%     203.25        interrupts.CPU51.165:IR-PCI-MSI.1574963-edge.eth1-TxRx-51
      5816 ± 15%     -24.3%       4404        interrupts.CPU51.CAL:Function_call_interrupts
   1063686 ±  6%     -23.4%     815241 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU52.166:IR-PCI-MSI.1574964-edge.eth1-TxRx-52
      5809 ± 15%     -23.9%       4420        interrupts.CPU52.CAL:Function_call_interrupts
   1063758 ±  6%     -23.4%     815164 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
    276.00 ±  2%     -26.4%     203.25        interrupts.CPU53.167:IR-PCI-MSI.1574965-edge.eth1-TxRx-53
      5797 ± 15%     -24.1%       4402        interrupts.CPU53.CAL:Function_call_interrupts
   1063910 ±  6%     -23.4%     815224 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
    275.50 ±  2%     -25.3%     205.75        interrupts.CPU54.168:IR-PCI-MSI.1574966-edge.eth1-TxRx-54
      5781 ± 15%     -24.0%       4396        interrupts.CPU54.CAL:Function_call_interrupts
   1064139 ±  6%     -23.4%     815128 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
    322.25 ± 24%     -36.9%     203.25        interrupts.CPU55.169:IR-PCI-MSI.1574967-edge.eth1-TxRx-55
      5766 ± 14%     -24.1%       4375        interrupts.CPU55.CAL:Function_call_interrupts
   1063901 ±  6%     -23.4%     815109 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
    275.50 ±  2%     -26.0%     203.75        interrupts.CPU56.170:IR-PCI-MSI.1574968-edge.eth1-TxRx-56
      5698 ± 15%     -23.4%       4366        interrupts.CPU56.CAL:Function_call_interrupts
   1063923 ±  6%     -23.4%     815101 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
    276.00 ±  2%     -26.2%     203.75        interrupts.CPU57.171:IR-PCI-MSI.1574969-edge.eth1-TxRx-57
      5750 ± 15%     -24.2%       4358        interrupts.CPU57.CAL:Function_call_interrupts
   1063868 ±  6%     -23.4%     814792 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU58.172:IR-PCI-MSI.1574970-edge.eth1-TxRx-58
      5770 ± 15%     -24.5%       4357        interrupts.CPU58.CAL:Function_call_interrupts
   1063870 ±  6%     -23.4%     815218 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
    275.25 ±  2%     -26.2%     203.25        interrupts.CPU59.173:IR-PCI-MSI.1574971-edge.eth1-TxRx-59
      5793 ± 16%     -24.9%       4349        interrupts.CPU59.CAL:Function_call_interrupts
   1063943 ±  6%     -23.4%     815138 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
      5810 ± 12%     -33.3%       3878 ± 19%  interrupts.CPU6.CAL:Function_call_interrupts
   1068871 ±  5%     -23.5%     817731 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
    275.00 ±  2%     -26.1%     203.25        interrupts.CPU60.174:IR-PCI-MSI.1574972-edge.eth1-TxRx-60
      5693 ± 14%     -23.8%       4339        interrupts.CPU60.CAL:Function_call_interrupts
   1063234 ±  6%     -23.3%     815105 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
    275.50 ±  2%     -26.1%     203.50        interrupts.CPU61.175:IR-PCI-MSI.1574973-edge.eth1-TxRx-61
      5758 ± 16%     -24.8%       4330        interrupts.CPU61.CAL:Function_call_interrupts
   1063910 ±  6%     -23.4%     815085 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
    275.25 ±  2%     -26.1%     203.50        interrupts.CPU62.176:IR-PCI-MSI.1574974-edge.eth1-TxRx-62
      5756 ± 16%     -24.9%       4324        interrupts.CPU62.CAL:Function_call_interrupts
   1064031 ±  6%     -23.4%     814990 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
      5722 ± 15%     -24.6%       4312        interrupts.CPU63.CAL:Function_call_interrupts
   1065971 ±  5%     -23.5%     815015 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
      5759 ± 15%     -24.4%       4351        interrupts.CPU64.CAL:Function_call_interrupts
   1063874 ±  6%     -23.4%     815087 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
      5750 ± 15%     -24.0%       4370 ±  2%  interrupts.CPU65.CAL:Function_call_interrupts
   1064215 ±  6%     -23.4%     815017 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
      5737 ± 15%     -23.8%       4371 ±  3%  interrupts.CPU66.CAL:Function_call_interrupts
   1064010 ±  6%     -23.4%     815282 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
      5717 ± 15%     -22.8%       4416 ±  2%  interrupts.CPU67.CAL:Function_call_interrupts
   1063785 ±  6%     -23.4%     815181 ±  3%  interrupts.CPU67.LOC:Local_timer_interrupts
      5613 ± 17%     -22.3%       4360 ±  3%  interrupts.CPU68.CAL:Function_call_interrupts
   1064069 ±  6%     -23.4%     814925 ±  3%  interrupts.CPU68.LOC:Local_timer_interrupts
      5687 ± 15%     -23.3%       4359 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
   1063564 ±  6%     -23.4%     815054 ±  3%  interrupts.CPU69.LOC:Local_timer_interrupts
    366.25 ± 32%     -34.8%     238.75 ±  8%  interrupts.CPU7.117:IR-PCI-MSI.1574919-edge.eth1-TxRx-7
      5826 ± 13%     -25.9%       4320        interrupts.CPU7.CAL:Function_call_interrupts
   1068409 ±  5%     -23.5%     817390 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      5709 ± 15%     -23.7%       4357 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
   1063871 ±  6%     -23.4%     815060 ±  3%  interrupts.CPU70.LOC:Local_timer_interrupts
      5695 ± 15%     -23.6%       4349 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
   1064132 ±  6%     -23.4%     814595 ±  3%  interrupts.CPU71.LOC:Local_timer_interrupts
      5692 ± 13%     -23.5%       4351 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
   1065764 ±  5%     -23.5%     815695 ±  3%  interrupts.CPU72.LOC:Local_timer_interrupts
      5863 ± 14%     -27.8%       4235 ±  2%  interrupts.CPU73.CAL:Function_call_interrupts
   1066184 ±  5%     -23.5%     816127 ±  3%  interrupts.CPU73.LOC:Local_timer_interrupts
      5840 ± 13%     -25.9%       4327 ±  3%  interrupts.CPU74.CAL:Function_call_interrupts
   1065855 ±  5%     -23.5%     815593 ±  3%  interrupts.CPU74.LOC:Local_timer_interrupts
      5882 ± 12%     -25.6%       4374 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
   1065844 ±  5%     -23.5%     815713 ±  3%  interrupts.CPU75.LOC:Local_timer_interrupts
      5866 ± 12%     -26.2%       4327 ±  2%  interrupts.CPU76.CAL:Function_call_interrupts
   1065792 ±  5%     -23.5%     815691 ±  3%  interrupts.CPU76.LOC:Local_timer_interrupts
      5805 ± 12%     -25.0%       4356 ±  2%  interrupts.CPU77.CAL:Function_call_interrupts
   1065496 ±  5%     -23.5%     815630 ±  3%  interrupts.CPU77.LOC:Local_timer_interrupts
      5779 ± 12%     -23.7%       4411 ±  4%  interrupts.CPU78.CAL:Function_call_interrupts
   1065678 ±  5%     -23.5%     815169 ±  3%  interrupts.CPU78.LOC:Local_timer_interrupts
      5795 ± 12%     -24.8%       4359 ±  2%  interrupts.CPU79.CAL:Function_call_interrupts
   1065750 ±  5%     -23.5%     815664 ±  3%  interrupts.CPU79.LOC:Local_timer_interrupts
      5769 ± 14%     -25.2%       4317        interrupts.CPU8.CAL:Function_call_interrupts
   1068358 ±  5%     -23.5%     817290 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      5830 ± 14%     -24.6%       4395 ±  2%  interrupts.CPU80.CAL:Function_call_interrupts
   1065810 ±  5%     -23.5%     815187 ±  3%  interrupts.CPU80.LOC:Local_timer_interrupts
      5875 ± 13%     -24.4%       4439        interrupts.CPU81.CAL:Function_call_interrupts
   1065604 ±  5%     -23.4%     815987 ±  3%  interrupts.CPU81.LOC:Local_timer_interrupts
      5965 ± 12%     -25.5%       4443        interrupts.CPU82.CAL:Function_call_interrupts
   1065923 ±  5%     -23.5%     815763 ±  3%  interrupts.CPU82.LOC:Local_timer_interrupts
      5945 ± 13%     -26.1%       4394 ±  2%  interrupts.CPU83.CAL:Function_call_interrupts
   1065777 ±  5%     -23.5%     815539 ±  3%  interrupts.CPU83.LOC:Local_timer_interrupts
      5931 ± 13%     -25.3%       4431        interrupts.CPU84.CAL:Function_call_interrupts
   1065465 ±  5%     -23.5%     815387 ±  3%  interrupts.CPU84.LOC:Local_timer_interrupts
      5920 ± 14%     -25.5%       4408        interrupts.CPU85.CAL:Function_call_interrupts
   1065872 ±  5%     -23.5%     815110 ±  3%  interrupts.CPU85.LOC:Local_timer_interrupts
      5891 ± 14%     -25.1%       4414        interrupts.CPU86.CAL:Function_call_interrupts
   1065640 ±  5%     -23.5%     815544 ±  3%  interrupts.CPU86.LOC:Local_timer_interrupts
      5895 ± 13%     -25.3%       4403        interrupts.CPU87.CAL:Function_call_interrupts
   1065362 ±  5%     -23.4%     815629 ±  3%  interrupts.CPU87.LOC:Local_timer_interrupts
      5939 ± 13%     -26.9%       4341 ±  2%  interrupts.CPU88.CAL:Function_call_interrupts
   1065509 ±  5%     -23.5%     815643 ±  3%  interrupts.CPU88.LOC:Local_timer_interrupts
      5919 ± 13%     -25.7%       4395        interrupts.CPU89.CAL:Function_call_interrupts
   1065465 ±  5%     -23.4%     815615 ±  3%  interrupts.CPU89.LOC:Local_timer_interrupts
      5762 ± 13%     -25.2%       4311        interrupts.CPU9.CAL:Function_call_interrupts
   1067849 ±  5%     -23.5%     817350 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
      5940 ± 12%     -26.1%       4389        interrupts.CPU90.CAL:Function_call_interrupts
   1065728 ±  5%     -23.5%     815578 ±  3%  interrupts.CPU90.LOC:Local_timer_interrupts
      5922 ± 13%     -26.1%       4374        interrupts.CPU91.CAL:Function_call_interrupts
   1065455 ±  5%     -23.5%     815494 ±  3%  interrupts.CPU91.LOC:Local_timer_interrupts
      5950 ± 12%     -30.0%       4165 ±  4%  interrupts.CPU92.CAL:Function_call_interrupts
   1065765 ±  5%     -23.4%     815995 ±  3%  interrupts.CPU92.LOC:Local_timer_interrupts
    685.00 ± 97%     -75.9%     164.75 ± 34%  interrupts.CPU92.RES:Rescheduling_interrupts
      6025 ± 14%     -26.3%       4441        interrupts.CPU93.CAL:Function_call_interrupts
   1065657 ±  5%     -23.4%     815771 ±  3%  interrupts.CPU93.LOC:Local_timer_interrupts
      6050 ± 11%     -27.4%       4389        interrupts.CPU94.CAL:Function_call_interrupts
   1065874 ±  5%     -23.5%     815599 ±  3%  interrupts.CPU94.LOC:Local_timer_interrupts
      5956 ± 10%     -30.6%       4133 ±  6%  interrupts.CPU95.CAL:Function_call_interrupts
   1071360 ±  4%     -23.7%     816944 ±  3%  interrupts.CPU95.LOC:Local_timer_interrupts
     12839 ±  5%     -20.9%      10158 ±  6%  interrupts.CPU95.RES:Rescheduling_interrupts
      5968 ± 10%     -28.1%       4292 ±  3%  interrupts.CPU96.CAL:Function_call_interrupts
   1071091 ±  5%     -23.7%     817467 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
      6006 ± 11%     -26.8%       4395        interrupts.CPU97.CAL:Function_call_interrupts
   1068538 ±  5%     -23.5%     817381 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
      6069 ± 13%     -27.3%       4409        interrupts.CPU98.CAL:Function_call_interrupts
   1068457 ±  5%     -23.5%     817227 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
     25.00 ± 26%   +1018.0%     279.50 ± 46%  interrupts.CPU98.RES:Rescheduling_interrupts
      6048 ± 13%     -26.8%       4426        interrupts.CPU99.CAL:Function_call_interrupts
   1068492 ±  5%     -23.5%     817135 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
 2.046e+08 ±  5%     -23.5%  1.566e+08 ±  3%  interrupts.LOC:Local_timer_interrupts
    308.50 ± 70%     -84.8%      47.00 ± 54%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.0.0-11177-g9d65ac8"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.0.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
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
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
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
# CONFIG_DEBUG_BLK_CGROUP is not set
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
CONFIG_ANON_INODES=y
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
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
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
# CONFIG_X86_CPU_RESCTRL is not set
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
# CONFIG_QUEUED_LOCK_STAT is not set
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
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
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

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_INTEL_IDLE=y

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

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

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
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
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
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
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

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
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
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
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
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
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
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
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
# CONFIG_SMC is not set
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
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
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
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
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
CONFIG_NF_NAT_NEEDED=y
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
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
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

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
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
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_CLS_IND=y
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
# CONFIG_MPLS_ROUTING is not set
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
# CONFIG_CAN_DEBUG_DEVICES is not set
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
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
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
# CONFIG_NET_9P_RDMA is not set
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
# CONFIG_NET_DEVLINK is not set
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
CONFIG_VMD=y

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
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
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

#
# Bus devices
#
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

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

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
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
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
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set

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
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
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
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
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
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
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
CONFIG_SCSI_SMARTPQI=m
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
CONFIG_QEDI=m
CONFIG_QEDF=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
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
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
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
CONFIG_MLX5_CORE=m
# CONFIG_MLX5_FPGA is not set
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SWITCHIB=m
CONFIG_MLXSW_SWITCHX2=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=y
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
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
CONFIG_QED_LL2=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_FCOE=y
CONFIG_QED_OOO=y
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
# CONFIG_TI_CPSW_ALE is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
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
# CONFIG_ASIX_PHY is not set
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
CONFIG_ATH9K_COMMON_DEBUG=y
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
CONFIG_ATH9K_DEBUGFS=y
# CONFIG_ATH9K_STATION_STATISTICS is not set
# CONFIG_ATH9K_DYNACK is not set
CONFIG_ATH9K_WOW=y
CONFIG_ATH9K_RFKILL=y
# CONFIG_ATH9K_CHANNEL_CONTEXT is not set
CONFIG_ATH9K_PCOEM=y
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_ATH9K_HWRNG is not set
# CONFIG_ATH9K_COMMON_SPECTRAL is not set
CONFIG_CARL9170=m
CONFIG_CARL9170_LEDS=y
# CONFIG_CARL9170_DEBUGFS is not set
CONFIG_CARL9170_WPC=y
# CONFIG_CARL9170_HWRNG is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
CONFIG_WIL6210=m
CONFIG_WIL6210_ISR_COR=y
CONFIG_WIL6210_TRACING=y
CONFIG_WIL6210_DEBUGFS=y
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
# CONFIG_ATH10K_SDIO is not set
# CONFIG_ATH10K_USB is not set
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=y
# CONFIG_ATH10K_SPECTRAL is not set
# CONFIG_ATH10K_TRACING is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMSMAC=m
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
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
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
CONFIG_MWL8K=m
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
# CONFIG_RT2400PCI is not set
# CONFIG_RT2500PCI is not set
CONFIG_RT61PCI=m
CONFIG_RT2800PCI=m
CONFIG_RT2800PCI_RT33XX=y
CONFIG_RT2800PCI_RT35XX=y
CONFIG_RT2800PCI_RT53XX=y
CONFIG_RT2800PCI_RT3290=y
# CONFIG_RT2500USB is not set
CONFIG_RT73USB=m
CONFIG_RT2800USB=m
CONFIG_RT2800USB_RT33XX=y
CONFIG_RT2800USB_RT35XX=y
CONFIG_RT2800USB_RT3573=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
CONFIG_RT2X00_LIB_DEBUGFS=y
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
CONFIG_RTL8187=m
CONFIG_RTL8187_LEDS=y
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
# CONFIG_RTL8XXXU is not set
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
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_NO_SENDCOMPLETE=y
CONFIG_HISAX_NO_LLC=y
CONFIG_HISAX_NO_KEYPAD=y
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=m
# CONFIG_HISAX_HFCUSB is not set
CONFIG_HISAX_HFC4S8S=m
CONFIG_HISAX_FRITZ_PCIPNP=m
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
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
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

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
CONFIG_KEYBOARD_ATKBD=y
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
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
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
# CONFIG_R3964 is not set
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
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
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
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
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
# CONFIG_CHARGER_LTC3651 is not set
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
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
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
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

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

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
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
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
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
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
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
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

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
CONFIG_VIDEO_M52790=m

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
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
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

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
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

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
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

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
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set

#
# ARM devices
#
CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN1_0=y
CONFIG_DRM_AMD_DC_DCN1_01=y
# CONFIG_DEBUG_KERNEL_DC is not set
# CONFIG_HSA_AMD is not set

#
# AMD Library routines
#
CONFIG_CHASH=m
# CONFIG_CHASH_STATS is not set
# CONFIG_CHASH_SELFTEST is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
# CONFIG_DRM_NOUVEAU_SVM is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
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
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
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
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
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
CONFIG_BACKLIGHT_LCD_SUPPORT=y
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
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
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
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
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
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
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

#
# STMicroelectronics STM32 SOC audio support
#
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
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
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
# CONFIG_USB_SERIAL_TI is not set
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

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
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
CONFIG_LEDS_LT3593=m
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
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_MTHCA=m
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_CXGB3=m
CONFIG_INFINIBAND_CXGB4=m
CONFIG_INFINIBAND_I40IW=m
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_NES=m
# CONFIG_INFINIBAND_NES_DEBUG is not set
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_QEDR=m
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_RDMA_RXE=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
CONFIG_INFINIBAND_OPA_VNIC=m
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
CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
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
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
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
CONFIG_XEN_TMEM=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
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
# CONFIG_R8822BE is not set
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

#
# Analog to digital converters
#
# CONFIG_AD7780 is not set
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
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
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
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
# CONFIG_COMMON_CLK_PWM is not set
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

#
# Analog Front Ends
#

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set

#
# Counters
#

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

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

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

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

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

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
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

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set

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
CONFIG_NTB=m
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
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

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
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

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

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
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
# CONFIG_F2FS_FS is not set
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

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

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
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
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

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
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
CONFIG_SECURITY_INFINIBAND=y
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
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
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
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

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
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
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
CONFIG_DMA_VIRT_OPS=y
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
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
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
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set
CONFIG_OBJAGG=m

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

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
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
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
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
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
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
CONFIG_RCU_CPU_STALL_TIMEOUT=60
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
# CONFIG_FAIL_MMC_REQUEST is not set
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
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
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
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_STACKINIT is not set
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
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='vm-scalability'
	export testcase='vm-scalability'
	export category='benchmark'
	export runtime=300
	export size=17179869184
	export job_origin='/lkp/lkp/.src-20190315-235809/allot/cyclic:p1:linux-devel:devel-hourly/lkp-bdw-ep2/vm-scalability.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='lkp-bdw-ep2'
	export tbox_group='lkp-bdw-ep2'
	export submit_id='5c8e16070b9a9394f72465a4'
	export job_file='/lkp/jobs/scheduled/lkp-bdw-ep2/vm-scalability-performance-300s-16G-shm-pread-rand-debian-x86_64--20190317-38135-1ltic0j-3.yaml'
	export id='76c2ebefdf969bdcd038e678b10afa106c734700'
	export queuer_version='/lkp/lkp/.src-20190315-235809'
	export need_kconfig='CONFIG_BLK_DEV_LOOP'
	export commit='9d65ac8a35a75c7334cfa0f855215c91bb4e752b'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-03-17 17:40:24 +0800'
	export _id='5c8e16080b9a9394f72465a5'
	export _rt='/result/vm-scalability/performance-300s-16G-shm-pread-rand/lkp-bdw-ep2/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b'
	export user='lkp'
	export head_commit='0d02332d347b20a3d970d517eef8f65ab2527a92'
	export base_commit='1c163f4c7b3f621efff9b28a47abb36f7378d783'
	export branch='linux-devel/devel-hourly-2019031701'
	export result_root='/result/vm-scalability/performance-300s-16G-shm-pread-rand/lkp-bdw-ep2/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/3'
	export scheduler_version='/lkp/lkp/.src-20190315-235809'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-bdw-ep2/vm-scalability-performance-300s-16G-shm-pread-rand-debian-x86_64--20190317-38135-1ltic0j-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019031701
commit=9d65ac8a35a75c7334cfa0f855215c91bb4e752b
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/vmlinuz-5.0.0-11177-g9d65ac8
max_uptime=1500
RESULT_ROOT=/result/vm-scalability/performance-300s-16G-shm-pread-rand/lkp-bdw-ep2/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-01-01.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-1c163f4c7b3f_2019-03-04.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vm-scalability_2019-03-07.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/vm-scalability-x86_64-6328152_2019-03-07.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-03-14.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2018-05-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2018-05-18.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-03-14.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2016-11-15.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='Broadwell-EP'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_ssd_partitions=1
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BW360H6_CVTR551405ZP360DGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV539600YR800OGN-part1'
	export brand='Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz'
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/vmlinuz-5.0.0-11177-g9d65ac8'
	export dequeue_time='2019-03-17 17:48:42 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-bdw-ep2/vm-scalability-performance-300s-16G-shm-pread-rand-debian-x86_64--20190317-38135-1ltic0j-3.cgz'

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

	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='shm-pread-rand' $LKP_SRC/tests/wrapper vm-scalability
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper vm-scalability
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
	$LKP_SRC/stats/wrapper pmeter

	$LKP_SRC/stats/wrapper time vm-scalability.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/vm-scalability.yaml
suite: vm-scalability
testcase: vm-scalability
category: benchmark
perf-profile: 
runtime: 300s
size: 16G
vm-scalability:
  test: shm-pread-rand
job_origin: "/lkp/lkp/.src-20190315-235809/allot/cyclic:p1:linux-devel:devel-hourly/lkp-bdw-ep2/vm-scalability.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-bdw-ep2
tbox_group: lkp-bdw-ep2
submit_id: 5c8dceda0b9a9339b85ecf7c
job_file: "/lkp/jobs/scheduled/lkp-bdw-ep2/vm-scalability-performance-300s-16G-shm-pread-rand-debian-x86_64-20-20190317-80312-o9vp4u-0.yaml"
id: f30453daeadc87bdf15a7ba51891bc2c3ff50335
queuer_version: "/lkp/lkp/.src-20190315-235809"

#! hosts/lkp-bdw-ep2

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

#! include/category/ALL
cpufreq_governor: performance

#! include/vm-scalability
need_kconfig: CONFIG_BLK_DEV_LOOP

#! include/queue/cyclic
commit: 9d65ac8a35a75c7334cfa0f855215c91bb4e752b

#! include/testbox/lkp-bdw-ep2
pmeter:
  pmeter_server: lkp-nhm-dp2
  pmeter_device: yokogawa-wt310

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
rootfs: debian-x86_64-2018-04-03.cgz
enqueue_time: 2019-03-17 12:36:43.632552808 +08:00
_id: 5c8dceda0b9a9339b85ecf7c
_rt: "/result/vm-scalability/performance-300s-16G-shm-pread-rand/lkp-bdw-ep2/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b"

#! schedule options
user: lkp
head_commit: 0d02332d347b20a3d970d517eef8f65ab2527a92
base_commit: 1c163f4c7b3f621efff9b28a47abb36f7378d783
branch: linux-devel/devel-hourly-2019031701
result_root: "/result/vm-scalability/performance-300s-16G-shm-pread-rand/lkp-bdw-ep2/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/0"
scheduler_version: "/lkp/lkp/.src-20190315-235809"
LKP_SERVER: inn
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-2018-04-03.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-bdw-ep2/vm-scalability-performance-300s-16G-shm-pread-rand-debian-x86_64-20-20190317-80312-o9vp4u-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2019031701
- commit=9d65ac8a35a75c7334cfa0f855215c91bb4e752b
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/vmlinuz-5.0.0-11177-g9d65ac8
- max_uptime=1500
- RESULT_ROOT=/result/vm-scalability/performance-300s-16G-shm-pread-rand/lkp-bdw-ep2/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-01-01.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-1c163f4c7b3f_2019-03-04.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vm-scalability_2019-03-07.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/vm-scalability-x86_64-6328152_2019-03-07.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-03-14.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2018-05-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2018-05-18.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-03-14.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2016-11-15.cgz"
lkp_initrd: "/lkp/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190315-235809/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
schedule_notify_address: 
model: Broadwell-EP
nr_node: 2
nr_cpu: 88
memory: 128G
nr_ssd_partitions: 1
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW360H6_CVTR551405ZP360DGN-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV539600YR800OGN-part1"
brand: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/9d65ac8a35a75c7334cfa0f855215c91bb4e752b/vmlinuz-5.0.0-11177-g9d65ac8"
dequeue_time: 2019-03-17 12:57:18.790506827 +08:00
job_state: finished
loadavg: 68.51 55.32 25.40 1/686 9941
start_time: '1552798717'
end_time: '1552799041'
version: "/lkp/lkp/.src-20190315-235809"

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cd /lkp/benchmarks/vm-scalability
 mount -t tmpfs -o size=100% vm-scalability-tmp /tmp/vm-scalability-tmp
 truncate -s 135057952768 /tmp/vm-scalability-tmp/vm-scalability.img
 mkfs.xfs -q /tmp/vm-scalability-tmp/vm-scalability.img
 mount -o loop /tmp/vm-scalability-tmp/vm-scalability.img /tmp/vm-scalability-tmp/vm-scalability
 ./case-shm-pread-rand
 truncate /tmp/vm-scalability-tmp/sparse-shm-pread-rand -s 67528974336
 ./usemem --runtime 300 -n 88 -f /tmp/vm-scalability-tmp/sparse-shm-pread-rand --readonly --random 33764487168
 umount /tmp/vm-scalability-tmp/vm-scalability
 rm /tmp/vm-scalability-tmp/vm-scalability.img
 umount /tmp/vm-scalability-tmp

--FkmkrVfFsRoUs1wW--
