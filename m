Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0849AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0032087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rYNoj1tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfG3MOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:14:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36480 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfG3MOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:14:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so52325717wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nif3qHLVmcvrPjGpxqbZt9/vydbdek0IMR2qJ1UdOfY=;
        b=rYNoj1tSzf0sttrAZdSs0XsVpgLJYwh2JBmIkgCKdff9t45iEMVp+2cHfJrM/VHequ
         RbRBhTt/0cXeZKmlYao/z751WpX18xessLddOkzDYTEFnAWXW6Yxse55jAyRcZnxY/tt
         rJ5tpyDfKCTA8aqaFnZfcwrpxIrSm+Ws2Mu80jZqcAg2UyfC++kD+iiZAtQYDHUbB3uQ
         Gxn2RTDO3tb9g6OZrrmou3hHxY7gQYhQgSlZViGnC0PN2i7eyno/QKb0uL0z0R5MwRAy
         2bfe9WjPvpOblgbSgsYrp++rsj4vBiJAyu8Xblwumon2NV+xuhsRExoLICKISZhnynUl
         uy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nif3qHLVmcvrPjGpxqbZt9/vydbdek0IMR2qJ1UdOfY=;
        b=VXjklsuTjOAuOitjuwU7tXTpBuZVHCcDQxqaY7sXdklioageuXWDfQ2+DuBwkRysAD
         AVtY9ODDLhFj9CAe6USX/eE3pk/2CSIGrivUltt7dwLqvJLjeORRmwnoWNraj7TroKo3
         tnfgGVVcCicbjFJg7PgV2A+M9vTdp4x6QE0M3sCPMfSODG5g9GrUwqZSgAvtM5icpmLM
         7Nh6tkKXkWb3NokfHuqjB4V+iLyLHZ1HuKNxdZf4spGPEAjdBK8L4f+Y0Z5eYl3HJqjv
         EjjVF87sGEhfwDFfgfiwZl3IKVSZc2CNSdbN/gkj36F5lVBO4fyEEmcVid49ndVixUSh
         pJpg==
X-Gm-Message-State: APjAAAUMAa1nVb/3K27R56gmARzL/WSVmJX6QSfiyHCgZSx/k0iPm7xP
        PRyQma38lAAAygTZFwyyAEuwcpQtayuAU1tnCj8=
X-Google-Smtp-Source: APXvYqxBKE8FkPVrEqaGT/BokRytjmgYIEjMXXYbPz3pe96ONQT3DpM8Y+BsFeCrC+LD4o8MLveCcLyT0fkIChqWiqA=
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr97987106wma.171.1564488855824;
 Tue, 30 Jul 2019 05:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-12-anup.patel@wdc.com>
 <6ebde80e-e8a9-6b7b-52ea-656b9a9e5e5b@redhat.com>
In-Reply-To: <6ebde80e-e8a9-6b7b-52ea-656b9a9e5e5b@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 17:44:03 +0530
Message-ID: <CAAhSdy09Uhkg=-m213SeR92M1PRx1ZtE-fTLT=nNvg_0HY2YnA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/16] RISC-V: KVM: Implement stage2 page table programming
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

On Tue, Jul 30, 2019 at 2:30 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/07/19 13:57, Anup Patel wrote:
> > This patch implements all required functions for programming
> > the stage2 page table for each Guest/VM.
> >
> > At high-level, the flow of stage2 related functions is similar
> > from KVM ARM/ARM64 implementation but the stage2 page table
> > format is quite different for KVM RISC-V.
>
> FWIW I very much prefer KVM x86's recursive implementation of the MMU to
> the hardcoding of pgd/pmd/pte.  I am not asking you to rewrite it, but
> I'll mention it because I noticed that you do not support 48-bit guest
> physical addresses.

Yes, I also prefer recursive page table programming. In fact, the first
hypervisor we ported for RISC-V was Xvisor and over there have
recursive page table programming for both stage1 and stage2.

BTW, 48bit VA and guest physical address is already defined in
latest RISC-V spec. It's just that there is not HW (or QEMU) implementation
as of now for 4-level page table.

I will certainly add this to our TODO list.

Regards,
Anup
