Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8603AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6D120895
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F7HHpENW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfKTQgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:36:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39710 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfKTQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:36:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so292681wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tesw3sq2dFVfQE6pmhyrzRi4mLidJzG8GCQ0JteIIRE=;
        b=F7HHpENW/MM6F+QovxPoI6sD3Q9wtMmI6R6dM0bwlSguWpp1dqIM349WqcCRZu+Ce/
         xR2k/uEyP92duYLa1gM6Nay/ZhmL1TIAV4PFaefUAcdv3x2XPhuzYyCaphD0yChAMbfG
         vx5JWEzsgxHGZFMh86C1dpXAPEIMGmgSSS52g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tesw3sq2dFVfQE6pmhyrzRi4mLidJzG8GCQ0JteIIRE=;
        b=csSq46SqCP8U4ewg0Ox5OmnTfjaEJpn3ExQwvW3Kz8q7hi5GNlNPTIZ3Zetq/HRCKM
         s63vPxIEswi9EGrQUci2lnkIaMOIBtIHfGcXZ6WIPLDls5xgtW35htwLLIkzidT7ULvy
         O0wJFczzIPwQTIFFgrTgxDID97G0fSD1LKKI/dwgGnuFmXxnNLuk+gL4TZSXOAWNbKIx
         8rHjmTTzigWnYbWLYb8guJltK2z6x0iZzSxRkYtV02CkUgH+PNaw+fVop+/GMHW21o15
         6T2fzoAvvubgLwuhYBKBX1+avBANRugTjsliCCxdMPGrM5sO7cQbOOB/h/KFh0JnOdJf
         oi/w==
X-Gm-Message-State: APjAAAX9/dBr/SdwLLCHp6KompnulTcrCxTn6kJnky62e6wjDdQmDoNN
        DT7Pd1r+DhI39I1535yl25MyQw==
X-Google-Smtp-Source: APXvYqwrPubNXX8yGAPcnC9X0GNh3U53hk3U8rLobGyGtHY/2ZK1eXIvpY5fLmaxi+5jpeb51T2FsA==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr4550515wmg.44.1574267806819;
        Wed, 20 Nov 2019 08:36:46 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id g5sm7278951wma.43.2019.11.20.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:36:46 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:36:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Fix Kconfig indentation
Message-ID: <20191120163644.GN30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20191120133348.6640-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133348.6640-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:33:48PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Queued for 5.6 in drm-misc, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 6f4222f8beeb..1670a5cae3c7 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -28,17 +28,17 @@ config ROCKCHIP_ANALOGIX_DP
>  	  on RK3288 or RK3399 based SoC, you should select this option.
>  
>  config ROCKCHIP_CDN_DP
> -        bool "Rockchip cdn DP"
> +	bool "Rockchip cdn DP"
>  	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
> -        help
> +	help
>  	  This selects support for Rockchip SoC specific extensions
>  	  for the cdn DP driver. If you want to enable Dp on
>  	  RK3399 based SoC, you should select this
>  	  option.
>  
>  config ROCKCHIP_DW_HDMI
> -        bool "Rockchip specific extensions for Synopsys DW HDMI"
> -        help
> +	bool "Rockchip specific extensions for Synopsys DW HDMI"
> +	help
>  	  This selects support for Rockchip SoC specific extensions
>  	  for the Synopsys DesignWare HDMI driver. If you want to
>  	  enable HDMI on RK3288 or RK3399 based SoC, you should select
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
