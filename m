Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C93C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FF2206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfDWJ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:59:06 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45440 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfDWJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:59:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TQ1iUpX_1556013542;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TQ1iUpX_1556013542)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Apr 2019 17:59:03 +0800
Subject: Re: [RFC PATCH 5/5] numa: numa balancer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <85bcd381-ef27-ddda-6069-1f1d80cf296a@linux.alibaba.com>
 <20190423090505.GG11158@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <9c431cd5-bb9c-8f58-5f67-643b5bd21dd6@linux.alibaba.com>
Date:   Tue, 23 Apr 2019 17:59:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423090505.GG11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/23 下午5:05, Peter Zijlstra wrote:
[snip]
>>
>> TODO:
>>   * improve the logical to address the regression cases
>>   * Find a way, maybe, to handle the page cache left on remote
>>   * find more scenery which could gain benefit
>>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>> ---
>>  drivers/Makefile             |   1 +
>>  drivers/numa/Makefile        |   1 +
>>  drivers/numa/numa_balancer.c | 715 +++++++++++++++++++++++++++++++++++++++++++
> 
> So I really think this is the wrong direction. Why introduce yet another
> balancer thingy and not extend the existing numa balancer with the
> additional information you got from the previous patches?
> 
> Also, this really should not be a module and not in drivers
The reason why we present the idea in the way of a module is that
it's not suitable for all the situations, a module could be clean
and easier for deploy on demands.

Besides, we assume someone may prefer to have their own logical
on how to do the numa balancer, thus the module give them the way
to DIY easily.

But there are no insist on the style, once the logical is mature
enough, we can merge the idea into CFS, per-cgroup switch could be
enough :-P

Regards,
Michael Wang

> 
