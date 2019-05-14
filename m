Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EBC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D0320850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfENUoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:44:44 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44809 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfENUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:44:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TRkUBgw_1557866676;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TRkUBgw_1557866676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 May 2019 04:44:40 +0800
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Michal Hocko <mhocko@kernel.org>, Yang Shi <shy828301@gmail.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz>
 <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
 <20190513214503.GB25356@dhcp22.suse.cz>
 <CAHbLzkpUE2wBp8UjH72ugXjWSfFY5YjV1Ps9t5EM2VSRTUKxRw@mail.gmail.com>
 <20190514062039.GB20868@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <509de066-17bb-e3cf-d492-1daf1cb11494@linux.alibaba.com>
Date:   Tue, 14 May 2019 13:44:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190514062039.GB20868@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/19 11:20 PM, Michal Hocko wrote:
> On Mon 13-05-19 21:36:59, Yang Shi wrote:
>> On Mon, May 13, 2019 at 2:45 PM Michal Hocko <mhocko@kernel.org> wrote:
>>> On Mon 13-05-19 14:09:59, Yang Shi wrote:
>>> [...]
>>>> I think we can just account 512 base pages for nr_scanned for
>>>> isolate_lru_pages() to make the counters sane since PGSCAN_KSWAPD/DIRECT
>>>> just use it.
>>>>
>>>> And, sc->nr_scanned should be accounted as 512 base pages too otherwise we
>>>> may have nr_scanned < nr_to_reclaim all the time to result in false-negative
>>>> for priority raise and something else wrong (e.g. wrong vmpressure).
>>> Be careful. nr_scanned is used as a pressure indicator to slab shrinking
>>> AFAIR. Maybe this is ok but it really begs for much more explaining
>> I don't know why my company mailbox didn't receive this email, so I
>> replied with my personal email.
>>
>> It is not used to double slab pressure any more since commit
>> 9092c71bb724 ("mm: use sc->priority for slab shrink targets"). It uses
>> sc->priority to determine the pressure for slab shrinking now.
>>
>> So, I think we can just remove that "double slab pressure" code. It is
>> not used actually and looks confusing now. Actually, the "double slab
>> pressure" does something opposite. The extra inc to sc->nr_scanned
>> just prevents from raising sc->priority.
> I have to get in sync with the recent changes. I am aware there were
> some patches floating around but I didn't get to review them. I was
> trying to point out that nr_scanned used to have a side effect to be
> careful about. If it doesn't have anymore then this is getting much more
> easier of course. Please document everything in the changelog.

Thanks for reminding. Yes, I remembered nr_scanned would double slab 
pressure. But, when I inspected into the code yesterday, it turns out it 
is not true anymore. I will run some test to make sure it doesn't 
introduce regression.

BTW, I noticed the counter of memory reclaim is not correct with THP 
swap on vanilla kernel, please see the below:

pgsteal_kswapd 21435
pgsteal_direct 26573329
pgscan_kswapd 3514
pgscan_direct 14417775

pgsteal is always greater than pgscan, my patch could fix the problem.

Anyway, I will elaborate these in the commit log.


