Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B2C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313BE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="baJN3gmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfGKIer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:34:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37060 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:34:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so4932679eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CsHw28pKgN+na8MsfU5qTAb99IUST4U40dznTgxiPFI=;
        b=baJN3gmHffVGzGA5zNavCv2NKnmscYpdh9/R3+Uzq5y6bRTFrW8DcvsfYcroDi2zY9
         1gJtHI4Hz2FjYy2zGqiiG3krVh5QbQe6r/RNcqd+IEoXvPnbD25LbD/hXxajGKMyjccZ
         hqfDfIuxn1wLeh46NNl2XtJJQE2/g77uqqnnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CsHw28pKgN+na8MsfU5qTAb99IUST4U40dznTgxiPFI=;
        b=eKmjUdB1HREnYaBeOvKAay9LfeMBglhFwJ3oyCwO7QlPIfY9o5tb3lYQdoYVkKX+Db
         ZBhQ+ILxtoNXZ7jM2ASjyb4mU5CeEslUUi7s48KbpjA4/uP4YLPPx0laLkdCw2jU978s
         SURbIf0Ks1QIhqZVB1EaHdmOC1GkgNWvj1v9Oi4uvttI769Ezrs51f9MEDP6XkP5RY0A
         A1w3YViK5fM0CCaUKPFLxYARcIaxJOazLriAgs3rC/vItICDyWasdakZoYlDUFwgQaUD
         v5VThyiJKGcoLfQzbeEV6PJOCpzceVcRDywR01MpnCY1cR5Re4MDm8OapiE8fz6xwrAd
         +a+w==
X-Gm-Message-State: APjAAAXxOYsVLdqrgyECElKbTcAkL/peuYboj+lIQ3QG3wl18gSz7Gni
        /zTomRa73S9LCZnc28HaFus=
X-Google-Smtp-Source: APXvYqzV1asblfhenexP+5NuH0bzB0A6r1RZq1UlvbE7k0NvTT47IiMWBygNa6b3vciwdHXO9bumYw==
X-Received: by 2002:a50:941c:: with SMTP id p28mr2266855eda.103.1562834084222;
        Thu, 11 Jul 2019 01:34:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id rv16sm1014202ejb.79.2019.07.11.01.34.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:34:43 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:34:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/5] drm/vkms: Add support for writeback
Message-ID: <20190711083441.GJ15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <917fda9b620cd84a0826d2d5a59bff9ea07bfde2.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917fda9b620cd84a0826d2d5a59bff9ea07bfde2.1561491964.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:39:03PM -0300, Rodrigo Siqueira wrote:
> This patch implements the necessary functions to add writeback support
> for vkms. This feature is useful for testing compositors if you don't
> have hardware with writeback support.
> 
> Change in V3 (Daniel):
> - If writeback is enabled, compose everything into the writeback buffer
> instead of CRC private buffer.
> - Guarantees that the CRC will match exactly what we have in the
> writeback buffer.
> 
> Change in V2:
> - Rework signal completion (Brian)
> - Integrates writeback with active_planes (Daniel)
> - Compose cursor (Daniel)
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/Makefile         |   9 +-
>  drivers/gpu/drm/vkms/vkms_composer.c  |  16 ++-
>  drivers/gpu/drm/vkms/vkms_drv.c       |   4 +
>  drivers/gpu/drm/vkms/vkms_drv.h       |   8 ++
>  drivers/gpu/drm/vkms/vkms_output.c    |  10 ++
>  drivers/gpu/drm/vkms/vkms_writeback.c | 141 ++++++++++++++++++++++++++
>  6 files changed, 185 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
> 
> diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
> index 0b767d7efa24..333d3cead0e3 100644
> --- a/drivers/gpu/drm/vkms/Makefile
> +++ b/drivers/gpu/drm/vkms/Makefile
> @@ -1,4 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_composer.o
> +vkms-y := \
> +	vkms_drv.o \
> +	vkms_plane.o \
> +	vkms_output.o \
> +	vkms_crtc.o \
> +	vkms_gem.o \
> +	vkms_composer.o \
> +	vkms_writeback.o
>  
>  obj-$(CONFIG_DRM_VKMS) += vkms.o
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 8126aa0f968f..2317803e7320 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -157,16 +157,17 @@ void vkms_composer_worker(struct work_struct *work)
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>  	struct vkms_composer *primary_composer = NULL;
>  	struct vkms_composer *cursor_composer = NULL;
> +	bool crc_pending, wb_pending;

I'm not seeing how you schedule this work for writeback if there's no crc
enabled. Does that work?
>  	void *vaddr_out = NULL;
>  	u32 crc32 = 0;
>  	u64 frame_start, frame_end;
> -	bool crc_pending;
>  	int ret;
>  
>  	spin_lock_irq(&out->composer_lock);
>  	frame_start = crtc_state->frame_start;
>  	frame_end = crtc_state->frame_end;
>  	crc_pending = crtc_state->crc_pending;
> +	wb_pending = crtc_state->wb_pending;
>  	crtc_state->frame_start = 0;
>  	crtc_state->frame_end = 0;
>  	crtc_state->crc_pending = false;
> @@ -188,9 +189,12 @@ void vkms_composer_worker(struct work_struct *work)
>  	if (!primary_composer)
>  		return;
>  
> +	if (wb_pending)
> +		vaddr_out = crtc_state->active_writeback;
> +
>  	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
>  	if (ret) {
> -		if (ret == -EINVAL)
> +		if (ret == -EINVAL && !wb_pending)
>  			kfree(vaddr_out);
>  		return;
>  	}
> @@ -203,6 +207,14 @@ void vkms_composer_worker(struct work_struct *work)
>  	while (frame_start <= frame_end)
>  		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
>  
> +	if (wb_pending) {
> +		drm_writeback_signal_completion(&out->wb_connector, 0);
> +		spin_lock_irq(&out->composer_lock);
> +		crtc_state->wb_pending = false;
> +		spin_unlock_irq(&out->composer_lock);
> +		return;
> +	}
> +
>  	kfree(vaddr_out);
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index ac790b6527e4..152d7de24a76 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -30,6 +30,10 @@ bool enable_cursor;
>  module_param_named(enable_cursor, enable_cursor, bool, 0444);
>  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
>  
> +bool enable_writeback;
> +module_param_named(enable_writeback, enable_writeback, bool, 0444);
> +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
> +
>  static const struct file_operations vkms_driver_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= drm_open,
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index fc6cda164336..9ff2cd4ebf81 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -7,6 +7,7 @@
>  #include <drm/drm.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_encoder.h>
> +#include <drm/drm_writeback.h>
>  #include <linux/hrtimer.h>
>  
>  #define XRES_MIN    20
> @@ -19,6 +20,7 @@
>  #define YRES_MAX  8192
>  
>  extern bool enable_cursor;
> +extern bool enable_writeback;
>  
>  struct vkms_composer {
>  	struct drm_framebuffer fb;
> @@ -52,9 +54,11 @@ struct vkms_crtc_state {
>  	int num_active_planes;
>  	/* stack of active planes for crc computation, should be in z order */
>  	struct vkms_plane_state **active_planes;
> +	void *active_writeback;
>  
>  	/* below three are protected by vkms_output.composer_lock */
>  	bool crc_pending;
> +	bool wb_pending;
>  	u64 frame_start;
>  	u64 frame_end;
>  };
> @@ -63,6 +67,7 @@ struct vkms_output {
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
>  	struct drm_connector connector;
> +	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
>  	ktime_t period_ns;
>  	struct drm_pending_vblank_event *event;
> @@ -147,4 +152,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
>  /* Composer Support */
>  void vkms_composer_worker(struct work_struct *work);
>  
> +/* Writeback */
> +int enable_writeback_connector(struct vkms_device *vkmsdev);
> +
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index fb1941a6522c..aea1d4410864 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -84,6 +84,16 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  		goto err_attach;
>  	}
>  
> +	if (enable_writeback) {
> +		ret = enable_writeback_connector(vkmsdev);
> +		if (!ret) {
> +			output->composer_enabled = true;
> +			DRM_INFO("Writeback connector enabled");
> +		} else {
> +			DRM_ERROR("Failed to init writeback connector\n");
> +		}
> +	}
> +
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> new file mode 100644
> index 000000000000..34dad37a0236
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "vkms_drv.h"
> +#include <drm/drm_writeback.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +
> +static const u32 vkms_wb_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static const struct drm_connector_funcs vkms_wb_connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
> +{
> +	struct drm_framebuffer *fb;
> +	const struct drm_display_mode *mode = &crtc_state->mode;
> +
> +	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> +		return 0;
> +
> +	fb = conn_state->writeback_job->fb;
> +	if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
> +		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> +			      fb->width, fb->height);
> +		return -EINVAL;
> +	}
> +
> +	if (fb->format->format != DRM_FORMAT_XRGB8888) {
> +		struct drm_format_name_buf format_name;
> +
> +		DRM_DEBUG_KMS("Invalid pixel format %s\n",
> +			      drm_get_format_name(fb->format->format,
> +						  &format_name));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_funcs = {
> +	.atomic_check = vkms_wb_encoder_atomic_check,
> +};
> +
> +static int vkms_wb_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +
> +	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
> +				    dev->mode_config.max_height);
> +}

Do we need a mode for writeb connector? Is that used by userspace to
figure out the max size for writeback?

> +
> +static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
> +			       struct drm_writeback_job *job)
> +{
> +	struct vkms_gem_object *vkms_obj;
> +	struct drm_gem_object *gem_obj;
> +	int ret;
> +
> +	if (!job->fb)
> +		return 0;

Can this happen?

> +
> +	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
> +	ret = vkms_gem_vmap(gem_obj);
> +	if (ret) {
> +		DRM_ERROR("vmap failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> +	job->priv = vkms_obj->vaddr;
> +
> +	return 0;
> +}
> +
> +static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
> +				struct drm_writeback_job *job)
> +{
> +	struct drm_gem_object *gem_obj;
> +
> +	if (!job->fb)
> +		return;

Same here?

> +
> +	gem_obj = drm_gem_fb_get_obj(job->fb, 0);
> +	vkms_gem_vunmap(gem_obj);
> +}
> +
> +static void vkms_wb_atomic_commit(struct drm_connector *conn,
> +				  struct drm_connector_state *state)
> +{
> +	struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
> +	struct vkms_output *output = &vkmsdev->output;
> +	struct drm_writeback_connector *wb_conn = &output->wb_connector;
> +	struct drm_connector_state *conn_state = wb_conn->base.state;
> +	struct vkms_crtc_state *crtc_state = output->composer_state;
> +
> +	if (!conn_state)
> +		return;
> +
> +	if (!conn_state->writeback_job || !conn_state->writeback_job->fb) {
> +		DRM_DEBUG_DRIVER("Disable writeback\n");
> +		return;
> +	}

All three checks above sound like helpers should take care of this?

> +
> +	spin_lock_irq(&output->composer_lock);
> +	crtc_state->active_writeback = conn_state->writeback_job->priv;
> +	crtc_state->wb_pending = true;
> +	spin_unlock_irq(&output->composer_lock);
> +	drm_writeback_queue_job(wb_conn, state);
> +}
> +
> +static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
> +	.get_modes = vkms_wb_connector_get_modes,
> +	.prepare_writeback_job = vkms_wb_prepare_job,
> +	.cleanup_writeback_job = vkms_wb_cleanup_job,
> +	.atomic_commit = vkms_wb_atomic_commit,
> +};
> +
> +int enable_writeback_connector(struct vkms_device *vkmsdev)
> +{
> +	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
> +
> +	vkmsdev->output.wb_connector.encoder.possible_crtcs = 1;
> +	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
> +
> +	return drm_writeback_connector_init(&vkmsdev->drm, wb,
> +					    &vkms_wb_connector_funcs,
> +					    &vkms_wb_encoder_helper_funcs,
> +					    vkms_wb_formats,
> +					    ARRAY_SIZE(vkms_wb_formats));
> +}

Overall looks like good approach.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
