Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E17C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D780921873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCVGp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:45:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfCVGp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:45:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DE680D;
        Thu, 21 Mar 2019 23:45:55 -0700 (PDT)
Received: from [10.162.42.161] (p8cg001049571a15.blr.arm.com [10.162.42.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 146AB3F59C;
        Thu, 21 Mar 2019 23:45:52 -0700 (PDT)
Subject: Re: [RFC] mm/hotplug: Make get_nid_for_pfn() work with
 HAVE_ARCH_PFN_VALID
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        rientjes@google.com, zi.yan@cs.rutgers.edu
References: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
 <20190321103657.22ivyuyq3k7zhy5n@d104.suse.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a53cdeee-2e25-5c94-4724-d60af1754b88@arm.com>
Date:   Fri, 22 Mar 2019 12:15:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190321103657.22ivyuyq3k7zhy5n@d104.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2019 04:07 PM, Oscar Salvador wrote:
> On Thu, Mar 21, 2019 at 01:38:20PM +0530, Anshuman Khandual wrote:
>> Memory hot remove uses get_nid_for_pfn() while tearing down linked sysfs
>> entries between memory block and node. It first checks pfn validity with
>> pfn_valid_within() before fetching nid. With CONFIG_HOLES_IN_ZONE config
>> (arm64 has this enabled) pfn_valid_within() calls pfn_valid().
>>
>> pfn_valid() is an arch implementation on arm64 (CONFIG_HAVE_ARCH_PFN_VALID)
>> which scans all mapped memblock regions with memblock_is_map_memory(). This
>> creates a problem in memory hot remove path which has already removed given
>> memory range from memory block with memblock_[remove|free] before arriving
>> at unregister_mem_sect_under_nodes().
>>
>> During runtime memory hot remove get_nid_for_pfn() needs to validate that
>> given pfn has a struct page mapping so that it can fetch required nid. This
>> can be achieved just by looking into it's section mapping information. This
>> adds a new helper pfn_section_valid() for this purpose. Its same as generic
>> pfn_valid().
>>
>> This maintains existing behaviour for deferred struct page init case.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> I did not look really close to the patch, but I was dealing with
> unregister_mem_sect_under_nodes() some time ago [1].
> 
> The thing is, I think we can just make it less complex.
> Jonathan tried it out that patch on arm64 back then, and it worked correctly
> for him, and it did for me too on x86_64.
> 
> I am not sure if I overlooked a corner case during the creation of the patch,
> that could lead to problems.

Is there any known corner cases ?

> But if not, we can get away with that, and we would not need to worry
> about get_nid_for_pfn on hot-remove path.

The approach of passing down node ID looks good and will also avoid proposed
changes here to get_nid_for_pfn() during memory hot-remove.

> 
> I plan to revisit the patch in some days, but first I wanted to sort out
> the vmemmap stuff, which I am preparing a new version of it.
> 
> [1] https://patchwork.kernel.org/patch/10700795/
> 

Sure. Please keep me copied when you repost this patch. Thank you.
