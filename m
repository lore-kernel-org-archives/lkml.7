Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D141C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CD320833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEPM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:58:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPM6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:58:25 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRFxZ-0004u2-Lf; Thu, 16 May 2019 14:58:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add binding for IT6505.
Date:   Thu, 16 May 2019 14:58:08 +0200
Message-ID: <3548960.TAD2hRMT5j@phil>
In-Reply-To: <1557301722-20827-2-git-send-email-allen.chen@ite.com.tw>
References: <1557301722-20827-1-git-send-email-allen.chen@ite.com.tw> <1557301722-20827-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

Am Mittwoch, 8. Mai 2019, 09:48:40 CEST schrieb allen:
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

binding examples should not contain a "status" property.
Also as this is a board-specific i2c device, you shouldn't need
a status property in the board dts as well, as the default is
"okay" anyway.


> +                interrupt-parent = <&pio>;
> +                interrupts = <152 IRQ_TYPE_EDGE_RISING 152 0>;
> +                reg = <0x5c>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&it6505_pins>;
> +                ovdd-supply = <&mt6358_vsim1_reg>;
> +                pwr18-supply = <&it6505_pp18_reg>;
> +                reset-gpios = <&pio 179 1>;
> +                hpd-gpios = <&pio 9 0>;

This is missing from the property-list above.

> +                extcon = <&usbc_extcon>;

Not documented as well. Also this looks like it is the same functionality
as on rk3399-gru devices and circumvents the Type-C subsystem entirely
when handling the display-port alt-mode of the typec port.

At least on rk3399-gru the extcon from the chromeos-ec delivered the
status and allowed chaning settings of the hidden type-c controller
(fusb302 in that case). And while that works for ChromeOS devices this
makes it impossible for other devices to sanely use the chip as well.


The kernels type-c framework did develop a lot more in the meantime,
so this "hack" should probably not spread to more parts and instead should
use the type-c framework.

I pestered Guenter last year at ELCE about making cros-ec-pd a part of
the kernel's type-c subsystem, but I guess nobody had the time so far.

 

> +                port {
> +                        it6505_in: endpoint {
> +                                remote-endpoint = <&dpi_out>;

Ports usage also it not documented above. 


Heiko

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
>  itead	ITEAD Intelligent Systems Co.Ltd
>  iwave  iWave Systems Technologies Pvt. Ltd.
>  jdi	Japan Display Inc.
> 




