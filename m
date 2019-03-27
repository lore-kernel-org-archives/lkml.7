Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A56F20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rKrLlMPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfC0P7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:59:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44277 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfC0P7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:59:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so13257260oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ms8R5t0Sy0cFQVVltiL0O3pOI93JHwc/k56q+HG3fXo=;
        b=rKrLlMPPavT06CXNHUXV1sMSGzmf7uBiIS0VpP/Ucd/08D57cykjjr/9k2JKTbgo2Y
         eJUKIjwS9BKAxj2uxMh4GhiRWYe0Nz06ckI0QNWbm6JAMBQCUdEIsvMLlCBW7S3M9Hrm
         HPTKMXZnudKp1DP8wC4Yd0JK56oKg2bMOjMDTS0dKUWt6vZuVgxii/bBZzeJCA0VXmFr
         5IX8fM3XlHpQuSg6m46aVojuLNCBySuEGb/K7TzhKDmLWj2G8Bv/2akdYO5tbDf9ADua
         Xv/2aKfuuWK/7u6scWr/hUONPVgJ+75MRnsTBGYanBSlrH4eAnorx8B/ff6PYGzr6ZpM
         FgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ms8R5t0Sy0cFQVVltiL0O3pOI93JHwc/k56q+HG3fXo=;
        b=NgEh5L1DDpE20R5qcTvcXQ0GWsU+D8Ikd1MQ+UgNaeiWWBGaxdp5+4vVjr2UyD2fAf
         QFJHZVeR5jy1qWYb7N0Z+ajEa5sI548UmObkE9gh43sGnm1fW+IOG3Xlypysnepfk16V
         1T+MwyidodPB98cP91ZX5SGQoYBJ8fPpkuJGt8Kpc6eDA/q4stm2p6G34BXv/MmjG+a3
         PjOKxRLS2lzB12vdgh8Allc0su7lt6rc0d7GvJdNo3hsgosmA3yz+nWDvxfCa+Xzg31g
         6gsOo7I8cpJTWSdB1QS+xIO2Lm7o7wIoCXhguC2TasgWL0BKyievN9s80MYL2EnN5S7y
         g4xg==
X-Gm-Message-State: APjAAAUcar+eHBRQ+2u0jm9bw/E/fTW8tHHu8HOhflilJHuIKi4IXmYW
        aFU+YKW9+YU2ys1h9CWzTA5hnc1pGU1KMhoxwtbSLQ==
X-Google-Smtp-Source: APXvYqxmz0Pxbbw/ZMNJiT0Y7it7SGwv82lXAwKvDSjynw2uHIdjQMyrJc60RmazjatESgYJn1aKogl3Rg4rjg7Xkd8=
X-Received: by 2002:aca:4c88:: with SMTP id z130mr20220332oia.170.1553702354071;
 Wed, 27 Mar 2019 08:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <bfe609b73c36810457e5ae75b74e1d0fb7f6c5ac.1553696064.git.sramani@mellanox.com>
In-Reply-To: <bfe609b73c36810457e5ae75b74e1d0fb7f6c5ac.1553696064.git.sramani@mellanox.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Mar 2019 16:59:03 +0100
Message-ID: <CAMpxmJXB5cGi7z3b0p4Nmgtb=iPRXut+RTrGf=JnT6Bc3ziXeQ@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: gpio-mlxbf: Add dependency on 64BIT to Kconfig entry
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 mar 2019 o 15:15 Shravan Kumar Ramani <sramani@mellanox.com> n=
apisa=C5=82(a):
>
> Fixes a compile test failure
>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 0d9ddff..530ee34 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1318,7 +1318,7 @@ config GPIO_MERRIFIELD
>
>  config GPIO_MLXBF
>         tristate "Mellanox BlueField SoC GPIO"
> -       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMP=
ILE_TEST)
>         select GPIO_GENERIC
>         help
>           Say Y here if you want GPIO support on Mellanox BlueField SoC.
> --
> 2.1.2
>

Applied, thanks!

Bart
