Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D85C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C620820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438312AbfJQHix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:38:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfJQHix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:38:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F507308624A;
        Thu, 17 Oct 2019 07:38:52 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76B9D600C4;
        Thu, 17 Oct 2019 07:38:49 +0000 (UTC)
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
References: <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
 <20191016115119.GA317@dhcp22.suse.cz>
 <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
 <20191016124149.GB317@dhcp22.suse.cz>
 <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
 <e37c16f5-7068-5359-a539-bee58e705122@redhat.com>
 <c60b9e95-5c6c-fcb2-c8bb-13e7646ba8ea@arm.com>
 <20191017071129.GB24485@dhcp22.suse.cz>
 <bfc3b281-79d1-1d8f-337d-c01acc29ab30@redhat.com>
 <20191017073413.GC24485@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <31505b6d-1c09-4fcc-a079-3fbb3c96da48@redhat.com>
Date:   Thu, 17 Oct 2019 09:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017073413.GC24485@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 17 Oct 2019 07:38:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.19 09:34, Michal Hocko wrote:
> On Thu 17-10-19 09:21:24, David Hildenbrand wrote:
>> On 17.10.19 09:11, Michal Hocko wrote:
>>> On Thu 17-10-19 10:44:41, Anshuman Khandual wrote:
>>> [...]
>>>> Does this add-on documentation look okay ? Should we also mention about the
>>>> possible reduction in chances of success during pfn block search for the
>>>> non-power-of-two cases as the implicit alignment will probably turn out to
>>>> be bigger than nr_pages itself ?
>>>>
>>>>    * Requested nr_pages may or may not be power of two. The search for suitable
>>>>    * memory range in a zone happens in nr_pages aligned pfn blocks. But in case
>>>>    * when nr_pages is not power of two, an implicitly aligned pfn block search
>>>>    * will happen which in turn will impact allocated memory block's alignment.
>>>>    * In these cases, the size (i.e nr_pages) and the alignment of the allocated
>>>>    * memory will be different. This problem does not exist when nr_pages is power
>>>>    * of two where the size and the alignment of the allocated memory will always
>>>>    * be nr_pages.
>>>
>>> I dunno, it sounds more complicated than really necessary IMHO. Callers
>>> shouldn't really be bothered by memory blocks and other really deep
>>> implementation details.. Wouldn't be the below sufficient?
>>>
>>> The allocated memory is always aligned to a page boundary. If nr_pages
>>> is a power of two then the alignement is guaranteed to be to the given
>>
>> s/alignement/alignment/
>>
>> and "the PFN is guaranteed to be aligned to nr_pages" (the address is
>> aligned to nr_pages*PAGE_SIZE)
> 
> thx for the correction.
> 
>>> nr_pages (e.g. 1GB request would be aligned to 1GB).
>>>
>>
>> I'd probably add "This function will miss allocation opportunities if
>> nr_pages is not a power of two (and the implicit alignment is bogus)."
> 
> This is again an implementation detail and quite a confusing one to
> whoever not familiar with the MM internals. And to be fair even a proper
> alignment doesn't give you any stronger guarantee as long as the
> allocation operates on non movable zones anyway.
> 

To be honest, I'd not suggest to anyone to use this function with 
nr_pages not being a power of two, and I already explained why. I prefer 
to spill that out than having people complain afterwards. Yes it's an 
implementation detail users should be aware of until reworked.

But I think we talked about this here for way too long, so I am fine 
with either.

-- 

Thanks,

David / dhildenb
