Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898FAFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C862168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406429AbfJPQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404582AbfJPQsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:48:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75A6018C890F;
        Wed, 16 Oct 2019 16:48:41 +0000 (UTC)
Received: from [10.36.116.53] (ovpn-116-53.ams2.redhat.com [10.36.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 699C56CE5A;
        Wed, 16 Oct 2019 16:48:38 +0000 (UTC)
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
 <20191016115119.GA317@dhcp22.suse.cz>
 <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
 <20191016124149.GB317@dhcp22.suse.cz>
 <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e37c16f5-7068-5359-a539-bee58e705122@redhat.com>
Date:   Wed, 16 Oct 2019 18:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 16 Oct 2019 16:48:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 17:31, Anshuman Khandual wrote:
> 
> 
> On 10/16/2019 06:11 PM, Michal Hocko wrote:
>> On Wed 16-10-19 14:29:05, David Hildenbrand wrote:
>>> On 16.10.19 13:51, Michal Hocko wrote:
>>>> On Wed 16-10-19 16:43:57, Anshuman Khandual wrote:
>>>>>
>>>>>
>>>>> On 10/16/2019 04:39 PM, David Hildenbrand wrote:
>>>> [...]
>>>>>> Just to make sure, you ignored my comment regarding alignment
>>>>>> although I explicitly mentioned it a second time? Thanks.
>>>>>
>>>>> I had asked Michal explicitly what to be included for the respin. Anyways
>>>>> seems like the previous thread is active again. I am happy to incorporate
>>>>> anything new getting agreed on there.
>>>>
>>>> Your patch is using the same alignment as the original code would do. If
>>>> an explicit alignement is needed then this can be added on top, right?
>>>>
>>>
>>> Again, the "issue" I see here is that we could now pass in numbers that are
>>> not a power of two. For gigantic pages it was clear that we always have a
>>> number of two. The alignment does not make any sense otherwise.
> 
> ALIGN() does expect nr_pages two be power of two otherwise the mask
> value might not be correct, affecting start pfn value for a zone.
> 
> #define ALIGN(x, a)             	__ALIGN_KERNEL((x), (a))
> #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
> 
>>>
>>> What I'm asking for is
>>>
>>> a) Document "The resulting PFN is aligned to nr_pages" and "nr_pages should
>>> be a power of two".
>>
>> OK, this makes sense.
> Sure, will add this to the alloc_contig_pages() helper description and
> in the commit message as well.

As long as it is documented that implicit alignment will happen, fine 
with me.

The thing about !is_power_of2() is that we usually don't need an 
alignment there (or instead an explicit one). And as I mentioned, the 
current function might fail easily to allocate a suitable range due to 
the way the search works (== check aligned blocks only). The search 
really only provides reliable results when size==alignment and it's a 
power of two IMHO. Not documenting that is in my opinion misleading - 
somebody who wants !is_power_of2() and has no alignment requirements 
should probably rework the function first.

So with some documentation regarding that

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
