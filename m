Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D19217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="sbNtEop4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfDYFDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:03:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45968 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfDYFDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:03:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so28260875wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rPpif/lO1PgqKAdAimPxnVxznsaBoltRg8AdMlTuGsg=;
        b=sbNtEop4KViNHA7r4AjtxCzUrGkvjSuHLv5n7mF5ZH2y/VPoKLf9U2Fx1485oJ2Yg2
         lIEMEMbujpGAhlnOOto2/JXpdVEm5MrD+S98ThHb5ZskrnNkW2ErQBH8h348paWkjdOH
         pm0pvVCfCCCJnrs1meEvTc7Ofn0o0cgueQrup3pbtr0GnjRLe9ibEqAEkcGBJxoJdoKR
         7H8+I/KLGQcCThb2N20mGWaJJ56jfksrrd3XT7gReVgA/267CpTMVgRHaW4W9xQ15YoJ
         4zNHPBbFO0TI3Ju34tLXTwCAryU/tGoLucoCAyrwPC7orB+bBGVUM0FF8aQjYt+KQugX
         7xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rPpif/lO1PgqKAdAimPxnVxznsaBoltRg8AdMlTuGsg=;
        b=o/LG40S34v9TFJMjIVXDN69+dwMZdASB5Aeruxa7z2J8R+3gDYnRCPxWCyMxHUTiOM
         DRmEqaH6B/VZaWok7mIWwMniN9HnJr9yxOiBnuhPV7TSzy7VxkDB/8q2DSOMG6M1dQjE
         +cwgCNmDaS0baD1Hmgaqbf4qDu2CGaAjuoFcTggjTex4ybkxUrX1bj3FIoXGWLYEd/VU
         rAasZJtNjvzPrwxq2JBA38R4OeIU4WBKYPP+L21dDJIN9KNy/I/lOhdXEjK8KjSePqF4
         OczRlmnvVoouLRfAkAPRIH2dfYnRzLpxKpc6GIkOAcHj8faRMwTCFAiXcz4ZzqnL36P6
         eRJQ==
X-Gm-Message-State: APjAAAUkxJ29vh+vAvvrpIxbon5oAk8SnZmGT5+FWl6x3MiZrUzX/oPE
        ltj6m+2EyV3tNi1ZM1STpK0Kse4zuM7bd9JPOchITA==
X-Google-Smtp-Source: APXvYqzuiD5jhy+5bFH7/Y7F+EWVCeBICZBlfcYVE+PQAadsGEnVWl3giZ5ERkIRRgXG/HdluyaS7JEDHdvQwGrtefQ=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr25441619wrp.9.1556168593325;
 Wed, 24 Apr 2019 22:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190329045111.14040-1-anup.patel@wdc.com> <mhng-204d1c25-476e-4b47-89b8-ef78fde61c3f@palmer-si-x1e>
 <CAAhSdy3vOWaV_pwRBX1fN5Odt+_YKAo_dC67wTPuZxgxG2chwA@mail.gmail.com> <LO2P265MB08478F05EFDD5C0224B22677D63D0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO2P265MB08478F05EFDD5C0224B22677D63D0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 25 Apr 2019 10:33:02 +0530
Message-ID: <CAAhSdy0S9Riz9O768EnY90okX9oyLz7SaX5SSY53JBjZ-E8QhQ@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Implement ASID allocator
To:     Gary Guo <gary@garyguo.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 8:19 AM Gary Guo <gary@garyguo.net> wrote:
>
> This patch absolutely does not work with a hardware that implements ASID =
feature. Aside from many corner cases, it does not even boot on a hardware =
with ASID implemented. It only works because QEMU does not use ASID at all.=
 I have already pointed out many issues multiple times in the thread but mo=
st of them are not addressed.

We can fix this patch for you.

Can you give us access to your HW?

If it is FPGA then provide us access to bit files

If it is ASIC then let us know to buy it.

Regards,
Anup

>
> > -----Original Message-----
> > From: Anup Patel <anup@brainfault.org>
> > Sent: Thursday, April 25, 2019 03:04
> > To: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Anup Patel <Anup.Patel@wdc.com>; Albert Ou <aou@eecs.berkeley.edu>;
> > Gary Guo <gary@garyguo.net>; Atish Patra <Atish.Patra@wdc.com>; Christo=
ph
> > Hellwig <hch@infradead.org>; Paul Walmsley <paul.walmsley@sifive.com>;
> > Mike Rapoport <rppt@linux.ibm.com>; linux-riscv@lists.infradead.org; li=
nux-
> > kernel@vger.kernel.org List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v3] RISC-V: Implement ASID allocator
> >
> > On Thu, Apr 25, 2019 at 5:06 AM Palmer Dabbelt <palmer@sifive.com> wrot=
e:
> > >
> > > On Thu, 28 Mar 2019 21:51:38 PDT (-0700), Anup.Patel@wdc.com wrote:
> > > > Currently, we do local TLB flush on every MM switch. This is very h=
arsh on
> > > > performance because we are forcing page table walks after every MM
> > switch.
> > > >
> > > > This patch implements ASID allocator for assigning an ASID to a MM =
context.
> > > > The number of ASIDs are limited in HW so we create a logical entity=
 named
> > > > CONTEXTID for assigning to MM context. The lower bits of CONTEXTID =
are
> > ASID
> > > > and upper bits are VERSION number. The number of usable ASID bits
> > supported
> > > > by HW are detected at boot-time by writing 1s to ASID bits in SATP =
CSR.
> > > >
> > > > We allocate new CONTEXTID on first MM switch for a MM context where
> > the
> > > > ASID is allocated from an ASID bitmap and VERSION is provide by an =
atomic
> > > > counter. At time of allocating new CONTEXTID, if we run out of avai=
lable
> > > > ASIDs then:
> > > > 1. We flush the ASID bitmap
> > > > 2. Increment current VERSION atomic counter
> > > > 3. Re-allocate ASID from ASID bitmap
> > > > 4. Flush TLB on all CPUs
> > > > 5. Try CONTEXTID re-assignment on all CPUs
> > > >
> > > > Please note that we don't use ASID #0 because it is used at boot-ti=
me by
> > > > all CPUs for initial MM context. Also, newly created context is alw=
ays
> > > > assigned CONTEXTID #0 (i.e. VERSION #0 and ASID #0) which is an inv=
alid
> > > > context in our implementation.
> > > >
> > > > Using above approach, we have virtually infinite CONTEXTIDs on-top-=
of
> > > > limited number of HW ASIDs. This approach is inspired from ASID all=
ocator
> > > > used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall=
, this
> > > > ASID allocator helps us reduce rate of local TLB flushes on every C=
PU
> > > > thereby increasing performance.
> > > >
> > > > This patch is tested on QEMU/virt machine and SiFive Unleashed boar=
d. On
> > > > QEMU/virt machine, we see 10% (approx) performance improvement with
> > SW
> > > > emulated TLBs provided by QEMU. Unfortunately, ASID bits of SATP CS=
R are
> > > > not implemented on SiFive Unleashed board so we don't see any chang=
e in
> > > > performance.
> > >
> > > My worry here is the testing: I don't trust QEMU to be a good enough =
test of
> > > ASID handling to shake out the bugs in this sort of code -- unless I'=
m missing
> > > something, we're currently ignoring ASIDs in QEMU entirely.  As a res=
ult I'd
> > > consider this to be essentially untestable until someone comes up wit=
h an
> > > implementation that takes advantage of ASIDs.  Given that bugs here w=
ould be
> > > super hard to find, I'd prefer to avoid merging this until we're sure=
 it's
> > > solid.
> >
> > This patch is tested on both QEMU and SiFive Unleashed board so it work=
s
> > perfectly fine on existing HW out there at this moment.
> >
> > For future HW having ASID bits, it will certainly save development effo=
rts for
> > the RISC-V HW vendors if we merge it now.
> >
> > Irrespective to whether we merge this patch now or not, the debugging a=
nd
> > development complexity of ASID allocator will not change for whoever do=
es it.
> >
> > Not merging it now is a bigger problem because RISC-V HW vendor not
> > following
> > RISC-V LKML might re-implement it from scratch without realizing that t=
here is
> > already an implementation sitting on RISC-V LKML.
> >
> > In ARM world, any new ARM feature is first implemented and merged in Li=
nux
> > kernel by ARM Ltd folks (tested on their ARM fast models). Later some A=
RM
> > SOC vendor, sends patch fixes (if required) after trying out latest
> > Linux on their
> > HW having this new ARM feature.
> >
> > IMHO, we should merge this patch for Linux-5.2 so that RISC-V SOC vendo=
rs
> > can try it on their HW without re-implementing it from scratch. The "de=
bugging
> > complexity" is integral part of kernel development and this should not =
be a
> > reason to defer critical changes as long as changes are tested on exist=
ing HW.
> >
> > Linux kernel is all about "organic development". We start with a reason=
able
> > implementation of any thing and perfect it incrementally over time. Tha=
t's how
> > we get a solid implementation.
> >
> > Regards,
> > Anup
> >
> > >
> > > > Co-developed-by:: Gary Guo <gary@garyguo.net>
> > > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > > ---
> > > > Changes since v2:
> > > > - Move to lazy TLB flushing because we get slow path warnings if we
> > > >   use flush_tlb_all()
> > > > - Don't set ASID bits to all 1s in head.s. Instead just do it on
> > > >   boot CPU calling asids_init() for determining number of HW ASID b=
its
> > > > - Make CONTEXT version comparison more readable in set_mm_asid()
> > > > - Fix typo in __flush_context()
> > > >
> > > > Changes since v1:
> > > > - We adapt good aspects from Gary Guo's ASID allocator implementati=
on
> > > >   and provide due credit to him by adding his SoB.
> > > > - Track ASIDs active during context flush and mark them as reserved
> > > > - Set ASID bits to all 1s to simplify number of ASID bit detection
> > > > - Use atomic_long_t instead of atomic64_t for being 32bit friendly
> > > > - Use unsigned long instead of u64 for being 32bit friendly
> > > > - Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
> > > >   of context flush
> > > >
> > > > This patch is based on Linux-5.1-rc2 and TLB flush cleanup patches =
v4
> > > > from Gary Guo. It can be also found in riscv_asid_allocator_v3 bran=
ch
> > > > of https://github.com/avpatel/linux.git
> > > > ---
> > > >  arch/riscv/include/asm/csr.h         |   6 +
> > > >  arch/riscv/include/asm/mmu.h         |   1 +
> > > >  arch/riscv/include/asm/mmu_context.h |   1 +
> > > >  arch/riscv/mm/context.c              | 261 +++++++++++++++++++++++=
+++-
> > > >  4 files changed, 259 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/=
csr.h
> > > > index 28a0d1cb374c..ce18ab8f53ed 100644
> > > > --- a/arch/riscv/include/asm/csr.h
> > > > +++ b/arch/riscv/include/asm/csr.h
> > > > @@ -45,10 +45,16 @@
> > > >  #define SATP_PPN     _AC(0x003FFFFF, UL)
> > > >  #define SATP_MODE_32 _AC(0x80000000, UL)
> > > >  #define SATP_MODE    SATP_MODE_32
> > > > +#define SATP_ASID_BITS       9
> > > > +#define SATP_ASID_SHIFT      22
> > > > +#define SATP_ASID_MASK       _AC(0x1FF, UL)
> > > >  #else
> > > >  #define SATP_PPN     _AC(0x00000FFFFFFFFFFF, UL)
> > > >  #define SATP_MODE_39 _AC(0x8000000000000000, UL)
> > > >  #define SATP_MODE    SATP_MODE_39
> > > > +#define SATP_ASID_BITS       16
> > > > +#define SATP_ASID_SHIFT      44
> > > > +#define SATP_ASID_MASK       _AC(0xFFFF, UL)
> > > >  #endif
> > > >
> > > >  /* Interrupt Enable and Interrupt Pending flags */
> > > > diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/=
mmu.h
> > > > index 5df2dccdba12..42a9ca0fe1fb 100644
> > > > --- a/arch/riscv/include/asm/mmu.h
> > > > +++ b/arch/riscv/include/asm/mmu.h
> > > > @@ -18,6 +18,7 @@
> > > >  #ifndef __ASSEMBLY__
> > > >
> > > >  typedef struct {
> > > > +     atomic_long_t id;
> > > >       void *vdso;
> > > >  #ifdef CONFIG_SMP
> > > >       /* A local icache flush is needed before user execution can r=
esume. */
> > > > diff --git a/arch/riscv/include/asm/mmu_context.h
> > b/arch/riscv/include/asm/mmu_context.h
> > > > index bf4f097a9051..bd271c6b0e5e 100644
> > > > --- a/arch/riscv/include/asm/mmu_context.h
> > > > +++ b/arch/riscv/include/asm/mmu_context.h
> > > > @@ -30,6 +30,7 @@ static inline void enter_lazy_tlb(struct mm_struc=
t *mm,
> > > >  static inline int init_new_context(struct task_struct *task,
> > > >       struct mm_struct *mm)
> > > >  {
> > > > +     atomic_long_set(&mm->context.id, 0);
> > > >       return 0;
> > > >  }
> > > >
> > > > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > > > index 0f787bcd3a7a..863b6926d6d9 100644
> > > > --- a/arch/riscv/mm/context.c
> > > > +++ b/arch/riscv/mm/context.c
> > > > @@ -2,13 +2,213 @@
> > > >  /*
> > > >   * Copyright (C) 2012 Regents of the University of California
> > > >   * Copyright (C) 2017 SiFive
> > > > + * Copyright (C) 2019 Western Digital Corporation or its affiliate=
s.
> > > >   */
> > > >
> > > > +#include <linux/bitops.h>
> > > >  #include <linux/mm.h>
> > > > +#include <linux/slab.h>
> > > >
> > > >  #include <asm/tlbflush.h>
> > > >  #include <asm/cacheflush.h>
> > > >
> > > > +static bool use_asid_allocator;
> > > > +static unsigned long asid_bits;
> > > > +static unsigned long num_asids;
> > > > +static unsigned long asid_mask;
> > > > +
> > > > +static atomic_long_t current_version;
> > > > +
> > > > +static DEFINE_RAW_SPINLOCK(context_lock);
> > > > +static cpumask_t context_tlb_flush_pending;
> > > > +static unsigned long *context_asid_map;
> > > > +
> > > > +static DEFINE_PER_CPU(atomic_long_t, active_context);
> > > > +static DEFINE_PER_CPU(unsigned long, reserved_context);
> > > > +
> > > > +static bool check_update_reserved_context(unsigned long cntx,
> > > > +                                       unsigned long newcntx)
> > > > +{
> > > > +     int cpu;
> > > > +     bool hit =3D false;
> > > > +
> > > > +     /*
> > > > +      * Iterate over the set of reserved CONTEXT looking for a mat=
ch.
> > > > +      * If we find one, then we can update our mm to use new CONTE=
XT
> > > > +      * (i.e. the same CONTEXT in the current_version) but we can'=
t
> > > > +      * exit the loop early, since we need to ensure that all copi=
es
> > > > +      * of the old CONTEXT are updated to reflect the mm. Failure =
to do
> > > > +      * so could result in us missing the reserved CONTEXT in a fu=
ture
> > > > +      * version.
> > > > +      */
> > > > +     for_each_possible_cpu(cpu) {
> > > > +             if (per_cpu(reserved_context, cpu) =3D=3D cntx) {
> > > > +                     hit =3D true;
> > > > +                     per_cpu(reserved_context, cpu) =3D newcntx;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return hit;
> > > > +}
> > > > +
> > > > +/* Note: must be called with context_lock held */
> > > > +static void __flush_context(void)
> > > > +{
> > > > +     int i;
> > > > +     unsigned long cntx;
> > > > +
> > > > +     /* Update the list of reserved ASIDs and the ASID bitmap. */
> > > > +     bitmap_clear(context_asid_map, 0, num_asids);
> > > > +
> > > > +     /* Mark already acitve ASIDs as used */
> > > > +     for_each_possible_cpu(i) {
> > > > +             cntx =3D atomic_long_xchg_relaxed(&per_cpu(active_con=
text, i), 0);
> > > > +             /*
> > > > +              * If this CPU has already been through a rollover, b=
ut
> > > > +              * hasn't run another task in the meantime, we must p=
reserve
> > > > +              * its reserved CONTEXT, as this is the only trace we=
 have of
> > > > +              * the process it is still running.
> > > > +              */
> > > > +             if (cntx =3D=3D 0)
> > > > +                     cntx =3D per_cpu(reserved_context, i);
> > > > +
> > > > +             __set_bit(cntx & asid_mask, context_asid_map);
> > > > +             per_cpu(reserved_context, i) =3D cntx;
> > > > +     }
> > > > +
> > > > +     /* Mark ASID #0 as used because it is used at boot-time */
> > > > +     __set_bit(0, context_asid_map);
> > > > +
> > > > +     /* Queue a TLB invalidation for each CPU on next context-swit=
ch */
> > > > +     cpumask_setall(&context_tlb_flush_pending);
> > > > +}
> > > > +
> > > > +/* Note: must be called with context_lock held */
> > > > +static unsigned long __new_context(struct mm_struct *mm)
> > > > +{
> > > > +     static u32 cur_idx =3D 1;
> > > > +     unsigned long cntx =3D atomic_long_read(&mm->context.id);
> > > > +     unsigned long asid, ver =3D atomic_long_read(&current_version=
);
> > > > +
> > > > +     if (cntx !=3D 0) {
> > > > +             unsigned long newcntx =3D ver | (cntx & asid_mask);
> > > > +
> > > > +             /*
> > > > +              * If our current CONTEXT was active during a rollove=
r, we
> > > > +              * can continue to use it and this was just a false a=
larm.
> > > > +              */
> > > > +             if (check_update_reserved_context(cntx, newcntx))
> > > > +                     return newcntx;
> > > > +
> > > > +             /*
> > > > +              * We had a valid CONTEXT in a previous life, so try =
to
> > > > +              * re-use it if possible.
> > > > +              */
> > > > +             if (!__test_and_set_bit(cntx & asid_mask, context_asi=
d_map))
> > > > +                     return newcntx;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Allocate a free ASID. If we can't find one then increment
> > > > +      * current_version and flush all ASIDs.
> > > > +      */
> > > > +     asid =3D find_next_zero_bit(context_asid_map, num_asids, cur_=
idx);
> > > > +     if (asid !=3D num_asids)
> > > > +             goto set_asid;
> > > > +
> > > > +     /* We're out of ASIDs, so increment current_version */
> > > > +     ver =3D atomic_long_add_return_relaxed(num_asids, &current_ve=
rsion);
> > > > +
> > > > +     /* Flush everything  */
> > > > +     __flush_context();
> > > > +
> > > > +     /* We have more ASIDs than CPUs, so this will always succeed =
*/
> > > > +     asid =3D find_next_zero_bit(context_asid_map, num_asids, 1);
> > > > +
> > > > +set_asid:
> > > > +     __set_bit(asid, context_asid_map);
> > > > +     cur_idx =3D asid;
> > > > +     return asid | ver;
> > > > +}
> > > > +
> > > > +static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
> > > > +{
> > > > +     unsigned long flags;
> > > > +     bool need_flush_tlb =3D false;
> > > > +     unsigned long cntx, old_active_cntx;
> > > > +
> > > > +     cntx =3D atomic_long_read(&mm->context.id);
> > > > +
> > > > +     /*
> > > > +      * If our active_context is non-zero and the context matches =
the
> > > > +      * current_version, then we update the active_context entry w=
ith a
> > > > +      * relaxed cmpxchg.
> > > > +      *
> > > > +      * Following is how we handle racing with a concurrent rollov=
er:
> > > > +      *
> > > > +      * - We get a zero back from the cmpxchg and end up waiting o=
n the
> > > > +      *   lock. Taking the lock synchronises with the rollover and=
 so
> > > > +      *   we are forced to see the updated verion.
> > > > +      *
> > > > +      * - We get a valid context back from the cmpxchg then we con=
tinue
> > > > +      *   using old ASID because __flush_context() would have mark=
ed ASID
> > > > +      *   of active_context as used and next context switch we wil=
l allocate
> > > > +      *   new context.
> > > > +      */
> > > > +     old_active_cntx =3D atomic_long_read(&per_cpu(active_context,=
 cpu));
> > > > +     if (old_active_cntx &&
> > > > +         ((cntx & ~asid_mask) =3D=3D atomic_long_read(&current_ver=
sion)) &&
> > > > +         atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu)=
,
> > > > +                                     old_active_cntx, cntx))
> > > > +             goto switch_mm_fast;
> > > > +
> > > > +     raw_spin_lock_irqsave(&context_lock, flags);
> > > > +
> > > > +     /* Check that our ASID belongs to the current_version. */
> > > > +     cntx =3D atomic_long_read(&mm->context.id);
> > > > +     if ((cntx & ~asid_mask) !=3D atomic_long_read(&current_versio=
n)) {
> > > > +             cntx =3D __new_context(mm);
> > > > +             atomic_long_set(&mm->context.id, cntx);
> > > > +     }
> > > > +
> > > > +     if (cpumask_test_and_clear_cpu(cpu, &context_tlb_flush_pendin=
g))
> > > > +             need_flush_tlb =3D true;
> > > > +
> > > > +     atomic_long_set(&per_cpu(active_context, cpu), cntx);
> > > > +
> > > > +     raw_spin_unlock_irqrestore(&context_lock, flags);
> > > > +
> > > > +switch_mm_fast:
> > > > +     /*
> > > > +      * Use the old spbtr name instead of using the current satp
> > > > +      * name to support binutils 2.29 which doesn't know about the
> > > > +      * privileged ISA 1.10 yet.
> > > > +      */
> > > > +     csr_write(sptbr, virt_to_pfn(mm->pgd) |
> > > > +               ((cntx & asid_mask) << SATP_ASID_SHIFT) |
> > > > +               SATP_MODE);
> > > > +
> > > > +     if (need_flush_tlb)
> > > > +             local_flush_tlb_all();
> > > > +}
> > > > +
> > > > +static void set_mm_noasid(struct mm_struct *mm)
> > > > +{
> > > > +     /*
> > > > +      * Use the old spbtr name instead of using the current satp
> > > > +      * name to support binutils 2.29 which doesn't know about the
> > > > +      * privileged ISA 1.10 yet.
> > > > +      */
> > > > +     csr_write(sptbr, virt_to_pfn(mm->pgd) | SATP_MODE);
> > > > +
> > > > +     /*
> > > > +      * sfence.vma after SATP write. We call it on MM context inst=
ead of
> > > > +      * calling local_flush_tlb_all to prevent global mappings fro=
m being
> > > > +      * affected.
> > > > +      */
> > > > +     local_flush_tlb_mm(mm);
> > > > +}
> > > > +
> > > >  /*
> > > >   * When necessary, performs a deferred icache flush for the given =
MM
> > context,
> > > >   * on the local CPU.  RISC-V has no direct mechanism for instructi=
on cache
> > > > @@ -58,20 +258,61 @@ void switch_mm(struct mm_struct *prev, struct
> > mm_struct *next,
> > > >       cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > > >       cpumask_set_cpu(cpu, mm_cpumask(next));
> > > >
> > > > +     if (use_asid_allocator)
> > > > +             set_mm_asid(next, cpu);
> > > > +     else
> > > > +             set_mm_noasid(next);
> > > > +
> > > > +     flush_icache_deferred(next);
> > > > +}
> > > > +
> > > > +static int asids_init(void)
> > > > +{
> > > > +     unsigned long old;
> > > > +
> > > > +     /* Figure-out number of ASID bits in HW */
> > > > +     old =3D csr_read(sptbr);
> > > > +     asid_bits =3D old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
> > > > +     csr_write(sptbr, asid_bits);
> > > > +     asid_bits =3D (csr_read(sptbr) >> SATP_ASID_SHIFT)  & SATP_AS=
ID_MASK;
> > > > +     asid_bits =3D fls_long(asid_bits);
> > > > +     csr_write(sptbr, old);
> > > > +
> > > >       /*
> > > > -      * Use the old spbtr name instead of using the current satp
> > > > -      * name to support binutils 2.29 which doesn't know about the
> > > > -      * privileged ISA 1.10 yet.
> > > > +      * In the process of determining number of ASID bits (above)
> > > > +      * we polluted the TLB of current HART so let's do TLB flushe=
d
> > > > +      * to remove unwanted TLB enteries.
> > > >        */
> > > > -     csr_write(sptbr, virt_to_pfn(next->pgd) | SATP_MODE);
> > > > +     local_flush_tlb_all();
> > > > +
> > > > +     /* Pre-compute ASID details */
> > > > +     num_asids =3D 1 << asid_bits;
> > > > +     asid_mask =3D num_asids - 1;
> > > >
> > > >       /*
> > > > -      * sfence.vma after SATP write. We call it on MM context inst=
ead of
> > > > -      * calling local_flush_tlb_all to prevent global mappings fro=
m being
> > > > -      * affected.
> > > > +      * Use ASID allocator only if number of HW ASIDs are
> > > > +      * at-least twice more than CPUs
> > > >        */
> > > > -     local_flush_tlb_mm(next);
> > > > +     use_asid_allocator =3D
> > > > +             (num_asids <=3D (2 * num_possible_cpus())) ? false : =
true;
> > > >
> > > > -     flush_icache_deferred(next);
> > > > -}
> > > > +     /* Setup ASID allocator if available */
> > > > +     if (use_asid_allocator) {
> > > > +             atomic_long_set(&current_version, num_asids);
> > > > +
> > > > +             context_asid_map =3D kcalloc(BITS_TO_LONGS(num_asids)=
,
> > > > +                                sizeof(*context_asid_map), GFP_KER=
NEL);
> > > > +             if (!context_asid_map)
> > > > +                     panic("Failed to allocate bitmap for %lu ASID=
s\n",
> > > > +                           num_asids);
> > > > +
> > > > +             __set_bit(0, context_asid_map);
> > > >
> > > > +             pr_info("ASID allocator using %lu entries\n", num_asi=
ds);
> > > > +     } else {
> > > > +             pr_info("ASID allocator disabled\n");
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +early_initcall(asids_init);
