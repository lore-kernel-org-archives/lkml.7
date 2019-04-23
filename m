Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263AEC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E389F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDWJcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:32:35 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10428 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfDWJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:32:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TQ1gXzQ_1556011948;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TQ1gXzQ_1556011948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Apr 2019 17:32:29 +0800
Subject: Re: [RFC PATCH 1/5] numa: introduce per-cgroup numa balancing
 locality, statistic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
 <20190423084633.GC11158@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <f1f71150-b3e9-7d15-7a0b-57673a9021d5@linux.alibaba.com>
Date:   Tue, 23 Apr 2019 17:32:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423084633.GC11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/23 下午4:46, Peter Zijlstra wrote:
> On Mon, Apr 22, 2019 at 10:11:24AM +0800, 王贇 wrote:
>> +	 * 0 -- remote faults
>> +	 * 1 -- local faults
>> +	 * 2 -- page migration failure
>> +	 * 3 -- remote page accessing after page migration
>> +	 * 4 -- local page accessing after page migration
> 
>> @@ -2387,6 +2388,11 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
>>  		memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
>>  	}
>>
>> +	p->numa_faults_locality[mem_node == numa_node_id() ? 4 : 3] += pages;
>> +
>> +	if (mem_node == NUMA_NO_NODE)
>> +		return;
> 
> I'm confused on the meaning of 3 & 4. It says 'after page migration' but
> 'every' access if after 'a' migration. But even more confusingly, you
> even account it if we know the page has never been migrated.
> 
> So what are you really counting
Here is try to get the times of a task accessing the local or remote pages,
and on no migration cases we still account since it's also one time of accessing,
remotely or locally.

'after page migration' means this accounting need to understand the real page
position after PF, what ever migration failure or succeed, whatever page move to
local/remote or untouched, we want to know the times a task accessed the page
locally or remotely, on numa balancing period.

Regards,
Michael Wang

> 
