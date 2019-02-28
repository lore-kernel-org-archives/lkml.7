Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAz2RmJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfB1Wmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:42:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43527 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1Wmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:42:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so18633163ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzZ+n7IBdI2RXmQ15IzwcgP+pV0cSReqXSAMzq87oLo=;
        b=WAz2RmJbM6BkcX457lDuCbCQaYBv2DSxw7oZFusOuJIcAs3Qkd/3d0YbbaUq1dSw/z
         bsgUIILqV4bLOPkKuvVVMblM8H6LAmVrPi08swdxzggC4ATQV4xhpJE202H40EENr0vy
         PWeU1Rey5YERkN1Ru1wB0j+M7kX3YtsDQKBVKAa1maY2euDu4mI8zSWqfNbZgA9UutQk
         962aEQrwgHZsXx11rvnFuKSOwhU0FvwzNJ96/3A0+yMuC8++etRri7lPlgKiWaF0ijny
         0fZZqr0fX4xioS0GkO3PxFJF4Fj1uAt/FZmary9POSa3ayja233U/2InjmSBGeikkbjA
         P8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzZ+n7IBdI2RXmQ15IzwcgP+pV0cSReqXSAMzq87oLo=;
        b=GMfSdwJpUVvKW8uXBRVZPtffUfifsblNEaJXQG8WOFiuj4xVDYYEKe2XqZQNk7oh09
         jM843sBwDkGFrHA1SD9Xfhi2NlO73ZVrtDrm28/hMlgskLwsFJnzMNOL7vzxxfg+D8EK
         W7Gk6BBBS10WQ5QnnAHGePEaEQhqdKw2Q5k1hU+cgYcD47GEwTJyR9YcBgGlIQkMvxlP
         sDXZPWPTktknYAa7hFSfozr0Puc9Ns8W1QZSROcsKYp4jxcK5OANG5DxV2s8EtkTrofg
         tO6mcA+vQuSFpShNeXB/JgjAlgfP7iOeSqzuOyAK2FtB8OKCE9ownaZ/kM9m6Yy+5trg
         rApw==
X-Gm-Message-State: APjAAAX57/7NifNXU3sk4k+WWG78uQa1EMcnyNUq/cEbVboDTkkhXkPR
        iAo8QsBkB28QX83sj+2qQSXjYGfvXS+kzjT5VnA=
X-Google-Smtp-Source: APXvYqw22XZF5sRF2LYwx7g7BBpNP+uw03dtpHVz09/t+hQxIH6IvPRiwsh6xDfyE5SjgtTdGPoTGsuM2nHoVk1Z2Mc=
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr745123ljj.128.1551393770888;
 Thu, 28 Feb 2019 14:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20190228223257.6189-1-alistair.francis@wdc.com> <alpine.DEB.2.21.9999.1902281437380.17965@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1902281437380.17965@viisi.sifive.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 28 Feb 2019 14:41:53 -0800
Message-ID: <CAKmqyKND0ruL+cTLoMzV2oG5BOdHDzAzWkKrW5eqLAP2Q6smvQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "of/device: Really only set bus DMA mask when appropriate"
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 2:39 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hello Alistair,
>
> On Thu, 28 Feb 2019, Alistair Francis wrote:
>
> > This reverts commit 6778be4e520959659b27a441c06a84c9cb009085.
> >
> > Reverting the commit fixes these error messages and an non-functioning
> > USB bus when attaching a USB to PCIe card to a RISC-V board:
> >     xhci_hcd 0000:03:00.0: Host took too long to start, waited 16000 microseconds.
> >     xhci_hcd 0000:03:00.0: startup error -19
> >     xhci_hcd 0000:03:00.0: USB bus 2 deregistered
> >     xhci_hcd 0000:03:00.0: WARNING: Host System Error
> >     xhci_hcd 0000:03:00.0: remove, state 1
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > I'm not sure if this is the correct fix, it's possible something else is
> > wrong, but I wanted to get some feedback.
> >
> > drivers/of/device.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 3717f2a20d0d..8299f8055da7 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -149,11 +149,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
> >        * set by the driver.
> >        */
> >       mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> > +     dev->bus_dma_mask = mask;
> >       dev->coherent_dma_mask &= mask;
> >       *dev->dma_mask &= mask;
> > -     /* ...but only set bus mask if we found valid dma-ranges earlier */
>
> Does the DT data for the PCIe controller that you're using contain a
> dma-ranges node?

Ah, no it does not. It only has ranges and bus-range [1].

Any idea what the dma-ranges should be?

1: https://github.com/riscv/opensbi/blob/master/platform/sifive/fu540/HiFiveUnleashed-MicroSemi-Expansion.dts#L407

Alistair

>
> > -     if (!ret)
> > -             dev->bus_dma_mask = mask;
> >
> >       coherent = of_dma_is_coherent(np);
> >       dev_dbg(dev, "device is%sdma coherent\n",
>
>
> - Paul
