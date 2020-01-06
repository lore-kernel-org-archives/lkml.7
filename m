Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3282AC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D1220656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6EoJUPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgAFIph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:45:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:45:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so48744311wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E+ZsR7Z6Or+Q9BNSYlv8m9k1i0fDEt4sNmLSr2qVLrE=;
        b=b6EoJUPx4omgCfCytDHI5M/8GKVGW1pS/Q0ukuUb7HkffVkKyEWFhHUwnA4PXQB1m5
         qAUBj9pMGqUSqG4+z/oaABcxhRaKjqTHoqlJkl1X/pWm++WDEUh6zRHoz2qPVNU28txW
         kyvLH3wU019LV43vRa1wHHGDYaMIpm0Xt2B1Z2u7WT0FnwzkeDDFea6m2Az5EuZ73VaY
         iHoRWNHfEGFXf3eWklrzVDg4SX4+I2OI74ZuTK4H7grXGv0dj19Pds60dYhLIqIQme9E
         zaIZfiYyscy0y1Y3a5N8RLfshXOorElBxVojEvb9ruo0GAXpDWGysJDhxOx6hInEaopG
         ZPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E+ZsR7Z6Or+Q9BNSYlv8m9k1i0fDEt4sNmLSr2qVLrE=;
        b=c/mjVZmZjGJnbGUr4kwTK+xky21hZWQhQmrti44YJcFsL3mWByJYFNi15S05bHlSG+
         arZu6yqD93n7XpqxHsqNnQaX0DP3M7t6TJ0k7RN+9/QLkgqiFubKvaRHoKLM6S2HsIJF
         ZLNZCohrEzBIitg22hYAH4mc7jG1HF69MMl1jGIyRdBtPUcZPOb3gCEdfeqZ7ZMf5lVt
         OHYh8er9z01NeT5pLk7d1ODdC8SW9X5LEeHNR+cThc+x7RZQ0b2XZohjZFQNNLvWfvUX
         iFkXEc6g8gOspD4VivmiiEF0NiQBMtKARIbz23Vm7RxboOCbwjnz2K/Fs/BYlXMJSX32
         8Ndw==
X-Gm-Message-State: APjAAAVmdQxGsE0wSohvtYcxeQ2u8Z9fxmCe/wwLnGTV7mhX2MLPFuW7
        eprEUTaTiSdh8908WjSpZEuYNw==
X-Google-Smtp-Source: APXvYqwxcQQlcWtECdQoOFeMi0PnZaRKIl/UK7OQlM3noxtNGd+dNEVLfF5LUtq5jrb7KMBL2hK+Yg==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr100885486wrx.39.1578300334744;
        Mon, 06 Jan 2020 00:45:34 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id q6sm76176240wrx.72.2020.01.06.00.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:45:34 -0800 (PST)
Date:   Mon, 6 Jan 2020 08:45:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, agx@sigxcpu.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com,
        jjhiblot@ti.com
Subject: Re: LED backlight on Droid 4 and others
Message-ID: <20200106084549.GA14821@dell>
References: <20200105183202.GA17784@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200105183202.GA17784@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jan 2020, Pavel Machek wrote:

> Hi!
> 
> It would be good to get LED backlight to work in clean way for 5.6
> kernel.
> 
> As far as I can see, these are neccessary (but not enough; it does not
> work for me): lm3532 changes to register LED with of node, plus device
> tree changes for droid 4, and these generic changes:
> 
> commit d457d0c97d6d55fe3e62633791ac05d289a37d2e
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Thu Oct 3 10:28:12 2019 +0200
> 
>     backlight: add led-backlight driver
>     
>     This patch adds a led-backlight driver (led_bl), which is similar to
>     pwm_bl except the driver uses a LED class driver to adjust the
>     brightness in the HW. Multiple LEDs can be used for a single backlight.
>     
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>     Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> commit 44b7adbf0b07904e4198ae1d0a763917d1c68a23
> Author: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Date:   Thu Oct 3 10:28:10 2019 +0200
> 
>     leds: Add managed API to get a LED from a device driver
>     
>     If the LED is acquired by a consumer device with devm_led_get(), it is
>     automatically released when the device is detached.
>     
>     Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Signed-off-by: Pavel <pavel@ucw.cz>
> 
> commit 93b98c570d7f898063ab6204e1b3950a3335dd12
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Thu Oct 3 10:28:09 2019 +0200
> 
>     leds: Add of_led_get() and led_put()
>     
>     This patch adds basic support for a kernel driver to get a LED device.
>     This will be used by the led-backlight driver.
>     
>     Only OF version is implemented for now, and the behavior is similar to
>     PWM's of_pwm_get() and pwm_put().
>     
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>     Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Signed-off-by: Pavel <pavel@ucw.cz>
> 
> [If you have an idea what else is needed, it would be welcome; it
> works for me in development tree but not in tree I'd like to
> upstream.]
> 
> Lee, would you be willing to take "backlight: add led-backlight
> driver"? Would it help if I got "leds: Add managed API to get a LED
> from a device driver" and "leds: Add of_led_get() and led_put()" into
> for_next tree of the LED subsystem?

It looks like you have an open question from Tony on v10.

Is that patch orthogonal, or are there depend{ants,encies}?

> It is kind of important as, well, phone without screen looks pretty
> much dead, and same issue hits Droid 4 and Librem 5 phones at least...
> 
> Best regards,
> 									Pavel



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
