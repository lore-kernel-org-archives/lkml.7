Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D9CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D364620820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pYwivSRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392129AbfJRGAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:00:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36811 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbfJRGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:00:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so4247485oih.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UqfvRiIf/2+i2h/4Ujog5bIvchOk5tCgScNdijxQat0=;
        b=pYwivSRkBCkHKIKFMDxSUQzYxZubKHj+eCQPph1DAVEMONHUi6BTkSvZFnrCvfLDxH
         V4OwguAODrasciR5IXTpPZ+z7pwLQDiwResq2ZCCpKPZ9gC9ReqObuK06qxyekoEAnkt
         Lin0M1x80JQOW86VzKE/a/V400dWUexZDggO72ItnaHM0dmXMfVd6xC6Wgn1BvHuCudQ
         +GULmOf7tQBP3UOhpQk3PQVJyZkQCwRxOjGivUuHXavq2ko60LD+eB6Rc+0/aL0XABBw
         ZHBPvTIj+om6O9AfsDy4rIhOHzfkZ4RgLtxOeN9hldC0DmH8GJoJBm56IH7+s1eU4WZH
         szjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UqfvRiIf/2+i2h/4Ujog5bIvchOk5tCgScNdijxQat0=;
        b=iTgrIC6VykEgLKGCEmmGzuRe7my38FMSEx5OwgXZMtmUgC2weO6UujXk7JHy1tLYo8
         +qEIHiU4X5060GcxezvL1GQFb/O/FWmQcT3ZMMDgh4tjriBWeZSUjR/2b42CC9n6OoEj
         vVPuhU8izIreyRtaGrg4FJgxlZnunXlNytUKzBVOV5n/gENQzzZl93Pz3fwt5CPhYihB
         plgLpeFUTTBw7VwnqwscsvsHh6FpJXIHYIYRfZ14yV7b4y6wYPgS3rFBUlqxT+MPZJAU
         h8/s3Wn/Gm1Bx0687fU9LW6t3FPtIrku4sSO+AfubTokUfFjZ63VOZjoYW4whLFNmniD
         7Jtw==
X-Gm-Message-State: APjAAAXwplf/d4VDtCHAxXsKyZOPDSdgCnm2IHUQPb/b5dkiQcKxwhFh
        9TaWeuuBlfTOAkzN/7XXV9dAG+UkTNBSQCCpPkwdVQ==
X-Google-Smtp-Source: APXvYqyCvDHaJrg7j1BywNpOntr+hSlB0UMU2FiS9ccSeEXT+v+90TwnyKhF9R7q13vsCdz5mVYJmK4+DYouCWn6Cw8=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr6575837oiy.170.1571378401053;
 Thu, 17 Oct 2019 23:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191017031051.20366-1-chris.packham@alliedtelesis.co.nz>
 <20191017031051.20366-2-chris.packham@alliedtelesis.co.nz> <20191017192437.GA24080@bogus>
In-Reply-To: <20191017192437.GA24080@bogus>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 18 Oct 2019 07:59:50 +0200
Message-ID: <CAMpxmJVrFK38BPjoUtGt99sqgFeOA=wHFAu=QNQg_5Rj1gU92A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: brcm: Add bindings for xgs-iproc
To:     Rob Herring <robh@kernel.org>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 17 pa=C5=BA 2019 o 21:24 Rob Herring <robh@kernel.org> napisa=C5=82(a=
):
>
> On Thu, Oct 17, 2019 at 04:10:50PM +1300, Chris Packham wrote:
> > This GPIO controller is present on a number of Broadcom switch ASICs
> > with integrated SoCs. It is similar to the nsp-gpio and iproc-gpio
> > blocks but different enough to require a separate driver.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >
> > Notes:
> >     Changes in v2:
> >     - Document as DT schema
> >     - Include ngpios, #gpio-cells and gpio-controller properties
> >
> >  .../bindings/gpio/brcm,xgs-iproc.yaml         | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,xgs-ipr=
oc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml=
 b/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
> > new file mode 100644
> > index 000000000000..71998551209e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/brcm,xgs-iproc.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/brcm,xgs-iproc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom XGS iProc GPIO controller
> > +
> > +maintainers:
> > +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> > +
> > +description: |
> > +  This controller is the Chip Common A GPIO present on a number of Bro=
adcom
> > +  switch ASICs with integrated SoCs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,iproc-gpio-cca
>
> enum vs. const usage depends on whether you think you'll add more
> compatibles.
>

What if you don't know yet? For instance we use a const compatible and
then a new chip is released for which we can reuse the driver? Is this
something that is expected to remain stable in the binding document?
The question is unrelated to this patch, I'm just unsure about my own
approach to writing yaml bindings.

Bart

> > +
> > +  reg:
> > +    minItems: 2
> > +    maxItems: 2
> > +    description:
> > +      The first region defines the base I/O address containing
> > +      the GPIO controller registers. The second region defines
> > +      the I/O address containing the Chip Common A interrupt
> > +      registers.
>
> items:
>   - description: the I/O address containing the GPIO controller
>       registers
>   - description: the I/O address containing the Chip Common A interrupt
>       registers
>
> And minItems/maxItems can be implicit.
>
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +      const: 2
> > +
> > +  ngpios:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Common property, doesn't need a type definition. Also, it would have to
> be under an 'allOf' to actually work.
>
> > +    minimum: 0
> > +    maximum: 32
> > +
> > +  interrupt-controller:
> > +    type: boolean
>
> Just 'interrupt-controller: true'
>
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#gpio-cells"
> > +  - gpio-controller
> > +
> > +allOf:
> > + - if:
> > +     properties:
> > +       interrupt-controller:
> > +         contains:
> > +           const: true
> > +   then:
> > +     required:
> > +       - interrupts
> > +       - '#interrupt-cells'
>
> This is mostly handled in the core schema already and 'dependencies'
> works better for this anyways. All you need here is:
>
> dependencies:
>   interrupt-controller: [ interrupts ]
>
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    gpio@18000060 {
> > +        compatible =3D "brcm,iproc-gpio-cca";
> > +        #gpio-cells =3D <2>;
> > +        reg =3D <0x18000060 0x50>,
> > +              <0x18000000 0x50>;
> > +        ngpios =3D <12>;
> > +        gpio-controller;
> > +        interrupt-controller;
> > +        #interrupt-cells =3D <2>;
> > +        interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> > +    };
> > +
> > +
> > +...
> > --
> > 2.23.0
> >
