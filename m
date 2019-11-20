Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575E6C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2583720715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574265749;
	bh=fkai9iagblxVM80NF9jPjdkCT3Ll2l153n578/rJMQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uA8qzIs5qFbuOob94yr64lXvuL9I+NLESJMU3OotbKlD2gTefoR7iuMWirJPxaq99
	 PeG7iedqo5SfBpGVLpq5MeKGZEz9v9dyZTuauLJnOYwsXE/n3hVL4HcmI8SUtRPx0Y
	 3F1bij2KcCmoqWwSdtNy1+9ZZ6c2jC+zs7/CH9Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfKTQC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfKTQC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:02:27 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF6F2071B;
        Wed, 20 Nov 2019 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574265747;
        bh=fkai9iagblxVM80NF9jPjdkCT3Ll2l153n578/rJMQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGkW6V5+gVyijrtS+kBTvCY8m31Mmmyb/h1F1O1OAZerHqSS1odhUATaI66Npwnpu
         ozQGReuIyKVHiuQZrZOCqeYq+OLSoII+NmsYIBQGdWHFDX2HfxauSg1PW0TYKfcKh6
         QPXBN8gbv8TKF8D+tQ/jS+U+xo6B8t3DQCqUhBKs=
Received: by mail-qv1-f50.google.com with SMTP id n4so90495qvq.9;
        Wed, 20 Nov 2019 08:02:26 -0800 (PST)
X-Gm-Message-State: APjAAAX0LS+xSxuca0l6YIHgjA8d1aHjsKl/o7Qb2CGrz1Ze1V6h3fbc
        oCpdtn4tZf1TEvl7CTE3riVoUTPvWl7hVgmzMg==
X-Google-Smtp-Source: APXvYqwq5SAEBgw062GclbqqxIVUufSCPIi/U3DPvAif0XTbyFTcVbv7pvhxYJt8XQ2f7IL43GVlkAL9OgeMg9B2s0M=
X-Received: by 2002:ad4:42b4:: with SMTP id e20mr3287388qvr.85.1574265745927;
 Wed, 20 Nov 2019 08:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
 <20190910153409.111901-2-paul.kocialkowski@bootlin.com> <20190913143510.GA9504@bogus>
 <20190913155815.GA1554@aptenodytes> <CAL_Jsq+dzT1xrfBy2QQHLx9MUNukWWq5eXyOecVV8h0z5ziC8g@mail.gmail.com>
 <20190923153311.GE57525@aptenodytes> <CAL_JsqJLfAb0xhmBoX+GUcv5wsuHBOs8wZ=Hkw3x03kfsPgOqg@mail.gmail.com>
 <20191120144957.GA167553@aptenodytes>
In-Reply-To: <20191120144957.GA167553@aptenodytes>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Nov 2019 10:02:14 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+n2HYz3BLm3Nad=Uv6qiJNM2=fQmCxzkXJZx-0=VQTFQ@mail.gmail.com>
Message-ID: <CAL_Jsq+n2HYz3BLm3Nad=Uv6qiJNM2=fQmCxzkXJZx-0=VQTFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: Add xylon logicvc bindings documentation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 8:50 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> Circling back to this thread now, sorry for the delay.
>
> On Tue 24 Sep 19, 09:58, Rob Herring wrote:
> > On Mon, Sep 23, 2019 at 10:33 AM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri 13 Sep 19, 20:16, Rob Herring wrote:
> > > > On Fri, Sep 13, 2019 at 4:58 PM Paul Kocialkowski
> > > > <paul.kocialkowski@bootlin.com> wrote:
> > > > >
> > > > > Hi Rob and thanks for the review!
> > > > >
> > > > > On Fri 13 Sep 19, 15:35, Rob Herring wrote:
> > > > > > On Tue, Sep 10, 2019 at 05:34:08PM +0200, Paul Kocialkowski wrote:
> > > > > > > The Xylon LogiCVC is a display controller implemented as programmable
> > > > > > > logic in Xilinx FPGAs.
> > > > > > >
> > > > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > > ---
> > > > > > >  .../bindings/display/xylon,logicvc.txt        | 188 ++++++++++++++++++
> > > > > > >  1 file changed, 188 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > > >
> > > > > > Consider converting this to DT schema format. See
> > > > > > Documentation/devicetree/writing-schema.rst (.md in 5.3).
> > > > >
> > > > > Oh right, that would certainly be much more future-proof!
> > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc.txt b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..eb4b1553888a
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > > > > @@ -0,0 +1,188 @@
> > > > > > > +Xylon LogiCVC display controller
> > > > > > > +
> > > > > > > +The Xylon LogiCVC is a display controller that supports multiple layers.
> > > > > > > +It is usually implemented as programmable logic and was optimized for use
> > > > > > > +with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
> > > > > > > +
> > > > > > > +Because the controller is intended for use in a FPGA, most of the configuration
> > > > > > > +of the controller takes place at logic configuration bitstream synthesis time.
> > > > > > > +As a result, many of the device-tree bindings are meant to reflect the
> > > > > > > +synthesis configuration. These do not allow configuring the controller
> > > > > > > +differently than synthesis configuration.
> > > > > > > +
> > > > > > > +Layers are declared in the "layers" sub-node and have dedicated configuration.
> > > > > > > +In version 3 of the controller, each layer has fixed memory offset and address
> > > > > > > +starting from the video memory base address for its framebuffer. With version 4,
> > > > > > > +framebuffers are configured with a direct memory address instead.
> > > > > > > +
> > > > > > > +Matching synthesis parameters are provided when applicable.
> > > > > > > +
> > > > > > > +Required properties:
> > > > > > > +- compatible: Should be one of:
> > > > > > > +  "xylon,logicvc-3.02.a-display"
> > > > > > > +  "xylon,logicvc-4.01.a-display"
> > > > > > > +- reg: Physical base address and size for the controller registers.
> > > > > > > +- clocks: List of phandle and clock-specifier pairs, one for each entry
> > > > > > > +  in 'clock-names'
> > > > > > > +- clock-names: List of clock names that should at least contain:
> > > > > > > +  - "vclk": The VCLK video clock input.
> > > > > > > +- interrupts: The interrupt to use for VBLANK signaling.
> > > > > > > +- xylon,display-interface: Display interface in use, should be one of:
> > > > > > > +  - "lvds-4bits": 4-bit LVDS interface (C_DISPLAY_INTERFACE == 4).
> > > > > > > +- xylon,display-colorspace: Display output colorspace in use, should be one of:
> > > > > > > +  - "rgb": RGB colorspace (C_DISPLAY_COLOR_SPACE == 0).
> > > > > > > +- xylon,display-depth: Display output depth in use (C_PIXEL_DATA_WIDTH).
> > > > > > > +- xylon,row-stride: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
> > > > > > > +- xylon,layers-count: The number of available layers (C_NUM_OF_LAYERS).
> > > > > >
> > > > > > Presumably some of this is determined by the display attached. Isn't it
> > > > > > safe to assume the IP was configured correctly for the intended display
> > > > > > and you can just get this from the panel?
> > > > >
> > > > > Layers are what corresponds to DRM planes, which are not actually indicated
> > > > > by the panel but are a charasteristic of the display controller. In our case,
> > > > > this is directly selected at bitstream synthesis time for the controller.
> > > > >
> > > > > So I'm afraid there is no way we can auto-detect this from the driver.
> > > >
> > > > Sorry, I referring to the set of properties above. In particular,
> > > > xylon,display-interface and xylon,display-colorspace, though I don't
> > > > know if the latter is talking in memory format or on the wire format.
> > >
> > > Both of these are about the wire format, which is also "hardcoded" at synthesis
> > > time with no way to be detected afterwards, as far as I know. Memory format is
> > > described in the layer sub-nodes.
> >
> > You have to attach the controller to something at the other end of the
> > wire. A panel is only going to support 1 or a few wire formats, so you
> > do likely know because the panel knows. In the case that a panel
> > supports multiple wire formats, we do have some standard properties
> > there. See the LVDS panel binding.
>
> Looking at the LVDS panel binding, I see that the LVDS types that I have
> described as lvds-4bits and lvds-3bits are called jeida-24 and jeida-18.
>
> Either way, the controller cannot be dynamically configured to use one or
> another: it is configured to support one at synthesis time and this doesn't
> change.

Understood, but I was assuming you need to know how it was configured
for some reason?

> I'm not sure exactly what you implied here. Even if we can retreive the
> wire format from the lvds-panel's data-mapping property, I don't think it shall
> describe what the display controller was configured to. This information could
> be used to make sure that both are compatible (in the driver), but that's about
> it as far as I can see.

It's not the kernel's job to validate the DT is correct. Someone could
just as easily define a panel that doesn't match with the configured
format as they could having lvds-?bits set incorrectly.

So get the wire format from the panel driver (either implied or by DT
property) and assume that matches the configuration of the controller.
Though, I guess if the model is each end of the wire should advertise
what it supports and the core picks the best format, then that only
works if you advertise both formats. Or we could allow jeida-{24,18}
property at both ends of the graph.

Rob
