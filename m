Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8582084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="eseIQ+3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfEOR63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:58:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46259 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:58:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so655811qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T3r53rpcIIdNWUWUX1L2hWGIMIpNyc3n74ZjaoYk6ds=;
        b=eseIQ+3pKjwi0X7F8OvMJCGH+HwZS6LhXVbIONYoL/PKENiZd2gBx4UBYRuji8jiEz
         tD88w0+QZEhw7cKzTo63UlK+YINRL+VWCip+4N3tBcGJSycvR0Ev+BpmtCGXOEy2yn3q
         JoVdLsd/Wqhl6EcS55EdOIKpoybnyFmpMO9025SzEQrJE+87AypjP1QVb4fqnaJqnf44
         UxjWWas+DUpvhH2w59bKq25kU2Z5a2f5tLERhAySrspY7lXuUdOZ1HmI3cHdAiDuEc8S
         tcTdq4CwbibmjtyJVfzkkupk4W88fJj0J3yhJYwZy4Hv7kOednw2Y4NGqJ4aXF0mMHUf
         5yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T3r53rpcIIdNWUWUX1L2hWGIMIpNyc3n74ZjaoYk6ds=;
        b=q2PYccG5O6D08QHMvPb+6DcuhA5hQUfxwlTRoWY81dMvesPXx7XERow35YY7nJrqs2
         PksPRk1BFy6CT8J+BMf8pPefT3LxusqoBhzU0n8wQ4YDauYhwKirUt2gFaaHSJRfC5MW
         YUDgebbKJeQ9uegsZWKCnN1JIx3Q7MUUAVdu357wXpXTnbrg4sSRGd1Ow69p8q3pCCgp
         s8Ytc9+/bR5dyHOMNgWyobsMJf4ChqNyUYTjjVgMyjieD22ilMC1TlOG4gNQ6LY5gxLs
         nN25wijXxp9yDIJJUaB46wtHmyZI5NydkJsIQNlWD1A5Al60UyI7hLNoxWTpP+8iJ0MA
         +vFQ==
X-Gm-Message-State: APjAAAXt8fpCQmUPa194EdWtYnXvJL3sJ6AuC9Fv07r33r6nc34ZBCPm
        7mfvUTbh0oVno0oTKSNmzfIyUw==
X-Google-Smtp-Source: APXvYqxsReEgdKIvYRBuSR8ZyL1XCBJ4JluVaiQzwdUcL6yNsiM2bJ85D/CpKdFK7iN2V1E9k0sWTA==
X-Received: by 2002:a0c:d17b:: with SMTP id c56mr15467538qvh.61.1557943107807;
        Wed, 15 May 2019 10:58:27 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k89sm1491911qte.33.2019.05.15.10.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 10:58:26 -0700 (PDT)
Date:   Wed, 15 May 2019 13:58:26 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
Message-ID: <20190515175826.GT17077@art_vandelay>
References: <20190502223808.185180-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502223808.185180-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:38:07PM -0700, Douglas Anderson wrote:
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
> 
> 1. You lose the ability to detect an HDMI device being plugged in.
> 
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
> 
> Let's add a hook to the core dw-hdmi driver so that we can call it in
> dw_hdmi-rockchip in the next commit.
> 
> NOTE: the exact set of steps I've done here in resume come from
> looking at the normal dw_hdmi init sequence in upstream Linux plus the
> sequence that we did in downstream Chrome OS 3.14.  Testing show that
> it seems to work, but if an extra step is needed or something here is
> not needed we could improve it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
>  include/drm/bridge/dw_hdmi.h              |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index db761329a1e3..4b38bfd43e59 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2780,6 +2780,27 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
>  
> +int dw_hdmi_suspend(struct dw_hdmi *hdmi)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
> +
> +int dw_hdmi_resume(struct dw_hdmi *hdmi)
> +{
> +	initialize_hdmi_ih_mutes(hdmi);
> +
> +	dw_hdmi_setup_i2c(hdmi);
> +	if (hdmi->i2c)
> +		dw_hdmi_i2c_init(hdmi);
> +
> +	if (hdmi->phy.ops->setup_hpd)
> +		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_resume);

Both patches look good to me, I'd probably prefer to just smash them together,
but meh.

If no one more authoritative chimes in, I'll apply them to -misc in a few days.

Sean

> +
>  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
>  MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
>  MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 66e70770cce5..c4132e9a5ae3 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -154,6 +154,9 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
>  			     struct drm_encoder *encoder,
>  			     const struct dw_hdmi_plat_data *plat_data);
>  
> +int dw_hdmi_suspend(struct dw_hdmi *hdmi);
> +int dw_hdmi_resume(struct dw_hdmi *hdmi);
> +
>  void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
>  
>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
