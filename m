Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59EC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F07A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pJyaYF4A";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="D6/GgAVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKVDk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:40:58 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:38406
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbfKVDk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574394056;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=wcQmc1qWWDKU3RNJ2PkVmyqKhxkuizlVBftBF+CvuBY=;
        b=pJyaYF4ArmYPkIh88+IuE3NFD66gMZN0Xyex3pEJtBnZMZwhIMtZvdc9e0uush0e
        heMqRL3XzGxBZdXs0XKHnHWdk4NYy/+R0I0OwvB/jHdGmS6y7oNh+dHDnHCZsQMHSUf
        UjofEFdYyJ+0BCtMiSILXc1zip9qzLjzEq00dchg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574394056;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=wcQmc1qWWDKU3RNJ2PkVmyqKhxkuizlVBftBF+CvuBY=;
        b=D6/GgAVYTb9Wb4AVgaxiziQ2xCMOm/tVKqBx/9VtH0A4CnJz3WlvAl+eiuQMm5Hj
        7wBKlOi2Xx60D0fPPBED/NVqGBTFJmahIegS85AxeQ/tBn6ugF5X9gnUQEF9w0N/+tT
        BH6JIp9roS2h3eWQJVfI3aBcMSRu+VNAwaCyJR7k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73AA6C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2] rcu: Fix missed wakeup of exp_wq waiters
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        gkohli@codeaurora.org, prsood@codeaurora.org,
        pkondeti@codeaurora.org, rcu@vger.kernel.org
References: <0101016e81a9ecb9-ce4a6425-f21d-4166-96ed-32d3700717f1-000000@us-west-2.amazonses.com>
 <20191119193827.GB2889@paulmck-ThinkPad-P72>
 <25499aba-04a1-8d03-e2d9-fc89d7794b66@codeaurora.org>
 <20191121040751.GY2889@paulmck-ThinkPad-P72>
 <8536f970-d22a-885c-8203-54a7c15a4f1f@codeaurora.org>
 <20191121150110.GB2889@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <0101016e9132cdfa-267e200d-e184-43c2-a802-8c9a3722bbbe-000000@us-west-2.amazonses.com>
Date:   Fri, 22 Nov 2019 03:40:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121150110.GB2889@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.11.22-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2019 8:31 PM, Paul E. McKenney wrote:
> On Thu, Nov 21, 2019 at 09:48:05AM +0530, Neeraj Upadhyay wrote:
>> On 11/21/2019 9:37 AM, Paul E. McKenney wrote:
>>> On Wed, Nov 20, 2019 at 10:28:38AM +0530, Neeraj Upadhyay wrote:
>>>>
>>>> On 11/20/2019 1:08 AM, Paul E. McKenney wrote:
>>>>> On Tue, Nov 19, 2019 at 03:17:07AM +0000, Neeraj Upadhyay wrote:
>>>>>> For the tasks waiting in exp_wq inside exp_funnel_lock(),
>>>>>> there is a chance that they might be indefinitely blocked
>>>>>> in below scenario:
>>>>>>
>>>>>> 1. There is a task waiting on exp sequence 0b'100' inside
>>>>>>       exp_funnel_lock(). This task blocks at wq index 1.
>>>>>>
>>>>>>       synchronize_rcu_expedited()
>>>>>>         s = 0b'100'
>>>>>>         exp_funnel_lock()
>>>>>>           wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]
>>>>>>
>>>>>> 2. The expedited grace period (which above task blocks for)
>>>>>>       completes and task (task1) holding exp_mutex queues
>>>>>>       worker and schedules out.
>>>>>>
>>>>>>       synchronize_rcu_expedited()
>>>>>>         s = 0b'100'
>>>>>>         queue_work(rcu_gp_wq, &rew.rew_work)
>>>>>>           wake_up_worker()
>>>>>>             schedule()
>>>>>>
>>>>>> 3. kworker A picks up the queued work and completes the exp gp
>>>>>>       sequence and then blocks on exp_wake_mutex, which is held
>>>>>>       by another kworker, which is doing wakeups for expedited_sequence
>>>>>>       0.
>>>>>>
>>>>>>       rcu_exp_wait_wake()
>>>>>>         rcu_exp_wait_wake()
>>>>>>           rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
>>>>>>                                   // to 0b'100'
>>>>>>           mutex_lock(&rcu_state.exp_wake_mutex)
>>>>>>
>>>>>> 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
>>>>>>       and releases exp_mutex.
>>>>>>
>>>>>>       wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>>>>>>         sync_exp_work_done(rsp, s));
>>>>>>       mutex_unlock(&rsp->exp_mutex);
>>>>>>
>>>>>> 5. Next exp GP completes, and sequence number is incremented:
>>>>>>
>>>>>>       rcu_exp_wait_wake()
>>>>>>         rcu_exp_wait_wake()
>>>>>>           rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
>>>>>>
>>>>>> 6. kworker A acquires exp_wake_mutex. As it uses current
>>>>>>       expedited_sequence, it wakes up workers from wrong wait queue
>>>>>>       index - it should have worken wait queue corresponding to
>>>>>>       0b'100' sequence, but wakes up the ones for 0b'200' sequence.
>>>>>>       This results in task at step 1 indefinitely blocked.
>>>>>>
>>>>>>       rcu_exp_wait_wake()
>>>>>>         wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
>>>>>>
>>>>>> This issue manifested as DPM device timeout during suspend, as scsi
>>>>>> device was stuck in _synchronize_rcu_expedited().
>>>>>>
>>>>>> schedule()
>>>>>> synchronize_rcu_expedited()
>>>>>> synchronize_rcu()
>>>>>> scsi_device_quiesce()
>>>>>> scsi_bus_suspend()
>>>>>> dpm_run_callback()
>>>>>> __device_suspend()
>>>>>>
>>>>>> Fix this by using the correct exp sequence number, the one which
>>>>>> owner of the exp_mutex initiated and passed to kworker,
>>>>>> to index the wait queue, inside rcu_exp_wait_wake().
>>>>>>
>>>>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>>>
>>>>> Queued, thank you!
>>>>>
>>>>> I reworked the commit message to make it easier to follow the sequence
>>>>> of events.  Please see below and let me know if I messed anything up.
>>>>>
>>>>> 							Thanx, Paul
>>>>>
>>>>> ------------------------------------------------------------------------
>>>>>
>>>>> commit d887fd2a66861f51ed93b5dde894b9646a5569dd
>>>>> Author: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>>> Date:   Tue Nov 19 03:17:07 2019 +0000
>>>>>
>>>>>        rcu: Fix missed wakeup of exp_wq waiters
>>>>>        Tasks waiting within exp_funnel_lock() for an expedited grace period to
>>>>>        elapse can be starved due to the following sequence of events:
>>>>>        1.      Tasks A and B both attempt to start an expedited grace
>>>>>                period at about the same time.  This grace period will have
>>>>>                completed when the lower four bits of the rcu_state structure's
>>>>>                ->expedited_sequence field are 0b'0100', for example, when the
>>>>>                initial value of this counter is zero.  Task A wins, and thus
>>>>>                does the actual work of starting the grace period, including
>>>>>                acquiring the rcu_state structure's .exp_mutex and sets the
>>>>>                counter to 0b'0001'.
>>>>>        2.      Because task B lost the race to start the grace period, it
>>>>>                waits on ->expedited_sequence to reach 0b'0100' inside of
>>>>>                exp_funnel_lock(). This task therefore blocks on the rcu_node
>>>>>                structure's ->exp_wq[1] field, keeping in mind that the
>>>>>                end-of-grace-period value of ->expedited_sequence (0b'0100')
>>>>>                is shifted down two bits before indexing the ->exp_wq[] field.
>>>>>        3.      Task C attempts to start another expedited grace period,
>>>>>                but blocks on ->exp_mutex, which is still held by Task A.
>>>>>        4.      The aforementioned expedited grace period completes, so that
>>>>>                ->expedited_sequence now has the value 0b'0100'.  A kworker task
>>>>>                therefore acquires the rcu_state structure's ->exp_wake_mutex
>>>>>                and starts awakening any tasks waiting for this grace period.
>>>>>        5.      One of the first tasks awakened happens to be Task A.  Task A
>>>>>                therefore releases the rcu_state structure's ->exp_mutex,
>>>>>                which allows Task C to start the next expedited grace period,
>>>>>                which causes the lower four bits of the rcu_state structure's
>>>>>                ->expedited_sequence field to become 0b'0101'.
>>>>>        6.      Task C's expedited grace period completes, so that the lower four
>>>>>                bits of the rcu_state structure's ->expedited_sequence field now
>>>>>                become 0b'1000'.
>>>>>        7.      The kworker task from step 4 above continues its wakeups.
>>>>>                Unfortunately, the wake_up_all() refetches the rcu_state
>>>>>                structure's .expedited_sequence field:
>>>>
>>>> This might not be true. I think wake_up_all(), which internally calls
>>>> __wake_up(), will use a single wq_head for doing all wakeups. So, a single
>>>> .expedited_sequence value would be used to get wq_head.
>>>>
>>>> void __wake_up(struct wait_queue_head *wq_head, ...)
>>>
>>> The wake_up_all() really is selecting among four different ->exp_wq[]
>>> array entries:
>>>
>>> wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
>>>
>>> So I lost you here.  Are you saying that the wake_up_all() will somehow
>>> be operating on ->exp_wq[1], which is where Task B is blocked?  Or that
>>> Task B would instead be blocked on ->exp_wq[2]?  Or that failing to wake
>>> up Task B is OK for some reason?  Or something else entirely?
>>
>> My bad; I was thinking only of the case where there is only one
>> rnp node (which is also the root) in RCU tree. In case of only
>> one rnp node also, issue can be seen. Please ignore my
>> comment. The commit description looks good to me.
> 
> Thank you for checking!
> 
> And the sequence of events below looks greatly improved over your
> original.  I suspect that there are more similar bugs to find in
> Linux-kernel RCU, so please use a carefully labeled style like that
> below when reporting the next one.
> 
> 							Thanx, Paul
> 

Ok, thanks. I will keep that in mind, while reporting any issues in future.


Thanks
Neeraj

>> Thanks
>> Neeraj
>>>
>>> 							Thanx, Paul
>>>
>>>> However, below sequence of events would result in problem:
>>>>
>>>> 1.      Tasks A starts an expedited grace period at about the same time.
>>>>           This grace period will have completed when the lower four bits
>>>> 		of the rcu_state structure's ->expedited_sequence field are 0b'0100',
>>>> 		for example, when the initial value of this counter is zero.
>>>> 		Task A wins, acquires the rcu_state structure's .exp_mutex and
>>>> 		sets the counter to 0b'0001'.
>>>>
>>>> 2.      The aforementioned expedited grace period completes, so that
>>>>           ->expedited_sequence now has the value 0b'0100'.  A kworker task
>>>>           therefore acquires the rcu_state structure's ->exp_wake_mutex
>>>>           and starts awakening any tasks waiting for this grace period.
>>>>           This kworker gets preempted while unlocking wq_head lock
>>>>
>>>>           wake_up_all()
>>>>             __wake_up()
>>>>               __wake_up_common_lock()
>>>>                 spin_unlock_irqrestore()
>>>>                   __raw_spin_unlock_irqrestore()
>>>>                     preempt_enable()
>>>>                       __preempt_schedule()
>>>>
>>>> 3.      One of the first tasks awakened happens to be Task A.  Task A
>>>>           therefore releases the rcu_state structure's ->exp_mutex,
>>>>
>>>> 4.      Tasks B and C both attempt to start an expedited grace
>>>>           period at about the same time.  This grace period will have
>>>>           completed when the lower four bits of the rcu_state structure's
>>>>           ->expedited_sequence field are 0b'1000'. Task B wins, and thus
>>>>           does the actual work of starting the grace period, including
>>>>           acquiring the rcu_state structure's .exp_mutex and sets the
>>>>           counter to 0b'0101'.
>>>>
>>>> 5.      Because task C lost the race to start the grace period, it
>>>>           waits on ->expedited_sequence to reach 0b'1000' inside of
>>>>           exp_funnel_lock(). This task therefore blocks on the rcu_node
>>>>           structure's ->exp_wq[2] field, keeping in mind that the
>>>>           end-of-grace-period value of ->expedited_sequence (0b'1000')
>>>>           is shifted down two bits before indexing the ->exp_wq[] field.
>>>>
>>>> 6.      Task B queues work to complete expedited grace period. This
>>>>           task is preempted just before wait_event call. Kworker task picks
>>>> 		up the work queued by task B and and completes grace period, so
>>>> 		that the lower four bits of the rcu_state structure's
>>>> 		->expedited_sequence field now become 0b'1000'. This kworker starts
>>>> 		waiting on the exp_wake_mutex, which is owned by kworker doing
>>>> 		wakeups for expedited sequence initiated by task A.
>>>>
>>>> 7.      Task B schedules in and finds its expedited sequence snapshot has
>>>>           completed; so, it does not enter waitq and releases exp_mutex. This
>>>> 		allows Task D to start the next expedited grace period,
>>>>           which causes the lower four bits of the rcu_state structure's
>>>>           ->expedited_sequence field to become 0b'1001'.
>>>>
>>>> 8.      Task D's expedited grace period completes, so that the lower four
>>>>           bits of the rcu_state structure's ->expedited_sequence field now
>>>>           become 0b'1100'.
>>>>
>>>> 9.      kworker from step 2 is scheduled in and releases exp_wake_mutex;
>>>>           kworker correspnding to Task B's expedited grace period acquires
>>>> 		exp_wake_mutex and starts wakeups. Unfortunately, it used the
>>>> 		rcu_state structure's .expedited_sequence field for determining
>>>> 		the waitq index.
>>>>
>>>>
>>>> wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
>>>>
>>>>           This results in the wakeup being applied to the rcu_node
>>>>           structure's ->exp_wq[3] field, which is unfortunate given that
>>>>           Task C is instead waiting on ->exp_wq[2].
>>>>
>>>>
>>>>>                wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
>>>>>                This results in the wakeup being applied to the rcu_node
>>>>>                structure's ->exp_wq[2] field, which is unfortunate given that
>>>>>                Task B is instead waiting on ->exp_wq[1].
>>>>>        On a busy system, no harm is done (or at least no permanent harm is done).
>>>>>        Some later expedited grace period will redo the wakeup.  But on a quiet
>>>>>        system, such as many embedded systems, it might be a good long time before
>>>>>        there was another expedited grace period.  On such embedded systems,
>>>>>        this situation could therefore result in a system hang.
>>>>>        This issue manifested as DPM device timeout during suspend (which
>>>>>        usually qualifies as a quiet time) due to a SCSI device being stuck in
>>>>>        _synchronize_rcu_expedited(), with the following stack trace:
>>>>>                schedule()
>>>>>                synchronize_rcu_expedited()
>>>>>                synchronize_rcu()
>>>>>                scsi_device_quiesce()
>>>>>                scsi_bus_suspend()
>>>>>                dpm_run_callback()
>>>>>                __device_suspend()
>>>>>        This commit therefore prevents such delays, timeouts, and hangs by
>>>>>        making rcu_exp_wait_wake() use its "s" argument consistently instead of
>>>>>        refetching from rcu_state.expedited_sequence.
>>>>
>>>> Do we need a "fixes" tag here?
>>>>
>>>>>        Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>>>        Signed-off-by: Paul E. McKenney <paulmck@kernel.org
>>>>>
>>>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>>>> index 6ce598d..4433d00a 100644
>>>>> --- a/kernel/rcu/tree_exp.h
>>>>> +++ b/kernel/rcu/tree_exp.h
>>>>> @@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
>>>>>     			spin_unlock(&rnp->exp_lock);
>>>>>     		}
>>>>>     		smp_mb(); /* All above changes before wakeup. */
>>>>> -		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
>>>>> +		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
>>>>>     	}
>>>>>     	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
>>>>>     	mutex_unlock(&rcu_state.exp_wake_mutex);
>>>>>
>>>>
>>>> -- 
>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>>>> the Code Aurora Forum, hosted by The Linux Foundation
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
