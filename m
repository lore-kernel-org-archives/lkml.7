Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7821D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMAN3fdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfKMKES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:04:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38583 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfKMKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:04:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id v8so1859391ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+8BQXrFfd7vVPmmII5MsvQgRN4CoXbnwomYZzYOuqY=;
        b=mMAN3fdIVYqvkW+CCwE1FaCWLT/+gk7vKGNzCppol6zgvEuroWh9/jm7pl4xT8LIGX
         3LjJ3sR8oUGViV3RJEyRlI7im8IbX48BTncshoWro0q7EL4bbvzjEymw4MTqwEcf9jtI
         9BWNAEe43iBAc2tXQvJeo7HfELxKrC3V99rStbt8WYXVbh8Z0db4yl5ang30F9LnZxn9
         ZYgpU+bzQRKAyFCzqmIVuvD822+mOYDUqOye8/CbIl2fbIDHENMjxIwxeFfJvjZhkiT3
         Ps4mcdrA/v0jpDT8QJIq1TNkd5GeNrPpsf/Tcf7kcu+1z5O6lyGbZBuhWiByv7fUMHvg
         D76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+8BQXrFfd7vVPmmII5MsvQgRN4CoXbnwomYZzYOuqY=;
        b=goO8rVij7DOn34KEgSgO+ROPYOjd9XHWC2j2HDyimtFOCPTsNQNflQHyTSfGoTsyCU
         RBdj+jtcTaoyICQ485w0HUUcCN+0ATEqPCCi86FOByukZ8EPjFamRnNP1+gorv+cDqB4
         QO06rLX7chyDDdNF6t13CFBIVg6AgL8AKRsGM4Obworu8F9UsLTb8KyikiTRtt0TG/UA
         clxLYnVgO4MyY8/QWMoBOarAIRYjDlhVx2QpdKwD8Y5bOsv2Vm27vJBUE5ljxtUilJ6I
         XGJDyl6soTHuKJw0elK3t0Jh0zxs/FJREmhCRGVdm8cWrfmOmoo5oaZPZnc4H1qLCz6t
         JnIg==
X-Gm-Message-State: APjAAAV8HWZkVrR/vt9O6RzqSIt2XnuMfzhV700aWBn39q3sfjQn2m53
        ZorQUOG7Q/QjTQX52EmcUOP7XXO43EV8/GGClVw=
X-Google-Smtp-Source: APXvYqzrkpAd6Hpz3oz1kJ9bkYQ6lCyOOdYOttbdfnR7t7OIB4Lor9ihWI0dnmDs0iE8LILZppn3CI05bzG6SSFxJnw=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr1762023ljh.44.1573639450872;
 Wed, 13 Nov 2019 02:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20191107153048.843881-1-paul.kocialkowski@bootlin.com>
 <CAMeQTsYG+YvXqQqvJvsxT1h0z5zZJbdCtc5wPjUossvwidV=cA@mail.gmail.com>
 <20191112151157.GD4506@aptenodytes> <20191112155012.GE4506@aptenodytes>
In-Reply-To: <20191112155012.GE4506@aptenodytes>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 13 Nov 2019 11:04:00 +0100
Message-ID: <CAMeQTsb0+Tc9Gij_1zMH=mPSbDAjMkMEFatvZrfjLvVsQGwVgA@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Fixup fbdev stolen size usage evaluation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 4:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Tue 12 Nov 19, 16:11, Paul Kocialkowski wrote:
> > Hi,
> >
> > On Tue 12 Nov 19, 11:20, Patrik Jakobsson wrote:
> > > On Thu, Nov 7, 2019 at 4:30 PM Paul Kocialkowski
> > > <paul.kocialkowski@bootlin.com> wrote:
> > > >
> > > > psbfb_probe performs an evaluation of the required size from the stolen
> > > > GTT memory, but gets it wrong in two distinct ways:
> > > > - The resulting size must be page-size-aligned;
> > > > - The size to allocate is derived from the surface dimensions, not the fb
> > > >   dimensions.
> > > >
> > > > When two connectors are connected with different modes, the smallest will
> > > > be stored in the fb dimensions, but the size that needs to be allocated must
> > > > match the largest (surface) dimensions. This is what is used in the actual
> > > > allocation code.
> > > >
> > > > Fix this by correcting the evaluation to conform to the two points above.
> > > > It allows correctly switching to 16bpp when one connector is e.g. 1920x1080
> > > > and the other is 1024x768.
> > > >
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/gma500/framebuffer.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
> > > > index 218f3bb15276..90237abee088 100644
> > > > --- a/drivers/gpu/drm/gma500/framebuffer.c
> > > > +++ b/drivers/gpu/drm/gma500/framebuffer.c
> > > > @@ -462,6 +462,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
> > > >                 container_of(helper, struct psb_fbdev, psb_fb_helper);
> > > >         struct drm_device *dev = psb_fbdev->psb_fb_helper.dev;
> > > >         struct drm_psb_private *dev_priv = dev->dev_private;
> > > > +       unsigned int fb_size;
> > > >         int bytespp;
> > > >
> > > >         bytespp = sizes->surface_bpp / 8;
> > > > @@ -471,8 +472,11 @@ static int psbfb_probe(struct drm_fb_helper *helper,
> > > >         /* If the mode will not fit in 32bit then switch to 16bit to get
> > > >            a console on full resolution. The X mode setting server will
> > > >            allocate its own 32bit GEM framebuffer */
> > > > -       if (ALIGN(sizes->fb_width * bytespp, 64) * sizes->fb_height >
> > > > -                       dev_priv->vram_stolen_size) {
> > > > +       fb_size = ALIGN(sizes->surface_width * bytespp, 64) *
> > > > +                 sizes->surface_height;
> > > > +       fb_size = ALIGN(fb_size, PAGE_SIZE);
> > > > +
> > > > +       if (fb_size > dev_priv->vram_stolen_size) {
> > >
> > > psb_gtt_alloc_range() already aligns by PAGE_SIZE for us. Looks like
> > > we align a couple of times extra for luck. This needs cleaning up
> > > instead of adding even more aligns.
> >
> > I'm not sure this is really for luck. As far as I can see, we need to do it
> > properly for this size estimation since it's the final size that will be
> > allocated (and thus needs to be available in whole).

Ok now I understand what you meant. Actually vram_stolen_size is
always page aligned so fb_size doesn't need any page alignment here.
There is also no need to align for psbfb_create() since it also takes
care of this.

> >
> > For the other times there is explicit alignment, they seem justified too:
> > - in psb_gem_create: it is common to pass the aligned size when creating the
> >   associated GEM object with drm_gem_object_init, even though it's probably not
> >   crucial given that this is not where allocation actually happens;
> > - in psbfb_create: the full size is apparently only really used to memset 0
> >   the allocated buffer. I think this makes sense for security reasons (and not
> >   leak previous contents in the additional space required for alignment).

What I would prefer is to have a single place where the alignment is
made so any hardware requirements would be transparent to the rest of
the code.

Best would be if alignment is only made in psb_gtt_alloc_range() and
then store the actual size in struct gtt_range. That way we can just
pass along that value to memset() and drm_gem_object_init() without
caring about how it is adjusted.

> >
> > What strikes me however is that each call to psb_gtt_alloc_range takes the
> > alignment as a parameter when it's really always PAGE_SIZE, so it should
> > probably just be hardcoded in the call to allocate_resource.

This is a remnant from trying to add support for 2D and/or overlay
planes (don't really remember). Doesn't matter if it stays or goes
away.

> >
> > What do you think?

I suppose most of this is outside the scope of what you're trying to
do so we can just leave it as is and I can clean it up later.

> >
> > > Your size calculation looks correct and indeed makes my 1024x600 +
> > > 1920x1080 setup actually display something, but for some reason I get
> > > an incorrect panning on the smaller screen and stale data on the
> > > surface only visible by the larger CRTC. Any idea what's going on?
> >
> > I'm not seeing this immediately, but I definitely have something strange
> > after having printed more lines than the smallest display can handle or
> > scrolling, where more than the actual size of the fb is used.
> >
> > Maybe this is related to using the PowerVR-accelerated fb ops, that aren't
> > quite ready for this use case?
> >
> > I'll give it a try with psbfb_roll_ops and psbfb_unaccel_ops instead to see
> > if it changes something for me. Maybe it would help for you too?
>
> Some quick feedback about that:
> - psbfb_unaccel_ops gives a correct result where the scrolling area is bound
>   to the smallest display;

Yes, this also works correctly for me.

> - psbfb_roll_ops gives a working scrolling but bound to the largest display
>   (so the current shell line becomes invisible on the smallest one eventually);

It's not panning at all for me. I never really found gtt rolling to be
useful. It's a neat trick but I didn't have a problem with console
scrolling speed to begin with. I might just remove it.

> - psbfb_ops gives the same issue as above and seems to add artifacts on top.

Did you try this on CDV? There's only 2D acceleration on Poulsbo and Oaktrail.

>
> There's probably limited interest in working on that aspect on our side though.
> I'd be interested to know if it affects the issue you're seeing though.

Focus on your requirements and I'll look at the rest.

-Patrik

>
> Cheers,
>
> Paul
>
> > I suspect that the generic implementation is already bullet-proof for these
> > kinds of use case.
> >
> > Cheers and thanks for the feedback,
> >
> > Paul
> >
> > >
> > > >                  sizes->surface_bpp = 16;
> > > >                  sizes->surface_depth = 16;
> > > >          }
> > > > --
> > > > 2.23.0
> > > >
> >
> > --
> > Paul Kocialkowski, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
>
>
>
> --
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
