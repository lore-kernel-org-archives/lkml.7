Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E7AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065A0217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 04:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfH0E17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 00:27:59 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47243 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfH0E17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:27:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Taa5IL3_1566880067;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Taa5IL3_1566880067)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 12:27:50 +0800
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <9e4ba38e-0670-7292-ab3a-38af391598ec@linux.alibaba.com>
 <20190826074350.GE7538@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <416daa85-44d4-1ef9-cc4c-6b91a8354c79@linux.alibaba.com>
Date:   Mon, 26 Aug 2019 21:27:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190826074350.GE7538@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/19 12:43 AM, Michal Hocko wrote:
> On Thu 22-08-19 08:33:40, Yang Shi wrote:
>>
>> On 8/22/19 1:04 AM, Michal Hocko wrote:
>>> On Thu 22-08-19 01:55:25, Yang Shi wrote:
> [...]
>>>> And, they seems very common with the common workloads when THP is
>>>> enabled.  A simple run with MariaDB test of mmtest with THP enabled as
>>>> always shows it could generate over fifteen thousand deferred split THPs
>>>> (accumulated around 30G in one hour run, 75% of 40G memory for my VM).
>>>> It looks worth accounting in MemAvailable.
>>> OK, this makes sense. But your above numbers are really worrying.
>>> Accumulating such a large amount of pages that are likely not going to
>>> be used is really bad. They are essentially blocking any higher order
>>> allocations and also push the system towards more memory pressure.
>> That is accumulated number, during the running of the test, some of them
>> were freed by shrinker already. IOW, it should not reach that much at any
>> given time.
> Then the above description is highly misleading. What is the actual
> number of lingering THPs that wait for the memory pressure in the peak?

By rerunning sysbench mariadb test of mmtest, I didn't see too many THPs 
in the peak. I saw around 2K THPs sometimes on my VM with 40G memory. 
But they were short-lived (should be freed when the test exit). And, the 
number of accumulated THPs are variable.

And, this reminded me to go back double check our internal bug report 
which lead to the "make deferred split shrinker memcg aware" patchset.

In that case, a mysql instance with real production load was running in 
a memcg with ~86G limit, the number of deferred split THPs may reach to 
~68G (~34K deferred split THPs) in a few hours. The deferred split THP 
shrinker was not invoked since global memory pressure is still fine 
since the host has 256G memory, but memcg limit reclaim was triggered.

And, I can't tell if all those deferred split THPs came from mysql or 
not since there were some other processes run in that container too 
according to the oom log.

I will update the commit log with the more solid data from production 
environment.

>   
>>> IIUC deferred splitting is mostly a workaround for nasty locking issues
>>> during splitting, right? This is not really an optimization to cache
>>> THPs for reuse or something like that. What is the reason this is not
>>> done from a worker context? At least THPs which would be freed
>>> completely sound like a good candidate for kworker tear down, no?
>> Yes, deferred split THP was introduced to avoid locking issues according to
>> the document. Memcg awareness would help to trigger the shrinker more often.
>>
>> I think it could be done in a worker context, but when to trigger to worker
>> is a subtle problem.
> Why? What is the problem to trigger it after unmap of a batch worth of
> THPs?

This leads to another question, how many THPs are "a batch of worth"? 
And, they may be short-lived as showed by Kirill's example, we can't 
tell in advance how long the THPs life time is. We may waste cpu cycles 
to do something unneeded.


