Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DECCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E912087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfJaPra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:47:30 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49754 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfJaPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:47:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TgnKHgK_1572536841;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TgnKHgK_1572536841)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 23:47:23 +0800
Subject: Re: [PATCH] mm: mempolicy: fix the wrong return value and potential
 pages leak of mbind
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     lixinhai.lxh@gmail.com, vbabka@suse.cz, mhocko@suse.com,
        mgorman@techsingularity.net, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1572454731-3925-1-git-send-email-yang.shi@linux.alibaba.com>
 <12ac5b41-27a6-5a5b-0d07-7e9cb847829d@linux.alibaba.com>
 <20191030213144.dd7cd8084d4171e29abba875@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5cc16fd6-dd63-6798-4e3e-5c3a6b731aa2@linux.alibaba.com>
Date:   Thu, 31 Oct 2019 08:47:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191030213144.dd7cd8084d4171e29abba875@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/19 9:31 PM, Andrew Morton wrote:
> On Wed, 30 Oct 2019 11:14:58 -0700 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> On 10/30/19 9:58 AM, Yang Shi wrote:
>>> The commit d883544515aa ("mm: mempolicy: make the behavior consistent
>>> when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") fixed the return
>>> value of mbind() for a couple of corner cases.  But, it altered the
>>> errno for some other cases, for example, mbind() should return -EFAULT
>>> when part or all of the memory range specified by nodemask and maxnode
>>> points  outside your accessible address space, or there was an unmapped
>>> hole in the specified memory range specified by addr and len.
>>>
>>> Fixed this by preserving the errno returned by queue_pages_range().
>>> And, the pagelist may be not empty even though queue_pages_range()
>>> returns error, put the pages back to LRU since mbind_range() is not called
>>> to really apply the policy so those pages should not be migrated, this
>>> is also the old behavior before the problematic commit.
>> Forgot fixes tag.
>>
>> Fixes: d883544515aa ("mm: mempolicy: make the behavior consistent when
>> MPOL_MF_MOVE* and MPOL_MF_STRICT were specified")
> What's the relationship between this patch and
> http://lkml.kernel.org/r/201910291756045288126@gmail.com?

They are irrelevant. The commit d883544515aa ("mm: mempolicy: make the 
behavior consistent
when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") override the 
-EFAULT return value of queue_pages_range() by -EIO mistakenly and 
missed putting non-empty pagelist back, this patch is aimed to fix the 
two issues.

I think Li Xinhai found the return value override problem during 
debugging his patch.


