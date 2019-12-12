Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CFF2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfLLHuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:50:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44400 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfLLHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:50:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id x3so763523oto.11;
        Wed, 11 Dec 2019 23:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i/kQrCR6DRe6WEYPeoiMdcrOD+Sk8SKui3HhgY5J0s=;
        b=mfksngvisLsxX/EDeyFMVuYwSYwFdD87SHWUX0H5nPuTWvyGv1bStpCx5CDkO/Idey
         evfxi9XPRJZzqMVwD/5qx5Ujja34U8miEkiLXuW51pwlq3j2AzYvbdps/2SFyor581Td
         iiUnUaACoZM05KSKE1VInn+gDsFkJZRqODHuZApVvjedLG8vNUppTs5NfsAx0nVEqMUa
         Vxc7ADtU12FjyL03Ms7qCYEYtIVxCukzF53RR93v/7rFLbb11C3dWxwVnKWmSuiWYfyP
         COvduXzUfMdGCq6XBGnxCExyD0T3zEmQijZo1ggCIExKC9nsJUcJK/MGPbPENGKMClWA
         a7mw==
X-Gm-Message-State: APjAAAVOuyKt/0/OijIehqspNQK63uf+kNA8GzCw34Ki+SYXq1AeaxkG
        0ZBbXQLa9e0XX/ngITrsiijqY4CV4TB9sFgud2A=
X-Google-Smtp-Source: APXvYqx5Q1XLzgImqMNSLFEKkWfP29H11T2mMVKgou1wFXgvzMdVoOIlVa0RXO+hmfl2N4vbkLgMry9BjhklGEomGUc=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr6639922ota.145.1576137009080;
 Wed, 11 Dec 2019 23:50:09 -0800 (PST)
MIME-Version: 1.0
References: <87v9qmcloc.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87v9qmcloc.wl-kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Dec 2019 08:49:58 +0100
Message-ID: <CAMuHMdU2LTuOeNAm4bHbei6LOcvEWbwS=WzVSGkZE0kw8RA0kA@mail.gmail.com>
Subject: Re: [PATCH] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_2x
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Thu, Dec 12, 2019 at 3:39 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> __ashiftrt_r4_2x is used from kernel module.
> We need DECLARE_EXPORT(), otherwise we will get compile error.
>
> ERROR: "__ashiftrt_r4_25" [drivers/iio/pressure/bmp280.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/dac/ad5764.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/mma7660.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/iio/accel/dmard06.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/bma220_spi.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/crypto/hisilicon/sec/hisi_sec.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/rtc/rtc-x1205.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf85063.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf2123.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/input/tablet/gtco.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [fs/udf/udf.ko] undefined!
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/kernel/sh_ksyms_32.c
> +++ b/arch/sh/kernel/sh_ksyms_32.c
> @@ -53,8 +53,14 @@ DECLARE_EXPORT(__ashiftrt_r4_21);
>  DECLARE_EXPORT(__ashiftrt_r4_22);
>  DECLARE_EXPORT(__ashiftrt_r4_23);
>  DECLARE_EXPORT(__ashiftrt_r4_24);
> +DECLARE_EXPORT(__ashiftrt_r4_25);
> +DECLARE_EXPORT(__ashiftrt_r4_26);
>  DECLARE_EXPORT(__ashiftrt_r4_27);
> +DECLARE_EXPORT(__ashiftrt_r4_28);
> +DECLARE_EXPORT(__ashiftrt_r4_29);
>  DECLARE_EXPORT(__ashiftrt_r4_30);
> +DECLARE_EXPORT(__ashiftrt_r4_31);
> +DECLARE_EXPORT(__ashiftrt_r4_32);
>  DECLARE_EXPORT(__movstr);
>  DECLARE_EXPORT(__movstrSI8);
>  DECLARE_EXPORT(__movstrSI12);

Wouldn't it make sense to just add all of them (__ashiftrt_r4_[0-32])?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
