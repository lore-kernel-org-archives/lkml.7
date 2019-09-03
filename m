Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDABD2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567506870;
	bh=hptEnLPHuH30TwmUN0YADeJBNKeIbZ4C9q8fPG5LnOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EV26qLuv0ibCuqFmTQlAaV/tAquJ5TbD0LROgal4puMq2UYTLKR1j5SrB6qplcCv9
	 z3FSsX7zTuCciLr0lcOy2XP9M3rixtKYLAFF/aJzI7yIIYkK1lvFojSMO8t3Ege+7y
	 YpXwsdCSZp11aAk/W6w0ofUphjo6qANJXdknrGxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfICKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfICKe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:34:29 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F5322D6D;
        Tue,  3 Sep 2019 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567506868;
        bh=hptEnLPHuH30TwmUN0YADeJBNKeIbZ4C9q8fPG5LnOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P8gMUP3mOTh+x/n5rjAdPdIv3JqWqM7gpfd6mKlV+wayBfTlMzcMwJNo2BTDxXyqa
         SdHvfzG9+5poUJXXVDEsJ6hlHJAOZfK3c89sD1ALfTf1mk8b12rF4pxNQTLmM4/VsY
         KLUMd725nc4wCgTfcPx4fqW1nFRqbnBS6pql7pqY=
Received: by mail-qk1-f182.google.com with SMTP id s18so4280761qkj.3;
        Tue, 03 Sep 2019 03:34:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUFPP0S4ccnqxcJX+CfPT3ZnirUXuJKsOTKO+UmY/RxOi+ab5Pl
        SDoH4Hjrvld2jzS4xHSuTeUdayNKwI34slkTFg==
X-Google-Smtp-Source: APXvYqy/wDpCQldglZhQIwwac8erR9ogXJI6jQq+VxbfwZS3PcAb20qYGTM2Kk1Wv4zRF23m6EeaT4rkCagdzKQ0HCg=
X-Received: by 2002:ae9:e212:: with SMTP id c18mr27120739qkc.254.1567506867330;
 Tue, 03 Sep 2019 03:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190902033716.GA18092@bogus> <9f4d6bdd-072a-ab71-1ef1-1d00c22bd064@linux.intel.com>
 <CAL_JsqKm=-5F-Ej1mzRaygJnjS2Lec6uJF4J3vfCnqdkQNNbug@mail.gmail.com> <39d6fe60-e9f5-d205-ec6c-4a3143fe1e13@linux.intel.com>
In-Reply-To: <39d6fe60-e9f5-d205-ec6c-4a3143fe1e13@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Sep 2019 11:34:16 +0100
X-Gmail-Original-Message-ID: <CAL_Jsq+f27t5Wu+qtynDd_O9vBVZFKHCrgCP7WhyGo+W1y-XAA@mail.gmail.com>
Message-ID: <CAL_Jsq+f27t5Wu+qtynDd_O9vBVZFKHCrgCP7WhyGo+W1y-XAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 11:08 AM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Hi Rob,
>
>   Thank you so much for prompt reply.
>
> On 3/9/2019 5:19 PM, Rob Herring wrote:
> > On Tue, Sep 3, 2019 at 2:57 AM Ramuthevar, Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> >> Hi Rob,
> >>
> >> Thank you for review comments.
> >>
> >> On 2/9/2019 9:38 PM, Rob Herring wrote:
> >>> On Wed, Aug 28, 2019 at 08:43:14PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> >>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>>
> >>>> Add a YAML schema to use the host controller driver with the
> >>>> SDXC PHY on Intel's Lightning Mountain SoC.
> >>>>
> >>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>> ---
> >>>>    .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 52 ++++++++++++++++++++++
> >>>>    .../devicetree/bindings/phy/intel,syscon.yaml      | 33 ++++++++++++++
> >>>>    2 files changed, 85 insertions(+)
> >>>>    create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>>>    create mode 100644 Documentation/devicetree/bindings/phy/intel,syscon.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..99647207b414
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>>> @@ -0,0 +1,52 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
> >>>> +
> >>>> +maintainers:
> >>>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>> +
> >>>> +allOf:
> >>>> +  - $ref: "intel,syscon.yaml"
> >>> You don't need this. It should be selected and applied by the compatible
> >>> string matching.
> >> Agreed, fix it in the next patch.
> >>>> +
> >>>> +description: Binding for SDXC PHY
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: intel,lgm-sdxc-phy
> >>>> +
> >>>> +  intel,syscon:
> >>>> +    description: phandle to the sdxc through syscon
> >>>> +
> >>>> +  clocks:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  clock-names:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  "#phy-cells":
> >>>> +    const: 0
> >>>> +
> >>>> +required:
> >>>> +  - "#phy-cells"
> >>>> +  - compatible
> >>>> +  - intel,syscon
> >>>> +  - clocks
> >>>> +  - clock-names
> >>>> +
> >>>> +additionalProperties: false
> >>>> +
> >>>> +examples:
> >>>> +  - |
> >>>> +    sdxc_phy: sdxc_phy {
> >>>> +        compatible = "intel,lgm-sdxc-phy";
> >>>> +        intel,syscon = <&sysconf>;
> >>> Make this a child of the below node and then you don't need this.
> >>>
> >>> If there's a register address range associated with this, then add a reg
> >>> property.
> >> Thanks for comments,  I have defined herewith example
> >>
> >> sysconf: chiptop@e0020000 {
> >>               compatible = "intel,syscon";
> > Needs to be SoC specific value.
> Agreed! it should be "intel, lgm-syscon"
> >>               reg = <0xe0020000 0x100>;
> >>
> >>               emmc_phy: emmc_phy {
> >>                   compatible = "intel,lgm-emmc-phy";
> >>                   intel,syscon = <&sysconf>;
> > This is redundant because you can just get the parent node.
> >
> > If there's a defined register range within the 'intel,syscon' block
> > then define it here with 'reg'.
>
> Agreed!, avoided redundant
>
> sysconf: chiptop@e0020000 {
>              compatible = "intel,lgm-syscon";
>              emmc_phy: emmc_phy {
>                  compatible = "intel,lgm-emmc-phy";
>                  reg = <0xe0020000 0x100>;

This is the same addresses you had for the parent, so that doesn't
seem right. The parent should have the entire range and then the child
nodes only the addresses for their functions. However, if the
registers are all interleaved then you can really put 'reg' in the
child nodes and just have it only in the parent. We don't want to have
overlapping addresses in DT.

Rob
