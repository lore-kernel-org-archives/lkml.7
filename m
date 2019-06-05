Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D671C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140B320717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfFEJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:22:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFEJWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:22:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AF22A78;
        Wed,  5 Jun 2019 02:22:23 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 273193F690;
        Wed,  5 Jun 2019 02:22:23 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 77FAC682572; Wed,  5 Jun 2019 10:22:21 +0100 (BST)
Date:   Wed, 5 Jun 2019 10:22:21 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v1 1/2] drm/komeda: Add rotation support on Komeda driver
Message-ID: <20190605092221.GS15316@e110455-lin.cambridge.arm.com>
References: <1555902945-2877-1-git-send-email-lowry.li@arm.com>
 <1555902945-2877-2-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555902945-2877-2-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Mon, Apr 22, 2019 at 04:16:26AM +0100, Lowry Li (Arm Technology China) wrote:
> - Adds rotation property to plane.
> - Komeda display rotation support diverges from the specific formats,
> so need to check the user required rotation type with the format caps
> and reject the commit if it can not be supported.
> - In the layer validate flow, sets the rotation value to the layer
> state. If r90 or r270, swap the width and height of the data flow
> for next stage.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h  | 11 +++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_pipeline_state.c   |  7 +++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c        | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> index bc3b2df36..96de22e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -79,6 +79,17 @@ struct komeda_format_caps_table {
>  
>  extern u64 komeda_supported_modifiers[];
>  
> +static inline const char *komeda_get_format_name(u32 fourcc, u64 modifier)
> +{
> +	struct drm_format_name_buf buf;
> +	static char name[64];
> +
> +	snprintf(name, sizeof(name), "%s with modifier: 0x%llx.",
> +		 drm_get_format_name(fourcc, &buf), modifier);
> +
> +	return name;
> +}

Can you roll the content of this function inside the if () {.....} part? We
only have one use for it, I don't see the need to split it into a separate
function.

With that: Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> +
>  const struct komeda_format_caps *
>  komeda_get_format_caps(struct komeda_format_caps_table *table,
>  		       u32 fourcc, u64 modifier);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 9b29e9a..8c133e4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -317,6 +317,13 @@ struct komeda_pipeline_state *
>  	/* update the data flow for the next stage */
>  	komeda_component_set_output(&dflow->input, &layer->base, 0);
>  
> +	/*
> +	 * The rotation has been handled by layer, so adjusted the data flow for
> +	 * the next stage.
> +	 */
> +	if (drm_rotation_90_or_270(st->rot))
> +		swap(dflow->in_h, dflow->in_w);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index 14d6861..5e5bfdb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -9,12 +9,14 @@
>  #include <drm/drm_plane_helper.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> +#include "komeda_framebuffer.h"
>  
>  static int
>  komeda_plane_init_data_flow(struct drm_plane_state *st,
>  			    struct komeda_data_flow_cfg *dflow)
>  {
>  	struct drm_framebuffer *fb = st->fb;
> +	const struct komeda_format_caps *caps = to_kfb(fb)->format_caps;
>  
>  	memset(dflow, 0, sizeof(*dflow));
>  
> @@ -35,6 +37,15 @@
>  	dflow->in_w = st->src_w >> 16;
>  	dflow->in_h = st->src_h >> 16;
>  
> +	dflow->rot = drm_rotation_simplify(st->rotation, caps->supported_rots);
> +	if (!has_bits(dflow->rot, caps->supported_rots)) {
> +		DRM_DEBUG_ATOMIC("rotation(0x%x) isn't supported by %s.\n",
> +				 dflow->rot,
> +				 komeda_get_format_name(caps->fourcc,
> +							fb->modifier));
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -233,6 +244,11 @@ static int komeda_plane_add(struct komeda_kms_dev *kms,
>  
>  	drm_plane_helper_add(plane, &komeda_plane_helper_funcs);
>  
> +	err = drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
> +						 layer->supported_rots);
> +	if (err)
> +		goto cleanup;
> +
>  	err = drm_plane_create_alpha_property(plane);
>  	if (err)
>  		goto cleanup;
> -- 
> 1.9.1
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
