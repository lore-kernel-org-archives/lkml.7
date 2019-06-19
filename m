Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CCC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996EA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Of3BQPYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfFSHvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:51:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36824 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfFSHvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:51:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so25762367edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=titOKqm2FtwiI20YuYIPgTzaXhqwWPUnBMtwVOPuEAE=;
        b=Of3BQPYqR3hobtFRHEZZ/8xZYZfh9nMj/b6fTp45wVJDr79tMqfenFBEiW8jq61Gsw
         q80CHAn1N4AaSrmMRS6GByo69wxYBqpqH3QWlLkKsCTktnQ+9VIyBtrjNqAM1B2IuzmJ
         lt8VtsjeIsaCoh9VWMnZQhyPkC166hnXKuzq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=titOKqm2FtwiI20YuYIPgTzaXhqwWPUnBMtwVOPuEAE=;
        b=JdH88qlai55xnyUDA90uJscYVzS7fDC16/moy+g76HxGuyjPsXyRtR2/zhMP+ylPHe
         /rzqgV8sCmVCxf2lPnDystCzUQUJKwSaTjmB3Tw1g5cIHZPIuvRPmDagPvsxp/PpRyh1
         GJ0xT1hEuoHOnIRlYO5mpVTXqm+2wft6SWEe9t1fYEbhlAYwoyfKINQYKdoemu3HT8bM
         XX/S3vhR53nfZJVFQkQ9pQk1NMVjjuQ3K8yePBNVxWNF0zPZim5m0ce/2nnSIslz/VNJ
         m0MeDnwuCJtfRSwTVrIHvjnyWJjjLbO1ZUzOPBrckzCqyhzRiUcECEOxudwNGWLmWENM
         6JUg==
X-Gm-Message-State: APjAAAU9FmhPS/M8CgaL3uXd77EkWnnB6+jNQOPJnyMgfquxsACOx5LZ
        wtdvkrkrrfU6lccWlXjARJBByg==
X-Google-Smtp-Source: APXvYqz6cxeikFtW40TZo1ZGzWIefjG4b46C5M+VobgvEQ4Uy67QhcejpHEoQxslttiLIW4/rsYy1w==
X-Received: by 2002:a50:aeee:: with SMTP id f43mr57838085edd.221.1560930663798;
        Wed, 19 Jun 2019 00:51:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w35sm2940089edd.32.2019.06.19.00.51.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:51:03 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:50:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V4] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190619075059.GK12905@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
 <20190619074856.GJ12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619074856.GJ12905@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 09:48:56AM +0200, Daniel Vetter wrote:
> On Tue, Jun 18, 2019 at 11:07:50PM -0300, Rodrigo Siqueira wrote:
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
> > Change since V3:
> >  - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)
> > 
> > Change since V2:
> >  Daniel Vetter and Chris Wilson
> >  - Replace ENOTTY by EOPNOTSUPP
> >  - Return EINVAL if the parameters are wrong
> > 
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Apologies for the confusion on the last time around. btw if someone tells
> you "r-b (or a-b) with these changes", then just apply the r-b/a-b tag
> next time around. Otherwise people will re-review the same thing over and
> over again.

btw when resending patches it's good practice to add anyone who commented
on it (or who commented on the igt test for the same patch and other way
round) onto the explicit Cc: list of the patch. That way it's easier for
them to follow the patch evolution and do a quick r-b once they're happy.

If you don't do that then much bigger chances your patch gets ignored.
-Daniel
> 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 603ab105125d..bed233361614 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> >  	unsigned int flags, pipe, high_pipe;
> >  
> >  	if (!dev->irq_enabled)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> >  
> >  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> >  		return -EINVAL;
> > -- 
> > 2.21.0
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
