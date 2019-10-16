Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74462FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530D22067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405665AbfJPN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404448AbfJPN7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9111B800DF2;
        Wed, 16 Oct 2019 13:59:07 +0000 (UTC)
Received: from [10.36.116.19] (ovpn-116-19.ams2.redhat.com [10.36.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B166D60C5D;
        Wed, 16 Oct 2019 13:59:01 +0000 (UTC)
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
 <bd38d88d-19a7-275a-386d-f37cb76a3390@redhat.com>
 <20191016134519.GC317@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <50ee63c0-9d0b-0479-a5b9-494e4bc00446@redhat.com>
Date:   Wed, 16 Oct 2019 15:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016134519.GC317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 16 Oct 2019 13:59:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 15:45, Michal Hocko wrote:
> On Wed 16-10-19 14:50:30, David Hildenbrand wrote:
>> On 16.10.19 13:43, Michal Hocko wrote:
>>> On Thu 19-09-19 16:22:25, David Hildenbrand wrote:
>>>> virtio-mem wants to allow to offline memory blocks of which some parts
>>>> were unplugged, especially, to later offline and remove completely
>>>> unplugged memory blocks. The important part is that PageOffline() has
>>>> to remain set until the section is offline, so these pages will never
>>>> get accessed (e.g., when dumping). The pages should not be handed
>>>> back to the buddy (which would require clearing PageOffline() and
>>>> result in issues if offlining fails and the pages are suddenly in the
>>>> buddy).
>>>>
>>>> Let's use "PageOffline() + reference count = 0" as a sign to
>>>> memory offlining code that these pages can simply be skipped when
>>>> offlining, similar to free or HWPoison pages.
>>>>
>>>> Pass flags to test_pages_isolated(), similar as already done for
>>>> has_unmovable_pages(). Use a new flag to indicate the
>>>> requirement of memory offlining to skip over these special pages.
>>>>
>>>> In has_unmovable_pages(), make sure the pages won't be detected as
>>>> movable. This is not strictly necessary, however makes e.g.,
>>>> alloc_contig_range() stop early, trying to isolate such page blocks -
>>>> compared to failing later when testing if all pages were isolated.
>>>>
>>>> Also, make sure that when a reference to a PageOffline() page is
>>>> dropped, that the page will not be returned to the buddy.
>>>>
>>>> memory devices (like virtio-mem) that want to make use of this
>>>> functionality have to make sure to synchronize against memory offlining,
>>>> using the memory hotplug notifier.
>>>>
>>>> Alternative: Allow to offline with a reference count of 1
>>>> and use some other sign in the struct page that offlining is permitted.
>>>
>>> Few questions. I do not see onlining code to take care of this special
>>> case. What should happen when offline && online?
>>
>> Once offline, the memmap is garbage. When onlining again:
>>
>> a) memmap will be re-initialized
>> b) online_page_callback_t will be called for every page in the section. The
>> driver can mark them offline again and not give them to the buddy.
>> c) section will be marked online.
> 
> But we can skip those pages when onlining and keep them in the offline
> state right? We do not poison offlined pages.

https://lkml.org/lkml/2019/10/6/60

But  again, onlining will overwrite the whole memmap right now and there 
is no way to identify if a memmap contains garbage or not.

We would have to identify/remember if re-onlining, but I am not yet sure 
if re-using memmaps when onlining is such a good idea ...

-- 

Thanks,

David / dhildenb
