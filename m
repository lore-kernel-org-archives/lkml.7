Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A872D21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395304AbfJRIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391232AbfJRIul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3CE38A1C95;
        Fri, 18 Oct 2019 08:50:39 +0000 (UTC)
Received: from [10.36.118.57] (unknown [10.36.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2F1819C77;
        Fri, 18 Oct 2019 08:50:25 +0000 (UTC)
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
 a reference count of 0
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-7-david@redhat.com>
 <20191016114321.GX317@dhcp22.suse.cz>
 <36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
 <20191016140350.GD317@dhcp22.suse.cz>
 <7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
 <20191018081524.GD5017@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
Date:   Fri, 18 Oct 2019 10:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018081524.GD5017@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 18 Oct 2019 08:50:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.19 10:15, Michal Hocko wrote:
> On Wed 16-10-19 16:14:52, David Hildenbrand wrote:
>> On 16.10.19 16:03, Michal Hocko wrote:
> [...]
>>> But why cannot you keep the reference count at 1 (do get_page when
>>> offlining the page)? In other words as long as the driver knows the page
>>> has been returned to the host then it has ref count at 1. Once the page
>>> is returned to the guest for whatever reason it can free it to the
>>> system by clearing the offline state and put_page.
>>
>> I think I explained how the reference count of 1 is problematic when wanting
>> to offline the memory. After all that's the problem I try to solve: Keep
>> PG_offline set until the memory is offline and make sure nobody will touch
>> the page.
> 
> Please bear with me but I still believe that elevated reference count
> has some merits. I do understand that you maintain your metadata to
> recognize that the memory handed over to the hypervisor will not
> magically appear after onlining. But I believe that you can achieve
> the same with an elevated reference count and have a more robust design
> as well.

Thanks for thinking about this. I still believe it is problematic. And I 
don't like releasing "pages that should not be used" to the buddy. It 
comes with some problems if offlining fails (see below).

> 
> Let's say that you still keep a reference to your offlined pages and
> mark them offlined. That should make sure that no consumer of the
> pfn_to_online_page will touch the page's content nor the state. Now

pfn_to_online_page() does not check against PG_offline. (which is 
correct IMHO. As documented, PG_offline means "logically offline".

The memmap is valid, however the page content should not be accessed. 
(PG_logically_offline would have been ugly ;) ).

But that shouldn't be an issue right now.

> admin might want to offline/hotremove the whole memory block via sysfs.

The admin can only trigger offlining via sysfs. Hotremove is under 
control of the driver. (removing the whole memory block)

And with the current virtio-mem prototype, this works like a charm.

> An elevated reference count would prevent offlining to finish. And I
> believe this is a good thing because the owner of the offline page might
> still need to do something to "untrack" that page. We have an interface

And here is the thing: The owner of the page does not have to do 
anything to untrack the page. I mean that's what a reference count of 
zero actually means - no direct reference.

I could emphasize how this is to be used in the documentation:

PageOffline() pages that have a reference count of 0 will be treated
like free pages when offlining pages, allowing the containing memory
block to get offlined. In case a driver wants to revive such a page, it 
has to synchronize against memory onlining/offlining (e.g., using memory 
notifiers) while incrementing the reference count. Also, a driver that 
relies in this feature is aware that re-onlining the memory will require 
to re-set the pages PageOffline() - e.g., via the online_page_callback_t.


> for that - MEM_GOING_OFFLINE notification. This sounds like a good place
> for the driver to decide whether it is safe to let the page go or not.

As I explained, this is too late and fragile. I post again what I posted 
before with some further explanations

__offline_pages() works like this:

1) start_isolate_page_range()
-> offline pages with a reference count of one will be detected as
unmovable -> offlining aborted. (see below on the memory isolation notifier)

2) memory_notify(MEM_GOING_OFFLINE, &arg);
-> Here, we could release all pages to the buddy, clearing PG_offline
-> PF_offline must not be cleared so dumping tools will not touch
    these pages. There is a time where pages are !PageBuddy() and
    !PageOffline().

3) scan_movable_pages() ...

4a) Memory offlining succeeded: memory_notify(MEM_OFFLINE, &arg);

Perfect, it worked. Sections are offline.

4b) Memory offlining failed

     undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
     memory_notify(MEM_CANCEL_OFFLINE, &arg);

-> Offlining failed for whatever reason. Once we reach the notifier, the
    pages are already back in use by the buddy.
-> Pages are in the buddy, they are no longer under control of the
    driver.


To summarize the important parts

1. PG_offline has to remain set until the section is offline.

2. When we reach MEM_GOING_OFFLINE, it is too late. The pages were 
already detected as unmovable.

3. When we release pages that are supposed to be PG_offline to the buddy 
and offlining fails, we are in big trouble.


> If you can let the page go then just drop the reference count. The page
> is isolated already by that time. If you cannot let it go for whatever
> reason you can fail the offlining.

We do have one hack in current MM code, which is the memory isolation 
notifier only used by CMM on PPC. It allows to "cheat" 
has_unmovable_pages() to skip over unmovable pages. But quite frankly, I 
rather want to get rid of that crap (something I am working on right 
now) than introduce new users. This stuff is racy as hell and for CMM, 
if memory offlining fails, the ballooned pages are suddenly part of the 
buddy. Fragile.

> 
> An advantage is that the driver has the full control over offlining and
> also you do not really have to track a new online request to do the
> right thing.

The driver still has to synchronize against onlining/offlining requests 
and track the state of the memory blocks.

Simple example: virtio-mem wants to try yo unplug a 4MB chunk. If the 
memory block is online, it has to use alloc contig_range(). If the 
memory block is offline (e.g., user space has not onlined it yet), it is 
sufficient to update metadata. It has to be aware of the state of the 
memory blocks and synchronize against onlining/offlining.

> 
> Or do I still see it too simplistically and the notifier is not a good
> place to handle the reference count?

Yes :) I could hack something via the memory isolation notifier (which 
is ugly) and MEM_GOING_OFFLINE. But if offlining fails, the pages are in 
the buddy and the driver lost control (which is one issue with PPC CMA 
implementation right now).

Again, I think routing pages via the buddy is the problematic part. (if 
offlining fails, but also the period where the pages are neither 
PageBuddy() nor PageOffline()))


-- 

Thanks,

David / dhildenb
