Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C65ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171B021835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsOtMSHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439737AbfJQLhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:37:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439727AbfJQLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:37:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so2193388wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kz81GWsdy+gT4h09Jxnw2SGeMu79bPfNDv5X5wml0Ow=;
        b=wsOtMSHpdRb6Eyt0a4RIHj3ouio4xANV3N5raaZk1cU6ih1BY7YK6f325AhA1diobG
         BoWDhKGQOnDjqitMuKFbONryFjMvYhZmmtl5rmPznmkTrsP/nAWrpY0aOqIlR1HAARM7
         N/1QBXvBRGJE7dzNZi8tAMcuJ1bPouAvd/7WSc9b0ZQOoHsKqZBvcPsPddV4pI0Iho5Z
         DgQO9eIECjl+wUtc+XLAFN3gZWbGdpPq3rWLFAoaw+88iW2ze6C5XjKTY0IQJsCRoKQ9
         ZLY5Mi8HF9bcMw+3rZd+S2RC9xAefNibIiecULZ6nBDr1NAtYRifeOwAy2lom3/e9mrJ
         ZcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kz81GWsdy+gT4h09Jxnw2SGeMu79bPfNDv5X5wml0Ow=;
        b=l5TdR+4SjhMgMz7ZbTcCtjprYezMxxMHkksE/OByGq5twTAi6u/5R6PTNpDlXz3ThY
         zNk0+gtwLXOtmKXME21KguyHaOrkIabbl0z4SK/jJkXYTW9l+iwHymauUGNBk1o2eAWE
         Sc3061I9u2P+FG8Jrir0fumrBlW+ZrN9UTVy+wWdSzuj/TKvoG8FBJ1y8qbhNtsIArDb
         PpLNMSpaSxAXlfStP9MnK46YdUObLE2vBsrl13loAvX6YSMrKiXPmIFYLSCOWnbPME0j
         jWO/Cyk7mQ/afwp4OT3rdtqfsb2iPNfLY/9UeYwUnnS+5Yw7qs1kCCAd8Fs3zdo6jGrO
         IzFg==
X-Gm-Message-State: APjAAAWsKh5lH7tCq0YycoWL99AiRcWux+54HduIHtsdZHXksUVpcZXQ
        99OfQBeXXgeHB1uQM8Is+kWsjQ==
X-Google-Smtp-Source: APXvYqwVcAbF9NKa2DBqA54nZM8E1xuownksYgsSe+rQmhJK4e6KkHf1SfpZesJWdHwSR9jrw3iaOw==
X-Received: by 2002:a1c:1dc9:: with SMTP id d192mr2631862wmd.51.1571312229630;
        Thu, 17 Oct 2019 04:37:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u1sm2020090wrp.56.2019.10.17.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:37:08 -0700 (PDT)
Date:   Thu, 17 Oct 2019 12:37:07 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-ID: <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191821.11479-30-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:18:16PM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the Kconfig dependency to CONFIG_PREEMPTION.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +LCD_HP700]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

(I know... the review for this particular patch is trivial but an
Acked-by from a maintainer means something specific and it is Lee
Jones who coordinates landing cross sub-system patch sets for
backlight).


Daniel.

> ---
>  drivers/video/backlight/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 40676be2e46aa..d09396393724b 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -99,7 +99,7 @@ config LCD_TOSA
>  
>  config LCD_HP700
>  	tristate "HP Jornada 700 series LCD Driver"
> -	depends on SA1100_JORNADA720_SSP && !PREEMPT
> +	depends on SA1100_JORNADA720_SSP && !PREEMPTION
>  	default y
>  	help
>  	  If you have an HP Jornada 700 series handheld (710/720/728)
> @@ -228,7 +228,7 @@ config BACKLIGHT_HP680
>  
>  config BACKLIGHT_HP700
>  	tristate "HP Jornada 700 series Backlight Driver"
> -	depends on SA1100_JORNADA720_SSP && !PREEMPT
> +	depends on SA1100_JORNADA720_SSP && !PREEMPTION
>  	default y
>  	help
>  	  If you have an HP Jornada 700 series,
> -- 
> 2.23.0
> 
