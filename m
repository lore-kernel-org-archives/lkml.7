Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39504C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0211322393
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8uqZ/Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfDPNz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:55:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54782 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfDPNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:55:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so25481445wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vvFxrPLkejUPPY2g5EocpsZ0E/YogFqjIRDDqUhhQDE=;
        b=M8uqZ/QjurmAo9MVsoTxSRZ1/uvuJ0ArTwFB959EDdwCH18/yAeZbkCzY2GVu99WC2
         BZstzP22tBIUXNWIFfp/d6b1ae8ftpfh2MX7F0bC0kCNT4LZ8svcdPfDcRirVU1MdDcj
         YlTvJocjW0Bs/He52sS1sgIOvJKeZE9MS/Tmlbw23sruiIi48/Qxz8yPc5L2hjsFfl+l
         qFjQFgeVmPkNo+sT/G+cyGvWcvNGhobmbfPnmHDxgNzD0ODQQbBLNSHBfood1Mbe5nkF
         K2cFFO9oK0SnKjvDqheB85n9kvhTAJB9CPU2JE3ZisBCoZ1WhfWleXZl4FRb0J/eS3jY
         QLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vvFxrPLkejUPPY2g5EocpsZ0E/YogFqjIRDDqUhhQDE=;
        b=TEegvfVuukUR6sDmEDtRIGWucEkjeukgFpRHI2blM2UkqmEruUO7DKxG6pnzhs0ZiT
         97u4xpQZc2PbnCjUvhGK/qMCMcCkVjThh3Rs+BpnfSpAzNt/KPuieIt86XVFZCVsG/ey
         uSRgEWmbdZ5v7Gesue16LyAVg4srNVJ8amqRdH2QrZz7rnSGs1IYZjHH5Cu/Zcnrffwo
         vGPVRI2GAjpvXqbfNcJckE69vHuYG4BGHAg0g8UpIubB52gJQ5qrVn35VRJqq8IgdeAF
         mPaFXbLeJBtAn+QNuCm65SRG9X3r+vm8iuW2aS9rzhzcpWSYsdOg46JLKBcipH164ctP
         ig6g==
X-Gm-Message-State: APjAAAV4h2oCd+BU2OoTu14HV4VGZShBPrmFmfGOW1M7+oPDRoGaDds2
        a/oPEGgiVPgYqWwnlV6OW9nEQQ==
X-Google-Smtp-Source: APXvYqzxyfB6HukBDgswEGVx01NxU43uiaSQckFEcvNDsWkyM1rYWCKjiV7YkogmVVtI1BQd4BfzGw==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr26239914wmc.49.1555422956628;
        Tue, 16 Apr 2019 06:55:56 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id f11sm73524418wrm.30.2019.04.16.06.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:55:56 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] clocksource/drivers/tcb_clksrc: move Kconfig
 option
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd.bergmann@linaro.org>
References: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
 <20190415150856.9384-6-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5bf6c4e6-ed3e-491e-37be-7edaa4b8e1cc@linaro.org>
Date:   Tue, 16 Apr 2019 15:55:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415150856.9384-6-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Arnd can you ack this patch? I would like to take the series via my tree.


On 15/04/2019 17:08, Alexandre Belloni wrote:
> Move the ATMEL_TCB_CLKSRC option to drivers/clocksource and make it silent
> if COMPILE_TEST is not selected.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clocksource/Kconfig |  7 +++++++
>  drivers/misc/Kconfig        | 14 --------------
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 171502a356aa..e38ef4906e30 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -410,6 +410,13 @@ config ATMEL_ST
>  	help
>  	  Support for the Atmel ST timer.
>  
> +config ATMEL_TCB_CLKSRC
> +	bool "Atmel TC Block timer driver" if COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select TIMER_OF if OF
> +	help
> +	  Support for Timer Counter Blocks on Atmel SoCs.
> +
>  config CLKSRC_EXYNOS_MCT
>  	bool "Exynos multi core timer driver" if COMPILE_TEST
>  	depends on ARM || ARM64
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 268a01d3d6f3..c84033909395 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -59,20 +59,6 @@ config ATMEL_TCLIB
>  	  blocks found on many Atmel processors.  This facilitates using
>  	  these blocks by different drivers despite processor differences.
>  
> -config ATMEL_TCB_CLKSRC
> -	bool "TC Block Clocksource"
> -	depends on ARCH_AT91
> -	select TIMER_OF if OF
> -	default y
> -	help
> -	  Select this to get a high precision clocksource based on a
> -	  TC block with a 5+ MHz base clock rate.  Two timer channels
> -	  are combined to make a single 32-bit timer.
> -
> -	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
> -	  may be used as a clock event device supporting oneshot mode
> -	  (delays of up to two seconds) based on the 32 KiHz clock.
> -
>  config DUMMY_IRQ
>  	tristate "Dummy IRQ handler"
>  	default n
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

