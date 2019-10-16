Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608FCC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E1320663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfJPEYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:24:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56164 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729376AbfJPEYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:24:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TfBfph7_1571199849;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TfBfph7_1571199849)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Oct 2019 12:24:09 +0800
Subject: Re: [PATCH 2/7] rcu: fix tracepoint string when RCU CPU kthread runs
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191015102402.1978-1-laijs@linux.alibaba.com>
 <20191015102402.1978-3-laijs@linux.alibaba.com>
 <20191016033814.GX2689@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <c54063d6-c6d0-cd8c-40e3-5185258d71dd@linux.alibaba.com>
Date:   Wed, 16 Oct 2019 12:24:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016033814.GX2689@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 11:38 上午, Paul E. McKenney wrote:
> On Tue, Oct 15, 2019 at 10:23:57AM +0000, Lai Jiangshan wrote:
>> "rcu_wait" is incorrct here, use "rcu_run" instead.
>>
>> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   kernel/rcu/tree.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 278798e58698..c351fc280945 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -2485,7 +2485,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>>   	int spincnt;
>>   
>>   	for (spincnt = 0; spincnt < 10; spincnt++) {
>> -		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
>> +		trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
>>   		local_bh_disable();
>>   		*statusp = RCU_KTHREAD_RUNNING;
>>   		local_irq_disable();
>> @@ -2496,7 +2496,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>>   			rcu_core();
>>   		local_bh_enable();
>>   		if (*workp == 0) {
>> -			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
>> +			trace_rcu_utilization(TPS("End CPU kthread@rcu_run"));
> 
> This one needs to stay as it was because this is where we wait when out
> of work.

I don't fully understand those TPS marks.

If it is all about "where we wait when out of work", it ought to
be "Start ... wait", rather than "End ... wait". The later one
("End ... wait") should be put before
"for (spincnt = 0; spincnt < 10; spincnt++)" and remove
the whole "rcu_run" as this patch suggested. To be honest,
"rcu_run" is redundant since we already has TPS("Start RCU core").

Any ways, patch2&3 lose their relevance and should be dropped.
Looking forward to your improved version.

Thanks,
Lai

> 
> So I took the first hunk and dropped this second hunk.
> 
> Please let me know if I am missing something.
> 
> 							Thanx, Paul
> 
>>   			*statusp = RCU_KTHREAD_WAITING;
>>   			return;
>>   		}
>> -- 
>> 2.20.1
>>
