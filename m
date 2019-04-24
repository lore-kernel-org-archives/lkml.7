Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7312148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfDXRJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:09:16 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:32994 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfDXRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:09:15 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AEA20200A7;
        Wed, 24 Apr 2019 19:09:11 +0200 (CEST)
Date:   Wed, 24 Apr 2019 19:09:10 +0200
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
Subject: Re: [PATCH 24/25] drm: kirin: Pass driver data to crtc init and
 plane init
Message-ID: <20190424170910.GC21067@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-25-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556061656-1733-25-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=9WKW5R43fgoMaNO0QP4A:9
        a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Tue, Apr 23, 2019 at 04:20:55PM -0700, John Stultz wrote:
> From: Xu YiPing <xuyiping@hisilicon.com>
> 
> As part of refactoring the kirin driver to better support
> different hardware revisions, this patch changes funcitons
> to pass the kirin_driver_data as a prameter.
> 
> This will allow those funcitons to be later moved to the
> generic kirin_drm_drv.c
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
> [jstultz: Reworded commit message]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 71671f8..876e25b 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -572,7 +572,8 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
>  };
>  
>  static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -			 struct drm_plane *plane)
> +				struct drm_plane *plane,
> +				const struct kirin_drm_data *driver_data)

Indent looks wrong here.

>  {
>  	struct device_node *port;
>  	int ret;
> @@ -589,13 +590,13 @@ static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>  	crtc->port = port;
>  
>  	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> -					ade_driver_data.crtc_funcs, NULL);
> +					driver_data->crtc_funcs, NULL);
>  	if (ret) {
>  		DRM_ERROR("failed to init crtc.\n");
>  		return ret;
>  	}
>  
> -	drm_crtc_helper_add(crtc, ade_driver_data.crtc_helper_funcs);
> +	drm_crtc_helper_add(crtc, driver_data->crtc_helper_funcs);
>  
>  	return 0;
>  }


> @@ -894,21 +895,22 @@ static struct drm_plane_funcs ade_plane_funcs = {
>  
>  static int kirin_drm_plane_init(struct drm_device *dev,
>  				struct kirin_plane *kplane,
> -				enum drm_plane_type type)
> +				enum drm_plane_type type,
> +				const struct kirin_drm_data *driver_data)
>  {
>  	int ret = 0;
>  
>  	ret = drm_universal_plane_init(dev, &kplane->base, 1,
> +				driver_data->plane_funcs,
> +				driver_data->channel_formats,
> +				driver_data->channel_formats_cnt,
> +				NULL, type, NULL);
Indent looks wrong here.

I missed where ade_driver_data came from.
This looks an extra patch to intoduce driver_data,
that maybe should be merged with an earlier version?

	Sam
