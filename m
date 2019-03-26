Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3340C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43212075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfCZMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:03:29 -0400
Received: from foss.arm.com ([217.140.101.70]:35308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731501AbfCZMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:03:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE2DD1596;
        Tue, 26 Mar 2019 05:03:25 -0700 (PDT)
Received: from [10.162.41.160] (p8cg001049571a15.blr.arm.com [10.162.41.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C06B3F59C;
        Tue, 26 Mar 2019 05:03:22 -0700 (PDT)
Subject: Re: [RFC] mm/hotplug: Make get_nid_for_pfn() work with
 HAVE_ARCH_PFN_VALID
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, osalvador@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        rientjes@google.com, zi.yan@cs.rutgers.edu
References: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
 <20190321083639.GJ8696@dhcp22.suse.cz>
 <621cc94c-210d-6fd4-a2e1-b7cfce733cf3@arm.com>
 <20190322120219.GI32418@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <65a4b160-a654-8bd3-8022-491094cf6b8f@arm.com>
Date:   Tue, 26 Mar 2019 17:33:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322120219.GI32418@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/22/2019 05:32 PM, Michal Hocko wrote:
> On Fri 22-03-19 11:49:30, Anshuman Khandual wrote:
>>
>> On 03/21/2019 02:06 PM, Michal Hocko wrote:
>>> On Thu 21-03-19 13:38:20, Anshuman Khandual wrote:
>>>> Memory hot remove uses get_nid_for_pfn() while tearing down linked sysfs
>>>> entries between memory block and node. It first checks pfn validity with
>>>> pfn_valid_within() before fetching nid. With CONFIG_HOLES_IN_ZONE config
>>>> (arm64 has this enabled) pfn_valid_within() calls pfn_valid().
>>>>
>>>> pfn_valid() is an arch implementation on arm64 (CONFIG_HAVE_ARCH_PFN_VALID)
>>>> which scans all mapped memblock regions with memblock_is_map_memory(). This
>>>> creates a problem in memory hot remove path which has already removed given
>>>> memory range from memory block with memblock_[remove|free] before arriving
>>>> at unregister_mem_sect_under_nodes().
>>> Could you be more specific on what is the actual problem please? It
>>> would be also helpful to mention when is the memblock[remove|free]
>>> called actually.
>> The problem is in unregister_mem_sect_under_nodes() as it skips calling into both
>> instances of sysfs_remove_link() which removes node-memory block sysfs symlinks.
>> The node enumeration of the memory block still remains in sysfs even if the memory
>> block itself has been removed.
>>
>> This happens because get_nid_for_pfn() returns -1 for a given pfn even if it has
>> a valid associated struct page to fetch the node ID from.
>>
>> On arm64 (with CONFIG_HOLES_IN_ZONE)
>>
>> get_nid_for_pfn() -> pfn_valid_within() -> pfn_valid -> memblock_is_map_memory()
>>
>> At this point memblock for the range has been removed.
>>
>> __remove_memory()
>> 	memblock_free()
>> 	memblock_remove()	--------> memblock has already been removed
>> 	arch_remove_memory()
>> 		__remove_pages()
>> 			__remove_section()
>> 				unregister_memory_section()
>>  					remove_memory_section()
>> 						unregister_mem_sect_under_nodes()
>>
>> There is a dependency on memblock (after it has been removed) through pfn_valid().
> Can we reorganize or rework the code that the memblock is removed later?
> I guess this is what Oscar was suggesting.

I could get it working with the following re-order of memblock_[free|remove] and
arch_remove_memory(). I did not observe any other adverse side affect because of
this change. Does it look okay ?

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1863,11 +1863,11 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 
        /* remove memmap entry */
        firmware_map_remove(start, start + size, "System RAM");
+       arch_remove_memory(nid, start, size, NULL);
+
        memblock_free(start, size);
        memblock_remove(start, size);
 
-       arch_remove_memory(nid, start, size, NULL);
-
        try_offline_node(nid);
 
        mem_hotplug_done();
