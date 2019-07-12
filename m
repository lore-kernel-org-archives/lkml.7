Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B4C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C221019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfGLDRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:17:37 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60155 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbfGLDRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:17:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TWfas.h_1562901451;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TWfas.h_1562901451)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jul 2019 11:17:32 +0800
Subject: Re: [PATCH 2/4] numa: append per-node execution info in
 memory.numa_stat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <825ebaf0-9f71-bbe1-f054-7fa585d61af1@linux.alibaba.com>
 <20190711134527.GC3402@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <e0c38e99-7a01-7a84-2030-6cb963452e81@linux.alibaba.com>
Date:   Fri, 12 Jul 2019 11:17:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711134527.GC3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/11 下午9:45, Peter Zijlstra wrote:
> On Wed, Jul 03, 2019 at 11:29:15AM +0800, 王贇 wrote:
> 
>> +++ b/include/linux/memcontrol.h
>> @@ -190,6 +190,7 @@ enum memcg_numa_locality_interval {
>>
>>  struct memcg_stat_numa {
>>  	u64 locality[NR_NL_INTERVAL];
>> +	u64 exectime;
> 
> Maybe call the field jiffies, because that's what it counts.

Sure, will be in next version.

Regards,
Michael Wang

> 
>>  };
>>
>>  #endif
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 2edf3f5ac4b9..d5f48365770f 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3575,6 +3575,18 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>>  		seq_printf(m, " %u", jiffies_to_msecs(sum));
>>  	}
>>  	seq_putc(m, '\n');
>> +
>> +	seq_puts(m, "exectime");
>> +	for_each_online_node(nr) {
>> +		int cpu;
>> +		u64 sum = 0;
>> +
>> +		for_each_cpu(cpu, cpumask_of_node(nr))
>> +			sum += per_cpu(memcg->stat_numa->exectime, cpu);
>> +
>> +		seq_printf(m, " %llu", jiffies_to_msecs(sum));
>> +	}
>> +	seq_putc(m, '\n');
>>  #endif
>>
>>  	return 0;
