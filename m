Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E5CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D056D2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfJ1IZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:25:23 -0400
Received: from foss.arm.com ([217.140.110.172]:37258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbfJ1IZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:25:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625AE1FB;
        Mon, 28 Oct 2019 01:25:21 -0700 (PDT)
Received: from [10.162.40.135] (p8cg001049571a15.blr.arm.com [10.162.40.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7D93F71E;
        Mon, 28 Oct 2019 01:25:14 -0700 (PDT)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <87ef9d38-a9ab-24b3-cc2e-93fedb4c0383@arm.com>
Date:   Mon, 28 Oct 2019 13:55:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5db2aab1-1dde-4545-a03d-e7ae2d86aec7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/2019 10:39 PM, James Morse wrote:
> Hi guys,
> 
> On 21/10/2019 10:53, Anshuman Khandual wrote:
>> On 10/18/2019 03:18 PM, Catalin Marinas wrote:
>>> On Fri, Oct 11, 2019 at 08:26:32AM +0530, Anshuman Khandual wrote:
>>>> On 10/10/2019 05:04 PM, Catalin Marinas wrote:
>>>>> Mark Rutland mentioned at some point that, as a preparatory patch to
>>>>> this series, we'd need to make sure we don't hot-remove memory already
>>>>> given to the kernel at boot. Any plans here?
>>>>
>>>> Hmm, this series just enables platform memory hot remove as required from
>>>> generic memory hotplug framework. The path here is triggered either from
>>>> remove_memory() or __remove_memory() which takes physical memory range
>>>> arguments like (nid, start, size) and do the needful. arch_remove_memory()
>>>> should never be required to test given memory range for anything including
>>>> being part of the boot memory.
>>>
>>> Assuming arch_remove_memory() doesn't (cannot) check, is there a risk on
>>
>> Platform can definitely enumerate boot memory ranges. But checking on it in
>> arch_remove_memory() which deals with actual procedural details might not be
>> ideal IMHO. Refusing a requested removal attempt should have been done up in
>> the call chain. This will require making generic hot plug reject any removal
>> request which falls within enumerated boot memory. IFAICS currently there is
>> no generic way to remember which memory came as part of the boot process.
>> Probably be a new MEMBLOCK flag will do.
> 
> Memblock flags are fun because they have to be provided to the walkers like
> for_each_mem_range().

Yes, it will require some code changes but nevertheless, it can properly track
early boot time added memory and differentiate it from runtime added memory. I
am not saying we will have to go in this direction but it will be one of the
viable generic ways to enumerate boot memory. IIUC the other existing method is
through firmware memory map.

> 
> Unless hot remove is a hot path, it should be enough to check against the UEFI memory map
> or DT memory node. (we already have helpers to query the attributes from the memory map at
> runtime, so it is still available).

Only problem will be unlike memblock or firmware memory map, it does not get
updated after each memory hot add or remove operation.

> 
> 
>>> arm64 that, for example, one removes memory available at boot and then
>>> kexecs a new kernel? Does the kexec tool present the new kernel with the
>>> original memory map?
>> I dont know, probably James can help here. But as I had mentioned earlier,
>> the callers of remove_memory() should be able to control that. ACPI should
>> definitely be aware about which ranges were part of boot memory and refrain
>> from removing any subset, if the platform is known to have problems with
>> any subsequent kexec operation because the way boot memory map get used.
>>
>> Though I am not much aware about kexec internals, it should inherit the
>> memory state at given point in time
> 
> It does, but t = first-boot
> 
> 
>> accommodating all previous memory hot and remove operations.
> 
> This would imply we rewrite the tables we get from firmware as the facts about the
> platform change ... that way madness lies!

OR the firmware itself can rewrite it's own table in memory after performing
memory hotplug operations. But lets take a step back. The basic question here
would be "What should the new kexec kernel get in terms of memory resources".

There can be two options

1. Memory state as available at runtime

	- Seems logical unless kexec kernel has to be associated with boot resources
	- Requires tracking the changes some where, either in kernel or firmware
	- If kernel has to track this in a generic way, there are some options 

		- memblock lists all accessible memory but does not identify boot memory
		- firmware memmap

	- If kexec needs resource enumeration from firmware table, then it requires re-write

		- Either in memory hotplug path as with existing firmware memory map
		- OR firmware updates the table itself after driving memory hotplug operation

2. Memory state as available at boot

	- If boot memory has been removed

		- Platform must guarantee they are still accessible to next kexec kernel
		- This is highly unlikely because

			- DIMM might be taken out e.g resource trimming, error handling 
			- DIMM might be reassigned to other guests in virtualization

	- If new memory added

		- Not problematic, new kexec kernel will not use this additional memory

			- Just resource wastage from platform perspective

>
> ACPI doesn't describe memory, the UEFI memory map does. You may be using the UEFI memory
> map on either a DT or ACPI system. If you don't have UEFI, you're using the DT memory-node.

Is there any reason why firmware cannot update these tables (UEFI memory map or DT memory
node) after driving memory hotplug operation ?

> 
> Linux passes on exactly what it had at boot through kexec. We don't rewrite the tables.
> Memory is either described in DT, or in the UEFI memory map that was left in memory by the
> EFI stub. Linux remembers where the UEFI memory map is through kexec using the additional
> entries in the DT chosen node that were put there by the EFI stub.

Okay, but again the point is if hot-plug is driven by firmware why cant it just update
the resource table ? What is rationale of having values in there which does not correctly
represent the entire addressable memory range anymore.

> 
> 
> The bootloader (including the EFI stub) needs to know what memory is removable. Certain
> allocations can't move once they have been made:
>  * The kernel's randomised physical address should not be in removable memory. With UEFI,
>    the EFI stub does this.
>  * Firmware structures like the DT or ACPI tables should not be in removable memory.
>    Neither should reservations for runtime use, like the RAS CPER regions, or the UEFI
>    runtime services.
>  * The EFI stub should not allocate the authoritative copy of the memory map in removable
>    memory. (we have runtime helpers to lookup the attributes. we pass the boot-time memory
>    map to the next OS via kexec).
>  * During paging_init() we allocate memory for swapper_pg_dir. This isn't something we can
> easily move around.
> 
> Its not just software!:
>  * The GIC ITS property/pending (?) tables should not be in removable memory.

All these are kernel allocations and they are always protected either being on non movable
zones or with PG_reserved set. AFAICS these pages cannot be isolated, migrated or removed.
So the protection comes from kernel because of their zone classification or allocation
method (memblock_reserve etc).

> 
> 
> The simplest thing to do here is decree that all memory present at boot, is non-removable.
> Firmware may need to trim the memory available to UEFI to the minimum needed to boot the
> system, we can hot-add the rest of it once we're up and running.

That will be a more fundamental change in the way memory is handled during boot. AFAICS,
we dont have to go in that direction.

> 
> 
>> As an example cloud environment scenario, memory
>> resources might have increased or decreased during a guest lifetime, so
>> when the guest needs to have new OS image why should not it have all the
>> memory ? I dont know if it's feasible for the guest to expect previous hot
>> add or remove operations to be played again after the kexec.
> 
> Firmware can't know that we kexec'd, so it can't replay the operations.

Okay.

> 
> I think we need a way of determining whether a particular block of removable memory is
> present or not. If we do this during boot, then kexec works in the same way as a normal boot.
> 
> 
>> There is another fundamental question here. Is there a notion of a minimum
>> subset of boot memory which cannot be hot removed no matter what ? If yes,
>> how that is being conveyed to the kernel currently ?
> 
> Yes. The UEFI memory map.
> 
> See drivers/firmware/efi/libstub/fdt.c::exit_boot_func()
> the EFI stub calls efi_get_virtmap() to get the running memory map, then stores in the DT
> with update_fdt_memmap().
> 
> The memory described at this stage may not be removed as allocations from the EFI stub
> can't be moved. The biggest of these, is the kernel, which relocates itself to a random
> physical address during the EFI stub.
> 
> See drivers/firmware/efi/libstub/arm64-stub.c::handle_kernel_image()
> The memcpy() is at the end.

But all these should be protected because their current allocation and usage
(i.e ZONE_NORMAL, PG_reserved etc).

> 
> 
>> The point is that all these need to be established between ACPI, EFI and
>> kernel. AFAICS this problem is for MM subsystem (including the platform
>> part of it) to solve instead.
> 
>>> I can see x86 has CONFIG_FIRMWARE_MEMMAP suggesting that it is used by
>>> kexec. try_remove_memory() calls firmware_map_remove() so maybe they
>>> solve this problem differently.
>>>
>>> Correspondingly, after an arch_add_memory(), do we want a kexec kernel
>>> to access it? x86 seems to use the firmware_map_add_hotplug() mechanism.
>>
>> Hmm, kexec could use it instead on arm64 as well ?
> 
> Mmm, a linux specific description of the platform that we have to keep over kexec.

As we mentioned before, if the kexec needs to inherent runtime memory resources
instead of boot time, then changed memory resources will have to be tracked
either in Linux or in firmware which kexec can refer.

> 
> How do we describe this if we kexec something that isn't linux? How do we tell a version
Kexec tool reads memory resource enumeration from first running kernel and
presents that to new kexec kernel. It can read what ever format it wants (EUFI
memory map, DT, memblock, firmware memory map) but presents in way which kexec
kernel can use (EUFI memory map, DT). Both formats need not be the same.

> of linux that doesn't support hotplug not to overwrite it?

If the running kernel does not support hotplug, nothing updates the memory map.
It remains unchanged from boot. If the kexec kernel does not support hotplug, it
is irrelevant because it will just consume memory as presented from the first
running kernel which remains the same through out it's runtime.

> 
> It would be better if we had something in ACPI to tell us at runtime whether a hot
> pluggable range of memory was populated.
> 
> (I haven't looked to see whether ACPI can already do this)

There is a mechanism in ACPI for this i.e ACPI_SRAT_MEM_HOT_PLUGGABLE.

Lets re-evaluate the situation here from scratch. Memory can be classified as
boot and runtime because it impacts the way in which kernel allocations, zone
initializations are treated. Boot memory deals with kernel allocation before
zone init happens where as runtime memory might choose which zone to get into
right away.

(1) Boot memory

	- Non-movable

		- Normal memblocks
		- All kernel allocations come here
		- Become ZONE_NORMAL/DMA/DMA32 at runtime

			- Never removable because isolation and hence migration impossible
			- Removal protection because of the zone classification

	- Movable	(ACPI_SRAT_MEM_HOT_PLUGGABLE)

		- Memblock will be marked with MEMBLOCK_HOTPLUG
		- Memblock allocations tried to be avoided (reversing the memblock order etc)
		- Become ZONE_MOVABLE at runtime

			- Removable  [1]

(2) Runtime memory


	- Removable
		- Can become ZONE_NORMAL

			- Never removable because isolation and hence migration impossible
			- Removal protection because of the zone classification

		- Can become ZONE_MOVABLE

			- Removable [2]


We dont have to worry about non-movable boot memory as they are protected
against removal because of their zone and subsequent usage. Hence even if
the firmware attempts (which it should not), it cannot be removed.

[1] Remove hotpluggable boot memory

Firmware should only attempt to remove memory which was tagged as hotpluggable
ACPI_SRAT_MEM_HOT_PLUGGABLE in the SRAT table. The entire discussion here, is
how to handle only this particular situation. Though DT based systems might
also have similar concerns, if they support hotpluggable boot memory.

a) Platform decides not to support removal of hotpluggable memory

Platform can have a policy not to either give hotpluggable memory regions or
not to attempt removing them even if given. This is a purely a firmware centric
platform solution without requiring any changes to current memory hot-remove code.

b) Platform decides to support removal of hotpluggable memory

As mentioned before, free_hotplug_page_range() will have to handle PG_reserved
pages while freeing. But kexec also needs to understand part of the boot memory
is inaccessible now and should not be passed to the next kernel. This will
require tracking boot memory changes in EUFI memory map or DT nodes or membock
or firmware memory map, updated either by kernel or firmware itself.

[2] Remove hotpluggable runtime memory

There are no similar problems here. If runtime added memory is never going to
be part of the kexec enumeration, it does not even matter whether these memory
are removed or not.

- Anshuman

> 
> 
> 
> Thanks,
> 
> James
> 
> 
