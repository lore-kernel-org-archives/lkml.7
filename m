Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BBAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD12208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfFYPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:49:46 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42413 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfFYPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:49:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TVBV9sb_1561477780;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVBV9sb_1561477780)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jun 2019 23:49:44 +0800
Subject: Re: [v3 PATCH 2/4] mm: move mem_cgroup_uncharge out of
 __page_cache_release()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560376609-113689-3-git-send-email-yang.shi@linux.alibaba.com>
 <20190613113943.ahmqpezemdbwgyax@box>
 <2909ce59-86ba-ea0b-479f-756020fb32af@linux.alibaba.com>
 <df469474-9b1c-6052-6aaa-be4558f7bd86@linux.alibaba.com>
 <20190625093543.qsl5l5hyjv6shvve@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <18396199-8997-c721-0b9f-b1d8650c0f5b@linux.alibaba.com>
Date:   Tue, 25 Jun 2019 08:49:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190625093543.qsl5l5hyjv6shvve@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/19 2:35 AM, Kirill A. Shutemov wrote:
> On Mon, Jun 24, 2019 at 09:54:05AM -0700, Yang Shi wrote:
>>
>> On 6/13/19 10:13 AM, Yang Shi wrote:
>>>
>>> On 6/13/19 4:39 AM, Kirill A. Shutemov wrote:
>>>> On Thu, Jun 13, 2019 at 05:56:47AM +0800, Yang Shi wrote:
>>>>> The later patch would make THP deferred split shrinker memcg aware, but
>>>>> it needs page->mem_cgroup information in THP destructor, which
>>>>> is called
>>>>> after mem_cgroup_uncharge() now.
>>>>>
>>>>> So, move mem_cgroup_uncharge() from __page_cache_release() to compound
>>>>> page destructor, which is called by both THP and other compound pages
>>>>> except HugeTLB.  And call it in __put_single_page() for single order
>>>>> page.
>>>> If I read the patch correctly, it will change behaviour for pages with
>>>> NULL_COMPOUND_DTOR. Have you considered it? Are you sure it will not
>>>> break
>>>> anything?
>> Hi Kirill,
>>
>> Did this solve your concern? Any more comments on this series?
> Everyting looks good now. You can use my
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> for the series.

Thanks!

>

