Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F05F206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfCYVtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:49:53 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50384 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729106AbfCYVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:49:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNeoZoD_1553550582;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNeoZoD_1553550582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Mar 2019 05:49:48 +0800
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
To:     Zi Yan <ziy@nvidia.com>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <B4EB750E-482B-4E4D-A679-4821E57C172E@nvidia.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <c0e53bf9-2091-a224-187c-4de68ee6d753@linux.alibaba.com>
Date:   Mon, 25 Mar 2019 14:49:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <B4EB750E-482B-4E4D-A679-4821E57C172E@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/19 11:03 PM, Zi Yan wrote:
> On 22 Mar 2019, at 21:44, Yang Shi wrote:
>
>> Since PMEM provides larger capacity than DRAM and has much lower
>> access latency than disk, so it is a good choice to use as a middle
>> tier between DRAM and disk in page reclaim path.
>>
>> With PMEM nodes, the demotion path of anonymous pages could be:
>>
>> DRAM -> PMEM -> swap device
>>
>> This patch demotes anonymous pages only for the time being and demote
>> THP to PMEM in a whole.  However this may cause expensive page reclaim
>> and/or compaction on PMEM node if there is memory pressure on it.  But,
>> considering the capacity of PMEM and allocation only happens on PMEM
>> when PMEM is specified explicity, such cases should be not that often.
>> So, it sounds worth keeping THP in a whole instead of splitting it.
>>
>> Demote pages to the cloest non-DRAM node even though the system is
>> swapless.  The current logic of page reclaim just scan anon LRU when
>> swap is on and swappiness is set properly.  Demoting to PMEM doesn't
>> need care whether swap is available or not.  But, reclaiming from PMEM
>> still skip anon LRU is swap is not available.
>>
>> The demotion just happens between DRAM node and its cloest PMEM node.
>> Demoting to a remote PMEM node is not allowed for now.
>>
>> And, define a new migration reason for demotion, called MR_DEMOTE.
>> Demote page via async migration to avoid blocking.
>>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   include/linux/migrate.h        |  1 +
>>   include/trace/events/migrate.h |  3 +-
>>   mm/debug.c                     |  1 +
>>   mm/internal.h                  | 22 ++++++++++
>>   mm/vmscan.c                    | 99 ++++++++++++++++++++++++++++++++++--------
>>   5 files changed, 107 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index e13d9bf..78c8dda 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -25,6 +25,7 @@ enum migrate_reason {
>>   	MR_MEMPOLICY_MBIND,
>>   	MR_NUMA_MISPLACED,
>>   	MR_CONTIG_RANGE,
>> +	MR_DEMOTE,
>>   	MR_TYPES
>>   };
>>
>> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
>> index 705b33d..c1d5b36 100644
>> --- a/include/trace/events/migrate.h
>> +++ b/include/trace/events/migrate.h
>> @@ -20,7 +20,8 @@
>>   	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>>   	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>>   	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
>> -	EMe(MR_CONTIG_RANGE,	"contig_range")
>> +	EM( MR_CONTIG_RANGE,	"contig_range")			\
>> +	EMe(MR_DEMOTE,		"demote")
>>
>>   /*
>>    * First define the enums in the above macros to be exported to userspace
>> diff --git a/mm/debug.c b/mm/debug.c
>> index c0b31b6..cc0d7df 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -25,6 +25,7 @@
>>   	"mempolicy_mbind",
>>   	"numa_misplaced",
>>   	"cma",
>> +	"demote",
>>   };
>>
>>   const struct trace_print_flags pageflag_names[] = {
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 46ad0d8..0152300 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -303,6 +303,19 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask,
>>   }
>>   #endif
>>
>> +static inline bool has_nonram_online(void)
>> +{
>> +	int i = 0;
>> +
>> +	for_each_online_node(i) {
>> +		/* Have PMEM node online? */
>> +		if (!node_isset(i, def_alloc_nodemask))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   /* mm/util.c */
>>   void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>>   		struct vm_area_struct *prev, struct rb_node *rb_parent);
>> @@ -565,5 +578,14 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>>   }
>>
>>   void setup_zone_pageset(struct zone *zone);
>> +
>> +#ifdef CONFIG_NUMA
>>   extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
>> +#else
>> +static inline struct page *alloc_new_node_page(struct page *page,
>> +					       unsigned long node)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>>   #endif	/* __MM_INTERNAL_H */
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index a5ad0b3..bdcab6b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1094,6 +1094,19 @@ static void page_check_dirty_writeback(struct page *page,
>>   		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>>   }
>>
>> +static inline bool is_demote_ok(struct pglist_data *pgdat)
>> +{
>> +	/* Current node is not DRAM node */
>> +	if (!node_isset(pgdat->node_id, def_alloc_nodemask))
>> +		return false;
>> +
>> +	/* No online PMEM node */
>> +	if (!has_nonram_online())
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   /*
>>    * shrink_page_list() returns the number of reclaimed pages
>>    */
>> @@ -1106,6 +1119,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   {
>>   	LIST_HEAD(ret_pages);
>>   	LIST_HEAD(free_pages);
>> +	LIST_HEAD(demote_pages);
>>   	unsigned nr_reclaimed = 0;
>>
>>   	memset(stat, 0, sizeof(*stat));
>> @@ -1262,6 +1276,22 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		}
>>
>>   		/*
>> +		 * Demote DRAM pages regardless the mempolicy.
>> +		 * Demot anonymous pages only for now and skip MADV_FREE
> s/Demot/Demote

Thanks for catching this. Will fix.

>
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
> I like your approach here. It reuses the existing migrate_pages() interface without
> adding extra code. I also would like to be CC’d in your future versions.

Yes, sure.

Thanks,
Yang

>
> Thank you.
>
> --
> Best Regards,
> Yan Zi

