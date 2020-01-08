Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8EC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3E2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578493141;
	bh=NpIOj2xv7pDBbKJoDzHTLBryZBvAzAOfx4TGCOim4hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hqU1mzILR75nxCoZ8ljZAu2UJtnEln0zNUvXk38ChHeun6yCVrwy18HJK/U6Sgt/r
	 xc8Hw04ZeZ9moVcSeE0uW8GwryJEgvxTFCAJDUIeCrzaUhsHAKan+sfCcVeJH4JKOh
	 JuVs95s8F0pWhW9/wTztqNbhY0JLfu9Hxa6HwFlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAHOTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:19:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43104 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:18:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so3683677oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1m7+yDcgBUVIUJLMTIa72YR6jFMUNBts53vV9PcOf7o=;
        b=Ct016VU66et72oQAO9UZpyET/jclG4AML2R1xNDzJBzyEWEvWaT98yw37ABa5/RHVx
         NXmBgecxyv8iPCQVVUoerAfFRpbrrgIcz90Z7Nj8LMyXdEK5eyIlShCIrdGEOFtGexz4
         mDB5PAexN8gw9/10PDcywKN6ZsTC3sayDzKo25qvi9WqDloHzKpM7p8B0+H0LYsW05nC
         r5V9oAMJJIklYZYoI3yrGtTWzPihaWcq9CcRjwdxfomBl/QPw7hm0zjCy/VjlhcVuND3
         vKexnp6XtXSANjOQVPTg8stwpAsUr39nYXvr3WhDVfgSK2rlm0h2v2PZTTH7W0+9ZEHD
         5P3A==
X-Gm-Message-State: APjAAAXMts7uoxj2dzn0ylRNZ1dLsrjD9J90QiKg9BDLvWHTtaL4s5lu
        QBX0u0fES3+DocdAHVFWyyECXyA=
X-Google-Smtp-Source: APXvYqxPGgseaGCiHJz3E2KSZmP7kXInNGC5XFerz5gZIfmug6rjlhLo92E3tHyWS/6lqLe/af24wQ==
X-Received: by 2002:a9d:74c4:: with SMTP id a4mr4430984otl.119.1578493137937;
        Wed, 08 Jan 2020 06:18:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m12sm1151111otq.15.2020.01.08.06.18.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:18:57 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22001a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 08:18:55 -0600
Date:   Wed, 8 Jan 2020 08:18:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add YAML schemas for Intel Combo
 phy
Message-ID: <20200108141855.GA14868@bogus>
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:28:27PM +0800, Dilip Kota wrote:
> Combo phy subsystem provides PHY support to number of
> controllers, viz. PCIe, SATA and EMAC.
> Adding YAML schemas for the same.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 147 +++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> new file mode 100644
> index 000000000000..fc9cbad9dd88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Combo phy Subsystem
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +description: |
> +  Intel combo phy subsystem supports PHYs for PCIe, EMAC and SATA
> +  controllers. A single combo phy provides two PHY instances.
> +
> +properties:
> +  $nodename:
> +    pattern: "^combophy@[0-9]+$"
> +
> +  compatible:
> +    items:
> +      - const: intel,combo-phy
> +      - const: simple-bus

This will cause the schema to be applied to every 'simple-bus'. You need 
a custom 'select' to prevent that. There's several examples in the tree.

Though I'm not sure you need child nodes here.

> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Index of Combo phy hardware instance.

Drop this. Not used for FDT.

> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: core
> +
> +  intel,syscfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Chip configuration registers handle
> +
> +  intel,hsio:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: HSIO registers handle
> +
> +  intel,bid:
> +    description: Index of HSIO bus
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 1

If this is related to intel,hsio, just make it an args cell for 
intel,hsio.

> +
> +  intel,cap-pcie-only:
> +    description: |
> +      This flag specifies capability of the combo phy.
> +      If it is set, combo phy has only PCIe capability.
> +      Else it has PCIe, XPCS and SATA PHY capabilities.
> +    type: boolean
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^cb[0-9]phy@[0-9]+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: intel,phydev
> +
> +      "#phy-cells":
> +        const: 0
> +
> +      reg:
> +        description: Offset and size of pcie phy control registers
> +
> +      intel,phy-mode:
> +        description: |
> +          Configure the mode of the PHY.
> +            0 - PCIe
> +            1 - xpcs
> +            2 - sata

PHY mode is normally a cell in the client's phys property. There's 
already common defines for this.

> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 0
> +          - maximum: 2
> +
> +      clocks:
> +        description: |
> +          List of phandle and clock specifier pairs as listed
> +          in clock-names property. Configure the clocks according
> +          to the PHY mode.
> +
> +      resets:
> +        description: |
> +          reset handle according to the PHY mode.
> +          See ../reset/reset.txt for details.
> +
> +    required:
> +      - compatible
> +      - reg
> +      - "#phy-cells"
> +      - clocks
> +      - intel,phy-mode
> +
> +required:
> +  - compatible
> +  - cell-index
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - intel,syscfg
> +  - intel,hsio
> +  - intel,bid
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    combophy@0 {
> +        compatible = "intel,combo-phy", "simple-bus";
> +        cell-index = <0>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        resets = <&rcu0 0x50 6>,
> +        	 <&rcu0 0x50 17>;
> +        reset-names = "phy", "core";
> +        intel,syscfg = <&sysconf>;
> +        intel,hsio = <&hsiol>;
> +        intel,bid = <0>;
> +
> +        cb0phy0:cb0phy@0 {
> +            compatible = "intel,phydev";
> +            #phy-cells = <0>;
> +            reg = <0xd0a40000 0x1000>;
> +            clocks = <&cgu0 1>;
> +            resets = <&rcu0 0x50 23>;
> +            intel,phy-mode = <0>;
> +        };

If you only have 1 child, then you don't need a child node here. Is this 
example complete?

> +    };
> +
> +
> -- 
> 2.11.0
> 
