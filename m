Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C377C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E36205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NgFqi0Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfDPM4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:56:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43579 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfDPM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:56:18 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so17469784iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRA+719Jb6DmH3m40XxxF+dPwu6yMsYrTAF586sH5GI=;
        b=NgFqi0HnLNs4Ixap/D6zOVxXcnbzDc1rcrLgaOKWHU7vxjksiwJSMZrwKKU/2VOTDf
         MYaCFjHNftGp+HGq9nZ+JP2a4N6aQeA2GV/qr7aNwAKTKOAw9FgndQWWSmYeodFCv9Kf
         JzlGHXSNkqGYzz+yGrL0dknCaOyXNi1FM79Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRA+719Jb6DmH3m40XxxF+dPwu6yMsYrTAF586sH5GI=;
        b=AhWyuEtSAU/CbhZ6RrnTrCueqt23wmMK15vgCuylEnKzmBUO5obE5Zs4tbcRf2mI5b
         oH/9JWlqlLN/YMEG47OKndfxVgOc1ln2zXglS1+tCDHn4cYmqWyVyHNReaPKsl3I/m3b
         nuL8dmx9SrqnORx0uPomo9lVqMOUjJ8f091FlFjem9+HhjUetvi6ye16Whe1jYxX4yUm
         16Py/PtTjATmk1Wwe7sa312cySuJw1aYXjkn1feK44tZ+F3axfV5xyK7MxY+crCnqpfK
         pnfGExZFUyAMbOaQVnTkj2yKkvVeJKT45PAfYZJhMeR/E1JKuDLnd0HHqazMM7eWEHD1
         uHZQ==
X-Gm-Message-State: APjAAAWFZTK9/5RWHw0syGIXwH7/bSBdDliKiZn29/qMDw1gvgqNaxSr
        bmIMGCoMgI71bVIAhy2Eghop1QQdvuArngfjbtoya9AALg4=
X-Google-Smtp-Source: APXvYqw3FsaIUUGWEThs+Fkg+EZ0n9mDftcBlIXEAfqIy1hVZnjI+rxCLqhUX4Bb6KWoz+ng2AQhk+Pit+Kvow7xtSM=
X-Received: by 2002:a5e:9805:: with SMTP id s5mr55319251ioj.149.1555419377116;
 Tue, 16 Apr 2019 05:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <1555078094-6587-2-git-send-email-ben.davis@arm.com>
 <20190415075922.GA24596@james-ThinkStation-P300> <20190415092045.GO15144@e110455-lin.cambridge.arm.com>
 <20190416073419.GN2665@phenom.ffwll.local> <20190416091658.GP15144@e110455-lin.cambridge.arm.com>
 <CAKMK7uEZge0=WOWB7MTJUtXUg-q1YEgTxRAY6krtsEmGWEbY0w@mail.gmail.com> <20190416124307.GQ15144@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190416124307.GQ15144@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 16 Apr 2019 14:56:05 +0200
Message-ID: <CAKMK7uHU7Vkv9ONgWnE=RmQq695NkxEqOmWi-3urBFL7L_Wg8Q@mail.gmail.com>
Subject: Re: [v2,1/2] drm: Add writeback_w,h properties
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>,
        Ben Davis <Ben.Davis@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:43 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Tue, Apr 16, 2019 at 11:55:34AM +0200, Daniel Vetter wrote:
> > On Tue, Apr 16, 2019 at 11:17 AM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > >
> > > On Tue, Apr 16, 2019 at 09:34:20AM +0200, Daniel Vetter wrote:
> > > > On Mon, Apr 15, 2019 at 10:20:45AM +0100, Liviu Dudau wrote:
> > > > > On Mon, Apr 15, 2019 at 08:59:30AM +0100, james qian wang (Arm Technology China) wrote:
> > > > > > Hi Ben:
> > > > > > Do we real need these two individual properties for specifing the writeback
> > > > > > w/h, can we use fb->w/h ?
> > > > > > And since these two properties are added as common and standard properties,
> > > > > > it influnce all existing write-back implementation which all assumed
> > > > > > writeback size as fb->w/h.
> > > > >
> > > > > The idea of having these additional properties was to maintain backwards
> > > > > compatibility (of some sort). If you don't set writeback_w/h then the
> > > > > assumption is that they are the same as fb->w/h, but I can see how it's
> > > > > going to be confusing to have fb->w/h different from crtc->w/h and
> > > > > different from writeback_w/h.
> > > >
> > > > Since we already have crtc_w/h independent of writeback_fb_w/h, do we need
> > > > another set of w/h? Are all the interactions between these tree
> > > > well-defined?
> > >
> > > No, we probably don't need another set of w/h values. As for the
> > > interaction, I propose the following:
> > >
> > > - writeback is only attached to a connector, so the crtc_x/y/w/h are the
> > >   "input source" parameters into the writeback. Given that we put in the
> > >   writeback the content of the CRTC, I suggest we ignore x,y (consider
> > >   them to be always 0 for the writeback output).
> >
> > There's no crtc_x/y.
>
> Bah, sorry about that!
>
> >                       And what I meant with crtc_w/h is
> > crtc_state->mode->h/vdisplay. And you can already express scaling with
> > that, by setting the plane_state->crtc_x/y/h/w parameters as you wish.
>
> We don't have a plane associated with the writeback, it's a connector
> with a framebuffer attached to it. :(

I meant the input planes, I know there's no output/writeback planes.
Afaiui what we want to do is:

planes -> plane composition hw -> some scaling -> writeback

We can model this already (I think at least, that's really my question
here) by adjustinv mode->h/vdisplay and ofc also adjusting dst_x/y/w/h
of all the input planes. But is that good enough?

With your proposal (either autoscaling per fb->w/h from the writeback
fb, or the writeback_w/h properties we'd have double-scaling:

planes -> plane composition hw -> some scaling (because of
crtc->mode.h/vdisplay) -> more scaling (due to writeback h/w, whether
as props or from the fb) -> writeback

Scaling twice with nothing else in the pipeline seems silly to me.

> > > - writeback has a framebuffer attached, so we can use the fb->w/h to
> > >   determine if we need to do any scaling of the output.
> >
> > Hm, not sure we want that. You might want to automatically round
> > fb->w/h to whatever (ok right now we don't do that I think anywhere),
> > so forcing the output to match the fb->h/w doesn't make sense for me.
> > It's also inconsistent with how we treat fb attached to planes (where
> > we have the full set of src coordinates).
>
> The writeback will have to fit into that framebuffer, so it can't be
> bigger than fb->w/h. Smaller, yes.

Yeah we should probably check that in core atomic code. Like we do
already for planes in drm_atomic_plane_check()

> > > > Atm I'm assuming that writeback is using crtc_w/h into the fb, at offset
> > > > 0, not scaled any further. But the planes themselves can be scaled into
> > > > the crtc_w/h window ofc.
> > >
> > > Our hardware has the ability to also write back one of the planes and
> > > scale it during writeback, but we have no way of expressing that in DRM
> > > via connectors, so we are going to ignore that case. The supported usecase
> > > is for the planes to be scaled into the "composition" area which is the size
> > > of the CRTC, and then writeback that to memory, possibly with scaling (we
> > > officially only going to support downscaling due to external dependencies
> > > on the memory clock that is needed for supporting upscaling).
> >
> > Hm, see above, you can already express that:
> > - set crtc_state->mode->h/vdisplay to what you want the resulting
> > writeback image to be sized at.
> > - place the plane however you want using the plane properties within
> > that crtc window.
>
> The way we agreed ~2 years ago in the community to implement this was to have
> the writeback as a connector that gets the "output" of the CRTC and writes it into
> memory rather than on phosphorus. We have not added a plane to that, but
> in hindsight we might find it would have been useful.

Still not talking about planes on the output side here :-) Adding a
plane would also just give you double-scaling (but with the benefit
that you can set writeback_x/y too, plus select a window of the
overall crtc to write back).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
