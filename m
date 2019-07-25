Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC5C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189C822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="M3t1O2gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfGYMOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:14:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34469 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfGYMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:14:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so15203187edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xBQlbxU4sIAkZTKOezDDuKJzUoBaUMJjzL90w1I4sJI=;
        b=M3t1O2gx3+K3rmn/pg3IKsxF+wMha3/LFiBk1fJtQOwd8o0IqWLiVGplJsSGS0D56s
         9xudBdZ2cfavEGGdm0BxzNjv7mYMR/gZDIdJDMJnpyWgil3kUhBR8OYvLmQzLxtkugQC
         Fvqfzg4SzAyYVYQu3pyILKvHWBdT4P88aG3lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xBQlbxU4sIAkZTKOezDDuKJzUoBaUMJjzL90w1I4sJI=;
        b=TUD1HSrBazMuMAiJPu4uAFGtOXGcb7CYWjFR9WxbiOOqMdeDjH38PZ+z+3jr08sbdR
         GzHr6xPCgtYhPsO+7ADGoYw3DC12yvYhJRRL7zT44q5gbHw2skDTtCBZEhTJnR9k5t0T
         kL43EqMVb/PSDv9G01RtjBdgE0zVl9LIuLnPBxkNlnMw4jZt+sE9BfLS6pFAueYe5z4f
         /oKBWOyOb5blNRPx71KnASoWuAiKkZ9C2B18xNLs/j0tJ250jHZ+NCsJh0pGyTvmh43t
         gozwx1upk76SD/vncFS8VAgnsRnKjPQxujd3JSBTFpwj4ELHxRRdNI4fmq2UIAUpoeFo
         jn1g==
X-Gm-Message-State: APjAAAX4mpmT1B1ljK9l1ifgSWxncSKcsSNzvm/w0/a89BvL4YTZe1Gg
        XD/fFHyX0vxp4cZoOPqQUjM=
X-Google-Smtp-Source: APXvYqxpjLksWwyG57A6QDgvk5QYVTO1S3Bu71l5am95Yyx/jOFyNfHhPMap/yiKB8fT77bOtSzaSQ==
X-Received: by 2002:a50:e618:: with SMTP id y24mr76229999edm.142.1564056888257;
        Thu, 25 Jul 2019 05:14:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 34sm13374689eds.5.2019.07.25.05.14.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:14:47 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:14:45 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/1] drm/bridge: vga-dac: Fix detect of monitor connection
Message-ID: <20190725121445.GD15868@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
        Jonas Karlman <jonas@kwiboo.se>, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20190725110520.26848-1-oleksandr.suvorov@toradex.com>
 <20190725110520.26848-2-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725110520.26848-2-oleksandr.suvorov@toradex.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:05:24AM +0000, Oleksandr Suvorov wrote:
> DDC and VGA channels are independent, and therefore
> we cannot decide whether the monitor is connected or not,
> depending on the information from the DDC.
> 
> So the monitor should always be considered connected.
> Thus there is no reason to use connector detect callback for this
> driver.
> 
> Fixes DRM error of dumb monitor detection like:
> ...
> DRM: head 'VGA-1' found, connector 32 is disconnected.
> ...
> 
> Cc: stable@vger.kernel.org
> Fixes: 56fe8b6f4991 ("drm/bridge: Add RGB to VGA bridge support")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Uh nope :-)

Yes VGA monitors are broken, but the way to fix that is to either override
that on the kernel cmdline, or in your userspace somewhere. Not hardcode
this in the kernel for everyone. Because not everyone does have a broken
VGA monitor, but if you do this _every_ desktop will try to light up that
broken monitor. Which leads to lots of bug reports and regressions.

This case is exactly what connector_status_unknown is meant for: The
kernel couldn't authoritatively figure out whether there is a monitor or
not. Userspace should/can try this into account for autoconfiguration.

Note a more proper fix would be to somehow wire up load detection. That
will work even for dumb VGA monitors, and e.g. i915 then gives you an
authoritative connector_status_disconnected if it could execute a load
detect cycle (not always possible on some hw) and there's no screen
detected with that.

Maybe we should document this better somewhere in docs? Would be great if
you can type a patch for this ...
-Daniel

> ---
> 
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> index d32885b906ae..e37c19356d12 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -73,25 +73,7 @@ static const struct drm_connector_helper_funcs dumb_vga_con_helper_funcs = {
>  	.get_modes	= dumb_vga_get_modes,
>  };
>  
> -static enum drm_connector_status
> -dumb_vga_connector_detect(struct drm_connector *connector, bool force)
> -{
> -	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
> -
> -	/*
> -	 * Even if we have an I2C bus, we can't assume that the cable
> -	 * is disconnected if drm_probe_ddc fails. Some cables don't
> -	 * wire the DDC pins, or the I2C bus might not be working at
> -	 * all.
> -	 */
> -	if (!IS_ERR(vga->ddc) && drm_probe_ddc(vga->ddc))
> -		return connector_status_connected;
> -
> -	return connector_status_unknown;
> -}
> -
>  static const struct drm_connector_funcs dumb_vga_con_funcs = {
> -	.detect			= dumb_vga_connector_detect,
>  	.fill_modes		= drm_helper_probe_single_connector_modes,
>  	.destroy		= drm_connector_cleanup,
>  	.reset			= drm_atomic_helper_connector_reset,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
