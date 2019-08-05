Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA62C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48FD206C1
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ZW+9EsnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfHEGze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:55:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfHEGze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:55:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so83151298wrl.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TTBYe7R89ObYhNrQ7Cl1PDjf+qeeSySCDSm/yvi8hE=;
        b=ZW+9EsnPgnlzTYewisjxT+EOSy6r2aUxK55FB/Fm+mi+AtDooHD4mu+yQ4gb37M10g
         NFW40A+O1T6r5RXaZM/8SExP8R6DwkNY4tOg66IuS30k7+H4zGVIjXQc5CsCiFM2+BMe
         V0+mlrOMXhxPEG24hqd84dDo9gu3cphW0r9/JFlKTTaR+vGq0uS9aklZTp2Wcx8DcdRa
         2kuzuR1HDGS6PxOG/Lzvo154FcmiWh5jjA0bm9vC2WXhhhOramW5aZIV01jvhSj2rdDM
         n+kO58hpipZI6NalfKRWflgcGxRn2DNY40LLNgm/sPPLUvZwPDy7XRixemaSGUe+O/Df
         PYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TTBYe7R89ObYhNrQ7Cl1PDjf+qeeSySCDSm/yvi8hE=;
        b=LUiZI/W9xldoFRoycXs8UU4NKa9V5eJ2PHd8qA3IJALIoulLkwoIOqL43eoi+PsuMy
         tFRK8vWfGbFBnxYlO62wbn9eC+cVvw75nMPAW6zAkHNrpbDDHAeyYdHdXoKIDWeYVasr
         f5Ia3N5sPswnhxL8v2YkyrKycR/Oat+F/shcrNoGFj+1p7+8cryTX7GA55/CCLB5GjDO
         7minWESKoLOgodxKoaxszFSXvJXKwi6fW2XmBQpoVGRReasmlEXVHk9wa5KEdBHhsHEQ
         1tDeWrrFetJS8LpxgrzGbVIXaha7TMNQ++q2RhP4FR/1x5Ru3sUFtZaklCzs3aBRzDBm
         nKQw==
X-Gm-Message-State: APjAAAUQf0yskc37vZ3ZcrFGsuWmsZJ9nwN6BpPafHyoDNx2PzEty63u
        IaZf3nshwj/G0/0k+WA3Nnv5OiNukjVpqwiDotE=
X-Google-Smtp-Source: APXvYqxAjiUTpRBRVnl8zo2WRruaXTltVlSlDaYn0gjxaCM1yH1vbKfeokdHZ8Ie7GExj9eQjB7BsoJu8wlqK+dlYTk=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr150790179wra.328.1564988131513;
 Sun, 04 Aug 2019 23:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-8-anup.patel@wdc.com>
 <03f60f3a-bb50-9210-8352-da16cca322b9@redhat.com>
In-Reply-To: <03f60f3a-bb50-9210-8352-da16cca322b9@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 5 Aug 2019 12:25:20 +0530
Message-ID: <CAAhSdy3hdWfUCUEK-idoTzgB2hKeAd3FzsHEH1DK_BTC_KGdJw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement KVM_GET_ONE_REG/KVM_SET_ONE_REG
 ioctls
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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

On Fri, Aug 2, 2019 at 2:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/08/19 09:47, Anup Patel wrote:
> > +     if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
> > +             kvm_riscv_vcpu_flush_interrupts(vcpu, false);
>
> Not updating the vsip CSR here can cause an interrupt to be lost, if the
> next call to kvm_riscv_vcpu_flush_interrupts finds a zero mask.

Thanks for catching this issue. I will address it in v3.

If we think more on similar lines then we also need to handle the case
where Guest VCPU had pending interrupts and we suddenly stopped it
for Guest migration. In this case, we would eventually use SET_ONE_REG
ioctl on destination Host which should set vsip_shadow instead of vsip so
that we force update HW after resuming Guest VCPU on destination host.

>
> You could add a new field vcpu->vsip_shadow that is updated every time
> CSR_VSIP is written (including kvm_arch_vcpu_load) with a function like
>
> void kvm_riscv_update_vsip(struct kvm_vcpu *vcpu)
> {
>         if (vcpu->vsip_shadow != vcpu->arch.guest_csr.vsip) {
>                 csr_write(CSR_VSIP, vcpu->arch.guest_csr.vsip);
>                 vcpu->vsip_shadow = vcpu->arch.guest_csr.vsip;
>         }
> }
>
> And just call this unconditionally from kvm_vcpu_ioctl_run.  The cost is
> just a memory load per VS-mode entry, it should hardly be measurable.
>

I think we can do this at start of kvm_riscv_vcpu_flush_interrupts() as well.

Regards,
Anup
