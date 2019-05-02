Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5321CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164A72081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfEBQVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:21:49 -0400
Received: from foss.arm.com ([217.140.101.70]:48810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBQVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:21:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EF87A78;
        Thu,  2 May 2019 09:21:46 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25B953F5AF;
        Thu,  2 May 2019 09:21:46 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 6351268240E; Thu,  2 May 2019 17:21:44 +0100 (BST)
Date:   Thu, 2 May 2019 17:21:44 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ben Davis <Ben.Davis@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] drm: Add writeback_dest_x,y,w,h properties
Message-ID: <20190502162144.GY15144@e110455-lin.cambridge.arm.com>
References: <1556813386-18823-1-git-send-email-ben.davis@arm.com>
 <1556813386-18823-2-git-send-email-ben.davis@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556813386-18823-2-git-send-email-ben.davis@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 05:10:09PM +0100, Ben Davis wrote:
> Add new properties to specify x,y coordinates and
> width and height for writeback.
> 
> These are reset to 0 on duplicating state to provide
> robustness against accidental scaling.
> 
> Signed-off-by: Ben Davis <ben.davis@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  6 +++
>  drivers/gpu/drm/drm_atomic_uapi.c         | 17 ++++++++
>  drivers/gpu/drm/drm_writeback.c           | 66 +++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h               | 23 +++++++++++
>  include/drm/drm_mode_config.h             | 20 ++++++++++
>  5 files changed, 132 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 25a95b9..5973ca3 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -382,6 +382,12 @@ __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,
>  
>  	/* Don't copy over a writeback job, they are used only once */
>  	state->writeback_job = NULL;
> +
> +	/* Auto clear writeback coordinates, should only be used once */
> +	state->writeback_dest_x = 0;
> +	state->writeback_dest_y = 0;
> +	state->writeback_dest_w = 0;
> +	state->writeback_dest_h = 0;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_connector_duplicate_state);
>  
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index d520a04..7d3fb7f 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -765,6 +765,14 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>  			return -EINVAL;
>  		}
>  		state->content_protection = val;
> +	} else if (property == config->prop_writeback_dest_x) {
> +		state->writeback_dest_x = val;
> +	} else if (property == config->prop_writeback_dest_y) {
> +		state->writeback_dest_y = val;
> +	} else if (property == config->prop_writeback_dest_w) {
> +		state->writeback_dest_w = val;
> +	} else if (property == config->prop_writeback_dest_h) {
> +		state->writeback_dest_h = val;
>  	} else if (property == config->writeback_fb_id_property) {
>  		struct drm_framebuffer *fb = drm_framebuffer_lookup(dev, NULL, val);
>  		int ret = drm_atomic_set_writeback_fb_for_connector(state, fb);
> @@ -837,6 +845,15 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		*val = state->scaling_mode;
>  	} else if (property == connector->content_protection_property) {
>  		*val = state->content_protection;
> +	} else if (property == config->prop_writeback_dest_x) {
> +		/* Auto clear wb co-ordinates to prevent accidental scaling */
> +		*val = 0;
> +	} else if (property == config->prop_writeback_dest_y) {
> +		*val = 0;
> +	} else if (property == config->prop_writeback_dest_w) {
> +		*val = 0;
> +	} else if (property == config->prop_writeback_dest_h) {
> +		*val = 0;
>  	} else if (property == config->writeback_fb_id_property) {
>  		/* Writeback framebuffer is one-shot, write and forget */
>  		*val = 0;
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index c20e6fe..7c53abd 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -74,6 +74,30 @@
>   *	applications making use of writeback connectors *always* retrieve an
>   *	out-fence for the commit and use it appropriately.
>   *	From userspace, this property will always read as zero.
> + *
> + *  "WRITEBACK_DEST_X":
> + *	The x-coordinate to write back onto the output writeback framebuffer.
> + *	0 acts as default. If non-zero the composition will be translated
> + *	horizontally in the buffer by the amount specified. This is the case
> + *	even if not scaling on writeback.
> + *
> + *  "WRITEBACK_DEST_Y":
> + *	The y-coordinate to write back onto the output writeback framebuffer.
> + *	0 acts as default. If non-zero the composition will be translated
> + *	vertically in the buffer by the amount specified. This is the case even
> + *	if not scaling on writeback.
> + *
> + *  "WRITEBACK_DEST_W":
> + *	The width of the composition to write back. 0 acts as default. If
> + *	non-zero the composition will be scaled to match the given width.
> + *	If scaling both WRITEBACK_DEST_W and WRITEBACK_DEST_H should be
> + *	set as non-zero.
> + *
> + *  "WRITEBACK_DEST_H":
> + *	The height of the composition to write back. 0 acts as default. If
> + *	non-zero the composition will be scaled to match the given height.
> + *	If scaling both WRITEBACK_DEST_W and WRITEBACK_DEST_H should be
> + *	set as non-zero.
>   */
>  
>  #define fence_to_wb_connector(x) container_of(x->lock, \
> @@ -141,6 +165,38 @@ static int create_writeback_properties(struct drm_device *dev)
>  		dev->mode_config.writeback_out_fence_ptr_property = prop;
>  	}
>  
> +	if (!dev->mode_config.prop_writeback_dest_x) {
> +		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +						 "WRITEBACK_DEST_X", 0, UINT_MAX);
> +		if (!prop)
> +			return -ENOMEM;
> +		dev->mode_config.prop_writeback_dest_x = prop;
> +	}
> +
> +	if (!dev->mode_config.prop_writeback_dest_y) {
> +		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +						 "WRITEBACK_DEST_Y", 0, UINT_MAX);
> +		if (!prop)
> +			return -ENOMEM;
> +		dev->mode_config.prop_writeback_dest_y = prop;
> +	}
> +
> +	if (!dev->mode_config.prop_writeback_dest_w) {
> +		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +						 "WRITEBACK_DEST_W", 0, UINT_MAX);
> +		if (!prop)
> +			return -ENOMEM;
> +		dev->mode_config.prop_writeback_dest_w = prop;
> +	}
> +
> +	if (!dev->mode_config.prop_writeback_dest_h) {
> +		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +						 "WRITEBACK_DEST_H", 0, UINT_MAX);
> +		if (!prop)
> +			return -ENOMEM;
> +		dev->mode_config.prop_writeback_dest_h = prop;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -225,6 +281,16 @@ int drm_writeback_connector_init(struct drm_device *dev,
>  	drm_object_attach_property(&connector->base,
>  				   config->writeback_pixel_formats_property,
>  				   blob->base.id);
> +
> +	drm_object_attach_property(&connector->base,
> +				   config->prop_writeback_dest_x, 0);
> +	drm_object_attach_property(&connector->base,
> +				   config->prop_writeback_dest_y, 0);
> +	drm_object_attach_property(&connector->base,
> +				   config->prop_writeback_dest_w, 0);
> +	drm_object_attach_property(&connector->base,
> +				   config->prop_writeback_dest_h, 0);
> +
>  	wb_connector->pixel_formats_blob_ptr = blob;
>  
>  	return 0;
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 8fe22ab..4c7701e 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -515,6 +515,25 @@ struct drm_connector_state {
>  	 */
>  	struct drm_writeback_job *writeback_job;
>  
> +	/** @writeback_dest_x: x coord to write plane to on wb buffer
> +	 *  The written back composition will be translated by this
> +	 *  amount horizontally on the output buffer.
> +	 */
> +	/** @writeback_dest_y: y coord to write plane to on wb buffer
> +	 *  The written back composition will be translated by this
> +	 *  amount vertically on the output buffer.
> +	 */
> +	/** @writeback_dest_w: width of plane to write to wb buffer
> +	 *  The written back composition will be scaled to match this
> +	 *  height dimension on the output buffer. Ignored if 0.
> +	 */
> +	/** @writeback_dest_h: height of plane to write to wb buffer
> +	 *  The written back composition will be scaled to match this
> +	 *  width dimension on the output buffer. Ignored if 0.
> +	 */
> +	uint32_t writeback_dest_x, writeback_dest_y,
> +		 writeback_dest_w, writeback_dest_h;
> +
>  	/**
>  	 * @max_requested_bpc: Connector property to limit the maximum bit
>  	 * depth of the pixels.
> @@ -704,6 +723,10 @@ struct drm_connector_funcs {
>  	 * cleaned up by calling the @atomic_destroy_state hook in this
>  	 * structure.
>  	 *
> +	 * State relating to writeback including writeback_job and
> +	 * writeback_dest_x,y,w,h is not intended to be reused and so will not
> +	 * be duplicated and will instead be reset to NULL/0 respectively.
> +	 *
>  	 * This callback is mandatory for atomic drivers.
>  	 *
>  	 * Atomic drivers which don't subclass &struct drm_connector_state should use
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 7f60e8e..40ce4a8 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -622,6 +622,26 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *prop_crtc_h;
>  	/**
> +	 * @prop_writeback_dest_x: Writeback connector property for the crtc
> +	 * output destination position in the writeback buffer.
> +	 */
> +	struct drm_property *prop_writeback_dest_x;
> +	/**
> +	 * @prop_writeback_dest_y: Writeback connector property for the crtc
> +	 * output destination position in the writeback buffer.
> +	 */
> +	struct drm_property *prop_writeback_dest_y;
> +	/**
> +	 * @prop_writeback_dest_w: Writeback connector property for the crtc
> +	 * output destination position in the writeback buffer.
> +	 */
> +	struct drm_property *prop_writeback_dest_w;
> +	/**
> +	 * @prop_writeback_dest_h: Writeback connector property for the crtc
> +	 * output destination position in the writeback buffer.
> +	 */
> +	struct drm_property *prop_writeback_dest_h;
> +	/**
>  	 * @prop_fb_id: Default atomic plane property to specify the
>  	 * &drm_framebuffer.
>  	 */
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
