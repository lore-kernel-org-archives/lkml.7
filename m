Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CE3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195E720673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566913022;
	bh=mD4q3LMo8D/oOkYLDOKCUAJJn9XFxRojkzOMMIIoH1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZOLIPuXvovKwdqXQPOQaKzJ8PRR2u6OG/+Siop/6tV9sHtFw9v/b4Xd61RKLxkobm
	 4rkG9yRrz2FZVBrze6yfCQs/sdxDDpxYGtUiZ4FpKESvtvX6eg9CV8fpCwUwEI6Jd8
	 clPF4kB5xmtuN5ugMQezQpxJxFXF8poJLKNteEVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfH0NhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0NhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:37:01 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82A820673;
        Tue, 27 Aug 2019 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566913019;
        bh=mD4q3LMo8D/oOkYLDOKCUAJJn9XFxRojkzOMMIIoH1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iIHtOikMNFdIzPT8jWOw/5DwxGlxnvIEDZv9e0PiIiaJHWvdLX+iDsXGeyppF1TUt
         c17W7Fc/T4Ik+b8XGYSHnukX7bjPDJcSTOeFIdDfjLuyWZrYhffCGT6g1hesZDhpUj
         3ZgF2FfSALXvFmHTL98And13MaG/+fN4e5USc9s4=
Received: by mail-qt1-f177.google.com with SMTP id z4so21308542qtc.3;
        Tue, 27 Aug 2019 06:36:59 -0700 (PDT)
X-Gm-Message-State: APjAAAU7mfZwakEtztu/sMj5ID/Uyt9AY8SLd0ZRYKMJM4kH7V8NLZ/0
        ok97OqN9a2T9MWbWZlAgsWg3nUEhOCJIEReUwQ==
X-Google-Smtp-Source: APXvYqzEOWLWWqszNcnpUlBSWwsUeCt8Jjat6t6FjKZi0ldOgh/0RivRU5T9R/NH2jHj7b42YDO9ISbX143dqtx8U7A=
X-Received: by 2002:a0c:eb92:: with SMTP id x18mr20126969qvo.39.1566913018683;
 Tue, 27 Aug 2019 06:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190822092643.593488-1-lkundrak@v3.sk> <20190822092643.593488-3-lkundrak@v3.sk>
 <CAL_JsqJ4_h+M=6L-nzK2N+A9TAy-N8SoiFv1SSTk_kCcKt0eXw@mail.gmail.com> <136a57cf3d293e3233f31d5ee660a6418726333a.camel@v3.sk>
In-Reply-To: <136a57cf3d293e3233f31d5ee660a6418726333a.camel@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 08:36:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK1pkwPZj+Us8CecNnfA7L17YVk9aTe3qPoNTAvRiHibw@mail.gmail.com>
Message-ID: <CAL_JsqK1pkwPZj+Us8CecNnfA7L17YVk9aTe3qPoNTAvRiHibw@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] dt-bindings: arm: Convert Marvell MMP board/soc
 bindings to json-schema
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 8:24 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Tue, 2019-08-27 at 06:59 -0500, Rob Herring wrote:
> > On Thu, Aug 22, 2019 at 4:27 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > Convert Marvell MMP SoC bindings to DT schema format using json-schema.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > >
> > > ---
> > > Changes since v1:
> > > - Added this patch
> > >
> > >  .../devicetree/bindings/arm/mrvl/mrvl.txt     | 14 ---------
> > >  .../devicetree/bindings/arm/mrvl/mrvl.yaml    | 31 +++++++++++++++++++
> > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > > deleted file mode 100644
> > > index 951687528efb0..0000000000000
> > > --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > > +++ /dev/null
> > > @@ -1,14 +0,0 @@
> > > -Marvell Platforms Device Tree Bindings
> > > -----------------------------------------------------
> > > -
> > > -PXA168 Aspenite Board
> > > -Required root node properties:
> > > -       - compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
> > > -
> > > -PXA910 DKB Board
> > > -Required root node properties:
> > > -       - compatible = "mrvl,pxa910-dkb";
> > > -
> > > -MMP2 Brownstone Board
> > > -Required root node properties:
> > > -       - compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
> > > diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> > > new file mode 100644
> > > index 0000000000000..dc9de506ac6e3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> > > @@ -0,0 +1,31 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/mrvl/mrvl.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Marvell Platforms Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Lubomir Rintel <lkundrak@v3.sk>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: '/'
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: PXA168 Aspenite Board
> > > +        items:
> > > +          - enum:
> > > +              - mrvl,pxa168-aspenite
> > > +          - const: mrvl,pxa168
> > > +      - description: PXA910 DKB Board
> > > +        items:
> > > +          - enum:
> > > +              - mrvl,pxa910-dkb
> >
> > Doesn't match what's in dts file:
> >
> > arch/arm/boot/dts/pxa910-dkb.dts:       compatible =
> > "mrvl,pxa910-dkb", "mrvl,pxa910";
>
> It corresponds to the .txt bindings specification this commit is
> converting. I thought it wouldn't be a good idea to do any changes to
> the contents at the time the conversion is done.

There are so many errors like this, that it's fine to do it in the
conversion. A separate patch is fine too.

> I also don't understand why does the dts file specify the board-
> specific compatible string. Surely "mrvl,pxa910" alone would be
> sufficient?

To potentially work around any board specific issue without a dtb change.

>
> > > +      - description: MMP2 Brownstone Board
> >
> > If this entry is only for this board...
> >
> > > +        items:
> > > +          - enum:
> > > +              - mrvl,mmp2-brownstone
> >
> > ...then this can be a 'const' instead. Same for the others.
>
> Sure, but is it preferable? I've actually done a "git grep -A3 enum
> Documentation/devicetree/bindings/" to see if the single-element is
> typically used and it seems like it is. Perhaps it's a good idea to
> indicate to a human reader that this is a list that's expected to
> eventually be extended with new elements.

Then the description should match and say 'MMP2 based boards'.

> In any case, there are more boards with MMP2 currently supported,
> notably the XO-1.75 laptop. I've actually sent out the dts file for
> review some time ago. I haven't added a separate compatible string for
> it because I thought it is not necessary (see above).

You should add one.

Rob
