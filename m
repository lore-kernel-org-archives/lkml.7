Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675B9C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC3920684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SwoYHX5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfLCGmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:42:16 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35687 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLCGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:42:15 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xB36fxQx002046;
        Tue, 3 Dec 2019 15:41:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xB36fxQx002046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575355319;
        bh=d1TaPWKkweQ1rY/9jQKGxR8RbctwUl4ZdBH262gE6Ek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SwoYHX5ogHo9RL8Nc+N0vXtoMdM8NTbmdzHaNGMQ8mkQAHOL/krz6QWLr4Vn72MfY
         OSPm4OaSQgfPeghIdjSFPVKurVV4Xy94Oj7MQBwgH6ptJ3vMjxhRLLFZXS4PWfmiUA
         H+3M1wPKDdPRfYCJbv7nrR6FEeXsW80r09rOsxFGVYzix4//vA5PBuTlv4w82VJSwZ
         M5twJrrM7vL8yd/iXmHzDlkHiEL/XxvPOAOlfcQLae//PzwCdFxrjI3Ydqbt6OlzOj
         iOEKDYVL4rR3wZYDxQ1Q7KHFhcrD7JIXTDhePJ04lvB2YzzFcbU8l0X3mVkYKj0Htg
         ARgPMppx73Zbg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id n27so1685569vsa.0;
        Mon, 02 Dec 2019 22:41:59 -0800 (PST)
X-Gm-Message-State: APjAAAVWGdEYYebf8uWhcG94343K8IDlsICABzwOHU0u7SyVDdGc97NC
        kfP/TqR3ynAKgV8wsW4MRT+DhUI/2SfjNU0ou8g=
X-Google-Smtp-Source: APXvYqzLsiH4HRQY9QqmGR/SA97yO7NrrmjdmBWFjksc9y+rkTjK3+4kSlw3fdNk79ycV87KfqHrKT+gli71BIb+qN8=
X-Received: by 2002:a67:f6c2:: with SMTP id v2mr1763077vso.54.1575355318341;
 Mon, 02 Dec 2019 22:41:58 -0800 (PST)
MIME-Version: 1.0
References: <1575000968-19434-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1575000968-19434-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 3 Dec 2019 15:41:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjGtt-Ee_seet=nB7K0AVA8x4Q+bFRm=1A_aLn7Qancg@mail.gmail.com>
Message-ID: <CAK7LNARjGtt-Ee_seet=nB7K0AVA8x4Q+bFRm=1A_aLn7Qancg@mail.gmail.com>
Subject: Re: [PATCH] clk: uniphier: Add SCSSI clock gate for each channel
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 1:16 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> SCSSI has clock gates for each channel in the SoCs newer than Pro4,
> so this adds missing clock gates for channel 1, 2 and 3. And more, this
> moves MCSSI clock ID after SCSSI.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Fixes: ff388ee36516 ("clk: uniphier: add clock frequency support for SPI")

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




>  drivers/clk/uniphier/clk-uniphier-peri.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
> index 9caa529..3e32db9 100644
> --- a/drivers/clk/uniphier/clk-uniphier-peri.c
> +++ b/drivers/clk/uniphier/clk-uniphier-peri.c
> @@ -18,8 +18,8 @@
>  #define UNIPHIER_PERI_CLK_FI2C(idx, ch)                                        \
>         UNIPHIER_CLK_GATE("i2c" #ch, (idx), "i2c", 0x24, 24 + (ch))
>
> -#define UNIPHIER_PERI_CLK_SCSSI(idx)                                   \
> -       UNIPHIER_CLK_GATE("scssi", (idx), "spi", 0x20, 17)
> +#define UNIPHIER_PERI_CLK_SCSSI(idx, ch)                               \
> +       UNIPHIER_CLK_GATE("scssi" #ch, (idx), "spi", 0x20, 17 + (ch))
>
>  #define UNIPHIER_PERI_CLK_MCSSI(idx)                                   \
>         UNIPHIER_CLK_GATE("mcssi", (idx), "spi", 0x24, 14)
> @@ -35,7 +35,7 @@ const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
>         UNIPHIER_PERI_CLK_I2C(6, 2),
>         UNIPHIER_PERI_CLK_I2C(7, 3),
>         UNIPHIER_PERI_CLK_I2C(8, 4),
> -       UNIPHIER_PERI_CLK_SCSSI(11),
> +       UNIPHIER_PERI_CLK_SCSSI(11, 0),
>         { /* sentinel */ }
>  };
>
> @@ -51,7 +51,10 @@ const struct uniphier_clk_data uniphier_pro4_peri_clk_data[] = {
>         UNIPHIER_PERI_CLK_FI2C(8, 4),
>         UNIPHIER_PERI_CLK_FI2C(9, 5),
>         UNIPHIER_PERI_CLK_FI2C(10, 6),
> -       UNIPHIER_PERI_CLK_SCSSI(11),
> -       UNIPHIER_PERI_CLK_MCSSI(12),
> +       UNIPHIER_PERI_CLK_SCSSI(11, 0),
> +       UNIPHIER_PERI_CLK_SCSSI(12, 1),
> +       UNIPHIER_PERI_CLK_SCSSI(13, 2),
> +       UNIPHIER_PERI_CLK_SCSSI(14, 3),
> +       UNIPHIER_PERI_CLK_MCSSI(15),
>         { /* sentinel */ }
>  };
> --
> 2.7.4
>

-- 
Best Regards
Masahiro Yamada
