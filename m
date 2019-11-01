Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5544CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52BD21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfKALwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:52:21 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35819 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfKALwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:52:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgtH3hA_1572609135;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgtH3hA_1572609135)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Nov 2019 19:52:16 +0800
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
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <2573b108-7885-5c4f-a0ae-2b245d663250@linux.alibaba.com>
Date:   Fri, 1 Nov 2019 19:52:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101091348.GM28938@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/1 下午5:13, Mel Gorman wrote:
[snip]
>> For example in our cases, we could have hundreds of cgroups, each contain
>> hundreds of tasks, these worker thread could live and die at any moment,
>> for gathering we need to cat the list of tasks and then go reading these proc
>> files one by one, which fall into kernel rapidly and may even need to holding
>> some locks, this introduced big latency impact, and give no accurate output
>> since some task may already died before reading it's data.
>>
>> Then before next sample window, info of tasks died during the window can't be
>> acquired anymore.
>>
>> We need kernel's help on reserving data since tool can't catch them in time
>> before they are lost, also we have to avoid rapidly proc reading, which really
>> cost a lot and further more, introduce big latency on each sample window.
>>
> 
> There is somewhat of a disconnect here. You say that the information must
> be accurate and historical yet are relying on NUMA hinting faults to build
> the picture which may not be accurate at all given that faults are not
> guaranteed to happen. For short-lived tasks, it is also potentially skewed
> information if short-lived tasks dominated remote accesses for whatever
> reason even though it does not matter -- the tasks were short-lived and
> their performance is probably irrelevant. Short-lived tasks may not even
> show up if they do not run longer than sysctl_numa_balancing_scan_delay
> so the data gathered already has holes in it.
> 
> While it's a bit more of a stretch, even this could still be done from
> userspace if numa_hint_fault was probed and the event handled (eBPF,
> systemtap etc) to build the picture or add a tracepoint. That would give
> a much higher degree of flexibility on what information is tracked and
> allow flexibility on 
> 
> So, overall I think this can be done outside the kernel but recognise
> that it may not be suitable in all cases. If you feel it must be done
> inside the kernel, split out the patch that adds information on failed
> page migrations as it stands apart. Put it behind its own kconfig entry
> that is disabled by default -- do not tie it directly to NUMA balancing
> because of the data structure changes. When enabled, it should still be
> disabled by default at runtime and only activated via kernel command line
> parameter so that the only people who pay the cost are those that take
> deliberate action to enable it.

Agree, we could have these per-task faults info there, give the possibility
to implement maybe a practical userland tool, meanwhile have these kernel
numa data disabled by default, folks who got no tool but want to do easy
monitoring can just turn on the switch :-)

Will have these in next version:

 * separate patch for showing per-task faults info
 * new CONFIG for numa stat (disabled by default)
 * dynamical runtime switch for numa stat (disabled by default)
 * doc to explain the numa stat and give hint on how to handle it

Best Regards,
Michale Wang

> 
