Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A20CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726FD20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfJaOfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:35:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46602 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbfJaOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:35:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tgn.PxY_1572532522;
Received: from 192.168.2.229(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgn.PxY_1572532522)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 22:35:22 +0800
Subject: Re: [PATCH 04/11] rcu: cleanup rcu_preempt_deferred_qs()
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-5-laijs@linux.alibaba.com>
 <20191031141056.GR20975@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <1b5cf860-3d4a-954c-09ac-6383b38da4cf@linux.alibaba.com>
Date:   Thu, 31 Oct 2019 22:35:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031141056.GR20975@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/31 10:10 下午, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 10:07:59AM +0000, Lai Jiangshan wrote:
>> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
>> rcu_preempt_deferred_qs_irqrestore() doesn't expect
>> ->rcu_read_lock_nesting to be negative to work, it even
>> doesn't access to ->rcu_read_lock_nesting any more.
>>
>> It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
>> may access to ->rcu_read_lock_nesting, but it is still safe
>> since rcu_read_unlock_special() can protect itself from NMI.
> 
> Hmmm...  Testing identified the need for this one.  But I will wait for
> your responses on the earlier patches before going any further through
> this series.

Hmmm... I was wrong, it should be after patch7 to avoid
the scheduler deadlock.

> 
> 							Thanx, Paul
> 
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   kernel/rcu/tree_plugin.h | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 82595db04eec..9fe8138ed3c3 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -555,16 +555,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>>   static void rcu_preempt_deferred_qs(struct task_struct *t)
>>   {
>>   	unsigned long flags;
>> -	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
>>   
>>   	if (!rcu_preempt_need_deferred_qs(t))
>>   		return;
>> -	if (couldrecurse)
>> -		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
>>   	local_irq_save(flags);
>>   	rcu_preempt_deferred_qs_irqrestore(t, flags);
>> -	if (couldrecurse)
>> -		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
>>   }
>>   
>>   /*
>> -- 
>> 2.20.1
>>
