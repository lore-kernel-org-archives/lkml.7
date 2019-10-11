Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F818ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1563921D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJKGPt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:15:49 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45482 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfJKGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:15:48 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9B6FatW020534
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Oct 2019 15:15:36 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B6FZuR002915;
        Fri, 11 Oct 2019 15:15:36 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B6E396014848;
        Fri, 11 Oct 2019 15:15:35 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9394841; Fri, 11 Oct 2019 15:02:51 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Fri,
 11 Oct 2019 15:02:50 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Thread-Topic: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Thread-Index: AQHVfq1QC/9/3IlYuEK91tWnhgAEnKdRy5KAgAEYjwCAAAI1AIAABLgAgAABxQCAAXH3gA==
Date:   Fri, 11 Oct 2019 06:02:49 +0000
Message-ID: <20191011060249.GA30500@hori.linux.bs1.fc.nec.co.jp>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191009144323.GH6681@dhcp22.suse.cz>
 <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
 <20191010073526.GC18412@dhcp22.suse.cz>
 <18383432-c74a-9ce5-a3c6-1e57d54cb629@redhat.com>
 <52e81b85-c460-5b99-a297-e065caab3a16@redhat.com>
In-Reply-To: <52e81b85-c460-5b99-a297-e065caab3a16@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <89CA1456C580664C8DA0362F03F6C601@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:58:40AM +0200, David Hildenbrand wrote:
> On 10.10.19 09:52, David Hildenbrand wrote:
> > On 10.10.19 09:35, Michal Hocko wrote:
> >> On Thu 10-10-19 09:27:32, David Hildenbrand wrote:
> >>> On 09.10.19 16:43, Michal Hocko wrote:
> >>>> On Wed 09-10-19 16:24:35, David Hildenbrand wrote:
> >>>>> We should check for pfn_to_online_page() to not access uninitialized
> >>>>> memmaps. Reshuffle the code so we don't have to duplicate the error
> >>>>> message.
> >>>>>
> >>>>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>>> Cc: Michal Hocko <mhocko@kernel.org>
> >>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>>> ---
> >>>>>  mm/memory-failure.c | 14 ++++++++------
> >>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>>> index 7ef849da8278..e866e6e5660b 100644
> >>>>> --- a/mm/memory-failure.c
> >>>>> +++ b/mm/memory-failure.c
> >>>>> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
> >>>>>  	if (!sysctl_memory_failure_recovery)
> >>>>>  		panic("Memory failure on page %lx", pfn);
> >>>>>  
> >>>>> -	if (!pfn_valid(pfn)) {
> >>>>> +	p = pfn_to_online_page(pfn);
> >>>>> +	if (!p) {
> >>>>> +		if (pfn_valid(pfn)) {
> >>>>> +			pgmap = get_dev_pagemap(pfn, NULL);
> >>>>> +			if (pgmap)
> >>>>> +				return memory_failure_dev_pagemap(pfn, flags,
> >>>>> +								  pgmap);
> >>>>> +		}
> >>>>>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
> >>>>>  			pfn);
> >>>>>  		return -ENXIO;
> >>>>
> >>>> Don't we need that earlier at hwpoison_inject level?
> >>>>
> >>>
> >>> Theoretically yes, this is another instance. But pfn_to_online_page(pfn)
> >>> alone would not be sufficient as discussed. We would, again, have to
> >>> special-case ZONE_DEVICE via things like get_dev_pagemap() ...
> >>>
> >>> But mm/hwpoison-inject.c:hwpoison_inject() is a pure debug feature either way:
> >>>
> >>> 	/*
> >>> 	 * Note that the below poison/unpoison interfaces do not involve
> >>> 	 * hardware status change, hence do not require hardware support.
> >>> 	 * They are mainly for testing hwpoison in software level.
> >>> 	 */
> >>>
> >>> So it's not that bad compared to memory_failure() called from real HW or
> >>> drivers/base/memory.c:soft_offline_page_store()/hard_offline_page_store()
> >>
> >> Yes, this is just a toy. And yes we need to handle zone device pages
> >> here because a) people likely want to test MCE behavior even on these
> >> pages and b) HW can really trigger MCEs there as well. I was just
> >> pointing that the patch is likely incomplete.
> >>
> > 
> > I rather think this deserves a separate patch as it is a separate
> > interface :)
> > 
> > I do wonder why hwpoison_inject() has to perform so much extra work
> > compared to other memory_failure() users. This smells like legacy
> > leftovers to me, but I might be wrong. The interface is fairly old,
> > though. Does anybody know why we need this magic? I can spot quite some
> > duplicate checks/things getting performed.

It concerns me too, this *is* an old legacy code. I guess it was left as-is
because no one complained about it.  That's not good, so I'll do some cleanup.

> > 
> > Naiive me would just make the interface perform the same as
> > hard_offline_page_store(). But most probably I am not getting the real
> > purpose of both different interfaces.

Maybe for historical reason, we have these slightly different interfaces:

- corrupt-pfn
  - purely for debugging purpose
  - paired with unpoison-pfn
  - used by in-kernel tool tools/vm/page-types.c
- hard_offline_page
  - paired with soft_offline_page
  - used by other userspace tools like mcelog

But these don't explain why implemented differently, so I think that both
should be written in the same manner.

> > 
> > HWPOISON_INJECT is only selected for DEBUG_KERNEL, so I would have
> > guessed that fixing this is not urgent.
> > 
> > BTW: mm/memory-failure.c:soft_offline_page() also looks wrong and needs
> > fixing to make sure we access initialized memmaps.
> > 
> 
> To be more precise, soft_offline_page_store() needs a
> pfn_to_online_page() check. Will send a patch.

Thanks for finding this.

- Naoya Horiguchi
