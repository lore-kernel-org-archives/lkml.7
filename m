Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A47DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CAD20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eVWg8TPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404415AbfHBIoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:44:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40277 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHBIoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:44:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so76271675wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fvZtEUHzSAKzVrV5AOyqmz39HB0VJQNW+QYwyaRSP8=;
        b=eVWg8TPmTdTRpDNDCOsjC4/KOvtHtbA59TBmQpqBTpEAcbGe1sHWV9Ml4O0/GHWjIC
         TIk0QMnDFaqET3emtRhSQaQHsG2RAbId4A2KPGGTXL7s29NqSW0K7GhCoMcmZ+KZ8dKI
         PwC6FuSYrrbGPGJf7mkFuicfKeymU78FbY7saknYYNLWo+vqWdXIxb2vNEl+c/oSo1vJ
         D72TyjVS2XCILOUSIqknYw+d+6Lri7hcad32mztop9cmXfd93VlHjoizzJNNbHW94HmX
         c5BZ/dtEwOAoDlwI85Byw8UHZh49hT1dy6qXDhYaW/bYdZh16X7zSNGwUAWBPXZVo3k4
         lV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fvZtEUHzSAKzVrV5AOyqmz39HB0VJQNW+QYwyaRSP8=;
        b=fN1CKO0LT0zpLZLx+N9qIlZ1zXUf6RBS7yR8REUZQN1FXyQMj4hET7YzysIfnNaNkt
         5pFsgg6rygZMaEoFSEUCw2aTS+uNvzQw2OfHThVp5gDXuj5rfSFudZvo26qerDbJdKwi
         sO8R0OUBcrdlxnpDi833fRFpAmh63AvcmZOAKOrIR9D4D68OYVpcxCIry5enR24oR+tQ
         ySV17t4fOcx61IbXNh50c5qB1PMpdC3gYZfoipZDXui/k4rtPliFSjmRr08ITV6VVbOn
         iCtDlbbtqRLZp2pQ99OUv2Wz6YNVRBVExI9sCkVdqUd3sJTPH5rFOXT6tpqdHGQm6/x+
         0RUg==
X-Gm-Message-State: APjAAAU2V5+IgeYsJGW9JiLj2B8Dx3ZNEmN3NLDpzqxufF7X8Rc8c0jf
        TT2cY652zng/NFo+oviDJ6JJSQatW+8q6zCfcRE=
X-Google-Smtp-Source: APXvYqxas7y2Zc7v8qVSPU0beTBrHfoNVyfQR6SsOerqrYpig1rTc8AZXwSt8FqQnA9mXGGMe0nRqgvYh5el8Os44GI=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr136837207wra.328.1564735442789;
 Fri, 02 Aug 2019 01:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-9-anup.patel@wdc.com>
 <72d8efbf-ec62-ab1e-68bf-e0c5f0bc256e@redhat.com>
In-Reply-To: <72d8efbf-ec62-ab1e-68bf-e0c5f0bc256e@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Aug 2019 14:13:52 +0530
Message-ID: <CAAhSdy2_ZsnT7gSKb624r9wzuJSx+1TnKxgW6srtqvXV1Ri9Aw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/19] RISC-V: KVM: Implement VCPU world-switch
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

On Fri, Aug 2, 2019 at 2:00 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/08/19 09:47, Anup Patel wrote:
> > +     /* Save Host SSTATUS, HSTATUS, SCRATCH and STVEC */
> > +     csrr    t0, CSR_SSTATUS
> > +     REG_S   t0, (KVM_ARCH_HOST_SSTATUS)(a0)
> > +     csrr    t1, CSR_HSTATUS
> > +     REG_S   t1, (KVM_ARCH_HOST_HSTATUS)(a0)
> > +     csrr    t2, CSR_SSCRATCH
> > +     REG_S   t2, (KVM_ARCH_HOST_SSCRATCH)(a0)
> > +     csrr    t3, CSR_STVEC
> > +     REG_S   t3, (KVM_ARCH_HOST_STVEC)(a0)
> > +
>
> A possible optimization: if these cannot change while Linux runs (I am
> thinking especially of STVEC and HSTATUS, but perhaps SSCRATCH can be
> saved on kvm_arch_vcpu_load too) you can avoid the csrr and store.

Actual exception vector of Host Linux is different so we switch STVEC
every time.

HSTATUS.SPV is set whenever we come back from Guest world so
while we are in in-kernel run loop with interrupts enabled we can get
external interrupt and HSTATUS.SPV bit can affect SRET of interrupt
handler. To handle this we switch HSTATUS every time.

The world switch code uses SSCRATCH to save vcpu->arch pointer
which is later used on return path. Now, I did not want to restrict Host
Linux from using SSCRATCH for some other purpose hence we
switch SSCRATCH every time.

Regards,
Anup
