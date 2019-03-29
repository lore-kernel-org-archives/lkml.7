Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCA92075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="NIiTgRY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfC2EoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:44:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfC2EoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:44:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so908687wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 21:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwSzlHmc8IX3ds8RISvZU7PRqJbl0dx5y2sJa3kXf90=;
        b=NIiTgRY6zF2jTV9pE6V1O71q4l4DV0q3UCSzuA4DrAOgkb8ktGYpWG+SgOKTcL5fwX
         IkGnk2G31PyyKNuv28Ot8mMu6XgMoisE7yalXgtgYbiHoMPq3P6sTp2VOoyj43Ma/1bc
         N5nVr4idKnROMceMm5jhB5lmpbfgSpFR96UxyO4VN87LSL63RwWJA82ukt3JdKNf5WIX
         +Om56aTEF9PJBHubwtWOAHmoSnJkyDSBljQ77rIASSqx794TsmAA321W92mSrgzF7mPy
         BGk6xRJOLuIFxDFjUBmpiASTBXpozsaMnHvH9xItaLD/SZRH/beT+YAVjnhy91XvRB2V
         Sb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwSzlHmc8IX3ds8RISvZU7PRqJbl0dx5y2sJa3kXf90=;
        b=L6eSxigz7+kEr12YmlxINnRMOaZO6AwFMvn6G7TPP+bM5h6otU5XKn5+YtFCiNUSKh
         vUi+Ql4t/SV+qEAxCR/ZfMG+mJtCykx0TiKtM7nrQXjlyQKiFkJreZAceKcBm4d/FP/V
         av/UEWad1ImkoKVsvLBuulfo+33Mjin9ZWzlSykjiMxtTSFBKOOLn/hl5kAZ8yBq+Qea
         CRpnfooI94S42ksARNN/1b7nL7CIBPTlXH7YKo+1nvtRGbqC4cr8cvh/EeKLyxdLrAY4
         F+IxaC8lKfS4Hxr0WwhtshZZP8TuJiLqutGmRk28pA/TkPaADNqpiHQOSFUFeommUkyd
         mwNA==
X-Gm-Message-State: APjAAAXutSFDnDkXJZDmfIdyHiyyvYmGPTY1WxvE8y+KVxRudYT7fINJ
        wTUnQdhA0WmdRNQ03o+azbKabo12LGJ10Ztg/kRoTw==
X-Google-Smtp-Source: APXvYqwGVggRG8Q5bBnlQoAHH8AtZN4bY+mh5pv9roTKv5cHO4YLLu60i5nJDIUciQUatm4zBSRyJtvMEdhjywHoWYE=
X-Received: by 2002:a5d:5108:: with SMTP id s8mr26980874wrt.99.1553834650279;
 Thu, 28 Mar 2019 21:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190328063211.13052-1-anup.patel@wdc.com> <b6872ed0-4b8c-ca1d-4ee0-b01324e40da5@garyguo.net>
 <CAAhSdy0muQe23Fz2yA2VP_BTNB9h3U-z7P9TREmSf1n0yu1Xig@mail.gmail.com> <4f290078-54bd-62e2-6356-d700e53e6315@garyguo.net>
In-Reply-To: <4f290078-54bd-62e2-6356-d700e53e6315@garyguo.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 Mar 2019 10:13:58 +0530
Message-ID: <CAAhSdy3E0CBTFFAdSB=oqn10bh=EqBqRObhcqknLMSD6BZa0WA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Implement ASID allocator
To:     Gary Guo <gary@garyguo.net>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 8:00 PM Gary Guo <gary@garyguo.net> wrote:
>
>
>
> On 28/03/2019 14:09, Anup Patel wrote:
> > On Thu, Mar 28, 2019 at 7:07 PM Gary Guo <gary@garyguo.net> wrote:
> >>
> >> Hi Anup,
> >>
> >> The code still does not use ASID in TLB flush routines. Without this
> >> added the code does not boot on systems with true ASID support.
> >
> > Can you elaborate why flush by ASID is need and flush_tlb_all() will
> > not work?
>  >
> flush_tlb_all() will work, but not flush_tlb_mm, flush_tlb_page,
> flush_tlb_range. When we want to flush something related to a MM we need
> to get its ASID and SFENCE with that ASID.

Please don't make self contradicting statements without looking at code.

The flush_tlb_all()/local_flush_tlb_all() are only suitable here.

The ASID space is global across CPUs so when we run-out of ASIDs
we have to flush complete TLB for all CPUs because we cannot be
certain what all ASIDs where used on each CPU.

> >>
> >> We also need to consider the case of CONTEXTID overflow on 32-bit
> >> systems. 32-bit CONTEXTID may overflow in a month time.
> >
> > On 32bit systems, upper 24bits of CONTEXTID will be VERSION and
> > lower 8bits will be HW ASID.
> >
> > Can you elaborate how did you reach to conclusion that CONTEXID
> > will overflow in a month time?
> >
> Assume a case where we have 256 processes to run, and 8 cores,
> 2^32/(250Hz)/8 = 24 days.

I think you are confusing CONTEXTID with CONTEXTID register in
ARMv7/ARMv8 world.

The CONTEXTID is a software entity that we assigne to a mmu_context

It has two parts:
1. Lower bits are ASID that we will programe in SATP CSR
2. Upper bits is the current version number

Whenever we run-out ASIDs in ASID bitmap at time of creating new
CONTEXTID, we simply flush the complete ASID bitmap and atomically
increment version number.

The most important thing here is that version number before and after
ASID bitmap flush should be different so that all CPU see the change
in current version after a ASID bitmap flush.

It is totally fine if the current version number rolls-over as long as we
get different current version after ASID bitmap flush.

> >>
> >> Please all see my inline comments.
> >>
> >> Best,
> >> Gary
> >>
> >> On 28/03/2019 06:32, Anup Patel wrote:
> >>> Currently, we do local TLB flush on every MM switch. This is very harsh
> >>> on performance because we are forcing page table walks after every MM
> >>> switch.
> >>>
> >>> This patch implements ASID allocator for assigning an ASID to every MM
> >>> context. The number of ASIDs are limited in HW so we create a logical
> >>> entity named CONTEXTID for assigning to MM context. The lower bits of
> >>> CONTEXTID are ASID and upper bits are VERSION number. The number of
> >>> usable ASID bits supported by HW are detected at boot-time by writing
> >>> 1s to ASID bits in SATP CSR. This means last ASID is always reserved
> >>> because it is used for initial MM context.
> >>>
> >>> We allocate new CONTEXTID on first MM switch for a MM context where
> >>> the ASID is allocated from an ASID bitmap and VERSION is provide by
> >>> an atomic counter. At time of allocating new CONTEXTID, if we run out
> >>> of available ASIDs then:
> >>> 1. We flush the ASID bitmap
> >>> 2. Increment current VERSION atomic counter
> >>> 3. Re-allocate ASID from ASID bitmap
> >>> 4. Flush TLB on all CPUs
> >>> 5. Try CONTEXTID re-assignment on all CPUs
> >>>
> >>> Using above approach, we have virtually infinite CONTEXTIDs on-top-of
> >>> limited number of HW ASIDs. This approach is inspired from ASID allocator
> >>> used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall,
> >>> this ASID allocator helps us reduce rate of local TLB flushes on every
> >>> CPU thereby increasing performance.
> >>>
> >>> This patch is tested on QEMU/virt machine and SiFive Unleashed board.
> >>> On QEMU/virt machine, we see 10% (approx) performance improvement with
> >>> SW emulated TLBs provided by QEMU. Unfortunately, ASID bits of SATP CSR
> >>> are not implemented on SiFive Unleashed board so we don't see any change
> >>> in performance.
> >>>
> >>> Signed-off-by: Gary Guo <gary@garyguo.net>
> >> Could you add a Co-developed-by line in addition to Signed-off-by as
> >> well? Thanks.
> >
> > Sure, I will add.
> >
> >>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >>> ---
> >>> Changes since v1:
> >>> - We adapt good aspects from Gary Guo's ASID allocator implementation
> >>>     and provide due credit to him by adding his SoB.
> >>> - Track ASIDs active during context flush and mark them as reserved
> >>> - Set ASID bits to all 1s to simplify number of ASID bit detection
> >>> - Use atomic_long_t instead of atomic64_t for being 32bit friendly
> >>> - Use unsigned long instead of u64 for being 32bit friendly
> >>> - Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
> >>>     of context flush
> >>>
> >>> This patch is based on Linux-5.1-rc2 and TLB flush cleanup patches v4
> >>> from Gary Guo. It can be also found in riscv_asid_allocator_v2 branch
> >>> of https://github.com/avpatel/linux.git
> >>> ---
> >>>    arch/riscv/include/asm/csr.h         |   6 +
> >>>    arch/riscv/include/asm/mmu.h         |   1 +
> >>>    arch/riscv/include/asm/mmu_context.h |   1 +
> >>>    arch/riscv/kernel/head.S             |   2 +
> >>>    arch/riscv/mm/context.c              | 249 +++++++++++++++++++++++++--
> >>>    5 files changed, 247 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> >>> index 28a0d1cb374c..ce18ab8f53ed 100644
> >>> --- a/arch/riscv/include/asm/csr.h
> >>> +++ b/arch/riscv/include/asm/csr.h
> >>> @@ -45,10 +45,16 @@
> >>>    #define SATP_PPN     _AC(0x003FFFFF, UL)
> >>>    #define SATP_MODE_32 _AC(0x80000000, UL)
> >>>    #define SATP_MODE    SATP_MODE_32
> >>> +#define SATP_ASID_BITS       9
> >>> +#define SATP_ASID_SHIFT      22
> >>> +#define SATP_ASID_MASK       _AC(0x1FF, UL)
> >>>    #else
> >>>    #define SATP_PPN     _AC(0x00000FFFFFFFFFFF, UL)
> >>>    #define SATP_MODE_39 _AC(0x8000000000000000, UL)
> >>>    #define SATP_MODE    SATP_MODE_39
> >>> +#define SATP_ASID_BITS       16
> >>> +#define SATP_ASID_SHIFT      44
> >>> +#define SATP_ASID_MASK       _AC(0xFFFF, UL)
> >>>    #endif
> >>>
> >>>    /* Interrupt Enable and Interrupt Pending flags */
> >>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> >>> index 5df2dccdba12..42a9ca0fe1fb 100644
> >>> --- a/arch/riscv/include/asm/mmu.h
> >>> +++ b/arch/riscv/include/asm/mmu.h
> >>> @@ -18,6 +18,7 @@
> >>>    #ifndef __ASSEMBLY__
> >>>
> >>>    typedef struct {
> >>> +     atomic_long_t id;
> >>>        void *vdso;
> >>>    #ifdef CONFIG_SMP
> >>>        /* A local icache flush is needed before user execution can resume. */
> >>> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> >>> index bf4f097a9051..ba6ab35c18dc 100644
> >>> --- a/arch/riscv/include/asm/mmu_context.h
> >>> +++ b/arch/riscv/include/asm/mmu_context.h
> >>> @@ -30,6 +30,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
> >>>    static inline int init_new_context(struct task_struct *task,
> >>>        struct mm_struct *mm)
> >>>    {
> >>> +     atomic_long_set(&(mm)->context.id, 0);
> >> Parenthesis around mm isn't necessary
> >
> > Okay, I will update.
> >
> >>>        return 0;
> >>>    }
> >>>
> >>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> >>> index fe884cd69abd..c3f9adc0d054 100644
> >>> --- a/arch/riscv/kernel/head.S
> >>> +++ b/arch/riscv/kernel/head.S
> >>> @@ -95,6 +95,8 @@ relocate:
> >>>        la a2, swapper_pg_dir
> >>>        srl a2, a2, PAGE_SHIFT
> >>>        li a1, SATP_MODE
> >>> +     li a0, (SATP_ASID_MASK << SATP_ASID_SHIFT)
> >>> +     or a1, a1, a0
> >>>        or a2, a2, a1
> >>>
> >>>        /*
> >>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> >>> index 0f787bcd3a7a..1205d33d1b1b 100644
> >>> --- a/arch/riscv/mm/context.c
> >>> +++ b/arch/riscv/mm/context.c
> >>> @@ -2,13 +2,209 @@
> >>>    /*
> >>>     * Copyright (C) 2012 Regents of the University of California
> >>>     * Copyright (C) 2017 SiFive
> >>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> >>>     */
> >>>
> >>> +#include <linux/bitops.h>
> >>>    #include <linux/mm.h>
> >>> +#include <linux/slab.h>
> >>>
> >>>    #include <asm/tlbflush.h>
> >>>    #include <asm/cacheflush.h>
> >>>
> >>> +static bool use_asid_allocator;
> >>> +static unsigned long asid_bits;
> >>> +static unsigned long num_asids;
> >>> +static unsigned long asid_mask;
> >>> +static unsigned long first_version;
> >>> +
> >>> +static atomic_long_t current_version;
> >>> +
> >>> +static DEFINE_RAW_SPINLOCK(context_lock);
> >>> +static unsigned long *context_asid_map;
> >>> +
> >>> +static DEFINE_PER_CPU(atomic_long_t, active_context);
> >>> +static DEFINE_PER_CPU(unsigned long, reserved_context);
> >>> +
> >>> +static bool check_update_reserved_context(unsigned long cntx,
> >>> +                                       unsigned long newcntx)
> >>> +{
> >>> +     int cpu;
> >>> +     bool hit = false;
> >>> +
> >>> +     /*
> >>> +      * Iterate over the set of reserved CONTEXT looking for a match.
> >>> +      * If we find one, then we can update our mm to use new CONTEXT
> >>> +      * (i.e. the same CONTEXT in the current_version) but we can't
> >>> +      * exit the loop early, since we need to ensure that all copies
> >>> +      * of the old CONTEXT are updated to reflect the mm. Failure to do
> >>> +      * so could result in us missing the reserved CONTEXT in a future
> >>> +      * version.
> >>> +      */
> >>> +     for_each_possible_cpu(cpu) {
> >>> +             if (per_cpu(reserved_context, cpu) == cntx) {
> >>> +                     hit = true;
> >>> +                     per_cpu(reserved_context, cpu) = newcntx;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     return hit;
> >>> +}
> >>> +
> >>> +/* Note: must be called with context_lock held */
> >>> +static void __flush_context(void)
> >>> +{
> >>> +     int i;
> >>> +     unsigned long cntx;
> >>> +
> >>> +     /* Update the list of reserved ASIDs and the ASID bitmap. */
> >>> +     bitmap_clear(context_asid_map, 0, num_asids);
> >>> +
> >>> +     /* Mark already acitve ASIDs as used */
> >>> +     for_each_possible_cpu(i) {
> >>> +             cntx = atomic_long_xchg_relaxed(&per_cpu(active_context, i), 0);
> >>> +             /*
> >>> +              * If this CPU has already been through a rollover, but
> >>> +              * hasn't run another task in the meantime, we must preserve
> >>> +              * its reserved CONTEXT, as this is the only trace we have of
> >>> +              * the process it is still running.
> >>> +              */
> >>> +             if (cntx == 0)
> >>> +                     cntx = per_cpu(reserved_context, i);
> >>> +
> >>> +             __set_bit(cntx & asid_mask, context_asid_map);
> >>> +             per_cpu(reserved_context, i) = cntx;
> >>> +     }
> >>> +
> >>> +     /* Mark last ASID as used because it is used at boot-time */
> >>> +     __set_bit(asid_mask, context_asid_map);
> >> Looks unnecessary as we always start find_next_zero_bit from idx 1.
> >
> > This is to ensure that we never use last ASID >
> Uh, sorry. I misread. But we surely can use the last ASID after the
> first rollover?
> >>> +} >>> +
> >>> +/* Note: must be called with context_lock held */
> >>> +static unsigned long __new_context(struct mm_struct *mm,
> >>> +                                bool *need_tlb_flush)
> >>> +{
> >>> +     static u32 cur_idx = 1;
> >>> +     unsigned long cntx = atomic_long_read(&mm->context.id);
> >>> +     unsigned long asid, ver = atomic_long_read(&current_version);
> >>> +
> >>> +     if (cntx != 0) {
> >>> +             unsigned long newcntx = ver | (cntx & ~asid_mask);
> >> Shouldn't this be cntx & asid_mask ?
> >
> > Ahh, typo. Thanks for catching.
> >
> >>> +
> >>> +             /*
> >>> +              * If our current CONTEXT was active during a rollover, we
> >>> +              * can continue to use it and this was just a false alarm.
> >>> +              */
> >>> +             if (check_update_reserved_context(cntx, newcntx))
> >>> +                     return newcntx;
> >>> +
> >>> +             /*
> >>> +              * We had a valid CONTEXT in a previous life, so try to
> >>> +              * re-use it if possible.
> >>> +              */
> >>> +             if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
> >>> +                     return newcntx;
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Allocate a free ASID. If we can't find one then increment
> >>> +      * current_version and flush all ASIDs.
> >>> +      */
> >>> +     asid = find_next_zero_bit(context_asid_map, num_asids, cur_idx);
> >>> +     if (asid != num_asids)
> >>> +             goto set_asid;
> >>> +
> >>> +     /* We're out of ASIDs, so increment current_version */
> >>> +     ver = atomic_long_add_return_relaxed(first_version, &current_version);
> >>> +
> >>> +     /* Flush everything  */
> >>> +     __flush_context();
> >>> +     *need_tlb_flush = true;
> >>> +
> >>> +     /* We have more ASIDs than CPUs, so this will always succeed */
> >>> +     asid = find_next_zero_bit(context_asid_map, num_asids, 1);
> >>> +
> >>> +set_asid:
> >>> +     __set_bit(asid, context_asid_map);
> >>> +     cur_idx = asid;
> >>> +     return asid | ver;
> >>> +}
> >>> +
> >>> +static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
> >>> +{
> >>> +     unsigned long flags;
> >>> +     bool need_tlb_flush = false;
> >>> +     unsigned long cntx, old_active_cntx;
> >>> +
> >>> +     cntx = atomic_long_read(&mm->context.id);
> >>> +
> >>> +     /*
> >>> +      * If our active_context is non-zero and the context matches the
> >>> +      * current_version, then we update the active_context entry with a
> >>> +      * relaxed cmpxchg.
> >>> +      *
> >>> +      * Following is how we handle racing with a concurrent rollover:
> >>> +      *
> >>> +      * - We get a zero back from the cmpxchg and end up waiting on the
> >>> +      *   lock. Taking the lock synchronises with the rollover and so
> >>> +      *   we are forced to see the updated verion.
> >>> +      *
> >>> +      * - We get a valid context back from the cmpxchg then we continue
> >>> +      *   using old ASID because __flush_context() would have marked ASID
> >>> +      *   of active_context as used and next context switch we will allocate
> >>> +      *   new context.
> >>> +      */
> >>> +     old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
> >>> +     if (old_active_cntx &&
> >>> +         !((cntx ^ atomic_long_read(&current_version)) >> asid_bits) &&
> >> This looks hard to read. Probably
> >> (cntx &~ asid_mask) == atomic_long_read(&current_version)
> >> is clearer.
> >
> > No issues, I am fine with either way. I will update.
> >
> >>> +         atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
> >>> +                                     old_active_cntx, cntx))
> >>> +             goto switch_mm_fast;
> >>> +
> >>> +     raw_spin_lock_irqsave(&context_lock, flags);
> >> Any reason that we prefer raw_ here?
> >>> +
> >>> +     /* Check that our ASID belongs to the current_version. */
> >>> +     cntx = atomic_long_read(&mm->context.id);
> >>> +     if ((cntx ^ atomic_long_read(&current_version)) >> asid_bits) {
> >> Same as above, probably
> >> (cntx &~ asid_mask) != atomic_long_read(&current_version)
> >> makes more sense.
> >>> +             cntx = __new_context(mm, &need_tlb_flush);
> >>> +             atomic_long_set(&mm->context.id, cntx);
> >>> +     }
> >>> +
> >>> +     atomic_long_set(&per_cpu(active_context, cpu), cntx);
> >>> +
> >>> +     raw_spin_unlock_irqrestore(&context_lock, flags);
> >>> +
> >>> +switch_mm_fast:
> >>> +     /*
> >>> +      * Use the old spbtr name instead of using the current satp
> >>> +      * name to support binutils 2.29 which doesn't know about the
> >>> +      * privileged ISA 1.10 yet.
> >>> +      */
> >>> +     csr_write(sptbr, virt_to_pfn(mm->pgd) |
> >>> +               ((cntx & asid_mask) << SATP_ASID_SHIFT) |
> >>> +               SATP_MODE);
> >>> +
> >>> +     if (need_tlb_flush)
> >>> +             flush_tlb_all();
> >> I think your intention here is to avoid calling flush_tlb_all when IRQs
> >> are off in the critical region. However, switch_mm will be called from
> >> scheduler as well which also turn irqs off, so this still cause issue. I
> >> think a better way is to force flush_tlb_all to use SBI when IRQs are
> >> off. What do you think?
> >
> > We are still waiting for OpenSBI to provide complete implementation.
> >
> > I agree that we should prefer SBI based remote TLB flush all here. Let's
> > wait for more comments.
> >
> I prefer SBI as well. Can you reopen OpenSBI issue #87 to track the
> progress until we can proper handle race conditions in OpenSBI? Once
> that's completed I'll drop the IPI patch and we can safely do
> flush_tlb_all within __flush_context.

I did various testing. We definetly run into kernel crash if we use
flush_tlb_all().

Based on comment about local_flush_tlb_all() used in ARM/ARM64. I dig
throught the specs. Let me clarify to everyone, The local_flush_tlb_all() on
ARM64 uses __tlbi(vmalle1) and flush_tlb_all() on ARM64 uses __tlbi(vmalle1is).
The __tlbi(vmalle1) will only flush TLB for current CPU whereas
__tlbi(vmalle1is)
will flush TLB accross CPUs.

The Linux ARM64 implementation of ASID allocator uses a lazy TLB flush
by doing local_flush_tlb_all() on each CPU. We should also follow same
apporach to avoid unnecessary IPI overhead at Linux-level or at OpenSBI
level.

I will use lazy TLB flush just like it was done in v1 patch.

If you think lazy TLB flush will not work for your "prorietary" HW then please
investigae further with open-mind because lazy TLB flushing is a proven
approach in Linux ARM/ARM64 world.

> >>> +}
> >>> +
> >>> +static void set_mm_noasid(struct mm_struct *mm)
> >>> +{
> >>> +     /*
> >>> +      * Use the old spbtr name instead of using the current satp
> >>> +      * name to support binutils 2.29 which doesn't know about the
> >>> +      * privileged ISA 1.10 yet.
> >>> +      */
> >>> +     csr_write(sptbr, virt_to_pfn(mm->pgd) | SATP_MODE);
> >>> +
> >>> +     /*
> >>> +      * sfence.vma after SATP write. We call it on MM context instead of
> >>> +      * calling local_flush_tlb_all to prevent global mappings from being
> >>> +      * affected.
> >>> +      */
> >>> +     local_flush_tlb_mm(mm);
> >>> +}
> >>> +
> >>>    /*
> >>>     * When necessary, performs a deferred icache flush for the given MM context,
> >>>     * on the local CPU.  RISC-V has no direct mechanism for instruction cache
> >>> @@ -58,20 +254,49 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >>>        cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >>>        cpumask_set_cpu(cpu, mm_cpumask(next));
> >>>
> >>> -     /*
> >>> -      * Use the old spbtr name instead of using the current satp
> >>> -      * name to support binutils 2.29 which doesn't know about the
> >>> -      * privileged ISA 1.10 yet.
> >>> -      */
> >>> -     csr_write(sptbr, virt_to_pfn(next->pgd) | SATP_MODE);
> >>> +     if (use_asid_allocator)
> >>> +             set_mm_asid(next, cpu);
> >>> +     else
> >>> +             set_mm_noasid(next);
> >>> +
> >>> +     flush_icache_deferred(next);
> >>> +}
> >>> +
> >>> +static int asids_init(void)
> >>> +{
> >>> +     /* Figure-out number of ASID bits in HW */
> >>> +     asid_bits = (csr_read(sptbr) >> SATP_ASID_SHIFT) & SATP_ASID_MASK;
> >>> +     asid_bits = fls_long(asid_bits);
> >>> +
> >>> +     /* Pre-compute ASID details */
> >>> +     num_asids = 1 << asid_bits;
> >>> +     asid_mask = num_asids - 1;
> >>> +     first_version = num_asids;
> >> Is there any reason we want to have two set-once variables with same value?
> >
> > Yap, "first_version" looks redundant. I will update.
> >
> >>>
> >>>        /*
> >>> -      * sfence.vma after SATP write. We call it on MM context instead of
> >>> -      * calling local_flush_tlb_all to prevent global mappings from being
> >>> -      * affected.
> >>> +      * Use ASID allocator only if number of HW ASIDs are
> >>> +      * at-least twice more than CPUs
> >>>         */
> >>> -     local_flush_tlb_mm(next);
> >>> +     use_asid_allocator =
> >>> +             (num_asids <= (2 * num_possible_cpus())) ? false : true;
> >>>
> >>> -     flush_icache_deferred(next);
> >>> -}
> >>> +     /* Setup ASID allocator if available */
> >>> +     if (use_asid_allocator) {
> >>> +             atomic_long_set(&current_version, first_version);
> >>>
> >>> +             context_asid_map = kcalloc(BITS_TO_LONGS(num_asids),
> >>> +                                sizeof(*context_asid_map), GFP_KERNEL);
> >>> +             if (!context_asid_map)
> >>> +                     panic("Failed to allocate bitmap for %lu ASIDs\n",
> >>> +                           num_asids);
> >>> +
> >>> +             __set_bit(asid_mask, context_asid_map);
> >>> +
> >>> +             pr_info("ASID allocator using %lu entries\n", num_asids);
> >>> +     } else {
> >> If we decide not to use ASID allocator, we will need to set ASID field
> >> to zero on *all harts* before we do our first switch_mm. Otherwise we
> >> will end up a hart running non-zero ASID and another running zero ASID
> >> with different page table.
> >
> > Yes, I saw that in your implementation but for better readability and
> > debugability. I have preserved asid_bits that we computed and added
> > separate use_asid_allocator flag.
> I didn't say I'm against having use_asid_allocator.
> >
> > In future, I plan to show asid_bits in /proc/cpuinfo as-well.
> >
> >>> +             pr_info("ASID allocator disabled\n");
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +early_initcall(asids_init);
> >>>
> >
> > Regards,
> > Anup
> >
