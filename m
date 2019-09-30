Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A30C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1404F21924
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569878455;
	bh=nDimeaTefAJte0JkKYh0LxNPHJJjkhIW+4kgCyDLziI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U69pyb01092VE9fFlXeiBdS56clMNxH5pbV3bZT8t5WTN4w29JI2VXMsK8QF740YS
	 6yUTCxoJ8KfGxPLL0Ei6AadqRBug+YW5pz4cmFJ/NNxeWUFshqu7lDteXoZlxmYarU
	 /zW7e466det+6IEPi5k4s05NJ9fyVE7EyaIQyqG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfI3VUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbfI3VUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:20:54 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834CE224ED;
        Mon, 30 Sep 2019 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569869695;
        bh=nDimeaTefAJte0JkKYh0LxNPHJJjkhIW+4kgCyDLziI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wJQ8Kzn/d79BEfVY4JQlE/ULuHR6uLx09oEVYsba9tU7oofK2UHc0aeB6nuNW6+LJ
         zjl9T6uDZSievxqZ+K3mOKK9MOV4PH6kgNimYWGiEcc0hIDLG8P+tvXF2BQLG60CH6
         jCp4rMLdAlO9p3d5fB/+IZDV6r3H2djgiNv6CFy8=
Received: by mail-qt1-f175.google.com with SMTP id r5so18428130qtd.0;
        Mon, 30 Sep 2019 11:54:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXDbZM4nBhPemoF1KTTQ/s77Ny1flMMkUPCpQWeIVj5NcQi9PGQ
        fgq4u/EQn1uLQe0hAOpYYw2EQnOihhNCdRGFFA==
X-Google-Smtp-Source: APXvYqwQYdlSI7/i8ggFNTh1DGOtr9KQeJIFZEEaJGmzqPFXf0j7zK7eWLxWs8gkLE1tDlyw5qjrswBNXHCBDP46w/8=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr26354991qtn.110.1569869694707;
 Mon, 30 Sep 2019 11:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190927143314eucas1p2d419866cd740207426cd37cb6fdff468@eucas1p2.samsung.com>
 <20190927143306.12133-1-m.szyprowski@samsung.com> <CAJKOXPdbDropa0iL6YP4Fb4aFSEXQ87thOk5mN+cSCU=i+ZwUw@mail.gmail.com>
In-Reply-To: <CAJKOXPdbDropa0iL6YP4Fb4aFSEXQ87thOk5mN+cSCU=i+ZwUw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Sep 2019 13:54:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5PDM97zJZhp_E27d=RVFf87=QFH4d6=q_YC+tff6v-w@mail.gmail.com>
Message-ID: <CAL_Jsq+5PDM97zJZhp_E27d=RVFf87=QFH4d6=q_YC+tff6v-w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: gpu: Convert Samsung Image Scaler to dt-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Maciej Falkowski <m.falkowski@samsung.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, 27 Sep 2019 at 16:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > From: Maciej Falkowski <m.falkowski@samsung.com>
> >
> > Convert Samsung Image Scaler to newer dt-schema format.
> >
> > Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > v3:
> > - Fixed description of 'clocks' property:
> > rather than 'mscl clock', 'pclk clock'
> > - Added empty line within if-else statement
> > - Added 'additionalProperties: false'
> > - Listed all missing 'properties' in properties scope
> >
> > Best regards,
> > Maciej Falkowski
> > ---
> >  .../bindings/gpu/samsung-scaler.txt           | 27 -------
> >  .../bindings/gpu/samsung-scaler.yaml          | 81 +++++++++++++++++++
> >  2 files changed, 81 insertions(+), 27 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> > deleted file mode 100644
> > index 9c3d98105dfd..000000000000
> > --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> > +++ /dev/null
> > @@ -1,27 +0,0 @@
> > -* Samsung Exynos Image Scaler
> > -
> > -Required properties:
> > -  - compatible : value should be one of the following:
> > -       (a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
> > -       (b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
> > -
> > -  - reg : Physical base address of the IP registers and length of memory
> > -         mapped region.
> > -
> > -  - interrupts : Interrupt specifier for scaler interrupt, according to format
> > -                specific to interrupt parent.
> > -
> > -  - clocks : Clock specifier for scaler clock, according to generic clock
> > -            bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
> > -
> > -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
> > -                 on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
> > -
> > -Example:
> > -       scaler@12800000 {
> > -               compatible = "samsung,exynos5420-scaler";
> > -               reg = <0x12800000 0x1294>;
> > -               interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
> > -               clocks = <&clock CLK_MSCL0>;
> > -               clock-names = "mscl";
> > -       };
> > diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> > new file mode 100644
> > index 000000000000..5317ac64426a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung Exynos SoC Image Scaler
> > +
> > +maintainers:
> > +  - Inki Dae <inki.dae@samsung.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,exynos5420-scaler
> > +      - samsung,exynos5433-scaler
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks: {}
> > +  clock-names: {}
> > +  iommus: {}
> > +  power-domains: {}
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: samsung,exynos5420-scaler
> > +
> > +then:
> > +  properties:
> > +    clocks:
> > +      items:
> > +        - description: mscl clock
> > +
> > +    clock-names:
> > +      items:
> > +        - const: mscl
> > +
> > +else:
> > +  properties:
> > +    clocks:
> > +      items:
> > +        - description: pclk clock
> > +        - description: aclk clock
> > +        - description: aclk_xiu clock
> > +
> > +    clock-names:
> > +      items:
> > +        - const: pclk
> > +        - const: aclk
> > +        - const: aclk_xiu
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/exynos5420.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    scaler@12800000 {
> > +        compatible = "samsung,exynos5420-scaler";
> > +        reg = <0x12800000 0x1294>;
> > +        interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&clock CLK_MSCL0>;
> > +        clock-names = "mscl";
> > +    };
> > +
> > +...
>
> You have some left-overs at the end. With cleaning them:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

You mean the '...'? That's the end of YAML marker. It's not strictly needed.

Rob
