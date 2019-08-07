Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7386CC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E5A21743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="hGk8PdnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfHGEMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 00:12:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55892 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfHGEMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 00:12:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so5436wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 21:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4Mto+u+o/GrqhpuJO5sk5R5bWRkMiGx0GZ7PDoZHhY=;
        b=hGk8PdnRxQzAhPWjp8Solk8ESY/KLU+gAfVMhPUcVLaljCWzEf6pRIB+ykme9AcMV8
         uAMtTV6f+Mx5YHksBZHynRnf2uhdVUemjoj0uxOcmrrY1JIbbFbS0TII60Mk2X1s8Jl/
         cMMx5rySLkA8gG789t5MzOsrqa0w7yTB0pEEEBDxkaLeh3zBd+1GZU9sY+yiinrg0DAe
         hyS7LzVjCYue1rlQI0GA7Df+jRhMw0TfOfQbKfP7IGeSYpyIcPYtpCe5rpAeLJf0KAdC
         Qkxv/hMazv3lm9Tbb+XMXF7EmbBgGFSUwcCFwyhL0rLnN8CnZlKlQXh1r8Ge2wr45zvb
         P1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4Mto+u+o/GrqhpuJO5sk5R5bWRkMiGx0GZ7PDoZHhY=;
        b=V6azhc+0caiKa/m16vN+naIUqv25gi0qZhmCxZclm7xaJMvOUSVwoD0Bjx4D+MO3yZ
         ktyOa4JvAhbdBjCD6fzi/dNfc8AWcwnx7fMn7YNAUCP0/PeXX8iZmBfQRUNbY7VVNrB9
         Vdkjqre4TZI0D5lV75pb9z6cgNcxYVs+8wvjVqtiWqWz+wPC85z6HDP0zhJjeEQC89p2
         UjuVXyDqVyRgK26o5LotifoWYnX1c/NSjDvhueGDDoanOe0QZjAt/yoTsckz+D33PO8H
         pHQv2LvHsC4gd9bb/+GcMxVPxFuWJ+woYaalMlggCfUgdNWvO6E+eDDOejeHkOxnnnxC
         6pBg==
X-Gm-Message-State: APjAAAUD/MNZtPq6DBDteRGN/XvHQORaflMproIROk+bKypGJSD5Xqpd
        4bRjc6UcFKK5mYoUWVJjGZx9qDyLMgCRkwaFIOroNw==
X-Google-Smtp-Source: APXvYqxNQXi0Vk0popN48576tfFY9XromzfT2N02IGLgqdhJFMVPw6vXQpznv3nKE3ce9kACVusM9LL3MVE7mwSI0Mg=
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr7920551wme.103.1565151161058;
 Tue, 06 Aug 2019 21:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190803042723.7163-1-atish.patra@wdc.com> <20190803042723.7163-3-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1908061452570.13971@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908061452570.13971@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 7 Aug 2019 09:42:29 +0530
Message-ID: <CAAhSdy3tJ3RbnyOtKAT4zsjPUxMQkm+UtWa4sTTZxSAsYUBs5g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] RISC-V: Add riscv_isa reprensenting ISA features
 common across CPUs
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 3:24 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hi Anup, Atish,
>
> On Fri, 2 Aug 2019, Atish Patra wrote:
>
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > This patch adds riscv_isa integer to represent ISA features common
> > across all CPUs. The riscv_isa is not same as elf_hwcap because
> > elf_hwcap will only have ISA features relevant for user-space apps
> > whereas riscv_isa will have ISA features relevant to both kernel
> > and user-space apps.
> >
> > One of the use case is KVM hypervisor where riscv_isa will be used
> > to do following operations:
> >
> > 1. Check whether hypervisor extension is available
> > 2. Find ISA features that need to be virtualized (e.g. floating
> >    point support, vector extension, etc.)
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> Do you have any opinions on how this patch might change for the Z-prefix
> extensions?  This bitfield approach probably won't scale, and with the
> EXPORT_SYMBOL(), it might be worth trying to put together a approach that
> would work over the long term?

Our plan is to use bitmap instead of bitfield and all Zxyz extensions will be
assigned bit positions "27 + i" where "i" will be based on order in-which they
are defined in RISC-V spec. In general, "i" is just a unique relative index
(starting from 0).

To summarize, the existing bitfield approach can be naturally extended
using bitmap.

We will update this patch accordingly.

Regards,
Anup
