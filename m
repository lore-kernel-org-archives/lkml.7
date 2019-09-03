Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E8322CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="L3WvK8Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfICJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:26:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38940 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfICJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:26:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id n2so15947128wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=320H5oeQ/ypZcJNziT2UEvpQLvhZJXO4w0Kft3y1blQ=;
        b=L3WvK8Fda9g/OFils619wQfmyD12uuA61bQl/l1rzqQGS+XiG9DZkPmnxECaVW8Yfy
         wVQBiPsO1nsrj3ZPVkgQiKFSudKf8UDs7dBhL8+u0WmTx3kQrQqOcxOGFj6ilF+fPB65
         IFp7XgPkxr7d6suy26EpCfguqH1uex0AHvemIomAJPgK/Q0aIcEvUETkjIbd8VS4WNlb
         +YbWv3qDKgIePZyyNcMUIR22ydth/bTj/ms3hvmWEDY8MwurYOy5NGKvA8WftKI8bcpy
         sH3zMs4IcfX00tZZilYCaxxTN0VMMijcxkDzGD+4OhOE8a4ZGUtbZytBJN/qWz+O3pnY
         EaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=320H5oeQ/ypZcJNziT2UEvpQLvhZJXO4w0Kft3y1blQ=;
        b=iXBbi1JPTdDk1EWC2QVcQkhxegSnROAScAvayo0u4YJr8etZXcP/UpqcUJnDczvIaE
         2tbJFotJwC+LH4q9hmvNnGP1sbZ1AM3rGJ4EpKtGiLelqCdh22GWmwvzjXnKVe9QHwgw
         3RSLVJFciyBeXQQ6VjPVuLcIAOv+zAtWskB75jF2OCazKcG335KZ8LrTEQaj3VQtKGt/
         89DmKCtPFmTuUgI2JtHu08rzjuEI7XCMyH1ykOZZro13813tLQbU9U8LiENOc2UQ3olo
         kC3TC2w+Ti1bbN5GY/bLfx/nNosBfpYY0mAHrbv7NeGUiM1QjztipN2LL9uD/6PqyMtI
         bnEA==
X-Gm-Message-State: APjAAAXkz3KxGdDf42qDlT+SDMp5jC/p1g1CSVWALPfoUqgkUeWgZ14U
        0wBT3xh3UiSSzymRPKKmpTvbcPnk8FjkdpsKOwpHqQ==
X-Google-Smtp-Source: APXvYqxbRKzXBZDIsULcCQOmd941u33RLDqR7W+BFpNzSkMZsny4p6y2wrdwkuKrl94bbnpxNfsz2eWptRCpwpAu9Is=
X-Received: by 2002:a1c:c909:: with SMTP id f9mr42044895wmb.52.1567502800623;
 Tue, 03 Sep 2019 02:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190829135427.47808-1-anup.patel@wdc.com> <20190829135427.47808-11-anup.patel@wdc.com>
 <20190903085823.s4amn27pewc54hl2@kamzik.brq.redhat.com>
In-Reply-To: <20190903085823.s4amn27pewc54hl2@kamzik.brq.redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 3 Sep 2019 14:56:29 +0530
Message-ID: <CAAhSdy1p3KG-m_Gw4LzeY+ap3reVpx+FNjugnDJEDj_-jhgc2w@mail.gmail.com>
Subject: Re: [PATCH v6 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
To:     Andrew Jones <drjones@redhat.com>
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

On Tue, Sep 3, 2019 at 2:28 PM Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Aug 29, 2019 at 01:56:18PM +0000, Anup Patel wrote:
> >  int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  {
> > -     /* TODO: */
> > +     u8 data8;
> > +     u16 data16;
> > +     u32 data32;
> > +     u64 data64;
> > +     ulong insn;
> > +     int len, shift;
> > +
> > +     insn = vcpu->arch.mmio_decode.insn;
> > +
> > +     if (run->mmio.is_write)
> > +             goto done;
> > +
> > +     len = vcpu->arch.mmio_decode.len;
> > +     shift = vcpu->arch.mmio_decode.shift;
> > +
> > +     switch (len) {
> > +     case 1:
> > +             data8 = *((u8 *)run->mmio.data);
> > +             SET_RD(insn, &vcpu->arch.guest_context,
> > +                     (ulong)data8 << shift >> shift);
> > +             break;
> > +     case 2:
> > +             data16 = *((u16 *)run->mmio.data);
> > +             SET_RD(insn, &vcpu->arch.guest_context,
> > +                     (ulong)data16 << shift >> shift);
> > +             break;
> > +     case 4:
> > +             data32 = *((u32 *)run->mmio.data);
> > +             SET_RD(insn, &vcpu->arch.guest_context,
> > +                     (ulong)data32 << shift >> shift);
> > +             break;
> > +     case 8:
> > +             data64 = *((u64 *)run->mmio.data);
> > +             SET_RD(insn, &vcpu->arch.guest_context,
> > +                     (ulong)data64 << shift >> shift);
> > +             break;
> > +     default:
> > +             return -ENOTSUPP;
> > +     };
> > +
> > +done:
> > +     /* Move to next instruction */
> > +     vcpu->arch.guest_context.sepc += INSN_LEN(insn);
> > +
>
> As I pointed out in the last review, just moving this instruction skip
> here is not enough. Doing so introduces the same problem that 2113c5f62b74
> ("KVM: arm/arm64: Only skip MMIO insn once") fixes for arm.

Thanks Drew, I had seen your comment previously but forgot
to address it in v6. I will address it in v7.

Regards,
Anup
