Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1282C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F00204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfDRGGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:06:17 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50541 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfDRGGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:06:16 -0400
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6DE99100004;
        Thu, 18 Apr 2019 06:06:06 +0000 (UTC)
Subject: Re: [PATCH v3 07/11] arm: Use generic mmap top-down layout
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
        Linux-MM <linux-mm@kvack.org>
References: <20190417052247.17809-1-alex@ghiti.fr>
 <20190417052247.17809-8-alex@ghiti.fr>
 <CAGXu5jLhZS3+tiDCMsQQ=s9_f5ZBTLEYfcSfmtDRYv8Pp-KF2Q@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <5d0385b0-c03b-f4c7-45fa-4d97677cf816@ghiti.fr>
Date:   Thu, 18 Apr 2019 02:06:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLhZS3+tiDCMsQQ=s9_f5ZBTLEYfcSfmtDRYv8Pp-KF2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 1:28 AM, Kees Cook wrote:
> On Wed, Apr 17, 2019 at 12:30 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> arm uses a top-down mmap layout by default that exactly fits the generic
>> functions, so get rid of arch specific code and use the generic version
>> by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Kees Cook <keescook@chromium.org>


Thanks !


>
> -Kees
>
>> ---
>>   arch/arm/Kconfig                 |  1 +
>>   arch/arm/include/asm/processor.h |  2 --
>>   arch/arm/mm/mmap.c               | 62 --------------------------------
>>   3 files changed, 1 insertion(+), 64 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 850b4805e2d1..f8f603da181f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -28,6 +28,7 @@ config ARM
>>          select ARCH_SUPPORTS_ATOMIC_RMW
>>          select ARCH_USE_BUILTIN_BSWAP
>>          select ARCH_USE_CMPXCHG_LOCKREF
>> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>          select ARCH_WANT_IPC_PARSE_VERSION
>>          select BUILDTIME_EXTABLE_SORT if MMU
>>          select CLONE_BACKWARDS
>> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
>> index 57fe73ea0f72..944ef1fb1237 100644
>> --- a/arch/arm/include/asm/processor.h
>> +++ b/arch/arm/include/asm/processor.h
>> @@ -143,8 +143,6 @@ static inline void prefetchw(const void *ptr)
>>   #endif
>>   #endif
>>
>> -#define HAVE_ARCH_PICK_MMAP_LAYOUT
>> -
>>   #endif
>>
>>   #endif /* __ASM_ARM_PROCESSOR_H */
>> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
>> index 0b94b674aa91..b8d912ac9e61 100644
>> --- a/arch/arm/mm/mmap.c
>> +++ b/arch/arm/mm/mmap.c
>> @@ -17,43 +17,6 @@
>>          ((((addr)+SHMLBA-1)&~(SHMLBA-1)) +      \
>>           (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
>>
>> -/* gap between mmap and stack */
>> -#define MIN_GAP                (128*1024*1024UL)
>> -#define MAX_GAP                ((STACK_TOP)/6*5)
>> -#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
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
>>   /*
>>    * We need to ensure that shared mappings are correctly aligned to
>>    * avoid aliasing issues with VIPT caches.  We need to ensure that
>> @@ -181,31 +144,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>>          return addr;
>>   }
>>
>> -unsigned long arch_mmap_rnd(void)
>> -{
>> -       unsigned long rnd;
>> -
>> -       rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>> -
>> -       return rnd << PAGE_SHIFT;
>> -}
>> -
>> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>> -{
>> -       unsigned long random_factor = 0UL;
>> -
>> -       if (current->flags & PF_RANDOMIZE)
>> -               random_factor = arch_mmap_rnd();
>> -
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
>>    * You really shouldn't be using read() or write() on /dev/mem.  This
>>    * might go away in the future.
>> --
>> 2.20.1
>>
>
