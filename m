Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E954C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F214F213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDIC40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:56:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38296 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDIC40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:56:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so9371094qki.5;
        Mon, 08 Apr 2019 19:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Dr+OQlDjT2ihsIzOfsx77WtEJOj2lJ+jb9w43bqiZo=;
        b=RRlHtKhPA/agKGhv+BPZSQeg9QC8xrQM+zxMnFXyIvtk61GAZ3m7VChJacWdH3NtFz
         UMNnk1H0lvXl3Qbl6c3/HBq/uGNVD9bTXM86+s9lC6Uyo2O2qAb/uBtajztX7h3z45M1
         6wFiSNlaWSY4oufjMhJNv1oZMbnSDQ/7pXLI1JGkmV5liHGUQtaMsaseq+XP+EknE/D7
         uzBtSfa/WwE7mcoER+4afUawRvtl+mA9+2hn05A06gBuHZc6kyGqIJFGU/W6265yJes/
         sfG4JAUlpu6vPLIO77Ktl+8+lKK4ll9v9V6gUtlxvyAnHqxFmmwmXjR1SBdJw7xGolMd
         wpmw==
X-Gm-Message-State: APjAAAVFnABni8hEi1Yt4d9QTDssfvRL63MGmTuwpXslhPKUDmt2/6JM
        tdkKVW4NzqH3T7g0/aFB4j+R64X5sOoE5w==
X-Google-Smtp-Source: APXvYqymm3Wo2oqgMEv5v1YWgT+YT9VHjkoSDTYzcGvMt0xxRTB6V9JnBdl8MRhuZps512gVFJyOvA==
X-Received: by 2002:ae9:f501:: with SMTP id o1mr25781033qkg.205.1554778584960;
        Mon, 08 Apr 2019 19:56:24 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id n70sm21391355qkn.5.2019.04.08.19.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:56:24 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id p20so18045597qtc.9;
        Mon, 08 Apr 2019 19:56:23 -0700 (PDT)
X-Received: by 2002:ac8:298d:: with SMTP id 13mr28712278qts.174.1554778583806;
 Mon, 08 Apr 2019 19:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89@epcas1p1.samsung.com>
 <1554198011-24342-1-git-send-email-pankaj.dubey@samsung.com>
 <0d3e8992-06e1-57e4-edd5-ba230caaa189@arm.com> <CAGcde9F1h31FQ7qLUdFTvZ_1vt67956=5r-Do6qU3Q0vSVe6=g@mail.gmail.com>
In-Reply-To: <CAGcde9F1h31FQ7qLUdFTvZ_1vt67956=5r-Do6qU3Q0vSVe6=g@mail.gmail.com>
From:   Sriram Dash <sriram.dash@samsung.com>
Date:   Tue, 9 Apr 2019 08:26:11 +0530
X-Gmail-Original-Message-ID: <CAOD6=z69K9bBqUikwogJ2YH_OfxODfsy+uRb6dX9x9AOuP6Wpw@mail.gmail.com>
Message-ID: <CAOD6=z69K9bBqUikwogJ2YH_OfxODfsy+uRb6dX9x9AOuP6Wpw@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: inherit dma_mask from bus if set correctly
To:     Pankaj Dubey <pankaj.dubey@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, mgautam@codeaurora.org,
        felipe.balbi@linux.intel.com, Sriram Dash <sriram.dash@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 9:53 PM Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>
> On Tue, 2 Apr 2019 at 15:34, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 02/04/2019 10:40, Pankaj Dubey wrote:
> > > From: Sriram Dash <sriram.dash@samsung.com>
> > >
> > > The xhci forcefully converts the dma_mask to either 64 or 32 and the
> > > dma-mask set by the bus is somewhat ignored. If the platform  sets the
> > > correct dma_mask, then respect that.
> >
> > It's expected for dma_mask to be larger than bus_dma_mask if the latter
> > is set - conceptually, the device mask represents what the device is
> > inherently capable of, while the bus mask represents external
> > interconnect restrictions which individual drivers should not have to
> > care about. The DMA API backend should take care of combining the two to
> > find the intersection.
>
> Thanks for the review.
>
> We are dealing here with the xhci platform which inherits the dma mask
> of the parent, which is from a controller device.
>
> When the controller dma mask is set by the platform in DT, what we
> observe is, its not getting inherited properly and the xhci bus is
> forcing the dma address to be either 32 bit or 64 bit.
>
> In "drivers/usb/host/xhci-plat.c" we have dma_mask setting as below:
>
>  /* Try to set 64-bit DMA first */
> if (WARN_ON(!sysdev->dma_mask))
>      /* Platform did not initialize dma_mask */
>      ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
> else
>      ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>
> So even if the controller device has set the dma_mask as per it's
> configuration in DT, xhci-plat.c will override it here in else part.
>
> Next it goes to "drivers/usb/host/xhci.c" file, here we have code as:
>
> /* Set dma_mask and coherent_dma_mask to 64-bits,
>  * if xHC supports 64-bit addressing */
> if (HCC_64BIT_ADDR(xhci->hcc_params) &&
>                 !dma_set_mask(dev, DMA_BIT_MASK(64))) {
>         xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
>         dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> } else {
>         /*
>          * This is to avoid error in cases where a 32-bit USB
>          * controller is used on a 64-bit capable system.
>          */
>         retval = dma_set_mask(dev, DMA_BIT_MASK(32));
>         if (retval)
>                 return retval;
>         xhci_dbg(xhci, "Enabling 32-bit DMA addresses.\n");
>         dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> }
>
> So xhci will force the dma_mask to either DMA_BIT_MASK(32) or
> DMA_BIT_MASK(64), what if my device needs other than 32 bit or 64 bit
> dma_mask.
>
> The bus_dma_mask was introduced for a case when the bus from a
> device's dma interface may carry fewer address bits. But apparently,
> it is the only mask which retains the original dma addressing from the
> parent. So basically what we observe is currently there is no way we
> can pass dma_mask greater than 32-bit, from DT via dev->dma_mask or
> dev->coherent_dma_mask due to below logic in
>
> from "drivers/of/platform.c" we have
> static struct platform_device *of_platform_device_create_pdata(
>                                         struct device_node *np,
>                                         const char *bus_id,
>                                         void *platform_data,
>                                         struct device *parent)
> {
>       struct platform_device *dev;
>       ...
>       dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>       if (!dev->dev.dma_mask)
>              dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>   ...
> }
>
> and then in of_dma_configure function in "drivers/of/device.c" we have..
>
> mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1); //This mask
> computation is going fine and gets mask greater than 32-bit if defined
> in DT
> dev->coherent_dma_mask &= mask;  // Here the higher bit [63:32] will
> get truncated as coherent_dma_mask is initialized to DMA_BIT_MASK(32)
> in platform.c
>
> *dev->dma_mask &= mask; //Same here higher bits will get truncated
> /* ...but only set bus mask if we found valid dma-ranges earlier */
> if (!ret)
> dev->bus_dma_mask = mask; //Only bus_dma_mask can carry the original
> mask as specified in platform DT.
>
> To minimise the impact on existing code, we reused the bus_dma_mask
> for finding the dma addressing bits.
>
> Or other way we may need to initialise dma_mask/coherent_dma_mask as
> DMA_BIT_MASK(64) in "drivers/of/platform.c" and let all devices set
> dma_mask via DT using "dma-ranges" property or respective platform
> driver.
>
> > Are you seeing an actual problem here, and if so
> > on which platform? (If the bus mask is set at all then it wouldn't seem
> > to be the DT PCI issue that I'm still trying to fix).
> >
>
>
> We are facing this issue in one of the Samsung's upcoming SoC where we
> need dma_mask greater than 32-bit.
>
> Thanks,
> Pankaj
> > Robin.
> >
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> > > ---
> > >   drivers/usb/host/xhci.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > index 005e659..55cf89e 100644
> > > --- a/drivers/usb/host/xhci.c
> > > +++ b/drivers/usb/host/xhci.c
> > > @@ -5119,6 +5119,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
> > >               dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > >       }
> > >
> > > +     /*
> > > +      * A platform may require coherent masks other than 64/32 bit, and we
> > > +      * should respect that. If the firmware has already requested for a
> > > +      * dma-range, we inherit the dma_mask presuming the platform knows
> > > +      * what it is doing.
> > > +      */
> > > +
> > > +     if (dev->bus_dma_mask)
> > > +             dma_set_mask_and_coherent(dev, dev->bus_dma_mask);
> > > +
> > >       xhci_dbg(xhci, "Calling HCD init\n");
> > >       /* Initialize HCD and host controller data structures. */
> > >       retval = xhci_init(hcd);
> > >

Hello Robin,

Hope you found the crux of the matter. Any comments on the same?

-- 
Regards,
Sriram
