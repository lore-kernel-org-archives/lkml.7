Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607AECA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 03:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3920869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 03:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKDD5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 22:57:35 -0500
Received: from foss.arm.com ([217.140.110.172]:35146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfKDD5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 22:57:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3CF531F;
        Sun,  3 Nov 2019 19:57:33 -0800 (PST)
Received: from [10.163.1.23] (unknown [10.163.1.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2B33F6C4;
        Sun,  3 Nov 2019 19:57:24 -0800 (PST)
Subject: Re: [PATCH V9 2/2] arm64/mm: Enable memory hot remove
To:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, mark.rutland@arm.com, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
References: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
 <1570609308-15697-3-git-send-email-anshuman.khandual@arm.com>
 <20191010113433.GI28269@mbp> <f51cdb20-ddc4-4fb7-6c45-791d2e1e690c@arm.com>
 <20191018094825.GD19734@arrakis.emea.arm.com>
 <f5581644-42b7-097e-6a86-ba7db9d0b544@arm.com>
 <5db2aab1-1dde-4545-a03d-e7ae2d86aec7@arm.com>
 <87ef9d38-a9ab-24b3-cc2e-93fedb4c0383@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c121abbe-ba63-48f3-d732-3af41b8503e5@arm.com>
Date:   Mon, 4 Nov 2019 09:27:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87ef9d38-a9ab-24b3-cc2e-93fedb4c0383@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2019 01:55 PM, Anshuman Khandual wrote:
> There is a mechanism in ACPI for this i.e ACPI_SRAT_MEM_HOT_PLUGGABLE.
> 
> Lets re-evaluate the situation here from scratch. Memory can be classified as
> boot and runtime because it impacts the way in which kernel allocations, zone
> initializations are treated. Boot memory deals with kernel allocation before
> zone init happens where as runtime memory might choose which zone to get into
> right away.
> 
> (1) Boot memory
> 
> 	- Non-movable
> 
> 		- Normal memblocks
> 		- All kernel allocations come here
> 		- Become ZONE_NORMAL/DMA/DMA32 at runtime
> 
> 			- Never removable because isolation and hence migration impossible
> 			- Removal protection because of the zone classification
> 
> 	- Movable	(ACPI_SRAT_MEM_HOT_PLUGGABLE)
> 
> 		- Memblock will be marked with MEMBLOCK_HOTPLUG
> 		- Memblock allocations tried to be avoided (reversing the memblock order etc)
> 		- Become ZONE_MOVABLE at runtime
> 
> 			- Removable  [1]

There is another way in which boot memory can be created as ZONE_MOVABLE
irrespective of whether the firmware (ACPI/OF) had asked for it or not.
This is achieved with "kernelcore" or "movablecore" kernel command line
options where the administrator exclusively asks for sections of memory
to be converted as ZONE_MOVABLE. This creates some of the memory block
devices in /sys/devices/system/memory as removable (ZONE_MOVABLE). IIUC
this is mutually exclusive with respect to removable boot memory creation
with "movable_node" kernel command line option with firmware tagged hot
pluggable memory sections (ACPI_SRAT_MEM_HOT_PLUGGABLE).

Details here: mm/page_alloc.c find_zone_movable_pfns_for_nodes()

Now, this boils down to the fact whether firmware will ever request for
removal of boot memory sections which was never tagged as hotpluggable
by the firmware during boot. Wondering if tagging portions of boot memory
as ZONE_MOVABLE might have any other use case if they are never to be hot
removed. Will continue looking into ACPI/OF memory hotplug scenarios.
