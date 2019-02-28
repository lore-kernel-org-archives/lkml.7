Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4113CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B220851
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iMKKcH1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfB1XEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:04:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39206 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1XEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:04:38 -0500
Received: by mail-io1-f67.google.com with SMTP id x3so18052232ior.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gmKEt95/bKerSzneuZjTxHAhkZtg6bph+MZYvRvMaE0=;
        b=iMKKcH1teYSrhuXMA5msAb49RrO2FvVesrVlcxUMxIv2b2n8o7XPeQyx00E8zOVgdg
         sA5EM0XZzi/k58Y9KNMKjYg7cW9EXdZ/SHJhRrKsDByA2IPmdR1FBScBBkgZaclWah/l
         KqqnEsPegpdFttU/Qx2HlRxY+5iviPo+BYSk+edBDcikG+eVkozGhYbL7jQWImezUvbH
         Oodk7MRNHZS69syX78o7uMTub/LuBc5CMIZvS1zvYSxOdkit6xd4zJMjlv0ZIBYiNd0u
         pcIcpaLuaOC0Nr9o/IgqIOeNkNZyZZysVBN8rOc8bAI9+Ew7uhA+GdWVmhHg8LENHRah
         aL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gmKEt95/bKerSzneuZjTxHAhkZtg6bph+MZYvRvMaE0=;
        b=Z/pYHR/mDJUITaIoBA3CjVZaoIbIFpJG+BtxXWQpGogBvZTeD8ccIPXNYDSNCrcE5u
         s2RTuDHnokxORjEuHQqPpmO5F9LvliUb/o1hVOh7hnQ0x2NAwL6ia/Fm1dkzjejlgKjp
         9eYy4RWlxFhuYgaCFzr99BV6y13dhXLV74GVpoOH7dLCihIbzdLSm5vGou6AKDCIsLbv
         8g2lXQ64KwG8g0NbRGo9we5ziMVDVepCHNwGiSSyQn4nH2dFovHSy+RiDpACn6BAykgZ
         ltBVYhoAcOxdcRXh1UXKlQPGJ6VuTcFyzTkgPmU67C0K8M4+Ma7uc94ipSoNA5nwxmAx
         3FWg==
X-Gm-Message-State: APjAAAW2dDSqQ3ODy5PMT/8vMmXFS301i1hYu1UTVAFuN1DpAee4UKCt
        JLiBb5Dgxs13AYieGizHoowgog==
X-Google-Smtp-Source: APXvYqz4f5ZN5H+9U9fRvdvL5J1x6Nw+Px9y4Ao+FXNlLRGrppjsrlQWPzGR9bA1DRwxwjrI5MBh4g==
X-Received: by 2002:a6b:b644:: with SMTP id g65mr1103203iof.198.1551395077046;
        Thu, 28 Feb 2019 15:04:37 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id f142sm3594011itc.15.2019.02.28.15.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 15:04:36 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:04:35 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <alistair23@gmail.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "of/device: Really only set bus DMA mask when
 appropriate"
In-Reply-To: <CAKmqyKND0ruL+cTLoMzV2oG5BOdHDzAzWkKrW5eqLAP2Q6smvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1902281452270.17965@viisi.sifive.com>
References: <20190228223257.6189-1-alistair.francis@wdc.com> <alpine.DEB.2.21.9999.1902281437380.17965@viisi.sifive.com> <CAKmqyKND0ruL+cTLoMzV2oG5BOdHDzAzWkKrW5eqLAP2Q6smvQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Alistair Francis wrote:

> On Thu, Feb 28, 2019 at 2:39 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > On Thu, 28 Feb 2019, Alistair Francis wrote:
> > > This reverts commit 6778be4e520959659b27a441c06a84c9cb009085.
> > >
> > > Reverting the commit fixes these error messages and an non-functioning
> > > USB bus when attaching a USB to PCIe card to a RISC-V board:
> > >     xhci_hcd 0000:03:00.0: Host took too long to start, waited 16000 microseconds.
> > >     xhci_hcd 0000:03:00.0: startup error -19
> > >     xhci_hcd 0000:03:00.0: USB bus 2 deregistered
> > >     xhci_hcd 0000:03:00.0: WARNING: Host System Error
> > >     xhci_hcd 0000:03:00.0: remove, state 1
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > > I'm not sure if this is the correct fix, it's possible something else is
> > > wrong, but I wanted to get some feedback.
> > >
> > > drivers/of/device.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > index 3717f2a20d0d..8299f8055da7 100644
> > > --- a/drivers/of/device.c
> > > +++ b/drivers/of/device.c
> > > @@ -149,11 +149,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
> > >        * set by the driver.
> > >        */
> > >       mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> > > +     dev->bus_dma_mask = mask;
> > >       dev->coherent_dma_mask &= mask;
> > >       *dev->dma_mask &= mask;
> > > -     /* ...but only set bus mask if we found valid dma-ranges earlier */
> >
> > Does the DT data for the PCIe controller that you're using contain a
> > dma-ranges node?
> 
> Ah, no it does not. It only has ranges and bus-range [1].
> 
> Any idea what the dma-ranges should be?
> 
> 1: https://github.com/riscv/opensbi/blob/master/platform/sifive/fu540/HiFiveUnleashed-MicroSemi-Expansion.dts#L407

Not off the top of my head, but this may help:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/booting-without-of.txt#n1389

You might also consider grepping through existing DT data for examples of 
dma-ranges usage.

N.B., I have no direct knowledge of this, but have been told that some of 
the MicroSemi PCIe controllers can only bus-master into a 32-bit region.  
If this is a MicroSemi controller, that would need to be reflected in 
dma-ranges.


- Paul
