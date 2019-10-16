Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BCFFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAF121848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393849AbfJPOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390615AbfJPOQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D78BA3D3C;
        Wed, 16 Oct 2019 14:16:15 +0000 (UTC)
Received: from [10.36.116.19] (ovpn-116-19.ams2.redhat.com [10.36.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2AA1001925;
        Wed, 16 Oct 2019 14:16:10 +0000 (UTC)
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
 <2aef8477-7d12-63a8-e273-9eae8712d5c2@redhat.com>
 <20191016140958.GE317@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f2ca2396-8aae-842c-91f5-84c3e0fae70e@redhat.com>
Date:   Wed, 16 Oct 2019 16:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016140958.GE317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Oct 2019 14:16:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 16:09, Michal Hocko wrote:
> On Wed 16-10-19 15:55:00, David Hildenbrand wrote:
>> On 16.10.19 15:45, Michal Hocko wrote:
> [...]
>>> There is state stored in the struct page. In other words this shouldn't
>>> be really different from HWPoison pages. I cannot find the code that is
>>> doing that and maybe we don't handle that. But we cannot simply online
>>> hwpoisoned page. Offlining the range will not make a broken memory OK
>>> all of the sudden. And your usecase sounds similar to me.
>>
>> Sorry to say, but whenever we online memory the memmap is overwritten,
>> because there is no way you could tell it contains garbage or not. You have
>> to assume it is garbage. (my recent patch even poisons the memmap when
>> offlining, which helped to find a lot of these "garbage memmap" BUGs)
>>
>> online_pages()
>> 	...
>> 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL);
>> 	...
>> 		memmap_init_zone()
>> 			-> memmap initialized
>>
>> So yes, offlining memory with HWPoison and re-onlining it effectively drops
>> HWPoison markers. On the next access, you will trigger a new HWPoison.
> 
> Right you are! I need to sit on this much more and think about it with a
> clean head.
> 

Sure, take your time and let me know if you need any details on how 
virtio-mem works, how it uses these interfaces, and how the mm internals 
it uses play along.

Thanks Michal!

-- 

Thanks,

David / dhildenb
