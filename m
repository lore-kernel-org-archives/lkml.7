Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44ACC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7018B2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guk/cB4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKXT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:19:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45255 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:19:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so11172049wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8S5DPbkJUeuS0msuewZK6ytnsqOwMF+XHe7JKmZJ8Q=;
        b=guk/cB4SALjmTWo06lOmPQCfirOWm5hC8o53ccneMsCRkFC9QHiI/xB15Zyz7SC3nk
         aGyIYavYYaSeEMzuWn02kb1tCSZGZqG3Z3Tb3ASsKg6LKlbt1He/tCyKidF/mn14JaTL
         FhySs/SeSryiYFdkbhPU1KAtWLAxKwAIJRqW08MKt0nK8cyCRKDstHISEzYgN7FMFNU+
         PYS/gKX8IPjKx9i4TNNs14fvkcNfVneHr5rR4F1CGEnxs2se7NtsA3fhVRRmE2FlPv84
         M1eoWBwEoxGzcvroxQhiE9H2+F6Tkn1s5duXbFdkfdnxlvFeXzJHaZjrqSCtTC7Vc8eE
         hKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8S5DPbkJUeuS0msuewZK6ytnsqOwMF+XHe7JKmZJ8Q=;
        b=Z4fg5nX4/VLdPFTUzStTM2G2/rm5AyMWuQwbsy7F3qEtAIs+s4BMo0RrUZM4jpPxdB
         uy8eJ258aFbQ5/JUz9gryNMDxlGSR+wXHgKeOFWiux008LNgV3xKpf10Dn2SkSWneshT
         uqJvTa2+baNRUBjae9sksabLjlgHGI/rNTel3oM4hfprDsM8RoITDScg/NY5rYu9giM+
         VGs3bSuR9gZSGHs6dw4ktjj9aeeirTr0zSosGu4iaMoZjTXE3EGK5UphuIx7lzCWM4V5
         BBlumDc6SNWswfT3zhU6De/+tMXg1Nl6R/TwifdQyHEs0VaSgMQgChhdUN4JWCGT6U9D
         uahQ==
X-Gm-Message-State: APjAAAXZV709D0BaxhYu7FikRpeEuihGaQDblR/T/S6b6vr/vfo4h3lO
        cQSF1Sg7mKd/kZ27ygPlyUo=
X-Google-Smtp-Source: APXvYqw72aIe/celjP64cfcn7BsbhSwJGpB7wvaG0aGHvTDm9lDToXMurYqYpCb3UrV1PSywUttkMA==
X-Received: by 2002:adf:dc0e:: with SMTP id t14mr23102815wri.170.1573514392256;
        Mon, 11 Nov 2019 15:19:52 -0800 (PST)
Received: from [192.168.1.221] ([195.245.39.207])
        by smtp.gmail.com with ESMTPSA id q124sm779492wme.13.2019.11.11.15.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 15:19:51 -0800 (PST)
Subject: Re: [PATCH] ARM: ep93xx: Avoid soc_device_to_device()
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
References: <20191111223722.2364-1-afaerber@suse.de>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <ef0dcc43-1b5d-0617-4d1e-4d6eb366e39d@gmail.com>
Date:   Tue, 12 Nov 2019 00:17:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191111223722.2364-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 11/11/2019 23:37, Andreas Färber wrote:
> ep93xx_init_soc() uses soc_device_to_device() to return a device
> to ep93xx_init_devices(), where it is passed on to its callers,
> who all ignore the return value. As this helper is deprecated,
> change the return type of ep93xx_init_devices() to void and
> have ep93xx_init_soc() return the soc_device instead.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andreas Färber <afaerber@suse.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/core.c     | 12 ++++--------
>  arch/arm/mach-ep93xx/platform.h |  2 +-
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 6fb19a393fd2..7a0c82b30564 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -937,7 +937,7 @@ static const char __init *ep93xx_get_machine_name(void)
>  	return kasprintf(GFP_KERNEL,"%s", machine_desc->name);
>  }
>  
> -static struct device __init *ep93xx_init_soc(void)
> +static struct soc_device __init *ep93xx_init_soc(void)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
> @@ -958,13 +958,11 @@ static struct device __init *ep93xx_init_soc(void)
>  		return NULL;
>  	}
>  
> -	return soc_device_to_device(soc_dev);
> +	return soc_dev;
>  }
>  
> -struct device __init *ep93xx_init_devices(void)
> +void __init ep93xx_init_devices(void)
>  {
> -	struct device *parent;
> -
>  	/* Disallow access to MaverickCrunch initially */
>  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
>  
> @@ -975,7 +973,7 @@ struct device __init *ep93xx_init_devices(void)
>  			       EP93XX_SYSCON_DEVCFG_GONIDE |
>  			       EP93XX_SYSCON_DEVCFG_HONIDE);
>  
> -	parent = ep93xx_init_soc();
> +	ep93xx_init_soc();
>  
>  	/* Get the GPIO working early, other devices need it */
>  	platform_device_register(&ep93xx_gpio_device);
> @@ -989,8 +987,6 @@ struct device __init *ep93xx_init_devices(void)
>  	platform_device_register(&ep93xx_wdt_device);
>  
>  	gpio_led_register_device(-1, &ep93xx_led_data);
> -
> -	return parent;
>  }
>  
>  void ep93xx_restart(enum reboot_mode mode, const char *cmd)
> diff --git a/arch/arm/mach-ep93xx/platform.h b/arch/arm/mach-ep93xx/platform.h
> index b4045a186239..8a3a2be50f11 100644
> --- a/arch/arm/mach-ep93xx/platform.h
> +++ b/arch/arm/mach-ep93xx/platform.h
> @@ -34,7 +34,7 @@ void ep93xx_register_ac97(void);
>  void ep93xx_register_ide(void);
>  void ep93xx_register_adc(void);
>  
> -struct device *ep93xx_init_devices(void);
> +void ep93xx_init_devices(void);
>  extern void ep93xx_timer_init(void);
>  
>  void ep93xx_restart(enum reboot_mode, const char *);
