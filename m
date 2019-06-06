Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E77C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430C2206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="PmHXHYVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfFFQmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:42:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43011 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:42:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so1853877qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5QPjMBZ7QhHbHLNmjjqsDaYi7y/cyLKjCBZGOMHoSEM=;
        b=PmHXHYVp6HOkCqaTqZemv5nyGH4FlSL0ZuPiDcmSv5FFWeztRTukCpz/zF5umFyIF7
         4je6OpUcXwr9MhnH+dUacPzDzOiGFu/lP3laPt023f0oct1OV/EEyTcH5GhBWHvXLFxK
         vKCUR+DAFolYNwYYr/Cge6hSW3ditkcGKysmai/+ch0RqByKpmJe9Cd5GkK65gU0U4Pp
         LrEWbGJLa6vvzJ/p/5edCgDWYufEVxSjT2bXgvsP6sQBbQYYKpC8A3kBe8Zk3kv2HE90
         UmGUMJbUF1qisGKUvh0WZTCZVRDcV7TyoVZnpbUtquwGTLSsgYt5qbp62PSAp2I1wRBL
         9nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5QPjMBZ7QhHbHLNmjjqsDaYi7y/cyLKjCBZGOMHoSEM=;
        b=mSuJt2Strusm/deins97TSl5i/arVCUKCkrpMkTKQZMKdQI2UjVS2df/UNrT6yscCJ
         +4BZ4h6xGer0xzKDH8w+ZXwWVn9/SihlowSYHAqbJXF+MF48cVP8zYBcb2jZJXi3LXLP
         aKYDh3EkzwuQBYmvpN+OJrmGLjP1r203+ruMu+rNg6uQ7UCsAJMWXm5YVyYdN+fbsSJe
         8lilhms8M36M0L12MuaiaihUGh6pIJ9HVidVeuEwgWC0gI6xKiIt3ZBXW5RgFTz7k6pn
         twW3uYT5hHZlsiscS/8PnTN21TCdMU91dp3l5xNenLdXXvTw9MOFYjkMobL0fjx5diSY
         wOxw==
X-Gm-Message-State: APjAAAW86xLxz0eHsE6htGobxJXRx0Eeca4eZr6EQKloq3LO8WMX6TGU
        IT/O4VlytQPawE41IkLGW2PqSQ==
X-Google-Smtp-Source: APXvYqwDhHGG37UbtEUsjlslSQxaipRrUqUsFH2C+nCiwkgDH0iYGuNgjedUKpFCxqL2WIrawISaTQ==
X-Received: by 2002:a37:7a47:: with SMTP id v68mr25644536qkc.56.1559839342745;
        Thu, 06 Jun 2019 09:42:22 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id d123sm1224349qkb.94.2019.06.06.09.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:42:22 -0700 (PDT)
Date:   Thu, 6 Jun 2019 12:42:21 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
Message-ID: <20190606164221.GI17077@art_vandelay>
References: <20190604204207.168085-1-dianders@chromium.org>
 <20190604204207.168085-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604204207.168085-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:42:07PM -0700, Douglas Anderson wrote:
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
> 
> 1. You lose the ability to detect an HDMI device being plugged in.
> 
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
> 
> Let's call the core dw-hdmi's suspend/resume functions to restore
> things.
> 
> NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
> "late/early" versions of suspend/resume because we found that the VOP
> was sometimes resuming before dw_hdmi and then calling into us before
> we were fully resumed.  For now I have gone back to the normal
> suspend/resume because I can't reproduce the problems.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - dw_hdmi_resume() is now a void function (Laurent)
> 
> Changes in v2:
> - Add forgotten static (Laurent)
> - No empty stub for suspend (Laurent)
> 
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 4cdc9f86c2e5..7bb0f922b303 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -542,11 +542,25 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
> +{
> +	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +	dw_hdmi_resume(hdmi->hdmi);

The rockchip driver is already using the atomic suspend/resume helpers (via the
modeset helpers). Would you be able to accomplish the same thing by just moving
this call into the encoder enable callback? 

.enable is called on resume via the atomic commit framework, so everything is
ordered properly. Of course, this would reset the dw_hdmi bridge on each enable,
but I don't think that would be a problem?

Sean

> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dw_hdmi_rockchip_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, dw_hdmi_rockchip_resume)
> +};
> +
>  struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
>  	.probe  = dw_hdmi_rockchip_probe,
>  	.remove = dw_hdmi_rockchip_remove,
>  	.driver = {
>  		.name = "dwhdmi-rockchip",
> +		.pm = &dw_hdmi_rockchip_pm,
>  		.of_match_table = dw_hdmi_rockchip_dt_ids,
>  	},
>  };
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
