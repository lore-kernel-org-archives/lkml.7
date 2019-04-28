Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB723C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EA520652
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfD1SoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:44:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41246 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1SoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:44:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id f25so9643968qtc.8;
        Sun, 28 Apr 2019 11:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qIZb4MEtnuaQO412PRiKeuotlIUz5RFI6XjQg/gCwk=;
        b=rt1upsKIz0+BHjI1Uv5p9nPm8EY14iETDOi0HgPreITuBSyRxhgFkzzeDqxYz05iAE
         Tf/pbl9qjQXK9iM6TyFuH15KgDc5o6rEP7edXdJ/DuPs1G1APDeLxPl9q4DOxhQTRxOl
         0sNApjegfxiHeHVtyrDmPLuFT+wCGCrD/tXl/FgmuDExVxvxsRqnWBrzeubY1YRQH0yr
         UewER1zN4vzrYQ4BjWo2f30+ZZTc+NGUnKZUZu74x70NoAU3wgLNz1Q1+6wFKG1FuP4U
         NL3spbhiY7Dl/97Ko+Bi7HUCPF63UftzTZTom7J8S/ktV+vVRcEjNonR+Vs8lGQuRLW/
         Ni2g==
X-Gm-Message-State: APjAAAWpGkkhef/BIR/6B9u68SZPc/U+ImMQPVHUknmWPlp6LlT4GRmO
        nX+QjjHbhqAN13zRUNUXkk/Ioaj9Jqqu1QRgIBHD88KfOw4=
X-Google-Smtp-Source: APXvYqzfBhMtdl9iZ7Wk1alB8NzTqYuSpJSOwJUnFpeHo0+iuoXPvMXxQKouEL5GMmGOibA+gMMyrBSnirusDmej/ok=
X-Received: by 2002:ac8:2924:: with SMTP id y33mr44874396qty.212.1556477060147;
 Sun, 28 Apr 2019 11:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com> <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
In-Reply-To: <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Apr 2019 20:44:03 +0200
Message-ID: <CAK8P3a16O57dvUYUPVZJpvZ7Hm6WA-jc_svQHTAEdDpbyLRv7w@mail.gmail.com>
Subject: Re: endianness swapped
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 3:59 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> > On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
> >>> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
> >
> > Coldfire makes the behavior of readw()/readl() depend on the
> > MMIO address, presumably since that was the easiest way to
> > get drivers working originally, but it breaks the assumption
> > in the asm-generic code.
>
> Yes, that is right.
>
> There is a number of common hardware modules that Freescale have
> used in the ColdFire SoC parts and in their ARM based parts (iMX
> families). The ARM parts are pretty much always little endian, and
> the ColdFire is always big endian. The hardware registers in those
> hardware blocks are always accessed in native endian of the processor.

In later Freescale/NXP ARM SoCs (i.MX and Layerscape), we
also get a lot of devices pulled over from PowerPC, with random
endianess. In some cases, the same device that had big-endian
registers originally ends up in two different ARM products and one of
them uses big-endian while the other one uses little-endian registers.

> So the address range checks are to deal with those internal
> hardware blocks (i2c, spi, dma, etc), since we know those are
> at fixed addresses. That leaves the usual endian swapping in place for
> other general (ie external) devices (PCI devices, network chips, etc).

Is there a complete list of coldfire on-chip device drivers?

Looking at some of the drivers:

- drivers/i2c/busses/i2c-imx.c uses only 8-bit accesses and works either way,
  same for drivers/tty/serial/mcf.c
- drivers/spi/spi-coldfire-qspi.c is apparently coldfire-only and could use
  ioread32be for a portable to do big-endian register access.
- edma-common has a wrapper to support both big-endian and little-endian
  configurations in the same kernel image, but the mcf interrupt handler
  is hardcoded to the (normally) little-endian ioread32 function.
- drivers/net/ethernet/freescale/fec_main.c is shared between coldfire
  and i.MX (but not mpc52xx), and is hardcoded to readl/writel, and
  would need the same trick as edma to make it portable.

      Arnd
