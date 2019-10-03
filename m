Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12362217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJa852nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJCJws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:52:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38725 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfJCJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:52:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so2701128qta.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SSBsBczGcSS8AYnQT2gIKnk5ZoChC5Gk02m0qwrbers=;
        b=MJa852nxKhA3euxSyy0l7Mecdk6yK3Zonce5ipIci8aD6OWz4XWrUJ27zy8vrI5PFD
         8N0gxMUhINOVbmSx4XfLXr5RJs5keJ9/sSrzQ0hm7atyuIiD7QwEDG+5LRUMNTk16OfT
         saxqdLWgbEQ5BU+EWUShcU9jBR0KtZRDLvzivVZhEoyplsiwNDfxJH58g7bjl8Kxd7Ax
         HFSxCWNVeKsze/mBDdRDHbk7tCgtKaIzdpEXYEWRtgHiSTzATJ5K+u4vdr/FUzr11FXm
         jNoAYtoIfNRSQCFi+5FDE4uplOQvidjMb8fM+ajh1RK31sSBSdhEBigB/9Fy93LWY0jC
         kovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SSBsBczGcSS8AYnQT2gIKnk5ZoChC5Gk02m0qwrbers=;
        b=q7dz2x9vH+x/PFFD01Sh7aU3r/CC907DJyrtSFvvbzaIXNa9JWG6E91NyqivJTlHIL
         4xllQHbvMrVD6zZKFuXEq1OMDOjznm3Dmrmi33CC/G/k2wNOOWf2SezdFRFercvRGXND
         cxN2Ckl88jUIe/hmpwTq433RBHT3uPHt6oytTrE+1hClEt9bSHDUIK+zzVFfD5YWlIB+
         R/2ox+rHmPVT5vB9Kkcr4DQwCWaT7F7npbTmo43xA1HNjtVuoJlxDEdheZu9SjlMOEVH
         xoXR7WSYgieeZuHPhvl88LFGQOaEVRjCmS53EZMfEGTxKAP3jZpqvzF0S/FaKM0D9CM/
         xcSw==
X-Gm-Message-State: APjAAAX7XhG0tk4+aJCWkmV2jPrN/D1kikAZwBTF6vJYK0V02qS8SwY8
        8UP/u07QRB0BJyWTFnFTNo+JDquJyrMHQQniqbiVlA==
X-Google-Smtp-Source: APXvYqzXuAph39qARPrOfF4x0AFL3sKEzFoLQWpsC5LG3pdJ6Py2bKKNGLM5jl3g3dFOV6dMw5yiWvrNkJkQT8NB5ns=
X-Received: by 2002:ac8:76ce:: with SMTP id q14mr7518795qtr.239.1570096365616;
 Thu, 03 Oct 2019 02:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com> <CA+M3ks7Y998qW+dOLPD+WLUH-Qi-=-okTYwDh7SBB0xo5XAs_w@mail.gmail.com>
In-Reply-To: <CA+M3ks7Y998qW+dOLPD+WLUH-Qi-=-okTYwDh7SBB0xo5XAs_w@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 3 Oct 2019 11:52:34 +0200
Message-ID: <CA+M3ks5=7N=sB2K6oqMGAUoi8DaCoRW1SEOs3_JHOj13qRV1oQ@mail.gmail.com>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 16 sept. 2019 =C3=A0 15:19, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> Le lun. 9 sept. 2019 =C3=A0 16:41, Benjamin Gaignard
> <benjamin.gaignard@st.com> a =C3=A9crit :
> >
> > Fix warnings with W=3D1.
> > Few for_each macro set variables that are never used later.
> > Prevent warning by marking these variables as __maybe_unused.
> >
>

Gentle Ping

benjamin

> A little up on this one because it may exist others ways to fix these war=
nings.
> Get feedback on this path could give the direction for similar ones in dr=
m.
>
> Thanks,
> Benjamin
>
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
> >               struct drm_encoder *encoder)
> >  {
> >         struct drm_crtc_state *crtc_state;
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *old_connector_state, *new_connector=
_state;
> >         int i;
> >
> > @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
> >  {
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *new_crtc_state;
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *new_conn_state;
> >         int i;
> >         int ret;
> > @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_device *=
dev,
> >  {
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *old_connector_state, *new_connector=
_state;
> >         int i, ret;
> >         unsigned connectors_mask =3D 0;
> > @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state=
,
> >  static void
> >  disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_s=
tate)
> >  {
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *old_conn_state, *new_conn_state;
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_=
atomic_state *old_state)
> >  {
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *new_crtc_state;
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *new_conn_state;
> >         int i;
> >
> > @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables(str=
uct drm_device *dev,
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *old_crtc_state;
> >         struct drm_crtc_state *new_crtc_state;
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *new_conn_state;
> >         int i;
> >
> > @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_=
device *dev,
> >                                       struct drm_atomic_state *state,
> >                                       bool pre_swap)
> >  {
> > -       struct drm_plane *plane;
> > +       struct drm_plane __maybe_unused *plane;
> >         struct drm_plane_state *new_plane_state;
> >         int i, ret;
> >
> > @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_dev=
ice *dev,
> >                 struct drm_atomic_state *old_state)
> >  {
> >         struct drm_crtc *crtc;
> > -       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > +       struct drm_crtc_state __maybe_unused *old_crtc_state, *new_crtc=
_state;
> >         int i, ret;
> >         unsigned crtc_mask =3D 0;
> >
> > @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *work)
> >  int drm_atomic_helper_async_check(struct drm_device *dev,
> >                                    struct drm_atomic_state *state)
> >  {
> > -       struct drm_crtc *crtc;
> > +       struct drm_crtc __maybe_unused *crtc;
> >         struct drm_crtc_state *crtc_state;
> >         struct drm_plane *plane =3D NULL;
> >         struct drm_plane_state *old_plane_state =3D NULL;
> > @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm_ato=
mic_state *state,
> >  {
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > -       struct drm_connector *conn;
> > +       struct drm_connector __maybe_unused *conn;
> >         struct drm_connector_state *old_conn_state, *new_conn_state;
> > -       struct drm_plane *plane;
> > +       struct drm_plane __maybe_unused *plane;
> >         struct drm_plane_state *old_plane_state, *new_plane_state;
> >         struct drm_crtc_commit *commit;
> >         int i, ret;
> > @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> >   */
> >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_sta=
te)
> >  {
> > -       struct drm_crtc *crtc;
> > +       struct drm_crtc __maybe_unused *crtc;
> >         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> >         struct drm_crtc_commit *commit;
> >         int i;
> > @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_do=
ne);
> >  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> >                                      struct drm_atomic_state *state)
> >  {
> > -       struct drm_connector *connector;
> > +       struct drm_connector __maybe_unused *connector;
> >         struct drm_connector_state *new_conn_state;
> >         struct drm_plane *plane;
> >         struct drm_plane_state *new_plane_state;
> > @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_devi=
ce *dev,
> >  {
> >         struct drm_atomic_state *state;
> >         struct drm_connector_state *conn_state;
> > -       struct drm_connector *conn;
> > +       struct drm_connector __maybe_unused *conn;
> >         struct drm_plane_state *plane_state;
> > -       struct drm_plane *plane;
> > +       struct drm_plane __maybe_unused *plane;
> >         struct drm_crtc_state *crtc_state;
> >         struct drm_crtc *crtc;
> >         int ret, i;
> > @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_state(s=
truct drm_atomic_state *state,
> >  {
> >         int i, ret;
> >         struct drm_plane *plane;
> > -       struct drm_plane_state *new_plane_state;
> > +       struct drm_plane_state __maybe_unused *new_plane_state;
> >         struct drm_connector *connector;
> > -       struct drm_connector_state *new_conn_state;
> > +       struct drm_connector_state __maybe_unused *new_conn_state;
> >         struct drm_crtc *crtc;
> > -       struct drm_crtc_state *new_crtc_state;
> > +       struct drm_crtc_state __maybe_unused *new_crtc_state;
> >
> >         state->acquire_ctx =3D ctx;
> >
> > --
> > 2.15.0
> >
