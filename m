Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FDBC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B1C20815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbfI3V1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:27:23 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55860 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729964AbfI3V1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:27:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TdsL5-O_1569871543;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TdsL5-O_1569871543)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Oct 2019 03:25:50 +0800
Subject: Re: [mm] 87eaceb3fa: stress-ng.madvise.ops_per_sec -19.6% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>, Qian Cai <cai@lca.pw>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20190930084604.GC17687@shao2-debian>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d30b1358-fb6b-2658-e675-ceff3bc465ab@linux.alibaba.com>
Date:   Mon, 30 Sep 2019 12:25:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190930084604.GC17687@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/19 1:46 AM, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed a -19.6% regression of stress-ng.madvise.ops_per_sec due to commit:
>
>
> commit: 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make deferred split shrinker memcg aware")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: stress-ng
> on test machine: 72 threads Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz with 192G memory
> with following parameters:
>
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 1s
> 	class: vm
> 	ucode: 0x200005e
> 	cpufreq_governor: performance

Thanks for reporting the case. I did the same test on my VM (24 threads, 
48GB), I saw average ~3% degradation. The test itself may have 15% 
variation in the same environment according to my test, so I compared 
the average result within 10 runs.

In 5.3 the deferred split queue is per node, currently it is per memcg. 
If the test is run in default memcg configuration (just one root memcg), 
the lock contention may get worse (two locks -> one lock).

Actually, I already noticed this issue in a different way. The patch 
changed its NUMA awareness. The global kswapd may end up reclaiming THPs 
from a different node.

I already came up with a patch which moves deferred split queue to 
memcg->nodeinfo[] to restore NUMA awareness and keep it memcg aware at 
the mean time. The same test shows average ~4% improvement and slightly 
better than 5.3 with this patch.

I'm going to post the patch to the mailing list soon.

>
>
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
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
>
> =========================================================================================
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
>    vm/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-05-14.cgz/lkp-skl-2sp8/stress-ng/1s/0x200005e
>
> commit:
>    0a432dcbeb ("mm: shrinker: make shrinker not depend on memcg kmem")
>    87eaceb3fa ("mm: thp: make deferred split shrinker memcg aware")
>
> 0a432dcbeb32edcd 87eaceb3faa59b9b4d940ec9554
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>        6457           -19.5%       5198        stress-ng.madvise.ops
>        6409           -19.6%       5154        stress-ng.madvise.ops_per_sec
>        3575           -26.8%       2618 ±  6%  stress-ng.mremap.ops
>        3575           -26.9%       2613 ±  6%  stress-ng.mremap.ops_per_sec
>       15.77            -5.8%      14.85 ±  2%  iostat.cpu.user
>     3427944 ±  4%      -9.3%    3109984        meminfo.AnonPages
>       33658 ± 22%  +69791.3%   23524535 ±165%  sched_debug.cfs_rq:/.load.max
>       19951 ±  7%     +13.3%      22611 ±  3%  softirqs.CPU54.TIMER
>      109.94            -4.1%     105.41        turbostat.RAMWatt
>        5.89 ± 62%      -3.1        2.78 ±173%  perf-profile.calltrace.cycles-pp.page_fault
>        3.39 ±101%      -0.6        2.78 ±173%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
>        3.39 ±101%      -0.6        2.78 ±173%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
>        5.28 ±100%      -5.3        0.00        perf-profile.children.cycles-pp.___might_sleep
>        5.28 ±100%      -5.3        0.00        perf-profile.self.cycles-pp.___might_sleep
>      885704 ±  5%     -11.0%     787888 ±  6%  proc-vmstat.nr_anon_pages
>   1.742e+08 ±  5%      -9.6%  1.576e+08 ±  2%  proc-vmstat.pgalloc_normal
>   1.741e+08 ±  5%      -9.6%  1.575e+08 ±  2%  proc-vmstat.pgfree
>      375505           -19.4%     302688        proc-vmstat.pglazyfree
>       55236 ± 38%     -55.5%      24552 ± 41%  proc-vmstat.thp_deferred_split_page
>       55234 ± 38%     -55.6%      24543 ± 41%  proc-vmstat.thp_fault_alloc
>        3218           -19.4%       2595        proc-vmstat.thp_split_page
>       12163 ±  7%     -22.1%       9473 ± 12%  proc-vmstat.thp_split_pmd
>     8193516            +3.2%    8459146        proc-vmstat.unevictable_pgs_scanned
>       79085 ± 10%      -7.8%      72890        interrupts.CAL:Function_call_interrupts
>        1139 ±  9%     -10.7%       1018 ±  3%  interrupts.CPU0.CAL:Function_call_interrupts
>        3596 ±  3%     -13.8%       3100 ±  8%  interrupts.CPU20.TLB:TLB_shootdowns
>        3602 ±  4%     -12.6%       3149 ± 10%  interrupts.CPU23.TLB:TLB_shootdowns
>        3512 ±  5%      -9.9%       3163 ±  9%  interrupts.CPU25.TLB:TLB_shootdowns
>        3512 ±  3%     -12.1%       3088 ±  9%  interrupts.CPU26.TLB:TLB_shootdowns
>        3610 ±  5%     -13.2%       3134 ±  5%  interrupts.CPU29.TLB:TLB_shootdowns
>        3602 ±  5%     -17.4%       2973 ±  8%  interrupts.CPU31.TLB:TLB_shootdowns
>        3548 ±  4%     -12.7%       3098 ±  6%  interrupts.CPU32.TLB:TLB_shootdowns
>        3637 ±  5%     -15.2%       3085 ±  7%  interrupts.CPU35.TLB:TLB_shootdowns
>        3588 ±  3%     -12.7%       3131 ±  9%  interrupts.CPU56.TLB:TLB_shootdowns
>        3664 ±  5%     -14.3%       3142 ± 10%  interrupts.CPU59.TLB:TLB_shootdowns
>        3542 ±  6%     -13.0%       3082 ±  5%  interrupts.CPU64.TLB:TLB_shootdowns
>        3539 ±  5%     +12.4%       3977 ± 11%  interrupts.CPU7.TLB:TLB_shootdowns
>        3485 ±  5%     -13.0%       3033 ± 10%  interrupts.CPU70.TLB:TLB_shootdowns
>        3651 ±  4%     -16.1%       3062 ±  9%  interrupts.CPU71.TLB:TLB_shootdowns
>   1.557e+10 ±  2%      -8.1%  1.431e+10 ±  3%  perf-stat.i.branch-instructions
>   1.887e+08 ±  9%     -21.4%  1.484e+08        perf-stat.i.cache-misses
>   5.026e+08 ±  2%      -8.6%  4.595e+08 ±  4%  perf-stat.i.cache-references
>        2609 ±  3%      +6.0%       2766        perf-stat.i.cycles-between-cache-misses
>   7.344e+09            -6.6%  6.861e+09 ±  3%  perf-stat.i.dTLB-stores
>   6.969e+10            -7.6%   6.44e+10 ±  3%  perf-stat.i.instructions
>        0.37 ±  2%      -7.2%       0.34        perf-stat.i.ipc
>       43.29 ±  5%      +3.7       46.94 ±  4%  perf-stat.i.node-load-miss-rate%
>    15474576 ±  8%     -23.9%   11782653 ± 13%  perf-stat.i.node-load-misses
>       28.50 ±  6%      +3.2       31.74 ±  3%  perf-stat.i.node-store-miss-rate%
>    26447212 ±  5%     -11.6%   23382361 ±  4%  perf-stat.i.node-stores
>        0.61            +0.0        0.65        perf-stat.overall.branch-miss-rate%
>       37.58 ±  8%      -5.2       32.39 ±  4%  perf-stat.overall.cache-miss-rate%
>        2.91 ±  2%      +3.4%       3.00        perf-stat.overall.cpi
>        1091 ± 10%     +19.5%       1303 ±  3%  perf-stat.overall.cycles-between-cache-misses
>        0.17            +0.0        0.18 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>        5922            -6.6%       5533 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
>        0.34 ±  2%      -3.3%       0.33        perf-stat.overall.ipc
>   1.462e+10 ±  2%      -5.3%  1.384e+10 ±  3%  perf-stat.ps.branch-instructions
>   1.765e+08 ± 10%     -18.7%  1.435e+08        perf-stat.ps.cache-misses
>   6.926e+09            -4.0%  6.648e+09 ±  3%  perf-stat.ps.dTLB-stores
>   6.555e+10            -5.0%  6.229e+10 ±  3%  perf-stat.ps.instructions
>    14736035 ±  8%     -21.6%   11547658 ± 14%  perf-stat.ps.node-load-misses
>   2.703e+12            -4.4%  2.585e+12 ±  2%  perf-stat.total.instructions
>
>
>                                                                                  
>                                 stress-ng.madvise.ops
>                                                                                  
>    7000 +-+------------------------------------------------------------------+
>    6800 +-+                          +                                       |
>         |                            :                                       |
>    6600 +-+.+  ++.+  +.+ ++   + ++. : :+.+  +.  ++ .++  +. ++    + +.   +    |
>    6400 +-+  ++    ++   +  +.+ +   ++ +   ++  + : +   ++  +  ++.+ +  ++ :+.++|
>         |                                      +                       +     |
>    6200 +-+                                                                  |
>    6000 +-+                                                                  |
>    5800 +-+                                                                  |
>         |                                                                    |
>    5600 +-+                                                                  |
>    5400 +-+                                                                  |
>         OO   OOO  O  O   O    O     O  O O O  O      O                       |
>    5200 +-O O   O  OO  OO OO O OOO O OO   O O  OOOO O O                      |
>    5000 +-+------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                             stress-ng.madvise.ops_per_sec
>                                                                                  
>    7000 +-+------------------------------------------------------------------+
>    6800 +-+                          +                                       |
>         |                            :                                       |
>    6600 +-+                         : :                                      |
>    6400 +-+.+++++.++++.+++++.+++++.++ ++.++++.+ +++.+++++.+++++.++++.++ ++.++|
>         |                                      +                       +     |
>    6200 +-+                                                                  |
>    6000 +-+                                                                  |
>    5800 +-+                                                                  |
>         |                                                                    |
>    5600 +-+                                                                  |
>    5400 +-+                                                                  |
>         |O   O    O  O   O                           O                       |
>    5200 O-O O OOO  O   OO OO OOOOO OOOOO OOOO OO  O O O                      |
>    5000 +-+---------O---------------------------OO---------------------------+
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

