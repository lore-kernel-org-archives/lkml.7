Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723172084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbfCASlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:41:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:37428 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCASlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:41:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 10:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="137358009"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 01 Mar 2019 10:41:48 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 01 Mar 2019 20:41:47 +0200
Date:   Fri, 1 Mar 2019 20:41:47 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190301184147.GS20097@intel.com>
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local>
 <20190228140341.GG20097@intel.com>
 <CAKkTe8Ei2fbz4L2noLvGWMCsHy1f7sadOV-horjNsGBEHt=q3w@mail.gmail.com>
 <20190301152558.GR20097@intel.com>
 <CAKkTe8HbgkVm1i2xAFT6ecgv2jFjyoqrSEYUpx_40Uj=ogKYPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKkTe8HbgkVm1i2xAFT6ecgv2jFjyoqrSEYUpx_40Uj=ogKYPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 03:35:35PM -0300, Shayenne Moura wrote:
> Em sex, 1 de mar de 2019 às 12:26, Ville Syrjälä
> <ville.syrjala@linux.intel.com> escreveu:
> >
> > On Fri, Mar 01, 2019 at 11:55:11AM -0300, Shayenne Moura wrote:
> > > Em qui, 28 de fev de 2019 às 11:03, Ville Syrjälä
> > > <ville.syrjala@linux.intel.com> escreveu:
> > > >
> > > > On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> > > > > On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> > > > > > vkms_crc_work_handle needs the value of the actual frame to
> > > > > > schedule the workqueue that calls periodically the vblank
> > > > > > handler and the destroy state functions. However, the frame
> > > > > > value returned from vkms_vblank_simulate is updated and
> > > > > > diminished in vblank_get_timestamp because it is not in a
> > > > > > vblank interrupt, and return an inaccurate value.
> > > > > >
> > > > > > Solve this getting the actual vblank frame directly from the
> > > > > > vblank->count inside the `struct drm_crtc`, instead of using
> > > > > > the `drm_accurate_vblank_count` function.
> > > > > >
> > > > > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> > > > >
> > > > > Sorry for the delay, I'm a bit swamped right now :-/
> > > > >
> > > > > Debug work you're doing here is really impressive! But I have no idea
> > > > > what's going on. It doesn't look like it's just papering over a bug (like
> > > > > the in_vblank_irq check we've discussed on irc), but I also have no idea
> > > > > why it works.
> > > > >
> > > > > I'll pull in Ville, he understands this better than me.
> > > >
> > > > It's not entirely clear what we're trying to fix. From what I can see
> > > > the crc work seems to be in no way synchronized with page flips, so
> > > > I'm not sure how all this is really supposed to work.
> > > >
> > >
> > > Hi, Ville!
> > >
> > > Thank you for the review! :)
> > >
> > > I do not understand well what crc code is doing, but the issue that I found
> > > is related to the vblank timestamp and frame count.
> > >
> > > When vkms handles the crc_cursor it uses the start frame and end frame
> > > values to verify if it needs to call the function 'drm_crtc_add_crc_entry()'
> > > for each frame.
> > >
> > > However, when getting the frame count, the code is calling the function
> > > drm_update_vblank_count(dev, pipe, false) and, because of the 'false',
> > > subtracting the actual vblank timestamp (consequently, the frame count
> > > value), causing conflicts.
> >
> > The in_vblank_irq behavour looks sane to me. What are these conflicts?
> >
> 
> The entire history was:
>  - I sent the patch with bugfix for vblank extra frame. The patch changed
>    our function vkms_get_vblank_timestamp() to look like this:
> 
> bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
>                    int *max_error, ktime_t *vblank_time,
>                    bool in_vblank_irq)
> {
>     struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
>     struct vkms_output *output = &vkmsdev->output;
> 
>     *vblank_time = output->vblank_hrtimer.node.expires;
> 
> +   if (!in_vblank_irq)
> +        *vblank_time -= output->period_ns;
> 
>     return true;
> }
> 
>  - This patch solve the issue that I was looking for (extra vblank
> frames on kms_flip).
> 
>  - However, kms_cursor_crc tests, which passed before my patch, started to fail.
> 
>  - Debugging them, I found that the problem was inside of function
> `vkms_vblank_simulate()`
> when it was handling the crc_enabled (inside  if (state && output->crc_enabled))
> and inside the function vkms_crc_work_handle() too.
> 
>  - Following the steps:
> 1. Inside vkms_vblank_simulate() we call drm_crtc_accurate_vblank_count()
> 2. In its turn, drm_crtc_accurate_vblank_count() calls the function
>    drm_update_vblank_count(dev, pipe, false).  /* This false is default */
> 3. Finally, the “false” used in drm_update_vblank_count(), will be
>   passed to vkms_get_vblank_timestamp() and the condition “if
>   (!in_vblank_irq)” will be executed multiple times (we don’t want it).
> 
>  - Inside vkms_crc, the issue is that the returned frame value change for
> every call of drm_crtc_accurate_vblank_count() because
> in_vblank_irq == false.

OK. So why is it changing? AFAICS it should not change unless the
timer was moved forward in between the calls.

> 
>  - To solve this, I used the value already calculated on vblank->count,
> instead of using the helper function that updates the value.
> 
> Shayenne
> 
> > >
> > > Does it make sense? I am not sure about this crc code behavior.
> > >
> > > Shayenne
> > >
> > > > > -Daniel
> > > > >
> > > > > > ---
> > > > > >  drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
> > > > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
> > > > > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> > > > > > index d7b409a3c0f8..09a8b00ef1f1 100644
> > > > > > --- a/drivers/gpu/drm/vkms/vkms_crc.c
> > > > > > +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> > > > > > @@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct *work)
> > > > > >     struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> > > > > >     struct vkms_device *vdev = container_of(out, struct vkms_device,
> > > > > >                                             output);
> > > > > > +   unsigned int pipe = drm_crtc_index(crtc);
> > > > > > +   struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
> > > > > >     struct vkms_crc_data *primary_crc = NULL;
> > > > > >     struct vkms_crc_data *cursor_crc = NULL;
> > > > > >     struct drm_plane *plane;
> > > > > > @@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct *work)
> > > > > >     if (primary_crc)
> > > > > >             crc32 = _vkms_get_crc(primary_crc, cursor_crc);
> > > > > >
> > > > > > -   frame_end = drm_crtc_accurate_vblank_count(crtc);
> > > > > > +   frame_end = vblank->count;
> > > > > >
> > > > > >     /* queue_work can fail to schedule crc_work; add crc for
> > > > > >      * missing frames
> > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > > index 8a9aeb0a9ea8..9bf3268e2e92 100644
> > > > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > > @@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> > > > > >                                               vblank_hrtimer);
> > > > > >     struct drm_crtc *crtc = &output->crtc;
> > > > > >     struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
> > > > > > +   unsigned int pipe = drm_crtc_index(crtc);
> > > > > > +   struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
> > > > > >     u64 ret_overrun;
> > > > > >     bool ret;
> > > > > >
> > > > > > @@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> > > > > >             DRM_ERROR("vkms failure on handling vblank");
> > > > > >
> > > > > >     if (state && output->crc_enabled) {
> > > > > > -           u64 frame = drm_crtc_accurate_vblank_count(crtc);
> > > > > > +           u64 frame = vblank->count;
> > > > > >
> > > > > >             /* update frame_start only if a queued vkms_crc_work_handle()
> > > > > >              * has read the data
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
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
Ville Syrjälä
Intel
