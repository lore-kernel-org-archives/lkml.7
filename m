Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E3C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235226909
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfEaMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:51:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54223 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfEaMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:51:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TT54NNn_1559307066;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TT54NNn_1559307066)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 May 2019 20:51:07 +0800
Subject: Re: [HELP] How to get task_struct from mm
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5cf71366-ba01-8ef0-3dbd-c9fec8a2b26f@linux.alibaba.com>
 <20190530154119.GF6703@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <352de468-9091-9866-ccbd-10d80c25ebb4@linux.alibaba.com>
Date:   Fri, 31 May 2019 20:51:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190530154119.GF6703@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/19 11:41 PM, Michal Hocko wrote:
> On Thu 30-05-19 14:57:46, Yang Shi wrote:
>> Hi folks,
>>
>>
>> As what we discussed about page demotion for PMEM at LSF/MM, the demotion
>> should respect to the mempolicy and allowed mems of the process which the
>> page (anonymous page only for now) belongs to.
> cpusets memory mask (aka mems_allowed) is indeed tricky and somehow
> awkward.  It is inherently an address space property and I never
> understood why we have it per _thread_. This just doesn't make any
> sense to me. This just leads to weird corner cases. What should happen
> if different threads disagree about the allocation affinity while
> working on a shared address space?

I'm supposed (just my guess) such restriction should just apply for the 
first allocation. Just like memcg charge, who does it first, whose 
policy gets applied.

>   
>> The vma that the page is mapped to can be retrieved from rmap walk easily,
>> but we need know the task_struct that the vma belongs to. It looks there is
>> not such API, and container_of seems not work with pointer member.
> I do not think this is a good idea. As you point out in the reply we
> have that for memcgs but we really hope to get rid of mm->owner there
> as well. It is just more tricky there. Moreover such a reverse mapping
> would be incorrect. Just think of a disagreeing yet overlapping cpusets
> for different threads mapping the same page.
>
> Is it such a big deal to document that the node migrate is not
> compatible with cpusets?

Not only cpuset, but get_vma_policy() also needs find task_struct from 
vma. Currently, get_vma_policy() just uses "current", so it just returns 
the current process's mempolicy if the vma doesn't have mempolicy. For 
the node migrate case, "current" is definitely not correct.

It looks there is not an easy way to workaround it unless we claim node 
migrate is not compatible with both cpusets and mempolicy.


