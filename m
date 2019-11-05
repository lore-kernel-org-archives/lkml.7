Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004CCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C08217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfKECJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:09:20 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35101 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728987AbfKECJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:09:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ThE8SMa_1572919755;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0ThE8SMa_1572919755)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Nov 2019 10:09:16 +0800
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
To:     paulmck@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
 <20191103020150.GA23770@tardis>
 <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
 <20191104145539.GY20975@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <e820852f-87ca-f974-2245-99833205e270@linux.alibaba.com>
Date:   Tue, 5 Nov 2019 10:09:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104145539.GY20975@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/4 10:55 下午, Paul E. McKenney wrote:
> On Sun, Nov 03, 2019 at 01:01:21PM +0800, Lai Jiangshan wrote:
>>
>>
>> On 2019/11/3 10:01 上午, Boqun Feng wrote:
>>> Hi Jiangshan,
>>>
>>>
>>> I haven't checked the correctness of this patch carefully, but..
>>>
>>>
>>> On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
>>>> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
>>>> rcu_preempt_deferred_qs_irqrestore() doesn't expect
>>>> ->rcu_read_lock_nesting to be negative to work, it even
>>>> doesn't access to ->rcu_read_lock_nesting any more.
>>>
>>> rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
>>> eventually call swake_up() or its friends to wake up, say, the gp
>>> kthread, and the wake up functions could go into the scheduler code
>>> path which might have RCU read-side critical section in it, IOW,
>>> accessing ->rcu_read_lock_nesting.
>>
>> Sure, thank you for pointing it out.
>>
>> I should rewrite the changelog in next round. Like this:
>>
>> rcu: cleanup rcu_preempt_deferred_qs()
>>
>> IRQ-protected rcu_preempt_deferred_qs_irqrestore() itself doesn't
>> expect ->rcu_read_lock_nesting to be negative to work.
>>
>> There might be RCU read-side critical section in it (from wakeup()
>> or so), 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
>> will ensure that ->rcu_read_unlock_special is zero and these RCU
>> read-side critical sections will not call rcu_read_unlock_special().
>>
>> Thanks
>> Lai
>>
>> ===
>> PS: Were 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
>> not applied earlier, it will be protected by previous patch (patch1)
>> in this series
>> "rcu: use preempt_count to test whether scheduler locks is held"
>> when rcu_read_unlock_special() is called.
> 
> This one in -rcu, you mean?
> 
> 5c5d9065e4eb ("rcu: Clear ->rcu_read_unlock_special only once")


Yes, but the commit ID is floating in the tree.

> 
> Some adjustment was needed due to my not applying the earlier patches
> that assumed nested interrupts.  Please let me know if further adjustments
> are needed.

I don't think the earlier patches are needed. If the possible? nested
interrupts described in my previous emails is an issue, the patch
"rcu: don't use negative ->rcu_read_lock_nesting" in this
series is enough to fixed it. If any adjustments needed for
this series, I will just put the adjustments the series.

Thanks
Lai

> 
> 							Thanx, Paul
> 
>>> Again, haven't checked closely, but this argument in the commit log
>>> seems untrue.
>>>
>>> Regards,
>>> Boqun
>>>
>>>>
>>>> It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
>>>> may access to ->rcu_read_lock_nesting, but it is still safe
>>>> since rcu_read_unlock_special() can protect itself from NMI.
>>>>
>>>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>>>> ---
>>>>    kernel/rcu/tree_plugin.h | 5 -----
>>>>    1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>> index aba5896d67e3..2fab8be2061f 100644
>>>> --- a/kernel/rcu/tree_plugin.h
>>>> +++ b/kernel/rcu/tree_plugin.h
>>>> @@ -552,16 +552,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>>>>    static void rcu_preempt_deferred_qs(struct task_struct *t)
>>>>    {
>>>>    	unsigned long flags;
>>>> -	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
>>>>    	if (!rcu_preempt_need_deferred_qs(t))
>>>>    		return;
>>>> -	if (couldrecurse)
>>>> -		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
>>>>    	local_irq_save(flags);
>>>>    	rcu_preempt_deferred_qs_irqrestore(t, flags);
>>>> -	if (couldrecurse)
>>>> -		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
>>>>    }
>>>>    /*
>>>> -- 
>>>> 2.20.1
>>>>
