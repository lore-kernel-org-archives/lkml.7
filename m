Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE4C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A09208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfFSKZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:25:23 -0400
Received: from foss.arm.com ([217.140.110.172]:60272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfFSKZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:25:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0012360;
        Wed, 19 Jun 2019 03:25:21 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5B913F738;
        Wed, 19 Jun 2019 03:27:07 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 3719D680120; Wed, 19 Jun 2019 11:25:20 +0100 (BST)
Date:   Wed, 19 Jun 2019 11:25:20 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH] drm/komeda: Correct printk format specifier for "size_t"
Message-ID: <20190619102520.GC17204@e110455-lin.cambridge.arm.com>
References: <20190619074225.13521-1-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619074225.13521-1-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:42:45AM +0100, james qian wang (Arm Technology China) wrote:
> Warnings popup when "make ARCH=i386"
> 
> In file included from include/drm/drm_mm.h:49,
>                  from include/drm/drm_vma_manager.h:26,
>                  from include/drm/drm_gem.h:40,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:9:
> drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c: In function 'komeda_fb_afbc_size_check':
> drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:96:17: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
> 
> That leads by misuse "%lx" as format speicifier for size_t, correct it
> to "%zx"
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../gpu/drm/arm/display/komeda/komeda_framebuffer.c   | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index abc8c0ccc053..3b0a70ed6aa0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -43,8 +43,8 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
>  	struct drm_framebuffer *fb = &kfb->base;
>  	const struct drm_format_info *info = fb->format;
>  	struct drm_gem_object *obj;
> -	u32 alignment_w = 0, alignment_h = 0, alignment_header;
> -	u32 n_blocks = 0, min_size = 0;
> +	u32 alignment_w = 0, alignment_h = 0, alignment_header, n_blocks;
> +	u64 min_size;
>  
>  	obj = drm_gem_object_lookup(file, mode_cmd->handles[0]);
>  	if (!obj) {
> @@ -93,7 +93,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
>  			       AFBC_SUPERBLK_ALIGNMENT);
>  	min_size = kfb->afbc_size + fb->offsets[0];
>  	if (min_size > obj->size) {
> -		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
> +		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%zx. min_size 0x%llx.\n",
>  			      obj->size, min_size);
>  		goto check_failed;
>  	}
> @@ -114,7 +114,8 @@ komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *kfb,
>  	struct drm_framebuffer *fb = &kfb->base;
>  	const struct drm_format_info *info = fb->format;
>  	struct drm_gem_object *obj;
> -	u32 i, min_size, block_h;
> +	u32 i, block_h;
> +	u64 min_size;
>  
>  	if (komeda_fb_check_src_coords(kfb, 0, 0, fb->width, fb->height))
>  		return -EINVAL;
> @@ -137,7 +138,7 @@ komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *kfb,
>  		min_size = komeda_fb_get_pixel_addr(kfb, 0, fb->height, i)
>  			 - to_drm_gem_cma_obj(obj)->paddr;
>  		if (obj->size < min_size) {
> -			DRM_DEBUG_KMS("The fb->obj[%d] size: %ld lower than the minimum requirement: %d.\n",
> +			DRM_DEBUG_KMS("The fb->obj[%d] size: 0x%zx lower than the minimum requirement: 0x%llx.\n",
>  				      i, obj->size, min_size);
>  			return -EINVAL;
>  		}
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
