Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873B7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uy7M4LUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDCQdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:33:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39246 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDCQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:33:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so15454487ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49LiaxgLCt2pzdt9ApMMcOcyaCZtDTqdHkb/0BnM004=;
        b=uy7M4LUnyZH5iWQabTMaM4vTBxDq5tgiHvX5BFp/5HE70BJg/0rnfYcDl0NeWfu2i8
         RCyyu9WWMnMU3PtZ43X/m99HpBM1teA11TdcCjzZlynfIK2rWjUNoCgcXXiQX6b/LTQr
         P78Qr8ftLKE9TXton/Y+05Os/OsePDYWYqUmS+vt4+MLi2C96ByVx/LrEKvLz+6FlABY
         2u7jT8cgBggl1I4XnQyUjluRAp4pvUILLz5muFyJz+CPCo0V9xf5nA6Rjg2/oNYODTVa
         F9HYB4WhkZrMvOK9e8xZayo/278BuDqLQjM5Qt3+Ltb8NHPFEBiKum4LkYDIyhmNlBT6
         Qiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49LiaxgLCt2pzdt9ApMMcOcyaCZtDTqdHkb/0BnM004=;
        b=s92Ln4yVY36ckeL8+9hxvddVUAF9vN0JwrIIUE4/lmynXCujr8Ozu+Wwyc1Z2DrD96
         lm2A9YMVVcb89RMJ9msJI2XQfFjnaJtAfGagZQhBeWsd9utWY6w3g/nuTeyDXZRy4MBe
         BVy/aqQcTEfQV/Ig8pGx1JScizrEmXfyG5+9fbISIM0EgM9lGHhogD8RM94mm7g/IE4u
         /aKkRb7HHzNjtERNkrNTiTaJnUQtglWmKBzvrrov/uNVKqYILXR9xatJKEfAhp1bEaAS
         42/oRfousRyB1la2eoYcN7IzR520NhG7JfYp2iMrmcyd0TSuFp3kBUY3ZuyEl101tTPW
         Sdxg==
X-Gm-Message-State: APjAAAUo4utmHHLhPtV3uq+KFJlL8+Tq7aBThZ2WHweoeURjcPKSG+EX
        kz0VvhoJmIQlkNIMjsbWwHQtvZBqCdmQSI+U/uH1QQ==
X-Google-Smtp-Source: APXvYqwn6SVIa5Ls2B3SgFR2MSdQ6zqtvl7aFfjk0GG96k23EkKsEwYsWkUN+T2m/oXCTHbz81Gge/0WpMxMqjnzo8g=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr411875lje.138.1554309196833;
 Wed, 03 Apr 2019 09:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190307103348.1591457-1-arnd@arndb.de>
In-Reply-To: <20190307103348.1591457-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 23:33:05 +0700
Message-ID: <CACRpkdb-x0wja_k7r_Dj0VO8E-TEE2_iebswBnvEoA-Ghddiug@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: avoid clang warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:

> clang warns about a tentative array definition in the gpio-omap driver:
>
> drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id omap_gpio_match[];
>
> It's best to just reorder the entire file to avoid forward declarations,
> which lets us use the regular declaration. To do this, the unnecessary
> CONFIG_OF check must also be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
