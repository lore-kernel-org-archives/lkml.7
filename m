Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ADC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CBE2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfH0JEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:04:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58728 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:04:01 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 76CE228A3A1;
        Tue, 27 Aug 2019 10:03:59 +0100 (BST)
Date:   Tue, 27 Aug 2019 11:03:56 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/8] drm/bridge: synopsys: dw-hdmi: add bus
 format negociation
Message-ID: <20190827110356.3bec488b@collabora.com>
In-Reply-To: <20190827081425.15011-4-narmstrong@baylibre.com>
References: <20190827081425.15011-1-narmstrong@baylibre.com>
        <20190827081425.15011-4-narmstrong@baylibre.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 10:14:20 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negociate

								   ^negotiate

> the possible output and input formats for the current mode and monitor,
> and use the negociated formats in a basic atomic_check callback.

	      ^negotiated

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---


>  
> +static void dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state,
> +					unsigned int *num_output_fmts,
> +					u32 *output_fmts)
> +{
> +	struct drm_connector *conn = conn_state->connector;
> +	struct drm_display_info *info = &conn->display_info;
> +	struct drm_display_mode *mode = &crtc_state->mode;
> +	bool is_hdmi2_sink = info->hdmi.scdc.supported;	
> +	int i = 0;
> +
> +	/*
> +	 * If the current mode enforces 4:2:0, force the output but format
> +	 * to 4:2:0 and do not add the YUV422/444/RGB formats
> +	 */
> +	if (drm_mode_is_420_only(info, mode) ||
> +	    (!is_hdmi2_sink && drm_mode_is_420_also(info, mode))) {
> +
> +		/* Order bus formats from 16bit to 8bit if supported */
> +		if (info->bpc == 16 &&
> +		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48)) {
> +			if (output_fmts)
> +				output_fmts[i] = MEDIA_BUS_FMT_UYYVYY16_0_5X48;
> +			++i;
> +		}

You could probably add the following helper:

static void dw_hdmi_bridge_add_fmt(unsigned int *num_fmts, u32 *fmts,
				   u32 new_fmt)
{
	if (fmts)
		fmts[*num_fmts] = new_fmt;

	(*num_fmts)++;
}

to avoid duplicating the

	if (fmts)
		...

	i++;			

logic.
