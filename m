Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 05:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052AA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 05:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392252AbfIWFq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 01:46:26 -0400
Received: from foss.arm.com ([217.140.110.172]:37348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387559AbfIWFqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 01:46:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5D0E142F;
        Sun, 22 Sep 2019 22:46:24 -0700 (PDT)
Received: from [10.162.40.137] (p8cg001049571a15.blr.arm.com [10.162.40.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069EC3F59C;
        Sun, 22 Sep 2019 22:46:21 -0700 (PDT)
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f505cc64-ddff-4c1a-2659-7a3890055d73@arm.com>
Date:   Mon, 23 Sep 2019 11:16:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/16/2019 11:17 AM, Anshuman Khandual wrote:
> In add_memory_resource() the memory range to be hot added first gets into
> the memblock via memblock_add() before arch_add_memory() is called on it.
> Reverse sequence should be followed during memory hot removal which already
> is being followed in add_memory_resource() error path. This now ensures
> required re-order between memblock_[free|remove]() and arch_remove_memory()
> during memory hot-remove.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Original patch https://lkml.org/lkml/2019/9/3/327
> 
> Memory hot remove now works on arm64 without this because a recent commit
> 60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").
> 
> David mentioned that re-ordering should still make sense for consistency
> purpose (removing stuff in the reverse order they were added). This patch
> is now detached from arm64 hot-remove series.
> 
> https://lkml.org/lkml/2019/9/3/326
> 
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..355c466e0621 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1770,13 +1770,13 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
> -	memblock_free(start, size);
> -	memblock_remove(start, size);
>  
>  	/* remove memory block devices before removing memory */
>  	remove_memory_block_devices(start, size);
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +	memblock_free(start, size);
> +	memblock_remove(start, size);
>  	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);
> 

Hello Andrew,

Any feedbacks on this, does it look okay ?

- Anshuman
