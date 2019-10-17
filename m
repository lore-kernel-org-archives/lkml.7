Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB5ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E11020872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404522AbfJQDTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:19:36 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58184 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfJQDTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:19:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D345337;
        Wed, 16 Oct 2019 20:19:13 -0700 (PDT)
Received: from [10.162.40.130] (p8cg001049571a15.blr.arm.com [10.162.40.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA733F718;
        Wed, 16 Oct 2019 20:19:07 -0700 (PDT)
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <0ce85182-e00c-8748-32f7-89c30b3be35b@oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e13eb7ca-7f2e-5bf8-1f9f-672d65d12b5e@arm.com>
Date:   Thu, 17 Oct 2019 08:49:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0ce85182-e00c-8748-32f7-89c30b3be35b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2019 06:20 AM, Mike Kravetz wrote:
> On 10/16/19 4:02 AM, Anshuman Khandual wrote:
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
> 
> I had a 'test harness' used when previously working on such an interface.
> It simply provides a user interface to call the allocator with random
> values for nr_pages.  Several tasks are then started doing random allocations
> in parallel.  The new interface is pretty straight forward, but the idea
> was to stress the underlying code.  In fact, it did identify issues with
> isolation which were corrected.
> 
> I exercised this new interface in the same way and am happy to report that
> no issues were detected.

Cool, thanks Mike.
