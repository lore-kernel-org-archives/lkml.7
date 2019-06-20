Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F5220675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcQ2LGsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfFTNcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:32:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51258 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:32:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so3120094wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s4mJvF/EBCi9urzBjDVk6HyByyO2EXSJJe+w8Mr6PqE=;
        b=fcQ2LGsvLhMHenQaR0fPJrheg/Ke4ddcB5Wu7YfIryVJUo9ToV0DrbYLLy5uEKt+Te
         2eAlQZaWMnmihwnpB4DJYMLeVliQetctkognWmabqg2/bsj8vtTQ3Wdrk+/7DO4VmNG3
         idw+XcIFBhIqZqB++Mw/O8IMVCpYutg5pJSVKzdMLiLzmItHKlz0b8OfrR7rtZ9kG3B0
         PKKZxH1aruGECIB8MkZB2p8I+nWXXn5inX9QgpLCSUp9zSeHDaxhypHI8x4Pe1hjvwhw
         vzzKpP408bHesT24rsySd1QPusV0TiHkwQeIkwFsr0iPxO7OVyk0/rcCLNTy7QcBcnmw
         lOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4mJvF/EBCi9urzBjDVk6HyByyO2EXSJJe+w8Mr6PqE=;
        b=s/BxE0HQR1Yc7bpBqf8EAXllQCDMzDZ9XFKjqzXQSe+9tYpVppawISzkB8Bl/+TAZ1
         hoHozAQjYubDuC3+ANYEYUolPCHgym0nB8mGdQNEHQiLbjikNjW/HDFaWPYveVn+n6I2
         GTFL0rM8nLcXLysz52b+kSv/NduW6JLYAaHJl2RXCq6cdGmoNxvKhUMgARLrl049XKnb
         FBl+6aAMsHBrl/JmnWaeKQKpXCSMFc7279FCux9ZreayRwO0jwA4DmXH5K43EWLe4dTP
         xg7MOAh8c7MyGFinNpxBaaknLJAQZUqj1SRSPMr6F9bLUVFdKor+wWS7XbekEops1ici
         Q0kQ==
X-Gm-Message-State: APjAAAWOR0KSPeRTABy8f1TW8N3vXCWgCDFHL0MCVYIfa1xW976B2gqv
        qVWqr7325MIQy2UneviMNfDO/Q==
X-Google-Smtp-Source: APXvYqyZ+XwqzkDzsOqDlRPJBWJqgVr7mKBJlSUjoZoLBHrCLh8eDBez55m86Gy5WHroG5f6vyKnPA==
X-Received: by 2002:a1c:cb0c:: with SMTP id b12mr2974917wmg.93.1561037520557;
        Thu, 20 Jun 2019 06:32:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id l19sm2782480wmj.33.2019.06.20.06.31.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:31:59 -0700 (PDT)
Subject: Re: [PATCH v1] backlight: Don't build support by default
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        fbdev <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Antonino Daplas <adaplas@gmail.com>
References: <70bd61f9-8fc5-75b1-9f32-7a5826ce6b48@free.fr>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <7958bf6a-5c2e-1330-1800-f9dbce3c01c6@linaro.org>
Date:   Thu, 20 Jun 2019 14:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <70bd61f9-8fc5-75b1-9f32-7a5826ce6b48@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2019 14:27, Marc Gonzalez wrote:
> b20c5249aa6a ("backlight: Fix compile error if CONFIG_FB is unset")
> added 'default m' for BACKLIGHT_CLASS_DEVICE and LCD_CLASS_DEVICE.

It took me some little while until I realized this patch is from 2005 
which explains why I couldn't find it in the modern git repo!


> Let's go back to not building support by default.

At first glance disabling this by default looks like it would cause some 
existing defconfig files to disable useful drivers.

For backlight I think this isn't true (because both DRM and FB_BACKLIGHT 
have a "select" on BACKLIGHT_CLASS_DEVICE).

However for LCD it is not nearly as clear cut. Commit message needs to 
explain why this won't cause unacceptable problems for existinng 
defconfig files.


Daniel.




> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>   drivers/video/backlight/Kconfig | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8b081d61773e..40676be2e46a 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -10,7 +10,6 @@ menu "Backlight & LCD device support"
>   #
>   config LCD_CLASS_DEVICE
>           tristate "Lowlevel LCD controls"
> -	default m
>   	help
>   	  This framework adds support for low-level control of LCD.
>   	  Some framebuffer devices connect to platform-specific LCD modules
> @@ -143,7 +142,6 @@ endif # LCD_CLASS_DEVICE
>   #
>   config BACKLIGHT_CLASS_DEVICE
>           tristate "Lowlevel Backlight controls"
> -	default m
>   	help
>   	  This framework adds support for low-level control of the LCD
>             backlight. This includes support for brightness and power.
> 

