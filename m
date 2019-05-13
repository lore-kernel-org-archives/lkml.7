Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67911C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFED208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEMVKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:10:32 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:24784 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfEMVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:10:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TRdjdXM_1557781806;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TRdjdXM_1557781806)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 May 2019 05:10:09 +0800
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Michal Hocko <mhocko@kernel.org>
Cc:     ying.huang@intel.com, hannes@cmpxchg.org,
        mgorman@techsingularity.net, kirill.shutemov@linux.intel.com,
        hughd@google.com, shakeelb@google.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
Date:   Mon, 13 May 2019 14:09:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190513080929.GC24036@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/19 1:09 AM, Michal Hocko wrote:
> On Sat 11-05-19 00:23:40, Yang Shi wrote:
>> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
>> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
>> still gets inc'ed by one even though a whole THP (512 pages) gets
>> swapped out.
>>
>> This doesn't make too much sense to memory reclaim.  For example, direct
>> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
>> could fulfill it.  But, if nr_reclaimed is not increased correctly,
>> direct reclaim may just waste time to reclaim more pages,
>> SWAP_CLUSTER_MAX * 512 pages in worst case.
> You are technically right here. This has been a known issue for a while.
> I am wondering whether somebody actually noticed some misbehavior.
> Swapping out is a rare event and you have to have a considerable number
> of THPs to notice.

The commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after 
swapped out") was added in 4.14, it might be not used widely yet. And we 
need swap + THPs to trigger it, furthermore the misbehavior might be 
accumulative over time. I don't expect it will have any obvious 
misbehavior for a single shot.

>
>> This change may result in more reclaimed pages than scanned pages showed
>> by /proc/vmstat since scanning one head page would reclaim 512 base pages.
> This is quite nasty and confusing. I am worried that having those two
> unsynced begs for subtle issues. Can we account THP as scanning 512 base
> pages as well?

Actually, such unsync has been there for a while. The 
isolate_lru_pages() returns nr_taken which has THP accounted as 512 base 
pages, but nr_scanned just shows 1. nr_taken is not showed via 
/proc/vmstat, but it is showed via trace point.

I think we can just account 512 base pages for nr_scanned for 
isolate_lru_pages() to make the counters sane since PGSCAN_KSWAPD/DIRECT 
just use it.

And, sc->nr_scanned should be accounted as 512 base pages too otherwise 
we may have nr_scanned < nr_to_reclaim all the time to result in 
false-negative for priority raise and something else wrong (e.g. wrong 
vmpressure).

>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v2: Added Shakeel's Reviewed-by
>>      Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>>
>>   mm/vmscan.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index fd9de50..4226d6b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1446,7 +1446,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   
>>   		unlock_page(page);
>>   free_it:
>> -		nr_reclaimed++;
>> +		/*
>> +		 * THP may get swapped out in a whole, need account
>> +		 * all base pages.
>> +		 */
>> +		nr_reclaimed += hpage_nr_pages(page);
>>   
>>   		/*
>>   		 * Is there need to periodically free_page_list? It would
>> -- 
>> 1.8.3.1
>>

