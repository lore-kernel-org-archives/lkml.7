Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF39C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97C721849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KD3lK83s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGSJDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:03:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38607 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfGSJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:03:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so33800375edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NTYdVI+WDghg25Lh1/RUZv6ZZAp/zTJ3VjSdQgXSPTs=;
        b=KD3lK83s3CIHwHrpMPtIFEt1gEGpK1VVDPD+T0VOHRw+09nr37+fu+WFfqTFwj/cm0
         SBlscF/y3i/N5TrzmAQC96yMp3LuMv9GHskQFPxbyGRHvb/S4eeBwnNnaKJxym2WANYg
         I4WJUvMz5Cb7VqheqrvQ+2ZsktKi2h46cJlaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NTYdVI+WDghg25Lh1/RUZv6ZZAp/zTJ3VjSdQgXSPTs=;
        b=ZemcqwzY8i0R6agzUtrldVOQPephQaqfHCVjc72sFNVv+VXMFiOWrsxoZeGkK6YgWR
         +xfIfvwksBzQGmAgTT6F2pud0uucm8l1KVmgZyuLbcFW6UDvae4uCgBMHyZbSavsc1m3
         fadbnQTgvG7ajYxByHyTVHG267KWVUy5DZSglx8GbwTTNnbtpzHkMZMTc36pJGNgTrmu
         aSzKPHFph/O6B3MLd5JPphtI4ajjRroYZBYTSaLjaYlnEdR+pXRivFv9le+4bsVOxhc6
         OfsXUsm+gLJ69gVV2Q0lSdJ2lR0rrz1rAtKrJOYXUw3qkEaY0v3awBV1AzwqM7/wx/cz
         rOJQ==
X-Gm-Message-State: APjAAAWbiPbGw6bCIbmvEnK0z6GlNcbUJ66mPD3a4TnzkmonIPBOGB0E
        zb1+V+OLtYsTv7l+G5a8+qQ=
X-Google-Smtp-Source: APXvYqzPCEN4N6ROEqjAAde4BDvee7qmW4cqQsY/XO1fq2mi39wNlizjYgnGUxS2u2JgwzVdNFkVMA==
X-Received: by 2002:a50:987a:: with SMTP id h55mr46028023edb.108.1563526985231;
        Fri, 19 Jul 2019 02:03:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e29sm7797870eda.51.2019.07.19.02.03.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 02:03:04 -0700 (PDT)
Date:   Fri, 19 Jul 2019 11:03:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] drm/vkms: Add support for vkms work without vblank
Message-ID: <20190719090302.GE15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190710015514.42anrmx3r2ijaomz@smtp.gmail.com>
 <20190710164036.GZ15868@phenom.ffwll.local>
 <20190712025718.wdlafaujpxhpupj7@smtp.gmail.com>
 <20190716090345.GX15868@phenom.ffwll.local>
 <20190717020737.z2mu64s3lfyt7pl7@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190717020737.z2mu64s3lfyt7pl7@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:07:37PM -0300, Rodrigo Siqueira wrote:
> On 07/16, Daniel Vetter wrote:
> > On Thu, Jul 11, 2019 at 11:57:18PM -0300, Rodrigo Siqueira wrote:
> > > On 07/10, Daniel Vetter wrote:
> > > > On Tue, Jul 09, 2019 at 10:55:14PM -0300, Rodrigo Siqueira wrote:
> > > > > Currently, vkms only work with enabled VBlank. This patch adds another
> > > > > operation model that allows vkms to work without VBlank support. In this
> > > > > scenario, vblank signaling is faked by calling drm_send_vblank_event()
> > > > > in vkms_crtc_atomic_flush(); this approach works due to the
> > > > > drm_vblank_get() == 0 checking.
> > > > > 
> > > > > Changes since V2:
> > > > >  - Rebase
> > > > > 
> > > > > Changes since V1:
> > > > >   Daniel Vetter:
> > > > >   - Change module parameter name from disablevblank to virtual_hw
> > > > >   - Improve parameter description
> > > > >   - Improve commit message
> > > > > 
> > > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 10 ++++++++++
> > > > >  drivers/gpu/drm/vkms/vkms_drv.c  | 13 +++++++++++--
> > > > >  drivers/gpu/drm/vkms/vkms_drv.h  |  2 ++
> > > > >  3 files changed, 23 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > index 49a8ec2cb1c1..a0c75b8c4335 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > @@ -207,12 +207,22 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
> > > > >  static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
> > > > >  				    struct drm_crtc_state *old_state)
> > > > >  {
> > > > > +	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
> > > > > +
> > > > > +	if (vkms_out->disable_vblank)
> > > > > +		return;
> > > > > +
> > > > >  	drm_crtc_vblank_on(crtc);
> > > > >  }
> > > > >  
> > > > >  static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
> > > > >  				     struct drm_crtc_state *old_state)
> > > > >  {
> > > > > +	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
> > > > > +
> > > > > +	if (vkms_out->disable_vblank)
> > > > > +		return;
> > > > > +
> > > > >  	drm_crtc_vblank_off(crtc);
> > > > >  }
> > > > >  
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > > index 152d7de24a76..542a002ef9d5 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > > @@ -34,6 +34,11 @@ bool enable_writeback;
> > > > >  module_param_named(enable_writeback, enable_writeback, bool, 0444);
> > > > >  MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
> > > > >  
> > > > > +bool virtual_hw;
> > > > 
> > > > Can be static, you only use this in vkms_drv.c.
> > > > 
> > > > > +module_param_named(virtual_hw, virtual_hw, bool, 0444);
> > > > > +MODULE_PARM_DESC(virtual_hw,
> > > > > +		 "Enable virtual hardware mode (disables vblanks and immediately completes flips)");
> > > > > +
> > > > >  static const struct file_operations vkms_driver_fops = {
> > > > >  	.owner		= THIS_MODULE,
> > > > >  	.open		= drm_open,
> > > > > @@ -154,9 +159,13 @@ static int __init vkms_init(void)
> > > > >  	if (ret)
> > > > >  		goto out_unregister;
> > > > >  
> > > > > -	vkms_device->drm.irq_enabled = true;
> > > > > +	vkms_device->output.disable_vblank = virtual_hw;
> > > > > +	vkms_device->drm.irq_enabled = !virtual_hw;
> > > > > +
> > > > > +	if (virtual_hw)
> > > > > +		DRM_INFO("Virtual hardware mode enabled");
> > > > >  
> > > > > -	ret = drm_vblank_init(&vkms_device->drm, 1);
> > > > > +	ret = (virtual_hw) ? 0 : drm_vblank_init(&vkms_device->drm, 1);
> > > > >  	if (ret) {
> > > > >  		DRM_ERROR("Failed to vblank\n");
> > > > >  		goto out_fini;
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > > > > index 9ff2cd4ebf81..256e5e65c947 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > > > > @@ -21,6 +21,7 @@
> > > > >  
> > > > >  extern bool enable_cursor;
> > > > >  extern bool enable_writeback;
> > > > > +extern bool virtual_hw;
> > > > >  
> > > > >  struct vkms_composer {
> > > > >  	struct drm_framebuffer fb;
> > > > > @@ -69,6 +70,7 @@ struct vkms_output {
> > > > >  	struct drm_connector connector;
> > > > >  	struct drm_writeback_connector wb_connector;
> > > > >  	struct hrtimer vblank_hrtimer;
> > > > > +	bool disable_vblank;
> > > > >  	ktime_t period_ns;
> > > > >  	struct drm_pending_vblank_event *event;
> > > > >  	/* ordered wq for composer_work */
> > > > 
> > > > I'm kinda wondering how this works at all ... does writeback/crc still
> > > > work if you set virtual mode? Writeback since this seems based on the
> > > > writeback series ...
> > > 
> > > Hi,
> > > 
> > > I tested this patch with kms_flip with the "drm/drm_vblank: Change
> > > EINVAL by the correct errno" patch [1]. However, you’re right about the
> > > writeback/crc tests, they does not pass because this patch disables
> > > vblank which in turn does not invoke "vkms_vblank_simulate()".
> > > 
> > > In this sense, I’m a little bit confused about how should I handle this
> > > issue. If I correctly understood, without vblank support we have to
> > > trigger vkms_composer_worker() when the userspace invoke
> > > drmModePageFlip(), am I right?  If so, an approach could add page_flip()
> > > callback to vkms and invoke vkms_composer_worker(); however, the
> > > documentation says that page_flip is a legacy entry point. Do you have a
> > > suggestion?
> > 
> > We need this in atomic, for everyone. So instead of launching a vblank and
> > letting the vblank simulation kick off the crc/writeback work,
> > atomic_flush needs to also kick of the crc/vblank work. And make sure that
> > we feed the same vblank frame count values to the generated vblank even as
> > to the crc work (or maybe those are hardcoded to 0 for vblank-less, not
> > sure).
> > -Daniel
> 
> Just for checking if I correctly understood... the idea is reworking
> vkms_vblank_simulate() a little bit in order to decouple the kick of
> crc/writeback to atomic_flush(). Right?

Yes, but only for virtual mode, where we do not have the vblank. For
vblank mode we obviously still need the vblank simulation. I haven't
looked into what/how you should set the vblank counts for the crc/composer
work in the virtual case, that probably needs some figuring out.
-Daniel
>  
> > > 
> > > 1. https://patchwork.freedesktop.org/patch/314399/?series=50697&rev=7
> > > 
> > > Thanks
> > >  
> > > > btw if you send out patches that need other patches, point at that other
> > > > series in the cover letter or patch. Gets confusing fast otherwise.
> > > > -Daniel
> > > > -- 
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > > 
> > > -- 
> > > Rodrigo Siqueira
> > > https://siqueira.tech
> > 
> > 
> > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
