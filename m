Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B5CC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93C520879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfCYTtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:49:40 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49808 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729626AbfCYTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:49:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNeJ9A9_1553543363;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNeJ9A9_1553543363)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Mar 2019 03:49:33 +0800
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
To:     Keith Busch <kbusch@kernel.org>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
Date:   Mon, 25 Mar 2019 12:49:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190324222040.GE31194@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/19 3:20 PM, Keith Busch wrote:
> On Sat, Mar 23, 2019 at 12:44:31PM +0800, Yang Shi wrote:
>>   		/*
>> +		 * Demote DRAM pages regardless the mempolicy.
>> +		 * Demot anonymous pages only for now and skip MADV_FREE
>> +		 * pages.
>> +		 */
>> +		if (PageAnon(page) && !PageSwapCache(page) &&
>> +		    (node_isset(page_to_nid(page), def_alloc_nodemask)) &&
>> +		    PageSwapBacked(page)) {
>> +
>> +			if (has_nonram_online()) {
>> +				list_add(&page->lru, &demote_pages);
>> +				unlock_page(page);
>> +				continue;
>> +			}
>> +		}
>> +
>> +		/*
>>   		 * Anonymous process memory has backing store?
>>   		 * Try to allocate it some swap space here.
>>   		 * Lazyfree page could be freed directly
>> @@ -1477,6 +1507,25 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>>   	}
>>   
>> +	/* Demote pages to PMEM */
>> +	if (!list_empty(&demote_pages)) {
>> +		int err, target_nid;
>> +		nodemask_t used_mask;
>> +
>> +		nodes_clear(used_mask);
>> +		target_nid = find_next_best_node(pgdat->node_id, &used_mask,
>> +						 true);
>> +
>> +		err = migrate_pages(&demote_pages, alloc_new_node_page, NULL,
>> +				    target_nid, MIGRATE_ASYNC, MR_DEMOTE);
>> +
>> +		if (err) {
>> +			putback_movable_pages(&demote_pages);
>> +
>> +			list_splice(&ret_pages, &demote_pages);
>> +		}
>> +	}
>> +
>>   	mem_cgroup_uncharge_list(&free_pages);
>>   	try_to_unmap_flush();
>>   	free_unref_page_list(&free_pages);
> How do these pages eventually get to swap when migration fails? Looks
> like that's skipped.

Yes, they will be just put back to LRU. Actually, I don't expect it 
would be very often to have migration fail at this stage (but I have no 
test data to support this hypothesis) since the pages have been isolated 
from LRU, so other reclaim path should not find them anymore.

If it is locked by someone else right before migration, it is likely 
referenced again, so putting back to LRU sounds not bad.

A potential improvement is to have sync migration for kswapd.

>
> And page cache demotion is useful too, we shouldn't consider only
> anonymous for this feature.

Yes, definitely. I'm looking into the page cache case now. Any 
suggestion is welcome.

Thanks,
Yang


