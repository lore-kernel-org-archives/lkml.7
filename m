Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67454C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37927218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgb6E9r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfCAJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:42:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43942 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCAJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:42:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id j1so17529155lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsvJ9dGN0DfEes+tAz/D2MAdEBN03OZQ+kd1xigefBg=;
        b=vgb6E9r8UbJ3icTtLYIZ6I2DzOs3JoB/4aF3KkjGF7RrGr5IBrgo9ab2SwRA4ZR76M
         AZZaOmVoEvYxaCxyzs34Jn3h6HbeMh8HDaigKI93VrDidRrlCn/Gw9CMjisHV1/LNFLr
         Gw2bWBM92KX7DyslsH1KoRBWWctMIAVl1maY6TSejHnwq5Ajw3gX3/r2r134cdl8jhlN
         rKaex++Tf8Ii83iYdUSOy2MBuDsqVr+/ocS+OqBrIYF3I5mZi7gwXpaKMkkE1uLER3SI
         OnwdGMo6CHZ/vXmCOrbw4WVRUM9m4yf1lD8hGtOK7sPjSwNAlCQFuSGcl4E6cpX+gdvv
         jKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsvJ9dGN0DfEes+tAz/D2MAdEBN03OZQ+kd1xigefBg=;
        b=qjcctRNLueRrOV0AsEDUyGjJ/e6X1C2/piplNRxh7Nx78xFo1kmURAUyFEqnqEyz8Z
         M0xf/C5I50rmmodJF23+twP7P96b2d+hRC9RDtPJ23PA0TFWOF6DYi3rXPqS1Y7YKXoQ
         JnANxPEcd03/VWDihVqMvBZQwlwNF8SZJcl6gmODznpVEUHZU34Oo4mw0nWVg2SqFwiK
         j6lJy2yRZ1g/J9mvrKjLNvh8E2R+BetGvF0Y0botyYhaHhDcAL+Z+HbyhPKK0tMk78RM
         Iwm9S5VcMA0nw7mlapSJOsB812971ujHrKF22GcpDGpEZZmAWcH/uNixqlsV7TtDSicJ
         Q97g==
X-Gm-Message-State: APjAAAWMplAdBVsbMoh9vaHqQ4OMgkTFtV/hi/gtO0OZJAxhwo48Qqo9
        lXO4HCCgNjpvxggG+2aa+Y7oZ5/QSphSUCz6OhTKvw==
X-Google-Smtp-Source: APXvYqyoRpOjWAEXyXfx/AnnZ/RjXqqD7qAWFTmpzEwV5kiRBU/Lc9VBEf68hwGOLBBgV8Qr4FZirSRNYquKYuyDdJk=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr2399337lfa.40.1551433366216;
 Fri, 01 Mar 2019 01:42:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550560916.git.baolin.wang@linaro.org> <8f0a032f9bcce28bb0d147f9646950f64fc22a74.1550560916.git.baolin.wang@linaro.org>
 <20190228195319.GA13133@bogus>
In-Reply-To: <20190228195319.GA13133@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 1 Mar 2019 17:42:32 +0800
Message-ID: <CAMz4kuLQucODjYzei6TY1jRkP8VCY6i_8z963VuW7PWEDJLF2A@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: serial: sprd: Add dma properties to
 support DMA mode
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 at 03:53, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 19, 2019 at 03:31:14PM +0800, Baolin Wang wrote:
> > From: Lanqing Liu <lanqing.liu@unisoc.com>
> >
> > This patch adds dmas and dma-names properties for the UART DMA mode.
> >
> > Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > index 6eb5863..9ac28f6 100644
> > --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > @@ -15,12 +15,18 @@ Required properties:
> >    UART clock and source clock are optional properties, but enable clock
> >    is required.
> >
> > +Optional properties:
> > +- dma-names: Should contain "tx" for transmit and "rx" for receive channels.
>
> The order here doesn't match the example.

Ah, yes, will update new version to fix this. Thanks.

>
> > +- dmas: A list of dma specifiers, one for each entry in dma-names.
> > +
> >  Example:
> >       uart0: serial@0 {
> >               compatible = "sprd,sc9860-uart",
> >                            "sprd,sc9836-uart";
> >               reg = <0x0 0x100>;
> >               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +             dma-names = "rx", "tx";
> > +             dmas = <&ap_dma 19 19>, <&ap_dma 20 20>;
> >               clock-names = "enable", "uart", "source";
> >               clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
> >       };
> > --
> > 1.7.9.5
> >



-- 
Baolin Wang
Best Regards
