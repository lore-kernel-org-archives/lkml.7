Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094FCC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CA5206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfFLECl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:02:41 -0400
Received: from foss.arm.com ([217.140.110.172]:44784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfFLECl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:02:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723F228;
        Tue, 11 Jun 2019 21:02:40 -0700 (PDT)
Received: from [10.162.42.142] (p8cg001049571a15.blr.arm.com [10.162.42.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9C03F557;
        Tue, 11 Jun 2019 21:02:36 -0700 (PDT)
Subject: Re: [PATCH V5 - Rebased] mm/hotplug: Reorder memblock_[free|remove]()
 calls in try_remove_memory()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@arm.com, osalvador@suse.de,
        david@redhat.com, mhocko@suse.com, mark.rutland@arm.com
References: <36e0126f-e2d1-239c-71f3-91125a49e019@redhat.com>
 <1560252373-3230-1-git-send-email-anshuman.khandual@arm.com>
 <20190611151908.cdd6b73fd17fda09b1b3b65b@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5b4f1f19-2f8d-9b8f-4240-7b728952b6fe@arm.com>
Date:   Wed, 12 Jun 2019 09:32:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190611151908.cdd6b73fd17fda09b1b3b65b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2019 03:49 AM, Andrew Morton wrote:
> On Tue, 11 Jun 2019 16:56:13 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
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
>>
>> [   62.007176] NUMA: Unknown node for memory at 0x680000000, assuming node 0
>> [   62.052517] ------------[ cut here ]------------
>> [   62.053211] kernel BUG at mm/memory_hotplug.c:1143!
>> [   62.053868] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> [   62.054589] Modules linked in:
>> [   62.054999] CPU: 19 PID: 3275 Comm: bash Not tainted 5.1.0-rc2-00004-g28cea40b2683 #41
>> [   62.056274] Hardware name: linux,dummy-virt (DT)
>> [   62.057166] pstate: 40400005 (nZcv daif +PAN -UAO)
>> [   62.058083] pc : add_memory_resource+0x1cc/0x1d8
>> [   62.058961] lr : add_memory_resource+0x10c/0x1d8
>> [   62.059842] sp : ffff0000168b3ce0
>> [   62.060477] x29: ffff0000168b3ce0 x28: ffff8005db546c00
>> [   62.061501] x27: 0000000000000000 x26: 0000000000000000
>> [   62.062509] x25: ffff0000111ef000 x24: ffff0000111ef5d0
>> [   62.063520] x23: 0000000000000000 x22: 00000006bfffffff
>> [   62.064540] x21: 00000000ffffffef x20: 00000000006c0000
>> [   62.065558] x19: 0000000000680000 x18: 0000000000000024
>> [   62.066566] x17: 0000000000000000 x16: 0000000000000000
>> [   62.067579] x15: ffffffffffffffff x14: ffff8005e412e890
>> [   62.068588] x13: ffff8005d6b105d8 x12: 0000000000000000
>> [   62.069610] x11: ffff8005d6b10490 x10: 0000000000000040
>> [   62.070615] x9 : ffff8005e412e898 x8 : ffff8005e412e890
>> [   62.071631] x7 : ffff8005d6b105d8 x6 : ffff8005db546c00
>> [   62.072640] x5 : 0000000000000001 x4 : 0000000000000002
>> [   62.073654] x3 : ffff8005d7049480 x2 : 0000000000000002
>> [   62.074666] x1 : 0000000000000003 x0 : 00000000ffffffef
>> [   62.075685] Process bash (pid: 3275, stack limit = 0x00000000d754280f)
>> [   62.076930] Call trace:
>> [   62.077411]  add_memory_resource+0x1cc/0x1d8
>> [   62.078227]  __add_memory+0x70/0xa8
>> [   62.078901]  probe_store+0xa4/0xc8
>> [   62.079561]  dev_attr_store+0x18/0x28
>> [   62.080270]  sysfs_kf_write+0x40/0x58
>> [   62.080992]  kernfs_fop_write+0xcc/0x1d8
>> [   62.081744]  __vfs_write+0x18/0x40
>> [   62.082400]  vfs_write+0xa4/0x1b0
>> [   62.083037]  ksys_write+0x5c/0xc0
>> [   62.083681]  __arm64_sys_write+0x18/0x20
>> [   62.084432]  el0_svc_handler+0x88/0x100
>> [   62.085177]  el0_svc+0x8/0xc
> 
> This seems like a serious problem.  Once which should be fixed in 5.2
> and perhaps the various -stable kernels as well.

But the problem does not exist in the current kernel as yet till the reworked
versions of the other two patches in this series get merged. This patch was
after arm64 hot-remove enablement in V1 (https://lkml.org/lkml/2019/4/3/28)
but after some discussions it was decided to be moved before hot-remove from
V2 (https://lkml.org/lkml/2019/4/14/5) onwards as a prerequisite patch instead.

> 
>> Re-ordering memblock_[free|remove]() with arch_remove_memory() solves the
>> problem on arm64 as pfn_valid() behaves correctly and returns positive
>> as memblock for the address range still exists. arch_remove_memory()
>> removes applicable memory sections from zone with __remove_pages() and
>> tears down kernel linear mapping. Removing memblock regions afterwards
>> is safe because there is no other memblock (bootmem) allocator user that
>> late. So nobody is going to allocate from the removed range just to blow
>> up later. Also nobody should be using the bootmem allocated range else
>> we wouldn't allow to remove it. So reordering is indeed safe.
>>
>> ...
>>
>>
>> - Rebased on linux-next (next-20190611)
> 
> Yet the patch you've prepared is designed for 5.3.  Was that
> deliberate, or should we be targeting earlier kernels?

It was deliberate for 5.3 as a preparation for upcoming reworked arm64 hot-remove.
