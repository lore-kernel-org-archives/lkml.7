Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BBB2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTaTRPUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCEHtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:49:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32944 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfCEHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:49:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id z23so5475675lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSiSFvGkiOmapjm2KoeSbhNtRpSk54DNnf01ewQD2ec=;
        b=dTaTRPUEhaXAndF8SdsHGPH4aUkAED/Lnfd5VlmitYiXDKzXEjHS61250y7gwfqogL
         oOw9MKpqU6MbHIGBm8dsJYU32mk7ZzGFCBHUQV0GWK3YiwY74zuSuuv+3EStIMDeNd4e
         7fgXlvP11QSV13nUw1scZT6vWBlXlU8gR7bYMCuxqnjkvtraGwuDR+jYoR1/JwqEqFVm
         7yKAR+uiN5ftZ0Xqw0gI47I1S7qbNQFtVdg9S7tq+FGrxRzVc18ujZtp+0Mw6yjE4dvD
         Q+GmD9GaOvcTQgV/NFenmrMTc/zXbM5DFu7QPV0FYcXozivY2VArT7miOAz1ShIXOD6k
         Py6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSiSFvGkiOmapjm2KoeSbhNtRpSk54DNnf01ewQD2ec=;
        b=U0rgEebSba6UwerxF+DExeyrgp+fDX86iVZT3zouPmNy30PQpuSs7o4WM1vm9hiyt9
         1vuVqj6PMLrXBCtZK4wtg0MUd/nQeXcjWY1B1mZ0Ed/rp4K6y56WVI0YxFU6QMwQMmd3
         upqpBiS8W64Q7gwIofgkp9XSOv8T0YhWvxgWtrR7C5vNIrt6iWUCXJMulzuamBordUYt
         D8La/JFlOVmvPuLGwueJIfbNX4ZfcDU/PcUGreAg2+t/NJjiGSGjNiRhdGOpk76bWnMi
         jKEgsmJfme2bND64Yb+zwUek2Cod/Xt+Z5DR/ncECv8VdCOtAV152ZisQCgondBXg16N
         mNtA==
X-Gm-Message-State: APjAAAX9mE9anK+W56FTDUy1BWFN5Bs23KixNHdpkqQqiNODnl5bJHrR
        D0AZeHjzIPotPLXGG8YO2A/XKdXPMoZ004Yivy2nOw==
X-Google-Smtp-Source: APXvYqwLS+50EffwDm50/GZj1wxtqUHxQqpa+bRTfQUD9jAmw7kv3zTvdvwligVEGdL+goWOxwoq+fbf+VGZ01NujQE=
X-Received: by 2002:a19:ed19:: with SMTP id y25mr7013234lfy.51.1551772154322;
 Mon, 04 Mar 2019 23:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20190304195734.1070109-1-arnd@arndb.de>
In-Reply-To: <20190304195734.1070109-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 08:49:01 +0100
Message-ID: <CACRpkdaq9YzFSSXp7HSOf+RC2PGxv0N-m+iV99tn-0xTeEZr=Q@mail.gmail.com>
Subject: Re: [PATCH] Input: msm-vibrator: use correct gpio header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 8:57 PM Arnd Bergmann <arnd@arndb.de> wrote:

> When CONFIG_GPIOLIB is not set, we get a couple of build
> errors during test building:
>
> drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_start':
> drivers/input/misc/msm-vibrator.c:79:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>    gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
>    ^~~~~~~~~~~~~~~~~~~~~~~~
>    gpio_set_value_cansleep
> drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_probe':
> drivers/input/misc/msm-vibrator.c:176:26: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>   vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
>                           ^~~~~~~~~~~~~~
>                           devm_gpio_free
> drivers/input/misc/msm-vibrator.c:177:13: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>              GPIOD_OUT_LOW);
>              ^~~~~~~~~~~~~
>              GPIOF_INIT_LOW
> drivers/input/misc/msm-vibrator.c:177:13: note: each undeclared identifier is reported only once for each function it appears in
>
> This is easy to avoid when we use gpio/consumer.h as the documented interface.
>
> Fixes: 0f681d09e66e ("Input: add new vibrator driver for various MSM SOCs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
