Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D028C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C572086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437108AbfHIQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:19:36 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50196 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436965AbfHIQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:19:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TZ1jNrk_1565367555;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TZ1jNrk_1565367555)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 10 Aug 2019 00:19:18 +0800
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
Date:   Fri, 9 Aug 2019 09:19:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190809083216.GM18351@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/19 1:32 AM, Michal Hocko wrote:
> On Fri 09-08-19 07:57:44, Yang Shi wrote:
>> When doing partial unmap to THP, the pages in the affected range would
>> be considered to be reclaimable when memory pressure comes in.  And,
>> such pages would be put on deferred split queue and get minus from the
>> memory statistics (i.e. /proc/meminfo).
>>
>> For example, when doing THP split test, /proc/meminfo would show:
>>
>> Before put on lazy free list:
>> MemTotal:       45288336 kB
>> MemFree:        43281376 kB
>> MemAvailable:   43254048 kB
>> ...
>> Active(anon):    1096296 kB
>> Inactive(anon):     8372 kB
>> ...
>> AnonPages:       1096264 kB
>> ...
>> AnonHugePages:   1056768 kB
>>
>> After put on lazy free list:
>> MemTotal:       45288336 kB
>> MemFree:        43282612 kB
>> MemAvailable:   43255284 kB
>> ...
>> Active(anon):    1094228 kB
>> Inactive(anon):     8372 kB
>> ...
>> AnonPages:         49668 kB
>> ...
>> AnonHugePages:     10240 kB
>>
>> The THPs confusingly look disappeared although they are still on LRU if
>> you are not familair the tricks done by kernel.
> Is this a fallout of the recent deferred freeing work?

This series follows up the discussion happened when reviewing "Make 
deferred split shrinker memcg aware".

David Rientjes suggested deferred split THP should be accounted into 
available memory since they would be shrunk when memory pressure comes 
in, just like MADV_FREE pages. For the discussion, please refer to: 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2010115.html

>
>> Accounted the lazy free pages to NR_LAZYFREE, and show them in meminfo
>> and other places.  With the change the /proc/meminfo would look like:
>> Before put on lazy free list:
> The name is really confusing because I have thought of MADV_FREE immediately.

Yes, I agree. We may use a more specific name, i.e. DeferredSplitTHP.

>
>> +LazyFreePages: Cleanly freeable pages under memory pressure (i.e. deferred
>> +               split THP).
> What does that mean actually? I have hard time imagine what cleanly
> freeable pages mean.

Like deferred split THP and MADV_FREE pages, they could be reclaimed 
during memory pressure.

If you just go with "DeferredSplitTHP", these ambiguity would go away.


