Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69963C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182292070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WMuMjmBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfECOGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:06:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34873 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfECOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:06:40 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so9191908itb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NEBK+itDqLpaQzIiXTglWmxEFdhux7VlnZizVOQVIVc=;
        b=WMuMjmBx3lj6x38iGJVNcwBasFWkyxZY/OqpxZe09YEBiIPfqGr/S5o8pymnTbx6D4
         bgmmYDVAbZTDfXHZkLaOGm36AopBmxEg9ccL2L41NSw1NKiOHxkG+fwKpS+reUcYE1lz
         8s/QZWs3SHuBOvxuSArQcApKc+W687e0QOzsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NEBK+itDqLpaQzIiXTglWmxEFdhux7VlnZizVOQVIVc=;
        b=lFWy3NGXYUjLQDmu2MEqebOKvL18mUIIVJQmJVNshNYs0rfw+eoyKhI1NAZttH1nZA
         YAZDSE6AFQ26C2StmYXconIIFLXXLuMoRNYBQRZoihlOerfZL7qgaf34Ix8crPRVV7P1
         IyPsgvh8r8NNz5QEIhGodJIImV1gl79W0qXH3rilj5ZHNikAQ8/+PiadzLe0t/KU5+tD
         X91rd20z6+fwEU2ipXaa2QJLIwvgTJXOazqM6DlYVdJHnQRB0hUedydayjBvT7V+yia3
         GimVGSEQy1ra7Rhk++Y4h2VYZTAS2ZTyXAIXKkZHUoEPrqL6IDFFGRpjTnPPsj9WVclQ
         zLcw==
X-Gm-Message-State: APjAAAXPIj4S9xNElEKbRwBWs6QLUk7mD8WmfHzGmF2DVTPJiawj56ZK
        w1oeDyUSg40qrpKIEnjYK/AgshEr3lmv79Gw5M6ELg==
X-Google-Smtp-Source: APXvYqzH4Ia8Df5BIyy/IJAAdZ7fahWpKTdOWq9tGBOK0qtZumiXSF1VYx81MR/m53eJ4VxgYzFudJh3oq1nwY+FHUk=
X-Received: by 2002:a24:6f48:: with SMTP id x69mr6921488itb.117.1556892399225;
 Fri, 03 May 2019 07:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190502194956.218441-1-sean@poorly.run> <20190502194956.218441-3-sean@poorly.run>
 <20190503081851.GI3271@phenom.ffwll.local> <20190503124737.GH17077@art_vandelay>
In-Reply-To: <20190503124737.GH17077@art_vandelay>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 3 May 2019 16:06:28 +0200
Message-ID: <CAKMK7uGcpFJdXF1xmyMfToT+Vdhe2Q5hQWCNc-grFnq+cMVg5A@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] drm: Add drm_atomic_crtc_state_for_encoder helper
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 2:47 PM Sean Paul <sean@poorly.run> wrote:
> On Fri, May 03, 2019 at 10:18:51AM +0200, Daniel Vetter wrote:
> > On Thu, May 02, 2019 at 03:49:44PM -0400, Sean Paul wrote:
> > > From: Sean Paul <seanpaul@chromium.org>
> > >
> > > This patch adds a helper to tease out the currently connected crtc fo=
r
> > > an encoder, along with its state. This follows the same pattern as th=
e
> > > drm_atomic_crtc_*_for_* macros in the atomic helpers. Since the
> > > relationship of crtc:encoder is 1:n, we don't need a loop since there=
 is
> > > only one crtc per encoder.
> >
> > No idea which macros you mean, couldn't find them.
>
> No longer relevant with the changes below, but for completeness, I was tr=
ying to
> refer to drm_atomic_crtc_state_for_each_plane and friends. I see now that=
 I
> wasn't terribly clear :)
>
>
> > >
> > > Instead of splitting this into 3 functions which all do the same thin=
g,
> > > this is presented as one function. Perhaps that's too ugly and it sho=
uld
> > > be split to:
> > > struct drm_crtc *drm_atomic_crtc_for_encoder(state, encoder);
> > > struct drm_crtc_state *drm_atomic_new_crtc_state_for_encoder(state, e=
ncoder);
> > > struct drm_crtc_state *drm_atomic_old_crtc_state_for_encoder(state, e=
ncoder);
> > >
> > > Suggestions welcome.
> > >
> > > Changes in v3:
> > > - Added to the set
> > >
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 48 +++++++++++++++++++++++++++=
++
> > >  include/drm/drm_atomic_helper.h     |  6 ++++
> > >  2 files changed, 54 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/dr=
m_atomic_helper.c
> > > index 71cc7d6b0644..1f81ca8daad7 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -3591,3 +3591,51 @@ int drm_atomic_helper_legacy_gamma_set(struct =
drm_crtc *crtc,
> > >     return ret;
> > >  }
> > >  EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
> > > +
> > > +/**
> > > + * drm_atomic_crtc_state_for_encoder - Get crtc and new/old state fo=
r an encoder
> > > + * @state: Atomic state
> > > + * @encoder: The encoder to fetch the crtc information for
> > > + * @crtc: If not NULL, receives the currently connected crtc
> > > + * @old_crtc_state: If not NULL, receives the crtc's old state
> > > + * @new_crtc_state: If not NULL, receives the crtc's new state
> > > + *
> > > + * This function finds the crtc which is currently connected to @enc=
oder and
> > > + * returns it as well as its old and new state. If there is no crtc =
currently
> > > + * connected, the function will clear @crtc, @old_crtc_state, @new_c=
rtc_state.
> > > + *
> > > + * All of @crtc, @old_crtc_state, and @new_crtc_state are optional.
> > > + */
> > > +void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *stat=
e,
> > > +                                  struct drm_encoder *encoder,
> > > +                                  struct drm_crtc **crtc,
> > > +                                  struct drm_crtc_state **old_crtc_s=
tate,
> > > +                                  struct drm_crtc_state **new_crtc_s=
tate)
> > > +{
> > > +   struct drm_crtc *tmp_crtc;
> > > +   struct drm_crtc_state *tmp_new_crtc_state, *tmp_old_crtc_state;
> > > +   u32 enc_mask =3D drm_encoder_mask(encoder);
> > > +   int i;
> > > +
> > > +   for_each_oldnew_crtc_in_state(state, tmp_crtc, tmp_old_crtc_state=
,
> > > +                                 tmp_new_crtc_state, i) {
> >
> > So there's two ways to do this:
> >
> > - Using encoder_mask, which is a helper thing. In that case I'd rename
> >   this to drm_atomic_helper_crtc_for_encoder.
> >
> > - By looping over the connectors, and looking at ->best_encoder and
> >   ->crtc, see drm_encoder_get_crtc in drm_encoder.c. That's the core wa=
y
> >   of doing things. In that case call it drm_atomic_crtc_for_encoder, an=
d
> >   put it into drm_atomic.c.
> >
> > There's two ways of doing the 2nd one: looping over connectors in a
> > drm_atomic_state, or the connector list overall. First requires that th=
e
> > encoder is already in drm_atomic_state (which I think makes sense).
>
> Yeah, I wasn't particularly interested in encoders not in state. I had
> considered going the connector route, but since you can have multiple con=
nectors
> per encoder, going through crtc seemed a bit more direct.

You can have multiple possible connectors for a given encoder, and
multiple possible encoders for a given connector. In both cases the
driver picks for you. But for active encoders and connectors the
relationship is 1:1. That's what the helpers exploit by looping over
connectors to get at encoders.

> > Even more complications on old/new_crtc_state: Is that the old state fo=
r
> > the old crtc, or the old state for the new crtc (that can switch too).
> > Same for the new crtc state ...
> >
> > tldr; I'd create 2 functions:
> >
> > drm_crtc *drm_atomic_encoder_get_new_crtc(drm_atomic_state *state, enco=
der)
> > drm_crtc *drm_atomic_encoder_get_old_crtc(drm_atomic_state *state, enco=
der)
> >
> > With the requirement that they'll return NULL if the encder isn't in in
> > @state, and implemented using looping over connectors in @state.
>
> It seems like we could just tweak this function a bit to get the new or o=
ld crtc
> for an encoder. Any particular reason for going through connector instead=
? Is it
> to avoid the encoder_mask which is a helper thing? In that case, perhaps =
this
> should use connector links and live in drm_atomic.c?

Well as explained, there's 3 ways you can achieve the same really. I
do think the "loop over connectors in drm_atomic_state, WARN() if we
haven't found the encoder you want the crtc for" is probably the most
solid aproach since it picks up a core atomic concept. But the others
(looping the connector list, or looping encoder_mask) all work too.

Aside: plane/encoder_mask was added to go from crtc to
planes/encoders, not really to go the other way round.

Another solution would be to pass the connector_state to all atomic
encoder hooks, then you could just look at connector_state->crtc. Plus
you can get at all the other interesting bits and pieces of
information. In a way this is fallout from us keeping encoders as a
meaningful concept for easier transition of legacy drivers, while
still keeping them entirely irrelevant for the actual userspace api
semantics.

So maybe we want drm_atomic_encoder_get_old/new_connector here. Or
maybe we even want the full set of functions, i.e.
drm_atomic_encoder_get_old/new_connector/crtc.

In all cases I think only returning the object, not it's state is
simplest, since then you avoid the confusion of old/new state for
old/new obj.
-Daniel


> Thanks for the review!
>
> Sean
>
> >
> > tldr; this is a lot more tricky than it looks like ...
> > -Daniel
> >
> >
> > > +           if (!(tmp_new_crtc_state->encoder_mask & enc_mask))
> > > +                   continue;
> > > +
> > > +           if (new_crtc_state)
> > > +                   *new_crtc_state =3D tmp_new_crtc_state;
> > > +           if (old_crtc_state)
> > > +                   *old_crtc_state =3D tmp_old_crtc_state;
> > > +           if (crtc)
> > > +                   *crtc =3D tmp_crtc;
> > > +           return;
> > > +   }
> > > +
> > > +   if (new_crtc_state)
> > > +           *new_crtc_state =3D NULL;
> > > +   if (old_crtc_state)
> > > +           *old_crtc_state =3D NULL;
> > > +   if (crtc)
> > > +           *crtc =3D NULL;
> > > +}
> > > +EXPORT_SYMBOL(drm_atomic_crtc_state_for_encoder);
> > > diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic=
_helper.h
> > > index 58214be3bf3d..2383550a0cc8 100644
> > > --- a/include/drm/drm_atomic_helper.h
> > > +++ b/include/drm/drm_atomic_helper.h
> > > @@ -153,6 +153,12 @@ int drm_atomic_helper_legacy_gamma_set(struct dr=
m_crtc *crtc,
> > >                                    uint32_t size,
> > >                                    struct drm_modeset_acquire_ctx *ct=
x);
> > >
> > > +void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *stat=
e,
> > > +                                  struct drm_encoder *encoder,
> > > +                                  struct drm_crtc **crtc,
> > > +                                  struct drm_crtc_state **old_crtc_s=
tate,
> > > +                                  struct drm_crtc_state **new_crtc_s=
tate);
> > > +
> > >  /**
> > >   * drm_atomic_crtc_for_each_plane - iterate over planes currently at=
tached to CRTC
> > >   * @plane: the loop cursor
> > > --
> > > Sean Paul, Software Engineer, Google / Chromium OS
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
