Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9319CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E59C2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566394102;
	bh=i5OSWlioycaF2Znxi7uMbWMmm2fZgjZElmT5IOPeXtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aThMXxqYTplODGboPzEYWCI45mUme26PNcrpQta3G45XloH6mNOKS5RXanze22dQC
	 uQUqKh/j+R5+JCaa3gQjSFCSXt9RUAF27ZwnjuEwgOjyxm/ihONSdhFrxP6bLxQ2cW
	 kXI3RnTtIEfE2W79FEWD7BDr4gSpk07Qk2AwBI5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfHUN2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfHUN2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:28:21 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14E7233A1;
        Wed, 21 Aug 2019 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566394100;
        bh=i5OSWlioycaF2Znxi7uMbWMmm2fZgjZElmT5IOPeXtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t6Xz1n0Nk1LrGg7AltwDRbxtIXhE07BH99OfT01zbaf0tJObd6DQIs69LhFVO90AO
         crMBgjBKafVYM9XboXhg5tIfVvl8nRpUUZH0h3qqq49jJfcPzahiSltdjKB1FObqoi
         DRymR5/HpqHl0CkloXLp2UONEbE5GSDBW9VI1yu8=
Received: by mail-qt1-f180.google.com with SMTP id b11so2958732qtp.10;
        Wed, 21 Aug 2019 06:28:19 -0700 (PDT)
X-Gm-Message-State: APjAAAWBqo+kpBRCp/ybwAVXOIw5mYrv4e7IjQcjEnVXZE/jiRmLkiBZ
        p+nqEKXzwwSUXSNd+a3YXm/WPcPZnfRaAwNIEA==
X-Google-Smtp-Source: APXvYqyZ8fsK6kGZwgr/fYxzi8cJ+hkrMeSsTdRTwMYv70RA5TletRh85GG86B60S3n03t8C6AAOpjBUMIzbxQONMXQ=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr30978115qto.224.1566394099123;
 Wed, 21 Aug 2019 06:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190820195959.6126-1-robh@kernel.org> <20190820195959.6126-2-robh@kernel.org>
 <0ab5959e-fc6c-06c3-a3f1-ea5a1ebef87d@baylibre.com>
In-Reply-To: <0ab5959e-fc6c-06c3-a3f1-ea5a1ebef87d@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Aug 2019 08:28:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=qCVfbKnNK6q_au2PXKcOpZ6584gungRgz7T0oXNFdg@mail.gmail.com>
Message-ID: <CAL_JsqL=qCVfbKnNK6q_au2PXKcOpZ6584gungRgz7T0oXNFdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Convert Arm Mali Midgard GPU to DT schema
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 2:12 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Rob,
>
> On 20/08/2019 21:59, Rob Herring wrote:
> > Convert the Arm Midgard GPU binding to DT schema format.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
> >  .../bindings/gpu/arm,mali-midgard.yaml        | 165 ++++++++++++++++++
> >  2 files changed, 165 insertions(+), 119 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > deleted file mode 100644
> > index 9b298edec5b2..000000000000
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > +++ /dev/null
> > @@ -1,119 +0,0 @@
> > -ARM Mali Midgard GPU
> > -====================
> > -
> > -Required properties:
> > -
> > -- compatible :
> > -  * Must contain one of the following:
> > -    + "arm,mali-t604"
> > -    + "arm,mali-t624"
> > -    + "arm,mali-t628"
> > -    + "arm,mali-t720"
> > -    + "arm,mali-t760"
> > -    + "arm,mali-t820"
> > -    + "arm,mali-t830"
> > -    + "arm,mali-t860"
> > -    + "arm,mali-t880"
> > -  * which must be preceded by one of the following vendor specifics:
> > -    + "allwinner,sun50i-h6-mali"
> > -    + "amlogic,meson-gxm-mali"
> > -    + "samsung,exynos5433-mali"
> > -    + "rockchip,rk3288-mali"
> > -    + "rockchip,rk3399-mali"
> > -
> > -- reg : Physical base address of the device and length of the register area.
> > -
> > -- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
> > -
> > -- interrupt-names : Contains the names of IRQ resources in the order they were
> > -  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
> > -
> > -
> > -Optional properties:
> > -
> > -- clocks : Phandle to clock for the Mali Midgard device.
> > -
> > -- clock-names : Specify the names of the clocks specified in clocks
> > -  when multiple clocks are present.
> > -    * core: clock driving the GPU itself (When only one clock is present,
> > -      assume it's this clock.)
> > -    * bus: bus clock for the GPU
> > -
> > -- mali-supply : Phandle to regulator for the Mali device. Refer to
> > -  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> > -
> > -- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
> > -  for details.
> > -
> > -- #cooling-cells: Refer to Documentation/devicetree/bindings/thermal/thermal.txt
> > -  for details.
> > -
> > -- resets : Phandle of the GPU reset line.
> > -
> > -Vendor-specific bindings
> > -------------------------
> > -
> > -The Mali GPU is integrated very differently from one SoC to
> > -another. In order to accommodate those differences, you have the option
> > -to specify one more vendor-specific compatible, among:
> > -
> > -- "allwinner,sun50i-h6-mali"
> > -  Required properties:
> > -  - clocks : phandles to core and bus clocks
> > -  - clock-names : must contain "core" and "bus"
> > -  - resets: phandle to GPU reset line
> > -
> > -- "amlogic,meson-gxm-mali"
> > -  Required properties:
> > -  - resets : Should contain phandles of :
> > -    + GPU reset line
> > -    + GPU APB glue reset line
> > -
> > -Example for a Mali-T760:
> > -
> > -gpu@ffa30000 {
> > -     compatible = "rockchip,rk3288-mali", "arm,mali-t760";
> > -     reg = <0xffa30000 0x10000>;
> > -     interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > -                  <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > -                  <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > -     interrupt-names = "job", "mmu", "gpu";
> > -     clocks = <&cru ACLK_GPU>;
> > -     mali-supply = <&vdd_gpu>;
> > -     operating-points-v2 = <&gpu_opp_table>;
> > -     power-domains = <&power RK3288_PD_GPU>;
> > -     #cooling-cells = <2>;
> > -};
> > -
> > -gpu_opp_table: opp_table0 {
> > -     compatible = "operating-points-v2";
> > -
> > -     opp@533000000 {
> > -             opp-hz = /bits/ 64 <533000000>;
> > -             opp-microvolt = <1250000>;
> > -     };
> > -     opp@450000000 {
> > -             opp-hz = /bits/ 64 <450000000>;
> > -             opp-microvolt = <1150000>;
> > -     };
> > -     opp@400000000 {
> > -             opp-hz = /bits/ 64 <400000000>;
> > -             opp-microvolt = <1125000>;
> > -     };
> > -     opp@350000000 {
> > -             opp-hz = /bits/ 64 <350000000>;
> > -             opp-microvolt = <1075000>;
> > -     };
> > -     opp@266000000 {
> > -             opp-hz = /bits/ 64 <266000000>;
> > -             opp-microvolt = <1025000>;
> > -     };
> > -     opp@160000000 {
> > -             opp-hz = /bits/ 64 <160000000>;
> > -             opp-microvolt = <925000>;
> > -     };
> > -     opp@100000000 {
> > -             opp-hz = /bits/ 64 <100000000>;
> > -             opp-microvolt = <912500>;
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> > new file mode 100644
> > index 000000000000..24c4af74fb8d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> > @@ -0,0 +1,165 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpu/arm,mali-midgard.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM Mali Midgard GPU
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^gpu@[a-f0-9]+$'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +             - allwinner,sun50i-h6-mali
> > +          - const: arm,mali-t720
> > +      - items:
> > +          - enum:
> > +             - amlogic,meson-gxm-mali
> > +          - const: arm,mali-t820
> > +      - items:
> > +          - enum:
> > +             - rockchip,rk3288-mali
> > +          - const: arm,mali-t760
> > +      - items:
> > +          - enum:
> > +             - rockchip,rk3399-mali
> > +          - const: arm,mali-t860
> > +      - items:
> > +          - enum:
> > +             - samsung,exynos5433-mali
> > +          - const: arm,mali-t760
> > +
> > +          # "arm,mali-t604"
> > +          # "arm,mali-t624"
> > +          # "arm,mali-t628"
> > +          # "arm,mali-t830"
> > +          # "arm,mali-t880"
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Job interrupt
> > +      - description: MMU interrupt
> > +      - description: GPU interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: job
> > +      - const: mmu
> > +      - const: gpu
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: core
> > +      - const: bus
> > +
> > +  mali-supply:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  operating-points-v2: true
> > +
> > +  "#cooling-cells":
> > +    const: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun50i-h6-mali
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> > +      required:
> > +        - clocks
> > +        - clock-names
> > +        - resets
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: amlogic,meson-gxm-mali
> > +    then:
> > +      properties:
> > +        resets:
> > +          minItems: 2
> > +      required:
> > +        - resets
>
> The original bindings was wrong, In fact, clocks should be required here aswell.
> Same for bifrost and utgard...
>
> Should I send a fixup patch ?

I think we should just make clocks required. I can't imagine anyone
not using the clock binding.

Rob
