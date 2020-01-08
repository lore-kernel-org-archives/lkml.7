Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D288C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C3C20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TS8kRNJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgAHRGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:06:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40493 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgAHRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:06:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so3000147lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZG5mwCvO/8hHzDnaJkWUXAlThWqWwO0oMCIc1jFVaF8=;
        b=TS8kRNJ63oRSoj916IeOJ0PSYySbhpJVts40N/G6X/Liosb+K6ymAHraHW/2+OH/67
         e3eJjovLYr3Ci6qG5WYWYT9rkVkqlI50jkBp3TP9GZRr2Oge/dVfEZaCDebNkdcyLppo
         haAUiiVrcK7Y56QF9jZ571DcYLvG2NInKbOja7r62OAi/VqD7dt04zVVIFr8iE533lwp
         AoTpiaJHNmxiLeGW0U08Rd0AZYoiqtEVqyQrTZHhXEIQbE3rCqdVjgisd27wysNXFasU
         alVEi0kDrmLKaKWG1rBKga3afcDzjQrT1vO8vYiBRztodkPw73R0gKFEfOlvIP5IBvqb
         STsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZG5mwCvO/8hHzDnaJkWUXAlThWqWwO0oMCIc1jFVaF8=;
        b=dHCDm6eYVVKacJotO49H8iCm0fPL73A6wR9Ajq1grvtujiCmWEUFXWGlx2VjaeTH26
         LDweDLbvl90gaHb/zLWeJhlP3B1qhZTnfAu3sRDo8YqslVgLfzsp00FxxJ09Fu6NpY+D
         Y8GD11DRQ2uRfpbqEwPzQRbF51X9R55XwxBAqFQHGUHR7VwX/+lNdtd0ygJdqWN33b9q
         Zxs1CWi8Eitau16GNT1ATI9EuzXkrOVu/r/5+OrGAA4xGjqeqCfkkBCgzPgEuzD9H9jP
         X97aCYjqhlTHy6Sjsiuy1HKQsIGBVRbeoA66XP4NHab30RUodlzFuZAaCCqYZROGaNm2
         08SQ==
X-Gm-Message-State: APjAAAWVubZ23+Dlq91bIuUL+c/tDR+nqKK7gKc8JN5WJjg42/TWWx9w
        DsvD0lewS+Htj0bbxtN1qLDLbRhK78d4RxlTVNJAaA==
X-Google-Smtp-Source: APXvYqy4CrhXJ4b/8g3RMkCam7ca/MhZfkbfOrlpD7xBB9Cw6TsTScAGa+ViToMmlgE2pl5ieDU41zioyn0u52uwhcU=
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr3376017lfr.5.1578503182554;
 Wed, 08 Jan 2020 09:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20200108015322.51103-1-yuehaibing@huawei.com>
In-Reply-To: <20200108015322.51103-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jan 2020 18:06:11 +0100
Message-ID: <CACRpkdYz0UwAj0Ncs9SKWbN8vN-5E14GHL2KkANMb6H5OqEW7A@mail.gmail.com>
Subject: Re: [PATCH -next] leds: leds-bd2802: remove set but not used variable 'pdata'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 2:57 AM YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/leds/leds-bd2802.c: In function 'bd2802_probe':
> drivers/leds/leds-bd2802.c:663:35: warning:
>  variable 'pdata' set but not used [-Wunused-but-set-variable]
>
> commit 4c3718f9d6a6 ("leds: bd2802: Convert to use GPIO descriptors")
> left behind this unused variable.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
