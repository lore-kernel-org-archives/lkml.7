Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2B1C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B99D21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569512173;
	bh=ncxPzpQz8BLxmfkZRs9G1Ix6IIyLzOR3M2H36B+FqsY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W6kH460+HX/pVBjyi67jBM/dbjM3y01vi4S/kvXTwj0D9ZtAWHcjvfE6M9hjhnQ+w
	 MRLhaWk68ceX5Zj8ZqEurQd0q+95rJFsdWn9x1KEqc7oEIdYnKz9LjqLY+SXTfAv+6
	 d7fNenbxRNwfkNH3IS49BDw4Mypgg+rWom+dmreU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfIZPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfIZPgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:36:12 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B53E21D56;
        Thu, 26 Sep 2019 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569512170;
        bh=ncxPzpQz8BLxmfkZRs9G1Ix6IIyLzOR3M2H36B+FqsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fEL922CotjCRORMLKTbFZ4oOcDKY+QL4SzDHXhA20dsZO+6e1pGReHQw7W9/BbPZW
         rvz5PZOFelZpPB+HrQwBgBftjTE6vW81RXnexQz1jnGAjVpyutY8UX1YY8LO6hmFpk
         lFtpHbWHsHmu7cD8o8ucTCc1MDomh4AeENfIwoRc=
Received: by mail-qt1-f172.google.com with SMTP id c21so3335207qtj.12;
        Thu, 26 Sep 2019 08:36:10 -0700 (PDT)
X-Gm-Message-State: APjAAAWPYiBhxtFIHKKBN/e7D8qc0tsXzcYCVYSUGhN7DYAIVARLDZFV
        UU/W/qQCo656InJaVVlFW7dwKwxXsEXX2KkCLQ==
X-Google-Smtp-Source: APXvYqxQOADsBfOqIVHdW6gFpIIfgYly8PGgVMOXjuhb+x2+qzmtAr9/o6x8BGzc6hLagaWPlkoyWp5WOx4+2A4cqz8=
X-Received: by 2002:ac8:6915:: with SMTP id e21mr4520639qtr.224.1569512169600;
 Thu, 26 Sep 2019 08:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be@eucas1p2.samsung.com>
 <20190926125614.10408-1-m.szyprowski@samsung.com> <20190926140315.GA16002@pi3>
 <0d3831ae-e33d-774d-02f7-fba45a95d25c@samsung.com>
In-Reply-To: <0d3831ae-e33d-774d-02f7-fba45a95d25c@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 26 Sep 2019 10:35:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL4LZdkWkDkZdEpv4Sh840GywfHhLgmWjYCm9z+QPxrLg@mail.gmail.com>
Message-ID: <CAL_JsqL4LZdkWkDkZdEpv4Sh840GywfHhLgmWjYCm9z+QPxrLg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Scaler to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 9:47 AM Maciej Falkowski
<m.falkowski@samsung.com> wrote:
>
>
> On 9/26/19 4:03 PM, Krzysztof Kozlowski wrote:
> > On Thu, Sep 26, 2019 at 02:56:14PM +0200, Marek Szyprowski wrote:
> >> From: Maciej Falkowski <m.falkowski@samsung.com>
> >>
> >> Convert Samsung Image Scaler to newer dt-schema format.
> >>
> >> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >> v2:
> >> - Removed quotation marks from string in 'compatible' property
> >> - Added if-then statement for 'clocks' and 'clock-names' property
> >> - Added include directive to example
> >> - Added GIC_SPI macro to example
> >>
> >> Best regards,
> >> Maciej Falkowski
> >> ---
> >>   .../bindings/gpu/samsung-scaler.txt           | 27 -------
> >>   .../bindings/gpu/samsung-scaler.yaml          | 71 +++++++++++++++++++
> >>   2 files changed, 71 insertions(+), 27 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >>   create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >> deleted file mode 100644
> >> index 9c3d98105dfd..000000000000
> >> --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >> +++ /dev/null
> >> @@ -1,27 +0,0 @@
> >> -* Samsung Exynos Image Scaler
> >> -
> >> -Required properties:
> >> -  - compatible : value should be one of the following:
> >> -    (a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
> >> -    (b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
> >> -
> >> -  - reg : Physical base address of the IP registers and length of memory
> >> -      mapped region.
> >> -
> >> -  - interrupts : Interrupt specifier for scaler interrupt, according to format
> >> -             specific to interrupt parent.
> >> -
> >> -  - clocks : Clock specifier for scaler clock, according to generic clock
> >> -         bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
> >> -
> >> -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
> >> -              on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
> >> -
> >> -Example:
> >> -    scaler@12800000 {
> >> -            compatible = "samsung,exynos5420-scaler";
> >> -            reg = <0x12800000 0x1294>;
> >> -            interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
> >> -            clocks = <&clock CLK_MSCL0>;
> >> -            clock-names = "mscl";
> >> -    };
> >> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >> new file mode 100644
> >> index 000000000000..af19930d052e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >> @@ -0,0 +1,71 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: https://protect2.fireeye.com/url?k=1ffa720fd467d028.1ffbf940-9a5a550397b4da2b&u=http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Samsung Exynos SoC Image Scaler
> >> +
> >> +maintainers:
> >> +  - Inki Dae <inki.dae@samsung.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - samsung,exynos5420-scaler
> >> +      - samsung,exynos5433-scaler
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
>
> Hi Krzysztof,

Please work on your quoting. Reply below what you are replying to.

>
> By "Midgard" I assume that you referred to
> 'Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml'.
>
> I think that 'clocks' and 'clock-names' properties before if statement
> serve different purpose in this schema.
> It totally has about 10 different compatibles grouped in five pairs.
> Then schema declares for 'clocks' minItems as one and maxItems as two and
> later it overrides this boundaries with if statement for particular
> compatibles.

It's not an override, but an AND. So what's under 'properties' has to
be the looser constraints than what is under an if/then schema.

> Well, then clearly, the purpose is to declare boundaries for all of
> pairs and
> not to provide easy-to-find definition for this properties.
>
> In my schema I directly set boundaries per compatible with single
> if-else statement.
> I didn't know what to put before then as if statement is already
> self-explanatory.
>
> Best regards,
> Maciej Falkowski
>
> > I am repeating myself... leave the clocks and clock-names.
> >
> > "I think it is worth to leave the clocks and clock-names here (could be
> > empty or with min/max values for number of items). This makes it easy to
> > find the properties by humans.

I agree.

Let me put it another way. You need to add an 'additionalProperties:
false' and (I think) to make that work you'll need them listed here.

Rob
