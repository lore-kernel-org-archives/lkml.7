Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A96CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A0B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3cX8WuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfJUKfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:35:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfJUKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:35:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so2074018wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCC2K+1Phv+hZCvepsAaxz4dYzO4ZQaseMmOK9Alp0E=;
        b=t3cX8WuPKhyW/BpGMRXewuy78R7w/7zHRJAn8p3dQKQhukExp9KXRyiHQyZRTZgcFr
         0/pl5MrCraK5WBczSBLwEjUlqJTKVoS/g+6NITgaiFUHaA7IbHUBno7wgha+PhK8Ezmj
         5mJSHCJmisfZGWC1TVJG+/bomIXUOeCqAXrKt+0YDkAEWgYrCiIUXsZ8c30JsZpVc/uW
         2F25TYKY7ZnPOQ/WQe6pOp9mAEwYaNyQVo2o5NzhBoPbgVKO/CdBduSVc9MBnP5TSM6f
         VLUNnsx7qaQ2y3zEpnuF8EUCKoY7Wl+T/mPi5QVjgndd4zTXy2aXSO8Y1CRecvEAspBy
         D7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCC2K+1Phv+hZCvepsAaxz4dYzO4ZQaseMmOK9Alp0E=;
        b=g4pHs8V3Q2rs0hR/nweF4kRHxUXefJtRhqt53WunmrvEyMGFy0RC3R3mwlJs7ssk9a
         8Q66fAu5v79iAAIswb6c0AdMsddAqWInyW4dE8EqhfJZUpFpvP5Cov54zVbgR2NBAfZf
         v6T0EkJQhm1g789va5/gA3ic6ksuZYpYQFpyJyD48hx9UHq+LUb4s7XjEHnyq+aHaaka
         gMLL+hUUgv9v5izHh+IRq6CvOufWU5Pq6gPEAQNy1Yc4p9decOMLPWcoWq9MwL+uUS7R
         gMcbYvK9ZgZp4jtqqJ1icUkVY1xIaZC5b6ePwW5GKMUgwhSoFFn3Vb6Ev191Ha8QYoQ6
         fbtw==
X-Gm-Message-State: APjAAAWNsCKMsJayx/hCWRjMM3MQnkzvYJehUPQz4U5wUCI9YtsrBNGz
        dqgPHARHFCRI4wq63ThhIyAIxg==
X-Google-Smtp-Source: APXvYqwzq4W2hoqMGfXD+SnL4v4XRwsU52eKiLQU7E1OuYqmacWEauu7fUOpM3T6jtW1TY+PYeZ8Yw==
X-Received: by 2002:adf:92a5:: with SMTP id 34mr18183433wrn.337.1571654139130;
        Mon, 21 Oct 2019 03:35:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c18sm13475121wrv.10.2019.10.21.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:35:38 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:35:36 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v6 2/9] backlight: gpio: remove stray newline
Message-ID: <20191021103536.svhda5kmffhm5hjd@holly.lan>
References: <20191019083556.19466-1-brgl@bgdev.pl>
 <20191019083556.19466-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019083556.19466-3-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 10:35:49AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove a double newline from the driver.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

(wow! that one was easy ;-) )

> ---
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 7e1990199fae..3955b513f2f8 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -91,7 +91,6 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>  	return FB_BLANK_UNBLANK;
>  }
>  
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct gpio_backlight_platform_data *pdata =
> -- 
> 2.23.0
> 
