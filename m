Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBCC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6727520873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571060181;
	bh=l2qUNwt7FFr1rsxxvdpk7Mw7GWepspqDclg4wIz8fgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rcegHjBAuXB/aysqgRIC654U64+vKN/kuU/0xTEHcw0KSijUDOQFXRU/kZm7DBal2
	 9p/MfkrI6Zk0bG+4h8mRt2ANyqRUXc+cxrq3FW6xad6nCIhBmZhle5N3Bsjs6h9dM8
	 +gNgG0kDQtT2uenDYc+WR+ykYA0u310Obi3zDMTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfJNNgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:36:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfJNNgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:36:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E94CBEBD;
        Mon, 14 Oct 2019 13:36:18 +0000 (UTC)
Date:   Mon, 14 Oct 2019 15:36:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Message-ID: <20191014133617.GJ317@dhcp22.suse.cz>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191009144323.GH6681@dhcp22.suse.cz>
 <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
 <20191010073526.GC18412@dhcp22.suse.cz>
 <18383432-c74a-9ce5-a3c6-1e57d54cb629@redhat.com>
 <52e81b85-c460-5b99-a297-e065caab3a16@redhat.com>
 <20191011060249.GA30500@hori.linux.bs1.fc.nec.co.jp>
 <3706d642-6c29-41b8-a676-1b5541af3169@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3706d642-6c29-41b8-a676-1b5541af3169@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Oscar]

On Fri 11-10-19 12:13:17, David Hildenbrand wrote:
> On 11.10.19 08:02, Naoya Horiguchi wrote:
> > On Thu, Oct 10, 2019 at 09:58:40AM +0200, David Hildenbrand wrote:
> >> On 10.10.19 09:52, David Hildenbrand wrote:
> >>> On 10.10.19 09:35, Michal Hocko wrote:
> >>>> On Thu 10-10-19 09:27:32, David Hildenbrand wrote:
> >>>>> On 09.10.19 16:43, Michal Hocko wrote:
> >>>>>> On Wed 09-10-19 16:24:35, David Hildenbrand wrote:
> >>>>>>> We should check for pfn_to_online_page() to not access uninitialized
> >>>>>>> memmaps. Reshuffle the code so we don't have to duplicate the error
> >>>>>>> message.
> >>>>>>>
> >>>>>>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
> >>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>>>>> ---
> >>>>>>>   mm/memory-failure.c | 14 ++++++++------
> >>>>>>>   1 file changed, 8 insertions(+), 6 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>>>>> index 7ef849da8278..e866e6e5660b 100644
> >>>>>>> --- a/mm/memory-failure.c
> >>>>>>> +++ b/mm/memory-failure.c
> >>>>>>> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
> >>>>>>>   	if (!sysctl_memory_failure_recovery)
> >>>>>>>   		panic("Memory failure on page %lx", pfn);
> >>>>>>>   
> >>>>>>> -	if (!pfn_valid(pfn)) {
> >>>>>>> +	p = pfn_to_online_page(pfn);
> >>>>>>> +	if (!p) {
> >>>>>>> +		if (pfn_valid(pfn)) {
> >>>>>>> +			pgmap = get_dev_pagemap(pfn, NULL);
> >>>>>>> +			if (pgmap)
> >>>>>>> +				return memory_failure_dev_pagemap(pfn, flags,
> >>>>>>> +								  pgmap);
> >>>>>>> +		}
> >>>>>>>   		pr_err("Memory failure: %#lx: memory outside kernel control\n",
> >>>>>>>   			pfn);
> >>>>>>>   		return -ENXIO;
> >>>>>>
> >>>>>> Don't we need that earlier at hwpoison_inject level?
> >>>>>>
> >>>>>
> >>>>> Theoretically yes, this is another instance. But pfn_to_online_page(pfn)
> >>>>> alone would not be sufficient as discussed. We would, again, have to
> >>>>> special-case ZONE_DEVICE via things like get_dev_pagemap() ...
> >>>>>
> >>>>> But mm/hwpoison-inject.c:hwpoison_inject() is a pure debug feature either way:
> >>>>>
> >>>>> 	/*
> >>>>> 	 * Note that the below poison/unpoison interfaces do not involve
> >>>>> 	 * hardware status change, hence do not require hardware support.
> >>>>> 	 * They are mainly for testing hwpoison in software level.
> >>>>> 	 */
> >>>>>
> >>>>> So it's not that bad compared to memory_failure() called from real HW or
> >>>>> drivers/base/memory.c:soft_offline_page_store()/hard_offline_page_store()
> >>>>
> >>>> Yes, this is just a toy. And yes we need to handle zone device pages
> >>>> here because a) people likely want to test MCE behavior even on these
> >>>> pages and b) HW can really trigger MCEs there as well. I was just
> >>>> pointing that the patch is likely incomplete.
> >>>>
> >>>
> >>> I rather think this deserves a separate patch as it is a separate
> >>> interface :)
> >>>
> >>> I do wonder why hwpoison_inject() has to perform so much extra work
> >>> compared to other memory_failure() users. This smells like legacy
> >>> leftovers to me, but I might be wrong. The interface is fairly old,
> >>> though. Does anybody know why we need this magic? I can spot quite some
> >>> duplicate checks/things getting performed.
> > 
> > It concerns me too, this *is* an old legacy code. I guess it was left as-is
> > because no one complained about it.  That's not good, so I'll do some cleanup.
> 
> Most of that stuff was introduced in
> 
> commit 31d3d3484f9bd263925ecaa341500ac2df3a5d9b
> Author: Wu Fengguang <fengguang.wu@intel.com>
> Date:   Wed Dec 16 12:19:59 2009 +0100
> 
>      HWPOISON: limit hwpoison injector to known page types
> 
>      __memory_failure()'s workflow is
> 
>              set PG_hwpoison
>              //...
>              unset PG_hwpoison if didn't pass hwpoison filter
> 
>      That could kill unrelated process if it happens to page fault on the
>      page with the (temporary) PG_hwpoison. The race should be big enough to
>      appear in stress tests.
> 
>      Fix it by grabbing the page and checking filter at inject time.  This
>      also avoids the very noisy "Injecting memory failure..." messages.
> 
> 
> Now, we still have the same "issue" in memory_failure() today:
> 
> 
> 	if (TestSetPageHWPoison(p)) {
> 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
> 			pfn);
> 		return 0;
> 	}
> [...]
> 	if (hwpoison_filter(p)) {
> 		if (TestClearPageHWPoison(p))
> 			num_poisoned_pages_dec();
> 		unlock_page(p);
> 		put_hwpoison_page(p);
> 		return 0;
> 	}
> 
> However, I don't understand why we need that special handling only for this
> debug interface and not the other users.
> 
> I'd vote for ripping out that legacy crap (so the interface works correctly
> with ZONE_DEVICE) and instead (if really required) rework memory_failure()
> to not produce such side effects.

I do agree. The two should be really using the same code. My
understanding was that MADV_HWPOISON was there to test the actual MCE
behavior (and the man page seems to agree with that).

Oscar is working on a rewrite. Not sure he has considered this as well.
-- 
Michal Hocko
SUSE Labs
