Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D20C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74209206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfLLKcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:32:50 -0500
Received: from foss.arm.com ([217.140.110.172]:41612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfLLKct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:32:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12CCF1045;
        Thu, 12 Dec 2019 02:32:49 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37FB03F6CF;
        Thu, 12 Dec 2019 02:32:47 -0800 (PST)
Subject: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
Date:   Thu, 12 Dec 2019 10:32:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1575057559-25496-3-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 29/11/2019 19:59, Bhupesh Sharma wrote:
> vabits_actual variable on arm64 indicates the actual VA space size,
> and allows a single binary to support both 48-bit and 52-bit VA
> spaces.
> 
> If the ARMv8.2-LVA optional feature is present, and we are running
> with a 64KB page size; then it is possible to use 52-bits of address
> space for both userspace and kernel addresses. However, any kernel
> binary that supports 52-bit must also be able to fall back to 48-bit
> at early boot time if the hardware feature is not present.
> 
> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> addressed by TTBR1_EL1 (and hence can be used for determining the
> vabits_actual value) it makes more sense to export the same in
> vmcoreinfo rather than vabits_actual variable, as the name of the
> variable can change in future kernel versions, but the architectural
> constructs like TCR_EL1.T1SZ can be used better to indicate intended
> specific fields to user-space.
> 
> User-space utilities like makedumpfile and crash-utility, need to
> read/write this value from/to vmcoreinfo

(write?)

> for determining if a virtual address lies in the linear map range.

I think this is a fragile example. The debugger shouldn't need to know this.


> The user-space computation for determining whether an address lies in
> the linear map range is the same as we have in kernel-space:
> 
>   #define __is_lm_address(addr)	(!(((u64)addr) & BIT(vabits_actual - 1)))

This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA space"). If user-space
tools rely on 'knowing' the kernel memory layout, they must have to constantly be fixed
and updated. This is a poor argument for adding this to something that ends up as ABI.


I think a better argument is walking the kernel page tables from the core dump.
Core code's vmcoreinfo exports the location of the kernel page tables, but in the example
above you can't walk them without knowing how T1SZ was configured.

On older kernels, user-space that needs this would have to assume the value it computes
from VA_BITs (also in vmcoreinfo) is the value in use.


---%<---
> I have sent out user-space patches for makedumpfile and crash-utility
> to add features for obtaining vabits_actual value from TCR_EL1.T1SZ (see
> [0] and [1]).
> 
> Akashi reported that he was able to use this patchset and the user-space
> changes to get user-space working fine with the 52-bit kernel VA
> changes (see [2]).
> 
> [0]. http://lists.infradead.org/pipermail/kexec/2019-November/023966.html
> [1]. http://lists.infradead.org/pipermail/kexec/2019-November/024006.html
> [2]. http://lists.infradead.org/pipermail/kexec/2019-November/023992.html
---%<---

This probably belongs in the cover letter instead of the commit log.

(From-memory: one of vmcore/kcore is virtually addressed, the other physically. Does this
fix your poblem in both cases?)


> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e12d8c5..f78310ba65ea 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -7,6 +7,13 @@
>  #include <linux/crash_core.h>
>  #include <asm/memory.h>

You need to include asm/sysreg.h for read_sysreg(), and asm/pgtable-hwdef.h for the macros
you added.


> +static inline u64 get_tcr_el1_t1sz(void);

Why do you need to do this?


> +static inline u64 get_tcr_el1_t1sz(void)
> +{
> +	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
> +}

(We don't modify this one, and its always the same one very CPU, so this is fine.
This function is only called once when the stringy vmcoreinfo elf_note is created...)


>  void arch_crash_save_vmcoreinfo(void)
>  {
>  	VMCOREINFO_NUMBER(VA_BITS);
> @@ -15,5 +22,7 @@ void arch_crash_save_vmcoreinfo(void)
>  						kimage_voffset);
>  	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>  						PHYS_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(tcr_el1_t1sz)=0x%llx\n",
> +						get_tcr_el1_t1sz());

You document the name as being upper-case.
The two values either values either side are upper-case.


>  	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>  }


Thanks,

James
