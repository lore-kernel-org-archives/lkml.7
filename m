Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E688C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F324F20657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="j2cxRWIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfHEL4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:56:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55540 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfHEL4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:56:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so74448161wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhTBJZEcsjvTkvOpSV7JcEtFKAA9Exg0pMP9uE8HBUs=;
        b=j2cxRWIzJWwkZSXOsd7iqkdySk76thOrHaNvBOCn2itmKfoj5zmnKFKd5PZ83DQUpd
         VWN6CriBZdpZ6mayWW41Dg0KK6Np+Wv8SZf0ZyjwXE42dDXcHFU2P964QIOrXYcB9RrJ
         th68YmT5hWQKspO1CFMPKRhlZ68MHu1nfflC4c316MaJM41iyU3eG+5jEOH6IOSi6FDc
         JOQPdmSu01w6czCcx8rCHJLaXZ4Ig5ko6Qtd28QVjqmvlANS2GK+V/gisiBAt9NChtg0
         e42XgEfznhyur69CRHk2XN/GF62OC+Xd06npgkw7ZqGvaqWVi0uGxeeRuDsHgwc+JF7P
         /5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhTBJZEcsjvTkvOpSV7JcEtFKAA9Exg0pMP9uE8HBUs=;
        b=IZaVFcxJ0SCop8SRJ9ziM7eblZ3cNg5+NU7+tpYJc1DR34FTXv/WHgvZXabTO1OEOA
         eD1GmgIu/uNS2rdWlrVD+4LQJANemHyx8ryjbzqYeeu21vqeNoSSIGJsLYyudhRd0U//
         /uR6+fbcq7tY/tIwTyq6WpXDeJtKifHUW9ukBi9BjB16p/0fiN4TolAdN6LhW3vu+vEX
         S56taByH8syYpNgYJ0elQXc0q0cxUAMIU5S86z+paUFBKScQOnvDykAyQY25Kv5PtJvB
         8gXlwrARipK9TsnZcejver5zfIjK6SwvY3qBE6agJFJ7RHTgbGzmV5n85vV/7rQNxaUJ
         5Uyg==
X-Gm-Message-State: APjAAAUp/1IgL/f5b/zbtJOxiHY6Z8CX6evXAgjdu/K/YoX3MIZXhqP2
        va97pmyMexaugSKnjf8JPNeAtaEfdXSqq9Ki5d+ybg==
X-Google-Smtp-Source: APXvYqyF2repcCJOaZYS4p2lUuk5LTjS5XFEImFO3Oxk67YaRU8tEsimiGNdEpidJLWjEePzjO3jrxahGnlJVrib7EY=
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr17243611wma.171.1565006193144;
 Mon, 05 Aug 2019 04:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-8-anup.patel@wdc.com>
 <edbed85f-f7ad-a240-1bef-75729b527a69@de.ibm.com>
In-Reply-To: <edbed85f-f7ad-a240-1bef-75729b527a69@de.ibm.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 5 Aug 2019 17:26:21 +0530
Message-ID: <CAAhSdy2PDSpTy1JEEC2LCB4ESvZHBbkVEZ2wqz-D2b7SKD5VSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement KVM_GET_ONE_REG/KVM_SET_ONE_REG
 ioctls
To:     Christian Borntraeger <borntraeger@de.ibm.com>
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

On Mon, Aug 5, 2019 at 5:08 PM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 02.08.19 09:47, Anup Patel wrote:
> > For KVM RISC-V, we use KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls to access
> > VCPU config and registers from user-space.
> >
> > We have three types of VCPU registers:
> > 1. CONFIG - these are VCPU config and capabilities
> > 2. CORE   - these are VCPU general purpose registers
> > 3. CSR    - these are VCPU control and status registers
> >
> > The CONFIG registers available to user-space are ISA and TIMEBASE. Out
> > of these, TIMEBASE is a read-only register which inform user-space about
> > VCPU timer base frequency. The ISA register is a read and write register
> > where user-space can only write the desired VCPU ISA capabilities before
> > running the VCPU.
> >
> > The CORE registers available to user-space are PC, RA, SP, GP, TP, A0-A7,
> > T0-T6, S0-S11 and MODE. Most of these are RISC-V general registers except
> > PC and MODE. The PC register represents program counter whereas the MODE
> > register represent VCPU privilege mode (i.e. S/U-mode).
> >
> > The CSRs available to user-space are SSTATUS, SIE, STVEC, SSCRATCH, SEPC,
> > SCAUSE, STVAL, SIP, and SATP. All of these are read/write registers.
> >
> > In future, more VCPU register types will be added (such as FP) for the
> > KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls.
>
> While have ONE_REG will certainly work, have you considered the sync_reg scheme
> (registers as part of kvm_run structure)
> This will speed up the exit to QEMU as you do not have to do multiple ioctls
> (each imposing a systemcall overhead) for one exit.
>
> Ideally you should not exit too often into qemu, but for those cases sync_regs
> is faster than ONE_REG.
>

We will certainly explore sync_regs interface. Reducing exits to user-space
will definitely help.

This is the first series for KVM RISC-V so here we want to establish a stable
and extensible UAPI header using which we will add support to QEMU KVM.

For time being, we are using KVMTOOL for debug and development.

Thanks,
Anup
