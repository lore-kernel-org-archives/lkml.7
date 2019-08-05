Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD35C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EA92075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565033000;
	bh=d6p6NWXIzAr/w+L57W8Oyrx5VdZnumUCXtu9FxtaNsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rAjRShUfYSfU3CdTNaRnJssZrQOwCWFWlSCZxzTkU6AkVloqvHR55yxFjBrIUmuH3
	 s3PqhVwnWSeydlSf4myO8dCe7iN3A022orga48l9OKqigQjyA51HWMf+AHOT9DdzoA
	 fkupjUdQDzt/TmxAp3UlAcyOYnBG2k9UK3MSAEcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfHETXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfHETXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:23:19 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBBD216B7;
        Mon,  5 Aug 2019 19:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565032998;
        bh=d6p6NWXIzAr/w+L57W8Oyrx5VdZnumUCXtu9FxtaNsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R/AKCL41e439d3YyW9Frd8+LqZmY/L/BTeDfKJwCw0IYn+fId94XDv2wn7Pml91f9
         dnKXgXpHTXeFphyc7/df75+ieHN1KnS+kSCTZqgR9c8Gkj9yb5S930ddLj/+yapLMz
         2x3mqfxdOrcNQAQnSXJqYUrWF68Oxa6/5KI536WM=
Received: by mail-qk1-f178.google.com with SMTP id r6so61041032qkc.0;
        Mon, 05 Aug 2019 12:23:17 -0700 (PDT)
X-Gm-Message-State: APjAAAVSB5PylCegkKpUn4dEGuognuvnPB/gPuH0SriL0sldMylqBLk0
        YsgD+I/Z9n6hTEpzycwbHgGfX/VtDA1usktBFA==
X-Google-Smtp-Source: APXvYqzJ3385dVDr7a416MCnVTqPVutjB6pJSnn10jB+T3hVVAIomIypEjVR/sntYZAAkaMyD0seP3rNxE7IslWzcJM=
X-Received: by 2002:a37:6944:: with SMTP id e65mr95063738qkc.119.1565032997083;
 Mon, 05 Aug 2019 12:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
 <20190731154752.16557-4-nsaenzjulienne@suse.de> <CAL_JsqKF5nh3hcdLTG5+6RU3_TnFrNX08vD6qZ8wawoA3WSRpA@mail.gmail.com>
 <2050374ac07e0330e505c4a1637256428adb10c4.camel@suse.de>
In-Reply-To: <2050374ac07e0330e505c4a1637256428adb10c4.camel@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Aug 2019 13:23:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LjsRmFg-xaLgpVx3miXN3hid3aD+mgTW__j0SbEFYjQ@mail.gmail.com>
Message-ID: <CAL_Jsq+LjsRmFg-xaLgpVx3miXN3hid3aD+mgTW__j0SbEFYjQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] of/fdt: add function to get the SoC wide DMA
 addressable memory size
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        wahrenst@gmx.net, Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-mm@kvack.org, Frank Rowand <frowand.list@gmail.com>,
        phill@raspberryi.org, Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 10:03 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Rob,
> Thanks for the review!
>
> On Fri, 2019-08-02 at 11:17 -0600, Rob Herring wrote:
> > On Wed, Jul 31, 2019 at 9:48 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > Some SoCs might have multiple interconnects each with their own DMA
> > > addressing limitations. This function parses the 'dma-ranges' on each of
> > > them and tries to guess the maximum SoC wide DMA addressable memory
> > > size.
> > >
> > > This is specially useful for arch code in order to properly setup CMA
> > > and memory zones.
> >
> > We already have a way to setup CMA in reserved-memory, so why is this
> > needed for that?
>
> Correct me if I'm wrong but I got the feeling you got the point of the patch
> later on.

No, for CMA I don't. Can't we already pass a size and location for CMA
region under /reserved-memory. The only advantage here is perhaps the
CMA range could be anywhere in the DMA zone vs. a fixed location.

> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >
> > >  drivers/of/fdt.c       | 72 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of_fdt.h |  2 ++
> > >  2 files changed, 74 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 9cdf14b9aaab..f2444c61a136 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -953,6 +953,78 @@ int __init early_init_dt_scan_chosen_stdout(void)
> > >  }
> > >  #endif
> > >
> > > +/**
> > > + * early_init_dt_dma_zone_size - Look at all 'dma-ranges' and provide the
> > > + * maximum common dmable memory size.
> > > + *
> > > + * Some devices might have multiple interconnects each with their own DMA
> > > + * addressing limitations. For example the Raspberry Pi 4 has the
> > > following:
> > > + *
> > > + * soc {
> > > + *     dma-ranges = <0xc0000000  0x0 0x00000000  0x3c000000>;
> > > + *     [...]
> > > + * }
> > > + *
> > > + * v3dbus {
> > > + *     dma-ranges = <0x00000000  0x0 0x00000000  0x3c000000>;
> > > + *     [...]
> > > + * }
> > > + *
> > > + * scb {
> > > + *     dma-ranges = <0x0 0x00000000  0x0 0x00000000  0xfc000000>;
> > > + *     [...]
> > > + * }
> > > + *
> > > + * Here the area addressable by all devices is [0x00000000-0x3bffffff].
> > > Hence
> > > + * the function will write in 'data' a size of 0x3c000000.
> > > + *
> > > + * Note that the implementation assumes all interconnects have the same
> > > physical
> > > + * memory view and that the mapping always start at the beginning of RAM.
> >
> > Not really a valid assumption for general code.
>
> Fair enough. On my defence I settled on that assumption after grepping all dts
> and being unable to find a board that behaved otherwise.
>
> [...]
>
> > It's possible to have multiple levels of nodes and dma-ranges. You need to
> > handle that case too. Doing that and handling differing address translations
> > will be complicated.
>
> Understood.
>
> > IMO, I'd just do:
> >
> > if (of_fdt_machine_is_compatible(blob, "brcm,bcm2711"))
> >     dma_zone_size = XX;
> >
> > 2 lines of code is much easier to maintain than 10s of incomplete code
> > and is clearer who needs this. Maybe if we have dozens of SoCs with
> > this problem we should start parsing dma-ranges.
>
> FYI that's what arm32 is doing at the moment and was my first instinct. But it
> seems that arm64 has been able to survive so far without any machine specific
> code and I have the feeling Catalin and Will will not be happy about this
> solution. Am I wrong?

No doubt. I'm fine if the 2 lines live in drivers/of/.

Note that I'm trying to reduce the number of early_init_dt_scan_*
calls from arch code into the DT code so there's more commonality
across architectures in the early DT scans. So ideally, this can all
be handled under early_init_dt_scan() call.

Rob
