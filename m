Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1121FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB3C2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x2nC6RGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfC3QQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:16:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbfC3QQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/M1uSYtZkQvPKOHp63HAkmI42eBbHUqb+hiERWhWK3I=; b=x2nC6RGs3fNlcMzadG2OV7qp3T
        RiFdMf897apIiC8HwUrFOSbTHH7avYA8496MqxUgDLjw2M1TNBHpmNa9NHuU2lS3s08fEG/8F66Xj
        3bzacAQhJ4u7IH+AC3YoVzTLq71iipIqFwM6EKY4V7z1fDpU96TaTV+y9FXkpqbv9bg9eeD8w949F
        /EB8YtAmfu7TsxtNlSVaOh3drl6pHcgLUIv4SiBH3yYIUheV8VziC64Kntcq+KrVbPCVzxoMORmih
        PENGFIIUHqw7paazgNBm6GakXgBBy3YM1hFGxjm9i8MSI4ESDEkmJBlNuwE9Y2L7HvdrwFSAye2GE
        d80cHbCg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAGeG-0006Ez-Fr; Sat, 30 Mar 2019 16:16:00 +0000
Subject: Re: [RESEND PATCH v6 12/12] x86/fsgsbase/64: Add documentation for
 FSGSBASE
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-13-git-send-email-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1bda8272-1f3b-7e9d-1065-e40cd9db6c4a@infradead.org>
Date:   Sat, 30 Mar 2019 09:15:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552680405-5265-13-git-send-email-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 1:06 PM, Chang S. Bae wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> v2: Minor updates to documentation requested in review.
> v3: Update for new gcc and various improvements.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  Documentation/x86/fsgs.txt | 104 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/x86/fsgs.txt
> 

Globally s/64bit/64-bit/ and s/32bit/32-bit/.

More comments below.

> diff --git a/Documentation/x86/fsgs.txt b/Documentation/x86/fsgs.txt
> new file mode 100644
> index 000000000000..7a973a5c1767
> --- /dev/null
> +++ b/Documentation/x86/fsgs.txt
> @@ -0,0 +1,104 @@
> +
> +Using FS and GS prefixes on 64bit x86 linux
> +
> +The x86 architecture supports segment prefixes per instruction to add an
> +offset to an address.  On 64bit x86, these are mostly nops, except for FS
> +and GS.
> +
> +This offers an efficient way to reference a global pointer.
> +
> +The compiler has to generate special code to use these base registers,
> +or they can be accessed with inline assembler.
> +
> +	mov %gs:offset,%reg
> +	mov %fs:offset,%reg
> +
> +On 64bit code, FS is used to address the thread local segment (TLS), declared using
> +__thread.  The compiler then automatically generates the correct prefixes and
> +relocations to access these values.
> +
> +FS is normally managed by the runtime code or the threading library

                                                               library.

> +Overwriting it can break a lot of things (including syscalls and gdb),
> +but it can make sense to save/restore it for threading purposes.
> +
> +GS is freely available, but may need special (compiler or inline assembler)
> +code to use.
> +
> +Traditionally 64bit FS and GS could be set by the arch_prctl system call
> +
> +	arch_prctl(ARCH_SET_GS, value)
> +	arch_prctl(ARCH_SET_FS, value)
> +
> +[There was also an older method using modify_ldt(), inherited from 32bit,
> +but this is not discussed here.]
> +
> +However using a syscall is problematic for user space threading libraries

   However,

> +that want to context switch in user space. The whole point of them
> +is avoiding the overhead of a syscall. It's also cleaner for compilers
> +wanting to use the extra register to use instructions to write
> +it, or read it directly to compute addresses and offsets.
> +
> +Newer Intel CPUs (Ivy Bridge and later) added new instructions to directly
> +access these registers quickly from user context

                                            context.  {or context:}

> +
> +	RDFSBASE %reg	read the FS base	(or _readfsbase_u64)
> +	RDGSBASE %reg	read the GS base	(or _readgsbase_u64)
> +
> +	WRFSBASE %reg	write the FS base	(or _writefsbase_u64)
> +	WRGSBASE %reg	write the GS base	(or _writegsbase_u64)
> +
> +If you use the intrinsics include <immintrin.h> and set the -mfsgsbase option.

                  intrinsics,

> +
> +The instructions are supported by the CPU when the "fsgsbase" string is shown in
> +/proc/cpuinfo (or directly retrieved through the CPUID instruction,
> +7:0 (ebx), word 9, bit 0)

add ending '.' above.

> +
> +The instructions are only available to 64bit binaries.
> +
> +In addition the kernel needs to explicitly enable these instructions, as it
> +may otherwise not correctly context switch the state. Newer Linux
> +kernels enable this. When the kernel did not enable the instruction

                                        does not

> +they will fault with an #UD exception.

well, I would say "with a #UD exception."

> +
> +An FSGSBASE enabled kernel can be detected by checking the AT_HWCAP2

      FSGSBASE-enabled

> +bitmask in the aux vector. When the HWCAP2_FSGSBASE bit is set the
> +kernel supports FSGSBASE.
> +
> +	#include <sys/auxv.h>
> +	#include <elf.h>
> +
> +	/* Will be eventually in asm/hwcap.h */
> +	#define HWCAP2_FSGSBASE        (1 << 1)
> +
> +        unsigned val = getauxval(AT_HWCAP2);
> +        if (val & HWCAP2_FSGSBASE) {
> +                asm("wrgsbase %0" :: "r" (ptr));
> +        }
> +
> +No extra CPUID check needed as the kernel will not set this bit if the CPU

            CPUID check is needed

> +does not support it.
> +
> +gcc 6 will have special support to directly access data relative

"will have"? future? or:

   gcc 6 has special support

> +to fs/gs using the __seg_fs and __seg_gs address space pointer
> +modifiers.
> +
> +#ifndef __SEG_GS
> +#error "Need gcc 6 or later"
> +#endif
> +
> +struct gsdata {
> +	int a;
> +	int b;
> +} gsdata = { 1, 2 };
> +
> +int __seg_gs *valp = 0;		/* offset relative to GS */
> +
> +	/* Check if kernel supports FSGSBASE as above */
> +
> +	/* Set up new GS */
> +	asm("wrgsbase %0" :: "r" (&gsdata));
> +
> +	/* Now the global pointer can be used normally */
> +	printf("gsdata.a = %d\n", *valp);
> +
> +Andi Kleen
> 


-- 
~Randy
