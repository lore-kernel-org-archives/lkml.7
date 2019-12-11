Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FAFC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488E9206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtyeG8Rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLKAo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:44:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32897 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLKAo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:44:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so15320639lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vxe3R5EVIXOlzXfg/ekg4fF+ZY9IvaW7g6YuHiA6CRc=;
        b=MtyeG8RpnpRGMdHyeEPGILjfxKzcweWjFHPnZnPKGrFC89h32clJMupq6IVPMFKjIj
         gOeCDnC7nFYvShxcl11BGmqnpkE0ipUZXu3xM6Jidjp1LySuANUWWCitzYibKMYfvWG1
         X1dvYxmajrxJPXeE9qG5K0USO0k/bPEeJpx6HsPEPGy1Vl6tmElflipIQZNvgvcRDfEz
         SYDSjIP8HkM6mjRFvP1HY5WnFHD4ZK+w6bTmrXu0iRwf6dpv9ylEpnrlCFSTeWitv/IO
         Q7peiKQcOi7HYEcvYEhxZSQSrV0XcqSLQtkL7vje6t8GWlJruym/eFAOowG1osU80Onk
         +0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vxe3R5EVIXOlzXfg/ekg4fF+ZY9IvaW7g6YuHiA6CRc=;
        b=c+J5h5REm9lbojNZJIL2ukGdZElAz+rdIsfNo8WmUMCE3mK6sRlVAjZNDMIGhm5H5u
         mFPV3goas9EsOxChEX1ZWnCKvGefNMLJNIz3zBUquGCeO+mPWKXvJJYX5gH8zL6Ns6Pa
         VFenzu+lcizyV17UdmdCx7Up1jTpRQ8pp4xrGI4HtmHfAAHDDCRYSbVmMCUhhUUbAYGn
         TyYRLE432j+a65Xxys8nQOUw/G1kHzdGAoEGso/6mkUfe/MHLMcqlpLSSYN2V6wco7U9
         MCUr5YVkrxI/B4ub5OwHG7LtktoYcCk8g0Wh1oOy/pbUtNWpsMDv5bR+vFakQu1DhI4g
         EHTQ==
X-Gm-Message-State: APjAAAXrYpjl0EoSCZZpaasdtphoJHSVHPwJZNm50H8+pUaXP7cZzU/2
        Ad3kAJCsVg4u72ds/sl1JX8yZ0fjgKuWcPt7TSw6IQ==
X-Google-Smtp-Source: APXvYqyzkVpMJI7AkzWZi2reeD8NSrXhhAftpTMTQWujAo4UvyYRUUGGNKIP2kxrZNb+IPDOetsu2JxL4GfMINwTvD4=
X-Received: by 2002:a19:c0b:: with SMTP id 11mr408358lfm.135.1576025094524;
 Tue, 10 Dec 2019 16:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20191205212501.9163-1-jacek.anaszewski@gmail.com>
In-Reply-To: <20191205212501.9163-1-jacek.anaszewski@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 01:44:43 +0100
Message-ID: <CACRpkda220vtWPRkkKX+gSPsTuA+VjmKhCDTn8ZeLrkrLd3u8w@mail.gmail.com>
Subject: Re: [PATCH] leds: gpio: Fix uninitialized gpio label for fwnode based probe
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 10:25 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:

> When switching to using generic LED name composition mechanism via
> devm_led_classdev_register_ext() API the part of code initializing
> struct gpio_led's template name property was removed alongside.
> It was however overlooked that the property was also passed to
> devm_fwnode_get_gpiod_from_child() in place of "label" parameter,
> which when set to NULL, results in gpio label being initialized to '?'.
>
> It could be observed in debugfs and failed to properly identify
> gpio association with LED consumer.
>
> Fix this shortcoming by updating the GPIO label after the LED is
> registered and its final name is known.
>
> Fixes: d7235f5feaa0 ("leds: gpio: Use generic support for composing LED names")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
