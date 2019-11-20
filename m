Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE504C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9042089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HdWShTL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfKTQha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:37:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35113 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfKTQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:37:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so613456wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oBzjewY0/4230hInVXCRKl4aHXyti/pZjQvt6RHt1VA=;
        b=HdWShTL7uCjMONRqimJ2Eyo1ErSQletuc9rg4RJp8o2bbAXc6g8xE5d2oe6BykafHS
         bSovGk+jYKaKxa6lr3D8Ku2oaQEgdSwfSmbmXJQ2qmxKm0oAs63TVV5NHo0Y95Sggj1o
         1w54Gfx8i+ukog6S2BG5rc/BftMP4JzzIdkU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oBzjewY0/4230hInVXCRKl4aHXyti/pZjQvt6RHt1VA=;
        b=QD/767jENeTMiLItHC55A+4xhVqUpCCWK9GqnKL2qaSyb/BzlfL4mp4yMK6Y841vLV
         53QwbRmniqC0fwRqpfOElo9h17EjGXDHwe8Urr8r4sjFuMJbdxQ86Y/JI5INdgFZOGmB
         UeIAQYwOqfntxvISogdE2uD6bc2vt25TsyreSUIvD2YdULjU0G9R4lsCOI7LGhCk7pZY
         uUQHTzDAmHpjBuKurl1IdOtTJyb5G4Pxd98hRhHfGA3tyvTk1i9FNqdB0Vfdbna7Qy3Z
         hu4shfoL+t1TR39f/AiC/sydsn6h5U5wCIJTOXhx39SVeEX6wVg8Dpl+Xvar2DVfJLdR
         j4NA==
X-Gm-Message-State: APjAAAXPR9jtFCnby3iAZ2xDDjAldZ9+cf7GAEIataNQwfKZw8rSRM2v
        JjbXMvyL5p3D7I/TI816a+cMFg==
X-Google-Smtp-Source: APXvYqzNCV+sfP02kErA79n55a947yOZR5HcIjv64GQCubrDGzn6eKqtIii7sRSDlHmruuk2gvm8gg==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr4563865wrp.5.1574267847491;
        Wed, 20 Nov 2019 08:37:27 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id w10sm6906706wmd.26.2019.11.20.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:37:26 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:37:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/omap: Fix Kconfig indentation
Message-ID: <20191120163724.GO30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20191120133615.11329-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133615.11329-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:36:14PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Queued for 5.6 in drm-misc, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/omapdrm/displays/Kconfig |  6 +++---
>  drivers/gpu/drm/omapdrm/dss/Kconfig      | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/Kconfig b/drivers/gpu/drm/omapdrm/displays/Kconfig
> index 240dda102845..b562a8cd61bf 100644
> --- a/drivers/gpu/drm/omapdrm/displays/Kconfig
> +++ b/drivers/gpu/drm/omapdrm/displays/Kconfig
> @@ -8,18 +8,18 @@ config DRM_OMAP_ENCODER_OPA362
>  	  through a GPIO.
>  
>  config DRM_OMAP_ENCODER_TPD12S015
> -        tristate "TPD12S015 HDMI ESD protection and level shifter"
> +	tristate "TPD12S015 HDMI ESD protection and level shifter"
>  	help
>  	  Driver for TPD12S015, which offers HDMI ESD protection and level
>  	  shifting.
>  
>  config DRM_OMAP_CONNECTOR_HDMI
> -        tristate "HDMI Connector"
> +	tristate "HDMI Connector"
>  	help
>  	  Driver for a generic HDMI connector.
>  
>  config DRM_OMAP_CONNECTOR_ANALOG_TV
> -        tristate "Analog TV Connector"
> +	tristate "Analog TV Connector"
>  	help
>  	  Driver for a generic analog TV connector.
>  
> diff --git a/drivers/gpu/drm/omapdrm/dss/Kconfig b/drivers/gpu/drm/omapdrm/dss/Kconfig
> index 956f23e1452d..72ae79c0c9b4 100644
> --- a/drivers/gpu/drm/omapdrm/dss/Kconfig
> +++ b/drivers/gpu/drm/omapdrm/dss/Kconfig
> @@ -6,12 +6,12 @@ config OMAP_DSS_BASE
>  	tristate
>  
>  menuconfig OMAP2_DSS
> -        tristate "OMAP2+ Display Subsystem support"
> +	tristate "OMAP2+ Display Subsystem support"
>  	select OMAP_DSS_BASE
>  	select VIDEOMODE_HELPERS
>  	select OMAP2_DSS_INIT
>  	select HDMI
> -        help
> +	help
>  	  OMAP2+ Display Subsystem support.
>  
>  if OMAP2_DSS
> @@ -52,7 +52,7 @@ config OMAP2_DSS_DPI
>  
>  config OMAP2_DSS_VENC
>  	bool "VENC support"
> -        default y
> +	default y
>  	help
>  	  OMAP Video Encoder support for S-Video and composite TV-out.
>  
> @@ -61,7 +61,7 @@ config OMAP2_DSS_HDMI_COMMON
>  
>  config OMAP4_DSS_HDMI
>  	bool "HDMI support for OMAP4"
> -        default y
> +	default y
>  	select OMAP2_DSS_HDMI_COMMON
>  	help
>  	  HDMI support for OMAP4 based SoCs.
> @@ -85,7 +85,7 @@ config OMAP5_DSS_HDMI
>  
>  config OMAP2_DSS_SDI
>  	bool "SDI support"
> -        default n
> +	default n
>  	help
>  	  SDI (Serial Display Interface) support.
>  
> @@ -94,7 +94,7 @@ config OMAP2_DSS_SDI
>  
>  config OMAP2_DSS_DSI
>  	bool "DSI support"
> -        default n
> +	default n
>  	help
>  	  MIPI DSI (Display Serial Interface) support.
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
