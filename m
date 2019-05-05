Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F19BC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2DA20644
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 05:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEEFlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 01:41:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:59762 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEEFlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 01:41:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 May 2019 22:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,431,1549958400"; 
   d="yaml'?scan'208";a="155024282"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2019 22:40:49 -0700
Date:   Sun, 5 May 2019 13:41:13 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger.hoffstaette@googlemail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benjamin Gordon <bmgordon@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@01.org
Subject: [loop]  56a85fd837:  fxmark.hdd_btrfs_MWUM_1_bufferedio.works/sec
 224.0% improvement
Message-ID: <20190505054113.GF29809@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 224.0% improvement of fxmark.hdd_btrfs_MWUM_1_bufferedio.works/sec due to commit:


commit: 56a85fd8376ef32458efb6ea97a820754e12f6bb ("loop: properly observe rotational flag of underlying device")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.2/block

in testcase: fxmark
on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
with following parameters:

	disk: 1HDD
	media: hdd
	test: MWUM
	fstype: btrfs
	directio: bufferedio
	cpufreq_governor: performance
	ucode: 0x42d


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.hdd_btrfs_MWUM_1_directio.works/sec 236.5% improvement |
| test machine     | 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory  |
| test parameters  | cpufreq_governor=performance                                          |
|                  | directio=directio                                                     |
|                  | disk=1HDD                                                             |
|                  | fstype=btrfs                                                          |
|                  | media=hdd                                                             |
|                  | test=MWUM                                                             |
|                  | ucode=0x42d                                                           |
+------------------+-----------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.hdd_btrfs_MWUL_1_directio.works/sec -33.9% regression  |
| test machine     | 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory  |
| test parameters  | cpufreq_governor=performance                                          |
|                  | directio=directio                                                     |
|                  | disk=1HDD                                                             |
|                  | fstype=btrfs                                                          |
|                  | media=hdd                                                             |
|                  | test=MWUL                                                             |
|                  | ucode=0x42d                                                           |
+------------------+-----------------------------------------------------------------------+


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/bufferedio/1HDD/btrfs/x86_64-rhel-7.6/hdd/debian-x86_64-2018-04-03.cgz/ivb44/MWUM/fxmark/0x42d

commit: 
  4438cf50e7 ("doc, block, bfq: add information on bfq execution time")
  56a85fd837 ("loop: properly observe rotational flag of underlying device")

4438cf50e7b315ff 56a85fd8376ef32458efb6ea97a 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:4            2%           0:4     perf-profile.children.cycles-pp.error_entry
          0:4            3%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     17.58 ±  4%     -47.0%       9.31 ± 52%  fxmark.hdd_btrfs_MWUM_12_bufferedio.user_util
     10.58 ±  3%     -24.7%       7.97 ± 20%  fxmark.hdd_btrfs_MWUM_16_bufferedio.iowait_util
     20.54 ±  4%      -8.0%      18.89        fxmark.hdd_btrfs_MWUM_1_bufferedio.iowait_sec
     86.59           -17.3%      71.58        fxmark.hdd_btrfs_MWUM_1_bufferedio.iowait_util
     24.03 ±  3%     +10.9%      26.66        fxmark.hdd_btrfs_MWUM_1_bufferedio.real_sec
     23.97 ±  3%     +11.0%      26.60        fxmark.hdd_btrfs_MWUM_1_bufferedio.secs
      0.10 ±  4%     +39.0%       0.14 ±  9%  fxmark.hdd_btrfs_MWUM_1_bufferedio.softirq_sec
      0.43 ±  6%     +24.6%       0.54 ±  7%  fxmark.hdd_btrfs_MWUM_1_bufferedio.softirq_util
      2.83 ±  3%    +148.2%       7.01        fxmark.hdd_btrfs_MWUM_1_bufferedio.sys_sec
     11.92 ±  2%    +122.9%      26.57        fxmark.hdd_btrfs_MWUM_1_bufferedio.sys_util
      0.25 ± 12%     +36.6%       0.35 ±  3%  fxmark.hdd_btrfs_MWUM_1_bufferedio.user_sec
      1.06 ±  8%     +23.2%       1.31 ±  3%  fxmark.hdd_btrfs_MWUM_1_bufferedio.user_util
     47985          +260.0%     172754        fxmark.hdd_btrfs_MWUM_1_bufferedio.works
      2004 ±  4%    +224.0%       6495        fxmark.hdd_btrfs_MWUM_1_bufferedio.works/sec
      0.29 ±  9%     -23.8%       0.22 ±  6%  fxmark.hdd_btrfs_MWUM_2_bufferedio.softirq_util
      2.17 ± 30%     -41.1%       1.28 ±  5%  fxmark.hdd_btrfs_MWUM_2_bufferedio.sys_sec
      4.02 ± 41%     -46.2%       2.16 ±  5%  fxmark.hdd_btrfs_MWUM_2_bufferedio.sys_util
     15122 ±104%     -83.7%       2468 ± 15%  fxmark.hdd_btrfs_MWUM_2_bufferedio.works
    599.22 ±115%     -86.3%      82.18 ± 15%  fxmark.hdd_btrfs_MWUM_2_bufferedio.works/sec
      2747 ±166%     -97.2%      76.08 ± 25%  fxmark.hdd_btrfs_MWUM_4_bufferedio.works/sec
    107.14 ± 13%    +451.3%     590.70 ±  2%  fxmark.time.elapsed_time
    107.14 ± 13%    +451.3%     590.70 ±  2%  fxmark.time.elapsed_time.max
   1092168 ±  6%    +443.2%    5932256 ±  3%  fxmark.time.file_system_outputs
    116421 ±  2%    +314.6%     482732        fxmark.time.involuntary_context_switches
     10.50 ± 10%    +145.2%      25.75 ± 19%  fxmark.time.percent_of_cpu_this_job_got
      6.12 ±  2%    +178.6%      17.05        fxmark.time.system_time
      5.29 ± 21%   +2488.7%     137.01 ± 20%  fxmark.time.user_time
     61250 ± 39%    +161.7%     160299 ±  4%  fxmark.time.voluntary_context_switches
     29.38 ±  8%     -12.2       17.16 ±  4%  mpstat.cpu.all.idle%
      7.55 ± 13%      -2.2        5.32 ±  3%  mpstat.cpu.all.sys%
      6.79 ± 26%     +16.8       23.60 ±  5%  mpstat.cpu.all.usr%
    524443 ±  7%    +221.0%    1683330 ±  4%  numa-numastat.node0.local_node
    533969 ±  6%    +216.0%    1687419 ±  4%  numa-numastat.node0.numa_hit
     92268 ± 47%    +167.2%     246564 ± 23%  numa-numastat.node1.local_node
     98645 ± 44%    +161.9%     258346 ± 21%  numa-numastat.node1.numa_hit
     27.75 ±  9%     -40.5%      16.50 ±  6%  vmstat.cpu.id
      6.25 ± 28%    +272.0%      23.25 ±  5%  vmstat.cpu.us
    178.50 ± 27%     -78.3%      38.75 ±  4%  vmstat.io.bi
     36059 ±  6%     -14.2%      30956 ±  2%  vmstat.io.bo
   1328891           +24.6%    1655470        vmstat.memory.cache
     11112 ± 12%     -20.5%       8834 ±  3%  vmstat.system.cs
     28.80 ±  9%     -40.5%      17.14 ±  5%  iostat.cpu.idle
      7.14 ± 13%     -24.5%       5.39 ±  2%  iostat.cpu.system
      6.46 ± 27%    +263.6%      23.49 ±  5%  iostat.cpu.user
      1.37 ±  3%     -10.7%       1.22        iostat.sda.avgqu-sz
    346.97 ±  6%     -26.2%     255.90 ±  3%  iostat.sda.avgrq-sz
      9.84 ±  2%     +11.0%      10.93        iostat.sda.util
    121.14 ±  2%     +23.7%     149.85        iostat.sda.w/s
     19961 ±  5%     -11.8%      17610        iostat.sda.wkB/s
     88.86 ±  4%      +9.6%      97.40        iostat.sda.wrqm/s
  20279326 ± 35%    +650.7%  1.522e+08 ± 38%  cpuidle.C1.time
    299578 ± 16%    +525.9%    1875124 ± 22%  cpuidle.C1.usage
  96298070 ± 27%    +363.9%  4.467e+08 ± 32%  cpuidle.C1E.time
    324745 ± 29%    +279.6%    1232581 ± 35%  cpuidle.C1E.usage
 1.005e+08 ± 37%    +211.6%  3.131e+08 ±  8%  cpuidle.C3.time
    282616 ± 35%    +139.7%     677380 ± 52%  cpuidle.C3.usage
 2.981e+08 ± 13%    +210.5%  9.256e+08 ±  8%  cpuidle.C6.time
    363597 ±  7%    +191.1%    1058366 ± 11%  cpuidle.C6.usage
     48812 ± 35%   +1775.0%     915237 ±131%  cpuidle.POLL.time
     76720 ± 42%    +418.0%     397431 ± 28%  cpuidle.POLL.usage
    322430           +44.9%     467345        meminfo.Active
     72883 ±  5%    +194.7%     214811        meminfo.Active(file)
    101543 ± 10%     +95.2%     198169        meminfo.AnonHugePages
   1236230           +14.6%    1416469        meminfo.Cached
    778.50 ±  7%     +40.3%       1092 ±  5%  meminfo.Dirty
     55357 ±  2%     +77.4%      98223        meminfo.Inactive
     16246           +38.9%      22567 ±  4%  meminfo.Inactive(anon)
     39110 ±  3%     +93.4%      75655 ±  2%  meminfo.Inactive(file)
     92300          +158.6%     238718        meminfo.KReclaimable
   1942348           +16.1%    2254116        meminfo.Memused
    227.75 ±130%    +641.4%       1688 ± 24%  meminfo.Mlocked
     92300          +158.6%     238718        meminfo.SReclaimable
     89450           +45.9%     130499        meminfo.SUnreclaim
     16467           +43.6%      23644 ±  4%  meminfo.Shmem
    181752          +103.1%     369219        meminfo.Slab
      1233 ±  7%     -64.2%     441.75 ± 10%  meminfo.Writeback
     18996 ± 14%     -77.5%       4271 ±  2%  meminfo.max_used_kB
    191433 ± 26%     +73.9%     332877 ± 15%  numa-meminfo.node0.Active
     72301 ±  5%    +179.2%     201850 ±  3%  numa-meminfo.node0.Active(file)
    755.50 ± 10%     +35.3%       1022 ±  6%  numa-meminfo.node0.Dirty
    676145 ±  4%     +29.0%     872381        numa-meminfo.node0.FilePages
     47747 ±  9%     +89.1%      90308 ±  5%  numa-meminfo.node0.Inactive
     11387 ± 49%     +81.2%      20635 ±  5%  numa-meminfo.node0.Inactive(anon)
     36359 ±  7%     +91.6%      69672 ±  6%  numa-meminfo.node0.Inactive(file)
     68533          +200.0%     205610        numa-meminfo.node0.KReclaimable
   1072189 ±  4%     +33.0%    1425930 ±  4%  numa-meminfo.node0.MemUsed
    131.50 ±130%    +530.8%     829.50 ± 24%  numa-meminfo.node0.Mlocked
     68533          +200.0%     205610        numa-meminfo.node0.SReclaimable
     55745 ±  3%     +70.3%      94941 ±  3%  numa-meminfo.node0.SUnreclaim
     11600 ± 48%     +86.9%      21680 ±  5%  numa-meminfo.node0.Shmem
    124278 ±  2%    +141.8%     300552        numa-meminfo.node0.Slab
    867.50 ± 51%     -68.1%     276.50 ± 25%  numa-meminfo.node0.Writeback
    511.50 ± 47%   +2449.8%      13042 ± 43%  numa-meminfo.node1.Active(file)
     23701 ± 10%     +39.7%      33120 ±  9%  numa-meminfo.node1.KReclaimable
     13731 ± 24%     -21.5%      10779        numa-meminfo.node1.Mapped
     95.75 ±131%    +797.1%     859.00 ± 33%  numa-meminfo.node1.Mlocked
     23701 ± 10%     +39.7%      33120 ±  9%  numa-meminfo.node1.SReclaimable
     18083 ±  5%    +179.1%      50464 ±  3%  numa-vmstat.node0.nr_active_file
    307479 ± 11%    +519.9%    1906179 ± 14%  numa-vmstat.node0.nr_dirtied
    198.25 ±  7%     +29.0%     255.75 ±  7%  numa-vmstat.node0.nr_dirty
    169038 ±  4%     +29.0%     218101        numa-vmstat.node0.nr_file_pages
      2846 ± 49%     +81.2%       5159 ±  5%  numa-vmstat.node0.nr_inactive_anon
      9083 ±  7%     +91.8%      17421 ±  6%  numa-vmstat.node0.nr_inactive_file
     32.75 ±131%    +531.3%     206.75 ± 24%  numa-vmstat.node0.nr_mlock
      2900 ± 48%     +86.9%       5420 ±  5%  numa-vmstat.node0.nr_shmem
     17128          +200.1%      51402        numa-vmstat.node0.nr_slab_reclaimable
     13938 ±  3%     +70.3%      23736 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
    185.75 ± 47%     -65.0%      65.00 ± 27%  numa-vmstat.node0.nr_writeback
    306114 ± 11%    +521.7%    1903090 ± 14%  numa-vmstat.node0.nr_written
     18083 ±  5%    +179.1%      50464 ±  3%  numa-vmstat.node0.nr_zone_active_file
      2846 ± 49%     +81.2%       5159 ±  5%  numa-vmstat.node0.nr_zone_inactive_anon
      9083 ±  7%     +91.8%      17421 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
    707100 ±  8%     +87.1%    1322828 ±  6%  numa-vmstat.node0.numa_hit
    697656 ±  8%     +89.0%    1318732 ±  6%  numa-vmstat.node0.numa_local
    128.00 ± 47%   +2446.5%       3259 ± 43%  numa-vmstat.node1.nr_active_file
     39945 ± 69%   +1064.1%     465000 ± 35%  numa-vmstat.node1.nr_dirtied
      3432 ± 24%     -21.5%       2694        numa-vmstat.node1.nr_mapped
     23.75 ±131%    +803.2%     214.50 ± 33%  numa-vmstat.node1.nr_mlock
      5924 ± 10%     +39.8%       8280 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
     39837 ± 69%   +1065.8%     464426 ± 35%  numa-vmstat.node1.nr_written
    128.00 ± 47%   +2446.5%       3259 ± 43%  numa-vmstat.node1.nr_zone_active_file
     62408            +1.2%      63137        proc-vmstat.nr_active_anon
     18216 ±  4%    +194.8%      53704        proc-vmstat.nr_active_file
    714319 ± 10%    +500.0%    4285627 ±  3%  proc-vmstat.nr_dirtied
    205.75 ±  6%     +32.9%     273.50 ±  4%  proc-vmstat.nr_dirty
    308956           +14.6%     354129        proc-vmstat.nr_file_pages
      4062           +38.9%       5643 ±  4%  proc-vmstat.nr_inactive_anon
      9675 ±  4%     +95.6%      18921 ±  2%  proc-vmstat.nr_inactive_file
     11885            -1.1%      11758        proc-vmstat.nr_kernel_stack
     57.00 ±130%    +639.9%     421.75 ± 24%  proc-vmstat.nr_mlock
      1122            -3.6%       1082        proc-vmstat.nr_page_table_pages
      4119           +43.5%       5912 ±  4%  proc-vmstat.nr_shmem
     23069          +158.9%      59734        proc-vmstat.nr_slab_reclaimable
     22375           +45.9%      32639        proc-vmstat.nr_slab_unreclaimable
    252.75 ± 11%     -58.3%     105.50 ±  9%  proc-vmstat.nr_writeback
    707337 ±  9%    +502.7%    4262826 ±  3%  proc-vmstat.nr_written
     62408            +1.2%      63137        proc-vmstat.nr_zone_active_anon
     18216 ±  4%    +194.8%      53704        proc-vmstat.nr_zone_active_file
      4062           +38.9%       5643 ±  4%  proc-vmstat.nr_zone_inactive_anon
      9675 ±  4%     +95.6%      18921 ±  2%  proc-vmstat.nr_zone_inactive_file
    447.25 ±  8%     -16.8%     372.00 ±  4%  proc-vmstat.nr_zone_write_pending
    662642 ±  5%    +198.2%    1975999        proc-vmstat.numa_hit
    646735 ±  5%    +203.1%    1960116        proc-vmstat.numa_local
     80763 ±  6%    +217.7%     256554        proc-vmstat.pgactivate
    814052 ±  5%    +201.0%    2450399        proc-vmstat.pgalloc_normal
      1823 ±  7%    +121.4%       4038 ±  5%  proc-vmstat.pgdeactivate
    431214 ±  8%    +250.6%    1511771 ±  2%  proc-vmstat.pgfault
    773651 ±  6%    +207.9%    2382081 ±  2%  proc-vmstat.pgfree
     19211 ± 10%     +21.0%      23238 ±  4%  proc-vmstat.pgpgin
   3859882 ± 10%    +375.5%   18352553 ±  3%  proc-vmstat.pgpgout
     29797            +1.1%      30135        proc-vmstat.pgrotated
    471257          +272.1%    1753661        proc-vmstat.slabs_scanned
     78816          +138.1%     187665        slabinfo.Acpi-Parse.active_objs
      1100          +134.5%       2579        slabinfo.Acpi-Parse.active_slabs
     80343          +134.4%     188306        slabinfo.Acpi-Parse.num_objs
      1100          +134.5%       2579        slabinfo.Acpi-Parse.num_slabs
      1007 ±  6%    +193.5%       2957 ±  2%  slabinfo.Acpi-State.active_objs
      1325 ±  5%    +146.9%       3272 ±  2%  slabinfo.Acpi-State.num_objs
    495.50 ±  2%     +22.5%     607.00 ±  5%  slabinfo.avc_xperms_data.active_objs
    204.75 ±  4%    +161.1%     534.50 ±  6%  slabinfo.blkdev_ioc.active_objs
    496.50 ±  2%     +63.4%     811.50 ±  5%  slabinfo.blkdev_ioc.num_objs
     36217 ±  3%    +301.5%     145411        slabinfo.btrfs_delayed_node.active_objs
    703.50 ±  3%    +298.1%       2800        slabinfo.btrfs_delayed_node.active_slabs
     36612 ±  3%    +297.8%     145644        slabinfo.btrfs_delayed_node.num_objs
    703.50 ±  3%    +298.1%       2800        slabinfo.btrfs_delayed_node.num_slabs
      1382 ±  5%    +214.6%       4350        slabinfo.btrfs_extent_buffer.active_objs
      1722 ±  5%    +170.7%       4662        slabinfo.btrfs_extent_buffer.num_objs
      5553 ±  3%    +112.5%      11801        slabinfo.btrfs_extent_map.active_objs
    108.25 ±  2%    +166.5%     288.50        slabinfo.btrfs_extent_map.active_slabs
      6082 ±  2%    +166.3%      16199        slabinfo.btrfs_extent_map.num_objs
    108.25 ±  2%    +166.5%     288.50        slabinfo.btrfs_extent_map.num_slabs
     35872 ±  3%    +305.2%     145366        slabinfo.btrfs_inode.active_objs
      1291 ±  3%    +302.5%       5196        slabinfo.btrfs_inode.active_slabs
     36151 ±  3%    +302.5%     145512        slabinfo.btrfs_inode.num_objs
      1291 ±  3%    +302.5%       5196        slabinfo.btrfs_inode.num_slabs
    377.50 ± 16%    +135.5%     889.00 ± 14%  slabinfo.btrfs_ordered_extent.active_objs
    572.00 ± 19%     +90.6%       1090 ± 11%  slabinfo.btrfs_ordered_extent.num_objs
      1355 ± 11%    +144.6%       3316 ±  5%  slabinfo.btrfs_path.active_objs
      1537 ± 10%    +127.5%       3496 ±  5%  slabinfo.btrfs_path.num_objs
     81315          +133.1%     189530        slabinfo.dentry.active_objs
      1959          +130.7%       4520        slabinfo.dentry.active_slabs
     82321          +130.6%     189873        slabinfo.dentry.num_objs
      1959          +130.7%       4520        slabinfo.dentry.num_slabs
      1818           +80.5%       3282 ±  4%  slabinfo.kmalloc-128.active_objs
      4048           +16.7%       4723 ±  3%  slabinfo.kmalloc-128.num_objs
      1522 ±  8%     -20.2%       1215        slabinfo.kmalloc-192.active_objs
    289.00           -43.5%     163.25 ±  2%  slabinfo.kmalloc-8k.active_objs
    334.75           -39.2%     203.50 ±  2%  slabinfo.kmalloc-8k.num_objs
    630.75 ± 16%     +37.9%     869.50 ± 12%  slabinfo.proc_inode_cache.active_objs
     13320           +20.5%      16048        slabinfo.radix_tree_node.active_objs
     14608           +13.3%      16544        slabinfo.radix_tree_node.num_objs
     12170 ± 15%    +542.4%      78185 ±  6%  softirqs.BLOCK
      3690 ±  5%    +635.8%      27156 ±  6%  softirqs.CPU0.BLOCK
     27309 ± 10%    +322.2%     115303 ±  5%  softirqs.CPU0.RCU
     14409 ±  8%    +126.3%      32613 ± 11%  softirqs.CPU0.SCHED
      2616 ±  2%    +686.6%      20580 ±  2%  softirqs.CPU0.TASKLET
     56869 ± 11%    +426.4%     299346 ±  3%  softirqs.CPU0.TIMER
      6362 ± 19%    +421.6%      33187 ±  6%  softirqs.CPU1.BLOCK
     14732 ± 17%    +332.9%      63775 ±  3%  softirqs.CPU1.RCU
      8987 ± 10%    +204.7%      27380 ± 10%  softirqs.CPU1.SCHED
      7344 ± 20%    +485.8%      43021 ±  5%  softirqs.CPU1.TASKLET
     35918 ± 13%    +326.5%     153174 ±  9%  softirqs.CPU1.TIMER
      3058 ± 22%    +388.5%      14938 ± 12%  softirqs.CPU16.RCU
      9104 ± 11%    +309.3%      37263 ± 17%  softirqs.CPU16.TIMER
      3235 ± 11%    +425.9%      17011 ±  8%  softirqs.CPU17.RCU
      9182 ±  7%    +300.7%      36795 ± 15%  softirqs.CPU17.TIMER
      3656 ± 43%    +382.4%      17640 ±  7%  softirqs.CPU18.RCU
      9113 ±  9%    +300.5%      36505 ± 17%  softirqs.CPU18.TIMER
      3133 ±  9%    +437.0%      16828 ± 10%  softirqs.CPU19.RCU
      8885 ±  6%    +308.0%      36249 ± 16%  softirqs.CPU19.TIMER
      9057 ± 18%    +382.8%      43727 ±  7%  softirqs.CPU2.RCU
      3663 ± 24%    +212.0%      11428 ± 13%  softirqs.CPU2.SCHED
     25233 ± 35%    +294.5%      99549 ± 10%  softirqs.CPU2.TIMER
      2690 ± 43%    +257.3%       9612 ± 17%  softirqs.CPU20.RCU
      7410 ±  2%    +183.8%      21032 ± 19%  softirqs.CPU20.TIMER
      2654 ± 38%    +277.0%      10008 ± 10%  softirqs.CPU21.RCU
      7516 ±  5%    +233.3%      25051 ± 27%  softirqs.CPU21.TIMER
      2433 ± 40%    +334.3%      10568 ± 31%  softirqs.CPU22.RCU
      9428 ± 39%    +120.4%      20784 ± 20%  softirqs.CPU22.TIMER
      7385 ±  7%    +210.0%      22895 ± 21%  softirqs.CPU23.TIMER
     10963 ± 17%    +312.7%      45240 ±  6%  softirqs.CPU3.RCU
      4502 ± 19%    +125.6%      10157 ± 10%  softirqs.CPU3.SCHED
     25273 ± 17%    +303.7%     102035 ±  6%  softirqs.CPU3.TIMER
      3945 ±  7%    +562.4%      26134 ±  2%  softirqs.CPU4.RCU
     11596 ±  5%    +433.3%      61840 ± 10%  softirqs.CPU4.TIMER
      4012 ±  7%    +552.0%      26160 ±  7%  softirqs.CPU5.RCU
     11690 ±  4%    +424.2%      61275 ± 17%  softirqs.CPU5.TIMER
      4329 ± 18%    +557.8%      28479 ±  4%  softirqs.CPU6.RCU
     11685 ±  3%    +417.8%      60510 ± 14%  softirqs.CPU6.TIMER
      4890 ±  8%    +412.6%      25065 ± 12%  softirqs.CPU7.RCU
     12680 ± 13%    +400.3%      63441 ± 15%  softirqs.CPU7.TIMER
    153116 ± 10%    +247.1%     531466 ±  4%  softirqs.RCU
    110587 ±  4%     +76.4%     195064 ±  4%  softirqs.SCHED
     10691 ± 14%    +501.7%      64332 ±  2%  softirqs.TASKLET
    465137 ±  5%    +189.7%    1347412 ±  8%  softirqs.TIMER
      0.12 ± 22%     -80.1%       0.02 ± 60%  perf-stat.i.MPKI
  32264538 ± 34%     -84.8%    4908413 ± 33%  perf-stat.i.branch-instructions
      0.14 ± 20%      -0.1        0.02 ±  6%  perf-stat.i.branch-miss-rate%
   2347695 ± 38%     -84.9%     354908 ± 34%  perf-stat.i.branch-misses
      0.55 ± 20%      -0.4        0.10 ±  3%  perf-stat.i.cache-miss-rate%
    218451 ± 26%     -83.1%      36882 ±  6%  perf-stat.i.cache-misses
    765568 ± 23%     -84.2%     120694 ±  2%  perf-stat.i.cache-references
     11274 ± 10%     -21.7%       8829 ±  3%  perf-stat.i.context-switches
      0.03 ± 13%     -80.8%       0.01 ± 34%  perf-stat.i.cpi
 1.904e+08 ± 29%     -84.4%   29787431 ± 16%  perf-stat.i.cpu-cycles
    267.06 ±  2%     -17.0%     221.78 ±  4%  perf-stat.i.cpu-migrations
     16.67 ± 19%     -83.5%       2.74 ± 21%  perf-stat.i.cycles-between-cache-misses
      0.00 ± 17%      -0.0        0.00 ± 40%  perf-stat.i.dTLB-load-miss-rate%
     58282 ± 12%     -81.8%      10594 ± 12%  perf-stat.i.dTLB-load-misses
  30020546 ± 33%     -84.6%    4617083 ± 30%  perf-stat.i.dTLB-loads
      0.00 ±  3%      -0.0        0.00 ± 21%  perf-stat.i.dTLB-store-miss-rate%
      8607 ± 12%     -83.2%       1448 ±  4%  perf-stat.i.dTLB-store-misses
  15481321 ± 25%     -84.7%    2370348 ± 20%  perf-stat.i.dTLB-stores
      1.62 ± 16%      -1.3        0.28 ±  2%  perf-stat.i.iTLB-load-miss-rate%
     17137 ± 13%     -83.3%       2865 ±  4%  perf-stat.i.iTLB-load-misses
      3563 ±  6%     -82.2%     634.96 ±  5%  perf-stat.i.iTLB-loads
  1.53e+08 ± 34%     -84.8%   23283520 ± 33%  perf-stat.i.instructions
    164.81 ± 38%     -83.5%      27.27 ± 33%  perf-stat.i.instructions-per-iTLB-miss
      0.01 ± 22%     -82.9%       0.00 ± 23%  perf-stat.i.ipc
      3737 ±  5%     -34.5%       2449        perf-stat.i.minor-faults
      0.39 ± 10%      -0.3        0.07 ± 25%  perf-stat.i.node-load-miss-rate%
      7270 ±  9%     -80.5%       1414 ± 24%  perf-stat.i.node-load-misses
     43041 ± 28%     -83.3%       7194 ± 20%  perf-stat.i.node-loads
      0.28 ± 28%      -0.2        0.06 ± 40%  perf-stat.i.node-store-miss-rate%
     46796 ± 52%     -81.0%       8897 ± 30%  perf-stat.i.node-stores
      3738 ±  5%     -34.5%       2449        perf-stat.i.page-faults
  32033779 ± 34%     -84.6%    4918392 ± 33%  perf-stat.ps.branch-instructions
   2331066 ± 38%     -84.7%     355655 ± 34%  perf-stat.ps.branch-misses
    217143 ± 26%     -83.0%      36975 ±  6%  perf-stat.ps.cache-misses
    760933 ± 23%     -84.1%     120998 ±  2%  perf-stat.ps.cache-references
     11164 ± 10%     -21.0%       8816 ±  3%  perf-stat.ps.context-switches
 1.892e+08 ± 28%     -84.2%   29855538 ± 16%  perf-stat.ps.cpu-cycles
    264.50 ±  2%     -16.3%     221.45 ±  4%  perf-stat.ps.cpu-migrations
     57898 ± 12%     -81.7%      10617 ± 12%  perf-stat.ps.dTLB-load-misses
  29806077 ± 32%     -84.5%    4626290 ± 30%  perf-stat.ps.dTLB-loads
      8557 ± 11%     -83.0%       1452 ±  4%  perf-stat.ps.dTLB-store-misses
  15376824 ± 25%     -84.6%    2375476 ± 20%  perf-stat.ps.dTLB-stores
     17027 ± 13%     -83.1%       2871 ±  4%  perf-stat.ps.iTLB-load-misses
      3538 ±  6%     -82.0%     635.92 ±  5%  perf-stat.ps.iTLB-loads
 1.519e+08 ± 34%     -84.6%   23330678 ± 33%  perf-stat.ps.instructions
      3702 ±  5%     -34.0%       2445        perf-stat.ps.minor-faults
      7222 ±  9%     -80.4%       1417 ± 24%  perf-stat.ps.node-load-misses
     42707 ± 28%     -83.1%       7201 ± 20%  perf-stat.ps.node-loads
     46491 ± 52%     -80.8%       8914 ± 30%  perf-stat.ps.node-stores
      3703 ±  5%     -34.0%       2445        perf-stat.ps.page-faults
     90.25 ± 14%    +487.3%     530.00 ± 20%  interrupts.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
    114.00 ± 46%    +168.2%     305.75 ±  2%  interrupts.36:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
     58.00 ± 17%    +764.7%     501.50 ± 39%  interrupts.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
    150.75 ± 80%    +267.7%     554.25 ± 40%  interrupts.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
     79.75 ± 54%    +392.2%     392.50 ± 38%  interrupts.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     58.00 ± 16%    +563.4%     384.75 ± 21%  interrupts.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
     14555 ± 60%    +774.3%     127259 ±  2%  interrupts.75:IR-PCI-MSI.2097152-edge.isci-msix
     83416 ± 14%     +46.7%     122365 ± 12%  interrupts.CAL:Function_call_interrupts
     33.75 ± 33%    +462.2%     189.75 ± 17%  interrupts.CPU0.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
     83.00 ± 62%    +207.2%     255.00 ± 34%  interrupts.CPU0.36:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
     16.75 ± 25%   +1120.9%     204.50 ± 52%  interrupts.CPU0.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
     81.75 ± 81%    +244.3%     281.50 ± 39%  interrupts.CPU0.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
     24.00 ± 55%    +508.3%     146.00 ± 53%  interrupts.CPU0.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     15.25 ±  5%    +713.1%     124.00 ± 21%  interrupts.CPU0.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
      3862 ± 57%    +963.2%      41061 ±  2%  interrupts.CPU0.75:IR-PCI-MSI.2097152-edge.isci-msix
      3046 ±  6%    +185.7%       8703 ± 32%  interrupts.CPU0.CAL:Function_call_interrupts
    215872 ± 13%    +444.1%    1174553 ±  4%  interrupts.CPU0.LOC:Local_timer_interrupts
     13610 ± 36%    +177.6%      37781 ±  5%  interrupts.CPU0.RES:Rescheduling_interrupts
    133.50 ± 20%    +186.7%     382.75 ± 18%  interrupts.CPU0.TLB:TLB_shootdowns
     39.25 ± 18%    +581.5%     267.50 ± 24%  interrupts.CPU1.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
     70.50 ± 20%     +74.5%     123.00 ±  4%  interrupts.CPU1.39:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
     47.50 ± 40%    +394.2%     234.75 ± 23%  interrupts.CPU1.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     18.75 ±  6%    +348.0%      84.00 ± 18%  interrupts.CPU1.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
     10570 ± 63%    +713.9%      86036 ±  5%  interrupts.CPU1.75:IR-PCI-MSI.2097152-edge.isci-msix
      2771 ± 12%    +151.5%       6971 ± 22%  interrupts.CPU1.CAL:Function_call_interrupts
    158997 ± 16%    +401.8%     797825 ±  6%  interrupts.CPU1.LOC:Local_timer_interrupts
      1.75 ±173%  +3.5e+05%       6043 ± 36%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1.75 ±173%  +3.5e+05%       6043 ± 36%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     12388 ± 57%    +157.6%      31915 ±  7%  interrupts.CPU1.RES:Rescheduling_interrupts
     86.00 ± 18%    +162.2%     225.50 ± 20%  interrupts.CPU1.TLB:TLB_shootdowns
      2.25 ± 96%   +4522.2%     104.00 ±162%  interrupts.CPU15.RES:Rescheduling_interrupts
      2108 ± 17%    +176.0%       5817 ± 45%  interrupts.CPU16.CAL:Function_call_interrupts
     23021 ±  7%    +736.9%     192658 ± 13%  interrupts.CPU16.LOC:Local_timer_interrupts
    507.00 ± 78%    +390.3%       2486 ± 40%  interrupts.CPU16.RES:Rescheduling_interrupts
      2179 ± 15%     +70.4%       3714 ±  4%  interrupts.CPU17.CAL:Function_call_interrupts
     23398 ±  7%    +721.0%     192090 ± 13%  interrupts.CPU17.LOC:Local_timer_interrupts
    680.00 ± 89%    +136.8%       1610 ± 28%  interrupts.CPU17.RES:Rescheduling_interrupts
      2453 ± 15%     +85.4%       4548 ± 25%  interrupts.CPU18.CAL:Function_call_interrupts
     24008 ±  6%    +703.4%     192897 ± 13%  interrupts.CPU18.LOC:Local_timer_interrupts
      2090 ± 11%    +120.6%       4610 ± 46%  interrupts.CPU19.CAL:Function_call_interrupts
     23873 ±  7%    +706.9%     192644 ± 13%  interrupts.CPU19.LOC:Local_timer_interrupts
    577.75 ± 91%    +226.9%       1888 ± 30%  interrupts.CPU19.RES:Rescheduling_interrupts
     19.50 ± 53%    +306.4%      79.25 ± 21%  interrupts.CPU2.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
     22.00 ± 34%    +678.4%     171.25 ± 22%  interrupts.CPU2.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
      2630 ±  5%    +117.0%       5707 ± 22%  interrupts.CPU2.CAL:Function_call_interrupts
     88898 ± 29%    +479.2%     514888 ± 10%  interrupts.CPU2.LOC:Local_timer_interrupts
      0.00         +4e+105%       4025 ± 49%  interrupts.CPU2.NMI:Non-maskable_interrupts
      0.00         +4e+105%       4025 ± 49%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      5082 ± 75%    +146.1%      12508 ± 12%  interrupts.CPU2.RES:Rescheduling_interrupts
     37.50 ± 51%    +149.3%      93.50 ± 44%  interrupts.CPU2.TLB:TLB_shootdowns
      1983 ± 13%     +37.3%       2722 ± 13%  interrupts.CPU20.CAL:Function_call_interrupts
     15478 ±  5%    +548.7%     100401 ± 24%  interrupts.CPU20.LOC:Local_timer_interrupts
     15466 ±  4%    +550.7%     100638 ± 24%  interrupts.CPU21.LOC:Local_timer_interrupts
     30.75 ± 25%    +861.8%     295.75 ± 32%  interrupts.CPU21.RES:Rescheduling_interrupts
      1859 ± 16%     +45.2%       2700 ± 22%  interrupts.CPU22.CAL:Function_call_interrupts
     15198 ±  3%    +561.7%     100566 ± 24%  interrupts.CPU22.LOC:Local_timer_interrupts
      1906 ± 15%    +129.3%       4372 ± 48%  interrupts.CPU23.CAL:Function_call_interrupts
     15510 ±  4%    +547.1%     100373 ± 24%  interrupts.CPU23.LOC:Local_timer_interrupts
    227.00 ± 90%    +863.1%       2186 ± 78%  interrupts.CPU23.RES:Rescheduling_interrupts
     46.25 ± 97%    +224.9%     150.25 ± 10%  interrupts.CPU3.38:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      2824 ± 19%    +117.8%       6150 ± 26%  interrupts.CPU3.CAL:Function_call_interrupts
     88752 ± 29%    +479.3%     514160 ± 10%  interrupts.CPU3.LOC:Local_timer_interrupts
      4973 ± 30%    +107.9%      10339 ± 16%  interrupts.CPU3.RES:Rescheduling_interrupts
      2271 ± 10%    +115.2%       4887 ± 23%  interrupts.CPU4.CAL:Function_call_interrupts
     33054 ±  9%    +852.6%     314879 ± 10%  interrupts.CPU4.LOC:Local_timer_interrupts
      1762 ± 36%    +122.6%       3922 ± 36%  interrupts.CPU4.RES:Rescheduling_interrupts
      2366 ±  7%    +164.8%       6265 ± 36%  interrupts.CPU5.CAL:Function_call_interrupts
     33087 ± 10%    +851.6%     314849 ± 10%  interrupts.CPU5.LOC:Local_timer_interrupts
      1270 ± 41%    +181.5%       3575 ± 40%  interrupts.CPU5.RES:Rescheduling_interrupts
      2543 ± 10%    +115.9%       5493 ± 19%  interrupts.CPU6.CAL:Function_call_interrupts
     33202 ±  9%    +847.9%     314737 ± 10%  interrupts.CPU6.LOC:Local_timer_interrupts
      1275 ± 70%    +188.7%       3683 ± 31%  interrupts.CPU6.RES:Rescheduling_interrupts
     32.75 ±110%    +425.2%     172.00 ± 45%  interrupts.CPU7.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
      2281 ± 13%    +148.9%       5679 ± 24%  interrupts.CPU7.CAL:Function_call_interrupts
     33380 ±  9%    +844.3%     315206 ± 10%  interrupts.CPU7.LOC:Local_timer_interrupts
    578.75 ± 34%    +526.6%       3626 ± 40%  interrupts.CPU7.RES:Rescheduling_interrupts
   1047530 ± 12%    +438.4%    5640297 ±  9%  interrupts.LOC:Local_timer_interrupts
    863.25 ± 59%   +4898.7%      43151 ± 24%  interrupts.NMI:Non-maskable_interrupts
    863.25 ± 59%   +4898.7%      43151 ± 24%  interrupts.PMI:Performance_monitoring_interrupts
     45861 ± 29%    +162.8%     120545 ±  2%  interrupts.RES:Rescheduling_interrupts
    343.25 ± 14%    +180.6%     963.25 ± 17%  interrupts.TLB:TLB_shootdowns
    959.64 ±100%     -79.6%     195.46 ±173%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     17007 ± 62%   +1860.2%     333391 ± 98%  sched_debug.cfs_rq:/.load.avg
      0.00       +1.1e+107%     111405 ± 24%  sched_debug.cfs_rq:/.load.min
    188.18 ± 17%    +990.0%       2051 ± 83%  sched_debug.cfs_rq:/.load_avg.avg
      1296 ± 27%    +175.7%       3574 ± 54%  sched_debug.cfs_rq:/.load_avg.max
      4.75 ± 47%  +31555.4%       1503 ± 96%  sched_debug.cfs_rq:/.load_avg.min
    959.64 ±100%     -79.6%     195.46 ±173%  sched_debug.cfs_rq:/.max_vruntime.stddev
     11846 ±  6%   +7399.1%     888367 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
     33194 ± 13%   +2749.7%     945932 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
      6672 ±  8%  +11820.6%     795381 ± 14%  sched_debug.cfs_rq:/.min_vruntime.min
      4324 ±  8%   +1296.5%      60389 ± 27%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.29 ± 13%    +148.6%       0.73 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
      0.00       +5.2e+101%       0.52 ± 13%  sched_debug.cfs_rq:/.nr_running.min
      0.45 ±  4%     -51.6%       0.22 ± 16%  sched_debug.cfs_rq:/.nr_running.stddev
    121.51 ± 22%     -93.8%       7.58 ± 34%  sched_debug.cfs_rq:/.removed.load_avg.avg
      1024           -88.0%     123.37 ± 38%  sched_debug.cfs_rq:/.removed.load_avg.max
    326.63 ± 10%     -91.3%      28.46 ± 31%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      5605 ± 22%     -93.8%     349.00 ± 34%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
     47413           -88.0%       5684 ± 37%  sched_debug.cfs_rq:/.removed.runnable_sum.max
     15063 ± 10%     -91.3%       1308 ± 31%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
     39.99 ± 20%     -92.6%       2.96 ± 44%  sched_debug.cfs_rq:/.removed.util_avg.avg
    431.75 ± 13%     -87.9%      52.25 ± 34%  sched_debug.cfs_rq:/.removed.util_avg.max
    111.67 ±  9%     -90.1%      11.03 ± 41%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      9.48 ± 97%   +1659.9%     166.91 ± 57%  sched_debug.cfs_rq:/.runnable_load_avg.avg
      0.00       +8.7e+103%      86.54 ± 25%  sched_debug.cfs_rq:/.runnable_load_avg.min
     15572 ± 68%   +1898.0%     311140 ±103%  sched_debug.cfs_rq:/.runnable_weight.avg
      0.00       +9.5e+106%      94876 ± 22%  sched_debug.cfs_rq:/.runnable_weight.min
   -270.52        +25569.1%     -69440        sched_debug.cfs_rq:/.spread0.min
      4326 ±  8%   +1295.8%      60390 ± 27%  sched_debug.cfs_rq:/.spread0.stddev
      1641 ± 26%     -51.0%     803.39 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    102.00 ± 92%    +202.1%     308.14 ± 23%  sched_debug.cfs_rq:/.util_avg.min
    289.84 ± 12%     -41.1%     170.78 ± 21%  sched_debug.cfs_rq:/.util_avg.stddev
    443.50 ±  7%     -72.5%     121.90 ± 64%  sched_debug.cfs_rq:/.util_est_enqueued.max
      0.00       +3.4e+103%      34.41 ±116%  sched_debug.cfs_rq:/.util_est_enqueued.min
    121.85 ± 13%     -78.4%      26.33 ± 53%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    540117 ±  3%     +46.0%     788667 ±  3%  sched_debug.cpu.avg_idle.avg
     15537 ±127%   +3862.8%     615726 ±  7%  sched_debug.cpu.avg_idle.min
    246385 ±  5%     -54.1%     112968 ± 26%  sched_debug.cpu.avg_idle.stddev
     32423          +882.0%     318397 ±  5%  sched_debug.cpu.clock.avg
     32425          +881.9%     318397 ±  5%  sched_debug.cpu.clock.max
     32420          +882.1%     318396 ±  5%  sched_debug.cpu.clock.min
      1.27 ±  5%     -73.8%       0.33 ± 16%  sched_debug.cpu.clock.stddev
     32423          +882.0%     318397 ±  5%  sched_debug.cpu.clock_task.avg
     32425          +881.9%     318397 ±  5%  sched_debug.cpu.clock_task.max
     32420          +882.1%     318396 ±  5%  sched_debug.cpu.clock_task.min
      1.27 ±  5%     -73.8%       0.33 ± 16%  sched_debug.cpu.clock_task.stddev
     10.12 ± 94%   +1554.2%     167.40 ± 61%  sched_debug.cpu.cpu_load[0].avg
      0.00       +8.9e+103%      89.29 ± 33%  sched_debug.cpu.cpu_load[0].min
      8.52 ± 61%   +1877.0%     168.35 ± 44%  sched_debug.cpu.cpu_load[1].avg
      0.00       +9.2e+103%      91.70 ± 27%  sched_debug.cpu.cpu_load[1].min
     21.44 ±129%    +743.7%     180.86 ±113%  sched_debug.cpu.cpu_load[1].stddev
      8.85 ± 36%   +1590.0%     149.64 ± 44%  sched_debug.cpu.cpu_load[2].avg
     83.25 ±117%    +630.1%     607.79 ±107%  sched_debug.cpu.cpu_load[2].max
      0.00       +8.2e+103%      82.36 ± 40%  sched_debug.cpu.cpu_load[2].min
     13.58 ± 99%   +1053.0%     156.60 ±114%  sched_debug.cpu.cpu_load[2].stddev
      9.90 ± 23%   +1155.0%     124.26 ± 48%  sched_debug.cpu.cpu_load[3].avg
     76.50 ± 42%    +541.2%     490.54 ±111%  sched_debug.cpu.cpu_load[3].max
      0.00       +6.4e+103%      63.96 ± 42%  sched_debug.cpu.cpu_load[3].min
     12.92 ± 44%    +896.9%     128.83 ±116%  sched_debug.cpu.cpu_load[3].stddev
     11.53 ± 14%    +750.7%      98.10 ± 49%  sched_debug.cpu.cpu_load[4].avg
      0.00       +4.7e+103%      47.34 ± 37%  sched_debug.cpu.cpu_load[4].min
    420.46 ± 17%   +1601.5%       7153 ±  4%  sched_debug.cpu.curr->pid.avg
      1627          +467.6%       9236 ±  4%  sched_debug.cpu.curr->pid.max
      0.00       +5.7e+105%       5712 ±  8%  sched_debug.cpu.curr->pid.min
    668.78 ±  7%    +133.1%       1558 ±  7%  sched_debug.cpu.curr->pid.stddev
     16656 ± 66%   +1924.8%     337260 ± 98%  sched_debug.cpu.load.avg
      0.00       +1.2e+107%     120213 ± 27%  sched_debug.cpu.load.min
      7312 ±  2%   +3882.6%     291227 ±  5%  sched_debug.cpu.nr_load_updates.avg
     14652 ±  2%   +1900.1%     293066 ±  4%  sched_debug.cpu.nr_load_updates.max
      5756 ±  2%   +4946.5%     290501 ±  5%  sched_debug.cpu.nr_load_updates.min
      1428 ±  2%     -48.9%     730.36 ± 50%  sched_debug.cpu.nr_load_updates.stddev
      0.29 ± 16%    +182.4%       0.82 ±  9%  sched_debug.cpu.nr_running.avg
      0.00       +6.4e+101%       0.64 ± 14%  sched_debug.cpu.nr_running.min
      0.45 ±  5%     -53.5%       0.21 ±  9%  sched_debug.cpu.nr_running.stddev
      1375        +43827.9%     604207 ±  3%  sched_debug.cpu.nr_switches.avg
     13207 ± 12%   +4702.9%     634333 ±  3%  sched_debug.cpu.nr_switches.max
    310.50 ±  7%  +1.9e+05%     581402 ±  4%  sched_debug.cpu.nr_switches.min
      2126 ±  9%    +906.4%      21402 ± 24%  sched_debug.cpu.nr_switches.stddev
     10.25 ± 27%   +1350.4%     148.66 ± 40%  sched_debug.cpu.nr_uninterruptible.max
      3.94 ± 11%   +2183.1%      89.93 ± 57%  sched_debug.cpu.nr_uninterruptible.stddev
     32420          +882.1%     318396 ±  5%  sched_debug.cpu_clk
     29544          +968.0%     315520 ±  5%  sched_debug.ktime
     32903          +869.1%     318879 ±  5%  sched_debug.sched_clk
     24.00           -38.6%      14.73 ±  2%  sched_debug.sysctl_sched.sysctl_sched_latency
      3.00           -38.6%       1.84 ±  2%  sched_debug.sysctl_sched.sysctl_sched_min_granularity
      4.00           -38.6%       2.45 ±  2%  sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
     17.69 ± 73%     -17.7        0.00        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.33 ± 71%      -9.3        0.00        perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.87 ± 71%      -8.9        0.00        perf-profile.calltrace.cycles-pp.btrfs_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.61 ± 69%      -6.6        0.00        perf-profile.calltrace.cycles-pp.btrfs_unlink_inode.btrfs_unlink.vfs_unlink.do_unlinkat.do_syscall_64
      6.61 ± 69%      -6.6        0.00        perf-profile.calltrace.cycles-pp.__btrfs_unlink_inode.btrfs_unlink_inode.btrfs_unlink.vfs_unlink.do_unlinkat
      6.50 ± 76%      -6.5        0.00        perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.97 ± 72%      -6.0        0.00        perf-profile.calltrace.cycles-pp.btrfs_evict_inode.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.96 ± 66%      -5.0        0.00        perf-profile.calltrace.cycles-pp.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_unlink_inode.btrfs_unlink.vfs_unlink
      4.70 ± 67%      -4.7        0.00        perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_unlink_inode.btrfs_unlink
      0.00            +0.7        0.71 ± 18%  perf-profile.calltrace.cycles-pp.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +0.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.push_leaf_right.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow
      0.00            +0.8        0.84 ± 24%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +1.0        1.01 ± 11%  perf-profile.calltrace.cycles-pp.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item
      0.00            +1.0        1.05 ± 10%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.1        1.05 ± 10%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.1        1.09 ± 20%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.3        1.28 ± 40%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +1.5        1.49 ± 50%  perf-profile.calltrace.cycles-pp.btrfs_lookup_dentry.btrfs_lookup.path_openat.do_filp_open.do_sys_open
      0.00            +1.5        1.50 ± 50%  perf-profile.calltrace.cycles-pp.btrfs_lookup.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.00            +1.5        1.53 ± 30%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.9        1.92 ± 67%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.btrfs_new_inode.btrfs_create.path_openat
      0.00            +2.0        1.96 ± 22%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
      0.20 ±173%      +2.0        2.17 ± 59%  perf-profile.calltrace.cycles-pp.__btrfs_update_delayed_inode.__btrfs_run_delayed_items.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      0.00            +2.1        2.12 ± 66%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_new_inode.btrfs_create.path_openat.do_filp_open
      0.00            +2.1        2.13 ± 66%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.__btrfs_run_delayed_items.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      0.35 ±173%      +2.3        2.67 ± 24%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      0.00            +2.6        2.55 ± 25%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.03 ±103%      +2.9        3.92 ± 32%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      1.03 ±103%      +3.1        4.13 ± 33%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.78 ± 88%      +3.4        4.14 ± 27%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
      1.25 ±100%      +3.5        4.73 ± 30%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +3.7        3.70 ± 28%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +4.3        4.30 ± 61%  perf-profile.calltrace.cycles-pp.btrfs_new_inode.btrfs_create.path_openat.do_filp_open.do_sys_open
      0.00            +4.4        4.39 ± 22%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.00            +4.6        4.60 ± 29%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +5.3        5.28 ± 20%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +5.4        5.42 ± 19%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt
      0.00            +6.0        5.96 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create
      0.00            +6.0        6.02 ± 14%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create.path_openat
      1.15 ± 75%      +6.1        7.28 ± 22%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry
      0.00            +6.8        6.84 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create.path_openat.do_filp_open
      0.00            +7.2        7.19 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create.path_openat.do_filp_open.do_sys_open
      0.00            +7.4        7.36 ± 22%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
      0.00           +15.6       15.58 ± 37%  perf-profile.calltrace.cycles-pp.btrfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.00           +17.5       17.47 ± 23%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
      0.00           +19.6       19.60 ± 40%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +26.5       26.45 ± 23%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      6.59 ± 65%     +27.7       34.28 ± 18%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      0.00           +31.6       31.64 ± 19%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +31.7       31.70 ± 19%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +31.7       31.70 ± 19%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     17.69 ± 73%     -17.6        0.10 ±173%  perf-profile.children.cycles-pp.do_unlinkat
      9.33 ± 71%      -9.3        0.04 ±173%  perf-profile.children.cycles-pp.vfs_unlink
      8.87 ± 71%      -8.8        0.04 ±173%  perf-profile.children.cycles-pp.btrfs_unlink
      6.61 ± 69%      -6.6        0.03 ±173%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
      6.61 ± 69%      -6.6        0.03 ±173%  perf-profile.children.cycles-pp.btrfs_unlink_inode
      0.02 ±173%      +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.__alloc_file
      0.00            +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.alloc_empty_file
      0.03 ±173%      +0.1        0.12 ± 45%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.10 ± 40%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.find_inode
      0.04 ±100%      +0.1        0.14 ± 31%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.00            +0.1        0.10 ± 43%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.04 ±100%      +0.1        0.15 ± 32%  perf-profile.children.cycles-pp.cpu_load_update
      0.02 ±173%      +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.rcu_irq_enter
      0.00            +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.11 ± 51%  perf-profile.children.cycles-pp.btrfs_alloc_delayed_item
      0.02 ±173%      +0.1        0.14 ± 33%  perf-profile.children.cycles-pp.run_local_timers
      0.04 ±100%      +0.1        0.16 ± 30%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.12 ± 67%  perf-profile.children.cycles-pp.hrtimer_active
      0.00            +0.1        0.12 ± 53%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.05 ±100%      +0.1        0.17 ± 18%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.11 ± 62%      +0.1        0.23 ± 16%  perf-profile.children.cycles-pp.__switch_to_asm
      0.02 ±173%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.02 ±173%      +0.1        0.15 ± 50%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.02 ±173%      +0.1        0.15 ± 35%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.02 ±173%      +0.1        0.16 ± 61%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.02 ±173%      +0.1        0.16 ± 22%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.get_cpu_device
      0.02 ±173%      +0.1        0.16 ± 42%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.14 ± 51%  perf-profile.children.cycles-pp.btrfs_find_free_objectid
      0.00            +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.complete_walk
      0.00            +0.2        0.16 ± 30%  perf-profile.children.cycles-pp.update_blocked_averages
      0.10 ± 80%      +0.2        0.26 ± 36%  perf-profile.children.cycles-pp.__pagevec_release
      0.00            +0.2        0.16 ± 53%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.2        0.16 ± 54%  perf-profile.children.cycles-pp.btrfs_find_free_ino
      0.04 ±173%      +0.2        0.20 ± 42%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.2        0.17 ± 61%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.inode_insert5
      0.02 ±173%      +0.2        0.20 ±  9%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.02 ±173%      +0.2        0.21 ± 38%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.2        0.19 ± 25%  perf-profile.children.cycles-pp.pm_qos_request
      0.02 ±173%      +0.2        0.21 ± 15%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.2        0.19 ± 28%  perf-profile.children.cycles-pp.insert_inode_locked4
      0.02 ±173%      +0.2        0.22 ± 45%  perf-profile.children.cycles-pp.interrupt_entry
      0.09 ±112%      +0.2        0.29 ±  9%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.02 ±173%      +0.2        0.24 ± 68%  perf-profile.children.cycles-pp.__push_leaf_left
      0.03 ±173%      +0.2        0.24 ± 27%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.02 ±173%      +0.2        0.25 ± 31%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.2        0.23 ± 10%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.2        0.23 ± 43%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.2        0.24 ± 52%  perf-profile.children.cycles-pp.d_instantiate_new
      0.00            +0.3        0.25 ± 63%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.03 ±173%      +0.3        0.29 ± 45%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.3        0.26 ± 60%  perf-profile.children.cycles-pp.find_busiest_group
      0.07 ±113%      +0.3        0.33 ± 33%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.00            +0.3        0.27 ± 20%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.06 ±173%      +0.3        0.33 ± 29%  perf-profile.children.cycles-pp.update_rq_clock
      0.07 ±113%      +0.3        0.34 ± 43%  perf-profile.children.cycles-pp.__fput
      0.11 ±173%      +0.3        0.40 ± 66%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.10 ± 80%      +0.3        0.39 ± 29%  perf-profile.children.cycles-pp.push_leaf_left
      0.09 ± 64%      +0.3        0.40 ± 54%  perf-profile.children.cycles-pp.run_timer_softirq
      0.19 ± 79%      +0.3        0.52 ± 61%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.00            +0.3        0.34 ± 56%  perf-profile.children.cycles-pp.load_balance
      0.11 ± 83%      +0.3        0.45 ± 31%  perf-profile.children.cycles-pp.update_curr
      0.19 ± 86%      +0.4        0.56 ± 33%  perf-profile.children.cycles-pp.dequeue_entity
      0.11 ± 83%      +0.4        0.48 ± 65%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.03 ±173%      +0.4        0.40 ± 44%  perf-profile.children.cycles-pp.do_dentry_open
      0.05 ±100%      +0.4        0.43 ± 35%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.07 ±113%      +0.4        0.45 ± 35%  perf-profile.children.cycles-pp.task_work_run
      0.02 ±173%      +0.4        0.41 ± 84%  perf-profile.children.cycles-pp.btrfs_delayed_inode_release_metadata
      0.26 ± 73%      +0.4        0.68 ± 23%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.4        0.42 ± 87%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.00            +0.4        0.42 ± 14%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.05 ±100%      +0.4        0.49 ± 30%  perf-profile.children.cycles-pp.tick_irq_enter
      0.02 ±173%      +0.4        0.46 ± 57%  perf-profile.children.cycles-pp.__push_leaf_right
      0.11 ± 77%      +0.5        0.56 ± 53%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.20 ± 71%      +0.5        0.67 ± 25%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.38 ± 65%      +0.5        0.87 ± 13%  perf-profile.children.cycles-pp.push_leaf_right
      0.08 ±100%      +0.5        0.58 ± 29%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.5        0.51 ± 50%  perf-profile.children.cycles-pp.inode_tree_add
      0.00            +0.5        0.52 ± 81%  perf-profile.children.cycles-pp.alloc_inode
      0.17 ± 72%      +0.5        0.70 ± 46%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.27 ± 71%      +0.5        0.81 ± 27%  perf-profile.children.cycles-pp.native_write_msr
      0.00            +0.6        0.56 ± 50%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.00            +0.6        0.58 ± 82%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.09 ± 69%      +0.6        0.68 ± 37%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.07 ± 59%      +0.6        0.67 ± 21%  perf-profile.children.cycles-pp.irq_enter
      0.24 ± 95%      +0.6        0.88 ± 61%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.02 ±173%      +0.6        0.67 ± 43%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.7        0.66 ± 70%  perf-profile.children.cycles-pp.new_inode
      0.20 ± 60%      +0.7        0.88 ± 40%  perf-profile.children.cycles-pp.unlock_up
      0.00            +0.7        0.70 ± 42%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.10 ±127%      +0.7        0.81 ± 46%  perf-profile.children.cycles-pp.read_tsc
      0.11 ± 62%      +0.7        0.83 ± 27%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.02 ±173%      +0.8        0.78 ± 17%  perf-profile.children.cycles-pp.task_tick_fair
      0.29 ±135%      +0.8        1.08 ± 79%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.26 ± 89%      +0.8        1.06 ± 56%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.12 ± 97%      +0.8        0.93 ± 56%  perf-profile.children.cycles-pp.wait_reserve_ticket
      0.13 ± 67%      +0.8        0.96 ± 28%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.13 ± 70%      +0.9        1.05 ± 33%  perf-profile.children.cycles-pp.clockevents_program_event
      0.16 ± 59%      +1.0        1.16 ± 24%  perf-profile.children.cycles-pp.ktime_get
      0.21 ± 83%      +1.0        1.22 ± 24%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.43 ± 97%      +1.1        1.50 ± 27%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.05 ±102%      +1.1        1.16 ± 11%  perf-profile.children.cycles-pp.schedule_idle
      0.24 ± 81%      +1.3        1.55 ± 18%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.32 ± 89%      +1.3        1.64 ± 17%  perf-profile.children.cycles-pp.__wake_up_common
      0.09 ± 64%      +1.4        1.46 ± 25%  perf-profile.children.cycles-pp.split_leaf
      0.15 ±100%      +1.4        1.58 ± 22%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +1.6        1.57 ± 53%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      0.00            +1.6        1.58 ± 54%  perf-profile.children.cycles-pp.btrfs_lookup
      0.23 ±109%      +1.7        1.89 ± 47%  perf-profile.children.cycles-pp.btrfs_tree_read_lock
      0.00            +1.7        1.73 ± 43%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.37 ± 74%      +1.8        2.15 ± 49%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      2.21 ± 71%      +1.9        4.13 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock
      1.77 ± 58%      +2.0        3.76 ± 29%  perf-profile.children.cycles-pp.setup_items_for_insert
      0.47 ± 74%      +2.4        2.88 ± 21%  perf-profile.children.cycles-pp.menu_select
      1.29 ± 93%      +2.8        4.12 ± 29%  perf-profile.children.cycles-pp.update_process_times
      1.31 ± 91%      +3.0        4.29 ± 30%  perf-profile.children.cycles-pp.tick_sched_handle
      1.58 ± 84%      +3.3        4.92 ± 26%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +4.3        4.33 ± 61%  perf-profile.children.cycles-pp.btrfs_new_inode
      1.81 ± 81%      +4.8        6.62 ± 23%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +6.0        6.04 ± 14%  perf-profile.children.cycles-pp.insert_with_overflow
      0.00            +6.9        6.86 ± 18%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      2.08 ± 78%      +7.0        9.07 ± 25%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +7.2        7.21 ± 18%  perf-profile.children.cycles-pp.btrfs_add_link
      1.62 ± 61%      +9.9       11.49 ± 20%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      2.70 ± 73%     +10.9       13.55 ± 14%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      3.32 ± 70%     +11.0       14.31 ± 13%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.00           +15.6       15.63 ± 37%  perf-profile.children.cycles-pp.btrfs_create
      1.85 ± 60%     +16.9       18.78 ± 21%  perf-profile.children.cycles-pp.intel_idle
      0.31 ± 87%     +19.6       19.91 ± 39%  perf-profile.children.cycles-pp.path_openat
      0.31 ± 87%     +19.7       19.97 ± 39%  perf-profile.children.cycles-pp.do_filp_open
      0.31 ±101%     +20.0       20.34 ± 40%  perf-profile.children.cycles-pp.do_sys_open
      5.93 ± 68%     +22.9       28.78 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter_state
      6.59 ± 65%     +27.7       34.27 ± 18%  perf-profile.children.cycles-pp.do_idle
      6.59 ± 65%     +27.7       34.28 ± 18%  perf-profile.children.cycles-pp.secondary_startup_64
      6.59 ± 65%     +27.7       34.28 ± 18%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00           +31.7       31.70 ± 19%  perf-profile.children.cycles-pp.start_secondary
      0.04 ±100%      +0.1        0.12 ± 21%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.00            +0.1        0.08 ± 26%  perf-profile.self.cycles-pp.rcu_irq_enter
      0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.09 ± 46%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.02 ±173%      +0.1        0.12 ± 24%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.10 ± 40%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.1        0.10 ± 36%  perf-profile.self.cycles-pp.find_inode
      0.04 ±100%      +0.1        0.15 ± 32%  perf-profile.self.cycles-pp.cpu_load_update
      0.04 ±100%      +0.1        0.15 ± 26%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.enqueue_entity
      0.09 ± 64%      +0.1        0.20 ± 18%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.02 ±173%      +0.1        0.14 ± 33%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.1        0.12 ± 53%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.02 ±173%      +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.11 ± 62%      +0.1        0.23 ± 16%  perf-profile.self.cycles-pp.__switch_to_asm
      0.02 ±173%      +0.1        0.14 ± 47%  perf-profile.self.cycles-pp.irq_exit
      0.00            +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.task_tick_fair
      0.00            +0.1        0.13 ± 54%  perf-profile.self.cycles-pp.clockevents_program_event
      0.02 ±173%      +0.1        0.15 ± 50%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.02 ±173%      +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.smp_apic_timer_interrupt
      0.02 ±173%      +0.1        0.15 ± 35%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.02 ±173%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.15 ± 41%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.2        0.16 ± 53%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.05 ±102%      +0.2        0.21 ± 27%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.05 ±102%      +0.2        0.21 ± 56%  perf-profile.self.cycles-pp.run_timer_softirq
      0.00            +0.2        0.17 ± 36%  perf-profile.self.cycles-pp.finish_task_switch
      0.03 ±173%      +0.2        0.20 ± 42%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.18 ± 34%  perf-profile.self.cycles-pp.tick_sched_timer
      0.09 ±124%      +0.2        0.26 ± 62%  perf-profile.self.cycles-pp.btrfs_tree_read_lock
      0.04 ±100%      +0.2        0.22 ± 32%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.2        0.19 ± 25%  perf-profile.self.cycles-pp.pm_qos_request
      0.02 ±173%      +0.2        0.21 ± 41%  perf-profile.self.cycles-pp.try_to_wake_up
      0.02 ±173%      +0.2        0.22 ± 45%  perf-profile.self.cycles-pp.interrupt_entry
      0.07 ±103%      +0.2        0.27 ± 20%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.2        0.20 ± 54%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.11 ± 77%      +0.2        0.31 ± 19%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.00            +0.3        0.27 ± 32%  perf-profile.self.cycles-pp.update_rq_clock
      0.04 ±100%      +0.3        0.34 ± 39%  perf-profile.self.cycles-pp.do_idle
      0.28 ± 67%      +0.3        0.58 ± 15%  perf-profile.self.cycles-pp.__sched_text_start
      0.08 ±173%      +0.3        0.40 ± 66%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.04 ±173%      +0.4        0.42 ± 61%  perf-profile.self.cycles-pp.__btrfs_release_delayed_node
      0.05 ±100%      +0.4        0.43 ± 35%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.10 ± 80%      +0.4        0.49 ± 25%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.4        0.39 ± 59%  perf-profile.self.cycles-pp.inode_tree_add
      0.20 ± 71%      +0.5        0.67 ± 25%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.02 ±173%      +0.5        0.56 ± 41%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.27 ± 71%      +0.5        0.81 ± 27%  perf-profile.self.cycles-pp.native_write_msr
      0.24 ± 63%      +0.6        0.84 ± 27%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.10 ±127%      +0.7        0.76 ± 46%  perf-profile.self.cycles-pp.read_tsc
      0.24 ± 70%      +0.9        1.16 ± 27%  perf-profile.self.cycles-pp.menu_select
      0.00            +1.7        1.72 ± 44%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.85 ± 60%     +16.9       18.76 ± 21%  perf-profile.self.cycles-pp.intel_idle


                                                                                
                      fxmark.hdd_btrfs_MWUM_1_bufferedio.works                  
                                                                                
  180000 +-+----------------------------------------------------------------+   
         O     O O  O     O  O O     O  O  O O  O  O  O O  O  O  O  O O  O  O   
  160000 +-+                                                                |   
  140000 +-+                                                                |   
         |                                                                  |   
  120000 +-+                                                                |   
  100000 +-+                                                                |   
         |                                                                  |   
   80000 +-+                                                                |   
   60000 +-+                                                                |   
         |..+..+.+..+..+..+    +     +     +    +..+..+.+..+..+..+..+.+     |   
   40000 +-+               :   ::   : :   : :  :                            |   
   20000 +-+                : :  :  :  :  : :  :                            |   
         |                  : :  : :   : :   ::                             |   
       0 +-+O----------O----------O-----------------------------------------+   
                                                                                
                                                                                                                                                                
                   fxmark.hdd_btrfs_MWUM_1_bufferedio.works_sec                 
                                                                                
  7000 O-+----------------------------------------------O-----O-------------+   
       |     O  O  O    O  O  O     O     O    O  O  O     O     O O  O  O  O   
  6000 +-+                             O    O                               |   
       |                                                                    |   
  5000 +-+                                                                  |   
       |                                                                    |   
  4000 +-+                                                                  |   
       |                                                                    |   
  3000 +-+                                                                  |   
       |                                                                    |   
  2000 +-++..+..+..+.+..+     +     +     +    +..+..+..+..+..+..+.+..+     |   
       |                 :   : :   : :   : :  :                             |   
  1000 +-+                :  :  :  :  :  : :  :                             |   
       |                  : :   : :   : :   ::                              |   
     0 +-+O----------O-----------O------------------------------------------+   
                                                                                
                                                                                                                                                                
                   fxmark.hdd_btrfs_MWUM_1_bufferedio.sys_sec                   
                                                                                
  8 +-+------------------------------O-----O--------------------------------+   
    O     O  O  O     O  O  O     O     O     O                          O  |   
  7 +-+                                          O  O  O  O  O  O  O  O     O   
  6 +-+                                                                     |   
    |                                                                       |   
  5 +-+                                                                     |   
    |                                                                       |   
  4 +-+                                                                     |   
    |                                                                       |   
  3 +-++..+..+..+..+..+     +     +     +     +..+..+..+..+..+..+..+..+     |   
  2 +-+                :   : :   : :   : :   :                              |   
    |                  :   : :   : :   : :   :                              |   
  1 +-+                 : :   : :   : :   : :                               |   
    |                   : :   : :   : :   : :                               |   
  0 +-+O-----------O-----------O--------------------------------------------+   
                                                                                
                                                                                                                                                                
                   fxmark.hdd_btrfs_MWUM_1_bufferedio.sys_util                  
                                                                                
  30 +-+--------------------------------------------------------------------+   
     O     O  O  O     O  O  O     O     O    O     O  O  O  O              |   
  25 +-+                              O    O     O              O  O  O  O  O   
     |                                                                      |   
     |                                                                      |   
  20 +-+                                                                    |   
     |                                                                      |   
  15 +-+                                                                    |   
     |    .+..+..+..+..+     +           +    +..+..  .+..  .+..+..         |   
  10 +-++.              :    ::    +     :    :     +.    +.       +..+     |   
     |                  :   : :   : :   : :  :                              |   
     |                   :  :  :  : :   : :  :                              |   
   5 +-+                 : :   : :   : :  : :                               |   
     |                    ::    ::   : :   ::                               |   
   0 +-+O-----------O-----------O-------------------------------------------+   
                                                                                
                                                                                                                                                                
                 fxmark.hdd_btrfs_MWUM_1_bufferedio.iowait_util                 
                                                                                
  90 +-+--------------------------------------------------------------------+   
     |     +..+..+..+..+     +     +     +    +..+.    +.    +..+.    +     |   
  80 +-+               :     :     :     :    :                             |   
  70 O-+   O  O  O     O  O  O     O  O  O O  O  O  O  O  O  O  O  O  O  O  O   
     |                  :   : :   : :   ::   :                              |   
  60 +-+                :   : :   : :   : :  :                              |   
  50 +-+                :   : :   : :   : :  :                              |   
     |                  :   : :   : :   : :  :                              |   
  40 +-+                 : :   : :   : :  : :                               |   
  30 +-+                 : :   : :   : :  : :                               |   
     |                   : :   : :   : :  : :                               |   
  20 +-+                 : :   : :   : :   ::                               |   
  10 +-+                  :     :     :    :                                |   
     |                    :     :     :    :                                |   
   0 +-+O-----------O-----------O-------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fxmark.time.system_time                            
                                                                                
  20 +-+---------O-----------------O----------------------------------------+   
  18 O-+   O  O        O  O  O           O    O  O  O  O  O  O  O           |   
     |                                O    O                       O  O  O  O   
  16 +-+                                                                    |   
  14 +-+                                                                    |   
     |                                                                      |   
  12 +-+                                                                    |   
  10 +-+                                                                    |   
   8 +-+                                                                    |   
     |  +..+..+..  .+..+     +     +                  .+..+..               |   
   6 +-+         +.     :   : :   : :    +    +..+..+.       +..+..+..+     |   
   4 +-+                :   : :   : :   : :  :                              |   
     |                   : :   : :   :  : :  :                              |   
   2 +-+                 : :   : :   : :   ::                               |   
   0 +-+O-----------O-----------O-------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fxmark.time.elapsed_time                           
                                                                                
  800 +-+-------------------------------------------------------------------+   
      |                            O     O     O                            |   
  700 O-+   O  O  O       O                          O  O  O                |   
  600 +-+               O    O        O     O     O          O  O     O  O  |   
      |                                                            O        O   
  500 +-+                                                                   |   
      |                                                                     |   
  400 +-+                                                                   |   
      |                                                                     |   
  300 +-+                                                                   |   
  200 +-+                                                                   |   
      |                                                                     |   
  100 +-++..+..+..+..+..+    +..   +..   +..   +..+..+..+..+.  .+..+..+     |   
      |.                 + ..    ..    ..    ..              +.             |   
    0 +-+O-----------O----------O-------------------------------------------+   
                                                                                
                                                                                                                                                                
                           fxmark.time.elapsed_time.max                         
                                                                                
  800 +-+-------------------------------------------------------------------+   
      |                            O     O     O                            |   
  700 O-+   O  O  O       O                          O  O  O                |   
  600 +-+               O    O        O     O     O          O  O     O  O  |   
      |                                                            O        O   
  500 +-+                                                                   |   
      |                                                                     |   
  400 +-+                                                                   |   
      |                                                                     |   
  300 +-+                                                                   |   
  200 +-+                                                                   |   
      |                                                                     |   
  100 +-++..+..+..+..+..+    +..   +..   +..   +..+..+..+..+.  .+..+..+     |   
      |.                 + ..    ..    ..    ..              +.             |   
    0 +-+O-----------O----------O-------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.time.involuntary_context_switches                  
                                                                                
  600000 +-+----------------------------------------------------------------+   
         |                                                                  |   
  500000 O-+     O        O          O     O    O                        O  |   
         |     O    O        O O        O    O     O  O O  O  O  O  O O     O   
         |                                                                  |   
  400000 +-+                                                                |   
         |                                                                  |   
  300000 +-+                                                                |   
         |                                                                  |   
  200000 +-+                                                                |   
         |                                                                  |   
         |..+..+.+..+..+..+    +     +     +    +..+..+.+..+..+..+..+.+     |   
  100000 +-+               +  : +   + +   + :  +                            |   
         |                  + :  + +   + +  : +                             |   
       0 +-+O----------O----------O-----------------------------------------+   
                                                                                
                                                                                                                                                                
                           fxmark.time.file_system_outputs                      
                                                                                
  8e+06 +-+-----------------------------------------------------------------+   
        |          O                                                        |   
  7e+06 O-+                         O     O     O                           |   
  6e+06 +-+   O  O       O  O  O                   O O  O  O     O    O  O  |   
        |                              O     O                O     O       O   
  5e+06 +-+                                                                 |   
        |                                                                   |   
  4e+06 +-+                                                                 |   
        |                                                                   |   
  3e+06 +-+                                                                 |   
  2e+06 +-+                                                                 |   
        |                                                                   |   
  1e+06 +-++..+..+.+..+..+..   +..  +..   +..   +..+.+..+..+..+..+..+.+     |   
        |                    ..    +    ..    ..                            |   
      0 +-+O----------O-----------O-----------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
ivb44: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/directio/1HDD/btrfs/x86_64-rhel-7.6/hdd/debian-x86_64-2018-04-03.cgz/ivb44/MWUM/fxmark/0x42d

commit: 
  4438cf50e7 ("doc, block, bfq: add information on bfq execution time")
  56a85fd837 ("loop: properly observe rotational flag of underlying device")

4438cf50e7b315ff 56a85fd8376ef32458efb6ea97a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3371 ±165%     -96.6%     113.96 ± 20%  fxmark.hdd_btrfs_MWUM_12_directio.works/sec
     20.68           -12.1%      18.18 ±  2%  fxmark.hdd_btrfs_MWUM_1_directio.iowait_sec
     87.19           -18.4%      71.15        fxmark.hdd_btrfs_MWUM_1_directio.iowait_util
      0.10 ± 14%     +33.3%       0.14 ±  5%  fxmark.hdd_btrfs_MWUM_1_directio.softirq_sec
      2.71 ±  3%    +154.4%       6.90        fxmark.hdd_btrfs_MWUM_1_directio.sys_sec
     11.43 ±  2%    +136.3%      27.02        fxmark.hdd_btrfs_MWUM_1_directio.sys_util
      0.22 ± 10%     +46.8%       0.33 ±  3%  fxmark.hdd_btrfs_MWUM_1_directio.user_sec
      0.94 ±  9%     +36.5%       1.28 ±  4%  fxmark.hdd_btrfs_MWUM_1_directio.user_util
     47985          +259.9%     172720        fxmark.hdd_btrfs_MWUM_1_directio.works
      1999          +236.5%       6728 ±  2%  fxmark.hdd_btrfs_MWUM_1_directio.works/sec
      1.94 ± 10%     -32.8%       1.30        fxmark.hdd_btrfs_MWUM_2_directio.sys_sec
      3.28 ±  9%     -32.8%       2.20        fxmark.hdd_btrfs_MWUM_2_directio.sys_util
      8087 ± 25%     -69.5%       2469 ±  6%  fxmark.hdd_btrfs_MWUM_2_directio.works
    269.28 ± 25%     -69.6%      81.99 ±  6%  fxmark.hdd_btrfs_MWUM_2_directio.works/sec
     22.08 ± 89%    +142.2%      53.47        fxmark.hdd_btrfs_MWUM_4_directio.iowait_sec
     12.83 ± 88%    +134.5%      30.10        fxmark.hdd_btrfs_MWUM_4_directio.real_sec
      3.21 ± 85%     -58.4%       1.34 ±  3%  fxmark.hdd_btrfs_MWUM_4_directio.sys_util
      8.24 ±166%     -97.5%       0.21        fxmark.hdd_btrfs_MWUM_4_directio.user_util
      3255 ±167%     -97.9%      69.79 ±  2%  fxmark.hdd_btrfs_MWUM_4_directio.works/sec
    103.91 ± 14%    +459.5%     581.40 ±  2%  fxmark.time.elapsed_time
    103.91 ± 14%    +459.5%     581.40 ±  2%  fxmark.time.elapsed_time.max
   1090720 ±  5%    +467.3%    6187885        fxmark.time.file_system_outputs
    115485 ±  5%    +314.7%     478935 ±  2%  fxmark.time.involuntary_context_switches
     13.50 ± 28%     +48.1%      20.00 ± 10%  fxmark.time.percent_of_cpu_this_job_got
      6.04          +184.6%      17.20        fxmark.time.system_time
      8.28 ± 54%   +1141.9%     102.86 ± 15%  fxmark.time.user_time
     47465 ±  9%    +246.3%     164378 ±  4%  fxmark.time.voluntary_context_switches
     27.53 ± 13%      -7.7       19.85 ±  5%  mpstat.cpu.all.idle%
      7.44 ± 11%      -2.1        5.37        mpstat.cpu.all.sys%
      9.91 ± 23%     +11.0       20.93 ±  4%  mpstat.cpu.all.usr%
    520961 ± 14%    +241.0%    1776251        numa-numastat.node0.local_node
    532808 ± 14%    +234.4%    1781585 ±  2%  numa-numastat.node0.numa_hit
     97321 ± 37%     +57.3%     153082 ± 17%  numa-numastat.node1.numa_hit
     23.75 ± 13%     -20.0%      19.00 ±  4%  vmstat.cpu.id
      9.75 ± 22%    +108.5%      20.33 ±  4%  vmstat.cpu.us
    171.25 ± 29%     -75.5%      42.00 ± 12%  vmstat.io.bi
     35370 ±  5%      -9.1%      32142 ±  2%  vmstat.io.bo
   1323519           +25.1%    1655202        vmstat.memory.cache
     10548 ±  9%     -12.0%       9282 ±  2%  vmstat.system.cs
     27.25 ± 13%     -27.2%      19.84 ±  5%  iostat.cpu.idle
      6.96 ± 11%     -21.3%       5.48        iostat.cpu.system
      9.53 ± 23%    +118.5%      20.83 ±  4%  iostat.cpu.user
      1.40 ±  6%     -10.4%       1.25        iostat.sda.avgqu-sz
    341.40 ±  6%     -22.7%     263.81        iostat.sda.avgrq-sz
      9.62 ±  2%     +14.3%      11.00        iostat.sda.util
    118.55 ±  3%     +27.3%     150.89        iostat.sda.w/s
     19735 ±  4%      -8.0%      18156        iostat.sda.wkB/s
     85.26 ±  2%     +16.7%      99.46        iostat.sda.wrqm/s
  21547184 ± 47%    +444.1%  1.172e+08 ± 67%  cpuidle.C1.time
    315822 ± 33%    +399.1%    1576235 ± 36%  cpuidle.C1.usage
 1.001e+08 ± 37%    +512.4%  6.129e+08 ±  2%  cpuidle.C1E.time
    265278 ± 39%    +476.8%    1530170        cpuidle.C1E.usage
  38041474 ± 54%    +344.6%  1.691e+08 ± 47%  cpuidle.C3.time
    108012 ± 48%    +367.2%     504612 ± 44%  cpuidle.C3.usage
   4.1e+08 ± 19%    +146.6%  1.011e+09 ±  8%  cpuidle.C6.time
    410345 ± 30%    +291.0%    1604416 ± 19%  cpuidle.C6.usage
     44723 ± 26%    +400.1%     223649 ±  3%  cpuidle.POLL.time
     58595 ± 18%    +525.8%     366715 ±  4%  cpuidle.POLL.usage
    320784           +44.9%     464888        meminfo.Active
     70618 ±  4%    +200.6%     212264        meminfo.Active(file)
    102470 ±  8%     +92.9%     197646        meminfo.AnonHugePages
   1232869           +14.8%    1415574        meminfo.Cached
    778.75 ±  9%     +41.3%       1100 ±  2%  meminfo.Dirty
     54344           +77.7%      96586        meminfo.Inactive
     16242           +34.6%      21862 ±  7%  meminfo.Inactive(anon)
     38101 ±  2%     +96.1%      74722        meminfo.Inactive(file)
     91380          +160.8%     238298        meminfo.KReclaimable
   1937696           +16.2%    2252355        meminfo.Memused
    234.00 ±173%    +457.7%       1305 ± 33%  meminfo.Mlocked
     91380          +160.8%     238298        meminfo.SReclaimable
     89314           +45.1%     129592        meminfo.SUnreclaim
     16473           +38.9%      22883 ±  6%  meminfo.Shmem
    180695          +103.6%     367892        meminfo.Slab
      1150 ± 17%     -56.9%     496.00 ±  6%  meminfo.Writeback
     19295 ± 14%     -77.6%       4328 ±  2%  meminfo.max_used_kB
    175441 ± 29%     +68.6%     295809 ± 10%  numa-meminfo.node0.Active
     69633 ±  5%    +195.6%     205857        numa-meminfo.node0.Active(file)
    819.25 ±  7%     +27.7%       1046 ±  4%  numa-meminfo.node0.Dirty
    679771 ±  3%     +26.1%     857241 ±  3%  numa-meminfo.node0.FilePages
     49955 ±  5%     +76.5%      88160 ±  4%  numa-meminfo.node0.Inactive
     35584 ±  7%    +106.7%      73557        numa-meminfo.node0.Inactive(file)
     67037 ±  2%    +207.5%     206156 ±  2%  numa-meminfo.node0.KReclaimable
   1059620 ±  4%     +29.2%    1368715 ±  4%  numa-meminfo.node0.MemUsed
    135.25 ±173%    +460.7%     758.33 ± 33%  numa-meminfo.node0.Mlocked
     67037 ±  2%    +207.5%     206156 ±  2%  numa-meminfo.node0.SReclaimable
     55564 ±  3%     +68.0%      93333 ±  2%  numa-meminfo.node0.SUnreclaim
    122602 ±  2%    +144.3%     299490 ±  2%  numa-meminfo.node0.Slab
    985.00 ± 84%    +588.7%       6783 ± 35%  numa-meminfo.node1.Active(file)
     52798 ± 63%    +158.8%     136624 ± 17%  numa-meminfo.node1.AnonHugePages
      1871 ± 15%    +288.0%       7261 ± 69%  numa-meminfo.node1.Inactive(anon)
     24434           +31.6%      32159 ±  9%  numa-meminfo.node1.KReclaimable
     24434           +31.6%      32159 ±  9%  numa-meminfo.node1.SReclaimable
      1885 ± 15%    +286.4%       7286 ± 69%  numa-meminfo.node1.Shmem
     58206 ±  3%     +17.6%      68427 ±  6%  numa-meminfo.node1.Slab
     17437 ±  5%    +195.0%      51435        numa-vmstat.node0.nr_active_file
    309678 ± 17%    +598.5%    2163146 ±  5%  numa-vmstat.node0.nr_dirtied
    203.75 ± 12%     +34.8%     274.67 ±  2%  numa-vmstat.node0.nr_dirty
    169986 ±  3%     +26.1%     214269 ±  3%  numa-vmstat.node0.nr_file_pages
      8910 ±  7%    +106.2%      18377        numa-vmstat.node0.nr_inactive_file
     33.25 ±173%    +469.4%     189.33 ± 33%  numa-vmstat.node0.nr_mlock
     16776 ±  2%    +207.1%      51520 ±  2%  numa-vmstat.node0.nr_slab_reclaimable
     13892 ±  3%     +67.9%      23328 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
    308469 ± 17%    +600.1%    2159645 ±  5%  numa-vmstat.node0.nr_written
     17437 ±  5%    +195.0%      51435        numa-vmstat.node0.nr_zone_active_file
      8910 ±  7%    +106.2%      18377        numa-vmstat.node0.nr_zone_inactive_file
    736094 ±  8%     +83.4%    1350345 ±  7%  numa-vmstat.node0.numa_hit
    724374 ±  8%     +85.7%    1345015 ±  7%  numa-vmstat.node0.numa_local
    245.25 ± 85%    +591.4%       1695 ± 35%  numa-vmstat.node1.nr_active_file
     31300 ± 69%    +728.5%     259314 ± 51%  numa-vmstat.node1.nr_dirtied
    467.75 ± 15%    +288.0%       1815 ± 69%  numa-vmstat.node1.nr_inactive_anon
     24.25 ±173%    +460.8%     136.00 ± 33%  numa-vmstat.node1.nr_mlock
    471.00 ± 15%    +286.6%       1821 ± 69%  numa-vmstat.node1.nr_shmem
      6109           +31.6%       8039 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
     31188 ± 69%    +730.6%     259044 ± 51%  numa-vmstat.node1.nr_written
    245.25 ± 85%    +591.4%       1695 ± 35%  numa-vmstat.node1.nr_zone_active_file
    467.75 ± 15%    +288.0%       1815 ± 69%  numa-vmstat.node1.nr_zone_inactive_anon
     17678 ±  4%    +200.4%      53103        proc-vmstat.nr_active_file
    695682 ±  9%    +529.4%    4378932        proc-vmstat.nr_dirtied
    209.00 ±  8%     +30.9%     273.67 ±  5%  proc-vmstat.nr_dirty
    308255           +14.8%     353955        proc-vmstat.nr_file_pages
      4060           +34.6%       5466 ±  7%  proc-vmstat.nr_inactive_anon
      9528 ±  2%     +96.2%      18697        proc-vmstat.nr_inactive_file
     11934            -1.5%      11752        proc-vmstat.nr_kernel_stack
      7469            -1.1%       7386        proc-vmstat.nr_mapped
     58.75 ±173%    +454.3%     325.67 ± 33%  proc-vmstat.nr_mlock
      1110            -2.5%       1082        proc-vmstat.nr_page_table_pages
      4116           +39.0%       5721 ±  6%  proc-vmstat.nr_shmem
     22890          +160.3%      59580        proc-vmstat.nr_slab_reclaimable
     22321           +45.1%      32396        proc-vmstat.nr_slab_unreclaimable
    309.50 ± 10%     -64.1%     111.00 ±  8%  proc-vmstat.nr_writeback
    689573 ±  9%    +531.7%    4356002        proc-vmstat.nr_written
     17678 ±  4%    +200.4%      53103        proc-vmstat.nr_zone_active_file
      4060           +34.6%       5466 ±  7%  proc-vmstat.nr_zone_inactive_anon
      9528 ±  2%     +96.2%      18697        proc-vmstat.nr_zone_inactive_file
    510.50 ±  6%     -25.6%     380.00 ±  3%  proc-vmstat.nr_zone_write_pending
      1222 ± 53%     -97.5%      30.67 ±105%  proc-vmstat.numa_hint_faults_local
    658998 ±  6%    +197.8%    1962342        proc-vmstat.numa_hit
    643072 ±  6%    +202.7%    1946433        proc-vmstat.numa_local
     12977 ± 40%     -54.8%       5864 ± 69%  proc-vmstat.numa_pages_migrated
     81778 ±  8%    +210.7%     254110        proc-vmstat.pgactivate
    818853 ±  6%    +197.9%    2439647        proc-vmstat.pgalloc_normal
      1848 ± 12%    +115.4%       3983 ±  3%  proc-vmstat.pgdeactivate
    429974 ±  9%    +246.4%    1489231 ±  2%  proc-vmstat.pgfault
    798429 ±  7%    +204.6%    2431959        proc-vmstat.pgfree
     12977 ± 40%     -54.8%       5864 ± 69%  proc-vmstat.pgmigrate_success
     19082 ± 12%     +31.3%      25060 ±  8%  proc-vmstat.pgpgin
   3756945 ± 10%    +397.8%   18702952        proc-vmstat.pgpgout
    471743          +270.9%    1749602        proc-vmstat.slabs_scanned
     12230 ± 12%    +513.7%      75057 ±  8%  softirqs.BLOCK
      3697 ±  3%    +588.2%      25444 ±  2%  softirqs.CPU0.BLOCK
     27049 ±  6%    +322.0%     114156 ±  2%  softirqs.CPU0.RCU
     13868 ±  8%    +156.3%      35549 ±  3%  softirqs.CPU0.SCHED
      2637          +661.4%      20081        softirqs.CPU0.TASKLET
     57544 ± 13%    +406.7%     291604 ±  2%  softirqs.CPU0.TIMER
      6178 ± 22%    +491.3%      36529 ±  4%  softirqs.CPU1.BLOCK
     13555 ± 16%    +363.5%      62832 ±  2%  softirqs.CPU1.RCU
      8817 ±  9%    +208.4%      27190 ± 11%  softirqs.CPU1.SCHED
      6914 ± 22%    +518.8%      42781 ±  3%  softirqs.CPU1.TASKLET
     31444 ± 27%    +373.4%     148863 ± 14%  softirqs.CPU1.TIMER
      5257 ± 16%    +221.2%      16886 ±  8%  softirqs.CPU16.RCU
      8750 ± 14%    +290.3%      34157 ± 15%  softirqs.CPU16.TIMER
      3820 ± 24%    +326.3%      16287 ±  5%  softirqs.CPU17.RCU
      9592 ± 29%    +253.1%      33867 ± 16%  softirqs.CPU17.TIMER
      4403 ± 30%    +260.0%      15851 ±  5%  softirqs.CPU18.RCU
      9074 ± 13%    +275.4%      34066 ± 16%  softirqs.CPU18.TIMER
      4065 ± 11%    +286.3%      15702 ± 12%  softirqs.CPU19.RCU
      8643 ± 11%    +288.6%      33591 ± 17%  softirqs.CPU19.TIMER
      8226 ± 21%    +445.4%      44863 ±  6%  softirqs.CPU2.RCU
      3151 ± 25%    +237.0%      10622 ±  7%  softirqs.CPU2.SCHED
     17684 ± 41%    +455.2%      98184 ± 18%  softirqs.CPU2.TIMER
      7360 ±  8%    +156.3%      18864 ±  7%  softirqs.CPU20.TIMER
      2335 ± 18%    +283.0%       8943 ± 20%  softirqs.CPU21.RCU
      7855 ± 15%    +178.4%      21867 ± 18%  softirqs.CPU21.TIMER
      2587 ± 24%    +276.7%       9747 ± 20%  softirqs.CPU22.RCU
      7339 ± 14%    +236.0%      24664 ± 35%  softirqs.CPU22.TIMER
      2880 ±  8%    +245.6%       9954 ± 32%  softirqs.CPU23.RCU
      7477 ± 11%    +161.4%      19549 ±  6%  softirqs.CPU23.TIMER
      8954 ± 20%    +370.9%      42162 ±  5%  softirqs.CPU3.RCU
      3510 ± 24%    +250.9%      12316 ±  7%  softirqs.CPU3.SCHED
     18856 ± 40%    +432.9%     100493 ± 12%  softirqs.CPU3.TIMER
      5110 ±  6%    +416.5%      26393 ±  7%  softirqs.CPU4.RCU
     12345 ± 20%    +391.1%      60631 ± 14%  softirqs.CPU4.TIMER
      5957 ± 23%    +325.4%      25343 ±  5%  softirqs.CPU5.RCU
     11487 ± 13%    +443.1%      62393 ±  8%  softirqs.CPU5.TIMER
      4832 ± 15%    +455.2%      26831 ± 12%  softirqs.CPU6.RCU
     11332 ± 16%    +454.5%      62839 ± 18%  softirqs.CPU6.TIMER
      5257 ± 17%    +407.4%      26674 ±  3%  softirqs.CPU7.RCU
     12022 ± 17%    +438.2%      64705 ± 17%  softirqs.CPU7.TIMER
    165149          +217.1%     523772 ±  3%  softirqs.RCU
    101949 ± 14%     +98.9%     202828        softirqs.SCHED
     10281 ± 14%    +518.5%      63586 ±  2%  softirqs.TASKLET
    429927 ± 13%    +208.1%    1324678 ±  9%  softirqs.TIMER
     78066          +140.2%     187478        slabinfo.Acpi-Parse.active_objs
      1093          +135.6%       2576        slabinfo.Acpi-Parse.active_slabs
     79862          +135.5%     188106        slabinfo.Acpi-Parse.num_objs
      1093          +135.6%       2576        slabinfo.Acpi-Parse.num_slabs
      1126 ±  7%    +160.5%       2934        slabinfo.Acpi-State.active_objs
      1440 ±  5%    +128.4%       3290        slabinfo.Acpi-State.num_objs
    230.25 ± 10%    +118.0%     502.00 ±  6%  slabinfo.blkdev_ioc.active_objs
    535.50 ±  6%     +48.3%     794.33 ±  2%  slabinfo.blkdev_ioc.num_objs
     35428 ±  2%    +308.2%     144624        slabinfo.btrfs_delayed_node.active_objs
    688.00 ±  2%    +304.9%       2785        slabinfo.btrfs_delayed_node.active_slabs
     35813 ±  2%    +304.5%     144873        slabinfo.btrfs_delayed_node.num_objs
    688.00 ±  2%    +304.9%       2785        slabinfo.btrfs_delayed_node.num_slabs
      1354 ±  4%    +219.1%       4320        slabinfo.btrfs_extent_buffer.active_objs
      1659 ±  3%    +178.4%       4618        slabinfo.btrfs_extent_buffer.num_objs
      5328 ±  3%    +121.1%      11783 ±  2%  slabinfo.btrfs_extent_map.active_objs
    104.00 ±  3%    +174.4%     285.33        slabinfo.btrfs_extent_map.active_slabs
      5851 ±  3%    +173.6%      16010        slabinfo.btrfs_extent_map.num_objs
    104.00 ±  3%    +174.4%     285.33        slabinfo.btrfs_extent_map.num_slabs
     35092 ±  2%    +312.1%     144613        slabinfo.btrfs_inode.active_objs
      1261 ±  2%    +309.7%       5169        slabinfo.btrfs_inode.active_slabs
     35342 ±  2%    +309.6%     144765        slabinfo.btrfs_inode.num_objs
      1261 ±  2%    +309.7%       5169        slabinfo.btrfs_inode.num_slabs
    361.75 ± 17%    +144.9%     886.00 ±  5%  slabinfo.btrfs_ordered_extent.active_objs
    514.25 ±  7%    +107.9%       1069 ±  8%  slabinfo.btrfs_ordered_extent.num_objs
      1376 ±  7%    +142.0%       3331        slabinfo.btrfs_path.active_objs
      1577 ±  6%    +123.4%       3522        slabinfo.btrfs_path.num_objs
     80653          +134.7%     189273        slabinfo.dentry.active_objs
      1945          +131.9%       4513        slabinfo.dentry.active_slabs
     81731          +131.9%     189574        slabinfo.dentry.num_objs
      1945          +131.9%       4513        slabinfo.dentry.num_slabs
      1886           +88.2%       3550 ± 14%  slabinfo.kmalloc-128.active_objs
      4081           +21.9%       4975 ±  7%  slabinfo.kmalloc-128.num_objs
      1517 ±  5%     -17.8%       1247 ±  2%  slabinfo.kmalloc-192.active_objs
      8374 ±  3%      -9.6%       7568        slabinfo.kmalloc-8.active_objs
    287.25 ±  2%     -42.8%     164.33        slabinfo.kmalloc-8k.active_objs
    331.50 ±  2%     -39.5%     200.67        slabinfo.kmalloc-8k.num_objs
      3826           -11.5%       3385        slabinfo.lsm_file_cache.active_objs
    638.50 ±  4%     -19.8%     512.33 ±  2%  slabinfo.pde_opener.active_objs
      1000 ±  3%     -10.4%     896.33        slabinfo.pid.active_objs
      1720 ±  5%     +11.4%       1916 ±  6%  slabinfo.pool_workqueue.num_objs
     13389           +19.4%      15989        slabinfo.radix_tree_node.active_objs
     14706           +12.0%      16473        slabinfo.radix_tree_node.num_objs
      5262 ±  3%     -11.7%       4649        slabinfo.vm_area_struct.active_objs
      6173 ±  3%      -9.2%       5606 ±  2%  slabinfo.vm_area_struct.num_objs
    605.00 ±  6%     +67.7%       1014 ±  5%  slabinfo.xfrm_dst_cache.active_objs
    953.75 ±  4%     +41.4%       1348 ±  4%  slabinfo.xfrm_dst_cache.num_objs
      0.20 ± 81%     -88.1%       0.02 ± 17%  perf-stat.i.MPKI
  28930661 ± 28%     -83.6%    4746705 ± 13%  perf-stat.i.branch-instructions
      0.15 ± 15%      -0.1        0.03        perf-stat.i.branch-miss-rate%
   2105071 ± 27%     -83.3%     352162 ± 12%  perf-stat.i.branch-misses
      0.64 ± 16%      -0.5        0.11 ±  5%  perf-stat.i.cache-miss-rate%
    248420 ± 14%     -81.5%      45906 ±  8%  perf-stat.i.cache-misses
    746487 ±  9%     -80.3%     146828 ±  8%  perf-stat.i.cache-references
     10753 ±  9%     -13.8%       9266 ±  2%  perf-stat.i.context-switches
      0.04 ± 56%     -86.1%       0.00 ±  6%  perf-stat.i.cpi
 1.745e+08 ± 16%     -82.0%   31326038 ±  8%  perf-stat.i.cpu-cycles
    248.01 ±  3%     -10.1%     222.96 ±  6%  perf-stat.i.cpu-migrations
     14.01 ± 28%     -82.8%       2.41 ± 13%  perf-stat.i.cycles-between-cache-misses
      0.01 ± 67%      -0.0        0.00 ±  3%  perf-stat.i.dTLB-load-miss-rate%
     63485 ± 19%     -82.7%      11007 ± 10%  perf-stat.i.dTLB-load-misses
  27498834 ± 25%     -83.7%    4474433 ± 13%  perf-stat.i.dTLB-loads
      0.00 ± 31%      -0.0        0.00 ±  9%  perf-stat.i.dTLB-store-miss-rate%
      9473 ±  5%     -79.2%       1972 ±  9%  perf-stat.i.dTLB-store-misses
  14624912 ± 16%     -82.5%    2559744 ±  6%  perf-stat.i.dTLB-stores
      1.66 ± 15%      -1.4        0.29        perf-stat.i.iTLB-load-miss-rate%
     16736 ± 21%     -82.8%       2885 ± 10%  perf-stat.i.iTLB-load-misses
      3205 ± 16%     -81.6%     591.28 ± 16%  perf-stat.i.iTLB-loads
 1.378e+08 ± 27%     -83.6%   22584373 ± 13%  perf-stat.i.instructions
    157.98 ± 38%     -82.7%      27.37 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.01 ± 21%     -82.3%       0.00 ± 10%  perf-stat.i.ipc
      3728 ±  5%     -34.3%       2450        perf-stat.i.minor-faults
     10359 ±  6%      -7.1%       9624 ±  3%  perf-stat.i.msec
      0.45 ± 45%      -0.4        0.08 ±  3%  perf-stat.i.node-load-miss-rate%
     10995 ± 44%     -84.7%       1679 ±  4%  perf-stat.i.node-load-misses
     48917 ± 17%     -84.8%       7451 ±  7%  perf-stat.i.node-loads
      0.31 ± 41%      -0.2        0.07 ±  8%  perf-stat.i.node-store-miss-rate%
      8224 ± 55%     -79.8%       1661 ± 49%  perf-stat.i.node-store-misses
     57973 ± 31%     -86.0%       8139 ± 33%  perf-stat.i.node-stores
      3728 ±  5%     -34.3%       2450        perf-stat.i.page-faults
  28746595 ± 28%     -83.5%    4756457 ± 13%  perf-stat.ps.branch-instructions
   2092001 ± 27%     -83.1%     352907 ± 12%  perf-stat.ps.branch-misses
    247060 ± 13%     -81.4%      45998 ±  8%  perf-stat.ps.cache-misses
    742450 ±  9%     -80.2%     147137 ±  8%  perf-stat.ps.cache-references
     10647 ±  9%     -13.1%       9251 ±  2%  perf-stat.ps.context-switches
 1.735e+08 ± 15%     -81.9%   31393197 ±  8%  perf-stat.ps.cpu-cycles
    245.60 ±  2%      -9.4%     222.60 ±  6%  perf-stat.ps.cpu-migrations
     63084 ± 18%     -82.5%      11028 ± 10%  perf-stat.ps.dTLB-load-misses
  27323655 ± 25%     -83.6%    4483293 ± 13%  perf-stat.ps.dTLB-loads
      9423 ±  5%     -79.0%       1976 ±  9%  perf-stat.ps.dTLB-store-misses
  14535653 ± 15%     -82.4%    2564990 ±  6%  perf-stat.ps.dTLB-stores
     16632 ± 21%     -82.6%       2891 ± 10%  perf-stat.ps.iTLB-load-misses
      3184 ± 15%     -81.4%     592.02 ± 16%  perf-stat.ps.iTLB-loads
 1.369e+08 ± 27%     -83.5%   22630330 ± 13%  perf-stat.ps.instructions
      3694 ±  5%     -33.8%       2446        perf-stat.ps.minor-faults
     10277 ±  6%      -6.5%       9611 ±  3%  perf-stat.ps.msec
     10916 ± 44%     -84.6%       1680 ±  4%  perf-stat.ps.node-load-misses
     48575 ± 17%     -84.7%       7453 ±  7%  perf-stat.ps.node-loads
      8173 ± 55%     -79.6%       1664 ± 49%  perf-stat.ps.node-store-misses
     57618 ± 31%     -85.9%       8147 ± 33%  perf-stat.ps.node-stores
      3694 ±  5%     -33.8%       2446        perf-stat.ps.page-faults
    172.25 ± 91%    +218.3%     548.33 ± 24%  interrupts.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
    102.25 ± 38%    +351.5%     461.67 ± 29%  interrupts.36:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
     57.50 ± 10%    +427.0%     303.00 ±  2%  interrupts.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
    202.50 ±107%    +199.6%     606.67        interrupts.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
     71.00 ± 42%    +355.9%     323.67 ±  7%  interrupts.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     75.50 ± 28%    +515.0%     464.33 ± 47%  interrupts.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
     94.00 ± 35%    +355.3%     428.00 ± 24%  interrupts.CPU0.36:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
    111.75 ±103%    +204.5%     340.33 ±  2%  interrupts.CPU0.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
     20.75 ± 35%    +377.1%      99.00 ±  2%  interrupts.CPU0.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     21.50 ± 20%    +583.7%     147.00 ± 52%  interrupts.CPU0.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
      2810 ±  9%     +83.1%       5146 ±  9%  interrupts.CPU0.CAL:Function_call_interrupts
    189007 ± 27%    +518.5%    1169077 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
    680.75 ±128%    +545.9%       4397 ± 56%  interrupts.CPU0.NMI:Non-maskable_interrupts
    680.75 ±128%    +545.9%       4397 ± 56%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     10187 ± 10%    +260.7%      36743 ±  3%  interrupts.CPU0.RES:Rescheduling_interrupts
    123.25 ± 38%    +234.3%     412.00 ± 22%  interrupts.CPU0.TLB:TLB_shootdowns
     51.50 ± 35%    +348.5%     231.00 ± 26%  interrupts.CPU1.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
     38.75 ± 15%    +434.2%     207.00 ±  4%  interrupts.CPU1.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
     37.00 ± 16%    +247.7%     128.67 ±  6%  interrupts.CPU1.39:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
     42.25 ± 31%    +427.8%     223.00 ±  9%  interrupts.CPU1.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
      2948 ±  8%     +73.3%       5110 ±  5%  interrupts.CPU1.CAL:Function_call_interrupts
    136336 ± 27%    +490.1%     804511 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
     10477 ±  8%    +201.5%      31595 ±  4%  interrupts.CPU1.RES:Rescheduling_interrupts
    131.25 ± 13%     +49.6%     196.33 ±  9%  interrupts.CPU1.TLB:TLB_shootdowns
      2226 ± 15%    +110.4%       4685 ± 27%  interrupts.CPU16.CAL:Function_call_interrupts
     27285 ± 20%    +580.5%     185667 ± 12%  interrupts.CPU16.LOC:Local_timer_interrupts
     27339 ± 19%    +581.6%     186357 ± 12%  interrupts.CPU17.LOC:Local_timer_interrupts
      2180 ± 14%    +146.0%       5365 ± 25%  interrupts.CPU18.CAL:Function_call_interrupts
     27681 ± 18%    +574.6%     186736 ± 12%  interrupts.CPU18.LOC:Local_timer_interrupts
    530.25 ± 39%    +474.1%       3044 ± 54%  interrupts.CPU18.RES:Rescheduling_interrupts
      2163 ± 19%    +157.8%       5576 ± 43%  interrupts.CPU19.CAL:Function_call_interrupts
     27638 ± 17%    +576.2%     186887 ± 12%  interrupts.CPU19.LOC:Local_timer_interrupts
     22.50 ± 37%    +891.1%     223.00 ± 53%  interrupts.CPU2.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
      2509 ± 15%    +103.5%       5106 ± 24%  interrupts.CPU2.CAL:Function_call_interrupts
     68246 ± 44%    +663.7%     521166 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
      3283 ± 16%    +202.1%       9920 ±  6%  interrupts.CPU2.RES:Rescheduling_interrupts
      1985 ± 27%     +77.2%       3517 ± 22%  interrupts.CPU20.CAL:Function_call_interrupts
     20176 ± 25%    +338.7%      88514 ±  4%  interrupts.CPU20.LOC:Local_timer_interrupts
    158.75 ± 85%    +423.5%     831.00 ± 81%  interrupts.CPU20.RES:Rescheduling_interrupts
     17714 ± 21%    +403.0%      89101 ±  4%  interrupts.CPU21.LOC:Local_timer_interrupts
     19989 ± 26%    +345.8%      89114 ±  4%  interrupts.CPU22.LOC:Local_timer_interrupts
      1917 ± 16%     +53.3%       2938 ± 14%  interrupts.CPU23.CAL:Function_call_interrupts
     20259 ± 25%    +337.8%      88694 ±  4%  interrupts.CPU23.LOC:Local_timer_interrupts
     65.50 ± 47%    +935.6%     678.33 ± 42%  interrupts.CPU23.RES:Rescheduling_interrupts
     42.25 ±106%    +213.2%     132.33 ±  3%  interrupts.CPU3.38:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      2459 ±  5%     +65.8%       4079 ± 11%  interrupts.CPU3.CAL:Function_call_interrupts
     67886 ± 44%    +668.3%     521548 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      3210 ± 11%    +258.6%      11513 ±  6%  interrupts.CPU3.RES:Rescheduling_interrupts
     30.75 ± 83%    +291.3%     120.33 ± 14%  interrupts.CPU3.TLB:TLB_shootdowns
      2426 ± 13%     +83.4%       4448 ± 36%  interrupts.CPU4.CAL:Function_call_interrupts
     37124 ± 15%    +761.3%     319758 ±  8%  interrupts.CPU4.LOC:Local_timer_interrupts
      2399 ± 13%     +49.5%       3586 ± 15%  interrupts.CPU5.CAL:Function_call_interrupts
     36954 ± 15%    +766.0%     320024 ±  8%  interrupts.CPU5.LOC:Local_timer_interrupts
      1160 ± 20%    +270.2%       4294 ± 35%  interrupts.CPU5.RES:Rescheduling_interrupts
      2312 ± 13%     +88.3%       4354 ± 36%  interrupts.CPU6.CAL:Function_call_interrupts
     36695 ± 15%    +771.4%     319752 ±  8%  interrupts.CPU6.LOC:Local_timer_interrupts
     26.75 ± 93%    +454.5%     148.33 ± 20%  interrupts.CPU7.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
      2264 ± 14%     +44.9%       3280 ±  4%  interrupts.CPU7.CAL:Function_call_interrupts
     37045 ± 16%    +763.5%     319871 ±  8%  interrupts.CPU7.LOC:Local_timer_interrupts
    988469 ± 19%    +467.0%    5604547 ±  4%  interrupts.LOC:Local_timer_interrupts
    682.50 ±128%   +4928.1%      34316 ± 64%  interrupts.NMI:Non-maskable_interrupts
    682.50 ±128%   +4928.1%      34316 ± 64%  interrupts.PMI:Performance_monitoring_interrupts
     42962 ± 15%    +174.9%     118108 ±  3%  interrupts.RES:Rescheduling_interrupts
    363.75 ± 25%    +174.7%     999.33 ±  8%  interrupts.TLB:TLB_shootdowns
     25990 ±122%   +2646.0%     713704 ± 54%  sched_debug.cfs_rq:/.load.avg
     64235 ± 51%   +9796.7%    6357197 ± 67%  sched_debug.cfs_rq:/.load.max
     12139 ±173%   +1078.2%     143022 ± 13%  sched_debug.cfs_rq:/.load.min
     17932 ± 52%   +9596.0%    1738721 ± 67%  sched_debug.cfs_rq:/.load.stddev
     38895 ±121%   +1749.5%     719393 ± 29%  sched_debug.cfs_rq:/.min_vruntime.avg
     55160 ± 81%   +1328.0%     787707 ± 27%  sched_debug.cfs_rq:/.min_vruntime.max
     34031 ±132%   +1714.5%     617519 ± 30%  sched_debug.cfs_rq:/.min_vruntime.min
      4690 ± 35%   +1321.4%      66668 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.38 ± 34%     +91.5%       0.72 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.08 ±173%    +540.0%       0.53 ± 17%  sched_debug.cfs_rq:/.nr_running.min
      0.42 ± 16%     -47.0%       0.22 ± 16%  sched_debug.cfs_rq:/.nr_running.stddev
     51.26 ± 71%     -76.5%      12.07 ±129%  sched_debug.cfs_rq:/.removed.load_avg.avg
    853.33 ± 34%     -88.0%     102.43 ± 81%  sched_debug.cfs_rq:/.removed.load_avg.max
    192.81 ± 48%     -84.9%      29.03 ±107%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      2358 ± 71%     -76.5%     554.12 ±128%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
     39372 ± 34%     -88.0%       4728 ± 81%  sched_debug.cfs_rq:/.removed.runnable_sum.max
      8865 ± 48%     -84.9%       1335 ±107%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
     19.30 ± 70%     -72.7%       5.27 ±133%  sched_debug.cfs_rq:/.removed.util_avg.avg
    334.25 ± 42%     -88.3%      39.03 ± 96%  sched_debug.cfs_rq:/.removed.util_avg.max
     73.16 ± 55%     -84.2%      11.55 ±118%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     20.06 ±135%    +715.8%     163.62 ± 23%  sched_debug.cfs_rq:/.runnable_load_avg.avg
     36.92 ± 91%   +1230.2%     491.07 ± 42%  sched_debug.cfs_rq:/.runnable_load_avg.max
     11.00 ±173%    +729.4%      91.23 ±  7%  sched_debug.cfs_rq:/.runnable_load_avg.min
     10.98 ± 68%   +1078.5%     129.38 ± 48%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
     20325 ±130%   +3215.0%     673797 ± 55%  sched_debug.cfs_rq:/.runnable_weight.avg
     36337 ± 89%  +17255.7%    6306603 ± 67%  sched_debug.cfs_rq:/.runnable_weight.max
     10942 ±173%    +920.9%     111713 ± 12%  sched_debug.cfs_rq:/.runnable_weight.min
     11513 ± 61%  +14930.8%    1730643 ± 67%  sched_debug.cfs_rq:/.runnable_weight.stddev
     -1228         +6393.3%     -79797        sched_debug.cfs_rq:/.spread0.min
      4690 ± 35%   +1321.3%      66669 ± 12%  sched_debug.cfs_rq:/.spread0.stddev
    613.69 ±  7%     -18.4%     501.06 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
      1466 ± 22%     -47.2%     773.77 ±  8%  sched_debug.cfs_rq:/.util_avg.max
    390.67 ± 34%     -71.6%     110.77 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.max
      0.08 ±173%  +12340.0%      10.37 ±134%  sched_debug.cfs_rq:/.util_est_enqueued.min
    110.31 ± 36%     -73.9%      28.77 ± 15%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    525263 ± 10%     +35.1%     709585 ±  9%  sched_debug.cpu.avg_idle.avg
    113812 ±169%    +390.1%     557751 ± 17%  sched_debug.cpu.avg_idle.min
     47864 ± 54%    +540.1%     306389        sched_debug.cpu.clock.avg
     47866 ± 54%    +540.1%     306389        sched_debug.cpu.clock.max
     47862 ± 54%    +540.1%     306388        sched_debug.cpu.clock.min
      1.05 ± 31%     -70.7%       0.31 ±  5%  sched_debug.cpu.clock.stddev
     47864 ± 54%    +540.1%     306389        sched_debug.cpu.clock_task.avg
     47866 ± 54%    +540.1%     306389        sched_debug.cpu.clock_task.max
     47862 ± 54%    +540.1%     306388        sched_debug.cpu.clock_task.min
      1.05 ± 31%     -70.7%       0.31 ±  5%  sched_debug.cpu.clock_task.stddev
     20.50 ±132%    +659.5%     155.68 ± 25%  sched_debug.cpu.cpu_load[0].avg
     44.08 ± 72%    +744.9%     372.47 ± 56%  sched_debug.cpu.cpu_load[0].max
     11.00 ±173%    +732.7%      91.60 ±  6%  sched_debug.cpu.cpu_load[0].min
     11.62 ± 64%    +747.7%      98.48 ± 63%  sched_debug.cpu.cpu_load[0].stddev
     21.23 ±118%    +457.1%     118.31 ± 26%  sched_debug.cpu.cpu_load[1].avg
     66.50 ± 70%    +300.2%     266.13 ± 47%  sched_debug.cpu.cpu_load[1].max
     11.00 ±173%    +533.9%      69.73 ± 13%  sched_debug.cpu.cpu_load[1].min
     12.94 ± 54%    +421.5%      67.47 ± 51%  sched_debug.cpu.cpu_load[1].stddev
    259.42 ± 13%     -50.6%     128.27 ± 31%  sched_debug.cpu.cpu_load[4].max
    957.37 ± 94%    +594.8%       6651        sched_debug.cpu.curr->pid.avg
      2129 ± 39%    +315.8%       8853        sched_debug.cpu.curr->pid.max
    446.83 ±173%   +1051.5%       5145 ±  2%  sched_debug.cpu.curr->pid.min
    708.90 ± 11%    +128.0%       1616 ±  4%  sched_debug.cpu.curr->pid.stddev
     25516 ±125%   +2655.5%     703092 ± 57%  sched_debug.cpu.load.avg
     64235 ± 51%   +9748.4%    6326187 ± 68%  sched_debug.cpu.load.max
     12139 ±173%   +1040.9%     138498 ± 18%  sched_debug.cpu.load.min
     17351 ± 56%   +9861.2%    1728442 ± 68%  sched_debug.cpu.load.stddev
     21460 ±120%   +1188.5%     276515        sched_debug.cpu.nr_load_updates.avg
     26877 ± 91%    +939.1%     279268        sched_debug.cpu.nr_load_updates.max
     20126 ±130%   +1268.8%     275499        sched_debug.cpu.nr_load_updates.min
      0.37 ± 36%     +92.6%       0.71 ±  4%  sched_debug.cpu.nr_running.avg
      0.08 ±173%    +500.0%       0.50 ± 16%  sched_debug.cpu.nr_running.min
      0.42 ± 16%     -42.6%       0.24 ± 15%  sched_debug.cpu.nr_running.stddev
     43921 ±167%   +1277.1%     604829 ±  5%  sched_debug.cpu.nr_switches.avg
     54096 ±130%   +1084.5%     640782 ±  5%  sched_debug.cpu.nr_switches.max
     42673 ±171%   +1252.3%     577085 ±  5%  sched_debug.cpu.nr_switches.min
      2063 ± 10%   +1163.0%      26068 ± 20%  sched_debug.cpu.nr_switches.stddev
     -1.94         -5537.1%     105.53 ± 47%  sched_debug.cpu.nr_uninterruptible.avg
     15.08 ± 45%   +1351.0%     218.87 ± 35%  sched_debug.cpu.nr_uninterruptible.max
     11.51 ±106%    +687.1%      90.62 ± 38%  sched_debug.cpu.nr_uninterruptible.stddev
     47862 ± 54%    +540.1%     306388        sched_debug.cpu_clk
     44986 ± 58%    +574.6%     303491        sched_debug.ktime
     48925 ± 52%    +527.3%     306925        sched_debug.sched_clk
     12.36 ±122%     -12.4        0.00        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.08 ±103%      -6.1        0.00        perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.62 ±101%      -5.6        0.00        perf-profile.calltrace.cycles-pp.btrfs_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.71 ± 26%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.1        1.14 ± 72%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_new_inode.btrfs_create.path_openat.do_filp_open
      0.18 ±173%      +1.3        1.48 ± 60%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +1.4        1.36 ± 18%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.15 ±173%      +1.5        1.66 ± 53%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      0.31 ±101%      +1.8        2.16 ± 51%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
      0.00            +1.9        1.91 ± 57%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.45 ±114%      +2.3        2.76 ± 54%  perf-profile.calltrace.cycles-pp.__btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_ordered_io.normal_work_helper.process_one_work
      0.00            +2.4        2.42 ± 58%  perf-profile.calltrace.cycles-pp.btrfs_new_inode.btrfs_create.path_openat.do_filp_open.do_sys_open
      0.54 ±122%      +2.5        3.02 ± 56%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_ordered_io.normal_work_helper.process_one_work.worker_thread
      0.00            +2.8        2.77 ± 27%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      0.27 ±173%      +2.8        3.09 ± 45%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.27 ±173%      +2.9        3.18 ± 42%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      0.58 ±100%      +3.0        3.54 ± 41%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      0.93 ±118%      +3.1        4.05 ± 60%  perf-profile.calltrace.cycles-pp.normal_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +3.4        3.39 ± 26%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create
      0.00            +3.4        3.42 ± 26%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_create.path_openat
      0.49 ±100%      +3.5        3.95 ± 38%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +3.9        3.89 ± 54%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +4.1        4.08 ± 31%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_create.path_openat.do_filp_open
      0.00            +4.2        4.23 ± 31%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_create.path_openat.do_filp_open.do_sys_open
      0.79 ±101%      +4.3        5.06 ± 38%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
      1.25 ±101%      +7.5        8.72 ± 39%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry
      0.00            +8.0        8.02 ± 34%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
      0.00            +8.7        8.71 ± 42%  perf-profile.calltrace.cycles-pp.btrfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.00           +11.1       11.08 ± 45%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +21.0       20.98 ± 46%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
      0.00           +31.1       31.14 ± 46%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +38.0       37.98 ± 45%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +38.1       38.11 ± 45%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +38.1       38.11 ± 45%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     12.36 ±122%     -12.4        0.00        perf-profile.children.cycles-pp.do_unlinkat
      6.08 ±103%      -6.1        0.00        perf-profile.children.cycles-pp.vfs_unlink
      5.62 ±101%      -5.6        0.00        perf-profile.children.cycles-pp.btrfs_unlink
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.do_faccessat
      0.01 ±173%      +0.1        0.08 ± 31%  perf-profile.children.cycles-pp.block_rsv_use_bytes
      0.00            +0.1        0.09 ± 39%  perf-profile.children.cycles-pp.may_open
      0.01 ±173%      +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.run_local_timers
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.trigger_load_balance
      0.01 ±173%      +0.1        0.11 ± 68%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.10 ± 52%  perf-profile.children.cycles-pp.__d_alloc
      0.01 ±173%      +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.01 ±173%      +0.1        0.12 ± 42%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.01 ±173%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.security_inode_alloc
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.01 ±173%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.13 ± 68%  perf-profile.children.cycles-pp.__push_leaf_left
      0.01 ±173%      +0.1        0.15 ± 66%  perf-profile.children.cycles-pp.cpu_load_update
      0.01 ±173%      +0.1        0.15 ± 30%  perf-profile.children.cycles-pp.d_alloc
      0.01 ±173%      +0.1        0.15 ± 35%  perf-profile.children.cycles-pp.alloc_set_pte
      0.01 ±173%      +0.1        0.15 ± 55%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.1        0.14 ± 43%  perf-profile.children.cycles-pp.btrfs_set_token_64
      0.01 ±173%      +0.1        0.16 ± 44%  perf-profile.children.cycles-pp.inode_init_always
      0.00            +0.1        0.15 ± 33%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.07 ±107%      +0.1        0.22 ± 26%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.00            +0.2        0.15 ±  5%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.01 ±173%      +0.2        0.16 ± 49%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.06 ±128%      +0.2        0.21 ± 41%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.01 ±173%      +0.2        0.17 ± 17%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.2        0.16 ± 41%  perf-profile.children.cycles-pp.tick_program_event
      0.01 ±173%      +0.2        0.17 ± 38%  perf-profile.children.cycles-pp.wp_page_copy
      0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.cpu_load_update_active
      0.00            +0.2        0.17 ± 45%  perf-profile.children.cycles-pp.update_cfs_group
      0.01 ±173%      +0.2        0.18 ± 13%  perf-profile.children.cycles-pp.update_blocked_averages
      0.01 ±173%      +0.2        0.18 ± 82%  perf-profile.children.cycles-pp.do_dentry_open
      0.03 ±173%      +0.2        0.20 ± 30%  perf-profile.children.cycles-pp.push_leaf_left
      0.01 ±173%      +0.2        0.19 ± 43%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.05 ±173%      +0.2        0.24 ± 50%  perf-profile.children.cycles-pp.rb_next
      0.03 ±173%      +0.2        0.21 ± 62%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.2        0.19 ± 47%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.2        0.20 ± 48%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.01 ±173%      +0.2        0.21 ± 72%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.2        0.20 ± 52%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.03 ±173%      +0.2        0.23 ± 50%  perf-profile.children.cycles-pp.do_wp_page
      0.01 ±173%      +0.2        0.24 ± 67%  perf-profile.children.cycles-pp.__push_leaf_right
      0.10 ±146%      +0.2        0.33 ± 58%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.2        0.24 ± 26%  perf-profile.children.cycles-pp.btrfs_alloc_inode
      0.00            +0.2        0.24 ± 54%  perf-profile.children.cycles-pp.inode_tree_add
      0.05 ±173%      +0.2        0.29 ± 57%  perf-profile.children.cycles-pp.clear_state_bit
      0.06 ±173%      +0.3        0.31 ± 47%  perf-profile.children.cycles-pp.timerqueue_del
      0.07 ±173%      +0.3        0.33 ± 49%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.01 ±173%      +0.3        0.27 ± 52%  perf-profile.children.cycles-pp.poll_idle
      0.04 ±173%      +0.3        0.30 ± 51%  perf-profile.children.cycles-pp.find_busiest_group
      0.03 ±173%      +0.3        0.30 ± 31%  perf-profile.children.cycles-pp.interrupt_entry
      0.01 ±173%      +0.3        0.29 ± 73%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.10 ±100%      +0.3        0.38 ± 19%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.01 ±173%      +0.3        0.30 ± 51%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.3        0.29 ± 36%  perf-profile.children.cycles-pp.new_slab
      0.04 ±173%      +0.3        0.34 ± 64%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.07 ±173%      +0.3        0.38 ± 48%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.13 ±115%      +0.3        0.44 ± 33%  perf-profile.children.cycles-pp.update_rq_clock
      0.07 ±107%      +0.3        0.39 ± 25%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.01 ±173%      +0.3        0.33 ± 13%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.3        0.33 ± 13%  perf-profile.children.cycles-pp.menu_reflect
      0.01 ±173%      +0.3        0.36 ± 55%  perf-profile.children.cycles-pp.timerqueue_add
      0.21 ±127%      +0.4        0.57 ± 45%  perf-profile.children.cycles-pp.btrfs_tree_lock
      0.00            +0.4        0.37 ± 38%  perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.4        0.37 ± 38%  perf-profile.children.cycles-pp.__slab_alloc
      0.08 ±100%      +0.4        0.46 ± 16%  perf-profile.children.cycles-pp.run_timer_softirq
      0.18 ±122%      +0.4        0.56 ± 17%  perf-profile.children.cycles-pp.push_leaf_right
      0.01 ±173%      +0.4        0.40 ± 32%  perf-profile.children.cycles-pp.alloc_inode
      0.01 ±173%      +0.4        0.42 ± 36%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.07 ±107%      +0.4        0.49 ± 28%  perf-profile.children.cycles-pp.native_sched_clock
      0.01 ±173%      +0.4        0.44 ± 67%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.03 ±173%      +0.4        0.45 ± 77%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.07 ±107%      +0.4        0.50 ± 26%  perf-profile.children.cycles-pp.sched_clock
      0.01 ±173%      +0.4        0.45 ± 41%  perf-profile.children.cycles-pp.new_inode
      0.00            +0.4        0.45 ± 54%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.13 ±115%      +0.5        0.59 ± 29%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.01 ±173%      +0.5        0.49 ± 72%  perf-profile.children.cycles-pp.wait_reserve_ticket
      0.00            +0.5        0.48 ± 66%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.00            +0.5        0.49 ± 56%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.09 ±173%      +0.5        0.58 ± 68%  perf-profile.children.cycles-pp.irq_enter
      0.00            +0.5        0.50 ± 38%  perf-profile.children.cycles-pp.find_next_bit
      0.17 ±119%      +0.5        0.67 ± 36%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.07 ±107%      +0.5        0.57 ± 18%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.04 ±173%      +0.5        0.54 ± 64%  perf-profile.children.cycles-pp.rebalance_domains
      0.04 ±173%      +0.5        0.57 ± 61%  perf-profile.children.cycles-pp.load_balance
      0.24 ±133%      +0.5        0.77 ± 33%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.11 ±128%      +0.6        0.67 ± 22%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.03 ±173%      +0.6        0.63 ± 66%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.17 ±100%      +0.6        0.79 ± 12%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.14 ±107%      +0.6        0.76 ± 17%  perf-profile.children.cycles-pp.native_write_msr
      0.00            +0.7        0.69 ± 71%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.10 ±173%      +0.7        0.83 ± 30%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.21 ±135%      +0.8        0.98 ± 17%  perf-profile.children.cycles-pp.clockevents_program_event
      0.03 ±173%      +0.8        0.80 ± 27%  perf-profile.children.cycles-pp.schedule_idle
      0.16 ±139%      +0.8        0.95 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.04 ±173%      +0.8        0.84 ± 20%  perf-profile.children.cycles-pp.split_leaf
      0.16 ±139%      +0.9        1.03 ± 30%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.9        0.87 ± 56%  perf-profile.children.cycles-pp.btrfs_lookup
      0.00            +0.9        0.87 ± 56%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      0.14 ±173%      +0.9        1.07 ± 18%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.06 ±128%      +0.9        1.01 ±115%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
      0.06 ±128%      +0.9        1.01 ±115%  perf-profile.children.cycles-pp.cow_file_range
      0.13 ±115%      +1.0        1.09 ± 61%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.15 ±154%      +1.0        1.13 ± 15%  perf-profile.children.cycles-pp.__wake_up_common
      0.19 ±100%      +1.0        1.19 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.26 ±109%      +1.3        1.53 ± 51%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.12 ±173%      +1.3        1.40 ± 51%  perf-profile.children.cycles-pp.btrfs_tree_read_lock
      0.23 ±127%      +1.5        1.70 ± 61%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.04 ±173%      +1.6        1.63 ± 13%  perf-profile.children.cycles-pp.scheduler_tick
      0.82 ±134%      +1.9        2.72 ± 37%  perf-profile.children.cycles-pp.setup_items_for_insert
      0.24 ±122%      +2.0        2.20 ± 62%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +2.5        2.45 ± 59%  perf-profile.children.cycles-pp.btrfs_new_inode
      0.54 ±122%      +2.5        3.02 ± 56%  perf-profile.children.cycles-pp.insert_reserved_file_extent
      0.41 ±149%      +3.1        3.48 ± 38%  perf-profile.children.cycles-pp.update_process_times
      1.00 ±102%      +3.1        4.12 ± 26%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.93 ±118%      +3.1        4.05 ± 60%  perf-profile.children.cycles-pp.normal_work_helper
      0.42 ±149%      +3.1        3.57 ± 35%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +3.4        3.45 ± 27%  perf-profile.children.cycles-pp.insert_with_overflow
      0.69 ±111%      +3.5        4.15 ± 32%  perf-profile.children.cycles-pp.tick_sched_timer
      0.77 ±106%      +3.7        4.51 ± 18%  perf-profile.children.cycles-pp.irq_exit
      0.00            +4.1        4.11 ± 32%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      0.38 ±102%      +4.2        4.61 ± 54%  perf-profile.children.cycles-pp.menu_select
      0.00            +4.3        4.26 ± 32%  perf-profile.children.cycles-pp.btrfs_add_link
      0.97 ±112%      +5.2        6.13 ± 21%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.85 ±106%      +5.9        6.77 ± 33%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      1.24 ±104%      +7.3        8.55 ± 21%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +8.8        8.78 ± 42%  perf-profile.children.cycles-pp.btrfs_create
      0.24 ±101%     +11.2       11.40 ± 46%  perf-profile.children.cycles-pp.path_openat
      0.24 ±101%     +11.2       11.42 ± 46%  perf-profile.children.cycles-pp.do_filp_open
      0.30 ±103%     +11.3       11.62 ± 46%  perf-profile.children.cycles-pp.do_sys_open
      1.78 ±100%     +12.0       13.76 ± 15%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      2.22 ±100%     +12.4       14.62 ± 14%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.00           +38.1       38.11 ± 45%  perf-profile.children.cycles-pp.start_secondary
      0.00            +0.1        0.07 ± 28%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.00            +0.1        0.08 ± 36%  perf-profile.self.cycles-pp.irq_enter
      0.00            +0.1        0.08 ± 48%  perf-profile.self.cycles-pp.___slab_alloc
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.trigger_load_balance
      0.01 ±173%      +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.10 ± 31%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.1        0.13 ± 33%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.13 ± 31%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.01 ±173%      +0.1        0.14 ± 62%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.13 ± 43%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.13 ± 36%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.07 ±107%      +0.1        0.20 ± 20%  perf-profile.self.cycles-pp._raw_read_lock
      0.01 ±173%      +0.1        0.15 ± 66%  perf-profile.self.cycles-pp.cpu_load_update
      0.00            +0.1        0.14 ± 37%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.1        0.15 ± 33%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.01 ±173%      +0.2        0.16 ± 49%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.00            +0.2        0.15 ± 55%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.2        0.16 ± 24%  perf-profile.self.cycles-pp.new_slab
      0.01 ±173%      +0.2        0.17 ± 17%  perf-profile.self.cycles-pp.hrtimer_forward
      0.03 ±173%      +0.2        0.18 ± 44%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.2        0.16 ± 41%  perf-profile.self.cycles-pp.tick_program_event
      0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp.cpu_load_update_active
      0.00            +0.2        0.16 ± 44%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.2        0.17 ± 22%  perf-profile.self.cycles-pp.idle_cpu
      0.03 ±173%      +0.2        0.19 ± 62%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.01 ±173%      +0.2        0.18 ± 37%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.07 ±107%      +0.2        0.25 ± 12%  perf-profile.self.cycles-pp.update_rq_clock
      0.05 ±173%      +0.2        0.24 ± 50%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.2        0.19 ± 55%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.00            +0.2        0.20 ± 50%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.00            +0.2        0.21 ± 46%  perf-profile.self.cycles-pp.smp_apic_timer_interrupt
      0.01 ±173%      +0.2        0.23 ± 41%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.10 ±146%      +0.2        0.32 ± 59%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.2        0.23 ± 48%  perf-profile.self.cycles-pp.inode_tree_add
      0.05 ±173%      +0.2        0.29 ± 57%  perf-profile.self.cycles-pp.__btrfs_release_delayed_node
      0.07 ±107%      +0.2        0.31 ± 67%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.01 ±173%      +0.3        0.26 ± 48%  perf-profile.self.cycles-pp.timerqueue_add
      0.01 ±173%      +0.3        0.27 ± 52%  perf-profile.self.cycles-pp.poll_idle
      0.03 ±173%      +0.3        0.30 ± 31%  perf-profile.self.cycles-pp.interrupt_entry
      0.10 ±100%      +0.3        0.37 ± 20%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.3        0.28 ± 12%  perf-profile.self.cycles-pp.menu_reflect
      0.01 ±173%      +0.3        0.29 ± 51%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.03 ±173%      +0.3        0.31 ± 62%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.01 ±173%      +0.3        0.30 ± 16%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.07 ±107%      +0.3        0.37 ± 19%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.03 ±173%      +0.3        0.33 ± 37%  perf-profile.self.cycles-pp.run_timer_softirq
      0.00            +0.3        0.31 ± 72%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.06 ±128%      +0.3        0.39 ± 50%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.4        0.37 ± 63%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.03 ±173%      +0.4        0.43 ± 33%  perf-profile.self.cycles-pp.native_sched_clock
      0.01 ±173%      +0.4        0.44 ± 38%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.5        0.46 ± 44%  perf-profile.self.cycles-pp.find_next_bit
      0.10 ±100%      +0.5        0.64 ± 19%  perf-profile.self.cycles-pp.__sched_text_start
      0.17 ±100%      +0.5        0.72 ± 27%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.11 ±128%      +0.5        0.66 ± 23%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.14 ±107%      +0.6        0.76 ± 17%  perf-profile.self.cycles-pp.native_write_msr
      0.10 ±173%      +0.7        0.82 ± 31%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.12 ±105%      +1.6        1.68 ± 40%  perf-profile.self.cycles-pp.menu_select



***************************************************************************************************
ivb44: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/directio/1HDD/btrfs/x86_64-rhel-7.6/hdd/debian-x86_64-2018-04-03.cgz/ivb44/MWUL/fxmark/0x42d

commit: 
  4438cf50e7 ("doc, block, bfq: add information on bfq execution time")
  56a85fd837 ("loop: properly observe rotational flag of underlying device")

4438cf50e7b315ff 56a85fd8376ef32458efb6ea97a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    193.22 ±  5%     +52.0%     293.74        fxmark.hdd_btrfs_MWUL_12_directio.idle_sec
     33.12 ±  5%     +67.1%      55.34        fxmark.hdd_btrfs_MWUL_12_directio.iowait_sec
     14.29           +10.1%      15.73        fxmark.hdd_btrfs_MWUL_12_directio.iowait_util
     19.83 ±  4%     +52.2%      30.17        fxmark.hdd_btrfs_MWUL_12_directio.real_sec
     19.82 ±  4%     +52.0%      30.12        fxmark.hdd_btrfs_MWUL_12_directio.secs
      4.96           -53.2%       2.32 ± 10%  fxmark.hdd_btrfs_MWUL_12_directio.sys_sec
      2.15 ±  4%     -69.3%       0.66 ± 10%  fxmark.hdd_btrfs_MWUL_12_directio.sys_util
      0.13 ±  5%     -38.0%       0.08 ±  2%  fxmark.hdd_btrfs_MWUL_12_directio.user_util
     41694           -90.3%       4050 ± 12%  fxmark.hdd_btrfs_MWUL_12_directio.works
      2109 ±  4%     -93.6%     134.50 ± 12%  fxmark.hdd_btrfs_MWUL_12_directio.works/sec
    272.51 ± 10%     +50.6%     410.51        fxmark.hdd_btrfs_MWUL_16_directio.idle_sec
     33.40 ± 12%     +66.8%      55.72        fxmark.hdd_btrfs_MWUL_16_directio.iowait_sec
     10.70           +11.0%      11.88        fxmark.hdd_btrfs_MWUL_16_directio.iowait_util
     19.98 ± 10%     +51.0%      30.17        fxmark.hdd_btrfs_MWUL_16_directio.real_sec
     19.92 ± 10%     +51.6%      30.20        fxmark.hdd_btrfs_MWUL_16_directio.secs
      5.28 ±  4%     -55.1%       2.37 ±  6%  fxmark.hdd_btrfs_MWUL_16_directio.sys_sec
      1.71 ±  8%     -70.4%       0.51 ±  6%  fxmark.hdd_btrfs_MWUL_16_directio.sys_util
      0.11 ±  9%     -37.0%       0.07 ±  5%  fxmark.hdd_btrfs_MWUL_16_directio.user_util
     41487           -91.0%       3729 ± 12%  fxmark.hdd_btrfs_MWUL_16_directio.works
      2106 ± 10%     -94.1%     123.51 ± 12%  fxmark.hdd_btrfs_MWUL_16_directio.works/sec
      2.92 ±  3%    +562.3%      19.34 ±  2%  fxmark.hdd_btrfs_MWUL_1_directio.iowait_sec
      4.47 ±  2%    +507.0%      27.16 ±  2%  fxmark.hdd_btrfs_MWUL_1_directio.real_sec
      4.41 ±  2%    +514.1%      27.10 ±  2%  fxmark.hdd_btrfs_MWUL_1_directio.secs
      0.02 ± 19%    +488.9%       0.13 ± 16%  fxmark.hdd_btrfs_MWUL_1_directio.softirq_sec
      1.38 ±  2%    +411.2%       7.07 ±  2%  fxmark.hdd_btrfs_MWUL_1_directio.sys_sec
     31.18 ±  2%     -15.7%      26.29 ±  2%  fxmark.hdd_btrfs_MWUL_1_directio.sys_util
      0.11 ±  6%    +218.2%       0.35 ±  4%  fxmark.hdd_btrfs_MWUL_1_directio.user_sec
      2.48 ±  7%     -47.6%       1.30 ±  3%  fxmark.hdd_btrfs_MWUL_1_directio.user_util
     40914          +306.1%     166158        fxmark.hdd_btrfs_MWUL_1_directio.works
      9278 ±  2%     -33.9%       6136 ±  2%  fxmark.hdd_btrfs_MWUL_1_directio.works/sec
      4.26 ± 16%     +64.6%       7.02 ± 38%  fxmark.hdd_btrfs_MWUL_2_directio.idle_sec
     21.71 ± 15%    +132.2%      50.41 ±  5%  fxmark.hdd_btrfs_MWUL_2_directio.iowait_sec
     74.52 ±  4%     +14.4%      85.28 ±  5%  fxmark.hdd_btrfs_MWUL_2_directio.iowait_util
     14.81 ± 11%    +103.3%      30.11        fxmark.hdd_btrfs_MWUL_2_directio.real_sec
     14.74 ± 11%    +103.8%      30.05        fxmark.hdd_btrfs_MWUL_2_directio.secs
      0.33 ± 13%     -28.2%       0.24 ± 18%  fxmark.hdd_btrfs_MWUL_2_directio.softirq_util
      2.79 ±  3%     -51.2%       1.36 ±  2%  fxmark.hdd_btrfs_MWUL_2_directio.sys_sec
      9.69 ±  8%     -76.3%       2.30 ±  2%  fxmark.hdd_btrfs_MWUL_2_directio.sys_util
      0.65           -52.3%       0.31 ±  6%  fxmark.hdd_btrfs_MWUL_2_directio.user_util
     41050           -92.1%       3249 ±  6%  fxmark.hdd_btrfs_MWUL_2_directio.works
      2821 ± 10%     -96.2%     108.14 ±  6%  fxmark.hdd_btrfs_MWUL_2_directio.works/sec
     29.77 ±  5%    +114.6%      63.89        fxmark.hdd_btrfs_MWUL_4_directio.idle_sec
     22.13 ±  6%    +133.3%      51.63        fxmark.hdd_btrfs_MWUL_4_directio.iowait_sec
     14.37 ±  6%    +110.4%      30.22        fxmark.hdd_btrfs_MWUL_4_directio.real_sec
     14.30 ±  6%    +110.9%      30.16        fxmark.hdd_btrfs_MWUL_4_directio.secs
      0.10 ± 14%     +42.9%       0.15 ± 16%  fxmark.hdd_btrfs_MWUL_4_directio.softirq_sec
      0.19 ±  9%     -32.1%       0.13 ± 17%  fxmark.hdd_btrfs_MWUL_4_directio.softirq_util
      3.59 ±  3%     -38.4%       2.21 ± 10%  fxmark.hdd_btrfs_MWUL_4_directio.sys_sec
      6.45 ±  3%     -71.0%       1.87 ±  9%  fxmark.hdd_btrfs_MWUL_4_directio.sys_util
      0.21 ± 10%     +15.3%       0.24 ±  4%  fxmark.hdd_btrfs_MWUL_4_directio.user_sec
      0.38 ±  7%     -45.5%       0.21 ±  4%  fxmark.hdd_btrfs_MWUL_4_directio.user_util
     41386           -82.2%       7348 ± 15%  fxmark.hdd_btrfs_MWUL_4_directio.works
      2906 ±  6%     -91.6%     243.53 ± 14%  fxmark.hdd_btrfs_MWUL_4_directio.works/sec
    110.14 ± 10%     +61.5%     177.85        fxmark.hdd_btrfs_MWUL_8_directio.idle_sec
     31.07 ± 10%     +74.5%      54.21        fxmark.hdd_btrfs_MWUL_8_directio.iowait_sec
     18.81 ± 10%     +60.1%      30.10        fxmark.hdd_btrfs_MWUL_8_directio.real_sec
     18.78 ± 10%     +60.0%      30.05        fxmark.hdd_btrfs_MWUL_8_directio.secs
      0.10 ± 11%     -32.5%       0.07 ± 16%  fxmark.hdd_btrfs_MWUL_8_directio.softirq_util
      4.58 ±  5%     -51.4%       2.22 ±  8%  fxmark.hdd_btrfs_MWUL_8_directio.sys_sec
      3.15 ±  5%     -69.9%       0.95 ±  8%  fxmark.hdd_btrfs_MWUL_8_directio.sys_util
      0.34 ± 11%     -20.0%       0.27 ±  4%  fxmark.hdd_btrfs_MWUL_8_directio.user_sec
      0.23 ± 13%     -50.6%       0.12 ±  4%  fxmark.hdd_btrfs_MWUL_8_directio.user_util
     41677           -89.7%       4290 ±  9%  fxmark.hdd_btrfs_MWUL_8_directio.works
      2246 ± 11%     -93.6%     142.77 ±  9%  fxmark.hdd_btrfs_MWUL_8_directio.works/sec
    209.59 ±  2%    +407.7%       1064        fxmark.time.elapsed_time
    209.59 ±  2%    +407.7%       1064        fxmark.time.elapsed_time.max
     14186 ±  2%     -20.7%      11254 ±  4%  fxmark.time.file_system_inputs
   1402120 ±  2%    +363.3%    6495744        fxmark.time.file_system_outputs
    108821 ±  4%    +381.2%     523616 ±  5%  fxmark.time.involuntary_context_switches
      7.25 ± 17%     -69.0%       2.25 ± 19%  fxmark.time.percent_of_cpu_this_job_got
      7.89          +141.6%      19.06        fxmark.time.system_time
    167121 ±  2%     +15.3%     192617 ±  2%  fxmark.time.voluntary_context_switches
     35.66 ±  3%      +9.8       45.51        mpstat.cpu.all.iowait%
      5.05            -1.5        3.53 ±  2%  mpstat.cpu.all.sys%
      4.43 ± 15%      -3.5        0.98 ± 16%  mpstat.cpu.all.usr%
    694220 ±  4%    +282.7%    2656546        numa-numastat.node0.local_node
    703679 ±  4%    +279.0%    2666820        numa-numastat.node0.numa_hit
    159588 ± 11%    +155.5%     407780 ± 11%  numa-numastat.node1.local_node
    166029 ± 10%    +149.0%     413398 ± 12%  numa-numastat.node1.numa_hit
     52.50 ±  2%      -7.1%      48.75        vmstat.cpu.id
     35.25 ±  3%     +28.4%      45.25        vmstat.cpu.wa
     99.75 ± 13%     -75.9%      24.00 ± 12%  vmstat.io.bi
     44840           -43.0%      25581        vmstat.io.bo
   1338807           +26.4%    1692708        vmstat.memory.cache
     18901           -59.9%       7576        vmstat.system.cs
     17520 ±  2%     -22.9%      13503 ± 10%  vmstat.system.in
  62746964 ± 12%    +374.6%  2.978e+08 ± 46%  cpuidle.C1.time
   1425690 ±  2%    +173.1%    3893177 ± 39%  cpuidle.C1.usage
 2.554e+08 ± 21%    +484.7%  1.494e+09 ±  9%  cpuidle.C1E.time
    940670 ± 50%    +394.7%    4653803 ± 42%  cpuidle.C1E.usage
 1.083e+09 ± 15%    +332.0%  4.679e+09 ±  9%  cpuidle.C6.time
   1591508 ± 31%    +249.6%    5564109 ±  2%  cpuidle.C6.usage
    218610 ±  2%    +303.8%     882839 ± 73%  cpuidle.POLL.time
    314892 ±  2%    +135.6%     741934 ± 16%  cpuidle.POLL.usage
     54.36 ±  2%      -8.4%      49.79        iostat.cpu.idle
     35.27 ±  3%     +28.8%      45.42        iostat.cpu.iowait
      4.68           -23.5%       3.59        iostat.cpu.system
      4.29 ± 16%     -77.7%       0.96 ± 16%  iostat.cpu.user
      1.38           -18.3%       1.13        iostat.sda.avgqu-sz
    389.97           -47.9%     203.35        iostat.sda.avgrq-sz
     10.65            +6.2%      11.31        iostat.sda.util
    132.07           +19.4%     157.69        iostat.sda.w/s
     24369           -38.4%      15019        iostat.sda.wkB/s
     91.11           +17.1%     106.68        iostat.sda.wrqm/s
    196784 ± 20%     +94.6%     382883 ±  9%  numa-meminfo.node0.Active
     80877 ±  5%    +184.1%     229800 ±  3%  numa-meminfo.node0.Active(file)
    657695 ±  2%     +33.4%     877093 ±  3%  numa-meminfo.node0.FilePages
     43803 ± 11%    +142.4%     106184 ±  4%  numa-meminfo.node0.Inactive
     32692 ±  8%    +188.5%      94307 ±  5%  numa-meminfo.node0.Inactive(file)
     58506 ±  2%    +204.2%     177961        numa-meminfo.node0.KReclaimable
   1016173 ±  5%     +38.7%    1409076 ±  2%  numa-meminfo.node0.MemUsed
     58506 ±  2%    +204.2%     177961        numa-meminfo.node0.SReclaimable
     54423 ±  4%     +58.7%      86372 ±  5%  numa-meminfo.node0.SUnreclaim
    112930 ±  2%    +134.1%     264334 ±  2%  numa-meminfo.node0.Slab
      9361 ± 55%     +70.2%      15936 ± 25%  numa-meminfo.node1.Inactive
     32598 ±  4%     +40.9%      45932 ±  3%  numa-meminfo.node1.KReclaimable
     32598 ±  4%     +40.9%      45932 ±  3%  numa-meminfo.node1.SReclaimable
     70803 ±  3%     +23.3%      87282 ±  6%  numa-meminfo.node1.Slab
    338162           +47.6%     499163        meminfo.Active
     87276          +180.0%     244379        meminfo.Active(file)
    158421           +31.4%     208195        meminfo.AnonHugePages
   1247393           +17.8%    1469212        meminfo.Cached
     53141          +129.7%     122069        meminfo.Inactive
     17515           +34.6%      23581        meminfo.Inactive(anon)
     35625          +176.5%      98488        meminfo.Inactive(file)
     91080          +145.8%     223850        meminfo.KReclaimable
   1925145           +18.7%    2285482        meminfo.Memused
    697.25 ±100%    +140.0%       1673 ± 13%  meminfo.Mlocked
     91080          +145.8%     223850        meminfo.SReclaimable
     92595           +37.9%     127720        meminfo.SUnreclaim
     17846           +39.9%      24961        meminfo.Shmem
    183676           +91.4%     351571        meminfo.Slab
      9537 ±  3%     -74.7%       2414        meminfo.max_used_kB
     20184 ±  5%    +184.6%      57444 ±  3%  numa-vmstat.node0.nr_active_file
    754305 ± 13%    +254.8%    2676564 ±  6%  numa-vmstat.node0.nr_dirtied
    179.50 ±  8%     +26.0%     226.25 ±  3%  numa-vmstat.node0.nr_dirty
    164374 ±  2%     +33.4%     219262 ±  3%  numa-vmstat.node0.nr_file_pages
      8159 ±  8%    +188.9%      23570 ±  5%  numa-vmstat.node0.nr_inactive_file
     88.00 ±102%    +153.7%     223.25        numa-vmstat.node0.nr_mlock
     14626 ±  2%    +204.2%      44487        numa-vmstat.node0.nr_slab_reclaimable
     13605 ±  4%     +58.7%      21593 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
    146.25 ± 20%     -69.6%      44.50 ± 24%  numa-vmstat.node0.nr_writeback
    745730 ± 13%    +258.4%    2672434 ±  6%  numa-vmstat.node0.nr_written
     20184 ±  5%    +184.6%      57444 ±  3%  numa-vmstat.node0.nr_zone_active_file
      8159 ±  8%    +188.9%      23570 ±  5%  numa-vmstat.node0.nr_zone_inactive_file
    310.50 ±  8%     -23.5%     237.50 ±  6%  numa-vmstat.node0.nr_zone_write_pending
    658998 ±  4%    +145.9%    1620694 ±  3%  numa-vmstat.node0.numa_hit
    649527 ±  5%    +147.9%    1610414 ±  3%  numa-vmstat.node0.numa_local
    144908 ± 60%    +212.9%     453395 ± 42%  numa-vmstat.node1.nr_dirtied
      8149 ±  4%     +40.9%      11482 ±  3%  numa-vmstat.node1.nr_slab_reclaimable
    142126 ± 61%    +218.6%     452773 ± 43%  numa-vmstat.node1.nr_written
    574963 ±  5%     +30.1%     747952 ±  9%  numa-vmstat.node1.numa_hit
    413376 ±  8%     +42.2%     587779 ± 11%  numa-vmstat.node1.numa_local
     62731            +1.5%      63696        proc-vmstat.nr_active_anon
     21848          +179.7%      61105        proc-vmstat.nr_active_file
     62693            +1.2%      63433        proc-vmstat.nr_anon_pages
     76.75           +31.9%     101.25        proc-vmstat.nr_anon_transparent_hugepages
   1767315 ±  3%    +253.1%    6241266        proc-vmstat.nr_dirtied
    189.50 ±  2%     +18.5%     224.50 ±  2%  proc-vmstat.nr_dirty
    311881           +17.8%     367315        proc-vmstat.nr_file_pages
      4379           +34.6%       5895        proc-vmstat.nr_inactive_anon
      8891          +176.9%      24624        proc-vmstat.nr_inactive_file
     12107            -3.3%      11705        proc-vmstat.nr_kernel_stack
    174.75 ±100%    +139.3%     418.25 ± 13%  proc-vmstat.nr_mlock
      1122            -2.4%       1095        proc-vmstat.nr_page_table_pages
      4461           +39.9%       6241        proc-vmstat.nr_shmem
     22819          +145.3%      55981        proc-vmstat.nr_slab_reclaimable
     23153           +37.9%      31928        proc-vmstat.nr_slab_unreclaimable
    174.75 ± 14%     -67.1%      57.50 ±  8%  proc-vmstat.nr_writeback
   1739838 ±  3%    +257.2%    6215147        proc-vmstat.nr_written
     62731            +1.5%      63696        proc-vmstat.nr_zone_active_anon
     21848          +179.7%      61105        proc-vmstat.nr_zone_active_file
      4379           +34.6%       5895        proc-vmstat.nr_zone_inactive_anon
      8891          +176.9%      24624        proc-vmstat.nr_zone_inactive_file
    345.25 ±  7%     -27.7%     249.75 ±  2%  proc-vmstat.nr_zone_write_pending
      3707 ± 82%     -66.0%       1262 ±139%  proc-vmstat.numa_hint_faults_local
    897890          +246.4%    3110289        proc-vmstat.numa_hit
    881981          +250.8%    3094390        proc-vmstat.numa_local
    142288          +142.1%     344443 ±  2%  proc-vmstat.pgactivate
   1074500          +235.2%    3601375        proc-vmstat.pgalloc_normal
      3013 ±  2%    +100.8%       6052 ±  2%  proc-vmstat.pgdeactivate
    658693 ±  2%    +288.6%    2559777        proc-vmstat.pgfault
   1069950          +235.7%    3591932        proc-vmstat.pgfree
     21175 ± 11%     +25.8%      26646 ±  7%  proc-vmstat.pgpgin
   9508094 ±  3%    +187.4%   27321590        proc-vmstat.pgpgout
     30091            +1.9%      30666        proc-vmstat.pgrotated
    439624          +285.0%    1692566        proc-vmstat.slabs_scanned
    446.93 ± 24%     +55.0%     692.87 ± 10%  sched_debug.cfs_rq:/.load_avg.avg
    149.94 ± 70%    +139.6%     359.32 ± 21%  sched_debug.cfs_rq:/.load_avg.min
     58835 ± 13%     +27.5%      75024 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
     41480 ± 26%     +56.1%      64749 ± 14%  sched_debug.cfs_rq:/.min_vruntime.min
      0.39 ± 16%     -22.9%       0.30 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
    869.56 ± 10%     -27.8%     627.99 ±  5%  sched_debug.cfs_rq:/.util_avg.max
     69.46 ±117%     -91.1%       6.17 ± 26%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    255.56 ± 26%     -76.6%      59.80 ± 38%  sched_debug.cfs_rq:/.util_est_enqueued.max
     57.09 ± 20%     -73.4%      15.16 ± 31%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    123588          +346.0%     551256 ±  2%  sched_debug.cpu.clock.avg
    123589          +346.0%     551257 ±  2%  sched_debug.cpu.clock.max
    123587          +346.0%     551256 ±  2%  sched_debug.cpu.clock.min
      0.61 ± 11%     -47.4%       0.32 ± 11%  sched_debug.cpu.clock.stddev
    123588          +346.0%     551256 ±  2%  sched_debug.cpu.clock_task.avg
    123589          +346.0%     551257 ±  2%  sched_debug.cpu.clock_task.max
    123587          +346.0%     551256 ±  2%  sched_debug.cpu.clock_task.min
      0.61 ± 11%     -47.4%       0.32 ± 11%  sched_debug.cpu.clock_task.stddev
    135.94 ± 19%     -45.5%      74.09 ± 35%  sched_debug.cpu.cpu_load[4].max
      1861 ± 22%    +331.6%       8035 ±  8%  sched_debug.cpu.curr->pid.avg
      4221          +251.0%      14814 ±  2%  sched_debug.cpu.curr->pid.max
    844.69 ±100%    +502.1%       5085 ± 12%  sched_debug.cpu.curr->pid.min
      1327 ± 30%    +195.7%       3924 ±  5%  sched_debug.cpu.curr->pid.stddev
     96381          +443.8%     524082 ±  2%  sched_debug.cpu.nr_load_updates.avg
     99314          +430.8%     527202 ±  2%  sched_debug.cpu.nr_load_updates.max
     95092          +449.7%     522696 ±  2%  sched_debug.cpu.nr_load_updates.min
      0.39 ± 16%     -22.2%       0.30 ±  3%  sched_debug.cpu.nr_running.stddev
    239136 ± 13%    +185.0%     681612 ±  3%  sched_debug.cpu.nr_switches.avg
    255369 ± 11%    +179.1%     712761 ±  3%  sched_debug.cpu.nr_switches.max
    225112 ± 15%    +189.1%     650706 ±  4%  sched_debug.cpu.nr_switches.min
     10213 ± 26%    +132.5%      23748 ± 29%  sched_debug.cpu.nr_switches.stddev
    -20.55          -959.0%     176.51 ± 27%  sched_debug.cpu.nr_uninterruptible.avg
     58.31 ± 23%    +751.7%     496.62 ±  8%  sched_debug.cpu.nr_uninterruptible.max
   -146.56          +106.4%    -302.54        sched_debug.cpu.nr_uninterruptible.min
     75.90 ± 44%    +341.5%     335.12 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
    123587          +346.0%     551256 ±  2%  sched_debug.cpu_clk
    120708          +354.3%     548379 ±  2%  sched_debug.ktime
    124070          +344.7%     551740 ±  2%  sched_debug.sched_clk
     78299          +124.6%     175827        slabinfo.Acpi-Parse.active_objs
      1085          +122.4%       2413        slabinfo.Acpi-Parse.active_slabs
     79233          +122.4%     176218        slabinfo.Acpi-Parse.num_objs
      1085          +122.4%       2413        slabinfo.Acpi-Parse.num_slabs
      3271 ±  4%     +32.7%       4339 ±  3%  slabinfo.Acpi-State.active_objs
      3610 ±  4%     +27.9%       4619 ±  3%  slabinfo.Acpi-State.num_objs
      9125           -11.5%       8073 ±  6%  slabinfo.anon_vma_chain.num_objs
      1000 ±  2%     -11.3%     886.75        slabinfo.avc_xperms_data.active_objs
    403.50           +81.2%     731.25 ±  4%  slabinfo.blkdev_ioc.active_objs
    656.50 ±  3%     +52.8%       1003 ±  4%  slabinfo.blkdev_ioc.num_objs
     35676          +276.2%     134224        slabinfo.btrfs_delayed_node.active_objs
    690.25          +274.4%       2584        slabinfo.btrfs_delayed_node.active_slabs
     35920          +274.2%     134423        slabinfo.btrfs_delayed_node.num_objs
    690.25          +274.4%       2584        slabinfo.btrfs_delayed_node.num_slabs
      1912 ±  4%    +127.6%       4352        slabinfo.btrfs_extent_buffer.active_objs
      2176 ±  3%    +116.0%       4700        slabinfo.btrfs_extent_buffer.num_objs
      7889 ±  2%     +39.5%      11008        slabinfo.btrfs_extent_map.active_objs
    155.00 ±  2%     +76.5%     273.50        slabinfo.btrfs_extent_map.active_slabs
      8701 ±  2%     +76.4%      15347        slabinfo.btrfs_extent_map.num_objs
    155.00 ±  2%     +76.5%     273.50        slabinfo.btrfs_extent_map.num_slabs
     34867          +284.7%     134127        slabinfo.btrfs_inode.active_objs
      1251          +283.1%       4794        slabinfo.btrfs_inode.active_slabs
     35056          +283.0%     134254        slabinfo.btrfs_inode.num_objs
      1251          +283.1%       4794        slabinfo.btrfs_inode.num_slabs
      2732           +23.4%       3371 ±  4%  slabinfo.btrfs_path.active_objs
      2893           +22.6%       3546 ±  4%  slabinfo.btrfs_path.num_objs
     79973          +121.5%     177127        slabinfo.dentry.active_objs
      1920          +119.9%       4223        slabinfo.dentry.active_slabs
     80675          +119.9%     177383        slabinfo.dentry.num_objs
      1920          +119.9%       4223        slabinfo.dentry.num_slabs
      1401 ±  5%     -11.0%       1247 ±  5%  slabinfo.eventpoll_pwq.num_objs
      2269 ±  3%     +74.7%       3965 ±  3%  slabinfo.kmalloc-128.active_objs
      4080           +24.4%       5074        slabinfo.kmalloc-128.num_objs
      2679 ±  7%     -44.5%       1486 ±  3%  slabinfo.kmalloc-192.active_objs
      3481 ±  5%     -21.3%       2739        slabinfo.kmalloc-192.num_objs
    898.50 ±  7%     -12.0%     790.75 ±  3%  slabinfo.kmalloc-rcl-64.active_objs
      4372           -11.3%       3880        slabinfo.lsm_file_cache.active_objs
     91.75 ± 29%    +115.8%     198.00 ±  7%  slabinfo.nfs_commit_data.active_objs
    187.00 ± 28%     +76.9%     330.75 ±  5%  slabinfo.nfs_commit_data.num_objs
     84.00 ±  9%    +103.6%     171.00 ± 11%  slabinfo.nfs_read_data.active_objs
    151.50 ±  8%    +121.3%     335.25 ± 13%  slabinfo.nfs_read_data.num_objs
    908.75 ±  2%     -19.8%     729.00        slabinfo.pde_opener.active_objs
      1145           -10.9%       1020        slabinfo.pid.active_objs
     13795           +17.7%      16232        slabinfo.radix_tree_node.active_objs
     14780           +14.7%      16948        slabinfo.radix_tree_node.num_objs
    892.00 ±  9%     -22.6%     690.75 ± 10%  slabinfo.skbuff_head_cache.active_objs
      1529 ±  7%     -11.8%       1348 ±  6%  slabinfo.skbuff_head_cache.num_objs
      6474 ±  4%     -12.3%       5678 ±  3%  slabinfo.vm_area_struct.active_objs
      7214 ±  5%     -12.2%       6335 ±  3%  slabinfo.vm_area_struct.num_objs
      1669 ±  7%     -13.3%       1448 ±  6%  slabinfo.xfrm_dst_cache.active_objs
     33612 ±  5%    +341.3%     148332        softirqs.BLOCK
      3556          +682.7%      27837        softirqs.CPU0.BLOCK
     39960 ±  5%    +318.1%     167062        softirqs.CPU0.RCU
     18883 ±  2%    +243.1%      64797 ±  2%  softirqs.CPU0.SCHED
      2563          +785.9%      22706        softirqs.CPU0.TASKLET
    104220 ±  9%    +403.9%     525161 ±  4%  softirqs.CPU0.TIMER
     14807 ±  5%    +455.0%      82179 ±  2%  softirqs.CPU1.BLOCK
     30579 ±  7%    +326.8%     130524 ± 10%  softirqs.CPU1.RCU
     14199 ±  3%    +330.5%      61134 ±  3%  softirqs.CPU1.SCHED
     17373 ±  4%    +462.2%      97667        softirqs.CPU1.TASKLET
     74093 ± 12%    +308.1%     302342 ± 17%  softirqs.CPU1.TIMER
     12767 ± 12%    +335.4%      55586 ± 22%  softirqs.CPU16.RCU
      6385 ±  3%    +250.6%      22390 ±  3%  softirqs.CPU16.SCHED
     35098 ± 12%    +236.1%     117949 ± 18%  softirqs.CPU16.TIMER
     13243 ±  8%    +326.8%      56520 ± 18%  softirqs.CPU17.RCU
      6331 ±  2%    +250.4%      22186 ±  2%  softirqs.CPU17.SCHED
     34984 ± 11%    +238.0%     118241 ± 18%  softirqs.CPU17.TIMER
     13151 ±  8%    +313.0%      54310 ± 12%  softirqs.CPU18.RCU
      6560 ±  3%    +239.5%      22271 ±  2%  softirqs.CPU18.SCHED
     34836 ± 10%    +235.0%     116695 ± 18%  softirqs.CPU18.TIMER
     13919 ± 14%    +286.7%      53831 ± 15%  softirqs.CPU19.RCU
      6518 ±  3%    +244.8%      22476 ±  2%  softirqs.CPU19.SCHED
     34164 ± 10%    +230.8%     113004 ± 14%  softirqs.CPU19.TIMER
     23237 ±  5%    +371.3%     109508 ± 13%  softirqs.CPU2.RCU
      8367 ±  3%    +313.9%      34630        softirqs.CPU2.SCHED
     60014 ± 15%    +312.2%     247368 ± 18%  softirqs.CPU2.TIMER
      8210 ± 22%    +263.8%      29871 ± 19%  softirqs.CPU20.RCU
     19520 ± 10%    +197.9%      58150 ± 17%  softirqs.CPU20.TIMER
      7227 ± 15%    +292.1%      28340 ± 17%  softirqs.CPU21.RCU
     19563 ± 13%    +176.8%      54148 ±  9%  softirqs.CPU21.TIMER
      6738 ±  8%    +312.1%      27771 ± 16%  softirqs.CPU22.RCU
     19856 ± 12%    +193.2%      58227 ± 17%  softirqs.CPU22.TIMER
      7068 ± 12%    +295.8%      27976 ± 21%  softirqs.CPU23.RCU
     20532 ± 13%    +206.9%      63019 ± 26%  softirqs.CPU23.TIMER
     24162 ± 12%    +376.9%     115228 ± 13%  softirqs.CPU3.RCU
      8685 ±  4%    +304.9%      35167        softirqs.CPU3.SCHED
     70700 ± 16%    +252.2%     249000 ± 17%  softirqs.CPU3.TIMER
     18076 ±  8%    +360.9%      83322 ± 12%  softirqs.CPU4.RCU
      6638 ±  3%    +259.3%      23854 ±  2%  softirqs.CPU4.SCHED
     52818 ± 16%    +254.0%     186954 ± 22%  softirqs.CPU4.TIMER
     19156 ±  6%    +349.5%      86102 ± 13%  softirqs.CPU5.RCU
      6655 ±  4%    +258.2%      23839 ±  2%  softirqs.CPU5.SCHED
     53180 ± 15%    +253.1%     187754 ± 22%  softirqs.CPU5.TIMER
     18758 ±  4%    +376.4%      89360 ± 15%  softirqs.CPU6.RCU
      6639 ±  5%    +258.1%      23772        softirqs.CPU6.SCHED
     52940 ± 16%    +256.6%     188770 ± 23%  softirqs.CPU6.TIMER
     18941 ±  2%    +327.8%      81024 ±  6%  softirqs.CPU7.RCU
      6768 ±  3%    +250.0%      23685 ±  2%  softirqs.CPU7.SCHED
     54451 ± 16%    +245.9%     188338 ± 23%  softirqs.CPU7.TIMER
    324173 ±  6%    +286.1%    1251558 ± 11%  softirqs.RCU
    171016          +174.8%     469998        softirqs.SCHED
     20655 ±  4%    +486.3%     121103        softirqs.TASKLET
    954209 ±  9%    +212.1%    2978155 ± 13%  softirqs.TIMER
      0.10 ± 44%     -87.6%       0.01 ± 26%  perf-stat.i.MPKI
  11917649 ± 28%     -79.1%    2486349 ± 19%  perf-stat.i.branch-instructions
      0.07 ±  8%      -0.1        0.01 ±  3%  perf-stat.i.branch-miss-rate%
    889209 ± 27%     -80.1%     176655 ± 21%  perf-stat.i.branch-misses
      0.30 ±  5%      -0.2        0.06 ±  3%  perf-stat.i.cache-miss-rate%
    124863 ±  8%     -83.0%      21240 ±  4%  perf-stat.i.cache-misses
    394540 ± 11%     -82.9%      67377 ±  3%  perf-stat.i.cache-references
     18966 ±  2%     -60.0%       7583        perf-stat.i.context-switches
      0.02 ± 31%     -84.8%       0.00 ± 16%  perf-stat.i.cpi
  81719357 ± 15%     -80.9%   15619893 ± 12%  perf-stat.i.cpu-cycles
    296.41           -56.4%     129.34 ±  2%  perf-stat.i.cpu-migrations
      6.07 ± 12%     -77.5%       1.37 ± 10%  perf-stat.i.cycles-between-cache-misses
      0.00 ± 32%      -0.0        0.00 ± 25%  perf-stat.i.dTLB-load-miss-rate%
     26515 ± 18%     -78.6%       5678 ± 19%  perf-stat.i.dTLB-load-misses
  11211406 ± 28%     -78.8%    2378574 ± 19%  perf-stat.i.dTLB-loads
      0.00 ± 17%      -0.0        0.00 ± 14%  perf-stat.i.dTLB-store-miss-rate%
      4617 ± 17%     -81.9%     836.25 ±  6%  perf-stat.i.dTLB-store-misses
   6514374 ± 21%     -80.4%    1276707 ± 13%  perf-stat.i.dTLB-stores
      0.81 ±  3%      -0.7        0.15 ±  2%  perf-stat.i.iTLB-load-miss-rate%
      7806 ± 14%     -78.8%       1657 ± 11%  perf-stat.i.iTLB-load-misses
      1566 ± 22%     -75.4%     384.63 ±  5%  perf-stat.i.iTLB-loads
  56576304 ± 28%     -79.1%   11809110 ± 19%  perf-stat.i.instructions
     63.87 ± 18%     -79.4%      13.18 ± 17%  perf-stat.i.instructions-per-iTLB-miss
      0.01 ± 17%     -77.3%       0.00 ±  8%  perf-stat.i.ipc
      2912           -20.4%       2317        perf-stat.i.minor-faults
     16709 ±  2%     -16.6%      13928        perf-stat.i.msec
      0.24 ±  7%      -0.2        0.04 ± 16%  perf-stat.i.node-load-miss-rate%
      6615 ± 76%     -85.3%     969.37 ± 38%  perf-stat.i.node-load-misses
     21880 ± 19%     -79.9%       4403 ± 16%  perf-stat.i.node-loads
      0.18 ± 26%      -0.2        0.03 ± 14%  perf-stat.i.node-store-miss-rate%
      6679 ± 17%     -85.1%     997.76 ± 12%  perf-stat.i.node-store-misses
     31549 ±  6%     -81.1%       5950 ± 14%  perf-stat.i.node-stores
      2912           -20.4%       2317        perf-stat.i.page-faults
      7.48 ±  4%      -0.4        7.09 ±  2%  perf-stat.overall.branch-miss-rate%
  11892777 ± 28%     -79.0%    2493017 ± 19%  perf-stat.ps.branch-instructions
    887326 ± 27%     -80.0%     177145 ± 21%  perf-stat.ps.branch-misses
    124722 ±  8%     -82.9%      21307 ±  4%  perf-stat.ps.cache-misses
    394052 ± 11%     -82.8%      67593 ±  3%  perf-stat.ps.cache-references
     18874 ±  2%     -59.9%       7576        perf-stat.ps.context-switches
  81586204 ± 15%     -80.8%   15666785 ± 12%  perf-stat.ps.cpu-cycles
    294.95           -56.2%     129.22 ±  2%  perf-stat.ps.cpu-migrations
     26472 ± 18%     -78.5%       5693 ± 19%  perf-stat.ps.dTLB-load-misses
  11187646 ± 28%     -78.7%    2384826 ± 19%  perf-stat.ps.dTLB-loads
      4613 ± 17%     -81.8%     838.99 ±  5%  perf-stat.ps.dTLB-store-misses
   6503546 ± 21%     -80.3%    1280306 ± 13%  perf-stat.ps.dTLB-stores
      7794 ± 14%     -78.7%       1661 ± 11%  perf-stat.ps.iTLB-load-misses
      1562 ± 22%     -75.3%     385.47 ±  5%  perf-stat.ps.iTLB-loads
  56457333 ± 28%     -79.0%   11840667 ± 19%  perf-stat.ps.instructions
      2899           -20.2%       2315        perf-stat.ps.minor-faults
     16645 ±  2%     -16.4%      13919        perf-stat.ps.msec
      6599 ± 76%     -85.3%     971.51 ± 38%  perf-stat.ps.node-load-misses
     21822 ± 19%     -79.8%       4410 ± 16%  perf-stat.ps.node-loads
      6669 ± 17%     -85.0%       1000 ± 12%  perf-stat.ps.node-store-misses
     31502 ±  6%     -81.1%       5966 ± 14%  perf-stat.ps.node-stores
      2899           -20.2%       2315        perf-stat.ps.page-faults
    244.50 ± 60%    +308.3%     998.25 ± 27%  interrupts.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
    234.00 ± 68%    +242.7%     802.00 ± 32%  interrupts.36:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
    219.25 ± 56%    +214.8%     690.25 ± 33%  interrupts.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
    165.00 ± 31%    +233.3%     550.00 ±  2%  interrupts.38:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
    133.00 ± 30%    +464.8%     751.25 ± 30%  interrupts.39:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
    197.50 ± 73%    +181.9%     556.75 ±  2%  interrupts.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
    119.25 ± 10%    +365.0%     554.50 ±  3%  interrupts.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
    162.75 ± 29%    +430.0%     862.50 ± 36%  interrupts.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
     29671 ± 57%    +711.6%     240799        interrupts.75:IR-PCI-MSI.2097152-edge.isci-msix
    108741 ±  2%     +69.5%     184290 ±  4%  interrupts.CAL:Function_call_interrupts
    183.00 ± 84%    +312.7%     755.25 ± 29%  interrupts.CPU0.36:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
     27.25 ± 38%    +280.7%     103.75 ±  3%  interrupts.CPU0.38:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
     19.00 ± 39%    +668.4%     146.00 ± 42%  interrupts.CPU0.39:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
     75.50 ± 90%    +165.9%     200.75 ±  4%  interrupts.CPU0.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
     18.00 ± 26%    +480.6%     104.50 ±  3%  interrupts.CPU0.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     29.50 ± 44%    +501.7%     177.50 ± 49%  interrupts.CPU0.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
      3760 ± 57%   +1105.1%      45313        interrupts.CPU0.75:IR-PCI-MSI.2097152-edge.isci-msix
      3356 ± 10%    +178.2%       9336 ± 16%  interrupts.CPU0.CAL:Function_call_interrupts
    424176 ±  2%    +384.8%    2056303 ±  7%  interrupts.CPU0.LOC:Local_timer_interrupts
     32371 ± 12%     +34.8%      43643 ±  8%  interrupts.CPU0.RES:Rescheduling_interrupts
    176.25 ± 31%    +234.9%     590.25 ± 38%  interrupts.CPU0.TLB:TLB_shootdowns
     35.75 ± 58%    +772.0%     311.75 ±  8%  interrupts.CPU1.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
    130.00 ± 26%    +306.0%     527.75 ± 26%  interrupts.CPU1.37:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
     22.50 ± 26%    +325.6%      95.75 ±  4%  interrupts.CPU1.38:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
     41.25 ± 26%    +437.6%     221.75 ± 18%  interrupts.CPU1.39:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
     98.75 ±  8%    +353.4%     447.75 ±  3%  interrupts.CPU1.41:IR-PCI-MSI.2621447-edge.eth0-TxRx-6
     24.00 ± 26%    +427.1%     126.50 ± 16%  interrupts.CPU1.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
     25787 ± 58%    +657.4%     195323        interrupts.CPU1.75:IR-PCI-MSI.2097152-edge.isci-msix
      3547 ± 15%    +141.9%       8581 ± 14%  interrupts.CPU1.CAL:Function_call_interrupts
    366025 ±  3%    +356.0%    1669062 ±  6%  interrupts.CPU1.LOC:Local_timer_interrupts
     28035 ± 18%     +58.6%      44474 ± 14%  interrupts.CPU1.RES:Rescheduling_interrupts
     92.25 ± 18%    +208.4%     284.50 ± 16%  interrupts.CPU1.TLB:TLB_shootdowns
      2.75 ± 30%   +3809.1%     107.50 ±161%  interrupts.CPU12.RES:Rescheduling_interrupts
      6458 ±  7%    +104.2%      13190 ±  8%  interrupts.CPU16.CAL:Function_call_interrupts
    161518 ±  5%    +270.6%     598601 ± 17%  interrupts.CPU16.LOC:Local_timer_interrupts
      6882 ±  9%     +91.8%      13202 ±  7%  interrupts.CPU17.CAL:Function_call_interrupts
    162111 ±  5%    +269.3%     598629 ± 17%  interrupts.CPU17.LOC:Local_timer_interrupts
      6071 ±  9%    +115.1%      13057 ± 12%  interrupts.CPU18.CAL:Function_call_interrupts
    162778 ±  5%    +267.4%     598039 ± 17%  interrupts.CPU18.LOC:Local_timer_interrupts
      8133 ±  7%     +61.6%      13146 ±  4%  interrupts.CPU19.CAL:Function_call_interrupts
    162807 ±  5%    +276.2%     612554 ± 13%  interrupts.CPU19.LOC:Local_timer_interrupts
     97.00 ± 22%    +454.1%     537.50 ± 35%  interrupts.CPU2.42:IR-PCI-MSI.2621448-edge.eth0-TxRx-7
      3447 ± 13%    +152.5%       8704 ± 18%  interrupts.CPU2.CAL:Function_call_interrupts
    299158 ±  4%    +329.7%    1285348 ±  9%  interrupts.CPU2.LOC:Local_timer_interrupts
      5497 ± 12%     +39.9%       7691 ±  5%  interrupts.CPU2.RES:Rescheduling_interrupts
     40.25 ± 19%    +106.8%      83.25 ± 39%  interrupts.CPU2.TLB:TLB_shootdowns
      4339 ± 16%     +44.2%       6256 ±  5%  interrupts.CPU20.CAL:Function_call_interrupts
     82165 ± 11%    +251.6%     288905 ± 16%  interrupts.CPU20.LOC:Local_timer_interrupts
      3425 ± 14%    +118.5%       7485 ±  5%  interrupts.CPU21.CAL:Function_call_interrupts
     82124 ± 12%    +266.4%     300890 ±  8%  interrupts.CPU21.LOC:Local_timer_interrupts
      3889 ± 15%     +80.2%       7009 ± 12%  interrupts.CPU22.CAL:Function_call_interrupts
     82060 ± 12%    +252.2%     289035 ± 16%  interrupts.CPU22.LOC:Local_timer_interrupts
      3156 ± 10%    +117.7%       6870 ± 14%  interrupts.CPU23.CAL:Function_call_interrupts
     82305 ± 12%    +264.2%     299736 ±  9%  interrupts.CPU23.LOC:Local_timer_interrupts
    102.00 ± 24%    +241.7%     348.50 ±  2%  interrupts.CPU3.38:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      3307 ±  2%    +138.3%       7882 ± 13%  interrupts.CPU3.CAL:Function_call_interrupts
    299207 ±  4%    +327.1%    1277903 ± 10%  interrupts.CPU3.LOC:Local_timer_interrupts
      4325 ±  6%     +41.9%       6138 ± 10%  interrupts.CPU3.RES:Rescheduling_interrupts
     67.00 ± 26%    +455.2%     372.00 ± 33%  interrupts.CPU4.39:IR-PCI-MSI.2621445-edge.eth0-TxRx-4
      2950 ±  4%    +145.3%       7239 ± 20%  interrupts.CPU4.CAL:Function_call_interrupts
    234082 ±  4%    +300.8%     938197 ± 13%  interrupts.CPU4.LOC:Local_timer_interrupts
      2753 ± 11%     +38.7%       3818 ± 14%  interrupts.CPU4.RES:Rescheduling_interrupts
      3.75 ± 54%   +1540.0%      61.50 ±143%  interrupts.CPU40.RES:Rescheduling_interrupts
      3093 ±  5%    +137.8%       7354 ± 17%  interrupts.CPU5.CAL:Function_call_interrupts
    233637 ±  4%    +300.4%     935496 ± 14%  interrupts.CPU5.LOC:Local_timer_interrupts
      2616 ±  9%     +39.5%       3649 ± 18%  interrupts.CPU5.RES:Rescheduling_interrupts
      3110 ±  5%    +122.7%       6927 ± 11%  interrupts.CPU6.CAL:Function_call_interrupts
    233360 ±  4%    +300.6%     934844 ± 14%  interrupts.CPU6.LOC:Local_timer_interrupts
    624.00 ± 17%     -53.3%     291.50 ± 35%  interrupts.CPU6.NMI:Non-maskable_interrupts
    624.00 ± 17%     -53.3%     291.50 ± 35%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     65.00 ± 57%    +596.9%     453.00 ± 26%  interrupts.CPU7.35:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
     75.75 ± 38%    +249.8%     265.00 ±  2%  interrupts.CPU7.40:IR-PCI-MSI.2621446-edge.eth0-TxRx-5
      2918          +129.8%       6706 ± 18%  interrupts.CPU7.CAL:Function_call_interrupts
    233720 ±  4%    +305.4%     947415 ± 11%  interrupts.CPU7.LOC:Local_timer_interrupts
   3522671 ±  4%    +293.1%   13846285 ± 11%  interrupts.LOC:Local_timer_interrupts
     94.00           +18.1%     111.00        interrupts.MCP:Machine_check_polls
     89232 ±  4%     +39.8%     124725 ±  6%  interrupts.RES:Rescheduling_interrupts
    495.75 ± 13%    +164.4%       1310 ± 36%  interrupts.TLB:TLB_shootdowns
     15.33 ± 17%      -9.6        5.77 ± 14%  perf-profile.calltrace.cycles-pp.ret_from_fork
     15.33 ± 17%      -9.6        5.77 ± 14%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      9.42 ± 68%      -9.4        0.00        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.50 ± 55%      -9.1        1.43 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.49 ± 55%      -9.1        1.42 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.36 ± 22%      -6.4        3.93 ± 16%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
     10.12 ± 21%      -6.3        3.82 ± 17%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      4.03 ± 56%      -2.9        1.15 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
      4.35 ± 25%      -2.8        1.53 ± 15%  perf-profile.calltrace.cycles-pp.kthread_worker_fn.kthread.ret_from_fork
      4.30 ± 25%      -2.8        1.51 ± 15%  perf-profile.calltrace.cycles-pp.loop_queue_work.kthread_worker_fn.kthread.ret_from_fork
      3.93 ± 54%      -2.8        1.14 ± 11%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread.kthread
      3.61 ± 28%      -2.6        1.03 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_finish_ordered_io.normal_work_helper.process_one_work.worker_thread.kthread
      3.62 ± 28%      -2.6        1.03 ±  8%  perf-profile.calltrace.cycles-pp.normal_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      2.64 ± 35%      -2.1        0.50 ± 59%  perf-profile.calltrace.cycles-pp.__btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_ordered_io.normal_work_helper.process_one_work
      2.82 ± 34%      -2.1        0.70 ±  9%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_ordered_io.normal_work_helper.process_one_work.worker_thread
      6.26 ± 12%      -2.0        4.21 ± 36%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64
      6.25 ± 12%      -2.0        4.21 ± 36%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64
      6.22 ± 12%      -2.0        4.20 ± 36%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64
      2.28 ± 37%      -2.0        0.31 ±100%  perf-profile.calltrace.cycles-pp.lo_write_bvec.loop_queue_work.kthread_worker_fn.kthread.ret_from_fork
      2.24 ± 37%      -1.9        0.31 ±100%  perf-profile.calltrace.cycles-pp.do_iter_write.lo_write_bvec.loop_queue_work.kthread_worker_fn.kthread
      2.19 ± 39%      -1.9        0.30 ±100%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.lo_write_bvec.loop_queue_work.kthread_worker_fn
      2.19 ± 39%      -1.9        0.30 ±100%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.do_iter_readv_writev.do_iter_write.lo_write_bvec.loop_queue_work
      2.09 ± 38%      -1.8        0.28 ±100%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.do_iter_readv_writev.do_iter_write.lo_write_bvec
      1.98 ± 20%      -1.0        0.97 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.loop_queue_work.kthread_worker_fn.kthread.ret_from_fork
      1.01 ± 23%      -0.8        0.26 ±100%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work.worker_thread
      1.01 ± 23%      -0.8        0.26 ±100%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_async_reclaim_metadata_space.process_one_work
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.calltrace.cycles-pp.fb_flashcursor.process_one_work.worker_thread.kthread.ret_from_fork
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.calltrace.cycles-pp.bit_cursor.fb_flashcursor.process_one_work.worker_thread.kthread
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.calltrace.cycles-pp.soft_cursor.bit_cursor.fb_flashcursor.process_one_work.worker_thread
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.calltrace.cycles-pp.mga_dirty_update.soft_cursor.bit_cursor.fb_flashcursor.process_one_work
      2.12 ± 22%      -0.7        1.42 ± 34%  perf-profile.calltrace.cycles-pp.memcpy_toio.mga_dirty_update.soft_cursor.bit_cursor.fb_flashcursor
      0.79 ± 37%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.irq_exit.do_IRQ.ret_from_intr.cpuidle_enter_state.do_idle
      0.13 ±173%      +0.5        0.66 ±  7%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt
      0.14 ±173%      +0.5        0.69 ± 10%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +0.6        0.61 ±  8%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.53 ± 62%      +0.6        1.16 ± 17%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +0.7        0.67 ± 19%  perf-profile.calltrace.cycles-pp.run_timer_softirq.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.15 ±173%      +0.7        0.83 ±  8%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
      0.15 ±173%      +0.9        1.10 ±  7%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±173%      +1.0        1.12 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92 ± 12%      +1.3        2.21 ± 22%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.48 ±105%      +1.6        2.12 ± 23%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      1.89 ± 34%      +2.1        3.99 ± 21%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      2.10 ± 30%      +2.4        4.52 ± 22%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      2.53 ± 31%      +3.3        5.81 ± 26%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      4.15 ± 27%      +4.3        8.43 ± 16%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      5.91 ± 29%      +6.4       12.27 ± 14%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle
     10.84 ± 28%      +9.0       19.87 ± 12%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry
     10.61 ± 32%     +10.2       20.81 ± 10%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
     34.32 ± 28%     +15.4       49.73 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary
     49.61 ± 29%     +25.3       74.93 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     64.73 ± 24%     +25.5       90.24        perf-profile.calltrace.cycles-pp.secondary_startup_64
     58.35 ± 27%     +27.5       85.86 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     58.47 ± 27%     +27.6       86.03 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     58.47 ± 27%     +27.6       86.03 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     16.37 ± 80%     -14.0        2.37 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.34 ± 80%     -14.0        2.36 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
     15.33 ± 17%      -9.6        5.77 ± 14%  perf-profile.children.cycles-pp.kthread
     15.34 ± 17%      -9.6        5.79 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
      9.43 ± 68%      -9.4        0.00        perf-profile.children.cycles-pp.do_unlinkat
     10.36 ± 22%      -6.4        3.93 ± 16%  perf-profile.children.cycles-pp.worker_thread
     10.12 ± 21%      -6.3        3.82 ± 17%  perf-profile.children.cycles-pp.process_one_work
      7.51 ± 42%      -6.0        1.49 ±  8%  perf-profile.children.cycles-pp.btrfs_search_slot
      4.13 ± 53%      -3.0        1.14 ± 11%  perf-profile.children.cycles-pp.flush_space
      3.18 ±122%      -2.9        0.29 ± 34%  perf-profile.children.cycles-pp.down_write
      4.03 ± 56%      -2.9        1.15 ± 11%  perf-profile.children.cycles-pp.btrfs_async_reclaim_metadata_space
      3.13 ±122%      -2.9        0.28 ± 31%  perf-profile.children.cycles-pp.call_rwsem_down_write_failed
      3.13 ±122%      -2.9        0.28 ± 31%  perf-profile.children.cycles-pp.rwsem_down_write_failed
      4.35 ± 25%      -2.8        1.53 ± 15%  perf-profile.children.cycles-pp.kthread_worker_fn
      4.30 ± 25%      -2.8        1.51 ± 15%  perf-profile.children.cycles-pp.loop_queue_work
      3.62 ± 28%      -2.6        1.03 ±  8%  perf-profile.children.cycles-pp.normal_work_helper
      3.61 ± 28%      -2.6        1.03 ±  8%  perf-profile.children.cycles-pp.btrfs_finish_ordered_io
      2.92 ± 34%      -2.2        0.76 ± 13%  perf-profile.children.cycles-pp.__btrfs_drop_extents
      2.37 ±118%      -2.1        0.25 ± 31%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      2.82 ± 34%      -2.1        0.70 ±  9%  perf-profile.children.cycles-pp.insert_reserved_file_extent
      2.26 ±102%      -2.1        0.18 ± 14%  perf-profile.children.cycles-pp.__btrfs_run_delayed_items
      6.26 ± 12%      -2.0        4.21 ± 36%  perf-profile.children.cycles-pp.start_kernel
      2.28 ± 37%      -1.8        0.51 ± 22%  perf-profile.children.cycles-pp.lo_write_bvec
      2.24 ± 37%      -1.7        0.50 ± 24%  perf-profile.children.cycles-pp.do_iter_write
      2.19 ± 39%      -1.7        0.48 ± 26%  perf-profile.children.cycles-pp.do_iter_readv_writev
      2.19 ± 39%      -1.7        0.48 ± 26%  perf-profile.children.cycles-pp.btrfs_file_write_iter
      2.10 ± 38%      -1.6        0.46 ± 24%  perf-profile.children.cycles-pp.btrfs_buffered_write
      1.82 ± 28%      -1.6        0.20 ± 21%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      1.97 ± 44%      -1.6        0.37 ± 18%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      1.64 ± 45%      -1.6        0.06 ± 63%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      2.22 ± 54%      -1.5        0.68 ± 16%  perf-profile.children.cycles-pp.__sched_text_start
      1.70 ± 21%      -1.5        0.17 ± 20%  perf-profile.children.cycles-pp.btrfs_tree_read_lock
      1.85 ± 52%      -1.5        0.38 ± 30%  perf-profile.children.cycles-pp.try_to_wake_up
      1.61 ± 54%      -1.4        0.21 ± 15%  perf-profile.children.cycles-pp.btrfs_del_items
      1.22 ± 85%      -1.1        0.09 ± 21%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      1.81 ± 50%      -1.1        0.72 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock
      1.98 ± 20%      -1.0        0.97 ± 11%  perf-profile.children.cycles-pp.btrfs_sync_file
      1.09 ± 60%      -1.0        0.12 ± 54%  perf-profile.children.cycles-pp.__wake_up_common
      1.15 ± 38%      -0.9        0.20 ± 63%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.05 ± 60%      -0.9        0.12 ± 48%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.48 ± 27%      -0.9        0.59 ±  4%  perf-profile.children.cycles-pp.do_writepages
      0.99 ± 67%      -0.9        0.10 ± 45%  perf-profile.children.cycles-pp.__wake_up_common_lock
      1.48 ± 28%      -0.9        0.61 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      1.23 ± 58%      -0.8        0.41 ± 16%  perf-profile.children.cycles-pp.schedule
      0.84 ± 58%      -0.8        0.03 ±105%  perf-profile.children.cycles-pp.reserve_metadata_bytes
      0.83 ± 88%      -0.8        0.06 ± 58%  perf-profile.children.cycles-pp.btrfs_release_path
      1.06 ± 42%      -0.8        0.28 ± 22%  perf-profile.children.cycles-pp.setup_items_for_insert
      1.01 ± 47%      -0.8        0.26 ± 21%  perf-profile.children.cycles-pp.schedule_idle
      1.47 ± 29%      -0.7        0.73 ± 10%  perf-profile.children.cycles-pp.__btrfs_cow_block
      0.87 ± 22%      -0.7        0.13 ± 25%  perf-profile.children.cycles-pp.prepare_to_wait_event
      1.47 ± 29%      -0.7        0.73 ± 10%  perf-profile.children.cycles-pp.btrfs_cow_block
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.children.cycles-pp.fb_flashcursor
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.children.cycles-pp.bit_cursor
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.children.cycles-pp.soft_cursor
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.children.cycles-pp.mga_dirty_update
      2.21 ± 23%      -0.7        1.48 ± 33%  perf-profile.children.cycles-pp.memcpy_toio
      0.91 ± 77%      -0.7        0.18 ± 20%  perf-profile.children.cycles-pp.read_block_for_search
      0.90 ± 50%      -0.7        0.18 ± 24%  perf-profile.children.cycles-pp.btrfs_get_token_32
      0.82 ± 45%      -0.7        0.11 ± 42%  perf-profile.children.cycles-pp.btrfs_tree_lock
      1.21 ±  7%      -0.7        0.51 ± 17%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      1.21 ±  7%      -0.7        0.51 ± 17%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      0.77 ± 50%      -0.7        0.10 ± 37%  perf-profile.children.cycles-pp.btrfs_lock_root_node
      0.73 ± 74%      -0.7        0.07 ± 23%  perf-profile.children.cycles-pp.start_transaction
      0.94 ± 34%      -0.6        0.30 ± 21%  perf-profile.children.cycles-pp.start_ordered_ops
      0.91 ± 37%      -0.6        0.28 ± 25%  perf-profile.children.cycles-pp.extent_writepages
      0.77 ± 51%      -0.6        0.14 ± 53%  perf-profile.children.cycles-pp.generic_bin_search
      0.71 ± 74%      -0.6        0.08 ± 23%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      0.91 ± 37%      -0.6        0.28 ± 23%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
      0.85 ± 33%      -0.6        0.27 ± 23%  perf-profile.children.cycles-pp.extent_write_cache_pages
      0.69 ± 44%      -0.6        0.12 ± 12%  perf-profile.children.cycles-pp.memmove
      0.74 ± 53%      -0.6        0.18 ± 30%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.86 ± 38%      -0.5        0.34 ± 53%  perf-profile.children.cycles-pp.blk_done_softirq
      1.03 ± 30%      -0.5        0.52 ± 15%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.75 ± 33%      -0.5        0.25 ± 29%  perf-profile.children.cycles-pp.__extent_writepage
      0.77 ± 40%      -0.5        0.28 ± 47%  perf-profile.children.cycles-pp.blk_update_request
      0.60 ± 84%      -0.5        0.12 ± 16%  perf-profile.children.cycles-pp.find_extent_buffer
      0.62 ± 41%      -0.5        0.14 ± 28%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.70 ± 39%      -0.5        0.22 ± 51%  perf-profile.children.cycles-pp.btrfs_end_bio
      0.54 ± 39%      -0.5        0.06 ± 20%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.60 ± 44%      -0.5        0.13 ± 27%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.52 ±124%      -0.5        0.05 ± 64%  perf-profile.children.cycles-pp.write
      0.58 ± 43%      -0.5        0.12 ± 28%  perf-profile.children.cycles-pp.memcpy_from_page
      1.22 ± 21%      -0.5        0.77 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.58 ± 61%      -0.4        0.14 ± 23%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.53 ± 38%      -0.4        0.11 ± 74%  perf-profile.children.cycles-pp.btrfs_dirty_pages
      0.65 ± 45%      -0.4        0.23 ± 64%  perf-profile.children.cycles-pp.scsi_io_completion
      0.54 ± 56%      -0.4        0.13 ± 42%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.64 ± 43%      -0.4        0.23 ± 64%  perf-profile.children.cycles-pp.scsi_end_request
      0.65 ± 52%      -0.4        0.26 ± 12%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.45 ± 53%      -0.4        0.09 ±106%  perf-profile.children.cycles-pp.end_bio_extent_writepage
      0.39 ± 75%      -0.4        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_block_rsv_add
      0.65 ± 30%      -0.3        0.35 ± 21%  perf-profile.children.cycles-pp.copy_page
      0.37 ± 28%      -0.3        0.08 ± 17%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.33 ± 42%      -0.3        0.05 ±102%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.59 ± 19%      -0.3        0.32 ± 24%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
      0.32 ± 40%      -0.3        0.05 ± 62%  perf-profile.children.cycles-pp.map_private_extent_buffer
      0.37 ± 20%      -0.3        0.11 ± 28%  perf-profile.children.cycles-pp.__extent_writepage_io
      0.36 ± 31%      -0.3        0.10 ± 42%  perf-profile.children.cycles-pp.poll_idle
      0.34 ± 46%      -0.3        0.08 ± 45%  perf-profile.children.cycles-pp.btrfs_mark_buffer_dirty
      0.40 ± 18%      -0.3        0.14 ± 36%  perf-profile.children.cycles-pp.__libc_fork
      0.57 ± 22%      -0.3        0.31 ± 19%  perf-profile.children.cycles-pp.btree_write_cache_pages
      0.53 ± 16%      -0.2        0.28 ± 17%  perf-profile.children.cycles-pp.__btrfs_free_extent
      0.41 ± 30%      -0.2        0.16 ± 28%  perf-profile.children.cycles-pp.__set_extent_bit
      0.33 ± 32%      -0.2        0.09 ± 60%  perf-profile.children.cycles-pp.kmem_cache_free
      0.32 ± 53%      -0.2        0.08 ± 33%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.32 ± 67%      -0.2        0.09 ± 16%  perf-profile.children.cycles-pp.link_path_walk
      0.33 ± 37%      -0.2        0.11 ± 28%  perf-profile.children.cycles-pp.submit_extent_page
      0.30 ± 28%      -0.2        0.08 ± 28%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.45 ± 26%      -0.2        0.24 ± 34%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      0.50 ±  8%      -0.2        0.28 ± 24%  perf-profile.children.cycles-pp.btrfs_log_changed_extents
      0.28 ± 27%      -0.2        0.08 ± 24%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.26 ± 43%      -0.2        0.06 ± 71%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      0.23 ± 46%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.___might_sleep
      0.23 ± 71%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.58 ± 11%      -0.2        0.38 ± 20%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
      0.58 ± 11%      -0.2        0.38 ± 20%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
      0.58 ± 12%      -0.2        0.38 ± 19%  perf-profile.children.cycles-pp.btrfs_log_inode
      0.31 ± 46%      -0.2        0.12 ± 29%  perf-profile.children.cycles-pp.add_pending_csums
      0.36 ± 21%      -0.2        0.17 ± 21%  perf-profile.children.cycles-pp.write_one_eb
      0.21 ± 50%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.21 ± 20%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.clear_state_bit
      0.24 ± 38%      -0.2        0.06 ± 11%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.31 ± 34%      -0.2        0.14 ± 18%  perf-profile.children.cycles-pp.pagecache_get_page
      0.25 ± 66%      -0.2        0.08 ± 70%  perf-profile.children.cycles-pp.set_next_entity
      0.25 ± 19%      -0.2        0.08 ± 76%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.25 ± 19%      -0.2        0.08 ± 76%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.20 ± 36%      -0.2        0.03 ±105%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.34 ± 24%      -0.2        0.18 ± 22%  perf-profile.children.cycles-pp.read
      0.20 ± 14%      -0.2        0.04 ±102%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.19 ± 46%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_get_token_64
      0.21 ± 35%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.update_curr
      0.24 ± 27%      -0.1        0.10 ± 33%  perf-profile.children.cycles-pp.lock_extent_bits
      0.20 ± 43%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.19 ± 32%      -0.1        0.05 ± 61%  perf-profile.children.cycles-pp.clear_extent_bit
      0.18 ± 23%      -0.1        0.05 ±114%  perf-profile.children.cycles-pp.blk_mq_do_dispatch_sched
      0.16 ± 31%      -0.1        0.04 ±107%  perf-profile.children.cycles-pp._cond_resched
      0.14 ± 69%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__switch_to
      0.18 ± 32%      -0.1        0.07 ± 70%  perf-profile.children.cycles-pp.blk_flush_plug_list
      0.18 ± 34%      -0.1        0.07 ± 70%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.15 ± 16%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.21 ± 14%      -0.1        0.10 ± 27%  perf-profile.children.cycles-pp.end_bio_extent_buffer_writepage
      0.14 ± 63%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.do_anonymous_page
      0.14 ± 35%      -0.1        0.04 ±113%  perf-profile.children.cycles-pp.btrfs_writepage_endio_finish_ordered
      0.14 ± 35%      -0.1        0.04 ±113%  perf-profile.children.cycles-pp.end_extent_writepage
      0.18 ± 23%      -0.1        0.08 ± 59%  perf-profile.children.cycles-pp.seq_read
      0.22 ± 35%      -0.1        0.14 ± 24%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.16 ± 34%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.find_get_entry
      0.22 ± 25%      -0.1        0.14 ± 32%  perf-profile.children.cycles-pp.__blk_mq_run_hw_queue
      0.22 ± 25%      -0.1        0.14 ± 32%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.13 ± 31%      -0.1        0.05 ±114%  perf-profile.children.cycles-pp.btrfs_wait_extents
      0.17 ± 17%      -0.1        0.10 ± 30%  perf-profile.children.cycles-pp.proc_reg_read
      0.20 ± 28%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.__blk_mq_delay_run_hw_queue
      0.10 ± 38%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__etree_search
      0.03 ±100%      +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.call_timer_fn
      0.01 ±173%      +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.hrtimer_run_queues
      0.03 ±100%      +0.1        0.12 ± 33%  perf-profile.children.cycles-pp.tick_program_event
      0.04 ±173%      +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.rcu_segcblist_ready_cbs
      0.04 ±115%      +0.1        0.14 ± 34%  perf-profile.children.cycles-pp.profile_tick
      0.15 ±  8%      +0.1        0.25 ± 34%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.call_function_single_interrupt
      0.08 ± 68%      +0.1        0.21 ± 32%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.23 ±  5%      +0.1        0.37 ± 26%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.09 ± 33%      +0.1        0.23 ± 12%  perf-profile.children.cycles-pp.run_local_timers
      0.35 ±  8%      +0.1        0.49 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.36 ±  7%      +0.1        0.51 ± 11%  perf-profile.children.cycles-pp.sched_clock
      0.14 ± 34%      +0.2        0.29 ± 13%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.48 ± 10%      +0.2        0.64 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.17 ± 19%      +0.2        0.33 ± 33%  perf-profile.children.cycles-pp.cpu_load_update
      0.18 ± 15%      +0.2        0.38 ± 29%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.06 ±104%      +0.2        0.25 ± 22%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.09 ± 50%      +0.2        0.28 ± 32%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.11 ± 59%      +0.2        0.32 ± 36%  perf-profile.children.cycles-pp.account_process_tick
      0.23 ± 35%      +0.2        0.44 ± 19%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.54 ± 32%      +0.2        0.77 ±  9%  perf-profile.children.cycles-pp.native_write_msr
      0.16 ± 24%      +0.2        0.40 ± 33%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.47 ± 34%      +0.3        0.74 ± 12%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.31 ± 43%      +0.3        0.59 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      0.27 ± 48%      +0.3        0.56 ± 10%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.13 ± 60%      +0.3        0.43 ± 51%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.22 ± 36%      +0.3        0.53 ± 22%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.29 ± 33%      +0.3        0.64 ±  9%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.39 ± 22%      +0.4        0.76 ± 17%  perf-profile.children.cycles-pp.run_timer_softirq
      0.38 ± 32%      +0.4        0.80 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.24 ± 54%      +0.5        0.73 ± 30%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.36 ± 44%      +0.5        0.90 ± 12%  perf-profile.children.cycles-pp.rebalance_domains
      0.67 ± 31%      +0.6        1.23 ± 17%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      1.23 ± 18%      +1.1        2.38 ± 24%  perf-profile.children.cycles-pp.scheduler_tick
      0.85 ± 44%      +1.4        2.20 ± 22%  perf-profile.children.cycles-pp.clockevents_program_event
      0.93 ± 32%      +1.5        2.41 ± 18%  perf-profile.children.cycles-pp.ktime_get
      2.21 ± 28%      +2.1        4.27 ± 22%  perf-profile.children.cycles-pp.update_process_times
      2.42 ± 24%      +2.3        4.76 ± 23%  perf-profile.children.cycles-pp.tick_sched_handle
      2.95 ± 25%      +3.1        6.03 ± 24%  perf-profile.children.cycles-pp.tick_sched_timer
      5.00 ± 27%      +3.8        8.76 ± 15%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      6.79 ± 30%      +5.7       12.53 ± 13%  perf-profile.children.cycles-pp.hrtimer_interrupt
     11.63 ± 29%      +8.3       19.95 ± 12%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
     12.37 ± 27%      +8.8       21.16 ± 11%  perf-profile.children.cycles-pp.apic_timer_interrupt
     37.70 ± 26%     +14.5       52.19 ±  6%  perf-profile.children.cycles-pp.intel_idle
     54.85 ± 25%     +24.2       79.06 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     64.73 ± 24%     +25.5       90.24        perf-profile.children.cycles-pp.secondary_startup_64
     64.73 ± 24%     +25.5       90.24        perf-profile.children.cycles-pp.cpu_startup_entry
     64.71 ± 24%     +25.6       90.27        perf-profile.children.cycles-pp.do_idle
     58.47 ± 27%     +27.6       86.03 ±  2%  perf-profile.children.cycles-pp.start_secondary
      2.37 ±118%      -2.1        0.25 ± 31%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.15 ± 38%      -0.9        0.20 ± 63%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.19 ± 23%      -0.7        1.48 ± 33%  perf-profile.self.cycles-pp.memcpy_toio
      0.78 ± 49%      -0.6        0.14 ± 25%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.67 ± 47%      -0.6        0.11 ±  9%  perf-profile.self.cycles-pp.memmove
      0.58 ± 43%      -0.5        0.12 ± 28%  perf-profile.self.cycles-pp.memcpy_from_page
      0.54 ± 46%      -0.4        0.12 ± 48%  perf-profile.self.cycles-pp.__sched_text_start
      0.55 ± 63%      -0.4        0.12 ± 16%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.37 ± 61%      -0.3        0.07 ± 62%  perf-profile.self.cycles-pp.generic_bin_search
      0.62 ± 34%      -0.3        0.35 ± 21%  perf-profile.self.cycles-pp.copy_page
      0.34 ± 28%      -0.3        0.07 ± 66%  perf-profile.self.cycles-pp.poll_idle
      0.30 ± 39%      -0.3        0.05 ± 62%  perf-profile.self.cycles-pp.map_private_extent_buffer
      0.23 ± 71%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.27 ± 64%      -0.2        0.07 ± 68%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.23 ± 46%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.___might_sleep
      0.20 ± 51%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.22 ± 43%      -0.2        0.07 ± 72%  perf-profile.self.cycles-pp.try_to_wake_up
      0.18 ± 40%      -0.1        0.05 ± 59%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ± 67%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__switch_to
      0.14 ± 20%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.09 ± 24%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__etree_search
      0.08 ± 17%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.find_get_entry
      0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.__intel_pmu_disable_all
      0.02 ±173%      +0.1        0.09 ± 25%  perf-profile.self.cycles-pp.rebalance_domains
      0.01 ±173%      +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.apic_timer_interrupt
      0.03 ±100%      +0.1        0.11 ± 36%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.00            +0.1        0.08 ± 26%  perf-profile.self.cycles-pp.hrtimer_run_queues
      0.03 ±100%      +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.update_process_times
      0.01 ±173%      +0.1        0.10 ± 36%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.intel_pmu_disable_all
      0.03 ±100%      +0.1        0.12 ± 33%  perf-profile.self.cycles-pp.tick_program_event
      0.04 ±115%      +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.profile_tick
      0.08 ± 59%      +0.1        0.17 ± 20%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.03 ±173%      +0.1        0.13 ± 38%  perf-profile.self.cycles-pp.load_balance
      0.04 ±106%      +0.1        0.15 ± 23%  perf-profile.self.cycles-pp.run_local_timers
      0.08 ± 68%      +0.1        0.20 ± 33%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.01 ±173%      +0.1        0.14 ± 39%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.16 ± 41%      +0.1        0.29 ± 19%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.16 ± 42%      +0.2        0.32 ± 28%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.30 ±  4%      +0.2        0.46 ± 11%  perf-profile.self.cycles-pp.native_sched_clock
      0.17 ± 19%      +0.2        0.33 ± 33%  perf-profile.self.cycles-pp.cpu_load_update
      0.21 ± 57%      +0.2        0.37 ± 20%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.03 ±100%      +0.2        0.20 ± 21%  perf-profile.self.cycles-pp.rcu_core
      0.18 ± 15%      +0.2        0.37 ± 29%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.06 ±104%      +0.2        0.25 ± 22%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.11 ± 59%      +0.2        0.32 ± 36%  perf-profile.self.cycles-pp.account_process_tick
      0.06 ± 73%      +0.2        0.28 ± 31%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.54 ± 32%      +0.2        0.77 ±  9%  perf-profile.self.cycles-pp.native_write_msr
      0.16 ± 24%      +0.2        0.40 ± 33%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.30 ± 23%      +0.3        0.58 ± 19%  perf-profile.self.cycles-pp.run_timer_softirq
      0.12 ± 21%      +0.4        0.48 ± 44%  perf-profile.self.cycles-pp.tick_sched_timer
      0.20 ± 35%      +0.4        0.60 ± 27%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      1.10 ± 25%      +0.9        2.00 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.43 ± 40%      +1.2        1.61 ± 29%  perf-profile.self.cycles-pp.ktime_get
     37.57 ± 26%     +14.5       52.03 ±  6%  perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.1.0-rc3-00011-g56a85fd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.1.0-rc3 Kernel Configuration
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
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
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
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
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
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
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
# CONFIG_DRM_ETNAVIV is not set
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
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
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
CONFIG_PRIME_NUMBERS=m
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
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
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
CONFIG_TEST_LIVEPATCH=m
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

--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fxmark'
	export testcase='fxmark'
	export category='benchmark'
	export media='hdd'
	export job_origin='/lkp/lkp/.src-20190424-154702/allot/cyclic:default:linux-next:master/ivb44/fxmark.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='ivb44'
	export tbox_group='ivb44'
	export submit_id='5cc6c9450b9a93a0ee8fccc3'
	export job_file='/lkp/jobs/scheduled/ivb44/fxmark-performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d-debian-x8-20190429-41198-d3igsr-3.yaml'
	export id='6d6ced73c5c195018157f99da5c7c5a7831186d6'
	export queuer_version='/lkp/lkp/.src-20190428-205935'
	export arch='x86_64'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_F2FS_FS=m'
	export commit='56a85fd8376ef32458efb6ea97a820754e12f6bb'
	export netconsole_port=6644
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-04-29 17:52:07 +0800'
	export _id='5cc6c9470b9a93a0ee8fccc4'
	export _rt='/result/fxmark/performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d/ivb44/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb'
	export user='lkp'
	export head_commit='2f4c4d833153517c7791318f8608cf5c212cef68'
	export base_commit='15ade5d2e7775667cf191cf2f94327a4889f8b9d'
	export branch='linux-next/master'
	export result_root='/result/fxmark/performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d/ivb44/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/3'
	export scheduler_version='/lkp/lkp/.src-20190429-155455'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/ivb44/fxmark-performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d-debian-x8-20190429-41198-d3igsr-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-next/master
commit=56a85fd8376ef32458efb6ea97a820754e12f6bb
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/vmlinuz-5.1.0-rc3-00011-g56a85fd
max_uptime=3600
RESULT_ROOT=/result/fxmark/performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d/ivb44/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-04-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fxmark_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/fxmark-x86_64-e09f78f_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-04-28.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2018-05-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2019-04-25.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-9520b5324b0e_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-04-24.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='Ivy Bridge-EP'
	export nr_node=2
	export nr_cpu=48
	export memory='64G'
	export nr_hdd_partitions=2
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part1 /dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part2'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part3'
	export ucode='0x42d'
	export brand='Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz'
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/vmlinuz-5.1.0-rc3-00011-g56a85fd'
	export dequeue_time='2019-04-29 18:13:51 +0800'
	export job_initrd='/lkp/jobs/scheduled/ivb44/fxmark-performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d-debian-x8-20190429-41198-d3igsr-3.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

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

	run_test test='MWUM' fstype='btrfs' directio='bufferedio' $LKP_SRC/tests/wrapper fxmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper fxmark
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

	$LKP_SRC/stats/wrapper time fxmark.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/fxmark.yaml
suite: fxmark
testcase: fxmark
category: benchmark
disk: 1HDD
media: hdd
fxmark:
  test: MWUM
  fstype: btrfs
  directio: bufferedio
job_origin: "/lkp/lkp/.src-20190424-154702/allot/cyclic:default:linux-next:master/ivb44/fxmark.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: ivb44
tbox_group: ivb44
submit_id: 5cc6a6510b9a93ce22fef1f8
job_file: "/lkp/jobs/scheduled/ivb44/fxmark-performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d-debian-x86_-20190429-52770-fcaydz-0.yaml"
id: 06dcb96f61012901cd6619a9f0736bd89702724b
queuer_version: "/lkp/lkp/.src-20190428-205935"
arch: x86_64

#! hosts/ivb44

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

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_F2FS_FS=m

#! include/fxmark

#! include/queue/cyclic
commit: 56a85fd8376ef32458efb6ea97a820754e12f6bb

#! include/testbox/ivb44
netconsole_port: 6644

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
rootfs: debian-x86_64-2018-04-03.cgz
enqueue_time: 2019-04-29 15:22:59.170603497 +08:00
_id: 5cc6a6510b9a93ce22fef1f8
_rt: "/result/fxmark/performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d/ivb44/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb"

#! schedule options
user: lkp
head_commit: 2f4c4d833153517c7791318f8608cf5c212cef68
base_commit: 15ade5d2e7775667cf191cf2f94327a4889f8b9d
branch: linux-next/master
result_root: "/result/fxmark/performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d/ivb44/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/0"
scheduler_version: "/lkp/lkp/.src-20190429-155455"
LKP_SERVER: inn
max_uptime: 3600
initrd: "/osimage/debian/debian-x86_64-2018-04-03.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/ivb44/fxmark-performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d-debian-x86_-20190429-52770-fcaydz-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-next/master
- commit=56a85fd8376ef32458efb6ea97a820754e12f6bb
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/vmlinuz-5.1.0-rc3-00011-g56a85fd
- max_uptime=3600
- RESULT_ROOT=/result/fxmark/performance-bufferedio-1HDD-btrfs-hdd-MWUM-ucode=0x42d/ivb44/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-04-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fxmark_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/fxmark-x86_64-e09f78f_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-04-28.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2018-05-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-d5256b2_2019-04-25.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-9520b5324b0e_2019-04-29.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-04-29.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-04-24.cgz"
lkp_initrd: "/lkp/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190428-205935/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
schedule_notify_address: 
model: Ivy Bridge-EP
nr_node: 2
nr_cpu: 48
memory: 64G
nr_hdd_partitions: 2
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part1 /dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part2"
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part3"
ucode: '0x42d'
brand: Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/56a85fd8376ef32458efb6ea97a820754e12f6bb/vmlinuz-5.1.0-rc3-00011-g56a85fd"
dequeue_time: 2019-04-29 17:00:31.128519359 +08:00

#! /lkp/lkp/.src-20190429-155455/include/site/inn
job_state: finished
loadavg: 2.87 3.84 2.62 1/446 17195
start_time: '1556528491'
end_time: '1556529078'
version: "/lkp/lkp/.src-20190429-155455"

--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done


--JSkcQAAxhB1h8DcT--
