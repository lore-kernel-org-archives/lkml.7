Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2FDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5960222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569388026;
	bh=c5/d+TL32DDKR4zrZOhj8g4B4tFDujkoeIXaSUevUvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WpBezNfY88QfBYysu+dYDORkqQzSE9LGeYeyVS8CfZF8TtZwtuZvb3xOhJt4t7Pwx
	 wZWfbfaOa5BqCddB1tBvDNk/rzgFtX+qAE4XmsM0QkmmJsLYyJBh/8XwQpHdLuP8fJ
	 7GR6LOq7HEtwOGyfTlebiE18yFN0//HuktSRqcSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442282AbfIYFHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 01:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437141AbfIYFHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:07:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FEC21D81;
        Wed, 25 Sep 2019 05:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569388023;
        bh=c5/d+TL32DDKR4zrZOhj8g4B4tFDujkoeIXaSUevUvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViHccNiZ6k3Rm7Iga397cVf8P0Rx9fHMwGdF/Zv2tZTM/Dz3hUpUSfOlSJ4dDUyVU
         9YzXzJsiRTP7WgVEp2VSy7FPNpStI7x5CVBW51tA36tpWdjDqdkid1P2USN6YRJ95M
         ByQdf5th2sxiFO7aIYvf9S8EYS/HGdz8D20LyNmY=
Date:   Wed, 25 Sep 2019 07:06:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anup Patel <anup@brainfault.org>
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
Subject: Re: [PATCH 1/2] platform: goldfish: Allow goldfish virtual platform
 drivers for RISCV
Message-ID: <20190925050653.GA1337454@kroah.com>
References: <20190925042912.119553-1-anup.patel@wdc.com>
 <20190925042912.119553-2-anup.patel@wdc.com>
 <20190925044308.GA1245729@kroah.com>
 <CAAhSdy1Z09tpNtfS10gL5BXJ=1wydLy4nmtFyKQenAPDSyTLTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1Z09tpNtfS10gL5BXJ=1wydLy4nmtFyKQenAPDSyTLTQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:30:00AM +0530, Anup Patel wrote:
> On Wed, Sep 25, 2019 at 10:13 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 25, 2019 at 04:30:03AM +0000, Anup Patel wrote:
> > > We will be using some of the Goldfish virtual platform devices (such
> > > as RTC) on QEMU RISC-V virt machine so this patch enables goldfish
> > > kconfig option for RISC-V architecture.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > ---
> > >  drivers/platform/goldfish/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
> > > index 77b35df3a801..0ba825030ffe 100644
> > > --- a/drivers/platform/goldfish/Kconfig
> > > +++ b/drivers/platform/goldfish/Kconfig
> > > @@ -1,7 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  menuconfig GOLDFISH
> > >       bool "Platform support for Goldfish virtual devices"
> > > -     depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
> > > +     depends on X86_32 || X86_64 || ARM || ARM64 || MIPS || RISCV
> >
> > Why does this depend on any of these?  Can't we just have:
> 
> May be Goldfish drivers were compile tested/tried on these architectures only.

True, but that does not mean a driver should only have a specific list
of arches.  This should only be needed if you _know_ it doesn't work on
a specific arch, not the other way around.

> > >       depends on HAS_IOMEM
> >
> > And that's it?
> 
> I think it should be just "depends on HAS_IOMEM && HAS_DMA" just like
> VirtIO MMIO. Agree ??

No idea, but if that's what  is needed for building, then sure :)

thanks,

greg k-h
