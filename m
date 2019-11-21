Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D80C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1A20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pdd7aoWe";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JIeCfZIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKUEgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 23:36:51 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:38618
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbfKUEgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 23:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574311009;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=J8o9Sijo++BVPP0PJOgI7j7c7B/AnkslQwKDPxAGBCg=;
        b=Pdd7aoWeJW8+7t/PDVf5TQqAfD0D9eTvKozg7cVkwRVfVH2N4dMqgSfYWKQSOWUE
        xQXNxK4CpC62ZJxLKinwxpJgEWHjg7uMaxlqmizBdwuS6p5WShDtiXqKDr1yAtkSEnJ
        sqrk3ILF5ivvrQXOU79oF/AjljamH06S/iEzxIh0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574311009;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=J8o9Sijo++BVPP0PJOgI7j7c7B/AnkslQwKDPxAGBCg=;
        b=JIeCfZIplIC9iTi5ub2ZKuGUWeRDpbCpFCghMIgO0fmVbxPtXQMdWzgAuTXhpqW2
        4j3yMWRAPzgCNXwmnQtuBeLLjNonPHXIX+Ll2elyZmVDqQKOgewNRaZt8ybNrMBm/w7
        /LzPK0itw8NhrKWJ183a4ky87eHLDLzslA1RBrf4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80FD8C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Fix missed wakeup of exp_wq waiters
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pkondeti@codeaurora.org, prsood@codeaurora.org,
        gkohli@codeaurora.org
References: <0101016e7dd7b824-50600058-ab5e-44d8-8d24-94cf095f1783-000000@us-west-2.amazonses.com>
 <20191118150856.GN2889@paulmck-ThinkPad-P72>
 <0101016e7f644106-90b40f19-ba9e-4974-bdbe-1062b52222a2-000000@us-west-2.amazonses.com>
 <20191118172401.GO2889@paulmck-ThinkPad-P72>
 <0101016e81ba8865-028ac62b-3fcd-481b-b657-be8519c4edf5-000000@us-west-2.amazonses.com>
 <20191119040533.GS2889@paulmck-ThinkPad-P72>
 <0101016e8278f225-9df7f507-2b6d-45e4-9c4d-d37141a1c5c6-000000@us-west-2.amazonses.com>
 <20191119150931.GX2889@paulmck-ThinkPad-P72>
 <20191119200647.GC2889@paulmck-ThinkPad-P72>
 <eeb7de82-c24b-c914-05fb-683088c9f8e2@codeaurora.org>
 <20191121041034.GZ2889@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <0101016e8c3f9c44-add1ac1b-68cf-4399-9313-3a114cda9b21-000000@us-west-2.amazonses.com>
Date:   Thu, 21 Nov 2019 04:36:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121041034.GZ2889@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.11.21-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2019 9:40 AM, Paul E. McKenney wrote:
> On Wed, Nov 20, 2019 at 10:38:56AM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 11/20/2019 1:36 AM, Paul E. McKenney wrote:
>>> On Tue, Nov 19, 2019 at 07:09:31AM -0800, Paul E. McKenney wrote:
>>>> On Tue, Nov 19, 2019 at 07:03:14AM +0000, Neeraj Upadhyay wrote:
>>>>> Hi Paul,
>>>>>
>>>>> On 11/19/2019 9:35 AM, Paul E. McKenney wrote:
>>>>>> On Tue, Nov 19, 2019 at 03:35:15AM +0000, Neeraj Upadhyay wrote:
>>>>>>> Hi Paul,
>>>>>>>
>>>>>>> On 11/18/2019 10:54 PM, Paul E. McKenney wrote:
>>>>>>>> On Mon, Nov 18, 2019 at 04:41:47PM +0000, Neeraj Upadhyay wrote:
>>>>>>>>> Hi Paul,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 11/18/2019 8:38 PM, Paul E. McKenney wrote:
>>>>>>>>>> On Mon, Nov 18, 2019 at 09:28:39AM +0000, Neeraj Upadhyay wrote:
>>>>>>>>>>> Hi Paul,
>>>>>>>>>>>
>>>>>>>>>>> On 11/18/2019 3:06 AM, Paul E. McKenney wrote:
>>>>>>>>>>>> On Fri, Nov 15, 2019 at 10:58:14PM +0530, Neeraj Upadhyay wrote:
>>>>>>>>>>>>> For the tasks waiting in exp_wq inside exp_funnel_lock(),
>>>>>>>>>>>>> there is a chance that they might be indefinitely blocked
>>>>>>>>>>>>> in below scenario:
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1. There is a task waiting on exp sequence 0b'100' inside
>>>>>>>>>>>>>          exp_funnel_lock().
>>>>>>>>>>>>>
>>>>>>>>>>>>>          _synchronize_rcu_expedited()
>>>>>>>>>>>>
>>>>>>>>>>>> This symbol went away a few versions back, but let's see how this
>>>>>>>>>>>> plays out in current -rcu.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Sorry; for us this problem is observed on 4.19 stable version; I had
>>>>>>>>>>> checked against the -rcu code, and the relevant portions were present
>>>>>>>>>>> there.
>>>>>>>>>>>
>>>>>>>>>>>>>            s = 0b'100
>>>>>>>>>>>>>            exp_funnel_lock()
>>>>>>>>>>>>>              wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]
>>>>>>>>>>>>
>>>>>>>>>>>> All of the above could still happen if the expedited grace
>>>>>>>>>>>> period number was zero (or a bit less) when that task invoked
>>>>>>>>>>>
>>>>>>>>>>> Yes
>>>>>>>>>>>
>>>>>>>>>>>> synchronize_rcu_expedited().  What is the relation, if any,
>>>>>>>>>>>> between this task and "task1" below?  Seems like you want them to
>>>>>>>>>>>> be different tasks.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> This task is the one which is waiting for the expedited sequence, which
>>>>>>>>>>> "task1" completes ("task1" holds the exp_mutex for it). "task1" would
>>>>>>>>>>> wake up this task, on exp GP completion.
>>>>>>>>>>>
>>>>>>>>>>>> Does this task actually block, or is it just getting ready
>>>>>>>>>>>> to block?  Seems like you need it to have actually blocked.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Yes, it actually blocked in wait queue.
>>>>>>>>>>>
>>>>>>>>>>>>> 2. The Exp GP completes and task (task1) holding exp_mutex queues
>>>>>>>>>>>>>          worker and schedules out.
>>>>>>>>>>>>
>>>>>>>>>>>> "The Exp GP" being the one that was initiated when the .expedited_sequence
>>>>>>>>>>>> counter was zero, correct?  (Looks that way below.)
>>>>>>>>>>>>
>>>>>>>>>>> Yes, correct.
>>>>>>>>>>>
>>>>>>>>>>>>>          _synchronize_rcu_expedited()
>>>>>>>>>>>>>            s = 0b'100
>>>>>>>>>>>>>            queue_work(rcu_gp_wq, &rew.rew_work)
>>>>>>>>>>>>>              wake_up_worker()
>>>>>>>>>>>>>                schedule()
>>>>>>>>>>>>>
>>>>>>>>>>>>> 3. kworker A picks up the queued work and completes the exp gp
>>>>>>>>>>>>>          sequence.
>>>>>>>>>>>>>
>>>>>>>>>>>>>          rcu_exp_wait_wake()
>>>>>>>>>>>>>            rcu_exp_wait_wake()
>>>>>>>>>>>>>              rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
>>>>>>>>>>>>>                                      // to 0b'100'
>>>>>>>>>>>>>
>>>>>>>>>>>>> 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
>>>>>>>>>>>>>          and releases exp_mutex.
>>>>>>>>>>>>>
>>>>>>>>>>>>>          wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>>>>>>>>>>>>>            sync_exp_work_done(rsp, s));
>>>>>>>>>>>>>          mutex_unlock(&rsp->exp_mutex);
>>>>>>>>>>>>
>>>>>>>>>>>> So task1 is the one that initiated the expedited grace period that
>>>>>>>>>>>> started when .expedited_sequence was zero, right?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Yes, right.
>>>>>>>>>>>
>>>>>>>>>>>>> 5. Next exp GP completes, and sequence number is incremented:
>>>>>>>>>>>>>
>>>>>>>>>>>>>          rcu_exp_wait_wake()
>>>>>>>>>>>>>            rcu_exp_wait_wake()
>>>>>>>>>>>>>              rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
>>>>>>>>>>>>>
>>>>>>>>>>>>> 6. As kworker A uses current expedited_sequence, it wakes up workers
>>>>>>>>>>>>>          from wrong wait queue index - it should have worken wait queue
>>>>>>>>>>>>>          corresponding to 0b'100' sequence, but wakes up the ones for
>>>>>>>>>>>>>          0b'200' sequence. This results in task at step 1 indefinitely blocked.
>>>>>>>>>>>>>
>>>>>>>>>>>>>          rcu_exp_wait_wake()
>>>>>>>>>>>>>            wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
>>>>>>>>>>>>
>>>>>>>>>>>> So the issue is that the next expedited RCU grace period might
>>>>>>>>>>>> have completed before the completion of the wakeups for the previous
>>>>>>>>>>>> expedited RCU grace period, correct?  Then expedited grace periods have
>>>>>>>>>>>
>>>>>>>>>>> Yes. Actually from the ftraces, I saw that next expedited RCU grace
>>>>>>>>>>> period completed while kworker A was in D state, while waiting for
>>>>>>>>>>> exp_wake_mutex. This led to kworker A using sequence 2 (instead of 1) for
>>>>>>>>>>> its wake_up_all() call; so, task (point 1) was never woken up, as it was
>>>>>>>>>>> waiting on wq index 1.
>>>>>>>>>>>
>>>>>>>>>>>> to have stopped to prevent any future wakeup from happening, correct?
>>>>>>>>>>>> (Which would make it harder for rcutorture to trigger this, though it
>>>>>>>>>>>> really does have code that attempts to trigger this sort of thing.)
>>>>>>>>>>>>
>>>>>>>>>>>> Is this theoretical in nature, or have you actually triggered it?
>>>>>>>>>>>> If actually triggered, what did you do to make this happen?
>>>>>>>>>>>
>>>>>>>>>>> This issue, we had seen previously - 1 instance in May 2018 (on 4.9 kernel),
>>>>>>>>>>> another instance in Nov 2018 (on 4.14 kernel), in our customer reported
>>>>>>>>>>> issues. Both instances were in downstream drivers and we didn't have RCU
>>>>>>>>>>> traces. Now 2 days back, it was reported on 4.19 kernel, with RCU traces
>>>>>>>>>>> enabled, where it was observed in suspend scenario, where we are observing
>>>>>>>>>>> "DPM device timeout" [1], as scsi device is stuck in
>>>>>>>>>>> _synchronize_rcu_expedited().
>>>>>>>>>>>
>>>>>>>>>>> schedule+0x70/0x90
>>>>>>>>>>> _synchronize_rcu_expedited+0x590/0x5f8
>>>>>>>>>>> synchronize_rcu+0x50/0xa0
>>>>>>>>>>> scsi_device_quiesce+0x50/0x120
>>>>>>>>>>> scsi_bus_suspend+0x70/0xe8
>>>>>>>>>>> dpm_run_callback+0x148/0x388
>>>>>>>>>>> __device_suspend+0x430/0x8a8
>>>>>>>>>>>
>>>>>>>>>>> [1]
>>>>>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/base/power/main.c#L489
>>>>>>>>>>>
>>>>>>>>>>>> What have you done to test the change?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I have given this for testing; will share the results . Current analysis
>>>>>>>>>>> and patch is based on going through ftrace and code review.
>>>>>>>>>>
>>>>>>>>>> OK, very good.  Please include the failure information in the changelog
>>>>>>>>>> of the next version of this patch.
>>>>>>>
>>>>>>> Done.
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I prefer your original patch, that just uses "s", over the one below
>>>>>>>>>> that moves the rcu_exp_gp_seq_end().  The big advantage of your original
>>>>>>>>>> patch is that it allow more concurrency between a consecutive pair of
>>>>>>>>>> expedited RCU grace periods.  Plus it would not be easy to convince
>>>>>>>>>> myself that moving rcu_exp_gp_seq_end() down is safe, so your original
>>>>>>>>>> is also conceptually simpler with a more manageable state space.
>>>>>>>
>>>>>>> The reason for highlighting the alternate approach of doing gp end inside
>>>>>>> exp_wake_mutex is the requirement of 3 wqs. Now, this is a theoretical case;
>>>>>>> please correct me if I am wrong here:
>>>>>>>
>>>>>>> 1. task0 holds exp_wake_mutex, and is preempted.
>>>>>>
>>>>>> Presumably after it has awakened the kthread that initiated the prior
>>>>>> expedited grace period (the one with seq number = -4).
>>>>>>
>>>>>>> 2. task1 initiates new GP (current seq number = 0).
>>>>>>
>>>>>> Yes, this can happen.
>>>>>>
>>>>>>> 3. task1 queues worker kworker1 and schedules out.
>>>>>>
>>>>>> And thus still holds .exp_mutex, but yes.
>>>>>>
>>>>>>> 4. kworker1 sets exp GP to 1 and waits on exp_wake_mutex
>>>>>>
>>>>>> And thus cannot yet have awakened task1.
>>>>>>
>>>>>>> 5. task1 releases exp mutex, w/o entering waitq.
>>>>>>
>>>>>> So I do not believe that we can get to #5.  What am I missing here?
>>>>>>
>>>>>
>>>>> As mentioned in this patch, task1 could have scheduled out after queuing
>>>>> work:
>>>>>
>>>>> queue_work(rcu_gp_wq, &rew.rew_work)
>>>>>              wake_up_worker()
>>>>>                schedule()
>>>>>
>>>>> kworker1 runs and picks up this queued work, and sets exp GP to 1 and waits
>>>>> on exp_wake_mutex.
>>>>>
>>>>> task1 gets scheduled in and checks sync_exp_work_done(rsp, s), which return
>>>>> true and it does not enter wait queue and releases exp_mutex.
>>>>>
>>>>> wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>>>>>            sync_exp_work_done(rsp, s));
>>>>
>>>> Well, I have certainly given enough people a hard time about missing the
>>>> didn't-actually-sleep case, so good show on finding one in my code!  ;-)
>>>>
>>>> Which also explains why deferring the rcu_exp_gp_seq_end() is safe:
>>>> The .exp_mutex won't be released until after it happens, and the
>>>> next manipulation of the sequence number cannot happen until after
>>>> .exp_mutex is next acquired.
>>>>
>>>> Good catch!  And keep up the good work!!!
>>>
>>> And here is the commit corresponding to your earlier patch.  Please let
>>> me know of any needed adjustments.
>>>
>>> 							Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>> commit 3ec440b52831eea172061c5db3d2990b22904863
>>> Author: Neeraj Upadhyay <neeraju@codeaurora.org>
>>> Date:   Tue Nov 19 11:50:52 2019 -0800
>>>
>>>       rcu: Allow only one expedited GP to run concurrently with wakeups
>>>       The current expedited RCU grace-period code expects that a task
>>>       requesting an expedited grace period cannot awaken until that grace
>>>       period has reached the wakeup phase.  However, it is possible for a long
>>>       preemption to result in the waiting task never sleeping.  For example,
>>>       consider the following sequence of events:
>>>       1.      Task A starts an expedited grace period by invoking
>>>               synchronize_rcu_expedited().  It proceeds normally up to the
>>>               wait_event() near the end of that function, and is then preempted
>>>               (or interrupted or whatever).
>>>       2.      The expedited grace period completes, and a kworker task starts
>>>               the awaken phase, having incremented the counter and acquired
>>>               the rcu_state structure's .exp_wake_mutex.  This kworker task
>>>               is then preempted or interrupted or whatever.
>>>       3.      Task A resumes and enters wait_event(), which notes that the
>>>               expedited grace period has completed, and thus doesn't sleep.
>>>       4.      Task B starts an expedited grace period exactly as did Task A,
>>>               complete with the preemption (or whatever delay) just before
>>>               the call to wait_event().
>>>       5.      The expedited grace period completes, and another kworker
>>>               task starts the awaken phase, having incremented the counter.
>>>               However, it blocks when attempting to acquire the rcu_state
>>>               structure's .exp_wake_mutex because step 2's kworker task has
>>>               not yet released it.
>>>       6.      Steps 4 and 5 repeat, resulting in overflow of the rcu_node
>>>               structure's ->exp_wq[] array.
>>>       In theory, this is harmless.  Tasks waiting on the various ->exp_wq[]
>>>       array will just be spuriously awakened, but they will just sleep again
>>>       on noting that the rcu_state structure's ->expedited_sequence value has
>>>       not advanced far enough.
>>>       In practice, this wastes CPU time and is an accident waiting to happen.
>>>       This commit therefore moves the rcu_exp_gp_seq_end() call that officially
>>>       ends the expedited grace period (along with associate tracing) until
>>>       after the ->exp_wake_mutex has been acquired.  This prevents Task A from
>>>       awakening prematurely, thus preventing more than one expedited grace
>>>       period from being in flight during a previous expedited grace period's
>>>       wakeup phase.
>>
>> I am not sure, if a "fixes" tag is required for it.
> 
> If you have a suggested commit, I would be happy to add it.
> 

I think either or below 2 - first one is on the tree_exp.h file, second
one looks to be the original commit.


1. 
https://github.com/torvalds/linux/commit/3549c2bc2c4ea8ecfeb9d21cb81cb00c6002b011 


2. 
https://github.com/torvalds/linux/commit/3b5f668e715bc19610ad967ef97a7e8c55a186ec


Thanks
Neeraj

>>>       Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>       [ paulmck: Added updated comment. ]
>>>       Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>> index 4433d00a..8840729 100644
>>> --- a/kernel/rcu/tree_exp.h
>>> +++ b/kernel/rcu/tree_exp.h
>>> @@ -539,14 +539,13 @@ static void rcu_exp_wait_wake(unsigned long s)
>>>    	struct rcu_node *rnp;
>>>    	synchronize_sched_expedited_wait();
>>> -	rcu_exp_gp_seq_end();
>>> -	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
>>> -	/*
>>> -	 * Switch over to wakeup mode, allowing the next GP, but -only- the
>>> -	 * next GP, to proceed.
>>> -	 */
>>> +	// Switch over to wakeup mode, allowing the next GP to proceed.
>>> +	// End the previous grace period only after acquiring the mutex
>>> +	// to ensure that only one GP runs concurrently with wakeups.
>>
>> Should comment style be changed to below?
>>
>> /* Switch over to wakeup mode, allowing the next GP to proceed.
>>   * End the previous grace period only after acquiring the mutex
>>   * to ensure that only one GP runs concurrently with wakeups.
>>   */
> 
> No.  "//" is acceptable comment format, aside from docbook headers.
> The "//" approach saves three characters per line compared to "/* ... */"
> single-line comments and a line compared to the style you show above.
> 
> So yes, some maintainers prefer the style you show, but not me.
> 
> 							Thanx, Paul
> 
>>>    	mutex_lock(&rcu_state.exp_wake_mutex);
>>> +	rcu_exp_gp_seq_end();
>>> +	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
>>>    	rcu_for_each_node_breadth_first(rnp) {
>>>    		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
>>>
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
