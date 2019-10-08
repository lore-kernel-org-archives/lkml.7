Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E459C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5DC20873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfJHXJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:09:44 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54808 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbfJHXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:09:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TeUt30J_1570576174;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TeUt30J_1570576174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Oct 2019 07:09:40 +0800
Subject: Re: [PATCH] mm: thp: move deferred split queue to memcg's nodeinfo
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kirill.shutemov@linux.intel.com,
        ktkhai@virtuozzo.com, hannes@cmpxchg.org, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1569968203-64647-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191002084304.GI15624@dhcp22.suse.cz>
 <30421920-4fdb-767a-6ef2-60187932c414@suse.cz>
 <20191007143030.GN2381@dhcp22.suse.cz> <20191008144437.fr374cxtpnrnnjsv@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d96cf698-585a-c90b-c038-1009447d4daa@linux.alibaba.com>
Date:   Tue, 8 Oct 2019 16:09:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191008144437.fr374cxtpnrnnjsv@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/19 7:44 AM, Kirill A. Shutemov wrote:
> On Mon, Oct 07, 2019 at 04:30:30PM +0200, Michal Hocko wrote:
>> On Mon 07-10-19 16:19:59, Vlastimil Babka wrote:
>>> On 10/2/19 10:43 AM, Michal Hocko wrote:
>>>> On Wed 02-10-19 06:16:43, Yang Shi wrote:
>>>>> The commit 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make
>>>>> deferred split shrinker memcg aware") makes deferred split queue per
>>>>> memcg to resolve memcg pre-mature OOM problem.  But, all nodes end up
>>>>> sharing the same queue instead of one queue per-node before the commit.
>>>>> It is not a big deal for memcg limit reclaim, but it may cause global
>>>>> kswapd shrink THPs from a different node.
>>>>>
>>>>> And, 0-day testing reported -19.6% regression of stress-ng's madvise
>>>>> test [1].  I didn't see that much regression on my test box (24 threads,
>>>>> 48GB memory, 2 nodes), with the same test (stress-ng --timeout 1
>>>>> --metrics-brief --sequential 72  --class vm --exclude spawn,exec), I saw
>>>>> average -3% (run the same test 10 times then calculate the average since
>>>>> the test itself may have most 15% variation according to my test)
>>>>> regression sometimes (not every time, sometimes I didn't see regression
>>>>> at all).
>>>>>
>>>>> This might be caused by deferred split queue lock contention.  With some
>>>>> configuration (i.e. just one root memcg) the lock contention my be worse
>>>>> than before (given 2 nodes, two locks are reduced to one lock).
>>>>>
>>>>> So, moving deferred split queue to memcg's nodeinfo to make it NUMA
>>>>> aware again.
>>>>>
>>>>> With this change stress-ng's madvise test shows average 4% improvement
>>>>> sometimes and I didn't see degradation anymore.
>>>> My concern about this getting more and more complex
>>>> (http://lkml.kernel.org/r/20191002084014.GH15624@dhcp22.suse.cz) holds
>>>> here even more. Can we step back and reconsider the whole thing please?
>>> What about freeing immediately after split via workqueue and also have a
>>> synchronous version called before going oom? Maybe there would be also
>>> other things that would benefit from this scheme instead of traditional
>>> reclaim and shrinkers?
>> That is exactly what we have discussed some time ago.
> Yes, I've posted the patch:
>
> http://lkml.kernel.org/r/20190827125911.boya23eowxhqmopa@box
>
> But I still not sure that the approach is right. I expect it to trigger
> performance regressions. For system with pleanty of free memory, we will
> just pay split cost for nothing in many cases.

This is exactly what I'm concerned about as well.

>

