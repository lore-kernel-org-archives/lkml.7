Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA922CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="egKRBOY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394452AbfHWMTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:19:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35543 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbfHWMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:19:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so8459848wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYnKooGAz/mlH//vFYVeCnlGLtd4YMyaR7dMhD5g3Ao=;
        b=egKRBOY6T+iHEx6i2bpwOVrDK5E+iUy/1Jr2VP37Xdy4TLrla+q4pkZndjdXqnHiHK
         mtaTLIxuZBDXoLfDMhs4tYjjWnmMGtyl5dLbT1yCedbE7MMf8Mh90hvJdKJp+3qcI/tW
         MtUpYrMIf91Fd5vQMkm5yeMAHyx2FZ7jSNafbeDlyDfN9gxyJjsa4K1f68DNVX5C0VpA
         4zzgHgKKf74NPSusdkLYUGCaL7ep7967MErfnLWERuCwcRGWnaSBe7OQYYS/k/DQ+e8I
         Pj5tnbOCxnwiNxiDgpGICI9Do0qy2STOJpt8GCil1Kr5guweLZFAsmmdrDdHNVzdPm2z
         iUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYnKooGAz/mlH//vFYVeCnlGLtd4YMyaR7dMhD5g3Ao=;
        b=TMKjA8zWkRd1eHENlQZy4d0KsFn1/XY8ddJZFVbATwLwdG2MZ6eiCeiZr0OvEGOX53
         1bRMcnDzLJo2gNtWYQK2H+9hPQzB6jrTp4orOl/ovyu3zRTdNLTeTVityOwk0Ym6F8pE
         xexcx4yV0Lc1rbrZ/U3P53WJO8ddZOPE5BalJErGV9NxLyPlnGdwIxy3lNmrBC1jos0v
         +8upK3z5ZR7R+njk6KD2XUdjMLF4bx70ICYzofBjHbcO6VHmrOY5xY8z1LSZdYNiqgFf
         r4tOkLsyeXf3WAtc4lwcDvG3MndNpnOy/hjokifDwIV8Qgj5U3u22VZFsbQEbdTECCcB
         lWnQ==
X-Gm-Message-State: APjAAAXVSuMejbdCtN3ypyxcP4IR01lIP5T743M6IKbCuHUR2Eef6DG/
        Z6Q6Px9oHVXuqmouuZRuTyFqa3V3ILYA+rLZVVIDwQ==
X-Google-Smtp-Source: APXvYqyiffUPdRbthtoeU5iHSxUcXZATp2nwKI/3hiwIGiM2dZnwJz+txTHd6WA3LOy2smUSPUERZ3sDle/MwMI8wro=
X-Received: by 2002:adf:f641:: with SMTP id x1mr4992458wrp.179.1566562756752;
 Fri, 23 Aug 2019 05:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190822084131.114764-1-anup.patel@wdc.com> <8a2a9ea6-5636-e79a-b041-580159e703b2@amazon.com>
 <CAAhSdy2RC6Gw708wZs+FM56UkkyURgbupwdeTak7VcyarY9irg@mail.gmail.com>
 <757C929B-D26C-46D9-98E8-1191E3B86F3C@amazon.com> <fda67a5d-6984-c3ef-8125-7805d927f15b@redhat.com>
In-Reply-To: <fda67a5d-6984-c3ef-8125-7805d927f15b@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Aug 2019 17:49:05 +0530
Message-ID: <CAAhSdy1k96m8GinxAhcfRL_gOxCzK+ODfyjDxCmr-AF2ycntwA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] KVM RISC-V Support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Graf (AWS), Alexander" <graf@amazon.com>,
        Anup Patel <Anup.Patel@wdc.com>,
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

On Fri, Aug 23, 2019 at 5:40 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/08/19 13:44, Graf (AWS), Alexander wrote:
> >> Overall, I'm quite happy with the code. It's a very clean implementation
> >> of a KVM target.
>
> Yup, I said the same even for v1 (I prefer recursive implementation of
> page table walking but that's all I can say).
>
> >> I will send v6 next week. I will try my best to implement unpriv
> >> trap handling in v6 itself.
> > Are you sure unpriv is the only exception that can hit there? What
> > about NMIs? Do you have #MCs yet (ECC errors)? Do you have something
> > like ARM's #SError which can asynchronously hit at any time because
> > of external bus (PCI) errors?
>
> As far as I know, all interrupts on RISC-V are disabled by
> local_irq_disable()/local_irq_enable().

Yes, we don't have per-CPU interrupts for async bus errors or
non-maskable interrupts. The local_irq_disable() and local_irq_enable()
affect all interrupts (excepts traps).

Although, the async bus errors can certainly be routed to Linux
via PLIC (interrupt-controller) as regular peripheral interrupts.

Regards,
Anup

>
> Paolo
