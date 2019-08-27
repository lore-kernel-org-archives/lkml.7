Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1794C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92432173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfH0Ixd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:53:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0Ixd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:53:33 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E3EF427FB86;
        Tue, 27 Aug 2019 09:53:30 +0100 (BST)
Date:   Tue, 27 Aug 2019 10:53:27 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/8] drm/meson: meson_dw_hdmi: switch to
 drm_bridge_funcs
Message-ID: <20190827105327.3df8ec37@collabora.com>
In-Reply-To: <20190827081425.15011-3-narmstrong@baylibre.com>
References: <20190827081425.15011-1-narmstrong@baylibre.com>
        <20190827081425.15011-3-narmstrong@baylibre.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 10:14:19 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Switch the dw-hdmi driver to drm_bridge_funcs, and implement the
> atomic_get_input_bus_fmts/atomic_get_output_bus_fmts.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 67 +++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index f893ebd0b799..333583ef3ab9 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -368,7 +368,7 @@ static inline void meson_dw_hdmi_phy_reset(struct meson_dw_hdmi *dw_hdmi)
>  }
>  
>  static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
> -			     struct drm_display_mode *mode)
> +			     const struct drm_display_mode *mode)
>  {
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	int vic = drm_match_cea_mode(mode);
> @@ -663,6 +663,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  
>  /* Encoder */
>  
> +static const u32 meson_dw_hdmi_out_bus_fmts[] = {
> +	MEDIA_BUS_FMT_YUV8_1X24,
> +};
> +
>  static void meson_venc_hdmi_encoder_destroy(struct drm_encoder *encoder)
>  {
>  	drm_encoder_cleanup(encoder);
> @@ -672,15 +676,50 @@ static const struct drm_encoder_funcs meson_venc_hdmi_encoder_funcs = {
>  	.destroy        = meson_venc_hdmi_encoder_destroy,
>  };
>  
> -static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
> +static void
> +meson_venc_hdmi_encoder_get_out_bus_fmts(struct drm_bridge *bridge,
> +					 struct drm_bridge_state *bridge_state,
> +					 struct drm_crtc_state *crtc_state,
> +					 struct drm_connector_state *conn_state,
> +					 unsigned int *num_output_fmts,
> +					 u32 *output_fmts)
> +{
> +	*num_output_fmts = ARRAY_SIZE(meson_dw_hdmi_out_bus_fmts);
> +
> +	if (output_fmts)
> +		memcpy(output_fmts, meson_dw_hdmi_out_bus_fmts,
> +		       ARRAY_SIZE(meson_dw_hdmi_out_bus_fmts));
> +}
> +
> +static void
> +meson_venc_hdmi_encoder_get_inp_bus_fmts(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state,
> +					u32 output_fmt,
> +					unsigned int *num_input_fmts,
> +					u32 *input_fmts)
> +{
> +	if (output_fmt == meson_dw_hdmi_out_bus_fmts[0]) {
> +		*num_input_fmts = 1;
> +		if (input_fmts)
> +			input_fmts[0] = output_fmt;
> +	}
> +	else
> +		*num_input_fmts = 0;

nitpick:

	} else {
		*num_input_fmts = 0;
	}

> +}
> +
> +static int meson_venc_hdmi_encoder_atomic_check(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
>  					struct drm_crtc_state *crtc_state,
>  					struct drm_connector_state *conn_state)
>  {
>  	return 0;
>  }

This hook is optional, you don't need this stub.

Looks good otherwise:

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

>  
> -static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
> +static void meson_venc_hdmi_encoder_disable(struct drm_bridge *bridge)
>  {
> +	struct drm_encoder *encoder = bridge_to_encoder(bridge);
>  	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
>  	struct meson_drm *priv = dw_hdmi->priv;
>  
> @@ -693,8 +732,9 @@ static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
>  	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
>  }
>  
> -static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
> +static void meson_venc_hdmi_encoder_enable(struct drm_bridge *bridge)
>  {
> +	struct drm_encoder *encoder = bridge_to_encoder(bridge);
>  	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
>  	struct meson_drm *priv = dw_hdmi->priv;
>  
> @@ -706,10 +746,11 @@ static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
>  		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
>  }
>  
> -static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
> -				   struct drm_display_mode *mode,
> -				   struct drm_display_mode *adjusted_mode)
> +static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
> +				   const struct drm_display_mode *mode,
> +				   const struct drm_display_mode *adjusted_mode)
>  {
> +	struct drm_encoder *encoder = bridge_to_encoder(bridge);
>  	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	int vic = drm_match_cea_mode(mode);
> @@ -726,11 +767,12 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>  	writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
>  }
>  
> -static const struct drm_encoder_helper_funcs
> -				meson_venc_hdmi_encoder_helper_funcs = {
> -	.atomic_check	= meson_venc_hdmi_encoder_atomic_check,
> -	.disable	= meson_venc_hdmi_encoder_disable,
> +static const struct drm_bridge_funcs meson_venc_hdmi_encoder_bridge_funcs = {
>  	.enable		= meson_venc_hdmi_encoder_enable,
> +	.disable	= meson_venc_hdmi_encoder_disable,
> +	.atomic_check	= meson_venc_hdmi_encoder_atomic_check,
> +	.atomic_get_output_bus_fmts = meson_venc_hdmi_encoder_get_out_bus_fmts,
> +	.atomic_get_input_bus_fmts = meson_venc_hdmi_encoder_get_inp_bus_fmts,
>  	.mode_set	= meson_venc_hdmi_encoder_mode_set,
>  };
>  
> @@ -912,8 +954,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>  
>  	/* Encoder */
>  
> -	drm_encoder_helper_add(encoder, &meson_venc_hdmi_encoder_helper_funcs);
> -
> +	encoder->bridge.funcs = &meson_venc_hdmi_encoder_bridge_funcs;
>  	ret = drm_encoder_init(drm, encoder, &meson_venc_hdmi_encoder_funcs,
>  			       DRM_MODE_ENCODER_TMDS, "meson_hdmi");
>  	if (ret) {

