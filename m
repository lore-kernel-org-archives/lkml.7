Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C189C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770732082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbfIYKZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:25:42 -0400
Received: from foss.arm.com ([217.140.110.172]:46072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfIYKZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:25:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A572D1570;
        Wed, 25 Sep 2019 03:25:41 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62B5E3F694;
        Wed, 25 Sep 2019 03:25:41 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 2BF45682851; Wed, 25 Sep 2019 11:25:40 +0100 (BST)
Date:   Wed, 25 Sep 2019 11:25:40 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 2/2] drm/komeda: Adds layer horizontal input size
 limitation check for D71
Message-ID: <20190925102540.oepvakvcshyrhc3u@e110455-lin.cambridge.arm.com>
References: <20190924080022.19250-1-lowry.li@arm.com>
 <20190924080022.19250-3-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190924080022.19250-3-lowry.li@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:00:49AM +0000, Lowry Li (Arm Technology China) wrote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> 
> Adds maximum line size check according to the AFBC decoder limitation
> and special Line size limitation(2046) for format: YUV420_10BIT and X0L2.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../arm/display/komeda/d71/d71_component.c    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 357837b9d6ed..6740b8422f11 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -349,7 +349,56 @@ static void d71_layer_dump(struct komeda_component *c, struct seq_file *sf)
>  	seq_printf(sf, "%sAD_V_CROP:\t\t0x%X\n", prefix, v[2]);
>  }
>  
> +static int d71_layer_validate(struct komeda_component *c,
> +			      struct komeda_component_state *state)
> +{
> +	struct komeda_layer_state *st = to_layer_st(state);
> +	struct komeda_layer *layer = to_layer(c);
> +	struct drm_plane_state *plane_st;
> +	struct drm_framebuffer *fb;
> +	u32 fourcc, line_sz, max_line_sz;
> +
> +	plane_st = drm_atomic_get_new_plane_state(state->obj.state,
> +						  state->plane);
> +	fb = plane_st->fb;
> +	fourcc = fb->format->format;
> +
> +	if (drm_rotation_90_or_270(st->rot))
> +		line_sz = st->vsize - st->afbc_crop_t - st->afbc_crop_b;
> +	else
> +		line_sz = st->hsize - st->afbc_crop_l - st->afbc_crop_r;
> +
> +	if (fb->modifier) {
> +		if ((fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) ==
> +			AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
> +			max_line_sz = layer->line_sz;
> +		else
> +			max_line_sz = layer->line_sz / 2;
> +
> +		if (line_sz > max_line_sz) {
> +			DRM_DEBUG_ATOMIC("afbc request line_sz: %d exceed the max afbc line_sz: %d.\n",
> +					 line_sz, max_line_sz);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (fourcc == DRM_FORMAT_YUV420_10BIT && line_sz > 2046 && (st->afbc_crop_l % 4)) {
> +		DRM_DEBUG_ATOMIC("YUV420_10BIT input_hsize: %d exceed the max size 2046.\n",
> +				 line_sz);
> +		return -EINVAL;
> +	}
> +
> +	if (fourcc == DRM_FORMAT_X0L2 && line_sz > 2046 && (st->addr[0] % 16)) {
> +		DRM_DEBUG_ATOMIC("X0L2 input_hsize: %d exceed the max size 2046.\n",
> +				 line_sz);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct komeda_component_funcs d71_layer_funcs = {
> +	.validate	= d71_layer_validate,
>  	.update		= d71_layer_update,
>  	.disable	= d71_layer_disable,
>  	.dump_register	= d71_layer_dump,
> -- 
> 2.17.1
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
