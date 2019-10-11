Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0359DECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF452190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfJKKNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfJKKNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B76203004E5B;
        Fri, 11 Oct 2019 10:13:19 +0000 (UTC)
Received: from [10.36.118.168] (unknown [10.36.118.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8606F5D6C8;
        Fri, 11 Oct 2019 10:13:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191009144323.GH6681@dhcp22.suse.cz>
 <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
 <20191010073526.GC18412@dhcp22.suse.cz>
 <18383432-c74a-9ce5-a3c6-1e57d54cb629@redhat.com>
 <52e81b85-c460-5b99-a297-e065caab3a16@redhat.com>
 <20191011060249.GA30500@hori.linux.bs1.fc.nec.co.jp>
Organization: Red Hat GmbH
Message-ID: <3706d642-6c29-41b8-a676-1b5541af3169@redhat.com>
Date:   Fri, 11 Oct 2019 12:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011060249.GA30500@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 11 Oct 2019 10:13:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.19 08:02, Naoya Horiguchi wrote:
> On Thu, Oct 10, 2019 at 09:58:40AM +0200, David Hildenbrand wrote:
>> On 10.10.19 09:52, David Hildenbrand wrote:
>>> On 10.10.19 09:35, Michal Hocko wrote:
>>>> On Thu 10-10-19 09:27:32, David Hildenbrand wrote:
>>>>> On 09.10.19 16:43, Michal Hocko wrote:
>>>>>> On Wed 09-10-19 16:24:35, David Hildenbrand wrote:
>>>>>>> We should check for pfn_to_online_page() to not access uninitialized
>>>>>>> memmaps. Reshuffle the code so we don't have to duplicate the error
>>>>>>> message.
>>>>>>>
>>>>>>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>> ---
>>>>>>>   mm/memory-failure.c | 14 ++++++++------
>>>>>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>>> index 7ef849da8278..e866e6e5660b 100644
>>>>>>> --- a/mm/memory-failure.c
>>>>>>> +++ b/mm/memory-failure.c
>>>>>>> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>>>   	if (!sysctl_memory_failure_recovery)
>>>>>>>   		panic("Memory failure on page %lx", pfn);
>>>>>>>   
>>>>>>> -	if (!pfn_valid(pfn)) {
>>>>>>> +	p = pfn_to_online_page(pfn);
>>>>>>> +	if (!p) {
>>>>>>> +		if (pfn_valid(pfn)) {
>>>>>>> +			pgmap = get_dev_pagemap(pfn, NULL);
>>>>>>> +			if (pgmap)
>>>>>>> +				return memory_failure_dev_pagemap(pfn, flags,
>>>>>>> +								  pgmap);
>>>>>>> +		}
>>>>>>>   		pr_err("Memory failure: %#lx: memory outside kernel control\n",
>>>>>>>   			pfn);
>>>>>>>   		return -ENXIO;
>>>>>>
>>>>>> Don't we need that earlier at hwpoison_inject level?
>>>>>>
>>>>>
>>>>> Theoretically yes, this is another instance. But pfn_to_online_page(pfn)
>>>>> alone would not be sufficient as discussed. We would, again, have to
>>>>> special-case ZONE_DEVICE via things like get_dev_pagemap() ...
>>>>>
>>>>> But mm/hwpoison-inject.c:hwpoison_inject() is a pure debug feature either way:
>>>>>
>>>>> 	/*
>>>>> 	 * Note that the below poison/unpoison interfaces do not involve
>>>>> 	 * hardware status change, hence do not require hardware support.
>>>>> 	 * They are mainly for testing hwpoison in software level.
>>>>> 	 */
>>>>>
>>>>> So it's not that bad compared to memory_failure() called from real HW or
>>>>> drivers/base/memory.c:soft_offline_page_store()/hard_offline_page_store()
>>>>
>>>> Yes, this is just a toy. And yes we need to handle zone device pages
>>>> here because a) people likely want to test MCE behavior even on these
>>>> pages and b) HW can really trigger MCEs there as well. I was just
>>>> pointing that the patch is likely incomplete.
>>>>
>>>
>>> I rather think this deserves a separate patch as it is a separate
>>> interface :)
>>>
>>> I do wonder why hwpoison_inject() has to perform so much extra work
>>> compared to other memory_failure() users. This smells like legacy
>>> leftovers to me, but I might be wrong. The interface is fairly old,
>>> though. Does anybody know why we need this magic? I can spot quite some
>>> duplicate checks/things getting performed.
> 
> It concerns me too, this *is* an old legacy code. I guess it was left as-is
> because no one complained about it.  That's not good, so I'll do some cleanup.

Most of that stuff was introduced in

commit 31d3d3484f9bd263925ecaa341500ac2df3a5d9b
Author: Wu Fengguang <fengguang.wu@intel.com>
Date:   Wed Dec 16 12:19:59 2009 +0100

     HWPOISON: limit hwpoison injector to known page types

     __memory_failure()'s workflow is

             set PG_hwpoison
             //...
             unset PG_hwpoison if didn't pass hwpoison filter

     That could kill unrelated process if it happens to page fault on the
     page with the (temporary) PG_hwpoison. The race should be big enough to
     appear in stress tests.

     Fix it by grabbing the page and checking filter at inject time.  This
     also avoids the very noisy "Injecting memory failure..." messages.


Now, we still have the same "issue" in memory_failure() today:


	if (TestSetPageHWPoison(p)) {
		pr_err("Memory failure: %#lx: already hardware poisoned\n",
			pfn);
		return 0;
	}
[...]
	if (hwpoison_filter(p)) {
		if (TestClearPageHWPoison(p))
			num_poisoned_pages_dec();
		unlock_page(p);
		put_hwpoison_page(p);
		return 0;
	}

However, I don't understand why we need that special handling only for this
debug interface and not the other users.

I'd vote for ripping out that legacy crap (so the interface works correctly
with ZONE_DEVICE) and instead (if really required) rework memory_failure()
to not produce such side effects.

> 
>>>
>>> Naiive me would just make the interface perform the same as
>>> hard_offline_page_store(). But most probably I am not getting the real
>>> purpose of both different interfaces.
> 
> Maybe for historical reason, we have these slightly different interfaces:
> 
> - corrupt-pfn
>    - purely for debugging purpose
>    - paired with unpoison-pfn
>    - used by in-kernel tool tools/vm/page-types.c
> - hard_offline_page
>    - paired with soft_offline_page
>    - used by other userspace tools like mcelog
> 
> But these don't explain why implemented differently, so I think that both
> should be written in the same manner.
> 
>>>
>>> HWPOISON_INJECT is only selected for DEBUG_KERNEL, so I would have
>>> guessed that fixing this is not urgent.
>>>
>>> BTW: mm/memory-failure.c:soft_offline_page() also looks wrong and needs
>>> fixing to make sure we access initialized memmaps.
>>>
>>
>> To be more precise, soft_offline_page_store() needs a
>> pfn_to_online_page() check. Will send a patch.
> 
> Thanks for finding this.
> 
> - Naoya Horiguchi
> 


-- 

Thanks,

David / dhildenb
