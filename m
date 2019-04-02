Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6A7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A322070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfDBR0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:26:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54924 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:26:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93D1F80D;
        Tue,  2 Apr 2019 10:26:51 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A9EB3F59C;
        Tue,  2 Apr 2019 10:26:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Steve Capper <Steve.Capper@arm.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a48bb02c-8f93-4e3b-085d-a6f0e5a1f3a0@arm.com>
Date:   Tue, 2 Apr 2019 18:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 28/03/2019 11:42, Bhupesh Sharma wrote:
> On 03/26/2019 10:06 PM, James Morse wrote:
>> On 20/03/2019 05:09, Bhupesh Sharma wrote:
>>> With ARMv8.2-LVA architecture extension availability, arm64 hardware
>>> which supports this extension can support a virtual address-space upto
>>> 52-bits.
>>>
>>> Since at the moment we enable the support of this extension in kernel
>>> via CONFIG flags, e.g.
>>>   - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
>>>
>>> so, there is no clear mechanism in the user-space right now to
>>> determine these CONFIG flag values and hence determine the maximum
>>> virtual address space supported by the underlying kernel.
>>>
>>> User-space tools like 'makedumpfile' therefore are broken currently
>>> as they have no proper method to calculate the 'PTRS_PER_PGD' value
>>> which is required to perform a page table walk to determine the
>>> physical address of a corresponding virtual address found in
>>> kcore/vmcoreinfo.
>>>
>>> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
>>> it can be used in user-space to determine the maximum virtual address
>>> supported by underlying kernel.
>>
>> I don't think this really solves the problem, it feels fragile.
>>
>> I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
>> You can use this to work out that the top level page table size isn't consistent with a
>> 48bit VA, so 52bit VA must be in use...
>>
>> But wasn't your problem walking the kernel page tables? In particular the offset that we
>> apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.
>>
>> Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
>> hard-codes it when it sees 52bit is in use ... somewhere.
>> We haven't solved the problem!

> But isn't the TTBR1_EL1 offset already appended by the kernel via e842dfb5a2d3 ("arm64:
> mm: Offset TTBR1 to allow 52-bit PTRS_PER_PGD")
> in case of kernel configuration where 52-bit userspace VAs are possible.

> Accordingly we have the following assembler helper in 'arch/arm64/include/asm/assembler.h':
> 
>        .macro  offset_ttbr1, ttbr
> #ifdef CONFIG_ARM64_52BIT_VA
>        orr     \ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
> #endif
>        .endm
> 
> where:
> #ifdef CONFIG_ARM64_52BIT_VA
> /* Must be at least 64-byte aligned to prevent corruption of the TTBR */
> #define TTBR1_BADDR_4852_OFFSET        (((UL(1) << (52 - PGDIR_SHIFT)) - \
>                                 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
> #endif

Sure, and all this would work today, because there is only one weird combination. But once
we support another combination of 52bit-va, you'd either need another value, or to start
using PTRS_PER_PGD as a flag for v5.1_FUNNY_BEHAVIOUR_ONE.


[...]

> Note that the above computation holds true both for PTRS_PER_PGD = 64 (48-bit kernel with
> 48-bit User VA) and 1024 (48-bit with 52-bit User VA) cases. And these are the
> configurations for which we are trying to fix the user-space regressions reported (on
> arm64) recently.

... and revisit it when there is another combination?


>> Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
>> could set them the same, or different the other-way-round.
>>
>> Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
>> there would be no ttbr offset.
>>
>> If you need another vmcoreinfo flag once that happens, we've done something wrong here.
> 
> I am currently experimenting with Steve's patches for 52-bit kernel VA
> (<https://lwn.net/Articles/780093/>) and will comment more on the same when I am able to
> get the user-space utilities like makedumpfile and kexec-tools to work with the same on
> both ARMv8 Fast Simulator model and older CPUs which don't support ARMv8.2 extensions.


> However, I think we should not hold up fixes for regressions already reported, because the
> 52-bit kernel VA changes probably still need some more rework.

Chucking things into vmcoreinfo isn't free: we need to keep them there forever, otherwise
yesterdays version of the tools breaks. Can we take the time to get this right for the
cases we know about?

Yes the kernel code is going to move around, this is why the information we expose via
vmcoreinfo needs to be thought through: something we would always need, regardless of how
the kernel implements it.


>> (Not to mention what happens if the TTBR1_EL1 uses 52bit va, but TTBR0_EL1 doesn't)
> 
> I am wondering if there are any real users of the above combination.

Heh! Is there any hardware that supports this?

Pointer-auth changes all this again, as we may prefer to use the bits for pointer-auth in
one TTB or the other. PTRS_PER_PGD may show the 52bit value in this case, but neither TTBR
is mapping 52bits of VA.


> So far, I have generally come across discussions where the following variations of the
> address spaces have been proposed/requested:
> - 48bit kernel VA + 48-bit User VA,
> - 48-bit kernel VA + 52-bit User VA,

+ 52bit kernel, because there is excessive quantities of memory, and the kernel maps it
all, but 48-bit user, because it never maps all the memory, and we prefer the bits for
pointer-auth.

> - 52-bit kernel VA + 52-bit User VA.

And...  all four may happen with the same built image. I don't see how you can tell these
cases apart with the one (build-time-constant!) PTRS_PER_PGD value.

I'm sure some of these cases are hypothetical, but by considering it all now, we can avoid
three more kernel:vmcoreinfo updates, and three more fix-user-space-to-use-the-new-value.


I think you probably do need PTRS_PER_PGD, as this is the one value the mm is using to
generate page tables. I'm pretty sure you also need T0SZ and T1SZ to know if that's
actually in use, or the kernel is bodging round it with an offset.


Thanks,

James
