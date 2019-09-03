Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DBBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B86D20882
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567546486;
	bh=IdpXtRd5jnnabchBibkUQDBUCSG/a18Xwl3/yBrVel8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rQnnRrqDnttPHCm7TOXEw5/SWneAC/+SG7rEMTvbfgCgBBeQ/SDDCjX7894BHSvyX
	 EeLGeRHng+i5oNQgvv+pEyK7jFJbJtDENPDzhje/+JSy+3xYoq0TviuNiuH0TvN1e+
	 6UvWasoVEcN0MsVDtcozb1sB412mgA20P8k9aZjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfICVep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfICVep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:34:45 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D09A21883;
        Tue,  3 Sep 2019 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567546483;
        bh=IdpXtRd5jnnabchBibkUQDBUCSG/a18Xwl3/yBrVel8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WzWWzP85nHHKwuggzWchFOkTMXqOO0RyCdrGl7RslwGrff+1pR9Hc6QCMxQIbtq7K
         zX6xqeUhLi0DavTsOnapu2h1D9pDDZ4WDol/aKhW7R7DUnL0paytPSX5/KboUmgajs
         kk6/5G9AxPZwE+8lwjQLQawMetmoTZYb7v77zkIs=
Received: by mail-qk1-f173.google.com with SMTP id z67so4688491qkb.12;
        Tue, 03 Sep 2019 14:34:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWGq2f1m8aRJtlbg6v+oB1EKLPejiH6HYjShEq5zJUjUGvHWxzy
        DR+K2WskiVBwHEWzrIRVDz9+wf0e6KXrtnmtTA==
X-Google-Smtp-Source: APXvYqwfWtLMLuUirpm5Fe/VrL/zxWY6EJ7L09TAZqvtOumPKowkC/c2waSeuZDr1xTl6zWbyy4AndR/Xub+a3vwZB8=
X-Received: by 2002:a37:682:: with SMTP id 124mr35364550qkg.393.1567546482644;
 Tue, 03 Sep 2019 14:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190902033716.GA18092@bogus> <9f4d6bdd-072a-ab71-1ef1-1d00c22bd064@linux.intel.com>
 <CAL_JsqKm=-5F-Ej1mzRaygJnjS2Lec6uJF4J3vfCnqdkQNNbug@mail.gmail.com>
 <39d6fe60-e9f5-d205-ec6c-4a3143fe1e13@linux.intel.com> <CAL_Jsq+f27t5Wu+qtynDd_O9vBVZFKHCrgCP7WhyGo+W1y-XAA@mail.gmail.com>
 <a7aa3ae0-b8b6-5199-468f-f282fdff15cf@linux.intel.com>
In-Reply-To: <a7aa3ae0-b8b6-5199-468f-f282fdff15cf@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Sep 2019 22:34:30 +0100
X-Gmail-Original-Message-ID: <CAL_Jsq++P6_Pv2GnuwHm50asE+-xtiQG-kioNzHuF7XbseukaA@mail.gmail.com>
Message-ID: <CAL_Jsq++P6_Pv2GnuwHm50asE+-xtiQG-kioNzHuF7XbseukaA@mail.gmail.com>
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

On Tue, Sep 3, 2019 at 11:52 AM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Hi Rob,
>
>     Thank you for your suggestions and clarifications.
>
> On 3/9/2019 6:34 PM, Rob Herring wrote:
> > On Tue, Sep 3, 2019 at 11:08 AM Ramuthevar, Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> >> Hi Rob,
> >>
> >>    Thank you so much for prompt reply.
> >>
> >> On 3/9/2019 5:19 PM, Rob Herring wrote:
> >>> On Tue, Sep 3, 2019 at 2:57 AM Ramuthevar, Vadivel MuruganX
> >>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> >>>> Hi Rob,
> >>>>
> >>>> Thank you for review comments.
> >>>>
> >>>> On 2/9/2019 9:38 PM, Rob Herring wrote:
> >>>>> On Wed, Aug 28, 2019 at 08:43:14PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> >>>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>>>>
> >>>>>> Add a YAML schema to use the host controller driver with the
> >>>>>> SDXC PHY on Intel's Lightning Mountain SoC.
> >>>>>>
> >>>>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>>>> ---
> >>>>>>     .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 52 ++++++++++++++++++++++
> >>>>>>     .../devicetree/bindings/phy/intel,syscon.yaml      | 33 ++++++++++++++
> >>>>>>     2 files changed, 85 insertions(+)
> >>>>>>     create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>>>>>     create mode 100644 Documentation/devicetree/bindings/phy/intel,syscon.yaml
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..99647207b414
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>>>>> @@ -0,0 +1,52 @@
> >>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>>> +%YAML 1.2
> >>>>>> +---
> >>>>>> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
> >>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>> +
> >>>>>> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
> >>>>>> +
> >>>>>> +maintainers:
> >>>>>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>>>> +
> >>>>>> +allOf:
> >>>>>> +  - $ref: "intel,syscon.yaml"
> >>>>> You don't need this. It should be selected and applied by the compatible
> >>>>> string matching.
> >>>> Agreed, fix it in the next patch.
> >>>>>> +
> >>>>>> +description: Binding for SDXC PHY
> >>>>>> +
> >>>>>> +properties:
> >>>>>> +  compatible:
> >>>>>> +    const: intel,lgm-sdxc-phy
> >>>>>> +
> >>>>>> +  intel,syscon:
> >>>>>> +    description: phandle to the sdxc through syscon
> >>>>>> +
> >>>>>> +  clocks:
> >>>>>> +    maxItems: 1
> >>>>>> +
> >>>>>> +  clock-names:
> >>>>>> +    maxItems: 1
> >>>>>> +
> >>>>>> +  "#phy-cells":
> >>>>>> +    const: 0
> >>>>>> +
> >>>>>> +required:
> >>>>>> +  - "#phy-cells"
> >>>>>> +  - compatible
> >>>>>> +  - intel,syscon
> >>>>>> +  - clocks
> >>>>>> +  - clock-names
> >>>>>> +
> >>>>>> +additionalProperties: false
> >>>>>> +
> >>>>>> +examples:
> >>>>>> +  - |
> >>>>>> +    sdxc_phy: sdxc_phy {
> >>>>>> +        compatible = "intel,lgm-sdxc-phy";
> >>>>>> +        intel,syscon = <&sysconf>;
> >>>>> Make this a child of the below node and then you don't need this.
> >>>>>
> >>>>> If there's a register address range associated with this, then add a reg
> >>>>> property.
> >>>> Thanks for comments,  I have defined herewith example
> >>>>
> >>>> sysconf: chiptop@e0020000 {
> >>>>                compatible = "intel,syscon";
> >>> Needs to be SoC specific value.
> >> Agreed! it should be "intel, lgm-syscon"
> >>>>                reg = <0xe0020000 0x100>;
> >>>>
> >>>>                emmc_phy: emmc_phy {
> >>>>                    compatible = "intel,lgm-emmc-phy";
> >>>>                    intel,syscon = <&sysconf>;
> >>> This is redundant because you can just get the parent node.
> >>>
> >>> If there's a defined register range within the 'intel,syscon' block
> >>> then define it here with 'reg'.
> >> Agreed!, avoided redundant
> >>
> >> sysconf: chiptop@e0020000 {
> >>               compatible = "intel,lgm-syscon";
> >>               emmc_phy: emmc_phy {
> >>                   compatible = "intel,lgm-emmc-phy";
> >>                   reg = <0xe0020000 0x100>;
> > This is the same addresses you had for the parent, so that doesn't
> > seem right. The parent should have the entire range and then the child
> > nodes only the addresses for their functions. However, if the
> > registers are all interleaved then you can really put 'reg' in the
> > child nodes and just have it only in the parent. We don't want to have
> > overlapping addresses in DT.
> syscon is parent node, which has the base address for all the peripheral
> registers and used by child nodes.
> child nodes have only offsets, we do not specify in device tree.

Right, and I'm asking you to add the offsets whether Linux uses them or not.

Rob
