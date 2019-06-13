Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBFCC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C7021473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfFMSpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:45:01 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50945 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:45:01 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 93BD620024;
        Thu, 13 Jun 2019 20:44:57 +0200 (CEST)
Date:   Thu, 13 Jun 2019 20:44:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: Drop use of DRM_WAIT_ON() [Was: drm/drm_vblank: Change EINVAL by
 the correct errno]
Message-ID: <20190613184456.GB2385@ravnborg.org>
References: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com>
 <20190613050403.GA21502@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613050403.GA21502@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=MGE9myiAT6FqPCjaB2EA:9 a=QEXdDO2ut3YA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo et al.

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
> 
> Below you can find my untested first try - where I did an attempt not to
> change behaviour.

intel-gfx did not like the patch - so no need to spend time looking at
the patch until I have that fixed.

	Sam
