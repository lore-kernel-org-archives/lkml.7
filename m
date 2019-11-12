Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F870C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8302184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKLB2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:45 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34795 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727571AbfKLB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:28:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Thqw6v2_1573522118;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Thqw6v2_1573522118)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 09:28:39 +0800
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
To:     paulmck@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
 <20191103020150.GA23770@tardis>
 <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
 <20191104145539.GY20975@paulmck-ThinkPad-P72>
 <e820852f-87ca-f974-2245-99833205e270@linux.alibaba.com>
 <20191105071911.GL20975@paulmck-ThinkPad-P72>
 <20191111143238.GA13306@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <cbded276-6770-25a0-2975-2c087872a38e@linux.alibaba.com>
Date:   Tue, 12 Nov 2019 09:28:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191111143238.GA13306@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/11 10:32 下午, Paul E. McKenney wrote:
> On Mon, Nov 04, 2019 at 11:19:11PM -0800, Paul E. McKenney wrote:
>> On Tue, Nov 05, 2019 at 10:09:15AM +0800, Lai Jiangshan wrote:
>>> On 2019/11/4 10:55 下午, Paul E. McKenney wrote:
>>>> On Sun, Nov 03, 2019 at 01:01:21PM +0800, Lai Jiangshan wrote:
>>>>>
>>>>>
>>>>> On 2019/11/3 10:01 上午, Boqun Feng wrote:
>>>>>> Hi Jiangshan,
>>>>>>
>>>>>>
>>>>>> I haven't checked the correctness of this patch carefully, but..
>>>>>>
>>>>>>
>>>>>> On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
>>>>>>> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
>>>>>>> rcu_preempt_deferred_qs_irqrestore() doesn't expect
>>>>>>> ->rcu_read_lock_nesting to be negative to work, it even
>>>>>>> doesn't access to ->rcu_read_lock_nesting any more.
>>>>>>
>>>>>> rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
>>>>>> eventually call swake_up() or its friends to wake up, say, the gp
>>>>>> kthread, and the wake up functions could go into the scheduler code
>>>>>> path which might have RCU read-side critical section in it, IOW,
>>>>>> accessing ->rcu_read_lock_nesting.
>>>>>
>>>>> Sure, thank you for pointing it out.
>>>>>
>>>>> I should rewrite the changelog in next round. Like this:
>>>>>
>>>>> rcu: cleanup rcu_preempt_deferred_qs()
>>>>>
>>>>> IRQ-protected rcu_preempt_deferred_qs_irqrestore() itself doesn't
>>>>> expect ->rcu_read_lock_nesting to be negative to work.
>>>>>
>>>>> There might be RCU read-side critical section in it (from wakeup()
>>>>> or so), 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
>>>>> will ensure that ->rcu_read_unlock_special is zero and these RCU
>>>>> read-side critical sections will not call rcu_read_unlock_special().
>>>>>
>>>>> Thanks
>>>>> Lai
>>>>>
>>>>> ===
>>>>> PS: Were 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
>>>>> not applied earlier, it will be protected by previous patch (patch1)
>>>>> in this series
>>>>> "rcu: use preempt_count to test whether scheduler locks is held"
>>>>> when rcu_read_unlock_special() is called.
>>>>
>>>> This one in -rcu, you mean?
>>>>
>>>> 5c5d9065e4eb ("rcu: Clear ->rcu_read_unlock_special only once")
>>>
>>> Yes, but the commit ID is floating in the tree.
>>
>> Indeed, that part of -rcu is subject to rebase, and will continue
>> to be until about v5.5-rc5 or thereabouts.
>>
>> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
>>
>> My testing of your full stack should be complete by this coming Sunday
>> morning, Pacific Time.
> 
> And you will be happy to hear that it ran the full time without errors.
> 
> Good show!!!
> 
> My next step is to look much more carefully at the remaining patches,
> checking my first impressions.  This will take a few days.
> 

Hi, All

I'm still asking for more comments.

By now, I have received some precious comments, mainly due to my
stupid naming mistakes and a misleading changelog. I should have
updated all these with a new series patches. But I hope I
can polish more in the new patchset with more suggestions from
valuable comments, especially in x86,scheduler,percpu and rcu
areas.

I'm very obliged to hear anything.

Thanks
Lai
