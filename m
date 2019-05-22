Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B80AC16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C43217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfEVD02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:26:28 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54643 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727733AbfEVD01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:26:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TSM5PZQ_1558495581;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSM5PZQ_1558495581)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 May 2019 11:26:22 +0800
Subject: Re: [v3 PATCH 2/2] mm: vmscan: correct some vmscan counters for THP
 swapout
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     hannes@cmpxchg.org, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1558431642-52120-1-git-send-email-yang.shi@linux.alibaba.com>
 <1558431642-52120-2-git-send-email-yang.shi@linux.alibaba.com>
 <87ftp7cmds.fsf@yhuang-dev.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <200a8dc9-f9cd-e039-fefe-1971271e27c3@linux.alibaba.com>
Date:   Wed, 22 May 2019 11:26:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87ftp7cmds.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/19 9:23 AM, Huang, Ying wrote:
> Yang Shi <yang.shi@linux.alibaba.com> writes:
>
>> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
>> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
>> and some other vm counters still get inc'ed by one even though a whole
>> THP (512 pages) gets swapped out.
>>
>> This doesn't make too much sense to memory reclaim.  For example, direct
>> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
>> could fulfill it.  But, if nr_reclaimed is not increased correctly,
>> direct reclaim may just waste time to reclaim more pages,
>> SWAP_CLUSTER_MAX * 512 pages in worst case.
>>
>> And, it may cause pgsteal_{kswapd|direct} is greater than
>> pgscan_{kswapd|direct}, like the below:
>>
>> pgsteal_kswapd 122933
>> pgsteal_direct 26600225
>> pgscan_kswapd 174153
>> pgscan_direct 14678312
>>
>> nr_reclaimed and nr_scanned must be fixed in parallel otherwise it would
>> break some page reclaim logic, e.g.
>>
>> vmpressure: this looks at the scanned/reclaimed ratio so it won't
>> change semantics as long as scanned & reclaimed are fixed in parallel.
>>
>> compaction/reclaim: compaction wants a certain number of physical pages
>> freed up before going back to compacting.
>>
>> kswapd priority raising: kswapd raises priority if we scan fewer pages
>> than the reclaim target (which itself is obviously expressed in order-0
>> pages). As a result, kswapd can falsely raise its aggressiveness even
>> when it's making great progress.
>>
>> Other than nr_scanned and nr_reclaimed, some other counters, e.g.
>> pgactivate, nr_skipped, nr_ref_keep and nr_unmap_fail need to be fixed
>> too since they are user visible via cgroup, /proc/vmstat or trace
>> points, otherwise they would be underreported.
>>
>> When isolating pages from LRUs, nr_taken has been accounted in base
>> page, but nr_scanned and nr_skipped are still accounted in THP.  It
>> doesn't make too much sense too since this may cause trace point
>> underreport the numbers as well.
>>
>> So accounting those counters in base page instead of accounting THP as
>> one page.
>>
>> This change may result in lower steal/scan ratio in some cases since
>> THP may get split during page reclaim, then a part of tail pages get
>> reclaimed instead of the whole 512 pages, but nr_scanned is accounted
>> by 512, particularly for direct reclaim.  But, this should be not a
>> significant issue.
>>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
>>      Switched back to use compound_order per Matthew
>>      Fixed more counters per Johannes
>> v2: Added Shakeel's Reviewed-by
>>      Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>>
>>   mm/vmscan.c | 40 ++++++++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index b65bc50..1044834 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1250,7 +1250,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		case PAGEREF_ACTIVATE:
>>   			goto activate_locked;
>>   		case PAGEREF_KEEP:
>> -			stat->nr_ref_keep++;
>> +			stat->nr_ref_keep += (1 << compound_order(page));
>>   			goto keep_locked;
>>   		case PAGEREF_RECLAIM:
>>   		case PAGEREF_RECLAIM_CLEAN:
>> @@ -1294,6 +1294,17 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   						goto activate_locked;
>>   				}
>>   
>> +				/*
>> +				 * Account all tail pages when THP is added
>> +				 * into swap cache successfully.
>> +				 * The head page has been accounted at the
>> +				 * first place.
>> +				 */
>> +				if (PageTransHuge(page))
>> +					sc->nr_scanned +=
>> +						((1 << compound_order(page)) -
>> +							1);
>> +
> The "if" here could be changed to "else if" because if add_to_swap()
> fails we don't need to call PageTransHuge() here.  But this isn't a big
> deal.

This could be moved to the beginning according to Johannes.

>
> You have analyzed the code and found that nr_dirty, nr_unqueued_dirty,
> nr_congested and nr_writeback are file cache related and not impacted by
> THP swap out.  How about add your findings in the patch description?

Yes, sure. Will add in v4.

>
> Best Regards,
> Huang, Ying
>

