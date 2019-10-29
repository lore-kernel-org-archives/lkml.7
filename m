Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB56CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AE0217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfJ2CCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 22:02:41 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51077 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728242AbfJ2CCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:02:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgaVt6a_1572314557;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgaVt6a_1572314557)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Oct 2019 10:02:38 +0800
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191028130222.GM4131@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <2b692012-50b5-20f1-b656-fd72a12c1d1a@linux.alibaba.com>
Date:   Tue, 29 Oct 2019 10:02:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028130222.GM4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/28 下午9:02, Peter Zijlstra wrote:
[snip]
>> +	tg = task_group(p);
>> +	while (tg) {
>> +		/* skip account when there are no faults records */
>> +		if (idx != -1)
>> +			this_cpu_inc(tg->numa_stat->locality[idx]);
>> +
>> +		this_cpu_inc(tg->numa_stat->jiffies);
>> +
>> +		tg = tg->parent;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
> 
> Thing is, we already have a cgroup hierarchy walk in the tick; see
> task_tick_fair().
> 
> On top of that, you're walking an entirely different set of pointers,
> instead of cfs_rq, you're walking tg->parent, which pretty much
> guarantees you're adding even more cache misses.
> 
> How about you stick those numa_stats in cfs_rq (with cacheline
> alignment) and see if you can frob your update loop into the cgroup walk
> we already do.

Thanks for the reply :-)

The hierarchy walk here you mean is the loop of entity_tick(), correct?

Should working if we introduce the per-cfs_rq numa_stat accounting and
do update there, I'll try to reform the implementation in next version.

Regards,
Michael Wang

> 
