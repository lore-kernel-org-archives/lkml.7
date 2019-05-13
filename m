Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83053C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566022084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="HkidcekK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfEMOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:41:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34575 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfEMOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:41:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id h1so7188148qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AShDMcr6wP0O8DE+n5XbgpPJ5YloQ1/JdOPbCC8lARw=;
        b=HkidcekKkBXgGOaNW72+pYp8w3VZS3ih8WWwPsmB/Ibu7CJs0yJAhBlEFyDteU5jD/
         Ggoo0PZceRDrjWt0tLEYlbjYfSwyLT/alA67azusGTnakoNEqljeQPvLgsR43eR/k0dJ
         hwQmGG4VdAGyHf6aGGvjhRmlPABjRvfA6qAmlY9QItuPNCGFEr0UGOx/SSuGMYaybjsX
         e0RiJqx4nfZ+qUZeMz3KOL5ByyauTWA7X+lGpDwcVJ9iLMZEUAkVpM/syZlwxcrDStH7
         3skFGnmq4XK5+6Jen+ktCVShwScLwsTp4uTSYT2sHTgh977o1y9tYN49jpYxV07QkqTx
         VMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AShDMcr6wP0O8DE+n5XbgpPJ5YloQ1/JdOPbCC8lARw=;
        b=oofcbfTUxhJxguepQx2YPFiPcyPwKL6FUY+/GL5pdlTIeZ5U+yYQoCJVuatCDp3dax
         l9A/tWq3lEfvZhO9dUjvYhYlzArnKmOr4PSNn/R3cP+cHr0sOzdHnr7o0fcMzUQXePcp
         X6MD3NkHZaDzpuAb9TXfgLwExIcXeR6rA88ijlv1xryBBZgt0OkgFFJFwsyN3VH8bbzB
         p0glWf8qxjR0MqeZBjac/Ogl8DnTD2mZpP6Z/HFJy4tD99GV+FV+wm16pSUrr5p/JGV7
         h0V7FBpMYkQ+TgVIWobyphjOVduTcgmcKYYkiib4+/46SOcG4M/rRfIuaPnBbA+bURWp
         /y4w==
X-Gm-Message-State: APjAAAXRtYsY+cUXS5TAgfdBTYJwmM6WTMQOvPQzPnzZ/yLw7RT3Yfln
        l4GMlATgr5tdGtmZqIiEGJLchw==
X-Google-Smtp-Source: APXvYqykNJUXhSJgZA6vtUnxVCZWGlTPm+rCJaK1kqlt7UHvDAJRFjnm1qlB5I6AjuDJ8LtM1pVexg==
X-Received: by 2002:ac8:3783:: with SMTP id d3mr21972886qtc.293.1557758481560;
        Mon, 13 May 2019 07:41:21 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id o13sm6206257qtk.74.2019.05.13.07.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 07:41:20 -0700 (PDT)
Date:   Mon, 13 May 2019 10:41:20 -0400
From:   Sean Paul <sean@poorly.run>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] drm/rockchip: Change the scl_vop_cal_scl_fac to
 pass drm_format_info
Message-ID: <20190513144120.GM17077@art_vandelay>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 01:08:46PM +0200, Maxime Ripard wrote:
> The Rockchip VOP driver has a function, scl_vop_cal_scl_fac, that will
> lookup the drm_format_info structure from the fourcc passed to it by its
> caller.
> 
> However, its only caller already derefences the drm_format_info structure
> it has access to to retrieve that fourcc. Change the prototype of that
> function to pass the drm_format_info structure directly, removing the need
> for an extra lookup.
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 20a9c296d027..9c0d6b367709 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -315,14 +315,13 @@ static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
>  
>  static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
>  			     uint32_t src_w, uint32_t src_h, uint32_t dst_w,
> -			     uint32_t dst_h, uint32_t pixel_format)
> +			     uint32_t dst_h, const struct drm_format_info *info)
>  {
>  	uint16_t yrgb_hor_scl_mode, yrgb_ver_scl_mode;
>  	uint16_t cbcr_hor_scl_mode = SCALE_NONE;
>  	uint16_t cbcr_ver_scl_mode = SCALE_NONE;
> -	int hsub = drm_format_horz_chroma_subsampling(pixel_format);
> -	int vsub = drm_format_vert_chroma_subsampling(pixel_format);
> -	const struct drm_format_info *info;
> +	int hsub = drm_format_horz_chroma_subsampling(info->format);
> +	int vsub = drm_format_vert_chroma_subsampling(info->format);
>  	bool is_yuv = false;
>  	uint16_t cbcr_src_w = src_w / hsub;
>  	uint16_t cbcr_src_h = src_h / vsub;
> @@ -331,8 +330,6 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
>  	uint32_t val;
>  	int vskiplines;
>  
> -	info = drm_format_info(pixel_format);
> -
>  	if (info->is_yuv)
>  		is_yuv = true;
>  
> @@ -856,7 +853,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>  	if (win->phy->scl)
>  		scl_vop_cal_scl_fac(vop, win, actual_w, actual_h,
>  				    drm_rect_width(dest), drm_rect_height(dest),
> -				    fb->format->format);
> +				    fb->format);
>  
>  	VOP_WIN_SET(vop, win, act_info, act_info);
>  	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
> 
> base-commit: a802303934b3bd4df6e2fc8bf2e4ebced1c37556
> -- 
> git-series 0.9.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
