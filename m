Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B067C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506AF20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="J0sdHWzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfENSMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:12:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33812 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:12:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id j20so123824qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sZPPr8NGhHoJdmUxN5wiV/8svlug9VYTHhuXEbiDTIs=;
        b=J0sdHWzHgNXc/T6S5pXJau+wiI3sT1CAKCHzpcU9ZfRdac6fquW/qSi/EdFnTd8/hv
         I8v4S+RoINJT2chsyyNhKb/+oR1z+ZiqLKlVP4POFtN19qaB9e2bIYBKrht/mnOqIssB
         PBzGjFwsMbr892LK0Kt8UtTMx2c6hCWUBfvsKwvqFMlr/4KfhetV2wbzHv/7Dcnps+Ia
         PZDiauM/MENz/lQ9d9OKQKlUUl1QBhScvjb8RQ/vUTp3GDzptRDdcpTLScpOPqCxes8Y
         HRkD2PJv0Uf8MNG5uqNIDUGm71WPo0g09yWu+RKoQI4Uci7SPfOGMVH0Zfh3pgdAIlOm
         gedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sZPPr8NGhHoJdmUxN5wiV/8svlug9VYTHhuXEbiDTIs=;
        b=DufaFqFo5kbb0NLl/2q2TaEk7aqMCFZzSOT1Tat5UD2h6Jv5kUoyoOt5Vz4IFy7JAq
         Q6MHMZs64zLAHeVxBw8pYA5iROFFglB5VkYV1rvWMvQqbZSLGZwvY8praGS8DbTMT9l3
         ZxNOLTTSzVBiTafPLNr0elijXpm0y6M4ix72co/UgMP16pkFL+FpDvlm07xC2HtJSr4V
         IXlzbdX+gezy8ChjzD77RnW4r+g/Rz3bEme0gbJZydVCUzzd50Bd3rmo+tHkVjUfLVOc
         vAmRZE2Pq1KOsxWbMu1vnTekQfLXwTvMk1NZzU94mlv0B1KsirG5+lQH7n2Ed59juYRH
         hANA==
X-Gm-Message-State: APjAAAVs+ocFeL0e4WIigtNDnb4bw7rlcCJuxNZ+tHKIw71t4uMfWxcB
        furlhkqK4p8lufN3EizhbwSLXjix1uc=
X-Google-Smtp-Source: APXvYqyuHJzqUT7Z2Pj09whePMH3EbHddhBKbeNS8tp2bKdSLjym61SPS67apixuM3EHOeXj9XBYtw==
X-Received: by 2002:a37:5005:: with SMTP id e5mr28417713qkb.99.1557857550434;
        Tue, 14 May 2019 11:12:30 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id e8sm8209768qtm.34.2019.05.14.11.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:12:29 -0700 (PDT)
Date:   Tue, 14 May 2019 14:12:29 -0400
From:   Sean Paul <sean@poorly.run>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run, bjorn.andersson@linaro.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        jonathan@marek.ca, robh@kernel.org
Subject: Re: [PATCH v2.1 1/2] drm/msm: remove resv fields from msm_gem_object
 struct
Message-ID: <20190514181229.GR17077@art_vandelay>
References: <20190513234105.7531-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513234105.7531-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 07:41:04PM -0400, Brian Masney wrote:
> The msm_gem_object structure contains resv and _resv fields that are
> no longer needed since the reservation object is now stored on
> drm_gem_object. msm_atomic_prepare_fb() and msm_atomic_prepare_fb()
> both referenced the wrong reservation object, and would lead to an
> attempt to dereference a NULL pointer. Correct those two cases to
> point to the correct reservation object.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Thanks Brian for your patches. I've applied them to drm-misc-next-fixes for
inclusion in 5.2

Sean

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: dd55cf6929e6 ("drm: msm: Switch to use drm_gem_object reservation_object")
> ---
> This is a split out version of this patch from where I am working to get
> the display working on the Nexus 5:
> 
> https://lore.kernel.org/lkml/20190509020352.14282-2-masneyb@onstation.org/
> 
> Bjorn asks:
>     This resolves a NULL-pointer dereference about to show up in v5.2-rc1,
>     so please pick this up for -rc.
> 
> In this version, I dropped the change to msm_gem_new_impl() that
> mistakenly removed 'msm_obj->base.resv = resv;'. I did not put a v3 on
> this patch since I wanted to keep that version number for the larger work
> to get the display working on the Nexus 5 so I went with 2.1 here. :)
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 +---
>  drivers/gpu/drm/msm/msm_atomic.c          | 4 +---
>  drivers/gpu/drm/msm/msm_gem.h             | 4 ----
>  3 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 4fca24b8702c..f3d009a3dc63 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -781,7 +781,6 @@ static int dpu_plane_prepare_fb(struct drm_plane *plane,
>  	struct dpu_plane_state *pstate = to_dpu_plane_state(new_state);
>  	struct dpu_hw_fmt_layout layout;
>  	struct drm_gem_object *obj;
> -	struct msm_gem_object *msm_obj;
>  	struct dma_fence *fence;
>  	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
>  	int ret;
> @@ -800,8 +799,7 @@ static int dpu_plane_prepare_fb(struct drm_plane *plane,
>  	 *       implicit fence and fb prepare by hand here.
>  	 */
>  	obj = msm_framebuffer_bo(new_state->fb, 0);
> -	msm_obj = to_msm_bo(obj);
> -	fence = reservation_object_get_excl_rcu(msm_obj->resv);
> +	fence = reservation_object_get_excl_rcu(obj->resv);
>  	if (fence)
>  		drm_atomic_set_fence_for_plane(new_state, fence);
>  
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index f5b1256e32b6..131c23a267ee 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -49,15 +49,13 @@ int msm_atomic_prepare_fb(struct drm_plane *plane,
>  	struct msm_drm_private *priv = plane->dev->dev_private;
>  	struct msm_kms *kms = priv->kms;
>  	struct drm_gem_object *obj;
> -	struct msm_gem_object *msm_obj;
>  	struct dma_fence *fence;
>  
>  	if (!new_state->fb)
>  		return 0;
>  
>  	obj = msm_framebuffer_bo(new_state->fb, 0);
> -	msm_obj = to_msm_bo(obj);
> -	fence = reservation_object_get_excl_rcu(msm_obj->resv);
> +	fence = reservation_object_get_excl_rcu(obj->resv);
>  
>  	drm_atomic_set_fence_for_plane(new_state, fence);
>  
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index c5ac781dffee..812d1b1369a5 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -86,10 +86,6 @@ struct msm_gem_object {
>  
>  	struct llist_node freed;
>  
> -	/* normally (resv == &_resv) except for imported bo's */
> -	struct reservation_object *resv;
> -	struct reservation_object _resv;
> -
>  	/* For physically contiguous buffers.  Used when we don't have
>  	 * an IOMMU.  Also used for stolen/splashscreen buffer.
>  	 */
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
