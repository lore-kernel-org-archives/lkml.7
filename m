Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF8CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469FE2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/But+Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfGVNnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:43:43 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34072 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbfGVNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:43:42 -0400
Received: by mail-vk1-f194.google.com with SMTP id v68so4107498vkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfWmDXv4BPNqOTEY9hU9q6gKX1IYDQYRoMyC7yt2MNI=;
        b=E/But+YuUKIzOcn6HUyy4svfKw8XGm9k9ye+AQjkaG9X/TWQ3EMinTa8z7xp3u05Ky
         JWLgAuxe+lrOiI6YgBbO1YHkcwMk6k9b1ZRdkUtPGe/4LwAz1LutDwQ5KqLZ7Z3lJ5Yv
         6Aab+564w4FX4UBEEuWjzVfV67IBm1INTk5+0MvliPxcuFfyrM6BdfkDALKnY9IIkVKq
         qjRaHqKPO3eI5FFDdjleOVM/8YI/580dxzUMI/vSffxY/2VAgjXK7Azfvw9IQUmo+Ise
         qXJvgJTr3m1dzRR0XTuq6QeYuVikSCmxtlV7q25GKKMyCmReGzDEOYl/7YtUodEuC0UN
         UtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfWmDXv4BPNqOTEY9hU9q6gKX1IYDQYRoMyC7yt2MNI=;
        b=ozQTYBSCpHA2S0b34wj/YNnx8+dWEYm8o0mApfhoPowycgKvB8n2cYCErAorabFhf6
         4LyT/JyPrz+G5rDmf0+CutcLmf67D8byRTiJL4hm9zlZqUlIZEA6w55eOSaxjTnDrqfq
         gkp0F+y6x2SgF5KGODhqNysZCtk2CUHvr+ghJPy0jaHqRpDqRBTTqtbsrwyuf6SXWKv9
         KpVXR1S3pL58JLV2i/VNoGC0Gr8YBF9tvYlrleFdRh67WKvJQEVKEQtekfGlRIfmyb2Q
         +cQZ10F/f/V8s1FutK9oKAUiWvLY5SEPshUQ0PzVVLOG8gXrZKJXsehpMzPdFTvEb8+t
         +xVA==
X-Gm-Message-State: APjAAAWnvDAtfPOzpYOFBXM6yoalsh6Oxzp12s7w045V0a2IkPBQL9uT
        yG3lYD8Wtpqu/8SSL6MVNrFkwVPmc7r2njqwdswOgQ==
X-Google-Smtp-Source: APXvYqx14wMKbyhub1IcdyQKRP208Xy4cOVwN13tySgJSo9PZ3oI+ibBZ47r4EOcKXyhteGxLy3BIFkVyqio17fYhcQ=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr25220311vkh.4.1563803021647;
 Mon, 22 Jul 2019 06:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562734889.git.joe@perches.com> <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
In-Reply-To: <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:43:05 +0200
Message-ID: <CAPDyKFpmc3qkU4mXk7X0nGkOLnZ060e-n-en5T-Z7FXzcO5ymw@mail.gmail.com>
Subject: Re: [PATCH 06/12] mmc: meson-mx-sdio: Fix misuse of GENMASK macro
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 at 07:04, Joe Perches <joe@perches.com> wrote:
>
> Arguments are supposed to be ordered high then low.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Applied for fixes by adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2d736e416775..ba9a63db73da 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -73,7 +73,7 @@
>         #define MESON_MX_SDIO_IRQC_IF_CONFIG_MASK               GENMASK(7, 6)
>         #define MESON_MX_SDIO_IRQC_FORCE_DATA_CLK               BIT(8)
>         #define MESON_MX_SDIO_IRQC_FORCE_DATA_CMD               BIT(9)
> -       #define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK          GENMASK(10, 13)
> +       #define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK          GENMASK(13, 10)
>         #define MESON_MX_SDIO_IRQC_SOFT_RESET                   BIT(15)
>         #define MESON_MX_SDIO_IRQC_FORCE_HALT                   BIT(30)
>         #define MESON_MX_SDIO_IRQC_HALT_HOLE                    BIT(31)
> --
> 2.15.0
>
