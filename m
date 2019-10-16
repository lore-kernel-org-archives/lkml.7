Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54406FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388EF2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394123AbfJPP1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:27:31 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50564 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393605AbfJPP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:27:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TfEscsj_1571239583;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TfEscsj_1571239583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Oct 2019 23:26:24 +0800
Subject: Re: [PATCH 6/7] rcu: rename some CONFIG_PREEMPTION to
 CONFIG_PREEMPT_RCU
To:     paulmck@kernel.org, 20191015102402.1978-1-laijs@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
 <20191015102850.2079-4-laijs@linux.alibaba.com>
 <20191016035407.GB2689@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <484d846f-8fbb-ccd2-d66a-a6b48d4a1df4@linux.alibaba.com>
Date:   Wed, 16 Oct 2019 23:26:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016035407.GB2689@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 11:54 上午, Paul E. McKenney wrote:
> On Tue, Oct 15, 2019 at 10:28:48AM +0000, Lai Jiangshan wrote:
>> CONFIG_PREEMPTION and CONFIG_PREEMPT_RCU are always identical,
>> but some code depends on CONFIG_PREEMPTION to access to
>> rcu_preempt functionalitis. This patch changes CONFIG_PREEMPTION
>> to CONFIG_PREEMPT_RCU in these cases.
>>
>> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> I believe that this does not cause problems with Sebastian's patch
> "[PATCH 27/34] rcu: Use CONFIG_PREEMPTION where appropriate", but could
> you please check?

I don't know for which commit the patch "[PATCH 27/34] rcu: Use
CONFIG_PREEMPTION where appropriate" should be applied against
after several tries. But I don't think there will be any conflicts
which this patch by "eye" applying.

Thanks,
Lai



> 
> 							Thanx, Paul
> 
>> ---
>>   kernel/rcu/tree.c       | 4 ++--
>>   kernel/rcu/tree_stall.h | 6 +++---
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 7db5ea06a9ed..81eb64fcf5ab 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1926,7 +1926,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
>>   	struct rcu_node *rnp_p;
>>   
>>   	raw_lockdep_assert_held_rcu_node(rnp);
>> -	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
>> +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RCU)) ||
>>   	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
>>   	    rnp->qsmask != 0) {
>>   		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>> @@ -2294,7 +2294,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>>   		mask = 0;
>>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>   		if (rnp->qsmask == 0) {
>> -			if (!IS_ENABLED(CONFIG_PREEMPTION) ||
>> +			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
>>   			    rcu_preempt_blocked_readers_cgp(rnp)) {
>>   				/*
>>   				 * No point in scanning bits because they
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index 0b75426ebb3e..55f9b84790d3 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
>>   //
>>   // Printing RCU CPU stall warnings
>>   
>> -#ifdef CONFIG_PREEMPTION
>> +#ifdef CONFIG_PREEMPT_RCU
>>   
>>   /*
>>    * Dump detailed information for all tasks blocking the current RCU
>> @@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
>>   	return ndetected;
>>   }
>>   
>> -#else /* #ifdef CONFIG_PREEMPTION */
>> +#else /* #ifdef CONFIG_PREEMPT_RCU */
>>   
>>   /*
>>    * Because preemptible RCU does not exist, we never have to check for
>> @@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
>>   {
>>   	return 0;
>>   }
>> -#endif /* #else #ifdef CONFIG_PREEMPTION */
>> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>>   
>>   /*
>>    * Dump stacks of all tasks running on stalled CPUs.  First try using
>> -- 
>> 2.20.1
>>
