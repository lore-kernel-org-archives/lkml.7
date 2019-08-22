Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D21C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF44422CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="SsLoyyE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfHVN65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:58:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35245 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbfHVN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:58:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so5916685wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2ZETo25ZbVRtndwNoCMa7+VCH83yBcVxID8DRYyuKs=;
        b=SsLoyyE522ywIbe4SxLwD0VKyIDByZrtNPvNWvYLTA4kRAmAWxmfateXO/jFyWaiR7
         N/itX9bTIxwE4cBf/pxAO9XfvTUPiTk87Kn7jX1/FfAeODsDvA9iBb+yDXkT6oT0Xy87
         j6wFSjbJKNHrmL8a5RrFX3Avr2XRfpsUngPHa+6HmtmUmq/veGgUq7xtokdA6m06/Zwx
         ZBDzRi+CKbpMKvw4mVcrjWZIFIig9wMQ5v0YyRwhyXQJj629DruxjxezhbWkStjt9bwb
         HMJeASWbV8d8wFeuRFJZ7wflqATCIDDFU1GvyIBW4aPzKmMV5aPsafsEqaX9ypjHFtMg
         OO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2ZETo25ZbVRtndwNoCMa7+VCH83yBcVxID8DRYyuKs=;
        b=I4RoVtWDmk71egRJjq9pYCyFTXdW3lhJ1n4lfRkjMMhWGPBYoZuWKdHST524R78EtH
         bqT4t5So2O6GaJCe3Y9t3kHobXKBLozFMBV985GqFlX3X6SOCdsJCWSssEfx6yUdkx68
         T+v+LhYj0ZAMXGH9OMqiGXtXBlg3HZfEkvCzKn0X4qWBt1NiWVeQ7nykz9lpjME94p+v
         QAf9MJeiW0x3yr0Wd462Cxlj8nbOZXXfNzQUb5kBwrdIybImyvQ3J7qApUvJnhS/6yIV
         ohqCkuFmroPmfC92ubBjGZ7RDYRVaHUt0ojj/RbiQDrRbH3MCNYE8U1S7+ukxvlrqI8d
         UBew==
X-Gm-Message-State: APjAAAVPUwpKE8wxiex3FKU7vJhmiJLWya224uZfTmNvQWvq72czXj/+
        onYHXvw1jcZcTvGYEpqbmhykShU12ynqcBF/3iAg2mSB
X-Google-Smtp-Source: APXvYqwFCRfHPFhmoCxdnEut9Pl3bieYvMC+ES1WiyQNBcXiQzFQbQv/xowoZF8XsFOFoHrZnrb0cwnjMzew4z2awXs=
X-Received: by 2002:a1c:c909:: with SMTP id f9mr6765062wmb.52.1566482334676;
 Thu, 22 Aug 2019 06:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190822084131.114764-1-anup.patel@wdc.com> <20190822084131.114764-14-anup.patel@wdc.com>
 <77b9ff3c-292f-ee17-ddbb-134c0666fde7@amazon.com> <CAAhSdy1h+m0gA2pro-XAb4qhe0Q+8knjW+8+6jaz3efOdKWskA@mail.gmail.com>
 <a44f86ac-8902-0aa3-1eee-013ac97d667b@amazon.com>
In-Reply-To: <a44f86ac-8902-0aa3-1eee-013ac97d667b@amazon.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 22 Aug 2019 19:28:43 +0530
Message-ID: <CAAhSdy20D=t5hbeWDi=1XmNAe5rwvNyjMth-WUwrVe+HcagVpg@mail.gmail.com>
Subject: Re: [PATCH v5 13/20] RISC-V: KVM: Implement stage2 page table programming
To:     Alexander Graf <graf@amazon.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 6:57 PM Alexander Graf <graf@amazon.com> wrote:
>
>
>
> On 22.08.19 14:38, Anup Patel wrote:
> > On Thu, Aug 22, 2019 at 5:58 PM Alexander Graf <graf@amazon.com> wrote:
> >>
> >> On 22.08.19 10:45, Anup Patel wrote:
> >>> This patch implements all required functions for programming
> >>> the stage2 page table for each Guest/VM.
> >>>
> >>> At high-level, the flow of stage2 related functions is similar
> >>> from KVM ARM/ARM64 implementation but the stage2 page table
> >>> format is quite different for KVM RISC-V.
> >>>
> >>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> ---
> >>>    arch/riscv/include/asm/kvm_host.h     |  10 +
> >>>    arch/riscv/include/asm/pgtable-bits.h |   1 +
> >>>    arch/riscv/kvm/mmu.c                  | 637 +++++++++++++++++++++++++-
> >>>    3 files changed, 638 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> >>> index 3b09158f80f2..a37775c92586 100644
> >>> --- a/arch/riscv/include/asm/kvm_host.h
> >>> +++ b/arch/riscv/include/asm/kvm_host.h
> >>> @@ -72,6 +72,13 @@ struct kvm_mmio_decode {
> >>>        int shift;
> >>>    };
> >>>
> >>> +#define KVM_MMU_PAGE_CACHE_NR_OBJS   32
> >>> +
> >>> +struct kvm_mmu_page_cache {
> >>> +     int nobjs;
> >>> +     void *objects[KVM_MMU_PAGE_CACHE_NR_OBJS];
> >>> +};
> >>> +
> >>>    struct kvm_cpu_context {
> >>>        unsigned long zero;
> >>>        unsigned long ra;
> >>> @@ -163,6 +170,9 @@ struct kvm_vcpu_arch {
> >>>        /* MMIO instruction details */
> >>>        struct kvm_mmio_decode mmio_decode;
> >>>
> >>> +     /* Cache pages needed to program page tables with spinlock held */
> >>> +     struct kvm_mmu_page_cache mmu_page_cache;
> >>> +
> >>>        /* VCPU power-off state */
> >>>        bool power_off;
> >>>
> >>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> >>> index bbaeb5d35842..be49d62fcc2b 100644
> >>> --- a/arch/riscv/include/asm/pgtable-bits.h
> >>> +++ b/arch/riscv/include/asm/pgtable-bits.h
> >>> @@ -26,6 +26,7 @@
> >>>
> >>>    #define _PAGE_SPECIAL   _PAGE_SOFT
> >>>    #define _PAGE_TABLE     _PAGE_PRESENT
> >>> +#define _PAGE_LEAF      (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
> >>>
> >>>    /*
> >>>     * _PAGE_PROT_NONE is set on not-present pages (and ignored by the hardware) to
> >>> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> >>> index 2b965f9aac07..9e95ab6769f6 100644
> >>> --- a/arch/riscv/kvm/mmu.c
> >>> +++ b/arch/riscv/kvm/mmu.c
> >>> @@ -18,6 +18,432 @@
> >>>    #include <asm/page.h>
> >>>    #include <asm/pgtable.h>
> >>>
> >>> +#ifdef CONFIG_64BIT
> >>> +#define stage2_have_pmd              true
> >>> +#define stage2_gpa_size              ((phys_addr_t)(1ULL << 39))
> >>> +#define stage2_cache_min_pages       2
> >>> +#else
> >>> +#define pmd_index(x)         0
> >>> +#define pfn_pmd(x, y)                ({ pmd_t __x = { 0 }; __x; })
> >>> +#define stage2_have_pmd              false
> >>> +#define stage2_gpa_size              ((phys_addr_t)(1ULL << 32))
> >>> +#define stage2_cache_min_pages       1
> >>> +#endif
> >>> +
> >>> +static int stage2_cache_topup(struct kvm_mmu_page_cache *pcache,
> >>> +                           int min, int max)
> >>> +{
> >>> +     void *page;
> >>> +
> >>> +     BUG_ON(max > KVM_MMU_PAGE_CACHE_NR_OBJS);
> >>> +     if (pcache->nobjs >= min)
> >>> +             return 0;
> >>> +     while (pcache->nobjs < max) {
> >>> +             page = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> >>> +             if (!page)
> >>> +                     return -ENOMEM;
> >>> +             pcache->objects[pcache->nobjs++] = page;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static void stage2_cache_flush(struct kvm_mmu_page_cache *pcache)
> >>> +{
> >>> +     while (pcache && pcache->nobjs)
> >>> +             free_page((unsigned long)pcache->objects[--pcache->nobjs]);
> >>> +}
> >>> +
> >>> +static void *stage2_cache_alloc(struct kvm_mmu_page_cache *pcache)
> >>> +{
> >>> +     void *p;
> >>> +
> >>> +     if (!pcache)
> >>> +             return NULL;
> >>> +
> >>> +     BUG_ON(!pcache->nobjs);
> >>> +     p = pcache->objects[--pcache->nobjs];
> >>> +
> >>> +     return p;
> >>> +}
> >>> +
> >>> +struct local_guest_tlb_info {
> >>> +     struct kvm_vmid *vmid;
> >>> +     gpa_t addr;
> >>> +};
> >>> +
> >>> +static void local_guest_tlb_flush_vmid_gpa(void *info)
> >>> +{
> >>> +     struct local_guest_tlb_info *infop = info;
> >>> +
> >>> +     __kvm_riscv_hfence_gvma_vmid_gpa(READ_ONCE(infop->vmid->vmid_version),
> >>> +                                      infop->addr);
> >>> +}
> >>> +
> >>> +static void stage2_remote_tlb_flush(struct kvm *kvm, gpa_t addr)
> >>> +{
> >>> +     struct local_guest_tlb_info info;
> >>> +     struct kvm_vmid *vmid = &kvm->arch.vmid;
> >>> +
> >>> +     /* TODO: This should be SBI call */
> >>> +     info.vmid = vmid;
> >>> +     info.addr = addr;
> >>> +     preempt_disable();
> >>> +     smp_call_function_many(cpu_all_mask, local_guest_tlb_flush_vmid_gpa,
> >>> +                            &info, true);
> >>
> >> This is all nice and dandy on the toy 4 core systems we have today, but
> >> it will become a bottleneck further down the road.
> >>
> >> How many VMIDs do you have? Could you just allocate a new one every time
> >> you switch host CPUs? Then you know exactly which CPUs to flush by
> >> looking at all your vcpu structs and a local field that tells you which
> >> pCPU they're on at this moment.
> >>
> >> Either way, it's nothing that should block inclusion. For today, we're fine.
> >
> > We are not happy about this either.
> >
> > Other two options, we have are:
> > 1. Have SBI calls for remote HFENCEs
> > 2. Propose RISC-V ISA extension for remote FENCEs
> >
> > Option1 is mostly extending SBI spec and implementing it in runtime
> > firmware.
> >
> > Option2 is ideal solution but requires consensus among wider audience
> > in RISC-V foundation.
> >
> > At this point, we are fine with a simple solution.
>
> It's fine to explicitly IPI other CPUs to flush their TLBs. What is not
> fine is to IPI *all* CPUs to flush their TLBs.

Ahh, this should have been cpu_online_mask instead of cpu_all_mask

I will update this in next revision.

Regards,
Anup

>
>
> Alex
