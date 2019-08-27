Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C4C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B45B206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfH0CpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:45:14 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40583 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbfH0CpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:45:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=liangyan.peng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TaZLKac_1566873900;
Received: from LiangyandeMacBook-Pro.local(mailfrom:liangyan.peng@linux.alibaba.com fp:SMTPD_---0TaZLKac_1566873900)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 10:45:00 +0800
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
To:     bsegall@google.com, Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
 <xm26d0gvirdg.fsf@bsegall-linux.svl.corp.google.com>
 <942ae15c-ffa5-74da-208b-7e82df917e16@arm.com>
 <xm26k1azn7yd.fsf@bsegall-linux.svl.corp.google.com>
From:   Liangyan <liangyan.peng@linux.alibaba.com>
Message-ID: <5cfadb62-10b7-d16b-7f30-f3573bb04844@linux.alibaba.com>
Date:   Tue, 27 Aug 2019 10:45:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xm26k1azn7yd.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/8/27 上午1:38, bsegall@google.com wrote:
> Valentin Schneider <valentin.schneider@arm.com> writes:
> 
>> On 23/08/2019 21:00, bsegall@google.com wrote:
>> [...]
>>> Could you mention in the message that this a throttled cfs_rq can have
>>> account_cfs_rq_runtime called on it because it is throttled before
>>> idle_balance, and the idle_balance calls update_rq_clock to add time
>>> that is accounted to the task.
>>>
>>
>> Mayhaps even a comment for the extra condition.
>>
>>> I think this solution is less risky than unthrottling
>>> in this area, so other than that:
>>>
>>> Reviewed-by: Ben Segall <bsegall@google.com>
>>>
>>
>> If you don't mind squashing this in:
>>
>> -----8<-----
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b1d9cec9b1ed..b47b0bcf56bc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4630,6 +4630,10 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>>   		if (!cfs_rq_throttled(cfs_rq))
>>   			goto next;
>>   
>> +		/* By the above check, this should never be true */
>> +		WARN_ON(cfs_rq->runtime_remaining > 0);
>> +
>> +		/* Pick the minimum amount to return to a positive quota state */
>>   		runtime = -cfs_rq->runtime_remaining + 1;
>>   		if (runtime > remaining)
>>   			runtime = remaining;
>> ----->8-----
>>
>> I'm not adamant about the extra comment, but the WARN_ON would be nice IMO.
>>
>>
>> @Ben, do you reckon we want to strap
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: ec12cb7f31e2 ("sched: Accumulate per-cfs_rq cpu usage and charge against bandwidth")
>>
>> to the thing? AFAICT the pick_next_task_fair() + idle_balance() dance you
>> described should still be possible on that commit.
> 
> I'm not sure about stable policy in general, but it seems reasonable.
> The WARN_ON might want to be WARN_ON_ONCE, and it seems fine to have it
> or not.

Thanks Ben and Valentin for all of the comments. Per Xunlei's 
suggestion, I used SCHED_WARN_ON instead in v3. Regarding whether cc 
stable, I'm also not sure.

> 
>>
>>
>> Other than that,
>>
>> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>>
>> [...]
