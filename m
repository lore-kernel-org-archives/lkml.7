Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ABDC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A702054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560439245;
	bh=hGTL0UDB9YcWjm74Ir6wQQkX+JwdFyiJOCXF2M+5evU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uSoPzi+fGqpaO691BrM/F7Wa4718r0eUhkbdOMBc86xlIURHoSN0Jprn/Vj7ZARxh
	 zgiFWJ8L/Wfj7ypP0Jatnh2EvstvuIB4wO8eUxngVmXAvPS3Q0tzMbvAW6CcAChp7q
	 VE9GnjFmDSi+ZmH3X4rji/DTmYP1ZuzuqPrUrfL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfFMPUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732015AbfFMMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:52:06 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B79F217F5;
        Thu, 13 Jun 2019 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560430325;
        bh=hGTL0UDB9YcWjm74Ir6wQQkX+JwdFyiJOCXF2M+5evU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wTbq5CEloa5SHhkjgeBYGYhL8+3cX1A9KNfN+w4wcEsou4uoK3R8GYYknSIbC0XIw
         yMulQoFX7Op9+tmF1uisRQ1zdrMdT6oHMrM5jwVwc6ZR0HX/6KT6sJuFaqhby7RTL4
         hoqPqr8M2vylF39fcb7bXFgXZLZDkOMCY3ZSYu+A=
Received: by mail-qt1-f174.google.com with SMTP id z24so9121577qtj.10;
        Thu, 13 Jun 2019 05:52:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUZdZeBp7EFAIhRQCVQ3CEwI66QPvqMbp/wqw8y7ssY8VH5oBhV
        /7KDepjn2vLfHDRQO8BxR/1RuS0VkvSJpb/c7Q==
X-Google-Smtp-Source: APXvYqyQSf3AAUre27+KCK29BAV13oivw2pUie02NLqVC7Y0PandMlDUCad0+vn9k1QO92NFUsbnlgd0BItkrNEdFVo=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr3426471qve.148.1560430324645;
 Thu, 13 Jun 2019 05:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-3-dbasehore@chromium.org> <CAL_JsqLM1CikZ8+NPjLk2CEW-z9vPynZpVG20x0jsa7hVq0LvA@mail.gmail.com>
 <CAGAzgsoWGqf0JQPNyRFnv2xZTMxje6idce7Dy5FZzuxj30mQyw@mail.gmail.com>
In-Reply-To: <CAGAzgsoWGqf0JQPNyRFnv2xZTMxje6idce7Dy5FZzuxj30mQyw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Jun 2019 06:51:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9K764hFT6GG=4paumGaxOUbnts4VJvTZ9a8Y-YPWdhg@mail.gmail.com>
Message-ID: <CAL_Jsq+9K764hFT6GG=4paumGaxOUbnts4VJvTZ9a8Y-YPWdhg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: display/panel: Expand rotation documentation
To:     "dbasehore ." <dbasehore@chromium.org>
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

On Tue, Jun 11, 2019 at 4:02 PM dbasehore . <dbasehore@chromium.org> wrote:
>
> On Tue, Jun 11, 2019 at 8:25 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Jun 10, 2019 at 10:03 PM Derek Basehore <dbasehore@chromium.org> wrote:
> > >
> > > This adds to the rotation documentation to explain how drivers should
> > > use the property and gives an example of the property in a devicetree
> > > node.
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > >  .../bindings/display/panel/panel.txt          | 32 +++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
> > > index e2e6867852b8..f35d62d933fc 100644
> > > --- a/Documentation/devicetree/bindings/display/panel/panel.txt
> > > +++ b/Documentation/devicetree/bindings/display/panel/panel.txt
> > > @@ -2,3 +2,35 @@ Common display properties
> > >  -------------------------
> > >
> > >  - rotation:    Display rotation in degrees counter clockwise (0,90,180,270)
> > > +
> > > +Property read from the device tree using of of_drm_get_panel_orientation
> >
> > Don't put kernel specifics into bindings.
>
> Will remove that. I'll clean up the documentation to indicate that
> this binding creates a panel orientation property unless the rotation
> is handled in the Timing Controller on the panel if that sounds fine.

Even if the timing ctrlr handles it, don't you still need to know what
the native orientation is?

> > > +
> > > +The panel driver may apply the rotation at the TCON level, which will
> >
> > What's TCON? Something Mediatek specific IIRC.
>
> The TCON is the Timing controller, which is on the panel. Every panel
> has one. I'll add to the doc that the TCON is in the panel, etc.
>
> >
> > > +make the panel look like it isn't rotated to the kernel and any other
> > > +software.
> > > +
> > > +If not, a panel orientation property should be added through the SoC
> > > +vendor DRM code using the drm_connector_init_panel_orientation_property
> > > +function.
> >
> > The 'rotation' property should be defined purely based on how the
> > panel is mounted relative to a device's orientation. If the display
> > pipeline has some ability to handle rotation, that's a feature of the
> > display pipeline and not the panel.
>
> This is how the panel orientation property is already handled in the
> kernel. See drivers/gpu/drm/i915/vlv_dsi.c for more details.

The point is your description is all about the kernel. This is a
binding which is not kernel specific.

> > > +
> > > +Example:
> >
> > This file is a collection of common properties. It shouldn't have an
> > example especially as this example is mostly non-common properties.
>
> Just copied one of our DTS entries that uses the property. I'll remove
> everything under compatible except for rotation and status.

Just remove the example or add what you want to the "boe,himax8279d8p"
binding doc. We are moving towards examples being compiled and
validated, so incomplete ones won't work.

Rob
