Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C3CC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5EB21A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HT2E7HWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKLKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:20:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43273 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:20:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id l14so13823460oti.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rjd1FS8nNm6yRr4WVn+HN8ZG0ZScPCeZT4lpNVe4Zbk=;
        b=HT2E7HWmfg4NPppXd4Z/N3e+10XqEJpkjLfqXexTfchGFx59EKIlflcB29Pvff1Ii+
         Pee1vLZ2acJeOayIkvQe1hyi56T6jI6nITcT9E2DBBnQq5J17t3acaq+8cyxRmA4k+fm
         WA46zucZtzf5PeihhI8Cp2UsziPgYvcqyd1YpZHDAe/RpWNEiIaddhmbc6XHTsTLMwGK
         hrIRhCGCg12VYvW1IsWdRWeFqQVf/n4WkoCKnbQ8LcdTIxaXkMjkxWrjnviserTeAkL9
         DarQ/kew1zKc/ZWhn4Ge8QJzrHzk5AEvI8rGEV4/4PKULnnxZybyYBkdT3ayUrli5Mhe
         b5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rjd1FS8nNm6yRr4WVn+HN8ZG0ZScPCeZT4lpNVe4Zbk=;
        b=ipDhKzOvYpp2u11H2jYhVe9HY6CUbcaywBBoc9I2NGSkDI6vTwF5Qa99Oh+52sERUt
         F9r8LLqRT5SQB8wlEYfwyQ4JoNcxy65oitDZdLIYOWjSMhGovwdueUhDZOM5oaibac+c
         dqk0B0jKLSfcA/yH3Eg+MTg8TXWjaLPp7QxSaBWnSQTeLONuiSFwfxAdlw/CUD5at5J6
         TN7s3WRc0AJDw+1HyLUBGkEQgqjPlE2bAcESBxrvqawXtkXnl8kMYCVEvCduhTKsD/S9
         AUt6TiURTqBAh129p89mIYCry6BAMfpn91xFFo1zkTvCzu/K1FWMn+dZhRiH7+S663gp
         /Uww==
X-Gm-Message-State: APjAAAWEMb0FoXE7m831/ZeFiRX4V0EbjuQiPhWqYHmAeceZTekA8llt
        m4ydjw5Q+Js4cQgt/oUgxiOLLzzB2tHmhpziMaA4Ww==
X-Google-Smtp-Source: APXvYqyJYU1a1wAD6RMTrT6g96ZtxZ7A8y0Kd61mPfdbLz15t3BIBUD3Ta5YCEivW+oP4c/yRxIQN1WJuUKzonHyOUI=
X-Received: by 2002:a05:6830:210e:: with SMTP id i14mr24546593otc.250.1573554016083;
 Tue, 12 Nov 2019 02:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20191108160747.3274377-1-thierry.reding@gmail.com> <20191108160747.3274377-2-thierry.reding@gmail.com>
In-Reply-To: <20191108160747.3274377-2-thierry.reding@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Nov 2019 11:20:05 +0100
Message-ID: <CAMpxmJUdqWzMJo0LMXudyzyoyP9TZyAA1t50GxG0DCL3aTBASw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: bd70528: Use correct unit for debounce times
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lis 2019 o 17:07 Thierry Reding <thierry.reding@gmail.com> napisa=C5=
=82(a):
>
> From: Thierry Reding <treding@nvidia.com>
>
> The debounce time passed to gpiod_set_debounce() is specifid in
> microseconds, so make sure to use the correct unit when computing the
> register values, which denote delays in milliseconds.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpio/gpio-bd70528.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-bd70528.c b/drivers/gpio/gpio-bd70528.c
> index d934d23b77c6..d29cbd3c9e53 100644
> --- a/drivers/gpio/gpio-bd70528.c
> +++ b/drivers/gpio/gpio-bd70528.c
> @@ -25,13 +25,13 @@ static int bd70528_set_debounce(struct bd70528_gpio *=
bdgpio,
>         case 0:
>                 val =3D BD70528_DEBOUNCE_DISABLE;
>                 break;
> -       case 1 ... 15:
> +       case 1 ... 15000:
>                 val =3D BD70528_DEBOUNCE_15MS;
>                 break;
> -       case 16 ... 30:
> +       case 15001 ... 30000:
>                 val =3D BD70528_DEBOUNCE_30MS;
>                 break;
> -       case 31 ... 50:
> +       case 30001 ... 50000:
>                 val =3D BD70528_DEBOUNCE_50MS;
>                 break;
>         default:
> --
> 2.23.0
>

This fixes commit 18bc64b3aebf ("gpio: Initial support for ROHM
bd70528 GPIO block") present in v5.3 so applied to fixes and marked
for stable.

Bart
