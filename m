Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC9EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54D220644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXaGzb14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfFMVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:00:39 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42589 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbfFMVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:00:39 -0400
Received: by mail-ua1-f68.google.com with SMTP id a97so84626uaa.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANvjNrcE6QQq73dnlL+mZyHS0xmMxjzetcJMdK2W1jQ=;
        b=CXaGzb143DooLWuwJbQV6crBWgqXBWrbK4+440tGPl1wKAyG8snXREUHW1cU4JZmsm
         FByj4Hbh/N7MYr7J1mbnB5t09OsVMCB1N4NOkq7QEs9SD5IFkvvlk2kM4aqXonR4pgZ7
         0hbbny8wK43pD9gCj8eWhwnzsqv2xTicEtM7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANvjNrcE6QQq73dnlL+mZyHS0xmMxjzetcJMdK2W1jQ=;
        b=Ld+Luvcz48V1iRV2FmOy9lug7Sak5yVU8uWVCuRu24dST1WM09wKxh1maceIB5FnPv
         iLYE+34GVC5Y5feyGc78lxm1bluh2LzZfe7oGIWXQy0ZRIb8uUOSnS/SzwmI+Ng212pQ
         VpOI6yLYvWLHnIgKb3aaCkkNCVZ2+wfZitSOtmCbD6LK5b5LLCZDcp3C62sgTyClhtnI
         5fAlGphZ6uB589wsY1j0AxGXe5xs00pw8JGjY6OWJIQE94DJe/bIKRmU8fzgZtkqn6PO
         +53SgYLhgN3z8sprEV/XjPIt4Ya79exSwsvWynQEzTPEykvPo3yJ1jg7Q9Muq0GJoE8M
         eVFQ==
X-Gm-Message-State: APjAAAWfXlaqOZ1tDVRVVtJuboQFDh/rzNNBWN+RFoD1g6cP5y/+CxeT
        PRikXWLKq2bZl5r4cKa03nLoWKbHjby0engfjhNcpeJc2V0=
X-Google-Smtp-Source: APXvYqzlG0QFlUSsjLJYtq2bSsXOqJPxL2qmav8y+XGpEorpyChcZ6aWL5jxAoS7c6ipQTO+UOtbuYWiPAgZ4BuXj/Q=
X-Received: by 2002:ab0:3d2:: with SMTP id 76mr17494821uau.12.1560459637540;
 Thu, 13 Jun 2019 14:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-3-dbasehore@chromium.org> <CAL_JsqLM1CikZ8+NPjLk2CEW-z9vPynZpVG20x0jsa7hVq0LvA@mail.gmail.com>
 <CAGAzgsoWGqf0JQPNyRFnv2xZTMxje6idce7Dy5FZzuxj30mQyw@mail.gmail.com> <CAL_Jsq+9K764hFT6GG=4paumGaxOUbnts4VJvTZ9a8Y-YPWdhg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+9K764hFT6GG=4paumGaxOUbnts4VJvTZ9a8Y-YPWdhg@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 13 Jun 2019 14:00:26 -0700
Message-ID: <CAGAzgsrNhumP2DEOff34cZ3UY=CV-EG1RM06Uf_tX3gdUMeSQg@mail.gmail.com>
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

On Thu, Jun 13, 2019 at 5:52 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jun 11, 2019 at 4:02 PM dbasehore . <dbasehore@chromium.org> wrote:
> >
> > On Tue, Jun 11, 2019 at 8:25 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Mon, Jun 10, 2019 at 10:03 PM Derek Basehore <dbasehore@chromium.org> wrote:
> > > >
> > > > This adds to the rotation documentation to explain how drivers should
> > > > use the property and gives an example of the property in a devicetree
> > > > node.
> > > >
> > > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > > ---
> > > >  .../bindings/display/panel/panel.txt          | 32 +++++++++++++++++++
> > > >  1 file changed, 32 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
> > > > index e2e6867852b8..f35d62d933fc 100644
> > > > --- a/Documentation/devicetree/bindings/display/panel/panel.txt
> > > > +++ b/Documentation/devicetree/bindings/display/panel/panel.txt
> > > > @@ -2,3 +2,35 @@ Common display properties
> > > >  -------------------------
> > > >
> > > >  - rotation:    Display rotation in degrees counter clockwise (0,90,180,270)
> > > > +
> > > > +Property read from the device tree using of of_drm_get_panel_orientation
> > >
> > > Don't put kernel specifics into bindings.
> >
> > Will remove that. I'll clean up the documentation to indicate that
> > this binding creates a panel orientation property unless the rotation
> > is handled in the Timing Controller on the panel if that sounds fine.
>
> Even if the timing ctrlr handles it, don't you still need to know what
> the native orientation is?

Not really. For all intents and purposes, the orientation of the panel
has changed.

>
> > > > +
> > > > +The panel driver may apply the rotation at the TCON level, which will
> > >
> > > What's TCON? Something Mediatek specific IIRC.
> >
> > The TCON is the Timing controller, which is on the panel. Every panel
> > has one. I'll add to the doc that the TCON is in the panel, etc.
> >
> > >
> > > > +make the panel look like it isn't rotated to the kernel and any other
> > > > +software.
> > > > +
> > > > +If not, a panel orientation property should be added through the SoC
> > > > +vendor DRM code using the drm_connector_init_panel_orientation_property
> > > > +function.
> > >
> > > The 'rotation' property should be defined purely based on how the
> > > panel is mounted relative to a device's orientation. If the display
> > > pipeline has some ability to handle rotation, that's a feature of the
> > > display pipeline and not the panel.
> >
> > This is how the panel orientation property is already handled in the
> > kernel. See drivers/gpu/drm/i915/vlv_dsi.c for more details.
>
> The point is your description is all about the kernel. This is a
> binding which is not kernel specific.

Ah, I see. I thought you were saying what the implementation should be.

>
> > > > +
> > > > +Example:
> > >
> > > This file is a collection of common properties. It shouldn't have an
> > > example especially as this example is mostly non-common properties.
> >
> > Just copied one of our DTS entries that uses the property. I'll remove
> > everything under compatible except for rotation and status.
>
> Just remove the example or add what you want to the "boe,himax8279d8p"
> binding doc. We are moving towards examples being compiled and
> validated, so incomplete ones won't work.

Ok, will do.

>
> Rob

Thanks for the quick reviews.
