Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DED205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ngW23tj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfFXPWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:22:50 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35427 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFXPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:22:48 -0400
Received: by mail-ua1-f65.google.com with SMTP id j21so5850516uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fw9ocu3ILyh7JW9RCJOLuVWP36rPco7a/hj0+uZNVSw=;
        b=ngW23tj/e1XwHQlTa4Tw6C+p8n/7+Ufead5lPUbuPNXOt6W4//TGJUU5NiGiCMX+tU
         xEAijs0zH1ZHE2FvWTYiyEcNLGzo3w2B9rwxQJAAZeRR0Ijn6zyyZbeuB1EzWnfJmok4
         MVQCUExm9K9JQwQBvyMh1slqbqh+gynGXkEx6N5uxXakXFBhtaDP41rY0wgdW7Wr+uyp
         Vw+Pn8/3GO0Vef61M1ccX/ma6I15iadkPOAV2gOWfuNiZmGPdN2QJtWX9WExVcvAvryp
         jSOL0QrTSChaioxqc2oZIaziSBTCAzXuu3O9+d5AFbVMiyw+I659238WJe3B6Vl5C7sA
         aciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fw9ocu3ILyh7JW9RCJOLuVWP36rPco7a/hj0+uZNVSw=;
        b=M/iYWIgVddU6R9GSfPhSG/e1fi/SrtO0pquRMMxJTwvHaZv9wHld+jyJ/5JArFSJsu
         x/ExwAF9c1R0T24y6MT6EJNbmN4YuArtG8GdvhKLLGxWn5c23SJluIKLD+cjdcBDpcMF
         XqS5hg2kni8GFzPoUv7uo933c/kPgQ7JaesG4+SkMCTK6hnNGgXg/pcOmcyC+3nOLP/H
         L7PB7rSfb4xLu7vExkHpzMrZ09SYJL08JnW8yKFY1fpgkcALWHiQan/alGHVvKAmGw7x
         xBI6k7ysCYZ/yb4YPoZKGtnSax7lKLVcpzeh13Biarm1TzDtiUEZjmoYI3F6bmFFxTgC
         Bs8w==
X-Gm-Message-State: APjAAAVNrqPvEEhZ32Rf4DK6pydHVJ3Iok6kbYPUSmX+Zel2yH14TEpo
        fxKaLHFUQZV/5U892IIU2F1PJ4ypUCwDYHvE+eFNhw==
X-Google-Smtp-Source: APXvYqxlvUS8caqcECDPWhbA2qx/n2Bpa/ec5duzMYEONa5Dfw6bcGRS4DgVoeSBWILBIgDsl4sAMxormx+BZFRAt/c=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr638135uad.121.1561389767357;
 Mon, 24 Jun 2019 08:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-2-git-send-email-sagar.kadam@sifive.com>
 <325855d0-00f9-df8a-ea57-c140d39dd6ef@ti.com> <CAARK3H=O=h1VDgOMxs_0ThcisrH=2tzpW5pQqt0O9oYs=MFFVw@mail.gmail.com>
 <93b9c5fd-8f59-96d7-5e40-2b9d540965dd@ti.com> <CAARK3H=CmxSG2srUaoxN1HF6W7CVKtpATrf89n6kuht2Paqp8A@mail.gmail.com>
 <3fe68154-5d1e-a395-4c53-d8e806b2cc6d@ti.com> <CAARK3HmNSOqhv_+Y2dMTRTyg=Jtry7J-j419CS5GTAiPiPLLdw@mail.gmail.com>
 <8edce82b-5b3e-fccd-4748-457fe86f36be@ti.com>
In-Reply-To: <8edce82b-5b3e-fccd-4748-457fe86f36be@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 24 Jun 2019 20:52:35 +0530
Message-ID: <CAARK3HmWja2aY6ZPTANi1J6PE0iUmurkqwEjyEwQSfODQ-suDQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: add support for is25wp256
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Mon, Jun 24, 2019 at 6:37 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 24/06/19 6:10 PM, Sagar Kadam wrote:
> > Hello Vignesh,
> >
> > On Mon, Jun 24, 2019 at 3:04 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On 21/06/19 3:58 PM, Sagar Kadam wrote:
> >>> Hello Vignesh,
> >>>
> >>> On Fri, Jun 21, 2019 at 11:33 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 17/06/19 8:48 PM, Sagar Kadam wrote:
> >>>>> Hello Vignesh,
> >>>>>
> >>>>> Thanks for your review comments.
> >>>>>
> >>>>> On Sun, Jun 16, 2019 at 6:14 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
> >>>>>> [...]
> >>>>>>
> >>>>>>> @@ -4129,7 +4137,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >>>>>>>       if (ret)
> >>>>>>>               return ret;
> >>>>>>>
> >>>>>>> -     if (nor->addr_width) {
> >>>>>>> +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
> >>>>>>>               /* already configured from SFDP */
> >>>>>>
> >>>>>> Hmm, why would you want to ignore addr_width that's read from SFDP table?
> >>>>>
> >>>>> The SFDP table for ISSI device considered here, has addr_width set to
> >>>>> 3 byte, and the flash considered
> >>>>> here is 32MB. With 3 byte address width we won't be able to access
> >>>>> flash memories higher address range.
> >>>>
> >>>> Is it specific to a particular ISSI part as indicated here[1]? If so,
> >>>> please submit solution agreed there i.e. use spi_nor_fixups callback
> >>>>
> >>>> [1]https://patchwork.ozlabs.org/patch/1056049/
> >>>>
> >>>
> >>> Thanks for sharing the link.
> >>> From what I understand here, it seems that "Address Bytes" of SFDP
> >>> table for the device under
> >>> consideration (is25lp256) supports 3 byte only Addressing mode
> >>> (DWORD1[18:17] = 0b00.
> >>> where as that of ISSI device (is25LP/WP 256Mb/512/Mb/1Gb) support 3 or
> >>> 4 byte Addressing mode DWORD1[18:17] = 0b01.
> >>>
> >>
> >> Okay, so that SFDP table entry is correct. SPI NOR framework should
> >> using 4 byte addressing if WORD1[18:17] = 0b01. Could you see if below
> >> diff helps:
> >>
> > Thank-you for the suggestion.
> > I applied it, and observed, that data in SFDP table mentioned in
> > document received
> > from ISSI support doesn't match with what is actually present on the
> > device (I have raised a query with issi support for the same)
> > The WP device also has the same SFDP entry as the LP device (the one
> > which you shared).
> > So, will submit V7 with the solution agreed in the link you shared above.
> >      https://patchwork.ozlabs.org/patch/1056049/
> > Apologies for the confusion, so please excuse the v6 which I submitted earlier.
> >
>
> There is an updated version of the patch:
> https://patchwork.ozlabs.org/patch/1071453/
>
> You may want to align with Liu Xiang to avoid duplication of effort
>

Ok. It seems Liu Xiang, is working on supporting is25LP256 device,
while the one considered here is WP
Although both are very similar devices, they differ a bit maybe with
Operating voltage, ID values, die revision etc..
I will sync-up with him about his v4 plan, and update you accordingly.
Thanks for the link.

BR,
Sagar Kadam


> > Thanks & BR,
> > Sagar Kadam
> >
> >> --->8---
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> >> index c0a8837c0575..ebf32aebe5e9 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -2808,6 +2808,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
> >>                 break;
> >>
> >>         case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
> >> +       case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
> >>                 nor->addr_width = 4;
> >>                 break;
> >
> >
> >>
> >>
> >>
> >>
> >> --
> >> Regards
> >> Vignesh
>
> --
> Regards
> Vignesh
