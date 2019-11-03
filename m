Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7828CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 05:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E9D215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 05:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKCFB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 01:01:26 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58281 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbfKCFB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 01:01:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Th1RgFd_1572757281;
Received: from 192.168.2.229(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th1RgFd_1572757281)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 03 Nov 2019 13:01:22 +0800
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
 <20191103020150.GA23770@tardis>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
Date:   Sun, 3 Nov 2019 13:01:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191103020150.GA23770@tardis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/3 10:01 上午, Boqun Feng wrote:
> Hi Jiangshan,
> 
> 
> I haven't checked the correctness of this patch carefully, but..
> 
> 
> On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
>> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
>> rcu_preempt_deferred_qs_irqrestore() doesn't expect
>> ->rcu_read_lock_nesting to be negative to work, it even
>> doesn't access to ->rcu_read_lock_nesting any more.
> 
> rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
> eventually call swake_up() or its friends to wake up, say, the gp
> kthread, and the wake up functions could go into the scheduler code
> path which might have RCU read-side critical section in it, IOW,
> accessing ->rcu_read_lock_nesting.

Sure, thank you for pointing it out.

I should rewrite the changelog in next round. Like this:

rcu: cleanup rcu_preempt_deferred_qs()

IRQ-protected rcu_preempt_deferred_qs_irqrestore() itself doesn't
expect ->rcu_read_lock_nesting to be negative to work.

There might be RCU read-side critical section in it (from wakeup()
or so), 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
will ensure that ->rcu_read_unlock_special is zero and these RCU
read-side critical sections will not call rcu_read_unlock_special().

Thanks
Lai

===
PS: Were 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
not applied earlier, it will be protected by previous patch (patch1)
in this series
"rcu: use preempt_count to test whether scheduler locks is held"
when rcu_read_unlock_special() is called.



> 
> Again, haven't checked closely, but this argument in the commit log
> seems untrue.
> 
> Regards,
> Boqun
> 
>>
>> It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
>> may access to ->rcu_read_lock_nesting, but it is still safe
>> since rcu_read_unlock_special() can protect itself from NMI.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   kernel/rcu/tree_plugin.h | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index aba5896d67e3..2fab8be2061f 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -552,16 +552,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
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
