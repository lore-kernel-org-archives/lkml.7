Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A75ACA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ABC208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MATi3vkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfJaO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:58:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37926 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfJaO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:58:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id j30so738381pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wd8Ydy5zI08ENTcanTYfVXPKw0S2sQWsullzEMfk7rQ=;
        b=MATi3vkPvCiMr4+UiaeWs9j6XA6Ee4hxcdUFDrIZUcE960Da2PCpKrgNX3lOYJVORf
         kjGtwykAZk1CO3SPjlEM19TYE10BGXfr6iodpfABU+PvPt8W9d/GGtXfQwaRS3cpI4t8
         X8v8E0VU9loMbWAfNuCIeHtf41n24YolQpRSOw2aq277L3Kexz1Izu+FC01MH/amZYZS
         6etmN7QJnMaFVEq9WMgkdq02ym+4qkl0M64AxMRuGGko2h5fWoHE7f2P/Y6nMF+xMJRa
         90RVs5Lx07rcWPbkp4WYJ/pGMxhUsy/QHCxUoOoK4MiwSGun6H02mdjrtL1YDS3i5YSp
         EAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wd8Ydy5zI08ENTcanTYfVXPKw0S2sQWsullzEMfk7rQ=;
        b=ftJ8yDSoOf1GU+fznhQndRaVy0PgdnDRszXE9EsBTIemt+9cM+eKjCqfKcTwLrPAnD
         WoZxh8wefgWiKZAn1r74HKY7s0Xe32Gosz7BNDOHLwJyfPUb6cFMCU+115AuGiOv3hrr
         kXMu8cdYgD/nkQsOoyLJ4sZGmVz2ZNiTOYfczcHh+Us39VnNfG+AAGuLiKAumU7u97jT
         CJ4k7hyaXBKcemL+7NgW9ib8ULRSYRKUsnXAm0Q0TtlcdJQy8kNYd/l2O/4QQpnPmnUa
         Qo1JlEpfMZwvaDjrxj/2ahnu633Xb5mZDdINLpDeKF1hOD7IoMLvRqC/Ir6pTp4aOBJW
         A1Zw==
X-Gm-Message-State: APjAAAWNUN8KQtCxrciWVimK6T+P7wUruwen8dYWsH0+LxAJrvO5yVW8
        RdNwBK2+Vb1qKrOo/tm8PW0l
X-Google-Smtp-Source: APXvYqxM+gswwlpQxJViGySnazlj4i+t35eyJuQby6bTFIUSurtlH9D8LQqbBLKTMOWksA2rFGOkHw==
X-Received: by 2002:a63:6581:: with SMTP id z123mr7193723pgb.367.1572533921416;
        Thu, 31 Oct 2019 07:58:41 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id fh5sm5626592pjb.2.2019.10.31.07.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 07:58:40 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:28:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org
Subject: Re: [PATCH v4 1/2] dt-bindings: media: i2c: Add IMX296 CMOS sensor
 binding
Message-ID: <20191031145831.GA27800@mani>
References: <20191030094902.32582-1-manivannan.sadhasivam@linaro.org>
 <20191030094902.32582-2-manivannan.sadhasivam@linaro.org>
 <20191031131538.GA9170@pendragon.ideasonboard.com>
 <20191031134512.GB24273@mani>
 <20191031141141.GD5018@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031141141.GD5018@pendragon.ideasonboard.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Oct 31, 2019 at 04:11:41PM +0200, Laurent Pinchart wrote:
> Hi Mani,
> 
> On Thu, Oct 31, 2019 at 07:15:12PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Oct 31, 2019 at 03:15:38PM +0200, Laurent Pinchart wrote:
> > > On Wed, Oct 30, 2019 at 03:19:01PM +0530, Manivannan Sadhasivam wrote:
> > >> Add YAML devicetree binding for IMX296 CMOS image sensor. Let's also
> > >> add MAINTAINERS entry for the binding and driver.
> > >> 
> > >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >> ---
> > >>  .../devicetree/bindings/media/i2c/imx296.yaml | 94 +++++++++++++++++++
> > >>  MAINTAINERS                                   |  8 ++
> > >>  2 files changed, 102 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.yaml
> > >> 
> > >> diff --git a/Documentation/devicetree/bindings/media/i2c/imx296.yaml b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
> > >> new file mode 100644
> > >> index 000000000000..c04ec2203268
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
> > >> @@ -0,0 +1,94 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/media/i2c/imx296.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Sony IMX296 1/2.8-Inch CMOS Image Sensor
> > >> +
> > >> +maintainers:
> > >> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >> +
> > >> +description: |-
> > >> +  The Sony IMX296 is a 1/2.9-Inch active pixel type CMOS Solid-state image
> > >> +  sensor with square pixel array and 1.58 M effective pixels. This chip
> > >> +  features a global shutter with variable charge-integration time. It is
> > >> +  programmable through I2C and 4-wire interfaces. The sensor output is
> > >> +  available via CSI-2 serial data output (1 Lane).
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: sony,imx296
> > >> +
> > >> +  reg:
> > >> +    maxItems: 1
> > >> +
> > >> +  clocks:
> > >> +    maxItems: 1
> > >> +
> > >> +  clock-names:
> > >> +    description:
> > >> +      Input clock for the sensor.
> > >> +    items:
> > >> +      - const: mclk
> > > 
> > > The pin is named INCK, let's name the clock accordingly.
> > 
> > Okay, I thought generic names are preferred here!
> >  
> > >> +  clock-frequency:
> > >> +    description:
> > >> +      Frequency of the mclk clock in Hertz.
> > > 
> > > This shouldn't be needed, you can retrieve the clock frequency at
> > > runtime from the clock source.
> > 
> > Unless the clock source is a fixed one! What if the clock source comes from
> > SoC? We need to set the rate, right?
> 
> In that case, if you want to hardcode the clock in DT, the preferred way
> is to use the assigned-clock-rates property. Otherwise, if the driver
> requires a specific clock frequency, it's better to hardcode it in the
> driver itself. In this specific case, I think assigned-clock-rates is
> best as the device can support three different clock frequencies.
> 

Agree. assigned-clock* properties makes sense for multiple frequencies. In
my driver, I only used one frequency so I was happy with clock-frequency :)

> > >> +  vddo-supply:
> > >> +    description:
> > >> +      Definition of the regulator used as interface power supply.
> > >> +
> > >> +  vdda-supply:
> > >> +    description:
> > >> +      Definition of the regulator used as analog power supply.
> > >> +
> > >> +  vddd-supply:
> > >> +    description:
> > >> +      Definition of the regulator used as digital power supply.
> > > 
> > > Do we really need three regulators ? I agree that the sensor has three
> > > power rails, but aren't they usually powered by regulators that are
> > > tied together, without individual control ? The IMX926 specifications
> > > require the three power supplies to raise within 200ms, which we should
> > > be able to ensure in software. What does your board use, does it have
> > > multiple GPIOs to control each power supply ? If not I wonder if we
> > > could just define vddd-supply now, and add vdda-supply and vddo-supply
> > > later if we need to support systems that can control the supplies
> > > individually.
> > 
> > The whole power supply model is a bit rotten. In my case, there are 3 different
> > regulators used with no software control. So, I can't control the rise time
> > (I assume that they are handled by the external power regulator itself).
> > 
> > So to be sane, I just documented with the assumption of fixed-regulators.
> 
> Should we then go for one supply, and add the other two when (and if)
> needed ?
> 

I'm not really sure if we should use one power supply here. The single power
supply configuration is not true for all cases. And following what other
sensors are using, I'd prefer to have 3 individual power supplies.

Thanks,
Mani

> > >> +  reset-gpios:
> > >> +    description:
> > >> +      The phandle and specifier for the GPIO that controls sensor reset.
> > >> +    maxItems: 1
> > >> +
> > >> +  port: true
> > >> +
> > >> +required:
> > >> +  - compatible
> > >> +  - reg
> > >> +  - clocks
> > >> +  - clock-names
> > >> +  - clock-frequency
> > >> +  - vddo-supply
> > >> +  - vdda-supply
> > >> +  - vddd-supply
> > >> +
> > >> +additionalProperties: false
> > >> +
> > >> +examples:
> > >> +  - |
> > >> +    #include <dt-bindings/gpio/gpio.h>
> > >> +
> > >> +    imx296: camera-sensor@1a {
> > >> +        compatible = "sony,imx296";
> > >> +        reg = <0x1a>;
> > >> +        reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> > >> +        pinctrl-names = "default";
> > >> +        pinctrl-0 = <&camera_rear_default>;
> > >> +        clocks = <&gcc 90>;
> > >> +        clock-names = "mclk";
> > >> +        clock-frequency = <37125000>;
> > >> +        vddo-supply = <&camera_vddo_1v8>;
> > >> +        vdda-supply = <&camera_vdda_3v3>;
> > >> +        vddd-supply = <&camera_vddd_1v2>;
> > >> +
> > >> +        port {
> > >> +            imx296_ep: endpoint {
> > >> +                remote-endpoint = <&csiphy0_ep>;
> > >> +            };
> > >> +        };
> > >> +    };
> > >> +
> > >> +...
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index 55199ef7fa74..51194bb2c392 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -15140,6 +15140,14 @@ S:	Maintained
> > >>  F:	drivers/media/i2c/imx274.c
> > >>  F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
> > >>  
> > >> +SONY IMX296 SENSOR DRIVER
> > >> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >> +L:	linux-media@vger.kernel.org
> > >> +T:	git git://linuxtv.org/media_tree.git
> > >> +S:	Maintained
> > >> +F:	drivers/media/i2c/imx296.c
> > >> +F:	Documentation/devicetree/bindings/media/i2c/imx296.yaml
> > >> +
> > >>  SONY IMX319 SENSOR DRIVER
> > >>  M:	Bingbu Cao <bingbu.cao@intel.com>
> > >>  L:	linux-media@vger.kernel.org
> 
> -- 
> Regards,
> 
> Laurent Pinchart
