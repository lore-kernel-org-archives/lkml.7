Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4599206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfJHOdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:33:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJHOdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:33:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC9A2315C033;
        Tue,  8 Oct 2019 14:33:01 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC026012C;
        Tue,  8 Oct 2019 14:33:00 +0000 (UTC)
Date:   Tue, 8 Oct 2019 10:32:58 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
Subject: Re: [PATCH v3 0/8] sched/fair: rework the CFS load balance
Message-ID: <20191008143258.GC8431@pauld.bos.csb>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 08 Oct 2019 14:33:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, Sep 19, 2019 at 09:33:31AM +0200 Vincent Guittot wrote:
> Several wrong task placement have been raised with the current load
> balance algorithm but their fixes are not always straight forward and
> end up with using biased values to force migrations. A cleanup and rework
> of the load balance will help to handle such UCs and enable to fine grain
> the behavior of the scheduler for other cases.
> 
> Patch 1 has already been sent separately and only consolidate asym policy
> in one place and help the review of the changes in load_balance.
> 
> Patch 2 renames the sum of h_nr_running in stats.
> 
> Patch 3 removes meaningless imbalance computation to make review of
> patch 4 easier.
> 
> Patch 4 reworks load_balance algorithm and fixes some wrong task placement
> but try to stay conservative.
> 
> Patch 5 add the sum of nr_running to monitor non cfs tasks and take that
> into account when pulling tasks.
> 
> Patch 6 replaces runnable_load by load now that the signal is only used
> when overloaded.
> 
> Patch 7 improves the spread of tasks at the 1st scheduling level.
> 
> Patch 8 uses utilization instead of load in all steps of misfit task
> path.
> 
> Patch 9 replaces runnable_load_avg by load_avg in the wake up path.
> 
> Patch 10 optimizes find_idlest_group() that was using both runnable_load
> and load. This has not been squashed with previous patch to ease the
> review.
> 
> Some benchmarks results based on 8 iterations of each tests:
> - small arm64 dual quad cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe      54981 +/-0.36%        55459 +/-0.31%   (+0.97%)
> 
> hackbench
> 1 groups       0.906 +/-2.34%        0.906 +/-2.88%   (+0.06%)
> 
> - large arm64 2 nodes / 224 cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe     125323 +/-0.98%       125624 +/-0.71%   (+0.24%)
> 
> hackbench -l (256000/#grp) -g #grp
> 1 groups      15.360 +/-1.76%       14.206 +/-1.40%   (+8.69%)
> 4 groups       5.822 +/-1.02%        5.508 +/-6.45%   (+5.38%)
> 16 groups      3.103 +/-0.80%        3.244 +/-0.77%   (-4.52%)
> 32 groups      2.892 +/-1.23%        2.850 +/-1.81%   (+1.47%)
> 64 groups      2.825 +/-1.51%        2.725 +/-1.51%   (+3.54%)
> 128 groups     3.149 +/-8.46%        3.053 +/-13.15%  (+3.06%)
> 256 groups     3.511 +/-8.49%        3.019 +/-1.71%  (+14.03%)
> 
> dbench
> 1 groups     329.677 +/-0.46%      329.771 +/-0.11%   (+0.03%)
> 4 groups     931.499 +/-0.79%      947.118 +/-0.94%   (+1.68%)
> 16 groups   1924.210 +/-0.89%     1947.849 +/-0.76%   (+1.23%)
> 32 groups   2350.646 +/-5.75%     2351.549 +/-6.33%   (+0.04%)
> 64 groups   2201.524 +/-3.35%     2192.749 +/-5.84%   (-0.40%)
> 128 groups  2206.858 +/-2.50%     2376.265 +/-7.44%   (+7.68%)
> 256 groups  1263.520 +/-3.34%     1633.143 +/-13.02% (+29.25%)
> 
> tip/sched/core sha1:
>   0413d7f33e60 ('sched/uclamp: Always use 'enum uclamp_id' for clamp_id values')
> 
> Changes since v2:
> - fix typo and reorder code
> - some minor code fixes
> - optimize the find_idles_group()
> 
> Not covered in this patchset:
> - update find_idlest_group() to be more aligned with load_balance(). I didn't
>   want to delay this version because of this update which is not ready yet
> - Better detection of overloaded and fully busy state, especially for cases
>   when nr_running > nr CPUs.
> 
> Vincent Guittot (8):
>   sched/fair: clean up asym packing
>   sched/fair: rename sum_nr_running to sum_h_nr_running
>   sched/fair: remove meaningless imbalance calculation
>   sched/fair: rework load_balance
>   sched/fair: use rq->nr_running when balancing load
>   sched/fair: use load instead of runnable load in load_balance
>   sched/fair: evenly spread tasks when not overloaded
>   sched/fair: use utilization to select misfit task
>   sched/fair: use load instead of runnable load in wakeup path
>   sched/fair: optimize find_idlest_group
> 
>  kernel/sched/fair.c | 805 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 417 insertions(+), 388 deletions(-)
> 
> -- 
> 2.7.4
> 

We've been testing v3 and for the most part everything looks good. The 
group imbalance issues are fixed on all of our test systems except one.

The one is an 8-node intel system with 160 cpus. I'll put the system 
details at the end. 

This shows the average number of benchmark threads running on each node
through the run. That is, not including the 2 stress jobs. The end 
results are a 4x slow down in the cgroup case versus not. The 152 and 
156 are the number of LU threads in the run. In all cases there are 2 
stress CPU threads running either in their own cgroups (GROUP) or 
everything is in one cgroup (NORMAL).  The normal case is pretty well 
balanced with only a few >= 20 and those that are are only a little 
over. In the GROUP cases things are not so good. There are some > 30 
for example, and others < 10.


lu.C.x_152_GROUP_1   17.52  16.86  17.90  18.52  20.00  19.00  22.00  20.19
lu.C.x_152_GROUP_2   15.70  15.04  15.65  15.72  23.30  28.98  20.09  17.52
lu.C.x_152_GROUP_3   27.72  32.79  22.89  22.62  11.01  12.90  12.14  9.93
lu.C.x_152_GROUP_4   18.13  18.87  18.40  17.87  18.80  19.93  20.40  19.60
lu.C.x_152_GROUP_5   24.14  26.46  20.92  21.43  14.70  16.05  15.14  13.16
lu.C.x_152_NORMAL_1  21.03  22.43  20.27  19.97  18.37  18.80  16.27  14.87
lu.C.x_152_NORMAL_2  19.24  18.29  18.41  17.41  19.71  19.00  20.29  19.65
lu.C.x_152_NORMAL_3  19.43  20.00  19.05  20.24  18.76  17.38  18.52  18.62
lu.C.x_152_NORMAL_4  17.19  18.25  17.81  18.69  20.44  19.75  20.12  19.75
lu.C.x_152_NORMAL_5  19.25  19.56  19.12  19.56  19.38  19.38  18.12  17.62

lu.C.x_156_GROUP_1   18.62  19.31  18.38  18.77  19.88  21.35  19.35  20.35
lu.C.x_156_GROUP_2   15.58  12.72  14.96  14.83  20.59  19.35  29.75  28.22
lu.C.x_156_GROUP_3   20.05  18.74  19.63  18.32  20.26  20.89  19.53  18.58
lu.C.x_156_GROUP_4   14.77  11.42  13.01  10.09  27.05  33.52  23.16  22.98
lu.C.x_156_GROUP_5   14.94  11.45  12.77  10.52  28.01  33.88  22.37  22.05
lu.C.x_156_NORMAL_1  20.00  20.58  18.47  18.68  19.47  19.74  19.42  19.63
lu.C.x_156_NORMAL_2  18.52  18.48  18.83  18.43  20.57  20.48  20.61  20.09
lu.C.x_156_NORMAL_3  20.27  20.00  20.05  21.18  19.55  19.00  18.59  17.36
lu.C.x_156_NORMAL_4  19.65  19.60  20.25  20.75  19.35  20.10  19.00  17.30
lu.C.x_156_NORMAL_5  19.79  19.67  20.62  22.42  18.42  18.00  17.67  19.42


From what I can see this was better but not perfect in v1.  It was closer and 
so the end results (LU reported times and op/s) were close enough. But looking 
closer at it there are still some issues. (NORMAL is comparable to above)


lu.C.x_152_GROUP_1   18.08  18.17  19.58  19.29  19.25  17.50  21.46  18.67
lu.C.x_152_GROUP_2   17.12  17.48  17.88  17.62  19.57  17.31  23.00  22.02
lu.C.x_152_GROUP_3   17.82  17.97  18.12  18.18  24.55  22.18  16.97  16.21
lu.C.x_152_GROUP_4   18.47  19.08  18.50  18.66  21.45  25.00  15.47  15.37
lu.C.x_152_GROUP_5   20.46  20.71  27.38  24.75  17.06  16.65  12.81  12.19

lu.C.x_156_GROUP_1   18.70  18.80  20.25  19.50  20.45  20.30  19.55  18.45
lu.C.x_156_GROUP_2   19.29  19.90  17.71  18.10  20.76  21.57  19.81  18.86
lu.C.x_156_GROUP_3   25.09  29.19  21.83  21.33  18.67  18.57  11.03  10.29
lu.C.x_156_GROUP_4   18.60  19.10  19.20  18.70  20.30  20.00  19.70  20.40
lu.C.x_156_GROUP_5   18.58  18.9   18.63  18.16  17.32  19.37  23.92  21.08

There is high variance so it may not be anythign specific between v1 and v3 here. 

The initial fixes I made for this issue did not exhibit this behavior. They 
would have had other issues dealing with overload cases though. In this case 
however there are only 154 or 158 threads on 160 CPUs so not overloaded. 

I'll try to get my hands on this system and poke into it. I just wanted to get 
your thoughts and let you know where we are. 



Thanks,
Phil


System details:

Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              160
On-line CPU(s) list: 0-159
Thread(s) per core:  2
Core(s) per socket:  10
Socket(s):           8
NUMA node(s):        8
Vendor ID:           GenuineIntel
CPU family:          6
Model:               47
Model name:          Intel(R) Xeon(R) CPU E7- 4870  @ 2.40GHz
Stepping:            2
CPU MHz:             1063.934
BogoMIPS:            4787.73
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            30720K
NUMA node0 CPU(s):   0-9,80-89
NUMA node1 CPU(s):   10-19,90-99
NUMA node2 CPU(s):   20-29,100-109
NUMA node3 CPU(s):   30-39,110-119
NUMA node4 CPU(s):   40-49,120-129
NUMA node5 CPU(s):   50-59,130-139
NUMA node6 CPU(s):   60-69,140-149
NUMA node7 CPU(s):   70-79,150-159
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm epb pti tpr_shadow vnmi flexpriority ept vpid dtherm ida arat

$ numactl --hardware
available: 8 nodes (0-7)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 80 81 82 83 84 85 86 87 88 89
node 0 size: 64177 MB
node 0 free: 60866 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 90 91 92 93 94 95 96 97 98 99
node 1 size: 64507 MB
node 1 free: 61167 MB
node 2 cpus: 20 21 22 23 24 25 26 27 28 29 100 101 102 103 104 105 106 107 108
109
node 2 size: 64507 MB
node 2 free: 61250 MB
node 3 cpus: 30 31 32 33 34 35 36 37 38 39 110 111 112 113 114 115 116 117 118
119
node 3 size: 64507 MB
node 3 free: 61327 MB
node 4 cpus: 40 41 42 43 44 45 46 47 48 49 120 121 122 123 124 125 126 127 128
129
node 4 size: 64507 MB
node 4 free: 60993 MB
node 5 cpus: 50 51 52 53 54 55 56 57 58 59 130 131 132 133 134 135 136 137 138
139
node 5 size: 64507 MB
node 5 free: 60892 MB
node 6 cpus: 60 61 62 63 64 65 66 67 68 69 140 141 142 143 144 145 146 147 148
149
node 6 size: 64507 MB
node 6 free: 61139 MB
node 7 cpus: 70 71 72 73 74 75 76 77 78 79 150 151 152 153 154 155 156 157 158
159
node 7 size: 64480 MB
node 7 free: 61188 MB
node distances:
node   0   1   2   3   4   5   6   7  
 0:  10  12  17  17  19  19  19  19  
 1:  12  10  17  17  19  19  19  19  
 2:  17  17  10  12  19  19  19  19  
 3:  17  17  12  10  19  19  19  19  
 4:  19  19  19  19  10  12  17  17  
 5:  19  19  19  19  12  10  17  17  
 6:  19  19  19  19  17  17  10  12  
 7:  19  19  19  19  17  17  12  10



-- 
