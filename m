Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C982075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bz8IFqRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfECOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:08:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40832 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfECOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:08:26 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so9161396itb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mywQSvXnzPWdYm7sqN7pr6yE7ta1JE5z/K6q1zKHbLQ=;
        b=bz8IFqRMleRvEpDmDQtUsFHR4Qnih+qSx7sD9kv6t8qZcTC+d81SA9X7ZcCT+pIjKL
         0It3KlJdG49+2RVbefKBMH/jxyvEEfd0sA2hGJHrXfVF5GwVM7AGkGPoS3JX8JtHxPts
         ozJA2ubxGvXqLYxGVB70J87PAUXmyQsatCbPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mywQSvXnzPWdYm7sqN7pr6yE7ta1JE5z/K6q1zKHbLQ=;
        b=PBCrrK79a7gw8pByqtdlE3tvzkmWRnwpqq6ozYh/PrUUAwaetaht2VIxcUWplvF5wz
         T8+iIvvYoHcu7mgifynNGcvaA98tzOyigyHcuWkw+Mg0zhSuNXECFuk6BsGUOf9Q+Bne
         gGGsyr8FY3XQGFub8PpnpxwyGiu5pfc8oSmUtLXLNIiEtXk+ofi35QPKRNzY+dpSkFSK
         mBstaeJ+AdGuzuIHVbVRdBtbxnbMXpeod4Aq2bDxK35t6KQtfK38CVwhzJ/pPs8zignm
         DJ3Q/Pn1wgZGfX+EtNhKpJYgM70F9c0spYq35Q1FXyBqgmXbpjoDM6wEvVjLDT1/qpvY
         o+Zw==
X-Gm-Message-State: APjAAAUgWImUtpf9UsHjzPx+YByymS5rH1n6liieDowO/7iiKr0rH3KD
        XyvEexl2pldQux7JNSRl8DRFhfksUQ0iwCGEY+0+Zw==
X-Google-Smtp-Source: APXvYqziTAkOv7m6A+Pg9MD72zm9a6DdDVSye7RwShJOceiOCfoRVwW8+N3hivyUQu93vgH+SrPy9Li1/Poipp5iNU0=
X-Received: by 2002:a24:39c6:: with SMTP id l189mr7201528ita.51.1556892505687;
 Fri, 03 May 2019 07:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190502194956.218441-1-sean@poorly.run> <20190502194956.218441-2-sean@poorly.run>
 <20190503075130.GH3271@phenom.ffwll.local> <20190503123452.GG17077@art_vandelay>
In-Reply-To: <20190503123452.GG17077@art_vandelay>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 3 May 2019 16:08:14 +0200
Message-ID: <CAKMK7uHO6rT=khqFrG7Saxxk_NZCC=rCYwATLUt1Cd_z+gh4rQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] drm: Add atomic variants of enable/disable to
 encoder helper funcs
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

On Fri, May 3, 2019 at 2:34 PM Sean Paul <sean@poorly.run> wrote:
>
> On Fri, May 03, 2019 at 09:51:30AM +0200, Daniel Vetter wrote:
> > On Thu, May 02, 2019 at 03:49:43PM -0400, Sean Paul wrote:
> > > From: Sean Paul <seanpaul@chromium.org>
> > >
> > > This patch adds atomic_enable and atomic_disable callbacks to the
> > > encoder helpers. This will allow encoders to make informed decisions =
in
> > > their start-up/shutdown based on the committed state.
> > >
> > > Aside from the new hooks, this patch also introduces the new signatur=
e
> > > for .atomic_* functions going forward. Instead of passing object stat=
e
> > > (well, encoders don't have atomic state, but let's ignore that), we p=
ass
> > > the entire atomic state so the driver can inspect more than what's
> > > happening locally.
> > >
> > > This is particularly important for the upcoming self refresh helpers.
> > >
> > > Changes in v3:
> > > - Added patch to the set
> > >
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c      |  6 +++-
> > >  include/drm/drm_modeset_helper_vtables.h | 45 ++++++++++++++++++++++=
++
> > >  2 files changed, 50 insertions(+), 1 deletion(-)
>
> /snip
>
> > > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/d=
rm_modeset_helper_vtables.h
> > > index 8f3602811eb5..de57fb40cb6e 100644
> > > --- a/include/drm/drm_modeset_helper_vtables.h
> > > +++ b/include/drm/drm_modeset_helper_vtables.h
> > > @@ -675,6 +675,51 @@ struct drm_encoder_helper_funcs {
> > >     enum drm_connector_status (*detect)(struct drm_encoder *encoder,
> > >                                         struct drm_connector *connect=
or);
> > >
> > > +   /**
> > > +    * @atomic_disable:
> > > +    *
> > > +    * This callback should be used to disable the encoder. With the =
atomic
> > > +    * drivers it is called before this encoder's CRTC has been shut =
off
> > > +    * using their own &drm_crtc_helper_funcs.atomic_disable hook. If=
 that
> > > +    * sequence is too simple drivers can just add their own driver p=
rivate
> > > +    * encoder hooks and call them from CRTC's callback by looping ov=
er all
> > > +    * encoders connected to it using for_each_encoder_on_crtc().
> > > +    *
> > > +    * This callback is a variant of @disable that provides the atomi=
c state
> > > +    * to the driver. It takes priority over @disable during atomic c=
ommits.
> > > +    *
> > > +    * This hook is used only by atomic helpers. Atomic drivers don't=
 need
> > > +    * to implement it if there's no need to disable anything at the =
encoder
> > > +    * level. To ensure that runtime PM handling (using either DPMS o=
r the
> > > +    * new "ACTIVE" property) works @atomic_disable must be the inver=
se of
> > > +    * @atomic_enable.
> > > +    */
> >
> > I'd add something like "For atomic drivers also consider @atomic_disabl=
e"
> > to the kerneldoc of @disable (before the NOTE: which is only relevant f=
or
> > pre-atomic). Same for the enable side.
> >
> > > +   void (*atomic_disable)(struct drm_encoder *encoder,
> > > +                          struct drm_atomic_state *state);
> > > +
> > > +   /**
> > > +    * @atomic_enable:
> > > +    *
> > > +    * This callback should be used to enable the encoder. It is call=
ed
> > > +    * after this encoder's CRTC has been enabled using their own
> > > +    * &drm_crtc_helper_funcs.atomic_enable hook. If that sequence is
> > > +    * too simple drivers can just add their own driver private encod=
er
> > > +    * hooks and call them from CRTC's callback by looping over all e=
ncoders
> > > +    * connected to it using for_each_encoder_on_crtc().
> > > +    *
> > > +    * This callback is a variant of @enable that provides the atomic=
 state
> > > +    * to the driver. It is called in place of @enable during atomic
> > > +    * commits.
> >
> > needs to be adjusted here for "takes priority".
>
> Can you clarify this comment? I'm a little fuzzy on what it means.

Further up I suggest that @atomic_disable should take priority over
all the others (plus explain why @disable is lower than @prepare,
because of the special semantics this has in legacy crtc helpers).
Once you do that you also need to adjust the wording in the kerneldoc
here (same wording as in @atomic_enable sounds good to me), i.e.
explain that @atomic_disable takes priority over all other hooks.
-Daniel

>
>
>
> > > +    *
> > > +    * This hook is used only by atomic helpers, for symmetry with @d=
isable.
> > > +    * Atomic drivers don't need to implement it if there's no need t=
o
> > > +    * enable anything at the encoder level. To ensure that runtime P=
M
> > > +    * handling (using either DPMS or the new "ACTIVE" property) work=
s
> > > +    * @enable must be the inverse of @disable for atomic drivers.
> > > +    */
> > > +   void (*atomic_enable)(struct drm_encoder *encoder,
> > > +                         struct drm_atomic_state *state);
> > > +
> >
> > With the nits:
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Thanks!
>
> Sean
>
> >
> > >     /**
> > >      * @disable:
> > >      *
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
