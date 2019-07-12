Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB77C742B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CFE20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfGLI6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:58:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:21624 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfGLI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:58:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TWh9RaS_1562921921;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TWh9RaS_1562921921)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jul 2019 16:58:42 +0800
Subject: Re: [PATCH 4/4] numa: introduce numa cling feature
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <9a440936-1e5d-d3bb-c795-ef6f9839a021@linux.alibaba.com>
 <20190711142728.GF3402@hirez.programming.kicks-ass.net>
 <82f42063-ce51-dd34-ba95-5b32ee733de7@linux.alibaba.com>
 <20190712075318.GM3402@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <0a5066be-ac10-5dce-c0a6-408725bc0784@linux.alibaba.com>
Date:   Fri, 12 Jul 2019 16:58:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712075318.GM3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/12 下午3:53, Peter Zijlstra wrote:
[snip]
>>>>  	return target;
>>>>  }
>>>
>>> Select idle sibling should never cross node boundaries and is thus the
>>> entirely wrong place to fix anything.
>>
>> Hmm.. in our early testing the printk show both select_task_rq_fair() and
>> task_numa_find_cpu() will call select_idle_sibling with prev and target on
>> different node, thus we pick this point to save few lines.
> 
> But it will never return @prev if it is not in the same cache domain as
> @target. See how everything is gated by:
> 
>   && cpus_share_cache(x, target)

Yeah, that's right.

> 
>> But if the semantics of select_idle_sibling() is to return cpu on the same
>> node of target, what about move the logical after select_idle_sibling() for
>> the two callers?
> 
> No, that's insane. You don't do select_idle_sibling() to then ignore the
> result. You have to change @target before calling select_idle_sibling().
> 

I see, we should not override the decision of select_idle_sibling().

Actually the original design we try to achieve is:

  let wake affine select the target
  try find idle sibling of target
  if got one
	pick it
  else if task cling to prev
	pick prev

That is to consider wake affine superior to numa cling.

But after rethinking maybe this is not necessary, since numa cling is
also some kind of strong wake affine hint, actually maybe even a better
one to filter out the bad cases.

I'll try change @target instead and give a retest then.

Regards,
Michael Wang
