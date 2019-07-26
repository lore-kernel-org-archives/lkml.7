Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BCDC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEDD218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGZNI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:08:26 -0400
Received: from foss.arm.com ([217.140.110.172]:43220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGZNIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:08:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FEBC337;
        Fri, 26 Jul 2019 06:08:24 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AD5C3F694;
        Fri, 26 Jul 2019 06:08:24 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CDEA7682072; Fri, 26 Jul 2019 14:08:22 +0100 (BST)
Date:   Fri, 26 Jul 2019 14:08:22 +0100
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
Subject: Re: [PATCH] drm/komeda: Adds internal bpp computing for arm afbc
 only format YU08 YU10
Message-ID: <20190726130822.GO15612@e110455-lin.cambridge.arm.com>
References: <1564127450-22601-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564127450-22601-1-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Fri, Jul 26, 2019 at 07:51:02AM +0000, Lowry Li (Arm Technology China) wrote:
> The drm_format_info doesn't have any cpp or block_size (both are zero)
> information for arm only afbc format YU08/YU10. we need to compute it
> by ourselves.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../drm/arm/display/komeda/komeda_format_caps.c    | 23 ++++++++++++++++++++++
>  .../drm/arm/display/komeda/komeda_format_caps.h    |  3 +++
>  .../drm/arm/display/komeda/komeda_framebuffer.c    |  6 ++++--
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> index cd4d9f5..3c9e060 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> @@ -35,6 +35,29 @@
>  	return NULL;
>  }
>  
> +u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info, u64 modifier)
> +{
> +	u32 bpp;
> +
> +	WARN_ON(modifier == DRM_FORMAT_MOD_LINEAR);

Is it not better to return the value from info->char_per_block if modifier is
DRM_FORMAT_MOD_LINEAR? Or return 0?

> +
> +	switch (info->format) {
> +	case DRM_FORMAT_YUV420_8BIT:
> +		bpp = 12;
> +		break;
> +	case DRM_FORMAT_YUV420_10BIT:
> +		bpp = 15;
> +		break;
> +	default:
> +		bpp = info->cpp[0] * 8;
> +		break;
> +	}
> +
> +	WARN_ON(bpp == 0);
> +
> +	return bpp;
> +}
> +
>  /* Two assumptions
>   * 1. RGB always has YTR
>   * 2. Tiled RGB always has SC
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> index 3631910..32273cf 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -97,6 +97,9 @@ static inline const char *komeda_get_format_name(u32 fourcc, u64 modifier)
>  komeda_get_format_caps(struct komeda_format_caps_table *table,
>  		       u32 fourcc, u64 modifier);
>  
> +u32 komeda_get_afbc_format_bpp(const struct drm_format_info *info,
> +			       u64 modifier);
> +
>  u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
>  				  u32 layer_type, u32 *n_fmts);
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index 10bf63e..966d0c7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -44,7 +44,7 @@ static int komeda_fb_create_handle(struct drm_framebuffer *fb,
>  	const struct drm_format_info *info = fb->format;
>  	struct drm_gem_object *obj;
>  	u32 alignment_w = 0, alignment_h = 0, alignment_header;
> -	u32 n_blocks = 0, min_size = 0;
> +	u32 n_blocks = 0, min_size = 0, bpp;
>  
>  	obj = drm_gem_object_lookup(file, mode_cmd->handles[0]);
>  	if (!obj) {
> @@ -86,10 +86,12 @@ static int komeda_fb_create_handle(struct drm_framebuffer *fb,
>  	kfb->offset_payload = ALIGN(n_blocks * AFBC_HEADER_SIZE,
>  				    alignment_header);
>  
> +	bpp = komeda_get_afbc_format_bpp(info, fb->modifier);
>  	kfb->afbc_size = kfb->offset_payload + n_blocks *
> -			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
> +			 ALIGN(bpp * AFBC_SUPERBLK_PIXELS / 8,
>  			       AFBC_SUPERBLK_ALIGNMENT);
>  	min_size = kfb->afbc_size + fb->offsets[0];
> +
>  	if (min_size > obj->size) {
>  		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
>  			      obj->size, min_size);

Patch doesn't apply to tip of drm-misc-next. What is this patch depending on?

Best regards,
Liviu

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
