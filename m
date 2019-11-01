Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F41CA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B52067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfKAC3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:29:46 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46423 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728218AbfKAC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:29:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tgp7hUD_1572575381;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgp7hUD_1572575381)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Nov 2019 10:29:42 +0800
Subject: Re: [PATCH 02/11] rcu: fix bug when rcu_exp_handler() in nested
 interrupt
To:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-3-laijs@linux.alibaba.com>
 <20191031134731.GP20975@paulmck-ThinkPad-P72>
 <20191031143119.GA15954@paulmck-ThinkPad-P72>
 <6b621228-4cab-6e2c-9912-cddc56ad6775@linux.alibaba.com>
 <20191031185258.GX20975@paulmck-ThinkPad-P72>
 <20191101001948.GA182@boqun-laptop.fareast.corp.microsoft.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <155e3e05-e0dc-26a7-c940-f86a819ffb2e@linux.alibaba.com>
Date:   Fri, 1 Nov 2019 10:29:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191101001948.GA182@boqun-laptop.fareast.corp.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/1 8:19 上午, Boqun Feng wrote:
> On Thu, Oct 31, 2019 at 11:52:58AM -0700, Paul E. McKenney wrote:
>> On Thu, Oct 31, 2019 at 11:14:23PM +0800, Lai Jiangshan wrote:
>>>
>>>
>>> On 2019/10/31 10:31 下午, Paul E. McKenney wrote:
>>>> On Thu, Oct 31, 2019 at 06:47:31AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, Oct 31, 2019 at 10:07:57AM +0000, Lai Jiangshan wrote:
>>>>>> These is a possible bug (although which I can't triger yet)
>>>>>> since 2015 8203d6d0ee78
>>>>>> (rcu: Use single-stage IPI algorithm for RCU expedited grace period)
>>>>>>
>>>>>>    rcu_read_unlock()
>>>>>>     ->rcu_read_lock_nesting = -RCU_NEST_BIAS;
>>>>>>     interrupt(); // before or after rcu_read_unlock_special()
>>>>>>      rcu_read_lock()
>>>>>>       fetch some rcu protected pointers
>>>>>>       // exp GP starts in other cpu.
>>>>>>       some works
>>>>>>       NESTED interrupt for rcu_exp_handler();
>>>>
>>>> Also, which platforms support nested interrupts?  Last I knew, this was
>>>> prohibited.
>>>>
>>>>>>         report exp qs! BUG!
>>>>>
>>>>> Why would a quiescent state for the expedited grace period be reported
>>>>> here?  This CPU is still in an RCU read-side critical section, isn't it?
>>>>
>>>> And I now see what you were getting at here.  Yes, the current code
>>>> assumes that interrupt-disabled regions, like hardware interrupt
>>>> handlers, cannot be interrupted.  But if interrupt-disabled regions such
>>>> as hardware interrupt handlers can be interrupted (as opposed to being
>>>> NMIed), wouldn't that break a whole lot of stuff all over the place in
>>>> the kernel?  So that sounds like an arch bug to me.
>>>
>>> I don't know when I started always assuming hardware interrupt
>>> handler can be nested by (other) interrupt. I can't find any
>>> documents say Linux don't allow nested interrupt handler.
>>> Google search suggests the opposite.
> 
> FWIW, there is a LWN article talking about we disallow interrupt nesting
> in *most* cases:
> 
> 	https://lwn.net/Articles/380931/

Much thanks for the information!


> 
> , that's unless a interrupt handler explicitly calls
> local_irq_enable_in_hardirq(), it remains irq disabled, which means no
> nesting interrupt allowed.
> 
Even so the problem here will be fixed by patch7/8.


> 
>>
>> The results I am seeing look to be talking about threaded interrupt
>> handlers, which indeed can be interrupted by hardware interrupts.  As can
>> softirq handlers.  But these are not examples of a hardware interrupt
>> handler being interrupted by another hardware interrupt.  For that to
>> work reasonably, something like a system priority level is required,
>> as in the old DYNIX/ptx kernel, or, going even farther back, DEC's RT-11.
>>
>>> grep -rIni nested Documentation/memory-barriers.txt Documentation/x86/
>>> It still have some words about nested interrupt handler.
>>
>> Some hardware does not differentiate between interrupts and exceptions,
>> for example, an illegal-instruction trap within an interrupt handler
>> might look in some ways like a nested interrupt.
>>
>>> The whole patchset doesn't depend on this patch, and actually
>>> it is reverted later in the patchset. Dropping this patch
>>> can be an option for next round.
>>
>> Sounds like a plan!
>>
>> 							Thanx, Paul
>>
> [...]
> 
