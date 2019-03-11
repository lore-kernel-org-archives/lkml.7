Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92627C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BFA214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCKO1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:27:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:44866 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfCKO1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:27:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 07:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="133333978"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 11 Mar 2019 07:27:11 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 11 Mar 2019 16:27:10 +0200
Date:   Mon, 11 Mar 2019 16:27:10 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190311142710.GY3888@intel.com>
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local>
 <20190228140341.GG20097@intel.com>
 <CAKkTe8Ei2fbz4L2noLvGWMCsHy1f7sadOV-horjNsGBEHt=q3w@mail.gmail.com>
 <20190301152558.GR20097@intel.com>
 <CAKkTe8HbgkVm1i2xAFT6ecgv2jFjyoqrSEYUpx_40Uj=ogKYPQ@mail.gmail.com>
 <20190301184147.GS20097@intel.com>
 <20190310203505.2needmil76a4rc74@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190310203505.2needmil76a4rc74@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 05:35:05PM -0300, Rodrigo Siqueira wrote:
> On 03/01, Ville Syrjälä wrote:
> > On Fri, Mar 01, 2019 at 03:35:35PM -0300, Shayenne Moura wrote:
> > > Em sex, 1 de mar de 2019 às 12:26, Ville Syrjälä
> > > <ville.syrjala@linux.intel.com> escreveu:
> > > >
> > > > On Fri, Mar 01, 2019 at 11:55:11AM -0300, Shayenne Moura wrote:
> > > > > Em qui, 28 de fev de 2019 às 11:03, Ville Syrjälä
> > > > > <ville.syrjala@linux.intel.com> escreveu:
> > > > > >
> > > > > > On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> > > > > > > On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> > > > > > > > vkms_crc_work_handle needs the value of the actual frame to
> > > > > > > > schedule the workqueue that calls periodically the vblank
> > > > > > > > handler and the destroy state functions. However, the frame
> > > > > > > > value returned from vkms_vblank_simulate is updated and
> > > > > > > > diminished in vblank_get_timestamp because it is not in a
> > > > > > > > vblank interrupt, and return an inaccurate value.
> > > > > > > >
> > > > > > > > Solve this getting the actual vblank frame directly from the
> > > > > > > > vblank->count inside the `struct drm_crtc`, instead of using
> > > > > > > > the `drm_accurate_vblank_count` function.
> > > > > > > >
> > > > > > > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> > > > > > >
> > > > > > > Sorry for the delay, I'm a bit swamped right now :-/
> > > > > > >
> > > > > > > Debug work you're doing here is really impressive! But I have no idea
> > > > > > > what's going on. It doesn't look like it's just papering over a bug (like
> > > > > > > the in_vblank_irq check we've discussed on irc), but I also have no idea
> > > > > > > why it works.
> > > > > > >
> > > > > > > I'll pull in Ville, he understands this better than me.
> > > > > >
> > > > > > It's not entirely clear what we're trying to fix. From what I can see
> > > > > > the crc work seems to be in no way synchronized with page flips, so
> > > > > > I'm not sure how all this is really supposed to work.
> > > > > >
> > > > >
> > > > > Hi, Ville!
> > > > >
> > > > > Thank you for the review! :)
> > > > >
> > > > > I do not understand well what crc code is doing, but the issue that I found
> > > > > is related to the vblank timestamp and frame count.
> > > > >
> > > > > When vkms handles the crc_cursor it uses the start frame and end frame
> > > > > values to verify if it needs to call the function 'drm_crtc_add_crc_entry()'
> > > > > for each frame.
> > > > >
> > > > > However, when getting the frame count, the code is calling the function
> > > > > drm_update_vblank_count(dev, pipe, false) and, because of the 'false',
> > > > > subtracting the actual vblank timestamp (consequently, the frame count
> > > > > value), causing conflicts.
> > > >
> > > > The in_vblank_irq behavour looks sane to me. What are these conflicts?
> > > >
> > > 
> > > The entire history was:
> > >  - I sent the patch with bugfix for vblank extra frame. The patch changed
> > >    our function vkms_get_vblank_timestamp() to look like this:
> > > 
> > > bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
> > >                    int *max_error, ktime_t *vblank_time,
> > >                    bool in_vblank_irq)
> > > {
> > >     struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> > >     struct vkms_output *output = &vkmsdev->output;
> > > 
> > >     *vblank_time = output->vblank_hrtimer.node.expires;
> > > 
> > > +   if (!in_vblank_irq)
> > > +        *vblank_time -= output->period_ns;
> > > 
> > >     return true;
> > > }
> > > 
> > >  - This patch solve the issue that I was looking for (extra vblank
> > > frames on kms_flip).
> > > 
> > >  - However, kms_cursor_crc tests, which passed before my patch, started to fail.
> > > 
> > >  - Debugging them, I found that the problem was inside of function
> > > `vkms_vblank_simulate()`
> > > when it was handling the crc_enabled (inside  if (state && output->crc_enabled))
> > > and inside the function vkms_crc_work_handle() too.
> > > 
> > >  - Following the steps:
> > > 1. Inside vkms_vblank_simulate() we call drm_crtc_accurate_vblank_count()
> > > 2. In its turn, drm_crtc_accurate_vblank_count() calls the function
> > >    drm_update_vblank_count(dev, pipe, false).  /* This false is default */
> > > 3. Finally, the “false” used in drm_update_vblank_count(), will be
> > >   passed to vkms_get_vblank_timestamp() and the condition “if
> > >   (!in_vblank_irq)” will be executed multiple times (we don’t want it).
> > > 
> > >  - Inside vkms_crc, the issue is that the returned frame value change for
> > > every call of drm_crtc_accurate_vblank_count() because
> > > in_vblank_irq == false.
> 
> Hi Ville,
>  
> > OK. So why is it changing? AFAICS it should not change unless the
> > timer was moved forward in between the calls.
> 
> Yes Ville, you’re right. We have to update it only when the function
> vkms_vblank_simulate() is invoked (timer move forward), and FWIU we do
> it when we call drm_crtc_handle_vblank(). However, the current
> implementation of vkms, has a call to drm_crtc_accurate_vblank_count()
> inside the vkms_vblank_simulate() which is a problem because it also
> update the vblank value. FWIU, this patch fixes this issue by taking the
> count value in the data struct instead of call
> drm_crtc_accurate_vblank_count() which will avoid the extra update.

But why does that extra update change the vblank count?

-- 
Ville Syrjälä
Intel
