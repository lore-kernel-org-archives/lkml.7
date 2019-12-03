Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A820684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwTTgtN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLCGDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:03:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42924 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLCGDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:03:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so1882811otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=em0mwcnekNPSrQ/TlvXcfMqa65n+WTC4RKGqGuPqh0E=;
        b=rwTTgtN9QbUVjkYn/DftNihRoNzWlKozTXKK/Oz6EFiI5FCqNX3eA84Ik8dRuF6uYZ
         fCpfslNuibOwIMTM8B6vcT82vvAxvndKCEQVWFa/W7ZYPo5Jzzxwd4YYtTRhOccZ+sd0
         v/KFd7bfR/bhY/p4sv6qW5SZLwZlHpEwTw59RoYxzG8SraSQxdLkXRL30s7tjJUFFcKZ
         qOTz6F+tUWH3tYfZC6ysvC5G4w28oNKF8gfoDV4lyrTARKXv8vUV2tB/AkcUPdmw2XbR
         h/huoCaLj6772I7cwpfHgH/ZdYGfc13dvkKgH3c9tA9IR/l8unPzFyY1pMcA42zsUTso
         /y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=em0mwcnekNPSrQ/TlvXcfMqa65n+WTC4RKGqGuPqh0E=;
        b=dftYcbAI5mOWJZaA/VlGF/arAI622IaPLW/9g4L0KQ0+T3joTfOrwyfws9ztWFv5CZ
         I+9cmUM1HkuUu2qfiB9J7Fn9lQ6mPBJ4eVHUbrfkyGlsNuC2WUD9BhYmkjMrd6eXBoko
         KCO43OcDL43V0TxIrheBMTuioLlCn+PDPfMtudtewxXGBmsxcBOTkXmBxcWyFTDAK3JC
         NbKj+2LJdWxXcOPDTiKb9oR2lLg6sfGAHDW0JaukjhtNCb2eAAg3GyRG2lM5TSdrkQFv
         c7Sab6F2mjO4vQPr65tr1QgwoEDSEAaGojt6ijMI9OegxnC9WO0Z1sa+KiOPm77HH/e5
         mw6g==
X-Gm-Message-State: APjAAAVk+zjsHa4bwk5hD0JpHaTCWpAHQY5kNQhCfA0hbY6fmdLDuQHZ
        5U4VaRPAbZ9Wk8Gu2U6uvW0ju5g19BtCsJ8jfXR1zA==
X-Google-Smtp-Source: APXvYqyUwjjUt6uilPV5TuiM+Ljl5ziWLr7U6mbVF1pTfEgj/j/jZ1ejlryeTCkLK1bytyv33a+7IyXMakumOsoc9E0=
X-Received: by 2002:a9d:3af:: with SMTP id f44mr1989987otf.332.1575353009553;
 Mon, 02 Dec 2019 22:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
 <20190911182546.17094-4-nsaenzjulienne@suse.de> <CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com>
 <CALAqxLUkPNf9JYyt+_VOrxq=Zq03veb1y-7aDx+_Vw+fF9i82A@mail.gmail.com>
In-Reply-To: <CALAqxLUkPNf9JYyt+_VOrxq=Zq03veb1y-7aDx+_Vw+fF9i82A@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 2 Dec 2019 22:03:17 -0800
Message-ID: <CALAqxLW7RTif_NPxFXnxfTm2_ST+6aNmE6X=3v4XsuojKH2mtg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, wahrenst@gmx.net,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Nicolas Dechense <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 9:38 PM John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Dec 2, 2019 at 9:08 PM John Stultz <john.stultz@linaro.org> wrote:
> > Hey Nicolas,
> >   Testing the db845c with linus/master, I found a regression causing
> > system hangs in early boot:
...
> > In the above log:
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: -188245
> > looks the most suspect, and going back to the working a573cdd7973d +
> > build fix I see:
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 957419
> >
> > Do you have any suggestions for what might be going wrong?
>
> Digging further, it seems the error is found in calculate_node_totalpages()
>  real_size = size - zone_absent_pages_in_node(pgdat->node_id, i,
>                                                   node_start_pfn, node_end_pfn,
>                                                   zholes_size);
>
> Where for zone DMA32 size is 262144, but real_size is calculated as -883520.
>
> I've not traced through to figure out why zone_absent_pages_in_node is
> coming up with such a large number yet, but I'm about to crash so I
> wanted to share.

Ok, narrowing it down further, it seems its the following bit from the patch:

> @@ -201,13 +212,18 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>         struct memblock_region *reg;
>         unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
>         unsigned long max_dma32 = min;
> +       unsigned long max_dma = min;
>
>         memset(zone_size, 0, sizeof(zone_size));
>
> -       /* 4GB maximum for 32-bit only capable devices */
> +#ifdef CONFIG_ZONE_DMA
> +       max_dma = PFN_DOWN(arm64_dma_phys_limit);
> +       zone_size[ZONE_DMA] = max_dma - min;
> +       max_dma32 = max_dma;
> +#endif
>  #ifdef CONFIG_ZONE_DMA32
>         max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
> -       zone_size[ZONE_DMA32] = max_dma32 - min;
> +       zone_size[ZONE_DMA32] = max_dma32 - max_dma;
>  #endif
>         zone_size[ZONE_NORMAL] = max - max_dma32;
>
> @@ -219,11 +235,17 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>
>                 if (start >= max)
>                         continue;
> -
> +#ifdef CONFIG_ZONE_DMA
> +               if (start < max_dma) {
> +                       unsigned long dma_end = min_not_zero(end, max_dma);
> +                       zhole_size[ZONE_DMA] -= dma_end - start;
> +               }
> +#endif
>  #ifdef CONFIG_ZONE_DMA32
>                 if (start < max_dma32) {
> -                       unsigned long dma_end = min(end, max_dma32);
> -                       zhole_size[ZONE_DMA32] -= dma_end - start;
> +                       unsigned long dma32_end = min(end, max_dma32);
> +                       unsigned long dma32_start = max(start, max_dma);
> +                       zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
>                 }
>  #endif
>                 if (end > max_dma32) {

The zhole_sizes end up being:
zhole_size: DMA: 67671, DMA32: 1145664 NORMAL: 0

This seems to be due to dma32_start being calculated as 786432 each
time - I'm guessing that's the max_dma value.
Where dma32_end is around 548800, but changes each iteration (so we
end up subtracting a negative value each pass, growing the size).

thanks
-john
