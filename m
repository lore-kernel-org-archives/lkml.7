Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2139C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF05222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569525596;
	bh=lDV2/khWaCrqwoPtDSkiXURiNo/w2nq/BGLRwKWnt3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SuOSkSAe+ujWvOT7ImePxCfw5V8/ztKNh8ejmIhboKtcnIbN2/uo+sSQ07NmCoaQe
	 XcoHYb/oRY5bADmN2kzI+IUgcZ8b3x8KiP/QN0uXdeaXua9i+h3GiK6eSUEni2g3kW
	 DVcr5WceDY3NudRVi7KEzX1wjYkQRwyx+f11FcmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfIZTT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfIZTTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:19:55 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6E9222C3;
        Thu, 26 Sep 2019 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569525594;
        bh=lDV2/khWaCrqwoPtDSkiXURiNo/w2nq/BGLRwKWnt3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqZixSfq2qYAapsIRWiOOX8W8WjKwlDOjiARabmw1Fza88xRWBB5MbLfopnH2Vq0N
         A9YTz69jPJ95S+FCDm4Tm6I5BwtL6vRXYOSchaFUnt9uyjjUxy2psa+ZNXGwRB6Njp
         Qp4luf7HPi9E4FDPC+LfqadJhJ6w5eS8I7IBiy9o=
Received: by mail-qt1-f179.google.com with SMTP id l3so4293219qtr.4;
        Thu, 26 Sep 2019 12:19:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXmzRFujkWbs6SkRnz5/U6/sqv20j+pGrTKwRvpebckP7OFjn20
        FHJtBylOlzbqq+fSvULPNmI5uIaLixK4ct9raA==
X-Google-Smtp-Source: APXvYqw/LWFeEuod/2bEzvhpoq5Re0c34dJP7Z9CwXq9dlPB6PTnXxBBlMZnG5YvRmYy0v6GNNoQOcxScphRMrO/kYg=
X-Received: by 2002:ac8:75c7:: with SMTP id z7mr5824094qtq.136.1569525593230;
 Thu, 26 Sep 2019 12:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be@eucas1p2.samsung.com>
 <20190926125614.10408-1-m.szyprowski@samsung.com> <20190926140315.GA16002@pi3>
 <0d3831ae-e33d-774d-02f7-fba45a95d25c@samsung.com> <CAL_JsqL4LZdkWkDkZdEpv4Sh840GywfHhLgmWjYCm9z+QPxrLg@mail.gmail.com>
 <f06da64d-58de-1d51-48d4-95a6efd417d0@samsung.com>
In-Reply-To: <f06da64d-58de-1d51-48d4-95a6efd417d0@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 26 Sep 2019 14:19:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+yWL3ZSnvHbGb4B0zHptQtFXjvOUJe0pNSHmH05GN-PA@mail.gmail.com>
Message-ID: <CAL_Jsq+yWL3ZSnvHbGb4B0zHptQtFXjvOUJe0pNSHmH05GN-PA@mail.gmail.com>
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

On Thu, Sep 26, 2019 at 11:54 AM Maciej Falkowski
<m.falkowski@samsung.com> wrote:
>
>
> On 9/26/19 5:35 PM, Rob Herring wrote:
> > On Thu, Sep 26, 2019 at 9:47 AM Maciej Falkowski
> > <m.falkowski@samsung.com> wrote:
> >>
> >> On 9/26/19 4:03 PM, Krzysztof Kozlowski wrote:
> >>> On Thu, Sep 26, 2019 at 02:56:14PM +0200, Marek Szyprowski wrote:
> >>>> From: Maciej Falkowski <m.falkowski@samsung.com>
> >>>>
> >>>> Convert Samsung Image Scaler to newer dt-schema format.
> >>>>
> >>>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> >>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>> ---
> >>>> v2:
> >>>> - Removed quotation marks from string in 'compatible' property
> >>>> - Added if-then statement for 'clocks' and 'clock-names' property
> >>>> - Added include directive to example
> >>>> - Added GIC_SPI macro to example
> >>>>
> >>>> Best regards,
> >>>> Maciej Falkowski
> >>>> ---
> >>>>    .../bindings/gpu/samsung-scaler.txt           | 27 -------
> >>>>    .../bindings/gpu/samsung-scaler.yaml          | 71 +++++++++++++++++++
> >>>>    2 files changed, 71 insertions(+), 27 deletions(-)
> >>>>    delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >>>>    create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >>>> deleted file mode 100644
> >>>> index 9c3d98105dfd..000000000000
> >>>> --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> >>>> +++ /dev/null
> >>>> @@ -1,27 +0,0 @@
> >>>> -* Samsung Exynos Image Scaler
> >>>> -
> >>>> -Required properties:
> >>>> -  - compatible : value should be one of the following:
> >>>> -    (a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
> >>>> -    (b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
> >>>> -
> >>>> -  - reg : Physical base address of the IP registers and length of memory
> >>>> -      mapped region.
> >>>> -
> >>>> -  - interrupts : Interrupt specifier for scaler interrupt, according to format
> >>>> -             specific to interrupt parent.
> >>>> -
> >>>> -  - clocks : Clock specifier for scaler clock, according to generic clock
> >>>> -         bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
> >>>> -
> >>>> -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
> >>>> -              on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
> >>>> -
> >>>> -Example:
> >>>> -    scaler@12800000 {
> >>>> -            compatible = "samsung,exynos5420-scaler";
> >>>> -            reg = <0x12800000 0x1294>;
> >>>> -            interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
> >>>> -            clocks = <&clock CLK_MSCL0>;
> >>>> -            clock-names = "mscl";
> >>>> -    };
> >>>> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..af19930d052e
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> >>>> @@ -0,0 +1,71 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: https://protect2.fireeye.com/url?k=1ffa720fd467d028.1ffbf940-9a5a550397b4da2b&u=http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Samsung Exynos SoC Image Scaler
> >>>> +
> >>>> +maintainers:
> >>>> +  - Inki Dae <inki.dae@samsung.com>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    enum:
> >>>> +      - samsung,exynos5420-scaler
> >>>> +      - samsung,exynos5433-scaler
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  interrupts:
> >>>> +    maxItems: 1
> >>>> +
> >> Hi Krzysztof,
> > Please work on your quoting. Reply below what you are replying to.
> >
> >> By "Midgard" I assume that you referred to
> >> 'Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml'.
> >>
> >> I think that 'clocks' and 'clock-names' properties before if statement
> >> serve different purpose in this schema.
> >> It totally has about 10 different compatibles grouped in five pairs.
> >> Then schema declares for 'clocks' minItems as one and maxItems as two and
> >> later it overrides this boundaries with if statement for particular
> >> compatibles.
> > It's not an override, but an AND. So what's under 'properties' has to
> > be the looser constraints than what is under an if/then schema.
> Hi Rob,
> Thank you for explaining that.
> >> Well, then clearly, the purpose is to declare boundaries for all of
> >> pairs and
> >> not to provide easy-to-find definition for this properties.
> >>
> >> In my schema I directly set boundaries per compatible with single
> >> if-else statement.
> >> I didn't know what to put before then as if statement is already
> >> self-explanatory.
> >>
> >> Best regards,
> >> Maciej Falkowski
> >>
> >>> I am repeating myself... leave the clocks and clock-names.
> >>>
> >>> "I think it is worth to leave the clocks and clock-names here (could be
> >>> empty or with min/max values for number of items). This makes it easy to
> >>> find the properties by humans.
> > I agree.
> >
> > Let me put it another way. You need to add an 'additionalProperties:
> > false' and (I think) to make that work you'll need them listed here.
> >
> > Rob
>
> So when properties are only defined inside if-then scope,
> they are labeled as 'additional' as they are not defined inside
> scope of 'properties'. It is mandatory then to mention 'clock' and
> 'clock-names' there if 'additionalProperties: false' .

Yes, which makes additionalProperties a bit fragile and can't be used
if we include a common schema. There's a fix for that coming in
json-schema draft8 called 'unevaluatedProperties'.

> However I had not set it intentionally as there are additional
> properties in some bindings,
> exactly 'iommu' and 'power-domains' are undocumented.
> Is it a good way to put them in 'properties' just to be able to forbid
> additional properties?

Simply put, they should be documented too.

Rob
