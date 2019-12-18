Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C266C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E71218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699029;
	bh=hsGVSDmHbY1DWWyuMtif+daCJjB+w7HogNzj7wAMcaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LY4zdf9EjkqKj5rGqdtz4rreg79zCUYXWHAkzCxf3fgdCOQN78p+dNIUV8Me2V6QF
	 lrbMW4q5a20tjDo5y5Q1moBzzwnZeLYItdGqRAHyIu59e6h+obiKMdPQld3keBk/uS
	 AbPRyGWssSFjZY3bBnPp0xfONu850CevBuPvS6xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLRT5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfLRT5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:57:08 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98A72467B;
        Wed, 18 Dec 2019 19:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576699026;
        bh=hsGVSDmHbY1DWWyuMtif+daCJjB+w7HogNzj7wAMcaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dLJofwbIWgFEPo3+S8hv7quxnIE+fomk9D9qPZ8ldXM1SNHmGCRh/4O/1hh4/lrG5
         62OUVSjet62RZ9+lOQFRmoVIVl7c1/fghP6vPTaCrmAW8fRQFTWr2ZdaflfC14Er0B
         NTV5/18Aa/Ct/IQpn0fEz+3SVNt2f6KqwXeaLZ/0=
Received: by mail-qv1-f49.google.com with SMTP id m14so1258476qvl.3;
        Wed, 18 Dec 2019 11:57:06 -0800 (PST)
X-Gm-Message-State: APjAAAXfJh2SehtoMvf6+br5Qmm74MUYtEOKmeVKKSaNIQAxHJ2jw1Pq
        iHa5ZAaMSYeN6vfCaXwpUdYgNLVGPiimJvr24w==
X-Google-Smtp-Source: APXvYqwlJ8PQxngE9bLOMO3xzC/6f1AKYXW3BjatdURrIOtmKFXm8/TbP1aRYGP/3EMq0xkMKSSwIjW5vHD2z4TRgFE=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr4018358qvn.79.1576699025700;
 Wed, 18 Dec 2019 11:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20191212014233.32799-1-john.stultz@linaro.org>
 <20191212014233.32799-8-john.stultz@linaro.org> <20191218163738.GA12358@bogus>
 <CALAqxLU=KPJoPKHP14BWcLYJdBoK8DC5+7hRtqCvE2-HZHWxZA@mail.gmail.com>
In-Reply-To: <CALAqxLU=KPJoPKHP14BWcLYJdBoK8DC5+7hRtqCvE2-HZHWxZA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Dec 2019 13:56:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9uSMfpQZxmfJX4Y4R_xwkK413SqNZ3x6XpKpMvWA56Q@mail.gmail.com>
Message-ID: <CAL_Jsq+9uSMfpQZxmfJX4Y4R_xwkK413SqNZ3x6XpKpMvWA56Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] dt-bindings: misc: Add bindings for HiSilicon usb
 hub and data role switch functionality on HiKey960
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
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:21 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Dec 18, 2019 at 8:37 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Dec 12, 2019 at 01:42:32AM +0000, John Stultz wrote:
> > > From: Yu Chen <chenyu56@huawei.com>
> > >
> > > This patch adds binding documentation to support usb hub and usb
> > > data role switch of Hisilicon HiKey960 Board.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > CC: ShuFan Lee <shufan_lee@richtek.com>
> > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > Cc: Yu Chen <chenyu56@huawei.com>
> > > Cc: Felipe Balbi <balbi@kernel.org>
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Cc: Jun Li <lijun.kernel@gmail.com>
> > > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > > Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > > Cc: Jack Pham <jackp@codeaurora.org>
> > > Cc: linux-usb@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > > v3: Reworked as usb-role-switch intermediary
> > >
> > > v7: Switched over to YAML dt binding description
> > > ---
> > >  .../bindings/misc/hisilicon-hikey-usb.yaml    | 85 +++++++++++++++++++
> > >  1 file changed, 85 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> > > new file mode 100644
> > > index 000000000000..1fc3b198ef73
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> > > @@ -0,0 +1,85 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2019 Linaro Ltd.
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/misc/hisilicon-hikey-usb.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: HiKey960 onboard USB GPIO Hub
> > > +
> > > +maintainers:
> > > +  - John Stultz <john.stultz@linaro.org>
> > > +
> > > +description: |
> > > +  Supports the onboard HiKey960 USB GPIO hub, which acts as a
> > > +  role-switch intermediary to detect the state of the USB-C
> > > +  port, to switch the hub into dual-role USB-C or host mode,
> > > +  which enables the onboard USB-A host ports.
> >
> > Honestly I'm torn between whatever works for you because this is pretty
> > "special" dev board design and it should more accurately match the
> > hardware design. I think we can do the later and it doesn't really need
> > anything new.
> >
> > > +
> > > +  Schematics about the hub can be found here:
> > > +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: hisilicon,gpio_hubv1
> >
> > As a whole this is HiSilicon specific, but really it is not. It's really
> > just a hub, a mux, and connectors for which we have bindings for. I
> > think you need to model the actual hub in DT. We have 2 ways already to
> > describe hubs in DT: a I2C device or USB device.
> >
> > AIUI, the board looks something like this:
> >
> > ctrl -> mux --> hub -> type-a connector
> >             +-> type-c connector
> >
> > If the hub I2C is not used, then you could do something like this:
> >
> > ctrl {
> >     mux-controls = <&usb_gpio_mux>;
> >     connector@0 {
> >         // type C connector binding
> >     };
> >     hub@1 {
> >         // USB device binding
> >     };
> > };
>
> I can't say I totally grok all this, but I'll go digging to try to
> better understand it.
> I don't believe there is any I2C involved here, so I'll try the
> approach you outline above.

Well, it is there in the schematics.

> > Or if I2C is used and the hub is under the I2C controller:
> >
> > ctrl {
> >     port@0 {
> >         mux-controls = <&usb_gpio_mux>;
> >         endpoint@0 { // mux state 0
> >                 remote-endpoint = <&usb_c_connector_port>;
> >         };
> >         endpoint@1 { // mux state 1
> >                 remote-endpoint = <&usb_hub_port>;
> >         };
> > };
> >
> > The only new bindings you really need are adding 'mux-controls' to the
> > USB host controller and the hub binding (we already have a few).
> >
> > If the USB2 and USB3 signals come from 2 different host controller
> > nodes, then I think it will need to look like the 2nd case regardless
> > of I2C. (It's strange that USB3 was not routed to Type-C connector. Can
> > you do USB2 on Type-C and USB3 on hub simultaneously? You need USB2 to
> > enumerate, right?)
>
> Yea, it is strange, and I unfortunately don't know why only USB2 was
> exported to the type-c connector.
> And to my knowledge, you cannot use both the type-c and hub simultaneously.
>
>
> > > +
> > > +  typec-vbus-gpios:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: phandle to the typec-vbus gpio
> >
> > This should be modeled as a GPIO regulator, and belongs as part of a
> > connector node. See bindings/connector/usb-connector.txt.
> >
> > > +
> > > +  otg-switch-gpios:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: phandle to the otg-switch gpio
> >
> > This would be the gpio-mux binding instead.
> >
> > > +
> > > +  hub-vdd33-en-gpios:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: phandle to the hub 3.3v power enablement gpio
> >
> > This should be modeled as a GPIO regulator.
> >
> > What about the reset line on the hub?
>
> Unknown. I don't have any details on that.

You might just be getting lucky that it is pulled to the right state.


> > > +  usb-role-switch:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description: Support role switch.
> >
> > This normally is a controller property. Role switch is foreign to the
> > hub, so doesn't really belong there for sure.
>
> So this part was critical to being able to get role switch
> notification from the connector and to properly switch modes without
> adding extra notifier gunk from the previous patch that folks didn't
> like.
>
> Trying to understand further,  your suggestion here is to re-model the
> binding, as gpio regulators and gpio muxes, and use a usb-connector
> node to describe them,  but I'm missing how I connect that to the
> driver implementation I have?

Good question, but that shouldn't really dictate your binding design.

> Is the idea to extend the rt1711h and
> dwc3 drivers further to support the mux/hub bit (this part is fairly
> foggy to me), completely removing the need for the misc driver?

I imagine that you need some driver to determine the state of the mux.
Perhaps a usb-mux driver which is instantiated by the host controller
driver when it sees a mux-controls property. Sorry, haven't looked at
the driver side of this at all.

> I did take an attempt at something similar with an earlier iteration
> of the patch set, where I was trying to move the vbus-gpio as a
> gpio-regulator to be controlled by the rt1711h/tpcm core, but that
> approach didn't work properly and Hans suggested I just go back to the
> approach submitted here:
>   https://lkml.org/lkml/2019/10/22/42

I don't see why that would matter. If you need to sense the Vbus
state, then you do need a GPIO typically. But for an enable line, it's
just another level of abstraction.

Rob
