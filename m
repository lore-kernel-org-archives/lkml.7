Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32017206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfCDRCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:02:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:43810 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCDRCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:02:40 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1h0qyg-0000MJ-7U; Mon, 04 Mar 2019 20:02:10 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH RFC] mm/vmscan: try to protect active working set of
 cgroup from reclaim.
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
References: <20190222175825.18657-1-aryabinin@virtuozzo.com>
 <20190222191552.GA15922@cmpxchg.org>
 <f752c208-599c-9b5a-bc42-e4282df43616@virtuozzo.com>
 <7c915942-6f52-e7a4-b879-e4c99dd65968@virtuozzo.com>
 <20190301174907.GA2375@cmpxchg.org>
 <51ac7aaa-6890-c674-854d-1e2d132b83f9@virtuozzo.com>
 <20190301222010.GA9215@cmpxchg.org>
Message-ID: <a0709797-e73d-9209-cb0c-5fd490738afd@virtuozzo.com>
Date:   Mon, 4 Mar 2019 20:02:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190301222010.GA9215@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/19 1:20 AM, Johannes Weiner wrote:
> On Fri, Mar 01, 2019 at 10:46:34PM +0300, Andrey Ryabinin wrote:
>> On 3/1/19 8:49 PM, Johannes Weiner wrote:
>>> On Fri, Mar 01, 2019 at 01:38:26PM +0300, Andrey Ryabinin wrote:
>>>> On 2/26/19 3:50 PM, Andrey Ryabinin wrote:
>>>>> On 2/22/19 10:15 PM, Johannes Weiner wrote:
>>>>>> On Fri, Feb 22, 2019 at 08:58:25PM +0300, Andrey Ryabinin wrote:
>>>>>>> In a presence of more than 1 memory cgroup in the system our reclaim
>>>>>>> logic is just suck. When we hit memory limit (global or a limit on
>>>>>>> cgroup with subgroups) we reclaim some memory from all cgroups.
>>>>>>> This is sucks because, the cgroup that allocates more often always wins.
>>>>>>> E.g. job that allocates a lot of clean rarely used page cache will push
>>>>>>> out of memory other jobs with active relatively small all in memory
>>>>>>> working set.
>>>>>>>
>>>>>>> To prevent such situations we have memcg controls like low/max, etc which
>>>>>>> are supposed to protect jobs or limit them so they to not hurt others.
>>>>>>> But memory cgroups are very hard to configure right because it requires
>>>>>>> precise knowledge of the workload which may vary during the execution.
>>>>>>> E.g. setting memory limit means that job won't be able to use all memory
>>>>>>> in the system for page cache even if the rest the system is idle.
>>>>>>> Basically our current scheme requires to configure every single cgroup
>>>>>>> in the system.
>>>>>>>
>>>>>>> I think we can do better. The idea proposed by this patch is to reclaim
>>>>>>> only inactive pages and only from cgroups that have big
>>>>>>> (!inactive_is_low()) inactive list. And go back to shrinking active lists
>>>>>>> only if all inactive lists are low.
>>>>>>
>>>>>> Yes, you are absolutely right.
>>>>>>
>>>>>> We shouldn't go after active pages as long as there are plenty of
>>>>>> inactive pages around. That's the global reclaim policy, and we
>>>>>> currently fail to translate that well to cgrouped systems.
>>>>>>
>>>>>> Setting group protections or limits would work around this problem,
>>>>>> but they're kind of a red herring. We shouldn't ever allow use-once
>>>>>> streams to push out hot workingsets, that's a bug.
>>>>>>
>>>>>>> @@ -2489,6 +2491,10 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>>>>>>>  
>>>>>>>  		scan >>= sc->priority;
>>>>>>>  
>>>>>>> +		if (!sc->may_shrink_active && inactive_list_is_low(lruvec,
>>>>>>> +						file, memcg, sc, false))
>>>>>>> +			scan = 0;
>>>>>>> +
>>>>>>>  		/*
>>>>>>>  		 * If the cgroup's already been deleted, make sure to
>>>>>>>  		 * scrape out the remaining cache.
>>>>>>> @@ -2733,6 +2739,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>>>>>>  	struct reclaim_state *reclaim_state = current->reclaim_state;
>>>>>>>  	unsigned long nr_reclaimed, nr_scanned;
>>>>>>>  	bool reclaimable = false;
>>>>>>> +	bool retry;
>>>>>>>  
>>>>>>>  	do {
>>>>>>>  		struct mem_cgroup *root = sc->target_mem_cgroup;
>>>>>>> @@ -2742,6 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>>>>>>  		};
>>>>>>>  		struct mem_cgroup *memcg;
>>>>>>>  
>>>>>>> +		retry = false;
>>>>>>> +
>>>>>>>  		memset(&sc->nr, 0, sizeof(sc->nr));
>>>>>>>  
>>>>>>>  		nr_reclaimed = sc->nr_reclaimed;
>>>>>>> @@ -2813,6 +2822,13 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>>>>>>  			}
>>>>>>>  		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
>>>>>>>  
>>>>>>> +		if ((sc->nr_scanned - nr_scanned) == 0 &&
>>>>>>> +		     !sc->may_shrink_active) {
>>>>>>> +			sc->may_shrink_active = 1;
>>>>>>> +			retry = true;
>>>>>>> +			continue;
>>>>>>> +		}
>>>>>>
>>>>>> Using !scanned as the gate could be a problem. There might be a cgroup
>>>>>> that has inactive pages on the local level, but when viewed from the
>>>>>> system level the total inactive pages in the system might still be low
>>>>>> compared to active ones. In that case we should go after active pages.
>>>>>>
>>>>>> Basically, during global reclaim, the answer for whether active pages
>>>>>> should be scanned or not should be the same regardless of whether the
>>>>>> memory is all global or whether it's spread out between cgroups.
>>>>>>
>>>>>> The reason this isn't the case is because we're checking the ratio at
>>>>>> the lruvec level - which is the highest level (and identical to the
>>>>>> node counters) when memory is global, but it's at the lowest level
>>>>>> when memory is cgrouped.
>>>>>>
>>>>>> So IMO what we should do is:
>>>>>>
>>>>>> - At the beginning of global reclaim, use node_page_state() to compare
>>>>>>   the INACTIVE_FILE:ACTIVE_FILE ratio and then decide whether reclaim
>>>>>>   can go after active pages or not. Regardless of what the ratio is in
>>>>>>   individual lruvecs.
>>>>>>
>>>>>> - And likewise at the beginning of cgroup limit reclaim, walk the
>>>>>>   subtree starting at sc->target_mem_cgroup, sum up the INACTIVE_FILE
>>>>>>   and ACTIVE_FILE counters, and make inactive_is_low() decision on
>>>>>>   those sums.
>>>>>>
>>>>>
>>>>> Sounds reasonable.
>>>>>
>>>>
>>>> On the second thought it seems to be better to keep the decision on lru level.
>>>> There are couple reasons for this:
>>>>
>>>> 1) Using bare node_page_state() (or sc->targe_mem_cgroup's total_[in]active counters) would be wrong.
>>>>  Because some cgroups might have protection set (memory.low) and we must take it into account. Also different
>>>> cgroups have different available swap space/memory.swappiness and it must be taken into account as well to.
>>>>
>>>> So it has to be yet another full memcg-tree iteration.
>>>
>>> It should be possible to take that into account on the first iteration
>>> and adjust the inactive/active counters in proportion to how much of
>>> the cgroup's total memory is exempt by memory.low or min, right?
>>>
>>
>> Should be possible, more complexity though to this subtle code.
>>
>>
>>>> 2) Let's consider simple case. Two cgroups, one with big 'active' set of pages the other allocates one-time used pages.
>>>> So the total inactive is low, thus checking inactive ratio on higher level will result in reclaiming pages.
>>>> While with check on lru-level only inactive will be reclaimed.
>>>
>>> It's the other way around. Let's say you have two cgroups, A and B:
>>>
>>>         A:  500M inactive   10G active -> inactive is low
>>>         B:   10G inactive  500M active -> inactive is NOT low
>>>    ----------------------------------------------------------
>>>    global: 10.5G inactive 10.5G active -> inactive is NOT low
>>>
>>> Checking locally will scan active pages from A.
>>
>> No, checking locally will not scan active from A. Initial state of
>> sc->may_shrink_active = 0, so A group will be skipped completely,
>> and will reclaim from B. Since overall reclaim was successful,
>> sc->may_shrink_active remain 0 and A will be protected as long as B
>> supply enough inactive pages.
> 
> Oh, this was a misunderstanding. When you wrote "on second thought it
> seems to be better to keep the decision at the lru level", I assumed
> you were arguing for keeping the current code as-is and abandoning
> your patch.
> 
> But that leaves my questions from above unanswered. Consider the
> following situation:
> 
>   A: 50M inactive   0 active
>   B:   0 inactive 20G active
> 
> If the processes in A and B were not cgrouped, these pages would be on
> a single LRU and we'd go after B's active pages.
> 
> But with your patches, we'd reclaim only A's inactive pages.
> 

I assume that not cgrouped case we would reclaim mostly from A anyway because going after B's active pages
only means that we move them to inactive list where we still have A's pages for reclaim. And B has a chance
to reactivate deactivated pages.
In cgrouped case going after B's active pages implies immediate reclaim of them.


> What's the justification for that unfairness?
> 
If it's A creates pressure by allocating a lot of one-time used pages,
than global inactive ratio check allows A to grow up to !inactive_is_low() point
by pushing out B's active pages.
