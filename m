Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7DDC7E0AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9CF24765
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269641;
	bh=4nHhAEX/vIi5LtzUJGrntF0L92HvYbc+cO8DA69TbUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ljupeXpKR4LdxbMHz3DhjCq0abafkWfa/KjjVBtyuayqDaOH09yjLh4gDcZblQifK
	 K0vd6e/JNqWR/87gGLvGHIWsSDr+zIJaUFmaHT71c9lP2JVkTr2Zks6PCUkB7OHOt6
	 1RXa2AqVZ55WOmFjNVgUCgXWpEezVhkClUOEFhoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfLMSpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:45:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37836 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfLMSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:45:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so248646otn.4;
        Fri, 13 Dec 2019 10:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n1wf2eteVGZXSC7Mqgl066hg7LQBWqUPacG1DYCVzng=;
        b=rY3BjVRYql7heo4jgbf7WiKQ8iIFH2cjqf37x8yoENRzioFr0JqkmOgRMGW8Njy5Az
         yJ6ljDJB6oJKY7mtsM00X9YYY/RwM9QOOgmqGezEXiCR4uUhBhhs2k3uKkqPoJzqHDs/
         6up91XcMJLhdb9dU7iFtsK0XWphf93T9G3+xfzu3AvuqNshTwjBj+RrOZmj0htspQuH/
         sHqmTCKlcoYWHI8R7SVRmxWw9j5tlFQEMj0VmfFsUzATahfDTLbEcisN4PKF5NIkSN30
         vyzHB6o6yrB0U9usU2phjD+mjDrFDxgwp2Yv7+timRttaBbmFw7WB90zzkgfYm6HOehw
         jRPA==
X-Gm-Message-State: APjAAAVw0uxh08AW7Ud27d0zp09MNo+wpUJhZkK5ZpzYdlheeJPRHRai
        qCtvpWSonEH+14hPRAUpTw==
X-Google-Smtp-Source: APXvYqw02K+Xpj85k8Pc/wTfISnwbcstHJKooxWFlJZLRYP8uQDgJJs9UuhmkvC1AW9kRTIB0iWUeQ==
X-Received: by 2002:a05:6830:1e37:: with SMTP id t23mr16377291otr.16.1576262753566;
        Fri, 13 Dec 2019 10:45:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u192sm3578273oia.41.2019.12.13.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:45:52 -0800 (PST)
Date:   Fri, 13 Dec 2019 12:45:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mark.rutland@arm.com, kishon@ti.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] dt-bindings: usb: Add NVIDIA Tegra XUSB device
 mode controller binding
Message-ID: <20191213184552.GA2133@bogus>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-3-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575629421-7039-3-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:20:05PM +0530, Nagarjuna Kristam wrote:
> Add device-tree binding documentation for the XUSB device mode controller
> present on Tegra210 and Tegra186 SoC. This controller supports the USB 3.0
> specification.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---

Next time version your patches correctly and include version history 
here so I don't have to go look up why my R-by is missing.

>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 204 +++++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
> new file mode 100644
> index 0000000..b23c451
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
> @@ -0,0 +1,204 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Device tree binding for NVIDIA Tegra XUSB device mode controller (XUDC)
> +
> +description:
> +  The Tegra XUDC controller supports both USB 2.0 HighSpeed/FullSpeed and
> +  USB 3.0 SuperSpeed protocols.
> +
> +maintainers:
> +  - Nagarjuna Kristam <nkristam@nvidia.com>
> +  - JC Kuo <jckuo@nvidia.com>
> +  - Thierry Reding <treding@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: nvidia,tegra210-xudc # For Tegra210
> +      - items:
> +        - const: nvidia,tegra186-xudc # For Tegra186

Use 'enum' instead of oneOf+const.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: Must contain the XUSB device interrupt.

Don't need a description for a single interrupt line.

> +
> +  power-domains:
> +    maxItems: 2
> +    description:
> +      A list of PM domain specifiers that reference each power-domain
> +      used by the XUSB device mode controller. This list must comprise of a
> +      specifier for the XUSBA and XUSBB power-domains.
> +      See ../power/power_domain.txt and ../arm/tegra/nvidia,tegra20-pmc.txt
> +      for details.

Just need:

items:
  - description: XUSBA power-domain
  - description: XUSBB power-domain

> +
> +  power-domains-names:
> +    maxItems: 2
> +    description:
> +       A list of names that represent each of the specifiers in
> +       the 'power-domains' property.

That's every 'power-domains-names'.

> +    items:
> +      - const: ss
> +      - const: dev

Okay, but those names don't match up with XUSBA and XUSBB. Names should 
be meaningful or local to the module, not the provider if that helps.

> +
> +  nvidia,xusb-padctl:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      phandle to the XUSB pad controller that is used to configure the USB pads
> +      used by the XUDC controller.
> +
> +  phys:
> +    minItems: 1
> +    description:
> +      Must contain an entry for each entry in phy-names.
> +      See ../phy/phy-bindings.txt for details.
> +
> +  phy-names:
> +    minItems: 1
> +    items:
> +      - const: usb2-0
> +      - const: usb2-1
> +      - const: usb2-2
> +      - const: usb2-3
> +      - const: usb3-0
> +      - const: usb3-1
> +      - const: usb3-2
> +      - const: usb3-3
> +
> +  avddio-usb-supply:
> +    description: PCIe/USB3 analog logic power supply. Must supply 1.05 V.
> +
> +  hvdd-usb-supply:
> +    description: USB controller power supply. Must supply 3.3 V.
> +
> +required:
> +  - compatible
> +  - power-domains
> +  - power-domain-names
> +  - nvidia,xusb-padctl
> +  - phys
> +  - phy-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            const: nvidia,tegra210-xudc
> +
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 3
> +          items:
> +          - description: XUSB device controller registers
> +          - description: XUSB device PCI Config registers
> +          - description: XUSB device registers.
> +        reg-names:
> +          maxItems: 3
> +          items:
> +            - const: base
> +            - const: fpci
> +            - const: ipfs

As these are a superset of tegra186, you can move this up and tegra186 
just needs to define 'maxItems: 2'.

> +        clocks:
> +          description:
> +            Must contain an entry for all clocks used. See ../clock/clock-bindings.txt
> +            for details.
> +          maxItems: 5
> +          items:
> +            - description: Clock to enable core XUSB dev clock.
> +            - description: Clock to enable XUSB super speed clock.
> +            - description: Clock to enable XUSB super speed dev clock.
> +            - description: Clock to enable XUSB high speed dev clock.
> +            - description: Clock to enable XUSB full speed dev clock.
> +        clock-names:
> +          items:
> +           - const: dev
> +           - const: ss
> +           - const: ss_src
> +           - const: hs_src
> +           - const: fs_src

I would re-order the last 2 entries so that you can do the same thing as 
I said for 'reg'.

> +      required:
> +        - reg
> +        - reg-names
> +        - clocks
> +        - clock-names

No need for these to be under the if. They are always required and 
don't have to be where defined by 'properties'.

> +        - avddio-usb-supply
> +        - hvdd-usb-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra186-xudc
> +
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +          items:
> +          - description: XUSB device controller registers
> +          - description: XUSB device PCI Config registers
> +        reg-names:
> +          maxItems: 2
> +          items:
> +            - const: base
> +            - const: fpci
> +        clocks:
> +          description:
> +            Must contain an entry for all clocks used. See ../clock/clock-bindings.txt
> +            for details.
> +          maxItems: 4
> +          items:
> +            - description: Clock to enable core XUSB dev clock.
> +            - description: Clock to enable XUSB super speed clock.
> +            - description: Clock to enable XUSB super speed dev clock.
> +            - description: Clock to enable XUSB full speed dev clock.
> +        clock-names:
> +          items:
> +           - const: dev
> +           - const: ss
> +           - const: ss_src
> +           - const: fs_src
> +      required:
> +        - reg
> +        - reg-names
> +        - clocks
> +        - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/gpio/tegra-gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    usb@700d0000 {
> +        compatible = "nvidia,tegra210-xudc";
> +        reg = <0x0 0x700d0000 0x0 0x8000>,
> +              <0x0 0x700d8000 0x0 0x1000>,
> +              <0x0 0x700d9000 0x0 0x1000>;
> +        reg-names = "base", "fpci", "ipfs";
> +
> +        interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>,
> +                 <&tegra_car TEGRA210_CLK_XUSB_SS>,
> +                 <&tegra_car TEGRA210_CLK_XUSB_SSP_SRC>,
> +                 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>,
> +                 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>;
> +        clock-names = "dev", "ss", "ss_src", "hs_src", "fs_src";
> +
> +        power-domains = <&pd_xusbdev>, <&pd_xusbss>;
> +        power-domain-names = "dev", "ss";
> +
> +        nvidia,xusb-padctl = <&padctl>;
> +
> +        phys = <&micro_b>;
> +        phy-names = "usb2-0";
> +
> +        avddio-usb-supply = <&vdd_pex_1v05>;
> +        hvdd-usb-supply = <&vdd_3v3_sys>;
> +    };
> -- 
> 2.7.4
> 
