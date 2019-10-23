Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F93CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B18205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571825582;
	bh=9zSbmzwBSm/Stzg9ZLWyQRs1rXLCa6hqw4qTfvR/gXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WUG5caV/LK2Ycz+o0ZKsNVJmLHA0lP8/hGNFv6V6pWUTqapyQxj/mYGPfi6TTL1Lv
	 PeDdePL3LVzLDSHIpRm9Py+BLTim3f7W7N7BBoZHZtYv7nLpOT5qTZlhhpXfdDjMgG
	 a6+oyuO04uOU60BRdh+TUlBSjT8wT01HlDIxFRc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391066AbfJWKNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34540 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390935AbfJWKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id b72so6350788edf.1;
        Wed, 23 Oct 2019 03:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gh/A8yPMnN6fLcg7Rkm6GEnRbYetJz0QGF4U7JjOn9o=;
        b=CqFuotSGn9LzNIm4SthqduS4KqT2rB4NrzWStgpv0ksDkEOnSPXWHb/qkPVtrIOaw8
         glDcRsmuSiR9ESLK+cFy8DZyBwaE1k04m+IW2V41uqxRdzPN0gPaqWDlswIuUCsnM/+O
         1fj1Eae3PYJBs1RncaN91NVeBGy0C06sIEZ2xvPgVjlQbsiyRCbJluRNbKm+v5IrH6iQ
         J6WW2qlX2XL0LgfaGvtJn3JAaXDufREsVFwcPNDSqub5Itj7nOLku+apqqxvk4SBSbq3
         5qZemF0AenzN85n+ncvVomePTSkEmj/Ves2sM5V0eZUaNg7mJzW1igx3lJ96kX3Q8uyA
         U0tA==
X-Gm-Message-State: APjAAAXWSacLwsoQS7rtznUrAEgE/cnSvcQj9AEvEnxUBzgjt2lgRLMx
        g61APlLHXspz12z7zcH8xNs=
X-Google-Smtp-Source: APXvYqyuj6NCW72i3rqtWTRKsJx3LFyO3f0M4VmCWK792D/NQODCSFHNhIH0XERkCGbZhxUd4Vbu0g==
X-Received: by 2002:a50:f40c:: with SMTP id r12mr13174374edm.50.1571825579739;
        Wed, 23 Oct 2019 03:12:59 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id m14sm790794edc.61.2019.10.23.03.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:12:59 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:12:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/36] ARM: samsung: move CONFIG_DEBUG_S3C_UART to
 Kconfig.debug
Message-ID: <20191023101257.GC10630@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-6-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:50PM +0200, Arnd Bergmann wrote:
> Before we can plat-samsung from the individual platforms,

"Before we can split"? Or moved? What did you want to say here?

Best regards,
Krzysztof

> this one has to get moved to a place where it remains
> accessible.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug        | 10 ++++++++++
>  arch/arm/plat-samsung/Kconfig |  8 --------
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 8bcbd0cd739b..d05b836dfeb2 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1464,6 +1464,16 @@ config DEBUG_S3C64XX_UART
>  config DEBUG_S5PV210_UART
>  	bool
>  
> +config DEBUG_S3C_UART
> +	depends on DEBUG_S3C2410_UART || DEBUG_S3C24XX_UART || \
> +		   DEBUG_S3C64XX_UART ||  DEBUG_S5PV210_UART || \
> +		   DEBUG_EXYNOS_UART
> +	int
> +	default "0" if DEBUG_S3C_UART0
> +	default "1" if DEBUG_S3C_UART1
> +	default "2" if DEBUG_S3C_UART2
> +	default "3" if DEBUG_S3C_UART3
> +
>  config DEBUG_OMAP2PLUS_UART
>  	bool
>  	depends on ARCH_OMAP2PLUS
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 301e572651c0..832ab0e6cd72 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -296,13 +296,5 @@ config SAMSUNG_WDT_RESET
>  	  Compile support for system restart by triggering watchdog reset.
>  	  Used on SoCs that do not provide dedicated reset control.
>  
> -config DEBUG_S3C_UART
> -	depends on PLAT_SAMSUNG
> -	int
> -	default "0" if DEBUG_S3C_UART0
> -	default "1" if DEBUG_S3C_UART1
> -	default "2" if DEBUG_S3C_UART2
> -	default "3" if DEBUG_S3C_UART3
> -
>  endmenu
>  endif
> -- 
> 2.20.0
> 
