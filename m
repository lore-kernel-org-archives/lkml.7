Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6851CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAB62085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DZxe9WXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFYUWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:22:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44344 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFYUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:22:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so28974116edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IbaPTmVSK1Auuensg5mZK66IsBxApH2FblnD8ib5Dg0=;
        b=DZxe9WXKrsmxaaroa2rbKK1EsEntZAaqVR/+UjyyI7hGgL3bekEganJsyf+fyFbk0X
         PktDQ/QOboGkcqQb2mlJEWZ60RRAFBy6DQixbZ+b8tm+c4oLCvC4oKBiMlUvm+ludtHT
         A88M05J210TfYPMN3036eGm3lcpipS7i2woEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IbaPTmVSK1Auuensg5mZK66IsBxApH2FblnD8ib5Dg0=;
        b=BnDbSVjgroqksEiDYcJs+BKdr+kvpXVQQi858CVc4ly4tHXvBs0oIDYsiXpt0FuAwt
         kjjnV98LSQLC1PxeCfwkRHKHd+34oIGj282cu9PYsExBE9lIDSPNbnLDF88nd9v6kQvg
         0lHAylDyiDDpJQRzlusRln93ZEBzuooILM2Y1qZZsOZAw30TYpl6+Z/2BPEwcRn46wEU
         6GhnWLPK97bD5CulR3wk/17Pn9Tp/y6hlhMP01i03mixQKr12EOcC1rt37awD7PCRY9j
         YoLAL4TJUyxo68TsrPHVcOpK9n7ji8fpPAB0Hlon7+8TpsRfDSYrvJ0HHBcpmeOUTNmg
         SalA==
X-Gm-Message-State: APjAAAXM/hnTAZx3zlNOXMYrP9Ask8bjqiaKMmloRynYmt6FgedWWlzC
        m/5PjtlMX6oqINw2l3eZ2iJDSg==
X-Google-Smtp-Source: APXvYqzf4IQVb9h7Dov4iMeSGmus3NKT567mUeCO3NbEkQYOBEowGMzZ7rMIdDBuAYAw+tichO+cdg==
X-Received: by 2002:a17:906:b211:: with SMTP id p17mr410520ejz.11.1561494168042;
        Tue, 25 Jun 2019 13:22:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s5sm4839873edh.3.2019.06.25.13.22.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:22:47 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:22:44 +0200
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
Subject: Re: [PATCH v3 4/4] drm/imx: only send event on crtc disable if kept
 disabled
Message-ID: <20190625202244.GG12905@phenom.ffwll.local>
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
 <6599f538740632c5524bab86514b8ba026798537.1561483965.git.bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599f538740632c5524bab86514b8ba026798537.1561483965.git.bob.beckett@collabora.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:59:15PM +0100, Robert Beckett wrote:
> The event will be sent as part of the vblank enable during the modeset
> if the crtc is not being kept disabled.
> 
> Fixes: 5f2f911578fb ("drm/imx: atomic phase 3 step 1: Use atomic configuration")
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/imx/ipuv3-crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> index e04d6efff1b5..c436a28d50e4 100644
> --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> @@ -94,7 +94,7 @@ static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
>  	drm_crtc_vblank_off(crtc);
>  
>  	spin_lock_irq(&crtc->dev->event_lock);
> -	if (crtc->state->event) {
> +	if (crtc->state->event && !crtc->state->active) {
>  		drm_crtc_send_vblank_event(crtc, crtc->state->event);
>  		crtc->state->event = NULL;
>  	}
> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
