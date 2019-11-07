Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E666A21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfKGIh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:37:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:52296 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfKGIh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:37:27 -0500
Received: from [172.16.24.104]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iSdHp-00040B-A7; Thu, 07 Nov 2019 11:37:01 +0300
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
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
Date:   Thu, 7 Nov 2019 11:36:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106172737.GM5671@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2019 20:27, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 05:54:37PM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 06, 2019 at 06:51:40PM +0300, Kirill Tkhai wrote:
>>>> +#ifdef CONFIG_SMP
>>>> +	if (!rq->nr_running) {
>>>> +		/*
>>>> +		 * Make sure task_on_rq_curr() fails, such that we don't do
>>>> +		 * put_prev_task() + set_next_task() on this task again.
>>>> +		 */
>>>> +		prev->on_cpu = 2;
>>>>  		newidle_balance(rq, rf);
>>>
>>> Shouldn't we restore prev->on_cpu = 1 after newidle_balance()? Can't prev
>>> become pickable again after newidle_balance() releases rq->lock, and we
>>> take it again, so this on_cpu == 2 never will be cleared?
>>
>> Indeed so.
> 
> Oh wait, the way it was written this is not possible. Because
> rq->nr_running == 0 and prev->on_cpu > 0 it means the current task is
> going to sleep and cannot be woken back up.

I mostly mean throttling. AFAIR, tasks of throttled rt_rq are not accounted
in rq->nr_running. But it seems rt_rq may become unthrottled again after
newidle_balance() unlocks rq lock, and prev will become pickable again.
 
> But if I move the ->on_cpu=2 thing earlier, as I wrote I'd do, then yes,
> we have to set it back to 1. Because in that case we can get here for a
> spurious schedule and we'll pick the same task again.
