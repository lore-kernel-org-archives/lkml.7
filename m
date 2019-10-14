Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A70CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3FA2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD7yH42N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfJNIM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:12:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51654 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfJNIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:12:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so16193412wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+deUZXsERBoIwuF8w37rkTqOJuJ0YNPkmp+VXhLAItk=;
        b=LD7yH42N59JCCaLRFfXRFerOH8rkSLiF+LkhxjTWD8eNTeij5IMQn1woDobFZE2iCw
         T7PRQ5NqIOzxbidAmveDF27g/uRI4cYMXqKO/PiT6vh6oSEh5FGBE6Qpt93GBWqnaEGH
         lmBXwIYnLtN3udyc40lT+rQqfc2okHAYI2K6oBmuKA/w4jSTcX3jV3q0ApsAULz+4gmY
         VlAEmK5rk0W33jfbswlq2l3XI2DuvEvHpgXpf26c0IXqlDSe7GMgnINcA03sbbgoQM7N
         T1vcoiZ56aqBt+IXEp1ThrluAiAOm+Bm/XI852XhW4XdnC238NJb/RqDGBbxXyCEc5Yf
         dWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+deUZXsERBoIwuF8w37rkTqOJuJ0YNPkmp+VXhLAItk=;
        b=Wm7WG3h0qpqlicOWgxpWIfLmyOFkqY+ulHgF9st/Jp1oO375tHyVl9TT77yYzNRYzG
         uNNeyICwlXyDJfdtTA87Z4tgDDV5ZsX8HIAqp6KtpQgILzA7jJZcj14NLcgdKIGWOfRi
         8ah1J3lidaVAMqW8e+CWifcZP5rbTbtUjws4q1yWAv2ZbOOnHh7Au2uqs4NBONJKOGKS
         vUskr7xN0U0DWbu9MssqiFATP+Mq/FnLxy2aOvkkMb/CTZgBtLa8SVZNb4gzeXHqtbCM
         wWMBhGmtfW9PpSNXxMrpPruxrgiLYFHkW1j6Ho77/YmPrGNRrBlOER6aU+Nlwd+nk8sS
         Prkg==
X-Gm-Message-State: APjAAAXzJyonQzywvDAJt0no1f1Ffhj22OJSyTSW8tuSvWOT+KoqM9r+
        uzNTj4wOlYOpXR98Khe24CRH/w==
X-Google-Smtp-Source: APXvYqzzMPmMnU/mdIbw3oXsYhkR72iWEBpRtwUxn8lSxoffzDIn8VIjfySG7MOoXzNCS5f6xEQ2pA==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr13965770wmj.2.1571040743235;
        Mon, 14 Oct 2019 01:12:23 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id c9sm16087692wrt.7.2019.10.14.01.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 01:12:22 -0700 (PDT)
Date:   Mon, 14 Oct 2019 09:12:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
Message-ID: <20191014081220.GK4545@dell>
References: <20191007033200.13443-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191007033200.13443-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019, Bartosz Golaszewski wrote:

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
> v3 -> v4:
> - rebased on top of v5.4-rc1
> - removed changes that are no longer relevant after commit ec665b756e6f
>   ("backlight: gpio-backlight: Correct initial power state handling")
> - added patch 7/7
> 
> v4 ->V5:
> - in patch 7/7: added a comment replacing the name of the function being
>   pulled into probe()
> 
> Bartosz Golaszewski (7):
>   backlight: gpio: remove unneeded include
>   sh: ecovec24: add additional properties to the backlight device
>   backlight: gpio: simplify the platform data handling
>   sh: ecovec24: don't set unused fields in platform data
>   backlight: gpio: remove unused fields from platform data
>   backlight: gpio: use a helper variable for &pdev->dev
>   backlight: gpio: pull gpio_backlight_initial_power_state() into probe
> 
>  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--

I guess we're just waiting for the SH Acks now?

>  drivers/video/backlight/gpio_backlight.c     | 108 +++++--------------
>  include/linux/platform_data/gpio_backlight.h |   3 -
>  3 files changed, 53 insertions(+), 91 deletions(-)
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
