Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D2BC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71F7208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Bg0elYlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfGRSv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:51:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:51:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so31547029edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=URiLqv3fqj5L9yZBYo/hYzJLLFJ5n1+De76gKP8TH6E=;
        b=Bg0elYlpdWxC/T3gzK23vslgUN6925fC/aCeuZLDoKgqRzGdnLK8tUlH/9YrTBYdg1
         /Z2Flq8qtRoksfGeVT1J1DXm3VWNE37nTCVnfMIeqXJ7cwaDgeKAMbWoy7ygwAvvDgCi
         E4C0NY08/o9mLY2KtndFo8aH0b5ZdKvIqjbXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=URiLqv3fqj5L9yZBYo/hYzJLLFJ5n1+De76gKP8TH6E=;
        b=s9n46IQErzC4ihHef6kekZG4MAlOtT/SU2jgmJEYzzw91K2h3ao20F0pAiGrynG3gq
         xYp91Rk1lkA2cRSE/R/Y3n4dA87McMLNVLIkm8bXjsHVMRvLrC+c30DWercnL3yHv71+
         ARK9/VeQ0tpG4kMZxFnUdUneinRk1rJ/usuGQ+I5I3Z1KEOYATEj7+/mDeII7m6Ndt8Q
         f+iAyK+v9dfMTUu7Uh/gpUIjrFyvGV9WzVsdM8f4NERcmJP0dRinUC8bVB54nFjFV6kV
         GnoZtErj1c8P0rjJmykEGM3oXrz3uRi30f+5+qz3NbISy/1ARCuZ5sedxQfAVc+MIl6x
         8hAQ==
X-Gm-Message-State: APjAAAWRD7HRda/ZvJ7zjNC2ekPjEN3YBGMKagpf4USXu7NFfvkbo55I
        Wlo4yrljLY8vPAJbiTqQTFE=
X-Google-Smtp-Source: APXvYqzbB3jXKHw3Uwosyum0yf2AS5zz+W8fa+KDKL9/umSNpOtvTRqydz0lqflAV0hyXA5c19HLTQ==
X-Received: by 2002:a50:fa96:: with SMTP id w22mr42911286edr.45.1563475914324;
        Thu, 18 Jul 2019 11:51:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m31sm8028027edd.42.2019.07.18.11.51.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:51:53 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:51:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     james.qian.wang@arm.com, liviu.dudau@arm.com,
        brian.starkey@arm.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch
Subject: Re: [PATCH -next] drm/komeda: remove set but not used variable 'old'
Message-ID: <20190718185150.GC15868@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        james.qian.wang@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190709135808.56388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709135808.56388-1-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:58:08PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:
>  In function komeda_plane_atomic_duplicate_state:
> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:161:35:
>  warning: variable old set but not used [-Wunused-but-set-variable
> 
> It is not used since commit 990dee3aa456 ("drm/komeda:
> Computing image enhancer internally")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Queued for 5.3, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index c095af1..c1381ac 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -158,8 +158,6 @@ static void komeda_plane_reset(struct drm_plane *plane)
>  static struct drm_plane_state *
>  komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>  {
> -	struct komeda_plane_state *new, *old;
> -
>  	if (WARN_ON(!plane->state))
>  		return NULL;
>  
> @@ -169,8 +167,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>  
>  	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
>  
> -	old = to_kplane_st(plane->state);
> -
>  	return &new->base;
>  }
>  
> -- 
> 2.7.4
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
