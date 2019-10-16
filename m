Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DFFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3055F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404902AbfJPLNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:13:40 -0400
Received: from foss.arm.com ([217.140.110.172]:36806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404881AbfJPLNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:13:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECFEC28;
        Wed, 16 Oct 2019 04:13:38 -0700 (PDT)
Received: from [10.163.1.216] (unknown [10.163.1.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16BA73F6C4;
        Wed, 16 Oct 2019 04:13:31 -0700 (PDT)
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
Date:   Wed, 16 Oct 2019 16:43:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 04:39 PM, David Hildenbrand wrote:
> On 16.10.19 13:02, Anshuman Khandual wrote:
>> HugeTLB helper alloc_gigantic_page() implements fairly generic allocation
>> method where it scans over various zones looking for a large contiguous pfn
>> range before trying to allocate it with alloc_contig_range(). Other than
>> deriving the requested order from 'struct hstate', there is nothing HugeTLB
>> specific in there. This can be made available for general use to allocate
>> contiguous memory which could not have been allocated through the buddy
>> allocator.
>>
>> alloc_gigantic_page() has been split carving out actual allocation method
>> which is then made available via new alloc_contig_pages() helper wrapped
>> under CONFIG_CONTIG_ALLOC. All references to 'gigantic' have been replaced
>> with more generic term 'contig'. Allocated pages here should be freed with
>> free_contig_range() or by calling __free_page() on each allocated page.
>>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This is based on https://patchwork.kernel.org/patch/11190213/
>>
>> Changes in V2:
>>
>> - Rephrased patch subject per David
>> - Fixed all typos per David
>> - s/order/contiguous
> 
> Just to make sure, you ignored my comment regarding alignment although I explicitly mentioned it a second time? Thanks.

I had asked Michal explicitly what to be included for the respin. Anyways
seems like the previous thread is active again. I am happy to incorporate
anything new getting agreed on there.

- Anshuman
