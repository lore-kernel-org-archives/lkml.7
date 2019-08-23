Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82957C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3229F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VQVQnrUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfHWLEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:04:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46830 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfHWLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:04:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so8226031wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygfIpc5apaxRo+gk58vjhr3w3ln7J604+QM3c4R2roQ=;
        b=VQVQnrURdnPzhIrabeH5DtvjFIUJ7ZIjRkrIUgxeou+tMh2L/UjgAA9hf3ChtnuOsR
         KI1cDth9m3TkdG1zz9zyr59VL8jXXYZrBWaZoKSxUJYBhqP2A/JiN1oP163a7lrwlZBK
         8IP4uJfpuSht6hcsCGktzEZxPhCUST2hQ0V9T7fG0fo/JXm3lrw7zSMuu3NkRfSN7g7Z
         jqISKCYSsAute1hCed0/6lVnTfMQsWqp1J/4ly+4rFDXMWgQDUSPMBzfyI6ItLio36Xb
         e76cTaidDb7ILaRBRCLxsZOfr8TLE/ulgdqzYjUsU0zF7Uk+Nmb9dISwWgIpsdV+Kdq2
         9rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygfIpc5apaxRo+gk58vjhr3w3ln7J604+QM3c4R2roQ=;
        b=Q+7NJMtYzeb0/r7YAUNc0EKja+SrlyhtX9K+nsWjqWd2c2pC1nZ4b0u8n8vvkqXXlM
         f1AiNWBzICLjiTMt1+5D5b8DyVNRGZKOnxtHjIsfI3CzS3heLxkaHlvoDyGhCFB9uzg3
         yt1l2xNrQ4ZVYsjhbsdI210Eae2C0do0rmdo8acI3L9A4Mbjzh9OTelfdiMHWixaQc8x
         uwp6JmvZlizMX5H8UiMlnxG3iF2NXkb704eXQUwpeIC4hQLMeIHMy5Z5i8hMy3C7urBE
         tfp3pbJ2Bqcwmx8r1KoJnVCqqurWR3G5urhsWsvRyHR6kJllPlhQaF2sTpeZV2v16JWL
         bBzw==
X-Gm-Message-State: APjAAAVYmHyMUDPICA6AjnzJJvd1Pzg5Lo6tqwCSEz0HUy72JW4GWgYb
        i1AeQ6HIwBfZP2PoRz0IZ4p4lonQel6T2Dbtb7BD8A==
X-Google-Smtp-Source: APXvYqyGTcFpwVXeR8p0rFxkPUmfj0ZXcu+4OQoD1Tzt7QkIB/fNyXgSbNMHu3m0BsuivcaxOqd8c8yXlsMZ8ZAGYKc=
X-Received: by 2002:adf:f641:: with SMTP id x1mr4581017wrp.179.1566558286135;
 Fri, 23 Aug 2019 04:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190822084131.114764-1-anup.patel@wdc.com> <20190822084131.114764-16-anup.patel@wdc.com>
 <09d74212-4fa3-d64c-5a63-d556e955b88c@amazon.com>
In-Reply-To: <09d74212-4fa3-d64c-5a63-d556e955b88c@amazon.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Aug 2019 16:34:33 +0530
Message-ID: <CAAhSdy36q5-x8cXM=M5S3cnE2nvCMhcsfuQayVt7jahd58HWFw@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] RISC-V: KVM: Add timer functionality
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

On Fri, Aug 23, 2019 at 1:23 PM Alexander Graf <graf@amazon.com> wrote:
>
> On 22.08.19 10:46, Anup Patel wrote:
> > From: Atish Patra <atish.patra@wdc.com>
> >
> > The RISC-V hypervisor specification doesn't have any virtual timer
> > feature.
> >
> > Due to this, the guest VCPU timer will be programmed via SBI calls.
> > The host will use a separate hrtimer event for each guest VCPU to
> > provide timer functionality. We inject a virtual timer interrupt to
> > the guest VCPU whenever the guest VCPU hrtimer event expires.
> >
> > The following features are not supported yet and will be added in
> > future:
> > 1. A time offset to adjust guest time from host time
> > 2. A saved next event in guest vcpu for vm migration
>
> Implementing these 2 bits right now should be trivial. Why wait?

We were waiting for HTIMEDELTA CSR to be merged so we
deferred this items.

>
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   arch/riscv/include/asm/kvm_host.h       |   4 +
> >   arch/riscv/include/asm/kvm_vcpu_timer.h |  32 +++++++
> >   arch/riscv/kvm/Makefile                 |   2 +-
> >   arch/riscv/kvm/vcpu.c                   |   6 ++
> >   arch/riscv/kvm/vcpu_timer.c             | 106 ++++++++++++++++++++++++
> >   drivers/clocksource/timer-riscv.c       |   8 ++
> >   include/clocksource/timer-riscv.h       |  16 ++++
> >   7 files changed, 173 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/riscv/include/asm/kvm_vcpu_timer.h
> >   create mode 100644 arch/riscv/kvm/vcpu_timer.c
> >   create mode 100644 include/clocksource/timer-riscv.h
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index ab33e59a3d88..d2a2e45eefc0 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -12,6 +12,7 @@
> >   #include <linux/types.h>
> >   #include <linux/kvm.h>
> >   #include <linux/kvm_types.h>
> > +#include <asm/kvm_vcpu_timer.h>
> >
> >   #ifdef CONFIG_64BIT
> >   #define KVM_MAX_VCPUS                       (1U << 16)
> > @@ -167,6 +168,9 @@ struct kvm_vcpu_arch {
> >       unsigned long irqs_pending;
> >       unsigned long irqs_pending_mask;
> >
> > +     /* VCPU Timer */
> > +     struct kvm_vcpu_timer timer;
> > +
> >       /* MMIO instruction details */
> >       struct kvm_mmio_decode mmio_decode;
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_timer.h b/arch/riscv/include/asm/kvm_vcpu_timer.h
> > new file mode 100644
> > index 000000000000..df67ea86988e
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/kvm_vcpu_timer.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> > + *
> > + * Authors:
> > + *   Atish Patra <atish.patra@wdc.com>
> > + */
> > +
> > +#ifndef __KVM_VCPU_RISCV_TIMER_H
> > +#define __KVM_VCPU_RISCV_TIMER_H
> > +
> > +#include <linux/hrtimer.h>
> > +
> > +#define VCPU_TIMER_PROGRAM_THRESHOLD_NS              1000
> > +
> > +struct kvm_vcpu_timer {
> > +     bool init_done;
> > +     /* Check if the timer is programmed */
> > +     bool is_set;
> > +     struct hrtimer hrt;
> > +     /* Mult & Shift values to get nanosec from cycles */
> > +     u32 mult;
> > +     u32 shift;
> > +};
> > +
> > +int kvm_riscv_vcpu_timer_init(struct kvm_vcpu *vcpu);
> > +int kvm_riscv_vcpu_timer_deinit(struct kvm_vcpu *vcpu);
> > +int kvm_riscv_vcpu_timer_reset(struct kvm_vcpu *vcpu);
> > +int kvm_riscv_vcpu_timer_next_event(struct kvm_vcpu *vcpu,
> > +                                 unsigned long ncycles);
>
> This function never gets called?

It's called from SBI emulation.

>
> > +
> > +#endif
> > diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> > index c0f57f26c13d..3e0c7558320d 100644
> > --- a/arch/riscv/kvm/Makefile
> > +++ b/arch/riscv/kvm/Makefile
> > @@ -9,6 +9,6 @@ ccflags-y := -Ivirt/kvm -Iarch/riscv/kvm
> >   kvm-objs := $(common-objs-y)
> >
> >   kvm-objs += main.o vm.o vmid.o tlb.o mmu.o
> > -kvm-objs += vcpu.o vcpu_exit.o vcpu_switch.o
> > +kvm-objs += vcpu.o vcpu_exit.o vcpu_switch.o vcpu_timer.o
> >
> >   obj-$(CONFIG_KVM)   += kvm.o
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 6124077d154f..018fca436776 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -54,6 +54,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
> >
> >       memcpy(cntx, reset_cntx, sizeof(*cntx));
> >
> > +     kvm_riscv_vcpu_timer_reset(vcpu);
> > +
> >       WRITE_ONCE(vcpu->arch.irqs_pending, 0);
> >       WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
> >   }
> > @@ -108,6 +110,9 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
> >       cntx->hstatus |= HSTATUS_SP2P;
> >       cntx->hstatus |= HSTATUS_SPV;
> >
> > +     /* Setup VCPU timer */
> > +     kvm_riscv_vcpu_timer_init(vcpu);
> > +
> >       /* Reset VCPU */
> >       kvm_riscv_reset_vcpu(vcpu);
> >
> > @@ -116,6 +121,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
> >
> >   void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> >   {
> > +     kvm_riscv_vcpu_timer_deinit(vcpu);
> >       kvm_riscv_stage2_flush_cache(vcpu);
> >       kmem_cache_free(kvm_vcpu_cache, vcpu);
> >   }
> > diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> > new file mode 100644
> > index 000000000000..a45ca06e1aa6
> > --- /dev/null
> > +++ b/arch/riscv/kvm/vcpu_timer.c
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> > + *
> > + * Authors:
> > + *     Atish Patra <atish.patra@wdc.com>
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/err.h>
> > +#include <linux/kvm_host.h>
> > +#include <clocksource/timer-riscv.h>
> > +#include <asm/csr.h>
> > +#include <asm/kvm_vcpu_timer.h>
> > +
> > +static enum hrtimer_restart kvm_riscv_vcpu_hrtimer_expired(struct hrtimer *h)
> > +{
> > +     struct kvm_vcpu_timer *t = container_of(h, struct kvm_vcpu_timer, hrt);
> > +     struct kvm_vcpu *vcpu = container_of(t, struct kvm_vcpu, arch.timer);
> > +
> > +     t->is_set = false;
> > +     kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_S_TIMER);
> > +
> > +     return HRTIMER_NORESTART;
> > +}
> > +
> > +static u64 kvm_riscv_delta_cycles2ns(u64 cycles, struct kvm_vcpu_timer *t)
> > +{
> > +     unsigned long flags;
> > +     u64 cycles_now, cycles_delta, delta_ns;
> > +
> > +     local_irq_save(flags);
> > +     cycles_now = get_cycles64();
> > +     if (cycles_now < cycles)
> > +             cycles_delta = cycles - cycles_now;
> > +     else
> > +             cycles_delta = 0;
> > +     delta_ns = (cycles_delta * t->mult) >> t->shift;
> > +     local_irq_restore(flags);
> > +
> > +     return delta_ns;
> > +}
> > +
> > +static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
> > +{
> > +     if (!t->init_done || !t->is_set)
> > +             return -EINVAL;
> > +
> > +     hrtimer_cancel(&t->hrt);
> > +     t->is_set = false;
> > +
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_timer_next_event(struct kvm_vcpu *vcpu,
> > +                                 unsigned long ncycles)
> > +{
> > +     struct kvm_vcpu_timer *t = &vcpu->arch.timer;
> > +     u64 delta_ns = kvm_riscv_delta_cycles2ns(ncycles, t);
>
> ... in fact, I feel like I'm missing something obvious here. How does
> the guest trigger the timer event? What is the argument it uses for that
> and how does that play with the tbfreq in the earlier patch?

We have SBI call inferface between Hypervisor and Guest. One of the
SBI call allows Guest to program time event. The next event is specified
as absolute cycles. The Guest can read time using TIME CSR which
returns system timer value (@ tbfreq freqency).

Guest Linux will know the tbfreq from DTB passed by QEMU/KVMTOOL
and it has to be same as Host tbfreq.

The TBFREQ config register visible to user-space is a read-only CONFIG
register which tells user-space tools (QEMU/KVMTOOL) about Host tbfreq.

Regards,
Anup

>
>
> Alex
>
