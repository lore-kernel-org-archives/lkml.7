Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D49218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfDXQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:50:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:60443 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbfDXQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:50:54 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 19C18200B5;
        Wed, 24 Apr 2019 18:50:51 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:50:49 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH 11/25] drm: kirin: Move kirin_crtc, kirin_plane,
 kirin_format to kirin_drm_drv.h
Message-ID: <20190424165049.GD20110@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-12-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556061656-1733-12-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=6BsCes5lsf5TXTDByRIA:9
        a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Tue, Apr 23, 2019 at 04:20:42PM -0700, John Stultz wrote:
> From: Xu YiPing <xuyiping@hisilicon.com>
> 
> As part of refactoring the kirin driver to better support
> different hardware revisions, this patch moves some shared
> structures and helpers to the common kirin_drm_drv.h
> 
> These structures will later used by both kirin620 and
> future kirin960 driver
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
> [jstultz: reworded commit message]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 27 ++-----------------------
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 24 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index f54cf99..69604ad 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -38,12 +38,6 @@
>  #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
>  #define ADE_DEBUG	1
>  
> -#define to_kirin_crtc(crtc) \
> -	container_of(crtc, struct kirin_crtc, base)
> -
> -#define to_kirin_plane(plane) \
> -	container_of(plane, struct kirin_plane, base)
> -
>  
>  struct ade_hw_ctx {
>  	void __iomem  *base;
> @@ -59,18 +53,6 @@ struct ade_hw_ctx {
>  	struct drm_crtc *crtc;
>  };
>  
> -struct kirin_crtc {
> -	struct drm_crtc base;
> -	void *hw_ctx;
> -	bool enable;
> -};
> -
> -struct kirin_plane {
> -	struct drm_plane base;
> -	void *hw_ctx;
> -	u32 ch;
> -};
> -
>  struct ade_data {
>  	struct kirin_crtc crtc;
>  	struct kirin_plane planes[ADE_CH_NUM];
> @@ -78,12 +60,7 @@ struct ade_data {
>  };


This struct: 
>  /* ade-format info: */
> -struct ade_format {
> -	u32 pixel_format;
> -	enum ade_fb_format ade_format;
> -};
> -
> -static const struct ade_format ade_formats[] = {
> +static const struct kirin_format ade_formats[] = {
>  	/* 16bpp RGB: */
>  	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
>  	{ DRM_FORMAT_BGR565, ADE_BGR_565 },
> @@ -127,7 +104,7 @@ static u32 ade_get_format(u32 pixel_format)
>  
>  	for (i = 0; i < ARRAY_SIZE(ade_formats); i++)
>  		if (ade_formats[i].pixel_format == pixel_format)
> -			return ade_formats[i].ade_format;
> +			return ade_formats[i].hw_format;
>  
>  	/* not found */
>  	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n",
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> index ad027d1..b6626f5 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> @@ -13,6 +13,30 @@
>  
>  #define MAX_CRTC	2
>  
> +#define to_kirin_crtc(crtc) \
> +	container_of(crtc, struct kirin_crtc, base)
> +
> +#define to_kirin_plane(plane) \
> +	container_of(plane, struct kirin_plane, base)
> +
> +/* kirin-format translate table */
> +struct kirin_format {
> +	u32 pixel_format;
> +	u32 hw_format;
> +};
Is renamed.
The member hw_format is renamed and no longer uses an enum.
(The sole user of this enum type).

These changes are not included in the changelog - should they be part of
this patch?
And also the change from enum to u32 is not understood.

	Sam
