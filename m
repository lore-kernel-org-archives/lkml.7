Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869C6C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C8F22CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbfGZOBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:01:04 -0400
Received: from foss.arm.com ([217.140.110.172]:45126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbfGZOBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:01:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F03337;
        Fri, 26 Jul 2019 07:00:59 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D37703F694;
        Fri, 26 Jul 2019 07:00:57 -0700 (PDT)
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
 <4c8a3a11-adc2-efa4-f765-6be338546ae4@arm.com>
 <CA+CK2bBj9UsQZCLsy-S8c_Kd5SRAPvtdS8s9P_Fdg+VifTbT5w@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9f74788a-98e8-9839-2017-df64e8532026@arm.com>
Date:   Fri, 26 Jul 2019 15:00:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBj9UsQZCLsy-S8c_Kd5SRAPvtdS8s9P_Fdg+VifTbT5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 17/07/2019 20:13, Pavel Tatashin wrote:
>> After a quick skim:
>>
>> This will map 'nomap' regions of memory with cacheable attributes. This is a non-starter.
>> These regions were described by firmware as having content that was/is written with
>> different attributes. The attributes must match whenever it is mapped, otherwise we have a
>> loss of coherency. Mapping this stuff as cacheable means the CPU can prefetch it into the
>> cache whenever it likes.
> 
>> It may be important that we do not ever map some of these regions, even though its
>> described as memory. On AMD-Seattle the bottom page of memory is reserved by firmware for
>> its own use; it is made secure-only, and any access causes an
>> external-abort/machine-check. UEFI describes this as 'Reserved', and we preserve this in
>> the kernel as 'nomap'. The equivalent DT support uses memreserve, possibly with the
>> 'nomap' attribute.
>>
>> Mapping a 'new'/unknown region with cacheable attributes can never be safe, even if we
>> trusted kexec-tool to only write the kernel to memory. The host may be using a bigger page
>> size causing more memory to become cacheable than was intended.
>> Linux's EFI support rounds the UEFI memory map to the largest support page size, (and
>> winges about firmware bugs).
>> If we're allowing kexec to load images in a region not described as IORESOURCE_SYSTEM_RAM,
>> that is a bug we should fix.
> 
> We are allowing this. If you consider this to be a bug, I will fix it,
> and this will actually simplify the idmap page table. User will
> receive an error during kexec load if a request is made to load into
> !IORESOURCE_SYSTEM_RAM region.

I consider this a bug, but we can see what others think.
This suggests kexec-tools can open /proc/iomem, find a likely looking gap, and try to load
the new kernel between two platform devices.


>> The only way to do this properly is to copy the linear mapping. The arch code has lots of
>> complex code to generate it correctly at boot, we do not want to duplicate it.
>> (this is why hibernate copies the linear mapping)
> 
> As I understand, you would like to take a copy of idmap page table,
> and add entries only for segment
> sources and destinations into the new page table?

I don't think there is a need to idmap memory at all. We should copy the linear map so you
know you won't overwrite its page tables as part of loading the new kernel.


> If so, there is a slight problem: arch hook machine_kexec_prepare() is
> called prior to loading segments from userland. We can solve this by
> adding another hook that is called after kimage_terminate().

Yes, all this would need doing as machine_kexec() runs. We preferably need to allocate
memory in this path, or at least have a bitmap of what we can/can't overwrite.


>> These patches do not remove the running page tables from TTBR1. As you overwrite the live
>> page tables you will corrupt the state of the CPU. The page-table walker may access things
>> that aren't memory, cache memory that shouldn't be cached (see above), and allocate
>> conflicting entries in the TLB.
> 
> Indeed. However, I was following what is done in create_safe_exec_page():
> https://soleen.com/source/xref/linux/arch/arm64/kernel/hibernate.c?r=af873fce#263
> 
> ttbr1 is not removed there. Am I missing something, or is not yet
> configured there?

Hibernate maps a single executable page in ttbr0_el1 that holds its relocation code.
The relocation code then switches ttbr1_el1 to point to the copy of the linear map. See
the 'break_before_make_ttbr_switch' macro in swsusp_arch_suspend_exit().


> I will set ttbr1 to zero page.
> 
>> You cannot use the mm page table helpers to build an idmap on arm64. The mm page table
>> helpers have a compile-time VA_BITS, and we support systems where there is no memory below
>> 1<<VA_BITS. (crazy huh!). Picking on AMD-Seattle again: if you boot a 4K 39bit VA kernel,
>> the idmap will have more page table levels than the page table helpers can build. This is
>> why there are special helpers to load the idmap, and twiddle TCR_EL1.T0SZ.
>> You already need to copy the linear-map, so using an idmap is extra work. You want to work
>> with linear-map addresses, you probably need to add the field to the appropriate structure.
> 
> OK. Makes sense. I will do the way hibernate setup this table. I was
> indeed following x86, hoping that eventually it would be possible to
> unite: kasan, hibernate, and kexec implementation of this page table.

Our kasan and hibernate code already went a different way. I doubt we can bring them back
in to look like x86, they have different problems to solve.


>> The kexec relocation code still runs at EL2. You can't use a copy of the linear map here
>> as there is only one TTBR on v8.0, and you'd need to setup EL2 as its been torn back to
>> the hyp-stub.
> 
> As I understand normally on baremetal kexec runs at EL1 not EL2. On my
> machine is_kernel_in_hyp_mode() == false in cpu_soft_restart.

and is_hyp_mode_available() ?


This depends on which exception-level your bootloader set Linux running. You should get a
boot message that tells you:
| CPU: All CPU(s) started at EL2

is_kernel_in_hyp_mode() is for determining if the kernel is running at EL2. This is the
case if you get a message like:
| kvm [1]: VHE mode initialized successfully
VHE is a v8.1 feature that repaints the system-registers so a kernel written to run at EL1
can run almost unmodified at EL2.

We also have is_hyp_mode_available(), which will return true if all the CPUs booted at EL2.


kexec either runs its relocation code at EL1, or at EL2 if that is where the first kernel
booted. If you call to EL2, the MMU was already off as KVM will reset EL2 to the hyp-stub
in response to the reboot notifiers hardware_disable() call.

(kvm_arch_hardware_disable() calls cpu_hyp_reset())


> This is the reason hibernate posts EL2 in a holding pen while it rewrites
>> all of memory, then calls back to fixup EL2. Keeping the rewrite phase at EL1 means it
>> doesn't need independently tweaking/testing. You need to do something similar, either
>> calling EL2 to start the new image, or disabling the MMU at EL1 to start the new image there.

> OK, I will study how hibernate does this. I was thinking that if we
> are running in EL2 we can simply configure TTBR0_EL2 instead of
> TTBR0_EL1. But, I need to understand this better.

Yes, if you've got a VHE system it can skip the jumping around Exception-levels, but we
still need to support the non-VHE systems.


>>> This patch series works in terms, that I can kexec-reboot both in QEMU
>>> and on a physical machine. However, I do not see performance improvement
>>> during relocation. The performance is just as slow as before with disabled
>>> caches.
>>
>>> Am I missing something? Perhaps, there is some flag that I should also
>>> enable in page table? Please provide me with any suggestions.
>>
>> Some information about the physical machine you tested this on would help.
>> I'm guessing its v8.0, and booted at EL2....

> I am using Broadcom's Stingray SoC.

First hit on google is [0]. Which assuming its the same SoC, says its Cortex-A72, this is
a v8.0 part, it doesn't have VHE. The kernel will be running at EL1, if it supports KVM it
must have booted at EL2.


> Because  is_kernel_in_hyp_mode()
> returns false, I believe it is EL1. How can I boot it at EL2?

This check is for VHE.
|static inline bool is_kernel_in_hyp_mode(void)
| {
|	return read_sysreg(CurrentEL) == CurrentEL_EL2;
| }

The kernel's early startup in head.S detects if its running at EL2 or EL1. If it has VHE,
it enables the feature and stays at EL2. Otherwise it installs the 'hyp-stub' and drops to
EL1.

On v8.0 the kernel has to run at EL1 because we need the two ttbr registers.
(kernel/user-space). EL2 on these parts only has one. v8.1's VHE adds a second ttbr to
EL2, meaning we can run linux at EL2 and KVM avoids the jumping between exception levels.


You can check for that:
| CPU: All CPU(s) started at EL2
message. If your bootloader is starting the OS at EL1, you will need to speak to the
firmware folk about getting that changed.


> So, I am still confused why I do not see performance improvements
> during relocation on this machine. Any theories?

I assume you started at EL2. You moved EL1's mmu-off code, but cpu_soft_restart() will
call the relocation code at EL2 where the MMU is already off. Because you expected to be
using an idmap, nothing goes wrong, but nothing has changed.


Thanks,

James

[0] https://www.broadcom.com/products/storage/ethernet-storage-adapters-ics/ps1100r
