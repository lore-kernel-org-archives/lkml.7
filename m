Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0EC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C101720883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437065AbfFLBw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:52:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:22044 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437016AbfFLBw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:52:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 18:52:56 -0700
X-ExtLoop1: 1
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2019 18:52:51 -0700
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <4bd9a132-bbdb-ec45-331f-829df07a7376@linux.intel.com>
Date:   Wed, 12 Jun 2019 09:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190606152637.GA5703@sinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/6 23:26, Julien Desfossez wrote:
> As mentioned above, we have come up with a fix for the long starvation
> of untagged interactive threads competing for the same core with tagged
> threads at the same priority. The idea is to detect the stall and boost
> the stalling threads priority so that it gets a chance next time.
> Boosting is done by a new counter(min_vruntime_boost) for every task
> which we subtract from vruntime before comparison. The new logic looks
> like this:
> 
> If we see that normalized runtimes are equal, we check the min_vruntimes
> of their runqueues and give a chance for the task in the runqueue with
> less min_vruntime. That will help it to progress its vruntime. While
> doing this, we boost the priority of the task in the sibling so that, we
> don’t starve the task in the sibling until the min_vruntime of this
> runqueue catches up.
> 
> If min_vruntimes are also equal, we do as before and consider the task
> ‘a’ of higher priority. Here we boost the task ‘b’ so that it gets to
> run next time.
> 
> The min_vruntime_boost is reset to zero once the task in on cpu. So only
> waiting tasks will have a non-zero value if it is starved while matching
> a task on the other sibling.
> 
> The attached patch has a sched_feature to enable the above feature so
> that you can compare the results with and without this feature.
> 
> What we observe with this patch is that it helps for untagged
> interactive tasks and fairness in general, but this increases the
> overhead of core scheduling when there is contention for the CPU with
> tasks of varying cpu usage. The general trend we see is that if there is
> a cpu intensive thread and multiple relatively idle threads in different
> tags, the cpu intensive tasks continuously yields to be fair to the
> relatively idle threads when it becomes runnable. And if the relatively
> idle threads make up for most of the tasks in a system and are tagged,
> the cpu intensive tasks sees a considerable drop in performance.
> 
> If you have any feedback or creative ideas to help improve, let us
> know !

The data on my side looks good with CORESCHED_STALL_FIX = true.

Environment setup
--------------------------
Skylake 8170 server, 2 numa nodes, 52 cores, 104 CPUs (HT on)
cgroup1 workload, sysbench (CPU mode, non AVX workload)
cgroup2 workload, gemmbench (AVX512 workload)

sysbench throughput result:
.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	      490.8	[ 0.1%/ 0.0%]	  1.9% |        492.6	[ 0.1%/ 0.0%]	  0.4%	  1.9% |   489.5 [ 0.1%/ 0.0%]  -0.3%	  3.9% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|  2/2	      975.0	[ 0.6%/ 0.1%]	  3.9% |        970.4	[ 0.4%/ 0.0%]	 -0.5%	  3.9% |   975.6 [ 0.2%/ 0.0%]   0.1%	  7.7% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|  4/4	     1856.9	[ 0.2%/ 0.0%]	  7.8% |       1854.5	[ 0.3%/ 0.0%]	 -0.1%	  7.8% |  1849.4 [ 0.8%/ 0.1%]  -0.4%	 14.8% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|  8/8	     3622.8	[ 0.2%/ 0.0%]	 14.6% |       3618.3	[ 0.1%/ 0.0%]	 -0.1%	 14.7% |  3626.6 [ 0.4%/ 0.0%]   0.1%	 30.1% |
'--------------------------------------------------------------------------------------------------------------------------------------'
| 16/16	     6976.7	[ 0.2%/ 0.0%]	 30.1% |       6959.3	[ 0.3%/ 0.0%]	 -0.2%	 30.1% |  6964.4 [ 0.9%/ 0.1%]  -0.2%	 60.1% |
'--------------------------------------------------------------------------------------------------------------------------------------'
| 32/32	    10347.7	[ 3.8%/ 0.4%]	 60.1% |      11525.4	[ 2.8%/ 0.3%]	 11.4%	 59.5% |  9810.5 [ 9.4%/ 0.8%]  -5.2%	 97.7% |
'--------------------------------------------------------------------------------------------------------------------------------------'
| 64/64	    15284.9	[ 9.0%/ 0.9%]	 98.1% |      17022.1	[ 4.5%/ 0.5%]	 11.4%	 98.2% |  9989.7 [19.3%/ 1.1%] -34.6%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|128/128    16211.3	[18.9%/ 1.9%]	100.0% |      16507.9	[ 6.1%/ 0.6%]	  1.8%	 99.8% | 10379.0 [12.6%/ 0.8%] -36.0%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|256/256    16667.1	[ 3.1%/ 0.3%]	100.0% |      16499.1	[ 3.2%/ 0.3%]	 -1.0%	100.0% | 10540.9 [16.2%/ 1.0%] -36.8%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

sysbench latency result:
(The story we care about latency is that some customers reported their
latency critical job is affected when co-locating a deep learning job
(AVX512 task) onto the same core, because when a core executes AVX512
instructions, the core automatically reduces its frequency. This can
lead to a significant overall performance loss for a non-AVX512 job
on the same core.

And now we have core cookie match mechanism, so if we put AVX512 task
and non AVX512 task into the different cgroups, they are supposed not
to be co-located. That's why we saw the improvements of 32/32 and 64/64
cases.) 

.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	        2.1	[ 0.6%/ 0.1%]	  1.9% |          2.0	[ 0.2%/ 0.0%]	  3.8%	  1.9% |     2.1 [ 0.7%/ 0.1%]  -0.8%	  3.9% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|  2/2	        2.1	[ 0.7%/ 0.1%]	  3.9% |          2.1	[ 0.3%/ 0.0%]	  0.2%	  3.9% |     2.1 [ 0.6%/ 0.1%]   0.5%	  7.7% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|  4/4	        2.2	[ 0.6%/ 0.1%]	  7.8% |          2.2	[ 0.4%/ 0.0%]	 -0.2%	  7.8% |     2.2 [ 0.2%/ 0.0%]  -0.3%	 14.8% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|  8/8	        2.2	[ 0.4%/ 0.0%]	 14.6% |          2.2	[ 0.0%/ 0.0%]	  0.1%	 14.7% |     2.2 [ 0.0%/ 0.0%]   0.1%	 30.1% |
'--------------------------------------------------------------------------------------------------------------------------------------'
| 16/16	        2.4	[ 1.6%/ 0.2%]	 30.1% |          2.4	[ 1.6%/ 0.2%]	 -0.9%	 30.1% |     2.4 [ 1.9%/ 0.2%]  -0.3%	 60.1% |
'--------------------------------------------------------------------------------------------------------------------------------------'
| 32/32	        4.9	[ 6.2%/ 0.6%]	 60.1% |          3.1	[ 5.0%/ 0.5%]	 36.6%	 59.5% |     6.7 [17.3%/ 3.7%] -34.5%	 97.7% |
'--------------------------------------------------------------------------------------------------------------------------------------'
| 64/64	        9.4	[28.3%/ 2.8%]	 98.1% |          3.5	[25.6%/ 2.6%]	 62.4%	 98.2% |    18.5 [ 9.5%/ 5.0%] -97.9%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|128/128       21.3	[10.1%/ 1.0%]	100.0% |         24.8	[ 8.1%/ 0.8%]	-16.1%	 99.8% |    34.5 [ 4.9%/ 0.7%] -62.0%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'
|256/256       35.5	[ 7.8%/ 0.8%]	100.0% |         37.3	[ 5.4%/ 0.5%]	 -5.1%	100.0% |    40.8 [ 5.9%/ 0.6%] -15.0%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

Note:
----
64/64:		64 sysbench threads(in one cgroup) and 64 gemmbench threads(in other cgroup) run simultaneously.
Vanilla-SMT:	baseline with HT on
coresched-SMT:	core scheduling enabled
no-SMT:		HT off thru /sys/devices/system/cpu/smt/control
std%:		standard deviation
sem%:		standard error of the mean
±:		improvement/regression against baseline
cpu%:		derived by vmstat.idle and vmstat.iowait
