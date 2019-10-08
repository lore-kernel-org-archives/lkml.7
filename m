Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D5C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE12217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fgrfOdMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHJ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:56:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36105 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfJHJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:56:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so15081401edn.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=glqoLLXRKhPZK2QNujLh3Eeqj01ONLHAWWq9xjc6ZXU=;
        b=fgrfOdMmS/aA3AyBG71zocxJJBLuxbcU15pBaS4rfJHfeqJZUhgTLTIf+zmrYyKH61
         yRb8+de3BSxzoAS7jSBvYgCYqwuZxWehOPiam4BFyopIHzCHvEbTYudahMyH/JLwdcbh
         oj5WxPoTXh5Kn0PWmQmwysADXMjbOd2fcqSv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=glqoLLXRKhPZK2QNujLh3Eeqj01ONLHAWWq9xjc6ZXU=;
        b=WuYHJnOopGO9nSRkLQ0WTgMZeDhTO9435nUF/ziFdkx0lKF5CPVhlCLti4d+rReieM
         aC2dhivKcEVfavx15O58jvqav8uX0S+AU5ZlRSXlXxzHiXmzUyfL/ZrzGCEDaNiNj6Ds
         5kKV6vJsLuoIR9Cm2n2hXzb0xvkjwVt/7NFznVJG4+HV89TwVtER4hRH4zcQltPuhpye
         G8ZXKBhxQZBYGUEqIqY3RtaaFYbVsG3AtSIeP2hzhRDvxDcfNomQKcJ/riXwWAIaeOX2
         h0IP9ryd2LoGHIX7aLTsnP3X5HgujN+rCr3sMKSzpKLKZ0Ud/3RhATb33fF2Nfj7+jUc
         Ydcg==
X-Gm-Message-State: APjAAAVDYDqmMDsXlMq3sh7562ig3/6ZPSLj1yFxa+Qu2JmlnkyY0N9x
        mK4D5CsBR62rRv28acIQOveCYQ==
X-Google-Smtp-Source: APXvYqzX9caPjLchcI30EsY4UbL8/AXABCo9Q2Cai3OfE3/ck5PhkZeBSKlffnE3S/Q8wwGOClOzNg==
X-Received: by 2002:a17:906:8c8:: with SMTP id o8mr28256623eje.56.1570528558229;
        Tue, 08 Oct 2019 02:55:58 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id g19sm2217121eje.0.2019.10.08.02.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 02:55:57 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:55:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
Message-ID: <20191008095555.GK16989@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com>
 <20191003142738.GM1208@intel.com>
 <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
 <20191003150526.GN1208@intel.com>
 <CA+M3ks7-SNusVJsiHqrmy4AN+_OO5e1X=ZRN16Hj6f-V3GnVow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks7-SNusVJsiHqrmy4AN+_OO5e1X=ZRN16Hj6f-V3GnVow@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:37:15PM +0200, Benjamin Gaignard wrote:
> Le jeu. 3 oct. 2019 à 17:05, Ville Syrjälä
> <ville.syrjala@linux.intel.com> a écrit :
> >
> > On Thu, Oct 03, 2019 at 04:46:54PM +0200, Benjamin Gaignard wrote:
> > > Le jeu. 3 oct. 2019 à 16:27, Ville Syrjälä
> > > <ville.syrjala@linux.intel.com> a écrit :
> > > >
> > > > On Mon, Sep 09, 2019 at 03:52:05PM +0200, Benjamin Gaignard wrote:
> > > > > Fix warnings with W=1.
> > > > > Few for_each macro set variables that are never used later.
> > > > > Prevent warning by marking these variables as __maybe_unused.
> > > > >
> > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++------------------
> > > > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > index aa16ea17ff9b..b69d17b0b9bd 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
> > > > >             struct drm_encoder *encoder)
> > > > >  {
> > > > >       struct drm_crtc_state *crtc_state;
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > >
> > > > Rather ugly. IMO would be nicer if we could hide something inside
> > > > the iterator macros to suppress the warning.
> > >
> > > Ok but how ?
> > > connector is assigned in the macros but not used later and we can't
> > > set "__maybe_unused"
> > > in the macro.
> > > Does another keyword exist for that ?
> >
> > Stick a (void)(connector) into the macro?
> 
> That could work but it will look strange inside the macro.

If this works I think it's fine, maybe together with a FIXME or so ... At
least as an interim solution. Much better than sprinkling all the
maybe_unused annotations around like in this patch.
-Daniel
> 
> >
> > Another (arguably cleaner) idea would be to remove the connector/crtc/plane
> > argument from the iterators entirely since it's redundant, and instead just
> > extract it from the appropriate new/old state as needed.
> >
> > We could then also add a for_each_connector_in_state()/etc. which omit
> > s the state arguments and just has the connector argument, for cases where
> > you don't care about the states when iterating.
> 
> That may lead to get a macro for each possible combination of used variables.
> 
> >
> > >
> > > >
> > > > >       struct drm_connector_state *old_connector_state, *new_connector_state;
> > > > >       int i;
> > > > >
> > > > > @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
> > > > >  {
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *new_crtc_state;
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >       struct drm_connector_state *new_conn_state;
> > > > >       int i;
> > > > >       int ret;
> > > > > @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
> > > > >  {
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >       struct drm_connector_state *old_connector_state, *new_connector_state;
> > > > >       int i, ret;
> > > > >       unsigned connectors_mask = 0;
> > > > > @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
> > > > >  static void
> > > > >  disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> > > > >  {
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
> > > > >  {
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *new_crtc_state;
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >       struct drm_connector_state *new_conn_state;
> > > > >       int i;
> > > > >
> > > > > @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *old_crtc_state;
> > > > >       struct drm_crtc_state *new_crtc_state;
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >       struct drm_connector_state *new_conn_state;
> > > > >       int i;
> > > > >
> > > > > @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
> > > > >                                     struct drm_atomic_state *state,
> > > > >                                     bool pre_swap)
> > > > >  {
> > > > > -     struct drm_plane *plane;
> > > > > +     struct drm_plane __maybe_unused *plane;
> > > > >       struct drm_plane_state *new_plane_state;
> > > > >       int i, ret;
> > > > >
> > > > > @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
> > > > >               struct drm_atomic_state *old_state)
> > > > >  {
> > > > >       struct drm_crtc *crtc;
> > > > > -     struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > +     struct drm_crtc_state __maybe_unused *old_crtc_state, *new_crtc_state;
> > > > >       int i, ret;
> > > > >       unsigned crtc_mask = 0;
> > > > >
> > > > > @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *work)
> > > > >  int drm_atomic_helper_async_check(struct drm_device *dev,
> > > > >                                  struct drm_atomic_state *state)
> > > > >  {
> > > > > -     struct drm_crtc *crtc;
> > > > > +     struct drm_crtc __maybe_unused *crtc;
> > > > >       struct drm_crtc_state *crtc_state;
> > > > >       struct drm_plane *plane = NULL;
> > > > >       struct drm_plane_state *old_plane_state = NULL;
> > > > > @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
> > > > >  {
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > -     struct drm_connector *conn;
> > > > > +     struct drm_connector __maybe_unused *conn;
> > > > >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > > > > -     struct drm_plane *plane;
> > > > > +     struct drm_plane __maybe_unused *plane;
> > > > >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > > > >       struct drm_crtc_commit *commit;
> > > > >       int i, ret;
> > > > > @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> > > > >   */
> > > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
> > > > >  {
> > > > > -     struct drm_crtc *crtc;
> > > > > +     struct drm_crtc __maybe_unused *crtc;
> > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > >       struct drm_crtc_commit *commit;
> > > > >       int i;
> > > > > @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done);
> > > > >  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> > > > >                                    struct drm_atomic_state *state)
> > > > >  {
> > > > > -     struct drm_connector *connector;
> > > > > +     struct drm_connector __maybe_unused *connector;
> > > > >       struct drm_connector_state *new_conn_state;
> > > > >       struct drm_plane *plane;
> > > > >       struct drm_plane_state *new_plane_state;
> > > > > @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_device *dev,
> > > > >  {
> > > > >       struct drm_atomic_state *state;
> > > > >       struct drm_connector_state *conn_state;
> > > > > -     struct drm_connector *conn;
> > > > > +     struct drm_connector __maybe_unused *conn;
> > > > >       struct drm_plane_state *plane_state;
> > > > > -     struct drm_plane *plane;
> > > > > +     struct drm_plane __maybe_unused *plane;
> > > > >       struct drm_crtc_state *crtc_state;
> > > > >       struct drm_crtc *crtc;
> > > > >       int ret, i;
> > > > > @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
> > > > >  {
> > > > >       int i, ret;
> > > > >       struct drm_plane *plane;
> > > > > -     struct drm_plane_state *new_plane_state;
> > > > > +     struct drm_plane_state __maybe_unused *new_plane_state;
> > > > >       struct drm_connector *connector;
> > > > > -     struct drm_connector_state *new_conn_state;
> > > > > +     struct drm_connector_state __maybe_unused *new_conn_state;
> > > > >       struct drm_crtc *crtc;
> > > > > -     struct drm_crtc_state *new_crtc_state;
> > > > > +     struct drm_crtc_state __maybe_unused *new_crtc_state;
> > > > >
> > > > >       state->acquire_ctx = ctx;
> > > > >
> > > > > --
> > > > > 2.15.0
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Ville Syrjälä
> > > > Intel
> >
> > --
> > Ville Syrjälä
> > Intel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
