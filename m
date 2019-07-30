Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFAC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AF420644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfG3QIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:08:39 -0400
Received: from foss.arm.com ([217.140.110.172]:35178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfG3QIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F244528;
        Tue, 30 Jul 2019 09:08:37 -0700 (PDT)
Received: from [10.1.194.23] (unknown [10.1.194.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDAB3F694;
        Tue, 30 Jul 2019 09:08:36 -0700 (PDT)
Subject: Re: [PATCH 5/5] sched/deadline: Use return value of SCHED_WARN_ON()
 in bw accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-6-dietmar.eggemann@arm.com>
 <20190726121819.32be6fb1@sweethome>
 <20190729165434.GO31398@hirez.programming.kicks-ass.net>
 <a12e2330-50d4-b31f-14b5-5b386252d418@arm.com>
 <20190730082316.GK31381@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7da6555c-baff-39df-b562-2510566ba4bf@arm.com>
Date:   Tue, 30 Jul 2019 17:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730082316.GK31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 9:23 AM, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 05:59:04PM +0100, Dietmar Eggemann wrote:
>> On 7/29/19 5:54 PM, Peter Zijlstra wrote:
>>> On Fri, Jul 26, 2019 at 12:18:19PM +0200, luca abeni wrote:
>>>> Hi Dietmar,
>>>>
>>>> On Fri, 26 Jul 2019 09:27:56 +0100
>>>> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>>> To make the decision whether to set rq or running bw to 0 in underflow
>>>>> case use the return value of SCHED_WARN_ON() rather than an extra if
>>>>> condition.
>>>>
>>>> I think I tried this at some point, but if I remember well this
>>>> solution does not work correctly when SCHED_DEBUG is not enabled.
>>>
>>> Well, it 'works' in so far that it compiles. But it might not be what
>>> one expects. That is, for !SCHED_DEBUG the return value is an
>>> unconditional false.
>>>
>>> In this case I think that's fine, the WARN _should_ not be happending.
>>
>> But there is commit 6d3aed3d ("sched/debug: Fix SCHED_WARN_ON() to
>> return a value on !CONFIG_SCHED_DEBUG as well")?
>>
>> But it doesn't work with !CONFIG_SCHED_DEBUG
>>
>> What compiles and work is (at least on Arm64).
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 4012f98b9d26..494a767a4091 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -78,7 +78,7 @@
>>  #ifdef CONFIG_SCHED_DEBUG
>>  # define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
>>  #else
>> -# define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
>> +# define SCHED_WARN_ON(x)      ({ (void)(x), x; })
> 
> Why doesn't the ,0 compile? That should work just fine. The thing is,
> the two existing users:
> 
> kernel/sched/fair.c:            if (SCHED_WARN_ON(!se->on_rq))
> kernel/sched/fair.c:            if (SCHED_WARN_ON(!se->on_rq))
> 
> seem to compile just fine with it.

You're right, compiling is not an issue. But it looks like the code does
different things depending on CONFIG_SCHED_DEBUG.

E.g. in set_last_buddy() we would return if '!se->on_rq' with
CONFIG_SCHED_DEBUG and continue the for_each_sched_entity() with
!CONFIG_SCHED_DEBUG.

IMHO, this forced Luca e.g. in __sub_running_bw() to code:

SCHED_WARN_ON(dl_rq->running_bw > old);
if (dl_rq->running_bw > old)
    dl_rq->running_bw = 0;

and not:

if (SCHED_WARN_ON(dl_rq->running_bw > old))
    dl_rq->running_bw = 0;

I experimented with '# define SCHED_WARN_ON(x) ({ (void)(x), x; })' and
in this case code inside an 'if (SCHED_WARN_ON(cond))' is also executed
with !CONFIG_SCHED_DEBUG.
