Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF6CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192572084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfKDSmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:42:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:11873 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfKDSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:42:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 10:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="212367018"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 04 Nov 2019 10:41:57 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 04 Nov 2019 20:41:56 +0200
Date:   Mon, 4 Nov 2019 20:41:56 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
Message-ID: <20191104184156.GL1208@intel.com>
References: <20191101180713.5470-1-robdclark@gmail.com>
 <20191101180713.5470-2-robdclark@gmail.com>
 <20191101192458.GI1208@intel.com>
 <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
 <20191101214431.GJ1208@intel.com>
 <CAF6AEGsHQ-V9aVvxLE6VeV2Ld+1_QOh7LS6GBsd6Lsr4qPZNMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGsHQ-V9aVvxLE6VeV2Ld+1_QOh7LS6GBsd6Lsr4qPZNMw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:14:09PM -0700, Rob Clark wrote:
> On Fri, Nov 1, 2019 at 2:44 PM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Fri, Nov 01, 2019 at 12:49:02PM -0700, Rob Clark wrote:
> > > On Fri, Nov 1, 2019 at 12:25 PM Ville Syrjälä
> > > <ville.syrjala@linux.intel.com> wrote:
> > > >
> > > > On Fri, Nov 01, 2019 at 11:07:13AM -0700, Rob Clark wrote:
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > The new state should not be accessed after this point.  Clear the
> > > > > pointers to make that explicit.
> > > > >
> > > > > This makes the error corrected in the previous patch more obvious.
> > > > >
> > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++++++++++
> > > > >  1 file changed, 29 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > index 732bd0ce9241..176831df8163 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> > > > >   */
> > > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
> > > > >  {
> > > > > +     struct drm_connector *connector;
> > > > > +     struct drm_connector_state *old_conn_state, *new_conn_state;
> > > > >       struct drm_crtc *crtc;
> > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > +     struct drm_plane *plane;
> > > > > +     struct drm_plane_state *old_plane_state, *new_plane_state;
> > > > >       struct drm_crtc_commit *commit;
> > > > > +     struct drm_private_obj *obj;
> > > > > +     struct drm_private_state *old_obj_state, *new_obj_state;
> > > > >       int i;
> > > > >
> > > > > +     /*
> > > > > +      * After this point, drivers should not access the permanent modeset
> > > > > +      * state, so we also clear the new_state pointers to make this
> > > > > +      * restriction explicit.
> > > > > +      *
> > > > > +      * For the CRTC state, we do this in the same loop where we signal
> > > > > +      * hw_done, since we still need to new_crtc_state to fish out the
> > > > > +      * commit.
> > > > > +      */
> > > > > +
> > > > > +     for_each_oldnew_connector_in_state(old_state, connector, old_conn_state, new_conn_state, i) {
> > > > > +             old_state->connectors[i].new_state = NULL;
> > > > > +     }
> > > > > +
> > > > > +     for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
> > > > > +             old_state->planes[i].new_state = NULL;
> > > > > +     }
> > > > > +
> > > > > +     for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_state, new_obj_state, i) {
> > > > > +             old_state->private_objs[i].new_state = NULL;
> > > > > +     }
> > > > > +
> > > > >       for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> > > > >               old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
> > > > > +             old_state->crtcs[i].new_state = NULL;
> > > >
> > > > That's going to be a real PITA when doing programming after the fact from
> > > > a vblank worker. It's already a pain that the new_crtc_state->state is
> > > > getting NULLed somewhere.
> > > >
> > >
> > > I think you already have that problem, this just makes it explicit.
> >
> > I don't yet. Except on a branch where I have my vblank workers.
> > And I think the only problem is having the helpers/core clobber
> > the pointers when it should not. I don't see why it can't just
> > leave them be and let me use them.
> >
> 
> I guess it comes down to what assumptions you can make in driver
> backend.  But if you can, for example, move planes between crtcs, I
> think you can't make assumptions about the order in which things
> complete even if you don't have commits overtaking each other on a
> single crtc..

IMO this whole notion of accessing new_crtc_state & co. being unsafe
for some reason is wrong. I think as long as I have the drm_atomic_state
I should be able to look at the new/old states within.

-- 
Ville Syrjälä
Intel
