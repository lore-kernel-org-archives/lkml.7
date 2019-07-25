Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B1CC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524C2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfGYRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:21:19 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:43761 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfGYRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:21:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TXn99.H_1564075272;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXn99.H_1564075272)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jul 2019 01:21:15 +0800
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190724194835.59947a6b4df3c2ae7816470d@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <c086eadf-dd92-9a06-7214-876c66015b49@linux.alibaba.com>
Date:   Thu, 25 Jul 2019 10:21:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190724194835.59947a6b4df3c2ae7816470d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/19 7:48 PM, Andrew Morton wrote:
> On Sat, 13 Jul 2019 04:49:04 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> When running ltp's oom test with kmemleak enabled, the below warning was
>> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
>> passed in:
>>
>> ...
>>
>> The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, kmemleak has
>> __GFP_NOFAIL set all the time due to commit
>> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
>> with fault injection").
>>
>> The fault-injection would not try to fail slab or page allocation if
>> __GFP_NOFAIL is used and that commit tries to turn off fault injection
>> for kmemleak allocation.  Although __GFP_NOFAIL doesn't guarantee no
>> failure for all the cases (i.e. non-blockable allocation may fail), it
>> still makes sense to the most cases.  Kmemleak is also a debugging tool,
>> so it sounds not worth changing the behavior.
>>
>> It also meaks sense to keep the warning, so just document the special
>> case in the comment.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4531,8 +4531,14 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>>   	 */
>>   	if (gfp_mask & __GFP_NOFAIL) {
>>   		/*
>> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
>> -		 * of any new users that actually require GFP_NOWAIT
>> +		 * The users of the __GFP_NOFAIL are expected be blockable,
>> +		 * and this is true for the most cases except for kmemleak.
>> +		 * The kmemleak pass in __GFP_NOFAIL to skip fault injection,
>> +		 * however kmemleak may allocate object at some non-blockable
>> +		 * context to trigger this warning.
>> +		 *
>> +		 * Keep this warning since it is still useful for the most
>> +		 * normal cases.
>>   		 */
> Comment has rather a lot of typos.  I'd normally fix them but I think
> I'll duck this patch until the kmemleak situation is addressed, so we
> can add a kmemleakless long-term comment, if desired.

Actually, this has been replaced by reverting the problematic commit. 
And, the patch has been in -mm tree. Please see: 
revert-kmemleak-allow-to-coexist-with-fault-injection.patch

I think we would like to have this merged in 5.3-rc1 or rc2?


