Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D7C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B8D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EqENzc8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfFYULk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:11:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40431 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:11:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so28996111eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zkV6FjfcQsvo6WYlA8ceAW7NTugFBRZuAe5/8PprGgI=;
        b=EqENzc8ZFmkojdUW4bYooe/jHYrBPUxIfH5lufyaa/ljp7fZjFaQVWzP2rlePy2DAk
         tfSJFccP/J6XNDXKPMrYnu/DCrc9n9AXAa/9a0pfe5ig1PwrFxmcHQChxJ1LNWbAM/az
         ssuZV1iUpkscfXe/eYKaPcbpNlh7TWiA16EY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zkV6FjfcQsvo6WYlA8ceAW7NTugFBRZuAe5/8PprGgI=;
        b=XCoAU6VF4ddBl34wn4VLNh+27VNtHGl8hWojHv6cdCjon+azJ2pQgPUo97L8+GQmCP
         CzWtC1GPB6GQUhoAUrCufhYtlXoHhZsy5oyQdCFhSAAIhTv7p8Yj2stSq2kt3eCiyzSl
         4zE7kZte3p8x8ez6VShtgTGyaSRnuetRO+F2lUVty/h/Iylsg7In2hqGYjHh8O6gnk2G
         yR+zDiSQCil+Biko2JeXxPjqC5BnMdw4fQaV3Xw9A5w0FthxPVi6tEKvPhwmIcrzBPLd
         QesTU/e1YsWjJW8BxntNNEjPins3+d/taf7J2YH51xiCU5+wOVJ/DYmLMVUrYs9AHpr9
         rPDQ==
X-Gm-Message-State: APjAAAXH++aswa8R7Wf78x2Goq37BbCUVtx6o4kD6QXhuuOXB6amp4sb
        TdynCm8Ul2Z45xK2i4MGplH+HQ==
X-Google-Smtp-Source: APXvYqwoVMnAgUuE3liJcixkOYd1NT201/L7ZxinP68zsYUut//RkA+BJy/SK3l/jTY4VRTqV7InDw==
X-Received: by 2002:a50:b635:: with SMTP id b50mr327666ede.293.1561493497807;
        Tue, 25 Jun 2019 13:11:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k3sm1048485edi.14.2019.06.25.13.11.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:11:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:11:34 +0200
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
Subject: Re: [PATCH v3 3/4] drm/vblank: estimate vblank while disabling
 vblank if interrupt disabled
Message-ID: <20190625201134.GF12905@phenom.ffwll.local>
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
 <b96132cef4b63118df1026a99b3c345692e3de26.1561483965.git.bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96132cef4b63118df1026a99b3c345692e3de26.1561483965.git.bob.beckett@collabora.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:59:14PM +0100, Robert Beckett wrote:
> If interrupts are disabled (e.g. via vblank_disable_fn) and we come to
> disable vblank, update the vblank count to best guess as to what it
> would be had the interrupts remained enabled, and update the timesamp to
> now.
> 
> This avoids a stale vblank event being sent while disabling crtcs during
> atomic modeset.
> 
> Fixes: 68036b08b91bc ("drm/vblank: Do not update vblank count if interrupts
> are already disabled.")
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 7dabb2bdb733..db68b8cbf797 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -375,9 +375,23 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe)
>  	 * interrupts were enabled. This avoids calling the ->disable_vblank()
>  	 * operation in atomic context with the hardware potentially runtime
>  	 * suspended.
> +	 * If interrupts are disabled (e.g. via blank_disable_fn) then make
> +	 * best guess as to what it would be now and make sure we have an up
> +	 * to date timestamp.
>  	 */
> -	if (!vblank->enabled)
> +	if (!vblank->enabled) {
> +		ktime_t now = ktime_get();

Would be nice to fake this a bit more accurately and round the timestamp
here to a multiple of the frame duration, i.e. ...
> +		u32 diff = 0;
> +		if (vblank->framedur_ns) {
> +			u64 diff_ns = ktime_to_ns(ktime_sub(now, vblank->time));
> +			diff = DIV_ROUND_CLOSEST_ULL(diff_ns,
> +						     vblank->framedur_ns);
> +		}

		now = vblank->time + diff * vblank_framedur_ns;

Picking the right macro for doing 64bit multiplies left to you :-)

> +
> +		store_vblank(dev, pipe, diff, now, vblank->count);
> +
>  		goto out;
> +	}
>  
>  	/*
>  	 * Update the count and timestamp to maintain the

Somewhat unhappy that we're duplicating this logic with
drm_update_vblank_count, but it's just 2 lines of math.
-Daniel

> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
