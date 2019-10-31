Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD44CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6120873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfJaPZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:25:19 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:56427 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfJaPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:25:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tgn887B_1572535511;
Received: from 192.168.2.229(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgn887B_1572535511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 23:25:12 +0800
Subject: Re: [PATCH 03/11] rcu: clean up rcu_preempt_deferred_qs_irqrestore()
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-4-laijs@linux.alibaba.com>
 <20191031135234.GQ20975@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <49c778ff-2187-26fb-1477-bdef6eaf298b@linux.alibaba.com>
Date:   Thu, 31 Oct 2019 23:25:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031135234.GQ20975@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/31 9:52 下午, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 10:07:58AM +0000, Lai Jiangshan wrote:
>> Remove several unneeded return.
>>
>> It doesn't need to return earlier after every code block.
>> The code protects itself and be safe to fall through because
>> every code block has its own condition tests.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   kernel/rcu/tree_plugin.h | 14 +-------------
>>   1 file changed, 1 insertion(+), 13 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 59ef10da1e39..82595db04eec 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -439,19 +439,10 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>   	 * t->rcu_read_unlock_special cannot change.
>>   	 */
>>   	special = t->rcu_read_unlock_special;
>> -	rdp = this_cpu_ptr(&rcu_data);
>> -	if (!special.s && !rdp->exp_deferred_qs) {
>> -		local_irq_restore(flags);
>> -		return;
>> -	}
> 
> The point of this check is the common case of this function being invoked
> when both fields are zero, avoiding the below redundant store and all the
> extra checks of subfields of special.
> 
> Or are you saying that current compilers figure all this out?

No.

So, I have to keep the first/above return branch.

Any reasons to keep the following 2 return branches?
There is no redundant store and the load for the checks
are hot in the cache if the condition for return is met.

Thanks.
Lai

> 
> 							Thanx, Paul
> 
>>   	t->rcu_read_unlock_special.b.deferred_qs = false;
>>   	if (special.b.need_qs) {
>>   		rcu_qs();
>>   		t->rcu_read_unlock_special.b.need_qs = false;
>> -		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
>> -			local_irq_restore(flags);
>> -			return;
>> -		}
>>   	}
>>   
>>   	/*
>> @@ -460,12 +451,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>   	 * tasks are handled when removing the task from the
>>   	 * blocked-tasks list below.
>>   	 */
>> +	rdp = this_cpu_ptr(&rcu_data);
>>   	if (rdp->exp_deferred_qs) {
>>   		rcu_report_exp_rdp(rdp);
>> -		if (!t->rcu_read_unlock_special.s) {
>> -			local_irq_restore(flags);
>> -			return;
>> -		}
>>   	}
>>   
>>   	/* Clean up if blocked during RCU read-side critical section. */
>> -- 
>> 2.20.1
>>
