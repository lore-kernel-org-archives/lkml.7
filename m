Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E7320C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfB1ODq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:03:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:59011 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfB1ODp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:03:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 06:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="137001786"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 28 Feb 2019 06:03:42 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:03:41 +0200
Date:   Thu, 28 Feb 2019 16:03:41 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190228140341.GG20097@intel.com>
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228101107.GL2665@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> > vkms_crc_work_handle needs the value of the actual frame to
> > schedule the workqueue that calls periodically the vblank
> > handler and the destroy state functions. However, the frame
> > value returned from vkms_vblank_simulate is updated and
> > diminished in vblank_get_timestamp because it is not in a
> > vblank interrupt, and return an inaccurate value.
> > 
> > Solve this getting the actual vblank frame directly from the
> > vblank->count inside the `struct drm_crtc`, instead of using
> > the `drm_accurate_vblank_count` function.
> > 
> > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> 
> Sorry for the delay, I'm a bit swamped right now :-/
> 
> Debug work you're doing here is really impressive! But I have no idea
> what's going on. It doesn't look like it's just papering over a bug (like
> the in_vblank_irq check we've discussed on irc), but I also have no idea
> why it works.
> 
> I'll pull in Ville, he understands this better than me.

It's not entirely clear what we're trying to fix. From what I can see
the crc work seems to be in no way synchronized with page flips, so
I'm not sure how all this is really supposed to work.

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> > index d7b409a3c0f8..09a8b00ef1f1 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> > @@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct *work)
> >  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> >  	struct vkms_device *vdev = container_of(out, struct vkms_device,
> >  						output);
> > +	unsigned int pipe = drm_crtc_index(crtc);
> > +	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
> >  	struct vkms_crc_data *primary_crc = NULL;
> >  	struct vkms_crc_data *cursor_crc = NULL;
> >  	struct drm_plane *plane;
> > @@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct *work)
> >  	if (primary_crc)
> >  		crc32 = _vkms_get_crc(primary_crc, cursor_crc);
> >  
> > -	frame_end = drm_crtc_accurate_vblank_count(crtc);
> > +	frame_end = vblank->count;
> >  
> >  	/* queue_work can fail to schedule crc_work; add crc for
> >  	 * missing frames
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index 8a9aeb0a9ea8..9bf3268e2e92 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> >  						  vblank_hrtimer);
> >  	struct drm_crtc *crtc = &output->crtc;
> >  	struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
> > +	unsigned int pipe = drm_crtc_index(crtc);
> > +	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
> >  	u64 ret_overrun;
> >  	bool ret;
> >  
> > @@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> >  		DRM_ERROR("vkms failure on handling vblank");
> >  
> >  	if (state && output->crc_enabled) {
> > -		u64 frame = drm_crtc_accurate_vblank_count(crtc);
> > +		u64 frame = vblank->count;
> >  
> >  		/* update frame_start only if a queued vkms_crc_work_handle()
> >  		 * has read the data
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
