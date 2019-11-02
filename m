Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062CBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D203C208CB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfKBApy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:45:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:51966 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726932AbfKBApy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:45:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgxzPUJ_1572655540;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgxzPUJ_1572655540)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 08:45:41 +0800
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
 <5d69ff1b-a477-31b5-8600-9233a38445c7@linux.alibaba.com>
 <20191101091348.GM28938@suse.de>
 <2573b108-7885-5c4f-a0ae-2b245d663250@linux.alibaba.com>
 <20191101133528.GP28938@suse.de>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <9eac8254-2d53-5d09-1394-26438db9a6a9@linux.alibaba.com>
Date:   Sat, 2 Nov 2019 08:45:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101133528.GP28938@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/1 下午9:35, Mel Gorman wrote:
> On Fri, Nov 01, 2019 at 07:52:15PM +0800, ?????? wrote:
>>> a much higher degree of flexibility on what information is tracked and
>>> allow flexibility on 
>>>
>>> So, overall I think this can be done outside the kernel but recognise
>>> that it may not be suitable in all cases. If you feel it must be done
>>> inside the kernel, split out the patch that adds information on failed
>>> page migrations as it stands apart. Put it behind its own kconfig entry
>>> that is disabled by default -- do not tie it directly to NUMA balancing
>>> because of the data structure changes. When enabled, it should still be
>>> disabled by default at runtime and only activated via kernel command line
>>> parameter so that the only people who pay the cost are those that take
>>> deliberate action to enable it.
>>
>> Agree, we could have these per-task faults info there, give the possibility
>> to implement maybe a practical userland tool,
> 
> I'd prefer not because that would still require the space in the locality
> array to store the data. I'd also prefer that numa_faults_locality[]
> information is not exposed unless this feature is enabled. That information
> is subject to change and interpreting it requires knowledge of the
> internals of automatic NUMA balancing.
> 
> There are just too many corner cases where the information is garbage.
> Tasks with a memory policy would never update the counters, short-lived
> tasks may not update it, interleaving will give confused information about
> locality, the timing of the reads matter because it might be cleared,
> the frequency at which they clear is unknown as the frequency is adaptive
> -- the list goes on. I find it very very difficult to believe that a
> tool based on faults_locality will be able to give anything but the
> most superficial help and any sensible decision will require ftrace or
> numa_maps to get real information.

Yeah, there are no very good approach to estimate the numa efficiency
since there are no per-task counter to tell the local & remote accessing
on hardware level, numa balancing won't cover all the cases, otherwise
we will have overhead issue again.

Well, at least we will be able to know whether this feature itself is
working well or not by reading locality, especially for cross nodes
workloads, locality could at least tell us the numa balancing is helping,
or just wasting resources :-P

> 
>> meanwhile have these kernel
>> numa data disabled by default, folks who got no tool but want to do easy
>> monitoring can just turn on the switch :-)
>>
>> Will have these in next version:
>>
>>  * separate patch for showing per-task faults info
> 
> Please only expose the failed= (or migfailed=) in that patch. Do not
> expose numa_faults_locality unless it is explicitly enabled on behalf of
> a tool that claims it can sensibly interpret it.

Sounds fair enough, no such tool yet.

> 
>>  * new CONFIG for numa stat (disabled by default)
>>  * dynamical runtime switch for numa stat (disabled by default)
> 
> Dynamic runtime enabling will mean that if it's turned on, the information
> will be temporarily useless until stats are accumulated. Make sure to
> note that in any associated documentation stating a preference to
> enabling it with a kernel parameter.

That's right, will highlight in the doc.

Regards,
Michael Wang

> 
