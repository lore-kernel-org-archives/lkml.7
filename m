Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EA8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B782921850
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCzyNRN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfKDPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:05:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40115 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfKDPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:05:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so11439295ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UzsxUZvtQAv5yTZNCgAIyZvTbfcvOElCqD9Y1x8Cds=;
        b=vCzyNRN4s73hE44j//vz084Ojhi0V3RfoCm+wWuyesMKCgYTVcNIMm1zmzl/AVoMUG
         1u4+4Qeca5bRWcLRT+8xYc17wEHqVKkKignoqGjWL4d9getfO+0L9gDGrZLvUzAfT0jb
         F+f6wFtgwmTMhtJ8w8/GBF0zx8p/xVdyqpnhCAQTrUImUPKQujUPEWGx0HTMuMo55qQJ
         oFSzRjeeDhuf+lE65xn2fJ3KmEC0dDd9o7dghkqhoPzFfVLrRSJ44hPyacflpqsXTVxe
         Axu6mW+HA6ADnjQgtxSoN4lDE5ieQf3qhL/ZGNu+8kmqQPKA1K5WWRuOonjsEzoHMUhm
         E7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UzsxUZvtQAv5yTZNCgAIyZvTbfcvOElCqD9Y1x8Cds=;
        b=BjdLUN51/4U6C0wxj4iBkDjCFgKwNh2tc2YGG/loA7ThaTRu2FBy/XXmqg/1zHl9+9
         AKPLhwvj4A4xnm3AwYbHCgO+NK/zaTkfthqSvRz6dt0W/u5lOgUJTd9KsonusH1lLUtC
         79mG2R/In6mdnfjjZ73jC078DaEPMXyc5w+6u0eug4quCmVgDFVNTzAPOKUyXniuaT8q
         G/b5mmrjxkQd9nAs9vsxSeamrnN6Lj8F4MKpHulCEKtdmlVJXp69MjLj+D8SLWgf/HBI
         1blGibkUCFywZKPUv6YoC6Qgb5KSIpyxXE2av2Sz22Fk5TaHr74IDvryYQYx8dDRJaS1
         tGzA==
X-Gm-Message-State: APjAAAVHf42Ked/O0OmR4A3fuQiYFBRG0g9zQWY9LlMyQEk00yut8bvp
        xj/2xcN0kHbrVKGdOp/BydnqIApvrIzEEXXCQ1MQoQ==
X-Google-Smtp-Source: APXvYqws3TDQMt4oTHuaGCbLTVZBn1NqJZhtfLhI39uuuxwoVtmfNQM+7OO7GNGby5LOgL7nOpmlHxorL0t5iDxclEc=
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr5737529ljj.251.1572879945553;
 Mon, 04 Nov 2019 07:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20191022084318.22256-1-brgl@bgdev.pl> <20191022084318.22256-8-brgl@bgdev.pl>
In-Reply-To: <20191022084318.22256-8-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:05:34 +0100
Message-ID: <CACRpkdbGP6H=5R03Fi2LQzvYazke9Fye8bWNqoKs-4bEQroctQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 7/8] gpio: mvebu: use devm_platform_ioremap_resource_byname()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:43 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Use devm_platform_ioremap_resource_byname() instead of calling
> platform_get_resource_byname() and devm_ioremap_resource() separately.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
