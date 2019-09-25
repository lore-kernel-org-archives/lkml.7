Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FEAC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3FD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="h+uvIipM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633881AbfIYFRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 01:17:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54442 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393000AbfIYFRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:17:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so3127109wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCKowqUakGbd2bzBHhBCQJ3eP070qYwr7iHSC1ow4hM=;
        b=h+uvIipMHwBJLDtSoQbxKC4Dfhcem9jIhZJCvILcnapKxMU0If6F8x4YMY5gRWdm5H
         f7bxHwrcZbBhNOz2aLK84mxYIRxJfAAGWdFZ6BZbpgFb+zkrjl3V0sHXWD0cqnoygcIR
         38vwQ2qqbI1Bctp+hmEWpOPipadn5GvOWgC/4T/IdwoB6JkCubwho5A3sovPFuND+u9C
         Z3hdivxj5r2bm6Xchi785L43kVrGOn3G1rUJcMsX2mRNmcO7HJB6ZnsLhFIp4eskN1dl
         dP+48XqMlWyGssuc+MKr7PAxIfotbQV4IcsIQBgEX47BcyO9F3ikA/hmu3rNR+ZsftzR
         2PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCKowqUakGbd2bzBHhBCQJ3eP070qYwr7iHSC1ow4hM=;
        b=nlvp5y49QROSwCPzKM7IQPPFWP3IkPAnyzcLkh5okTuWYhTpJ7OnVSnpWgRIbyg63v
         lXIsM36vXcZIzonKv8ylJholDleHfASzBMu7spBCsTq7Dd4kYRCDC16VwyruZ4PwAcdX
         qFYWEyMjlQ5v5ILO5M3HSkKJcilJhOLTR2deRoGMoQZhWj8QsnVdg8n0bSliY0pRfVmR
         A6BlUAp3QoqqEKlFizyPrYvfZtWsiGY0zKfWumIgQhVg0+0XHWO5FvMOX7Iyv8/IiUFI
         MjIXGwcy1gVrlKoPE4ijbYoAqHvX0SA5moDd+yEvWhODisMA/RCNVms8sllziWfFdmRQ
         ARIQ==
X-Gm-Message-State: APjAAAWymT0+CLpkdCRWp/TvsXcTUrboQijJbJC5T47aHTOhBdG99+0p
        vqm3mfXR1m4MVQRyRArNxTi9yhxmAtPch03cQxBNEQ==
X-Google-Smtp-Source: APXvYqzhdUJMpM0GDlqgsIhYEXf0reKjaEVhO65SCeubaPWH1KDzfH89JQhOuWjayBOu2nPRonK1gHUlI6fgnWMuFv0=
X-Received: by 2002:a1c:80ca:: with SMTP id b193mr4789145wmd.171.1569388623980;
 Tue, 24 Sep 2019 22:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190925042912.119553-1-anup.patel@wdc.com> <20190925042912.119553-2-anup.patel@wdc.com>
 <20190925044308.GA1245729@kroah.com> <CAAhSdy1Z09tpNtfS10gL5BXJ=1wydLy4nmtFyKQenAPDSyTLTQ@mail.gmail.com>
 <20190925050653.GA1337454@kroah.com>
In-Reply-To: <20190925050653.GA1337454@kroah.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 25 Sep 2019 10:46:52 +0530
Message-ID: <CAAhSdy3JyLyLF0FHdeXj2yZQO8wz=aAgjyg15x9ENeGxfgbp-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform: goldfish: Allow goldfish virtual platform
 drivers for RISCV
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Roman Kiryanov <rkir@google.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:37 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 25, 2019 at 10:30:00AM +0530, Anup Patel wrote:
> > On Wed, Sep 25, 2019 at 10:13 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Sep 25, 2019 at 04:30:03AM +0000, Anup Patel wrote:
> > > > We will be using some of the Goldfish virtual platform devices (such
> > > > as RTC) on QEMU RISC-V virt machine so this patch enables goldfish
> > > > kconfig option for RISC-V architecture.
> > > >
> > > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > > ---
> > > >  drivers/platform/goldfish/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
> > > > index 77b35df3a801..0ba825030ffe 100644
> > > > --- a/drivers/platform/goldfish/Kconfig
> > > > +++ b/drivers/platform/goldfish/Kconfig
> > > > @@ -1,7 +1,7 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  menuconfig GOLDFISH
> > > >       bool "Platform support for Goldfish virtual devices"
> > > > -     depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
> > > > +     depends on X86_32 || X86_64 || ARM || ARM64 || MIPS || RISCV
> > >
> > > Why does this depend on any of these?  Can't we just have:
> >
> > May be Goldfish drivers were compile tested/tried on these architectures only.
>
> True, but that does not mean a driver should only have a specific list
> of arches.  This should only be needed if you _know_ it doesn't work on
> a specific arch, not the other way around.

No problem, I will drop depends on various architectures line

>
> > > >       depends on HAS_IOMEM
> > >
> > > And that's it?
> >
> > I think it should be just "depends on HAS_IOMEM && HAS_DMA" just like
> > VirtIO MMIO. Agree ??
>
> No idea, but if that's what  is needed for building, then sure :)

The Goldfish framebuffer can do DMA access so I add dependency on
HAS_DMA.

Refer, https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT

I will send v2 as-per above.

Regards,
Anup
