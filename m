Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B81C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F4024679
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576710282;
	bh=45HEpsQaodbLeIzLWZeTebdOakvhshmN/JIrCIvrOBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XUCZojE9myDlacdhNqryjL6/JDYn1HztvuSPWLgOlyi4nEJmaG357YRNrRQ2HdXoe
	 TDP3MyU+SS5zbemiY7stnEjVOJfLvovjQzerENAbyTya7hfu9o1r2Ngyrqg3FZjMz7
	 8GZOv4CGNlUfAl//pCAeB6qJ8eZ33Stvd2k9h7z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLRXEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRXEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:04:41 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 286402465E;
        Wed, 18 Dec 2019 23:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576710280;
        bh=45HEpsQaodbLeIzLWZeTebdOakvhshmN/JIrCIvrOBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1lPq+RnDhwzZ1n2Nbhb1zoeP1ubhK1q1LCpAzxqS/kki98ps317516LWRvOVo9qRP
         ZO9RqMJQjyc69vyiqJR1OmNOf+nWagvb6eQTbsDwuRW+U+6sR0hOHpPWDCo3Lq4xaw
         ut5skZ/ftwQqX5RrSEyMl2Lg3aPeOe1yI/MgYIjI=
Received: by mail-qt1-f169.google.com with SMTP id 38so3344306qtb.13;
        Wed, 18 Dec 2019 15:04:40 -0800 (PST)
X-Gm-Message-State: APjAAAUlB/adz6HqLM4CzIwwkZ4ooET1jtx+Nr5r55s4SN7fpZTfs3VW
        Q4n1F3quBcIzM7BQgmktiSZEFttBSBxOuYsAwQ==
X-Google-Smtp-Source: APXvYqxOHwJ6E5OVcoiMVSDDC+gN133m0yHx4YjhwS403ykPScEzWD40cqDw4Jl4/Bim36YFYtTqn8b4KIXzWgJS3f8=
X-Received: by 2002:ac8:59:: with SMTP id i25mr4613283qtg.110.1576710279250;
 Wed, 18 Dec 2019 15:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20191218142455.13542-1-benjamin.gaignard@st.com>
In-Reply-To: <20191218142455.13542-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Dec 2019 17:04:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhahGyk67U9zg1uqticD36aRc5TQQUU0aGb3D7KuMTcg@mail.gmail.com>
Message-ID: <CAL_JsqLhahGyk67U9zg1uqticD36aRc5TQQUU0aGb3D7KuMTcg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: Convert DWC2 bindings to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 8:25 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert DWC2 bindings to DT schema format using json-schema.
> DWC2 is widely use but a couple of compatibles and properties
> (vusb_d-supply,vusb_a-supply) were missing in dwc2.txt, the
> patch add them.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> Notes:
>  I have put Greg Kroah-Hartman has maintainer of this file
>  because it was the first entry when calling get_maintainers.pl
>  on dwc2.txt. All my apologies if that is an incorrect guess,
>  raise your hands if you know who should be the maintainer(s)
>  for this file.

DWC2 driver maintainer? Someone in ST that knows this h/w? Otherwise,
you can put me if no one else.

>  Documentation/devicetree/bindings/usb/dwc2.txt  |  64 ---------
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 178 ++++++++++++++++++++++++
>  2 files changed, 178 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/dwc2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc2.yaml


> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> new file mode 100644
> index 000000000000..2c11626e3bc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/dwc2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare HS OTG USB 2.0 controller Bindings
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: brcm,bcm2835-usb
> +        description: The DWC2 USB controller instance in the BCM2835 SoC

I think it's a bit easier to read if the description is first.
Personally, I find the description a bit redundant and would just drop
it.

> +      - const: hisilicon,hi6220-usb
> +        description: The DWC2 USB controller instance in the hi6220 SoC
> +      - items:
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the rk3066 Soc
> +      - items:
> +          - const: rockchip,px30-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the px30 Soc
> +      - items:
> +          - const: rockchip,rk3036-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the rk3036 Soc
> +      - items:
> +          - const: rockchip,rv1108-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the rv1108 Soc
> +      - items:
> +          - const: rockchip,rk3188-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the rk3188 Soc
> +      - items:
> +          - const: rockchip,rk3228-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the rk3228 Soc
> +      - items:
> +          - const: rockchip,rk3288-usb
> +          - const: rockchip,rk3066-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in the rk3288 Soc
> +      - const: lantiq,arx100-usb
> +        description: The DWC2 USB controller instance in Lantiq ARX SoCs
> +      - const: lantiq,xrx200-usb
> +        description: The DWC2 USB controller instance in Lantiq XRX SoCs
> +      - items:
> +          - const: amlogic,meson8-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in Amlogic Meson8 SoCs
> +      - items:
> +          - const: amlogic,meson8b-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in Amlogic Meson8b SoCs
> +      - const: amlogic,meson-gxbb-usb
> +        description: The DWC2 USB controller instance in Amlogic S905 SoCs
> +      - items:
> +          - const: amlogic,meson-g12a-usb
> +          - const: snps,dwc2
> +        description: The DWC2 USB controller instance in Amlogic G12A SoCs
> +      - const: amcc,dwc-otg
> +        description: The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs
> +      - const: snps,dwc2
> +        description: generic DWC2 USB controller with default parameters
> +      - const: st,stm32f4x9-fsotg
> +        description: The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs configured in FS mode
> +      - const: st,stm32f4x9-hsotg
> +        description: The DWC2 USB HS controller instance in STM32F4x9 SoCs configured in HS mode
> +      - const: st,stm32f7-hsotg
> +        description: The DWC2 USB HS controller instance in STM32F7 SoCs configured in HS mode
> +      - items:
> +          - const: samsung,s3c6400-hsotg
> +          - const: snps,dwc2
> +        minItems: 1

This seems like something to fix in dts files rather than work-around.
Pick whichever one gives fewer errors.

> +        description: The DWC2 USB controller instance in the exynos3250 Soc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: otg
> +
> +  resets:
> +    items:
> +     - description: common reset
> +     - description: ecc reset
> +    minItems: 1
> +
> +  reset-names:
> +    items:
> +     - const: dwc2
> +     - const: dwc2-ecc
> +    minItems: 1
> +
> +  phys:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Standard prop, can drop.

> +    description: phy provider specifier

That's all 'phys'. Drop.

> +    maxItems: 1
> +
> +  phy-names:
> +    const: usb2-phy
> +
> +  vbus-supply:
> +    description: reference to the VBUS regulator. Depending on the current mode
> +      this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
> +      regulator is updated if the controller is configured in "otg" mode and the
> +      status changes between "host" and "peripheral".
> +
> +  vusb_d-supply:
> +    description: phandle to voltage regulator of digital section,
> +
> +  vusb_a-supply:
> +    description: phandle to voltage regulator of analog section.
> +
> +  dr_mode:
> +    enum: [host, peripheral, otg]
> +
> +  g-rx-fifo-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size of rx fifo size in gadget mode.
> +
> +  g-np-tx-fifo-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size of non-periodic tx fifo size in gadget mode.
> +
> +  g-tx-fifo-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
> +
> +  snps,need-phy-for-wake:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If present indicates that the phy needs to be left on for remote wakeup during suspend.
> +
> +  snps,reset-phy-on-wake:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If present indicates that we need to reset the PHY when we detect a wakeup.
> +                 This is due to a hardware errata.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      usb@101c0000 {
> +        compatible = "ralink,rt3050-usb, snps,dwc2";
> +        reg = <0x101c0000 40000>;
> +        interrupts = <18>;
> +        clocks = <&usb_otg_ahb_clk>;
> +        clock-names = "otg";
> +        phys = <&usbphy>;
> +        phy-names = "usb2-phy";
> +        snps,need-phy-for-wake;
> +      };
> +
> +...
> --
> 2.15.0
>
