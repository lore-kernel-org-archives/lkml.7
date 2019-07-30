Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98633C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687342087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="hk/KqKIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfG3MJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:09:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfG3MJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:09:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so65574348wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEXRKVgiAewSzMHKuc4kYp85srZxayAyjwnb+cltz/A=;
        b=hk/KqKIGVmzsttbZR/gwF2OK0U4nrpMkMwgRfr4Suo1MJW2IsOPukKgv1lmqoSVUg0
         NBSR/3ku96WkmFUeRHx/6fqdNY7BtJP9EegEJVfs9eQkmvAITRarqhgmAJhPrrrTFwtK
         /NYeHp4JADVMdK6Z5mZH+maD5ERJmoTMxpKWubgggtX482hx5c1a8qUXN4ztkebaAXg5
         5CnI4ELBh+DDI08aHsI6B3hNBiuGKudfjO10f7xXoGTtPSHG3Hvq87Qao7/eUZESPJ9k
         UcWs5FBuqtax0X+W+DgUz2Xdw9l11bk1qBXgPXxW+q0MIdDYe4uoZ9W2FPiCToTeK7v1
         yeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEXRKVgiAewSzMHKuc4kYp85srZxayAyjwnb+cltz/A=;
        b=BXqslbWz6dlLyDG9a4O60Xp11XlsIhJu32WiGLw5qn0tgAWMVj/t/AJFl1CBcfywka
         yrUIS0QGejTDX1ay66DiXYF+0XjGm4RBAIBi9pZgMfHHx2UzTVsuMUG+yop6VRffz2Mj
         MAAWnr5SRQEu9hK2S+OVD4n6X4pTyxLAB8GQ87MhmcP6BDA/xZTR6Jm/nzQq9Y5WHAWG
         rkgRDltsaxFnKr9sM8fyzlNsjZSwh0sRBnQZRNi8mDlcGE4essaWzr9v+m0HahxvghrE
         0Yb6YS4Q5t1GYGUtYlQSI9SDcY/+DSczeJ24t7ozCGKSagfCIMz+Y/QLP32lvRwwnlZ5
         6x6g==
X-Gm-Message-State: APjAAAWk1n9QK9BZetU4aO+rEqEKFirlgGdvFbEJB6DuTmICiFU9wD0i
        FRbO8vm/tkyHqzm0fPZMjstDatT6wMfNDoROgBI=
X-Google-Smtp-Source: APXvYqy9j4zSHu4dp1+U/CdhnB7i3Hnbv00SVhZJbG6jzJT/h0YFIWOh4Y833SEXLrNLULQLDFdnZOtStWSu9W/tgKA=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr50422046wrw.323.1564488543296;
 Tue, 30 Jul 2019 05:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-7-anup.patel@wdc.com>
 <3caa5b31-f5ed-98cd-2bdf-88d8cb837919@redhat.com> <536673cd-3b84-4e56-6042-de73a536653f@redhat.com>
In-Reply-To: <536673cd-3b84-4e56-6042-de73a536653f@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 17:38:51 +0530
Message-ID: <CAAhSdy2jo6N4c9-_-hj=81mXjHjP8mvZy_8jOdRZELCyU9Y8Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/16] RISC-V: KVM: Implement KVM_GET_ONE_REG/KVM_SET_ONE_REG
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

On Tue, Jul 30, 2019 at 3:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 30/07/19 10:43, Paolo Bonzini wrote:
> > On 29/07/19 13:56, Anup Patel wrote:
> >> The PC register represents program counter whereas the MODE
> >> register represent VCPU privilege mode (i.e. S/U-mode).
> >>
> > Is there any reason to include this pseudo-register instead of allowing
> > SSTATUS access directly in this patch (and perhaps also SEPC)?
>
> Nevermind, I was confused - the current MODE is indeed not accessible as
> a "real" CSR in RISC-V.

Yes, you got it right.

>
> Still, I would prefer all the VS CSRs to be accessible via the get/set
> reg ioctls.

We had implemented VS CSRs access to user-space but then we
removed it to keep this series simple and easy to review. We thought
of adding it later when we deal with Guest/VM migration.

Do you want it to be added as part of this series ?

Regards,
Anup
