Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A76C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBE62071B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573782587;
	bh=K7DPgqI1uO+gESDRrTzIwuxJCFvF3Z803tdN3Ng+XyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nFWTgoa+Sjb6Osd1DneVoOTikugvJjUh6nfApUweKs+kHQIeeZ/TZRqcwlIDCudtA
	 y5nAkubK42d8G99WmCTqXkmnip2xTcyhBYQSgsHjSVHhmmiye9NHg0TkJxRuA4tr6m
	 x0JGlH5J/hFpWAqEaCsvqKt0CUm/6ytyABqOYLKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKOBtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfKOBtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:49:46 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9B82071B;
        Fri, 15 Nov 2019 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573782585;
        bh=K7DPgqI1uO+gESDRrTzIwuxJCFvF3Z803tdN3Ng+XyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iKU1GzimBzkqfmUUqfH61mDUDyX21eFsQ1pTuIK5C73CAaW4IWQwUc/BdmUlIYDDF
         xseVlIG9D3DoZDUKtjYtYM48tgw8KIHOI8IL6y8lqLdvGtX61SQQAgIIap/kKBO0Yb
         FGmNoJ95IS8sRJm2KIWFGi/EnzOS9ebaLvmyGBJU=
Received: by mail-qk1-f170.google.com with SMTP id h15so6838292qka.13;
        Thu, 14 Nov 2019 17:49:45 -0800 (PST)
X-Gm-Message-State: APjAAAXBGfsvBDwbu9C1c4Hj4lPYbjHQmbMvqzXjQiIqZg1YDW6MMTAz
        pZrfVWYOoCc4RefvyDbXKrR/GODSTwJMOSVHAw==
X-Google-Smtp-Source: APXvYqxjRhLNQlzP0CakaATDrANV+5U3OxFHW1Qu86/dXkhP6r3vzd87/xwIqDj+I08BApOQBH9IraLJA/bxw1zgbIw=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr10498140qka.152.1573782584495;
 Thu, 14 Nov 2019 17:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-3-chunyan.zhang@unisoc.com> <20191114205235.GA16668@bogus>
 <CAAfSe-s==xzeK_Y0rVezunR0T86b7ZcASo4HcW6g74qH7v-vbg@mail.gmail.com>
In-Reply-To: <CAAfSe-s==xzeK_Y0rVezunR0T86b7ZcASo4HcW6g74qH7v-vbg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Nov 2019 19:49:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJucaafDPSwcUZcEvzR-6p8Ro2+8=XeCc1pGyvcjg-N=w@mail.gmail.com>
Message-ID: <CAL_JsqJucaafDPSwcUZcEvzR-6p8Ro2+8=XeCc1pGyvcjg-N=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: serial: Convert sprd-uart to json-schema
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 7:35 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Fri, 15 Nov 2019 at 04:52, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Nov 11, 2019 at 05:02:27PM +0800, Chunyan Zhang wrote:
> > >
> > > Convert the sprd-uart binding to DT schema using json-schema.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  .../devicetree/bindings/serial/sprd-uart.txt  | 32 ---------
> > >  .../devicetree/bindings/serial/sprd-uart.yaml | 69 +++++++++++++++++++
> > >  2 files changed, 69 insertions(+), 32 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
> > >  create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > > deleted file mode 100644
> > > index 9607dc616205..000000000000
> > > --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > > +++ /dev/null
> > > @@ -1,32 +0,0 @@
> > > -* Spreadtrum serial UART
> > > -
> > > -Required properties:
> > > -- compatible: must be one of:
> > > -  * "sprd,sc9836-uart"
> > > -  * "sprd,sc9860-uart", "sprd,sc9836-uart"
> > > -
> > > -- reg: offset and length of the register set for the device
> > > -- interrupts: exactly one interrupt specifier
> > > -- clock-names: Should contain following entries:
> > > -  "enable" for UART module enable clock,
> > > -  "uart" for UART clock,
> > > -  "source" for UART source (parent) clock.
> > > -- clocks: Should contain a clock specifier for each entry in clock-names.
> > > -  UART clock and source clock are optional properties, but enable clock
> > > -  is required.
> > > -
> > > -Optional properties:
> > > -- dma-names: Should contain "rx" for receive and "tx" for transmit channels.
> > > -- dmas: A list of dma specifiers, one for each entry in dma-names.
> > > -
> > > -Example:
> > > -     uart0: serial@0 {
> > > -             compatible = "sprd,sc9860-uart",
> > > -                          "sprd,sc9836-uart";
> > > -             reg = <0x0 0x100>;
> > > -             interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > > -             dma-names = "rx", "tx";
> > > -             dmas = <&ap_dma 19>, <&ap_dma 20>;
> > > -             clock-names = "enable", "uart", "source";
> > > -             clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
> > > -     };
> > > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > > new file mode 100644
> > > index 000000000000..0cc4668a9b9c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license please. If you are okay with that on both patches, I can
> > fix them and apply patches 1-4.
>
> Sure, thanks for your help.

Thanks. Patches 1-4 applied.

Rob
