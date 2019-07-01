Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E454C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4073A21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qd4WduNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfGARFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:05:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44881 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfGARFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:05:55 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so30379684iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JolxjoC61TKJKf0jb4dN4P28SKpb+zH+zGH1st4ym90=;
        b=Qd4WduNYQlNNrJRAp36QmrwJY099eDBeJ105dOffHIB5X7OI66k1xlFc+yOJ0OeT8W
         JAeFJ2lUgNto0dagfE4x46ArMzjM/yE45uJXQQ80irLhpGEMjpsZkWyFodEwxLWk510o
         vqEu++m0gselpSMr634ICkAselddnefqJ4+VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JolxjoC61TKJKf0jb4dN4P28SKpb+zH+zGH1st4ym90=;
        b=UyEOSifVrOQXP5Sz06dApjkJ0jjBIj4+zWXzz5z/n7cP2hWY2s0uyxVsKTuojZGVdt
         6pMKmvhkcg1/ZVxkQOzdvJjN5zhYOcx5m3p1wgwTykGdBOp2yZvnk7UDxkN4aPdNYQWC
         WrVPXKBaGcpNLi/vThVSvBah6hBbQK/KVsWWI/onYzvLG40Q7Hj/yOxjy++XDZ4wPdPX
         1kbUbJkjmMz55+2oXMP6z9RHXzSXBiDAkvlUlnHkXws90alyKFEo93W+jJvpdhTbDkyI
         kCZtq2uBaTzyPO5i5IpOqfMvVsPbbAuoZ8aqvBgKJJpmYEIfwfiu+QHQddFXaimG9YVR
         8l8w==
X-Gm-Message-State: APjAAAWa6Bmq2OtI/LF/KQogp+RgQsCCoimMczGmBE6euDsK+2YQKphe
        Svq5BNvjxZXsqBHF0aNQ9nZypJ4IKLE=
X-Google-Smtp-Source: APXvYqw122v32WEOYU6eGFuWhtFlNhFqOre8/0sM6lcMnveGgeaz8h47rK88AsO4GZ13JBQozsDAzg==
X-Received: by 2002:a02:5a02:: with SMTP id v2mr29210978jaa.124.1562000754269;
        Mon, 01 Jul 2019 10:05:54 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id p3sm12759482iog.70.2019.07.01.10.05.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 10:05:54 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id r185so30445027iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:05:54 -0700 (PDT)
X-Received: by 2002:a02:6597:: with SMTP id u145mr30963069jab.26.1562000398582;
 Mon, 01 Jul 2019 09:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-2-dianders@chromium.org> <20190630200259.GA15102@ravnborg.org>
In-Reply-To: <20190630200259.GA15102@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Jul 2019 09:59:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3eiBXP4Z5KMxD=-csV5EAD9cY4MzuAOtMyphpDmW+_A@mail.gmail.com>
Message-ID: <CAD=FV=V3eiBXP4Z5KMxD=-csV5EAD9cY4MzuAOtMyphpDmW+_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to simple-panel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 30, 2019 at 1:03 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas.
>
> Some long overdue review feedback.
>
> On Mon, Apr 01, 2019 at 10:17:18AM -0700, Douglas Anderson wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> >
> > This patch adds a new subnode to simple-panel allowing us to override
> > the typical timing expressed in the panel's display_timing.
> >
> > Changes in v2:
> >  - Split out the binding into a new patch (Rob)
> >  - display-timings is a new section (Rob)
> >  - Use the full display-timings subnode instead of picking the timing
> >    out (Rob/Thierry)
> > Changes in v3:
> >  - Go back to using the timing subnode directly, but rename to
> >    panel-timing (Rob)
> > Changes in v4:
> >  - Simplify desc. for when override should be used (Thierry/Laurent)
> >  - Removed Rob H review since it's been a year and wording changed
> > Changes in v5:
> >  - Removed bit about OS may ignore (Rob/Ezequiel)
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/simple-pan=
el.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > index b2b872c710f2..93882268c0b9 100644
> > --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > @@ -15,6 +15,16 @@ Optional properties:
> >    (hot plug detect) signal, but the signal isn't hooked up so we shoul=
d
> >    hardcode the max delay from the panel spec when powering up the pane=
l.
> >
> > +panel-timing subnode
> > +--------------------
> > +
> > +This optional subnode is for devices which require a mode differing
> > +from the panel's "typical" display timing.
> Meybe add here that it is expected that the panel has included timing
> in the driver itself, and not as part of DT.
> So what is specified here is a more precise variant, within the limits
> of what is specified for the panel.

See discussions previous versions of this patch.  Specifically you can
see v4 at <https://patchwork.kernel.org/patch/10875505/> and v3
(posted by Sean) at <https://patchwork.kernel.org/patch/10207591/>.

Specifically: According to Rob H it is generally not required to
validate what's in device tree--it can be just blindly applied.  Thus
the bindings shouldn't really say anything about trying to reconcile
with the driver (especially since that's heavily relying on the
current driver implementation).

At the moment the driver still does validate things and we could
discuss removing that in a future patchset if it was deemed important
/ desirable.


> > +Format information on the panel-timing subnode can be found in
> > +display-timing.txt.
> display-timing defines otional properties:
> hsync-active, pixelclk-active, doublescan etc.
> It is not from the above obvious which properties from display-timings
> that can be specified for a panel-timing sub-node.
> Maybe because they can all be specified?
>
> Display-timing allows timings to be specified as a range.
> If it is also OK to specify a range for panle-timing then everythign is
> fine. But if the panel-timign subnode do not allow ranges this needs to
> be specified.

One thing to think about here is that the bindings are a bit divorced
from the real world.  Specifically the bindings should describe
hardware / what's possible and it's OK for bindings to describe things
that aren't yet supported in code.  You've gotta be really careful
here, of course, because it's easy to write ridiculous bindings if
there is no implementation backing them up, but in general that's
supposed to be the idea.

Here it seems like it should be possible to specify timings as a range
and that would be a sensible thing to do.  ...and we're already using
existing code to parse this node, specifically
of_get_display_timing().  If simple-panel can't (yet) handle
reconciling ranges specified in DT then presumably we shouldn't rely
on that yet.  ...but if it becomes useful then we can add it later.
...but it's OK to already have it in the bindings.

Did that make sense?  If I'm misunderstanding something about the
situation then please yell!  :-)

I will also note that perhaps we shouldn't nit-pick too much as per
Rob's comment in the cover letter [1] of v5 of the series.
Specifically he said this binding is going away anyway.

Summary: I think I have no actions here and this could go to drm-misc
with Theirry's Ack plus other tags.


[1] https://lore.kernel.org/patchwork/cover/1057038/
