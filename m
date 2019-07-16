Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213DAC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95A5206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Lh56n7fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfGPIkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:40:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36507 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPIkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:40:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so18741291edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIdfG/9yx6bw5IpeIgmgQH4CK6RHFEdgT21lugKeHCE=;
        b=Lh56n7feIgyi7zObGcLERfLnWAP1mnT1j4oeu06GC3aasYpXJHIXrldZQ2n4S5v0bM
         SNd/hnRj+f+PS+THIs3nTbnfUKcEr/HZIT9zwUjxinAukYKn4zZWtO9oUvt9wN7FihKV
         xt8Kv78NAE1fKZDowMC0/coPObZHe1aFe5Qas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LIdfG/9yx6bw5IpeIgmgQH4CK6RHFEdgT21lugKeHCE=;
        b=F0uHTUc5Zn5ALyJg1nFYIUyrG3r6yy0gahBEgeMszimWdAIha0DMSI3sqHRM2Kb6OR
         YKiJD/YQmKckVBfBJs6gMVaMG/F68b1Aq/ty5CfLlTA3pEUVGF98TDzaWOThSOyRY5Fi
         SnhEV29CKd0pbilb+qmnAsGs+PII/mrZXyyGrhGYoaHmhzPWAOv6hFwqd4VRWZBawub2
         qm6SY6qG0HmPLUFeo+7f5q7BwYasi37RbwxOKsL6vgwdv67ZdxZS2sAtyT88OFWQHaBo
         psj16dMdpPNlzASVk0+/tgMgT1FsQWUXb68ZgWxLj4xtKrch6CwhyLuMTRoC1fRa/QLv
         jryQ==
X-Gm-Message-State: APjAAAUd8P6Hswd/jciQ6zXQXH2I/quQ9FoJdqS86gsuMc9CoO9ZXzGC
        +0IiCSYrGGIM2BrJb5aLGG+8OtGG
X-Google-Smtp-Source: APXvYqwjzOEi697SC+7Q2wT7QIHOVFUkqe8WMG5gtzRg2o1DpPF/8eajMUyYSM2C95eqzUHMgIfSrw==
X-Received: by 2002:a17:907:447e:: with SMTP id oo22mr6209894ejb.169.1563266449633;
        Tue, 16 Jul 2019 01:40:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z2sm4180136ejp.73.2019.07.16.01.40.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 01:40:48 -0700 (PDT)
Date:   Tue, 16 Jul 2019 10:40:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] drm/vkms: Add support for writeback
Message-ID: <20190716084046.GU15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <917fda9b620cd84a0826d2d5a59bff9ea07bfde2.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <20190711083441.GJ15868@phenom.ffwll.local>
 <20190712033722.w3r7lvrajnrr4jzh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712033722.w3r7lvrajnrr4jzh@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:37:22AM -0300, Rodrigo Siqueira wrote:
> On 07/11, Daniel Vetter wrote:
> > On Tue, Jun 25, 2019 at 10:39:03PM -0300, Rodrigo Siqueira wrote:
> > > This patch implements the necessary functions to add writeback support
> > > for vkms. This feature is useful for testing compositors if you don't
> > > have hardware with writeback support.
> > > 
> > > Change in V3 (Daniel):
> > > - If writeback is enabled, compose everything into the writeback buffer
> > > instead of CRC private buffer.
> > > - Guarantees that the CRC will match exactly what we have in the
> > > writeback buffer.
> > > 
> > > Change in V2:
> > > - Rework signal completion (Brian)
> > > - Integrates writeback with active_planes (Daniel)
> > > - Compose cursor (Daniel)
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/Makefile         |   9 +-
> > >  drivers/gpu/drm/vkms/vkms_composer.c  |  16 ++-
> > >  drivers/gpu/drm/vkms/vkms_drv.c       |   4 +
> > >  drivers/gpu/drm/vkms/vkms_drv.h       |   8 ++
> > >  drivers/gpu/drm/vkms/vkms_output.c    |  10 ++
> > >  drivers/gpu/drm/vkms/vkms_writeback.c | 141 ++++++++++++++++++++++++++
> > >  6 files changed, 185 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
> > > index 0b767d7efa24..333d3cead0e3 100644
> > > --- a/drivers/gpu/drm/vkms/Makefile
> > > +++ b/drivers/gpu/drm/vkms/Makefile
> > > @@ -1,4 +1,11 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > -vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_composer.o
> > > +vkms-y := \
> > > +	vkms_drv.o \
> > > +	vkms_plane.o \
> > > +	vkms_output.o \
> > > +	vkms_crtc.o \
> > > +	vkms_gem.o \
> > > +	vkms_composer.o \
> > > +	vkms_writeback.o
> > >  
> > >  obj-$(CONFIG_DRM_VKMS) += vkms.o
> > > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > > index 8126aa0f968f..2317803e7320 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > > @@ -157,16 +157,17 @@ void vkms_composer_worker(struct work_struct *work)
> > >  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> > >  	struct vkms_composer *primary_composer = NULL;
> > >  	struct vkms_composer *cursor_composer = NULL;
> > > +	bool crc_pending, wb_pending;
> > 
> > I'm not seeing how you schedule this work for writeback if there's no crc
> > enabled. Does that work?
> 
> If we enable writeback, we set true for the flag composer_enabled (see
> vkms_output.c in this patch) which also make vkms_vblank_simulate able
> to handle crc. Since writeback is oneshot, we only enable it on
> vkms_wb_atomic_commit (crtc_state->wb_pending = true); in its turn
> vkms_composer_worker() use writeback buffer instead of creating a new
> one for computing crc. Finally, at the end of vkms_composer_worker() we
> disable the writeback.

Yeah I got all that. But who's doing the queue_work? That only happens
if crc_enabled is set, and I'm not seeing how that's changed. Might be in
one of the earlier patches ...
-Daniel

> 
> > >  	void *vaddr_out = NULL;
> > >  	u32 crc32 = 0;
> > >  	u64 frame_start, frame_end;
> > > -	bool crc_pending;
> > >  	int ret;
> > >  
> > >  	spin_lock_irq(&out->composer_lock);
> > >  	frame_start = crtc_state->frame_start;
> > >  	frame_end = crtc_state->frame_end;
> > >  	crc_pending = crtc_state->crc_pending;
> > > +	wb_pending = crtc_state->wb_pending;
> > >  	crtc_state->frame_start = 0;
> > >  	crtc_state->frame_end = 0;
> > >  	crtc_state->crc_pending = false;
> > > @@ -188,9 +189,12 @@ void vkms_composer_worker(struct work_struct *work)
> > >  	if (!primary_composer)
> > >  		return;
> > >  
> > > +	if (wb_pending)
> > > +		vaddr_out = crtc_state->active_writeback;
> > > +
> > >  	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
> > >  	if (ret) {
> > > -		if (ret == -EINVAL)
> > > +		if (ret == -EINVAL && !wb_pending)
> > >  			kfree(vaddr_out);
> > >  		return;
> > >  	}
> > > @@ -203,6 +207,14 @@ void vkms_composer_worker(struct work_struct *work)
> > >  	while (frame_start <= frame_end)
> > >  		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
> > >  
> > > +	if (wb_pending) {
> > > +		drm_writeback_signal_completion(&out->wb_connector, 0);
> > > +		spin_lock_irq(&out->composer_lock);
> > > +		crtc_state->wb_pending = false;
> > > +		spin_unlock_irq(&out->composer_lock);
> > > +		return;
> > > +	}
> > > +
> > >  	kfree(vaddr_out);
> > >  }
> > >  
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > index ac790b6527e4..152d7de24a76 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > @@ -30,6 +30,10 @@ bool enable_cursor;
> > >  module_param_named(enable_cursor, enable_cursor, bool, 0444);
> > >  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
> > >  
> > > +bool enable_writeback;
> > > +module_param_named(enable_writeback, enable_writeback, bool, 0444);
> > > +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
> > > +
> > >  static const struct file_operations vkms_driver_fops = {
> > >  	.owner		= THIS_MODULE,
> > >  	.open		= drm_open,
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > > index fc6cda164336..9ff2cd4ebf81 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > > @@ -7,6 +7,7 @@
> > >  #include <drm/drm.h>
> > >  #include <drm/drm_gem.h>
> > >  #include <drm/drm_encoder.h>
> > > +#include <drm/drm_writeback.h>
> > >  #include <linux/hrtimer.h>
> > >  
> > >  #define XRES_MIN    20
> > > @@ -19,6 +20,7 @@
> > >  #define YRES_MAX  8192
> > >  
> > >  extern bool enable_cursor;
> > > +extern bool enable_writeback;
> > >  
> > >  struct vkms_composer {
> > >  	struct drm_framebuffer fb;
> > > @@ -52,9 +54,11 @@ struct vkms_crtc_state {
> > >  	int num_active_planes;
> > >  	/* stack of active planes for crc computation, should be in z order */
> > >  	struct vkms_plane_state **active_planes;
> > > +	void *active_writeback;
> > >  
> > >  	/* below three are protected by vkms_output.composer_lock */
> > >  	bool crc_pending;
> > > +	bool wb_pending;
> > >  	u64 frame_start;
> > >  	u64 frame_end;
> > >  };
> > > @@ -63,6 +67,7 @@ struct vkms_output {
> > >  	struct drm_crtc crtc;
> > >  	struct drm_encoder encoder;
> > >  	struct drm_connector connector;
> > > +	struct drm_writeback_connector wb_connector;
> > >  	struct hrtimer vblank_hrtimer;
> > >  	ktime_t period_ns;
> > >  	struct drm_pending_vblank_event *event;
> > > @@ -147,4 +152,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
> > >  /* Composer Support */
> > >  void vkms_composer_worker(struct work_struct *work);
> > >  
> > > +/* Writeback */
> > > +int enable_writeback_connector(struct vkms_device *vkmsdev);
> > > +
> > >  #endif /* _VKMS_DRV_H_ */
> > > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > > index fb1941a6522c..aea1d4410864 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > > @@ -84,6 +84,16 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> > >  		goto err_attach;
> > >  	}
> > >  
> > > +	if (enable_writeback) {
> > > +		ret = enable_writeback_connector(vkmsdev);
> > > +		if (!ret) {
> > > +			output->composer_enabled = true;
> > > +			DRM_INFO("Writeback connector enabled");
> > > +		} else {
> > > +			DRM_ERROR("Failed to init writeback connector\n");
> > > +		}
> > > +	}
> > > +
> > >  	drm_mode_config_reset(dev);
> > >  
> > >  	return 0;
> > > diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> > > new file mode 100644
> > > index 000000000000..34dad37a0236
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> > > @@ -0,0 +1,141 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include "vkms_drv.h"
> > > +#include <drm/drm_writeback.h>
> > > +#include <drm/drm_probe_helper.h>
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_gem_framebuffer_helper.h>
> > > +
> > > +static const u32 vkms_wb_formats[] = {
> > > +	DRM_FORMAT_XRGB8888,
> > > +};
> > > +
> > > +static const struct drm_connector_funcs vkms_wb_connector_funcs = {
> > > +	.fill_modes = drm_helper_probe_single_connector_modes,
> > > +	.destroy = drm_connector_cleanup,
> > > +	.reset = drm_atomic_helper_connector_reset,
> > > +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > +};
> > > +
> > > +static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
> > > +					struct drm_crtc_state *crtc_state,
> > > +					struct drm_connector_state *conn_state)
> > > +{
> > > +	struct drm_framebuffer *fb;
> > > +	const struct drm_display_mode *mode = &crtc_state->mode;
> > > +
> > > +	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> > > +		return 0;
> > > +
> > > +	fb = conn_state->writeback_job->fb;
> > > +	if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
> > > +		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> > > +			      fb->width, fb->height);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (fb->format->format != DRM_FORMAT_XRGB8888) {
> > > +		struct drm_format_name_buf format_name;
> > > +
> > > +		DRM_DEBUG_KMS("Invalid pixel format %s\n",
> > > +			      drm_get_format_name(fb->format->format,
> > > +						  &format_name));
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_funcs = {
> > > +	.atomic_check = vkms_wb_encoder_atomic_check,
> > > +};
> > > +
> > > +static int vkms_wb_connector_get_modes(struct drm_connector *connector)
> > > +{
> > > +	struct drm_device *dev = connector->dev;
> > > +
> > > +	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
> > > +				    dev->mode_config.max_height);
> > > +}
> > 
> > Do we need a mode for writeb connector? Is that used by userspace to
> > figure out the max size for writeback?
> 
> Yes, we need it. You're right about the userspace utilizing it to figure
> out the max size writeback, kms_writeback strongly rely on this.
> 
> > > +
> > > +static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
> > > +			       struct drm_writeback_job *job)
> > > +{
> > > +	struct vkms_gem_object *vkms_obj;
> > > +	struct drm_gem_object *gem_obj;
> > > +	int ret;
> > > +
> > > +	if (!job->fb)
> > > +		return 0;
> > 
> > Can this happen?
> 
> Yes, here is the path until this function is invoked:
> 
>   drm_atomic_helper_prepare_planes()
> 
> Inside the above function we have:
> 
>   for_each_new_connector_in_state(state, connector, new_conn_state, i)
> 
> which in turn invoke:
> 
>   drm_writeback_prepare_job(new_conn_state->writeback_job);
> 
> FWIU, new_conn_state->writeback_job could be NULL. Anyway, I also tested
> it, and I notice this condition can be reached.
>  
> > > +
> > > +	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
> > > +	ret = vkms_gem_vmap(gem_obj);
> > > +	if (ret) {
> > > +		DRM_ERROR("vmap failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> > > +	job->priv = vkms_obj->vaddr;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
> > > +				struct drm_writeback_job *job)
> > > +{
> > > +	struct drm_gem_object *gem_obj;
> > > +
> > > +	if (!job->fb)
> > > +		return;
> > 
> > Same here?
> > 
> > > +
> > > +	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
> > > +	vkms_gem_vunmap(gem_obj);
> > > +}
> > > +
> > > +static void vkms_wb_atomic_commit(struct drm_connector *conn,
> > > +				  struct drm_connector_state *state)
> > > +{
> > > +	struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
> > > +	struct vkms_output *output = &vkmsdev->output;
> > > +	struct drm_writeback_connector *wb_conn = &output->wb_connector;
> > > +	struct drm_connector_state *conn_state = wb_conn->base.state;
> > > +	struct vkms_crtc_state *crtc_state = output->composer_state;
> > > +
> > > +	if (!conn_state)
> > > +		return;
> > > +
> > > +	if (!conn_state->writeback_job || !conn_state->writeback_job->fb) {
> > > +		DRM_DEBUG_DRIVER("Disable writeback\n");
> > > +		return;
> > > +	}
> > 
> > All three checks above sound like helpers should take care of this?
> 
> Maybe I missed something, but I did not find such helper. I also noticed
> that vc4, rcar-du, and mali does the same check.
>  
> Thanks
> 
> > > +
> > > +	spin_lock_irq(&output->composer_lock);
> > > +	crtc_state->active_writeback = conn_state->writeback_job->priv;
> > > +	crtc_state->wb_pending = true;
> > > +	spin_unlock_irq(&output->composer_lock);
> > > +	drm_writeback_queue_job(wb_conn, state);
> > > +}
> > > +
> > > +static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
> > > +	.get_modes = vkms_wb_connector_get_modes,
> > > +	.prepare_writeback_job = vkms_wb_prepare_job,
> > > +	.cleanup_writeback_job = vkms_wb_cleanup_job,
> > > +	.atomic_commit = vkms_wb_atomic_commit,
> > > +};
> > > +
> > > +int enable_writeback_connector(struct vkms_device *vkmsdev)
> > > +{
> > > +	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
> > > +
> > > +	vkmsdev->output.wb_connector.encoder.possible_crtcs = 1;
> > > +	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
> > > +
> > > +	return drm_writeback_connector_init(&vkmsdev->drm, wb,
> > > +					    &vkms_wb_connector_funcs,
> > > +					    &vkms_wb_encoder_helper_funcs,
> > > +					    vkms_wb_formats,
> > > +					    ARRAY_SIZE(vkms_wb_formats));
> > > +}
> > 
> > Overall looks like good approach.
> > -Daniel
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
