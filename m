Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E445C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1C022BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfGYVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:43:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:50797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGYVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:43:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 14:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="178151887"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jul 2019 14:42:57 -0700
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ebb80369-27c7-9a6a-721c-4c0e4167dd3f@linux.intel.com>
Date:   Fri, 26 Jul 2019 05:42:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190725143003.GA992@aaronlu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/25 22:30, Aaron Lu wrote:
> On Mon, Jul 22, 2019 at 06:26:46PM +0800, Aubrey Li wrote:
>> The granularity period of util_avg seems too large to decide task priority
>> during pick_task(), at least it is in my case, cfs_prio_less() always picked
>> core max task, so pick_task() eventually picked idle, which causes this change
>> not very helpful for my case.
>>
>>  <idle>-0     [057] dN..    83.716973: __schedule: max: sysbench/2578
>> ffff889050f68600
>>  <idle>-0     [057] dN..    83.716974: __schedule:
>> (swapper/5/0;140,0,0) ?< (mysqld/2511;119,1042118143,0)
>>  <idle>-0     [057] dN..    83.716975: __schedule:
>> (sysbench/2578;119,96449836,0) ?< (mysqld/2511;119,1042118143,0)
>>  <idle>-0     [057] dN..    83.716975: cfs_prio_less: picked
>> sysbench/2578 util_avg: 20 527 -507 <======= here===
>>  <idle>-0     [057] dN..    83.716976: __schedule: pick_task cookie
>> pick swapper/5/0 ffff889050f68600
> 
> I tried a different approach based on vruntime with 3 patches following.
> 
> When the two tasks are on the same CPU, no change is made, I still route
> the two sched entities up till they are in the same group(cfs_rq) and
> then do the vruntime comparison.
> 
> When the two tasks are on differen threads of the same core, the root
> level sched_entities to which the two tasks belong will be used to do
> the comparison.
> 
> An ugly illustration for the cross CPU case:
> 
>    cpu0         cpu1
>  /   |  \     /   |  \
> se1 se2 se3  se4 se5 se6
>     /  \            /   \
>   se21 se22       se61  se62
> 
> Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
> task B's se is se61. To compare priority of task A and B, we compare
> priority of se2 and se6. The smaller vruntime wins.
> 
> To make this work, the root level ses on both CPU should have a common
> cfs_rq min vuntime, which I call it the core cfs_rq min vruntime.
> 
> This is mostly done in patch2/3.
> 
> Test:
> 1 wrote an cpu intensive program that does nothing but while(1) in
>   main(), let's call it cpuhog;
> 2 start 2 cgroups, with one cgroup's cpuset binding to CPU2 and the
>   other binding to cpu3. cpu2 and cpu3 are smt siblings on the test VM;
> 3 enable cpu.tag for the two cgroups;
> 4 start one cpuhog task in each cgroup;
> 5 kill both cpuhog tasks after 10 seconds;
> 6 check each cgroup's cpu usage.
> 
> If the task is scheduled fairly, then each cgroup's cpu usage should be
> around 5s.
> 
> With v3, the cpu usage of both cgroups are sometimes 3s, 7s; sometimes
> 1s, 9s.
> 
> With the 3 patches applied, the numbers are mostly around 5s, 5s.
> 
> Another test is starting two cgroups simultaneously with cpu.tag set,
> with one cgroup running: will-it-scale/page_fault1_processes -t 16 -s 30,
> the other running: will-it-scale/page_fault2_processes -t 16 -s 30.
> With v3, like I said last time, the later started page_fault processes
> can't start running. With the 3 patches applied, both running at the
> same time with each CPU having a relatively fair score:
> 
> output line of 16 page_fault1 processes in 1 second interval:
> min:105225 max:131716 total:1872322
> 
> output line of 16 page_fault2 processes in 1 second interval:
> min:86797 max:110554 total:1581177
> 
> Note the value in min and max, the smaller the gap is, the better the
> faireness is.
> 
> Aubrey,
> 
> I haven't been able to run your workload yet...
> 

No worry, let me try to see how it works.

Thanks,
-Aubrey
