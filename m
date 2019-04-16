Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E5121773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDPJwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:52:36 -0400
Received: from foss.arm.com ([217.140.101.70]:51048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfDPJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:52:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEEE380D;
        Tue, 16 Apr 2019 02:52:35 -0700 (PDT)
Received: from [10.162.42.238] (p8cg001049571a15.blr.arm.com [10.162.42.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA29A3F68F;
        Tue, 16 Apr 2019 02:52:29 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] arm64/mm: Enable memory hot remove
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        cai@lca.pw, logang@deltatee.com, ira.weiny@intel.com
References: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
 <1555221553-18845-3-git-send-email-anshuman.khandual@arm.com>
 <614fe7d2-cc5d-61a2-6894-026e30498269@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <eeff6d30-f6c9-733b-5a27-76d2a80c649d@arm.com>
Date:   Tue, 16 Apr 2019 15:22:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <614fe7d2-cc5d-61a2-6894-026e30498269@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/15/2019 07:25 PM, David Hildenbrand wrote:
>> +
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
>> +{
>> +	unsigned long start_pfn = start >> PAGE_SHIFT;
>> +	unsigned long nr_pages = size >> PAGE_SHIFT;
>> +	struct zone *zone = page_zone(pfn_to_page(start_pfn));
>> +	int ret;
>> +
>> +	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
>> +	if (!ret)
> Please note that I posted patches that remove all error handling
> from arch_remove_memory and __remove_pages(). They are already in next/master
> 
> So this gets a lot simpler and more predictable.
> 
> 
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Apr 10 11:02:27 2019 +1000
> 
>     mm/memory_hotplug: make __remove_pages() and arch_remove_memory() never fail
>     
>     All callers of arch_remove_memory() ignore errors.  And we should really
>     try to remove any errors from the memory removal path.  No more errors are
>     reported from __remove_pages().  BUG() in s390x code in case
>     arch_remove_memory() is triggered.  We may implement that properly later.
>     WARN in case powerpc code failed to remove the section mapping, which is
>     better than ignoring the error completely right now

Sure will follow suit next time around.
