Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A4AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9122CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfHULx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:53:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:26485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfHULx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:53:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 04:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186211278"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 21 Aug 2019 04:53:55 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 21 Aug 2019 14:53:55 +0300
Date:   Wed, 21 Aug 2019 14:53:55 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2] drm: Bump encoder limit from 32 to 64
Message-ID: <20190821115355.GH5942@intel.com>
References: <20190821001656.32577-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821001656.32577-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:16:55PM -0400, Lyude Paul wrote:
> Assuming that GPUs would never have even close to 32 separate video
> encoders is quite honestly a pretty reasonable assumption. Unfortunately
> we do not live in a reasonable world, as it looks like it is actually
> possible to find devices that will create more drm_encoder objects then
> this. Case in point: the ThinkPad P71's discrete GPU, which exposes 1
> eDP port and 5 DP ports. On the P71, nouveau attempts to create one
> encoder for the eDP port, and two encoders for each DP++/USB-C port
> along with 4 MST encoders for each DP port. This comes out to 35
> different encoders. Unfortunately, this can't really be optimized to
> make less encoders either.
> 
> So, what if we bumped the limit to 64? Unfortunately this has one very
> awkward drawback: we already expose 32-bit bitmasks for encoders to
> userspace in drm_encoder->possible_clones. Yikes. While cloning is still
> (rarely) used in certain modern video hardware, it's mostly used in
> situations where memory bandwidth is so limited that it's not possible
> to scan out from 2 CRTCs at once.
> 
> So, let's try to compromise here: allow encoders with indexes <32 to
> have non-zero values in drm_encoder->possible_clones, and don't allow
> encoders with higher indexes to set drm_encoder->possible_clones to a
> non-zero value. This allows us to avoid breaking UAPI and keep things
> working sanely for hardware which still uses cloning, while still being
> able to bump up the encoder limit.
> 
> This also fixes driver probing for nouveau on the ThinkPad P71.
> 
> Changes since v1:
> * Move index+possible_clones check out of drm_encoder_init() and into
>   drm_encoder_register_all(), since encoder->possible_clones can get
>   changed any time before registration - Daniel Vetter
> * Update the commit message a bit to accurately reflect modern day usage
>   of hardware cloning, which as Daniel Stone pointed out is apparently a
>   thing
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_atomic.c  |  2 +-
>  drivers/gpu/drm/drm_encoder.c | 12 ++++++++++--
>  include/drm/drm_crtc.h        |  2 +-
>  include/drm/drm_encoder.h     | 20 +++++++++++++++-----
>  4 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 419381abbdd1..27ce988ef0cc 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -392,7 +392,7 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
>  	drm_printf(p, "\tcolor_mgmt_changed=%d\n", state->color_mgmt_changed);
>  	drm_printf(p, "\tplane_mask=%x\n", state->plane_mask);
>  	drm_printf(p, "\tconnector_mask=%x\n", state->connector_mask);
> -	drm_printf(p, "\tencoder_mask=%x\n", state->encoder_mask);
> +	drm_printf(p, "\tencoder_mask=%llx\n", state->encoder_mask);
>  	drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
>  
>  	if (crtc->funcs->atomic_print_state)
> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> index 7fb47b7b8b44..9d443b45ebba 100644
> --- a/drivers/gpu/drm/drm_encoder.c
> +++ b/drivers/gpu/drm/drm_encoder.c
> @@ -71,6 +71,14 @@ int drm_encoder_register_all(struct drm_device *dev)
>  	int ret = 0;
>  
>  	drm_for_each_encoder(encoder, dev) {
> +		/*
> +		 * Since possible_clones has been exposed to userspace as a
> +		 * 32bit bitmask, we don't allow creating encoders with an
> +		 * index >=32 which are capable of cloning
> +		 */
> +		if (WARN_ON(encoder->index >= 32 && encoder->possible_clones))
> +			return -EINVAL;

I believe possible_clones was supposed to include the encoder itself. Not
really sure why though. I guess we've now decided that it's OK not to do 
that?

git grep tells me drm_atomic_helper.c has some uses of drm_encoder_mask()
that need to be looked at.

> +
>  		if (encoder->funcs->late_register)
>  			ret = encoder->funcs->late_register(encoder);
>  		if (ret)
> @@ -112,8 +120,8 @@ int drm_encoder_init(struct drm_device *dev,
>  {
>  	int ret;
>  
> -	/* encoder index is used with 32bit bitmasks */
> -	if (WARN_ON(dev->mode_config.num_encoder >= 32))
> +	/* encoder index is used with 64bit bitmasks */
> +	if (WARN_ON(dev->mode_config.num_encoder >= 64))
>  		return -EINVAL;
>  
>  	ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 7d14c11bdc0a..fd0b2438c3d5 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -210,7 +210,7 @@ struct drm_crtc_state {
>  	 * @encoder_mask: Bitmask of drm_encoder_mask(encoder) of encoders
>  	 * attached to this CRTC.
>  	 */
> -	u32 encoder_mask;
> +	u64 encoder_mask;
>  
>  	/**
>  	 * @adjusted_mode:
> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> index 70cfca03d812..3f9cb65694e1 100644
> --- a/include/drm/drm_encoder.h
> +++ b/include/drm/drm_encoder.h
> @@ -159,7 +159,15 @@ struct drm_encoder {
>  	 * encoders can be used in a cloned configuration, they both should have
>  	 * each another bits set.
>  	 *
> -	 * In reality almost every driver gets this wrong.
> +	 * In reality almost every driver gets this wrong, and most modern
> +	 * display hardware does not have support for cloning. As well, while we
> +	 * expose this mask to userspace as 32bits long, we do sure purely to
> +	 * avoid breaking pre-existing UAPI since the limitation on the number
> +	 * of encoders has been increased from 32 bits to 64 bits. In order to
> +	 * maintain functionality for drivers which do actually support cloning,
> +	 * we only allow cloning with encoders that have an index <32. Encoders
> +	 * with indexes higher than 32 are not allowed to specify a non-zero
> +	 * value here.
>  	 *
>  	 * Note that since encoder objects can't be hotplugged the assigned indices
>  	 * are stable and hence known before registering all objects.
> @@ -198,13 +206,15 @@ static inline unsigned int drm_encoder_index(const struct drm_encoder *encoder)
>  }
>  
>  /**
> - * drm_encoder_mask - find the mask of a registered ENCODER
> + * drm_encoder_mask - find the mask of a registered encoder
>   * @encoder: encoder to find mask for
>   *
> - * Given a registered encoder, return the mask bit of that encoder for an
> - * encoder's possible_clones field.
> + * Returns:
> + * A bit mask with the nth bit set, where n is the index of the encoder. Take
> + * care when using this, as the DRM UAPI only allows for 32 bit encoder masks
> + * while internally encoder masks are 64 bits.
>   */
> -static inline u32 drm_encoder_mask(const struct drm_encoder *encoder)
> +static inline u64 drm_encoder_mask(const struct drm_encoder *encoder)
>  {
>  	return 1 << drm_encoder_index(encoder);
>  }
> -- 
> 2.21.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
