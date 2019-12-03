Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC5C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43282206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLCJZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:25:55 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39596 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfLCJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:25:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tjo4jQE_1575365150;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tjo4jQE_1575365150)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Dec 2019 17:25:52 +0800
Subject: Re: [PATCH RESEND] sched/numa: expose per-task
 pages-migration-failure
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7038afda-dd08-f01f-5da0-afadf76f5533@linux.alibaba.com>
 <20191203071615.GD115767@gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <d67d273c-41e7-d046-cdd1-0b2faae2ed07@linux.alibaba.com>
Date:   Tue, 3 Dec 2019 17:25:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191203071615.GD115767@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/3 下午3:16, Ingo Molnar wrote:
[snip]
>>  kernel/sched/debug.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index f7e4579e746c..73c4809c8f37 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -848,6 +848,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>>  	P(total_numa_faults);
>>  	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
>>  			task_node(p), task_numa_group_id(p));
>> +	SEQ_printf(m, "migfailed=%lu\n", p->numa_faults_locality[2]);
> 
> Any reason not to expose the other 2 fields of this array as well, which 
> show remote/local migrations?

The rest are local/remote faults counter, AFAIK not related to
migration, when the CPU triggered PF is from the same node of page
(before migration), local faults increased.

Regards,
Michael Wang

> 
> Thanks,
> 
> 	Ingo
> 
