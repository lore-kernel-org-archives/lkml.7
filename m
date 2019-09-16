Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F56DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE24206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfIPIuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:50:37 -0400
Received: from foss.arm.com ([217.140.110.172]:42062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfIPIug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:50:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE8E1000;
        Mon, 16 Sep 2019 01:50:36 -0700 (PDT)
Received: from [10.162.43.143] (p8cg001049571a15.blr.arm.com [10.162.43.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC6BE3F59C;
        Mon, 16 Sep 2019 01:50:33 -0700 (PDT)
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
 <20190916063612.GA1502@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <987dfde7-53f9-b013-5841-2c27c03d62d6@arm.com>
Date:   Mon, 16 Sep 2019 14:20:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190916063612.GA1502@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/16/2019 12:06 PM, Mike Rapoport wrote:
> On Mon, Sep 16, 2019 at 11:17:37AM +0530, Anshuman Khandual wrote:
>> In add_memory_resource() the memory range to be hot added first gets into
>> the memblock via memblock_add() before arch_add_memory() is called on it.
>> Reverse sequence should be followed during memory hot removal which already
>> is being followed in add_memory_resource() error path. This now ensures
>> required re-order between memblock_[free|remove]() and arch_remove_memory()
>> during memory hot-remove.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Original patch https://lkml.org/lkml/2019/9/3/327
>>
>> Memory hot remove now works on arm64 without this because a recent commit
>> 60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").
>>
>> David mentioned that re-ordering should still make sense for consistency
>> purpose (removing stuff in the reverse order they were added). This patch
>> is now detached from arm64 hot-remove series.
>>
>> https://lkml.org/lkml/2019/9/3/326
>>
>>  mm/memory_hotplug.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index c73f09913165..355c466e0621 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1770,13 +1770,13 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>>
>>  	/* remove memmap entry */
>>  	firmware_map_remove(start, start + size, "System RAM");
>> -	memblock_free(start, size);
>> -	memblock_remove(start, size);
>>
>>  	/* remove memory block devices before removing memory */
>>  	remove_memory_block_devices(start, size);
>>
>>  	arch_remove_memory(nid, start, size, NULL);
>> +	memblock_free(start, size);
> 
> I don't see memblock_reserve() anywhere in memory_hotplug.c, so the
> memblock_free() call here seems superfluous. I think it can be simply
> dropped.

I had observed that previously but was not sure whether or not there are
still scenarios where it might be true. Error path in add_memory_resource()
even just calls memblock_remove() not memblock_free(). Unless there is any
objection, can just drop it.
