Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF03C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668AB207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405872AbfIITvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731163AbfIITvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:51:14 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A4DDC04574F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 19:51:13 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id 72so17643351qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 12:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=cX/+uP2cXNy1rxyLG62p5Ml+Jo0Iv2JmVM5wnVFWQwo=;
        b=OV5z8ntDDQPpK5vjzYfVQRqg0Mtn4YeYwVfCNeMZh2ha4qkIalyD3M/Mo0GOwhf6IL
         QTAbiQ5XemG1XqViAHvuUcYDa5KJpHQRbZpXeigGEKzXWjcpbv11i6TXQaA60UZMUOLP
         kTpOBpkcPno0EJX9aHZ1g8VG5tfibAFz2oXPRIUBE630oFlG8hJ1yY+40aK3Qx7EQSk+
         UEmuXAZzWUB3DQ9dOXjLmCdK2gUTnzuwKqb7I36xWv5RmTUHof/YIP/7ZBVj7DozXHR3
         ZcMwoP1EN5niSadjmgAlwlc+ciazMYRIbrpywa5/jWme8O9hjHOVHKlctuKQhtGLvpBS
         JKqg==
X-Gm-Message-State: APjAAAVMKqaVGhJUWWltcskR0/82RQXL0jhYHJwpOi6dvqp9dpg06d89
        wPLuUphs4UshLdsZyZUhEX1EbPdc8c/AUqKHyenYTjuRJ87w6mUrutDMGrJ5RnTDv/ti2r7HG9E
        arYANuNclLXFAuLy7mXHs00qS
X-Received: by 2002:ac8:4556:: with SMTP id z22mr24894800qtn.134.1568058672360;
        Mon, 09 Sep 2019 12:51:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaYnXwjL5NSAmz2KcT+HiqPN+1dgYEDfYYYqIG9Oq37ivjAsVdBiCJjPEkwoO18h7ZTcEoGA==
X-Received: by 2002:ac8:4556:: with SMTP id z22mr24894780qtn.134.1568058672080;
        Mon, 09 Sep 2019 12:51:12 -0700 (PDT)
Received: from dhcp-10-20-1-34.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id e7sm8511412qtb.94.2019.09.09.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 12:51:11 -0700 (PDT)
Message-ID: <a81059f8e09b317b479f17aa0a578107d19726b7.camel@redhat.com>
Subject: Re: [PATCH v2] drm: Bump encoder limit from 32 to 64
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Date:   Mon, 09 Sep 2019 15:51:09 -0400
In-Reply-To: <20190821115355.GH5942@intel.com>
References: <20190821001656.32577-1-lyude@redhat.com>
         <20190821115355.GH5942@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got a chance to look at this again, some notes below

On Wed, 2019-08-21 at 14:53 +0300, Ville Syrjälä wrote:
> On Tue, Aug 20, 2019 at 08:16:55PM -0400, Lyude Paul wrote:
> > Assuming that GPUs would never have even close to 32 separate video
> > encoders is quite honestly a pretty reasonable assumption. Unfortunately
> > we do not live in a reasonable world, as it looks like it is actually
> > possible to find devices that will create more drm_encoder objects then
> > this. Case in point: the ThinkPad P71's discrete GPU, which exposes 1
> > eDP port and 5 DP ports. On the P71, nouveau attempts to create one
> > encoder for the eDP port, and two encoders for each DP++/USB-C port
> > along with 4 MST encoders for each DP port. This comes out to 35
> > different encoders. Unfortunately, this can't really be optimized to
> > make less encoders either.
> > 
> > So, what if we bumped the limit to 64? Unfortunately this has one very
> > awkward drawback: we already expose 32-bit bitmasks for encoders to
> > userspace in drm_encoder->possible_clones. Yikes. While cloning is still
> > (rarely) used in certain modern video hardware, it's mostly used in
> > situations where memory bandwidth is so limited that it's not possible
> > to scan out from 2 CRTCs at once.
> > 
> > So, let's try to compromise here: allow encoders with indexes <32 to
> > have non-zero values in drm_encoder->possible_clones, and don't allow
> > encoders with higher indexes to set drm_encoder->possible_clones to a
> > non-zero value. This allows us to avoid breaking UAPI and keep things
> > working sanely for hardware which still uses cloning, while still being
> > able to bump up the encoder limit.
> > 
> > This also fixes driver probing for nouveau on the ThinkPad P71.
> > 
> > Changes since v1:
> > * Move index+possible_clones check out of drm_encoder_init() and into
> >   drm_encoder_register_all(), since encoder->possible_clones can get
> >   changed any time before registration - Daniel Vetter
> > * Update the commit message a bit to accurately reflect modern day usage
> >   of hardware cloning, which as Daniel Stone pointed out is apparently a
> >   thing
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: nouveau@lists.freedesktop.org
> > ---
> >  drivers/gpu/drm/drm_atomic.c  |  2 +-
> >  drivers/gpu/drm/drm_encoder.c | 12 ++++++++++--
> >  include/drm/drm_crtc.h        |  2 +-
> >  include/drm/drm_encoder.h     | 20 +++++++++++++++-----
> >  4 files changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index 419381abbdd1..27ce988ef0cc 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -392,7 +392,7 @@ static void drm_atomic_crtc_print_state(struct
> > drm_printer *p,
> >  	drm_printf(p, "\tcolor_mgmt_changed=%d\n", state->color_mgmt_changed);
> >  	drm_printf(p, "\tplane_mask=%x\n", state->plane_mask);
> >  	drm_printf(p, "\tconnector_mask=%x\n", state->connector_mask);
> > -	drm_printf(p, "\tencoder_mask=%x\n", state->encoder_mask);
> > +	drm_printf(p, "\tencoder_mask=%llx\n", state->encoder_mask);
> >  	drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state-
> > >mode));
> >  
> >  	if (crtc->funcs->atomic_print_state)
> > diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> > index 7fb47b7b8b44..9d443b45ebba 100644
> > --- a/drivers/gpu/drm/drm_encoder.c
> > +++ b/drivers/gpu/drm/drm_encoder.c
> > @@ -71,6 +71,14 @@ int drm_encoder_register_all(struct drm_device *dev)
> >  	int ret = 0;
> >  
> >  	drm_for_each_encoder(encoder, dev) {
> > +		/*
> > +		 * Since possible_clones has been exposed to userspace as a
> > +		 * 32bit bitmask, we don't allow creating encoders with an
> > +		 * index >=32 which are capable of cloning
> > +		 */
> > +		if (WARN_ON(encoder->index >= 32 && encoder->possible_clones))
> > +			return -EINVAL;
> 
> I believe possible_clones was supposed to include the encoder itself. Not
> really sure why though. I guess we've now decided that it's OK not to do 
> that?
> 
> git grep tells me drm_atomic_helper.c has some uses of drm_encoder_mask()
> that need to be looked at.

ughhhhhhhhhh
you're completely right :(, it seems that there are some legacy drivers that
do this. An excerpt from sti_tvout.c:

static void sti_tvout_create_encoders(struct drm_device *dev,
		struct sti_tvout *tvout)
{
	tvout->hdmi = sti_tvout_create_hdmi_encoder(dev, tvout);
	tvout->hda = sti_tvout_create_hda_encoder(dev, tvout);
	tvout->dvo = sti_tvout_create_dvo_encoder(dev, tvout);

	tvout->hdmi->possible_clones = drm_encoder_mask(tvout->hdmi) |
		drm_encoder_mask(tvout->hda) | drm_encoder_mask(tvout->dvo);
	tvout->hda->possible_clones = drm_encoder_mask(tvout->hdmi) |
		drm_encoder_mask(tvout->hda) | drm_encoder_mask(tvout->dvo);
	tvout->dvo->possible_clones = drm_encoder_mask(tvout->hdmi) |
		drm_encoder_mask(tvout->hda) | drm_encoder_mask(tvout->dvo);
}

So yeah, I'm not really sure what we can do about this then, other then maybe
try and make nouveau use less encoders again (which I might have a better idea
on how to do now...). Either that, or danvet's idea with fake encoders
(although I'd really like to avoid something this complicated, but it might
not be able to be helped)

> 
> > +
> >  		if (encoder->funcs->late_register)
> >  			ret = encoder->funcs->late_register(encoder);
> >  		if (ret)
> > @@ -112,8 +120,8 @@ int drm_encoder_init(struct drm_device *dev,
> >  {
> >  	int ret;
> >  
> > -	/* encoder index is used with 32bit bitmasks */
> > -	if (WARN_ON(dev->mode_config.num_encoder >= 32))
> > +	/* encoder index is used with 64bit bitmasks */
> > +	if (WARN_ON(dev->mode_config.num_encoder >= 64))
> >  		return -EINVAL;
> >  
> >  	ret = drm_mode_object_add(dev, &encoder->base,
> > DRM_MODE_OBJECT_ENCODER);
> > diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> > index 7d14c11bdc0a..fd0b2438c3d5 100644
> > --- a/include/drm/drm_crtc.h
> > +++ b/include/drm/drm_crtc.h
> > @@ -210,7 +210,7 @@ struct drm_crtc_state {
> >  	 * @encoder_mask: Bitmask of drm_encoder_mask(encoder) of encoders
> >  	 * attached to this CRTC.
> >  	 */
> > -	u32 encoder_mask;
> > +	u64 encoder_mask;
> >  
> >  	/**
> >  	 * @adjusted_mode:
> > diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> > index 70cfca03d812..3f9cb65694e1 100644
> > --- a/include/drm/drm_encoder.h
> > +++ b/include/drm/drm_encoder.h
> > @@ -159,7 +159,15 @@ struct drm_encoder {
> >  	 * encoders can be used in a cloned configuration, they both should
> > have
> >  	 * each another bits set.
> >  	 *
> > -	 * In reality almost every driver gets this wrong.
> > +	 * In reality almost every driver gets this wrong, and most modern
> > +	 * display hardware does not have support for cloning. As well, while
> > we
> > +	 * expose this mask to userspace as 32bits long, we do sure purely to
> > +	 * avoid breaking pre-existing UAPI since the limitation on the number
> > +	 * of encoders has been increased from 32 bits to 64 bits. In order to
> > +	 * maintain functionality for drivers which do actually support
> > cloning,
> > +	 * we only allow cloning with encoders that have an index <32.
> > Encoders
> > +	 * with indexes higher than 32 are not allowed to specify a non-zero
> > +	 * value here.
> >  	 *
> >  	 * Note that since encoder objects can't be hotplugged the assigned
> > indices
> >  	 * are stable and hence known before registering all objects.
> > @@ -198,13 +206,15 @@ static inline unsigned int drm_encoder_index(const
> > struct drm_encoder *encoder)
> >  }
> >  
> >  /**
> > - * drm_encoder_mask - find the mask of a registered ENCODER
> > + * drm_encoder_mask - find the mask of a registered encoder
> >   * @encoder: encoder to find mask for
> >   *
> > - * Given a registered encoder, return the mask bit of that encoder for an
> > - * encoder's possible_clones field.
> > + * Returns:
> > + * A bit mask with the nth bit set, where n is the index of the encoder.
> > Take
> > + * care when using this, as the DRM UAPI only allows for 32 bit encoder
> > masks
> > + * while internally encoder masks are 64 bits.
> >   */
> > -static inline u32 drm_encoder_mask(const struct drm_encoder *encoder)
> > +static inline u64 drm_encoder_mask(const struct drm_encoder *encoder)
> >  {
> >  	return 1 << drm_encoder_index(encoder);
> >  }
> > -- 
> > 2.21.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Cheers,
	Lyude Paul

