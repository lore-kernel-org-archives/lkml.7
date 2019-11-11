Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C3AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2C220656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Dpyz2syb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKKQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:33:07 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46438 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:33:07 -0500
Received: by mail-il1-f196.google.com with SMTP id q1so11933797ile.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXka/KuS794Dw5agtvjYaCIxS4vPs1kS9p9tpGVlhWs=;
        b=Dpyz2sybErKJnRiJI+oI/8RzZr057t4Io5SDsa2SCJSgyJu3tNFx47Br+BgmWFWcRI
         MKuQrBXpVzYmqlTzNoHZ4aVyeJpnvWKBDEhbHUIROrywqaT3kDAc0KKWBbTGDTlZf2gg
         wVl3v1vdtVB5Tqpz13IwE8Y6Vn0FuFlzC8BVDMpMnpRCtwqx6Z/aCpal2e+BLUz2Om+U
         1TiuC0u+sL2gxfTHLgEkLBD+QyjuLM9WdbqfFsDLlE4gTvx73II+r+3FQxcBfKBaP62v
         Iq8Yb0ATVxUUNt8fS0F5UrA8k4CULCBz3q72dQ9Gz7neacwZPuPsMf7OjZ3egHnLSHml
         wI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXka/KuS794Dw5agtvjYaCIxS4vPs1kS9p9tpGVlhWs=;
        b=RnqahyYKqmTWPGJh7mXIju3ECHyOWht5qjRhR3Ga/6oC6wBK4HtAAJCsoUtRWDXfUf
         zcXPajdF083E0i4gkqG1324PHAM0GqNa9hKp1ahapHz/5MGH/qTRW9rqaeF3P7SDOTCB
         Q7wKrJyjdPT8T/Zp3i6bJUiUE8TQLKf0muwHn8Bj/6CIk/OzevrZE7sOBy2NLDKIQ3CT
         gIYBoVAOgpn8qSKasJaV5lfpbhjWBQ6KHPHqUJ1MA5F0BPLElINx0wCIYKQc7hjA57A7
         sAZvh3qj9jHUCPDMm8O/6LOyiSUBw6j9trH3BGxpRKRjd6q1mplC2QdsgTQNZXdY6jHx
         5/EQ==
X-Gm-Message-State: APjAAAWc7I17d41Dz1p6egN9g1iOG/VM5EKbnhlXI2h6D+LAh233TxCt
        a9Esg0GalTzeX6vd2E4aPDTvYmyqyGD1VXDi5tIEWg==
X-Google-Smtp-Source: APXvYqyU1J/dnwU0yZiBzytjrVyGPjjJECJa57lkbheRwH6jaY0nIH0p8Vt3kbMwQ5AnjKnYxs+0XJUBPmnFxiNv/ig=
X-Received: by 2002:a92:af98:: with SMTP id v24mr4703297ill.277.1573489985917;
 Mon, 11 Nov 2019 08:33:05 -0800 (PST)
MIME-Version: 1.0
References: <5DC960EB.9050503@huawei.com>
In-Reply-To: <5DC960EB.9050503@huawei.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 11 Nov 2019 08:32:54 -0800
Message-ID: <CAOesGMiEV_m32MRvN_-YmMmdL-8bm3DH95gnnCK5oAeyV1WqwA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range instructions
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, tangnianyao@huawei.com,
        xiexiangyou@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 5:24 AM Zhenyu Ye <yezhenyu2@huawei.com> wrote:
>
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This patch adds support for this feature.
> This is the second version of the patch.
>
> I traced the __flush_tlb_range() for a minute and get some statistical
> data as below:
>
>         PAGENUM         COUNT
>         1               34944
>         2               5683
>         3               1343
>         4               7857
>         5               838
>         9               339
>         16              933
>         19              427
>         20              5821
>         23              279
>         41              338
>         141             279
>         512             428
>         1668            120
>         2038            100
>
> Those data are based on kernel-5.4.0, where PAGENUM = end - start, COUNT
> shows number of calls to the __flush_tlb_range() in a minute. There only
> shows the data which COUNT >= 100. The kernel is started normally, and
> transparent hugepage is opened. As we can see, though most user TLBI
> ranges were 1 pages long, the num of long-range can not be ignored.
>
> The new feature of TLB range can improve lots of performance compared to
> the current implementation. As an example, flush 512 ranges needs only 1
> instruction as opposed to 512 instructions using current implementation.

But there's no indication whether this performs better or not in reality.

A perf report indicating, for example, cycles spent in TLBI on the two
versions would be a lot more valuable.

> And for a new hardware feature, support is better than not.

This is blatantly untrue. Complexity is added, and if there's no
evidence of benefit of said complexity, it is not something we want to
add.

> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
> ChangeLog v1 -> v2:
> - Change the main implementation of this feature.
> - Add some comments.
>
> ---
>  arch/arm64/include/asm/cpucaps.h  |  3 +-
>  arch/arm64/include/asm/sysreg.h   |  4 ++
>  arch/arm64/include/asm/tlbflush.h | 99 ++++++++++++++++++++++++++++++-
>  arch/arm64/kernel/cpufeature.c    | 10 ++++
>  4 files changed, 112 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index ac1dbca3d0cd..5b5230060e5b 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -54,7 +54,8 @@
>  #define ARM64_WORKAROUND_1463225               44
>  #define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM    45
>  #define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM   46
> +#define ARM64_HAS_TLBI_RANGE                   47
>
> -#define ARM64_NCAPS                            47
> +#define ARM64_NCAPS                            48
>
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6e919fafb43d..a6abbf2b067d 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -539,6 +539,7 @@
>                          ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
>
>  /* id_aa64isar0 */
> +#define ID_AA64ISAR0_TLB_SHIFT         56
>  #define ID_AA64ISAR0_TS_SHIFT          52
>  #define ID_AA64ISAR0_FHM_SHIFT         48
>  #define ID_AA64ISAR0_DP_SHIFT          44
> @@ -552,6 +553,9 @@
>  #define ID_AA64ISAR0_SHA1_SHIFT                8
>  #define ID_AA64ISAR0_AES_SHIFT         4
>
> +#define ID_AA64ISAR0_TLB_NI            0x0
> +#define ID_AA64ISAR0_TLB_RANGE         0x2
> +
>  /* id_aa64isar1 */
>  #define ID_AA64ISAR1_SB_SHIFT          36
>  #define ID_AA64ISAR1_FRINTTS_SHIFT     32
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index bc3949064725..f49bed7ecb68 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -59,6 +59,33 @@
>                 __ta;                                           \
>         })
>
> +/*
> + * This macro creates a properly formatted VA operand for the TLBI RANGE.
> + * The value bit assignments are:
> + *
> + * +----------+------+-------+-------+-------+----------------------+
> + * |   ASID   |  TG  | SCALE |  NUM  |  TTL  |        BADDR         |
> + * +-----------------+-------+-------+-------+----------------------+
> + * |63      48|47  46|45   44|43   39|38   37|36                   0|
> + *
> + * The address range is determined by below formula:
> + * [BADDR, BADDR + (NUM + 1) * 2^(5*SCALE + 1) * PAGESIZE)
> + *
> + */
> +#define __TLBI_VADDR_RANGE(addr, asid, tg, scale, num, ttl)    \
> +       ({                                                      \
> +               unsigned long __ta = (addr) >> PAGE_SHIFT;      \
> +               __ta |= (unsigned long)(ttl) << 37;             \
> +               __ta |= (unsigned long)(num) << 39;             \
> +               __ta |= (unsigned long)(scale) << 44;           \
> +               __ta |= (unsigned long)(tg) << 46;              \
> +               __ta |= (unsigned long)(asid) << 48;            \
> +               __ta;                                           \
> +       })
> +
> +#define TLB_RANGE_MASK_SHIFT 5
> +#define TLB_RANGE_MASK GENMASK_ULL(TLB_RANGE_MASK_SHIFT, 0)
> +
>  /*
>   *     TLB Invalidation
>   *     ================
> @@ -177,9 +204,9 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>   */
>  #define MAX_TLBI_OPS   PTRS_PER_PTE
>
> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
> -                                    unsigned long start, unsigned long end,
> -                                    unsigned long stride, bool last_level)
> +static inline void __flush_tlb_range_old(struct vm_area_struct *vma,
> +                                        unsigned long start, unsigned long end,
> +                                        unsigned long stride, bool last_level)

"old" and "new" are not very descriptive.

>  {
>         unsigned long asid = ASID(vma->vm_mm);
>         unsigned long addr;
> @@ -211,6 +238,72 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>         dsb(ish);
>  }
>
> +static inline void __flush_tlb_range_new(struct vm_area_struct *vma,
> +                                        unsigned long start, unsigned long end,
> +                                        unsigned long stride, bool last_level)
> +{
> +       int num = 0;
> +       int scale = 0;
> +       int ttl = 0;
> +       int tg = (PAGE_SHIFT - 12) / 2 + 1;

This is a constant, and shouldn't need to be a variable. You can push
it down to the addr generator macro.

> +       unsigned long asid = ASID(vma->vm_mm);
> +       unsigned long addr = 0;
> +       unsigned long offset = (end - start) >> PAGE_SHIFT;

"offset" confused me a lot here -- I think this variable really
describes number of pages to flush?

And, if so, you're probably off-by-one here: you need to round up
partial pages. As a matter of fact, you probably need to deal with
partial pages at both beginning and end.

> +       if (offset > (1UL << 21)) {
> +               flush_tlb_mm(vma->vm_mm);
> +               return;
> +       }

There's a comment that this limitation on iterative flushes is
arbitrary, and selected to not trigger soft lockups. At the very
least, you need a similar comment here as to why this code is needed.

> +       dsb(ishst);
> +
> +       /*
> +        * The minimum size of TLB RANGE is 2 PAGE;
> +        * Use normal TLB instruction to handle odd PAGEs
> +        */
> +       if (offset % 2 == 1) {
> +               addr = __TLBI_VADDR(start, asid);
> +               if (last_level) {
> +                       __tlbi(vale1is, addr);
> +                       __tlbi_user(vale1is, addr);
> +               } else {
> +                       __tlbi(vae1is, addr);
> +                       __tlbi_user(vae1is, addr);
> +               }
> +               start += 1 << PAGE_SHIFT;
> +               offset -= 1;
> +       }
> +
> +       while (offset > 0) {
> +               num = (offset & TLB_RANGE_MASK) - 1;
> +               if (num >= 0) {
> +                       addr = __TLBI_VADDR_RANGE(start, asid, tg,
> +                                                 scale, num, ttl);
> +                       if (last_level) {
> +                               __tlbi(rvale1is, addr);
> +                               __tlbi_user(rvale1is, addr);
> +                       } else {
> +                               __tlbi(rvae1is, addr);
> +                               __tlbi_user(rvae1is, addr);
> +                       }
> +                       start += (num + 1) << (5 * scale + 1) << PAGE_SHIFT;
> +               }
> +               scale++;

This is an odd way of doing the loop, by looping over the base and
linearly increasing the exponent.

Wouldn't it be easier to start with as high 'num' as possible as long
as the range ("offset" in your code) is larger than 2^5, and then do a
few iterations at the end for the smaller ranges?

> +               offset >>= TLB_RANGE_MASK_SHIFT;
> +       }
> +       dsb(ish);
> +}

The inner pieces of this loop, the special case at the beginning, and
the old implementation are all the same.

The main difference between now and before are:

1) How much you step forward on each iteration
2) How you calculate the address argument

Would it be better to just refactor the old code? You can calculate
the ranges the same way but just loop over them for non-8.4-TLBI
platforms.

No matter what, we really want some benchmarks and numbers to motivate
these changes. TLB operations tend to get on critical paths where
single cycles matter.

> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +                                    unsigned long start, unsigned long end,
> +                                    unsigned long stride, bool last_level)
> +{
> +       if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE))
> +               __flush_tlb_range_new(vma, start, end, stride, last_level);
> +       else
> +               __flush_tlb_range_old(vma, start, end, stride, last_level);
> +}
> +
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>                                    unsigned long start, unsigned long end)
>  {
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 80f459ad0190..bdefd8a34729 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1566,6 +1566,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>                 .min_field_value = 1,
>         },
>  #endif
> +       {
> +               .desc = "TLB range maintenance instruction",
> +               .capability = ARM64_HAS_TLBI_RANGE,
> +               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +               .matches = has_cpuid_feature,
> +               .sys_reg = SYS_ID_AA64ISAR0_EL1,
> +               .field_pos = ID_AA64ISAR0_TLB_SHIFT,
> +               .sign = FTR_UNSIGNED,
> +               .min_field_value = ID_AA64ISAR0_TLB_RANGE,
> +       },
>         {},
>  };
>
> --
> 2.19.1
>
>
