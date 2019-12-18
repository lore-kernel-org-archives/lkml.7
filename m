Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B53721D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576700991;
	bh=mSPEJI3ROuHLVQb5iHDzCgXyiZNPBjGSreIAkiAgh/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M8XWgti0c/hse/FKbz466U4m6jOpLVI3IICsxyRJH5uVLrTbkB2HO2f1IIVKKx0kT
	 NJYHpsHSdAegVOcxTz7siy3AN+iidGsglgKmIxChbpyR0iU4gt9Cc5KjQNCXpGn5A6
	 zb0seL7/P3qFj1RrIfYdDwG31s+R8lM3s25xUTQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLRU3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:29:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44751 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfLRU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:29:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so1438388otj.11;
        Wed, 18 Dec 2019 12:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zo7AMxlW3R7HGZ97qstWf9ACCoDZ26xr089DNiXllwk=;
        b=s3Ped9EQ5JBQzi50T0CB3jMB06rolZDLu9ZPaxB/5C3cVpFU7wv0a+FL68/Dkmnw5k
         jPuZrNBWu8mtVZG5mIMdngBbte5bdtSbw8LtkcWJxolAYd2eSMJs+ef7jvni3enqzdBj
         Qzq/sC0XnTlNkT9aaGFLkCMbEenqPIAF8oq3BhlmH8vU1ayxFglHFlEpShQqm52GBMIx
         jvEC/e3vyb8tH+2flTaTBABCOmBnCo69WMB9yWXq508MxPPKZrTzwyM7mVGTi4AZyaxz
         FJnsLRMvEIkl9R8D2zemTcwmwf9QaJEcWYdkNcM4rXC6e9e8PyDsTjVlzS6EVeeBeOc4
         X3iw==
X-Gm-Message-State: APjAAAUxkzW1JKAFqmDAhGZQ15FSO08FFKmcRc/kZXGexyxLMn1WHbps
        poCYsum4Pq8awSmVoCQ+Ow==
X-Google-Smtp-Source: APXvYqxlkDU6tHNTqvARly1HRqbjrV6DtccxT24N3+hW9tk6GPsRekHX9EabS1Ww9O3fu490Ffl3Zw==
X-Received: by 2002:a9d:6a8f:: with SMTP id l15mr4490805otq.59.1576700987466;
        Wed, 18 Dec 2019 12:29:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k5sm1187910otp.33.2019.12.18.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:29:46 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     allen <allen.chen@ite.com.tw>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 3/4] dt-bindings: Add binding for IT6505.
Message-ID: <20191218202946.GA27564@bogus>
References: <1575957299-12977-1-git-send-email-allen.chen@ite.com.tw>
 <1575957299-12977-4-git-send-email-allen.chen@ite.com.tw>
 <20191214082145.GD22818@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214082145.GD22818@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 09:21:45AM +0100, Sam Ravnborg wrote:
> Hi Allen.
> 
> On Tue, Dec 10, 2019 at 01:53:41PM +0800, allen wrote:
> > Add a DT binding documentation for IT6505.
> > 
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > ---
> >  .../bindings/display/bridge/ite,it6505.yaml        | 99 ++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > new file mode 100644
> > index 00000000..23a106a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: GPL-2.0
> Please dual license new bindings like this:
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 
> 
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/ite,it6505.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ITE it6505 Device Tree Bindings
> > +
> > +maintainers:
> > +  - Allen Chen <allen.chen@ite.com.tw>
> > +
> > +description: |
> > +  The IT6505 is a high-performance DisplayPort 1.1a transmitter,
> > +fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications.
> > +The IT6505 supports color depth of up to 36 bits (12 bits/color)
> > +and ensures robust transmission of high-quality uncompressed video
> > +content, along with uncompressed and compressed digital audio content.
> Can we get consistent indent of the text here.

Pretty sure that's not even valid YAML.

> With this fixed:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> > +
> > +  Aside from the various video output formats supported, the IT6505
> > +also encodes and transmits up to 8 channels of I2S digital audio,
> > +with sampling rate up to 192kHz and sample size up to 24 bits.
> > +In addition, an S/PDIF input port takes in compressed audio of up to
> > +192kHz frame rate.
> > +
> > +  Each IT6505 chip comes preprogrammed with an unique HDCP key,
> > +in compliance with the HDCP 1.3 standard so as to provide secure
> > +transmission of high-definition content. Users of the IT6505 need not
> > +purchase any HDCP keys or ROMs.
> > +
> > +properties:
> > +  compatible:
> > +    const: ite,it6505
> > +
> > +  reg:
> > +    - maxItems: 1
> > +    - description: i2c address of the bridge

And this is not valid json-schema. The '-' means list and properties 
aren't lists.

Run 'make dt_binding_check' and fix all the errors. See 
Documentation/devicetree/bindings/writing-schema.rst.

> > +
> > +  ovdd-supply:
> > +    - maxItems: 1
> > +    - description: I/O voltage
> > +
> > +  pwr18-supply:
> > +    - maxItems: 1
> > +    - description: core voltage
> > +
> > +  interrupts:
> > +    - maxItems: 1
> > +    - description: interrupt specifier of INT pin
> > +
> > +  reset-gpios:
> > +    - maxItems: 1
> > +    - description: gpio specifier of RESET pin
> > +
> > +  hpd-gpios:

Is HPD attached to the DP bridge or the DP connector. For the latter, 
then this property goes in a connector node.

> > +    - maxItems: 1
> > +    - description:
> > +        - Hotplug detect GPIO
> > +        - Indicates which GPIO should be used for hotplug detection
> > +
> > +  extcon:

Don't use extcon. Deprecated.

> > +    - maxItems: 1
> > +    - description: extcon specifier for the Power Delivery
> > +
> > +  port:
> > +    - type: object
> > +    - description: A port node pointing to DPI host port node
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ovdd-supply
> > +  - pwr18-supply
> > +  - interrupts
> > +  - reset-gpios
> > +  - hpd-gpios
> > +  - extcon
> > +
> > +examples:
> > +  - |
> > +    dp-bridge@5c {
> > +        compatible = "ite,it6505";
> > +        interrupts = <152 IRQ_TYPE_EDGE_RISING 152 0>;
> > +        reg = <0x5c>;
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&it6505_pins>;
> > +        ovdd-supply = <&mt6358_vsim1_reg>;
> > +        pwr18-supply = <&it6505_pp18_reg>;
> > +        reset-gpios = <&pio 179 1>;
> > +        hpd-gpios = <&pio 9 0>;
> > +        extcon = <&usbc_extcon>;
> > +
> > +        port {
> > +            it6505_in: endpoint {
> > +                remote-endpoint = <&dpi_out>;
> > +            };
> > +        };
> > +    };
> > +
> > +---
