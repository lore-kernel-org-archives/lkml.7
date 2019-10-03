Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3EBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E79D21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPQFIEAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJCPh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:37:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45828 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfJCPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:37:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so2760891qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gZFcoJD5h7pLVZwS4bu88KYjedPUR1Ymm2WLx75z8WU=;
        b=aPQFIEAO+y2jMTl8WnBSEMai7mJBphrA/yWDs3A7Zr+wWI3W2LjF/Mhzfr0/OvoNwx
         EFSQ5z6ZOqGRc3+ByyLU/tG2etAyO8akUr+L+QUvYdvLvLkWn+dVMowBeRZ4dFo27Zna
         nTVALah4L59jouOoOKKVc8Mob9hoPPBKmiBNTBiYn4GWq/yO3oalTfo2EIoItLKjxzqu
         0sNaFBRKZtCD2Ekg217uUcebIwFa6uZFWgrrcHIIHUZ85JOrLxyeBkVo4KW2l4XdLj1c
         vrZR2w3olCzfKjNlwls3T/0icphAx6wWnol6Rsq5cFeDc9Kg5Ntz25aMZ3BH1YwDwcjM
         hppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gZFcoJD5h7pLVZwS4bu88KYjedPUR1Ymm2WLx75z8WU=;
        b=e3jTngSlXVmcAI6Uf6/vBJo9IqO3m8Srnmfa2oJTrht2gjjSMlCSyUeS5BZsUaeguE
         4tULMjzbjTXw7iIhstjwwF7ThgcXDk99Gn6VdhYCjHdEMnar7E8rnJ+sOf9TmnpVMjgl
         oP7S6TjnoBroDQEQ6l5jJdinHeY5o3XUGOBr7JClIZQbRA82PWRH4R3ud/wCpGMdHEr6
         R53BqpQr//kLJF/8H5kLQ835ra0DhO50Jjx/rXAwzooy1iATaz7J6eFtB/qxw5nUU9t7
         AsIVPUIvBIrNhCCIuypiMbOvLxDo08/4L97dS9AfJSY/+khgIge+9eaaynL0R8vhtnsx
         zrjw==
X-Gm-Message-State: APjAAAV4VFEkebSZDwdLRlr8P8lCgPdOXpQAOzAfDdK6Dj9LqBGCUN6v
        /GkEvCA/QMLfz5k2gl2yTc7rtor9IFMBk+ytr9dfOvgp
X-Google-Smtp-Source: APXvYqwiB2DWrAYfbXnScIu7M9vzmf9DIqiWyAxKa/OaA6E9HbmFOxaATJYtY/iR6NE3MSLAYbobwi2eujPod/J6FVc=
X-Received: by 2002:a37:7086:: with SMTP id l128mr4793562qkc.433.1570117047075;
 Thu, 03 Oct 2019 08:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com> <20191003142738.GM1208@intel.com>
 <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com> <20191003150526.GN1208@intel.com>
In-Reply-To: <20191003150526.GN1208@intel.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 3 Oct 2019 17:37:15 +0200
Message-ID: <CA+M3ks7-SNusVJsiHqrmy4AN+_OO5e1X=ZRN16Hj6f-V3GnVow@mail.gmail.com>
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

Le jeu. 3 oct. 2019 =C3=A0 17:05, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> a =C3=A9crit :
>
> On Thu, Oct 03, 2019 at 04:46:54PM +0200, Benjamin Gaignard wrote:
> > Le jeu. 3 oct. 2019 =C3=A0 16:27, Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> a =C3=A9crit :
> > >
> > > On Mon, Sep 09, 2019 at 03:52:05PM +0200, Benjamin Gaignard wrote:
> > > > Fix warnings with W=3D1.
> > > > Few for_each macro set variables that are never used later.
> > > > Prevent warning by marking these variables as __maybe_unused.
> > > >
> > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++-------=
-----------
> > > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/=
drm_atomic_helper.c
> > > > index aa16ea17ff9b..b69d17b0b9bd 100644
> > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
> > > >             struct drm_encoder *encoder)
> > > >  {
> > > >       struct drm_crtc_state *crtc_state;
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > >
> > > Rather ugly. IMO would be nicer if we could hide something inside
> > > the iterator macros to suppress the warning.
> >
> > Ok but how ?
> > connector is assigned in the macros but not used later and we can't
> > set "__maybe_unused"
> > in the macro.
> > Does another keyword exist for that ?
>
> Stick a (void)(connector) into the macro?

That could work but it will look strange inside the macro.

>
> Another (arguably cleaner) idea would be to remove the connector/crtc/pla=
ne
> argument from the iterators entirely since it's redundant, and instead ju=
st
> extract it from the appropriate new/old state as needed.
>
> We could then also add a for_each_connector_in_state()/etc. which omit
> s the state arguments and just has the connector argument, for cases wher=
e
> you don't care about the states when iterating.

That may lead to get a macro for each possible combination of used variable=
s.

>
> >
> > >
> > > >       struct drm_connector_state *old_connector_state, *new_connect=
or_state;
> > > >       int i;
> > > >
> > > > @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
> > > >  {
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *new_crtc_state;
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > > >       struct drm_connector_state *new_conn_state;
> > > >       int i;
> > > >       int ret;
> > > > @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_devi=
ce *dev,
> > > >  {
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > > >       struct drm_connector_state *old_connector_state, *new_connect=
or_state;
> > > >       int i, ret;
> > > >       unsigned connectors_mask =3D 0;
> > > > @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_s=
tate,
> > > >  static void
> > > >  disable_outputs(struct drm_device *dev, struct drm_atomic_state *o=
ld_state)
> > > >  {
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > > >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct =
drm_atomic_state *old_state)
> > > >  {
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *new_crtc_state;
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > > >       struct drm_connector_state *new_conn_state;
> > > >       int i;
> > > >
> > > > @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables=
(struct drm_device *dev,
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *old_crtc_state;
> > > >       struct drm_crtc_state *new_crtc_state;
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > > >       struct drm_connector_state *new_conn_state;
> > > >       int i;
> > > >
> > > > @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct =
drm_device *dev,
> > > >                                     struct drm_atomic_state *state,
> > > >                                     bool pre_swap)
> > > >  {
> > > > -     struct drm_plane *plane;
> > > > +     struct drm_plane __maybe_unused *plane;
> > > >       struct drm_plane_state *new_plane_state;
> > > >       int i, ret;
> > > >
> > > > @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm=
_device *dev,
> > > >               struct drm_atomic_state *old_state)
> > > >  {
> > > >       struct drm_crtc *crtc;
> > > > -     struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > +     struct drm_crtc_state __maybe_unused *old_crtc_state, *new_cr=
tc_state;
> > > >       int i, ret;
> > > >       unsigned crtc_mask =3D 0;
> > > >
> > > > @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *w=
ork)
> > > >  int drm_atomic_helper_async_check(struct drm_device *dev,
> > > >                                  struct drm_atomic_state *state)
> > > >  {
> > > > -     struct drm_crtc *crtc;
> > > > +     struct drm_crtc __maybe_unused *crtc;
> > > >       struct drm_crtc_state *crtc_state;
> > > >       struct drm_plane *plane =3D NULL;
> > > >       struct drm_plane_state *old_plane_state =3D NULL;
> > > > @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm=
_atomic_state *state,
> > > >  {
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > -     struct drm_connector *conn;
> > > > +     struct drm_connector __maybe_unused *conn;
> > > >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > > > -     struct drm_plane *plane;
> > > > +     struct drm_plane __maybe_unused *plane;
> > > >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > > >       struct drm_crtc_commit *commit;
> > > >       int i, ret;
> > > > @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> > > >   */
> > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old=
_state)
> > > >  {
> > > > -     struct drm_crtc *crtc;
> > > > +     struct drm_crtc __maybe_unused *crtc;
> > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > >       struct drm_crtc_commit *commit;
> > > >       int i;
> > > > @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanu=
p_done);
> > > >  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> > > >                                    struct drm_atomic_state *state)
> > > >  {
> > > > -     struct drm_connector *connector;
> > > > +     struct drm_connector __maybe_unused *connector;
> > > >       struct drm_connector_state *new_conn_state;
> > > >       struct drm_plane *plane;
> > > >       struct drm_plane_state *new_plane_state;
> > > > @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_=
device *dev,
> > > >  {
> > > >       struct drm_atomic_state *state;
> > > >       struct drm_connector_state *conn_state;
> > > > -     struct drm_connector *conn;
> > > > +     struct drm_connector __maybe_unused *conn;
> > > >       struct drm_plane_state *plane_state;
> > > > -     struct drm_plane *plane;
> > > > +     struct drm_plane __maybe_unused *plane;
> > > >       struct drm_crtc_state *crtc_state;
> > > >       struct drm_crtc *crtc;
> > > >       int ret, i;
> > > > @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_sta=
te(struct drm_atomic_state *state,
> > > >  {
> > > >       int i, ret;
> > > >       struct drm_plane *plane;
> > > > -     struct drm_plane_state *new_plane_state;
> > > > +     struct drm_plane_state __maybe_unused *new_plane_state;
> > > >       struct drm_connector *connector;
> > > > -     struct drm_connector_state *new_conn_state;
> > > > +     struct drm_connector_state __maybe_unused *new_conn_state;
> > > >       struct drm_crtc *crtc;
> > > > -     struct drm_crtc_state *new_crtc_state;
> > > > +     struct drm_crtc_state __maybe_unused *new_crtc_state;
> > > >
> > > >       state->acquire_ctx =3D ctx;
> > > >
> > > > --
> > > > 2.15.0
> > > >
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Ville Syrj=C3=A4l=C3=A4
> > > Intel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
