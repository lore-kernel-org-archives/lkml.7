Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F59C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC073206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZZyv8KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLPMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:21:51 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36219 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfLPMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:21:50 -0500
Received: by mail-vk1-f195.google.com with SMTP id i4so1553475vkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Osz9VkIv77cDwS5TcCegl7t+g2vcc4c6bR2gC0bBTE=;
        b=DZZyv8KM/AkMijIzHa1GdiQtmMM5jFO5/iApv4ZaWBvNM353Ymxg2+pnW5EC9h1d10
         raOcV/4ZpE2mLiy9niImgy6S2uIbA8AxH7zU77oNYUJK5xvF07asZDBu2dJQL1Nt3X8x
         6HN96msV5Xasoa7rvuf7T9sxjtSopJk43dVkSSJ1RkjWKxqXtfKtVaWoc6wECXGLbsW6
         +5KQFjSFWGoSMFLp4WestwfyV+ESb9MvghUFcvSOF1K4p1gyWUHq00PnIs22QsYnLQ66
         zzcsQnc5XGu/COfqK2j7KirCwaIBS0mSgbm1k2K1q1CxtYxlAMMyEMywAX2JwUw3AoxK
         cEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Osz9VkIv77cDwS5TcCegl7t+g2vcc4c6bR2gC0bBTE=;
        b=RJ2CSFNq7Ym859sRNBJCFoXaeCw1sa7tWQPA+sA3fdTQZ/kQJK8eVsv3zVgO0Afl/q
         vjuiGKtM59YobgGqNDf2bbOMPO858G/Ae58jhR9+ti18th97w/OoeztRH8nciYtiRLcH
         UlUVyxnWDcixczkXhEyeSEcCtGD7gsLNAioqRpNzL8CrJBPhvxmL44sVcDaT/9E2Im3n
         u4Kd/NyJ6nl+95GRas4KkN9sLMwklRLZ06B7+doNcbbI4b9hpKXf2dTLnG3oj1b2A9J5
         n0AsPahMEdjyLH+5vA1C5Or+dOK2ELVHCEmyWwDihcfLC5rR8XCzdVC2NET9V4dZPuOu
         hNzQ==
X-Gm-Message-State: APjAAAUoNar4//sD/ztSny5ie4A1MX1lnbemEPoRuPxD60ZNoyHVmCF6
        vCuf7ogyzTaN/W9JqUSz7dE4bfQVFKHA7U0AA+E/0g==
X-Google-Smtp-Source: APXvYqx0xjbvyReO9ph3sJ/hbSdKSuPIz6dCp5eLmtjvK0OiHzZ5p261fyvWyE0OL/9Yo5d+jJByHNJNcdJ2/e/Yeww=
X-Received: by 2002:a1f:add3:: with SMTP id w202mr2070054vke.30.1576498909436;
 Mon, 16 Dec 2019 04:21:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
 <f34765b5cb4e949c2e85415ded3d0ee7736cc97b.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbUS7WeQ7OoTtjGnB7L=uhYncwwcHxkJ1Uj6GqYCGNGJA@mail.gmail.com> <812acba9df70c4bb6975580c7965b61e923a3a13.camel@fi.rohmeurope.com>
In-Reply-To: <812acba9df70c4bb6975580c7965b61e923a3a13.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 13:21:38 +0100
Message-ID: <CACRpkdbi9AhGnG3hBwXNQV9foK=JNBH8WUNvXZVxbEX4LyDCig@mail.gmail.com>
Subject: Re: [PATCH v6 10/15] gpio: devres: Add devm_gpiod_get_parent_array
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 9:59 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> I dropped the run-level support from regulator patch (for now at
> least). This means that I no longer have GPIO consumers needing this
> new API in the series.

OK I dropped it for now, we can add it when needed.

Yours,
Linus Walleij
