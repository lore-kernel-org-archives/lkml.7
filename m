Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510CFC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AD52182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfEJDDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:03:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:56872 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfEJDDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:03:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 20:03:18 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2019 20:03:17 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <kirill.shutemov@linux.intel.com>,
        <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
        <87y33fjbvr.fsf@yhuang-dev.intel.com>
        <1fb73973-f409-1411-423b-c48895d3dde8@linux.alibaba.com>
Date:   Fri, 10 May 2019 11:03:16 +0800
In-Reply-To: <1fb73973-f409-1411-423b-c48895d3dde8@linux.alibaba.com> (Yang
        Shi's message of "Thu, 9 May 2019 19:25:20 -0700")
Message-ID: <87tve3j9jf.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> writes:

> On 5/9/19 7:12 PM, Huang, Ying wrote:
>> Yang Shi <yang.shi@linux.alibaba.com> writes:
>>
>>> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
>>> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
>>> still gets inc'ed by one even though a whole THP (512 pages) gets
>>> swapped out.
>>>
>>> This doesn't make too much sense to memory reclaim.  For example, direct
>>> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
>>> could fulfill it.  But, if nr_reclaimed is not increased correctly,
>>> direct reclaim may just waste time to reclaim more pages,
>>> SWAP_CLUSTER_MAX * 512 pages in worst case.
>>>
>>> This change may result in more reclaimed pages than scanned pages showed
>>> by /proc/vmstat since scanning one head page would reclaim 512 base pages.
>>>
>>> Cc: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> ---
>>> I'm not quite sure if it was the intended behavior or just omission. I tried
>>> to dig into the review history, but didn't find any clue. I may miss some
>>> discussion.
>>>
>>>   mm/vmscan.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index fd9de50..7e026ec 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1446,7 +1446,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>     		unlock_page(page);
>>>   free_it:
>>> -		nr_reclaimed++;
>>> +		/*
>>> +		 * THP may get swapped out in a whole, need account
>>> +		 * all base pages.
>>> +		 */
>>> +		nr_reclaimed += (1 << compound_order(page));
>>>     		/*
>>>   		 * Is there need to periodically free_page_list? It would
>> Good catch!  Thanks!
>>
>> How about to change this to
>>
>>
>>          nr_reclaimed += hpage_nr_pages(page);
>
> Either is fine to me. Is this faster than "1 << compound_order(page)"?

I think the readability is a little better.  And this will become

        nr_reclaimed += 1

if CONFIG_TRANSPARENT_HUAGEPAGE is disabled.

Best Regards,
Huang, Ying

>>
>> Best Regards,
>> Huang, Ying
