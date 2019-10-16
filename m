Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0ACFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90B220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394160AbfJPPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:31:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJPPbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:31:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB43D142F;
        Wed, 16 Oct 2019 08:31:11 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFE353F68E;
        Wed, 16 Oct 2019 08:31:07 -0700 (PDT)
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
Date:   Wed, 16 Oct 2019 21:01:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191016124149.GB317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 06:11 PM, Michal Hocko wrote:
> On Wed 16-10-19 14:29:05, David Hildenbrand wrote:
>> On 16.10.19 13:51, Michal Hocko wrote:
>>> On Wed 16-10-19 16:43:57, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 10/16/2019 04:39 PM, David Hildenbrand wrote:
>>> [...]
>>>>> Just to make sure, you ignored my comment regarding alignment
>>>>> although I explicitly mentioned it a second time? Thanks.
>>>>
>>>> I had asked Michal explicitly what to be included for the respin. Anyways
>>>> seems like the previous thread is active again. I am happy to incorporate
>>>> anything new getting agreed on there.
>>>
>>> Your patch is using the same alignment as the original code would do. If
>>> an explicit alignement is needed then this can be added on top, right?
>>>
>>
>> Again, the "issue" I see here is that we could now pass in numbers that are
>> not a power of two. For gigantic pages it was clear that we always have a
>> number of two. The alignment does not make any sense otherwise.

ALIGN() does expect nr_pages two be power of two otherwise the mask
value might not be correct, affecting start pfn value for a zone.

#define ALIGN(x, a)             	__ALIGN_KERNEL((x), (a))
#define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
#define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))

>>
>> What I'm asking for is
>>
>> a) Document "The resulting PFN is aligned to nr_pages" and "nr_pages should
>> be a power of two".
> 
> OK, this makes sense.
Sure, will add this to the alloc_contig_pages() helper description and
in the commit message as well.

> 
>> b) Eventually adding something like
>>
>> if (WARN_ON_ONCE(!is_power_of_2(nr_pages)))
>> 	return NULL;
> 
> I am not sure this is really needed.
> 
Just wondering why not ? Ideally if we are documenting that nr_pages should be
power of two, then we should abort erring allocation request with an warning. Is
it because allocation can still succeed for non-power-of-two requests despite
possible problem with mask and alignment ? Hence there is no need to abort it.
