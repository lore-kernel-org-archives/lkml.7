Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F3CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155AC2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfFNRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:20:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:55329 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFNRU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:20:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 10:20:27 -0700
X-ExtLoop1: 1
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 14 Jun 2019 10:20:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 14 Jun 2019 20:20:22 +0300
Date:   Fri, 14 Jun 2019 20:20:22 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: Drop use of DRM_WAIT_ON() [Was: drm/drm_vblank: Change EINVAL by
 the correct errno]
Message-ID: <20190614172022.GE5942@intel.com>
References: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
 <20190613050403.GA21502@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613050403.GA21502@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:04:03AM +0200, Sam Ravnborg wrote:
> Hi Rodrigo.
> 
> On Wed, Jun 12, 2019 at 11:10:54PM -0300, Rodrigo Siqueira wrote:
> > For historical reason, the function drm_wait_vblank_ioctl always return
> > -EINVAL if something gets wrong. This scenario limits the flexibility
> > for the userspace make detailed verification of the problem and take
> > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > support vblank or not. If the driver does not support VBlank, the
> > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > Additionally, some operations are unsupported by this function, and
> > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > libdrm, which is used by many compositors; because of this, it is
> > important to check if this change breaks any compositor. In this sense,
> > the following projects were examined:
> > 
> > * Drm-hwcomposer
> > * Kwin
> > * Sway
> > * Wlroots
> > * Wayland-core
> > * Weston
> > * Xorg (67 different drivers)
> > 
> > For each repository the verification happened in three steps:
> > 
> > * Update the main branch
> > * Look for any occurrence "drmWaitVBlank" with the command:
> >   git grep -n "drmWaitVBlank"
> > * Look in the git history of the project with the command:
> >   git log -SdrmWaitVBlank
> > 
> > Finally, none of the above projects validate the use of EINVAL which
> > make safe, at least for these projects, to change the return values.
> > 
> > Change since V2:
> >  Daniel Vetter and Chris Wilson
> >  - Replace ENOTTY by EOPNOTSUPP
> >  - Return EINVAL if the parameters are wrong
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> > Update:
> >   Now IGT has a way to validate if a driver has vblank support or not.
> >   See: https://gitlab.freedesktop.org/drm/igt-gpu-tools/commit/2d244aed69165753f3adbbd6468db073dc1acf9A
> > 
> >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 0d704bddb1a6..d76a783a7d4b 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1578,10 +1578,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> >  	unsigned int flags, pipe, high_pipe;
> >  
> >  	if (!dev->irq_enabled)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> >  
> >  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> >  
> >  	if (vblwait->request.type &
> >  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> 
> When touching this function, could I ask you to take a look at
> eliminating the use of DRM_WAIT_ON()?
> It comes from the deprecated drm_os_linux.h header, and it is only of
> the few remaining users of DRM_WAIT_ON().

IIRC all previous attempts at removing that ended up with
regressions. I think there are some dragons lurking inside that
macro.

-- 
Ville Syrjälä
Intel
