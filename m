Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C4C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D72147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imzQQ9gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDCUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:22:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41169 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:22:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so21049lja.8;
        Wed, 03 Apr 2019 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/EoKRiqZwJ9batTheWvdpgnL44byukSisPeojhOTez0=;
        b=imzQQ9gWr816WhMJ6zObTdQgaNMZZdU+E8XyOv0IsvznkqJpUj6vJUHJ+vpqLWOfm3
         TlzDL7ynGntX+61L7XWmAbKy4tIXMnaX6WVKCNzBmotzrJGos5tXqut5rfHrygRw8vnc
         RYZtt6dgBUaWRIk68F1O/R4aIAHQuIX1aSTIVY+4B6GPUYMLmcACQ2zohM1f8X1fG6IX
         mUF5NL+EikQAKyY91lK8O4aBVzvKjcAwrJ3UN+WAbqRH28blb6OAQG52kqxBjWcOedDy
         GHSWVRHjZRIuYVdIiRqi6bvwcF/VykaXm6V809d7eatSh9vnTxuaGFQ1CAfSwYnplHBy
         RqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/EoKRiqZwJ9batTheWvdpgnL44byukSisPeojhOTez0=;
        b=kB198b3BgqB0IMFt9nlDHp/exzE2J6atcrmH7HQWlZQuN8E0YlloGVRBNpd4N6DJKm
         aDCCi1l4pcVjZZVNg0V3W+aOU0rQEsKm4B1YSjHcCHbDEUV6AXotN4hmS3DFeDbEOFV1
         WYr+5aqfq002fmR2O8sCvZofxw3pKLE1KBLzr+xzn5QGxUW3QGiGIg1BwJmONrGtg3sm
         CPLxQUC9nNuxkt7FTWZooToPm05NHKkEH+vSwG9jZcIv2lT7LjOctStuFYzNLvBsMnaf
         bbN9DPTJoPu0BhgmPkDsiZuFQqiPQclDYdLEran+vxuGyeM4nleH2SQN4wXmwjP8xQnY
         0rHA==
X-Gm-Message-State: APjAAAWKHTEVNwbPcxp49xbCcgqYsEQ7ioJQKrEGhVgyGPuHNRRtvYKc
        Orhr7kX0bPBzgZp+0FGB24c/QRCR
X-Google-Smtp-Source: APXvYqyAyu2fFxS4FI9a2ffHLoY2efVaggbL7ez4nAjEMXAYoZNVbqncGrAdVvAr1uz3BLbZ3V7Kbg==
X-Received: by 2002:a2e:9649:: with SMTP id z9mr1045369ljh.92.1554322929923;
        Wed, 03 Apr 2019 13:22:09 -0700 (PDT)
Received: from [192.168.1.19] (bkr161.neoplus.adsl.tpnet.pl. [83.28.185.161])
        by smtp.gmail.com with ESMTPSA id h15sm3139879lfp.34.2019.04.03.13.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:22:08 -0700 (PDT)
Subject: Re: [PATCH] leds: Small fixes for Flash class description
To:     Dan Murphy <dmurphy@ti.com>, pavel@ucw.cz, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190403181922.21273-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <19af37e8-93fd-c343-57ea-9792f18041f0@gmail.com>
Date:   Wed, 3 Apr 2019 22:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403181922.21273-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch.

On 4/3/19 8:19 PM, Dan Murphy wrote:
> Fix misspelling and capitalization of LED in the Kconfig.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/leds/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..f24d31138471 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -23,8 +23,8 @@ config LEDS_CLASS_FLASH
>   	tristate "LED Flash Class Support"
>   	depends on LEDS_CLASS
>   	help
> -	  This option enables the flash led sysfs class in /sys/class/leds.
> -	  It wrapps LED Class and adds flash LEDs specific sysfs attributes
> +	  This option enables the flash LED sysfs class in /sys/class/leds.
> +	  It wraps LED Class and adds flash LEDs specific sysfs attributes
>   	  and kernel internal API to it. You'll need this to provide support
>   	  for the flash related features of a LED device. It can be built
>   	  as a module.
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
