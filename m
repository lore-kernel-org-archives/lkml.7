Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EDC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A5221874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bt1VuYPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfIBJbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:31:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35593 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfIBJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:31:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so3143020wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r8AwJSmMaHIEN05eTIkJ4SIO7fhuuHmNGUIve5f+2G0=;
        b=Bt1VuYPsJX1pxqRR6NEEzZF0cAq3QqZSMeTnegdO8wAJVFRb/Jr0Ly4BgdgOysPSWb
         IZVVibSQpS0gOBIr0OUQUsZUwFVf97qS4uto28oZHVLLEWbqLvQ/+C9xlwxydZuudplm
         81UaLsko8zsLIGQXBw/VgDV7HZkHqUWUkEUWbs1UvWxFqMMsnxf+J2SceviM8fe7Ws7D
         QYXzlFLYLoRmtUnbMXQLOVXJVHdGzIcoMqNyU2TC4Psa6PULLHTj9RdtGxZtxSu3bTkm
         cnU2J3ip/ZBkcrqgo6YoEsJv/uU/p04nUgNpCOBqikubhWlYP2WpFFKnrv4ETvEbbXKA
         p5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r8AwJSmMaHIEN05eTIkJ4SIO7fhuuHmNGUIve5f+2G0=;
        b=c+CVNcdKNpMrutGNEMuKX1aHnotfAsSCkY2TucfndGXhgfVG8qbdVnAhmlEEK36TRU
         3AmNdPXAeXHNHp1OGHEfUOURHjLEH3ASjhhEo8L/+wOlefXs/IdCX/bhfNGW8ifBxsjZ
         oX0huXnj9qnwDMPWKK4LPwvDai8B5wErhBuQQhTr5DVTA9fyRVQZi6F4iaFZIfezUgok
         qAPsdwqRV7Ev7P4R5qKrIp/9D1DKtjsELJQSTZQQ+tIgKWlPQGIU1lfqXZEDxf+swpPi
         rLPphqddIT9PgZ5eKRhrYPwB6MN3djztgRLJwmP+2BiLgPk54nJOsDaoUOpLeHvzJiP9
         CPSA==
X-Gm-Message-State: APjAAAXQabKRFBypoZXUmBhflkF8RQjx1q8sxtNyRwJoGEa8ukjCeHrx
        OO0Xgd5cQjBfrpfXoC7i5lQpsA==
X-Google-Smtp-Source: APXvYqwSoSdzmSThKSMRUEmWnqBIzy3JLEQjsMsy3WU0XrIZvapOFxa+yJldgHFiQ3VCIhTfJdp9Wg==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr33287131wmf.140.1567416699794;
        Mon, 02 Sep 2019 02:31:39 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id v186sm33030150wmb.5.2019.09.02.02.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:31:39 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:31:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
Message-ID: <20190902093137.GI32232@dell>
References: <20190724082508.27617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
> 
> The first patch adds all necessary data structures to ecovec24. Patch
> 2/7 unifies much of the code for both pdata and non-pdata cases. Patches
> 3-4/7 remove unused platform data fields. Last three patches contain
> additional improvements for the GPIO backlight driver while we're already
> modifying it.
> 
> I don't have access to this HW but hopefully this works. Only compile
> tested.
> 
> [1] https://lkml.org/lkml/2019/6/25/900
> 
> v1 -> v2:
> - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> - added additional two patches with minor improvements
> 
> v2 -> v3:
> - in patch 7/7: used initializers to set values for pdata and dev local vars
> 
> Bartosz Golaszewski (7):
>   sh: ecovec24: add additional properties to the backlight device
>   backlight: gpio: simplify the platform data handling
>   sh: ecovec24: don't set unused fields in platform data
>   backlight: gpio: remove unused fields from platform data
>   backlight: gpio: remove dev from struct gpio_backlight
>   backlight: gpio: remove def_value from struct gpio_backlight
>   backlight: gpio: use a helper variable for &pdev->dev
> 
>  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
>  drivers/video/backlight/gpio_backlight.c     | 82 +++++---------------
>  include/linux/platform_data/gpio_backlight.h |  3 -
>  3 files changed, 44 insertions(+), 74 deletions(-)

Can you collect all your Acks and re-submit please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
