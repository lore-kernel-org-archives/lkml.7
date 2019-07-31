Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F30C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4850206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfGaRcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:32:51 -0400
Received: from foss.arm.com ([217.140.110.172]:52384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfGaRcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:32:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CEAB337;
        Wed, 31 Jul 2019 10:32:50 -0700 (PDT)
Received: from [10.1.31.37] (unknown [10.1.31.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04513F71F;
        Wed, 31 Jul 2019 10:32:48 -0700 (PDT)
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
To:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <20190729164932.GN31398@hirez.programming.kicks-ass.net>
 <20190730064115.GC8927@localhost.localdomain>
 <20190730082108.GJ31381@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c93f6c12-b804-99da-7e38-bbaf55fe7a1b@arm.com>
Date:   Wed, 31 Jul 2019 18:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730082108.GJ31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 9:21 AM, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 08:41:15AM +0200, Juri Lelli wrote:
>> On 29/07/19 18:49, Peter Zijlstra wrote:
>>> On Fri, Jul 26, 2019 at 09:27:55AM +0100, Dietmar Eggemann wrote:
>>>> Remove BUG_ON() in __enqueue_dl_entity() since there is already one in
>>>> enqueue_dl_entity().
>>>>
>>>> Move the check that the dl_se is not on the dl_rq from
>>>> __dequeue_dl_entity() to dequeue_dl_entity() to align with the enqueue
>>>> side and use the on_dl_rq() helper function.
>>>>
>>>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>>> ---
>>>>  kernel/sched/deadline.c | 8 +++-----
>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>>> index 1fa005f79307..a9cb52ceb761 100644
>>>> --- a/kernel/sched/deadline.c
>>>> +++ b/kernel/sched/deadline.c
>>>> @@ -1407,8 +1407,6 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
>>>>  	struct sched_dl_entity *entry;
>>>>  	int leftmost = 1;
>>>>  
>>>> -	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
>>>> -
>>>>  	while (*link) {
>>>>  		parent = *link;
>>>>  		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
>>>> @@ -1430,9 +1428,6 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
>>>>  {
>>>>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>>>>  
>>>> -	if (RB_EMPTY_NODE(&dl_se->rb_node))
>>>> -		return;
>>>> -
>>>>  	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
>>>>  	RB_CLEAR_NODE(&dl_se->rb_node);
>>>>  
>>>> @@ -1466,6 +1461,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>>>>  
>>>>  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
>>>>  {
>>>> +	if (!on_dl_rq(dl_se))
>>>> +		return;
>>>
>>> Why allow double dequeue instead of WARN?
>>
>> As I was saying to Valentin, it can currently happen that a task could
>> have already been dequeued by update_curr_dl()->throttle called by
>> dequeue_task_dl() before calling __dequeue_task_dl(). Do you think we
>> should check for this condition before calling into dequeue_dl_entity()?
> 
> Yes, that's what ->dl_throttled is for, right? And !->dl_throttled &&
> !on_dl_rq() is a BUG.

OK, I will add the following snippet to the patch.
Although it's easy to provoke a situation in which DL tasks are throttled,
I haven't seen a throttling happening when the task is being dequeued.

--->8---

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b6d2f263e0a4..a009762097fa 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1507,8 +1507,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 
 static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
 {
-       if (!on_dl_rq(dl_se))
-               return;
+       BUG_ON(!on_dl_rq(dl_se));
 
        __dequeue_dl_entity(dl_se);
 }
@@ -1592,6 +1591,10 @@ static void __dequeue_task_dl(struct rq *rq, struct task_struct *p)
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
        update_curr_dl(rq);
+
+       if (p->dl.dl_throttled)
+               return;
+
        __dequeue_task_dl(rq, p);
