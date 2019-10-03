Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E8C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3A620700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZCM2a1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfJCOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:47:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36388 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfJCOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:47:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so2631212qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLUc+EHoyxOyOiHrZOLYXj4Hf3H02RK9IUJ5/D7F1nw=;
        b=UZCM2a1jzQ/X5fiJIfFemT5V7Z65XfFCfchqiu0kFzulkulIDDOy0bUnxvleVCtjI8
         7xRnD95yQLjXTRk9OiSeaEmjEcCF0bmx8LBQF0p06UxvWM7mvoiRp1/ucKbP3plsLm/A
         ETdgipozpGBAbQ8G3fWEQ1z7hSKBDw8XP8j9bF9xX7W0yARdT3kvWg5h1ypG3uA/ckaH
         KpB29nh6VEl5E5TR0DQwiSRpnxmDJuemhQzcQ57FX079f1h43CluBsj633VEZ2zYKpgo
         dOBZtbgB0Jq/0ifclgJNGp+Zjz8I+oPtY4p/E4Xl6BFkh++Eo5sfbBbscI1Y1pjF/D9I
         YaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLUc+EHoyxOyOiHrZOLYXj4Hf3H02RK9IUJ5/D7F1nw=;
        b=TpQVXUnL1e3qdkX2LlnxsFsztv39UNqVE4kAgKIWPuMr6ncdYPdVWfkPpHO/4MCZL8
         dcJGWuNEK2bU5PL0Ht6s2hDrkno0CyVvNDVM8In/VNvxdV6blggkRgonQOBS5O34Disd
         qYjUdZzqzdaQ+a8XPvEskzJzTD/O27mJrR4po+kfakSSxzJG5XDzx2nmjlepltRB+rih
         UcU+LJE/KQNQBRi8Al6iyhZyihwoZ5r9P1IChE20oJcoc5DRIRK82PtkizYa/Ul4qeg6
         Y0y+BPYvCbzxOtVrQ/fEdA1xZ9y8S6HOHMSl/zaopOzzwzCmnTomks6yGXpBVciFPMfA
         OSUg==
X-Gm-Message-State: APjAAAVubUgPObWKTlyGISDOPkGD1e71lMdxZcoTY1gJDqHkqq5wVvsH
        RJTrZM0I1kueAxWEcIG9L8Lt0aD2tIzosOsoIXr2bw==
X-Google-Smtp-Source: APXvYqzbKXndE6X0Nk+kRn2EMgyHf+PH8PB7QY1E0lyEFuZbY/AD4DL2vL1f0Nx9TtGDqQ08NvI0ebrqSQK0FG2A0ok=
X-Received: by 2002:a05:620a:16d2:: with SMTP id a18mr4780071qkn.104.1570114025729;
 Thu, 03 Oct 2019 07:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com> <20191003142738.GM1208@intel.com>
In-Reply-To: <20191003142738.GM1208@intel.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 3 Oct 2019 16:46:54 +0200
Message-ID: <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
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

Le jeu. 3 oct. 2019 =C3=A0 16:27, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> a =C3=A9crit :
>
> On Mon, Sep 09, 2019 at 03:52:05PM +0200, Benjamin Gaignard wrote:
> > Fix warnings with W=3D1.
> > Few for_each macro set variables that are never used later.
> > Prevent warning by marking these variables as __maybe_unused.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++-----------=
-------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index aa16ea17ff9b..b69d17b0b9bd 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
> >             struct drm_encoder *encoder)
> >  {
> >       struct drm_crtc_state *crtc_state;
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
>
> Rather ugly. IMO would be nicer if we could hide something inside
> the iterator macros to suppress the warning.

Ok but how ?
connector is assigned in the macros but not used later and we can't
set "__maybe_unused"
in the macro.
Does another keyword exist for that ?

>
> >       struct drm_connector_state *old_connector_state, *new_connector_s=
tate;
> >       int i;
> >
> > @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
> >  {
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *new_crtc_state;
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
> >       struct drm_connector_state *new_conn_state;
> >       int i;
> >       int ret;
> > @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_device *=
dev,
> >  {
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
> >       struct drm_connector_state *old_connector_state, *new_connector_s=
tate;
> >       int i, ret;
> >       unsigned connectors_mask =3D 0;
> > @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state=
,
> >  static void
> >  disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_s=
tate)
> >  {
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
> >       struct drm_connector_state *old_conn_state, *new_conn_state;
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_=
atomic_state *old_state)
> >  {
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *new_crtc_state;
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
> >       struct drm_connector_state *new_conn_state;
> >       int i;
> >
> > @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables(str=
uct drm_device *dev,
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state;
> >       struct drm_crtc_state *new_crtc_state;
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
> >       struct drm_connector_state *new_conn_state;
> >       int i;
> >
> > @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_=
device *dev,
> >                                     struct drm_atomic_state *state,
> >                                     bool pre_swap)
> >  {
> > -     struct drm_plane *plane;
> > +     struct drm_plane __maybe_unused *plane;
> >       struct drm_plane_state *new_plane_state;
> >       int i, ret;
> >
> > @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_dev=
ice *dev,
> >               struct drm_atomic_state *old_state)
> >  {
> >       struct drm_crtc *crtc;
> > -     struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > +     struct drm_crtc_state __maybe_unused *old_crtc_state, *new_crtc_s=
tate;
> >       int i, ret;
> >       unsigned crtc_mask =3D 0;
> >
> > @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *work)
> >  int drm_atomic_helper_async_check(struct drm_device *dev,
> >                                  struct drm_atomic_state *state)
> >  {
> > -     struct drm_crtc *crtc;
> > +     struct drm_crtc __maybe_unused *crtc;
> >       struct drm_crtc_state *crtc_state;
> >       struct drm_plane *plane =3D NULL;
> >       struct drm_plane_state *old_plane_state =3D NULL;
> > @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm_ato=
mic_state *state,
> >  {
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > -     struct drm_connector *conn;
> > +     struct drm_connector __maybe_unused *conn;
> >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > -     struct drm_plane *plane;
> > +     struct drm_plane __maybe_unused *plane;
> >       struct drm_plane_state *old_plane_state, *new_plane_state;
> >       struct drm_crtc_commit *commit;
> >       int i, ret;
> > @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> >   */
> >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_sta=
te)
> >  {
> > -     struct drm_crtc *crtc;
> > +     struct drm_crtc __maybe_unused *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> >       struct drm_crtc_commit *commit;
> >       int i;
> > @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_do=
ne);
> >  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> >                                    struct drm_atomic_state *state)
> >  {
> > -     struct drm_connector *connector;
> > +     struct drm_connector __maybe_unused *connector;
> >       struct drm_connector_state *new_conn_state;
> >       struct drm_plane *plane;
> >       struct drm_plane_state *new_plane_state;
> > @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_devi=
ce *dev,
> >  {
> >       struct drm_atomic_state *state;
> >       struct drm_connector_state *conn_state;
> > -     struct drm_connector *conn;
> > +     struct drm_connector __maybe_unused *conn;
> >       struct drm_plane_state *plane_state;
> > -     struct drm_plane *plane;
> > +     struct drm_plane __maybe_unused *plane;
> >       struct drm_crtc_state *crtc_state;
> >       struct drm_crtc *crtc;
> >       int ret, i;
> > @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_state(s=
truct drm_atomic_state *state,
> >  {
> >       int i, ret;
> >       struct drm_plane *plane;
> > -     struct drm_plane_state *new_plane_state;
> > +     struct drm_plane_state __maybe_unused *new_plane_state;
> >       struct drm_connector *connector;
> > -     struct drm_connector_state *new_conn_state;
> > +     struct drm_connector_state __maybe_unused *new_conn_state;
> >       struct drm_crtc *crtc;
> > -     struct drm_crtc_state *new_crtc_state;
> > +     struct drm_crtc_state __maybe_unused *new_crtc_state;
> >
> >       state->acquire_ctx =3D ctx;
> >
> > --
> > 2.15.0
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
