Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDBC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F1420844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHI7V9VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfHMNUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:20:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53265 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfHMNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:20:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so1494423wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfLZK+aLXf7IAAQGT9kpcQjUA//C9TO1nW5nQQ+lsfA=;
        b=HHI7V9VWxdEm2ldMnuSEETf9TtQRRvw0u9IpAnbFdEDIldH0obuMMaRec5Agi5HTUa
         5IW6bcvigEZ8VrczojbBgrCbpZx2BecDQoam7fTeIDEgcnUem6nskJgAs3Z2oqzXxqID
         fI1giGDh1UEvzwuXJqe8vE/Ffyw+loocGo/rm8EmKNGyoz7QnMWQzpbYZ0x4/Rwpev8I
         FE2xzCTqbj/+xYrlcb4PnJZVB0DNbOv0IulMGdy/Yifvnur34UyvGrDqYU5JeqHGz00R
         O3LewDnqlT66dXkbyGQk+3uviMvG6EZ6SgIRA8KX1hSAP/JykmwXkxfDQls710u+6arZ
         CaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfLZK+aLXf7IAAQGT9kpcQjUA//C9TO1nW5nQQ+lsfA=;
        b=MZjThgS0xJDkLFXIo1HVnEpWwjttPKWk3sgsCxetQ28wynDqsjd04Ep8fdpmQpROEN
         l2dLjbjmwaPv7nHvUYKPdhIYpg44khtPgapk6sg+w1AaJmnni1BTIsv1gJQHa8P72JFE
         3uKcl4c3rAyOtNwug7Un1NHiLJo0cmV/nb5P2JtYU8A5z+aLPttzrW9wdUqJX39HcAN1
         NoidcwWq6IUPd0N8kpcEaf7C8+yQ9yar+szo5CSiFk4PptU0sFCJT3If89tygbTkLM/W
         n/J2uSJ0OvCyD/GWad91Mrb1BqpfOORzuWG+bvbWR3/biS406Gj8NvjWQnrpHxZSNDFi
         J3BA==
X-Gm-Message-State: APjAAAUqo0Ug1svqnXhDEFO81lCcDjO4J3bLGMEYJoGjxoXQxO3cPR2g
        0tm+pVPqNz/UpRFzgIOe5FfTFw==
X-Google-Smtp-Source: APXvYqxD9JIaAO8mg/yD2uQuL4bLr+ORAdUW5lgxOkILCPRyLV+UcWdOnX80lXIzt9mo7IA3xJko4w==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr3274136wmc.151.1565702400644;
        Tue, 13 Aug 2019 06:20:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d207sm1225341wmd.0.2019.08.13.06.19.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:20:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:19:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] video: backlight: Drop default m for
 {LCD,BACKLIGHT_CLASS_DEVICE}
Message-ID: <20190813131958.y3fgzeeuzhsfddbh@holly.lan>
References: <20190813115853.30329-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813115853.30329-1-geert@linux-m68k.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:58:53PM +0200, Geert Uytterhoeven wrote:
> When running "make oldconfig" on a .config where
> CONFIG_BACKLIGHT_LCD_SUPPORT is not set, two new config options
> ("Lowlevel LCD controls" and "Lowlevel Backlight controls") appear, both
> defaulting to "m".
> 
> Drop the "default m", as options should default to disabled, and because
> several driver config options already select LCD_CLASS_DEVICE or
> BACKLIGHT_CLASS_DEVICE when needed.
> 
> Fixes: 8c5dc8d9f19c7992 ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8b081d61773e21eb..40676be2e46aae61 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -10,7 +10,6 @@ menu "Backlight & LCD device support"
>  #
>  config LCD_CLASS_DEVICE
>          tristate "Lowlevel LCD controls"
> -	default m
>  	help
>  	  This framework adds support for low-level control of LCD.
>  	  Some framebuffer devices connect to platform-specific LCD modules
> @@ -143,7 +142,6 @@ endif # LCD_CLASS_DEVICE
>  #
>  config BACKLIGHT_CLASS_DEVICE
>          tristate "Lowlevel Backlight controls"
> -	default m
>  	help
>  	  This framework adds support for low-level control of the LCD
>            backlight. This includes support for brightness and power.
> -- 
> 2.17.1
> 
