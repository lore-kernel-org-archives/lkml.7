Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE43BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860182133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560455947;
	bh=dXbU2N6u2O6/521NTZLyOncgS6McSj2lgWl0Kb5bGtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p7jJlq+G4VW3T8/ZvaUmY/4Rt6fpeEQ+nF/nrWliKk+mOg2j9cUFNshebo48cMClt
	 gBYSsr2wYWDnAg+xTWXicKlRSFPm3eW9bLah48HsqafPDqUn8Excuz0L9nyJlQJ8cL
	 ErrjWl/FESJGczOhDokbeaE8L+i1aL3yYk+kZ77E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfFMT7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:59:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34713 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfFMT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:59:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so24066803qtu.1;
        Thu, 13 Jun 2019 12:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mABGHTQ4GLxORx7oxP2Dku+ogME6hgTlBgqCUM3jgVM=;
        b=gZrMvojA/ZEydTjdebiAKmAvpVcdkr/28s5E5+ZvBsZM8oZ9S3iUnBG/xGzBYO1A46
         uvvGPFaSwk5Iq6TtdLADyURX0nYfrSZGJDzSGQhsVUPk4Yv8UVk89o8T0cTASz4JtYFW
         matpzJSqhDH+w7csmZTA5VWGYsbLQRLYfxXfqaQMI6Gp5N8OeAau5/6mkeAYwDMvgwwt
         liCxhsslAwipidCKga2K5cZaNj54Bcj15yDCqWc/4fs8hx/dyWCMWYaQFfZVMWjyV6Fm
         Pjg2lKo5ild9cKNxLnNl6SWhICfieKV/HNriQ/lQozHk2fVUSAilhQmcyeZnKoAFGY+S
         u3nQ==
X-Gm-Message-State: APjAAAWLcFzxMxLxlxIH5V7Yd4hkZ5Jzm8WaZUVVGREWTlhPPm6tDRMi
        g3WNhw+t69XVcvzLTLlzzg==
X-Google-Smtp-Source: APXvYqwyWBDaFVyAkanoZ+1z164tB8nWMUvp9oZM0IcqpT3ialpFjN8XMhTphktzom9B4B87tNVOng==
X-Received: by 2002:aed:218b:: with SMTP id l11mr57399228qtc.66.1560455944697;
        Thu, 13 Jun 2019 12:59:04 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id f20sm233551qkh.15.2019.06.13.12.59.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 12:59:04 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:59:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Johan Hovold <johan@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Michal Simek <monstr@monstr.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Whitten <ben.whitten@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: Add binding for IT6505.
Message-ID: <20190613195903.GA23650@bogus>
References: <1557307985-21228-1-git-send-email-allen.chen@ite.com.tw>
 <1557307985-21228-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557307985-21228-2-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:31:56PM +0800, allen wrote:
> From: Allen Chen <allen.chen@ite.com.tw>
> 
> Add a DT binding documentation for IT6505.
> 
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> 
> ---
>  .../bindings/display/bridge/ite,it6505.txt         | 30 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> new file mode 100644
> index 0000000..c3506ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> @@ -0,0 +1,30 @@
> +iTE it6505 DP bridge bindings
> +
> +Required properties:
> +        - compatible: "ite,it6505"
> +        - reg: i2c address of the bridge
> +        - ovdd-supply: I/O voltage
> +        - pwr18-supply: Core voltage
> +        - interrupts: interrupt specifier of INT pin
> +        - reset-gpios: gpio specifier of RESET pin
> +
> +Example:
> +	it6505dptx: it6505dptx@5c {
> +                compatible = "ite,it6505";
> +                status = "okay";
> +                interrupt-parent = <&pio>;
> +                interrupts = <152 IRQ_TYPE_EDGE_RISING 152 0>;
> +                reg = <0x5c>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&it6505_pins>;
> +                ovdd-supply = <&mt6358_vsim1_reg>;
> +                pwr18-supply = <&it6505_pp18_reg>;
> +                reset-gpios = <&pio 179 1>;
> +                hpd-gpios = <&pio 9 0>;

HPD would be part of the connector, not this bridge chip if a GPIO is 
used.

> +                extcon = <&usbc_extcon>;

This should use the usb-connector binding if this is a Type C connector. 
Or it should have a dp-connector node connection if just a DP connector.


> +                port {
> +                        it6505_in: endpoint {
> +                                remote-endpoint = <&dpi_out>;
> +                        };
> +                };
> +        };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c3fc51..c088646 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -184,6 +184,7 @@ iom	Iomega Corporation
>  isee	ISEE 2007 S.L.
>  isil	Intersil
>  issi	Integrated Silicon Solutions Inc.
> +ite	iTE Tech. Inc.

This file is a schema now, so you'll have to update this.

>  itead	ITEAD Intelligent Systems Co.Ltd
>  iwave  iWave Systems Technologies Pvt. Ltd.
>  jdi	Japan Display Inc.
> -- 
> 1.9.1
> 
