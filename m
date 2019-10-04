Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92169C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E36720867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfJDM1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:27:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:12125 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfJDM1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:27:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 05:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="205842974"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 05:27:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 04 Oct 2019 15:27:47 +0300
Date:   Fri, 4 Oct 2019 15:27:47 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: atomic helper: fix W=1 warnings
Message-ID: <20191004122747.GT1208@intel.com>
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <20190909135205.10277-2-benjamin.gaignard@st.com>
 <20191003142738.GM1208@intel.com>
 <CA+M3ks4FBAgCRDDHZ=x7kvQ1Y=0dBdj4+KLO2djh__hW+L=3gQ@mail.gmail.com>
 <20191003150526.GN1208@intel.com>
 <CA+M3ks7-SNusVJsiHqrmy4AN+_OO5e1X=ZRN16Hj6f-V3GnVow@mail.gmail.com>
 <20191003154627.GQ1208@intel.com>
 <CA+M3ks4gpDdZTPdBYRd=CrwgEYiSWJbXqvtPb-0KpW1BhzvmEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks4gpDdZTPdBYRd=CrwgEYiSWJbXqvtPb-0KpW1BhzvmEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 12:48:02PM +0200, Benjamin Gaignard wrote:
> Le jeu. 3 oct. 2019 à 17:46, Ville Syrjälä
> <ville.syrjala@linux.intel.com> a écrit :
> >
> > On Thu, Oct 03, 2019 at 05:37:15PM +0200, Benjamin Gaignard wrote:
> > > Le jeu. 3 oct. 2019 à 17:05, Ville Syrjälä
> > > <ville.syrjala@linux.intel.com> a écrit :
> > > >
> > > > On Thu, Oct 03, 2019 at 04:46:54PM +0200, Benjamin Gaignard wrote:
> > > > > Le jeu. 3 oct. 2019 à 16:27, Ville Syrjälä
> > > > > <ville.syrjala@linux.intel.com> a écrit :
> > > > > >
> > > > > > On Mon, Sep 09, 2019 at 03:52:05PM +0200, Benjamin Gaignard wrote:
> > > > > > > Fix warnings with W=1.
> > > > > > > Few for_each macro set variables that are never used later.
> > > > > > > Prevent warning by marking these variables as __maybe_unused.
> > > > > > >
> > > > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++------------------
> > > > > > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > > index aa16ea17ff9b..b69d17b0b9bd 100644
> > > > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > > @@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
> > > > > > >             struct drm_encoder *encoder)
> > > > > > >  {
> > > > > > >       struct drm_crtc_state *crtc_state;
> > > > > > > -     struct drm_connector *connector;
> > > > > > > +     struct drm_connector __maybe_unused *connector;
> > > > > >
> > > > > > Rather ugly. IMO would be nicer if we could hide something inside
> > > > > > the iterator macros to suppress the warning.
> > > > >
> > > > > Ok but how ?
> > > > > connector is assigned in the macros but not used later and we can't
> > > > > set "__maybe_unused"
> > > > > in the macro.
> > > > > Does another keyword exist for that ?
> > > >
> > > > Stick a (void)(connector) into the macro?
> > >
> > > That could work but it will look strange inside the macro.
> > >
> > > >
> > > > Another (arguably cleaner) idea would be to remove the connector/crtc/plane
> > > > argument from the iterators entirely since it's redundant, and instead just
> > > > extract it from the appropriate new/old state as needed.
> > > >
> > > > We could then also add a for_each_connector_in_state()/etc. which omit
> > > > s the state arguments and just has the connector argument, for cases where
> > > > you don't care about the states when iterating.
> > >
> > > That may lead to get a macro for each possible combination of used variables.
> >
> > We already have new/old/oldnew, so would "just" add one more.
> 
> Not just one, it will be one each new/old/oldnew macro to be able to distinguish
> when connector is used or not.

What I'm suggesting is this:
for_each_connector_in_state(state, connector, i)
for_each_old_connector_in_state(state, old_conn_state, i)
for_each_new_connector_in_state(state, new_conn_state, i)
for_each_oldnew_connector_in_state(state, old_conn_state, new_conn_state, i)

So only four in total for each object type, instead of the current
three.

-- 
Ville Syrjälä
Intel
