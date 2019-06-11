Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7724CC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jynV4LeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436708AbfFKWCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:02:01 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43847 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436695AbfFKWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:02:01 -0400
Received: by mail-vs1-f68.google.com with SMTP id d128so8971922vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9aK4K+mYhxsBGuDL1wSkT9a9QdB+QJqvCcQqCRoZqk=;
        b=jynV4LeLSkp8mY/yMLs3t4Pg5sizpYJiXBSRzIWuITTAmY09IkU049XMUREkVXni+g
         JYmm1KjaWGlZolbGVaL1OfPnf3JRGs5E9Tzrgf9suFhpZzr0hUOGtfsAg/LWhL40oakz
         62yF0xRTAYPtIkJav7muvoNoGgY8jAOJHKSgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9aK4K+mYhxsBGuDL1wSkT9a9QdB+QJqvCcQqCRoZqk=;
        b=HTRVqJrQas6YpNC6CR0cxJ0LVUXtWQJe7ctfgaG3gytZdTcB2OFCM6Alz6p5/El6CK
         wNq4yX6VT4cuyT918fwURU44WoPdOa9aEVBHdXY1isuEMz6NPquRXFthvVqReFIfGvU0
         NBzqle4vl51o7ijz//rkikPYZgHuAwNDtz60V0UFVyqVpZwqEZ8aA1Xgx+vCd1Cra4ll
         NaRpaUgKDa26uDro+6rQm+xXfuaLDzCHhrQdod81wWvz6T5yVoyNpSvg1gTMsLOh/NRc
         DKq4R1Iu7rvpMKxBUcQUqrpZdkqdYtFlTViDKzjpEInwQ+H9hlVrcnT4P7cXT3s0p1Se
         A6Dw==
X-Gm-Message-State: APjAAAXGW32Tw70PbKmjk3vze8QILENLTH8i06Sy/MCOtLBA4u5QyaDi
        K5ha9sGIJmEjbBVqWwNI5h6NlbWyZdouCOLyW+zaqg==
X-Google-Smtp-Source: APXvYqw0envY6zW+Lz/LpkpAKuJuPPY1ZENACuLJfRT4NvK+IVqHR36Y7gi5Vlqk+iKUf5BiCUj6/+NTISBNAEyEhIk=
X-Received: by 2002:a67:d384:: with SMTP id b4mr9315081vsj.152.1560290519746;
 Tue, 11 Jun 2019 15:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-3-dbasehore@chromium.org> <CAL_JsqLM1CikZ8+NPjLk2CEW-z9vPynZpVG20x0jsa7hVq0LvA@mail.gmail.com>
In-Reply-To: <CAL_JsqLM1CikZ8+NPjLk2CEW-z9vPynZpVG20x0jsa7hVq0LvA@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Tue, 11 Jun 2019 15:01:48 -0700
Message-ID: <CAGAzgsoWGqf0JQPNyRFnv2xZTMxje6idce7Dy5FZzuxj30mQyw@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: display/panel: Expand rotation documentation
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:25 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jun 10, 2019 at 10:03 PM Derek Basehore <dbasehore@chromium.org> wrote:
> >
> > This adds to the rotation documentation to explain how drivers should
> > use the property and gives an example of the property in a devicetree
> > node.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  .../bindings/display/panel/panel.txt          | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
> > index e2e6867852b8..f35d62d933fc 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/panel.txt
> > @@ -2,3 +2,35 @@ Common display properties
> >  -------------------------
> >
> >  - rotation:    Display rotation in degrees counter clockwise (0,90,180,270)
> > +
> > +Property read from the device tree using of of_drm_get_panel_orientation
>
> Don't put kernel specifics into bindings.

Will remove that. I'll clean up the documentation to indicate that
this binding creates a panel orientation property unless the rotation
is handled in the Timing Controller on the panel if that sounds fine.

>
> > +
> > +The panel driver may apply the rotation at the TCON level, which will
>
> What's TCON? Something Mediatek specific IIRC.

The TCON is the Timing controller, which is on the panel. Every panel
has one. I'll add to the doc that the TCON is in the panel, etc.

>
> > +make the panel look like it isn't rotated to the kernel and any other
> > +software.
> > +
> > +If not, a panel orientation property should be added through the SoC
> > +vendor DRM code using the drm_connector_init_panel_orientation_property
> > +function.
>
> The 'rotation' property should be defined purely based on how the
> panel is mounted relative to a device's orientation. If the display
> pipeline has some ability to handle rotation, that's a feature of the
> display pipeline and not the panel.

This is how the panel orientation property is already handled in the
kernel. See drivers/gpu/drm/i915/vlv_dsi.c for more details.

>
> > +
> > +Example:
>
> This file is a collection of common properties. It shouldn't have an
> example especially as this example is mostly non-common properties.

Just copied one of our DTS entries that uses the property. I'll remove
everything under compatible except for rotation and status.

>
> > +       panel: panel@0 {
> > +               compatible = "boe,himax8279d8p";
> > +               reg = <0>;
> > +               enable-gpios = <&pio 45 0>;
>
> > +               pp33-gpios = <&pio 35 0>;
> > +               pp18-gpios = <&pio 36 0>;
>
> BTW, are these upstream because they look like GPIO controlled
> supplies which we model with gpio-regulator binding typically.

The boe,himax8279 driver was sent upstream, but it doesn't appear to
be merged. I'll look into it on that thread.

>
> > +               pinctrl-names = "default", "state_3300mv", "state_1800mv";
> > +               pinctrl-0 = <&panel_pins_default>;
> > +               pinctrl-1 = <&panel_pins_3300mv>;
> > +               pinctrl-2 = <&panel_pins_1800mv>;
> > +               backlight = <&backlight_lcd0>;
> > +               rotation = <180>;
> > +               status = "okay";
> > +
> > +               port {
> > +                       panel_in: endpoint {
> > +                               remote-endpoint = <&dsi_out>;
> > +                       };
> > +               };
> > +       };
> > --
> > 2.22.0.rc2.383.gf4fbbf30c2-goog
> >
