Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6157C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B9A259F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sJUJar7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfEaSsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:48:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44128 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEaSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:48:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id x3so1199697pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GcC078UrKNbyG6PtAE7wh1G7slXGT/uXTJ6yFTxcK6E=;
        b=sJUJar7z1RDi1CXHp8lCB44l1OJRU2xnnNGnTwg5hnJsgTYCluzcBfSWxWuSvPASZ5
         LxY4GBxs6O5rnSfEfB03hy5OgO4wlra82LC9uOpd0CX7DQgU8P9NqlD7f/OqPGwgo2zQ
         gIsvjVBBb/zHCtoVyxmIrBhfVjt+X0c/jk8INJVbh9aHzacBEdFokVb3BtdPE3ZVDTbT
         t29c/fouy8o/gg4FWHXkab4pn3IErtYWcRW9KngA2hVP6TSMVB8xAIiXmYMyeF7P4v/V
         /yF/l4iX7q48OEndVfKcFaPupDZKfLbRC2leAjRmQawcbPeplKRtDakBamq1QCNkGC1w
         I2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GcC078UrKNbyG6PtAE7wh1G7slXGT/uXTJ6yFTxcK6E=;
        b=J3Y6epc7CRZyxUKyGeIzB6Egvi9oYCobCOlRlgZED9W3VqVpQwT84z0oaPA8qaLd6M
         Kfc9HRhrWe6O4DR1wB9mZ/FwgeCiOkhDsVWNIaG93JyDZPtHPqRRlmmIqLr0euRi/kM/
         J2z5W+T2J2agl1tY0pThRvj4DnSjjVivbWKWOwHGBrh7/NAxgwClB+Q4SwJzaUC8hlWG
         E8c2Vw/lS1mTRg+NGtMsUDqt14RX0kP++29cW3c50c1ADcZb3WW2YpRdPlljXsmGIFa+
         kyieUi7PQJ3WF4PNayFU7KY3Z//GQYjcahy0Eg5GgBxrgzYMFn9BdSVTcKFBdoIneOUq
         Mimg==
X-Gm-Message-State: APjAAAVWby6usx7kOKJs+fQDLNtF6JHZ+/XvYtZ5ddTPYyNLLFxfA78S
        Sopdvq//EOswa8Ww768OkzhBsQ==
X-Google-Smtp-Source: APXvYqxdC+4Hswubngnew6GHxQkFLx0WQdZVpuoudnJPvB6H8EXBVr3hYmB0Q0tmIyswN6Kamdto6A==
X-Received: by 2002:a65:4283:: with SMTP id j3mr10743636pgp.88.1559328511312;
        Fri, 31 May 2019 11:48:31 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:4d40:e377:cfa4:3246? ([2601:646:c200:1ef2:4d40:e377:cfa4:3246])
        by smtp.gmail.com with ESMTPSA id d5sm7629676pfn.25.2019.05.31.11.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 11:48:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 08/12] x86/tlb: Privatize cpu_tlbstate
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190531063645.4697-9-namit@vmware.com>
Date:   Fri, 31 May 2019 11:48:29 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <933D5C14-5948-48FC-9379-167F59BD1FA1@amacapital.net>
References: <20190531063645.4697-1-namit@vmware.com> <20190531063645.4697-9-namit@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 30, 2019, at 11:36 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
> cpu_tlbstate is mostly private and only the variable is_lazy is shared.
> This causes some false-sharing when TLB flushes are performed.
>=20
> Break cpu_tlbstate intro cpu_tlbstate and cpu_tlbstate_shared, and mark
> each one accordingly.
>=20

At some point we=E2=80=99ll want to do a better job with our PV flush code, a=
nd I suspect we=E2=80=99ll end up with more of this shared again.

> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
> arch/x86/include/asm/tlbflush.h | 40 ++++++++++++++++++---------------
> arch/x86/mm/init.c              |  2 +-
> arch/x86/mm/tlb.c               | 15 ++++++++-----
> 3 files changed, 32 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflu=
sh.h
> index 79272938cf79..a1fea36d5292 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -178,23 +178,6 @@ struct tlb_state {
>    u16 loaded_mm_asid;
>    u16 next_asid;
>=20
> -    /*
> -     * We can be in one of several states:
> -     *
> -     *  - Actively using an mm.  Our CPU's bit will be set in
> -     *    mm_cpumask(loaded_mm) and is_lazy =3D=3D false;
> -     *
> -     *  - Not using a real mm.  loaded_mm =3D=3D &init_mm.  Our CPU's bit=

> -     *    will not be set in mm_cpumask(&init_mm) and is_lazy =3D=3D fals=
e.
> -     *
> -     *  - Lazily using a real mm.  loaded_mm !=3D &init_mm, our bit
> -     *    is set in mm_cpumask(loaded_mm), but is_lazy =3D=3D true.
> -     *    We're heuristically guessing that the CR3 load we
> -     *    skipped more than makes up for the overhead added by
> -     *    lazy mode.
> -     */
> -    bool is_lazy;
> -
>    /*
>     * If set we changed the page tables in such a way that we
>     * needed an invalidation of all contexts (aka. PCIDs / ASIDs).
> @@ -240,7 +223,27 @@ struct tlb_state {
>     */
>    struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
> };
> -DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
> +DECLARE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate);
> +
> +struct tlb_state_shared {
> +    /*
> +     * We can be in one of several states:
> +     *
> +     *  - Actively using an mm.  Our CPU's bit will be set in
> +     *    mm_cpumask(loaded_mm) and is_lazy =3D=3D false;
> +     *
> +     *  - Not using a real mm.  loaded_mm =3D=3D &init_mm.  Our CPU's bit=

> +     *    will not be set in mm_cpumask(&init_mm) and is_lazy =3D=3D fals=
e.
> +     *
> +     *  - Lazily using a real mm.  loaded_mm !=3D &init_mm, our bit
> +     *    is set in mm_cpumask(loaded_mm), but is_lazy =3D=3D true.
> +     *    We're heuristically guessing that the CR3 load we
> +     *    skipped more than makes up for the overhead added by
> +     *    lazy mode.
> +     */
> +    bool is_lazy;
> +};
> +DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shar=
ed);
>=20
> /*
>  * Blindly accessing user memory from NMI context can be dangerous
> @@ -439,6 +442,7 @@ static inline void __native_flush_tlb_one_user(unsigne=
d long addr)
> {
>    u32 loaded_mm_asid =3D this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>=20
> +    //invpcid_flush_one(kern_pcid(loaded_mm_asid), addr);
>    asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
>=20
>    if (!static_cpu_has(X86_FEATURE_PTI))
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index fd10d91a6115..34027f36a944 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -951,7 +951,7 @@ void __init zone_sizes_init(void)
>    free_area_init_nodes(max_zone_pfns);
> }
>=20
> -__visible DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) =3D=
 {
> +__visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) =3D {
>    .loaded_mm =3D &init_mm,
>    .next_asid =3D 1,
>    .cr4 =3D ~0UL,    /* fail hard if we screw up cr4 shadow initialization=
 */
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index b0c3065aad5d..755b2bb3e5b6 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -144,7 +144,7 @@ void leave_mm(int cpu)
>        return;
>=20
>    /* Warn if we're not lazy. */
> -    WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
> +    WARN_ON(!this_cpu_read(cpu_tlbstate_shared.is_lazy));
>=20
>    switch_mm(NULL, &init_mm, NULL);
> }
> @@ -276,7 +276,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct=
 mm_struct *next,
> {
>    struct mm_struct *real_prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
>    u16 prev_asid =3D this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> -    bool was_lazy =3D this_cpu_read(cpu_tlbstate.is_lazy);
> +    bool was_lazy =3D this_cpu_read(cpu_tlbstate_shared.is_lazy);
>    unsigned cpu =3D smp_processor_id();
>    u64 next_tlb_gen;
>    bool need_flush;
> @@ -321,7 +321,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct=
 mm_struct *next,
>        __flush_tlb_all();
>    }
> #endif
> -    this_cpu_write(cpu_tlbstate.is_lazy, false);
> +    this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
>=20
>    /*
>     * The membarrier system call requires a full memory barrier and
> @@ -462,7 +462,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_=
struct *tsk)
>    if (this_cpu_read(cpu_tlbstate.loaded_mm) =3D=3D &init_mm)
>        return;
>=20
> -    this_cpu_write(cpu_tlbstate.is_lazy, true);
> +    this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
> }
>=20
> /*
> @@ -543,7 +543,7 @@ static void flush_tlb_func_common(const struct flush_t=
lb_info *f,
>    VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=3D=

>           loaded_mm->context.ctx_id);
>=20
> -    if (this_cpu_read(cpu_tlbstate.is_lazy)) {
> +    if (this_cpu_read(cpu_tlbstate_shared.is_lazy)) {
>        /*
>         * We're in lazy mode.  We need to at least flush our
>         * paging-structure cache to avoid speculatively reading
> @@ -659,11 +659,14 @@ static void flush_tlb_func_remote(void *info)
>=20
> static inline bool tlb_is_not_lazy(int cpu)
> {
> -    return !per_cpu(cpu_tlbstate.is_lazy, cpu);
> +    return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> }
>=20
> static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
>=20
> +DEFINE_PER_CPU_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
> +EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);
> +
> void native_flush_tlb_multi(const struct cpumask *cpumask,
>                const struct flush_tlb_info *info)
> {
> --=20
> 2.20.1
>=20
