Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE5CFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0420872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392439AbfJPKlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:41:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfJPKlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA23F81F0D;
        Wed, 16 Oct 2019 10:41:50 +0000 (UTC)
Received: from [10.36.117.237] (ovpn-117-237.ams2.redhat.com [10.36.117.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE82C5C1D8;
        Wed, 16 Oct 2019 10:41:44 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
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
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <20191016085839.GP317@dhcp22.suse.cz>
 <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <77d835fd-91e7-4405-d252-26f565b0f1a1@redhat.com>
Date:   Wed, 16 Oct 2019 12:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 16 Oct 2019 10:41:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 12:28, Anshuman Khandual wrote:
> 
> 
> On 10/16/2019 02:28 PM, Michal Hocko wrote:
>> On Wed 16-10-19 13:04:53, Anshuman Khandual wrote:
>>> HugeTLB helper alloc_gigantic_page() implements fairly generic allocation
>>> method where it scans over various zones looking for a large contiguous pfn
>>> range before trying to allocate it with alloc_contig_range(). Other than
>>> deriving the requested order from 'struct hstate', there is nothing HugeTLB
>>> specific in there. This can be made available for general use to allocate
>>> contiguous memory which could not have been allocated through the buddy
>>> allocator.
>>>
>>> alloc_gigantic_page() has been split carving out actual allocation method
>>> which is then made available via new alloc_contig_pages() helper wrapped
>>> under CONFIG_CONTIG_ALLOC. All references to 'gigantic' have been replaced
>>> with more generic term 'contig'. Allocated pages here should be freed with
>>> free_contig_range() or by calling __free_page() on each allocated page.
>>
>> Do we want to export this to modules? Apart from mostly styling issues
>> pointed by David this looks fine.
>>
>> I do agree that a general allocator api belongs to page_alloc.c rather
>> than force people to invent their own and broken instances.
>>   
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: David Rientjes <rientjes@google.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> After other issues mentioned by David get resolved you can add
> 
> Just to confirm. Only the styling issues, right ? pfn_range_valid_contig(),
> pfn alignment and zone scanning all remain the same like before ?
> 

Fine with me. Please do think about the alignment thingy. (I suggest to 
just enforce an alignment to a power of two for now (and return NULL if 
not a power of two), we can always relax that when needed - and then 
think about a better search for !power of two)

-- 

Thanks,

David / dhildenb
