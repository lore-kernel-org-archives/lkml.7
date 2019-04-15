Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B120883
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDOJUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:20:48 -0400
Received: from foss.arm.com ([217.140.101.70]:59020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDOJUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:20:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC33374;
        Mon, 15 Apr 2019 02:20:47 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7C23F557;
        Mon, 15 Apr 2019 02:20:47 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 6F3EB6801C0; Mon, 15 Apr 2019 10:20:45 +0100 (BST)
Date:   Mon, 15 Apr 2019 10:20:45 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Ben Davis <Ben.Davis@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>
Subject: Re: [v2,1/2] drm: Add writeback_w,h properties
Message-ID: <20190415092045.GO15144@e110455-lin.cambridge.arm.com>
References: <1555078094-6587-2-git-send-email-ben.davis@arm.com>
 <20190415075922.GA24596@james-ThinkStation-P300>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415075922.GA24596@james-ThinkStation-P300>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:59:30AM +0100, james qian wang (Arm Technology China) wrote:
> On Fri, Apr 12, 2019 at 02:08:28PM +0000, Ben Davis wrote:
> > Add new properties to specify width and height for writeback.
> > 
> > Signed-off-by: Ben Davis <ben.davis@arm.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++++++
> >  drivers/gpu/drm/drm_writeback.c   | 28 ++++++++++++++++++++++++++++
> >  include/drm/drm_connector.h       |  4 ++++
> >  include/drm/drm_mode_config.h     | 10 ++++++++++
> >  4 files changed, 50 insertions(+)
> > 
> > -- 
> > 2.7.4
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > index d520a04..1f68dce 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -765,6 +765,10 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
> >  			return -EINVAL;
> >  		}
> >  		state->content_protection = val;
> > +	} else if (property == config->prop_writeback_w) {
> > +		state->writeback_w = val;
> > +	} else if (property == config->prop_writeback_h) {
> > +		state->writeback_h = val;
> >  	} else if (property == config->writeback_fb_id_property) {
> >  		struct drm_framebuffer *fb = drm_framebuffer_lookup(dev, NULL, val);
> >  		int ret = drm_atomic_set_writeback_fb_for_connector(state, fb);
> > @@ -837,6 +841,10 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
> >  		*val = state->scaling_mode;
> >  	} else if (property == connector->content_protection_property) {
> >  		*val = state->content_protection;
> > +	} else if (property == config->prop_writeback_w) {
> > +		*val = state->writeback_w;
> > +	} else if (property == config->prop_writeback_h) {
> > +		*val = state->writeback_h;
> >  	} else if (property == config->writeback_fb_id_property) {
> >  		/* Writeback framebuffer is one-shot, write and forget */
> >  		*val = 0;
> > diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> > index c20e6fe..3d0453e 100644
> > --- a/drivers/gpu/drm/drm_writeback.c
> > +++ b/drivers/gpu/drm/drm_writeback.c
> > @@ -74,6 +74,12 @@
> >   *	applications making use of writeback connectors *always* retrieve an
> >   *	out-fence for the commit and use it appropriately.
> >   *	From userspace, this property will always read as zero.
> > + *
> > + *  "WRITEBACK_W":
> > + *	The width of the writeback buffer to write back. 0 acts as default.
> > + *
> > + *  "WRITEBACK_H":
> > + *	The height of the writeback buffer to write back. 0 acts as default.
> >   */
> >  
> >  #define fence_to_wb_connector(x) container_of(x->lock, \
> > @@ -141,6 +147,22 @@ static int create_writeback_properties(struct drm_device *dev)
> >  		dev->mode_config.writeback_out_fence_ptr_property = prop;
> >  	}
> >  
> > +	if (!dev->mode_config.prop_writeback_w) {
> > +		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> > +						 "WRITEBACK_W", 1, UINT_MAX);
> > +		if (!prop)
> > +			return -ENOMEM;
> > +		dev->mode_config.prop_writeback_w = prop;
> > +	}
> > +
> > +	if (!dev->mode_config.prop_writeback_h) {
> > +		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> > +						 "WRITEBACK_H", 1, UINT_MAX);
> > +		if (!prop)
> > +			return -ENOMEM;
> > +		dev->mode_config.prop_writeback_h = prop;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -225,6 +247,12 @@ int drm_writeback_connector_init(struct drm_device *dev,
> >  	drm_object_attach_property(&connector->base,
> >  				   config->writeback_pixel_formats_property,
> >  				   blob->base.id);
> > +
> > +	drm_object_attach_property(&connector->base,
> > +				   config->prop_writeback_w, 0);
> > +	drm_object_attach_property(&connector->base,
> > +				   config->prop_writeback_h, 0);
> 
> Hi Ben:
> Do we real need these two individual properties for specifing the writeback
> w/h, can we use fb->w/h ?
> And since these two properties are added as common and standard properties,
> it influnce all existing write-back implementation which all assumed
> writeback size as fb->w/h.

The idea of having these additional properties was to maintain backwards
compatibility (of some sort). If you don't set writeback_w/h then the
assumption is that they are the same as fb->w/h, but I can see how it's
going to be confusing to have fb->w/h different from crtc->w/h and
different from writeback_w/h.


> To compatible with existing writeback support, I suggest to keep to
> use fb->w/h or add these properties as malidp private.

We don't need to make them malidp private, there is nothing malidp
specific in them. I'll talk with Ben, we should probably drop this patch
entirely and just enable malidp scaling when fb->w/h differ from
crtc->w/h.

Best regards,
Liviu


> 
> Thanks
> James
> 
> 
> >  	wb_connector->pixel_formats_blob_ptr = blob;
> >  
> >  	return 0;
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 8fe22ab..51c4cb2 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -515,6 +515,10 @@ struct drm_connector_state {
> >  	 */
> >  	struct drm_writeback_job *writeback_job;
> >  
> > +	/** @writeback_w: width of plane to write to wb buffer */
> > +	/** @writeback_h: height of plane to write to wb buffer */
> > +	uint32_t writeback_w, writeback_h;
> > +
> >  	/**
> >  	 * @max_requested_bpc: Connector property to limit the maximum bit
> >  	 * depth of the pixels.
> > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> > index 7f60e8e..a0c2133 100644
> > --- a/include/drm/drm_mode_config.h
> > +++ b/include/drm/drm_mode_config.h
> > @@ -622,6 +622,16 @@ struct drm_mode_config {
> >  	 */
> >  	struct drm_property *prop_crtc_h;
> >  	/**
> > +	 * @prop_writeback_w: Writeback connector property for the plane
> > +	 * destination position in the writeback buffer.
> > +	 */
> > +	struct drm_property *prop_writeback_w;
> > +	/**
> > +	 * @prop_writeback_h: Writeback connector property for the plane
> > +	 * destination position in the writeback buffer.
> > +	 */
> > +	struct drm_property *prop_writeback_h;
> > +	/**
> >  	 * @prop_fb_id: Default atomic plane property to specify the
> >  	 * &drm_framebuffer.
> >  	 */
> 
> Pls del this window style line ending 
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
