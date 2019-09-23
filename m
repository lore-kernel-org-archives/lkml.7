Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF28C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4777720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407472AbfIWNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:50:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfIWNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 385461000;
        Mon, 23 Sep 2019 06:50:01 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18CEF3F694;
        Mon, 23 Sep 2019 06:50:01 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CE9F4682855; Mon, 23 Sep 2019 14:49:59 +0100 (BST)
Date:   Mon, 23 Sep 2019 14:49:59 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Ayan Halder <ayan.halder@arm.com>
Subject: Re: [PATCH 10/36] drm/arm: use bpp instead of cpp for drm_format_info
Message-ID: <20190923134959.fm3fukhnzvazvsq5@e110455-lin.cambridge.arm.com>
References: <1569242784-182780-1-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569242784-182780-1-git-send-email-hjc@rock-chips.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:46:23PM +0800, Sandy Huang wrote:
> cpp[BytePerPlane] can't describe the 10bit data format correctly,
> So we use bpp[BitPerPlane] to instead cpp.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

Adding Ayan as well.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 2 +-
>  drivers/gpu/drm/arm/malidp_hw.c                         | 2 +-
>  drivers/gpu/drm/arm/malidp_planes.c                     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index 3b0a70e..d02dfc6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -89,7 +89,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
>  				    alignment_header);
>  
>  	kfb->afbc_size = kfb->offset_payload + n_blocks *
> -			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
> +			 ALIGN(info->bpp[0] / 8 * AFBC_SUPERBLK_PIXELS,
>  			       AFBC_SUPERBLK_ALIGNMENT);
>  	min_size = kfb->afbc_size + fb->offsets[0];
>  	if (min_size > obj->size) {
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index bd8265f..54be8d1 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -384,7 +384,7 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  int malidp_format_get_bpp(u32 fmt)
>  {
>  	const struct drm_format_info *info = drm_format_info(fmt);
> -	int bpp = info->cpp[0] * 8;
> +	int bpp = info->bpp[0];
>  
>  	if (bpp == 0) {
>  		switch (fmt) {
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 3c70a53..628f325 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -225,7 +225,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
>  
>  	if (modifier & AFBC_SPLIT) {
>  		if (!info->is_yuv) {
> -			if (info->cpp[0] <= 2) {
> +			if (info->bpp[0] <= 16) {
>  				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
>  				return false;
>  			}
> -- 
> 2.7.4
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
