Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D02CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A3120663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfKGPxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:53:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:39214 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:53:22 -0500
Received: from [172.16.24.104]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iSk5o-0006bI-G0; Thu, 07 Nov 2019 18:53:04 +0300
Subject: Re: NULL pointer dereference in pick_next_task_fair
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <79ecf426-8728-f36b-57ad-5948e5633ffb@virtuozzo.com>
 <20191107154239.GE4114@hirez.programming.kicks-ass.net>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e38e1326-a1e1-75c9-cb63-dd5fc7664723@virtuozzo.com>
Date:   Thu, 7 Nov 2019 18:53:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107154239.GE4114@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.2019 18:42, Peter Zijlstra wrote:
> On Thu, Nov 07, 2019 at 06:12:07PM +0300, Kirill Tkhai wrote:
>> On 07.11.2019 16:26, Peter Zijlstra wrote:
> 
>>> Urgh... throttling.
> 
>> One more thing about current code in git. After rq->lock became able to
>> be unlocked after put_prev_task() is commited, we got a new corner case.
>> We usually had the same order for running task:
>>
>>   dequeue_task()
>>   put_prev_task()
>>
>> Now the order may be reversed (this is also in case of throttling):
>>
>>   put_prev_task() (called from pick_next_task())
>>   dequeue_task()  (called from another cpu)
>>
>> This is more theoretically, since I don't see a problem here. But there are
>> too many statistics and counters in sched_class methods, that it is impossible
>> to be sure all of them work as expected.
> 
> Hmm,.. where does throttling happen on a remote CPU? I through both
> cfs-bandwidth and dl throttle locally.
> 
> Or are you talking about NO_HZ_FULL's sched_remote_tick() ?

I mean ordinary path: local throttling -> resched_curr -> schedule().
Then rq->nr_running == 0, but task is on rq. We call put_prev_task()
and newidle_balance().

On another cpu someone calls set_user_nice() and it makes dequeue_task()
in the middle of local cpu's newidle_balance().

Thus, we first made put_prev_task() and second dequeue_task().
