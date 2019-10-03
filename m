Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A99C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8A52133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfJCPFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:05:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:39611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJCPFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:05:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 08:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="221803088"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 03 Oct 2019 08:05:27 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 03 Oct 2019 18:05:26 +0300
Date:   Thu, 3 Oct 2019 18:05:26 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
Message-ID: <20191003150526.GN1208@intel.com>
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com>
 <20191003142738.GM1208@intel.com>
 <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:46:54PM +0200, Benjamin Gaignard wrote:
> Le jeu. 3 oct. 2019 à 16:27, Ville Syrjälä
> <ville.syrjala@linux.intel.com> a écrit :
> >
> > On Mon, Sep 09, 2019 at 03:52:05PM +0200, Benjamin Gaignard wrote:
> > > Fix warnings with W=1.
> > > Few for_each macro set variables that are never used later.
> > > Prevent warning by marking these variables as __maybe_unused.
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++------------------
> > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > index aa16ea17ff9b..b69d17b0b9bd 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
> > >             struct drm_encoder *encoder)
> > >  {
> > >       struct drm_crtc_state *crtc_state;
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> >
> > Rather ugly. IMO would be nicer if we could hide something inside
> > the iterator macros to suppress the warning.
> 
> Ok but how ?
> connector is assigned in the macros but not used later and we can't
> set "__maybe_unused"
> in the macro.
> Does another keyword exist for that ?

Stick a (void)(connector) into the macro?

Another (arguably cleaner) idea would be to remove the connector/crtc/plane
argument from the iterators entirely since it's redundant, and instead just
extract it from the appropriate new/old state as needed.

We could then also add a for_each_connector_in_state()/etc. which omit
s the state arguments and just has the connector argument, for cases where
you don't care about the states when iterating.

> 
> >
> > >       struct drm_connector_state *old_connector_state, *new_connector_state;
> > >       int i;
> > >
> > > @@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
> > >  {
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *new_crtc_state;
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> > >       struct drm_connector_state *new_conn_state;
> > >       int i;
> > >       int ret;
> > > @@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
> > >  {
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> > >       struct drm_connector_state *old_connector_state, *new_connector_state;
> > >       int i, ret;
> > >       unsigned connectors_mask = 0;
> > > @@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
> > >  static void
> > >  disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> > >  {
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> > >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > @@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
> > >  {
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *new_crtc_state;
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> > >       struct drm_connector_state *new_conn_state;
> > >       int i;
> > >
> > > @@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *old_crtc_state;
> > >       struct drm_crtc_state *new_crtc_state;
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> > >       struct drm_connector_state *new_conn_state;
> > >       int i;
> > >
> > > @@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
> > >                                     struct drm_atomic_state *state,
> > >                                     bool pre_swap)
> > >  {
> > > -     struct drm_plane *plane;
> > > +     struct drm_plane __maybe_unused *plane;
> > >       struct drm_plane_state *new_plane_state;
> > >       int i, ret;
> > >
> > > @@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
> > >               struct drm_atomic_state *old_state)
> > >  {
> > >       struct drm_crtc *crtc;
> > > -     struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > +     struct drm_crtc_state __maybe_unused *old_crtc_state, *new_crtc_state;
> > >       int i, ret;
> > >       unsigned crtc_mask = 0;
> > >
> > > @@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *work)
> > >  int drm_atomic_helper_async_check(struct drm_device *dev,
> > >                                  struct drm_atomic_state *state)
> > >  {
> > > -     struct drm_crtc *crtc;
> > > +     struct drm_crtc __maybe_unused *crtc;
> > >       struct drm_crtc_state *crtc_state;
> > >       struct drm_plane *plane = NULL;
> > >       struct drm_plane_state *old_plane_state = NULL;
> > > @@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
> > >  {
> > >       struct drm_crtc *crtc;
> > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > -     struct drm_connector *conn;
> > > +     struct drm_connector __maybe_unused *conn;
> > >       struct drm_connector_state *old_conn_state, *new_conn_state;
> > > -     struct drm_plane *plane;
> > > +     struct drm_plane __maybe_unused *plane;
> > >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > >       struct drm_crtc_commit *commit;
> > >       int i, ret;
> > > @@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> > >   */
> > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
> > >  {
> > > -     struct drm_crtc *crtc;
> > > +     struct drm_crtc __maybe_unused *crtc;
> > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > >       struct drm_crtc_commit *commit;
> > >       int i;
> > > @@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done);
> > >  int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> > >                                    struct drm_atomic_state *state)
> > >  {
> > > -     struct drm_connector *connector;
> > > +     struct drm_connector __maybe_unused *connector;
> > >       struct drm_connector_state *new_conn_state;
> > >       struct drm_plane *plane;
> > >       struct drm_plane_state *new_plane_state;
> > > @@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_device *dev,
> > >  {
> > >       struct drm_atomic_state *state;
> > >       struct drm_connector_state *conn_state;
> > > -     struct drm_connector *conn;
> > > +     struct drm_connector __maybe_unused *conn;
> > >       struct drm_plane_state *plane_state;
> > > -     struct drm_plane *plane;
> > > +     struct drm_plane __maybe_unused *plane;
> > >       struct drm_crtc_state *crtc_state;
> > >       struct drm_crtc *crtc;
> > >       int ret, i;
> > > @@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
> > >  {
> > >       int i, ret;
> > >       struct drm_plane *plane;
> > > -     struct drm_plane_state *new_plane_state;
> > > +     struct drm_plane_state __maybe_unused *new_plane_state;
> > >       struct drm_connector *connector;
> > > -     struct drm_connector_state *new_conn_state;
> > > +     struct drm_connector_state __maybe_unused *new_conn_state;
> > >       struct drm_crtc *crtc;
> > > -     struct drm_crtc_state *new_crtc_state;
> > > +     struct drm_crtc_state __maybe_unused *new_crtc_state;
> > >
> > >       state->acquire_ctx = ctx;
> > >
> > > --
> > > 2.15.0
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel
