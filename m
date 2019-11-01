Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E4ACA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7953218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfKABtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:49:24 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38860 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfKABtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:49:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgoYySs_1572572960;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgoYySs_1572572960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Nov 2019 09:49:21 +0800
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191030095505.GF28938@suse.de>
 <6f5e43db-24f1-5283-0881-f264b0d5f835@linux.alibaba.com>
 <20191031131731.GJ28938@suse.de>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <5d69ff1b-a477-31b5-8600-9233a38445c7@linux.alibaba.com>
Date:   Fri, 1 Nov 2019 09:49:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031131731.GJ28938@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/31 下午9:17, Mel Gorman wrote:
> On Thu, Oct 31, 2019 at 11:31:24AM +0800, ?????? wrote:
[snip]
>> For example, tasks bind to the cpus of node_0 could have their memory on
>> node_1 when node_0 almost run out of memory, numa balancing may not be
>> able to help in this case, while by reading locality we could know how
>> critical the problem is, and may take action to rebind cpus to node_1 or
>> reclaim the memory of node_0.
>>
> 
> You can already do this by walking each cgroup, identifying what tasks are
> in it and look at /proc/PID/numa_maps and /proc/PID/status to see what
> CPU bindings if any exist. This would use the actual memory placements
> and not those sampled by NUMA balancing, would not require NUMA balancing
> and would work on older kernels. It would be costly to access so I would
> not suggest doing it at high frequency but it makes sense for the tool
> that cares to pay the cost instead of spreading tidy bits of cost to
> every task whether there is an interested tool or not.

I see the biggest concern now is the necessity to let kernel providing these
data, IMHO there are actually good reasons here:
  * there are too many tasks to gathering data from, reading proc cost a lot
  * tasks living and dying, data lost between each sample window

For example in our cases, we could have hundreds of cgroups, each contain
hundreds of tasks, these worker thread could live and die at any moment,
for gathering we need to cat the list of tasks and then go reading these proc
files one by one, which fall into kernel rapidly and may even need to holding
some locks, this introduced big latency impact, and give no accurate output
since some task may already died before reading it's data.

Then before next sample window, info of tasks died during the window can't be
acquired anymore.

We need kernel's help on reserving data since tool can't catch them in time
before they are lost, also we have to avoid rapidly proc reading, which really
cost a lot and further more, introduce big latency on each sample window.

> 
>>>
>>>>   * the numa execution time on each node
>>>>
>>>
>>> This is less obvious because it does not define what NUMA execution time
>>> is and it's not documented by the patch.
>>>
>>>> The task locality is the local page accessing ratio traced on numa
>>>> balancing PF, and the group locality is the topology of task execution
>>>> time, sectioned by the locality into 8 regions.
>>>>
>>>
>>> This is another important limitation. Disabling NUMA balancing will also
>>> disable the stats which may be surprising to some users. It's not a
>>> show-stopper but arguably the file should be non-existant or always
>>> zeros if NUMA balancing is disabled.
>>
>> Maybe a check on sched_numa_balancing before showing the data could
>> be helpful? when user turn off numa balancing dynamically, we no longer
>> showing the data.
>>
[snip]
>>>
>>> Not clear from the comment what the difference between a remote fault
>>> and a remote page access is. Superficially, they're the same thing.
>>
>> The 'fault' is recording before page migration while 'accessing'
>> is after, they could be different when the page has been migrated.
>>
> 
> That's a very small distinction given that the counters may only differ
> by number of pages migrated which may be a very small number.

This could be very different when we switch the workloads from one node to
another by changing it's allowed cpus, a lot of page migration will happen.

> 
>>> It might still be misleading because the failure could be due to lack of
>>> memory or because the page is pinned. However, I would not worry about
>>> that in this case.
>>>
>>> What *does* make this dangerous is that numa_faults_locality is often
>>> cleared. A user could easily think that this data somehow accumulates
>>> over time but it does not. This exposes implementation details as
>>> numa_faults_locality could change its behaviour in the future and tools
>>> should not rely on the contents being stable. While I recognise that
>>> some numa balancing information is already exposed in that file, it's
>>> relatively harmless with the possible exception of numa_scan_seq but
>>> at least that value is almost worthless (other than detecting if NUMA
>>> balancing is completely broken) and very unlikely to change behaviour.
[snip]
>>> This may be misleading if a task is using a preferred node policy that
>>> happens to be remote. It'll report bad locality but it's how the task
>>> waqs configured. Similarly, shared pages that are interleaves will show
>>> as remote accesses which is not necessarily bad. It goes back to "what
>>> does a sysadmin do with this information?"
>>
>> IMHO a very important usage of these data is to tell the numa users
>> "something maybe going wrong", could be on purpose or really a setting
>> issue, users could then try to figure out whether this is a false alarm
>> or not.
>>
> 
> While this has value, again I think it should be done in userspace. I
> didn't read v2 or respond to the individual points because I cannot
> convince myself this needs to be in the kernel at all. If different
> historical information was ever needed, it's easier to do that in a
> userspace tool that is independent of the kernel version.

IMHO gathering numa info from userspace can't help address the problem,
per-cgroup numa stat from kernel providing a general/easy/light way of
daily monitoring, which could be really necessary for numa platforms.

Regards,
Michael Wang

> 
