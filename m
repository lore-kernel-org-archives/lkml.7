Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F7DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC612146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576687062;
	bh=8xxCNkUAzdSt8PiRdIANE3nzYQlFBne3CgEGOdfz7aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=huZHXsUWWkt/wcTP5JfQucJyAPtafvwlLSz5WuNl9AFVfeIZNK1C2SScP4DnByDhZ
	 TGWTaE3bw53/0MWAKC4Amf0Kfeq9THdTi+kvM7YkBNqI5oRmLVs3jhFY8+rRkBQRll
	 FFbiDgh8Sffz9Enm9bJbC5ONtC+f0le3fGtGcoVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLRQhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:37:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45952 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:37:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id v10so1304558oiv.12;
        Wed, 18 Dec 2019 08:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=potQJchvmkXdyjD8+YEbMuOtyx2Cyf8SplihkzOTltg=;
        b=lUkD6SulvgBo0F8+PeOoo3Oe57ZQEagEKAKHgYq8mqtqxg09p1rVlgfZz+62gdInC7
         xe68d6ahuSli/D+UnQkWMuCYmSnJT6/9lMxPWDiYapDu73Nsma+WUnaXB0zpRAb6vjMR
         CyRKC6V1fmObWZzAtz4G18RQAAli51UfXx1Sexpo5X93x3VUldmXsojUYBZ35eqV0Vsr
         9nUymwQPHKuGII+yqM50LDnVxjzd+9WPyd3Fo/hQGtImWnn7kyRGAMPv5TUCfjQjCdO/
         eNFSkJBz/+JIvfhDsoWp5PACG18VHUmsrUb89oPcf4wPzEdc5+ESmAt28Akubb7+tko3
         yKAg==
X-Gm-Message-State: APjAAAViD1hiOObEZAtF9aEgYsNNXt2MhvZ82s3lYe5gP0/KRy5E1VbO
        NvIez2xMvs/MKLo4zD+Dsw==
X-Google-Smtp-Source: APXvYqzZOHq9Lp+vs+GL43uPxqZ8cytoIKEEyfyzpRoxn+Fxpe72rj241gvyIDghUD3LuIy2xaZBrQ==
X-Received: by 2002:aca:ec4d:: with SMTP id k74mr857882oih.64.1576687059959;
        Wed, 18 Dec 2019 08:37:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o101sm950158ota.69.2019.12.18.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:37:39 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:37:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 7/8] dt-bindings: misc: Add bindings for HiSilicon usb
 hub and data role switch functionality on HiKey960
Message-ID: <20191218163738.GA12358@bogus>
References: <20191212014233.32799-1-john.stultz@linaro.org>
 <20191212014233.32799-8-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212014233.32799-8-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:42:32AM +0000, John Stultz wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds binding documentation to support usb hub and usb
> data role switch of Hisilicon HiKey960 Board.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Reworked as usb-role-switch intermediary
> 
> v7: Switched over to YAML dt binding description
> ---
>  .../bindings/misc/hisilicon-hikey-usb.yaml    | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> new file mode 100644
> index 000000000000..1fc3b198ef73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/hisilicon-hikey-usb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: HiKey960 onboard USB GPIO Hub
> +
> +maintainers:
> +  - John Stultz <john.stultz@linaro.org>
> +
> +description: |
> +  Supports the onboard HiKey960 USB GPIO hub, which acts as a
> +  role-switch intermediary to detect the state of the USB-C
> +  port, to switch the hub into dual-role USB-C or host mode,
> +  which enables the onboard USB-A host ports.

Honestly I'm torn between whatever works for you because this is pretty 
"special" dev board design and it should more accurately match the 
hardware design. I think we can do the later and it doesn't really need 
anything new.

> +
> +  Schematics about the hub can be found here:
> +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,gpio_hubv1

As a whole this is HiSilicon specific, but really it is not. It's really 
just a hub, a mux, and connectors for which we have bindings for. I 
think you need to model the actual hub in DT. We have 2 ways already to 
describe hubs in DT: a I2C device or USB device. 

AIUI, the board looks something like this:

ctrl -> mux --> hub -> type-a connector
            +-> type-c connector

If the hub I2C is not used, then you could do something like this:

ctrl {
    mux-controls = <&usb_gpio_mux>;
    connector@0 {
	// type C connector binding
    };
    hub@1 {
	// USB device binding
    };
};

Or if I2C is used and the hub is under the I2C controller:

ctrl {
    port@0 {
        mux-controls = <&usb_gpio_mux>;
        endpoint@0 { // mux state 0
		remote-endpoint = <&usb_c_connector_port>;
	};
        endpoint@1 { // mux state 1
		remote-endpoint = <&usb_hub_port>;
	};
};

The only new bindings you really need are adding 'mux-controls' to the 
USB host controller and the hub binding (we already have a few).

If the USB2 and USB3 signals come from 2 different host controller 
nodes, then I think it will need to look like the 2nd case regardless 
of I2C. (It's strange that USB3 was not routed to Type-C connector. Can 
you do USB2 on Type-C and USB3 on hub simultaneously? You need USB2 to 
enumerate, right?)

> +
> +  typec-vbus-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the typec-vbus gpio

This should be modeled as a GPIO regulator, and belongs as part of a 
connector node. See bindings/connector/usb-connector.txt.

> +
> +  otg-switch-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the otg-switch gpio

This would be the gpio-mux binding instead.

> +
> +  hub-vdd33-en-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the hub 3.3v power enablement gpio

This should be modeled as a GPIO regulator. 

What about the reset line on the hub?

> +
> +  usb-role-switch:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Support role switch.

This normally is a controller property. Role switch is foreign to the 
hub, so doesn't really belong there for sure.

> +
> +  port:
> +    description: |
> +      any connector to the data bus of this controller should be modelled
> +      using the OF graph bindings specified, if the "usb-role-switch"
> +      property is used. Note for this driver, two ports are supported,
> +      the first being the endpoint that will be notified by this driver,
> +      and the second being the endpoint that notifies this driver of a
> +      role switch.
> +
> +
> +required:
> +  - compatible
> +  - typec-vbus-gpios
> +  - otg-switch-gpios
> +  - hub-vdd33-en-gpios
> +  - usb-role-switch
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hisi_hikey_usb: hisi_hikey_usb {
> +        compatible = "hisilicon,gpio_hubv1";
> +        typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
> +        otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> +        hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> +        usb-role-switch;
> +
> +        port {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            hikey_usb_ep0: endpoint@0 {
> +                reg = <0>;
> +                remote-endpoint = <&dwc3_role_switch>;
> +            };
> +            hikey_usb_ep1: endpoint@1 {
> +                reg = <1>;
> +                remote-endpoint = <&rt1711h_ep>;
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
