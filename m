Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E6C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7502063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Z2+2CN1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfFYUDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:03:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35332 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFYUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:03:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id w20so21354147edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHs83YFBfNQZy/EqTIBWhIx/tAhxAnDwbcWzGiKotfU=;
        b=Z2+2CN1JavLtWBr2T1//ZKUDoABAKJ5zKuNVyzePsNE9TasWyMzfPaevhIMmrD1UeR
         z3wJRNgVVcilRdlu2CiBDWSpt9mkj8kL0YPZVtYExVwxhnkjrlPzT7uJx62fHhu9DMsP
         /uTZQQ2TO6IaS17xbaMUGi+TXmRL+dEuxiPOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KHs83YFBfNQZy/EqTIBWhIx/tAhxAnDwbcWzGiKotfU=;
        b=qGTzW9WEw0901BcFC+ZP6h+lY0/KTr9RoLShHXcO1dSJgRosKzCaxSNBbGPFYuO3fO
         /9hy724WcJtHSWlIy6kphHXRqwpJbV3w1BBkwKRorS7edTf/ojANXo6Hyj0F5MRJbJyF
         TjZuENV/k0/Bqwpe6KHbMc8M/SsVH/0xQDJijJjjxDWi0nQG8zE9cwRGhJ176CW8VJ+S
         xoIxhmyVoSog0CQt6gJpFACsWELTD7yC7aV4qcrNuZrkVk+1NrptPjTMLJ7U5kl3do0Y
         Dfb6NyRi/xjONIuaNyEAIXR0FokkZu+c6Ln2i1PFE53ESA6dA/TbvLstTlhVJORsx6iL
         16kw==
X-Gm-Message-State: APjAAAU0xpLwgu3VR0Z/L+s9r2zSL/4yd0AnOi/KCb1amHTXdkSDwFa/
        OY0Q27tuOearQun+XEXrCRPqjw==
X-Google-Smtp-Source: APXvYqzWmKDhdveaUADlwWBYeUgo7D5urxpoW3hfNOobLVUCSmkrF5iNrK07R4dKXM7pAl9426NJYQ==
X-Received: by 2002:a17:906:5c4a:: with SMTP id c10mr338323ejr.15.1561493007994;
        Tue, 25 Jun 2019 13:03:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z22sm5063953edz.6.2019.06.25.13.03.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:03:27 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:03:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Robert Beckett <bob.beckett@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] drm/imx: notify drm core before sending event
 during crtc disable
Message-ID: <20190625200324.GE12905@phenom.ffwll.local>
Mail-Followup-To: Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1561483965.git.bob.beckett@collabora.com>
 <066eb916ec920e0515367548e4af2ee28f9d0a43.1561483965.git.bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066eb916ec920e0515367548e4af2ee28f9d0a43.1561483965.git.bob.beckett@collabora.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:59:13PM +0100, Robert Beckett wrote:
> Notify drm core before sending pending events during crtc disable.
> This fixes the first event after disable having an old stale timestamp
> by having drm_crtc_vblank_off update the timestamp to now.
> 
> This was seen while debugging weston log message:
> Warning: computed repaint delay is insane: -8212 msec
> 
> This occured due to:
> 1. driver starts up
> 2. fbcon comes along and restores fbdev, enabling vblank
> 3. vblank_disable_fn fires via timer disabling vblank, keeping vblank
> seq number and time set at current value
> (some time later)
> 4. weston starts and does a modeset
> 5. atomic commit disables crtc while it does the modeset
> 6. ipu_crtc_atomic_disable sends vblank with old seq number and time
> 
> Fixes: a474478642d5 ("drm/imx: fix crtc vblank state regression")
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

Now that I understand what's going on here:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/imx/ipuv3-crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index 9cc1d678674f..e04d6efff1b5 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -91,14 +91,14 @@ static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
>  	ipu_dc_disable(ipu);
>  	ipu_prg_disable(ipu);
>  
> +	drm_crtc_vblank_off(crtc);
> +
>  	spin_lock_irq(&crtc->dev->event_lock);
>  	if (crtc->state->event) {
>  		drm_crtc_send_vblank_event(crtc, crtc->state->event);
>  		crtc->state->event = NULL;
>  	}
>  	spin_unlock_irq(&crtc->dev->event_lock);
> -
> -	drm_crtc_vblank_off(crtc);
>  }
>  
>  static void imx_drm_crtc_reset(struct drm_crtc *crtc)
> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
