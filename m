Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DE9C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BEE2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfIEE1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:27:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbfIEE1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:27:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0854728;
        Wed,  4 Sep 2019 21:27:23 -0700 (PDT)
Received: from [10.162.41.136] (p8cg001049571a15.blr.arm.com [10.162.41.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE723F718;
        Wed,  4 Sep 2019 21:27:16 -0700 (PDT)
Subject: Re: [PATCH V7 1/3] mm/hotplug: Reorder memblock_[free|remove]() calls
 in try_remove_memory()
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com
References: <1567503958-25831-1-git-send-email-anshuman.khandual@arm.com>
 <1567503958-25831-2-git-send-email-anshuman.khandual@arm.com>
 <e98f2950-bef9-3672-81a8-f9593354fffe@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <49c2a682-97c5-5eef-6635-9fe75e4677f7@arm.com>
Date:   Thu, 5 Sep 2019 09:57:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e98f2950-bef9-3672-81a8-f9593354fffe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2019 01:46 PM, David Hildenbrand wrote:
> On 03.09.19 11:45, Anshuman Khandual wrote:
>> Memory hot remove uses get_nid_for_pfn() while tearing down linked sysfs
>> entries between memory block and node. It first checks pfn validity with
>> pfn_valid_within() before fetching nid. With CONFIG_HOLES_IN_ZONE config
>> (arm64 has this enabled) pfn_valid_within() calls pfn_valid().
>>
>> pfn_valid() is an arch implementation on arm64 (CONFIG_HAVE_ARCH_PFN_VALID)
>> which scans all mapped memblock regions with memblock_is_map_memory(). This
>> creates a problem in memory hot remove path which has already removed given
>> memory range from memory block with memblock_[remove|free] before arriving
>> at unregister_mem_sect_under_nodes(). Hence get_nid_for_pfn() returns -1
>> skipping subsequent sysfs_remove_link() calls leaving node <-> memory block
>> sysfs entries as is. Subsequent memory add operation hits BUG_ON() because
>> of existing sysfs entries.
> Since
> 
> commit 60bb462fc7adb06ebee3beb5a4af6c7e6182e248
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Aug 28 13:57:15 2019 +1000
> 
>     drivers/base/node.c: simplify unregister_memory_block_under_nodes()
> 
> that problem should be gone. There is no get_nid_for_pfn() call anymore.

Yes, the problem is gone. The above commit is still not present on arm64
tree against which this series was rebased and tested while posting.

> 
> So this patch should no longer be necessary - but as I said during
> earlier versions of this patch, the re-ordering might still make sense
> for consistency (removing stuff in the reverse order they were added).
> You'll have to rephrase the description then.

Sure will reword the commit message on these lines.
