Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B545AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E1A2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S66dh4Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbfDRIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:05:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43646 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388254AbfDRIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:05:25 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so1224409iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbR0bNXOeX5XkekGGfrgR2SNLv2lg70f38dGHlM6btE=;
        b=S66dh4IpAaTtcy75alpA5rJi6X0chvwnFc35tJuNner1Um3zpi70Rsf2N54Cga15v6
         XQFg3pWKDsaw1LyA0zTfdMrNXoUUH7GyrF+ZQYTd+AyTmOwplDEbdQKYl4QiccLOLe1F
         Az2vqFNzkEXoQNgq2VSpD/on+QXSGCw64T7u6P4X/zH6AFPpk4SkeXActxrjkqqf09uG
         I7scldq8jTct1Q07YuHt3JPNS76/aAT7OcqhSVmo7IxDwZhrkLsxXg3IwF+lY27zQaX2
         fJFJyraRwzxcNB6Za+zCceUhOQnpGx/jxamZ+mj8NOvtt9+Xju7TrD9LUWncNhfrJBjD
         kH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbR0bNXOeX5XkekGGfrgR2SNLv2lg70f38dGHlM6btE=;
        b=NESIlI9GxE5M8pkKr0rVuxj+FeyFGbWVAGR9MHLOTR/JVFJLibmkpAEaWGdKYNjVVK
         3j5bkPwTlkrRlJFGrhbflALFSxc5xAD3pKcSR18qpA80jBQXjP63a2Ne5Rc4KqiGvgC0
         2SrzNifM8KhsA7S0TzcCT8g/VR0CdOQNqbQp9KSM6DFDmCoy0LVePF1e7tvJkUwcB4CE
         fMvgfdYx89PwDk7aqiSWzNhXQ+V3wUFU4Ar7VIWyl4k4Q9MHBlLIF6a+MpVRQSNTAcWs
         +G1L/lZWbcJJO/PONuniVRM4+kIvtV5P2uAPqV8rVTYrLLn50DZ9unkod2wEOiXVZOBW
         4GPA==
X-Gm-Message-State: APjAAAUP4Y+M+IblH1sxXQ64snhFe4K4y1JjERlE1VYaR60jY+o34aQT
        mWnTHyqbpl7fF/qd+/GcdmiFhIWIh9agFlOyC0hzcg==
X-Google-Smtp-Source: APXvYqzO/gs4XlvT5/1iyZ2hAg34PJ0Fwxw9lkhxzRbofHUSsExRxrB1OcWby5jOpygsvFSdNgLqPPomjx63lgMFdD8=
X-Received: by 2002:a6b:e61a:: with SMTP id g26mr60039595ioh.105.1555574724922;
 Thu, 18 Apr 2019 01:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-20-fparent@baylibre.com>
 <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com> <1555403151.7441.4.camel@mhfsdcap03>
In-Reply-To: <1555403151.7441.4.camel@mhfsdcap03>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Thu, 18 Apr 2019 10:05:13 +0200
Message-ID: <CAOwMV_yKAm1zar6buhe25O56AkAX8e0nXnm4GmqhvHC-yagKfQ@mail.gmail.com>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for MT8516
To:     lei liu <leilk.liu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        ryder.lee@mediatek.com, linux-watchdog@vger.kernel.org,
        jjian.zhou@mediatek.com, wenzhen.yu@mediatek.com,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        sean.wang@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yong.mao@mediatek.com,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org, hsin-hsiung.wang@mediatek.com,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:25 AM lei liu <leilk.liu@mediatek.com> wrote:
>
> On Tue, 2019-04-16 at 09:55 +0200, Matthias Brugger wrote:
> >
> > On 23/03/2019 22:16, Fabien Parent wrote:
> > > Add binding documentation of spi-mt65xx for MT8516 SoC.
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> >
> > applied to v5.1-next/dts64
> >
> > Mark let me know if you want to take it through your tree and I drop the patch.
> >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > > index 69c356767cf8..69ac5976b952 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > > +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > > @@ -10,6 +10,7 @@ Required properties:
> > >      - mediatek,mt8135-spi: for mt8135 platforms
> > >      - mediatek,mt8173-spi: for mt8173 platforms
> > >      - mediatek,mt8183-spi: for mt8183 platforms
> > > +    - "mediatek,mt8516-spi", "mediatek,mt2701-spi": for mt8516 platforms
> Hi Fabien,
> mt8516 SPI design comes from mt2712 and it's different from mt2701. Here
> it should compatible with mt2712.

Ok, thanks. I will retry with the mt2712 compatible.

> > >
> > >  - #address-cells: should be 1.
> > >
> > >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
>
