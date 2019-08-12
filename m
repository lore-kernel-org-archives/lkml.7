Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CA6C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D102085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfHLJ4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:56:17 -0400
Received: from foss.arm.com ([217.140.110.172]:47226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfHLJ4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:56:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56A715A2;
        Mon, 12 Aug 2019 02:56:15 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AA6A3F718;
        Mon, 12 Aug 2019 02:56:14 -0700 (PDT)
Subject: Re: [tip:sched/core] sched/fair: Use rq_lock/unlock in
 online_fair_sched_group
To:     Phil Auld <pauld@redhat.com>
Cc:     vincent.guittot@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-tip-commits@vger.kernel.org
References: <20190801133749.11033-1-pauld@redhat.com>
 <tip-6b8fd01b21f5f2701b407a7118f236ba4c41226d@git.kernel.org>
 <dfc8f652-ca98-e30a-546f-e6a2df36e33a@arm.com>
 <20190809172837.GB18727@pauld.bos.csb>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d711ee53-48ca-47f5-df23-0593cc0f3347@arm.com>
Date:   Mon, 12 Aug 2019 11:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809172837.GB18727@pauld.bos.csb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/19 7:28 PM, Phil Auld wrote:
> On Fri, Aug 09, 2019 at 06:21:22PM +0200 Dietmar Eggemann wrote:
>> On 8/8/19 1:01 PM, tip-bot for Phil Auld wrote:

[...]

>> Shouldn't this be:
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d9407517dae9..1054d2cf6aaa 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10288,11 +10288,11 @@ void online_fair_sched_group(struct task_group
>> *tg)
>>         for_each_possible_cpu(i) {
>>                 rq = cpu_rq(i);
>>                 se = tg->se[i];
>> -               rq_lock(rq, &rf);
>> +               rq_lock_irq(rq, &rf);
>>                 update_rq_clock(rq);
>>                 attach_entity_cfs_rq(se);
>>                 sync_throttle(tg, i);
>> -               rq_unlock(rq, &rf);
>> +               rq_unlock_irq(rq, &rf);
>>         }
>>  }
>>
>> Currently, you should get a 'inconsistent lock state' warning with
>> CONFIG_PROVE_LOCKING.
> 
> Yes, indeed. Sorry about that. Maybe it can be fixed in tip before 
> it gets any farther?  Or do we need a new patch?

I think Peter is on holiday so maybe you can send a new patch and ask
Ingo or Thomas to replace your original patch on tip sched/core?



