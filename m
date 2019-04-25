Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1533DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4879218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="sgPSZ8lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfDYGFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:05:05 -0400
Received: from mr85p00im-ztdg06021201.me.com ([17.58.23.189]:59978 "EHLO
        mr85p00im-ztdg06021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbfDYGFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:05:04 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Apr 2019 02:05:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=04042017;
        t=1556171714; bh=/q0n4ma9zarJA55arZt3oI7v3mF/TdyXAbmNGy4dfi8=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=sgPSZ8lElxenbJmPJvFO98gSV/gwhgDbBVwCEGGKQiR6sHpztfAjxDVvqb8eTcIpY
         SYX/ZHAAq+oNxxj63BIvG4FL1n468Nr8Wvwi0kVymo5G/se5Yd4WeqwOAaS8liMHp6
         7nfX6dFb6KrKY8Gxt8EEP/XkFjfJO74PPrtujfEWYs9lLmbLClrNj1tszBhvVFv4cY
         xIo4nzsuGSrpjMubJ9tkeFANbS4kiUq/+0wMh3r8sbHRbtpUCCitYhRtvJaUsOmY7f
         mdViOp65yQeMeb2ryjVeVptwoSj7oJXCNs55aW4fObjk+zFtoBy/r8VfWksnwuI8d5
         5uplfg/qabNiQ==
Received: from [192.168.17.2] (122-58-211-120-fibre.sparkbb.co.nz [122.58.211.120])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 6DD0012011B;
        Thu, 25 Apr 2019 05:55:13 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] RISC-V: Implement ASID allocator
From:   Michael Clark <michaeljclark@mac.com>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <mhng-204d1c25-476e-4b47-89b8-ef78fde61c3f@palmer-si-x1e>
Date:   Thu, 25 Apr 2019 17:55:08 +1200
Cc:     Anup.Patel@wdc.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, gary@garyguo.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9400A2A6-7313-4DBE-A081-8DBC1B1215E5@mac.com>
References: <mhng-204d1c25-476e-4b47-89b8-ef78fde61c3f@palmer-si-x1e>
To:     Palmer Dabbelt <palmer@sifive.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1904250040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> On 25/04/2019, at 11:36 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
>>=20
>> On Thu, 28 Mar 2019 21:51:38 PDT (-0700), Anup.Patel@wdc.com wrote:
>> Currently, we do local TLB flush on every MM switch. This is very harsh o=
n
>> performance because we are forcing page table walks after every MM switch=
.
>>=20
>> This patch implements ASID allocator for assigning an ASID to a MM contex=
t.
>> The number of ASIDs are limited in HW so we create a logical entity named=

>> CONTEXTID for assigning to MM context. The lower bits of CONTEXTID are AS=
ID
>> and upper bits are VERSION number. The number of usable ASID bits support=
ed
>> by HW are detected at boot-time by writing 1s to ASID bits in SATP CSR.
>>=20
>> We allocate new CONTEXTID on first MM switch for a MM context where the
>> ASID is allocated from an ASID bitmap and VERSION is provide by an atomic=

>> counter. At time of allocating new CONTEXTID, if we run out of available
>> ASIDs then:
>> 1. We flush the ASID bitmap
>> 2. Increment current VERSION atomic counter
>> 3. Re-allocate ASID from ASID bitmap
>> 4. Flush TLB on all CPUs
>> 5. Try CONTEXTID re-assignment on all CPUs
>>=20
>> Please note that we don't use ASID #0 because it is used at boot-time by
>> all CPUs for initial MM context. Also, newly created context is always
>> assigned CONTEXTID #0 (i.e. VERSION #0 and ASID #0) which is an invalid
>> context in our implementation.
>>=20
>> Using above approach, we have virtually infinite CONTEXTIDs on-top-of
>> limited number of HW ASIDs. This approach is inspired from ASID allocator=

>> used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall, this=

>> ASID allocator helps us reduce rate of local TLB flushes on every CPU
>> thereby increasing performance.
>>=20
>> This patch is tested on QEMU/virt machine and SiFive Unleashed board. On
>> QEMU/virt machine, we see 10% (approx) performance improvement with SW
>> emulated TLBs provided by QEMU. Unfortunately, ASID bits of SATP CSR are
>> not implemented on SiFive Unleashed board so we don't see any change in
>> performance.
>=20
> My worry here is the testing: I don't trust QEMU to be a good enough test o=
f
> ASID handling to shake out the bugs in this sort of code -- unless I'm mis=
sing
> something, we're currently ignoring ASIDs in QEMU entirely.  As a result I=
'd
> consider this to be essentially untestable until someone comes up with an
> implementation that takes advantage of ASIDs.  Given that bugs here would b=
e
> super hard to find, I'd prefer to avoid merging this until we're sure it's=

> solid.

I agree. Not merging code until there are proofs in the form of independentl=
y verifiable tests is a good idea and can =E2=80=9Ccause no harm=E2=80=9D. A=
s long as folk know where the branch is, they can try it out on its testing o=
r experimental branch. This sounds =E2=80=9Cexperimental=E2=80=9D. If it bre=
aks mm on hardware supporting ASID, as mentioned in other email on this thre=
ad, then it=E2=80=99s perhaps better described as =E2=80=9Cvery experimental=
=E2=80=9D.

QEMU has no support for ASID and will just unconditionally flush the soft-tl=
b, which is a valid behavior but not helpful for testing ASID. It could hide=
 serious bugs where the TLB is left in an inconsistent state, potentially le=
aking privileged data. I would want Linux user-space context switch tests wi=
th two or more processes created using clone from init pid 1 so there can be=
 no interference from daemons that exist on a full system. We can launch the=
 test cases as pid 1 using init=3D in hardware or a simulator.

I think QEMU could potentially map some ASID bits to its soft-tlb. The soft-=
tlb tag bits are limited but it=E2=80=99s possible to customize. That said, i=
t should run just fine in spike using CLINT and HTIF. mm tests don=E2=80=99t=
 need PLIC.

I know SiFive is in the business of selling formally verified RISC-V hardwar=
e and they have sophisticated in-house verification for their cores, but, =E2=
=80=A6 from Googling a bit, one can quickly see there is demand for more ope=
n source verification. Trust is important but we can=E2=80=99t really encour=
age a =E2=80=9Ctrust us=E2=80=9D as the basis for merging code when the curr=
ent software-engineering norm is to have automated tests in CI.

My 2c.

>> Co-developed-by:: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>> Changes since v2:
>> - Move to lazy TLB flushing because we get slow path warnings if we
>> use flush_tlb_all()
>> - Don't set ASID bits to all 1s in head.s. Instead just do it on
>> boot CPU calling asids_init() for determining number of HW ASID bits
>> - Make CONTEXT version comparison more readable in set_mm_asid()
>> - Fix typo in __flush_context()
>>=20
>> Changes since v1:
>> - We adapt good aspects from Gary Guo's ASID allocator implementation
>> and provide due credit to him by adding his SoB.
>> - Track ASIDs active during context flush and mark them as reserved
>> - Set ASID bits to all 1s to simplify number of ASID bit detection
>> - Use atomic_long_t instead of atomic64_t for being 32bit friendly
>> - Use unsigned long instead of u64 for being 32bit friendly
>> - Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
>> of context flush
>>=20
>> This patch is based on Linux-5.1-rc2 and TLB flush cleanup patches v4
>> from Gary Guo. It can be also found in riscv_asid_allocator_v3 branch
>> of https://github.com/avpatel/linux.git
>> ---
>> arch/riscv/include/asm/csr.h         |   6 +
>> arch/riscv/include/asm/mmu.h         |   1 +
>> arch/riscv/include/asm/mmu_context.h |   1 +
>> arch/riscv/mm/context.c              | 261 ++++++++++++++++++++++++++-
>> 4 files changed, 259 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> index 28a0d1cb374c..ce18ab8f53ed 100644
>> --- a/arch/riscv/include/asm/csr.h
>> +++ b/arch/riscv/include/asm/csr.h
>> @@ -45,10 +45,16 @@
>> #define SATP_PPN     _AC(0x003FFFFF, UL)
>> #define SATP_MODE_32 _AC(0x80000000, UL)
>> #define SATP_MODE    SATP_MODE_32
>> +#define SATP_ASID_BITS    9
>> +#define SATP_ASID_SHIFT    22
>> +#define SATP_ASID_MASK    _AC(0x1FF, UL)
>> #else
>> #define SATP_PPN     _AC(0x00000FFFFFFFFFFF, UL)
>> #define SATP_MODE_39 _AC(0x8000000000000000, UL)
>> #define SATP_MODE    SATP_MODE_39
>> +#define SATP_ASID_BITS    16
>> +#define SATP_ASID_SHIFT    44
>> +#define SATP_ASID_MASK    _AC(0xFFFF, UL)
>> #endif
>>=20
>> /* Interrupt Enable and Interrupt Pending flags */
>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
>> index 5df2dccdba12..42a9ca0fe1fb 100644
>> --- a/arch/riscv/include/asm/mmu.h
>> +++ b/arch/riscv/include/asm/mmu.h
>> @@ -18,6 +18,7 @@
>> #ifndef __ASSEMBLY__
>>=20
>> typedef struct {
>> +    atomic_long_t id;
>>   void *vdso;
>> #ifdef CONFIG_SMP
>>   /* A local icache flush is needed before user execution can resume. */
>> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/as=
m/mmu_context.h
>> index bf4f097a9051..bd271c6b0e5e 100644
>> --- a/arch/riscv/include/asm/mmu_context.h
>> +++ b/arch/riscv/include/asm/mmu_context.h
>> @@ -30,6 +30,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,=

>> static inline int init_new_context(struct task_struct *task,
>>   struct mm_struct *mm)
>> {
>> +    atomic_long_set(&mm->context.id, 0);
>>   return 0;
>> }
>>=20
>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> index 0f787bcd3a7a..863b6926d6d9 100644
>> --- a/arch/riscv/mm/context.c
>> +++ b/arch/riscv/mm/context.c
>> @@ -2,13 +2,213 @@
>> /*
>> * Copyright (C) 2012 Regents of the University of California
>> * Copyright (C) 2017 SiFive
>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
>> */
>>=20
>> +#include <linux/bitops.h>
>> #include <linux/mm.h>
>> +#include <linux/slab.h>
>>=20
>> #include <asm/tlbflush.h>
>> #include <asm/cacheflush.h>
>>=20
>> +static bool use_asid_allocator;
>> +static unsigned long asid_bits;
>> +static unsigned long num_asids;
>> +static unsigned long asid_mask;
>> +
>> +static atomic_long_t current_version;
>> +
>> +static DEFINE_RAW_SPINLOCK(context_lock);
>> +static cpumask_t context_tlb_flush_pending;
>> +static unsigned long *context_asid_map;
>> +
>> +static DEFINE_PER_CPU(atomic_long_t, active_context);
>> +static DEFINE_PER_CPU(unsigned long, reserved_context);
>> +
>> +static bool check_update_reserved_context(unsigned long cntx,
>> +                      unsigned long newcntx)
>> +{
>> +    int cpu;
>> +    bool hit =3D false;
>> +
>> +    /*
>> +     * Iterate over the set of reserved CONTEXT looking for a match.
>> +     * If we find one, then we can update our mm to use new CONTEXT
>> +     * (i.e. the same CONTEXT in the current_version) but we can't
>> +     * exit the loop early, since we need to ensure that all copies
>> +     * of the old CONTEXT are updated to reflect the mm. Failure to do
>> +     * so could result in us missing the reserved CONTEXT in a future
>> +     * version.
>> +     */
>> +    for_each_possible_cpu(cpu) {
>> +        if (per_cpu(reserved_context, cpu) =3D=3D cntx) {
>> +            hit =3D true;
>> +            per_cpu(reserved_context, cpu) =3D newcntx;
>> +        }
>> +    }
>> +
>> +    return hit;
>> +}
>> +
>> +/* Note: must be called with context_lock held */
>> +static void __flush_context(void)
>> +{
>> +    int i;
>> +    unsigned long cntx;
>> +
>> +    /* Update the list of reserved ASIDs and the ASID bitmap. */
>> +    bitmap_clear(context_asid_map, 0, num_asids);
>> +
>> +    /* Mark already acitve ASIDs as used */
>> +    for_each_possible_cpu(i) {
>> +        cntx =3D atomic_long_xchg_relaxed(&per_cpu(active_context, i), 0=
);
>> +        /*
>> +         * If this CPU has already been through a rollover, but
>> +         * hasn't run another task in the meantime, we must preserve
>> +         * its reserved CONTEXT, as this is the only trace we have of
>> +         * the process it is still running.
>> +         */
>> +        if (cntx =3D=3D 0)
>> +            cntx =3D per_cpu(reserved_context, i);
>> +
>> +        __set_bit(cntx & asid_mask, context_asid_map);
>> +        per_cpu(reserved_context, i) =3D cntx;
>> +    }
>> +
>> +    /* Mark ASID #0 as used because it is used at boot-time */
>> +    __set_bit(0, context_asid_map);
>> +
>> +    /* Queue a TLB invalidation for each CPU on next context-switch */
>> +    cpumask_setall(&context_tlb_flush_pending);
>> +}
>> +
>> +/* Note: must be called with context_lock held */
>> +static unsigned long __new_context(struct mm_struct *mm)
>> +{
>> +    static u32 cur_idx =3D 1;
>> +    unsigned long cntx =3D atomic_long_read(&mm->context.id);
>> +    unsigned long asid, ver =3D atomic_long_read(&current_version);
>> +
>> +    if (cntx !=3D 0) {
>> +        unsigned long newcntx =3D ver | (cntx & asid_mask);
>> +
>> +        /*
>> +         * If our current CONTEXT was active during a rollover, we
>> +         * can continue to use it and this was just a false alarm.
>> +         */
>> +        if (check_update_reserved_context(cntx, newcntx))
>> +            return newcntx;
>> +
>> +        /*
>> +         * We had a valid CONTEXT in a previous life, so try to
>> +         * re-use it if possible.
>> +         */
>> +        if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
>> +            return newcntx;
>> +    }
>> +
>> +    /*
>> +     * Allocate a free ASID. If we can't find one then increment
>> +     * current_version and flush all ASIDs.
>> +     */
>> +    asid =3D find_next_zero_bit(context_asid_map, num_asids, cur_idx);
>> +    if (asid !=3D num_asids)
>> +        goto set_asid;
>> +
>> +    /* We're out of ASIDs, so increment current_version */
>> +    ver =3D atomic_long_add_return_relaxed(num_asids, &current_version);=

>> +
>> +    /* Flush everything  */
>> +    __flush_context();
>> +
>> +    /* We have more ASIDs than CPUs, so this will always succeed */
>> +    asid =3D find_next_zero_bit(context_asid_map, num_asids, 1);
>> +
>> +set_asid:
>> +    __set_bit(asid, context_asid_map);
>> +    cur_idx =3D asid;
>> +    return asid | ver;
>> +}
>> +
>> +static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
>> +{
>> +    unsigned long flags;
>> +    bool need_flush_tlb =3D false;
>> +    unsigned long cntx, old_active_cntx;
>> +
>> +    cntx =3D atomic_long_read(&mm->context.id);
>> +
>> +    /*
>> +     * If our active_context is non-zero and the context matches the
>> +     * current_version, then we update the active_context entry with a
>> +     * relaxed cmpxchg.
>> +     *
>> +     * Following is how we handle racing with a concurrent rollover:
>> +     *
>> +     * - We get a zero back from the cmpxchg and end up waiting on the
>> +     *   lock. Taking the lock synchronises with the rollover and so
>> +     *   we are forced to see the updated verion.
>> +     *
>> +     * - We get a valid context back from the cmpxchg then we continue
>> +     *   using old ASID because __flush_context() would have marked ASID=

>> +     *   of active_context as used and next context switch we will alloc=
ate
>> +     *   new context.
>> +     */
>> +    old_active_cntx =3D atomic_long_read(&per_cpu(active_context, cpu));=

>> +    if (old_active_cntx &&
>> +        ((cntx & ~asid_mask) =3D=3D atomic_long_read(&current_version)) &=
&
>> +        atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
>> +                    old_active_cntx, cntx))
>> +        goto switch_mm_fast;
>> +
>> +    raw_spin_lock_irqsave(&context_lock, flags);
>> +
>> +    /* Check that our ASID belongs to the current_version. */
>> +    cntx =3D atomic_long_read(&mm->context.id);
>> +    if ((cntx & ~asid_mask) !=3D atomic_long_read(&current_version)) {
>> +        cntx =3D __new_context(mm);
>> +        atomic_long_set(&mm->context.id, cntx);
>> +    }
>> +
>> +    if (cpumask_test_and_clear_cpu(cpu, &context_tlb_flush_pending))
>> +        need_flush_tlb =3D true;
>> +
>> +    atomic_long_set(&per_cpu(active_context, cpu), cntx);
>> +
>> +    raw_spin_unlock_irqrestore(&context_lock, flags);
>> +
>> +switch_mm_fast:
>> +    /*
>> +     * Use the old spbtr name instead of using the current satp
>> +     * name to support binutils 2.29 which doesn't know about the
>> +     * privileged ISA 1.10 yet.
>> +     */
>> +    csr_write(sptbr, virt_to_pfn(mm->pgd) |
>> +          ((cntx & asid_mask) << SATP_ASID_SHIFT) |
>> +          SATP_MODE);
>> +
>> +    if (need_flush_tlb)
>> +        local_flush_tlb_all();
>> +}
>> +
>> +static void set_mm_noasid(struct mm_struct *mm)
>> +{
>> +    /*
>> +     * Use the old spbtr name instead of using the current satp
>> +     * name to support binutils 2.29 which doesn't know about the
>> +     * privileged ISA 1.10 yet.
>> +     */
>> +    csr_write(sptbr, virt_to_pfn(mm->pgd) | SATP_MODE);
>> +
>> +    /*
>> +     * sfence.vma after SATP write. We call it on MM context instead of
>> +     * calling local_flush_tlb_all to prevent global mappings from being=

>> +     * affected.
>> +     */
>> +    local_flush_tlb_mm(mm);
>> +}
>> +
>> /*
>> * When necessary, performs a deferred icache flush for the given MM conte=
xt,
>> * on the local CPU.  RISC-V has no direct mechanism for instruction cache=

>> @@ -58,20 +258,61 @@ void switch_mm(struct mm_struct *prev, struct mm_str=
uct *next,
>>   cpumask_clear_cpu(cpu, mm_cpumask(prev));
>>   cpumask_set_cpu(cpu, mm_cpumask(next));
>>=20
>> +    if (use_asid_allocator)
>> +        set_mm_asid(next, cpu);
>> +    else
>> +        set_mm_noasid(next);
>> +
>> +    flush_icache_deferred(next);
>> +}
>> +
>> +static int asids_init(void)
>> +{
>> +    unsigned long old;
>> +
>> +    /* Figure-out number of ASID bits in HW */
>> +    old =3D csr_read(sptbr);
>> +    asid_bits =3D old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
>> +    csr_write(sptbr, asid_bits);
>> +    asid_bits =3D (csr_read(sptbr) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK=
;
>> +    asid_bits =3D fls_long(asid_bits);
>> +    csr_write(sptbr, old);
>> +
>>   /*
>> -     * Use the old spbtr name instead of using the current satp
>> -     * name to support binutils 2.29 which doesn't know about the
>> -     * privileged ISA 1.10 yet.
>> +     * In the process of determining number of ASID bits (above)
>> +     * we polluted the TLB of current HART so let's do TLB flushed
>> +     * to remove unwanted TLB enteries.
>>    */
>> -    csr_write(sptbr, virt_to_pfn(next->pgd) | SATP_MODE);
>> +    local_flush_tlb_all();
>> +
>> +    /* Pre-compute ASID details */
>> +    num_asids =3D 1 << asid_bits;
>> +    asid_mask =3D num_asids - 1;
>>=20
>>   /*
>> -     * sfence.vma after SATP write. We call it on MM context instead of
>> -     * calling local_flush_tlb_all to prevent global mappings from being=

>> -     * affected.
>> +     * Use ASID allocator only if number of HW ASIDs are
>> +     * at-least twice more than CPUs
>>    */
>> -    local_flush_tlb_mm(next);
>> +    use_asid_allocator =3D
>> +        (num_asids <=3D (2 * num_possible_cpus())) ? false : true;
>>=20
>> -    flush_icache_deferred(next);
>> -}
>> +    /* Setup ASID allocator if available */
>> +    if (use_asid_allocator) {
>> +        atomic_long_set(&current_version, num_asids);
>> +
>> +        context_asid_map =3D kcalloc(BITS_TO_LONGS(num_asids),
>> +                   sizeof(*context_asid_map), GFP_KERNEL);
>> +        if (!context_asid_map)
>> +            panic("Failed to allocate bitmap for %lu ASIDs\n",
>> +                  num_asids);
>> +
>> +        __set_bit(0, context_asid_map);
>>=20
>> +        pr_info("ASID allocator using %lu entries\n", num_asids);
>> +    } else {
>> +        pr_info("ASID allocator disabled\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +early_initcall(asids_init);
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

