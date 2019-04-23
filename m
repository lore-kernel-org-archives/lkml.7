Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDE5C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D322077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDWJlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:41:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60839 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfDWJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:41:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TQ1rapc_1556012469;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TQ1rapc_1556012469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Apr 2019 17:41:10 +0800
Subject: Re: [RFC PATCH 3/5] numa: introduce per-cgroup preferred numa node
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <77452c03-bc4c-7aed-e605-d5351f868586@linux.alibaba.com>
 <20190423085533.GF11158@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <e5e39d99-2b7a-db27-5aa0-ecc8d064257b@linux.alibaba.com>
Date:   Tue, 23 Apr 2019 17:41:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423085533.GF11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/23 下午4:55, Peter Zijlstra wrote:
> On Mon, Apr 22, 2019 at 10:13:36AM +0800, 王贇 wrote:
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index af171ccb56a2..6513504373b4 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2031,6 +2031,10 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>>
>>  	pol = get_vma_policy(vma, addr);
>>
>> +	page = alloc_page_numa_preferred(gfp, order);
>> +	if (page)
>> +		goto out;
>> +
>>  	if (pol->mode == MPOL_INTERLEAVE) {
>>  		unsigned nid;
>>
> 
> This I think is wrong, it overrides app specific mbind() requests.

The original concern is that we scared the user apps insider cgroup deal
wrong with memory policy and do bad behavior, but now I agree that we
should not override the policy, the admin will take the responsibility.

Regards,
Michael Wang

> 
