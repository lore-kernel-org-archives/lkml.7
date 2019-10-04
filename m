Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A79C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37AC21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Grs3Hqx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfJDKsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:48:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42046 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:48:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so7853394qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s4KyIYNFvQvXAmS2eAKBVZheKGwMRoWGvLGk+6JrzQs=;
        b=Grs3Hqx4k5f/bH59wO9Us/mIBV6O6+3wNBH50kyKKowfVG/IfQ9RWAKtzFe0iIAJcw
         /KhJwYZiPrXUopKZJWk/JNyIQyzdVSwiygf8DbcFPGugji6dRgOugDOaa1aynvkGCGSL
         wio2yd2CBp+v5zD0Z3a5mnEvUrYEPOz9lQpEWlpxVRmGopw62V1XKB58J6pryAWehbiB
         fmvjnz42abs2zhbD0fWdEH2CGlACSawN6wESeZtQN8i0bS0uc18vGOWDqbNuq7uX0g2+
         4FtXFJaHQOtIzbYI6bI3Yzb/iYIjyenzL70bL5f5TVYmNhX5kjvQNVdLtkvRX6geI239
         AnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s4KyIYNFvQvXAmS2eAKBVZheKGwMRoWGvLGk+6JrzQs=;
        b=FMKfTBxASWnbtedUUFomqhsykdsefvsAKAdsATw057yOIVTCEPJb6Aw3sqaa69U3Xp
         sse5Cy8CxxC6FNRgVKD7yhRuzYdzmrTWb6ZLTSByYnyt+iqOGu/C6enLgXH3ZrMwkRLV
         6N6ynj/6hfoie1VCDJ5B5Xk7rIn00hgpQ8+C66nu7FQDktrQ5CQJjrr+oineTl/u7vmB
         qLienvn+hCfJuiwMP9fQzx8cHogA+omKmucN3uRt1qpI20vZAtOdamDMlpOksVLQIqu6
         G0oAmzoCUyc2XLzRxbvWunF70o6AWQf6lYBHD0A1Lgd2IMDmXBLYpoBd/PLsb70GfWYm
         4COg==
X-Gm-Message-State: APjAAAUUEpnC2dE6VYEv4c4X4sB9GCc/4bLrQNWpsG2HDpAkiKlIkJkq
        weeQJy+KChdnaTR4N3RGslJH0aqeNFOP+YaXPiP9gQ==
X-Google-Smtp-Source: APXvYqzg0CFK2zDNbHhh1v6Bgx6PIq+2osWbk0x/b6Hirq0Z6Io/RhZU1Mz2FWrXmtJGKYeXdz2S8Ssi55WIJT84FbA=
X-Received: by 2002:ad4:41cf:: with SMTP id a15mr1045342qvq.233.1570186093170;
 Fri, 04 Oct 2019 03:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com> <20191003142738.GM1208@intel.com>
 <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
 <20191003150526.GN1208@intel.com> <CA+M3ks7-SNusVJsiHqrmy4AN+_OO5e1X=ZRN16Hj6f-V3GnVow@mail.gmail.com>
 <20191003154627.GQ1208@intel.com>
In-Reply-To: <20191003154627.GQ1208@intel.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 4 Oct 2019 12:48:02 +0200
Message-ID: <CA+M3ks4gpDdZTPdBYRd=CrwgEYiSWJbXqvtPb-0KpW1BhzvmEQ@mail.gmail.com>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 3 oct. 2019 =C3=A0 17:46, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> a =C3=A9crit :
>
> On Thu, Oct 03, 2019 at 05:37:15PM +0200, Benjamin Gaignard wrote:
> > Le jeu. 3 oct. 2019 =C3=A0 17:05, Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> a =C3=A9crit :
> > >
> > > On Thu, Oct 03, 2019 at 04:46:54PM +0200, Benjamin Gaignard wrote:
> > > > Le jeu. 3 oct. 2019 =C3=A0 16:27, Ville Syrj=C3=A4l=C3=A4
> > > > <ville.syrjala@linux.intel.com> a =C3=A9crit :
> > > > >
> > > > > On Mon, Sep 09, 2019 at 03:52:05PM +0200, Benjamin Gaignard wrote=
:
> > > > > > Fix warnings with W=3D1.
> > > > > > Few for_each macro set variables that are never used later.
> > > > > > Prevent warning by marking these variables as __maybe_unused.
> > > > > >
> > > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++---=
---------------
> > > > > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/=
drm/drm_atomic_helper.c
> > > > > > index aa16ea17ff9b..b69d17b0b9bd 100644
> > > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *stat=
e,
> > > > > >             struct drm_encoder *encoder)
> > > > > >  {
> > > > > >       struct drm_crtc_state *crtc_state;
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >
> > > > > Rather ugly. IMO would be nicer if we could hide something inside
> > > > > the iterator macros to suppress the warning.
> > > >
> > > > Ok but how ?
> > > > connector is assigned in the macros but not used later and we can't
> > > > set "__maybe_unused"
> > > > in the macro.
> > > > Does another keyword exist for that ?
> > >
> > > Stick a (void)(connector) into the macro?
> >
> > That could work but it will look strange inside the macro.
> >
> > >
> > > Another (arguably cleaner) idea would be to remove the connector/crtc=
/plane
> > > argument from the iterators entirely since it's redundant, and instea=
d just
> > > extract it from the appropriate new/old state as needed.
> > >
> > > We could then also add a for_each_connector_in_state()/etc. which omi=
t
> > > s the state arguments and just has the connector argument, for cases =
where
> > > you don't care about the states when iterating.
> >
> > That may lead to get a macro for each possible combination of used vari=
ables.
>
> We already have new/old/oldnew, so would "just" add one more.

Not just one, it will be one each new/old/oldnew macro to be able to distin=
guish
when connector is used or not.
And it will be the same for the for_each macros...

>
> >
> > >
> > > >
> > > > >
> > > > > >       struct drm_connector_state *old_connector_state, *new_con=
nector_state;
> > > > > >       int i;
> > > > > >
> > > > > > @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
> > > > > >  {
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *new_crtc_state;
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >       struct drm_connector_state *new_conn_state;
> > > > > >       int i;
> > > > > >       int ret;
> > > > > > @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_=
device *dev,
> > > > > >  {
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >       struct drm_connector_state *old_connector_state, *new_con=
nector_state;
> > > > > >       int i, ret;
> > > > > >       unsigned connectors_mask =3D 0;
> > > > > > @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *o=
ld_state,
> > > > > >  static void
> > > > > >  disable_outputs(struct drm_device *dev, struct drm_atomic_stat=
e *old_state)
> > > > > >  {
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >       struct drm_connector_state *old_conn_state, *new_conn_sta=
te;
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > > @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, str=
uct drm_atomic_state *old_state)
> > > > > >  {
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *new_crtc_state;
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >       struct drm_connector_state *new_conn_state;
> > > > > >       int i;
> > > > > >
> > > > > > @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_ena=
bles(struct drm_device *dev,
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *old_crtc_state;
> > > > > >       struct drm_crtc_state *new_crtc_state;
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >       struct drm_connector_state *new_conn_state;
> > > > > >       int i;
> > > > > >
> > > > > > @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(str=
uct drm_device *dev,
> > > > > >                                     struct drm_atomic_state *st=
ate,
> > > > > >                                     bool pre_swap)
> > > > > >  {
> > > > > > -     struct drm_plane *plane;
> > > > > > +     struct drm_plane __maybe_unused *plane;
> > > > > >       struct drm_plane_state *new_plane_state;
> > > > > >       int i, ret;
> > > > > >
> > > > > > @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct=
 drm_device *dev,
> > > > > >               struct drm_atomic_state *old_state)
> > > > > >  {
> > > > > >       struct drm_crtc *crtc;
> > > > > > -     struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > > +     struct drm_crtc_state __maybe_unused *old_crtc_state, *ne=
w_crtc_state;
> > > > > >       int i, ret;
> > > > > >       unsigned crtc_mask =3D 0;
> > > > > >
> > > > > > @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struc=
t *work)
> > > > > >  int drm_atomic_helper_async_check(struct drm_device *dev,
> > > > > >                                  struct drm_atomic_state *state=
)
> > > > > >  {
> > > > > > -     struct drm_crtc *crtc;
> > > > > > +     struct drm_crtc __maybe_unused *crtc;
> > > > > >       struct drm_crtc_state *crtc_state;
> > > > > >       struct drm_plane *plane =3D NULL;
> > > > > >       struct drm_plane_state *old_plane_state =3D NULL;
> > > > > > @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct=
 drm_atomic_state *state,
> > > > > >  {
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > > -     struct drm_connector *conn;
> > > > > > +     struct drm_connector __maybe_unused *conn;
> > > > > >       struct drm_connector_state *old_conn_state, *new_conn_sta=
te;
> > > > > > -     struct drm_plane *plane;
> > > > > > +     struct drm_plane __maybe_unused *plane;
> > > > > >       struct drm_plane_state *old_plane_state, *new_plane_state=
;
> > > > > >       struct drm_crtc_commit *commit;
> > > > > >       int i, ret;
> > > > > > @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vbla=
nk);
> > > > > >   */
> > > > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state =
*old_state)
> > > > > >  {
> > > > > > -     struct drm_crtc *crtc;
> > > > > > +     struct drm_crtc __maybe_unused *crtc;
> > > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > >       struct drm_crtc_commit *commit;
> > > > > >       int i;
> > > > > > @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cl=
eanup_done);
> > > > > >  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> > > > > >                                    struct drm_atomic_state *sta=
te)
> > > > > >  {
> > > > > > -     struct drm_connector *connector;
> > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >       struct drm_connector_state *new_conn_state;
> > > > > >       struct drm_plane *plane;
> > > > > >       struct drm_plane_state *new_plane_state;
> > > > > > @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct =
drm_device *dev,
> > > > > >  {
> > > > > >       struct drm_atomic_state *state;
> > > > > >       struct drm_connector_state *conn_state;
> > > > > > -     struct drm_connector *conn;
> > > > > > +     struct drm_connector __maybe_unused *conn;
> > > > > >       struct drm_plane_state *plane_state;
> > > > > > -     struct drm_plane *plane;
> > > > > > +     struct drm_plane __maybe_unused *plane;
> > > > > >       struct drm_crtc_state *crtc_state;
> > > > > >       struct drm_crtc *crtc;
> > > > > >       int ret, i;
> > > > > > @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated=
_state(struct drm_atomic_state *state,
> > > > > >  {
> > > > > >       int i, ret;
> > > > > >       struct drm_plane *plane;
> > > > > > -     struct drm_plane_state *new_plane_state;
> > > > > > +     struct drm_plane_state __maybe_unused *new_plane_state;
> > > > > >       struct drm_connector *connector;
> > > > > > -     struct drm_connector_state *new_conn_state;
> > > > > > +     struct drm_connector_state __maybe_unused *new_conn_state=
;
> > > > > >       struct drm_crtc *crtc;
> > > > > > -     struct drm_crtc_state *new_crtc_state;
> > > > > > +     struct drm_crtc_state __maybe_unused *new_crtc_state;
> > > > > >
> > > > > >       state->acquire_ctx =3D ctx;
> > > > > >
> > > > > > --
> > > > > > 2.15.0
> > > > > >
> > > > > > _______________________________________________
> > > > > > dri-devel mailing list
> > > > > > dri-devel@lists.freedesktop.org
> > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >
> > > > > --
> > > > > Ville Syrj=C3=A4l=C3=A4
> > > > > Intel
> > >
> > > --
> > > Ville Syrj=C3=A4l=C3=A4
> > > Intel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
