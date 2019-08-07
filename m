Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC7CC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF702184E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DLSRPLWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfHGVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:55:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39349 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfHGVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:55:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so87979680edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OrsO+gZAf7nFyvHox7p8seqF+I14+DYh+G0GXJPRhhU=;
        b=DLSRPLWxYdiWyPjT0wbQ3JBu00DxDtIGMUz4aZu0mkFUTot0lr3aQBW2CK8FZopABZ
         HpXN1lqQ9k5MtopdRAqQbf5w1lUoC5uZSJI0PqHPeEQbwt4qXDb19+142A3uQEStIkFy
         C2EzloO1y4mtQr+ZUNGwuHvSsiPBnWyszCUoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OrsO+gZAf7nFyvHox7p8seqF+I14+DYh+G0GXJPRhhU=;
        b=t7ZwFA3ipiOozkHLtqzqhLqnbXXe9RN2sn2ANjctkRWOCSEX65o6+DqXLhdUqcs/yu
         p7KxUxHDdt1P2ZqG4wA8z/DybJdL35IM3QvI37WeJCGJ+tjgJVUlkgT/ngP8EWgS0nJx
         lz/Mxgucpo0DI0N6PmWl9PUs9qco4bjvzILfxxfJvx3vInUhSN5fr5a4YJX0FxuTzcF+
         dBqg6w8asLGXiSxd2ms7fo5FpRUiADUo0alnLwyNMZYPm+EUeTS2zTSoToaDzdGTxzLK
         Np2MIh505RHFbLsY0Ok6xIwhmPVlL8U5dzhdBxyN29qMCo1ibh7qWSuHixStBFRL6ycR
         O85Q==
X-Gm-Message-State: APjAAAX8w10syjHqIffkkbyJ9cKJdXdJ8fdo+342Sf5t5+ojJHUQmyGV
        +oyokTDO9OJ71rOi325HM8nJ5Q==
X-Google-Smtp-Source: APXvYqwOPOlLD6xxUbZQ+15QHAKL6zVsvhgoM0hS4XdLmgpFIINXEfioRbkcmn+Awviw5aDeMhCZ0g==
X-Received: by 2002:a17:906:f2d0:: with SMTP id gz16mr10122534ejb.21.1565214911758;
        Wed, 07 Aug 2019 14:55:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i21sm723738ejz.83.2019.08.07.14.55.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 14:55:11 -0700 (PDT)
Date:   Wed, 7 Aug 2019 23:55:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau/dispnv04: Grab/put runtime PM refs on
 DPMS on/off
Message-ID: <20190807215508.GK7444@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190807213304.9255-1-lyude@redhat.com>
 <20190807213304.9255-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807213304.9255-2-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:33:00PM -0400, Lyude Paul wrote:
> The code claims to grab a runtime PM ref when at least one CRTC is
> active, but that's not actually the case as we grab a runtime PM ref
> whenever a CRTC is enabled regardless of it's DPMS state. Meaning that
> we can end up keeping the GPU awake when there are no screens enabled,
> something we don't really want to do.
> 
> Note that we fixed this same issue for nv50 a while ago in:
> 
> commit e5d54f193572 ("drm/nouveau/drm/nouveau: Fix runtime PM leak in
> nv50_disp_atomic_commit()")
> 
> Since we're about to remove nouveau_drm->have_disp_power_ref in the next
> commit, let's also simplify the RPM code here while we're at it: grab a
> ref during a modeset, grab additional RPM refs for each CRTC enabled by
> said modeset, and drop an RPM ref for each CRTC disabled by said
> modeset. This allows us to keep the GPU awake whenever screens are
> turned on, without needing to use nouveau_drm->have_disp_power_ref.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> index f22f01020625..08ad8e3b9cd2 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -183,6 +183,10 @@ nv_crtc_dpms(struct drm_crtc *crtc, int mode)
>  		return;
>  
>  	nv_crtc->last_dpms = mode;
> +	if (mode == DRM_MODE_DPMS_ON)
> +		pm_runtime_get_noresume(dev->dev);
> +	else
> +		pm_runtime_put_noidle(dev->dev);

it's after we filter out duplicate operations, so that part looks good.
But not all of nouveau's legacy helper crtc callbacks go throuh ->dpms I
think: nv_crtc_disable doesn't, and crtc helpers use that in preference
over ->dpms in some cases.

I think the only way to actually hit that path is if you switch an active
connector from an active CRTC to an inactive one. This implicitly disables
the crtc (well, should, nv_crtc_disable doesn't seem to shut down hw), and
I think would leak your runtime PM reference here. At least temporarily.

No idea how to best fix that. Aside from "use atomic" :-)

Cheers, Daniel

>  
>  	if (nv_two_heads(dev))
>  		NVSetOwner(dev, nv_crtc->index);
> @@ -1045,7 +1049,6 @@ nouveau_crtc_set_config(struct drm_mode_set *set,
>  
>  	dev = set->crtc->dev;
>  
> -	/* get a pm reference here */
>  	ret = pm_runtime_get_sync(dev->dev);
>  	if (ret < 0 && ret != -EACCES)
>  		return ret;
> @@ -1061,19 +1064,6 @@ nouveau_crtc_set_config(struct drm_mode_set *set,
>  	}
>  
>  	pm_runtime_mark_last_busy(dev->dev);
> -	/* if we have active crtcs and we don't have a power ref,
> -	   take the current one */
> -	if (active && !drm->have_disp_power_ref) {
> -		drm->have_disp_power_ref = true;
> -		return ret;
> -	}
> -	/* if we have no active crtcs, then drop the power ref
> -	   we got before */
> -	if (!active && drm->have_disp_power_ref) {
> -		pm_runtime_put_autosuspend(dev->dev);
> -		drm->have_disp_power_ref = false;
> -	}
> -	/* drop the power reference we got coming in here */
>  	pm_runtime_put_autosuspend(dev->dev);
>  	return ret;
>  }
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
