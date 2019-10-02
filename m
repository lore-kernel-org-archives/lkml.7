Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EBC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA772133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYZZEpu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfJBMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:00:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40521 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:00:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so12529092lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sr94GOz0pdmFe8NPbOwLVU6p5EmhKwRfQwRJfRbnBs=;
        b=XYZZEpu74MT695K5Dhx/fEcUDe2G2eFTqT0vM+pZl4strKcLUGQ3PO4W5WWSVxueYL
         xelWz1hdlNawP22kgoRzj9+gri56rn4GqB2BzyyFyBo5wmMyFhTEsnWIpHJVg71Doawi
         X0UmzJ2Mg0sZHfbZGLjudQI7fiLTABciu0ckx66x6R7xiSKCO5fuWaMSTUW6PrAiHtWA
         qXsW2TsXsD+iH8Fe4lJWM9gQlkWrJ1YM3T7Hk3eA/l1lBEhX0turashSToMDo+qTRV0j
         EArNvVqF48LbX/WbJ3DoCu+mQYUp8glmcRPEUmIZi/vxLDpk2ipehTRQqN0ofY+uL0bj
         Kp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sr94GOz0pdmFe8NPbOwLVU6p5EmhKwRfQwRJfRbnBs=;
        b=KI46Q/cLKOttxfZRGYVd44Z/dq04JXZ2fBvv21oMEHCW5jx+7l5wkvDtQE0AJlW9Zo
         1LhHHMAqhwuuUgKw8zxj99zWl4G0cO4PFxYeOJvGIrokdtNFkR+H9aiz0nivtEgN53A6
         vhgxElerDNAahetDr5T6nhL31gdNv+j8LnnRSznsAufQj9s4D6TYxc/rKyie+KOKsYJm
         iYEj1NE/9WK4QgNBHm/hfFfS2JlHSKoQTK2dj2dB/xhsufsboIy8+WqzZBfgKu5hTb+c
         f2qCz3TSsfWziSNAG2OVgIfTofuM/D7R/9W5W4tXI+Mr71xpS7gnSzoudlDMFZAKi03A
         T3ZA==
X-Gm-Message-State: APjAAAX5akSq4nDdv8g1irE2c8sMI6wwMzLGlNwDfFPgrajcaZ+BM0ji
        sZEr8x+CgbBDy3fpbmwJXlKkW/autTAorvtEnwLlBA==
X-Google-Smtp-Source: APXvYqws7AaUk10K3J+WGNGa9aG6oOMKe/16UpknoRlkcmS+/JnmqWIQR5M1h0Xl7NN+bsfT58Bw3Xn6VFU0J6Gbf1k=
X-Received: by 2002:a19:14f:: with SMTP id 76mr2052115lfb.92.1570017625360;
 Wed, 02 Oct 2019 05:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191002095736.1297224-1-arnd@arndb.de>
In-Reply-To: <20191002095736.1297224-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Oct 2019 14:00:14 +0200
Message-ID: <CACRpkdaVhhGF-g_95zPg2wvXGcGfYG1YUVVuz5nOsRw8GwGQkw@mail.gmail.com>
Subject: Re: [PATCH] input: ixp4xx-beeper: include linux/io.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 11:57 AM Arnd Bergmann <arnd@arndb.de> wrote:

> asm/io.h may not be included implicitly, causing a rare
> randconfig build error:
>
> drivers/input/misc/ixp4xx-beeper.c:48:3: error: implicit declaration of function '__raw_writel' [-Werror,-Wimplicit-function-declaration]
>                 __raw_writel((count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE,
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I am thinking a bit about the future of this driver. Isn't it more
reasonable to just make a hrtimer-driven PWM and use the existing
PWM userspace ABI and timer framework in Linux for this?
Not that there is a generic timer-driven PWM but ... that is
essentially what this driver is.

Yours,
Linus Walleij
