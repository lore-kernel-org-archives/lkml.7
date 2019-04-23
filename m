Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B558C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3320843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfDWJO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:14:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40015 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfDWJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:14:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TQ1rXBG_1556010893;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TQ1rXBG_1556010893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Apr 2019 17:14:53 +0800
Subject: Re: [RFC PATCH 1/5] numa: introduce per-cgroup numa balancing
 locality, statistic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
 <20190423084444.GB11158@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <b0148598-3a9c-d5d5-4c30-5bbb0f68145d@linux.alibaba.com>
Date:   Tue, 23 Apr 2019 17:14:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423084444.GB11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/23 下午4:44, Peter Zijlstra wrote:
> On Mon, Apr 22, 2019 at 10:11:24AM +0800, 王贇 wrote:
>> +#ifdef CONFIG_NUMA_BALANCING
>> +
>> +enum memcg_numa_locality_interval {
>> +	PERCENT_0_9,
>> +	PERCENT_10_19,
>> +	PERCENT_20_29,
>> +	PERCENT_30_39,
>> +	PERCENT_40_49,
>> +	PERCENT_50_59,
>> +	PERCENT_60_69,
>> +	PERCENT_70_79,
>> +	PERCENT_80_89,
>> +	PERCENT_90_100,
>> +	NR_NL_INTERVAL,
>> +};
>> +
>> +struct memcg_stat_numa {
>> +	u64 locality[NR_NL_INTERVAL];
>> +};

> If you make that 8 it fits a single cacheline. Do you really need the
> additional resolution? If so, then 16 would be the next logical amount
> of buckets. 10 otoh makes no sense what so ever.

Thanks for point out :-) not have to be 10, I think we can save first two
and make it PERCENT_0_29, already wrong enough if it drops below 30% and
it's helpless to know detail changes in this section.

Regards,
Michael Wang

> 
