Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9721479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfDRFzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:55:14 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:60311 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:55:13 -0400
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0D19D20000A;
        Thu, 18 Apr 2019 05:55:03 +0000 (UTC)
Subject: Re: [PATCH v3 04/11] arm64, mm: Move generic mmap layout functions to
 mm
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20190417052247.17809-1-alex@ghiti.fr>
 <20190417052247.17809-5-alex@ghiti.fr>
 <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr>
Date:   Thu, 18 Apr 2019 01:55:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 1:17 AM, Kees Cook wrote:
> (
>
> On Wed, Apr 17, 2019 at 12:27 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> arm64 handles top-down mmap layout in a way that can be easily reused
>> by other architectures, so make it available in mm.
>> It then introduces a new config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> that can be set by other architectures to benefit from those functions.
>> Note that this new config depends on MMU being enabled, if selected
>> without MMU support, a warning will be thrown.
>>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/Kconfig                       |  8 ++++
>>   arch/arm64/Kconfig                 |  1 +
>>   arch/arm64/include/asm/processor.h |  2 -
>>   arch/arm64/mm/mmap.c               | 76 ------------------------------
>>   kernel/sysctl.c                    |  6 ++-
>>   mm/util.c                          | 74 ++++++++++++++++++++++++++++-
>>   6 files changed, 86 insertions(+), 81 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 33687dddd86a..7c8965c64590 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -684,6 +684,14 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
>>            and vice-versa 32-bit applications to call 64-bit mmap().
>>            Required for applications doing different bitness syscalls.
>>
>> +# This allows to use a set of generic functions to determine mmap base
>> +# address by giving priority to top-down scheme only if the process
>> +# is not in legacy mode (compat task, unlimited stack size or
>> +# sysctl_legacy_va_layout).
>> +config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> +       bool
>> +       depends on MMU
> I'd prefer the comment were moved to the help text. I would include
> any details about what the arch still needs to define. For example
> right now, I think STACK_RND_MASK is still needed. (Though I think a
> common one could be added for this series too...)


STACK_RND_MASK may be defined by the architecture or it can use the generic
definition in mm/util.c that I moved in patch 1/11 of this series. 
That's why I moved
randomize_stack_top in this file.
Regarding the help text, I agree that it does not seem to be frequent to 
place
comment above config like that, I'll let Christoph and you decide what's 
best. And I'll
add the possibility for the arch to define its own STACK_RND_MASK.


>
>> +
>>   config HAVE_COPY_THREAD_TLS
>>          bool
>>          help
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7e34b9eba5de..670719a26b45 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -66,6 +66,7 @@ config ARM64
>>          select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
>>          select ARCH_SUPPORTS_NUMA_BALANCING
>>          select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>>          select ARCH_WANT_FRAME_POINTERS
>>          select ARCH_HAS_UBSAN_SANITIZE_ALL
>>          select ARM_AMBA
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 5d9ce62bdebd..4de2a2fd605a 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -274,8 +274,6 @@ static inline void spin_lock_prefetch(const void *ptr)
>>                       "nop") : : "p" (ptr));
>>   }
>>
>> -#define HAVE_ARCH_PICK_MMAP_LAYOUT
>> -
>>   #endif
>>
>>   extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size */
>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>> index ac89686c4af8..c74224421216 100644
>> --- a/arch/arm64/mm/mmap.c
>> +++ b/arch/arm64/mm/mmap.c
>> @@ -31,82 +31,6 @@
>>
>>   #include <asm/cputype.h>
>>
>> -/*
>> - * Leave enough space between the mmap area and the stack to honour ulimit in
>> - * the face of randomisation.
>> - */
> This comment goes missing in the move...


True, I should have left it, sorry about that.


>
>> -#define MIN_GAP (SZ_128M)
>> -#define MAX_GAP        (STACK_TOP/6*5)
>> -
>> -static int mmap_is_legacy(struct rlimit *rlim_stack)
>> -{
>> -       if (current->personality & ADDR_COMPAT_LAYOUT)
>> -               return 1;
>> -
>> -       if (rlim_stack->rlim_cur == RLIM_INFINITY)
>> -               return 1;
>> -
>> -       return sysctl_legacy_va_layout;
>> -}
>> -
>> -unsigned long arch_mmap_rnd(void)
>> -{
>> -       unsigned long rnd;
>> -
>> -#ifdef CONFIG_COMPAT
>> -       if (is_compat_task())
>> -               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>> -       else
>> -#endif
>> -               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>> -       return rnd << PAGE_SHIFT;
>> -}
>> -
>> -static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>> -{
>> -       unsigned long gap = rlim_stack->rlim_cur;
>> -       unsigned long pad = stack_guard_gap;
>> -
>> -       /* Account for stack randomization if necessary */
>> -       if (current->flags & PF_RANDOMIZE)
>> -               pad += (STACK_RND_MASK << PAGE_SHIFT);
>> -
>> -       /* Values close to RLIM_INFINITY can overflow. */
>> -       if (gap + pad > gap)
>> -               gap += pad;
>> -
>> -       if (gap < MIN_GAP)
>> -               gap = MIN_GAP;
>> -       else if (gap > MAX_GAP)
>> -               gap = MAX_GAP;
>> -
>> -       return PAGE_ALIGN(STACK_TOP - gap - rnd);
>> -}
>> -
>> -/*
>> - * This function, called very early during the creation of a new process VM
>> - * image, sets up which VM layout function to use:
>> - */
>> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>> -{
>> -       unsigned long random_factor = 0UL;
>> -
>> -       if (current->flags & PF_RANDOMIZE)
>> -               random_factor = arch_mmap_rnd();
>> -
>> -       /*
>> -        * Fall back to the standard layout if the personality bit is set, or
>> -        * if the expected stack growth is unlimited:
>> -        */
>> -       if (mmap_is_legacy(rlim_stack)) {
>> -               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
>> -               mm->get_unmapped_area = arch_get_unmapped_area;
>> -       } else {
>> -               mm->mmap_base = mmap_base(random_factor, rlim_stack);
>> -               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>> -       }
>> -}
>> -
>>   /*
>>    * You really shouldn't be using read() or write() on /dev/mem.  This might go
>>    * away in the future.
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index e5da394d1ca3..eb3414e78986 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -269,7 +269,8 @@ extern struct ctl_table epoll_table[];
>>   extern struct ctl_table firmware_config_table[];
>>   #endif
>>
>> -#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
>> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> +    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>>   int sysctl_legacy_va_layout;
>>   #endif
>>
>> @@ -1564,7 +1565,8 @@ static struct ctl_table vm_table[] = {
>>                  .proc_handler   = proc_dointvec,
>>                  .extra1         = &zero,
>>          },
>> -#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
>> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> +    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>>          {
>>                  .procname       = "legacy_va_layout",
>>                  .data           = &sysctl_legacy_va_layout,
>> diff --git a/mm/util.c b/mm/util.c
>> index a54afb9b4faa..5c3393d32ed1 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -15,7 +15,12 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/userfaultfd_k.h>
>>   #include <linux/elf.h>
>> +#include <linux/elf-randomize.h>
>> +#include <linux/personality.h>
>>   #include <linux/random.h>
>> +#include <linux/processor.h>
>> +#include <linux/sizes.h>
>> +#include <linux/compat.h>
>>
>>   #include <linux/uaccess.h>
>>
>> @@ -313,7 +318,74 @@ unsigned long randomize_stack_top(unsigned long stack_top)
>>   #endif
>>   }
>>
>> -#if defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>> +#ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> +#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
> I think CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should select
> CONFIG_ARCH_HAS_ELF_RANDOMIZE. It would mean moving	


I don't think we should link those 2 features together: an architecture 
may want
topdown mmap and don't care about randomization right ?


> arch_randomize_brk() into this patch set too. For arm64 and arm, this
> is totally fine: they have identical logic. On MIPS this would mean
> bumping the randomization up: arm64 uses SZ_32M for 32-bit and SZ_1G
> for 64-bit. MIPS is 8M and 256M respectively. I don't see anything
> that indicates this would be a problem. *cross fingers*
>
> It looks like x86 would need bumping too: it uses 32M on both 32-bit
> and 64-bit. STACK_RND_MASK is the same though.
>
>> +unsigned long arch_mmap_rnd(void)
>> +{
>> +       unsigned long rnd;
>> +
>> +#ifdef CONFIG_COMPAT
>> +       if (is_compat_task())
>> +               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>> +       else
>> +#endif /* CONFIG_COMPAT */
> The ifdefs on is_compat_task() are not needed: is_compat_task()
> returns 0 in the !CONFIG_COMPAT case.


Actually, I had to add those ifdefs for mmap_rnd_compat_bits, not 
is_compat_task.


>
>> +               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>> +
>> +       return rnd << PAGE_SHIFT;
>> +}
>> +#endif /* CONFIG_ARCH_HAS_ELF_RANDOMIZE */
>> +
>> +static int mmap_is_legacy(struct rlimit *rlim_stack)
>> +{
>> +       if (current->personality & ADDR_COMPAT_LAYOUT)
>> +               return 1;
>> +
>> +       if (rlim_stack->rlim_cur == RLIM_INFINITY)
>> +               return 1;
>> +
>> +       return sysctl_legacy_va_layout;
>> +}
>> +
>> +#define MIN_GAP                (SZ_128M)
>> +#define MAX_GAP                (STACK_TOP / 6 * 5)
>> +
>> +static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>> +{
>> +       unsigned long gap = rlim_stack->rlim_cur;
>> +       unsigned long pad = stack_guard_gap;
>> +
>> +       /* Account for stack randomization if necessary */
>> +       if (current->flags & PF_RANDOMIZE)
>> +               pad += (STACK_RND_MASK << PAGE_SHIFT);
>> +
>> +       /* Values close to RLIM_INFINITY can overflow. */
>> +       if (gap + pad > gap)
>> +               gap += pad;
>> +
>> +       if (gap < MIN_GAP)
>> +               gap = MIN_GAP;
>> +       else if (gap > MAX_GAP)
>> +               gap = MAX_GAP;
>> +
>> +       return PAGE_ALIGN(STACK_TOP - gap - rnd);
>> +}
>> +
>> +void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>> +{
>> +       unsigned long random_factor = 0UL;
>> +
>> +       if (current->flags & PF_RANDOMIZE)
>> +               random_factor = arch_mmap_rnd();
>> +
>> +       if (mmap_is_legacy(rlim_stack)) {
>> +               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
>> +               mm->get_unmapped_area = arch_get_unmapped_area;
>> +       } else {
>> +               mm->mmap_base = mmap_base(random_factor, rlim_stack);
>> +               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>> +       }
>> +}
>> +#elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>>   void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>>   {
>>          mm->mmap_base = TASK_UNMAPPED_BASE;
>> --
>> 2.20.1
>>
>
> --
> Kees Cook
