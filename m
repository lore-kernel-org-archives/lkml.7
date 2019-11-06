Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB776C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80051217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="C+n82oQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfKFKAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:00:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37967 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbfKFKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so2580573wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zy+pSn3ZcoonGSv1GO7C8DvEXQpMaLJfKmRCgcy5jsg=;
        b=C+n82oQNJFjenuv/DNJAgBzVrh8fyteQYuLVy1XYG0jKDYAL0O8OiwweQ2NLFw5+5Z
         ZdIrd+/HVctvnEXkFTMOx5+k//af4trZVXXZxnubH7Vim5naTIuY8nLC3gKoBR3quozj
         8X7xb90cwVKttEgAQgiN9Nv/y8jr4IvUoqNeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zy+pSn3ZcoonGSv1GO7C8DvEXQpMaLJfKmRCgcy5jsg=;
        b=hhjA8L8+8cK6lK+ETa2DZrGrbB/EVYOmTjYyvLzhAiPKx5gVYmDMWan2P+i6LlpmCZ
         E0gANjHjdK2P8nIFMxxyDGv1resCrP39U4RtPLiULqulNVPJzT5/qWu82tMq0gPnWg14
         Wl06q8qKmxfMM7VWQI04wFqeIEPDwjnQbQYuNHKROi1UUto9QlSd9dJfzoTr8o7M5KIK
         qXcUT+jOrO+KodUiCq3jRMk991f1W8+/O3jlGTASU+enoEdDPA1+MkBkODeJsR1jCyHc
         CYdQ5545GTuRIZOvTgVwF05nGoh5XBUzlIKLIBs36ZzdyrKxtVLiTpHe5zc2ze85oLby
         qDBw==
X-Gm-Message-State: APjAAAUUZ+KiyEv3Qk3dA1LcsJfj2mjmoJdTV7DCTTwvNrwRd+FzNgBH
        SQykoYk3jaIxU67eACAjq++shw==
X-Google-Smtp-Source: APXvYqyQxNqhhawsrrSWps1N79qhazCv6pc1zOL9i3tUA/WFWiss6Xh9eJvnifMvzvFih9IDJzCAvg==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr1740732wmj.90.1573034407343;
        Wed, 06 Nov 2019 02:00:07 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id c144sm2310805wmd.1.2019.11.06.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 02:00:06 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:00:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH 1/1] drm/panel: boe-tv101wum-n16 seperate the panel power
 control
Message-ID: <20191106100004.GC23790@phenom.ffwll.local>
Mail-Followup-To: Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
References: <20191106081752.12944-1-jitao.shi@mediatek.com>
 <20191106081752.12944-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106081752.12944-2-jitao.shi@mediatek.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:17:52PM +0800, Jitao Shi wrote:
> Seperate the panel power control from prepare/unprepare.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Your patch series is all kinds of split up. Can you pls resend, with the
entire thing all in one go?

Thanks, Daniel

> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 69 +++++++++++++------
>  1 file changed, 49 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index e2496a334ab6..5b1b285a2194 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -50,6 +50,7 @@ struct boe_panel {
>  	struct regulator *avdd;
>  	struct gpio_desc *enable_gpio;
>  
> +	bool prepared_power;
>  	bool prepared;
>  	bool enabled;
>  
> @@ -501,12 +502,11 @@ static int boe_panel_disable(struct drm_panel *panel)
>  	return 0;
>  }
>  
> -static int boe_panel_unprepare(struct drm_panel *panel)
> +static int boe_panel_unprepare_power(struct drm_panel *panel)
>  {
>  	struct boe_panel *boe = to_boe_panel(panel);
> -	int ret;
>  
> -	if (!boe->prepared)
> +	if (!boe->prepared_power)
>  		return 0;
>  
>  	if (boe->desc->discharge_on_disable) {
> @@ -518,12 +518,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
>  		usleep_range(5000, 7000);
>  		regulator_disable(boe->pp1800);
>  	} else {
> -		ret = boe_panel_off(boe);
> -		if (ret < 0) {
> -			dev_err(panel->dev, "failed to set panel off: %d\n",
> -				ret);
> -			return ret;
> -		}
>  		msleep(150);
>  		gpiod_set_value(boe->enable_gpio, 0);
>  		usleep_range(500, 1000);
> @@ -533,17 +527,39 @@ static int boe_panel_unprepare(struct drm_panel *panel)
>  		regulator_disable(boe->pp1800);
>  	}
>  
> +	boe->prepared_power = false;
> +
> +	return 0;
> +}
> +
> +static int boe_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	if (!boe->prepared)
> +		return 0;
> +
> +	if (!boe->desc->discharge_on_disable) {
> +		ret = boe_panel_off(boe);
> +		if (ret < 0) {
> +			dev_err(panel->dev, "failed to set panel off: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>  	boe->prepared = false;
>  
>  	return 0;
>  }
>  
> -static int boe_panel_prepare(struct drm_panel *panel)
> +static int boe_panel_prepare_power(struct drm_panel *panel)
>  {
>  	struct boe_panel *boe = to_boe_panel(panel);
>  	int ret;
>  
> -	if (boe->prepared)
> +	if (boe->prepared_power)
>  		return 0;
>  
>  	gpiod_set_value(boe->enable_gpio, 0);
> @@ -571,18 +587,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
>  	gpiod_set_value(boe->enable_gpio, 1);
>  	usleep_range(6000, 10000);
>  
> -	ret = boe_panel_init(boe);
> -	if (ret < 0) {
> -		dev_err(panel->dev, "failed to init panel: %d\n", ret);
> -		goto poweroff;
> -	}
> -
> -	boe->prepared = true;
> +	boe->prepared_power = true;
>  
>  	return 0;
>  
> -poweroff:
> -	regulator_disable(boe->avee);
>  poweroffavdd:
>  	regulator_disable(boe->avdd);
>  poweroff1v8:
> @@ -593,6 +601,25 @@ static int boe_panel_prepare(struct drm_panel *panel)
>  	return ret;
>  }
>  
> +static int boe_panel_prepare(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	if (boe->prepared)
> +		return 0;
> +
> +	ret = boe_panel_init(boe);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to init panel: %d\n", ret);
> +		return ret;
> +	}
> +
> +	boe->prepared = true;
> +
> +	return 0;
> +}
> +
>  static int boe_panel_enable(struct drm_panel *panel)
>  {
>  	struct boe_panel *boe = to_boe_panel(panel);
> @@ -754,7 +781,9 @@ static int boe_panel_get_modes(struct drm_panel *panel)
>  static const struct drm_panel_funcs boe_panel_funcs = {
>  	.disable = boe_panel_disable,
>  	.unprepare = boe_panel_unprepare,
> +	.unprepare_power = boe_panel_unprepare_power,
>  	.prepare = boe_panel_prepare,
> +	.prepare_power = boe_panel_prepare_power,
>  	.enable = boe_panel_enable,
>  	.get_modes = boe_panel_get_modes,
>  };
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
