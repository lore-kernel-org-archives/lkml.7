Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D77C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90733206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573694417;
	bh=zDO9Js3j0YNxL31th55daw42XoRTkC6MaVj3ds3HBdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eA81ZB9/2Gb+N9smtwuFfs7DcPQUiBoKkGTs0h2j2SpUNwGuPpzdl+dtFsKHVlSAp
	 bPgnUHatjK8hoYbfxo25rWi1DdnoSFUZoOoyeb5BVKIxyEJ6kVI1NUIvMDuizt6i07
	 9lpJAwEYYQgfTR8GMk3FVogs3aXdgRHUNC3x1DUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKNBUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:20:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45971 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKNBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:20:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so3700986oir.12;
        Wed, 13 Nov 2019 17:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/K5jnJYkn2AvQdcmqwZlI7+QyjIXXZrWLvpnHt8x5XA=;
        b=Tz+FxUkH6xMvUTga8czsWe7dnoNSyGaqJQaQAvFpCcCpW089RkVPcUkw7mCi/JyvUK
         BafSuMyw8HRn5opofA4FBSKJsHODtxr6aB4SIQ4IKTZfePfqgQD8RO8o56AI1YhQqewh
         2qBuSie0h1kIAK6Q5J4LoFQ+5WELIaRcsAZyL5ggktr8H76NcC7wcnraGzaCfdRjiVIz
         nmFLiq0mxM4GjmIjUJ5KJB+fZX/levNczpjqmMgAq4RNalnaWirqUXXY+ZhGUVmb+D+a
         K17DkQzWlzdqKuMlWlRuXXiNuClbdVyWQB0xR6usWkOnmkLuUqiXmQMi8HV22MXj/LAo
         K86A==
X-Gm-Message-State: APjAAAWnRgIKuiNtjB1ip8TZ7Eto/BKRiPQaCVZgEKqN5IGuPFs3NP+r
        xZz3/LCpCRuoGLCJ8Dd9Iw==
X-Google-Smtp-Source: APXvYqyEIOl8lwb4tjxfJzJO7GYF8YSZw8Qlvayg5mTnoyRtLO6AIrgKiwBF/MtTFld693lhmoQU9A==
X-Received: by 2002:aca:a8d4:: with SMTP id r203mr1428225oie.12.1573694414787;
        Wed, 13 Nov 2019 17:20:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm1267887oie.37.2019.11.13.17.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:20:14 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:20:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH 06/13] dt-bindings: Add Broadcom STB USB PHY binding
 document
Message-ID: <20191114012013.GA25050@bogus>
References: <20191107141339.6079-1-alcooperx@gmail.com>
 <20191107141339.6079-7-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107141339.6079-7-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:13:32AM -0500, Al Cooper wrote:
> Add support for bcm7216 and bcm7211
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     | 69 +++++++++++++++----
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> index 24a0d06acd1d..14184cec15dc 100644
> --- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> @@ -1,30 +1,49 @@
>  Broadcom STB USB PHY
>  
>  Required properties:
> - - compatible: brcm,brcmstb-usb-phy
> - - reg: two offset and length pairs.
> -	The first pair specifies a manditory set of memory mapped
> -	registers used for general control of the PHY.
> -	The second pair specifies optional registers used by some of
> -	the SoCs that support USB 3.x
> - - #phy-cells: Shall be 1 as it expects one argument for setting
> -	       the type of the PHY. Possible values are:
> -	       - PHY_TYPE_USB2 for USB1.1/2.0 PHY
> -	       - PHY_TYPE_USB3 for USB3.x PHY
> +- compatible: should be one of
> +	"brcm,brcmstb-usb-phy"
> +	"brcm,bcm7216-usb-phy"
> +	"brcm,bcm7211-usb-phy"
> +
> +- reg and reg-names properties requirements are specific to the
> +  compatible string.
> +  "brcm,brcmstb-usb-phy":
> +    - reg: 1 or 2 offset and length pairs. One for the base CTRL registers
> +           and an optional pair for systems with USB 3.x support
> +    - reg-names: not specified
> +  "brcm,bcm7216-usb-phy":
> +    - reg: 3 offset and length pairs for CTRL, XHCI_EC and XHCI_GBL
> +           registers
> +    - reg-names: "ctrl", "xhci_ec", "xhci_gbl"
> +  "brcm,bcm7211-usb-phy":
> +    - reg: 5 offset and length pairs for CTRL, XHCI_EC, XHCI_GBL,
> +           USB_PHY and USB_MDIO registers and an optional pair
> +	   for the BDC registers
> +    - reg-names: "ctrl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
> +
> +- #phy-cells: Shall be 1 as it expects one argument for setting
> +	      the type of the PHY. Possible values are:
> +	      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
> +	      - PHY_TYPE_USB3 for USB3.x PHY
>  
>  Optional Properties:
>  - clocks : clock phandles.
>  - clock-names: String, clock name.
> +- interrupts: wake interrupt
> +- interrupt-names: "wake"

If a wakeup source, the standard name is 'wakeup'.

>  - brcm,ipp: Boolean, Invert Port Power.
>    Possible values are: 0 (Don't invert), 1 (Invert)
>  - brcm,ioc: Boolean, Invert Over Current detection.
>    Possible values are: 0 (Don't invert), 1 (Invert)
> -NOTE: one or both of the following two properties must be set
> -- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
> -- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
>  - dr_mode: String, PHY Device mode.
>    Possible values are: "host", "peripheral ", "drd" or "typec-pd"
>    If this property is not defined, the phy will default to "host" mode.
> +- syscon-piarbctl: phandle to syscon for handling config registers

Needs vendor prefix.

> +NOTE: one or both of the following two properties must be set
> +- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
> +- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
> +
>  
>  Example:
>  
> @@ -41,3 +60,27 @@ usbphy_0: usb-phy@f0470200 {
>  	clocks = <&usb20>, <&usb30>;
>  	clock-names = "sw_usb", "sw_usb3";
>  };
> +
> +usb-phy@29f0200 {
> +	reg = <0x29f0200 0x200>,
> +		<0x29c0880 0x30>,
> +		<0x29cc100 0x534>,
> +		<0x2808000 0x24>,
> +		<0x2980080 0x8>;
> +	reg-names = "ctrl",
> +		"xhci_ec",
> +		"xhci_gbl",
> +		"usb_phy",
> +		"usb_mdio";
> +	brcm,ioc = <0x0>;
> +	brcm,ipp = <0x0>;
> +	compatible = "brcm,bcm7211-usb-phy";
> +	interrupts = <0x30>;
> +	interrupt-parent = <&vpu_intr1_nosec_intc>;
> +	interrupt-names = "wake";
> +	#phy-cells = <0x1>;
> +	brcm,has-xhci;
> +	syscon-piarbctl = <&syscon_piarbctl>;
> +	clocks = <&scmi_clk 256>;
> +	clock-names = "sw_usb";
> +};
> -- 
> 2.17.1
> 
