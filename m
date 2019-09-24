Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F73C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44110217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569337137;
	bh=W5MeLhZS5sZtf9zaqV5bUOaPwvhvXSys/vKD9YXq2Aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aoRsWRHIIW6ss4g8v9rJh4EmFMyLR6SPEdbO02CvksV8J+RB43SBPYLYgTOImZ4jP
	 UmUkDsvrxPZXFWIGqf3VqlORX2uc8RUdPljULBM8oFEXYyJCdzAZFzts6YHjI2IkGO
	 Z1v7II7O+yUR4XXCMazerptj5CIpsAjfRnon0ALc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632803AbfIXO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIXO64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:58:56 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3422168B;
        Tue, 24 Sep 2019 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569337134;
        bh=W5MeLhZS5sZtf9zaqV5bUOaPwvhvXSys/vKD9YXq2Aw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W3DdP+rxCmtHzXrHnvsa4TWvWycRBThGjmG5edqmsozQ0EdQTU5Zq274LVPuNnSRU
         DmFZ1uPREQO4ALK33o1blCj06tSJfdGJQ0qKkTlHgxnXrLA0+SVrk78uERKXeT4amZ
         tKHg5Iy2x12Cbs2DDdkyOCr7OmMcjhwnaGF+p+2g=
Received: by mail-qk1-f176.google.com with SMTP id q203so2095271qke.1;
        Tue, 24 Sep 2019 07:58:54 -0700 (PDT)
X-Gm-Message-State: APjAAAVDVLMlgkvMfNZc5Syi1DBPqsrwd8NmeG+Zh2o8S1IRK5WMO8sV
        GAhRO4vSli5oG6z6nVd7tqE+RW4MFkV69UrlMQ==
X-Google-Smtp-Source: APXvYqzrsNdKm8ga0UPpciXHC3g0dXA3eN4kckY6MLSWPLk4pOq1pfp+X/Pc6CUjYP4Cf0OZwWsApY6kKpDO3/fnRiY=
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr2874837qkl.152.1569337133701;
 Tue, 24 Sep 2019 07:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
 <20190910153409.111901-2-paul.kocialkowski@bootlin.com> <20190913143510.GA9504@bogus>
 <20190913155815.GA1554@aptenodytes> <CAL_Jsq+dzT1xrfBy2QQHLx9MUNukWWq5eXyOecVV8h0z5ziC8g@mail.gmail.com>
 <20190923153311.GE57525@aptenodytes>
In-Reply-To: <20190923153311.GE57525@aptenodytes>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Sep 2019 09:58:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLfAb0xhmBoX+GUcv5wsuHBOs8wZ=Hkw3x03kfsPgOqg@mail.gmail.com>
Message-ID: <CAL_JsqJLfAb0xhmBoX+GUcv5wsuHBOs8wZ=Hkw3x03kfsPgOqg@mail.gmail.com>
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

On Mon, Sep 23, 2019 at 10:33 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Fri 13 Sep 19, 20:16, Rob Herring wrote:
> > On Fri, Sep 13, 2019 at 4:58 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > >
> > > Hi Rob and thanks for the review!
> > >
> > > On Fri 13 Sep 19, 15:35, Rob Herring wrote:
> > > > On Tue, Sep 10, 2019 at 05:34:08PM +0200, Paul Kocialkowski wrote:
> > > > > The Xylon LogiCVC is a display controller implemented as programmable
> > > > > logic in Xilinx FPGAs.
> > > > >
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > > >  .../bindings/display/xylon,logicvc.txt        | 188 ++++++++++++++++++
> > > > >  1 file changed, 188 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > >
> > > > Consider converting this to DT schema format. See
> > > > Documentation/devicetree/writing-schema.rst (.md in 5.3).
> > >
> > > Oh right, that would certainly be much more future-proof!
> > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc.txt b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > > new file mode 100644
> > > > > index 000000000000..eb4b1553888a
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> > > > > @@ -0,0 +1,188 @@
> > > > > +Xylon LogiCVC display controller
> > > > > +
> > > > > +The Xylon LogiCVC is a display controller that supports multiple layers.
> > > > > +It is usually implemented as programmable logic and was optimized for use
> > > > > +with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
> > > > > +
> > > > > +Because the controller is intended for use in a FPGA, most of the configuration
> > > > > +of the controller takes place at logic configuration bitstream synthesis time.
> > > > > +As a result, many of the device-tree bindings are meant to reflect the
> > > > > +synthesis configuration. These do not allow configuring the controller
> > > > > +differently than synthesis configuration.
> > > > > +
> > > > > +Layers are declared in the "layers" sub-node and have dedicated configuration.
> > > > > +In version 3 of the controller, each layer has fixed memory offset and address
> > > > > +starting from the video memory base address for its framebuffer. With version 4,
> > > > > +framebuffers are configured with a direct memory address instead.
> > > > > +
> > > > > +Matching synthesis parameters are provided when applicable.
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible: Should be one of:
> > > > > +  "xylon,logicvc-3.02.a-display"
> > > > > +  "xylon,logicvc-4.01.a-display"
> > > > > +- reg: Physical base address and size for the controller registers.
> > > > > +- clocks: List of phandle and clock-specifier pairs, one for each entry
> > > > > +  in 'clock-names'
> > > > > +- clock-names: List of clock names that should at least contain:
> > > > > +  - "vclk": The VCLK video clock input.
> > > > > +- interrupts: The interrupt to use for VBLANK signaling.
> > > > > +- xylon,display-interface: Display interface in use, should be one of:
> > > > > +  - "lvds-4bits": 4-bit LVDS interface (C_DISPLAY_INTERFACE == 4).
> > > > > +- xylon,display-colorspace: Display output colorspace in use, should be one of:
> > > > > +  - "rgb": RGB colorspace (C_DISPLAY_COLOR_SPACE == 0).
> > > > > +- xylon,display-depth: Display output depth in use (C_PIXEL_DATA_WIDTH).
> > > > > +- xylon,row-stride: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
> > > > > +- xylon,layers-count: The number of available layers (C_NUM_OF_LAYERS).
> > > >
> > > > Presumably some of this is determined by the display attached. Isn't it
> > > > safe to assume the IP was configured correctly for the intended display
> > > > and you can just get this from the panel?
> > >
> > > Layers are what corresponds to DRM planes, which are not actually indicated
> > > by the panel but are a charasteristic of the display controller. In our case,
> > > this is directly selected at bitstream synthesis time for the controller.
> > >
> > > So I'm afraid there is no way we can auto-detect this from the driver.
> >
> > Sorry, I referring to the set of properties above. In particular,
> > xylon,display-interface and xylon,display-colorspace, though I don't
> > know if the latter is talking in memory format or on the wire format.
>
> Both of these are about the wire format, which is also "hardcoded" at synthesis
> time with no way to be detected afterwards, as far as I know. Memory format is
> described in the layer sub-nodes.

You have to attach the controller to something at the other end of the
wire. A panel is only going to support 1 or a few wire formats, so you
do likely know because the panel knows. In the case that a panel
supports multiple wire formats, we do have some standard properties
there. See the LVDS panel binding.

>
> > Actually for xylon,layers-count, You should just count the child nodes
> > of 'layers'.
>
> Oh that's a good point, thanks!
>
> > > > > +Optional properties:
> > > > > +- memory-region: phandle to a node describing memory, as specified in:
> > > > > +  Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > > +- clock-names: List of clock names that can optionally contain:
> > > > > +  - "vclk2": The VCLK2 doubled-rate video clock input.
> > > > > +  - "lvdsclk": The LVDS clock.
> > > > > +  - "lvdsclkn": The LVDS clock inverted.
> > > >
> > > > How are these really optional?
> > >
> > > Well, the controller currently only supports LVDS, but more interfaces may be
> > > added later, so the lvdsclk clock will be optional when another interface
> > > is used instead. Maybe I'm mistaken about how to categorize them though.
> > >
> > > My understanding is that the need for vclk2 and lvdsclkn depend on the target
> > > FPGA family. I've developped the driver without the need for them, but the
> > > datasheet states that they may be needed (but doesn't provide significant
> > > details about their role though).
> >
> > Not sure what to tell you then. You'll see it becomes a bit messy to
> > describe in schema. Ideally we define the exact number, order, and
> > values possible (or sets of those).
>
> I'll try to do my best.
>
> > > > > +- xylon,syscon: Syscon phandle representing the logicvc instance.
> > > > > +- xylon,dithering: Dithering module is enabled (C_XCOLOR).
> > > > > +- xylon,background-layer: The last layer is used to display a black background
> > > > > +  (C_USE_BACKGROUND). It must still be registered.
> > > > > +- xylon,layers-configurable: Configuration of layers' size, position and offset
> > > > > +  is enabled (C_USE_SIZE_POSITION).
> > > >
> > > > I would think this will effectively have to be enabled to make this
> > > > usable with DRM. I'm not sure if a "standard" userspace would use any of
> > > > the layers if all this is fixed.
> > >
> > > I was going with the same assumption, but drm_atomic_helper_check_plane_state
> > > has a can_position parameter, which will check that the plane covers the
> > > whole CRTC if set to false. So I guess it is somewhat expected that this can
> > > be the case and some drivers (e.g. arm/hdlcd_crtc.c) also set this to false.
> >
> > Certainly atomic can fail on anything not supported. My question is
> > more whether userspace has some minimum requirements. A cursor
> > couldn't deal with can_position=false for example.
>
> Right, so I suppose that using an overlay plane as cursor wouldn't work
> in this situation. Well, I haven't found any formal definition of what minimal
> requirements are expected from overlay planes. I would expect userspace that
> tries to use an overlay plane as a cursor to have a software fallback as soon
> as something goes wrong. My feeling is that overlay planes are provided on a
> "best-effort" basis, though contradiction is welcome here.

For sure, there's always a software fallback. While we shouldn't let a
specific OS's requirements dictate DT bindings, I just wonder if some
of the configuration ends up always having to be set a certain way.
Clearly, you could be writing the whole software stack and do a fixed
configuration, but would you still be using DT at that point?

Rob
