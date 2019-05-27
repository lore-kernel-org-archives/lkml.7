Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E1EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8405821721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfE0IHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:07:31 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47368 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfE0IHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:07:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TSn3jsE_1558944443;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSn3jsE_1558944443)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 May 2019 16:07:24 +0800
Subject: Re: [v6 PATCH 2/2] mm: vmscan: correct some vmscan counters for THP
 swapout
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     hannes@cmpxchg.org, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, hdanton@sina.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1558929166-3363-1-git-send-email-yang.shi@linux.alibaba.com>
 <1558929166-3363-2-git-send-email-yang.shi@linux.alibaba.com>
 <87ef4k8jgs.fsf@yhuang-dev.intel.com>
 <aa145948-ac14-c89b-d847-ffca81d8dbdf@linux.alibaba.com>
 <87a7f88h6q.fsf@yhuang-dev.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3d0bd4a8-562a-1115-b192-60267b3c8973@linux.alibaba.com>
Date:   Mon, 27 May 2019 16:07:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87a7f88h6q.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/19 3:55 PM, Huang, Ying wrote:
> Yang Shi <yang.shi@linux.alibaba.com> writes:
>
>> On 5/27/19 3:06 PM, Huang, Ying wrote:
>>> Yang Shi <yang.shi@linux.alibaba.com> writes:
>>>
>>>> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
>>>> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
>>>> and some other vm counters still get inc'ed by one even though a whole
>>>> THP (512 pages) gets swapped out.
>>>>
>>>> This doesn't make too much sense to memory reclaim.  For example, direct
>>>> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
>>>> could fulfill it.  But, if nr_reclaimed is not increased correctly,
>>>> direct reclaim may just waste time to reclaim more pages,
>>>> SWAP_CLUSTER_MAX * 512 pages in worst case.
>>>>
>>>> And, it may cause pgsteal_{kswapd|direct} is greater than
>>>> pgscan_{kswapd|direct}, like the below:
>>>>
>>>> pgsteal_kswapd 122933
>>>> pgsteal_direct 26600225
>>>> pgscan_kswapd 174153
>>>> pgscan_direct 14678312
>>>>
>>>> nr_reclaimed and nr_scanned must be fixed in parallel otherwise it would
>>>> break some page reclaim logic, e.g.
>>>>
>>>> vmpressure: this looks at the scanned/reclaimed ratio so it won't
>>>> change semantics as long as scanned & reclaimed are fixed in parallel.
>>>>
>>>> compaction/reclaim: compaction wants a certain number of physical pages
>>>> freed up before going back to compacting.
>>>>
>>>> kswapd priority raising: kswapd raises priority if we scan fewer pages
>>>> than the reclaim target (which itself is obviously expressed in order-0
>>>> pages). As a result, kswapd can falsely raise its aggressiveness even
>>>> when it's making great progress.
>>>>
>>>> Other than nr_scanned and nr_reclaimed, some other counters, e.g.
>>>> pgactivate, nr_skipped, nr_ref_keep and nr_unmap_fail need to be fixed
>>>> too since they are user visible via cgroup, /proc/vmstat or trace
>>>> points, otherwise they would be underreported.
>>>>
>>>> When isolating pages from LRUs, nr_taken has been accounted in base
>>>> page, but nr_scanned and nr_skipped are still accounted in THP.  It
>>>> doesn't make too much sense too since this may cause trace point
>>>> underreport the numbers as well.
>>>>
>>>> So accounting those counters in base page instead of accounting THP as
>>>> one page.
>>>>
>>>> nr_dirty, nr_unqueued_dirty, nr_congested and nr_writeback are used by
>>>> file cache, so they are not impacted by THP swap.
>>>>
>>>> This change may result in lower steal/scan ratio in some cases since
>>>> THP may get split during page reclaim, then a part of tail pages get
>>>> reclaimed instead of the whole 512 pages, but nr_scanned is accounted
>>>> by 512, particularly for direct reclaim.  But, this should be not a
>>>> significant issue.
>>>>
>>>> Cc: "Huang, Ying" <ying.huang@intel.com>
>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Shakeel Butt <shakeelb@google.com>
>>>> Cc: Hillf Danton <hdanton@sina.com>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> ---
>>>> v6: Fixed the other double account issue introduced by v5 per Huang Ying
>>>> v5: Fixed sc->nr_scanned double accounting per Huang Ying
>>>>       Added some comments to address the concern about premature OOM per Hillf Danton
>>>> v4: Fixed the comments from Johannes and Huang Ying
>>>> v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
>>>>       Switched back to use compound_order per Matthew
>>>>       Fixed more counters per Johannes
>>>> v2: Added Shakeel's Reviewed-by
>>>>       Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>>>>
>>>>    mm/vmscan.c | 47 +++++++++++++++++++++++++++++++++++------------
>>>>    1 file changed, 35 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index b65bc50..378edff 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1118,6 +1118,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>>    		int may_enter_fs;
>>>>    		enum page_references references = PAGEREF_RECLAIM_CLEAN;
>>>>    		bool dirty, writeback;
>>>> +		unsigned int nr_pages;
>>>>      		cond_resched();
>>>>    @@ -1129,7 +1130,10 @@ static unsigned long
>>>> shrink_page_list(struct list_head *page_list,
>>>>      		VM_BUG_ON_PAGE(PageActive(page), page);
>>>>    -		sc->nr_scanned++;
>>>> +		nr_pages = 1 << compound_order(page);
>>>> +
>>>> +		/* Account the number of base pages even though THP */
>>>> +		sc->nr_scanned += nr_pages;
>>>>      		if (unlikely(!page_evictable(page)))
>>>>    			goto activate_locked;
>>>> @@ -1250,7 +1254,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>>    		case PAGEREF_ACTIVATE:
>>>>    			goto activate_locked;
>>>>    		case PAGEREF_KEEP:
>>>> -			stat->nr_ref_keep++;
>>>> +			stat->nr_ref_keep += nr_pages;
>>>>    			goto keep_locked;
>>>>    		case PAGEREF_RECLAIM:
>>>>    		case PAGEREF_RECLAIM_CLEAN:
>>>> @@ -1306,6 +1310,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>>    		}
>>>>      		/*
>>>> +		 * THP may get split above, need minus tail pages and update
>>>> +		 * nr_pages to avoid accounting tail pages twice.
>>>> +		 */
>>>> +		if ((nr_pages > 1) && !PageTransHuge(page)) {
>>>> +			sc->nr_scanned -= (nr_pages - 1);
>>>> +			nr_pages = 1;
>>>> +		}
>>> After checking the code again, it appears there's another hole in the
>>> code.  In the following code snippet.
>>>
>>> 				if (!add_to_swap(page)) {
>>> 					if (!PageTransHuge(page))
>>> 						goto activate_locked;
>>> 					/* Fallback to swap normal pages */
>>> 					if (split_huge_page_to_list(page,
>>> 								    page_list))
>>> 						goto activate_locked;
>>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> 					count_vm_event(THP_SWPOUT_FALLBACK);
>>> #endif
>>> 					if (!add_to_swap(page))
>>> 						goto activate_locked;
>>> 				}
>>>
>>>
>>> If the THP is split, but the first or the second add_to_swap() fails, we
>>> still need to deal with sc->nr_scanned and nr_pages.
>>>
>>> How about add a new label before "activate_locked" to deal with that?
>> It sounds not correct. If swapout fails it jumps to activate_locked
>> too, it has to be handled in if (!add_to_swap(page)). The below fix
>> should be good enough since only THP can reach here:
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 378edff..fff3937 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1294,8 +1294,15 @@ static unsigned long shrink_page_list(struct
>> list_head *page_list,
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> count_vm_event(THP_SWPOUT_FALLBACK);
>>   #endif
>> -                                       if (!add_to_swap(page))
>> +                                       if (!add_to_swap(page)) {
>> +                                               /*
>> +                                                * Minus tail pages
>> and reset
>> +                                                * nr_pages.
>> +                                                */
>> +                                               sc->nr_scanned -=
>> (nr_pages - 1);
>> +                                               nr_pages = 1;
>>                                                  goto activate_locked;
>> +                                       }
>>                                  }
> I think you need to add similar logic for the first add_to_swap() in the
> original code snippet.

Yes.

>
>>> 				if (!add_to_swap(page)) {
>>> 					if (!PageTransHuge(page))
> To reduce code duplication, I suggest to add another label to deal with
> it.
>
> activate_locked_split:
>          if (nr_pages > 1) {
>                  sc->nr_scanned -= nr_pages - 1;
>                  nr_pages = 1;
>          }
>
> activate_locked:
>
> And use "goto active_locked_split" if add_to_swap() failed.

OK, I could not think of better way to deal with it.

>
> Best Regards,
> Huang, Ying

